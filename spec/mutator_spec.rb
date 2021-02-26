require_relative '../lib/mutator'

RSpec.describe Mutator do
  
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
