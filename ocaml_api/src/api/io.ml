let hash_service host sheet hash =
  let path = Some (sheet ^ "/" ^ hash) in
  Http.json_get_service host path None 
  
let hash host sheet hash =
  let code, time, json = hash_service host sheet hash in
  match code with
    200 ->  LocatedValue.located_value_list_of_json json
  | _   ->  raise Http.Connection_failure

let read_service host sheet json_read_request =
  let path = Some ( "read/" ^ sheet) in
  Http.json_post_service host path json_read_request

let read host sheet read_request =
  let json_read_request =
    ReadRequest.read_request_to_json read_request in
  let code, time, json =
    read_service host sheet json_read_request     in
  match code with
    200 -> ReadPromise.read_promise_of_json json
  | _   -> raise Http.Connection_failure


let write_service host sheet json_write_request =
  let path = Some ( "write/" ^ sheet ) in
  Http.json_post_service host path json_write_request

let write host sheet write_request =
  let json_write_request =
    WriteRequest.write_request_to_json write_request in
  let code, time, json =
    write_service host sheet json_write_request      in
  match code with
    200 -> ()
  | _   -> raise Http.Connection_failure
