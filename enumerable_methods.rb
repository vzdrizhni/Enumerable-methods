module Enumerable

  def my_each
    length.times do |i|
      yield self[i] if block_given?
    end
  end

  def my_each_with_index
    length.times do |i|
        yield self[i], i if block_given?
    end
  end

  def my_select
    new_array = []
    self.length.times do |i|
        new_array << self[i] if yield self[i] 
    end
    new_array
  end

  #[2, 3, 4].my_each_with_index { |x, y| puts "#{x * 2} #{y + 1}" }

 puts [2, 3, 4].my_select { |x| x > 2 }

end
