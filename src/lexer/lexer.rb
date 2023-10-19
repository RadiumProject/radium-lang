class Lexer
  KEYWORDS = %w[pub fn print return include while return if].freeze
  OPERATORS = %w[+ - * / = == != < <= > >=].freeze

  def initialize(source_code)
    @source_code = source_code
    @tokens = []
    @current_token = ""
  end

  def tokenize
    @source_code.each_char do |char|
      if char == " " || char == "\n"
        handle_whitespace
      elsif char == "(" || char == ")"
        handle_parenthesis(char)
      elsif char == "{"
        handle_curly_brace
      elsif char == ";"
        handle_semicolon
      elsif OPERATORS.include?(char)
        handle_operator(char)
      else
        @current_token += char
      end
    end

    @tokens
  end

  private

  def handle_whitespace
    add_current_token unless @current_token.empty?
    @current_token = ""
  end

  def handle_parenthesis(char)
    add_current_token unless @current_token.empty?
    @tokens << { type: :parenthesis, value: char }
  end

  def handle_curly_brace
    add_current_token unless @current_token.empty?
    @tokens << { type: :curly_brace, value: "{" }
  end

  def handle_semicolon
    add_current_token unless @current_token.empty?
    @tokens << { type: :semicolon, value: ";" }
  end

  def handle_operator(char)
    add_current_token unless @current_token.empty?
    @tokens << { type: :operator, value: char }
  end

  def add_current_token
    if KEYWORDS.include?(@current_token)
      @tokens << { type: :keyword, value: @current_token }
    else
      @tokens << { type: :identifier, value: @current_token }
    end
    @current_token = ""
  end
end

source_code = File.read(@FilePath)

lexer = Lexer.new(source_code)
tokens = lexer.tokenize

puts "[AST]".yellow
tokens.each { |token| puts "  ├ #{token[:type]}:  #{token[:value]}" }