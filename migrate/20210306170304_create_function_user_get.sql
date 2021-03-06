-- +goose Up
-- +goose StatementBegin
create or replace function test.user_get(_id integer) 
  returns json as
$BODY$
declare
  _ret json;
begin
  if _id = 0 then
    select array_to_json(array(
      select row_to_json(r)
      from (
        select u.id, u.name, u.email
        from test.users u
      ) r
    )) into _ret;
  else
    select row_to_json(r) into _ret
    from (
      select u.id, u.name, u.email
      from test.users u
      where id = _id
    ) r;
  end if;

  return _ret;

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
