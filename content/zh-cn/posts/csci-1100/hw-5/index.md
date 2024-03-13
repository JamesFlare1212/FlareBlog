---
title: CSCI 1100 - 作业5 - 嵌套列表、网格和路径规划
subtitle:
date: 2024-03-13T15:36:47-04:00
slug: csci-1100-hw-5
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 本文概述了 CSCI 1100 计算机科学导论课程中一项关于使用 Python 进行嵌套列表、网格和路径规划的编程作业。文章包括每个部分的问题描述、指导方针和示例输出。
keywords: ["Python","计算机科学","列表","网格","路径规划"]
license:
comment: true
weight: 0
tags:
  - CSCI 1100
  - 作业
  - RPI
  - Python
  - 编程
categories:
  - 编程语言
collections:
  - CSCI 1100
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: 本文概述了 CSCI 1100 计算机科学导论课程中一项关于使用 Python 进行嵌套列表、网格和路径规划的编程作业。文章包括每个部分的问题描述、指导方针和示例输出。
resources:
  - name: featured-image
    src: featured-image.jpg
  - name: featured-image-preview
    src: featured-image-preview.jpg
toc: true
math: false
lightgallery: false
password:
message:
repost:
  enable: true
  url:

# 有关详细信息，请参阅前言：https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## 作业概述

本次作业总分值 100 分，将计入你的总作业成绩。截止日期为 2024 年 2 月 29 日星期四晚上 11:59:59。和往常一样，作业评分由自动评分、讲师测试用例和助教评分三部分组成。作业分为两个部分，需分别提交。两部分都应在截止日期前提交，否则将被视为逾期。

关于评分标准和过度合作的定义，请参阅提交指南和合作政策。这些规则将在本学期剩余时间内执行。

你将需要我们在 `hw5_files.zip` 中提供的数据文件，请务必从 Submitty 的课程资料部分下载并解压到你的作业 5 目录。压缩包内包含实用代码、数据文件以及程序的示例输入/输出。

## 问题描述

计算机科学和工程领域的许多问题都是在二维数值网格上求解的，常用技术包括"梯度上升（或下降）"、贪心搜索或爬山算法。我们将使用手工生成的高程数据来研究其简化版本。

我们主要使用的表示方法是"高度"（也称"海拔"，这里简称"高度"）的嵌套列表。例如：

```python
grid = [[15, 16, 18, 19, 12, 11],
        [13, 19, 23, 21, 16, 12],
        [12, 15, 17, 19, 22, 10],
        [10, 14, 16, 13, 9, 6]]
```

这个网格包含四个长度为六的整数列表。每个元素表示一个高度值，如海拔高度，以固定间隔测量，间隔可小至厘米，也可大至公里。美国地质调查局（USGS）和一些私营公司都在维护和分发此类高程数据。这些数据在评估径流、确定风力涡轮机位置以及规划道路和建设等方面都很重要。我们将以规划徒步路线为例来研究这个问题。

对于这些数据，我们可能会问以下问题：

1. 最高点（最大高度）在哪里？这也称为"全局最大值"，因为它是数据中的最大值。在上例中，最大高度为 23，出现在第 1 行第 2 列（简写为 (1, 2)，假设第一个值表示行，第二个值表示列）。我们称 (1, 2) 为一个"位置"。
2. 数据中是否存在"局部最大值"？即高度大于周围值但小于全局最大值的点。在上例中，位置 (2, 4) 处的 22 就是一个局部最大值。
3. 从给定位置出发，到达全局最大值的最佳路径是什么？这是一个棘手的问题，因为我们需要定义"最佳路径"。一个简单的定义是：能否从给定位置出发，只走最陡的路线到达全局最大值（是否能徒步到"山顶"）？例如，从 (3, 0) 出发，经过 (3, 0)、(3, 1)、(3, 2)、(2, 2)、(1, 2) 的路径是最陡的，可以到达顶峰。这是一种"梯度上升"方法。但如果从 (3, 5) 出发，会生成路径 (3, 5)、(3, 4)、(2, 4)，之后就无法继续向上到达全局最大值。

我们还可以提出并回答更多问题。有些问题很容易解决，有些则需要复杂的算法和大量计算。

