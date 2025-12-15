wire = {}

# Part 2 was done by changing b in input file =)
File.read("input.txt").split("\n").each do |line|
  line.sub!(" AND ", "&")
  line.sub!(" OR ", "|")
  line.sub!(" LSHIFT ", "<<")
  line.sub!(" RSHIFT ", ">>")
  line.sub!("NOT ", "65535^")
  line.gsub!(/[a-z]+/, "@\\0")
  arr = line.split(" -> ")
  wire[arr[1]] = arr[0]
end

def get_value(wire, key)
  str = wire[key]
  vars = str.scan(/@[a-z]+/)
  for var in vars
    if eval("defined? #{var}").nil?
      eval("#{var} = get_value(wire, '#{var}')")
    end
  end
  return eval(str)
end

puts get_value(wire, "@a")
