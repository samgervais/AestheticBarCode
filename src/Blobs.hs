module Blobs where
import Data.Array
import Data.Foldable
import Data.Tuple

xss :: [[Int]]
xss = [[0,0,0,0,0,0,0,0,0,0,0,0,0]
      ,[0,0,0,0,1,0,0,0,0,0,0,0,0]
      ,[0,0,0,0,0,0,0,1,1,1,0,0,0]
      ,[0,0,0,0,0,0,1,1,0,1,0,0,0]
      ,[0,0,0,0,0,0,0,1,1,1,0,0,0]
      ,[0,0,1,1,0,0,0,0,0,0,0,0,0]
      ,[0,0,1,0,0,0,0,0,0,0,0,0,0]
      ,[0,0,0,1,0,0,0,0,0,0,0,0,0]]

realXss = map (map (1-)) xss

nss = array ((0,0),(12,7)) [((x,y), xss !! y !! x) | x <- [0..12], y <- [0..7]]
realNss = array ((0,0),(12,7)) [((x,y), realXss !! y !! x) | x <- [0..12], y <- [0..7]]

inBounds :: Array (Int, Int) Int -> (Int,Int) -> Bool
inBounds arr (x,y) = x >= lx && x <= hx && y >= ly && y <= hy
  where ((lx,ly), (hx,hy)) = bounds arr

checkAround :: Array (Int, Int) Int -> (Int,Int) -> [(Int,Int)]
checkAround arr (x,y) = [ (x',y') | (h,k) <- [(0,1),(1,0),(-1,0),(0,-1)]
                        , let x' = x + h
                        , let y' = y + k
                        , inBounds arr (x',y') && arr ! (x',y') == 1
                        ]

getAllConnected' :: Array (Int, Int) Int -> [(Int,Int)] -> [(Int,Int)] -> [(Int,Int)]
getAllConnected' _ [] acc = acc
getAllConnected' arr is acc = getAllConnected' arr blobIndecies (blobIndecies++acc)
  where blobIndecies = [x | x <- concatMap (checkAround arr) is, x `notElem` acc]

getAllConnected :: Array (Int, Int) Int -> (Int,Int) -> [(Int,Int)]
getAllConnected arr i = getAllConnected' arr [i] [i]

replaceWith :: Int -> Array (Int, Int) Int -> [(Int,Int)] -> Array (Int, Int) Int
replaceWith x arr index = arr//[(i,x) | i <- index]

perIndex :: (Array (Int, Int) Int, [[(Int,Int)]]) -> (Int,Int) -> IO (Array (Int, Int) Int, [[(Int,Int)]])
perIndex (arr, xss) index = do
  print index
  print $ arr ! index
  return $ case arr ! index of
                1 -> (replaceWith 2 arr newXs, newXs : xss)
                x -> (arr, xss)
                where newXs = getAllConnected arr index

findBlobs :: Array (Int, Int) Int -> IO [[(Int,Int)]]
findBlobs arr = do
  snd <$> foldlM perIndex (arr, []) (map swap $ indices arr)