在开始实际作业之前，我们需要定义网格中"相邻"位置的概念，即从给定位置允许走到的位置。在本作业中，从位置 (r, c) 出发，相邻位置包括 (r-1, c)、(r, c-1)、(r, c+1) 和 (r+1, c)。

换句话说，相邻位置必须与当前位置在同一行或同一列。此外，相邻位置不能超出网格边界。例如，对于位置 (r, 0)，只有 (r-1, 0)、(r, 1)、(r+1, 0) 是允许的相邻位置。

## 入门指南

请下载 `hw5_files.zip` 并将所有文件放在你要编写解决方案的同一目录下。`hw5_util.py` 和 `hw5_grids.txt` 这两个文件非常重要：`hw5_util.py` 包含从 `hw5_grids.txt` 读取网格和起始位置的实用函数。具体来说：

- `hw5_util.num_grids()` 返回数据中不同网格的数量。
- `hw5_util.get_grid(n)` 返回第 n 个网格，其中 n==1 表示第一个网格，n == `hw5_util.num_grids()` 表示最后一个网格。
- `hw5_util.get_start_locations(n)` 返回一个元组列表，给出第 n 个网格要考虑的一个或多个起始位置。
- `hw5_util.get_path(n)` 返回一个元组列表，给出第 n 个网格的一条可能路径。

建议你先试用这些函数并打印结果，以确保你理解它们的功能。

你可以对数据做如下假设：

1. 网格至少有两行。
2. 每行至少有两个元素（列），且每行的列数相同。
3. 所有高度值都是正整数。
4. 起始位置都在网格的行列范围内。
5. 路径上的位置都在网格的行列范围内。

## 第一部分

编写一个 Python 程序 `hw5_part1.py`，完成以下任务：

1. 询问用户要使用的网格编号，并循环询问直到得到正确范围内的编号。将网格编号记为 n。
2. 获取第 n 个网格。
3. 询问用户是否要打印网格。如果用户输入单个字符 'Y' 或 'y'，则打印网格，否则不打印。打印时可假设高度值小于 1000 米。参考示例输出。
4. 获取与第 n 个网格关联的起始位置，对于每个起始位置，打印其在网格边界内的相邻位置。例如，如果第 n 个网格有 8 行 10 列，起始位置列表为 `[(4, 6), (0, 3), (7, 9)]`，则输出应为：

	```plaintext
	Neighbors of (4, 6): (3, 6) (4, 5) (4, 7) (5, 6)
	Neighbors of (0, 3): (0, 2) (0, 4) (1, 3)
	Neighbors of (7, 9): (6, 9) (7, 8)
	```

	非常重要：我们强烈建议你编写一个名为 `get_nbrs` 的函数，它接受行、列位置以及网格的行数和列数作为参数，返回一个元组列表，包含给定位置在网格边界内的所有相邻位置。你会经常用到这个函数。

5. 获取建议路径，判断它是否有效（每个位置都与下一个位置相邻），然后计算总下降高度和总上升高度。例如，对于上面的网格，如果路径为 `(3, 1), (3, 0), (2, 0), (1, 0), (1, 1), (0, 1), (0, 2), (1, 2)`，则下降高度为从 (3, 1) 到 (3, 0)（变化 4）和从 (1, 1) 到 (0, 1)（变化 3），总计 7；上升高度为从 (3, 0) 到 (2, 0)、从 (2, 0) 到 (1, 0)、从 (1, 0) 到 (1, 1)、从 (0, 1) 到 (0, 2) 以及从 (0, 2) 到 (1, 2)，总计 (2 + 1 + 6 + 2 + 5) = 16。输出应为：

```plaintext
有效路径
下降 7
上升 16
```

如果路径无效，代码应输出 `路径：从 point1 到 point2 的无效步骤。` 其中 point1 和 point2 是表示无效步骤起点和终点的元组。

只提交文件 `hw5_part1.py`，不要提交其他任何内容。

## 第二部分

修改第一部分的解决方案，并将其提交为 `hw5_part2.py`。程序应再次要求用户输入网格编号，但不应打印网格。接下来，它应找到并输出全局最大高度的位置和高度值。例如，对于上面的简单网格，输出应为 `全局最大值：(1, 2) 23`。你可以不加验证地假设全局最大值是唯一的。

