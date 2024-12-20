CREATE TABLE articles (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO articles (title, body) VALUES ('サンプル1', '最初のサンプルメモです。');
INSERT INTO articles (title, body) VALUES ('サンプル2', 'ふたつめのサンプルメモです。');
INSERT INTO articles (title, body) VALUES ('サンプル3', '最後のサンプルメモです。');