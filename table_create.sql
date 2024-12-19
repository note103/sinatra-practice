CREATE TABLE articles (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO articles (title, body) VALUES ('SAMPLE1', 'This is a sample article.');
INSERT INTO articles (title, body) VALUES ('SAMPLE2', 'This is another sample article.');
INSERT INTO articles (title, body) VALUES ('SAMPLE3', 'This is the last sample article.');