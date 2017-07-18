module Host = struct
  
  let host = "http://localhost:8080"

end

module LocalBlacs = BlacsPervasives.Make (Host)

open LocalBlacs 

let () =
  match clock_time "test" with
    Result.Ok t -> print_endline (Nativeint.to_string t)
  | Result.Error e -> failwith e

