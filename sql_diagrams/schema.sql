-- Item table
CREATE TABLE IF NOT EXISTS Item (
    id INT PRIMARY KEY AUTO_INCREMENT,
    genre_id INT,
    author_id INT,
    source TEXT,
    label_id INT,
    publish_date DATE,
    archived BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (genre_id) REFERENCES genre(id),
    FOREIGN KEY (author_id) REFERENCES author(id),
    FOREIGN KEY (label_id) REFERENCES label(id)
);

-- Book table
CREATE TABLE IF NOT EXISTS Book (
    item_id INTEGER PRIMARY KEY,
    publisher VARCHAR(255),
    cover_state VARCHAR(50),
    FOREIGN KEY (item_id) REFERENCES Item(id)
);

-- Music Album Table
CREATE TABLE IF NOT EXISTS music_album (
    id INT GENERATED ALWAYS AS IDENTITY,
    item_id INT,
    on_spotify BOOLEAN,
    CONSTRAINT fk_items FOREIGN KEY (item_id) REFERENCES Item(id)
);

-- Genre Table
CREATE TABLE genre (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    item_id INT
    CONSTRAINT fk_items FOREIGN KEY (item_id) REFERENCES Item (id)
)

-- Label table
CREATE TABLE IF NOT EXISTS label (
    id INTEGER PRIMARY KEY,
    title TEXT,
    color TEXT
);
