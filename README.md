## Test suite for the new Merlin external config readers
The CI runs everyday at noon and fetches the latest version of the two
experimental branches:
- `git+https://github.com/voodoos/dune.git#merlin-abs-paths`
- `git+https://github.com/voodoos/merlin.git#ocaml-merlin-errors`

Tests are defined using the new `cram` stanza of Dune.
