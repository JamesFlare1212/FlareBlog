---
title: Document of my DSAS CCA API
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
description: This is a document of my reverse engineering DSAS Engage CCA API.
keywords: ['DSAS', 'HTTP', 'Clubs', 'CCA', 'API', 'Wuxi Dipont School of Arts and Science']
license:
comment: true
weight: 0
tags:
  - HTTP
  - Engage
categories:
  - Programming
collections:
  - DSAS
hiddenFromHomePage: false
hiddenFromSearch: false
hiddenFromRss: false
hiddenFromRelated: false
summary: This is a document of my reverse engineering DSAS Engage CCA API.
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

## Overview

The DSAS CCA (Co-Curricular Activities) API provides programmatic access to information about clubs, activities, and staff at DSAS. This RESTful API allows developers to retrieve comprehensive details about clubs, filter activities by various parameters, and access staff information.

## Base URL

```
https://dsas-cca.jamesflare.com
```

## Authentication

The API endpoints are publicly accessible and do not require authentication for read operations.

## Rate Limiting

Please be considerate with your API usage. Excessive requests may be rate-limited.

## Endpoints

### Club & Activity Endpoints

#### 1. List All Clubs

```
GET /v1/activity/list
```

**Description**: Returns a list of all clubs with their names and photos.

**Response Format**:

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
  // More clubs...
}
```

#### 2. Filter Clubs by Category

```
GET /v1/activity/list?category={categoryName}
```

**Description**: Returns clubs that belong to the specified category.

**Parameters**:

* `category` (string): Name of the category (e.g., "Expressive Arts", "STEAM")

**Response Format**: Same as List All Clubs endpoint, filtered by the specified category.

#### 3. Filter Clubs by Academic Year

```
GET /v1/activity/list?academicYear={academicYear}
```

**Description**: Returns clubs from the specified academic year.

**Parameters**:

* `academicYear` (string): Academic year in the format YYYY/YYYY (e.g., "2022/2023")

**Response Format**: Same as List All Clubs endpoint, filtered by the specified academic year.

#### 4. Filter Clubs by Grade

```
GET /v1/activity/list?grade={grade}
```

**Description**: Returns clubs that accept students from the specified grade.

**Parameters**:

* `grade` (number): Grade level (1-12)

**Response Format**: Same as List All Clubs endpoint, filtered to include only clubs where the specified grade falls within the club's grade range.

#### 5. Filter Clubs by isStudentLed

```
GET /v1/activity/list?isStudentLed={true|false}
```

**Description**: Returns clubs that accept students from the specified grade.

**Parameters**:

* `isStudentLed` (boolean): `true` or `false`

**Response Format**: Same as List All Clubs endpoint, filtered by isStudentLed.

#### 6. Available Categories

```
GET /v1/activity/category
```

**Description**: Returns a list of all available club categories with the count of clubs in each category.

**Response Format**:

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

#### 7. Available Academic Years

```
GET /v1/activity/academicYear
```

**Description**: Returns a list of all available academic years with the count of clubs in each year.

**Response Format**:

```json
{
  "2024/2025": 1139,
  "2023/2024": 1477,
  "2022/2023": 418
}
```

#### 8. Get Club Details

```
GET /v1/activity/{activityId}
```

**Description**: Returns detailed information about a specific club.

**Parameters**:

* `activityId` (string): The ID of the club (1-4 digits)

**Response Format**:

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

### Staff Endpoints

#### 1. Get All Staff

```
GET /v1/staffs
```

**Description**: Returns a list of all staff members with their IDs and names.

**Response Format**:

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
  // More staff members...
}
```

## Combining Filters

The Activity List endpoint supports combining multiple filters to refine your search:

```
GET /v1/activity/list?category=STEAM&grade=10&academicYear=2023/2024&isStudentLed=true
```

This would return all sports clubs for the 2022/2023 academic year that accept grade 10 students.

## Error Handling

The API uses standard HTTP status codes to indicate the success or failure of requests:

* **200 OK**: Request succeeded
* **400 Bad Request**: Invalid parameters were provided
* **404 Not Found**: The requested resource was not found
* **500 Internal Server Error**: Server-side error occurred

Error responses include a JSON object with an `error` field describing the issue:

```json
{
  "error": "Invalid academicYear format. Expected format: YYYY/YYYY"
}
```

For invalid category or academicYear parameters, the response includes available options:

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

## Caching

The API implements caching to improve performance:

* Response objects include a `cache` field indicating cache status:

  * `"HIT"`: Response came from the cache
  * `"MISS"`: Response was freshly fetched from the source
  * `"ERROR"`: An error occurred during cache retrieval or data fetching

* Response objects also include a `lastCheck` timestamp indicating when the data was last updated.

## Examples

### Get details for club that has id 3350

**Request**:

```
GET /v1/activity/3350
```

**Response**:

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

### Get all available categories

**Request**:

```
GET /v1/activity/category
```

**Response**:

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

### Get all staff members

**Request**:

```
GET /v1/staffs
```

**Response**:

```json
{
  "CL1-100": "Mr Peter Bohovesky",
  "CL1-1000": "Mr Dan Achiroae",
  "CL1-1001": "Mr Johann Hartzenberg",
  // Additional staff members...
}
```

### Get STEAM student-led clubs in academic year 2023/2024 that accept grade 10 students

**Request**:

```
GET /v1/activity/list?category=STEAM&grade=10&academicYear=2023/2024&isStudentLed=true
```

**Response**:

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

## Implementation Notes

* When filtering by grade, clubs with `null` grade values are excluded from the results
* Academic year format must strictly follow the YYYY/YYYY pattern
* All API endpoints support CORS for cross-origin requests
