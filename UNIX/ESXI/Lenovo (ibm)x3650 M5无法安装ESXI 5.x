Lenovo (ibm)x3650 M5无法安装ESXI 5.x
提示Failed  to  resolve  circular  relocation或
System Halted: Fatal  Error  Handling类似错误

【回避策】
Unified Extensible Firmware Interface (uEFI) において、以下 2 つの設定を行うことで、正しくインストールが完了します。
1. [System Settings] -> [Devices and I/O Ports] -> [PCI 64-Bit Resource Allocation] を選択して、Disabled に変更します。
2. [System Settings] -> [Devices and I/O Ports] -> [MM Config] を選択して、3GB に変更します。

相关文档Info_SW_VMware_tips_H213638.pdf