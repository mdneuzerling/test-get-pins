# Required to stop pins from trying to write to the home directory
# See https://github.com/rstudio/pins-r/issues/611
Sys.setenv(PINS_USE_CACHE = "true")

library(pins)
library(lambdr)

get_pin_contents <- function(name) {
  b <- board_s3(bucket = "mdneuzerling", region = "ap-southeast-2")
  pin_read(b, name)
}

logger::log_threshold(logger::DEBUG)

start_lambda()
