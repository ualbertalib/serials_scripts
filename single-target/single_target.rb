require 'marc'

#read sfxdata file and determine single targets
 
reader = MARC::XMLReader.new(ARGV[0])
free_targets = File.open("free_targets.csv", "w")
paid_targets = File.open("paid_targets.csv", "w")

for record in reader
    if record['022'] then issn=record['022']['a'] else issn=" " end
    if record['245'] then title=record['245']['a'] end
    if record['866'] then
      targets=record.find_all{|field| field.tag=='866'}
      if targets.count==1 then
        if record['866']['x'].downcase.include? "free"
          unless issn.nil? then free_targets.print issn end
          free_targets.puts '^'+title+'^'+record['866']['x']
       #   free_targets.push record
        else
          unless issn.nil? then paid_targets.print issn end
          paid_targets.puts '^'+title+'^'+record['866']['x']
          #paid_targets.push record
        end   
      end
    end
   unless issn.nil? then puts issn end
   issn=nil;
end

puts "First pass - free targets: "+free_targets.length.to_s
puts "First pass - paid targets: "+paid_targets.length.to_s

#free_targets.close 
#paid_targets.close

#object_ids=Array.new

#file=File.open("notSIR", "r").each do |line|
#  object_ids.push line[16..25].gsub("|", "")
#end 

#for object in object_ids
#  puts object
#end

#for record in free_targets do
#  unless record['020'].nil? then 
#    if !object_ids.include? record['020']['a'] then
#      free_targets.delete record
#    end
#  end
#end

#for record in paid_targets do
#  unless record['020'].nil? then 
#    if !object_ids.include? record['020']['a'] then
#      paid_targets.delete record
#    end
#  end
#end

#puts "Second pass - free targets: "+free_targets.length.to_s
#puts "Second pass - paid targets: "+paid_targets.length.to_s

#file=File.open("matchissn", "r").each do |line|
 # if line.include? "ok"
  #  last_pipe = line.rindex("|")
   # object_ids.push line[last_pipe-9..last_pipe].gsub("|", "")
  #end
#end

#for object in object_ids
 # puts object
#end

#temp_free_targets=Array.new

#for record in free_targets do
#    unless record['020'].nil? then
#    curr_issn = record['020']['a']
#    if object_ids.include? curr_issn then
#      temp_free_targets.push(record)
#    end
#    puts record['020']['a']+" / "+object_ids.include?(record['020']['a'])
#	unless object_ids.include?(record['020']['a']) 
#	    temp_free_targets << record 
#	end
 # end   
#end

#temp_paid_targets=Array.new

#for record in paid_targets do
 #unless record['020'].nil? then
 #  curr_issn = record['020']['a']
 #  if object_ids.include? curr_issn then
 #    temp_paid_targets.push(record)
 #  end
 #end
#end

#puts "Third pass - free targets: "+temp_free_targets.length.to_s
#puts "Third pass - paid targets: "+temp_paid_targets.length.to_s
