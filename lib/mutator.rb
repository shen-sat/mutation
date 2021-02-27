class Mutator
  def run(filename, current_text, new_text)
    lines = File.readlines(filename)

    lines.each do |line|
      next unless line_match?(line, current_text)

      swap(line, current_text, new_text)

      write_lines_to_file(filename, lines)

      if !spec_passes?(filename)
        swap(line, new_text, current_text)
        write_lines_to_file(filename, lines)        
      end
    end
  end

  private

  def spec_passes?(filename)
    system("rspec #{filename}", :out => File::NULL)

    result = $?

    return true if result == 0
    false
  end

  def swap(line, current_text, new_text)
    line.gsub!(current_text, new_text)
  end

  def line_match?(line, match_text)
    return true if line.match(/#{match_text}/)

    false
  end

  def write_lines_to_file(filename, lines)
    content = lines.join()
    File.write(filename, content)
  end
end
