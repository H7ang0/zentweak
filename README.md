# ZenPopup · iOS弹窗插件

[![iOS 13+](https://img.shields.io/badge/iOS-13%2B-blue)](https://www.apple.com/ios)
[![License MIT](https://img.shields.io/badge/License-MIT-green)](LICENSE)
[![Telegram群组](https://img.shields.io/badge/Telegram-交流群组-blue)](https://t.me/HyanguChat)

**ZenPopup** 是一款轻量级iOS越狱插件，在设备启动后显示状态栏下方的优雅提示弹窗。支持有根(rootful)和无根(rootless)越狱环境，自动适配不同iOS版本和设备类型。

![弹窗效果演示](https://via.placeholder.com/400x250.png?text=ZenPopup+Demo+Preview)

## 目录
- [功能特性](#功能特性)
- [安装方法](#安装方法)
- [配置说明](#配置说明)
- [开发交流](#开发交流)
- [项目结构](#项目结构)
- [参与贡献](#参与贡献)
- [开源协议](#开源协议)

## 功能特性
- **智能定位**：自动计算状态栏高度，完美适配刘海屏/传统屏
- **视觉优化**：
  - 半透明磨砂玻璃效果
  - 顶部动态圆角（iOS 11+）
  - 平滑缩放动画
- **环境适配**：
  - 支持iOS 13+
  - 兼容rootful/rootless越狱
  - 多窗口场景识别
- **即时交互**：点击关闭按钮立即消失

### 从源码编译
bash
git clone https://github.com/H7ang0/zzentweak.git
cd ZenPopup
编译有根版本
make clean && make package
编译无根版本
make clean && make package ROOTLESS=1
## 配置说明
修改`TWEAK/Tweak.x`中的常量值：
objective-c
#define ALERT_WIDTH 300 // 弹窗宽度（单位：pt）
#define ALERT_HEIGHT 160 // 弹窗高度
#define TOP_MARGIN 20 // 状态栏下方间距
#define SHOW_DELAY 2 // 显示延迟（秒）

## 开发交流
遇到问题或有改进建议？立即加入Telegram群组：

[![Telegram群组](https://img.shields.io/badge/-点击加入-blue?logo=telegram)](https://t.me/HyanguChat)  
**群组信息**：
- 名称：函数诗的插件工坊
- 成员：13人（持续增长中）
- 功能：安装支持/开发讨论/越狱资讯


## 参与贡献
欢迎通过以下方式参与项目：
1. 提交Issue报告问题或建议
2. Fork项目并创建功能分支
3. 发起Pull Request并描述变更
4. 遵循现有代码风格

## 开源协议
本项目采用 [MIT License](LICENSE) 授权，您可以：
- 自由使用、修改和分发代码
- 用于商业或私人项目
- 需保留原始许可证声明

---
**开发者**：  
[H7ang0](https://t.me/H7ang0) & [窦窦] · 2025
