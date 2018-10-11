let
  mappings = ./mappings.dhall
in
{ storage = mappings.storage
, support = mappings.support
, unsigned = mappings.unsigned
, signed = mappings.signed
, floating = mappings.floating
, nn = mappings.nn
}
