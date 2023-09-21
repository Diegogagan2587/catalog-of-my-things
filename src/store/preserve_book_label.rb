require 'json'

module PreserveBookLabel
  DATA_DIR = 'data'.freeze
  BOOKS_FILE = File.join(DATA_DIR, 'books.json')
  LABELS_FILE = File.join(DATA_DIR, 'labels.json')

  def save_to_file
    save_books
    save_labels
  end

  def load_from_file
    load_books
    load_labels
  end

  private

  def save_books
    books = @items.select { |item| item.is_a?(Book) }.map(&:to_h)
    File.write(BOOKS_FILE, JSON.dump(books))
  end

  def save_labels
    labels = @labels.map(&:to_h)
    File.write(LABELS_FILE, JSON.dump(labels))
  end

  def load_books
    return unless File.exist?(BOOKS_FILE)

    books = JSON.parse(File.read(BOOKS_FILE))
    books.each do |book|
      label_data = book['label']
      label = find_or_create_label(label_data['title'])
      label.color = label_data['color']

      book_params = {
        genre: book['genre'],
        author: book['author'],
        source: book['source'],
        label: label,
        publish_date: book['publish_date'],
        cover_state: book['cover_state']
      }
      @items << Book.new(book_params)
    end
  end

  def load_labels
    return unless File.exist?(LABELS_FILE)

    labels = JSON.parse(File.read(LABELS_FILE))
    labels.each do |label|
      @labels << Label.new(label['title'], label['color'])
    end
  end
end
