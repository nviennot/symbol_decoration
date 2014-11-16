require 'spec_helper'

describe Symbol::Decoration do
  context 'when using a decorator' do
    before { Symbol::Decoration.register(decorator) }
    after  { Symbol::Decoration::Extensions.send(:undef_method, decorator) }

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
    its(:inspect)   { should == ":some_symbol.some_decorator(1, 2, 3, #{block.inspect})" }
    its(:to_s)      { should == subject.inspect }
  end

  context 'when registering multiple decorators' do
    before { Symbol::Decoration.register(:hello, :world) }
    after  { Symbol::Decoration::Extensions.send(:undef_method, :hello) }
    after  { Symbol::Decoration::Extensions.send(:undef_method, :world) }

    it 'should register the decorators' do
      :symbol.hello.should be_a(Symbol::Decoration)
      :symbol.world.should be_a(Symbol::Decoration)
    end
  end

  context 'when registering a string decorator' do
    before { Symbol::Decoration.register(decorator) }
    after  { Symbol::Decoration::Extensions.send(:undef_method, decorator) }

    let(:symbol)    { :some_symbol }
    let(:decorator) { 'some_decorator' }

    subject { symbol.send(decorator) }

    it { should be_a(Symbol::Decoration) }
    its(:decorator) { should == decorator.to_sym }
    its(:inspect)   { should == ":some_symbol.some_decorator" }
    its(:to_s)      { should == subject.inspect }
  end

  context 'when registering chainable decorator' do
    before { Symbol::Decoration.register(:non_chainable_dec) }
    before { Symbol::Decoration.register(:chainable_dec, :chainable => true) }
    after  { Symbol::Decoration::Extensions.send(:undef_method, :non_chainable_dec) }
    after  { Symbol::Decoration::Extensions.send(:undef_method, :chainable_dec) }

    it 'makes decorations chainable' do
      :some_symbol.chainable_dec.non_chainable_dec.symbol.should == :some_symbol.chainable_dec
      expect { :some_symbol.non_chainable_dec.non_chainable_dec }.to raise_error(NoMethodError)
    end

    context 'when registering the same decorator' do
      before { Symbol::Decoration.register(:chainable_dec) }

      it 'remembers the chainable attribute' do
        :some_symbol.chainable_dec.non_chainable_dec.symbol.should == :some_symbol.chainable_dec
        expect { :some_symbol.non_chainable_dec.non_chainable_dec }.to raise_error(NoMethodError)
      end
    end
  end
end
