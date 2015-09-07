import AI.CV.ImageProcessors
import Control.Arrow

win = window 0
cam = camera 0
edge = canny 30 190 3

main = do
  runTillKeyPressed (videoFile "out.mp4" >>> edge >>> win)
