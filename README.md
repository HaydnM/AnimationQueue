# Animation Queue
A queue implementation to help chain groups of CAAnimations across different CALayers

## Overview
* The queue is a standard FIFO queue
* You can enqueue /animation batches/ that contain one or more CAAnimations to be run on one or more CALayers
* The queue maintains a count internally that determines when to run the next batch of animations
* When the queue dequeues the next /animation batch/ it increments it’s count by 1 for each animation in the batch
* Each time one of the animations complete the queue’s counter is decremented
* When the queue’s count returns to 0 it dequeues the next animation batch
