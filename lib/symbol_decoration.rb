class Symbol
  class Decoration < Struct.new(:symbol, :decorator, :args, :block)
    module Extensions; end

    class << self; attr_accessor :decorator_options; end
    self.decorator_options = {}

    def self.register(*decorators)
      options = decorators.last.is_a?(Hash) ? decorators.pop : {}
      decorators.map(&:to_sym).each do |decorator|
        self.decorator_options[decorator] = (self.decorator_options[decorator] || {}).merge(options)
        klass = self.decorator_options[decorator][:chainable] ? ChainableDecoration : Decoration
        Extensions.module_eval do
          define_method(decorator) do |*args, &block|
            klass.new(self, decorator, args, block)
          end
        end
      end
    end
  end

  class ChainableDecoration < Decoration
    include Decoration::Extensions
  end

  include Decoration::Extensions
end
