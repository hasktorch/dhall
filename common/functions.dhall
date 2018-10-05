   let prelude  = ../dhall-to-cabal/dhall/prelude.dhall
in let types    = ../dhall-to-cabal/dhall/types.dhall
in let List/map = ../Prelude/List/map
in let getname = λ(foo : {name:Text,original:{name:Text,package:Optional Text}}) → foo.name
in
{ anyver =
   λ(pkg : Text) →
   { bounds = prelude.anyVersion, package = pkg } : types.Dependency

, renameNoop =
   λ(pkg : Text) →
   { name = pkg, original = { name = pkg, package = [] : Optional Text } }

, showlib =  λ(isth : Bool) → if isth then "TH" else "THC"

, getnames =
  λ(mods : List {name:Text,original:{ name:Text, package:Optional Text}})
  → List/map {name:Text,original:{name:Text,package:Optional Text}} Text getname mods

, renameSig =
   λ(to : Text) →
   λ(specific : Text) →
   { rename = ("Torch.Sig."++specific) : Text
   , to = ("Torch."++ to ++ "."++specific) : Text
   }
}
