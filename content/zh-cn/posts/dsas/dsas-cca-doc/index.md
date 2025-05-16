---
title: 逆向DSAS Engage CCA API的文档
subtitle:
date: 2025-05-14T02:47:46-04:00
lastmod: 2025-05-14T02:47:46-04:00
slug: dsas-cca-doc
draft: false
author:
  name: James
  link: https://www.jamesflare.com
  email:
  avatar: /site-logo.avif
description: 这是我逆向的DSAS Engage CCA API文档。
keywords: ['DSAS', 'HTTP', 'Clubs', 'CCA', 'API', '无锡狄邦文理学校']
license:
comment: true
weight: 0
tags:
  - HTTP
  - Engage
categories:
  - 编程语言
collections:
  - DSAS
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: 这是我逆向的DSAS Engage CCA API文档。
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
  enable: false
  url:

# See details front matter: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->

## 概述

DSAS CCA（课外活动）API 是一个可以通过程序访问 DSAS 学校俱乐部、活动以及教职员工信息的工具。这个 RESTful API（一种基于 REST 架构风格的接口，方便开发者通过网络请求获取数据）允许开发者轻松获取俱乐部的详细信息，根据多种条件筛选活动，还能查看教职员工的相关信息。

## 基础 URL

```
https://dsas-cca.jamesflare.com
```

## 认证

API 的所有端点都是公开访问的，读取数据时无需进行身份认证。

## 速率限制

请合理使用 API，过多的请求可能会受到速率限制（即限制单位时间内的请求次数，以保护服务器不被过度使用）。

## 端点

### 俱乐部与活动端点

#### 1. 列出所有俱乐部

```
GET /v1/activity/list
```

**描述**：返回所有俱乐部的列表，包括俱乐部名称和照片。

**响应格式**：

```json
{
  "3010": {
    "name": "Mixed Martial Arts",
    "photo": "https://minio-lv-a.jamesflare.com/dsas-cca/files/activity-3010-example.jpeg"
  },
  "3350": {
    "name": "Student-led Exploring the Art Major 探索美术专业社 (G9-G12)",
    "photo": "https://minio-lv-a.jamesflare.com/dsas-cca/files/activity-3350-32f97667-81ef-446c-acc6-45fea9b9c989.jpeg"
  }
  // 更多俱乐部...
}
```

#### 2. 按类别筛选俱乐部

```
GET /v1/activity/list?category={categoryName}
```

**描述**：返回属于指定类别的俱乐部。

**参数**：

* `category` (string)：类别名称 ( 例如 "Expressive Arts", "STEAM" )

**响应格式**：与列出所有俱乐部端点相同，但仅显示指定类别的俱乐部。

#### 3. 按学年筛选俱乐部

```
GET /v1/activity/list?academicYear={academicYear}
```

**描述**：返回指定学年的俱乐部。

**参数**：

* `academicYear` (string)：学年，格式为 YYYY/YYYY ( 例如 "2022/2023" )

**响应格式**：与列出所有俱乐部端点相同，但仅显示指定学年的俱乐部。

#### 4. 按年级筛选俱乐部

```
GET /v1/activity/list?grade={grade}
```

**描述**：返回适合指定年级学生的俱乐部。

**参数**：

* `grade` (number)：年级水平 ( 1-12 )

**响应格式**：与列出所有俱乐部端点相同，但仅包括指定年级在俱乐部年级范围内的俱乐部。

#### 5. 根据是否由学生主导筛选俱乐部

```
GET /v1/activity/list?isStudentLed={true|false}
```

**描述**：返回根据是否由学生主导筛选出的俱乐部。

**参数**：

* `isStudentLed` (boolean)：`true` 或 `false`

**响应格式**：与列出所有俱乐部端点相同，但仅显示符合是否由学生主导条件的俱乐部。

#### 6. 可用类别

```
GET /v1/activity/category
```

**描述**：返回所有俱乐部类别的列表，并显示每个类别中的俱乐部数量。

**响应格式**：

```json
{
  "STEAM": 429,
  "Expressive Arts": 814,
  "Languages & Media": 439,
  "Supercurricular": 58,
  "After School Care": 32,
  "Sport & Health": 1012,
  "Humanities": 250
}
```

#### 7. 可用学年

```
GET /v1/activity/academicYear
```

**描述**：返回所有学年的列表，并显示每个学年中的俱乐部数量。

**响应格式**：

```json
{
  "2024/2025": 1139,
  "2023/2024": 1477,
  "2022/2023": 418
}
```

#### 8. 获取俱乐部详情

```
GET /v1/activity/{activityId}
```

**描述**：返回某个特定俱乐部的详细信息。

**参数**：

