require "spec_helper"

describe FactoryGirl::Definition do
  it { should delegate(:declare_attribute).to(:declarations) }
end

describe FactoryGirl::Definition, "with a name" do
  let(:name) { :"great name" }
  subject    { FactoryGirl::Definition.new(name) }

  it "creates a new attribute list with the name passed" do
    FactoryGirl::DeclarationList.stubs(:new)
    subject
    FactoryGirl::DeclarationList.should have_received(:new).with(name)
  end
end

describe FactoryGirl::Definition, "#overridable" do
  let(:list) { stub("declaration list", overridable: true) }
  before { FactoryGirl::DeclarationList.stubs(new: list) }

  it "sets the declaration list as overridable" do
    subject.overridable.should == subject
    list.should have_received(:overridable).once
  end
end

describe FactoryGirl::Definition, "defining traits" do
  let(:trait_1) { stub("trait") }
  let(:trait_2) { stub("trait") }

  it "maintains a list of traits" do
    subject.define_trait(trait_1)
    subject.define_trait(trait_2)
    subject.defined_traits.should == [trait_1, trait_2]
  end
end

describe FactoryGirl::Definition, "adding callbacks" do
  let(:callback_1) { "callback1" }
  let(:callback_2) { "callback2" }

  it "maintains a list of callbacks" do
    subject.add_callback(callback_1)
    subject.add_callback(callback_2)
    subject.callbacks.should == [callback_1, callback_2]
  end
end

describe FactoryGirl::Definition, "#to_create" do
  its(:to_create) { should be_nil }

  it "returns the assigned value when given a block" do
    block = proc { nil }
    subject.to_create(&block)
    subject.to_create.should == block
  end
end
