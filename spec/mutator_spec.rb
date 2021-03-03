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

  it 'does not swap text in a spec that is already failing' do
    failing_spec_content = File.read('fixture/failing_spec.rb')

    filename = 'tmp/example_spec.rb'

    File.write(filename, failing_spec_content)

    expect(system("rspec #{filename}", :out => File::NULL)).to eq(false)

    Mutator.new.run(filename, 'FactoryBotFake.create', 'FactoryBotFake.build')

    expect(File.read(filename)).to eq(failing_spec_content)

    File.delete(filename)
  end
end
