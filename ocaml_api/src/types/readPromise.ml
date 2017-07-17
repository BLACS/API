type date = float
  
and  t = {
  date : date;
  hash : string
} [@@deriving yojson]

let read_promise ~date ~hash =
  { date = date;
    hash = hash }

let read_promise_to_json rp   =
  Yojson.Safe.to_string (to_yojson rp )

let read_promise_of_json j  =
  of_yojson ( Yojson.Safe.from_string j )
