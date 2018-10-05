   let prelude = ../dhall-to-cabal/dhall/prelude.dhall
in let types =   ../dhall-to-cabal/dhall/types.dhall
in let common = ../common.dhall
in let packages = common.packages
in let cabalvars = common.cabalvars
in let fn = ../common/functions.dhall
in let indef-support =
    λ(isth : Bool)
    → let lib = fn.showlib isth
    in
      [ { rename = "Torch.Sig.Index.Tensor"    , to = "Torch.FFI.${lib}.Long.Tensor"  }
      , { rename = "Torch.Sig.Index.TensorFree", to = "Torch.FFI.${lib}.Long.FreeTensor"  }
      , { rename = "Torch.Sig.Mask.Tensor"     , to = "Torch.FFI.${lib}.Byte.Tensor"  }
      , { rename = "Torch.Sig.Mask.TensorFree" , to = "Torch.FFI.${lib}.Byte.FreeTensor"  }
      , { rename = "Torch.Sig.Mask.MathReduce" , to = "Torch.FFI.${lib}.Byte.TensorMath"  }
      ]

in let unsigned =
    λ(isth : Bool) →
    λ(ttype : Text) →
        let lib = fn.showlib isth
     in let tensorMathOr = λ(pkg : Text) → if isth then "TensorMath" else pkg
     in let ffi = "Torch.FFI.${lib}.${ttype}"
     in indef-support isth #
        [ { rename = "Torch.Sig.State"                 , to = if isth then "Torch.Types.TH" else "Torch.FFI.THC.State" }
        , { rename = "Torch.Sig.Types.Global"          , to = "Torch.Types.${lib}" }
        , { rename = "Torch.Sig.Types"                 , to = "Torch.Types.${lib}.${ttype}" }
        , { rename = "Torch.Sig.Storage"               , to = "${ffi}.Storage" }
        , { rename = "Torch.Sig.Storage.Copy"          , to = "${ffi}.StorageCopy" }
        , { rename = "Torch.Sig.Storage.Memory"        , to = "${ffi}." ++ (if isth then "FreeStorage" else "Storage" ) }
        , { rename = "Torch.Sig.Tensor"                , to = "${ffi}." ++ (if isth then "Tensor" else "Tensor" ) }
        , { rename = "Torch.Sig.Tensor.Copy"           , to = "${ffi}.TensorCopy" }
        , { rename = "Torch.Sig.Tensor.Memory"         , to = "${ffi}." ++ (if isth then "FreeTensor" else "Tensor" ) }
        , { rename = "Torch.Sig.Tensor.Index"          , to = "${ffi}." ++ (tensorMathOr "TensorIndex" ) }
        , { rename = "Torch.Sig.Tensor.Masked"         , to = "${ffi}." ++ (tensorMathOr "TensorMasked" ) }
        , { rename = "Torch.Sig.Tensor.Math"           , to = "${ffi}." ++ (tensorMathOr "TensorMath" ) }
        , { rename = "Torch.Sig.Tensor.Math.Compare"   , to = "${ffi}." ++ (tensorMathOr "TensorMathCompare" ) }
        , { rename = "Torch.Sig.Tensor.Math.CompareT"  , to = "${ffi}." ++ (tensorMathOr "TensorMathCompareT" ) }
        , { rename = "Torch.Sig.Tensor.Math.Pairwise"  , to = "${ffi}." ++ (tensorMathOr "TensorMathPairwise" ) }
        , { rename = "Torch.Sig.Tensor.Math.Pointwise" , to = "${ffi}." ++ (tensorMathOr "TensorMathPointwise") }
        , { rename = "Torch.Sig.Tensor.Math.Reduce"    , to = "${ffi}." ++ (tensorMathOr "TensorMathReduce")  }
        , { rename = "Torch.Sig.Tensor.Math.Scan"      , to = "${ffi}." ++ (tensorMathOr "TensorMathScan" ) }
        , { rename = "Torch.Sig.Tensor.Mode"           , to = "${ffi}." ++ (tensorMathOr  "TensorMode" ) }
        , { rename = "Torch.Sig.Tensor.ScatterGather"  , to = "${ffi}." ++ (tensorMathOr "TensorScatterGather" ) }
        , { rename = "Torch.Sig.Tensor.Sort"           , to = "${ffi}." ++ (tensorMathOr "TensorSort" ) }
        , { rename = "Torch.Sig.Tensor.TopK"           , to = "${ffi}." ++ (tensorMathOr "TensorTopK" ) }
        ]

