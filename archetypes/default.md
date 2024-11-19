---
title: {{ replace .TranslationBaseName "-" " " | title }}
subtitle:
date: {{ .Date }}
lastmod: {{ .Date }}
slug: {{ substr .File.UniqueID 0 7 }}
description:
keywords:
draft: true
---
