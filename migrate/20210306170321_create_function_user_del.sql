-- +goose Up
-- +goose StatementBegin
create or replace function test.user_del(_id integer)
  returns json as
$BODY$
begin
  delete from test.users where id = _id;

  return json_build_object('id', _id);

  exception when others then

  raise notice 'Illegal operation: %', SQLERRM;

  return json_build_object('error', SQLERRM);
end
$BODY$
language plpgsql volatile cost 100;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';
-- +goose StatementEnd
