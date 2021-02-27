class Mutator
  def run_spec(filename)
    system("rspec #{filename}", :out => File::NULL)

    $?
  end

  def swap(content, current_text, new_text)
    content.gsub!(current_text, new_text)
  end

  def check_for_line_match(line, match_text)
    return true if line.match(/#{match_text}/)

    false
  end

  def write_lines_to_file(filename, lines)
    content = lines.join()
    File.write(filename, content)
  end

  def run(filename, current_text, new_text)
    lines = File.readlines(filename)

    lines.each do |line|
      next unless check_for_line_match(line, current_text)

      swap(line, current_text, new_text)

      write_lines_to_file(filename, lines)

      result = run_spec(filename)

      if result.exitstatus != 0
        swap(line, new_text, current_text)
        write_lines_to_file(filename, lines)        
      end
    end
  end
end
