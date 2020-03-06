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
    my_each do |value|
      new_array << value if yield value
    end
    new_array
  end

  def my_all?
    is_all_true = true
    my_each do |value|
      is_all_true = false unless yield value
    end
    is_all_true
  end

  def my_any?
    is_all_true = false
    my_each do |value|
      is_all_true = true if yield value
    end
    is_all_true
  end

  def my_none?
    is_all_true = true
    my_each do |value|
      is_all_true = false if yield value
    end
    is_all_true
  end

  # [2, 3, 4].my_each_with_index { |x, y| puts "#{x * 2} #{y + 1}" }

  puts [2, 3, 4].my_none? { |x| x > 1 }
end
