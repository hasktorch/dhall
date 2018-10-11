   let prelude = ../dhall-to-cabal/dhall/prelude.dhall
in let types =   ../dhall-to-cabal/dhall/types.dhall
in let common = ../common.dhall
in let packages = common.packages
in let cabalvars = common.cabalvars
in let fn = ../common/functions.dhall
in let tensorMathOr = λ(isth : Bool) → λ(pkg : Text) → if isth then "TensorMath" else pkg
in let th   = "Torch."
in let tsig = "${th}Sig."
in let tffi = "${th}FFI."
in let indef-support =
    λ(isth : Bool) →
        let lib = fn.showlib isth
     in [ { rename = "${tsig}Index.Tensor"    , to = "${tffi}${lib}.Long.Tensor"  }
        , { rename = "${tsig}Index.TensorFree", to = fn.memory-module isth "Long" "Tensor"  }
        , { rename = "${tsig}Mask.Tensor"     , to = "${tffi}${lib}.Byte.Tensor"  }
        , { rename = "${tsig}Mask.TensorFree" , to = fn.memory-module isth "Byte" "Tensor" }
        , { rename = "${tsig}Mask.MathReduce" , to = (fn.ffi-basename isth "Byte") ++"." ++ (tensorMathOr isth "TensorMathReduce")  }
        ]

in let unsigned =
    λ(isth : Bool) →
    λ(ttype : Text) →
        let lib = fn.showlib isth
     in let ffi = fn.ffi-basename isth ttype
     in indef-support isth #
        [ { rename = "${tsig}State"                 , to = if isth then "${th}Types.TH" else "${tffi}THC.State" }
        , { rename = "${tsig}Types.Global"          , to = "${th}Types.${lib}" }
        , { rename = "${tsig}Types"                 , to = "${th}Types.${lib}.${ttype}" }
        , { rename = "${tsig}Storage"               , to = "${ffi}.Storage" }
        , { rename = "${tsig}Storage.Copy"          , to = "${ffi}.StorageCopy" }
        , { rename = "${tsig}Storage.Memory"        , to = fn.memory-module isth ttype "Storage" }
        , { rename = "${tsig}Tensor"                , to = "${ffi}.Tensor" }
        , { rename = "${tsig}Tensor.Copy"           , to = "${ffi}.TensorCopy" }
        , { rename = "${tsig}Tensor.Memory"         , to = fn.memory-module isth ttype "Tensor"  }
        , { rename = "${tsig}Tensor.Index"          , to = "${ffi}." ++ (tensorMathOr isth "TensorIndex" ) }
        , { rename = "${tsig}Tensor.Masked"         , to = "${ffi}." ++ (tensorMathOr isth "TensorMasked" ) }
        , { rename = "${tsig}Tensor.Math"           , to = "${ffi}." ++ (tensorMathOr isth "TensorMath" ) }
        , { rename = "${tsig}Tensor.Math.Compare"   , to = "${ffi}." ++ (tensorMathOr isth "TensorMathCompare" ) }
        , { rename = "${tsig}Tensor.Math.CompareT"  , to = "${ffi}." ++ (tensorMathOr isth "TensorMathCompareT" ) }
        , { rename = "${tsig}Tensor.Math.Pairwise"  , to = "${ffi}." ++ (tensorMathOr isth "TensorMathPairwise" ) }
        , { rename = "${tsig}Tensor.Math.Pointwise" , to = "${ffi}." ++ (tensorMathOr isth "TensorMathPointwise") }
        , { rename = "${tsig}Tensor.Math.Reduce"    , to = "${ffi}." ++ (tensorMathOr isth "TensorMathReduce")  }
        , { rename = "${tsig}Tensor.Math.Scan"      , to = "${ffi}." ++ (tensorMathOr isth "TensorMathScan" ) }
        , { rename = "${tsig}Tensor.Mode"           , to = "${ffi}." ++ (tensorMathOr isth "TensorMode" ) }
        , { rename = "${tsig}Tensor.ScatterGather"  , to = "${ffi}." ++ (tensorMathOr isth "TensorScatterGather" ) }
        , { rename = "${tsig}Tensor.Sort"           , to = "${ffi}." ++ (tensorMathOr isth "TensorSort" ) }
        , { rename = "${tsig}Tensor.TopK"           , to = "${ffi}." ++ (tensorMathOr isth "TensorTopK" ) }
        ]

in let signed =
    λ(isth : Bool) →
    λ(ttype : Text) →
        let lib = fn.showlib isth
     in let ffi = fn.ffi-basename isth ttype
     in unsigned isth ttype #
        [ { rename = "${tsig}Tensor.Math.Pointwise.Signed", to = "${ffi}." ++ (tensorMathOr isth "TensorMathPointwise" ) }
        ]

in let floatingbase =
    λ(isth : Bool) →
    λ(ttype : Text) →
        let lib = fn.showlib isth
     in let ffi = fn.ffi-basename isth ttype
     in signed isth ttype #
        [ { rename = "${tsig}Tensor.Math.Pointwise.Floating" , to = "${ffi}." ++ (tensorMathOr isth "TensorMathPointwise" ) }
        , { rename = "${tsig}Tensor.Math.Reduce.Floating"    , to = "${ffi}." ++ (tensorMathOr isth "TensorMathReduce" ) }
        , { rename = "${tsig}Tensor.Math.Floating"           , to = "${ffi}." ++ (tensorMathOr isth "TensorMath" ) }
        , { rename = "${tsig}Tensor.Math.Blas"               , to = "${ffi}." ++ (tensorMathOr isth "TensorMathBlas" ) }
        , { rename = "${tsig}Tensor.Math.Lapack"             , to = "${ffi}.Tensor" ++ (if isth then "Lapack" else "MathMagma" ) }
        , { rename = "${tsig}NN"                             , to = "${tffi}${lib}.NN.${ttype}" }
        , { rename = "${tsig}Types.NN"                       , to = "${th}Types.${lib}" }
        ]
in let randombase
  =  \(isth : Bool)
  -> \(ttype : Text)
  -> \(use_namespace : Bool)
  -> let typespace = (if isth then "" else "Cuda.") ++ "${ttype}"
  in let namespace = if use_namespace then "${th}Undefined.${typespace}" else "${th}Undefined"
  in [ { rename = "${tsig}Tensor.Math.Random.TH", to =
         (if isth then "${tffi}TH.${ttype}.TensorMath" else "${namespace}.Tensor.Math.Random.TH") }

     , { rename = "${tsig}Tensor.Random.TH", to =
         (if isth then "${tffi}TH.${ttype}.TensorRandom" else "${namespace}.Tensor.Random.TH") }

     , { rename = "${tsig}Tensor.Random.THC", to =
         (if isth then "${namespace}.Tensor.Random.THC" else "${tffi}THC.${ttype}.TensorRandom") }
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
