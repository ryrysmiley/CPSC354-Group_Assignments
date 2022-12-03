{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_LamFun (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [3,14,1] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/kaiit/.cabal/bin"
libdir     = "/Users/kaiit/.cabal/lib/aarch64-osx-ghc-8.10.7/LamFun-3.14.1-inplace-lamfun"
dynlibdir  = "/Users/kaiit/.cabal/lib/aarch64-osx-ghc-8.10.7"
datadir    = "/Users/kaiit/.cabal/share/aarch64-osx-ghc-8.10.7/LamFun-3.14.1"
libexecdir = "/Users/kaiit/.cabal/libexec/aarch64-osx-ghc-8.10.7/LamFun-3.14.1"
sysconfdir = "/Users/kaiit/.cabal/etc"

getBinDir     = catchIO (getEnv "LamFun_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "LamFun_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "LamFun_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "LamFun_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "LamFun_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "LamFun_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
