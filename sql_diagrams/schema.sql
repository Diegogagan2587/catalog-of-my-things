-- Item table
CREATE TABLE IF NOT EXISTS Item (
    id INT PRIMARY KEY AUTO_INCREMENT,
    genre_id INT,
    author_id INT,
    source TEXT,
    label_id INT,
    publish_date DATE,
    archived BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (genre_id) REFERENCES Genre(id),
    FOREIGN KEY (author_id) REFERENCES Author(id),
    FOREIGN KEY (label_id) REFERENCES Label(id)
);

-- Book table
CREATE TABLE IF NOT EXISTS Book (
    item_id INTEGER PRIMARY KEY,
    publisher VARCHAR(255),
    cover_state VARCHAR(50),
    FOREIGN KEY (item_id) REFERENCES Item(id)
);

-- Label table
CREATE TABLE IF NOT EXISTS label (
    id INTEGER PRIMARY KEY,
    title TEXT,
    color TEXT
);
