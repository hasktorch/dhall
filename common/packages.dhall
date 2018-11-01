   let prelude = ../dhall-to-cabal/dhall/prelude.dhall
in let types = ../dhall-to-cabal/dhall/types.dhall
in let fn = ./functions.dhall
in let gte
  =  \(name  : Text)
  -> \(version : Text)
  -> { package = name
     , bounds =
        prelude.unionVersionRanges
          (prelude.thisVersion (prelude.v version))
          (prelude.laterVersion (prelude.v version))
     } : types.Dependency

in let gteBounded
  =  \(name  : Text)
  -> \(version : Text)
  -> \(bound : Text)
  -> { package = name
     , bounds =
        prelude.intersectVersionRanges
          ( prelude.unionVersionRanges
            ( prelude.thisVersion  (prelude.v version))
            ( prelude.laterVersion (prelude.v version)))
          ( prelude.earlierVersion (prelude.v bound))
     } : types.Dependency

in
{ async                        = fn.anyver        "async"
, backprop                     = gte           "backprop"  "0.2.5"
, base                         = gteBounded        "base"    "4.7" "5"
, bytestring                   = gte         "bytestring" "0.10.8"
, containers                   = gte         "containers" "0.5.10"
, cryptonite                   = gte         "cryptonite"   "0.25"
, cuda                         = fn.anyver         "cuda"
, deepseq                      = gte            "deepseq" "1.3.0"
, dimensions                   = gte         "dimensions"   "1.0"
, directory                    = gte          "directory" "1.3.0"
, dlist                        = gte              "dlist" "0.8.0"
, filepath                     = gte           "filepath" "1.4.1"
, gd                           = fn.anyver           "gd"
, generic-lens                 = fn.anyver "generic-lens"
-- FIXME: replace with thorin?
, ghc-typelits-natnormalise    = fn.anyver "ghc-typelits-natnormalise"
, hashable                     = gte "hashable"              "1.2.7"
, hspec                        = gte "hspec"                 "2.4.4"
, hspec-discover               = gte "hspec-discover"        "2.5.0"
, HTTP                         = gte "HTTP"              "4000.3.11"
, inline-c                     = gte "inline-c"                "0.5"
, JuicyPixels                  = gte "JuicyPixels"             "3.3"
, list-t                       = gte "list-t"                "1.0.1"
, managed                      = gteBounded "managed"        "1.0.0" "1.1"
, megaparsec                   = gteBounded "megaparsec"     "6.0.0" "8.0.0"
, microlens                    = gte "microlens"             "0.4.8"
, microlens-platform           = gte "microlens-platform"   "0.3.10"
, microlens-th                 = gte "microlens-th"          "0.4.2"
, monad-loops                  = gte "monad-loops"           "0.4.3"
, mtl                          = gte "mtl"                   "2.2.2"
, mwc-random                   = gte "mwc-random"           "0.14.0"
, network-uri                  = gte "network-uri"           "2.6.1"
, numeric-limits               = gte "numeric-limits"        "0.1.0"
, optparse-applicative         = gte "optparse-applicative" "0.14.2"
, primitive                    = gte "primitive"             "0.6.3"
, pretty-show                  = gte "pretty-show"             "1.7"
, QuickCheck                   = gte "QuickCheck"             "2.11"
, SafeSemaphore                = fn.anyver "SafeSemaphore"
, safe-exceptions              = gte "safe-exceptions"       "0.1.0"
, singletons                   = gte "singletons"              "2.2"
, text                         = gte "text"                  "1.2.2"
, time                         = gte "time"                  "1.8.0"
, transformers                 = gte "transformers"          "0.5.5"
, typelits-witnesses           = gte "typelits-witnesses"    "0.2.3"
, unordered-containers         = gte "unordered-containers"  "0.2.9"
, vector                       = gte "vector"               "0.12.0"

-- hasktorch projects
, hasktorch                    = fn.anyver "hasktorch"
, hasktorch-indef              = fn.anyver "hasktorch-indef"
, hasktorch-indef-floating     = fn.anyver "hasktorch-indef-floating"
, hasktorch-indef-signed       = fn.anyver "hasktorch-indef-signed"
, hasktorch-indef-unsigned     = fn.anyver "hasktorch-indef-unsigned"
, hasktorch-ffi-tests          = fn.anyver "hasktorch-ffi-tests"
, hasktorch-ffi-th             = fn.anyver "hasktorch-ffi-th"
, hasktorch-ffi-thc            = fn.anyver "hasktorch-ffi-thc"
, hasktorch-signatures         = fn.anyver "hasktorch-signatures"
, hasktorch-signatures-partial = fn.anyver "hasktorch-signatures-partial"
, hasktorch-signatures-support = fn.anyver "hasktorch-signatures-support"
, hasktorch-signatures-types   = fn.anyver "hasktorch-signatures-types"
, hasktorch-types-th           = fn.anyver "hasktorch-types-th"
, hasktorch-types-thc          = fn.anyver "hasktorch-types-thc"
, hasktorch-zoo                = fn.anyver "hasktorch-zoo"
}

