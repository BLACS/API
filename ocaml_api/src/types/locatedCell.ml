type t = {
  cell   : Cell.t;
  coords : Coordinates.t
} [@@deriving yojson]

type located_cell_list = t list [@@deriving yojson]

let located_cell (coordinates,cell) =
  {cell=cell;
   coords=coordinates}

let located_cell_list_to_json lcl =
  Yojson.Safe.to_string (located_cell_list_to_yojson lcl)
    
let located_cell_list_of_json j   =
  located_cell_list_of_yojson (Yojson.Safe.from_string j)
