   let prelude = ../dhall-to-cabal/dhall/prelude.dhall
in let types = ../dhall-to-cabal/dhall/types.dhall
in let fn = ./functions.dhall
in let range
  =  \(name  : Text)
  -> \(left  : Text)
  -> \(right : Text)
  -> { package = name
     , bounds =
        prelude.unionVersionRanges
          (prelude.thisVersion (prelude.v left))
          (prelude.laterVersion (prelude.v right))
     } : types.Dependency

in let exactly
  =  \(name  : Text)
  -> \(version : Text)
  -> { package = name
     , bounds =
        prelude.unionVersionRanges
          (prelude.thisVersion (prelude.v version))
          (prelude.laterVersion (prelude.v version))
     } : types.Dependency

in let rangeAndEarlierThan
  =  \(name  : Text)
  -> \(left  : Text)
  -> \(right : Text)
  -> \(earlierthan : Text)
  -> { package = name
     , bounds =
         prelude.intersectVersionRanges
           ( prelude.unionVersionRanges
             ( prelude.thisVersion (prelude.v left))
             ( prelude.laterVersion (prelude.v right)))
           ( prelude.earlierVersion (prelude.v earlierthan))
     } : types.Dependency
in
{ async                        = fn.anyver "async"
, backprop                     = exactly "backprop" "0.2.5"
, base                         = rangeAndEarlierThan "base" "4.7" "4.7" "5"
, bytestring                   = fn.anyver "bytestring"
, containers                   = fn.anyver "containers"
, cryptonite                   = fn.anyver "cryptonite"
, cuda                         = fn.anyver "cuda"
, deepseq                      = exactly "deepseq" "1.3.0.0"
, dimensions                   = exactly "dimensions" "1.0"
, directory                    = fn.anyver "directory"
, dlist                        = fn.anyver "dlist"
, filepath                     = fn.anyver "filepath"
, gd                           = fn.anyver "gd"
, generic-lens                 = fn.anyver "generic-lens"
-- FIXME: replace with thorin?
, ghc-typelits-natnormalise    = fn.anyver "ghc-typelits-natnormalise"
, hashable                     = fn.anyver "hashable"
, hasktorch                    = fn.anyver "hasktorch"
, hasktorch-indef              = fn.anyver "hasktorch-indef"
, hasktorch-indef-floating     = fn.anyver "hasktorch-indef-floating"
, hasktorch-indef-signed       = fn.anyver "hasktorch-indef-signed"
, hasktorch-indef-unsigned     = fn.anyver "hasktorch-indef-unsigned"
, hasktorch-raw-th             = fn.anyver "hasktorch-raw-th"
, hasktorch-raw-thc            = fn.anyver "hasktorch-raw-thc"
, hasktorch-signatures         = fn.anyver "hasktorch-signatures"
, hasktorch-signatures-partial = fn.anyver "hasktorch-signatures-partial"
, hasktorch-signatures-support = fn.anyver "hasktorch-signatures-support"
, hasktorch-signatures-types   = fn.anyver "hasktorch-signatures-types"
, hasktorch-types-th           = fn.anyver "hasktorch-types-th"
, hasktorch-types-thc          = fn.anyver "hasktorch-types-thc"
, hasktorch-zoo                = fn.anyver "hasktorch-zoo"
, hspec                        = exactly "hspec" "2.4.4"
, HTTP                         = fn.anyver "HTTP"
, JuicyPixels                  = fn.anyver "JuicyPixels"
, list-t                       = fn.anyver "list-t"
, managed                      = rangeAndEarlierThan "managed" "1.0.0" "1.0.0" "1.1"
, microlens                    = exactly "microlens" "0.4.8.1"
, microlens-platform           = fn.anyver "microlens-platform"
, microlens-th                 = fn.anyver "microlens-th"
, monad-loops                  = fn.anyver "monad-loops"
, mtl                          = fn.anyver "mtl"
, mwc-random                   = fn.anyver "mwc-random"
, network-uri                  = fn.anyver "network-uri"
, numeric-limits               = fn.anyver "numeric-limits"
, primitive                    = fn.anyver "primitive"
, QuickCheck                   = fn.anyver "QuickCheck"
, SafeSemaphore                = fn.anyver "SafeSemaphore"
, safe-exceptions              = exactly "safe-exceptions" "0.1.0.0"
, singletons                   = exactly "singletons" "2.2"
, text                         = exactly "text" "1.2.2.2"
, time                         = fn.anyver "time"
, transformers                 = fn.anyver "transformers"
, typelits-witnesses           = exactly "typelits-witnesses" "0.2.3.0"
, unordered-containers         = fn.anyver "unordered-containers"
, vector                       = fn.anyver "vector"
}

