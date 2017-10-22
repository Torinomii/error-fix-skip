ethtool ethX //查詢ethX網口基本設置
ethtool –h //顯示ethtool的命令幫助(help)
ethtool –i ethX //查詢ethX網口的相關信息
ethtool –d ethX //查詢ethX網口註冊性信息
ethtool –r ethX //重置ethX網口到自適應模式
ethtool –S ethX //查詢ethX網口收發包統計
ethtool –s ethX [speed 10|100|1000]\ //設置網口速率10/100/1000M