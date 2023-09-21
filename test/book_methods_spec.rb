require_relative '../src/item'
require_relative '../src/book_methods'
require_relative '../src/book'
require_relative '../src/label'
require_relative '../src/store/preserve_book_label'

class BookMethodsContainer
  include BookMethods
  include PreserveBookLabel

  attr_accessor :items, :labels

  def initialize
    @items = []
    @labels = []
  end
end

RSpec.describe BookMethods do
  let(:container) { BookMethodsContainer.new }
  let(:book) { instance_double('Book') }
  let(:label) { instance_double('Label') }

  describe '#add_book' do
    before do
      allow(container).to receive(:collect_book_details).and_return(
        genre: 'Fiction',
        publisher: 'PublisherName',
        source: 'Source',
        label_title: 'MyLabel',
        publish_date: '2023-01-01',
        cover_state: 'Good'
      )
      allow(container).to receive(:find_or_create_label).and_return(label)
      allow(container).to receive(:store_book_and_label)
    end

    it 'adds a book successfully' do
      expect { container.add_book }.to output("Book added successfully.\n").to_stdout
    end
  end

  describe '#list_books' do
    context 'when there are no books' do
      it 'outputs a message indicating there are no books' do
        expect { container.list_books }.to output("No books available, please add a new one.\n").to_stdout
      end
    end

    context 'when there are books' do
      before do
        allow(book).to receive(:genre).and_return('Fiction')
        allow(book).to receive(:publisher).and_return('PublisherName')
        allow(book).to receive(:is_a?).with(Book).and_return(true)
        container.items << book
      end

      it 'lists all books' do
        expect do
          container.list_books
        end.to output("Listing all books:\nGenre: Fiction, Publisher: PublisherName\n").to_stdout
      end
    end
  end

  describe '#list_labels' do
    context 'when there are no labels' do
      it 'outputs a message indicating there are no labels' do
        expect { container.list_labels }.to output("No labels available, please add a new one.\n").to_stdout
      end
    end

    context 'when there are labels' do
      before do
        allow(label).to receive(:title).and_return('MyLabel')
        container.labels << label
      end

      it 'lists all labels' do
        expect { container.list_labels }.to output("Listing all labels:\nMyLabel\n").to_stdout
      end
    end
  end
end
