require_relative '../lib/mutator'

RSpec.describe Mutator do
 let(:mutator) { Mutator.new }

  describe '#run' do
    let(:filename) { 'tmp/example_spec.rb' }

    before { File.write(filename, content_for_spec) }

    context 'when swapped text passes test' do
      let(:content_for_spec) { "RSpec.describe 'FactoryBot.create' do\n  \n  it 'passes' do\n    expect(1).to eq(1)\n  end\nend\n" }
      
      it 'swaps text' do
        expect(system("rspec #{filename}", :out => File::NULL)).to eq(true)

        mutator.run(filename, 'FactoryBot.create', 'FactoryBot.build')

        expect(File.read(filename)).to eq("RSpec.describe 'FactoryBot.build' do\n  \n  it 'passes' do\n    expect(1).to eq(1)\n  end\nend\n")

        File.delete(filename) 
      end
    end
    context 'when swapped text does not pass test' do
      let(:content_for_spec) { "RSpec.describe 'FactoryBot.create' do\n  \n  it 'passes' do\n    expect(1).to eq(2)\n  end\nend\n" }
      
      it 'does not swap text' do
        expect(system("rspec #{filename}", :out => File::NULL)).to eq(false)

        mutator.run(filename, 'FactoryBot.create', 'FactoryBot.build')

        expect(File.read(filename)).to eq("RSpec.describe 'FactoryBot.create' do\n  \n  it 'passes' do\n    expect(1).to eq(2)\n  end\nend\n")

        File.delete(filename) 
      end
    end
  end
end
