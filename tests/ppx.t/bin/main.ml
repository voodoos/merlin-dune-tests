open Sexplib0

type n = Z | S of n [@@deriving compare, sexp_of]

let two   = S (S Z)
let three = S (S (S Z))

let () =
  let stwo   = Sexp.to_string @@ [%sexp_of: n] two in
  let sthree = Sexp.to_string @@ [%sexp_of: n] three in
  if [%compare.equal: n] two three then
    Printf.printf "!!! %s = %s\n%!" stwo sthree
  else
    Printf.printf "%s != %s\n%!" stwo sthree
