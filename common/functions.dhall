   let prelude  = ../dhall-to-cabal/dhall/prelude.dhall sha256:01509b3c6e9eaae4150a6e0ced124c2db191bf6046534a9d4973b7f05afd1d0a
in let types    = ../dhall-to-cabal/dhall/types.dhall sha256:cfd7597246781e8d4c6dfa5f0eabba75f14dc3f3deb7527973909b37c93f42f5
in let List/map = ../Prelude/List/map sha256:310614c2949366621d7848e37c7845090d6c5b644234a1defe4d4048cf124fcd
in let ReexportedModule = ./types/ReexportedModule.dhall sha256:23ebbe22530692c84f9646131b55605be9506a56121a0cb1e5230e34a7675120
in let getname = λ(foo : ReexportedModule) → foo.name
in let showlib =  λ(isth : Bool) → if isth then "TH" else "THC"
in let ffi-basename =
  λ(isth : Bool) →
  λ(ttype : Text) →
  let lib = showlib isth
  in "Torch.FFI.${lib}.${ttype}"
in
{ anyver =
   λ(pkg : Text) →
   { bounds = prelude.anyVersion, package = pkg } : types.Dependency

, renameNoop =
   λ(pkg : Text) →
   { name = pkg, original = { name = pkg, package = [] : Optional Text } }

, showlib = showlib

, getnames =
  λ(mods : List ReexportedModule)
  → List/map ReexportedModule Text getname mods

, renameSig =
   λ(to : Text) →
   λ(specific : Text) →
   { rename = ("Torch.Sig."++specific) : Text
   , to = ("Torch."++ to ++ "."++specific) : Text
   }
, ffi-basename = ffi-basename

, memory-module =
    λ(isth : Bool) →
    λ(ttype : Text) →
    λ(modtype : Text) →
    (ffi-basename isth ttype) ++ "." ++ (if isth then "Free" else "") ++ modtype
}
