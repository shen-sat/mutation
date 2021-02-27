require_relative '../lib/mutator'

RSpec.describe Mutator do

  describe '#run_spec' do
    context 'for a passing test' do
      it 'returns exit code 0' do
        filename = 'fixture/passing_spec.rb'
        mutator = Mutator.new

        result = mutator.run_spec(filename);

        expect(result.exitstatus).to eq(0)
      end
    end
    context 'for a failing test' do
      it 'returns exit code 0' do
        filename = 'fixture/failing_spec.rb'
        mutator = Mutator.new

        result = mutator.run_spec(filename)

        expect(result.exitstatus).not_to eq(0)
      end
    end
  end

  describe '#swap' do
    it 'swaps strings' do
      content = "let(:foobar) { FactoryBot.create(:foobar) }\n"
      current_text = 'FactoryBot.create'
      new_text = 'FactoryBot.build'
      mutator = Mutator.new

      new_content = mutator.swap(content, current_text, new_text)

      expect(new_content).to eq("let(:foobar) { FactoryBot.build(:foobar) }\n")
    end
  end

  describe '#check_for_line_match' do
    match_text = 'FactoryBot.create'
    context 'if line is a match' do
      line = "let(:foobar) { FactoryBot.create(:foobar) }\n"
      it 'returns true' do
        mutator = Mutator.new

        expect(mutator.check_for_line_match(line, match_text)).to eq(true)
      end
    end
    context 'if line is not a match' do
      line = "let(:foobar) { FactoryBot.build(:foobar) }\n"
      it 'returns false' do
        mutator = Mutator.new

        expect(mutator.check_for_line_match(line, match_text)).to eq(false)
      end
    end
  end

  describe '#write_lines_to_file' do
    it 'writes contents to file' do
      lines = ['hello', 'world']
      filename = 'fixture/hello_world_spec.rb'

      FileUtils.touch filename

      mutator = Mutator.new
      mutator.write_lines_to_file(filename, lines)

      expect(File.read(filename)).to eq('helloworld')

      File.delete(filename)
    end
  end

  describe '#run' do
    context 'when swapped text passes test' do
      it 'swaps text' do
        #setup
        content_for_spec = "RSpec.describe 'FactoryBot.create' do\n  \n  it 'passes' do\n    expect(1).to eq(1)\n  end\nend\n"

        filename = 'fixture/foobar_spec.rb'

        File.write(filename, content_for_spec)
        #test setup passes
        expect(system("rspec #{filename}", :out => File::NULL)).to eq(true)

        #test
        mutator = Mutator.new
        mutator.run(filename, 'FactoryBot.create', 'FactoryBot.build')

        expect(File.read(filename)).to eq("RSpec.describe 'FactoryBot.build' do\n  \n  it 'passes' do\n    expect(1).to eq(1)\n  end\nend\n")

        File.delete(filename) 
      end
    end
    context 'when swapped text does not pass test' do
      it 'does not swap text' do
        #setup
        content_for_spec = "RSpec.describe 'FactoryBot.create' do\n  \n  it 'passes' do\n    expect(1).to eq(2)\n  end\nend\n"

        filename = 'fixture/foobar_spec.rb'

        File.write(filename, content_for_spec)
        #test setup passes
        expect(system("rspec #{filename}", :out => File::NULL)).to eq(false)

        #test
        mutator = Mutator.new
        mutator.run(filename, 'FactoryBot.create', 'FactoryBot.build')

        expect(File.read(filename)).to eq("RSpec.describe 'FactoryBot.create' do\n  \n  it 'passes' do\n    expect(1).to eq(2)\n  end\nend\n")

        File.delete(filename) 
      end
    end
  end
end
