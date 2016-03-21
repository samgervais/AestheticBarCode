import System.Environment

main = do
  (x:_) <- getArgs
  print $ (repeat 0) !! (read x)
