#import "@local/modern-cug-report:0.1.3": *
#show: doc => template(doc, footer: "水文气象学", header: "")

= R 包实战：从模板到 CI

== 1 四步流程

+ 克隆模板：`git clone https://github.com/rpkgs/rpkg.template`，VS Code 打开并点 **Trust**；
+ 加函数：把 `RHtests/R/Component.R` 粘进 `R/`，对外函数补 `#' @export`；
+ 写文档与测试：`#' ` 注释 → `devtools::document()`；`docs/*.typ` 手写；`tests/testthat/test-*.R` 写断言；
+ 推送看结果：`git push` 后在仓库 **Actions** 看 `R-CMD-check`，约 2--3 分钟起步。

== 2 关键命令

```r
devtools::document()   # 生成 man/ 与 NAMESPACE，不要手改 NAMESPACE
devtools::test()       # 本地跑 testthat
devtools::check()      # 与云端 R CMD check 等价
```

```powershell
git config user.name "luo123-123"; git config user.email "2050938619@qq.com"
git remote set-url origin https://github.com/luo123-123/zuoye.git
git add .; git commit -m "add functions, docs and tests"; git push -u origin master
```

== 3 容易踩的坑

#table(
  columns: (auto, 1fr, 1fr),
  align: (left, left, left),
  [现象], [原因], [处理],
  [Restricted Mode，扩展与终端受限], [文件夹未信任], [点 Trust],
  [`devtools` / `testthat` 提示没装], [只装了 R 本体], [装开发包，或先手写 `.Rd` 做轻量校验],
  [`checkRd`: Lost braces in itemize], [`\value` 里套了 `\itemize{\item{a}{b}}`], [`\value` 内直接写 `\item{a}{b}`],
  [`checkRd`: Non-ASCII without encoding], [中文没声明编码], [`.Rd` 第二行加 `\encoding{UTF-8}`],
  [测试意外失败], [`tapply()` 带 `dimnames`，`expect_equal` 连属性一起比], [`as.numeric()` 去属性],
  [`push` 报 handshake / connect 失败], [schannel 后端或代理未开], [`http.sslBackend openssl`，保证 Clash Verge 在 `127.0.0.1:7897` 运行],
)

== 4 交付前自检

+ `devtools::document()` 跑过，`NAMESPACE` 有 `export()`，`man/*.Rd` 无告警；
+ 测试只断言导出函数的返回值，本地 `devtools::test()` 全绿；
+ `git remote -v` 指向自己的仓库，推送后 `R-CMD-check` 是绿勾。
