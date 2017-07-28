type t = {
  tag    : string;
  time   : Nativeint.t;
  origin : Coordinates.t;
  length : int;
  width  : int;
  cells  : Cell.t list
} [@@deriving yojson]

let write_request ~tag ~time ~origin ~length ~width ~cells =
  { tag    = tag;
    time   = time;
    origin = origin;
    length = length;
    width  = width;
    cells = cells }

let write_request_to_json wr =
  Yojson.Safe.to_string (to_yojson wr)

let write_request_of_json j =
  of_yojson (Yojson.Safe.from_string j)
