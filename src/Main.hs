import AI.CV.ImageProcessors
import Control.Arrow

win = window 0
cam = camera 0
edge = canny 30 190 3

main = do
  runTillKeyPressed (videoFile "out.mp4" >>> edge >>> win)

getCode :: IOProcessor Image [((Int,Int),Color)]
getCode = getComponents >>> getDots

getComponents :: IOProcessor Image (Image,Image,Image)

getDots :: IOProcessor (Image, Image, Image) [((Int,Int),Color)]
