
let encode_prefix str =
  let buf = Buffer.create (String.length str) in
  let push_char = function
    | '%' -> Buffer.add_string buf "%#"
    | '=' -> Buffer.add_string buf "%+"
    | ':' -> Buffer.add_string buf "%."
    | '/' -> Buffer.add_string buf "\\\\"
    | c -> Buffer.add_char buf c
  in
  String.iter push_char str;
  Buffer.contents buf

let rec main () =
  match read_line () with
  | exception _ -> ()
  | line -> print_string (encode_prefix line); main ()

let () = main ()
