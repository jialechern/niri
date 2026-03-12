# Niri
## 使用
- 在使用前需要在 `conf.d/local-override.kdl` 中配置好显示器型号, 具体配置模板可以参照 `conf.d/output.kdl` 或是 `conf.d/local-override.kdl`, 显示器信息可以通过命令 `niri msg outputs` 显示.
## 注意事项
- 配置文件嵌套: niri 对配置文件的解析不深, 不能使用 `*.d` 配置片段进行嵌套配置. 等价的说, 不能在 `conf.d` 下的文件中再次使用 `include <path>` 节点.
- 配置初始化: `config.py` 脚本会创建针对本地特殊机器特殊配置的脚本, 使用前请务必运行它.
- 本地机器的特殊配置: 本地机器的特殊配置应当放置于 `conf.d/local-override.kdl` 中.
