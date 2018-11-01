   let prelude = ../dhall-to-cabal/dhall/prelude.dhall sha256:01509b3c6e9eaae4150a6e0ced124c2db191bf6046534a9d4973b7f05afd1d0a
in let types = ../dhall-to-cabal/dhall/types.dhall sha256:cfd7597246781e8d4c6dfa5f0eabba75f14dc3f3deb7527973909b37c93f42f5
in let fn = ../common/functions.dhall sha256:45e8bee44c93da6f4c47a3fdacc558b00858461325b807d4afc8bf0965716c33
in let List/map = ../Prelude/List/map sha256:310614c2949366621d7848e37c7845090d6c5b644234a1defe4d4048cf124fcd
in let common = ../common.dhall

in let mappings = ../common/mappings.dhall
in let ReexportedModule = ../common/types/ReexportedModule.dhall
in let packages = common.packages
in let cabalvars = common.cabalvars
in let mknamespace =
  λ(isth : Bool)  →
  λ(ttype : Text) →
  if isth then "${ttype}" else "Cuda.${ttype}"

in let indef-unsigned-reexports
  = [ fn.renameNoop "Torch.Indef.Index"
    , fn.renameNoop "Torch.Indef.Mask"
    , fn.renameNoop "Torch.Indef.Types"
    , fn.renameNoop "Torch.Indef.Storage"
    , fn.renameNoop "Torch.Indef.Storage.Copy"
    , fn.renameNoop "Torch.Indef.Dynamic.Print"

    , fn.renameNoop "Torch.Indef.Dynamic.Tensor"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Copy"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Index"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Masked"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Math"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Math.Compare"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Math.CompareT"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Math.Pairwise"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Math.Pointwise"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Math.Reduce"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Math.Scan"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Mode"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.ScatterGather"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Sort"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.TopK"

    , fn.renameNoop "Torch.Indef.Static.Tensor"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Copy"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Index"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Masked"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Math"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Math.Compare"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Math.CompareT"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Math.Pairwise"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Math.Pointwise"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Math.Reduce"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Math.Scan"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Mode"
    , fn.renameNoop "Torch.Indef.Static.Tensor.ScatterGather"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Sort"
    , fn.renameNoop "Torch.Indef.Static.Tensor.TopK"
    ]

in let indef-signed-reexports
  = indef-unsigned-reexports
  # [ fn.renameNoop "Torch.Indef.Static.Tensor.Math.Pointwise.Signed"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Math.Pointwise.Signed"
    ]

in let indef-floating-math-reexports
  = indef-signed-reexports
  # [ fn.renameNoop "Torch.Indef.Dynamic.Tensor.Math.Blas"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Math.Floating"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Math.Lapack"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Math.Pointwise.Floating"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Math.Reduce.Floating"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Random.TH"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Random.THC"
    , fn.renameNoop "Torch.Indef.Dynamic.Tensor.Math.Random.TH"

    , fn.renameNoop "Torch.Indef.Static.Tensor.Math.Blas"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Math.Floating"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Math.Lapack"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Math.Pointwise.Floating"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Math.Reduce.Floating"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Random.TH"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Random.THC"
    , fn.renameNoop "Torch.Indef.Static.Tensor.Math.Random.TH"
    ]

in let indef-nn-exports
  = [ "Torch.Indef.Dynamic.NN"
    , "Torch.Indef.Dynamic.NN.Activation"
    , "Torch.Indef.Dynamic.NN.Pooling"
    , "Torch.Indef.Dynamic.NN.Criterion"

    , "Torch.Indef.Static.NN"
    , "Torch.Indef.Static.NN.Activation"
    , "Torch.Indef.Static.NN.Backprop"
    , "Torch.Indef.Static.NN.Conv1d"
    , "Torch.Indef.Static.NN.Conv2d"
    -- , "Torch.Indef.Static.NN.Conv3d"
    , "Torch.Indef.Static.NN.Criterion"
    , "Torch.Indef.Static.NN.Layers"
    , "Torch.Indef.Static.NN.Linear"
    , "Torch.Indef.Static.NN.Math"
    , "Torch.Indef.Static.NN.Padding"
    , "Torch.Indef.Static.NN.Pooling"
    , "Torch.Indef.Static.NN.Sampling"
    ]

in let indef-nn-reexports = List/map Text ReexportedModule fn.renameNoop indef-nn-exports

in let allindef-reexports
  = indef-floating-math-reexports
  # indef-nn-reexports

in let indef-floating-reexports
  = allindef-reexports
  # [ fn.renameNoop "Torch.Undefined.Tensor.Math.Random.TH"
    , fn.renameNoop "Torch.Undefined.Tensor.Random.TH"
    , fn.renameNoop "Torch.Undefined.Tensor.Random.THC"
    ]

in let baseexports =
  λ(isth : Bool)  →
  λ(ttype : Text) →
  let namespace = mknamespace isth ttype
  in
    [ fn.renameNoop "Torch.${namespace}"
    , fn.renameNoop "Torch.${namespace}.Dynamic"
    , fn.renameNoop "Torch.${namespace}.Storage"
    ]

