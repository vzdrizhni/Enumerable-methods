module Enumerable
    def my_each
        self.length.times do |i|
          yield self[i] if block_given?
        end
    end
end