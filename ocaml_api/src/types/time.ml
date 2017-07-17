type t = Nativeint.t [@@deriving yojson]

let time_to_json t =
   Yojson.Safe.to_string (to_yojson t)

let time_of_json j =
  of_yojson (Yojson.Safe.from_string j)
