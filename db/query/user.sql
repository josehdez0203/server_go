-- name: CreateUser :one
INSERT INTO users (
  email,
  name,
  lastname,
  phone,
  image,
  password
) VALUES(
$1, $2, $3,$4,'',$5
) RETURNING *;


-- name: GetUser :one
SELECT * FROM users
WHERE email = $1 LIMIT 1;
