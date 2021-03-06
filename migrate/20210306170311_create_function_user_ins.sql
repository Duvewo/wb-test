-- +goose Up
-- +goose StatementBegin
create or replace function test.user_ins(_params json)
  returns json as
$BODY$
declare
  _newid integer;
begin
  _newid = 0;

  insert into test.users (name, email)
  select name, email
  from json_populate_record(null::test.users, _params)
  returning id into _newid;

  return json_build_object('id', _newid);

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
