-- Author: Samuel Gervais
-- Saint Piux X High School
-- email: samgervais512@gmail.com
-- cell: (505)933-2571
-- Main Module

{-# LANGUAGE ScopedTypeVariables, TypeOperators #-}

import AI.CV.ImageProcessors
import Control.Arrow
import Control.Processor
import Split
import Array
import Blobs
import Data.Array
-- win :: IOProcessor Image ()
win = window 0
-- cam :: IOProcessor () Image
cam = camera 0
-- edge :: IOProcessor Image Image
edge = canny 30 190 3

main = do
  output <- run (videoFile "out.mp4" >>> split' >>> getRed >>> arrIO iplToArray2) ()
  -- return ()
  print $ head $ findBlobs output

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
-- 995092

-- -- Do stuff, bind, apply, map
-- =<< :: (a -> m b) -> m a -> m b
-- <$> :: (a -> b) -> m a -> m b
-- $ :: (m a -> m b) -> m a -> m b => $
-- <?> :: (m a -> m b) -> a -> m b => f <?> x = f $ return x
-- $ :: (a -> m b) -> a -> m b => $
-- <?> :: m (a -> b) -> m a -> m b => f <?> x = fmap ($ x) f
-- $ :: (a -> b) -> a -> b
--
-- -- Compose
-- . :: (b -> c) -> (a -> b) -> (a -> c)
-- <=< :: (b -> m c) -> (a -> m b) -> (a -> m c)
-- <<< :: a' b c -> a' a b -> a' a c
--
--
-- <<
