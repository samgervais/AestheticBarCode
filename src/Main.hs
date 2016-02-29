{-# LANGUAGE ScopedTypeVariables, TypeOperators #-}

import AI.CV.ImageProcessors
import Control.Arrow
import Control.Processor
import Split

-- win :: IOProcessor Image ()
win = window 0
-- cam :: IOProcessor () Image
cam = camera 0
-- edge :: IOProcessor Image Image
edge = canny 30 190 3

main = do
  output <- run (videoFile "out.mp4" >>> split' >>> getRed >>> arrIO findBlobs) ()
  print output

-- getCode :: IOProcessor Image [((Int,Int),Color)]
-- getCode = split' >>> getDots
--
-- getDots :: IOProcessor (Image, Image, Image) [((Int,Int),Color)]
-- getDots = (modRed redDots >>> modGreen greenDots >>> modBlue blueDots) >>> glueTogether

-- glueTogether :: IOProcessor ([(Int, Int)],[(Int, Int)],[(Int, Int)]) [((Int,Int), Color)]
-- glueTogether = arr (\(bs,gs,rs) -> [])

-- redDots :: Image -> [(Int, Int)]
-- redDots
-- greenDots :: Image -> [(Int,Int)]
-- blueDots :: Image -> [(Int,Int)]