第二部分的主要任务是为网格的每个起始位置找到并输出两条路径。第一条是最陡峭的上升路径，第二条是最平缓的上升路径。每条路径上的步骤必须在相邻位置之间，与第一部分相同。此外，在每条路径上，不允许走到高度相同或更低的位置，并且步长（新位置与当前位置的高度差）不能超过最大步高（由用户输入）。

接下来，确定每条路径是到达了网格中全局最大高度的位置、局部最大值还是都不是。如果当前位置的唯一上升步骤相对于当前高度太高，就可能出现后一种情况。当然，真正的徒步路径可以上下起伏，但在这种更复杂的情况下寻找"最优路径"需要我们尚未准备好开发的更复杂算法。

以上面的网格为例：

```python
grid = [[15, 16, 18, 19, 12, 11],
        [13, 19, 23, 21, 16, 12],
        [12, 15, 17, 19, 20, 10],
        [10, 14, 16, 13, 9, 6]]
```

从位置 (3, 0) 出发，最大步高为 4，最陡峭的路径是 (3, 0)、(3, 1)、(3, 2)、(2, 2)、(2, 3)、(1, 3)、(1, 2)，最平缓的路径是 (3, 0)、(2, 0)、(1, 0)、(0, 0)、(0, 1)、(0, 2)、(0, 3)、(1, 3)、(1, 2)。两条路径都到达了全局最大值，并且在第一次接近时都避免了直接走到全局最大值，因为步高太大。注意，从位置 (3, 5) 出发的最陡峭和最平缓路径都将在局部最大值 (2, 4) 处结束。最陡峭的路径将在 4 步后结束（路径上有 5 个位置），最平缓的路径将在 6 步后结束（路径上有 7 个位置）。如果最大步高只有 3，那么从 (3, 5) 出发的两条路径都将在到达任何最大值之前的位置 (3, 4) 处停止。

路径输出时每行 5 个位置，例如：

```plaintext
steepest path
(3, 0) (2, 0) (1, 0) (0, 0) (0, 1)
(0, 2) (0, 3) (1, 3) (1, 2)
global maximum
```

更多细节请参考示例输出。

最后，如果用户请求，输出一个"路径网格"，在每个位置给出包含该位置的路径数量。这可以通过创建一个新的嵌套列表来处理，其中每个元素表示一个计数，初始化为 0。对于每条路径和路径上的每个位置 (i, j)，应增加嵌套列表中相应的计数。最后，在生成所有路径并将其添加到计数后，输出网格。在此输出中，对于不在任何路径上的位置，不要输出 0，而是输出 '.'，这将使输出更清晰。请参阅示例输出。

## 注意事项

1. 在选择路径的下一个位置时，如果有多个选择，则选择 `get_nbrs` 函数生成的列表中较早出现的位置。例如，在上面的示例网格中，从高度为 11 的位置 (0, 5) 出发，(0, 4) 和 (1, 5) 的高度都是 12。在这种情况下，(0, 4) 将在 `get_nbrs` 列表中较早出现，因此被选为路径上的下一个位置。
2. 在确保其他所有内容都正常工作之前，请不要处理路径网格输出（最后一步）。
3. 最平缓和最陡峭的路径都是贪心算法的示例，其中在每一步都做出当前最优选择，而不重新考虑之前的决定。更复杂的算法会考虑某种形式的回溯，即撤销决策并重新考虑替代方案。

## 支持文件

{{< link href="HW5.zip" content="HW5.zip" title="下载 HW5.zip" download="HW5.zip" card=true >}}

## 参考答案

### hw5_part1.py

