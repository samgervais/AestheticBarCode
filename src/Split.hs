{-# LANGUAGE ForeignFunctionInterface #-}

module Split where

import Foreign.C.Types
import Foreign.Ptr
import Foreign.ForeignPtr
 
import Data.Bits

import AI.CV.OpenCV.CxCore
import AI.CV.OpenCV.Util

#include <cv.h>
 
foreign import ccall unsafe "cv.h cvSplit" 
	split :: Ptr Priv_IplImage -> Ptr Priv_IplImage -> Ptr Priv_IplImage -> Ptr Priv_IplImage -> IO ()
