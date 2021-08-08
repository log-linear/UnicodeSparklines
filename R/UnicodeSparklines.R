# Sparkline character sets
.chars <- list(
  bar = intToUtf8(seq(0x2581, 0x2588), multiple = T),  # ▁ ▂ ▃ ▄ ▅ ▆ ▇ █
  tally = intToUtf8(seq(0x1d360, 0x1d364), multiple = T),  # 𝍠 𝍡 𝍢 𝍣 𝍤
  line = c(
    paste0(intToUtf8(c(0x005f, 0x005f), multiple = T), collapse = ""),
    intToUtf8(c(seq(0x1fb7b, 0x1fb76), 0x23ba), multiple = T)
  ),  # __ 🭻  🭺  🭹  🭸  🭷  🭶  ⎺
  dot = rbind(
    intToUtf8(c(0x28c0, 0x2860, 0x2850, 0x2848), multiple = T),  # ⣀  ⡠  ⡐  ⡈
    intToUtf8(c(0x2884, 0x2824, 0x2814, 0x280c), multiple = T),  # ⢄  ⠤  ⠔  ⠌
    intToUtf8(c(0x2882, 0x2822, 0x2812, 0x280a), multiple = T),  # ⢂  ⠢  ⠒  ⠊
    intToUtf8(c(0x2881, 0x2821, 0x2811, 0x2809), multiple = T)   # ⢁  ⠡  ⠑  ⠉
  ),
  shade = intToUtf8(c(0x2581, 0x2591, 0x2592, 0x2593, 0x2588), multiple = T),
  area = rbind(
    intToUtf8(c(0xfe2d, 0x1fb48, 0x1fb4a, 0x1fb4b), multiple = T),   # ︭ 🭈 🭊 🭋
    intToUtf8(c(0x1fb3d, 0x1fb2d, 0x1fb46, 0x1fb44), multiple = T),  # 🬽 🬭 🭆 🭄
    intToUtf8(c(0x1fb3f, 0x1fb51, 0x1fb39, 0x1fb42), multiple = T),  # 🬿 🭑 🬹 🭂
    intToUtf8(c(0x1fb40, 0x1fb4f, 0x1fb4d, 0x1fb8b), multiple = T)   # 🭀 🭏 🭍 🮋

  )
)

#' Generate a sparkline from a vector of numbers.
#'
#' Generate a sparkline from a vector of numbers. `sparkline_bars()`,
#' `sparkline_line()`, `sparkline_tally()` `sparkline_shade()` `sparkline_dot`,
#' and `sparkline_area()` are convenient wrappers for the base `sparkline()`
#' function.
#'
#' @param numbers Vector of numbers.
#' @param chart Symbols used to create sparkline. One of `bar`, `tally`, `line`,
#' `shade`, `dot`, or `area`
#' @return Sparkline plot as a character vector of length 1
#' @examples
#' test1 <- c(1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1)
#' test2 <- c(1.5, 0.5, 3.5, 2.5, 5.5, 4.5, 7.5, 6.5)
#' sparkline(test1)
#' sparkline(test2)
#' @export
sparkline <- function(numbers, chart = c("bar", "line", "shade", "tally", "dot",
                                         "area")) {
  chart <- match.arg(chart)
  chars <- .chars[[chart]]

  n_chars <- ifelse(chart == "area" | chart == "dot", 4, length(chars))
  mn <- min(numbers)
  mx <- max(numbers)
  interval <- mx - mn

  bins <- sapply(
    numbers,
    function(i) 1 + min(n_chars - 1, floor((i - mn) / interval * n_chars))
  )

  # For area and dot charts, output chars are based on distances from bin to bin
  if (chart == "area" | chart == "dot") {
    dists <- diff(bins)
    n_dists <- length(dists)
    dist_bins <- matrix(nrow = n_dists, ncol = 2)

    for (i in seq_along(dists)) {
      row <- ifelse(i == 1, bins[[i]], col)
      col <- row + dists[[i]]

      dist_bins[i, ] <- c(row, col)
    }

    sparkline <- paste0(chars[dist_bins], collapse = "")
  } else {
    sparkline <- paste0(chars[bins], collapse = "")
  }

  return(sparkline)
}

#' @rdname sparkline
#' @export
sparkline_bar <- function(numbers) return(sparkline(numbers, chart = "bar"))

#' @rdname sparkline
#' @export
sparkline_line <- function(numbers)  return(sparkline(numbers, chart = "line"))

#' @rdname sparkline
#' @export
sparkline_tally <- function(numbers) return(sparkline(numbers, chart = "tally"))

#' @rdname sparkline
#' @export
sparkline_shade <- function(numbers) return(sparkline(numbers, chart = "shade"))

#' @rdname sparkline
#' @export
sparkline_area <- function(numbers) return(sparkline(numbers, chart = "area"))

#' @rdname sparkline
#' @export
sparkline_dot <- function(numbers) return(sparkline(numbers, chart = "dot"))
