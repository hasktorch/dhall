   let prelude = ../dhall-to-cabal/dhall/prelude.dhall
in let types =   ../dhall-to-cabal/dhall/types.dhall
in  let common = ../common.dhall
in  let packages = common.packages
in  let cabalvars = common.cabalvars
in  let fn = ../common/functions.dhall
in  let partialLibrary = common.Library
        // { build-depends =
             [ packages.base
             , packages.hasktorch-signatures-partial
             , packages.hasktorch-signatures-support
             , packages.hasktorch-signatures
             ]
           }
in  let partialIndefLibrary = common.Library
        // { build-depends =
             [ packages.base
             , packages.hasktorch-signatures-partial
             , packages.hasktorch-signatures-support
             -- , packages.hasktorch-signatures
             , packages.hasktorch-indef
             ]
           }


in  let
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
       → unsigned-indefiniteMixins "hasktorch-indef" partialIndefLibrary
    }
, unsigned =
    { name = "hasktorch-partial-unsigned"
    , library =
      λ(config : types.Config)
       → unsigned-indefiniteMixins "hasktorch-signatures" partialLibrary
    }
, signed-definites = signed-definites
, signed-indefiniteMixins = signed-indefiniteMixins
, signed-indef =
    { name = "hasktorch-indef-signed"
    , library =
      λ(config : types.Config)
       → signed-indefiniteMixins "hasktorch-indef" partialIndefLibrary
    }
, signed =
    { name = "hasktorch-partial-signed"
    , library =
      λ(config : types.Config)
       → signed-indefiniteMixins "hasktorch-signatures" partialLibrary
    }
, floating-reexported = floating-reexported
, floating-indefiniteMixins = floating-indefiniteMixins
, floating-indef =
    { name = "hasktorch-indef-floating"
    , library =
      λ(config : types.Config)
       → floating-indefiniteMixins "hasktorch-indef" partialIndefLibrary
    }
, floating =
    { name = "hasktorch-partial-floating"
    , library =
      λ(config : types.Config)
       → floating-indefiniteMixins "hasktorch-signatures" partialLibrary
    }
}

