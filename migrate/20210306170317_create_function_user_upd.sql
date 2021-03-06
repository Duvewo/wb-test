-- +goose Up
-- +goose StatementBegin
create or replace function test.user_upd(_id integer, _params json)
  returns json as
$BODY$
begin
  update test.users set
    name = _params->>'name',
    email = _params->>'email'
  where id = _id;

  return json_build_object('id', _id);

  exception when others then

  return json_build_object('error', SQLERRM);
end
$BODY$
language plpgsql volatile cost 100;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';
-- +goose StatementEnd
