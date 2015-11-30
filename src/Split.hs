{-# LINE 1 "src/Split.hsc" #-}
{-# LANGUAGE ForeignFunctionInterface, CPP #-}
{-# LINE 2 "src/Split.hsc" #-}

module Split where

import Foreign.C.Types
import Foreign.Ptr
import Foreign.ForeignPtr

import Data.Bits

-- import AI.CV.OpenCV.CxCore
-- import AI.CV.OpenCV.Util


{-# LINE 15 "src/Split.hsc" #-}

foreign import ccall unsafe "cv.h cvSplit"
  split :: Ptr () -> Ptr () -> Ptr () -> Ptr () -> IO ()
--
-- main = print "yo"
