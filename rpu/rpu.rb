require_relative "deps/deps.rb"


command = ARGV[0]
subcommand = ARGV[1]

commands = [
    "--new-project",
    "--help",
    "--debug-deps",
    "--start"
]

if command == commands[0]
    system("sh src/structgen.sh #{subcommand}")
elsif command == commands[1]
    puts "help for RPU(Radium Packages Utils):
    --new-project: create new radium project.
    --help: output this text.
    --debug-deps: check the deps for project.
    --start: start project."
elsif command == commands[2]
    system("sh src/depsdebug.sh")
elsif command == commands[3]
    system("sh src/projectstart.sh")
else
    puts "unkown command.\nwrite --help for commands list."
end
