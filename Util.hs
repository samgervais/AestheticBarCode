import Data.List

-- | Creates the type for the four colors used to make a numerical code, black, red,
-- | green and blue which correspond to the base-four numbers 0, 1, 2 and 3, respectively.
data Color = Black | Red | Green | Blue  deriving (Show, Eq, Ord, Enum)

-- | Given a sorted list of colors and their Cartesian posistions, the "code" function creates
-- | a base-ten number from the base-four number derived from the colors. The provided list is sorted
-- | prior to its use in this function with the upper left most color at the head of the list and
-- | the lower right most color as the last element of the list.
code :: [((Int,Int), Color)] -- ^ Takes a list of colors with their corresponding positions
        -> Int -- ^ Outputs a base-ten int
code = toBaseTen . toBaseFourString

-- | Creates a base-four number as a string where each element of the given list represents a separate digit of the
-- | number, and the number is derived by converting the element's color into a number; the list is also sorted
-- | by posistion.
toBaseFourString :: [((Int,Int), Color)] -- ^ Takes a list of colors with their corresponding positions
                    -> String -- ^ Outputs a base-four number as a string
toBaseFourString [] = []
toBaseFourString dots = char : rest
  where dot@(_,c) = head $ furthest up $ furthest left dots
        char = head $ show $ fromEnum c
        rest = toBaseFourString $ delete dot dots

-- | Converts a string with a base-four number into base-ten. It is able to use the output of the "toBaseFourString" function.
toBaseTen :: String -- ^ Takes a string containing a base-four number
             -> Int -- ^ Outputs a base-ten int
toBaseTen = sum . zipWith (*) fours . reverse . map (read.(:[]))
  where fours = map (4^) [0..]

-- | A function properly used with the "furthest" function, which compares the x-coordinate of a given color's position and the
-- | x-coordinate of the first element of a list of colors and their positions. With this comparison, the function returns, in
-- | a list, the color with the smallest x-coordinate.
left :: ((Int, Int), Color) -- ^ Takes a color and its corresponding position
        -> [((Int, Int), Color)] -- ^ Takes a list of colors with their corresponding positions
        -> [((Int, Int), Color)] -- ^ Outputs a list of colors and their positions; this is either the original list, position, or both
left p [] = [p]
left p@((x,_),_) xs = case compare x (fst $ fst $ head xs) of
            LT -> [p]
            EQ -> p : xs
            GT -> xs
-- | Similar to the "left" function, except this function compares to y-coordinates of the colors.
up :: ((Int, Int), Color) -- ^ Takes a color and its corresponding position
      -> [((Int, Int), Color)] -- ^ Takes a list of colors with their corresponding positions
      -> [((Int, Int), Color)] -- ^ Outputs a list of colors and their positions; this is either the original list, position, or both
up p [] = [p]
up p@((_,y),_) ys = case compare y (snd $ fst $ head ys) of
            LT -> [p]
            EQ -> p : ys
            GT -> ys

-- | Uses the functions "up" and "left" to produce a sorted list where the first element is the upper-left most color
-- | and the last element is the lower-right most color by comparing each element to every other element.
furthest :: (((Int, Int), Color) -> [((Int, Int), Color)] -> [((Int, Int), Color)]) -- ^ Takes the "up" or "left" function
            -> [((Int, Int), Color)] -- ^ Takes a list of colors with their corresponding positions
            -> [((Int, Int), Color)] -- ^ Outputs a sorted list of colors and their positions
furthest = flip foldr []