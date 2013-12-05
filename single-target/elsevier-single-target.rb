require 'marc'

#read sfxdata file and determine single targets
issns = []

File.open("export_portfolios.txt").each_line do |line|
  issns << line.split("\t").first
  issns<< line.split("\t")[1]
end

puts issns.size
 
reader = MARC::XMLReader.new(ARGV[0])
free_targets = File.open("free_targets.csv", "w")
paid_targets = File.open("paid_targets.csv", "w")

for record in reader
  if record['022'] then issn=record['022']['a'] else issn=" " end
  if record['776'] then eissn = record['776']['x'] else eissn = " " end
   if record['245'] then title=record['245']['a'] end
  if record['866'] then
    targets=record.find_all{|field| field.tag=='866'}
    if targets.count==1 then
      if issns.include?(issn) || issns.include?(eissn) then 
        puts "#{issn}: #{title}"
      end
    end
  end
end
