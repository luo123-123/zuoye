test_that("RemoveSeasonal 正确扣除季节均值并返回距平", {
  y <- c(1, 3, 2, 4)
  t_mmdd <- c("0101", "0101", "0102", "0102")
  res <- RemoveSeasonal(y, t_mmdd)

  expect_equal(res$mu, c(2, 3))
  expect_equal(res$anomaly, c(-1, 1, -1, 1))
  # 距平按同一月日求和应为 0
  expect_equal(tapply(res$anomaly, t_mmdd, sum), c(0, 0))
})

test_that("LS_OneBreak 对两段截距突变数据拟合残差为 0", {
  n <- 20
  X <- 1:n
  Ic <- 10
  Y <- X + c(rep(0, Ic), rep(5, n - Ic))

  res <- LS_OneBreak(Y, X, Ic)
  expect_equal(length(res$coef), 3)
  expect_equal(res$SSE, 0, tolerance = 1e-8)
  expect_equal(length(res$fitted), n)
  expect_equal(length(res$resi), n)
})

test_that("LS_OneBreak 在 Ic = NA 时退化为一元线性回归", {
  n <- 20
  X <- 1:n
  Y <- 2 * X + 1
  res <- LS_OneBreak(Y, X, Ic = NA)

  expect_equal(length(res$coef), 2)
  expect_equal(res$SSE, 0, tolerance = 1e-8)
})

test_that("LS_MultiBreaks 多段拟合返回正确系数长度且残差为 0", {
  n <- 20
  X <- 1:n
  Ips <- c(0, 10, 20)
  Y <- X + c(rep(0, 10), rep(5, 10))

  res <- LS_MultiBreaks(Y, X, Ips)
  # 截距 + 斜率 + 两个分段截距
  expect_equal(length(res$coef), 4)
  expect_equal(res$SSE, 0, tolerance = 1e-8)
})
