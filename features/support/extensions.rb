# frozen_string_literal: true

# comment placeholder
class Hash
  def downcase
    dhash = {}
    each_pair do |k, v|
      dhash[k.downcase] = v.downcase
    end
    dhash
  end

  def to_s
    string = ''
    each_pair do |k, v|
      string << k.to_s + '='
      string << v.to_s + ' '
    end
    string
  end
end

# comment placeholder
class Array
  def downcase
    collect!(&:downcase)
  end

  def to_s
    join(',')
  end
end

# comment placeholder
class String
  def array_me
    array = []
    strip.split(' ').each do |item|
      keys, value = item.split('=')
      keys.split(',').each do |key|
        array << "#{key}=#{value}"
      end
    end
    array
  end

  def color(n = 31)
    "\e[#{n}m#{self}\e[0m"
  end
end