```python
import hw5_util

def show_grid(grid):
    """ Display the grid in a human-readable format. """
    display = ""
    for row in grid:
        for cell in row:
            display += "  {:2d}".format(int(cell))
        display += "\n"
    print(display, end="")

def find_grid_size(grid):
    """ Find the size of the grid. """
    return (len(grid), len(grid[0]))

def find_neighbors(point, grid):
    """ Find the neighbors of a point in the grid. """
    neighbors = []
    y, x = point
    max_y, max_x = find_grid_size(grid)
    neighbors.append((y-1, x)) if y-1 >= 0 else None
    neighbors.append((y, x-1)) if x-1 >= 0 else None
    neighbors.append((y, x+1)) if x+1 < max_x else None
    neighbors.append((y+1, x)) if y+1 < max_y else None
    neighbors.append((y-1, x-1)) if y-1 >= 0 and x-1 >= 0 else None
    neighbors.append((y-1, x+1)) if y-1 >= 0 and x+1 < max_x else None
    neighbors.append((y+1, x-1)) if y+1 < max_y and x-1 >= 0 else None
    neighbors.append((y+1, x+1)) if y+1 < max_y and x+1 < max_x else None
    return neighbors

def show_neighbors(start_locations, grid):
    """ Display the neighbors of the start locations."""
    for i in start_locations:
        neighbors = ""
        for j in find_neighbors(i, grid):
            neighbors += str(j) + " "
        neighbors = neighbors.strip()
        print("Neighbors of {}: {}".format(i, neighbors))

def path_validator(path, grid):
    """ Validate the path. """
    result = (True, "Valid path")
    for i in range(1, len(path)):
        if path[i] not in find_neighbors(path[i-1], grid):
            result = (False, "Path: invalid step from {} to {}".format(path[i-1], path[i]))
            break
    return result

def movement_status(path, grid):
    """ Determine the movement status of the path. """
    downward = 0
    upward = 0
    for i in range(1, len(path)):
        change = grid[path[i][0]][path[i][1]] - grid[path[i-1][0]][path[i-1][1]]
        if change > 0:
            upward += change
        elif change < 0:
            downward += change
    return (downward, upward)
    

if __name__ == "__main__":
    grid_index = input("Enter a grid index less than or equal to 3 (0 to end): ").strip()
    #grid_index = 1 # Debugging
    print(grid_index)
    grid_index = int(grid_index)
    grid = hw5_util.get_grid(int(grid_index))
    #print(grid) # Debugging
    """
    grid = [[15, 16, 18, 19, 12, 11],\
            [13, 19, 23, 21, 16, 12],\
            [12, 15, 17, 19, 20, 10],\
            [10, 14, 16, 13, 9, 6]]
    """
    
    print_gride = input("Should the grid be printed (Y or N): ").strip()
    #print_gride = "Y" # Debugging
    print(print_gride)
    if print_gride.upper() == "Y":
        print("Grid {}".format(grid_index))
        show_grid(grid)
    
    print("Grid has {} rows and {} columns".format(find_grid_size(grid)[0], find_grid_size(grid)[1]))
    
    start_locations = hw5_util.get_start_locations(grid_index)
    """start_locations = [(3, 3), (3, 0), (3, 5), (0, 2)]"""
    show_neighbors(start_locations, grid)
    """find_neighbors((3, 3), grid) = [(2, 3), (3, 2), (3, 4)]"""
    
    suggested_path = hw5_util.get_path(grid_index)
    #print("Suggested path: ", suggested_path) # Debugging
    """Suggested path:  [(3, 1), (3, 0), (2, 0), (1, 0), (1, 1), (0, 1), (0, 2), (1, 2)]"""
    print(path_validator(suggested_path, grid)[1])
    """
    (True, 'Valid path')
    (False, 'Path: invalid step from (2, 4) to (3, 3)')
    """
    
    if path_validator(suggested_path, grid)[0]:
        downward, upward = movement_status(suggested_path, grid)
        downward = abs(downward)
        print("Downward {}\nUpward {}".format(downward, upward))
```

### hw5_part2.py

