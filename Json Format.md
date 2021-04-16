# 接口统一封装

由于后台接口返回的数据结构比较杂乱，现对各种数据结构对应的JSON进行规范化。进行序列化(`toJson`)和反序列化(`fromJson`)的JSON需满足下面给出的范例要求。

## 用户

```json
{
	"user": {
		"joinTime": 20170,
		"lastLogin": "2019-11-24T01:38:17.734Z",
		"qq": "453433444",
		"isAdmin": false,
		"avatar": "/api/user/avatar/ChenXiaoMing",
		"email": "",
		"username": "陈小明",
		"spaceQuota": 200000,
		"dormitory": "23栋637",
		"signature": "",
		"id": "cjsidv0w900b907qweruaqt3",
		"className": "软工1710",
		"wechat": "14321234339",
		"mobile": "15932455679",
		"threads": 3,
		"major": "软工",
		"studentID": "",
		"active": true
	},
	"group": [{
		"id": "23453421641gart13451tga",
		"key": 5,
		"name": "Android",
		"color": "cyan"
	}]
}
```

## Post

```json
{
	"post": {
		"id": "4534523ergret13rgqege4512",
		"message": "C#和 js也太像了吧（逃?",
		"createDate": "2019-08-11T07:43:35.387Z",
		"isFirst": false,
		"quote": "-1",
		"subject": "heihei",
		"postCount": 2,
		"threadCreateDate": "2019-08-11T07:43:35.387Z",
		"active": true
	},
	"user": {
		"joinTime": 20183,
		"lastLogin": "2019-11-19T06:09:44.076Z",
		"qq": "",
		"isAdmin": false,
		"avatar": "/api/user/avatar/ChenXiaoMing",
		"email": "",
		"username": "陈小明",
		"spaceQuota": 200000,
		"dormitory": "",
		"signature": "",
		"id": "cjsijib12123fa23739sg0",
		"className": "",
		"wechat": "",
		"mobile": "1532313493",
		"threads": 2,
		"major": "",
		"studentID": "",
		"active": true
	},
	"thread": {
		"postCount": 3,
		"subject": " Lab组2019秋季第1期新人任务",
		"createDate": "2019-10-26T11:34:32.620Z",
		"closed": false,
		"id": "ck27hlm3141534d1244n45",
		"lastDate": "2019-10-27T06:15:39.221Z",
		"diamond": false,
		"top": 0,
		"active": true
	}
}
```

## Report

```json
{
	"id": "cjsijwuhs18c40232412429l",
	"message": "姓名：陈小明\nMentor：@陈小明\n学习时间：12:30~13:30 18:00~22:30\n学习内容：Vue.js",
	"createDate": "2019-01-04T06:55:42.800Z",
	"isWeek": false
}
```

## Thread

```json
{
	"thread": {
		"postCount": 1,
		"subject": "【2017.10.28】联创团队成员公约 v1.0.0",
		"createDate": "2017-10-28T04:19:32.159Z",
		"closed": false,
		"id": "cjsijp37d03hn0766ow9z0tc3",
		"lastDate": "2017-10-28T04:19:32.159Z",
		"diamond": false,
		"top": 2,
		"active": true
	},
	"user": {
		"joinTime": 20151,
		"lastLogin": "2019-03-14T10:25:52.126Z",
		"qq": "",
		"isAdmin": false,
		"avatar": "/api/user/avatar/ChenXiaoMing",
		"email": "",
		"username": "陈小明",
		"spaceQuota": 200000,
		"dormitory": "",
		"signature": "https://wula.la 大家一起乌啦啦！！",
		"id": "cjsiduoes004b0779l3q8gh1t",
		"className": "",
		"wechat": "",
		"mobile": "14532324243",
		"threads": 17,
		"major": "",
		"studentID": "",
		"active": true
	},
	"lastReply": [{
		"createDate": "2017-10-28T04:19:32.159Z",
		"isFirst": true,
		"quote": "-1",
		"id": "cjsiasdfr43qgre1i18lp",
		"message": "-",
		"active": true
	}],
	"firstPost": {
		"createDate": "2019-04-01T10:12:08.466Z",
		"isFirst": true,
		"quote": "-1",
		"id": "cjty72hak06vp07672o4ngsx1",
		"message": "![uniqueImg](unique://cjty6ziws06asdf367akhbu3p2)",
		"active": true
	},
	"postArr": [{
		"post": {
			"createDate": "2019-11-24T11:04:24.043Z",
			"isFirst": false,
			"quote": "-1",
			"id": "ck3cwakmo314534711qtwf6rkf",
			"message": "xixixixi",
			"active": true,
            "quote": null
		},
		"user": {
			"joinTime": 20183,
			"lastLogin": "2019-11-24T07:35:35.779Z",
			"qq": "1234359340",
			"isAdmin": true,
			"avatar": "/api/user/avatar/ChenXiaoMing",
			"email": "",
			"username": "陈小明",
			"spaceQuota": 200000,
			"dormitory": "韵苑11243",
			"signature": "我是?～",
			"id": "cjs1234fdsadsf07798ma2v0s2",
			"className": "",
			"wechat": "",
			"mobile": "18143534241",
			"threads": 7,
			"major": "",
			"studentID": "U23421187816",
			"active": true
		},
		"group": [{
			"id": "cjsidton3245r0779h9kn60jh",
			"key": 2,
			"name": "Web",
			"color": "cyan"
		}]
	}],
	"attachArr": [{
		"originalName": "ChenXiaoMing.png",
		"filesize": 219519,
		"createDate": "2019-04-01T10:09:50.704Z",
		"fileName": "/var/bbs/upload/2019_4_1/cjty72hak06vp07674t3gfdvqe323413528892_cjty6ziws06vc0767akhbu3p2.rabbit",
		"id": "cjty6ziws06v433545s113p2",
		"downloads": 32
	}],
	"forumInfo": {
		"name": "闲杂讨论",
		"description": "在这里讨论什么都可以",
		"icon": "message|#86C1B9",
		"id": "cjsijitna00o40766y6v2klml",
		"threads": 53
	}
}
```

