   let prelude = ../../dhall-to-cabal/dhall/prelude.dhall sha256:01509b3c6e9eaae4150a6e0ced124c2db191bf6046534a9d4973b7f05afd1d0a
in let types = ../../dhall-to-cabal/dhall/types.dhall sha256:cfd7597246781e8d4c6dfa5f0eabba75f14dc3f3deb7527973909b37c93f42f5
in let fn = ./common/functions.dhall sha256:45e8bee44c93da6f4c47a3fdacc558b00858461325b807d4afc8bf0965716c33
in let main-release = prelude.v "0.0.1.0" : types.Version
in let versions =
  { hasktorch  = main-release
  , zoo        = main-release
  , examples   = main-release
  , indef      = main-release
  , signatures = main-release
  , ffi        = main-release
  , types      = main-release
  , codegen    = prelude.v "0.0.1.1" : types.Version
  }

in let htConstraint
  =  \(name  : Text)
  -> { package = name
     , bounds = prelude.intersectVersionRanges
         ( prelude.unionVersionRanges
           (prelude.thisVersion (prelude.v "0.0.1"))
           (prelude.laterVersion (prelude.v "0.0.1"))
         )
       (prelude.earlierVersion (prelude.v "0.0.2"))
     } : types.Dependency

in let constraints =
  { hasktorch                    = htConstraint "hasktorch"
  , hasktorch-indef              = htConstraint "hasktorch-indef"
  , hasktorch-indef-floating     = fn.anyver "hasktorch-indef-floating"
  , hasktorch-indef-signed       = fn.anyver "hasktorch-indef-signed"
  , hasktorch-indef-unsigned     = fn.anyver "hasktorch-indef-unsigned"
  , hasktorch-ffi-tests          = htConstraint "hasktorch-ffi-tests"
  , hasktorch-ffi-th             = htConstraint "hasktorch-ffi-th"
  , hasktorch-ffi-thc            = htConstraint "hasktorch-ffi-thc"
  , hasktorch-signatures         = htConstraint "hasktorch-signatures"
  , hasktorch-signatures-partial = htConstraint "hasktorch-signatures-partial"
  , hasktorch-signatures-support = htConstraint "hasktorch-signatures-support"
  , hasktorch-signatures-types   = htConstraint "hasktorch-signatures-types"
  , hasktorch-types-th           = htConstraint "hasktorch-types-th"
  , hasktorch-types-thc          = htConstraint "hasktorch-types-thc"
  , hasktorch-zoo                = htConstraint "hasktorch-zoo"
  }
in
{ constraints = constraints
, versions = versions
, main-release = main-release
}
