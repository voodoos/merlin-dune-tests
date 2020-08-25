  $ export OPAM_PREFIX=$(opam config var prefix)
  $ export BUILD_PATH_PREFIX_MAP="OPAM=$OPAM_PREFIX:$BUILD_PATH_PREFIX_MAP"

  $ alias dot-merlin-reader="opam exec -- dot-merlin-reader"
  $ alias dune="opam exec -- dune"
  $ alias ocamlmerlin="opam exec -- ocamlmerlin"

Dune ocaml-merlin:
  $ cd dune-ocaml-merlin

  $ dune exec ./main.exe --root . --no-print-dir
  T0NhbWwgcm9ja3Mh

  $ cat _build/default/.merlin-conf |
  > sed "s,[0-9][0-9]*:,?:,g"
  ((?:EXCLUDE_QUERY_DIR)(?:B?:OPAM/lib/base64)(?:B?:OPAM/lib/bytes)(?:B?:$TESTCASE_ROOT/dune-ocaml-merlin/_build/default/.main.eobjs/byte)(?:S?:OPAM/lib/base64)(?:S?:OPAM/lib/bytes)(?:S?:$TESTCASE_ROOT/dune-ocaml-merlin)(?:FLG(?:-w?:@1..3@5..28@30..39@43@46..47@49..57@61..62-?:-strict-sequence?:-strict-formats?:-short-paths?:-keep-locs)))

  $ opam exec -- ocamlmerlin single dump-configuration -filename main.ml < main.ml |
  > jq '.value' | tee ../ocaml_merlin.res
  {
    "ocaml": {
      "include_dirs": [],
      "no_std_include": false,
      "unsafe": false,
      "classic": false,
      "principal": false,
      "real_paths": false,
      "recursive_types": false,
      "strict_sequence": true,
      "applicative_functors": true,
      "unsafe_string": false,
      "nopervasives": false,
      "strict_formats": true,
      "open_modules": [],
      "ppx": [],
      "pp": null,
      "warnings": {
        "actives": [
          1,
          2,
          3,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18,
          19,
          20,
          21,
          22,
          23,
          24,
          25,
          26,
          27,
          28,
          30,
          31,
          32,
          33,
          34,
          35,
          36,
          37,
          38,
          39,
          43,
          46,
          47,
          49,
          50,
          51,
          52,
          53,
          54,
          55,
          56,
          57,
          58,
          59,
          61,
          62,
          63,
          64,
          65
        ],
        "warn_error": [
          1,
          2,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18,
          19,
          20,
          21,
          22,
          23,
          24,
          25,
          26,
          27,
          28,
          30,
          31,
          32,
          33,
          34,
          35,
          36,
          37,
          38,
          39,
          43,
          46,
          47,
          49,
          50,
          51,
          52,
          53,
          54,
          55,
          56,
          57,
          61,
          62
        ]
      }
    },
    "merlin": {
      "build_path": [
        "OPAM/lib/base64",
        "OPAM/lib/bytes",
        "$TESTCASE_ROOT/dune-ocaml-merlin/_build/default/.main.eobjs/byte"
      ],
      "source_path": [
        "OPAM/lib/base64",
        "OPAM/lib/bytes",
        "$TESTCASE_ROOT/dune-ocaml-merlin"
      ],
      "cmi_path": [],
      "cmt_path": [],
      "flags_applied": [
        {
          "workdir": "$TESTCASE_ROOT/dune-ocaml-merlin",
          "workval": [
            "-w",
            "@1..3@5..28@30..39@43@46..47@49..57@61..62-40",
            "-strict-sequence",
            "-strict-formats",
            "-short-paths",
            "-keep-locs"
          ]
        }
      ],
      "extensions": [],
      "suffixes": [
        {
          "impl": ".ml",
          "intf": ".mli"
        },
        {
          "impl": ".re",
          "intf": ".rei"
        }
      ],
      "stdlib": null,
      "reader": [],
      "protocol": "json",
      "log_file": null,
      "log_sections": [],
      "flags_to_apply": [],
      "failures": [],
      "assoc_suffixes": [
        {
          "extension": ".re",
          "reader": "reason"
        },
        {
          "extension": ".rei",
          "reader": "reason"
        }
      ]
    },
    "query": {
      "filename": "main.ml",
      "directory": "$TESTCASE_ROOT/dune-ocaml-merlin",
      "printer_width": 0,
      "verbosity": 0
    }
  }

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

  $ ocamlmerlin single dump-configuration -filename main.ml <  main.ml |
  > jq '.value' | tee ../dot_reader.res
  {
    "ocaml": {
      "include_dirs": [],
      "no_std_include": false,
      "unsafe": false,
      "classic": false,
      "principal": false,
      "real_paths": false,
      "recursive_types": false,
      "strict_sequence": true,
      "applicative_functors": true,
      "unsafe_string": false,
      "nopervasives": false,
      "strict_formats": true,
      "open_modules": [],
      "ppx": [],
      "pp": null,
      "warnings": {
        "actives": [
          1,
          2,
          3,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18,
          19,
          20,
          21,
          22,
          23,
          24,
          25,
          26,
          27,
          28,
          30,
          31,
          32,
          33,
          34,
          35,
          36,
          37,
          38,
          39,
          43,
          46,
          47,
          49,
          50,
          51,
          52,
          53,
          54,
          55,
          56,
          57,
          58,
          59,
          61,
          62,
          63,
          64,
          65
        ],
        "warn_error": [
          1,
          2,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18,
          19,
          20,
          21,
          22,
          23,
          24,
          25,
          26,
          27,
          28,
          30,
          31,
          32,
          33,
          34,
          35,
          36,
          37,
          38,
          39,
          43,
          46,
          47,
          49,
          50,
          51,
          52,
          53,
          54,
          55,
          56,
          57,
          61,
          62
        ]
      }
    },
    "merlin": {
      "build_path": [
        "OPAM/lib/base64",
        "OPAM/lib/bytes",
        "$TESTCASE_ROOT/dot-merlin-reader/_build/default/.main.eobjs/byte"
      ],
      "source_path": [
        "OPAM/lib/base64",
        "OPAM/lib/bytes",
        "$TESTCASE_ROOT/dot-merlin-reader"
      ],
      "cmi_path": [],
      "cmt_path": [],
      "flags_applied": [
        {
          "workdir": "$TESTCASE_ROOT/dot-merlin-reader",
          "workval": [
            "-w",
            "@1..3@5..28@30..39@43@46..47@49..57@61..62-40",
            "-strict-sequence",
            "-strict-formats",
            "-short-paths",
            "-keep-locs"
          ]
        }
      ],
      "extensions": [],
      "suffixes": [
        {
          "impl": ".ml",
          "intf": ".mli"
        },
        {
          "impl": ".re",
          "intf": ".rei"
        }
      ],
      "stdlib": null,
      "reader": [],
      "protocol": "json",
      "log_file": null,
      "log_sections": [],
      "flags_to_apply": [],
      "failures": [],
      "assoc_suffixes": [
        {
          "extension": ".re",
          "reader": "reason"
        },
        {
          "extension": ".rei",
          "reader": "reason"
        }
      ]
    },
    "query": {
      "filename": "main.ml",
      "directory": "$TESTCASE_ROOT/dot-merlin-reader",
      "printer_width": 0,
      "verbosity": 0
    }
  }

  $ cd ..

Compare both
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
  188c188
  <     "directory": "$TESTCASE_ROOT/dune-ocaml-merlin",
  ---
  >     "directory": "$TESTCASE_ROOT/dot-merlin-reader",
  [1]
