module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?
    self.size.times do |i|      
      yield self.to_a[i]      
    end
  end

  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?
    length.times do |i|
      yield self.to_a[i], i if block_given?
    end    
  end  

  def my_select
    return enum_for(:select) unless block_given?
    new_array = []
    my_each do |value|
      new_array << value if yield value
    end
    new_array
  end  

  def my_all?(arg = nil)
    is_all_true = true
    my_each do |value|
      block_given? ? (is_all_true = false unless yield value) : (is_all_true = false unless value == arg)
    end
    is_all_true
  end  

  def my_any?(arg = nil)
    is_all_true = false
    my_each do |value|
      block_given? ? (is_all_true = true if yield value) : (is_all_true = true if value == arg)
    end
    is_all_true
  end  

  def my_none?(arg = true)
    is_all_true = true
    my_each do |value|
      block_given? ? (is_all_true = false if yield value) : (is_all_true = false if value == arg || value.class == arg || value == true)
    end
    is_all_true
  end   

  def my_count
    counter = 0
    my_each do |value|
      counter += 1 if yield value if block_given?
    end
    counter
  end

  def my_map
    return enum_for(:map) unless block_given?
    new_array = []
    my_each do |value|
      new_array << yield(value)
    end
    new_array
  end  

  def my_inject(acc = nil, arg = nil)
    if acc == nil || acc.is_a?(Symbol)
      arr = self.drop(1).to_a
      counter = self.to_a[0]
    else
      counter = acc
      acc = arg
      arr = self.to_a
    end
    i = 0    
    while i < arr.length do      
      block_given? ? counter = yield(counter, arr[i]) : counter = counter.send(acc, arr[i])
      i += 1
    end
    counter
  end

end

def multiply_els(arr)
    arr.my_inject { |x, y| x * y }
end