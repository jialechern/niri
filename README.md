# niri
## 初始化配置
`config.py` 脚本会创建针对本地特殊机器特殊配置的脚本, 使用前请务必运行它.
## 本地机器的特殊配置
本地机器的特殊配置应当放置于 `conf.d/local-override.d/` 下, 且命名格式为 `local-*.kdl`, 创建完成后需要及时的使用相对路径倒入到 `conf.d/local-override.kdl` 中再完成后续编辑.
