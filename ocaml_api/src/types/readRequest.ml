type t = {
  tag             : string;
  time            : Time.t;
  origin          : Coordinates.t;
  length          : int;
  width           : int;
  filter_formulas : bool;
  default         : string option
} [@@deriving yojson]

let read_request ~tag ~time ~origin ~length ~width ~filter_formulas ~default =
  { tag             = tag;
    time            = time;
    origin          = origin;
    length          = length;
    width           = width;
    filter_formulas = filter_formulas;
    default         = default }

let read_request_to_json rr =
  Yojson.Safe.to_string (to_yojson rr)

let read_request_of_json j =
  of_yojson (Yojson.Safe.from_string j)
