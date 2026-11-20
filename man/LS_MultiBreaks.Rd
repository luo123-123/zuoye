% Manual Rd (本地无 roxygen2，手写；装好 devtools 后可 devtools::document() 覆盖)
\encoding{UTF-8}
\name{LS_MultiBreaks}
\alias{LS_MultiBreaks}
\title{多断点分段回归（斜率相同，截距不同）}
\usage{
LS_MultiBreaks(Y, X, Ips, ...)
}
\arguments{
\item{Y}{响应值（观测序列）。}

\item{X}{自变量（通常为时间序列）。}

\item{Ips}{各段末尾的位置，末位为序列长度。}

\item{...}{传给内部求解函数。}
}
\value{
\item{coef}{系数。}

\item{fitted}{拟合值。}

\item{resi}{残差。}

\item{SSE}{误差平方和。}
}
\description{
单断点情形的推广，每一段对应一个截距项，斜率保持相同。
}
\examples{
n <- 20
X <- 1:n
Ips <- c(0, 10, 20)
Y <- X + c(rep(0, 10), rep(5, 10))
LS_MultiBreaks(Y, X, Ips)
}
