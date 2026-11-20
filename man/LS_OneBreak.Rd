% Manual Rd (本地无 R 环境生成；有 R 后可用 devtools::document() 覆盖)
\name{LS_OneBreak}
\alias{LS_OneBreak}
\title{单断点分段回归（斜率相同，截距不同）}
\usage{
LS_OneBreak(Y, X, Ic, ...)
}
\arguments{
\item{Y}{响应值（观测序列）}
\item{X}{自变量（通常为时间序列）}
\item{Ic}{断点位置：\code{[1, Ic]} 与 \code{[Ic + 1, end]} 分别对应两段；
若为 \code{NA}，则不加入分段截距项}
\item{...}{传给内部求解函数}
}
\value{
一个 list：
\item{coef}{系数}
\item{fitted}{拟合值}
\item{resi}{残差}
\item{SSE}{误差平方和}
}
\description{
在斜率不变的前提下，允许断点前后截距不同。若 \code{Ic = NA}，
则退化为普通一元线性回归。
}
\examples{
n <- 20
X <- 1:n
Ic <- 10
Y <- X + c(rep(0, Ic), rep(5, n - Ic))
LS_OneBreak(Y, X, Ic)
}
