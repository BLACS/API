type t = {
  tag    : string;
  time   : Time.t;
  origin : Coordinates.t;
  length : int;
  width  : int;
  default: string option
} [@@deriving yojson]

let read_request ~tag ~time ~origin ~length ~width ~default =
  { tag = tag;
    time = time;
    origin = origin;
    length = length;
    width = width;
    default = default }

let read_request_to_json rr =
  Yojson.Safe.to_string (to_yojson rr)

let read_request_of_json j =
  of_yojson (Yojson.Safe.from_string j)
