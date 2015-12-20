
module HaskellImageProcessingBenchmark.Hip (
    Image,readPng,threshold,mean) where

import Control.DeepSeq (force)
import Control.Exception (evaluate)

import Graphics.Image
import HIP.Algorithms.Convolution


readPng :: FilePath -> IO (Image Gray)
readPng filepath = do
    image <- readImageGray filepath
    evaluate (force image)

{-# INLINE threshold #-}
threshold :: Image Gray -> Image Binary
threshold = (.<. Gray 0.5)

{-# INLINE mean #-}
mean :: Image Gray -> Image Gray
mean = (/ 25) . convolveCols Wrap [1,1,1,1,1] . convolveRows Wrap [1,1,1,1,1]
