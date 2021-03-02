require_relative 'mutator'

class App
	attr_reader :mutator
	
	def initialize
		@mutator = Mutator.new
	end

	def run(current_text, new_text, filenames)
		filenames.each { |filename| mutator.run(filename, current_text, new_text) }
	end
end


input = ARGV
current_text = input.shift
new_text = input.shift
App.new.run(current_text, new_text, input)
# puts "hello"