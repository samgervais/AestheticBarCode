import AI.CV.ImageProcessors
import Control.Arrow
import Split

-- win :: IOProcessor Image ()
win = window 0
-- cam :: IOProcessor () Image
cam = camera 0
-- edge :: IOProcessor Image Image
edge = canny 30 190 3

main = do
  runTillKeyPressed (videoFile "out.mp4" >>> split' >>> getBlue >>> win)


-- getCode :: IOProcessor Image [((Int,Int),Color)]
-- getCode = getComponents >>> getDots
--
-- getComponents :: IOProcessor Image (Image,Image,Image)
--
-- getDots :: IOProcessor (Image, Image, Image) [((Int,Int),Color)]
