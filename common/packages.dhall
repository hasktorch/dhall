   let prelude = ../dhall-to-cabal/dhall/prelude.dhall
in let types = ../dhall-to-cabal/dhall/types.dhall
in let fn = ./functions.dhall
in
{ base =
  { package = "base"
  , bounds =
      prelude.intersectVersionRanges
        ( prelude.unionVersionRanges
          (prelude.thisVersion (prelude.v "4.7"))
          (prelude.laterVersion (prelude.v "4.7")))
        (prelude.earlierVersion (prelude.v "5"))
  } : types.Dependency
, hspec =
  { package = "hspec"
  , bounds =
      prelude.unionVersionRanges
        (prelude.thisVersion (prelude.v "2.4.4"))
        (prelude.laterVersion (prelude.v "2.4.4"))
  } : types.Dependency

, hasktorch-raw-th    = fn.anyver "hasktorch-raw-th"
, hasktorch-raw-thc   = fn.anyver "hasktorch-raw-thc"
, hasktorch-types-th  = fn.anyver "hasktorch-types-th"
, hasktorch-types-thc = fn.anyver "hasktorch-types-thc"

, hasktorch-signatures         = fn.anyver "hasktorch-signatures"
, hasktorch-signatures-types   = fn.anyver "hasktorch-signatures-types"
, hasktorch-signatures-partial = fn.anyver "hasktorch-signatures-partial"
, hasktorch-signatures-support = fn.anyver "hasktorch-signatures-support"

, hasktorch-indef          = fn.anyver "hasktorch-indef"
, hasktorch-indef-floating = fn.anyver "hasktorch-indef-floating"
, hasktorch-indef-signed   = fn.anyver "hasktorch-indef-signed"
, hasktorch-indef-unsigned = fn.anyver "hasktorch-indef-unsigned"
, hasktorch = fn.anyver "hasktorch"

, QuickCheck = fn.anyver "QuickCheck"
, containers = fn.anyver "containers"
, deepseq =
  { bounds =
    prelude.unionVersionRanges
      ( prelude.thisVersion (prelude.v "1.3.0.0") )
      ( prelude.laterVersion (prelude.v "1.3.0.0") )
  , package = "deepseq" }
, dimensions =
  { bounds =
    prelude.unionVersionRanges
      ( prelude.thisVersion (prelude.v "1.0"))
      ( prelude.laterVersion (prelude.v "1.0"))
  , package = "dimensions" }
, managed =
  { bounds =
    prelude.intersectVersionRanges
      ( prelude.unionVersionRanges
        ( prelude.thisVersion (prelude.v "1.0.0"))
        ( prelude.laterVersion (prelude.v "1.0.0")))
      ( prelude.earlierVersion (prelude.v "1.1"))
  , package = "managed" }
, microlens =
  { bounds =
    prelude.unionVersionRanges
      ( prelude.thisVersion (prelude.v "0.4.8.1"))
      ( prelude.laterVersion (prelude.v "0.4.8.1"))
  , package = "microlens" }
, numeric-limits = fn.anyver "numeric-limits"
, safe-exceptions =
  { bounds =
    prelude.unionVersionRanges
      ( prelude.thisVersion (prelude.v "0.1.0.0"))
      ( prelude.laterVersion (prelude.v "0.1.0.0"))
  , package = "safe-exceptions" }
, singletons =
  { bounds =
    prelude.unionVersionRanges
      ( prelude.thisVersion (prelude.v "2.2"))
      ( prelude.laterVersion (prelude.v "2.2"))
  , package = "singletons" }
, text =
  { bounds =
    prelude.unionVersionRanges
      ( prelude.thisVersion (prelude.v "1.2.2.2"))
      ( prelude.laterVersion (prelude.v "1.2.2.2"))
  , package = "text" }
, typelits-witnesses = { bounds =
    prelude.unionVersionRanges
      ( prelude.thisVersion (prelude.v "0.2.3.0"))
      ( prelude.laterVersion (prelude.v "0.2.3.0"))
  , package = "typelits-witnesses" }
, backprop =
  { bounds =
    prelude.unionVersionRanges
      (prelude.thisVersion (prelude.v "0.2.5"))
      (prelude.laterVersion (prelude.v "0.2.5"))
  , package = "backprop" }
, ghc-typelits-natnormalise = fn.anyver "ghc-typelits-natnormalise"
, generic-lens = fn.anyver "generic-lens"
, hashable = fn.anyver "hashable"
, mtl = fn.anyver "mtl"
, microlens-platform = fn.anyver "microlens-platform"
, microlens-th = fn.anyver "microlens-th"
, monad-loops = fn.anyver "monad-loops"
, time = fn.anyver "time"
, transformers = fn.anyver "transformers"
, cuda = fn.anyver "cuda"
, vector = fn.anyver "vector"
, directory = fn.anyver "directory"
, filepath = fn.anyver "filepath"
, async = fn.anyver "async"
, SafeSemaphore = fn.anyver "SafeSemaphore"
, mwc-random = fn.anyver "mwc-random"
, primitive = fn.anyver "primitive"
, list-t = fn.anyver "list-t"
, gd = fn.anyver "gd"
, JuicyPixels = fn.anyver "JuicyPixels"
}

