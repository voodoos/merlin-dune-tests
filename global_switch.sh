opam pin add dune.2.8.0 git+https://github.com/voodoos/dune.git#merlin-abs-paths --yes
opam install merlin base64 conf-jq ppx_compare ppx_sexp_conv --yes
opam update --yes
opam upgrade --yes
