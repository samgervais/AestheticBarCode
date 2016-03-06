module Array where
import AI.CV.OpenCV.CxCore
import AI.CV.OpenCV.HighGui
import Foreign.C.Types

import Data.Array
import Data.Array.Accelerate.Array.Sugar (EltRepr)
import Foreign.Ptr (castPtr)
import Foreign.Marshal.Array

iplToArray3 :: IplImage -> IO (Array (Int,Int,Int) CUChar)
iplToArray3 image = do
  (CvSize w h) <- getSize image
  d <- getNumChannels image
  print (w, h, d)
  let w' = fromIntegral w
  let h' = fromIntegral h
  let d' = fromIntegral d
  imgPtr <- castPtr <$> getImageData image
  xs <- peekArray (w' * h' * d') imgPtr :: IO [CUChar]
  let arr = array ((0,0,0),(w'-1,h'-1,d'-1)) [(((i `div` d') `mod` w',i `div` w'*d',i `mod` d'),x) | (i,x) <- zip [0..] xs]
  return arr

iplToArray2 :: IplImage -> IO (Array (Int,Int) Int)
iplToArray2 image = do
  (CvSize w h) <- getSize image
  d <- getNumChannels image
  if d /= 1 then error "Needs 1 channel image" else return ()
  let w' = fromIntegral w
  let h' = fromIntegral h
  imgPtr <- castPtr <$> getImageData image
  xs <- peekArray (w' * h') imgPtr :: IO [CUChar]
  let arr = array ((0,0),(w'-1,h'-1)) [((i `mod` w',i `div` w'), (255 - (fromIntegral x)) `div` 255) | (i,x) <- zip [0..] xs]
  return arr



-- arrayToIpl :: Array (Int, Int, Int) CUChar -> IO IplImage
-- arrayToIpl arr = do
--   let ((0,0,0), (w',h',d')) = bounds arr
--   image <- createImage (CvSize (w'+1) (h'+1)) iplDepth8u (d'+1)
--