```python
import hw5_util

def find_height(point, grid):
    """ Find the height of a point in the grid. """
    return grid[point[0]][point[1]]

def find_grid_size(grid):
    """ Find the size of the grid. """
    return (len(grid), len(grid[0]))

def find_global_max(grid):
    """ Find the global maximum of the grid. """
    max_height = ((0,0), 0)
    for i in range(len(grid)):
        for j in range(len(grid[i])):
            if grid[i][j] > max_height[1]:
                max_height = ((i,j), grid[i][j])
    return max_height

def find_neighbors(point, grid):
    """ Find the neighbors of a point in the grid. """
    neighbors = []
    y, x = point
    max_y, max_x = find_grid_size(grid)
    neighbors.append((y-1, x)) if y-1 >= 0 else None
    neighbors.append((y, x-1)) if x-1 >= 0 else None
    neighbors.append((y, x+1)) if x+1 < max_x else None
    neighbors.append((y+1, x)) if y+1 < max_y else None
    return neighbors

def find_steepest_path(start, grid, max_step):
    """ Find the steepest path."""
    path = [start]
    current = start
    
    while True:
        neighbors = find_neighbors(current, grid)
        next_step = None
        max_height_diff = 0
        
        for n in neighbors:
            height_diff = find_height(n, grid) - find_height(current, grid)
            if height_diff > 0 and height_diff <= max_step and height_diff > max_height_diff:
                next_step = n
                max_height_diff = height_diff
                
        if next_step is None:
            break
            
        path.append(next_step)
        current = next_step
    return path

def find_gradual_path(start, grid, max_step):
    """" Find the most gradual path."""
    path = [start]
    current = start
    
    while True:
        neighbors = find_neighbors(current, grid)
        next_step = None
        min_height_diff = float("inf")
        
        for n in neighbors:
            height_diff = find_height(n, grid) - find_height(current, grid)
            if height_diff > 0 and height_diff <= max_step and height_diff < min_height_diff:
                next_step = n
                min_height_diff = height_diff
                
        if next_step is None:
            break
            
        path.append(next_step)
        current = next_step
    return path

def show_path(path):
    """" Display the path."""
    display = ""
    counter = 0
    for i in range(len(path)):
        if counter == 5:
            display += "\n"
            counter = 0
        display += "({}, {}) ".format(path[i][0], path[i][1])
        counter += 1
    print(display)

def find_path_end(path, grid):
    """ Find the end of the path."""
    end_point = path[-1]
    end_height = find_height(end_point, grid)
    
    max_point, max_height = find_global_max(grid)
    
    if end_height == max_height:
        return "global maximum"
    
    neighbors = find_neighbors(end_point, grid)    
    is_local_max = True
    for n in neighbors:
        if find_height(n, grid) > end_height:
            is_local_max = False
            break
            
    if is_local_max:
        return "local maximum"
    else:
        return "no maximum"

def build_path_grid(grid, paths):
    """ Build the path grid."""
    rows, cols = find_grid_size(grid)
    path_grid = [[0] * cols for _ in range(rows)]
    
    for path in paths:
        for point in path:
            y, x = point
            path_grid[y][x] += 1
            
    return path_grid

def print_path_grid(path_grid):
    """ Display the path grid."""
    for i in range(len(path_grid)):
        row = "  " 
        for j in range(len(path_grid[i])):
            if path_grid[i][j] > 0:
                row += str(path_grid[i][j]) + "  "
            else:
                row += "." + "  "
        print(row.rstrip())

def print_path(path, path_type):
    """ Display the path."""
    print("{} path".format(path_type))
    show_path(path) 
    print(find_path_end(path, grid))

if __name__ == "__main__":
    grid_index = input("Enter a grid index less than or equal to 3 (0 to end): ").strip()
    #grid_index = 1  # Debugging
    print(grid_index)
    grid_index = int(grid_index)
    grid = hw5_util.get_grid(int(grid_index))
    """
    grid = [[15, 16, 18, 19, 12, 11],\
            [13, 19, 23, 21, 16, 12],\
            [12, 15, 17, 19, 20, 10],\
            [10, 14, 16, 13, 9, 6]]
    """
    start_locations = hw5_util.get_start_locations(grid_index)
    
    max_step_height = input("Enter the maximum step height: ").strip()
    #max_step_height = "4" # Debugging
    print(max_step_height)
    max_step_height = int(max_step_height)
    
    print_path_grid_choice = input("Should the path grid be printed (Y or N): ").strip()
    #print_path_grid_choice = "Y" # Debugging
    print(print_path_grid_choice)
    print_path_grid_choice = print_path_grid_choice.upper()
    
    print("Grid has {} rows and {} columns".format(find_grid_size(grid)[0], find_grid_size(grid)[1]))
    print("global max: {} {}".format(find_global_max(grid)[0], find_global_max(grid)[1]))
    
    print("===")
    
    paths = []
    
    for start in start_locations:
        steepest = find_steepest_path(start, grid, max_step_height)
        gradual = find_gradual_path(start, grid, max_step_height)
        
        print_path(steepest, "steepest")
        print("...")
        print_path(gradual, "most gradual")   
        print("===")
        
        paths.append(steepest)
        paths.append(gradual)
    
    path_grid = build_path_grid(grid, paths)
    print("Path grid")
    print_path_grid(path_grid)
```