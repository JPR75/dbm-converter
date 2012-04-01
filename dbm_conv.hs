-- dBm to volt and volt to dBm converter
-- 50 Ohm load

module Main
  where

import IO
import Text.Printf

main = do
  putStrLn "dBm convertor v1.0.0 ; 50 Ohm load"
  hSetBuffering stdin LineBuffering
  getChoice

getChoice = do
  printChoices
  num <- getLine
  let choiceNum = read num
  case choiceNum of
    0 -> return ()
    1 -> do putStrLn "Vpk-pk (V) ? : "
            result <- getValue 1
            putStrLn $ printf "\n  %f V pk-pk => %.4f dBm" (fst result:: Double) (snd result)
            getChoice
    2 -> do putStrLn "V rms (V) ? : "
            result <- getValue 2
            putStrLn $ printf "\n  %f V rms => %.4f dBm" (fst result:: Double) (snd result)
            getChoice
    3 -> do putStrLn "dbm ? : "
            result <- getValue 3
            putStrLn $ printf "\n  %f dBm => %.4f V pk-pk" (fst result:: Double) (snd result)
            getChoice
    4 -> do putStrLn "dbm ? : "
            result <- getValue 4
            putStrLn $ printf "\n  %f dBm => %.4f V pk-pk" (fst result:: Double) (snd result)
            getChoice
    _ -> getChoice

printChoices = do
  putStrLn " "
  putStrLn "select : "
  putStrLn "  0 : quit"
  putStrLn "  1 : V pk-pk to dBm"
  putStrLn "  2 : V rms to dBm"
  putStrLn "  3 : dBm to V pk-pk"
  putStrLn "  4 : dBm to V rms"

getValue convertionChoice = do
  numValue <- getLine
  let value = read numValue
  converter convertionChoice value

converter convertionChoice value
  | convertionChoice == 1 = return ((value , 10.0 * logBase 10 (value^2 * 2.5)))
  | convertionChoice == 2 = return ((value , 10.0 * logBase 10 (value^2 * 20)))
  | convertionChoice == 3 = return ((value , sqrt (0.4 * 10**(value / 10.0))))
  | convertionChoice == 4 = return ((value , sqrt (0.05 * 10**(value / 10.0))))
  | otherwise             = return (0.0, 0.0)

