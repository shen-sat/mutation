RSpec.describe 'run app' do
  it 'swaps text in passing tests only' do
    failing_content = File.read('fixture/failing_spec.rb')
    swappable_content = File.read('fixture/swappable_spec.rb')
    error_content = File.read('fixture/error_spec.rb')

    failing_filename = 'tmp/failing_example_spec.rb'
    swappable_filename = 'tmp/swappable_example_spec.rb'
    error_filename = 'tmp/error_example_spec.rb'

    File.write(failing_filename, failing_content)
    File.write(swappable_filename, swappable_content)
    File.write(error_filename, error_content)

    swapped_content = File.read('fixture/swapped_spec.rb')

    system("ruby lib/app.rb FactoryBotFake.create FactoryBotFake.build #{failing_filename} #{swappable_filename} #{error_filename}")

    expect(File.read(failing_filename)).to eq(failing_content)
    expect(File.read(swappable_filename)).to eq(swapped_content)
    expect(File.read(error_filename)).to eq(error_content)

    File.delete(failing_filename)
    File.delete(swappable_filename)
    File.delete(error_filename)
  end
end
