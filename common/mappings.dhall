   let types = ./types.dhall
in let PackageType = constructors types.PackageType
in let Storage   = PackageType.Storage {=}
in let Static    = PackageType.Static {=}
in let Dynamic   = PackageType.Dynamic {=}
in let Support   = PackageType.Support {=}
in let Undefined = PackageType.Undefined {=}
in let mkpkg =
  \(t : types.PackageType) ->
  \(indefexport : Bool) ->
  \(pkg : Text) ->
    { indefexport = indefexport, type = t, package = pkg }
    : types.BasePackage

in let storage =
  [ mkpkg Storage True "Storage"
  , mkpkg Storage True "Storage.Copy"
  ]

in let support =
  [ mkpkg Support True "Types"
  , mkpkg Support True "Index"
  , mkpkg Support True "Mask"
  ]

in let unsigned-fn =
  \(isdyn : Bool ) -> let TType = if isdyn then Dynamic else Static in
  [ mkpkg TType True "Tensor"
  , mkpkg TType True "Tensor.Copy"
  , mkpkg TType True "Tensor.Index"
  , mkpkg TType True "Tensor.Masked"
  , mkpkg TType True "Tensor.Math"
  , mkpkg TType True "Tensor.Math.Compare"
  , mkpkg TType True "Tensor.Math.CompareT"
  , mkpkg TType True "Tensor.Math.Pairwise"
  , mkpkg TType True "Tensor.Math.Pointwise"
  , mkpkg TType True "Tensor.Math.Reduce"
  , mkpkg TType True "Tensor.Math.Scan"
  , mkpkg TType True "Tensor.Mode"
  , mkpkg TType True "Tensor.ScatterGather"
  , mkpkg TType True "Tensor.Sort"
  , mkpkg TType True "Tensor.TopK"
  ]

in let unsigned = unsigned-fn True # unsigned-fn False

in let signed-fn =
  \(isdyn : Bool ) -> let TType = if isdyn then Dynamic else Static in
  [ mkpkg TType True "Tensor.Math.Pointwise.Signed"
  ]

in let signed = signed-fn True # signed-fn False

in let floating-fn =
  \(isdyn : Bool ) -> let TType = if isdyn then Dynamic else Static in
  [ mkpkg TType True "Tensor.Math.Blas"
  , mkpkg TType True "Tensor.Math.Lapack"

  , mkpkg TType True "Tensor.Math.Pointwise.Floating"
  , mkpkg TType True "Tensor.Math.Reduce.Floating"
  , mkpkg TType True "Tensor.Math.Floating"
  ]

in let floating = floating-fn True # floating-fn False
in let nn =
  [ mkpkg Dynamic False "NN"
  , mkpkg Dynamic False "NN.Activation"
  , mkpkg Dynamic False "NN.Pooling"
  , mkpkg Dynamic False "NN.Criterion"

  -- , mkpkg Static  False "NN.Conv3d"
  , mkpkg Static  False "NN"
  , mkpkg Static  False "NN.Activation"
  , mkpkg Static  False "NN.Backprop"
  , mkpkg Static  False "NN.Conv1d"
  , mkpkg Static  False "NN.Conv2d"
  , mkpkg Static  False "NN.Criterion"
  , mkpkg Static  False "NN.Layers"
  , mkpkg Static  False "NN.Linear"
  , mkpkg Static  False "NN.Math"
  , mkpkg Static  False "NN.Padding"
  , mkpkg Static  False "NN.Pooling"
  , mkpkg Static  False "NN.Sampling"
  ]
in let random-th =
  [ mkpkg Static    True "Tensor.Random.TH"
  , mkpkg Static    True "Tensor.Math.Random.TH"
  , mkpkg Dynamic   True "Tensor.Random.TH"
  , mkpkg Dynamic   True "Tensor.Math.Random.TH"

  , mkpkg Undefined True "Tensor.Random.THC"
  ]
in let random-thc =
  [ mkpkg Undefined True "Tensor.Random.TH"
  , mkpkg Undefined True "Tensor.Math.Random.TH"

  , mkpkg Static    True "Tensor.Random.THC"
  , mkpkg Dynamic   True "Tensor.Random.THC"
  ]
in
{ storage = storage
, support = support
, unsigned = unsigned
, signed = signed
, floating = floating
, nn = nn
, random-th = random-th
, random-thc = random-thc
}