in let signed =
    λ(isth : Bool) →
    λ(ttype : Text) →
        let lib = fn.showlib isth
     in let tensorMathOr = λ(pkg : Text) → if isth then "TensorMath" else pkg
     in let ffi = "Torch.FFI.${lib}.${ttype}"
     in unsigned isth ttype #
        [ { rename = "Torch.Sig.Tensor.Math.Pointwise.Signed", to = "Torch.FFI.${lib}.${ttype}." ++ (tensorMathOr "TensorMathPointwise" ) }
        ]

in let floatingbase =
    λ(isth : Bool) →
    λ(ttype : Text) →
        let lib = fn.showlib isth
     in let tensorMathOr = λ(pkg : Text) → if isth then "TensorMath" else pkg
     in let ffi = "Torch.FFI.${lib}.${ttype}"
     in signed isth ttype #
        [ { rename = "Torch.Sig.Tensor.Math.Pointwise.Floating" , to = "Torch.FFI.${lib}.${ttype}." ++ (tensorMathOr "TensorMathPointwise" ) }
        , { rename = "Torch.Sig.Tensor.Math.Reduce.Floating"    , to = "Torch.FFI.${lib}.${ttype}." ++ (tensorMathOr "TensorMathReduce" ) }
        , { rename = "Torch.Sig.Tensor.Math.Floating"           , to = "Torch.FFI.${lib}.${ttype}." ++ (tensorMathOr "TensorMath" ) }
        , { rename = "Torch.Sig.Tensor.Math.Blas"               , to = "Torch.FFI.${lib}.${ttype}." ++ (tensorMathOr "TensorMathBlas" ) }
        , { rename = "Torch.Sig.Tensor.Math.Lapack"             , to = "Torch.FFI.${lib}.${ttype}." ++ (if isth then "TensorLapack" else "TensorMathMagma" ) }
        , { rename = "Torch.Sig.NN"                             , to = "Torch.FFI.${lib}.NN.${ttype}" }
        , { rename = "Torch.Sig.Types.NN"                       , to = "Torch.Types.${lib}" }
        ]
in let randombase =
    λ(isth : Bool) →
    λ(ttype : Text) →
    λ(use_namespace : Bool) →
    let namespace = if use_namespace then "Torch.Undefined.${ttype}" else "Torch.Undefined"
    in
     [ { rename = "Torch.Sig.Tensor.Math.Random.TH", to =
         (if isth then "Torch.FFI.TH.${ttype}.TensorMath" else "${namespace}.Tensor.Math.Random.TH") }

     , { rename = "Torch.Sig.Tensor.Random.TH", to =
         (if isth then "Torch.FFI.TH.${ttype}.TensorRandom" else "${namespace}.Tensor.Random.TH") }

     , { rename = "Torch.Sig.Tensor.Random.THC", to =
         (if isth then "${namespace}.Tensor.Random.THC" else "Torch.FFI.THC.${ttype}.TensorRandom") }
     ]

in let floating =
    λ(isth : Bool) →
    λ(ttype : Text) →
     floatingbase isth ttype # randombase isth ttype True

in
{ unsigned      = unsigned
, signed        = signed
, floatingbase  = floatingbase
, floating      = floating
, randombase = randombase
}
