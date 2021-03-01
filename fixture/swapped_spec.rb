class FactoryBotFake
  def self.create(args)
    return 1
  end

  def self.build(args)
    return 2
  end
end

RSpec.describe 'swapping' do
  
  context 'this can be swapped' do
    let(:num) { FactoryBotFake.build(:a_factory) }

    it 'passes' do
      expect(num).to be_kind_of(Integer)
    end
  end

  context 'this cannot be swapped' do
    let(:num) { FactoryBotFake.create(:a_factory) }

    it 'passes' do
      expect(num).to eq(1)
    end
  end

  context 'this can be swapped' do
    let(:num) { FactoryBotFake.build(:a_factory) }

    it 'passes' do
      expect(num).to be_truthy
    end
  end

  context 'this cannot be swapped' do
    let(:num) { FactoryBotFake.create(:a_factory) }

    it 'passes' do
      expect(num + 1).to eq(2)
    end
  end
end
