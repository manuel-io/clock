module Main
where

import Graphics.Gloss.Data.Bitmap
import Graphics.Gloss.Interface.IO.Animate
import Data.Time.LocalTime
import Data.Time.Format
import Paths_clock (getDataFileName)

drawSec = Color yellow $ Pictures
  [ Polygon [ (-1,0), (1,0), (1,80), (-1,80) ]
  , Polygon [ (1,80), (0,90), (-1,80) ]
  ]

drawMin = Color yellow $ Pictures
  [ Polygon [ (-1,0), (1,0), (1,60), (-1,60) ]
  , Polygon [ (1,60), (0,80), (-1,60) ]
  ]

drawHor = Color yellow $ Pictures
  [ Polygon [ (-1,0), (1,0), (1,40), (-1,40) ]
  , Polygon [ (1,40), (0,50), (-1,40) ]
  ]

main = do
  file <- getDataFileName "data/clock.bmp" >>= loadBMP
  animateIO (InWindow "Clock" (320, 320) (0, 0)) black (frame file) controller
  where
    controller c = return ()
    frame :: Picture -> Float -> IO Picture
    frame file s = do
      sec <- getZonedTime >>= return . formatTime defaultTimeLocale "%S"
      min <- getZonedTime >>= return . formatTime defaultTimeLocale "%M"
      hor <- fmap (formatTime defaultTimeLocale "%H") getZonedTime
      return $ Pictures
        [ file
        , Rotate (360/60 * (read sec :: Float)) drawSec
        , Rotate (360/60 * (read min :: Float)) drawMin
        , Rotate (360/12 * (read hor :: Float)) drawHor
        ]
