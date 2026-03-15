require 'pry-byebug'

class HashMap
  
  def initialize
  @load_factor = 0.75
  @capacity = 16
  @hasharray = Array.new(@capacity).map { |val| val = [] }  
  end
  

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    
    hash_code
  end

  def set(key, value)
    hash_code = hash(key)
    bucket = hash_code % @capacity
    @hasharray[bucket] << { key => value }

    if length > (@load_factor * @capacity)
      @capacity *= 2
      entries_array = entries
      @hasharray = Array.new(@capacity).map { |val| val = [] }
      entries_array.each do |pair|
        hash_code = hash(pair[0])
        bucket = hash_code % @capacity
        @hasharray[bucket] << { pair[0] => pair[1] }
      end
      puts @hasharray
    end
  end

  def get(key)
    hash_code = hash(key)
    bucket = hash_code % @capacity
    pairs = @hasharray[bucket]
    keys_array = []
    pairs.each do | pair | 
      keys_array << pair.keys
      keys_array.each do | k |
        if k.join == key
          return pair[key]
        end
      end
    end
    nil
  end

  def has?(key)
    hash_code = hash(key)
    bucket = hash_code % @capacity
    pairs = @hasharray[bucket]
    keys_array = []
    pairs.each  { | pair | keys_array << pair.keys }
    keys_array.each do | k |
      if k.join == key
        return true
      end
    end
    false
  end

  def remove(key)
    hash_code = hash(key)
    bucket = hash_code % @capacity
    pairs = @hasharray[bucket]
    pairs.each do |pair|
      if pair[key] != nil
        return pairs.delete(pair)
      end
    end
  end

  def length
    count = 0 
    @hasharray.each do |bucket|
      if bucket == []
        next
      else
        bucket.each { |pair| count += 1 }
      end
    end
    count
  end

  def clear
    @hasharray = @hasharray.map { |value| value = [] }
    @hasharray
  end

  def keys
    keys_array = []
    @hasharray.each do |bucket|
      if bucket == []
        next
      else
        bucket.each { |pair| keys_array << pair.keys }
      end
    end
    output = keys_array.map { |ele| ele.join }
    puts "array of keys is #{output}"
    output
  end

  def values
    values_array = []
    @hasharray.each do |bucket|
      if bucket == []
        next
      else
        bucket.each { |pair| values_array << pair.values }
      end
    end
    output = values_array.map { |ele| ele.join }
    puts "array of values is #{output}"
    output
  end

  def entries
    entries_array = []
    @hasharray.each do |bucket|
      if bucket == []
        next
      else
        bucket.each do |pair| 
          pair.each do |key, val|
            entries_array << [key, val]
          end
        end
      end

    end
    puts "array of entries is #{entries_array}"
    entries_array
  end

end

test = HashMap.new
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown') #
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple') #
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
puts test.get("lion")
puts test.has?("lion")
puts "filled buckets is now:"
puts test.length
# puts test.remove("lion")
# puts test.length
# test.clear
test.keys
test.values
test.entries
binding.pry
test.set('moon', 'silver')
binding.pry
puts "The length is now:"
puts test.length
puts test.get('moon')
puts test.has?('hat')
puts test.remove('jacket')
puts "the length is now:"
puts test.length
test.keys
test.values
test.entries
