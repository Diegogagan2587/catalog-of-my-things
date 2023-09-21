module BookMethods
  def add_book
    book_details = collect_book_details
    label = find_or_create_label(book_details[:label_title])

    book = Book.new(
      genre: book_details[:genre],
      publisher: book_details[:publisher],
      source: book_details[:source],
      label: label,
      publish_date: book_details[:publish_date],
      cover_state: book_details[:cover_state]
    )

    store_book_and_label(book, label)
    puts 'Book added successfully.'
    save_to_file
  end

  def list_books
    if @items.empty?
      puts 'No books available, please add a new one.'
    else
      puts 'Listing all books:'
      @items.each do |item|
        puts "Genre: #{item.genre}, Publisher: #{item.publisher}" if item.is_a?(Book)
      end
    end
  end

  def list_labels
    if @labels.empty?
      puts 'No labels available, please add a new one.'
    else
      puts 'Listing all labels:'
      @labels.each { |label| puts label.title }
    end
  end
end

  private

def collect_book_details
  details = {}
  puts 'Enter book details:'
  print 'Genre: '
  details[:genre] = gets.chomp
  print 'Publisher: '
  details[:publisher] = gets.chomp
  print 'Source: '
  details[:source] = gets.chomp
  print 'Label: '
  details[:label_title] = gets.chomp
  print 'Publish Date: '
  details[:publish_date] = gets.chomp
  print 'Cover State: '
  details[:cover_state] = gets.chomp
  details
end

def find_or_create_label(label_title)
  @labels.find { |l| l.title == label_title } || Label.new(label_title, 'DefaultColor')
end

def store_book_and_label(book, label)
  @items << book
  return if @labels.include?(label)

  label.add_item(book)
  @labels << label
end
