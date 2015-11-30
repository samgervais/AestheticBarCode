{-# LINE 1 "src/Split.hs" #-}
{-# LANGUAGE ForeignFunctionInterface, CPP #-}
{-# LINE 2 "src/Split.hs" #-}

module Split where

import Foreign.C.Types
import Foreign.Ptr
import Foreign.ForeignPtr

import Data.Bits

import AI.CV.OpenCV.CxCore
import AI.CV.OpenCV.Util


{-# LINE 15 "src/Split.hs" #-}

foreign import ccall unsafe "cv.h cvSplit"
  split :: Ptr Priv_IplImage -> Ptr Priv_IplImage -> Ptr Priv_IplImage -> Ptr Priv_IplImage -> IO ()

main = print "yo"
