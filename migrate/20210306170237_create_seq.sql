-- +goose Up
-- +goose StatementBegin
create sequence if not exists test.seq_users;
create sequence if not exists test.seq_comments;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
-- +goose StatementEnd
