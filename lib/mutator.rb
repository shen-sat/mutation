class Mutator
  def create_copy(filename)
    in_file = File.read(filename)

    in_filename_partial = filename[/.+[^_spec.rb]/]

    out_filename = "#{in_filename_partial}_copy_spec.rb"
    out_file = File.write(out_filename, in_file)
  end

  def run_spec(filename)
    system("rspec #{filename}", :out => File::NULL)

    $?
  end
end
