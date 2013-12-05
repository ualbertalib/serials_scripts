

object_ids=Array.new

file=File.open("matchissn", "r").each do |line|
  if !line.include? "Not updated"
    last_pipe = line.rindex("|")
    object_ids.push line[last_pipe-9..last_pipe].gsub("|", "")
  end
end

for object in object_ids
  puts object
end

#for record in free_targets do
#  unless record['020'].nil? then
 #   if !object_ids.include? record['020']['a'] then
  #    free_targets.delete record
   # end
#  end
#end

#for record in paid_targets do
 # unless record['020'].nil? then
  #  if !object_ids.include? record['020']['a'] then
   #   paid_targets.delete record
#    end
#  end
#end

#puts "Third pass - free targets: "+free_targets.length.to_s
#puts "Third pass - paid targets: "+paid_targets.length.to_s
