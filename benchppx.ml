type t = 
  {
    red : int;
    green : string
  }

[@@deriving show]

let test = {red = 0; green = "qql"}
let () = print_endline (show test)