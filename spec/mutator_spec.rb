require_relative '../lib/mutator'

RSpec.describe Mutator do
  it 'swaps text in passing tests only' do
    swappable_content = File.read('fixture/swappable_spec.rb')
    swapped_content = File.read('fixture/swapped_spec.rb')

    filename = 'tmp/example_spec.rb'

    File.write(filename, swappable_content)

    expect(system("rspec #{filename}", :out => File::NULL)).to eq(true)

    Mutator.new.run(filename, 'FactoryBotFake.create', 'FactoryBotFake.build')

    expect(File.read(filename)).to eq(swapped_content)

    File.delete(filename)
  end
end
