module HaskellImageProcessingBenchmark.Friday (
    Image,readPng,threshold,mean) where

import Vision.Image.Grey (Grey,GreyPixel)
import Vision.Image.Storage.DevIL (load, PNG(..))
import Data.Convertible (convert)

import qualified Vision.Image.Threshold as Friday (threshold)
import Vision.Image.Threshold (ThresholdType(BinaryThreshold))

import Vision.Image.Filter (blur)
import Data.Int (Int16)

type Image = Grey

readPng :: FilePath -> IO Image
readPng filepath = do
    Right image <- load PNG filepath
    return image

{-# INLINE threshold #-}
threshold :: Image -> Image
threshold = Friday.threshold (>127) (BinaryThreshold 0 255)

{-# INLINE mean #-}
mean :: Image -> Image
mean image = blur 2 image -- apply (blur 2 :: SeparableFilter GreyPixel Int16 GreyPixel) image
