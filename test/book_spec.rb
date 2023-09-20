require_relative '../src/item'
require_relative '../src/book'

describe Book do
  let(:label) { double('Label') }
  let(:params) do
    {
      genre: 'Fiction',
      author: 'Author Name',
      source: 'Source Name',
      label: label,
      publish_date: '2022-01-01',
      cover_state: 'good'
    }
  end
  let(:book) { Book.new(params) }

  describe '#initialize' do
    it 'creates a new Book instance' do
      expect(book).to be_an_instance_of(Book)
    end

    it 'initializes the Book with given attributes' do
      expect(book.genre).to eq('Fiction')
      expect(book.author).to eq('Author Name')
      expect(book.source).to eq('Source Name')
      expect(book.label).to eq(label)
      expect(book.cover_state).to eq('good')
    end
  end
end
