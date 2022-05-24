require "option_parser"

__version = "0.0.1"

directory = "."
verbose = false
language = "python"
project = "lib"

parser = OptionParser.new do |parser|
    parser.banner = "Usage: initiator [OPTIONS] [LANGUAGE=#{language}] [PROJECT=#{project}]"
    parser.on("-V", "--version", "Shows the version") do
        puts "initiator v#{__version}"
        exit
    end
    parser.on("-h", "--help", "Shows help") do
        puts parser
        exit
    end
    parser.on("-v", "--verbose", "Specifies whether the output should be verbose or not") { verbose = true }
    parser.on("-d DIRECTORY", "--directory=DIRECTORY", "Specify the directory in which to create the new project") { |_dir| directory = _dir }
end

parser.parse

puts directory
puts verbose
