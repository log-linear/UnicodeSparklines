devtools::load_all()

# Test sparkline() function
test1 <- c(1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1)
sparkline(test1)
sparkline(test1, return_range = T)
sparkline(test1, symbols = "lines")

test2 <- c(1.5, 0.5, 3.5, 2.5, 5.5, 4.5, 7.5, 6.5)
sparkline(test2)
sparkline(test2, symbols = "lines")

test3 <- c(0, 0, 1, 1)
sparkline(test3)
sparkline(test3, symbols = "lines")

test4 <- c(0, 1, 19, 20)
sparkline(test4)
