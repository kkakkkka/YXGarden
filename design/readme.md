# 数据库表  

### 用户表

| 名           | 类型     | 长度 | 键          | 注释         |
| ------------ | -------- | ---- | ----------- | ------------ |
| userID       | varchar  | 20   | primary key | 用户名ID     |
| password     | varchar  | 26   |             | 用户密码     |
| userName     | varchar  | 26   |             | 用户名       |
| isRoot       | boolean  |      |             | 用户管理权限 |
| speechStatus | boolean  |      |             | 用户发言状态 |
| userAvatar   | varchar  | 255  |             | 用户头像URL  |
| regTime      | datetime |      |             | 注册时间     |
| motto        | text     |      |             | 用户座右铭   |
| homePage     | varchar  | 255  |             | 个人主页链接 |

### 博文表

注：博客作者根据userID从用户表中获取、分类名根据catID、标签名根据tagID。

（后期添加一个博文页的留言板？）

| 名            | 类型     | 长度 | 键          | 注释        |
| ------------- | -------- | ---- | ----------- | ----------- |
| blogID        | int      | 20   | primary key | 博客ID      |
| userID        | varchar  | 20   | foreign key | 发表用户ID  |
| catID         | int      | 10   | foreign key | 分类ID      |
| tagID         | int      | 10   | foreign key | 标签ID      |
| title         | text     |      |             | 博客标题    |
| content       | longtext |      |             | 博客内容    |
| releaseTime   | datetime |      |             | 发表日期    |
| updateTime    | datetime |      |             | 更新日期    |
| articleLength | varchar  | 20   |             | 文章字数    |
| readDuration  | varchar  | 20   |             | 阅读时长    |
| commentCount  | int      | 20   |             | 评论数      |
| backgroundImg | varchar  | 255  |             | 文章封面URL |

### 用户分类表

每个用户一个分类表

| 名       | 类型    | 长度 | 键          | 注释     |
| -------- | ------- | ---- | ----------- | -------- |
| ctableID | varchar | 20   | primary key | 分类表ID |
| userID   | varchar | 20   | foreign key | 用户ID   |
| catCount | int     | 20   |             | 分类数量 |

### 博文分类表

| 名           | 类型    | 长度 | 键          | 注释     |
| ------------ | ------- | ---- | ----------- | -------- |
| catID        | varchar | 20   | primary key | 分类ID   |
| ctableID     | varchar | 20   | foreign key | 分类表ID |
| catName      | varchar | 20   |             | 分类名称 |
| articleCount | int     | 20   |             | 文章数量 |

### 用户标签表

每个用户一个标签表

| 名       | 类型    | 长度 | 键          | 注释     |
| -------- | ------- | ---- | ----------- | -------- |
| ttableID | varchar | 20   | primary key | 标签表ID |
| userID   | varchar | 20   | foreign key | 用户ID   |
| tagCount | int     | 20   |             | 标签数量 |

### 博文标签表

| 名           | 类型    | 长度 | 键          | 注释     |
| ------------ | ------- | ---- | ----------- | -------- |
| tagID        | varchar | 20   | primary key | 标签ID   |
| ttableID     | varchar | 20   | foreign key | 标签表ID |
| tagName      | varchar | 20   |             | 标签名称 |
| articleCount | int     | 20   |             | 文章数量 |

### 留言表

留言作者根据userID从用户表中获取

| 名        | 类型     | 长度 | 键          | 注释         |
| --------- | -------- | ---- | ----------- | ------------ |
| msgID     | varchar  | 20   | primary key | 留言ID       |
| userID    | varchar  | 20   | foreign key | 留言用户ID   |
| userPlace | varchar  | 20   |             | 留言发送地点 |
| content   | text     |      |             | 留言内容     |
| time      | datetime |      |             | 留言日期     |

### 相册表

每个用户一个相册

| 名       | 类型    | 长度 | 键          | 注释     |
| -------- | ------- | ---- | ----------- | -------- |
| albumID  | varchar | 20   | primary key | 相册ID   |
| userID   | varchar | 20   | foreign key | 用户ID   |
| picCount | int     | 20   |             | 相片数量 |

### 相片表

不同用户的重复的图片就存多几张，不考虑性能

| 名         | 类型     | 长度 | 键          | 注释     |
| ---------- | -------- | ---- | ----------- | -------- |
| picID      | varchar  | 20   | primary key | 相片ID   |
| albumID    | varchar  | 20   | foreign key | 相册ID   |
| name       | text     |      |             | 相片名称 |
| content    | varchar  | 255  |             | 相片URL  |
| uploadTime | datetime |      |             | 上传时间 |

### 技术分布表

每个用户一个技术分布表

| 名         | 类型    | 长度 | 键          | 注释         |
| ---------- | ------- | ---- | ----------- | ------------ |
| distID     | varchar | 20   | primary key | 分布ID       |
| userID     | varchar | 20   | foreign key | 用户ID       |
| skillCount | int     | 20   |             | 技术分类数量 |

### 技术统计

文章数量做个判断，如果分类和标签名相同就算一个，不同算两个

| 名           | 类型    | 长度 | 键          | 注释     |
| ------------ | ------- | ---- | ----------- | -------- |
| skillID      | varchar | 20   | primary key | 技术ID   |
| distID       | varchar | 20   | foreign key | 分布ID   |
| skillName    | varchar | 20   |             | 技术名称 |
| articleCount | int     | 20   |             | 文章数量 |