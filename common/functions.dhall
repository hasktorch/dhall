   let prelude  = ../dhall-to-cabal/dhall/prelude.dhall
in let types    = ../dhall-to-cabal/dhall/types.dhall
in let ReexportedModule = ./types/ReexportedModule.dhall
in let List/map = ../Prelude/List/map
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
