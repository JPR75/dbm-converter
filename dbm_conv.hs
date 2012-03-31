module Main
  where

import IO

main = do
  hSetBuffering stdin LineBuffering
  result <- getChoice
  putStrLn ("====> " ++ show (result))

getChoice = do
  putStrLn "dBm convertor ; v1.0.0"
  putStrLn "  0 : quit"
  putStrLn "  1 : V pk-pk to dBm"
  putStrLn "  2 : V rms to dBm"
  putStrLn "  3 : dBm to V pk-pk"
  putStrLn "  4 : dBm to V rms"
  putStrLn "select the conversion : "
  num <- getLine
  let choiceNum = read num
  case choiceNum of
    0 -> return (0)
    1 -> vpk2dBm
    2 -> vrms2dBm
    3 -> dbm2vpk
    4 -> dbm2vrms
    _ -> getChoice

vpk2dBm = do
  putStrLn "Vpk-pk (V) ? : "
  numVpk <- getLine
  let vpk = read numVpk
  return (10.0 * logBase 10 (vpk^2 * 2.5))

vrms2dBm = do
  putStrLn "V rms (V) ? : "
  numVrms <- getLine
  let vrms = read numVrms
  return (10.0 * logBase 10 (vrms^2 * 20))

dbm2vpk = do
  putStrLn "dbm ? : "
  numdbm <- getLine
  let dbm = read numdbm
  return (sqrt (0.4 * 10**(dbm / 10.0)))

dbm2vrms = do
  putStrLn "dbm ? : "
  numdbm <- getLine
  let dbm = read numdbm
  return (sqrt (0.05 * 10**(dbm / 10.0)))
