type ty =
    TyInt
  | TyNone
  | TyCount 
    
let ty_to_yojson =
  let str t = `String t in
  function
    TyInt   -> str "int"
  | TyCount -> str "count"
  | TyNone  -> str "none"
                 
let ty_of_yojson =
  let ok t = Result.Ok t in
  function
    `String "int"   -> ok TyInt
  | `String "count" -> ok TyCount
  | `String "none"  -> ok TyNone
  | _ -> Result.Error "ty"

type date = float
  [@@deriving yojson]

type promise = {
  date   : date;
  domain : int list;
  definition  : int option
} [@@deriving yojson]
           
type t = {
  ty       : ty;
  data     : (int list)     option;
  promises : (promise list) option
} [@@deriving yojson]

let int i   = {
  ty       = TyInt;
  data     = Some [i];
  promises = None
}

let null_int = {
  ty       = TyInt;
  data     = None;
  promises = None
}

let count c r l w v = {
  ty       = TyCount;
  data     = Some [c; r; l; w; v];
  promises = None
}
                          
let none ={
  ty       = TyNone;
  data     = None;
  promises = None
}

let succ = function
    { ty = TyInt; data = Some [i]; promises = None } ->
    int (i + 1)
  | _ -> assert false

let string_of_definition =
  let open Printf in
  function
    { ty = TyNone; data = None }     -> "⊥"
  | { ty = TyInt;  data = None }     -> "null"
  | { ty = TyInt;  data = Some [i] } -> sprintf "val %d" i
  | { ty   = TyCount; data = Some [c; r; l; w; v] } ->
    sprintf "=( %d, %d, %d, %d, %d)" c r l w v
  | _ -> assert false


let definition_to_json v =
  Yojson.Safe.to_string (to_yojson v)

let definition_of_json j=
   of_yojson (Yojson.Safe.from_string j)
