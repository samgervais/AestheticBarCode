module Array where
import AI.CV.OpenCV.CxCore
import AI.CV.OpenCV.HighGui

import Data.Array.Accelerate as A
import Data.Array.Accelerate.IO as A
import Data.Array.Accelerate.Array.Sugar (EltRepr)
import Foreign.Ptr (castPtr)


iplToArray :: IplImage -> IO (Array (Int,Int,Int) CUChar)
iplToArray image = do
  (CvSize w h) <- getSize image
  d <- getNumChannels image
  print (w, h, d)
  imgPtr <- castPtr <$> getImageData frame
  xs <- peekArray (w * h * d) imgPtr :: [CUChar]
  let arr = array ((0,0,0),(w-1,h-1,d-1)) [(((i `div` d) `mod` w,i `div` w*d,i `mod` d),x) | (i,x) <- zip [0..] xs]
  return arr

-- arrayToIpl :: Array (Int, Int, Int) CUChar -> IO IplImage
-- arrayToIpl arr = do
--   let ((0,0,0), (w',h',d')) = bounds arr
--   image <- createImage (CvSize (w'+1) (h'+1)) iplDepth8u (d'+1)
--
