  $ export OPAM_PREFIX=$(opam config var prefix)
  $ export BUILD_PATH_PREFIX_MAP="OPAM=$OPAM_PREFIX:$BUILD_PATH_PREFIX_MAP"

Dune ocaml-merlin:
  $ cd dune-ocaml-merlin

  $ opam exec -- dune exec ./main.exe --root . --no-print-dir
  T0NhbWwgcm9ja3Mh

  $ cat _build/default/.merlin-conf |
  > sed "s,[0-9][0-9]*:,?:,g"
  ((?:EXCLUDE_QUERY_DIR)(?:B?:OPAM/lib/base64)(?:B?:OPAM/lib/bytes)(?:B?:$TESTCASE_ROOT/dune-ocaml-merlin/_build/default/.main.eobjs/byte)(?:S?:OPAM/lib/base64)(?:S?:OPAM/lib/bytes)(?:S?:$TESTCASE_ROOT/dune-ocaml-merlin)(?:FLG(?:-w?:@1..3@5..28@30..39@43@46..47@49..57@61..62-?:-strict-sequence?:-strict-formats?:-short-paths?:-keep-locs)))

  $ opam exec -- ocamlmerlin single dump-configuration -filename main.ml < main.ml | jq

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
  FLG -w @1..3@5..28@30..39@43@46..47@49..57@61..62-40 -strict-sequence -strict-formats -short-paths -keep-locs

  $ opam exec -- ocamlmerlin single dump-configuration -filename main.ml <  main.ml | jq

  $ cd ..
