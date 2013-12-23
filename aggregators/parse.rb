target_list = []
File.open("targets.txt").each_line do |line|
  target_list << line.split(" ").first
end

target_list.each do |t|
  puts t if t.include? ARGV[0]
end
