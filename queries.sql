-- name: GetExchangeDay :one
SELECT * FROM exchange_days
WHERE id = ? LIMIT 1;

-- name: ListExchangeDays :many
SELECT * FROM exchange_days
ORDER BY id;

-- name: CreateExchangeDay :one
INSERT INTO exchange_days (
  name, swish_number
) VALUES (
  ?, ?
)
RETURNING *;

-- name: DeleteExchangeDay :exec
DELETE from exchange_days
WHERE id = ?;

-- name: UpdateExchangeDay :one
UPDATE exchange_days
SET name = ?, 
swish_number = ?
WHERE id = ?
RETURNING *;

-- name: CreateSeller :one
INSERT INTO sellers (
  name, swish_number, exchange_day_id
) VALUES (
  ?, ?, ?
)
RETURNING *;
