require 'rspec'
require_relative '../src/item'
require_relative '../src/book'
require_relative '../src/label'
require_relative '../src/store/preserve_book_label'

class TestContainer
  include PreserveBookLabel

  attr_accessor :items, :labels

  def initialize
    @items = []
    @labels = []
  end

  def find_or_create_label(title)
    @labels.find { |l| l.title == title } || Label.new(title, 'DefaultColor')
  end
end

describe PreserveBookLabel do
  let(:container) { TestContainer.new }
  let(:book) { instance_double('Book') }
  let(:label) { instance_double('Label') }

  describe '#save_to_file' do
    before do
      allow(container).to receive(:save_books)
      allow(container).to receive(:save_labels)
    end

    it 'calls the save_books and save_labels methods' do
      container.save_to_file
      expect(container).to have_received(:save_books)
      expect(container).to have_received(:save_labels)
    end
  end

  describe '#load_from_file' do
    before do
      allow(container).to receive(:load_books)
      allow(container).to receive(:load_labels)
    end

    it 'calls the load_books and load_labels methods' do
      container.load_from_file
      expect(container).to have_received(:load_books)
      expect(container).to have_received(:load_labels)
    end
  end

  describe '#save_books' do
    it 'writes the correct data to BOOKS_FILE' do
      allow(File).to receive(:write)
      book_hash = { genre: 'Fiction', publisher: 'Publisher' }
      allow(book).to receive(:is_a?).with(Book).and_return(true)
      allow(book).to receive(:to_h).and_return(book_hash)
      container.items << book

      container.send(:save_books)

      expect(File).to have_received(:write).with(described_class::BOOKS_FILE, JSON.dump([book_hash]))
    end
  end

  describe '#save_labels' do
    it 'writes the correct data to LABELS_FILE' do
      allow(File).to receive(:write)
      label_hash = { title: 'MyLabel', color: 'Red' }
      allow(label).to receive(:to_h).and_return(label_hash)
      container.labels << label

      container.send(:save_labels)

      expect(File).to have_received(:write).with(described_class::LABELS_FILE, JSON.dump([label_hash]))
    end
  end

  describe '#load_books' do
    it 'loads books from BOOKS_FILE' do
      book_data = { 'genre' => 'Fiction', 'publisher' => 'Publisher',
                    'label' => { 'title' => 'MyLabel', 'color' => 'Red' } }
      allow(File).to receive(:exist?).with(described_class::BOOKS_FILE).and_return(true)
      allow(File).to receive(:read).with(described_class::BOOKS_FILE).and_return(JSON.dump([book_data]))
      allow(Book).to receive(:new)
      allow(Label).to receive(:new).and_return(label)
      allow(container).to receive(:find_or_create_label).and_return(label)
      allow(label).to receive(:color=)

      container.send(:load_books)

      expect(Book).to have_received(:new).with(hash_including(genre: 'Fiction', publisher: 'Publisher', label: label))
      expect(container.items).not_to be_empty
      expect(label).to have_received(:color=).with('Red')
    end
  end

  describe '#load_labels' do
    it 'loads labels from LABELS_FILE' do
      label_data = { 'title' => 'MyLabel', 'color' => 'Red' }
      allow(File).to receive(:exist?).with(described_class::LABELS_FILE).and_return(true)
      allow(File).to receive(:read).with(described_class::LABELS_FILE).and_return(JSON.dump([label_data]))
      allow(Label).to receive(:new).and_return(label)

      container.send(:load_labels)

      expect(Label).to have_received(:new).with('MyLabel', 'Red')
      expect(container.labels).not_to be_empty
    end
  end
end
