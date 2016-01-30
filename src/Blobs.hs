import Data.Array

xss :: [[Int]]
xss = [[0,0,0,0,0,0,0,0,0,0,0,0,0]
      ,[0,0,0,0,1,0,0,0,0,0,0,0,0]
      ,[0,0,0,0,0,0,0,1,1,1,0,0,0]
      ,[0,0,0,0,0,0,1,1,0,1,0,0,0]
      ,[0,0,0,0,0,0,0,1,1,1,0,0,0]
      ,[0,0,1,1,0,0,0,0,0,0,0,0,0]
      ,[0,0,1,0,0,0,0,0,0,0,0,0,0]
      ,[0,0,0,1,0,0,0,0,0,0,0,0,0]]


nss = array ((0,0),(12,7)) [((x,y), xss !! y !! x) | x <- [0..12], y <- [0..7]]

checkAround :: Array (Int, Int) Int -> (Int,Int) -> [(Int,Int)]
checkAround arr (x,y) = [ (x',y') | (i,j) <- [(0,1),(1,0),(-1,0),(0,-1)]
                        , let x' = x + i
                        , let y' = y + j
                        , arr ! (x', y') == 1
                        ]

getAllConnected' :: Array (Int, Int) Int -> [(Int,Int)] -> [(Int,Int)] -> [(Int,Int)]
getAllConnected' _ [] acc = acc
getAllConnected' arr is acc = getAllConnected' arr blobIndecies (blobIndecies++acc)
  where blobIndecies = [x | x <- concatMap (checkAround arr) is, x `notElem` acc]

getAllConnected :: Array (Int, Int) Int -> (Int,Int) -> [(Int,Int)]
getAllConnected arr i = getAllConnected' arr [i] [i]

replaceWith :: Int -> Array (Int, Int) Int -> [(Int,Int)] -> Array (Int, Int) Int
replaceWith x arr index = arr//[(i,x) | i <- index]

perIndex :: (Array (Int, Int) Int, [[(Int,Int)]]) -> (Int,Int) -> (Array (Int, Int) Int, [[(Int,Int)]])
perIndex (arr, xss) index = case arr ! index of
                          1 -> (replaceWith 971 arr newXs, newXs : xss) 
                          x -> (arr, xss)
                          where newXs = getAllConnected arr index

findBlobs :: Array (Int, Int) Int -> [[(Int,Int)]]
findBlobs arr = snd $ foldl perIndex (arr, []) (indices arr)