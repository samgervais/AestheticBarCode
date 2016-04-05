-- Author: Samuel Gervais
-- Saint Piux X High School
-- email: samgervais512@gmail.com
-- cell: (505)933-2571
-- Array Module  

module Array where
import AI.CV.OpenCV.CxCore
import AI.CV.OpenCV.HighGui
import Foreign.C.Types

import Data.Array
import Data.Array.Accelerate.Array.Sugar (EltRepr)
import Control.Applicative ((<$>))
import Foreign.Ptr (castPtr)
import Foreign.Marshal.Array


-- | Converts an IplImage, the native image type for C, into a three-dementional array
-- | such that the first and second demention represent the rows of the image, and the
-- | thrid shows the number of channels at every point of the image.
iplToArray3 :: IplImage -- ^ Initial image for conversion
               -> IO (Array (Int,Int,Int) Int) -- ^ 3-dementional array with pixel color as elements
iplToArray3 image = do
  (CvSize w h) <- getSize image
  d <- getNumChannels image
  print (w, h, d)
  let w' = fromIntegral w
  let h' = fromIntegral h
  let d' = fromIntegral d
  imgPtr <- castPtr <$> getImageData image
  xs <- peekArray (w' * h' * d') imgPtr :: IO [CUChar]
  let arr = array ((0,0,0),(w'-1,h'-1,d'-1)) [(((i `div` d') `mod` w',i `div` w'*d',i `mod` d'), fromIntegral x) | (i,x) <- zip [0..] xs]
  return arr

-- | Converts an IplImage, the native image type for C, into a two-dementional array
-- | such that the first and second represent the rows in the image. This function is
-- | for the use of images with only one channel.
iplToArray2 :: IplImage -- ^ Initial image for conversion
               -> IO (Array (Int,Int) Int) -- ^ 2-dementional array with pixel color as elements
iplToArray2 image = do
  (CvSize w h) <- getSize image
  d <- getNumChannels image
  if d /= 1 then error "Needs 1 channel image" else return ()
  let w' = fromIntegral w
  let h' = fromIntegral h
  imgPtr <- castPtr <$> getImageData image
  xs <- peekArray (w' * h') imgPtr :: IO [CUChar]
  let arr = listToArr xs (w',h')
  -- print $ elems arr
  return arr


listToArr :: [CUChar] -> (Int, Int) -> Array (Int, Int) Int
listToArr xs (w,h) = array bounds [inner i x | (i,x) <- zip [0..] xs]
  where bounds = ((0,0),(w-1,h-1))
        inner i x = ((i `mod` w,i `div` w), fromIntegral x `div` 255)