in let nnexports =
  λ(isth : Bool)  →
  λ(ttype : Text) →
  let namespace = mknamespace isth ttype
  in
    [ fn.renameNoop "Torch.${namespace}.NN"
    , fn.renameNoop "Torch.${namespace}.NN.Activation"
    , fn.renameNoop "Torch.${namespace}.NN.Backprop"
    , fn.renameNoop "Torch.${namespace}.NN.Conv1d"
    , fn.renameNoop "Torch.${namespace}.NN.Conv2d"
    , fn.renameNoop "Torch.${namespace}.NN.Criterion"
    , fn.renameNoop "Torch.${namespace}.NN.Layers"
    , fn.renameNoop "Torch.${namespace}.NN.Linear"
    , fn.renameNoop "Torch.${namespace}.NN.Math"
    , fn.renameNoop "Torch.${namespace}.NN.Padding"
    , fn.renameNoop "Torch.${namespace}.NN.Pooling"
    , fn.renameNoop "Torch.${namespace}.NN.Sampling"

    , fn.renameNoop "Torch.${namespace}.Dynamic.NN"
    , fn.renameNoop "Torch.${namespace}.Dynamic.NN.Activation"
    , fn.renameNoop "Torch.${namespace}.Dynamic.NN.Activation"
    ]
in
{ allindef-reexports = allindef-reexports
, unsigned =
  { name = "hasktorch-indef-unsigned"
  , library =
    λ (config : types.Config)
    → common.Library config //
      { build-depends =
        [ packages.base
        , packages.hasktorch-signatures-partial
        , fn.anyver "hasktorch-indef"
        ]
      , reexported-modules = indef-unsigned-reexports
      , default-extensions = [] : List types.Extensions
      , mixins =
        [ { package = "hasktorch-indef"
          , renaming =
            { provides = prelude.types.ModuleRenaming.default {=}
            , requires = prelude.types.ModuleRenaming.renaming
              [ { rename = "Torch.Sig.NN"                             , to = "Torch.Undefined.NN" }
              , { rename = "Torch.Sig.Types.NN"                       , to = "Torch.Undefined.Types.NN" }
              , { rename = "Torch.Sig.Tensor.Math.Blas"               , to = "Torch.Undefined.Tensor.Math.Blas" }
              , { rename = "Torch.Sig.Tensor.Math.Floating"           , to = "Torch.Undefined.Tensor.Math.Floating" }
              , { rename = "Torch.Sig.Tensor.Math.Lapack"             , to = "Torch.Undefined.Tensor.Math.Lapack" }
              , { rename = "Torch.Sig.Tensor.Math.Pointwise.Signed"   , to = "Torch.Undefined.Tensor.Math.Pointwise.Signed" }
              , { rename = "Torch.Sig.Tensor.Math.Pointwise.Floating" , to = "Torch.Undefined.Tensor.Math.Pointwise.Floating" }
              , { rename = "Torch.Sig.Tensor.Math.Reduce.Floating"    , to = "Torch.Undefined.Tensor.Math.Reduce.Floating" }
              , { rename = "Torch.Sig.Tensor.Math.Random.TH"          , to = "Torch.Undefined.Tensor.Math.Random.TH" }
              , { rename = "Torch.Sig.Tensor.Random.TH"               , to = "Torch.Undefined.Tensor.Random.TH" }
              , { rename = "Torch.Sig.Tensor.Random.THC"              , to = "Torch.Undefined.Tensor.Random.THC" }
              ]
            } }
         ]
      }
  }
, signed =
  { name = "hasktorch-indef-signed"
  , library =
    λ (config : types.Config)
    → common.Library config //
      { build-depends =
        [ packages.base
        , packages.hasktorch-signatures-partial
        , fn.anyver "hasktorch-indef"
        ]
      , reexported-modules = indef-signed-reexports
      , default-extensions = [] : List types.Extensions
      , mixins =
        [ { package = "hasktorch-indef"
          , renaming =
            { provides = prelude.types.ModuleRenaming.default {=}
            , requires = prelude.types.ModuleRenaming.renaming
              [ { rename = "Torch.Sig.NN"                             , to = "Torch.Undefined.NN" }
              , { rename = "Torch.Sig.Types.NN"                       , to = "Torch.Undefined.Types.NN" }
              , { rename = "Torch.Sig.Tensor.Math.Blas"               , to = "Torch.Undefined.Tensor.Math.Blas" }
              , { rename = "Torch.Sig.Tensor.Math.Floating"           , to = "Torch.Undefined.Tensor.Math.Floating" }
              , { rename = "Torch.Sig.Tensor.Math.Lapack"             , to = "Torch.Undefined.Tensor.Math.Lapack" }
              , { rename = "Torch.Sig.Tensor.Math.Pointwise.Floating" , to = "Torch.Undefined.Tensor.Math.Pointwise.Floating" }
              , { rename = "Torch.Sig.Tensor.Math.Reduce.Floating"    , to = "Torch.Undefined.Tensor.Math.Reduce.Floating" }
              , { rename = "Torch.Sig.Tensor.Math.Random.TH"          , to = "Torch.Undefined.Tensor.Math.Random.TH" }
              , { rename = "Torch.Sig.Tensor.Random.TH"               , to = "Torch.Undefined.Tensor.Random.TH" }
              , { rename = "Torch.Sig.Tensor.Random.THC"              , to = "Torch.Undefined.Tensor.Random.THC" }
              ]
            } }
         ]
      }
  }
, floating =
  { name = "hasktorch-indef-floating"
  , library =
    λ (config : types.Config)
    → common.Library config //
      { build-depends =
        [ packages.base
        , fn.anyver "hasktorch-indef"
        , packages.hasktorch-signatures-partial
        ]
      , default-extensions = [] : List types.Extensions
      , reexported-modules = indef-floating-reexports
      }
  }
}
