class FactoryBotFake
  def self.create(args)
    raise 'Error'
  end

  def self.build(args)
    return 2
  end
end

RSpec.describe 'error spec' do
  context 'this should not be swapped because spec raises error initially' do
    let(:num) { FactoryBotFake.create(:a_factory) }

    it 'raises error' do
      num
    end
  end
end
