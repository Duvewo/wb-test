-- +goose Up
-- +goose StatementBegin
create table if not exists test.users
(
  id int not null default nextval('test.seq_users'::regclass),
  name varchar not null,
  email varchar not null,
  constraint "PK_users" primary key (id),
  constraint "UQ_users_email" unique (email),
  constraint "CHK_users_email" check (email like '%@%')
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table test.users;
-- +goose StatementEnd