* `activityId` (string)：俱乐部 ID ( 1-4 位数字 )

**响应格式**：

```json
{
  "academicYear": "2022/2023",
  "category": "Expressive Arts",
  "description": "Kayla Qu, Nancy Xue\n\n要求：成员对美术相关专业有兴趣，比如说未来想要申请的美术专业。\n\n我们的社团会帮助未来想要申请美术专业的同学们更加了解其相关专业，并学习对应专业所需要的绘画技巧。\n（同学们需要自己准备一本 sketch book）\nThis CCA will help students who have interested in studying art majors in the future but have no idea what art major they are going to choose for college, and we will learn some art silks which needed for each art major.",
  "duration": {
    "endDate": "19/06/2023",
    "isRecurringWeekly": true,
    "startDate": "27/02/2023"
  },
  "grades": {
    "max": "12",
    "min": "10"
  },
  "id": "3350",
  "isPreSignup": false,
  "isStudentLed": true,
  "materials": [],
  "meeting": {
    "day": "Wednesday",
    "endTime": "17:10",
    "location": {
      "block": "Upper Secondary",
      "room": "B3026",
      "site": "Wuxi Campus"
    },
    "startTime": "16:10"
  },
  "name": "Student-led Exploring the Art Major 探索美术专业社 (G9-G12)",
  "photo": "https://minio-lv-a.jamesflare.com/dsas-cca/files/activity-3350-32f97667-81ef-446c-acc6-45fea9b9c989.jpeg",
  "poorWeatherPlan": "",
  "requirements": [],
  "schedule": "2022.23 CCA S2 - G10-12",
  "semesterCost": null,
  "staff": [
    "Ms Anastasia Pavlova",
    "Ms Kayla Chen",
    "Ms Luciana Liu"
  ],
  "staffForReports": [
    "Ms Kayla Chen",
    "Ms Luciana Liu",
    "Ms Anastasia Pavlova"
  ],
  "studentLeaders": [],
  "lastCheck": "2025-05-11T22:00:33.302Z",
  "cache": "HIT"
}
```

### 教职员工端点

#### 1. 获取所有教职员工

```
GET /v1/staffs
```

**描述**：返回所有教职员工的列表，包括他们的 ID 和姓名。

**响应格式**：

```json
{
  "CL1-1000": "Mr Dan Achiroae",
  "CL1-1001": "Mr Johann Hartzenberg",
  "CL1-1002": "Mr Samuel Pottas",
  "CL1-1003": "Ms Amanda Milne",
  "CL1-1004": "Mr Peter Regulagadda",
  "CL1-1005": "Mr Rajeev Ranjan",
  "CL1-1006": "Mr Lim Wan",
  "CL1-1007": "Ms Christina Feng",
  "CL1-1008": "Mr Jason Fang"
  // 更多教职员工...
}
```

## 组合筛选

活动列表端点支持通过组合多个筛选条件来精确搜索：

```
GET /v1/activity/list?category=STEAM&grade=10&academicYear=2023/2024&isStudentLed=true
```

这将返回 2023/2024 学年中适合 10 年级学生且属于 STEAM 类别的学生主导俱乐部。

## 错误处理

API 使用标准的 HTTP 状态码来表示请求的结果：

* **200 OK**：请求成功
* **400 Bad Request**：提供的参数无效
* **404 Not Found**：请求的资源未找到
* **500 Internal Server Error**：服务器端发生错误

错误响应中包含一个 JSON 对象，其中的 `error` 字段会描述具体问题：

```json
{
  "error": "Invalid academicYear format. Expected format: YYYY/YYYY"
}
```

如果类别或学年参数无效，响应中会包含可用的选项：

```json {data-open=true}
{
  "error": "Invalid category parameter. Category not found.",
  "availableCategories": [
    "Expressive Arts",
    "STEAM",
    "Sport & Health",
    "Languages & Media",
    "Humanities",
    "Supercurricular",
    "After School Care"
  ]
}
```

## 缓存

API 采用了缓存机制来提升性能：

* 响应对象中包含一个 `cache` 字段，用于显示缓存状态：
  * `"HIT"`：响应数据来自缓存
  * `"MISS"`：响应数据是从源头新获取的
  * `"ERROR"`：在缓存获取或数据获取过程中发生错误

* 响应对象中还包含一个 `lastCheck` 时间戳，显示数据最后更新的时间。

## 示例

### 获取 ID 为 3350 的俱乐部详情

**请求**：

```
GET /v1/activity/3350
```

**响应**：

