
# UnicodeSparklines

Generate [sparkline](https://en.wikipedia.org/wiki/Sparkline) plots in R
with [Unicode character symbols](https://en.wikipedia.org/wiki/Unicode).
▁▂▃▄▅▆▇█▇▆▅▄▃▂▁

Output might look weird in certain fonts, or if your terminal/IDE has
wonky UTF-8 output.

# Installation

``` r
remotes::install_github("log-linear/UnicodeSparklines")
```

# Usage

``` r
library(UnicodeSparklines)
test <- c(1.5, 0.5, 3.5, 2.5, 5.5, 4.5, 7.5, 6.5)
sparkline(test)
```

    ## [1] "▂▁▄▃▆▅█▇"

``` r
sparkline_bar(test)
```

    ## [1] "▂▁▄▃▆▅█▇"

``` r
sparkline(test, chart = "line")
```

    ## [1] "🭻__🭹🭺🭷🭸⎺🭶"

``` r
sparkline_tally(test)
```

    ## [1] "𝍠𝍠𝍢𝍡𝍣𝍢𝍤𝍤"

``` r
sparkline_line(test)
```

    ## [1] "🭻__🭹🭺🭷🭸⎺🭶"

``` r
sparkline_area(test)
```

    ## [1] "︭🭈🬭🭆🬹🭂🮋"

``` r
sparkline_dot(test)
```

    ## [1] "⣀⡠⠤⠔⠒⠊⠉"
