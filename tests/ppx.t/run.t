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

  $ cd bin

Project not build
  $ ocamlmerlin single errors -filename main.ml < main.ml |
  > jq '.value[0]'
  {
    "type": "config",
    "sub": [],
    "valid": true,
    "message": "No config found for file \"main.ml\" in \"bin\". Try calling `dune build`."
  }

Project built
  $ dune exec ./main.exe --no-print-dir
  (S(S Z)) != (S(S(S Z)))

  $ ocamlmerlin single errors -filename main.ml < main.ml |
  > jq '.value'
  []

  $ ocamlmerlin single dump-configuration -filename main.ml < main.ml |
  > jq '.value.merlin.build_path'
  [
    "OPAM/lib/base",
    "OPAM/lib/base/base_internalhash_types",
    "OPAM/lib/base/caml",
    "OPAM/lib/base/shadow_stdlib",
    "OPAM/lib/ppx_compare/runtime-lib",
    "OPAM/lib/ppx_sexp_conv/runtime-lib",
    "OPAM/lib/sexplib0",
    "$TESTCASE_ROOT/_build/default/bin/.main.eobjs/byte"
  ]


  $ ocamlmerlin single dump-configuration -filename main.ml < main.ml |
  > jq '.value.merlin.flags_applied' |
  > sed "s:.ppx/[^/]*/ppx:.ppx/.../ppx:"
  [
    {
      "workdir": "$TESTCASE_ROOT",
      "workval": [
        "-ppx",
        "$TESTCASE_ROOT/_build/default/.ppx/.../ppx.exe --as-ppx -no-locations-check -reserve-namespace toto"
      ]
    },
    {
      "workdir": "$TESTCASE_ROOT",
      "workval": [
        "-w",
        "@1..3@5..28@30..39@43@46..47@49..57@61..62-40",
        "-strict-sequence",
        "-strict-formats",
        "-short-paths",
        "-keep-locs"
      ]
    }
  ]

