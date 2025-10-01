CREATE TABLE todos (
  id INT NOT NULL PRIMARY KEY,
  title VARCHAR(20) NOT NULL,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'completed')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
