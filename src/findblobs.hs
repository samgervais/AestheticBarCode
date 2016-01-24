import Data.Array

type Blob = [(Int,Int)]

xss = [[0,0,0,0,0,0,0,0,0,0,0,0,0],
       [0,0,0,0,2,0,0,0,0,0,0,0,0],
       [0,0,0,0,0,0,0,3,3,3,0,0,0],
       [0,0,0,0,0,0,3,3,0,3,0,0,0],
       [0,0,0,0,0,0,0,3,3,3,0,0,0],
       [0,0,4,4,0,0,0,0,0,0,0,0,0],
       [0,0,4,0,0,0,0,0,0,0,0,0,0],
       [0,0,0,5,0,0,0,0,0,0,0,0,0]]

arr = array ((0,0),(12,7)) [((x,y), xss !! y !! x) | x <- [0..12], y <- [0..7]]

-- findBlobs :: [[Int]] -> [Blob]
-- findBlobs =

checkAround :: Array (Int, Int) Int -> (Int,Int) -> [(Int,Int)]
checkAround xss (x,y) = [ (x',y') | (i,j) <- [(0,1),(1,0),(-1,0),(0,-1)]
                        , let x' = x + i
                        , let y' = y + j
                        , xss ! (x', y') == 1
                        ]
getAllConnected ::

findBlob :: Array (Int, Int) Int -> [(Int,Int)]
findBlob arr = snd $ foldl perIndex (arr, []) (indices arr)

perIndex :: (Array (Int, Int) Int, [(Int,Int)]) -> (Int,Int) -> (Array (Int, Int) Int, [(Int,Int)])
perIndex (state, xs) index = (newState, newXs)
  where newState = case arr ! index of
                      1 ->
                      x -> -- arr // [(indexYouWantToChange, what you want to change it to)]
        newXs = thing you want to add to xs : xs


main = print $ checkAround arr (7,2)
