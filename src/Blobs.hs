module Blobs where
import Data.Array
import Control.Applicative ((<$>))
import Data.Tuple
import Data.List (nub)

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

-- | Given an array and an index, tests if the index fits within the array; 
-- | returns True if it is, and False if it is not.
inBounds :: Array (Int, Int) Int -- ^ Array to check bounds
            -> (Int,Int) -- ^ Index to test if it is in bounds 
            -> Bool -- ^ Returns boolean determining if index is in bounds
inBounds arr (x,y) = x >= lx && x <= hx && y >= ly && y <= hy
  where ((lx,ly), (hx,hy)) = bounds arr

-- | Returns the indices whose element equals one and surround a given index in a 
-- | plus-shaped pattern. Indecies which do not exist in the array are ignored.
checkAround :: Array (Int, Int) Int -- ^ Array of zeros and ones representing a black and white image
               -> (Int,Int) -- ^ Starting index
               -> [(Int,Int)] -- ^ Returns list of indices around the starting index
checkAround arr (x,y) = [ (x',y') | (h,k) <- [(0,1),(1,0),(-1,0),(0,-1)]
                        , let x' = x + h
                        , let y' = y + k
                        , inBounds arr (x',y') 
                        , arr ! (x',y') == 1
                        ]

-- | Returns a list of indecies of all the elements which are connected to a given element's index
-- | by recursively going through a list and using the "checkAround" function until all of the 
-- | idecies are found. Acts as a helper funtion for the "getAllConnected" function.
getAllConnected' :: Array (Int, Int) Int -- ^ Array representing image
                    -> [(Int,Int)] -- ^ List of indices to find connected around
                    -> [(Int,Int)] -- ^ Accumulator 
                    -> [(Int,Int)] -- ^ Returns list of indecies attached to the starting index
getAllConnected' _ [] acc = acc
getAllConnected' arr is acc = getAllConnected' arr blobIndecies (blobIndecies++acc)
  where blobIndecies = nub [x | x <- concatMap (checkAround arr) is, x `notElem` acc]
-- | Uses the "getAllConected'" helper function to find the connected elements around a given index.
getAllConnected :: Array (Int, Int) Int -- ^ Array representing image
                   -> (Int,Int) -- ^ Starting index
                   -> [(Int,Int)] -- ^ Returns list of indecies attached to the starting index
getAllConnected arr i = nub $ getAllConnected' arr [i] [i]

-- | Replaces all elements at the positions of given indices with a given number.
replaceWith :: Int -- ^ Elment which replaces the others
               -> Array (Int, Int) Int -- ^ Array 
               -> [(Int,Int)] -- ^ Indecies to be replaced
               -> Array (Int, Int) Int -- ^ Returns a ew array with replaced indecies
replaceWith x arr index = arr//[(i,x) | i <- index]

-- | The step function for "findBlobs", it takes a tuple of an array and a list of lists of indices (representing 
-- | the blobs in a image) and searches for the blobs around one index by using the "getAllConnected" function. 
perIndex :: (Array (Int, Int) Int, [[(Int,Int)]]) -- ^ 
            -> (Int,Int) -- ^ Index for step funtion
            -> (Array (Int, Int) Int, [[(Int,Int)]]) -- ^ Returns the array and new state of blobs
perIndex (arr, xss) index = case arr ! index of
                              1 -> (replaceWith 2 arr newXs, newXs : xss)
                              x -> (arr, xss)
                              where newXs = getAllConnected arr index

-- | Folds through an array to apply the "perIndex" funtion to every index in the list which ultimately finds all the
-- | blobs in the array. 
findBlobs :: Array (Int, Int) Int -- ^ Array representing image
             -> [[(Int,Int)]] -- ^ Returns a list of lists of the blobs in the image
findBlobs arr = snd $ foldl perIndex (arr, []) (indices arr)

--forFun :: Array (Int,Int) Int -> Int
forFun arr = length $ foldl (\acc x -> if x == 1 then x:acc else acc) [] (elems arr) 