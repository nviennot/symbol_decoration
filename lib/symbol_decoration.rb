class Symbol
  Decoration = Struct.new(:symbol, :decorator, :args, :block) do
    def self.register(*decorators)
      Symbol.class_eval do
        decorators.map(&:to_sym).each do |decorator|
          define_method(decorator) do |*args, &block|
            Decoration.new(self, decorator, args, block)
          end
        end
      end
    end
  end
end
