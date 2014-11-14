require 'spec_helper'

describe Symbol::Decoration do
  context 'when using a decorator' do
    before { Symbol::Decoration.register(decorator) }
    after  { Symbol.send(:undef_method, decorator) }

    let(:symbol)    { :some_symbol }
    let(:decorator) { :some_decorator }
    let(:args)      { [1,2,3] }
    let(:block)     { ->{} }

    subject { symbol.send(decorator, *args, &block) }

    it { should be_a(Symbol::Decoration) }
    its(:symbol)    { should == symbol }
    its(:args)      { should == args }
    its(:block)     { should == block }
    its(:decorator) { should == decorator }
  end

  context 'when registering multiple decorators' do
    before { Symbol::Decoration.register(:hello, :world) }
    after  { Symbol.send(:undef_method, :hello) }
    after  { Symbol.send(:undef_method, :world) }

    it 'should register the decorators' do
      :symbol.hello.should be_a(Symbol::Decoration)
      :symbol.world.should be_a(Symbol::Decoration)
    end
  end

  context 'when registering a string decorator' do
    before { Symbol::Decoration.register(decorator) }
    after  { Symbol.send(:undef_method, decorator) }

    let(:symbol)    { :some_symbol }
    let(:decorator) { 'some_decorator' }

    subject { symbol.send(decorator) }

    it { should be_a(Symbol::Decoration) }
    its(:decorator) { should == decorator.to_sym }
  end
end
