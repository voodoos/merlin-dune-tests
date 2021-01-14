========
 CONFIG
========

CRAM sanitization
  $ export OPAM_PREFIX=$(opam config var prefix | encode_prefix)
  $ export BUILD_PATH_PREFIX_MAP="OPAM=$OPAM_PREFIX:$BUILD_PATH_PREFIX_MAP"

Use correct executables
  $ alias dot-merlin-reader="opam exec -- dot-merlin-reader"
  $ alias dune="opam exec -- dune"
  $ alias ocamlmerlin="opam exec -- ocamlmerlin"

Enable root discovery
  $ unset INSIDE_DUNE

=======
 TESTS
=======

Dune ocaml-merlin:
  $ cd dune-ocaml-merlin

  $ dune exec ./main.exe --no-print-dir
  T0NhbWwgcm9ja3Mh

  $ dune ocaml-merlin --dump-config=$(pwd)
  Main
  ((EXCLUDE_QUERY_DIR)
   (B OPAM/lib/base64)
   (B OPAM/lib/bytes)
   (B
    $TESTCASE_ROOT/dune-ocaml-merlin/_build/default/.main.eobjs/byte)
   (S OPAM/lib/base64)
   (S OPAM/lib/bytes)
   (S
    $TESTCASE_ROOT/dune-ocaml-merlin)
   (FLG
    (-w
     @1..3@5..28@30..39@43@46..47@49..57@61..62-40
     -strict-sequence
     -strict-formats
     -short-paths
     -keep-locs))
   (SUFFIX ".aml .amli")
   (SUFFIX ".baml .bamli"))

  $ ocamlmerlin single dump-configuration -filename main.ml < main.ml |
  > jq '.value' | tee ../ocaml_merlin.res | jq '.merlin.build_path'
  [
    "OPAM/lib/base64",
    "OPAM/lib/bytes",
    "$TESTCASE_ROOT/dune-ocaml-merlin/_build/default/.main.eobjs/byte"
  ]

  $  cd ..

Dot merlin reader:
  $ cd dot-merlin-reader

  $ cat .merlin.template |
  > sed "s,%%OPAM%%,${OPAM_PREFIX},g" > .merlin

  $ cat .merlin
  EXCLUDE_QUERY_DIR
  B OPAM/lib/base64
  B OPAM/lib/bytes
  B _build/default/.main.eobjs/byte
  S OPAM/lib/base64
  S OPAM/lib/bytes
  S .
  SUFFIX .aml .amli
  SUFFIX .baml .bamli
  FLG -w @1..3@5..28@30..39@43@46..47@49..57@61..62-40 -strict-sequence -strict-formats -short-paths -keep-locs

  $ ocamlmerlin single dump-configuration -filename main.ml <  main.ml |
  > jq '.value' | tee ../dot_reader.res | jq '.merlin.build_path'
  [
    "OPAM/lib/base64",
    "OPAM/lib/bytes",
    "$TESTCASE_ROOT/dot-merlin-reader/_build/default/.main.eobjs/byte"
  ]

  $ cd ..

Compare both:
  $ diff ocaml_merlin.res dot_reader.res
  135c135
  <       "$TESTCASE_ROOT/dune-ocaml-merlin/_build/default/.main.eobjs/byte"
  ---
  >       "$TESTCASE_ROOT/dot-merlin-reader/_build/default/.main.eobjs/byte"
  140c140
  <       "$TESTCASE_ROOT/dune-ocaml-merlin"
  ---
  >       "$TESTCASE_ROOT/dot-merlin-reader"
  146c146
  <         "workdir": "$TESTCASE_ROOT/dune-ocaml-merlin",
  ---
  >         "workdir": "$TESTCASE_ROOT/dot-merlin-reader",
  196c196
  <     "directory": "$TESTCASE_ROOT/dune-ocaml-merlin",
  ---
  >     "directory": "$TESTCASE_ROOT/dot-merlin-reader",
  [1]
