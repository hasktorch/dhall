   let prelude = ../dhall-to-cabal/dhall/prelude.dhall sha256:01509b3c6e9eaae4150a6e0ced124c2db191bf6046534a9d4973b7f05afd1d0a
in let types = ../dhall-to-cabal/dhall/types.dhall sha256:cfd7597246781e8d4c6dfa5f0eabba75f14dc3f3deb7527973909b37c93f42f5
in let fn = ../common/functions.dhall sha256:45e8bee44c93da6f4c47a3fdacc558b00858461325b807d4afc8bf0965716c33
in let unsigned =
    λ(isth : Bool) →
    λ(ttype : Text) →
      let namespace = if isth then "${ttype}" else "Cuda.${ttype}"
    in
      [ { rename = "Torch.Indef.Storage"                              , to = "Torch.Indef.${namespace}.Storage" }
      , { rename = "Torch.Indef.Storage.Copy"                         , to = "Torch.Indef.${namespace}.Storage.Copy" }
      , { rename = "Torch.Indef.Static.Tensor"                        , to = "Torch.Indef.${namespace}.Tensor" }
      , { rename = "Torch.Indef.Static.Tensor.Copy"                   , to = "Torch.Indef.${namespace}.Tensor.Copy" }
      , { rename = "Torch.Indef.Static.Tensor.Index"                  , to = "Torch.Indef.${namespace}.Tensor.Index" }
      , { rename = "Torch.Indef.Static.Tensor.Masked"                 , to = "Torch.Indef.${namespace}.Tensor.Masked" }
      , { rename = "Torch.Indef.Static.Tensor.Math"                   , to = "Torch.Indef.${namespace}.Tensor.Math" }
      , { rename = "Torch.Indef.Static.Tensor.Math.Compare"           , to = "Torch.Indef.${namespace}.Tensor.Math.Compare" }
      , { rename = "Torch.Indef.Static.Tensor.Math.CompareT"          , to = "Torch.Indef.${namespace}.Tensor.Math.CompareT" }
      , { rename = "Torch.Indef.Static.Tensor.Math.Pairwise"          , to = "Torch.Indef.${namespace}.Tensor.Math.Pairwise" }
      , { rename = "Torch.Indef.Static.Tensor.Math.Pointwise"         , to = "Torch.Indef.${namespace}.Tensor.Math.Pointwise" }
      , { rename = "Torch.Indef.Static.Tensor.Math.Reduce"            , to = "Torch.Indef.${namespace}.Tensor.Math.Reduce" }
      , { rename = "Torch.Indef.Static.Tensor.Math.Scan"              , to = "Torch.Indef.${namespace}.Tensor.Math.Scan" }
      , { rename = "Torch.Indef.Static.Tensor.Mode"                   , to = "Torch.Indef.${namespace}.Tensor.Mode" }
      , { rename = "Torch.Indef.Static.Tensor.ScatterGather"          , to = "Torch.Indef.${namespace}.Tensor.ScatterGather" }
      , { rename = "Torch.Indef.Static.Tensor.Sort"                   , to = "Torch.Indef.${namespace}.Tensor.Sort" }
      , { rename = "Torch.Indef.Static.Tensor.TopK"                   , to = "Torch.Indef.${namespace}.Tensor.TopK" }

      , { rename = "Torch.Indef.Dynamic.Tensor"                       , to = "Torch.Indef.${namespace}.Dynamic.Tensor" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Copy"                  , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Copy" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Index"                 , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Index" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Masked"                , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Masked" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Math"                  , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Math" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Math.Compare"          , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Math.Compare" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Math.CompareT"         , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Math.CompareT" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Math.Pairwise"         , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Math.Pairwise" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Math.Pointwise"        , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Math.Pointwise" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Math.Reduce"           , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Math.Reduce" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Math.Scan"             , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Math.Scan" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Mode"                  , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Mode" }
      , { rename = "Torch.Indef.Dynamic.Tensor.ScatterGather"         , to = "Torch.Indef.${namespace}.Dynamic.Tensor.ScatterGather" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Sort"                  , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Sort" }
      , { rename = "Torch.Indef.Dynamic.Tensor.TopK"                  , to = "Torch.Indef.${namespace}.Dynamic.Tensor.TopK" }

      , { rename = "Torch.Indef.Types"                                , to = "Torch.${namespace}.Types" }
      , { rename = "Torch.Indef.Index"                                , to = "Torch.${namespace}.Index" }
      , { rename = "Torch.Indef.Mask"                                 , to = "Torch.${namespace}.Mask" }
      ]
in let signed =
    λ(isth : Bool) →
    λ(ttype : Text) →
      let namespace = if isth then "${ttype}" else "Cuda.${ttype}"
    in (unsigned isth ttype) #
      [ { rename = "Torch.Indef.Static.Tensor.Math.Pointwise.Signed"  , to = "Torch.Indef.${namespace}.Tensor.Math.Pointwise.Signed" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Math.Pointwise.Signed" , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Math.Pointwise.Signed" }
      ]
