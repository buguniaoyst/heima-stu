var navs = [{
	"title": "系统设置",
	"icon": "&#xe614;",
	"spread": true,
	"children": [{
        "title": "修改密码",
        "icon": "&#xe612;",
        "href": "/rest/student/user_control"
    }]
},{
	"title": "考试管理",
	"icon": "&#xe620;",
	"spread": false,
	"children": [ {
        "title": "今日测试",
        "icon": "&#xe654;",
        "href": "/rest/student/stu_test_detail"
    }]
}, {
	"title": "成绩管理",
	"icon": "&#xe629;",
	"href": "",
	"spread": false,
	"children": [  {
		"title": "我的成绩",
		"icon": "&#xe60a;",
		"href": "/rest/student/testctrl_scoreList"
	}]
}, {
	"title": "其他",
	"icon": "&#xe650;",
	"href": "#",
	"spread": false,
	"children": [{
		"title": "通讯录",
		"icon": "&#xe613;",
		"href": "/rest/student/score_list"
	}]
}];