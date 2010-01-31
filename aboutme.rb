require 'erb'
require 'time'
require 'aboutme-template'
$time_back = nil #604800

f = File.open("C:\\Users\\Miles\\AppData\\Roaming\\Opera\\Opera 10 Beta\\global_history.dat", "rb")
str = f.read
f.close

lines = str.split("\n")
i = 0
entry = []
while(i < lines.length)
	hsh = {}
	
	hsh[:time] = Time.at(lines[i+2].to_i)
	if($time_back and hsh[:time] < (Time.now - $time_back))
		i += 4
		next
	end
	pos = lines[i+1].match(/:\/\/[^\s\/]*/ix)
	if pos.nil?
		puts "REGEX Error #{lines[i+1]}"
		i += 4
		next
	end
	hsh[:site] = pos[0][3..-1]
	hsh[:title] = lines[i]
	hsh[:url] = lines[i+2]
	entry << hsh
	i += 4
end

total_count = entry.length
puts total_count

def frequency(arr, preinit=nil)
	hsh = Hash.new(0)
	if preinit
		preinit.times { |a| hsh[a] = 0 }
	end
	for i in arr
		hsh[i] += 1
	end
	return hsh
end

sites = entry.map { |a| a[:site] }
sites_freq = frequency(sites).sort { |a,b| a[1] <=> b[1]}.reverse
puts sites_freq[0..20]

times = entry.map { |a| a[:time].hour }
times_freq = frequency(times, 24).sort
max_times_freq = times_freq.sort { |a,b| a[1] <=> b[1]}.reverse[0][1]
puts times_freq.inspect

days = entry.map { |a| a[:time].wday }
days_freq = frequency(days, 7).sort
max_days_freq = days_freq.sort { |a,b| a[1] <=> b[1]}.reverse[0][1]
puts days_freq.inspect

o = File.open("output.html", "w")
template = ERB.new($template)
o.puts(template.result(binding))
o.close
