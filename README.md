# BMG191024001-gse29272_dge

此项目使用到[GSE29272差异表达分析流程](https://github.com/sxropensource/gse29272_dge)。

## 安装依赖

根据[流程说明文件](https://github.com/sxropensource/gse29272_dge/blob/master/README.md)
安装依赖。
    
## 建立目录结构

```
BMG191024001-volcano_map_edgerAML
├── README.md
├── VERSION.md
└── v1
    ├── results
    │   ├── Figure
    │   │   ├── Figure1.pdf
    │   │   └── Figure2.pdf
    │   └── Table
    └── runtime
        ├── ANALYSIS.md
        ├── data
        │   └── edgerAML.tsv
        ├── doc
        ├── figs
        │   ├── volcano_map.pdf
        │   └── volcano_map.png
        ├── output
        └── src
            └── volcano_map.R
```

1. 关于版本控制
    
    在做实际项目分析时，项目有所调整是很常见的情况。为了对项目进行控制，可以在
    项目根目录中分别建立版本子目录。例如，正常情况下，一个新的项目根目录下至少要
    有一个文件夹`v1`和一个对版本说明文件`VERSION.md`。文件夹`v1`包含最初版本
    所有文件。版本说明文件`VERSION.md`意在说明进行版本变更时变更的目的
    （[版本变更文件`VERSION.md`模板](VERSION.md)）。
    
    当需要进行项目调整时，如果项目调整比较小，可以建立`v1.1`目录。如果项目调整比较
    大的话，可以建立`v2`目录。然后根据`v1`的目录结构，建立相同的目录结构。拷贝相应
    的原始数据和代码。不能拷贝`v1`目录中的任何结果文件，如果需要该文件，可以根据
    `v2`中的代码再次生成。原则是`v2`中的文件除了原始文件之外不应该与`v1`中的文件
    有任何关系。
    
2. 关于`results`与`runtime`目录的目的

    `runtime`包含所有项目分析过程中的数据、程序、临时文件、结果文件、所需文档。
    
    当分析完成，需要向客户展示结果、发送报告时，可以将`runtime`中的文件整理、
    拷贝或者其他任何方式发送到`results`目录中。
    
3. `runtime/ANALYSIS.md`是用来做什么的？

    分析过程中，除了生成文件之外可以产生一些其他的结果，这些结果可以写入到该`ANALYSIS.md`中。
    例如，当进行无监督聚类时，分类数就可以写入到该`ANALYSIS.md`中。
    [`ANALYSIS.md`模板](v1/runtime/ANALYSIS.md)
    
4. `runtime`目录结构说明

    1. data: 用于存放原始数据
    2. doc: 项目的一些文档。例如，项目的方案文档、做项目过程中查询的一些重要文档
    3. figs: 分析过程中生成的图片
    4. output: 分析过程生成的表格及其他文本文件
    5. src：程序文件

## 运行分析

切换到当前版本的`runtime`目录（本例中即：`v1/runtime`）：

1. 画图

    1. 准备数据（本例中也即把`edgerAML.tsv`拷贝到`data`目录）
    2. 拷贝[volcano_map](https://github.com/sxropensource/volcano_map)流程中的
    [src/volcano_map.R](https://github.com/sxropensource/volcano_map/blob/master/src/volcano_map.R)
    到`src`目录
    3. 根据文档文档做相应的修改（针对探索性步骤）
    4. 运行`volcano_map.R`
    
        ```
        $ src/volcano_map.R --png figs/volcano_map.png --pdf figs/volcano_map.pdf data/edgerAML.tsv
        ```
        
## 整理结果

本例中需要把`figs/volcano_map.png`和`figs/volcano_map.pdf`拷贝到

1. 把[v1/runtime/figs/volcano_map.png](v1/runtime/figs/volcano_map.png)拷贝到[v1/results/Figure/Figure1.png]
1. 把[v1/runtime/figs/volcano_map.pdf](v1/runtime/figs/volcano_map.pdf)拷贝到[v1/results/Figure/Figure1.pdf]
