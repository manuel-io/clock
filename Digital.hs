module Main
where

import Graphics.Gloss.Data.Bitmap
import Graphics.Gloss.Interface.IO.Animate
import Data.Time.LocalTime
import Data.Time.Format

main = do
  animateIO (InWindow "Clock" (320, 150) (0, 0)) black frame controller
  where
    controller c = return ()
    frame :: Float -> IO Picture
    frame s = do
      now <- getZonedTime >>= return . formatTime defaultTimeLocale "%H:%M:%S"
      zone <- getZonedTime >>= return . formatTime defaultTimeLocale "%Z"
      return $ Translate (-125.0) 0.0 $ Pictures
        [ Scale 0.5 0.5 $ Color white $ Text $ now
        , Translate 80.0 (-35.0) $ Scale 0.3 0.2 $ Color yellow $ Text zone
        ]
