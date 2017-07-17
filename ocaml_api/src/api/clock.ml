let time_service host sheet =
  let path = Some ("time/" ^ sheet) in
  Http.json_get_service host path None

let time host sheet =
  let code,host,json = time_service host sheet in
  match code with
    200 ->  Time.time_of_json json
  | _   ->  raise Http.Connection_failure
