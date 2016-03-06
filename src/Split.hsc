{-# LANGUAGE ForeignFunctionInterface, CPP #-}

module Split where

import Foreign.C.Types
import Foreign.Ptr
import Foreign.ForeignPtr
import Foreign.Storable
import Foreign.Marshal.Alloc

import Data.Bits
import Control.Arrow

import AI.CV.OpenCV.CxCore
import AI.CV.OpenCV.Util
import AI.CV.ImageProcessors
import Control.Processor hiding (split)

#include <opencv/cv.h>

withForeignPtr4 a b c d f = do
  withForeignPtr a $ \a ->
    withForeignPtr b $ \b ->
      withForeignPtr c $ \c ->
        withForeignPtr d $ \d -> f a b c d

foreign import ccall unsafe "cv.h cvSplit"
  c_split :: Ptr Priv_IplImage -> Ptr Priv_IplImage -> Ptr Priv_IplImage -> Ptr Priv_IplImage -> Ptr Priv_IplImage -> IO ()


split :: Image -> Image -> Image -> Image -> IO ()
split a b c d = do
  withForeignPtr4 a b c d $ \a b c d -> do
    c_split a b c d nullPtr

split' :: IOProcessor Image (Image, Image, Image)
split' = processor processSplit allocateSplit convertState releaseState
  where processSplit src (red, green, blue) = do
          split src red green blue
          return (red, green, blue)
        allocateSplit src = do
          srcSize <- getSize src
          red <- createImage srcSize iplDepth8u 1
          green <- createImage srcSize iplDepth8u 1
          blue <- createImage srcSize iplDepth8u 1
          return (red, green, blue)
        convertState = return
        releaseState _ = return ()

fst3 :: (a,b,c) -> a
fst3 (a,_,_) = a

first3, getBlue :: IOProcessor (a,b,c) a
first3 = arr fst3

snd3 :: (a,b,c) -> b
snd3 (_,b,_) = b

second3, getGreen :: IOProcessor (a,b,c) b
second3 = arr snd3

trd3 :: (a,b,c) -> c
trd3 (_,_,c) = c

third3, getRed :: IOProcessor (a,b,c) c
third3 = arr trd3

modRed :: (x -> y) -> IOProcessor (a,b,x) (a,b,y)
modRed f = arr (\(a,b,x) -> (a,b,f x))

modGreen :: (x -> y) -> IOProcessor (a,x,c) (a,y,c)
modGreen f = arr (\(a,x,c) -> (a,f x,c))

modBlue :: (x -> y) -> IOProcessor (x,b,c) (y,b,c)
modBlue f = arr (\(x,b,c) -> (f x,b,c))

arrIO :: (x -> IO y) -> IOProcessor x y
arrIO f = processor process allocate convert release
  where process x _ = f x
        allocate x = f x
        convert = return
        release _ = return ()


modTrd :: (x -> y) -> (a,b,x) -> (a,b,y)
modTrd f (a,b,x) = (a,b,f x)


getBlue = first3
getGreen = second3
getRed = third3
