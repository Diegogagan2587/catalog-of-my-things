require_relative '../src/label'

describe Label do
  let(:label) { Label.new('MyLabel', 'Red') }
  let(:item) { double('Item') }

  describe '#initialize' do
    it 'creates a new Label instance' do
      expect(label).to be_an_instance_of(Label)
    end

    it 'initializes the Label with given title and color' do
      expect(label.title).to eq('MyLabel')
      expect(label.color).to eq('Red')
    end

    it 'initializes with an empty items array' do
      expect(label.items).to eq([])
    end
  end

  describe '#add_item' do
    before do
      allow(item).to receive(:label=)
    end

    it 'adds an item to the items array' do
      label.add_item(item)
      expect(label.items).to include(item)
    end

    it 'sets the label of the item to self' do
      expect(item).to receive(:label=).with(label)
      label.add_item(item)
    end
  end
end
