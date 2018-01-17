#!/usr/bin/env ruby

require 'digest/md5'
require 'liquid'
require 'optparse'

options = {
	:strict => false,
	:template_usage => File.exist?('/.dockerenv') ? '/opt/static-analysis/template_report_usage_junit.xml' : 'template_report_duplication_junit.xml',
	:template_duplication => File.exist?('/.dockerenv') ? '/opt/static-analysis/template_report_duplication_junit.xml' : 'template_report_duplication_junit.xml',
	:destination => '.',
	:source => '.'
}

def analyze(options)
	#Obtain a list of files to analyze. The resources we want to check for duplication
	a_files = list_files(options[:source])

	#Scan for duplicates. Select those that are duplicats
	duplicates = scan_duplicates(a_files).select { |k,v| v.length > 1 }

	#Write the report
	duplication_report(duplicates, options[:destination], options[:template_duplication])

	#Select everything that is NOT used
	usage = scan_usage(a_files, options[:source]).select { |k,v| v == false }
	unsused_resouces_report(usage, options[:destination], options[:template_usage])

	if options[:strict]
		if usage.any?
			puts "Unused files found: Exit(128)"
			exit 128
		end

		if duplicates.any?
			puts "Duplicate files found: Exit(127)"
			exit 127
		end
	end
end

def check_extension(file, ext)
		match = false
		ext.each { |fn|
			match ||= file.end_with?(fn)
		}
		match
end

def list_files(dir)
	hash = {}
	Dir.glob("#{dir}/**/*", File::FNM_DOTMATCH).each do |filename|

	  next if File.directory?(filename)
	  should_include = check_extension(filename, ['.jpg', '.png', '.jpeg', '.pdf', '.gif'])
	  next unless should_include

	  key = Digest::MD5.hexdigest(IO.read(filename)).to_sym
	  if hash.has_key? key
	    # puts "same file #{filename}"
	    hash[key].push filename
	  else
	    hash[key] = [filename]
	  end
	  puts "Scanned #{filename}"
	end
	hash
end

def scan_duplicates(files)
	files.each_value do |filename_array|
	  if filename_array.length > 1
	  	puts "Duplicate files:"
	    filename_array.each { |filename| puts '  '+filename }
	  end
	end
	files
end

#Here resources is the hash
def scan_usage(resources, dir)
	unique_files = Set.new

	resources.each_value do |filename_array|
	  if filename_array.length > 1
	    filename_array.each { |filename|
	    	unique_files.add("#{File.basename(filename)}:#{filename}")
	    }
	  else
	  	unique_files.add("#{File.basename(filename_array.first)}:#{filename_array.first}")
	  end
	end

	#The text files to look for the references
	files_to_scan = []
	extensions = ['.html','.md']
	extensions.each do |ext|
		files_to_scan += Dir.glob("#{dir}/**/*#{ext}", File::FNM_DOTMATCH)
	end

	mapped_files = Hash[unique_files.collect { |x| [x,false] }]
	#For each unique file name...see if they are referenced anywhere in the source
  unique_files.each do |check_file|
  	name = check_file.split(':')[0]
  	has_filename = false
		files_to_scan.each do |scan_file|
			has_filename ||= File.readlines(scan_file, :encoding => 'utf-8').grep(eval("/#{name}/")).any?
		end
		mapped_files[check_file] = has_filename
  end

  mapped_files
end

def unsused_resouces_report(files, dest, template)
	File.open("#{dest}/analyzed_report_unused.xml",'w:UTF-8') do |f|
 		f << Liquid::Template.parse(File.read(template)).render('unused' => files.map { |k,v| [k.to_s,v] })
	end
end

def duplication_report(files, dest, template)
	File.open("#{dest}/analyzed_report_duplication.xml",'w:UTF-8') do |f|
 		f << Liquid::Template.parse(File.read(template)).render('duplicates' => files.map { |k,v| [k.to_s,v] })
	end
end


OptionParser.new do |opts|
	opts.banner = "Usage: analyse.rb [options]"
	opts.on("-f", "--[no-]fail", "Run strictly, exit nonzero when analysis warnings are found") do |f|
		options[:strict] = f
	end

	opts.on("-dDESTINATION", "--destination=DESTINATION", "Output destination") do |d|
		options[:destination] = d
	end

	opts.on("-sSOURCE", "--source=SOURCE", "Source folder") do |s|
		options[:source] = s
	end

	opts.on("-uUNUSED","--unused=UNUSED", "Template file for the unused resource scanner") do |u|
		options[:template_usage] = u
	end

	opts.on("-cCOPIES","--copies=COPIES", "Template file for the duplicate resource scanner") do |i|
		options[:template_duplication] = i
	end
end.parse!

analyze(options)
