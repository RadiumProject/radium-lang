require_relative "deps/deps.rb"


command = ARGV[0]
subcommand = ARGV[1]

commands = [
    "--new-project",
    "--help"
]

if command == commands[0]
    system("sh structgen.sh #{subcommand}")
elsif command == commands[1]
    puts "soon.."
else
    puts "unkown command.\nwrite --help for commands list."
end
