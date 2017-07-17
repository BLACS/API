type t = {
  col : int;
  row : int
} [@@ deriving yojson]

exception No_successor

let coords c r  = { col = c ; row = r }

let equal x y   = match x, y with
    { col = xc ; row = xr },
    { col = yc ; row = yr } ->
    xc, xr = yc, yr
                               
let hash        =
  fun { col = c ; row = r } ->
    Hashtbl.hash (c, r)

let compare x y = match x, y with
    { col = c1 ; row = r1 },
    { col = c2 ; row = r2 } ->
    Pervasives.compare (c1, r1) (c2, r2)

let lteq x y    = match x, y with
    { col = c1 ; row = r1 },
    { col = c2 ; row = r2 } ->
    (c1 <= c2) && (r1 <= r2)
                  
let next origin length width =
  fun { col = c ; row = r } ->
    if c < (origin.col + length - 1) then
      coords (c + 1) r
    else
    if r < (origin.row + width  - 1) then
      coords origin.col (r + 1)
    else
      raise No_successor

let to_string =
  fun { row = r ; col = c } ->
    Printf.sprintf "(%d, %d)" c r

let coordinates_to_json c =
  Yojson.Safe.to_string (to_yojson c)

let coordinates_of_json j =
  of_yojson (Yojson.Safe.from_string j)

