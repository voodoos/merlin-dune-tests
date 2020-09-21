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

  $ dune exec ./main.exe --no-print-dir
  U3ludGFjdGljIHN1Z2FyIGNhdXNlcyBjYW5jZXIgb2YgdGhlIHNlbWljb2xvbi4=

  $ ocamlmerlin single dump-configuration -filename main.ml < main.ml |
  > jq '.value.merlin.build_path'
  [
    "OPAM/lib/base64",
    "OPAM/lib/bytes",
    "OPAM/lib/re",
    "OPAM/lib/seq",
    "$TESTCASE_ROOT/_build/default/.foo.objs/byte",
    "$TESTCASE_ROOT/_build/default/.main.eobjs/byte"
  ]

  $ ocamlmerlin single dump-configuration -filename foo.ml < foo.ml |
  > jq '.value.merlin.build_path'
  [
    "OPAM/lib/base64",
    "OPAM/lib/bytes",
    "OPAM/lib/re",
    "OPAM/lib/seq",
    "$TESTCASE_ROOT/_build/default/.foo.objs/byte",
    "$TESTCASE_ROOT/_build/default/.main.eobjs/byte"
  ]
