require 'rspec'
require_relative '../src/author'
require_relative '../src/item'
describe Author do
  subject(:author) { Author.new('John', 'Doe') }
  let(:item) { Item.new('Genre', author, 'Source', 'Label', '2023-09-22') }
  describe '#initialize' do
    it 'initializes with given first and last name' do
      expect(author.first_name).to eq('John')
      expect(author.last_name).to eq('Doe')
    end
    it 'initializes with an id' do
      expect(author.id).to be_kind_of(Integer)
    end
    it 'initializes with an empty items array' do
      expect(author.items).to eq([])
    end
  end
  describe '#add_item' do
    context 'when item is not an instance of Item' do
      it 'does not add the item' do
        author.add_item('not_an_item')
        expect(author.items).to be_empty
      end
    end
    context 'when item is an instance of Item' do
      it 'adds the item to the items array' do
        author.add_item(item)
        expect(author.items).to include(item)
      end
      it 'associates the item with the author' do
        author.add_item(item)
        expect(item.author).to eq(author)
      end
    end
  end
end