```json
{
  "academicYear": "2022/2023",
  "cache": "HIT",
  "category": "Expressive Arts",
  "description": "Kayla Qu, Nancy Xue\n\n要求：成员对美术相关专业有兴趣，比如说未来想要申请的美术专业。\n\n我们的社团会帮助未来想要申请美术专业的同学们更加了解其相关专业，并学习对应专业所需要的绘画技巧。\n（同学们需要自己准备一本 sketch book）\nThis CCA will help students who have interested in studying art majors in the future but have no idea what art major they are going to choose for college, and we will learn some art silks which needed for each art major.",
  "duration": {
    "endDate": "19/06/2023",
    "isRecurringWeekly": true,
    "startDate": "27/02/2023"
  },
  "grades": {
    "max": "12",
    "min": "10"
  },
  "id": "3350",
  "isPreSignup": false,
  "isStudentLed": true,
  "lastCheck": "2025-05-14T22:21:37.870Z",
  "materials": [],
  "meeting": {
    "day": "Wednesday",
    "endTime": "17:10",
    "location": {
      "block": "Upper Secondary",
      "room": "B3026",
      "site": "Wuxi Campus"
    },
    "startTime": "16:10"
  },
  "name": "Student-led Exploring the Art Major 探索美术专业社 (G9-G12)",
  "photo": "https://minio-lv-a.jamesflare.com/dsas-cca/files/100c6594e7603ddcc0a405d200d35684.avif",
  "poorWeatherPlan": "",
  "requirements": [],
  "schedule": "2022.23 CCA S2 - G10-12",
  "semesterCost": "",
  "staff": [
    "Ms Anastasia Pavlova",
    "Ms Kayla Chen",
    "Ms Luciana Liu"
  ],
  "staffForReports": [
    "Ms Kayla Chen",
    "Ms Luciana Liu",
    "Ms Anastasia Pavlova"
  ],
  "studentLeaders": []
}
```

### 获取所有可用类别

**请求**：

```
GET /v1/activity/category
```

**响应**：

```json
{
  "Expressive Arts": 814,
  "STEAM": 429,
  "Sport & Health": 1012,
  "Languages & Media": 439,
  "Humanities": 250,
  "Supercurricular": 58,
  "After School Care": 32
}
```

### 获取所有教职员工

**请求**：

```
GET /v1/staffs
```

**响应**：

```json
{
  "CL1-100": "Mr Peter Bohovesky",
  "CL1-1000": "Mr Dan Achiroae",
  "CL1-1001": "Mr Johann Hartzenberg",
  // 更多教职员工...
}
```

### 获取 2023/2024 学年接受 10 年级学生的 STEAM 学生主导俱乐部

**请求**：

```
GET /v1/activity/list?category=STEAM&grade=10&academicYear=2023/2024&isStudentLed=true
```

**响应**：

```json {data-open=true}
{
  "4329": {
    "name": "Student-led Club-War of The Three Kingdoms 三国社 G10-12",
   "photo": "https://minio-lv-a.jamesflare.com/dsas-cca/files/9069604b2c9ad9d9f22c1565b63c8f46.avif"
  },
  "4343": {
   "name": "Student-led TRPG Club 桌面角色扮演 G8-12",
   "photo": "https://minio-lv-a.jamesflare.com/dsas-cca/files/076bcc72f2cdeb9fb096c64027ae416e.avif"
  },
  "4344": {
   "name": "Student-led Geogusser Club 地理侦探社 G10-12",
   "photo": "https://minio-lv-a.jamesflare.com/dsas-cca/files/2389506d728482a6cafe069ede4a92ab.avif"
  },
  "4721": {
    "name": "Student-led Mathematical Thinkers' Club 数学思维社 G9-12",
    "photo": "https://minio-lv-a.jamesflare.com/dsas-cca/files/85bb550117996530f092a52e7a596b59.avif"
  },
  "4819": {
   "name": "Student-led Club-War of The Three Kingdoms 三国社 G10-12",
   "photo": "https://minio-lv-a.jamesflare.com/dsas-cca/files/9069604b2c9ad9d9f22c1565b63c8f46.avif"
  },
  "4827": {
    "name": "Student-led TRPG Club 桌面角色扮演 G8-12",
   "photo": "https://minio-lv-a.jamesflare.com/dsas-cca/files/076bcc72f2cdeb9fb096c64027ae416e.avif"
  },
  "4828": {
    "name": "Student-led Geogusser Club 地理侦探社 G10-12",
    "photo": "https://minio-lv-a.jamesflare.com/dsas-cca/files/2389506d728482a6cafe069ede4a92ab.avif"
  }
}
```

## 实现说明

* 按年级筛选时，会排除年级值为 `null` 的俱乐部
* 学年格式必须严格遵循 YYYY/YYYY 的模式
* 所有 API 端点都支持 CORS（跨域资源共享，允许不同域名下的网页访问 API）
