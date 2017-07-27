type t = {
  length : int;
  width  : int;
} [@@deriving yojson]

let dimensions_to_json d =
  Yojson.Safe.to_string (to_yojson d)

let dimensions_of_json j =
  of_yojson (Yojson.Safe.from_string j)
