   let prelude = ../dhall-to-cabal/dhall/prelude.dhall sha256:01509b3c6e9eaae4150a6e0ced124c2db191bf6046534a9d4973b7f05afd1d0a
in let types = ../dhall-to-cabal/dhall/types.dhall sha256:cfd7597246781e8d4c6dfa5f0eabba75f14dc3f3deb7527973909b37c93f42f5
in let fn = ../common/functions.dhall sha256:45e8bee44c93da6f4c47a3fdacc558b00858461325b807d4afc8bf0965716c33
in let common = ../common.dhall
in let packages = common.packages
in let cabalvars = common.cabalvars
in let partialLibrary =
  \(config : types.Config)
  -> common.Library config //
    { build-depends =
      [ packages.base
      , packages.hasktorch-signatures-partial
      , packages.hasktorch-signatures-support
      , fn.anyver "hasktorch-signatures"
      ]
    }
in let partialIndefLibrary =
  \(config : types.Config)
  -> common.Library config //
    { build-depends =
      [ packages.base
      , packages.hasktorch-signatures-partial
      , packages.hasktorch-signatures-support
      -- , packages.hasktorch-signatures
      , packages.hasktorch-indef
      ]
    }

in let
  signed-definites =
    [ fn.renameSig "Undefined" "NN"
    , fn.renameSig "Undefined" "Types.NN"
    , fn.renameSig "Undefined" "Tensor.Math.Blas"
    , fn.renameSig "Undefined" "Tensor.Math.Floating"
    , fn.renameSig "Undefined" "Tensor.Math.Lapack"
    , fn.renameSig "Undefined" "Tensor.Math.Pointwise.Floating"
    , fn.renameSig "Undefined" "Tensor.Math.Reduce.Floating"
    , fn.renameSig "Undefined" "Tensor.Math.Random.TH"
    , fn.renameSig "Undefined" "Tensor.Random.TH"
    , fn.renameSig "Undefined" "Tensor.Random.THC"
    ]
in  let
  unsigned-definites =
    (signed-definites # [ fn.renameSig "Undefined" "Tensor.Math.Pointwise.Signed" ])

in  let unsigned-indefiniteMixins =
         λ(pkg : Text)
       → λ(lib : types.Library)
       → lib // { mixins =
         [ { package = pkg
           , renaming =
             { provides = prelude.types.ModuleRenaming.default {=}
             , requires = prelude.types.ModuleRenaming.renaming unsigned-definites
             }
           } ]
       }

in  let signed-indefiniteMixins =
         λ(pkg : Text)
       → λ(lib : types.Library)
       → lib // { mixins =
         [ { package = pkg
           , renaming =
             { provides = prelude.types.ModuleRenaming.default {=}
             , requires = prelude.types.ModuleRenaming.renaming signed-definites
             }
           } ]
       }

in  let floating-reexported =
      [ fn.renameNoop "Torch.Undefined.Tensor.Math.Random.TH"
      , fn.renameNoop "Torch.Undefined.Tensor.Random.TH"
      , fn.renameNoop "Torch.Undefined.Tensor.Random.THC"
      ]

in  let floating-indefiniteMixins =
         λ(pkg : Text)
       → λ(lib : types.Library)
       → lib //
         { reexported-modules = floating-reexported
         }

in  let make-partial-lib =
         λ(name : Text)
       → λ(sigs : Text)
       → λ(lib : types.Library)
       → { name = name
         , library =
          λ(config : types.Config)
           → unsigned-indefiniteMixins sigs lib
         }
in
{ make-partial-lib = make-partial-lib
, unsigned-definites = unsigned-definites
, unsigned-indefiniteMixins = unsigned-indefiniteMixins
, unsigned-indef =
    { name = "hasktorch-indef-unsigned"
    , library =
      λ(config : types.Config)
       → unsigned-indefiniteMixins "hasktorch-indef" (partialIndefLibrary config)
    }
, unsigned =
    { name = "hasktorch-partial-unsigned"
    , library =
      λ(config : types.Config)
       → unsigned-indefiniteMixins "hasktorch-signatures" (partialLibrary config)
    }
, signed-definites = signed-definites
, signed-indefiniteMixins = signed-indefiniteMixins
, signed-indef =
    { name = "hasktorch-indef-signed"
    , library =
      λ(config : types.Config)
       → signed-indefiniteMixins "hasktorch-indef" (partialIndefLibrary config)
    }
, signed =
    { name = "hasktorch-partial-signed"
    , library =
      λ(config : types.Config)
       → signed-indefiniteMixins "hasktorch-signatures" (partialLibrary config)
    }
, floating-reexported = floating-reexported
, floating-indefiniteMixins = floating-indefiniteMixins
, floating-indef =
    { name = "hasktorch-indef-floating"
    , library =
      λ(config : types.Config)
       → floating-indefiniteMixins "hasktorch-indef" (partialIndefLibrary config)
    }
, floating =
    { name = "hasktorch-partial-floating"
    , library =
      λ(config : types.Config)
       → floating-indefiniteMixins "hasktorch-signatures" (partialLibrary config)
    }
}

