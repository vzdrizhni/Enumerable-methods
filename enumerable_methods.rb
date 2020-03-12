module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    size.times do |i|
      yield to_a[i]
    end
  end

  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?

    length.times do |i|
      yield to_a[i], i
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
      if block_given?
        is_all_true = false unless yield value
      elsif arg.nil?
        is_all_true = false unless value
      else
        is_all_true = false unless arg === value
      end
    end
    is_all_true
  end

  def my_any?(arg = nil)
    is_all_true = false
    my_each do |value|
      if block_given?
        is_all_true = true if yield value
      elsif arg.nil?
        is_all_true = true if value
      elsif arg === value
        is_all_true = true
      end
    end
    is_all_true
  end

  def my_none?(arg = nil)
    is_all_true = true
    my_each do |value|
      if block_given?
        is_all_true = false if yield value
      elsif arg.nil?
        is_all_true = false if value
      elsif arg === value
        is_all_true = false
      end
    end
    is_all_true
  end

  def my_count(arg = nil)
    counter = 0
    my_each do |value|
      block_given? ? (counter += 1 if yield value) : (counter += 1 if value == arg || arg.nil?)
    end
    counter
  end

  def my_map(proc = nil)
    return enum_for(:map) unless block_given?

    new_array = []
    if proc.nil?
      my_each do |value|
        new_array << yield(value)
      end
    else
      my_each do |value|
        new_array << proc.call(value)
      end
    end
    new_array
  end

  def my_inject(acc = nil, arg = nil)
    if acc.nil? || acc.is_a?(Symbol)
      arr = drop(1).to_a
      counter = to_a[0]
    else
      counter = acc
      acc = arg
      arr = to_a
    end
    i = 0
    while i < arr.length
      counter = block_given? ? yield(counter, arr[i]) : counter.send(acc, arr[i])
      i += 1
    end
    counter
  end

  def multiply_els(arr)
    arr.my_inject { |x, y| x * y }
  end
end
