#import "@local/modern-cug-report:0.1.3": *
#show: doc => template(doc, footer: "水文气象学", header: "")

= 1 去季节距平：RemoveSeasonal

`RemoveSeasonal` 按月日气候态对观测序列做去季节化，先按月日分组求均值，
再从原序列中扣除对应气候态：

$ anomaly_i = y_i - mu(t_i) $

其中 $mu(t)$ 为同一月日所有观测的均值，`NA` 在求均值时被忽略。

== 参数

- `y`：观测值向量。
- `t_mmdd`：与 `y` 对应的月日（MMDD）字符向量。

== 返回

- `mu`：按月日升序排列的季节均值。
- `anomaly`：去季节距平序列。

== 示例

```R
y <- c(1, 3, 2, 4)
t_mmdd <- c("0101", "0101", "0102", "0102")
RemoveSeasonal(y, t_mmdd)
#> $mu
#> [1] 2 3
#>
#> $anomaly
#> [1] -1  1 -1  1
```

= 2 单断点分段回归：LS_OneBreak

在斜率不变的前提下，允许断点 $I_c$ 前后截距不同，模型写作：

$ Y_i = beta_0 + beta_1 X_i + beta_2 * 1(i > I_c) + epsilon_i $

其中示性函数在断点之后取 1、之前取 0。若 `Ic = NA`，则不加分段项，
退化为普通一元线性回归。

== 参数

- `Y`：响应值（观测序列）。
- `X`：自变量（通常为时间序列）。
- `Ic`：断点位置，`[1, Ic]` 与 `[Ic + 1, end]` 分别对应两段。

== 返回

`coef`（系数）、`fitted`（拟合值）、`resi`（残差）与 `SSE`（误差平方和）。

== 示例

```R
n <- 20
X <- 1:n
Ic <- 10
Y <- X + c(rep(0, Ic), rep(5, n - Ic))
LS_OneBreak(Y, X, Ic)
```

= 3 多断点分段回归：LS_MultiBreaks

`LS_MultiBreaks` 是单断点情形的推广。`Ips` 给出各段末尾位置，末位为
序列长度；每一段对应一个截距项，斜率保持相同。

== 参数

- `Y`：响应值（观测序列）。
- `X`：自变量（通常为时间序列）。
- `Ips`：各段末尾的位置，末位为序列长度。

== 示例

```R
n <- 20
X <- 1:n
Ips <- c(0, 10, 20)
Y <- X + c(rep(0, 10), rep(5, 10))
LS_MultiBreaks(Y, X, Ips)
```
