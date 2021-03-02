RSpec.describe 'run app' do
  it 'swaps text in passing tests only' do
    swappable_content = File.read('fixture/swappable_spec.rb')
    swapped_content = File.read('fixture/swapped_spec.rb')

    filename = 'tmp/example_spec.rb'

    File.write(filename, swappable_content)

    system("ruby lib/app.rb FactoryBotFake.create FactoryBotFake.build #{filename}")

    expect(File.read(filename)).to eq(swapped_content)

    File.delete(filename)
  end
end
