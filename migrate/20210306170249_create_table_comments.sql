-- +goose Up
-- +goose StatementBegin
create table if not exists test.comments
(
  id int not null default nextval('test.seq_comments'::regclass),
  id_user int not null,
  txt varchar not null,
  constraint "PK_comments" primary key (id)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table test.comments;
-- +goose StatementEnd
