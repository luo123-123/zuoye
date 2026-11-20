% Manual Rd (本地无 R 环境生成；有 R 后可用 devtools::document() 覆盖)
\name{RemoveSeasonal}
\alias{RemoveSeasonal}
\title{去除季节气候态，返回季节均值与距平序列}
\usage{
RemoveSeasonal(y, t_mmdd)
}
\arguments{
\item{y}{观测值向量}
\item{t_mmdd}{与 \code{y} 对应的月日（MMDD）字符向量}
}
\value{
一个 list：
\item{mu}{按月日升序排列的季节均值}
\item{anomaly}{去季节序列（距平）}
}
\description{
按月日分组求气候态均值，再从原序列中扣除，得到距平序列。
}
\examples{
y <- c(1, 3, 2, 4)
t_mmdd <- c("0101", "0101", "0102", "0102")
RemoveSeasonal(y, t_mmdd)
}
