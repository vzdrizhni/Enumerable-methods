module Enumerable
  def my_each
    return enum_for(:each) unless block_given?
    self.size.times do |i|      
      yield self.to_a[i]      
    end
  end  

  def my_each_with_index
    return enum_for(:each_with_index) unless block_given?
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

  #p [2, 4, 3].select

  def my_inject    
    arr = self.drop(1)
    counter = self.to_a[0]
    i = 0    
    while i < arr.length do      
      counter = yield(counter, arr.to_a[i])
      i += 1
    end
    counter
  end 

  puts (2..4).my_inject { |x, y| x * y } 

end
