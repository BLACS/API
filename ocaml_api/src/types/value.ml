type ty =
    TyInt
  | TyNone
    
let ty_to_yojson =
  let str t = `String t in
  function
    TyInt   -> str "int"
  | TyNone  -> str "none"
                 
let ty_of_yojson =
  let ok t = Result.Ok t in
  function
    `String "int"   -> ok TyInt
  | `String "none"  -> ok TyNone
  | _ -> Result.Error "ty"
           
type t = {
  ty       : ty;
  data     : int option
} [@@deriving yojson]

let int i   = {
  ty       = TyInt;
  data     = Some i
}

let null_int = {
  ty       = TyInt;
  data     = None
}
                  
let none ={
  ty       = TyNone;
  data     = None
}

let value v =
  match v with
    None   -> none
  | Some i -> int i

let succ = function
    { ty = TyInt; data = Some i } ->
    int (i + 1)
  | _ -> assert false

let string_of_value =
  let open Printf in
  function
    { ty = TyNone; data = None }     -> "⊥"
  | { ty = TyInt;  data = None }     -> "null"
  | { ty = TyInt;  data = Some i } -> sprintf "val %d" i
  | _ -> assert false


let value_to_json v =
  Yojson.Safe.to_string (to_yojson v)

let value_of_json j=
   of_yojson (Yojson.Safe.from_string j)
