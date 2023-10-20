# lexer for radium

class Lexer
  KEYWORDS = %w[pub fn print return include while return if].freeze
  OPERATORS = %w[+ - * / = == != < <= > >=].freeze

  def initialize(source_code)
    @source_code = source_code
    @tokens = []
    @current_token = ""
    @token_types = []
    @token_values = []
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
    @token_types << :parenthesis
    @token_values << char
  end

  def handle_curly_brace
    add_current_token unless @current_token.empty?
    @token_types << :curly_brace
    @token_values << "{"
  end

  def handle_semicolon
    add_current_token unless @current_token.empty?
    @token_types << :semicolon
    @token_values << ";"
  end

  def handle_operator(char)
    add_current_token unless @current_token.empty?
    @token_types << :operator
    @token_values << char
  end

  def add_current_token
    if KEYWORDS.include?(@current_token)
      @token_types << :keyword
    else
      @token_types << :identifier
    end
    @token_values << @current_token
    @current_token = ""
  end
end

source_code = File.read(@FilePath)

lexer = Lexer.new(source_code)
lexer.tokenize
@TokenTypes = lexer.instance_variable_get(:@token_types)
@TokenValue = lexer.instance_variable_get(:@token_values)

puts "[AST]".yellow
@TokenTypes.each_with_index do |type, i|
  puts "  ├ #{type}:  #{@TokenValue[i]}"
end