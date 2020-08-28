========
 CONFIG
========

CRAM sanitization
  $ export OPAM_PREFIX=$(opam config var prefix)
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

  $ cd sub_project/bin
  $ dune exec ./main.exe --no-print-dir
  T0NhbWwgcm9ja3Mh

  $ ocamlmerlin single dump-configuration -filename main.ml < main.ml |
  > jq '.value.merlin.build_path'
  [
    "OPAM/lib/base64",
    "OPAM/lib/bytes",
    "$TESTCASE_ROOT/_build/default/sub_project/bin/.main.eobjs/byte"
  ]

  $ cd ../..
  $ ocamlmerlin single dump-configuration -filename sub_project/bin/main.ml \
  > < sub_project/bin/main.ml | jq '.value.merlin.build_path'
  [
    "OPAM/lib/base64",
    "OPAM/lib/bytes",
    "$TESTCASE_ROOT/_build/default/sub_project/bin/.main.eobjs/byte"
  ]
