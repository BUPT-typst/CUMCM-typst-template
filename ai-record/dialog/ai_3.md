# 使用Matplotlib绘制三维图像

下面是用Matplotlib绘制三维图像的代码，包括一个红点和三条线段：

```python
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np

# 创建图形和3D坐标轴
fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111, projection='3d')

# 绘制红点 (0,200,0)
ax.scatter(0, 200, 0, color='red', s=100, label='Red Point (0,200,0)')

# 定义线段
segments = [
    [(20000, 0, 2000), (0, 0, 0)],
    [(19000, 600, 2100), (0, 0, 0)],
    [(18000, -600, 1900), (0, 0, 0)]
]

# 绘制线段
colors = ['blue', 'green', 'purple']
labels = ['Segment 1', 'Segment 2', 'Segment 3']

for i, segment in enumerate(segments):
    start, end = segment
    # 提取坐标
    x = [start[0], end[0]]
    y = [start[1], end[1]]
    z = [start[2], end[2]]
    
    # 绘制线段
    ax.plot(x, y, z, color=colors[i], linewidth=2, label=labels[i])

# 设置坐标轴标签
ax.set_xlabel('X Axis')
ax.set_ylabel('Y Axis')
ax.set_zlabel('Z Axis')

# 设置标题
ax.set_title('3D Plot with Red Point and Line Segments')

# 添加图例
ax.legend()

# 设置视角以便更好地查看
ax.view_init(elev=20, azim=30)

# 显示图形
plt.show()
```

## 代码说明：

1. 首先创建了一个3D图形和坐标轴
2. 使用`scatter`函数绘制红点(0,200,0)
3. 定义了三条线段的起点和终点坐标
4. 使用循环绘制每条线段，并为每条线段指定不同颜色和标签
5. 设置了坐标轴标签、标题和图例
6. 调整了视角以便更好地观察三维图形

由于线段的一个端点是原点(0,0,0)，另一个端点距离较远，图形可能会显得有些拉伸。如果需要，可以调整坐标轴范围来更好地展示这些元素。