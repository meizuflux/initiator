require "option_parser"
require "colorize"

require "./creator"

__version = "0.0.1"

directory = "."
verbose = false
project_name = ARGV[0]?

parser = OptionParser.new do |parser|
    parser.banner = "Usage: #{"initiator".colorize(:blue)} #{"[OPTIONS] <PROJECT_NAME>".colorize(:yellow)}"
    parser.on("-h", "--help", "#{"Shows this message".colorize(:blue)}") do
        puts parser
        exit
    end
    parser.on("-V", "--version", "#{"Shows the version".colorize(:blue)}") do
        puts "#{"initiator".colorize(:blue)} v#{__version}"
        exit
    end
    parser.on("-v", "--verbose", "#{"Specifies whether the output should be verbose or not".colorize(:blue)}") { verbose = true }
    parser.on("-d DIRECTORY", "--directory=DIRECTORY", "#{"Specify the directory in which to create the new project".colorize(:blue)}") { |_dir| directory = _dir }
end

parser.parse

if project_name.nil?
    puts parser
    exit
end

Creator.python(project_name, verbose, directory)



