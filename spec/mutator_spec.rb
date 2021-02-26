require_relative '../lib/mutator'

RSpec.describe Mutator do
  
  describe '#create_copy' do
    it 'copies file' do
      filename = 'fixture/hello_spec.rb'
      file = File.read(filename)

      mutator = Mutator.new
      mutator.create_copy(filename)

      copy_filename = 'fixture/hello_copy_spec.rb'
      copy_file = File.read(copy_filename)

      expect(file).to eq(copy_file)

      File.delete(copy_filename)
    end
  end

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
  
  
end
