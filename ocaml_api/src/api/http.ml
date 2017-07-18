open Curl

exception Connection_failure

let accept_json  = "accept: application/json"

let content_json = "content_type: application/json"

let http_connection ~url ~header ~writer  =
  let connection = init () in
  set_url connection url;
  set_httpheader connection header;
  set_writefunction connection writer;
  connection

let send_request connection =
  perform connection;
  get_responsecode connection

let time_in_host connection =
  let connect_time = get_connecttime connection              in
  let start_transfer_time = get_starttransfertime connection in
  start_transfer_time -. connect_time

let cleanup_request connection =
  cleanup connection

let make_path ~host ~path = match path with
    Some p -> Printf.sprintf "%s/%s" host p
  | None -> host

let make_get_url ~host ~path ~query=
  let p = make_path host path in
  match query with
    Some q -> Printf.sprintf "%s?%s" p q
  | None -> p
  
let get_request ~host ~writer ~header ~path ~query =
  let url = make_get_url ~host ~path ~query in
  http_connection ~url:url ~header:header ~writer:writer

let post_request ~host ~writer ~header ~path ~body =
  let url  = make_path ~host:host ~path:path in
  let connection = http_connection ~url:url
      ~header:header ~writer:writer          in
  set_post connection true;
  set_postfields connection body;
  connection

let writer size =
  let buffer = Buffer.create size          in
  let write  data =
    Buffer.add_string buffer data;
    String.length data                     in
  let contents () = Buffer.contents buffer in
  (write,contents)


let json_service request contents =
  let code = send_request request              in
  let time = time_in_host request              in
  let raw  = contents ()                       in
  cleanup_request request;
  code,time,raw

let json_get_service ?(size=128) host path query  =
  let write,contents = writer size             in
  let request = get_request ~host:host
      ~writer:write ~header:[accept_json]
      ~path:path ~query:query                  in
  json_service request contents

let json_post_service ?(size=128) host path body  =
  let write,contents = writer size        in
  let request = post_request ~host:host
      ~writer:write
      ~header:[accept_json; content_json]
      ~path:path ~body:body               in
  json_service request contents
  
      