## Forum

```json
{
    "forum":{
        "id": "cjsijitdgqwer1234rfx3ln63v",
		"name": "通知公告",
		"threads": 10,
		"icon": "notification|#4e4bfc",
		"description": "全团队公告以及信息",
    },
	"lastPost": {
		"post": {
			"createDate": "2019-10-19T08:18:46.527Z",
			"isFirst": true,
			"quote": "-1",
			"id": "ck1xaiqwetrwg31r23ryndj8i7",
			"message": "-",
			"active": true
		},
		"thread": {
			...
		},
		"user": {
			...
		}
	}
}
```

## Group

```json
{
	"group": {
		"id": "cjsidton603245gdfh9kn60jh",
		"key": 2,
		"name": "Web",
		"color": "cyan",
        "count": 26
	},
	"master": {
		"joinTime": 20182,
		"lastLogin": "2019-11-01T07:09:17.784Z",
		"qq": "145314511322",
		"isAdmin": true,
		"email": "",
		"username": "陈小明",
		"spaceQuota": 200000,
		"dormitory": "韵苑213栋323",
		"signature": "System.out.println(\"girlfriend！！！\")",
		"userid": "ChenXiaoMing",
		"id": "cjsidur5k1234fd9y2s7tu1w",
		"className": "1709",
		"wechat": "j;21fl/sdfma.s",
		"mobile": "15324343159",
		"threads": 4,
		"major": "电子信息工程",
		"studentID": "U20324235",
		"active": true
	}
}
```

## Message

```
{
	"message": {
		"createDate": "2019-10-21T09:15:19.861Z",
		"url": "/report/mentor",
		"id": "ck207fcfv01234edf2uvp",
		"isRead": true,
		"message": "您设为了Mentor！"
	},
	"fromUser": {
		"joinTime": 20193,
		"lastLogin": "2019-11-23T17:17:39.679Z",
		"qq": "11234234049",
		"isAdmin": false,
		"avatar": "/api/user/avatar/ChenXiaoMing",
		"email": "",
		"username": "陈小明",
		"spaceQuota": 200000,
		"dormitory": "东十三131234",
		"signature": "",
		"id": "ck1yztcqwer324tre5llqcg",
		"className": "网安1911",
		"wechat": "",
		"mobile": "132452345307",
		"threads": 0,
		"major": "信息安全",
		"studentID": "U212342675",
		"active": true
	}
}
```

## Attach

```json
{
		"originalName": "ChenXiaoMing.png",
		"filesize": 219519,
		"createDate": "2019-04-01T10:09:50.704Z",
		"fileName": "/var/bbs/upload/2019_4_1/cjty72hak06vp07672o4ngs3452392_cjty6ziws06vc0767akhbu3p2.rabbit",
		"id": "cjty6ziws06v2345hbu3p2",
		"downloads": 32
}
```

