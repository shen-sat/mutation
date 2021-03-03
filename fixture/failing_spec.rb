class FactoryBotFake
  def self.create(args)
    return 1
  end

  def self.build(args)
    return 2
  end
end

RSpec.describe 'failing spec' do
  context 'this should not be swapped because spec fails initially' do
    let(:num) { FactoryBotFake.create(:a_factory) }

    it 'fails' do
      expect(num).to eq(2)
    end
  end
end
