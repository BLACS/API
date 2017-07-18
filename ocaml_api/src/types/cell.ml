type t = {
  value      : Value.t option;
  definition : Definition.t
} [@@deriving yojson]

let cell ?v d =
  let v = Value.value v in
  { value= Some v; definition=d }

let cell_to_json c =
  Yojson.Safe.to_string ( to_yojson c )

let cell_of_json j =
  of_yojson ( Yojson.Safe.from_string j )

