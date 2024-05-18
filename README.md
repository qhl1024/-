### 大学生心理健康辅导与检测平台

#### 一、项目介绍

本项目采用了前后端独立开发的方式，前端使用了`vue3`+`ts`+`element-plus` ，后台使用了`flask`+`python`+`mysql`。有大学生、心理辅导师和管理员三个用户。大学生登录平台，通过进行心理测试检测心理健康情况，可以预约心理辅导师进行心理辅导，心理辅导师根据大学生的辅导情况和心理测试情况提出对应的心理辅导方法，管理员管理大学生和心理辅导师的信息。

#### 二、安装使用

**前端**：本项目使用vite进行构建，vite官方中文文档参考：https://cn.vitejs.dev/guide/

项目初始化命令:

```
pnpm create vite
```

进入到项目根目录`pnpm install`安装全部依赖.安装完依赖运行程序:`pnpm run dev`

运行完毕项目跑在http://127.0.0.1:5173/可以访问你得项目啦

本项目安装了以下库：

```
pnpm install vue-router
pnpm install element-plus
pnpm install pinia
pnpm install axios
pnpm install mitt
pnpm install vite-plugin-svg-icons -D
pnpm install nprogress
pnpm install lodash
pnpm install -D eslint-plugin-prettier prettier eslint-config-prettier
pnpm install eslint -D
```

**后端**:使用flask框架进行构建，项目运行在 http://127.0.0.1:5000，通过`flask_cors`解决前后端跨域问题

在开始之前，请确保您已安装以下库：

```
import pymysql
import flask
import flask_cors
import json
import datetime
```

