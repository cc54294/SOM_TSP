## 用 RSOM 算法求解 TSP 问题

TSP 问题称为旅行商问题，即给定一堆城市，求从某一个城市开始访问每个城市一次，并回到起点城市的最短距离。

SOM 称为竞争型神经网络 (自组织映射)，通常用于无监督学习，也可用于求解 TSP 问题。

这里主要是用 matlab 实现了 RSOM 算法，用于求解 TSP 问题，**求出的不是最优解只是近似解**。RSOM 是《A simple learning algorithm for growing ring SOM and its application to TSP》 中提出的算法，具体原理请参考论文。

## 效果

![1](https://github.com/cc54294/SOM_TSP/blob/master/gif/att48.gif)
![](https://github.com/cc54294/SOM_TSP/blob/master/gif/eil101.gif)
![](https://github.com/cc54294/SOM_TSP/blob/master/gif/tsp225.gif)
![](https://github.com/cc54294/SOM_TSP/blob/master/gif/pa561.gif)

## 运行

用 matlab 打开 RSOMTSP.m，然后点击运行即可。

data 文件夹中有几个 TSP 数据集，tour.txt 是城市坐标文件，tsp.txt 是最短路径。

可以更改 RSOMTSP 中的数据，如下：

```
shortestPath=load('./data/tsp225.tour.txt'); % 最短路径城市序号 idx
Citys=load('./data/tsp225.tsp.txt'); % 城市坐标 (idx, x, y)
```

## 参考文献

A simple learning algorithm for growing ring SOM and its application to TSP