in let floatingbase =
    λ(isth : Bool) →
    λ(ttype : Text) →
      let namespace = if isth then "${ttype}" else "Cuda.${ttype}"
    in (signed isth ttype) #
      [ { rename = "Torch.Indef.Dynamic.Tensor.Math.Blas"               , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Math.Blas" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Math.Lapack"             , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Math.Lapack" }

      , { rename = "Torch.Indef.Dynamic.Tensor.Math.Pointwise.Floating" , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Math.Pointwise.Floating" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Math.Reduce.Floating"    , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Math.Reduce.Floating" }
      , { rename = "Torch.Indef.Dynamic.Tensor.Math.Floating"           , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Math.Floating" }

      , { rename = "Torch.Indef.Static.Tensor.Math.Blas"                , to = "Torch.Indef.${namespace}.Tensor.Math.Blas" }
      , { rename = "Torch.Indef.Static.Tensor.Math.Lapack"              , to = "Torch.Indef.${namespace}.Tensor.Math.Lapack" }

      , { rename = "Torch.Indef.Static.Tensor.Math.Pointwise.Floating"  , to = "Torch.Indef.${namespace}.Tensor.Math.Pointwise.Floating" }
      , { rename = "Torch.Indef.Static.Tensor.Math.Reduce.Floating"     , to = "Torch.Indef.${namespace}.Tensor.Math.Reduce.Floating" }
      , { rename = "Torch.Indef.Static.Tensor.Math.Floating"            , to = "Torch.Indef.${namespace}.Tensor.Math.Floating" }
      ]

in let nnbase
    = λ(isth : Bool)
    → λ(ttype : Text)
    → let namespace = if isth then "${ttype}" else "Cuda.${ttype}"
    in (signed isth ttype) #
      [ { rename = "Torch.Indef.Dynamic.NN"                             , to = "Torch.${namespace}.Dynamic.NN" }
      , { rename = "Torch.Indef.Dynamic.NN.Activation"                  , to = "Torch.${namespace}.Dynamic.NN.Activation" }
      , { rename = "Torch.Indef.Dynamic.NN.Pooling"                     , to = "Torch.${namespace}.Dynamic.NN.Pooling" }
      , { rename = "Torch.Indef.Dynamic.NN.Criterion"                   , to = "Torch.${namespace}.Dynamic.NN.Criterion" }

      , { rename = "Torch.Indef.Static.NN"                              , to = "Torch.${namespace}.NN" }

      , { rename = "Torch.Indef.Static.NN"                              , to = "Torch.${namespace}.NN" }
      , { rename = "Torch.Indef.Static.NN.Activation"                   , to = "Torch.${namespace}.NN.Activation" }
      , { rename = "Torch.Indef.Static.NN.Backprop"                     , to = "Torch.${namespace}.NN.Backprop" }
      , { rename = "Torch.Indef.Static.NN.Conv1d"                       , to = "Torch.${namespace}.NN.Conv1d" }
      , { rename = "Torch.Indef.Static.NN.Conv2d"                       , to = "Torch.${namespace}.NN.Conv2d" }
      -- , { rename = "Torch.Indef.Static.NN.Conv3d"                       , to = "Torch.${namespace}.NN.Conv3d" }
      , { rename = "Torch.Indef.Static.NN.Criterion"                    , to = "Torch.${namespace}.NN.Criterion" }
      , { rename = "Torch.Indef.Static.NN.Layers"                       , to = "Torch.${namespace}.NN.Layers" }
      , { rename = "Torch.Indef.Static.NN.Linear"                       , to = "Torch.${namespace}.NN.Linear" }
      , { rename = "Torch.Indef.Static.NN.Math"                         , to = "Torch.${namespace}.NN.Math" }
      , { rename = "Torch.Indef.Static.NN.Padding"                      , to = "Torch.${namespace}.NN.Padding" }
      , { rename = "Torch.Indef.Static.NN.Pooling"                      , to = "Torch.${namespace}.NN.Pooling" }
      , { rename = "Torch.Indef.Static.NN.Sampling"                     , to = "Torch.${namespace}.NN.Sampling" }

      ]
in let undefinedRandom =
    λ(isth : Bool) →
    λ(ttype : Text) →
      let namespace = if isth then "${ttype}" else "Cuda.${ttype}"
    in if isth
       then
         [ { rename = "Torch.Indef.Static.Tensor.Random.TH"            , to = "Torch.Indef.${namespace}.Tensor.Random.TH" }
         , { rename = "Torch.Indef.Static.Tensor.Math.Random.TH"       , to = "Torch.Indef.${namespace}.Tensor.Math.Random.TH" }
         , { rename = "Torch.Indef.Dynamic.Tensor.Random.TH"           , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Random.TH" }
         , { rename = "Torch.Indef.Dynamic.Tensor.Math.Random.TH"      , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Math.Random.TH" }
         , { rename = "Torch.Undefined.Tensor.Random.THC"              , to = "Torch.Undefined.${namespace}.Tensor.Random.THC" }
         ]
       else
         [ { rename = "Torch.Undefined.Tensor.Random.TH"               , to = "Torch.Undefined.${namespace}.Tensor.Random.TH" }
         , { rename = "Torch.Undefined.Tensor.Math.Random.TH"          , to = "Torch.Undefined.${namespace}.Tensor.Math.Random.TH" }
         , { rename = "Torch.Indef.Static.Tensor.Random.THC"           , to = "Torch.Indef.${namespace}.Tensor.Random.THC" }
         , { rename = "Torch.Indef.Dynamic.Tensor.Random.THC"          , to = "Torch.Indef.${namespace}.Dynamic.Tensor.Random.THC" }
         ]
in let floating = λ(isth : Bool) → λ(ttype : Text) → floatingbase isth ttype # undefinedRandom isth ttype # nnbase isth ttype
in
{ floating = floating
, undefinedRandom = undefinedRandom
, signed = signed
, unsigned = unsigned
}
