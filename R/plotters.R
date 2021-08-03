.chars <- list(
  bars = intToUtf8(seq(0x2581, 0x2588), multiple = T),
  lines = c(
    paste0(intToUtf8(c(0x005f, 0x005f), multiple = T), collapse = ""),
    intToUtf8(c(seq(0x1fb7b, 0x1fb76), 0x23ba), multiple = T)
  ),
  area = rbind(
    intToUtf8(c(0xfe2d, 0x1fb48, 0x1fb4a, 0x1fb4b), multiple = T),   # c("︭", "🭈", "🭊", "🭋"),
    intToUtf8(c(0x1fb3d, 0x1fb2d, 0x1fb46, 0x1fb44), multiple = T),  # c("🬽", "🬭", "🭆", "🭄"),
    intToUtf8(c(0x1fb3f, 0x1fb51, 0x1fb39, 0x1fb42), multiple = T),  # c("🬿", "🭑", "🬹", "🭂"),
    intToUtf8(c(0x1fb40, 0x1fb4f, 0x1fb4d, 0x1fb8b), multiple = T)   # c("🭀", "🭏", "🭍", "🮋")
  )
)

#' Generate a sparkline from a vector of numbers
#'
#' @param numbers Vector of numbers.
#' @param chars Symbols used to create sparkline. Either \code{'lines'} or
#'   \code{'bars'}.
#' @return Sparkline plot as a character vector of length 1
#' @examples
#' test1 <- c(1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1)
#' test2 <- c(1.5, 0.5, 3.5, 2.5, 5.5, 4.5, 7.5, 6.5)
#' sparkline(test1)
#' sparkline(test2)
sparkline <- function(numbers, chars = c("bars", "lines", "area")) {
  chars <- match.arg(chars)
  if (chars == "area") return(sparkline_area(numbers))
  chars <- .chars[[chars]]

  n_chars <- length(chars)
  mn <- min(numbers)
  mx <- max(numbers)
  interval <- mx - mn

  bins <- sapply(
    numbers,
    function(i) {
      chars[[1 + min(n_chars - 1,
                     floor((i - mn) / interval * n_chars))]]
    }
  )
  sparkline <- paste0(bins, collapse = "")

  return(sparkline)
}

sparkline_bars <- function(numbers) {
  return(sparkline(numbers, "bars"))
}

sparkline_lines <- function(numbers) {
  return(sparkline(numbers, "lines"))
}

sparkline_area <- function(numbers) {
  chars <- .chars$area
  n_lvls <- 4
  mn <- min(numbers)
  mx <- max(numbers)
  interval <- mx - mn

  # dists
  bins <- sapply(
    numbers,
    function(i) 1 + min(n_lvls - 1, floor((i - mn) / interval * n_lvls))
  )

  dists <- diff(bins)
  n_chars <- length(dists)
  sparkline <- character(n_chars)

  for (i in seq_along(dists)) {
    row <- ifelse(i == 1, bins[[i]], col)
    col <- row + dists[[i]]

    sparkline[i] = chars[row, col]
  }
  sparkline <- paste0(sparkline, collapse = "")

  return(sparkline)
}
