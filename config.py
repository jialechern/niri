#!/usr/bin/env python3
from pathlib import Path
from enum import Enum, auto
from dataclasses import dataclass


CWD: Path = Path(__file__).parent


class Type(Enum):
    FILE = auto()
    DIRECTORY = auto()


@dataclass
class RequireObj:
    type: Type
    path: Path


# 注意创建的先后顺序, 在创建文件时需要保证其父文件夹已经存在
require_files: list[RequireObj] = [
    RequireObj(type=Type.FILE, path=CWD/"conf.d/local-override.kdl"),
]


def local_require_object_preload(file: Path, preload_content: str) -> None:
    if (not file.exists()) or file.stat().st_size == 0:
        file.write_text(preload_content, encoding="utf-8")


def main() -> None:
    for item in require_files:
        match item.type:
            case Type.FILE:
                item.path.touch(exist_ok=True)
            case Type.DIRECTORY:
                item.path.mkdir(parents=True, exist_ok=True)

    local_require_object_preload(
        file=CWD/"conf.d/local-override.kdl",
        preload_content="""// local-override.kdl
// 此处存放特定机器的特殊配置


// --- --- --- 额外显示器配置 --- --- ---
// 显示器配置模板
/-output "eDP-1" {
    // 取消注释此行以禁用此输出
    // off

    // 输出的分辨率和可选刷新率
    // 格式为 "<宽度>x<高度>" 或 "<宽度>x<高度>@<刷新率>"
    // 如果省略刷新率，niri 将为此分辨率选择最高刷新率
    // 如果完全省略模式或模式无效，niri 将自动选择一个
    // 在 niri 实例中运行 `niri msg outputs` 以列出所有输出及其模式
    mode "1920x1080@120.030"

    // 可使用整数或小数缩放，例如使用 1.5 表示 150% 缩放
    scale 2

    // 变换允许逆时针旋转输出，有效值为：
    // normal, 90, 180, 270, flipped, flipped-90, flipped-180 and flipped-270.
    transform "normal"

    // 输出在全局坐标空间中的位置
    // 这会影响方向性显示器操作，如 "focus-monitor-left" 和光标移动
    // 光标只能在直接相邻的输出之间移动
    // 定位时必须考虑输出缩放和旋转：
    // 输出大小以逻辑（或缩放后的）像素为单位
    // 例如，3840×2160 输出，缩放 2.0 将具有 1920×1080 的逻辑大小，
    // 因此要在其右侧直接放置另一个输出，将其 x 设置为 1920
    // 如果未设置位置或导致重叠，输出将自动放置
    position x=1280 y=0
}

// 影响窗口定位和大小的设置
// 更多信息请查阅维基：
// https://yalter.github.io/niri/Configuration:-Layout

""")


if __name__ == '__main__':
    main()
