import sys
import os
import html
import unicodedata
from typing import List, Tuple

def is_cjk(char):
    """
    检查字符是否是中日韩文字或标点符号
    
    东亚字符宽度标记:
    - W: 宽字符 (如汉字)
    - F: 全角字符
    - A: 歧义字符 (部分中文标点)
    """
    east_asian_width = unicodedata.east_asian_width(char)
    return east_asian_width in ('W', 'F', 'A')
    
def is_cjk_punct(char):
    """检查字符是否是中文标点符号"""
    # 常见中文标点符号的Unicode范围
    cjk_punct_ranges = [
        (0x3000, 0x303F),  # CJK标点符号
        (0xFF00, 0xFFEF),  # 全角ASCII、全角标点
    ]
    
    code = ord(char)
    return any(start <= code <= end for start, end in cjk_punct_ranges)

def calculate_width(text: str) -> int:
    """
    根据文本内容计算矩形宽度
    
    Args:
        text: 要计算宽度的文本
    
    Returns:
        像素宽度
    """
    if len(text) <= 1:
        return 40
    
    # 计算中文字符和中文标点符号数量
    cjk_count = sum(1 for char in text if is_cjk(char) or is_cjk_punct(char))
    latin_count = len(text) - cjk_count
    
    # 根据示例近似计算宽度
    width = cjk_count * 26 + latin_count * 9.5
    
    # 添加内边距
    padding = 12
    return width + padding

def generate_svg(filename: str, texts: List[str]) -> str:
    """
    生成带有交替颜色圆角矩形的SVG图像
    
    Args:
        filename: 保存SVG的文件名
        texts: 要在矩形中显示的文本列表
    
    Returns:
        SVG内容字符串
    """
    # 固定参数
    rect_height = 40
    y_pos = 10
    
    # 根据文本长度计算每个矩形的宽度
    rect_widths = [calculate_width(text) for text in texts]
    
    # 初始化位置
    positions = []
    current_x = 10
    
    for width in rect_widths:
        positions.append(current_x)
        current_x += width + 5  # 矩形之间5px间距
    
    # 计算SVG总宽度
    total_width = positions[-1] + rect_widths[-1] + 10
    
    # 创建SVG
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {total_width} 60" width="{total_width}" height="60">'
    svg += f'<path fill="none" d="M0 0h{total_width}v60H0z"/>'
    
    # 添加矩形和文本
    for i, (text, x_pos, width) in enumerate(zip(texts, positions, rect_widths)):
        # 转义文本中的特殊字符
        escaped_text = html.escape(text)
        
        # 交替颜色
        fill_color = "#ffec99" if i % 2 == 0 else "#a5d8ff"
        
        # 添加矩形
        svg += f'<rect x="{x_pos}" y="{y_pos}" width="{width}" height="{rect_height}" rx="10" ry="10" '
        svg += f'fill="{fill_color}" stroke="#000" stroke-width="1.5"/>'
        
        # 添加文本
        text_x = x_pos + width / 2
        text_y = y_pos + rect_height / 2 + 7.5  # 垂直居中（近似值）
        svg += f'<text x="{text_x}" y="{text_y}" font-family="Arial, sans-serif" font-size="20" text-anchor="middle">{escaped_text}</text>'
    
    # 关闭SVG
    svg += '</svg>'
    
    return svg

def parse_input(input_str: str) -> Tuple[str, List[str]]:
    """
    解析格式为：filename|text1|text2|...|textN 的输入字符串
    
    Args:
        input_str: 按要求格式的输入字符串
    
    Returns:
        (filename, [text1, text2, ..., textN]) 元组
    """
    parts = input_str.strip().split('|')
    if len(parts) < 2:
        raise ValueError("输入必须至少包含一个文件名和一个文本元素，用'|'分隔")
    
    filename = parts[0]
    texts = parts[1:]
    
    return filename, texts

def main():
    """处理输入并生成SVG的主函数"""
    print("SVG 生成器工具")
    print("==============")
    print("此工具生成带有交替颜色圆角矩形的SVG图像。")
    print("输入格式: 文件名|文本1|文本2|...|文本N")
    print("示例: output|你好|我今天能怎么帮助你|1+1等于几|2")
    print()
    
    if len(sys.argv) > 1:
        # 从命令行参数获取输入
        input_str = sys.argv[1]
    else:
        # 从标准输入获取输入
        print("请按格式输入: 文件名|文本1|文本2|...|文本N")
        input_str = input().strip()
    
    try:
        filename, texts = parse_input(input_str)
        svg_content = generate_svg(filename, texts)
        
        # 如果没有.svg扩展名，添加它
        if not filename.lower().endswith('.svg'):
            filename += '.svg'
        
        # 保存到文件
        with open(filename, 'w', encoding='utf-8') as f:
            f.write(svg_content)
        
        print(f"SVG图像已保存到 {filename}")
        
    except Exception as e:
        print(f"错误: {e}")
        print("请检查输入格式并重试。")

if __name__ == "__main__":
    main()