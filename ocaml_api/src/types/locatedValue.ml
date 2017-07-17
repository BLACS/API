type t = {
  coords: Coordinates.t ;
  value : Value.t
} [@@deriving yojson]

type located_value_list =  t list  [@@deriving yojson]

let located_value_list_to_json lvl =
  Yojson.Safe.to_string ( located_value_list_to_yojson lvl )

let located_value_list_of_json j =
  located_value_list_of_yojson ( Yojson.Safe.from_string j )

