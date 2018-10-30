   let prelude = ./dhall-to-cabal/dhall/prelude.dhall
in let types = ./dhall-to-cabal/dhall/types.dhall
in let fn = ./common/functions.dhall
in let cabalvars =
  { author = "Hasktorch dev team" : Text
  , maintainer = "Sam Stites <fnz@fgvgrf.vb>, Austin Huang <nhfgvau@nyhz.zvg.rqh> - cipher:ROT13" : Text
  , bug-reports = "https://github.com/hasktorch/hasktorch/issues" : Text
  , version = prelude.v "0.0.1.0" : types.Version
  , build-type = [ prelude.types.BuildTypes.Simple {=} ] : Optional types.BuildType
  , homepage = "https://github.com/hasktorch/hasktorch#readme" : Text
  , default-language = [ (constructors types.Language).Haskell2010 {=} ] : Optional types.Language
  , license =
      prelude.types.Licenses.SPDX
        ( prelude.SPDX.license
          (prelude.types.LicenseId.BSD_3_Clause {=})
          ([] : Optional types.LicenseExceptionId)
        ) : types.License
  , source-repos =
    [ prelude.defaults.SourceRepo
      // { type = [ prelude.types.RepoType.Git {=} ] : Optional types.RepoType
         , location = [ "https://github.com/hasktorch/hasktorch" ] : Optional Text
         }
    ] : List types.SourceRepo
  , ghc-options = [ "-Wall", "-Wincomplete-uni-patterns", "-Wincomplete-record-updates"] -- , "-Wmissing-import-lists" ]
  , category = "Tensors, Machine Learning, AI"
  , default-extensions =
      [ prelude.types.Extensions.LambdaCase True
      , prelude.types.Extensions.DataKinds True
      , prelude.types.Extensions.TypeFamilies True
      , prelude.types.Extensions.TypeSynonymInstances True
      , prelude.types.Extensions.ScopedTypeVariables True
      , prelude.types.Extensions.FlexibleContexts True
      , prelude.types.Extensions.CPP True
      ]
  }

in
{ cabalvars = cabalvars
, packages = ./common/packages.dhall
, Package = prelude.defaults.Package
  // { version = cabalvars.version
     , author = cabalvars.author
     , maintainer = cabalvars.maintainer
     , bug-reports = cabalvars.bug-reports
     , build-type = cabalvars.build-type
     , homepage = cabalvars.homepage
     , license = cabalvars.license
     , source-repos = cabalvars.source-repos
     , category = cabalvars.category
     }
, Library = prelude.defaults.Library
  //
    { default-language = cabalvars.default-language
    , default-extensions = cabalvars.default-extensions
    }
, flags =
  { cuda =
    { name = "cuda"
    , description = "build with THC support"
    , manual = False
    , default = False
    }
  , lite =
    { name = "lite"
    , description = "only build with Double and Long support"
    , manual = False
    , default = False
    }
  , gd =
    { name = "gd"
    , description = "use gd graphics library for loading images"
    , manual = False
    , default = False
    }
  , debug =
    { name = "debug"
    , description = "turn on debugging flags"
    , manual = False
    , default = False
    }
  , half =
    { name = "half"
    , description = "build with half support"
    , manual = False
    , default = False
    }
  , float =
    { name = "float"
    , description = "Build with float support. THC doesn't seem to build uniform Float types by default."
    , manual = False
    , default = False
    }
  , with_nn =
    { name = "with_nn"
    , description = "build with nn support"
    , manual = False
    , default = True
    }
  }
}


