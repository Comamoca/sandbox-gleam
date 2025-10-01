-- name: GetTodo :one
SELECT id, title, status, CAST(created_at AS TEXT) as created_at FROM todos
WHERE id = ? LIMIT 1;

-- name: ListTodos :many
SELECT id, title, status, CAST(created_at AS TEXT) as created_at FROM todos
ORDER BY created_at DESC;

-- name: CreateTodo :one
INSERT INTO todos (
  id, title, status
) VALUES (
  ?, ?, ?
)
RETURNING id, title, status, CAST(created_at AS TEXT) as created_at;

-- name: UpdateTodo :one
UPDATE todos
SET title = ?, status = ?
WHERE id = ?
RETURNING id, title, status, CAST(created_at AS TEXT) as created_at;

-- name: DeleteTodo :exec
DELETE FROM todos
WHERE id = ?;
