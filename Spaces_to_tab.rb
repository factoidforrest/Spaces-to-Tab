#asks for folder




#def folder_explorer(directory) 
#	puts Dir.entries(directory)

#	Dir.entries(directory).each do |entry|
#		if File.directory?(entry) and entry != (".") and entry != ("..")
#			folder_explorer(entry)
#		end
#		
#		if entry.include?(".rb")
#			body= File.read(entry)
#			new_body = body.gsub("  ","\t")
#			f = File.new(entry, "w")
#			f.puts(new_body)
#			
#		end
#	
#	end
#end

#def file_or_folder(directory)
#	Dir.entries(directory).each do |entry|
#		entry_path = File.realpath(entry)
#		if File.directory?(entry) and entry != (".") and entry != ("..")
#			
#			file_or_folder(entry_path)
#		elsif File.fnmatch('*.rb',entry)
#			
#			replace(entry_path)
#		end
#	end
#end
require "optparse"
require 'ostruct'
require 'pp'
 @options = {}

optparse = OptionParser.new do |opts|
	opts.on("-a","--all","Edits all files regardless of type") do |a|
		@options[:all] = true
	end
	opts.on_tail("-h", "--help", "Show this message") do
		puts opts
		exit
	end

end

optparse.parse!



def replace(dir)
	Dir.entries(dir).each do |entry|
#		if @options[:all=>true] and File.file?(entry)
#			Dir.chdir(dir)
#			body= File.read(entry)
#			new_body = body.gsub("  ","\t")
#			f = File.new(entry, "w")
#			f.puts(new_body)
#			Dir.chdir(@directory)

		Dir.chdir(dir)
		if File.fnmatch('*.rb',entry) or File.fnmatch('*.html', entry) or File.fnmatch('*.haml',entry) or (@options[:all] == true and File.file?(entry))

			
			body= File.read(entry)
			new_body = body.gsub("  ","\t")
			f = File.new(entry, "w")
			f.puts(new_body)
			Dir.chdir(@directory)
		end
	end
end

def directory_scanner
	Dir.chdir(@directory)
	replace(@directory)
	Dir.glob("**/").each do |sub_dir|

		sub_dir = File.realpath(sub_dir)
		#Dir.chdir(sub_dir)
		replace(sub_dir)

	end
end



#optparse.parse!(ARGV)
input = ARGV[0]

if File.directory?(input)
	@directory = input
	directory_scanner
elsif			File.file?(input)
	entry = input
	body= File.read(entry)
	new_body = body.gsub("  ","\t")
	f = File.new(entry, "w")
	f.puts(new_body)
end


																																																							







