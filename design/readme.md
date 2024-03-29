# 数据库表  

### 用户表 user

| 名           | 类型     | 长度 | 键          | 注释         |
| ------------ | -------- | ---- | ----------- | ------------ |
| userID       | int      | 20   | primary key | 用户名ID     |
| password     | varchar  | 26   |             | 用户密码     |
| userName     | varchar  | 26   |             | 用户名       |
| isRoot       | boolean  |      |             | 用户管理权限 |
| speechStatus | boolean  |      |             | 用户发言状态 |
| userAvatar   | varchar  | 255  |             | 用户头像URL  |
| regTime      | datetime |      |             | 注册时间     |
| motto        | text     |      |             | 用户座右铭   |
| homePage     | varchar  | 255  |             | 个人主页链接 |

### 博文表 blog

注：博客作者根据userID从用户表中获取、分类名根据catID、标签名根据tagID。

（后期添加一个博文页的留言板？）

| 名            | 类型     | 长度 | 键          | 注释        |
| ------------- | -------- | ---- | ----------- | ----------- |
| blogID        | int      | 20   | primary key | 博客ID      |
| userID        | int      | 20   | foreign key | 发表用户ID  |
| catID         | int      | 10   | foreign key | 分类ID      |
| tagID         | int      | 10   | foreign key | 标签ID      |
| title         | text     |      |             | 博客标题    |
| content       | longtext |      |             | 博客内容    |
| releaseTime   | datetime |      |             | 发表日期    |
| updateTime    | datetime |      |             | 更新日期    |
| backgroundImg | varchar  | 255  |             | 文章封面URL |


### 博文分类表 cat

| 名      | 类型    | 长度 | 键          | 注释             |
| ------- | ------- | ---- | ----------- | ---------------- |
| catID   | int     | 20   | primary key | 分类ID           |
| userID  | int     | 20   | foreign key | 分类对应的用户ID |
| catName | varchar | 20   |             | 分类名称         |

### 博文标签表 tag

| 名      | 类型    | 长度 | 键          | 注释     |
| ------- | ------- | ---- | ----------- | -------- |
| tagID   | int     | 20   | primary key | 标签ID   |
| userID  | int     | 20   | foreign key | 标签表ID |
| tagName | varchar | 20   |             | 标签名称 |

### 留言表 webcomment

留言作者根据userID从用户表中获取

| 名        | 类型     | 长度 | 键          | 注释         |
| --------- | -------- | ---- | ----------- | ------------ |
| msgID     | int      | 20   | primary key | 留言ID       |
| userID    | int      | 20   | foreign key | 留言用户ID   |
| userPlace | varchar  | 20   |             | 留言发送地点 |
| content   | text     |      |             | 留言内容     |
| time      | datetime |      |             | 留言日期     |

### 相片表 pic

不同用户的重复的图片就存多几张，不考虑性能

| 名         | 类型     | 长度 | 键          | 注释       |
| ---------- | -------- | ---- | ----------- | ---------- |
| picID      | int      | 20   | primary key | 相片ID     |
| userID     | int      | 20   | foreign key | 所属用户ID |
| name       | varchar  | 20   |             | 相片名称   |
| content    | varchar  | 255  |             | 相片URL    |
| uploadTime | datetime |      |             | 上传时间   |

### 点赞表likes

| 名        | 类型    | 长度 | 键          | 注释       |
| --------- | ------- | ---- | ----------- | ---------- |
| likeID    | int     | 20   | primary key | 点赞ID     |
| userID    | int     | 20   | foreign key | 所属用户ID |
| blogID    | int     | 20   | foreign key | 博客ID     |
| likeOrNot | boolean |      |             | 点赞状态   |

