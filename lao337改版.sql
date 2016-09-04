/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50534
Source Host           : localhost:3306
Source Database       : lao337

Target Server Type    : MYSQL
Target Server Version : 50534
File Encoding         : 65001

Date: 2016-09-04 22:58:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for wp_action
-- ----------------------------
DROP TABLE IF EXISTS `wp_action`;
CREATE TABLE `wp_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text COMMENT '行为规则',
  `log` text COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='系统行为表';

-- ----------------------------
-- Records of wp_action
-- ----------------------------
INSERT INTO `wp_action` VALUES ('1', 'user_login', '用户登录', '积分+10，每天一次', 'table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;', '[user|get_nickname]在[time|time_format]登录了管理中心', '1', '0', '1393685660');
INSERT INTO `wp_action` VALUES ('2', 'add_article', '发布文章', '积分+5，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5', '', '2', '0', '1380173180');
INSERT INTO `wp_action` VALUES ('3', 'review', '评论', '评论积分+1，无限制', 'table:member|field:score|condition:uid={$self}|rule:score+1', '', '2', '0', '1383285646');
INSERT INTO `wp_action` VALUES ('4', 'add_document', '发表文档', '积分+10，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5', '[user|get_nickname]在[time|time_format]发表了一篇文章。\r\n表[model]，记录编号[record]。', '2', '0', '1386139726');
INSERT INTO `wp_action` VALUES ('5', 'add_document_topic', '发表讨论', '积分+5，每天上限10次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10', '', '2', '0', '1383285551');
INSERT INTO `wp_action` VALUES ('6', 'update_config', '更新配置', '新增或修改或删除配置', '', '', '1', '1', '1383294988');
INSERT INTO `wp_action` VALUES ('7', 'update_model', '更新模型', '新增或修改模型', '', '', '1', '1', '1383295057');
INSERT INTO `wp_action` VALUES ('8', 'update_attribute', '更新属性', '新增或更新或删除属性', '', '', '1', '1', '1383295963');
INSERT INTO `wp_action` VALUES ('9', 'update_channel', '更新导航', '新增或修改或删除导航', '', '', '1', '1', '1383296301');
INSERT INTO `wp_action` VALUES ('10', 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', '1', '1', '1383296392');
INSERT INTO `wp_action` VALUES ('11', 'update_category', '更新分类', '新增或修改或删除分类', '', '', '1', '1', '1383296765');
INSERT INTO `wp_action` VALUES ('12', 'admin_login', '登录后台', '管理员登录后台', '', '[user|get_nickname]在[time|time_format]登录了后台', '2', '1', '1393685618');

-- ----------------------------
-- Table structure for wp_action_log
-- ----------------------------
DROP TABLE IF EXISTS `wp_action_log`;
CREATE TABLE `wp_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='行为日志表';

-- ----------------------------
-- Records of wp_action_log
-- ----------------------------
INSERT INTO `wp_action_log` VALUES ('1', '12', '1', '2130706433', 'user', '1', 'admin在2016-03-22 15:08登录了后台', '1', '1458630484');

-- ----------------------------
-- Table structure for wp_addons
-- ----------------------------
DROP TABLE IF EXISTS `wp_addons`;
CREATE TABLE `wp_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  `type` tinyint(1) DEFAULT '0' COMMENT '插件类型 0 普通插件 1 微信插件 2 易信插件',
  `cate_id` int(11) DEFAULT NULL,
  `is_show` tinyint(2) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `sti` (`status`,`is_show`)
) ENGINE=MyISAM AUTO_INCREMENT=198 DEFAULT CHARSET=utf8 COMMENT='微信插件表';

-- ----------------------------
-- Records of wp_addons
-- ----------------------------
INSERT INTO `wp_addons` VALUES ('160', 'CustomReply', '自定义回复', '支持图文回复、多图文回复、文本回复功能', '1', 'null', '凡星', '0.1', '1448265263', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('161', 'AutoReply', '自动回复', 'WeiPHP基础功能，能实现配置关键词，用户回复此关键词后自动回复对应的文件，图文，图片信息', '1', 'null', '凡星', '0.1', '1448265611', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('162', 'WeiSite', '微官网', '微3G网站、支持分类管理，文章管理、底部导航管理、微信引导信息配置，微网站统计代码部署。同时支持首页多模板切换、信息列表多模板切换、信息详情模板切换、底部导航多模板切换。并配置有详细的模板二次开发教程', '1', '{\"title\":\"\\u70b9\\u51fb\\u8fdb\\u5165\\u9996\\u9875\",\"cover\":\"\",\"info\":\"\",\"background\":\"\",\"code\":\"\",\"template_index\":\"ColorV1\",\"template_footer\":\"V1\",\"template_lists\":\"V1\",\"template_detail\":\"V1\"}', '凡星', '0.1', '1448265667', '0', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('163', 'UserCenter', '微信用户中心', '实现3G首页、微信登录，微信用户绑定，微信用户信息初始化等基本功能', '1', '{\"score\":\"100\",\"experience\":\"100\",\"need_bind\":\"1\",\"bind_start\":\"0\",\"jumpurl\":\"\"}', '凡星', '0.1', '1448265671', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('164', 'Exam', '微考试', '主要功能有试卷管理，题目录入管理，考生信息和考分汇总管理。', '1', 'null', '凡星', '0.1', '1448265686', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('165', 'Draw', '比赛抽奖', '功能主要有奖品设置，抽奖配置和抽奖统计', '1', 'null', '凡星', '0.1', '1448265689', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('166', 'Extensions', '融合第三方', '第三方功能扩展', '1', 'null', '凡星', '0.1', '1448265693', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('167', 'Forms', '通用表单', '管理员可以轻松地增加一个表单用于收集用户的信息，如活动报名、调查反馈、预约填单等', '1', 'null', '凡星', '0.1', '1448265695', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('168', 'DeveloperTool', '开发者工具箱', '开发者可以用来调试，监控运营系统的参数', '1', 'null', '凡星', '0.1', '1448265698', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('190', 'YouaskService', '你问我答客服系统', '一个支持你问我答,关键词制定客服的客服系统', '1', '{\"state\":\"0\",\"zrg\":\"\\u4eba\\u5de5\\u5ba2\\u670d\",\"model\":\"1\",\"tcrg\":\"\\u9000\\u51fa\\u4eba\\u5de5\\u5ba2\\u670d\"}', '陌路生人', '0.1', '1448265818', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('191', 'RealPrize', '实物奖励', '实物奖励设置', '1', 'null', 'aManx', '0.1', '1448265822', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('192', 'Xydzp', '幸运大转盘', '网络上最热门的抽奖活动 支持作弊等各种详细配置', '1', '{\"need_trueljinfo\":\"1\"}', '南方卫视', '0.1', '1448265825', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('193', 'Reserve', '微预约', '微预约是商家利用微营销平台实现在线预约的一种服务，可以运用于汽车、房产、酒店、医疗、餐饮等一系列行业，给用户的出行办事、购物、消费带来了极大的便利！且操作简单， 响应速度非常快，受到业界的一致好评！', '1', 'null', '凡星', '0.1', '1448265828', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('188', 'Scratch', '刮刮卡', '刮刮卡', '1', 'null', '凡星', '0.1', '1448265811', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('189', 'Robot', '机器人聊天', '实现的效果如下\r\n用户输入：“机器人学习时间”\r\n微信回复：“你的问题是？”\r\n用户输入：“这个世界上谁最美？”\r\n微信回复： “你的答案是？”\r\n用户回复： “当然是你啦！”\r\n微信回复：“我明白啊，不信你可以问问我”\r\n用户回复：“这个世界上谁最美？”\r\n微信回复：“当然是你啦！”', '1', 'null', '凡星', '0.1', '1448265814', '0', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('169', 'Coupon', '优惠券', '配合粉丝圈子，打造粉丝互动的运营激励基础', '1', 'null', '凡星', '0.1', '1448265702', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('170', 'Guess', '竞猜', '节目竞猜 有奖竞猜 竞猜项目配置', '1', 'null', '无名', '0.1', '1448265704', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('171', 'Comment', '评论互动', '可放到手机界面里进行评论，显示支持弹屏方式', '1', '{\"min_time\":\"30\",\"limit\":\"15\"}', '凡星', '0.1', '1448265708', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('172', 'Game', '互动游戏', '这是一个临时描述', '1', 'null', '凡星', '0.1', '1448265711', '0', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('173', 'ConfigureAccount', '帐号配置', '配置共众帐号的信息', '0', '{\"title\":\"WeiPHP\\u6447\\u7535\\u89c6\",\"id\":\"gh_dd85ac50d2dd\",\"account\":\"weiphp-tv\",\"type\":\"3\",\"logo\":\"\",\"articleurl\":\"\"}', 'manx', '0.1', '1448265714', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('176', 'Ask', '抢答', '用于电视互动答题', '1', '{\"random\":\"1\"}', '凡星', '0.1', '1448265769', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('177', 'BusinessCard', '微名片', '', '1', '{\"random\":\"1\"}', '凡星', '0.1', '1448265772', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('178', 'HelloWorld', '微信入门案例', '这是一个简单的入门案例', '1', 'null', '凡星', '0.1', '1448265779', '0', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('182', 'Vote', '投票', '支持文本和图片两类的投票功能', '1', '{\"random\":\"1\"}', '凡星', '0.1', '1448265793', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('183', 'Sms', '短信服务', '短信服务，短信验证，短信发送', '1', '{\"random\":\"1\"}', 'jacy', '0.1', '1448265796', '0', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('184', 'Survey', '微调研', '实现通用的调研功能，支持单选、多选和简答三种题目的录入', '1', 'null', '凡星', '0.1', '1448265799', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('185', 'Shop', '商城', '支持后台发布商品 banner管理 前端多模板选择 订单管理等', '1', 'null', '凡星', '0.1', '1448265801', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('187', 'WishCard', '微贺卡', 'Diy贺卡 自定贺卡内容 发给好友 后台编辑', '1', 'null', '凡星', '0.1', '1448265808', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('186', 'Wecome', '欢迎语', '用户关注公众号时发送的欢迎信息，支持文本，图片，图文的信息', '1', '{\"type\":\"1\",\"keyword\":\"\",\"title\":\"\",\"description\":\"\",\"pic_url\":\"\",\"url\":\"\",\"appmsg_id\":\"\"}', '凡星', '0.1', '1448265805', '0', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('179', 'Invite', '微邀约', '微邀约适合各行各业，可用于会议邀约、活动邀约，同时实现微信报名人数自动统计等功能。', '1', 'null', '无名', '0.1', '1448265783', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('180', 'Tongji', '统计监控', '统计实时参与摇电视的次数', '1', 'null', '凡星', '0.1', '1448265787', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('181', 'Test', '微测试', '主要功能有问卷管理，题目录入管理，用户信息和得分汇总管理。', '1', 'null', '凡星', '0.1', '1448265790', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('175', 'CardVouchers', '微信卡券', '在微信平台创建卡券后，可配置到这里生成素材提供用户领取，它既支持电视台自己公众号发布的卡券，也支持由商家公众号发布的卡券', '1', 'null', '凡星', '0.1', '1448265766', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('174', 'Chat', '智能聊天', '通过网络上支持的智能API，实现：天气、翻译、藏头诗、笑话、歌词、计算、域名信息/备案/收录查询、IP查询、手机号码归属、人工智能聊天等功能', '1', '{\"tuling_key\":\"d812d695a5e0df258df952698faca6cc\",\"tuling_url\":\"http:\\/\\/www.tuling123.com\\/openapi\\/api\",\"simsim_key\":\"41250a68-3cb5-43c8-9aa2-d7b3caf519b1\",\"simsim_url\":\"http:\\/\\/sandbox.api.simsimi.com\\/request.p\",\"rand_reply\":\"\\r\\n\\u6211\\u4eca\\u5929\\u7d2f\\u4e86\\uff0c\\u660e\\u5929\\u518d\\u966a\\u4f60\\u804a\\u5929\\u5427\\r\\n\\u54c8\\u54c8~~\\r\\n\\u4f60\\u8bdd\\u597d\\u591a\\u554a\\uff0c\\u4e0d\\u8ddf\\u4f60\\u804a\\u4e86\\r\\n\\u867d\\u7136\\u4e0d\\u61c2\\uff0c\\u4f46\\u89c9\\u5f97\\u4f60\\u8bf4\\u5f97\\u5f88\\u5bf9\"}', '凡星', '0.1', '1448265717', '0', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('159', 'CustomMenu', '自定义菜单', '自定义菜单能够帮助公众号丰富界面，让用户更好更快地理解公众号的功能', '1', 'null', '凡星', '0.1', '1448265257', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('194', 'PublicBind', '一键绑定公众号', '', '1', '{\"random\":\"1\",\"ComponentVerifyTicket\":\"ticket@@@y2ENapQDybpEgf6sORyqZyYMNHmwoA_LJnTHU9EmcZKwjaZeyz4UVaS2GNawZ4ODnESWXut3NPExOZJ0MlgQlg\"}', '凡星', '0.1', '1448265831', '0', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('195', 'Payment', '支付通', '微信支付,财富通,支付宝', '1', '{\"isopen\":\"1\",\"isopenwx\":\"1\",\"isopenzfb\":\"0\",\"isopencftwap\":\"0\",\"isopencft\":\"0\",\"isopenyl\":\"0\",\"isopenload\":\"1\"}', '拉帮姐派(陌路生人)', '0.1', '1448265835', '1', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('196', 'Leaflets', '微信宣传页', '微信公众号二维码推广页面，用作推广或者制作广告易拉宝，可以发布到QQ群微博博客论坛等等...', '1', '{\"random\":\"1\"}', '凡星', '0.1', '1448265839', '0', '0', null, '1');
INSERT INTO `wp_addons` VALUES ('197', 'NoAnswer', '没回答的回复', '当用户提供的内容或者关键词系统无关识别回复时，自动把当前配置的内容回复给用户', '1', '{\"random\":\"1\"}', '凡星', '0.1', '1448265842', '0', '0', null, '1');

-- ----------------------------
-- Table structure for wp_addon_category
-- ----------------------------
DROP TABLE IF EXISTS `wp_addon_category`;
CREATE TABLE `wp_addon_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `icon` int(10) unsigned DEFAULT NULL COMMENT '分类图标',
  `title` varchar(255) DEFAULT NULL COMMENT '分类名',
  `sort` int(10) DEFAULT '0' COMMENT '排序号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='插件分类表';

-- ----------------------------
-- Records of wp_addon_category
-- ----------------------------
INSERT INTO `wp_addon_category` VALUES ('1', null, '奖励功能', '4');
INSERT INTO `wp_addon_category` VALUES ('2', null, '互动功能', '3');
INSERT INTO `wp_addon_category` VALUES ('7', '0', '高级功能', '10');
INSERT INTO `wp_addon_category` VALUES ('4', null, '公众号管理', '20');
INSERT INTO `wp_addon_category` VALUES ('8', '0', '用户管理', '1');

-- ----------------------------
-- Table structure for wp_admin
-- ----------------------------
DROP TABLE IF EXISTS `wp_admin`;
CREATE TABLE `wp_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `key` varchar(10) NOT NULL,
  `superadmin` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_admin
-- ----------------------------
INSERT INTO `wp_admin` VALUES ('1', 'admin', '3c1fd4fd06dcaff7fe95b32f7ec02a71', 'abcd', '1');

-- ----------------------------
-- Table structure for wp_analysis
-- ----------------------------
DROP TABLE IF EXISTS `wp_analysis`;
CREATE TABLE `wp_analysis` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sports_id` int(10) DEFAULT NULL COMMENT 'sports_id',
  `type` varchar(30) DEFAULT NULL COMMENT 'type',
  `time` varchar(50) DEFAULT NULL COMMENT 'time',
  `total_count` int(10) DEFAULT '0' COMMENT 'total_count',
  `follow_count` int(10) DEFAULT '0' COMMENT 'follow_count',
  `aver_count` int(10) DEFAULT '0' COMMENT 'aver_count',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_analysis
-- ----------------------------

-- ----------------------------
-- Table structure for wp_article_style
-- ----------------------------
DROP TABLE IF EXISTS `wp_article_style`;
CREATE TABLE `wp_article_style` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `group_id` int(10) DEFAULT '0' COMMENT '分组样式',
  `style` text COMMENT '样式内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_article_style
-- ----------------------------
INSERT INTO `wp_article_style` VALUES ('1', '1', '<section style=\"border: 0px none; padding: 0px; box-sizing: border-box; margin: 0px; font-family: 微软雅黑;\"><section class=\"main\" style=\"border: none rgb(0,187,236); margin: 0.8em 5% 0.3em; box-sizing: border-box; padding: 0px;\"><section class=\"main2 wxqq-color wxqq-bordertopcolor wxqq-borderleftcolor wxqq-borderrightcolor wxqq-borderbottomcolor\" data-brushtype=\"text\" style=\"color: rgb(0,187,236); font-size: 20px; letter-spacing: 3px; padding: 9px 4px 14px; text-align: center; margin: 0px auto; border: 4px solid rgb(0,187,236); border-top-left-radius: 8px; border-top-right-radius: 8px; border-bottom-right-radius: 8px; border-bottom-left-radius: 8px; box-sizing: border-box;\">理念<span class=\"main3 wxqq-color\" data-brushtype=\"text\" style=\"display: block; font-size: 10px; line-height: 12px; border-color: rgb(0,187,236); color: inherit; box-sizing: border-box; padding: 0px; margin: 0px;\">PHILOSOPHY</span></section><section class=\"main4 wxqq-bordertopcolor wxqq-borderbottomcolor\" style=\"width: 0px; margin-right: auto; margin-left: auto; border-top-width: 0.6em; border-top-style: solid; border-bottom-color: rgb(0,187,236); border-top-color: rgb(0,187,236); height: 10px; color: inherit; border-left-width: 0.7em !important; border-left-style: solid !important; border-left-color: transparent !important; border-right-width: 0.7em !important; border-right-style: solid !important; border-right-color: transparent !important; box-sizing: border-box; padding: 0px;\" data-width=\"0px\"></section></section></section>');
INSERT INTO `wp_article_style` VALUES ('2', '3', '<section label=\"Copyright © 2015 playhudong All Rights Reserved.\" style=\"\r\nmargin:1em auto;\r\npadding: 1em 2em;\r\nborder-style: none;\" id=\"shifu_c_001\"><span style=\"\r\nfloat: left;\r\nmargin-left: 19px;\r\nmargin-top: -9px;\r\noverflow: hidden;\r\ndisplay:block;\"><img style=\"\r\nvertical-align: top;\r\ndisplay:inline-block;\" src=\"http://1251001145.cdn.myqcloud.com/1251001145/style/images/card-3.gif\"><section class=\"color\" style=\"\r\nmin-height: 30px;\r\ncolor: #fff;\r\ndisplay: inline-block;\r\ntext-align: center;\r\nbackground: #999999;\r\nfont-size: 15px;\r\npadding: 7px 5px;\r\nmin-width: 30px;\"><span style=\"font-size:15px;\"> 01 </span></section></span><section style=\"\r\npadding: 16px;\r\npadding-top: 28px;\r\nborder: 2px solid #999999;\r\nwidth: 100%;\r\nfont-size: 14px;\r\nline-height: 1.4;\"><span>星期一天气晴我离开你／不带任何行李／除了一本陪我放逐的日记／今天天晴／心情很低／突然决定离开你</span></section></section>');
INSERT INTO `wp_article_style` VALUES ('3', '1', '<section><section class=\"wxqq-borderleftcolor wxqq-borderRightcolor wxqq-bordertopcolor wxqq-borderbottomcolor\" style=\"border:5px solid #A50003;padding:5px;width:100%;\"><section class=\"wxqq-borderleftcolor wxqq-borderRightcolor wxqq-bordertopcolor wxqq-borderbottomcolor\" style=\"border:1px solid #A50003;padding:15px 20px;\"><p style=\"color:#A50003;text-align:center;border-bottom:1px solid #A50003\"><span class=\"wxqq-color\" data-brushtype=\"text\" style=\"font-size:48px\">情人节快乐</span></p><section data-style=\"color:#A50003;text-align:center;font-size:18px\" style=\"color:#A50003;text-align:center;width:96%;margin-left:5px;\"><p class=\"wxqq-color\" style=\"color:#A50003;text-align:center;font-size:18px\">happy valentine\'s day<span style=\"color:inherit; font-size:24px; line-height:1.6em; text-align:right; text-indent:2em\"></span><span style=\"color:rgb(227, 108, 9); font-size:24px; line-height:1.6em; text-align:right; text-indent:2em\"></span></p><section style=\"width:100%;\"><section><section><p style=\"color:#000;text-align:left;\">我们没有秘密，整天花前月下，别人以为我们不懂爱情，我们乐呵呵地笑大人们都太傻。</p></section></section></section></section></section></section></section>');
INSERT INTO `wp_article_style` VALUES ('4', '4', '<p><img src=\"http://www.wxbj.cn//ys/gz/gx2.gif\"></p>');
INSERT INTO `wp_article_style` VALUES ('5', '5', '<section class=\"tn-Powered-by-XIUMI\" style=\"margin-top: 0.5em; margin-bottom: 0.5em; border: none rgb(142, 201, 101); font-size: 14px; font-family: inherit; font-weight: inherit; text-decoration: inherit; color: rgb(142, 201, 101);\"><img data-src=\"http://mmbiz.qpic.cn/mmbiz/4HiaqFGEibVwaxcmNMU5abRHm7bkZ9icUxC3DrlItWpOnXSjEpZXIeIr2K0923xw43aKw8oibucqm8wkMYZvmibqDkg/0?wx_fmt=png\" class=\"tn-Powered-by-XIUMI\" data-type=\"png\" data-ratio=\"0.8055555555555556\" data-w=\"36\" _width=\"2.6em\" src=\"https://mmbiz.qlogo.cn/mmbiz/4HiaqFGEibVwaxcmNMU5abRHm7bkZ9icUxC3DrlItWpOnXSjEpZXIeIr2K0923xw43aKw8oibucqm8wkMYZvmibqDkg/640?wx_fmt=png\" style=\"float: right; width: 2.6em !important; visibility: visible !important; background-color: rgb(142, 201, 101);\"><section class=\"tn-Powered-by-XIUMI\" style=\"clear: both;\"></section><section class=\"tn-Powered-by-XIUMI\" style=\"padding-right: 10px; padding-left: 10px; text-align: center;\"><section class=\"tn-Powered-by-XIUMI\" style=\"text-align: left;\">炎热的夏季，应该吃点什么好呢！我们为您打造7月盛夏美食狂欢季，清暑解渴的热带水果之王【芒果下午茶】，海鲜盛宴上的【生蚝狂欢】，肉食者的天堂【澳洲之夜】，呼朋唤友，户外聚餐的最佳攻略【夏季BBQ】，消暑瘦身利器【迷你冬瓜盅】，清淡亦或重口味，总有一款是你所爱！</section></section><img data-src=\"http://mmbiz.qpic.cn/mmbiz/4HiaqFGEibVwaxcmNMU5abRHm7bkZ9icUxCkEmrfLmAXYYOXO0q4RGYsQqfzhO6SOdoFCTqYqwlS87ovGrQjCYmWw/0?wx_fmt=png\" class=\"tn-Powered-by-XIUMI\" data-type=\"png\" data-ratio=\"0.8055555555555556\" data-w=\"36\" _width=\"2.6em\" src=\"https://mmbiz.qlogo.cn/mmbiz/4HiaqFGEibVwaxcmNMU5abRHm7bkZ9icUxCkEmrfLmAXYYOXO0q4RGYsQqfzhO6SOdoFCTqYqwlS87ovGrQjCYmWw/640?wx_fmt=png\" style=\"width: 2.6em !important; visibility: visible !important; background-color: rgb(142, 201, 101);\"><p><br></p></section>');
INSERT INTO `wp_article_style` VALUES ('8', '6', '<blockquote class=\"wxqq-borderTopColor wxqq-borderRightColor wxqq-borderBottomColor wxqq-borderLeftColor\" style=\"border: 3px dotted rgb(230, 37, 191); padding: 10px; margin: 10px 0px; font-weight: normal; border-top-left-radius: 5px !important; border-top-right-radius: 5px !important; border-bottom-right-radius: 5px !important; border-bottom-left-radius: 5px !important;\"><h3 style=\"color:rgb(89,89,89);font-size:14px;margin:0;\"><span class=\"wxqq-bg\" style=\"background-color: rgb(230, 37, 191); color: rgb(255, 255, 255); padding: 2px 5px; font-size: 14px; margin-right: 15px; border-top-left-radius: 5px !important; border-top-right-radius: 5px !important; border-bottom-right-radius: 5px !important; border-bottom-left-radius: 5px !important;\">微信编辑器</span>微信号：<span class=\"wxqq-bg\" style=\"background-color: rgb(230, 37, 191); color: rgb(255, 255, 255); padding: 2px 5px; font-size: 14px; border-top-left-radius: 5px !important; border-top-right-radius: 5px !important; border-bottom-right-radius: 5px !important; border-bottom-left-radius: 5px !important;\">wxbj.cn</span></h3><p style=\"margin:10px 0 5px 0;\">微信公众号简介，欢迎使用微信在线图文排版编辑器助手！</p></blockquote>');
INSERT INTO `wp_article_style` VALUES ('9', '8', '<p><img src=\"http://www.wxbj.cn/ys/gz/yw1.gif\"></p>');
INSERT INTO `wp_article_style` VALUES ('7', '7', '<p><img src=\"https://mmbiz.qlogo.cn/mmbiz/cZV2hRpuAPhuxibIOsThcH7HF1lpQ0Yvkvh88U3ia9AbTPJSmriawnJ7W7S5iblSlSianbHLGO6IvD0N4g2y2JEFRoA/0/mmbizgif\"></p>');

-- ----------------------------
-- Table structure for wp_article_style_group
-- ----------------------------
DROP TABLE IF EXISTS `wp_article_style_group`;
CREATE TABLE `wp_article_style_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `group_name` varchar(255) DEFAULT NULL COMMENT '分组名称',
  `desc` text COMMENT '说明',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_article_style_group
-- ----------------------------
INSERT INTO `wp_article_style_group` VALUES ('1', '标题', '标题样式');
INSERT INTO `wp_article_style_group` VALUES ('3', '卡片', '类卡片样式');
INSERT INTO `wp_article_style_group` VALUES ('4', '关注', '引导关注公众号的样式');
INSERT INTO `wp_article_style_group` VALUES ('5', '内容', '内容样式');
INSERT INTO `wp_article_style_group` VALUES ('6', '互推', '互推公众号的样式');
INSERT INTO `wp_article_style_group` VALUES ('7', '分割', '分割样式');
INSERT INTO `wp_article_style_group` VALUES ('8', '原文引导', '原文引导样式');

-- ----------------------------
-- Table structure for wp_ask
-- ----------------------------
DROP TABLE IF EXISTS `wp_ask`;
CREATE TABLE `wp_ask` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` varchar(100) NOT NULL COMMENT '关键词',
  `keyword_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '关键词类型',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `intro` text COMMENT '封面简介',
  `mTime` int(10) DEFAULT NULL COMMENT '修改时间',
  `cover` int(10) unsigned DEFAULT NULL COMMENT '封面图片',
  `cTime` int(10) unsigned DEFAULT NULL COMMENT '发布时间',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `finish_tip` text COMMENT '结束语',
  `content` text COMMENT '活动介绍',
  `shop_address` text COMMENT '商家地址',
  `appids` text COMMENT '提示关注的公众号',
  `finish_button` text COMMENT '成功抢答完后显示的按钮',
  `card_id` varchar(255) DEFAULT NULL COMMENT '卡券ID',
  `appsecre` varchar(255) DEFAULT NULL COMMENT '卡券对应的appsecre',
  `template` varchar(255) DEFAULT 'default' COMMENT '素材模板',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_ask
-- ----------------------------

-- ----------------------------
-- Table structure for wp_ask_answer
-- ----------------------------
DROP TABLE IF EXISTS `wp_ask_answer`;
CREATE TABLE `wp_ask_answer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `answer` text COMMENT '回答内容',
  `openid` varchar(255) DEFAULT NULL COMMENT 'OpenId',
  `uid` int(10) DEFAULT NULL COMMENT '用户UID',
  `question_id` int(10) unsigned NOT NULL COMMENT 'question_id',
  `cTime` int(10) unsigned DEFAULT NULL COMMENT '发布时间',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `ask_id` int(10) unsigned NOT NULL COMMENT 'ask_id',
  `is_correct` tinyint(2) DEFAULT '1' COMMENT '是否回答正确',
  `times` int(4) DEFAULT '0' COMMENT '次数',
  PRIMARY KEY (`id`),
  KEY `ask_id_uid` (`ask_id`,`uid`),
  KEY `question_uid` (`uid`,`question_id`,`times`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_ask_answer
-- ----------------------------

-- ----------------------------
-- Table structure for wp_ask_question
-- ----------------------------
DROP TABLE IF EXISTS `wp_ask_question`;
CREATE TABLE `wp_ask_question` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `intro` text COMMENT '问题描述',
  `cTime` int(10) unsigned DEFAULT NULL COMMENT '发布时间',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `is_must` tinyint(2) DEFAULT '1' COMMENT '是否必填',
  `extra` text NOT NULL COMMENT '参数',
  `type` char(50) NOT NULL DEFAULT 'radio' COMMENT '问题类型',
  `ask_id` int(10) unsigned NOT NULL COMMENT 'ask_id',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序号',
  `answer` varchar(255) NOT NULL COMMENT '正确答案',
  `is_last` tinyint(2) DEFAULT '0' COMMENT '是否最后一题',
  `wait_time` int(10) DEFAULT '0' COMMENT '等待时间',
  `percent` int(10) DEFAULT '100' COMMENT '抢中概率',
  `answer_time` int(10) DEFAULT NULL COMMENT '答题时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_ask_question
-- ----------------------------

-- ----------------------------
-- Table structure for wp_attachment
-- ----------------------------
DROP TABLE IF EXISTS `wp_attachment`;
CREATE TABLE `wp_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) DEFAULT '0' COMMENT '用户ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '附件显示名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件类型',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资源ID',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联记录ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '上级目录ID',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表';

-- ----------------------------
-- Records of wp_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for wp_attribute
-- ----------------------------
DROP TABLE IF EXISTS `wp_attribute`;
CREATE TABLE `wp_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `extra` text NOT NULL COMMENT '参数',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `validate_rule` varchar(255) NOT NULL DEFAULT '',
  `validate_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `error_info` varchar(100) NOT NULL DEFAULT '',
  `validate_type` varchar(25) NOT NULL DEFAULT '',
  `auto_rule` varchar(100) NOT NULL DEFAULT '',
  `auto_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `auto_type` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `model_id` (`model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12153 DEFAULT CHARSET=utf8 COMMENT='模型属性表';

-- ----------------------------
-- Records of wp_attribute
-- ----------------------------
INSERT INTO `wp_attribute` VALUES ('5', 'nickname', '用户名', 'text NULL', 'string', '', '', '0', '', '1', '1', '1', '1447302832', '1436929161', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('6', 'password', '登录密码', 'varchar(100) NULL', 'string', '', '', '0', '', '1', '0', '1', '1447302859', '1436929210', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('7', 'truename', '真实姓名', 'varchar(30) NULL', 'string', '', '', '0', '', '1', '0', '1', '1447302886', '1436929252', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('8', 'mobile', '联系电话', 'varchar(30) NULL', 'string', '', '', '0', '', '1', '0', '1', '1447302825', '1436929280', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('9', 'email', '邮箱地址', 'varchar(100) NULL', 'string', '', '', '0', '', '1', '0', '1', '1447302817', '1436929305', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('10', 'sex', '性别', 'tinyint(2) NULL', 'radio', '', '', '0', '0:保密\r\n1:男\r\n2:女', '1', '0', '1', '1447302800', '1436929397', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11', 'headimgurl', '头像地址', 'varchar(255) NULL', 'string', '', '', '0', '', '1', '0', '1', '1447302811', '1436929482', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12', 'city', '城市', 'varchar(30) NULL', 'string', '', '', '0', '', '1', '0', '1', '1447302793', '1436929506', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('13', 'province', '省份', 'varchar(30) NULL', 'string', '', '', '0', '', '1', '0', '1', '1447302787', '1436929524', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('14', 'country', '国家', 'varchar(30) NULL', 'string', '', '', '0', '', '1', '0', '1', '1447302781', '1436929541', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('15', 'language', '语言', 'varchar(20) NULL', 'string', 'zh-cn', '', '0', '', '1', '0', '1', '1447302725', '1436929571', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('16', 'score', '金币值', 'int(10) NULL', 'num', '0', '', '0', '', '1', '0', '1', '1447302731', '1436929597', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('17', 'experience', '经验值', 'int(10) NULL', 'num', '0', '', '0', '', '1', '0', '1', '1447302738', '1436929619', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('18', 'unionid', '微信第三方ID', 'varchar(50) NULL', 'string', '', '', '0', '', '1', '0', '1', '1447302717', '1436929681', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('19', 'login_count', '登录次数', 'int(10) NULL', 'num', '0', '', '0', '', '1', '0', '1', '1447302710', '1436930011', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('20', 'reg_ip', '注册IP', 'varchar(30) NULL', 'string', '', '', '0', '', '1', '0', '1', '1447302746', '1436930035', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('21', 'reg_time', '注册时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1', '0', '1', '1447302754', '1436930051', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('22', 'last_login_ip', '最近登录IP', 'varchar(30) NULL', 'string', '', '', '0', '', '1', '0', '1', '1447302761', '1436930072', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('23', 'last_login_time', '最近登录时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1', '0', '1', '1447302770', '1436930087', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('24', 'status', '状态', 'tinyint(2) NULL', 'bool', '1', '', '0', '0:禁用\r\n1:启用', '1', '0', '1', '1447302703', '1436930138', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('25', 'is_init', '初始化状态', 'tinyint(2) NULL', 'bool', '0', '', '0', '0:未初始化\r\n1:已初始化', '1', '0', '1', '1447302696', '1436930184', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('26', 'is_audit', '审核状态', 'tinyint(2) NULL', 'bool', '0', '', '0', '0:未审核\r\n1:已审核', '1', '0', '1', '1447302688', '1436930216', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('27', 'subscribe_time', '用户关注公众号时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1', '0', '1', '1437720655', '1437720655', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('28', 'remark', '微信用户备注', 'varchar(100) NULL', 'string', '', '', '0', '', '1', '0', '1', '1437720686', '1437720686', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('29', 'groupid', '微信端的分组ID', 'int(10) NULL', 'num', '', '', '0', '', '1', '0', '1', '1437720714', '1437720714', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('4', 'come_from', '来源', 'tinyint(1) NULL', 'select', '0', '', '0', '0:PC注册用户\r\n1:微信同步用户\r\n2:手机注册用户', '1', '0', '1', '1447302852', '1438331357', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('31', 'uid', '用户ID', 'int(10) NULL', 'num', '', '', '1', '', '2', '1', '1', '1436932588', '1436932588', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('32', 'has_public', '是否配置公众号', 'tinyint(2) NULL', 'bool', '0', '', '1', '0:否\r\n1:是', '2', '0', '1', '1436933464', '1436933464', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('33', 'headface_url', '管理员头像', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '2', '0', '1', '1436933503', '1436933503', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('34', 'GammaAppId', '摇电视的AppId', 'varchar(30) NULL', 'string', '', '', '1', '', '2', '0', '1', '1436933562', '1436933562', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('35', 'GammaSecret', '摇电视的Secret', 'varchar(100) NULL', 'string', '', '', '1', '', '2', '0', '1', '1436933602', '1436933602', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('36', 'copy_right', '授权信息', 'varchar(255) NULL', 'string', '', '', '1', '', '2', '0', '1', '1436933690', '1436933690', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('37', 'tongji_code', '统计代码', 'text NULL', 'textarea', '', '', '1', '', '2', '0', '1', '1436933778', '1436933778', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('38', 'website_logo', '网站LOGO', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '2', '0', '1', '1436934006', '1436934006', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('39', 'menu_type', '菜单类型', 'tinyint(2) NULL', 'bool', '0', '', '1', '0:顶级菜单|pid@hide\r\n1:侧栏菜单|pid@show', '3', '0', '1', '1435218508', '1435216049', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('40', 'pid', '上级菜单', 'varchar(50) NULL', 'cascade', '0', '', '1', 'type=db&table=manager_menu&menu_type=0&uid=[manager_id]', '3', '0', '1', '1438858450', '1435216147', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('41', 'title', '菜单名', 'varchar(50) NULL', 'string', '', '', '1', '', '3', '1', '1', '1435216185', '1435216185', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('42', 'url_type', '链接类型', 'tinyint(2) NULL', 'bool', '0', '', '1', '0:插件|addon_name@show,url@hide\r\n1:外链|addon_name@hide,url@show', '3', '0', '1', '1435218596', '1435216291', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('43', 'addon_name', '插件名', 'varchar(30) NULL', 'dynamic_select', '', '', '1', 'table=addons&type=0&value_field=name&title_field=title&order=id asc', '3', '0', '1', '1439433250', '1435216373', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('44', 'url', '外链', 'varchar(255) NULL', 'string', '', '', '1', '', '3', '0', '1', '1435216436', '1435216436', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('45', 'target', '打开方式', 'char(50) NULL', 'select', '_self', '', '1', '_self:当前窗口打开\r\n_blank:在新窗口打开', '3', '0', '1', '1435216626', '1435216626', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('46', 'is_hide', '是否隐藏', 'tinyint(2) NULL', 'radio', '0', '', '1', '0:否\r\n1:是', '3', '0', '1', '1435216697', '1435216697', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('47', 'sort', '排序号', 'int(10) NULL', 'num', '0', '值越小越靠前', '1', '', '3', '0', '1', '1435217270', '1435217270', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('48', 'uid', '管理员ID', 'int(10) NULL', 'num', '', '', '4', '', '3', '0', '1', '1435224916', '1435223957', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('49', 'keyword', '关键词', 'varchar(100) NOT NULL ', 'string', '', '', '1', '', '4', '1', '1', '1388815953', '1388815953', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('50', 'addon', '关键词所属插件', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '4', '1', '1', '1388816207', '1388816207', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('51', 'aim_id', '插件表里的ID值', 'int(10) unsigned NOT NULL ', 'num', '', '', '1', '', '4', '1', '1', '1388816287', '1388816287', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('52', 'cTime', '创建时间', 'int(10) NULL', 'datetime', '', '', '0', '', '4', '0', '1', '1407251221', '1388816392', '', '1', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('53', 'token', 'Token', 'varchar(100) NULL ', 'string', '', '', '0', '', '4', '0', '1', '1408945788', '1391399528', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('54', 'keyword_length', '关键词长度', 'int(10) unsigned NULL ', 'num', '0', '', '1', '', '4', '0', '1', '1407251147', '1393918566', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('55', 'keyword_type', '匹配类型', 'tinyint(2) NULL ', 'select', '0', '', '1', '0:完全匹配\r\n1:左边匹配\r\n2:右边匹配\r\n3:模糊匹配\r\n4:正则匹配\r\n5:随机匹配', '4', '0', '1', '1417745067', '1393919686', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('56', 'extra_text', '文本扩展', 'text NULL ', 'textarea', '', '', '0', '', '4', '0', '1', '1407251248', '1393919736', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('57', 'extra_int', '数字扩展', 'int(10) NULL ', 'num', '', '', '0', '', '4', '0', '1', '1407251240', '1393919798', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('58', 'request_count', '请求数', 'int(10) NULL', 'num', '0', '用户回复的次数', '0', '', '4', '0', '1', '1401938983', '1401938983', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('59', 'qr_code', '二维码', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '5', '1', '1', '1406127577', '1388815953', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('60', 'addon', '二维码所属插件', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '5', '1', '1', '1406127594', '1388816207', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('61', 'aim_id', '插件表里的ID值', 'int(10) unsigned NOT NULL ', 'num', '', '', '1', '', '5', '1', '1', '1388816287', '1388816287', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('62', 'cTime', '创建时间', 'int(10) NULL', 'datetime', '', '', '1', '', '5', '0', '1', '1388816392', '1388816392', '', '1', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('63', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '5', '0', '1', '1391399528', '1391399528', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('64', 'action_name', '二维码类型', 'char(30) NULL', 'select', 'QR_SCENE', 'QR_SCENE为临时,QR_LIMIT_SCENE为永久 ', '1', 'QR_SCENE:临时二维码\r\nQR_LIMIT_SCENE:永久二维码', '5', '0', '1', '1406130162', '1393919686', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('65', 'extra_text', '文本扩展', 'text NULL ', 'textarea', '', '', '1', '', '5', '0', '1', '1393919736', '1393919736', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('66', 'extra_int', '数字扩展', 'int(10) NULL ', 'num', '', '', '1', '', '5', '0', '1', '1393919798', '1393919798', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('67', 'request_count', '请求数', 'int(10) NULL', 'num', '0', '用户回复的次数', '0', '', '5', '0', '1', '1402547625', '1401938983', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('68', 'scene_id', '场景ID', 'int(10) NULL', 'num', '0', '', '1', '', '5', '0', '1', '1406127542', '1406127542', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('69', 'is_use', '是否为当前公众号', 'tinyint(2) NULL', 'bool', '0', '', '0', '0:否\r\n1:是', '6', '0', '1', '1391682184', '1391682184', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('70', 'token', 'Token', 'varchar(100) NULL', 'string', '', '', '0', '', '6', '0', '1', '1402453598', '1391597344', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('71', 'uid', '用户ID', 'int(10) NULL ', 'num', '', '', '0', '', '6', '1', '1', '1391575873', '1391575210', '', '3', '', 'regex', 'get_mid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('72', 'public_name', '公众号名称', 'varchar(50) NOT NULL', 'string', '', '', '1', '', '6', '1', '1', '1391576452', '1391575955', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('73', 'public_id', '公众号原始id', 'varchar(100) NOT NULL', 'string', '', '请正确填写，保存后不能再修改，且无法接收到微信的信息', '1', '', '6', '1', '1', '1402453976', '1391576015', '', '1', '公众号原始ID已经存在，请不要重复增加', 'unique', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('74', 'wechat', '微信号', 'varchar(100) NOT NULL', 'string', '', '', '1', '', '6', '1', '1', '1391576484', '1391576144', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('75', 'interface_url', '接口地址', 'varchar(255) NULL', 'string', '', '', '0', '', '6', '0', '1', '1392946881', '1391576234', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('76', 'headface_url', '公众号头像', 'varchar(255) NULL', 'picture', '', '', '1', '', '6', '0', '1', '1429847363', '1391576300', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('77', 'area', '地区', 'varchar(50) NULL', 'string', '', '', '0', '', '6', '0', '1', '1392946934', '1391576435', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('78', 'addon_config', '插件配置', 'text NULL', 'textarea', '', '', '0', '', '6', '0', '1', '1391576537', '1391576537', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('79', 'addon_status', '插件状态', 'text NULL', 'textarea', '', '', '0', '160:自定义回复\r\n161:自动回复\r\n162:微官网\r\n163:微信用户中心\r\n164:微考试\r\n165:比赛抽奖\r\n166:融合第三方\r\n167:通用表单\r\n168:开发者工具箱\r\n190:你问我答客服系统\r\n191:实物奖励\r\n192:幸运大转盘\r\n193:微预约\r\n188:刮刮卡\r\n189:机器人聊天\r\n169:优惠券\r\n170:竞猜\r\n171:评论互动\r\n172:互动游戏\r\n176:抢答\r\n177:微名片\r\n178:微信入门案例\r\n182:投票\r\n183:短信服务\r\n184:微调研\r\n185:商城\r\n187:微贺卡\r\n186:欢迎语\r\n179:微邀约\r\n180:统计监控\r\n181:微测试\r\n175:微信卡券\r\n174:智能聊天\r\n159:自定义菜单\r\n194:一键绑定公众号\r\n195:支付通\r\n196:微信宣传页\r\n197:没回答的回复\r\n', '6', '0', '1', '1391576571', '1391576571', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11269', 'keyword', '关键词', 'varchar(255) NULL', 'string', '', '', '1', '', '1143', '0', '1', '1396602514', '1396602514', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11270', 'keyword_type', '关键词类型', 'tinyint(2) NULL', 'select', '0', '', '1', '0:完全匹配\r\n1:左边匹配\r\n2:右边匹配\r\n3:模糊匹配\r\n4:正则匹配\r\n5:随机匹配', '1143', '0', '1', '1396602706', '1396602548', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11271', 'mult_ids', '多图文ID', 'varchar(255) NULL', 'string', '', '', '0', '', '1143', '0', '1', '1396602601', '1396602578', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11272', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1143', '0', '1', '1396602821', '1396602821', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11273', 'keyword', '关键词', 'varchar(100) NOT NULL', 'string', '', '', '1', '', '1144', '1', '1', '1396061575', '1396061575', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('80', 'type', '公众号类型', 'char(10) NULL', 'radio', '0', '', '1', '0:普通订阅号\r\n1:认证订阅号/普通服务号\r\n2:认证服务号', '6', '0', '1', '1416904702', '1393718575', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('81', 'appid', 'AppID', 'varchar(255) NULL', 'string', '', '应用ID', '1', '', '6', '0', '1', '1416904750', '1393718735', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('82', 'secret', 'AppSecret', 'varchar(255) NULL', 'string', '', '应用密钥', '1', '', '6', '0', '1', '1416904771', '1393718806', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('83', 'group_id', '等级', 'int(10) unsigned NULL ', 'select', '0', '', '0', '', '6', '0', '1', '1393753499', '1393724468', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('84', 'is_audit', '是否审核', 'tinyint(2) NULL', 'bool', '0', '', '0', '0:否\r\n1:是', '6', '1', '1', '1430879018', '1430879007', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('85', 'is_init', '是否初始化', 'tinyint(2) NULL', 'bool', '0', '', '0', '0:否\r\n1:是', '6', '1', '1', '1430888244', '1430878899', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('86', 'encodingaeskey', 'EncodingAESKey', 'varchar(255) NULL', 'string', '', '安全模式下必填', '1', '', '6', '0', '1', '1419775850', '1419775850', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('87', 'tips_url', '提示关注公众号的文章地址', 'varchar(255) NULL', 'string', '', '', '1', '', '6', '0', '1', '1420789769', '1420789769', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('88', 'GammaAppId', 'GammaAppId', 'varchar(255) NULL', 'string', '', '', '1', '', '6', '0', '1', '1424529968', '1424529968', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('89', 'GammaSecret', 'GammaSecret', 'varchar(255) NULL', 'string', '', '', '1', '', '6', '0', '1', '1424529990', '1424529990', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('90', 'public_copy_right', '版权信息', 'varchar(255) NULL', 'string', '', '', '1', '', '6', '0', '1', '1431141576', '1431141576', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('91', 'domain', '自定义域名', 'varchar(30) NULL', 'string', '', '', '0', '', '6', '0', '1', '1439698931', '1439698931', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('92', 'title', '等级名', 'varchar(50) NULL', 'string', '', '', '1', '', '7', '0', '1', '1393724854', '1393724854', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('93', 'addon_status', '插件权限', 'text NULL', 'checkbox', '', '', '1', '160:自定义回复\r\n161:自动回复\r\n162:微官网\r\n163:微信用户中心\r\n164:微考试\r\n165:比赛抽奖\r\n166:融合第三方\r\n167:通用表单\r\n168:开发者工具箱\r\n190:你问我答客服系统\r\n191:实物奖励\r\n192:幸运大转盘\r\n193:微预约\r\n188:刮刮卡\r\n189:机器人聊天\r\n169:优惠券\r\n170:竞猜\r\n171:评论互动\r\n172:互动游戏\r\n176:抢答\r\n177:微名片\r\n178:微信入门案例\r\n182:投票\r\n183:短信服务\r\n184:微调研\r\n185:商城\r\n187:微贺卡\r\n186:欢迎语\r\n179:微邀约\r\n180:统计监控\r\n181:微测试\r\n175:微信卡券\r\n174:智能聊天\r\n159:自定义菜单\r\n194:一键绑定公众号\r\n195:支付通\r\n196:微信宣传页\r\n197:没回答的回复\r\n', '7', '0', '1', '1393731903', '1393725072', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11314', 'pid', '一级目录', 'int(10) NULL', 'cascade', '0', '', '1', 'type=db&table=weisite_category&pid=id', '1148', '0', '1', '1439522271', '1439469294', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11315', 'keyword', '关键词', 'varchar(100) NOT NULL', 'string', '', '', '1', '', '1149', '1', '1', '1396061575', '1396061575', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11316', 'keyword_type', '关键词类型', 'tinyint(2) NULL', 'select', '', '', '1', '0:完全匹配\r\n1:左边匹配\r\n2:右边匹配\r\n3:模糊匹配\r\n4:正则匹配\r\n5:随机匹配', '1149', '0', '1', '1396061814', '1396061765', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('94', 'uid', '管理员UID', 'int(10) NULL ', 'admin', '', '', '1', '', '8', '1', '1', '1447215599', '1398933236', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('95', 'mp_id', '公众号ID', 'int(10) unsigned NOT NULL ', 'num', '', '', '4', '', '8', '1', '1', '1398933300', '1398933300', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('96', 'is_creator', '是否为创建者', 'tinyint(2) NULL', 'bool', '0', '', '0', '0:不是\r\n1:是', '8', '0', '1', '1398933380', '1398933380', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('97', 'addon_status', '插件权限', 'text NULL', 'checkbox', '', '', '1', '160:自定义回复\r\n161:自动回复\r\n162:微官网\r\n163:微信用户中心\r\n164:微考试\r\n165:比赛抽奖\r\n166:融合第三方\r\n167:通用表单\r\n168:开发者工具箱\r\n190:你问我答客服系统\r\n191:实物奖励\r\n192:幸运大转盘\r\n193:微预约\r\n188:刮刮卡\r\n189:机器人聊天\r\n169:优惠券\r\n170:竞猜\r\n171:评论互动\r\n172:互动游戏\r\n176:抢答\r\n177:微名片\r\n178:微信入门案例\r\n182:投票\r\n183:短信服务\r\n184:微调研\r\n185:商城\r\n187:微贺卡\r\n186:欢迎语\r\n179:微邀约\r\n180:统计监控\r\n181:微测试\r\n175:微信卡券\r\n174:智能聊天\r\n159:自定义菜单\r\n194:一键绑定公众号\r\n195:支付通\r\n196:微信宣传页\r\n197:没回答的回复\r\n', '8', '0', '1', '1398933475', '1398933475', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11309', 'icon', '分类图片', 'int(10) unsigned NULL ', 'picture', '', '', '1', '', '1148', '0', '1', '1395988966', '1395988966', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11310', 'url', '外链', 'varchar(255) NULL', 'string', '', '为空时默认跳转到该分类的文章列表页面', '1', '', '1148', '0', '1', '1401408363', '1395989660', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11311', 'is_show', '显示', 'tinyint(2) NULL', 'bool', '1', '', '1', '0: 不显示\r\n1: 显示', '1148', '0', '1', '1395989709', '1395989709', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11312', 'token', 'Token', 'varchar(100) NULL ', 'string', '', '', '0', '', '1148', '0', '1', '1395989760', '1395989760', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('98', 'is_use', '是否为当前管理的公众号', 'tinyint(2) NULL', 'bool', '0', '', '0', '0:不是\r\n1:是', '8', '0', '1', '1398996982', '1398996975', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('99', 'attach', '上传文件', 'int(10) unsigned NOT NULL ', 'file', '', '支持xls,xlsx两种格式', '1', '', '9', '1', '1', '1407554177', '1407554177', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('100', 'icon', '分类图标', 'int(10) unsigned NULL ', 'picture', '', '', '1', '', '10', '0', '1', '1400047745', '1400047745', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('101', 'title', '分类名', 'varchar(255) NULL', 'string', '', '', '1', '', '10', '0', '1', '1400047764', '1400047764', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('102', 'sort', '排序号', 'int(10) NULL', 'num', '0', '值越小越靠前', '1', '', '10', '0', '1', '1400050453', '1400047786', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12064', 'uid', '用户uid', 'int(10) NULL', 'num', '', '', '0', '', '1230', '0', '1', '1445255505', '1445255505', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12065', 'aim_id', 'aim_id', 'int(10) NULL', 'num', '', '', '0', '', '1230', '0', '1', '1445253482', '1445253482', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12063', 'status', '支付状态', 'tinyint(2) NOT NULL', 'bool', '0', '', '1', '0:未支付\r\n1:已支付\r\n2:支付失败', '1230', '0', '1', '1420597026', '1420597026', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12062', 'showwxpaytitle', '是否显示标题', 'tinyint(2) NOT NULL', 'bool', '0', '', '1', '0:不显示\r\n1:显示', '1230', '0', '1', '1420596980', '1420596980', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12061', 'paytype', '支付方式', 'varchar(30) NOT NULL', 'string', '', '', '1', '', '1230', '0', '1', '1420596929', '1420596929', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12060', 'wecha_id', 'OpenID', 'varchar(200) NOT NULL', 'string', '', '', '1', '', '1230', '0', '1', '1420596530', '1420596530', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12059', 'token', 'Token', 'varchar(100) NOT NULL', 'string', '', '', '1', '', '1230', '0', '1', '1420596492', '1420596492', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('110', 'name', '分类标识', 'varchar(255) NULL', 'string', '', '只能使用英文', '0', '', '12', '0', '1', '1403711345', '1397529355', '', '3', '只能输入由数字、26个英文字母或者下划线组成的标识名', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('111', 'title', '分类标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '12', '1', '1', '1397529407', '1397529407', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('112', 'icon', '分类图标', 'int(10) unsigned NULL ', 'picture', '', '', '1', '', '12', '0', '1', '1397529461', '1397529461', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('113', 'pid', '上一级分类', 'int(10) unsigned NULL ', 'select', '0', '如果你要增加一级分类，这里选择“无”即可', '1', '0:无', '12', '0', '1', '1398266132', '1397529555', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('114', 'path', '分类路径', 'varchar(255) NULL', 'string', '', '', '0', '', '12', '0', '1', '1397529604', '1397529604', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('115', 'module', '分类所属功能', 'varchar(255) NULL', 'string', '', '', '0', '', '12', '0', '1', '1397529671', '1397529671', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('116', 'sort', '排序号', 'int(10) unsigned NULL ', 'num', '0', '数值越小越靠前', '1', '', '12', '0', '1', '1397529705', '1397529705', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('117', 'is_show', '是否显示', 'tinyint(2) NULL', 'bool', '1', '', '1', '0:不显示\r\n1:显示', '12', '0', '1', '1397532496', '1397529809', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('118', 'intro', '分类描述', 'varchar(255) NULL', 'string', '', '', '1', '', '12', '0', '1', '1398414247', '1398414247', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('119', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '12', '0', '1', '1398593086', '1398523502', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('120', 'code', '分类扩展编号', 'varchar(255) NULL', 'string', '', '原分类或者导入分类的扩展编号', '0', '', '12', '0', '1', '1404182741', '1404182630', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('121', 'cTime', '发布时间', 'int(10) UNSIGNED NULL', 'datetime', '', '', '0', '', '13', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('122', 'name', '分组标识', 'varchar(100) NOT NULL', 'string', '', '英文字母或者下划线，长度不超过30', '1', '', '13', '1', '1', '1403624543', '1396061575', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('123', 'title', '分组标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '13', '1', '1', '1403624556', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('124', 'level', '最多级数', 'tinyint(1) unsigned NULL', 'select', '3', '', '1', '1:1级\r\n2:2级\r\n3:3级\r\n4:4级\r\n5:5级\r\n6:6级\r\n7:7级', '13', '0', '1', '1404193097', '1404192897', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('125', 'token', 'Token', 'varchar(100) NULL', 'string', '', '', '0', '', '13', '1', '1', '1408947244', '1396602859', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('126', 'title', '积分描述', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '14', '1', '1', '1438589622', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('127', 'name', '积分标识', 'varchar(50) NULL', 'string', '', '', '1', '', '14', '0', '1', '1438589601', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('128', 'mTime', '修改时间', 'int(10) NULL', 'datetime', '', '', '0', '', '14', '0', '1', '1396624664', '1396624664', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('129', 'experience', '经验值', 'int(10) NULL', 'num', '0', '可以是正数，也可以是负数，如 -10 表示减10个经验值', '1', '', '14', '0', '1', '1398564024', '1396062093', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('130', 'score', '金币值', 'int(10) NULL', 'num', '0', '可以是正数，也可以是负数，如 -10 表示减10个金币值', '1', '', '14', '0', '1', '1398564097', '1396062146', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('131', 'token', 'Token', 'varchar(255) NULL', 'string', '0', '', '0', '', '14', '0', '1', '1398564146', '1396602859', '', '3', '', 'regex', '', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('132', 'credit_name', '积分标识', 'varchar(50) NULL', 'string', '', '', '1', '', '15', '0', '1', '1398564405', '1398564405', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('133', 'uid', '用户ID', 'int(10) NULL', 'num', '0', '', '1', '', '15', '0', '1', '1398564351', '1398564351', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('134', 'experience', '经验值', 'int(10) NULL', 'num', '0', '', '1', '', '15', '0', '1', '1398564448', '1398564448', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('135', 'score', '金币值', 'int(10) NULL', 'num', '0', '', '1', '', '15', '0', '1', '1398564486', '1398564486', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('136', 'cTime', '记录时间', 'int(10) NULL', 'datetime', '', '', '0', '', '15', '0', '1', '1398564567', '1398564567', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('137', 'admin_uid', '操作者UID', 'int(10) NULL', 'num', '0', '', '0', '', '15', '0', '1', '1398564629', '1398564629', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('138', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '15', '0', '1', '1400603451', '1400603451', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('139', 'cover_id', '图片在本地的ID', 'int(10) NULL', 'num', '', '', '0', '', '16', '0', '1', '1438684652', '1438684652', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('140', 'cover_url', '本地URL', 'varchar(255) NULL', 'string', '', '', '0', '', '16', '0', '1', '1438684692', '1438684692', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('141', 'media_id', '微信端图文消息素材的media_id', 'varchar(100) NULL', 'string', '0', '', '0', '', '16', '0', '1', '1438744962', '1438684776', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('142', 'wechat_url', '微信端的图片地址', 'varchar(255) NULL', 'string', '', '', '0', '', '16', '0', '1', '1439973558', '1438684807', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('143', 'cTime', '创建时间', 'int(10) NULL', 'datetime', '', '', '0', '', '16', '0', '1', '1438684829', '1438684829', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('144', 'manager_id', '管理员ID', 'int(10) NULL', 'num', '', '', '0', '', '16', '0', '1', '1438684847', '1438684847', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('145', 'token', 'Token', 'varchar(100) NULL', 'string', '', '', '0', '', '16', '0', '1', '1438684865', '1438684865', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('146', 'title', '标题', 'varchar(100) NULL', 'string', '', '', '1', '', '17', '1', '1', '1438670933', '1438670933', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('147', 'author', '作者', 'varchar(30) NULL', 'string', '', '', '1', '', '17', '0', '1', '1438670961', '1438670961', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('148', 'cover_id', '封面', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '17', '0', '1', '1438674438', '1438670980', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('149', 'intro', '摘要', 'varchar(255) NULL', 'textarea', '', '', '1', '', '17', '0', '1', '1438671024', '1438671024', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('150', 'content', '内容', 'longtext  NULL', 'editor', '', '', '1', '', '17', '0', '1', '1440473839', '1438671049', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('151', 'link', '外链', 'varchar(255) NULL', 'string', '', '', '1', '', '17', '0', '1', '1438671066', '1438671066', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('152', 'group_id', '多图文组的ID', 'int(10) NULL', 'num', '0', '0 表示单图文，多于0 表示多图文中的第一个图文的ID值', '0', '', '17', '0', '1', '1438671163', '1438671163', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('153', 'thumb_media_id', '图文消息的封面图片素材id（必须是永久mediaID）', 'varchar(100) NULL', 'string', '', '', '0', '', '17', '0', '1', '1438671302', '1438671285', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('154', 'media_id', '微信端图文消息素材的media_id', 'varchar(100) NULL', 'string', '0', '', '1', '', '17', '0', '1', '1438744941', '1438671373', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('155', 'manager_id', '管理员ID', 'int(10) NULL', 'num', '', '', '0', '', '17', '0', '1', '1438683172', '1438683172', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('156', 'token', 'Token', 'varchar(100) NULL', 'string', '', '', '0', '', '17', '0', '1', '1438683194', '1438683194', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('157', 'cTime', '发布时间', 'int(10) NULL', 'datetime', '', '', '0', '', '17', '0', '1', '1438683499', '1438683499', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('158', 'bind_keyword', '关联关键词', 'varchar(50) NULL', 'string', '', '先在自定义回复里增加图文，多图文或者文本内容，再把它的关键词填写到这里', '1', '', '18', '0', '1', '1437984209', '1437984184', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('159', 'preview_openids', '预览人OPENID', 'text NULL', 'textarea', '', '选填，多个可用逗号或者换行分开，OpenID值可在微信用户的列表中找到', '1', '', '18', '0', '1', '1438049470', '1437985038', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('160', 'group_id', '群发对象', 'int(10) NULL', 'dynamic_select', '0', '全部用户或者某分组用户', '1', 'table=auth_group&manager_id=[manager_id]&token=[token]&value_field=id&title_field=title&first_option=全部用户', '18', '0', '1', '1438049058', '1437985498', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('161', 'type', '素材来源', 'tinyint(2) NULL', 'bool', '0', '', '1', '0:站内关键词|bind_keyword@show,media_id@hide\r\n1:微信永久素材ID|bind_keyword@hide,media_id@show', '18', '0', '1', '1437988869', '1437988869', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('162', 'media_id', '微信素材ID', 'varchar(100) NULL', 'string', '', '微信后台的素材管理里永久素材的media_id值', '1', '', '18', '0', '1', '1437988973', '1437988973', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('163', 'send_type', '发送方式', 'tinyint(1) NULL', 'bool', '0', '', '1', '0:按用户组发送|group_id@show,send_openids@hide\r\n1:指定OpenID发送|group_id@hide,send_openids@show', '18', '0', '1', '1438049241', '1438049241', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('164', 'send_openids', '要发送的OpenID', 'text NULL', 'textarea', '', '多个可用逗号或者换行分开，OpenID值可在微信用户的列表中找到', '1', '', '18', '0', '1', '1438049362', '1438049362', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('165', 'msg_id', 'msg_id', 'varchar(255) NULL', 'string', '', '', '0', '', '18', '0', '1', '1439980539', '1438054616', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('166', 'publicid', '公众号ID', 'int(10) NULL', 'num', '0', '', '0', '', '19', '0', '1', '1439448400', '1439448400', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('167', 'module_name', '类型名', 'varchar(30) NULL', 'string', '', '', '0', '', '19', '0', '1', '1439448516', '1439448516', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('168', 'controller_name', '控制器名', 'varchar(30) NULL', 'string', '', '', '0', '', '19', '0', '1', '1439448567', '1439448567', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('169', 'action_name', '方法名', 'varchar(30) NULL', 'string', '', '', '0', '', '19', '0', '1', '1439448616', '1439448616', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('170', 'uid', '访问者ID', 'varchar(255) NULL', 'string', '0', '', '0', '', '19', '0', '1', '1439448654', '1439448654', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('171', 'ip', 'ip地址', 'varchar(30) NULL', 'string', '', '', '0', '', '19', '0', '1', '1439448742', '1439448742', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('172', 'brower', '浏览器', 'varchar(30) NULL', 'string', '', '', '0', '', '19', '0', '1', '1439448792', '1439448792', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('173', 'param', '其它GET参数', 'text NULL', 'textarea', '', '', '0', '', '19', '0', '1', '1439448834', '1439448834', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('174', 'referer', '访问的URL', 'varchar(255) NULL', 'string', '', '', '0', '', '19', '0', '1', '1439448886', '1439448874', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('175', 'cTime', '时间', 'int(10) NULL', 'datetime', '', '', '0', '', '19', '0', '1', '1439450668', '1439450668', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('176', 'wechat_group_name', '微信端的分组名', 'varchar(100) NULL', 'string', '', '', '0', '', '20', '0', '1', '1437635205', '1437635205', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('177', 'wechat_group_id', '微信端的分组ID', 'int(10) NULL', 'num', '-1', '', '0', '', '20', '0', '1', '1447659224', '1437635149', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('178', 'qr_code', '微信二维码', 'varchar(255) NULL', 'string', '', '', '0', '', '20', '0', '1', '1437635117', '1437635117', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('179', 'is_default', '是否默认自动加入', 'tinyint(1) NULL', 'radio', '0', '只有设置一个默认组，设置当前为默认组后之前的默认组将取消', '0', '0:否\r\n1:是', '20', '0', '1', '1437642358', '1437635042', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('180', 'token', 'Token', 'varchar(100) NULL', 'string', '', '', '0', '', '20', '0', '1', '1437634089', '1437634089', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('181', 'manager_id', '管理员ID', 'int(10) NULL', 'num', '0', '为0时表示系统用户组', '0', '', '20', '0', '1', '1437634309', '1437634062', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('182', 'rules', '权限', 'text NULL', 'textarea', '', '', '0', '', '20', '0', '1', '1437634022', '1437634022', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('183', 'type', '类型', 'tinyint(2) NULL', 'bool', '1', '', '0', '0:普通用户组\r\n1:微信用户组\r\n2:等级用户组\r\n3:认证用户组', '20', '0', '1', '1437633981', '1437633981', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('184', 'status', '状态', 'tinyint(2) NULL', 'bool', '1', '', '0', '1:正常\r\n0:禁用\r\n-1:删除', '20', '0', '1', '1437633826', '1437633826', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('185', 'description', '描述信息', 'text NULL', 'textarea', '', '', '1', '', '20', '0', '1', '1437633751', '1437633751', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('186', 'icon', '图标', 'int(10) UNSIGNED NULL', 'picture', '', '', '0', '', '20', '0', '1', '1437633711', '1437633711', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('187', 'title', '分组名称', 'varchar(30) NULL', 'string', '', '', '1', '', '20', '1', '1', '1437641907', '1437633598', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('188', 'wechat_group_count', '微信端用户数', 'int(10) NULL', 'num', '', '', '0', '', '20', '0', '1', '1437644061', '1437644061', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('189', 'is_del', '是否已删除', 'tinyint(1) NULL', 'bool', '0', '', '0', '0:否\r\n1:是', '20', '0', '1', '1437650054', '1437650044', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('190', 'sports_id', 'sports_id', 'int(10) NULL', 'num', '', '', '0', '', '21', '0', '1', '1432806979', '1432806979', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('191', 'type', 'type', 'varchar(30) NULL', 'string', '', '', '0', '', '21', '0', '1', '1432807001', '1432807001', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('192', 'time', 'time', 'varchar(50) NULL', 'string', '', '', '0', '', '21', '0', '1', '1432807028', '1432807028', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('193', 'total_count', 'total_count', 'int(10) NULL', 'num', '0', '', '0', '', '21', '0', '1', '1432807049', '1432807049', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('194', 'follow_count', 'follow_count', 'int(10) NULL', 'num', '0', '', '0', '', '21', '0', '1', '1432807063', '1432807063', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('195', 'aver_count', 'aver_count', 'int(10) NULL', 'num', '0', '', '0', '', '21', '0', '1', '1432807079', '1432807079', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('196', 'group_id', '分组样式', 'int(10) NULL', 'num', '0', '', '1', '', '22', '0', '1', '1436845570', '1436845570', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('197', 'style', '样式内容', 'text NULL', 'textarea', '', '请填写html', '1', '', '22', '1', '1', '1436846111', '1436846111', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('198', 'group_name', '分组名称', 'varchar(255) NULL', 'string', '', '', '1', '', '23', '1', '1', '1436845332', '1436845332', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('199', 'desc', '说明', 'text NULL', 'textarea', '', '', '1', '', '23', '0', '1', '1436845361', '1436845361', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12057', 'single_orderid', '订单号', 'varchar(100) NOT NULL', 'string', '', '', '1', '', '1230', '0', '1', '1420596415', '1420596415', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12058', 'price', '价格', 'decimal(10,2) NULL', 'num', '', '', '1', '', '1230', '0', '1', '1439812508', '1420596472', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12056', 'orderName', '订单名称', 'varchar(255) NULL', 'string', '', '', '1', '', '1230', '0', '1', '1439976366', '1420596373', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12055', 'from', '回调地址', 'varchar(50) NOT NULL', 'string', '', '', '1', '', '1230', '0', '1', '1420596347', '1420596347', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12054', 'join_count', '参加人数', 'int(10) NULL', 'num', '0', '', '0', '', '1229', '0', '1', '1444962764', '1444962764', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12053', 'init_count', '初始化预约数', 'int(10) NULL', 'num', '0', '', '0', '', '1229', '0', '1', '1444962246', '1444962246', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12052', 'max_limit', '最大预约数', 'int(10) NULL', 'num', '0', '为空时表示不限制', '0', '', '1229', '0', '1', '1444962264', '1444962198', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12051', 'money', '报名费用', 'decimal(11,2) NULL', 'num', '0', '', '0', '', '1229', '0', '1', '1444962160', '1444962160', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12049', 'reserve_id', '预约活动ID', 'int(10) NULL', 'num', '', '', '0', '', '1229', '0', '1', '1444962084', '1444962084', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12050', 'name', '名称', 'varchar(100) NULL', 'string', '', '', '0', '', '1229', '0', '1', '1444962123', '1444962123', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12048', 'is_pay', '是否支付', 'int(10) NULL', 'num', '0', '', '0', '', '1228', '0', '1', '1445258123', '1445258123', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12047', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1228', '0', '1', '1396690911', '1396690911', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('12046', 'uid', '用户ID', 'int(10) NULL', 'num', '', '', '0', '', '1228', '0', '1', '1396688042', '1396688042', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12045', 'openid', 'OpenId', 'varchar(255) NULL', 'string', '', '', '0', '', '1228', '0', '1', '1396688187', '1396688187', '', '3', '', 'regex', 'get_openid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('12044', 'cTime', '增加时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1228', '0', '1', '1396688434', '1396688434', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('12043', 'value', '微预约值', 'text NULL', 'textarea', '', '', '0', '', '1228', '0', '1', '1396688355', '1396688355', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12042', 'reserve_id', '微预约ID', 'int(10) UNSIGNED NULL', 'num', '', '', '4', '', '1228', '0', '1', '1396710064', '1396688308', '', '3', '', 'regex', '', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('12040', 'type', '字段类型', 'char(50) NOT NULL', 'select', 'string', '用于微预约中的展示方式', '1', 'string:单行输入\r\ntextarea:多行输入\r\nradio:单选\r\ncheckbox:多选\r\nselect:下拉选择\r\ndatetime:时间\r\npicture:上传图片', '1227', '1', '1', '1396871262', '1396683600', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12041', 'is_check', '验证是否成功', 'int(10) NULL', 'num', '0', '', '0', '', '1228', '0', '1', '1445246146', '1445246146', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12020', 'intro', '封面简介', 'text NULL', 'textarea', '', '', '1', '', '1226', '1', '1', '1439371986', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12021', 'mTime', '修改时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1226', '0', '1', '1396624664', '1396624664', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12022', 'cover', '封面图片', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '1226', '1', '1', '1439372018', '1396062093', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12023', 'template', '模板', 'varchar(255) NULL', 'string', 'default', '', '1', '', '1226', '0', '1', '1431661124', '1431661124', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12024', 'status', '状态', 'tinyint(2) NULL', 'bool', '0', '', '1', '0:已禁用\r\n1:已开启', '1226', '0', '1', '1444917938', '1444917938', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12025', 'start_time', '报名开始时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1226', '0', '1', '1444959115', '1444959115', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12026', 'end_time', '报名结束时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1226', '0', '1', '1444959142', '1444959142', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12027', 'pay_online', '是否支持在线支付', 'tinyint(2) NULL', 'bool', '0', '', '1', '0:否\r\n1:是', '1226', '0', '1', '1444959225', '1444959225', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12028', 'is_show', '是否显示', 'tinyint(2) NULL', 'select', '1', '是否显示在微预约中', '1', '1:显示\r\n0:不显示', '1227', '0', '1', '1396848437', '1396848437', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12029', 'reserve_id', '微预约ID', 'int(10) UNSIGNED NULL', 'num', '', '', '4', '', '1227', '0', '1', '1396710040', '1396690613', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12030', 'error_info', '出错提示', 'varchar(255) NULL', 'string', '', '验证不通过时的提示语', '1', '', '1227', '0', '1', '1396685920', '1396685920', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12031', 'sort', '排序号', 'int(10) UNSIGNED NULL', 'num', '0', '值越小越靠前', '1', '', '1227', '0', '1', '1396685825', '1396685825', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12032', 'validate_rule', '正则验证', 'varchar(255) NULL', 'string', '', '为空表示不作验证', '1', '', '1227', '0', '1', '1396685776', '1396685776', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12033', 'is_must', '是否必填', 'tinyint(2) NULL', 'bool', '', '用于自动验证', '1', '0:否\r\n1:是', '1227', '0', '1', '1396685579', '1396685579', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12034', 'remark', '字段备注', 'varchar(255) NULL', 'string', '', '用于微预约中的提示', '1', '', '1227', '0', '1', '1396685482', '1396685482', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12035', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1227', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('12036', 'value', '默认值', 'varchar(255) NULL', 'string', '', '字段的默认值', '1', '', '1227', '0', '1', '1396685291', '1396685291', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12037', 'title', '字段标题', 'varchar(255) NOT NULL', 'string', '', '请输入字段标题，用于微预约显示', '1', '', '1227', '1', '1', '1396676830', '1396676830', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12038', 'mTime', '修改时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1227', '0', '1', '1396624664', '1396624664', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12039', 'extra', '参数', 'text NULL', 'textarea', '', '字段类型为单选、多选、下拉选择和级联选择时的定义数据，其它字段类型为空', '1', '', '1227', '0', '1', '1396835020', '1396685105', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12066', 'wxmchid', '微信支付商户号', 'varchar(255) NULL', 'string', '', '', '1', '', '1231', '1', '1', '1439364696', '1436437067', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12067', 'shop_id', '商店ID', 'int(10) NULL', 'num', '0', '', '0', '', '1231', '0', '1', '1436437020', '1436437003', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12068', 'quick_merid', '银联在线merid', 'varchar(255) NULL', 'string', '', '', '1', '', '1231', '0', '1', '1436436949', '1436436949', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12069', 'quick_merabbr', '商户名称', 'varchar(255) NULL', 'string', '', '', '1', '', '1231', '0', '1', '1436436970', '1436436970', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12070', 'wxpartnerid', '微信partnerid', 'varchar(255) NULL', 'string', '', '', '0', '', '1231', '0', '1', '1436437196', '1436436910', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12071', 'wxpartnerkey', '微信partnerkey', 'varchar(255) NULL', 'string', '', '', '0', '', '1231', '0', '1', '1436437236', '1436436888', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12072', 'partnerid', '财付通标识', 'varchar(255) NULL', 'string', '', '', '1', '', '1231', '0', '1', '1436436798', '1436436798', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12073', 'key', 'KEY', 'varchar(255) NULL', 'string', '', '', '1', '', '1231', '0', '1', '1436436771', '1436436771', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12074', 'ctime', '创建时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1231', '0', '1', '1436436498', '1436436498', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12075', 'quick_security_key', '银联在线Key', 'varchar(255) NULL', 'string', '', '', '1', '', '1231', '0', '1', '1436436931', '1436436931', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12076', 'wappartnerkey', 'WAP财付通Key', 'varchar(255) NULL', 'string', '', '', '1', '', '1231', '0', '1', '1436436863', '1436436863', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12077', 'wappartnerid', '财付通标识WAP', 'varchar(255) NULL', 'string', '', '', '1', '', '1231', '0', '1', '1436436834', '1436436834', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12078', 'partnerkey', '财付通Key', 'varchar(255) NULL', 'string', '', '', '1', '', '1231', '0', '1', '1436436816', '1436436816', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12079', 'pid', 'PID', 'varchar(255) NULL', 'string', '', '', '1', '', '1231', '0', '1', '1436436707', '1436436707', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12080', 'zfbname', '帐号', 'varchar(255) NULL', 'string', '', '', '1', '', '1231', '0', '1', '1436436653', '1436436653', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12081', 'wxappsecret', 'AppSecret', 'varchar(255) NULL', 'string', '', '微信支付中的公众号应用密钥', '1', '', '1231', '1', '1', '1439364612', '1436436618', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12082', 'wxpaysignkey', '支付密钥', 'varchar(255) NULL', 'string', '', 'PartnerKey', '1', '', '1231', '1', '1', '1439364810', '1436436569', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12083', 'wxappid', 'AppID', 'varchar(255) NULL', 'string', '', '微信支付中的公众号应用ID', '1', '', '1231', '1', '1', '1439364573', '1436436534', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12084', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '0', '', '1231', '0', '1', '1436436415', '1436436415', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12085', 'wx_cert_pem', '上传证书', 'int(10) UNSIGNED NULL', 'file', '', 'apiclient_cert.pem', '1', '', '1231', '0', '1', '1439804529', '1439550487', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12086', 'wx_key_pem', '上传密匙', 'int(10) UNSIGNED NULL', 'file', '', 'apiclient_key.pem', '1', '', '1231', '0', '1', '1439804544', '1439804014', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12087', 'shop_pay_score', '支付返积分', 'int(10) NULL', 'num', '0', '不设置则默认为采用该支付方式不送积分', '1', '', '1231', '0', '1', '1443065789', '1443064056', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12088', 'keyword', '关键词', 'varchar(50) NOT NULL', 'string', '', '用户在微信里回复此关键词将会触发此投票。', '1', '', '1232', '1', '1', '1392969972', '1388930888', 'keyword_unique', '1', '此关键词已经存在，请换成别的关键词再试试', 'function', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12089', 'title', '投票标题', 'varchar(100) NOT NULL', 'string', '', '', '1', '', '1232', '1', '1', '1388931041', '1388931041', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12090', 'description', '投票描述', 'text NULL', 'textarea', '', '', '1', '', '1232', '0', '1', '1400633517', '1388931173', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12091', 'picurl', '封面图片', 'int(10) unsigned NULL ', 'picture', '', '支持JPG、PNG格式，较好的效果为大图360*200，小图200*200', '1', '', '1232', '0', '1', '1388931285', '1388931285', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12092', 'type', '选择类型', 'char(10) NOT NULL', 'radio', '0', '', '0', '0:单选\r\n1:多选', '1232', '1', '1', '1430376146', '1388931487', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12093', 'start_date', '开始日期', 'int(10) NULL', 'datetime', '', '', '1', '', '1232', '0', '1', '1388931734', '1388931734', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12094', 'end_date', '结束日期', 'int(10) NULL', 'datetime', '', '', '1', '', '1232', '0', '1', '1388931769', '1388931769', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12095', 'is_img', '文字/图片投票', 'tinyint(2) NULL', 'radio', '0', '', '0', '0:文字投票\r\n1:图片投票', '1232', '1', '1', '1389081985', '1388931941', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12096', 'vote_count', '投票数', 'int(10) unsigned NULL ', 'num', '0', '', '0', '', '1232', '0', '1', '1388932035', '1388932035', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12097', 'cTime', '投票创建时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1232', '1', '1', '1388932128', '1388932128', '', '1', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12098', 'mTime', '更新时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1232', '0', '1', '1430379170', '1390634006', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('12099', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1232', '0', '1', '1391397388', '1391397388', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12100', 'template', '素材模板', 'varchar(255) NULL', 'string', 'default', '', '1', '', '1232', '0', '1', '1430188739', '1430188739', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12101', 'vote_id', '投票ID', 'int(10) unsigned NULL ', 'num', '', '', '1', '', '1233', '1', '1', '1429846753', '1388934189', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12102', 'user_id', '用户ID', 'int(10) NULL ', 'num', '', '', '1', '', '1233', '1', '1', '1429855665', '1388934265', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12103', 'token', '用户TOKEN', 'varchar(255) NULL', 'string', '', '', '0', '', '1233', '1', '1', '1429855713', '1388934296', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12104', 'options', '选择选项', 'varchar(255) NULL', 'string', '', '', '1', '', '1233', '1', '1', '1429855086', '1388934351', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12105', 'cTime', '创建时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1233', '0', '1', '1429874378', '1388934392', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12106', 'order', '选项排序', 'int(10) unsigned NULL ', 'num', '0', '', '1', '', '1234', '0', '1', '1388933951', '1388933951', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12107', 'opt_count', '当前选项投票数', 'int(10) unsigned NULL ', 'num', '0', '', '1', '', '1234', '0', '1', '1429861248', '1388933860', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12108', 'image', '图片选项', 'int(10) unsigned NULL ', 'picture', '', '', '5', '', '1234', '0', '1', '1388984467', '1388933679', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12109', 'name', '选项标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1234', '1', '1', '1388933552', '1388933552', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12110', 'vote_id', '投票ID', 'int(10) unsigned NOT NULL ', 'num', '', '', '4', '', '1234', '1', '1', '1388982678', '1388933478', '', '3', '', 'regex', '$_REQUEST[\'vote_id\']', '3', 'string');
INSERT INTO `wp_attribute` VALUES ('12111', 'title', '活动名称', 'varchar(255) NULL', 'string', '', '', '1', '', '1235', '1', '1', '1443148922', '1443148534', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12112', 'select_type', '投票类型', 'char(10) NULL', 'radio', '1', '', '1', '1:单选|multi_num@hide\r\n2:多选|multi_num@show', '1235', '0', '1', '1443148839', '1443148618', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12113', 'multi_num', '多选限制', 'int(10) NULL', 'num', '0', '0代表不限制', '1', '', '1235', '0', '1', '1443148734', '1443148734', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12114', 'start_time', '开始时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1235', '1', '1', '1443148948', '1443148880', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12115', 'end_time', '结束时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1235', '1', '1', '1443148958', '1443148911', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12116', 'remark', '活动说明', 'text NULL', 'textarea', '', '', '1', '', '1235', '0', '1', '1443149020', '1443149020', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12117', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '0', '', '1235', '0', '1', '1443149050', '1443149050', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12118', 'manager_id', '管理员id', 'int(10) NULL', 'num', '', '', '0', '', '1235', '0', '1', '1443149118', '1443149118', '', '3', '', 'regex', 'get_mid', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12119', 'is_verify', '投票是否需要填写验证码', 'tinyint(2) NULL', 'bool', '0', '防止刷票行为时需要开启', '1', '0:不需要\r\n1:需要', '1235', '0', '1', '1446000352', '1445997031', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12120', 'truename', '参赛者', 'varchar(255) NULL', 'string', '', '', '1', '', '1236', '1', '1', '1447817227', '1443149261', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12121', 'image', '参赛图片', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '1236', '1', '1', '1447817196', '1443149366', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12122', 'uid', '用户id', 'int(10) NULL', 'num', '', '', '0', '', '1236', '0', '1', '1443149449', '1443149437', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12123', 'manifesto', '参赛宣言', 'text NULL', 'textarea', '', '', '1', '', '1236', '1', '1', '1447817176', '1443149626', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12124', 'introduce', '选手介绍', 'text NULL', 'textarea', '', '', '1', '', '1236', '1', '1', '1443149732', '1443149732', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12125', 'ctime', '创建时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1236', '0', '1', '1443149776', '1443149776', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12126', 'vote_id', '活动id', 'int(10) NULL', 'num', '', '', '4', '', '1236', '0', '1', '1443149827', '1443149827', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12127', 'opt_count', '投票数', 'int(10) NULL', 'num', '0', '', '0', '', '1236', '0', '1', '1443154633', '1443149866', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12128', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '0', '', '1236', '0', '1', '1443149961', '1443149961', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12129', 'number', '编号', 'int(10) NULL', 'num', '1', '', '0', '', '1236', '0', '1', '1443173465', '1443173454', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12130', 'vote_id', '活动id', 'int(10) NULL', 'num', '', '', '1', '', '1237', '0', '1', '1443150128', '1443150128', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12131', 'option_id', '选项id', 'int(10) NULL', 'num', '', '', '1', '', '1237', '0', '1', '1443150157', '1443150157', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12132', 'uid', '投票者id', 'int(10) NULL', 'num', '', '', '1', '', '1237', '0', '1', '1443150185', '1443150185', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12133', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '0', '', '1237', '0', '1', '1443150248', '1443150248', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12134', 'ctime', '投票时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1237', '0', '1', '1443150271', '1443150271', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11518', 'cTime', '增加时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1171', '0', '1', '1396688434', '1396688434', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11516', 'forms_id', '表单ID', 'int(10) UNSIGNED NULL', 'num', '', '', '4', '', '1171', '0', '1', '1396710064', '1396688308', '', '3', '', 'regex', '', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11517', 'value', '表单值', 'text NULL', 'textarea', '', '', '0', '', '1171', '0', '1', '1396688355', '1396688355', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11515', 'type', '字段类型', 'char(50) NOT NULL', 'select', 'string', '用于表单中的展示方式', '1', 'string:单行输入\r\ntextarea:多行输入\r\nradio:单选\r\ncheckbox:多选\r\nselect:下拉选择\r\ndatetime:时间\r\npicture:上传图片', '1170', '1', '1', '1396871262', '1396683600', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11514', 'extra', '参数', 'text NULL', 'textarea', '', '字段类型为单选、多选、下拉选择和级联选择时的定义数据，其它字段类型为空', '1', '', '1170', '0', '1', '1396835020', '1396685105', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11513', 'mTime', '修改时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1170', '0', '1', '1396624664', '1396624664', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11512', 'title', '字段标题', 'varchar(255) NOT NULL', 'string', '', '请输入字段标题，用于表单显示', '1', '', '1170', '1', '1', '1396676830', '1396676830', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11511', 'value', '默认值', 'varchar(255) NULL', 'string', '', '字段的默认值', '1', '', '1170', '0', '1', '1396685291', '1396685291', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11510', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1170', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11509', 'name', '字段名', 'varchar(100) NULL', 'string', '', '请输入字段名 英文字母开头，长度不超过30', '1', '', '1170', '1', '1', '1447638080', '1396676792', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11508', 'remark', '字段备注', 'varchar(255) NULL', 'string', '', '用于表单中的提示', '1', '', '1170', '0', '1', '1396685482', '1396685482', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11507', 'is_must', '是否必填', 'tinyint(2) NULL', 'bool', '', '用于自动验证', '1', '0:否\r\n1:是', '1170', '0', '1', '1396685579', '1396685579', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11506', 'validate_rule', '正则验证', 'varchar(255) NULL', 'string', '', '为空表示不作验证', '1', '', '1170', '0', '1', '1396685776', '1396685776', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11504', 'error_info', '出错提示', 'varchar(255) NULL', 'string', '', '验证不通过时的提示语', '1', '', '1170', '0', '1', '1396685920', '1396685920', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11505', 'sort', '排序号', 'int(10) UNSIGNED NULL', 'num', '0', '值越小越靠前', '1', '', '1170', '0', '1', '1396685825', '1396685825', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11503', 'forms_id', '表单ID', 'int(10) UNSIGNED NULL', 'num', '', '', '4', '', '1170', '0', '1', '1396710040', '1396690613', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11502', 'is_show', '是否显示', 'tinyint(2) NULL', 'select', '1', '是否显示在表单中', '1', '1:显示\r\n0:不显示', '1170', '0', '1', '1396848437', '1396848437', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11501', 'template', '模板', 'varchar(255) NULL', 'string', 'default', '', '1', '', '1169', '0', '1', '1431661124', '1431661124', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11500', 'keyword', '关键词', 'varchar(100) NOT NULL', 'string', '', '', '1', '', '1169', '1', '1', '1396866048', '1396061575', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11499', 'cover', '封面图片', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '1169', '1', '1', '1439372018', '1396062093', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11498', 'mTime', '修改时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1169', '0', '1', '1396624664', '1396624664', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11497', 'intro', '封面简介', 'text NULL', 'textarea', '', '', '1', '', '1169', '1', '1', '1439371986', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11496', 'can_edit', '是否允许编辑', 'tinyint(2) NULL', 'bool', '0', '用户提交表单是否可以再编辑', '1', '0:不允许\r\n1:允许', '1169', '0', '1', '1396688624', '1396688624', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11495', 'finish_tip', '用户提交后提示内容', 'text NULL', 'string', '', '为空默认为：提交成功，谢谢参与', '1', '', '1169', '0', '1', '1447497102', '1396673689', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11494', 'content', '详细介绍', 'text NULL', 'editor', '', '可不填', '1', '', '1169', '0', '1', '1396865295', '1396865295', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11493', 'jump_url', '提交后跳转的地址', 'varchar(255) NULL', 'string', '', '要以http://开头的完整地址，为空时不跳转', '1', '', '1169', '0', '1', '1402458121', '1399800276', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11492', 'keyword_type', '关键词类型', 'tinyint(2) NOT NULL', 'select', '0', '', '1', '0:完全匹配\r\n1:左边匹配\r\n2:右边匹配\r\n3:模糊匹配', '1169', '1', '1', '1396624426', '1396061765', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11330', 'icon', '图标', 'int(10) unsigned NULL ', 'picture', '', '根据选择的底部模板决定是否需要上传图标', '1', '', '1150', '0', '1', '1396506297', '1396506297', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11329', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1150', '0', '1', '1394526820', '1394526820', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11331', 'title', '标题', 'varchar(255) NULL', 'string', '', '可为空', '1', '', '1151', '0', '1', '1396098316', '1396098316', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11327', 'pid', '一级菜单', 'tinyint(2) NULL', 'select', '0', '如果是一级菜单，选择“无”即可', '1', '0:无', '1150', '0', '1', '1409045931', '1394518930', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11328', 'sort', '排序号', 'tinyint(4) NULL ', 'num', '0', '数值越小越靠前', '1', '', '1150', '0', '1', '1394523288', '1394519175', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11300', 'keyword', '关键词', 'varchar(255) NULL', 'string', '', '多个关键词可以用空格分开，如“高富帅 白富美”', '1', '', '1147', '1', '1', '1439194858', '1439194849', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11301', 'msg_type', '消息类型', 'char(50) NULL', 'select', 'text', '', '0', 'text:文本|content@show,group_id@hide,image_id@hide\r\nnews:图文|content@hide,group_id@show,image_id@hide\r\nimage:图片|content@hide,group_id@hide,image_id@show', '1147', '1', '1', '1439204529', '1439194979', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11302', 'content', '文本内容', 'text NULL', 'textarea', '', '', '1', '', '1147', '0', '1', '1439195826', '1439195091', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11303', 'group_id', '图文', 'int(10) NULL', 'news', '', '', '1', '', '1147', '0', '1', '1439204192', '1439195901', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11304', 'image_id', '上传图片', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '1147', '0', '1', '1439195945', '1439195945', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11305', 'manager_id', '管理员ID', 'int(10) NULL', 'num', '', '', '0', '', '1147', '0', '1', '1439203621', '1439203575', '', '3', '', 'regex', 'get_mid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11306', 'token', 'Token', 'varchar(50) NULL', 'string', '', '', '0', '', '1147', '0', '1', '1439203612', '1439203612', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11307', 'image_material', '素材图片id', 'int(10) NULL', 'num', '', '', '0', '', '1147', '0', '1', '1447738833', '1447738833', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11317', 'title', '标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1149', '1', '1', '1396061877', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11318', 'intro', '简介', 'text NULL', 'textarea', '', '', '1', '', '1149', '0', '1', '1396061947', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11319', 'cate_id', '所属类别', 'int(10) unsigned NULL ', 'select', '0', '要先在微官网分类里配置好分类才可选择', '1', '0:请选择分类', '1149', '0', '1', '1396078914', '1396062003', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11320', 'cover', '封面图片', 'int(10) unsigned NULL ', 'picture', '', '', '1', '', '1149', '0', '1', '1396062093', '1396062093', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11321', 'content', '内容', 'text NULL', 'editor', '', '', '1', '', '1149', '0', '1', '1396062146', '1396062146', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11322', 'cTime', '发布时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1149', '0', '1', '1396075102', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11323', 'sort', '排序号', 'int(10) unsigned NULL ', 'num', '0', '数值越小越靠前', '1', '', '1149', '0', '1', '1396510508', '1396510508', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11324', 'view_count', '浏览数', 'int(10) unsigned NULL ', 'num', '0', '', '0', '', '1149', '0', '1', '1396510630', '1396510630', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11325', 'url', '关联URL', 'varchar(255) NULL ', 'string', '', '', '1', '', '1150', '0', '1', '1394519090', '1394519090', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11326', 'title', '菜单名', 'varchar(50) NOT NULL', 'string', '', '可创建最多 3 个一级菜单，每个一级菜单下可创建最多 5 个二级菜单。编辑中的菜单不会马上被用户看到，请放心调试。', '1', '', '1150', '1', '1', '1408950832', '1394518988', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11332', 'img', '图片', 'int(10) unsigned NOT NULL ', 'picture', '', '', '1', '', '1151', '1', '1', '1396098349', '1396098349', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11333', 'url', '链接地址', 'varchar(255) NULL', 'string', '', '', '1', '', '1151', '0', '1', '1396098380', '1396098380', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11334', 'is_show', '是否显示', 'tinyint(2) NULL', 'bool', '1', '', '1', '0:不显示\r\n1:显示', '1151', '0', '1', '1396098464', '1396098464', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11335', 'sort', '排序', 'int(10) unsigned NULL ', 'num', '0', '值越小越靠前', '1', '', '1151', '0', '1', '1396098682', '1396098682', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11336', 'token', 'Token', 'varchar(100) NULL', 'string', '', '', '0', '', '1151', '0', '1', '1396098747', '1396098747', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11337', 'keyword', '关键词', 'varchar(100) NOT NULL', 'string', '', '', '1', '', '1152', '1', '1', '1396624337', '1396061575', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11338', 'keyword_type', '关键词匹配类型', 'tinyint(2) NOT NULL', 'select', '0', '', '1', '0:完全匹配\r\n1:左边匹配\r\n2:右边匹配\r\n3:模糊匹配', '1152', '1', '1', '1396624426', '1396061765', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11339', 'title', '试卷标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1152', '1', '1', '1396624461', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11340', 'intro', '封面简介', 'text NOT NULL', 'textarea', '', '', '1', '', '1152', '0', '1', '1396624505', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11341', 'mTime', '修改时间', 'int(10) NOT NULL', 'datetime', '', '', '0', '', '1152', '0', '1', '1396624664', '1396624664', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11342', 'cover', '封面图片', 'int(10) UNSIGNED NOT NULL', 'picture', '', '', '1', '', '1152', '0', '1', '1396624534', '1396062093', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11343', 'cTime', '发布时间', 'int(10) UNSIGNED NOT NULL', 'datetime', '', '', '0', '', '1152', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11344', 'token', 'Token', 'varchar(255) NOT NULL', 'string', '', '', '0', '', '1152', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11345', 'finish_tip', '结束语', 'text NOT NULL', 'string', '', '为空默认为：考试完成，谢谢参与', '1', '', '1152', '0', '1', '1447646362', '1396953940', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11346', 'start_time', '考试开始时间', 'int(10) NULL', 'datetime', '', '为空表示什么时候开始都可以', '2', '', '1152', '0', '1', '1447752638', '1397036762', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11347', 'end_time', '考试结束时间', 'int(10) NULL', 'datetime', '', '为空表示不限制结束时间', '2', '', '1152', '0', '1', '1447753072', '1397036831', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11348', 'title', '题目标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1153', '1', '1', '1397037377', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11349', 'intro', '题目描述', 'text NOT NULL', 'textarea', '', '', '1', '', '1153', '0', '1', '1396954176', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11350', 'cTime', '发布时间', 'int(10) UNSIGNED NOT NULL', 'datetime', '', '', '0', '', '1153', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11351', 'token', 'Token', 'varchar(255) NOT NULL', 'string', '', '', '0', '', '1153', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11352', 'is_must', '是否必填', 'tinyint(2) NOT NULL', 'bool', '1', '', '0', '0:否\r\n1:是', '1153', '0', '1', '1397035513', '1396954649', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11353', 'extra', '参数', 'text NOT NULL', 'textarea', '', '每个选项换一行，每项输入格式如：A:男人', '1', '', '1153', '0', '1', '1397036210', '1396954558', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11354', 'type', '题目类型', 'char(50) NOT NULL', 'radio', 'radio', '', '1', 'radio:单选题\r\ncheckbox:多选题', '1153', '1', '1', '1397036281', '1396954463', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11355', 'exam_id', 'exam_id', 'int(10) UNSIGNED NOT NULL', 'num', '', '', '4', '', '1153', '1', '1', '1396954240', '1396954240', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11356', 'sort', '排序号', 'int(10) UNSIGNED NOT NULL', 'num', '0', '值越小越靠前', '1', '', '1153', '0', '1', '1396955010', '1396955010', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11357', 'score', '分值', 'int(10) UNSIGNED NOT NULL', 'num', '0', '考生答对此题的得分数', '1', '', '1153', '0', '1', '1397035609', '1397035609', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11358', 'answer', '标准答案', 'varchar(255) NOT NULL', 'string', '', '多个答案用空格分开，如： A B C', '1', '', '1153', '0', '1', '1397035889', '1397035889', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11359', 'answer', '回答内容', 'text NOT NULL', 'textarea', '', '', '0', '', '1154', '0', '1', '1396955766', '1396955766', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11360', 'openid', 'OpenId', 'varchar(255) NOT NULL', 'string', '', '', '0', '', '1154', '0', '1', '1396955581', '1396955581', '', '3', '', 'regex', 'get_openid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11361', 'uid', '用户UID', 'int(10) UNSIGNED NOT NULL', 'num', '', '', '0', '', '1154', '0', '1', '1396955530', '1396955530', '', '3', '', 'regex', 'get_mid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11362', 'question_id', 'question_id', 'int(10) UNSIGNED NOT NULL', 'num', '', '', '4', '', '1154', '1', '1', '1396955412', '1396955392', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11363', 'cTime', '发布时间', 'int(10) UNSIGNED NOT NULL', 'datetime', '', '', '0', '', '1154', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11364', 'token', 'Token', 'varchar(255) NOT NULL', 'string', '', '', '0', '', '1154', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11365', 'exam_id', 'exam_id', 'int(10) UNSIGNED NOT NULL', 'num', '', '', '4', '', '1154', '1', '1', '1396955403', '1396955369', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11366', 'score', '得分', 'int(10) UNSIGNED NOT NULL', 'num', '0', '', '0', '', '1154', '0', '1', '1397040133', '1397040133', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11367', 'follow_id', '粉丝id', 'int(10) NULL', 'num', '', '', '1', '', '1155', '0', '1', '1432619233', '1432619233', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11368', 'sports_id', '场次id', 'int(10) NULL', 'num', '', '', '1', '', '1155', '0', '1', '1432690316', '1432619261', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11369', 'count', '抽奖次数', 'int(10) NULL', 'num', '0', '', '1', '', '1155', '0', '1', '1432619288', '1432619288', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11370', 'uid', 'uid', 'int(10) NULL', 'num', '', '', '0', '', '1155', '0', '1', '1435313298', '1435313298', '', '3', '', 'regex', 'get_mid', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11371', 'cTime', '支持时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1155', '0', '1', '1432690461', '1432690461', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11372', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '0', '', '1155', '0', '1', '1444986759', '1444986759', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11373', 'sports_id', '活动编号', 'int(10) NULL', 'num', '', '', '1', '', '1156', '0', '1', '1432690590', '1432613794', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11374', 'award_id', '奖品编号', 'varchar(255) NULL', 'cascade', '', '', '1', '', '1156', '0', '1', '1432710935', '1432613820', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11375', 'award_num', '奖品数量', 'int(10) NULL', 'num', '', '', '1', '', '1156', '0', '1', '1432624743', '1432624743', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11376', 'uid', 'uid', 'int(10) NULL', 'num', '', '', '0', '', '1156', '0', '1', '1435313078', '1435313078', '', '3', '', 'regex', 'get_mid', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11377', 'uid', 'uid', 'int(10) NULL', 'num', '', '', '0', '', '1157', '0', '1', '1435313219', '1435313219', '', '3', '', 'regex', 'get_mid', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11378', 'draw_id', '活动编号', 'int(10) NULL', 'num', '', '', '1', '', '1157', '0', '1', '1432619092', '1432618270', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11379', 'sport_id', '场次编号', 'int(10) NULL', 'num', '', '', '1', '', '1157', '0', '1', '1432618305', '1432618305', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11380', 'award_id', '奖品编号', 'int(10) NULL', 'num', '', '', '1', '', '1157', '0', '1', '1432618336', '1432618336', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11381', 'follow_id', '粉丝id', 'int(10) NULL', 'num', '', '', '1', '', '1157', '0', '1', '1432618392', '1432618392', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11382', 'address', '地址', 'varchar(255) NULL', 'string', '', '', '1', '', '1157', '0', '1', '1432618543', '1432618543', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11383', 'num', '获奖数', 'int(10) NULL', 'num', '0', '', '1', '', '1157', '0', '1', '1432618584', '1432618584', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11384', 'state', '兑奖状态', 'tinyint(2) NULL', 'bool', '0', '', '1', '0:未兑奖\r\n1:已兑奖', '1157', '0', '1', '1432644421', '1432618716', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11385', 'zjtime', '中奖时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1157', '0', '1', '1432716949', '1432618837', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11386', 'djtime', '兑奖时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1157', '0', '1', '1432618922', '1432618922', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11387', 'remark', '备注', 'text NULL', 'textarea', '', '', '1', '', '1157', '0', '1', '1445056786', '1445056786', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11388', 'aim_table', '活动标识', 'varchar(255) NULL', 'string', '', '', '0', '', '1157', '0', '1', '1444966689', '1444966689', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11389', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '0', '', '1157', '0', '1', '1444966581', '1444966581', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11390', 'scan_code', '核销码', 'varchar(255) NULL', 'string', '', '', '1', '', '1157', '0', '1', '1446202559', '1446202559', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11391', 'title', '活动名称', 'varchar(255) NULL', 'string', '', '', '1', '', '1158', '1', '1', '1435306559', '1435306559', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11392', 'remark', '活动描述', 'text NULL', 'textarea', '', '', '1', '', '1158', '1', '1', '1435307454', '1435307126', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11393', 'logo_img', '活动LOGO', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '1158', '1', '1', '1435307446', '1435307174', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11394', 'start_time', '开始时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1158', '1', '1', '1435310820', '1435307277', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11395', 'end_time', '结束时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1158', '1', '1', '1435310830', '1435307296', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11396', 'get_prize_tip', '中奖提示信息', 'varchar(255) NULL', 'string', '', '', '1', '', '1158', '1', '1', '1435307421', '1435307411', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11397', 'no_prize_tip', '未中奖提示信息', 'varchar(255) NULL', 'string', '', '', '1', '', '1158', '1', '1', '1435307517', '1435307517', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11398', 'ctime', '活动创建时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1158', '0', '1', '1435307577', '1435307577', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11399', 'uid', 'uid', 'int(10) NULL', 'num', '', '', '0', '', '1158', '0', '1', '1435307671', '1435307671', '', '3', '', 'regex', 'get_mid', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11400', 'lottery_number', '抽奖次数', 'int(10) NULL', 'num', '1', '每日允许用户抽奖的机会数，小于0 为无限次', '1', '', '1158', '0', '1', '1436233580', '1435585561', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11401', 'comment_status', '评论是否需要审核', 'char(10) NULL', 'radio', '0', '', '1', '0:不审核\r\n1:审核', '1158', '0', '1', '1436155693', '1435665821', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11402', 'get_prize_count', '中奖次数', 'int(10) NULL', 'num', '1', '每用户是否允许多次中奖', '1', '', '1158', '0', '1', '1436181974', '1436181850', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11403', 'lzwg_id', '活动编号', 'int(10) NULL', 'num', '', '', '1', '', '1159', '0', '1', '1435734910', '1435734886', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11404', 'lzwg_type', '活动类型', 'char(10) NULL', 'radio', '0', '', '1', '0:投票\r\n1:调查', '1159', '0', '1', '1435734977', '1435734977', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11405', 'vote_id', '题目编号', 'int(10) NULL', 'num', '', '', '1', '', '1159', '0', '1', '1435735047', '1435735047', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11406', 'vote_type', '问题类型', 'char(10) NULL', 'radio', '1', '', '1', '0:单选\r\n1:多选', '1159', '0', '1', '1435735092', '1435735092', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11407', 'vote_limit', '最多选择几项', 'int(10) NULL', 'num', '', '', '1', '', '1159', '0', '1', '1435735172', '1435735172', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11408', 'img', '奖品图片', 'int(10) NOT NULL', 'picture', '', '', '1', '', '1160', '1', '1', '1432609211', '1432607410', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11409', 'name', '奖项名称', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1160', '1', '1', '1432621511', '1432607270', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11410', 'score', '积分数', 'int(10) NULL', 'num', '0', '虚拟奖品积分奖励', '1', '', '1160', '1', '1', '1433312545', '1433304974', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11411', 'award_type', '奖品类型', 'varchar(30) NULL', 'bool', '1', '选择奖品类别', '1', '1:实物奖品|price@show,score@hide\r\n0:虚拟奖品|price@hide,score@show', '1160', '1', '1', '1433312276', '1433303130', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11412', 'price', '商品价格', 'FLOAT(10) NULL', 'num', '0', '价格默认为0，表示未报价', '1', '', '1160', '0', '1', '1433312127', '1432607574', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11413', 'explain', '奖品说明', 'text NULL', 'textarea', '', '', '1', '', '1160', '0', '1', '1432621815', '1432607605', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11414', 'count', '奖品数量', 'int(10) NOT NULL', 'num', '', '', '1', '', '1160', '1', '1', '1447833730', '1432607983', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11415', 'sort', '排序号', 'int(10) unsigned NULL ', 'num', '0', '', '0', '', '1160', '0', '1', '1432809831', '1432608522', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11416', 'uid', 'uid', 'int(10) NULL', 'num', '', '', '0', '', '1160', '0', '1', '1435308540', '1435308540', '', '3', '', 'regex', 'get_mid', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11417', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '0', '', '1160', '0', '1', '1444879923', '1444879923', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11418', 'coupon_id', '选择赠送券', 'char(50) NULL', 'select', '', '', '1', '', '1160', '0', '1', '1444893831', '1444881398', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11419', 'money', '返现金额', 'float(10) NULL', 'num', '', '', '1', '', '1160', '0', '1', '1444882709', '1444881428', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11420', 'aim_table', '活动标识', 'varchar(255) NULL', 'string', '', '', '0', '', '1160', '0', '1', '1444883071', '1444883071', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11421', 'score', '比分', 'varchar(30) NULL', 'string', '', '输入格式：4:1', '1', '', '1161', '0', '1', '1432781750', '1432556644', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11422', 'content', '说明', 'text NULL', 'textarea', '', '请输入说明', '1', '', '1161', '0', '1', '1432556696', '1432556696', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11423', 'start_time', '时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1161', '1', '1', '1432556499', '1432556499', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11424', 'visit_team', '客场球队', 'varchar(255) NULL', 'cascade', '', '', '1', 'type=db&table=sports_team', '1161', '1', '1', '1432558295', '1432556450', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11425', 'home_team', '主场球队', 'varchar(255) NULL', 'cascade', '', '', '1', 'type=db&table=sports_team', '1161', '1', '1', '1432558269', '1432556380', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11426', 'countdown', '擂鼓时长', 'int(10) NULL', 'num', '60', '擂鼓倒计的时长,单位为秒,取值范围: 10~99', '1', '', '1161', '0', '1', '1432645901', '1432642097', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11427', 'drum_count', '擂鼓次数', 'int(10) NULL', 'num', '0', '', '0', '', '1161', '0', '1', '1432642664', '1432642664', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11428', 'drum_follow_count', '擂鼓人数', 'int(10) NULL', 'num', '0', '', '0', '', '1161', '0', '1', '1432642718', '1432642718', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11429', 'home_team_support_count', '主场球队支持数', 'int(10) NULL', 'num', '0', '', '0', '', '1161', '0', '1', '1432642808', '1432642808', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11430', 'visit_team_support_count', '客场球队支持人数', 'int(10) NULL', 'num', '0', '', '0', '', '1161', '0', '1', '1432642849', '1432642849', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11431', 'home_team_drum_count', '主场球队擂鼓数', 'int(10) NULL', 'num', '0', '', '0', '', '1161', '0', '1', '1432642978', '1432642978', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11432', 'visit_team_drum_count', '客场球队擂鼓数', 'int(10) NULL', 'num', '0', '', '0', '', '1161', '0', '1', '1432644311', '1432643015', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11433', 'yaotv_count', '摇一摇总次', 'int(10) NULL', 'num', '0', '', '0', '', '1161', '0', '1', '1432884957', '1432784354', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11434', 'draw_count', '抽奖总次数', 'int(10) NULL', 'num', '0', '', '0', '', '1161', '0', '1', '1432887571', '1432784416', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11435', 'is_finish', '是否已结束', 'tinyint(2) NULL', 'bool', '0', '', '0', '0:未结束\r\n1:已结束', '1161', '0', '1', '1432868975', '1432868975', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11436', 'yaotv_follow_count', '摇电视总人数', 'int(10) NULL', 'num', '0', '', '0', '', '1161', '0', '1', '1432884721', '1432884721', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11437', 'draw_follow_count', '抽奖总人数', 'int(10) NULL', 'num', '0', '', '0', '', '1161', '0', '1', '1432887553', '1432887553', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11438', 'comment_status', '评论是否需要审核', 'tinyint(2) NULL', 'radio', '0', '', '1', '0:不审核\r\n1:审核', '1161', '0', '1', '1435109668', '1435030411', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11439', 'sports_id', '场次ID', 'int(10) NULL', 'num', '', '', '0', '', '1162', '0', '1', '1432642290', '1432642290', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11440', 'team_id', '球队ID', 'int(10) NULL', 'num', '', '', '0', '', '1162', '0', '1', '1432642312', '1432642312', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11441', 'follow_id', '用户ID', 'int(10) NULL', 'num', '', '', '0', '', '1162', '0', '1', '1432642354', '1432642354', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11442', 'drum_count', '擂鼓次数', 'int(10) NULL', 'num', '', '', '0', '', '1162', '0', '1', '1432642384', '1432642384', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11443', 'cTime', '时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1162', '0', '1', '1432642409', '1432642409', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11444', 'sports_id', '场次ID', 'int(10) NULL', 'num', '', '', '0', '', '1163', '0', '1', '1432635120', '1432635120', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11445', 'team_id', '球队ID', 'int(10) NULL', 'num', '', '', '0', '', '1163', '0', '1', '1432635147', '1432635147', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11446', 'follow_id', '用户ID', 'int(10) NULL', 'num', '', '', '0', '', '1163', '0', '1', '1432635168', '1432635168', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11447', 'cTime', '支持时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1163', '0', '1', '1432635202', '1432635202', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11448', 'sort', '排序号', 'int(10) NULL', 'num', '0', '', '0', '', '1164', '0', '1', '1432559360', '1432559360', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11449', 'intro', '球队说明', 'text  NULL', 'textarea', '', '', '1', '', '1164', '0', '1', '1432557159', '1432556960', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11450', 'pid', 'pid', 'int(10) NULL', 'num', '0', '', '0', '', '1164', '0', '1', '1432557085', '1432557085', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11451', 'logo', '球队图标', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '1164', '1', '1', '1432556913', '1432556913', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11452', 'title', '球队名称', 'varchar(100) NULL', 'string', '', '请输入球队名称', '1', '', '1164', '1', '1', '1432958716', '1432556869', 'unique', '3', '球队名称不能重复', 'unique', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11453', 'title', '活动名称', 'varchar(255) NULL', 'string', '', '', '1', '', '1165', '1', '1', '1444877324', '1444877324', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11454', 'game_type', '游戏类型', 'char(10) NULL', 'radio', '1', '', '1', '1:刮刮乐\r\n2:大转盘\r\n3:砸金蛋\r\n4:九宫格', '1165', '1', '1', '1444877425', '1444877425', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11455', 'status', '状态', 'char(10) NULL', 'radio', '1', '', '1', '1:开启\r\n0:禁用', '1165', '0', '1', '1444877482', '1444877468', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11456', 'start_time', '开始时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1165', '1', '1', '1444877509', '1444877509', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11457', 'end_time', '结束时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1165', '1', '1', '1444877530', '1444877530', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11458', 'day_attend_limit', '每人每天抽奖次数', 'int(10) NULL', 'num', '0', '0，则不限制，超过此限制点击抽奖，系统会提示“您今天的抽奖次数已经用完!”', '1', '', '1165', '0', '1', '1444879540', '1444878111', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11459', 'attend_limit', '每人总共抽奖次数', 'int(10) NULL', 'num', '0', '0，则不限制；否则必须>=每人每天抽奖次数，超过此限制点击抽奖，系统会提示“您的所有抽奖次数已用完!”', '1', '', '1165', '0', '1', '1444879552', '1444878167', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11460', 'day_win_limit', '每人每天中奖次数', 'int(10) NULL', 'num', '0', '0，则不限制，超过此限制点击抽奖，抽奖者将无概率中奖', '1', '', '1165', '0', '1', '1444879608', '1444878254', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11461', 'win_limit', '每人总共中奖次数', 'int(10) NULL', 'num', '0', '0，则不限制；否则必须>=每人每天中奖次数，超过此限制点击抽奖，抽奖者将无概率中奖', '1', '', '1165', '0', '1', '1444879656', '1444878336', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11462', 'day_winners_count', '每天最多中奖人数', 'int(10) NULL', 'num', '0', '0，则不限制，超过此限制时，系统会提示“今天奖品已抽完，明天再来吧!”', '1', '', '1165', '0', '1', '1444879673', '1444878419', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11463', 'url', '关注链接', 'varchar(300) NULL', 'string', '', '', '0', '', '1165', '0', '1', '1445068488', '1444878621', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11464', 'remark', '活动说明', 'text NULL', 'textarea', '', '', '1', '', '1165', '0', '1', '1444878676', '1444878676', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11465', 'keyword', '微信关键词', 'varchar(255) NULL', 'string', '', '', '1', '', '1165', '1', '1', '1444878722', '1444878722', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11466', 'attend_num', '参与总人数', 'int(10) NULL', 'num', '0', '', '0', '', '1165', '0', '1', '1444878774', '1444878774', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11467', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '0', '', '1165', '0', '1', '1444878837', '1444878837', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11468', 'manager_id', '管理员id', 'int(10) NULL', 'num', '', '', '0', '', '1165', '0', '1', '1444878900', '1444878900', '', '3', '', 'regex', 'get_mid', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11469', 'award_id', '奖品id', 'int(10) NULL', 'num', '', '', '1', '', '1166', '1', '1', '1444901378', '1444900999', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11470', 'games_id', '抽奖游戏id', 'int(10) NULL', 'num', '', '', '1', '', '1166', '1', '1', '1444901386', '1444901037', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11471', 'grade', '中奖等级', 'varchar(255) NULL', 'string', '', '', '1', '', '1166', '1', '1', '1444901399', '1444901079', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11472', 'num', '奖品数量', 'int(10) NULL', 'num', '', '', '1', '', '1166', '1', '1', '1444901364', '1444901364', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11473', 'max_count', '最多抽奖', 'int(10) NULL', 'num', '', 'n次,把奖品发放完, 不能小于奖品数量', '1', '', '1166', '0', '1', '1444901486', '1444901486', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11474', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '0', '', '1166', '0', '1', '1444901512', '1444901512', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11475', 'follow_id', '粉丝id', 'int(10) NULL', 'num', '', '', '1', '', '1167', '0', '1', '1432619233', '1432619233', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11476', 'sports_id', '场次id', 'int(10) NULL', 'num', '', '', '1', '', '1167', '0', '1', '1432690316', '1432619261', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11477', 'count', '抽奖次数', 'int(10) NULL', 'num', '0', '', '1', '', '1167', '0', '1', '1432619288', '1432619288', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11478', 'uid', 'uid', 'int(10) NULL', 'num', '', '', '0', '', '1167', '0', '1', '1435313298', '1435313298', '', '3', '', 'regex', 'get_mid', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11479', 'cTime', '支持时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1167', '0', '1', '1432690461', '1432690461', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11480', 'keyword_type', '关键词匹配类型', 'tinyint(2) NULL', 'select', '0', '', '1', '0:完全匹配\r\n1:左边匹配\r\n2:右边匹配\r\n3:模糊匹配', '1168', '0', '1', '1394268247', '1393921586', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11481', 'api_token', 'Token', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1168', '0', '1', '1393922455', '1393912408', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11482', 'cTime', '创建时间', 'int(10) NOT NULL', 'datetime', '', '', '0', '', '1168', '0', '1', '1393913608', '1393913608', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11483', 'api_url', '第三方URL', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1168', '0', '1', '1393912354', '1393912354', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11484', 'output_format', '数据输出格式', 'tinyint(1) NULL', 'select', '0', '', '1', '0:标准微信xml\r\n1:json格式', '1168', '0', '1', '1394268422', '1393912288', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11485', 'keyword_filter', '关键词过滤', 'tinyint(2) NOT NULL', 'bool', '0', '如设置电影为触发词,用户输入 电影 美国派 时，如果启用过滤只将美国派这个词发送到的你的接口，如果不过滤 就是整个 电影 美国派全部发送到的接口', '1', '0:不过滤\r\n1:过滤', '1168', '0', '1', '1394268410', '1393912057', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11486', 'keyword', '关键词', 'varchar(255) NOT NULL', 'string', '', '多个关键词请用空格格开', '1', '', '1168', '1', '1', '1393912492', '1393911842', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11487', 'token', 'Token', 'varchar(255) NOT NULL', 'string', '', '', '0', '', '1168', '0', '1', '1402454223', '1402454223', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11488', 'title', '标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1169', '1', '1', '1396624461', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11489', 'cTime', '发布时间', 'int(10) UNSIGNED NULL', 'datetime', '', '', '0', '', '1169', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11490', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1169', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11491', 'password', '表单密码', 'varchar(255) NULL', 'string', '', '如要用户输入密码才能进入表单，则填写此项。否则留空，用户可直接进入表单', '0', '', '1169', '0', '1', '1396871497', '1396672643', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11313', 'sort', '排序号', 'int(10) NULL ', 'num', '0', '数值越小越靠前', '1', '', '1148', '0', '1', '1396340334', '1396340334', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11308', 'title', '分类标题', 'varchar(100) NOT NULL', 'string', '', '', '1', '', '1148', '1', '1', '1408950771', '1395988016', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11291', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1145', '0', '1', '1396603007', '1396603007', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11290', 'sort', '排序号', 'int(10) unsigned NULL ', 'num', '0', '', '1', '', '1145', '0', '1', '1396580674', '1396580674', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11289', 'view_count', '浏览数', 'int(10) unsigned NULL ', 'num', '0', '', '0', '', '1145', '0', '1', '1396580643', '1396580643', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11288', 'content', '回复内容', 'text NULL', 'textarea', '', '请不要多于1000字否则无法发送。支持加超链接，但URL必须带http://', '1', '', '1145', '0', '1', '1396607362', '1396578597', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('723', 'sn', 'SN码', 'varchar(255) NULL', 'string', '', '', '0', '', '81', '0', '1', '1399272236', '1399272228', '', '3', '', 'regex', 'uniqid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('724', 'uid', '粉丝UID', 'int(10) NULL', 'num', '', '', '0', '', '81', '0', '1', '1399772738', '1399272401', '', '3', '', 'regex', 'get_mid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('725', 'cTime', '创建时间', 'int(10) NULL', 'datetime', '', '', '0', '', '81', '0', '1', '1399272456', '1399272456', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('726', 'is_use', '是否已使用', 'tinyint(2) NULL', 'bool', '0', '', '0', '0:未使用\r\n1:已使用', '81', '0', '1', '1400601159', '1399272514', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('727', 'use_time', '使用时间', 'int(10) NULL', 'datetime', '', '', '0', '', '81', '0', '1', '1399272560', '1399272537', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('728', 'addon', '来自的插件', 'varchar(255) NULL', 'string', 'Coupon', '', '4', '', '81', '0', '1', '1399272651', '1399272651', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('729', 'target_id', '来源ID', 'int(10) unsigned NULL ', 'num', '', '', '4', '', '81', '0', '1', '1399272705', '1399272705', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('730', 'prize_id', '奖项ID', 'int(10) unsigned NULL ', 'num', '', '', '0', '', '81', '0', '1', '1399686317', '1399686317', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('731', 'prize_title', '奖项', 'varchar(255) NULL', 'string', '', '', '1', '', '81', '0', '1', '1399790367', '1399790367', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('732', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '81', '0', '1', '1404525481', '1404525481', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('733', 'can_use', '是否可用', 'tinyint(2) NULL', 'bool', '1', '', '0', '0:不可用\r\n1:可用', '81', '0', '1', '1418890020', '1418890020', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('734', 'server_addr', '服务器IP', 'varchar(50) NULL', 'string', '', '', '1', '', '81', '0', '1', '1425807865', '1425807865', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('776', 'title', '应用标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '87', '1', '1', '1402758132', '1394033402', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('777', 'uid', '用户ID', 'int(10) NULL ', 'num', '0', '', '0', '', '87', '0', '1', '1394087733', '1394033447', '', '3', '', 'regex', 'get_mid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('778', 'content', '应用详细介绍', 'text NULL ', 'editor', '', '', '1', '', '87', '1', '1', '1402758118', '1394033484', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('779', 'cTime', '发布时间', 'int(10) NULL ', 'datetime', '', '', '0', '', '87', '0', '1', '1394033571', '1394033571', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('780', 'attach', '应用压缩包', 'varchar(255) NULL ', 'file', '', '需要上传zip文件', '1', '', '87', '0', '1', '1402758100', '1394033674', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('781', 'is_top', '置顶', 'int(10) NULL ', 'bool', '0', '0表示不置顶，否则其它值表示置顶且值是置顶的时间', '1', '0:不置顶\r\n1:置顶', '87', '0', '1', '1402800009', '1394068787', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('782', 'cid', '分类', 'tinyint(4) NULL ', 'select', '', '', '0', '1:基础模块\r\n2:行业模块\r\n3:会议活动\r\n4:娱乐模块\r\n5:其它模块', '87', '0', '1', '1402758069', '1394069964', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('783', 'view_count', '浏览数', 'int(11) unsigned NULL ', 'num', '0', '', '0', '', '87', '0', '1', '1394072168', '1394072168', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('784', 'download_count', '下载数', 'int(10) unsigned NULL ', 'num', '0', '', '0', '', '87', '0', '1', '1394085763', '1394085763', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('785', 'img_2', '应用截图2', 'int(10) unsigned NULL ', 'picture', '', '', '1', '', '87', '0', '1', '1402758035', '1394084714', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('786', 'img_1', '应用截图1', 'int(10) unsigned NULL ', 'picture', '', '', '1', '', '87', '0', '1', '1402758046', '1394084635', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('787', 'img_3', '应用截图3', 'int(10) unsigned NULL ', 'picture', '', '', '1', '', '87', '0', '1', '1402758021', '1394084757', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('788', 'img_4', '应用截图4', 'int(10) unsigned NULL ', 'picture', '', '', '1', '', '87', '0', '1', '1402758011', '1394084797', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('789', 'uid', 'uid', 'int(10) NULL', 'num', '', '', '1', '', '88', '0', '1', '1430880974', '1430880974', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('790', 'name', '素材名称', 'varchar(100) NULL', 'string', '', '', '1', '', '88', '0', '1', '1424612322', '1424611929', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('791', 'status', '状态', 'char(10) NULL', 'radio', 'UnSubmit', '', '1', 'UnSubmit:未提交\r\nWaiting:入库中\r\nSuccess:入库成功\r\nFailure:入库失败', '88', '0', '1', '1424612039', '1424612039', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('792', 'cTime', '提交时间', 'int(10) NULL', 'datetime', '', '', '1', '', '88', '0', '1', '1424612114', '1424612114', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('793', 'url', '实际摇一摇所使用的页面URL', 'varchar(255) NULL', 'string', '', '', '1', '', '88', '0', '1', '1424612483', '1424612154', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('794', 'type', '素材类型', 'varchar(255) NULL', 'string', '', '', '1', '', '88', '0', '1', '1424612421', '1424612421', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('795', 'detail', '素材内容', 'text NULL', 'textarea', '', '', '1', '', '88', '0', '1', '1424612456', '1424612456', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('796', 'reason', '入库失败的原因', 'text NULL', 'textarea', '', '', '1', '', '88', '0', '1', '1424612509', '1424612509', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('797', 'create_time', '申请时间', 'int(10) NULL', 'datetime', '', '', '1', '', '88', '0', '1', '1424612542', '1424612542', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('798', 'checked_time', '入库时间', 'int(10) NULL', 'datetime', '', '', '1', '', '88', '0', '1', '1424612571', '1424612571', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('799', 'source', '来源', 'varchar(50) NULL', 'string', '', '', '1', '', '88', '0', '1', '1424836818', '1424836818', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('800', 'source_id', '来源ID', 'int(10) NULL', 'num', '', '', '1', '', '88', '0', '1', '1424836842', '1424836842', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('801', 'wechat_id', '微信端的素材ID', 'int(10) NULL', 'num', '', '', '0', '', '88', '0', '1', '1425370605', '1425370605', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('802', 'uid', '管理员id', 'int(10) NULL', 'num', '', '', '1', '', '89', '0', '1', '1431575588', '1431575588', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('803', 'token', '用户token', 'varchar(255) NULL', 'string', '', '', '1', '', '89', '0', '1', '1431575617', '1431575617', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('804', 'addons', '插件名称', 'varchar(255) NULL', 'string', '', '', '1', '', '89', '0', '1', '1431590322', '1431575667', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('805', 'template', '模版名称', 'varchar(255) NULL', 'string', '', '', '1', '', '89', '0', '1', '1431575691', '1431575691', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('832', 'title', '公告标题', 'varchar(255) NULL', 'string', '', '', '1', '', '93', '1', '1', '1431143985', '1431143985', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('833', 'content', '公告内容', 'text  NULL', 'editor', '', '', '1', '', '93', '1', '1', '1431144020', '1431144020', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('834', 'create_time', '发布时间', 'int(10) NULL', 'datetime', '', '', '4', '', '93', '0', '1', '1431146373', '1431144069', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('835', 'version', '版本号', 'int(10) unsigned NOT NULL ', 'num', '', '', '1', '', '94', '1', '1', '1393770457', '1393770457', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('836', 'title', '升级包名', 'varchar(50) NOT NULL', 'string', '', '', '1', '', '94', '1', '1', '1393770499', '1393770499', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('837', 'description', '描述', 'text NULL', 'textarea', '', '', '1', '', '94', '0', '1', '1393770546', '1393770546', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('838', 'create_date', '创建时间', 'int(10) NULL', 'datetime', '', '', '1', '', '94', '0', '1', '1393770591', '1393770591', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('839', 'download_count', '下载统计', 'int(10) unsigned NULL ', 'num', '0', '', '0', '', '94', '0', '1', '1393770659', '1393770659', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('840', 'package', '升级包地址', 'varchar(255) NOT NULL', 'textarea', '', '', '1', '', '94', '1', '1', '1393812247', '1393770727', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11980', 'template', '素材模板', 'varchar(255) NULL', 'string', 'default', '', '1', '', '1221', '0', '1', '1431659474', '1431659474', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11979', 'background', '背景图', 'int(10) UNSIGNED NULL', 'picture', '', '图片尺寸建议是760X421 并且主要内容要居中并留出大转盘位置', '1', '', '1221', '0', '1', '1419997464', '1419997464', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11977', 'start_date', '开始时间', 'int(10) NULL ', 'datetime', '', '', '1', '', '1221', '0', '1', '1395395676', '1395395179', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('11978', 'experience', '消耗经验值', 'int(10) NULL', 'num', '0', '', '1', '', '1221', '0', '1', '1419299966', '1419299966', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11976', 'keyword', '关键词', 'varchar(255) NULL ', 'string', '', '用户发送 “关键词” 触发', '1', '', '1221', '0', '1', '1395395713', '1395395179', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('11975', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1221', '0', '1', '1395396571', '1395396571', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11974', 'des_jj', '活动介绍', 'text NULL ', 'textarea', '', '活动介绍简介 用于给用户发送消息时候的图文描述', '1', '', '1221', '0', '1', '1431068323', '1395395179', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('11973', 'des', '活动介绍', 'text NULL ', 'textarea', '', '', '0', '', '1221', '0', '1', '1431068356', '1395395179', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('11972', 'choujnum', '每日抽奖次数', 'int(10) unsigned NULL ', 'num', '0', '', '1', '', '1221', '0', '1', '1395395485', '1395395179', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('11971', 'guiz', '活动规则', 'text NULL ', 'textarea', '', '', '1', '', '1221', '0', '1', '1418369751', '1395395179', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('11970', 'title', '活动标题', 'varchar(255) NULL ', 'string', '', '', '1', '', '1221', '0', '1', '1395395535', '1395395179', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('11969', 'picurl', '封面图片', 'int(10) unsigned NULL ', 'picture', '', '', '1', '', '1221', '1', '1', '1439370422', '1395395179', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('11968', 'states', '活动状态', 'char(10) NULL ', 'radio', '0', '', '0', '0:未开始\r\n1:已结束', '1221', '0', '1', '1395395602', '1395395179', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('11967', 'cTime', '活动创建时间', 'int(10) NULL ', 'datetime', '', '', '0', '', '1221', '0', '1', '1395395963', '1395395179', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11966', 'end_date', '结束日期', 'int(10) NULL ', 'datetime', '', '', '1', '', '1221', '0', '1', '1395395670', '1395395179', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('11965', 'template', '素材模板', 'varchar(255) NULL', 'string', 'default', '', '1', '', '1220', '0', '1', '1430132994', '1430132994', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11964', 'prize_title', '活动标题', 'varchar(255) NULL', 'string', '', '', '1', '', '1220', '1', '1', '1429855569', '1429855569', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11963', 'use_content', '使用说明', 'text NULL', 'textarea', '', '用户领取成功后才会看到', '1', '', '1220', '1', '1', '1429757185', '1429757185', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11960', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '0', '', '1220', '0', '1', '1429521039', '1429521039', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11961', 'fail_content', '领取失败提示', 'text NULL', 'textarea', '', '用户领取失败，或者没有领取到时看到的提示', '1', '', '1220', '1', '1', '1429860149', '1429860149', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11962', 'prize_type', '奖品类型', 'tinyint(2) NULL', 'radio', '1', '选择奖品类型', '1', '1:实物\r\n0:虚拟', '1220', '1', '1', '1429756998', '1429756539', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('896', 'ToUserName', 'Token', 'varchar(100) NULL', 'string', '', '', '0', '', '103', '0', '1', '1438143065', '1438143065', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('897', 'FromUserName', 'OpenID', 'varchar(100) NULL', 'string', '', '', '0', '', '103', '0', '1', '1438143098', '1438143098', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('898', 'CreateTime', '创建时间', 'int(10) NULL', 'datetime', '', '', '0', '', '103', '0', '1', '1438143120', '1438143120', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('899', 'MsgType', '消息类型', 'varchar(30) NULL', 'string', '', '', '0', '', '103', '0', '1', '1438143139', '1438143139', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('900', 'MsgId', '消息ID', 'varchar(100) NULL', 'string', '', '', '0', '', '103', '0', '1', '1438143182', '1438143182', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('901', 'Content', '文本消息内容', 'text NULL', 'textarea', '', '', '0', '', '103', '0', '1', '1438143218', '1438143218', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('902', 'PicUrl', '图片链接', 'varchar(255) NULL', 'string', '', '', '0', '', '103', '0', '1', '1438143273', '1438143273', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('903', 'MediaId', '多媒体文件ID', 'varchar(100) NULL', 'string', '', '', '0', '', '103', '0', '1', '1438143357', '1438143357', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('904', 'Format', '语音格式', 'varchar(30) NULL', 'string', '', '', '0', '', '103', '0', '1', '1438143397', '1438143397', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('905', 'ThumbMediaId', '缩略图的媒体id', 'varchar(30) NULL', 'string', '', '', '0', '', '103', '0', '1', '1438143445', '1438143426', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('906', 'Title', '消息标题', 'varchar(100) NULL', 'string', '', '', '0', '', '103', '0', '1', '1438143471', '1438143471', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('907', 'Description', '消息描述', 'text NULL', 'textarea', '', '', '0', '', '103', '0', '1', '1438143535', '1438143535', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('908', 'Url', 'Url', 'varchar(255) NULL', 'string', '', '', '0', '', '103', '0', '1', '1438143558', '1438143558', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('909', 'collect', '收藏状态', 'tinyint(1) NULL', 'bool', '0', '', '0', '0:未收藏\r\n1:已收藏', '103', '0', '1', '1438153936', '1438153936', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('910', 'deal', '处理状态', 'tinyint(1) NULL', 'bool', '0', '', '0', '0:未处理\r\n1:已处理', '103', '0', '1', '1438165005', '1438153991', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('911', 'is_read', '是否已读', 'tinyint(1) NULL', 'bool', '0', '', '1', '0:未读\r\n1:已读', '103', '0', '1', '1438165062', '1438165062', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('912', 'type', '消息分类', 'tinyint(1) NULL', 'bool', '0', '', '1', '0:用户消息\r\n1:管理员回复消息', '103', '0', '1', '1438168301', '1438168301', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12002', 'num', '库存数量', 'int(10) unsigned NULL ', 'num', '0', '', '1', '', '1224', '0', '1', '1396667941', '1395395190', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('12001', 'miaoshu', '奖品描述', 'text NULL ', 'textarea', '', '', '1', '', '1224', '0', '1', '1418628021', '1395395190', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('12000', 'pic', '奖品图片', 'int(10) unsigned NULL ', 'picture', '', '', '1', '', '1224', '0', '1', '1395495279', '1395395190', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('12008', 'uid', '用户id', 'varchar(255) NULL', 'string', '', '用户id', '0', '', '1225', '0', '1', '1395567404', '1395567404', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11998', 'duijma', '兑奖码', 'text NULL', 'textarea', '', '请输入兑奖码，一行一个', '0', '', '1224', '0', '1', '1419300292', '1396253842', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11999', 'title', '奖品名称', 'varchar(255) NULL ', 'string', '', '', '1', '', '1224', '0', '1', '1395495283', '1395395190', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('1062', 'login_name', 'login_name', 'varchar(100) NULL', 'string', '', '', '1', '', '1', '0', '1', '1447302647', '1439978705', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1063', 'content', '文本消息内容', 'text NULL', 'textarea', '', '', '0', '', '18', '0', '1', '1439980070', '1439980070', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11986', 'gailv_maxnum', '单日发放上限', 'int(10) UNSIGNED NULL', 'num', '0', '每天最多发放奖品的数量', '1', '', '1222', '0', '1', '1395559281', '1395559281', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11987', 'xydzp_option_id', '幸运大转盘关联的全局奖品id', 'int(10) UNSIGNED NULL', 'num', '', '幸运大转盘关联的全局奖品id', '0', '', '1222', '0', '1', '1395555085', '1395555085', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11988', 'uid', '用户openid', 'varchar(255) NULL', 'string', '', '', '0', '', '1223', '0', '1', '1396686415', '1396686415', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11989', 'message', '留言', 'text NULL ', 'string', '', '', '1', '', '1223', '0', '1', '1395395200', '1395395200', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11990', 'address', '收件地址', 'text NULL ', 'string', '', '', '1', '', '1223', '0', '1', '1395395200', '1395395200', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('1071', 'is_bind', '是否为微信开放平台绑定账号', 'tinyint(2) NULL', 'bool', '0', '', '0', '0:否\r\n1:是', '6', '0', '1', '1440746890', '1440746890', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11984', 'jlnum', '奖励数量', 'int(10) UNSIGNED NULL', 'num', '1', '中奖后，获得该奖品的数量', '0', '', '1222', '0', '1', '1419303776', '1395559386', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11985', 'type', '奖品中奖方式', 'char(50) NULL', 'select', '0', '选择奖品中奖的方式', '0', '0:按概率中奖\r\n1:按时间中奖(未启用)\r\n2:按顺序中奖(未启用)\r\n3:按指定用户id中奖(未启用)', '1222', '0', '1', '1419303723', '1395559102', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11983', 'xydzp_id', '幸运大转盘关联的活动id', 'int(10) UNSIGNED NULL', 'num', '0', '幸运大转盘关联的活动id', '0', '', '1222', '0', '1', '1395555019', '1395555019', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11878', 'cover', '封面图片', 'int(10) unsigned NULL ', 'picture', '', '可为空', '1', '', '1210', '0', '1', '1399710705', '1396062093', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11877', 'end_time', '结束时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1210', '0', '1', '1399259433', '1399259433', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11876', 'intro', '封面简介', 'text NULL', 'editor', '', '', '1', '', '1210', '0', '1', '1420983308', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11875', 'title', '标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1210', '1', '1', '1396624461', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11869', 'num', '名额数量', 'int(10) unsigned NULL ', 'num', '', '', '1', '', '1209', '1', '1', '1439370137', '1399348843', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11870', 'sort', '排序号', 'int(10) unsigned NULL ', 'num', '0', '值越小越靠前', '1', '', '1209', '0', '1', '1399557716', '1399557716', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11871', 'img', '奖品图片', 'int(10) unsigned NULL ', 'picture', '', '', '1', '', '1209', '0', '1', '1399557997', '1399557997', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11872', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1209', '0', '1', '1404525428', '1404525428', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11873', 'keyword', '关键词', 'varchar(100) NOT NULL', 'string', '', '', '1', '', '1210', '1', '1', '1396624337', '1396061575', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11874', 'use_tips', '使用说明', 'varchar(255) NOT NULL', 'textarea', '', '用户获取刮刮卡后显示的提示信息', '1', '', '1210', '1', '1', '1420989679', '1399259489', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1101', 'url', '图文页url', 'varchar(255) NULL', 'string', '', '', '0', '', '17', '0', '1', '1441077355', '1441077355', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11991', 'iphone', '电话', 'varchar(255) NULL ', 'string', '', '', '1', '', '1223', '0', '1', '1395395200', '1395395200', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11992', 'zip', '邮编', 'int(10) unsigned NULL ', 'string', '', '', '1', '', '1223', '0', '1', '1395395200', '1395395200', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11993', 'state', '领奖状态', 'tinyint(2) NULL', 'bool', '0', '', '0', '0:未领取\r\n1:已领取', '1223', '0', '1', '1396705093', '1395395200', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('11994', 'xydzp_option_id', '奖品id', 'int(10) unsigned NULL ', 'string', '0', '', '1', '', '1223', '0', '1', '1395395200', '1395395200', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11995', 'xydzp_id', '活动id', 'int(10) unsigned NULL ', 'string', '0', '', '1', '', '1223', '0', '1', '1395395200', '1395395200', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11996', 'zjdate', '中奖时间', 'int(10) UNSIGNED NULL', 'num', '', '', '0', '', '1223', '0', '1', '1396191999', '1396191999', '', '3', '', 'regex', 'time()', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11997', 'jptype', '奖品类型', 'char(10) NULL ', 'select', '0', '奖品的类型', '1', '0:经验值|coupon_id@hide,experience@show,num@show,card_url@hide\r\n1:优惠券|coupon_id@show,experience@hide,num@show,card_url@hide\r\n2:谢谢参与|coupon_id@hide,experience@hide,num@hide,card_url@hide\r\n3:微信卡券|coupon_id@hide,experience@hide,num@show,card_url@show', '1224', '0', '1', '1420207419', '1395395190', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1825', 'ToUserName', 'token', 'varchar(255) NULL', 'string', '', '', '1', '', '201', '0', '1', '1447241964', '1447241964', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1826', 'FromUserName', 'openid', 'varchar(255) NULL', 'string', '', '', '1', '', '201', '0', '1', '1447242006', '1447242006', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1827', 'cTime', '创建时间', 'int(10) NULL', 'datetime', '', '', '1', '', '201', '0', '1', '1447242030', '1447242030', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1828', 'msgType', '消息类型', 'varchar(255) NULL', 'string', '', '', '1', '', '201', '0', '1', '1447242059', '1447242059', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1829', 'manager_id', '管理员id', 'int(10) NULL', 'num', '', '', '1', '', '201', '0', '1', '1447242090', '1447242090', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1830', 'content', '内容', 'text NULL', 'textarea', '', '', '1', '', '201', '0', '1', '1447242120', '1447242120', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1831', 'media_id', '多媒体文件id', 'varchar(255) NULL', 'string', '', '', '1', '', '201', '0', '1', '1447242146', '1447242146', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1832', 'is_send', '是否已经发送', 'int(10) NULL', 'num', '', '', '1', '0:未发\r\n1:已发', '201', '0', '1', '1447242181', '1447242181', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1833', 'uid', '粉丝uid', 'int(10) NULL', 'num', '', '', '1', '', '201', '0', '1', '1447242202', '1447242202', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1834', 'news_group_id', '图文组id', 'varchar(255) NULL', 'string', '', '', '1', '', '201', '0', '1', '1447242229', '1447242229', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1835', 'video_title', '视频标题', 'varchar(255) NULL', 'string', '', '', '1', '', '201', '0', '1', '1447242267', '1447242267', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1836', 'video_description', '视频描述', 'text NULL', 'textarea', '', '', '1', '', '201', '0', '1', '1447242291', '1447242291', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1837', 'video_thumb', '视频缩略图', 'varchar(255) NULL', 'string', '', '', '1', '', '201', '0', '1', '1447242366', '1447242366', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1844', 'voice_id', '语音id', 'int(10) NULL', 'num', '', '', '1', '', '201', '0', '1', '1447242400', '1447242400', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1845', 'image_id', '图片id', 'int(10) NULL', 'num', '', '', '1', '', '201', '0', '1', '1447242440', '1447242440', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1846', 'video_id', '视频id', 'int(10) NULL', 'num', '', '', '1', '', '201', '0', '1', '1447242464', '1447242464', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1847', 'send_type', '发送方式', 'int(10) NULL', 'num', '', '', '1', '0:分组\r\n1:指定用户', '201', '0', '1', '1447242498', '1447242498', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1848', 'send_opends', '指定用户', 'text NULL', 'textarea', '', '', '1', '', '201', '0', '1', '1447242529', '1447242529', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1849', 'group_id', '分组id', 'int(10) NULL', 'num', '', '', '1', '', '201', '0', '1', '1447242553', '1447242553', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1850', 'diff', '区分消息标识', 'int(10) NULL', 'num', '0', '', '1', '', '201', '0', '1', '1447242584', '1447242584', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1326', 'content', '文本内容', 'text NULL', 'textarea', '', '', '1', '', '148', '1', '1', '1442976151', '1442976151', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1327', 'token', 'Token', 'varchar(50) NULL', 'string', '', '', '0', '', '148', '0', '1', '1442978004', '1442978004', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('1328', 'uid', 'uid', 'int(10) NULL', 'num', '', '', '0', '', '148', '0', '1', '1442978041', '1442978041', '', '3', '', 'regex', 'get_mid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('1820', 'is_use', '可否使用', 'int(10) NULL', 'num', '1', '', '0', '0:不可用\r\n1:可用', '148', '0', '1', '1445496947', '1445496947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1821', 'aim_id', '添加来源标识id', 'int(10) NULL', 'num', '', '', '0', '', '148', '0', '1', '1445497010', '1445497010', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1822', 'aim_table', '来源表名', 'varchar(255) NULL', 'string', '', '', '0', '', '148', '0', '1', '1445497218', '1445497218', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1329', 'file_id', '上传文件', 'int(10) NULL', 'file', '', '', '1', '', '149', '0', '1', '1442982169', '1438684652', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1330', 'cover_url', '本地URL', 'varchar(255) NULL', 'string', '', '', '0', '', '149', '0', '1', '1438684692', '1438684692', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1331', 'media_id', '微信端图文消息素材的media_id', 'varchar(100) NULL', 'string', '0', '', '0', '', '149', '0', '1', '1438744962', '1438684776', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1332', 'wechat_url', '微信端的文件地址', 'varchar(255) NULL', 'string', '', '', '0', '', '149', '0', '1', '1439973558', '1438684807', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1333', 'cTime', '创建时间', 'int(10) NULL', 'datetime', '', '', '0', '', '149', '0', '1', '1443004484', '1438684829', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('1334', 'manager_id', '管理员ID', 'int(10) NULL', 'num', '', '', '0', '', '149', '0', '1', '1442982446', '1438684847', '', '3', '', 'regex', 'get_mid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('1335', 'token', 'Token', 'varchar(100) NULL', 'string', '', '', '0', '', '149', '0', '1', '1442982460', '1438684865', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('1336', 'title', '素材名称', 'varchar(100) NULL', 'string', '', '', '1', '', '149', '0', '1', '1442981165', '1442981165', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1341', 'type', '类型', 'int(10) NULL', 'num', '', '', '0', '1:语音素材\r\n2:视频素材', '149', '0', '1', '1445599238', '1443006101', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1838', 'introduction', '描述', 'text NULL', 'textarea', '', '', '0', '', '149', '0', '1', '1447299133', '1445684769', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1121', 'level', '管理等级', 'tinyint(2) NULL', 'num', '0', '', '0', '', '1', '0', '1', '1441522953', '1441522953', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12007', 'card_url', '领取卡券的地址', 'varchar(255) NULL', 'string', '', '', '1', '', '1224', '0', '1', '1420207297', '1420207297', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12009', 'xydzp_id', '幸运大转盘关联的活动id', 'int(10) UNSIGNED NULL', 'num', '', '幸运大转盘关联的活动id', '0', '', '1225', '0', '1', '1395567452', '1395567452', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12010', 'num', '已经抽奖的次数', 'int(10) UNSIGNED NULL', 'num', '0', '', '1', '', '1225', '0', '1', '1395567486', '1395567486', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12011', 'cjdate', '抽奖日期', 'int(10) NULL', 'datetime', '', '', '1', '', '1225', '0', '1', '1395567537', '1395567537', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12012', 'title', '标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1226', '1', '1', '1396624461', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12013', 'cTime', '发布时间', 'int(10) UNSIGNED NULL', 'datetime', '', '', '0', '', '1226', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('12014', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1226', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('12015', 'password', '微预约密码', 'varchar(255) NULL', 'string', '', '如要用户输入密码才能进入微预约，则填写此项。否则留空，用户可直接进入微预约', '0', '', '1226', '0', '1', '1396871497', '1396672643', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12016', 'jump_url', '提交后跳转的地址', 'varchar(255) NULL', 'string', '', '要以http://开头的完整地址，为空时不跳转', '1', '', '1226', '0', '1', '1402458121', '1399800276', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12017', 'content', '详细介绍', 'text NULL', 'editor', '', '可不填', '1', '', '1226', '0', '1', '1396865295', '1396865295', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12018', 'finish_tip', '用户提交后提示内容', 'text NULL', 'textarea', '', '为空默认为：提交成功，谢谢参与', '1', '', '1226', '0', '1', '1396676366', '1396673689', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12019', 'can_edit', '是否允许编辑', 'tinyint(2) NULL', 'bool', '0', '用户提交预约是否可以再编辑', '1', '0:不允许\r\n1:允许', '1226', '0', '1', '1396688624', '1396688624', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11744', 'cover', '封面图片', 'int(10) unsigned NULL ', 'picture', '', '', '1', '', '1193', '1', '1', '1439368240', '1396062093', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11743', 'mTime', '修改时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1193', '0', '1', '1396624664', '1396624664', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11742', 'intro', '封面简介', 'text NULL', 'textarea', '', '', '1', '', '1193', '0', '1', '1396624505', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11741', 'title', '标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1193', '1', '1', '1396624461', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11739', 'keyword', '关键词', 'varchar(100) NOT NULL', 'string', '', '', '1', '', '1193', '1', '1', '1396624337', '1396061575', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11740', 'keyword_type', '关键词类型', 'tinyint(2) NOT NULL', 'select', '0', '', '1', '0:完全匹配\r\n1:左边匹配\r\n2:右边匹配\r\n3:模糊匹配\r\n4:正则匹配\r\n5:随机匹配', '1193', '1', '1', '1396624426', '1396061765', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11982', 'gailv_str', '参数', 'varchar(255) NULL', 'string', '', '请输入对应中奖方式的相应值 多个以英文状态下的 逗号(,)分隔', '0', '', '1222', '0', '1', '1419303819', '1395559219', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11981', 'gailv', '中奖概率', 'int(10) UNSIGNED NULL', 'num', '0', '请输入0-100之间的整数', '1', '', '1222', '0', '1', '1419303857', '1395559151', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1112', 'login_password', '登录密码', 'varchar(255) NULL', 'string', '', '', '1', '', '1', '0', '1', '1441187439', '1441187439', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1114', 'manager_id', '公众号管理员ID', 'int(10) NULL', 'num', '0', '', '0', '', '1', '0', '1', '1441512815', '1441512815', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12005', 'coupon_id', '优惠券编号', 'int(10) NULL', 'num', '', '', '1', '', '1224', '0', '1', '1419300336', '1419300336', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12006', 'experience', '奖励经验值', 'int(10) NULL', 'num', '0', '', '1', '', '1224', '0', '1', '1419300396', '1419300396', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12004', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1224', '0', '1', '1395554191', '1395554191', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12003', 'isdf', '是否为谢谢惠顾类', 'tinyint(2) NULL', 'bool', '0', '', '0', '0:中奖品\r\n1:该奖为谢谢惠顾类', '1224', '0', '1', '1419392345', '1396191564', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11867', 'title', '奖项标题', 'varchar(255) NULL', 'string', '', '如特等奖、一等奖。。。', '1', '', '1209', '1', '1', '1439370111', '1399348734', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11868', 'name', '奖项', 'varchar(255) NULL', 'string', '', '如iphone、吹风机等', '1', '', '1209', '1', '1', '1439370125', '1399348785', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11757', 'survey_id', 'survey_id', 'int(10) unsigned NOT NULL ', 'num', '', '', '4', '', '1194', '1', '1', '1396955403', '1396955369', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11753', 'uid', '用户UID', 'int(10) NULL ', 'num', '', '', '0', '', '1194', '0', '1', '1396955530', '1396955530', '', '3', '', 'regex', 'get_mid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11754', 'question_id', 'question_id', 'int(10) unsigned NOT NULL ', 'num', '', '', '4', '', '1194', '1', '1', '1396955412', '1396955392', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11755', 'cTime', '发布时间', 'int(10) unsigned NULL ', 'datetime', '', '', '0', '', '1194', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11756', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1194', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11745', 'cTime', '发布时间', 'int(10) unsigned NULL ', 'datetime', '', '', '0', '', '1193', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11746', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1193', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11747', 'finish_tip', '结束语', 'text NULL', 'string', '', '为空默认为：调研完成，谢谢参与', '1', '', '1193', '0', '1', '1447640072', '1396953940', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11748', 'template', '素材模板', 'varchar(255) NULL', 'string', 'default', '', '1', '', '1193', '0', '1', '1430193696', '1430193696', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11749', 'start_time', '开始时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1193', '1', '1', '1440408604', '1440407931', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11750', 'end_time', '结束时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1193', '1', '1', '1440408598', '1440407951', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11751', 'answer', '回答内容', 'text NULL', 'textarea', '', '', '0', '', '1194', '0', '1', '1396955766', '1396955766', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11752', 'openid', 'OpenId', 'varchar(255) NULL', 'string', '', '', '0', '', '1194', '0', '1', '1396955581', '1396955581', '', '3', '', 'regex', 'get_openid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('1155', 'membership', '会员等级', 'char(50) NULL', 'select', '0', '请在会员等级 添加会员级别名称', '0', '', '1', '0', '1', '1447302405', '1441795509', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11758', 'title', '标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1195', '1', '1', '1396624461', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11759', 'intro', '问题描述', 'text NULL', 'textarea', '', '', '1', '', '1195', '0', '1', '1396954176', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11760', 'cTime', '发布时间', 'int(10) unsigned NULL ', 'datetime', '', '', '0', '', '1195', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11761', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1195', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11762', 'is_must', '是否必填', 'tinyint(2) NULL', 'bool', '0', '', '1', '0:否\r\n1:是', '1195', '0', '1', '1396954649', '1396954649', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11763', 'extra', '参数', 'text NULL', 'textarea', '', '类型为单选、多选时的定义数据，格式见上面的提示', '1', '', '1195', '0', '1', '1396954558', '1396954558', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11764', 'type', '问题类型', 'char(50) NOT NULL', 'radio', 'radio', '', '1', 'radio:单选题\r\ncheckbox:多选题\r\ntextarea:简答题', '1195', '1', '1', '1396962517', '1396954463', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11765', 'survey_id', 'survey_id', 'int(10) unsigned NOT NULL ', 'num', '', '', '4', '', '1195', '1', '1', '1396954240', '1396954240', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11766', 'sort', '排序号', 'int(10) unsigned NULL ', 'num', '0', '值越小越靠前', '1', '', '1195', '0', '1', '1396955010', '1396955010', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11767', 'title', '商店名称', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1196', '1', '1', '1422671603', '1422671261', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11768', 'logo', '商店LOGO', 'int(10) NULL', 'picture', '', '', '1', '', '1196', '0', '1', '1422950521', '1422671295', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11769', 'intro', '店铺简介', 'text NULL', 'textarea', '', '', '1', '', '1196', '0', '1', '1422671570', '1422671345', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11770', 'mobile', '联系电话', 'varchar(30) NULL', 'string', '', '', '1', '', '1196', '0', '1', '1422671410', '1422671410', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11771', 'qq', 'QQ', 'int(10) NULL', 'num', '', '', '1', '', '1196', '0', '1', '1422671498', '1422671498', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11772', 'wechat', '微信', 'varchar(50) NULL', 'string', '', '', '1', '', '1196', '0', '1', '1422671544', '1422671544', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11773', 'template', '模板', 'varchar(30) NULL', 'string', '', '', '0', '', '1196', '0', '1', '1422950165', '1422950165', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11774', 'content', '店铺介绍', 'text  NULL', 'editor', '', '', '1', '', '1196', '0', '1', '1423108654', '1423108654', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11775', 'token', 'Token', 'varchar(100) NULL', 'string', '', '', '0', '', '1196', '0', '1', '1439456512', '1439455806', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11776', 'manager_id', '管理员ID', 'int(10) NULL', 'num', '', '', '0', '', '1196', '0', '1', '1439456496', '1439455828', '', '3', '', 'regex', 'get_mid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11777', 'cover', '商品封面图', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '1197', '0', '1', '1431071756', '1422672306', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11778', 'content', '商品介绍', 'text NOT NULL', 'editor', '', '', '1', '', '1197', '0', '1', '1422672255', '1422672255', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11779', 'title', '商品名称', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1197', '1', '1', '1422672113', '1422672113', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11780', 'price', '价格', 'decimal(10,2) NULL', 'num', '0', '', '1', '', '1197', '0', '1', '1439468076', '1422672186', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11781', 'imgs', '商品图片', 'varchar(255) NOT NULL', 'mult_picture', '', '可以上传多个图片', '1', '', '1197', '0', '1', '1438331467', '1422672449', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11782', 'inventory', '库存数量', 'int(10) NULL', 'num', '0', '', '1', '', '1197', '0', '1', '1422935578', '1422672560', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11783', 'shop_id', '商店ID', 'int(10) NULL', 'num', '0', '', '4', '', '1197', '0', '1', '1422934861', '1422931951', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11784', 'is_show', '是否上架', 'tinyint(2) NULL', 'bool', '0', '', '1', '0:否\r\n1:是', '1197', '0', '1', '1422935533', '1422935533', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11785', 'sale_count', '销售量', 'int(10) NULL', 'num', '0', '', '0', '', '1197', '0', '1', '1422935712', '1422935600', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11786', 'is_recommend', '是否推荐', 'tinyint(2) NULL', 'bool', '', '推荐后首页的推荐商品里显示', '1', '0:否\r\n1:是', '1197', '0', '1', '1423107236', '1423107213', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11787', 'rank', '热销度', 'int(10) NULL', 'num', '0', '热销度由发布时间、推荐状态、销量三个维度进行计算得到', '0', '', '1197', '0', '1', '1423474955', '1423126715', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11788', 'show_time', '上架时间', 'int(10) NULL', 'datetime', '0', '', '0', '', '1197', '0', '1', '1423127849', '1423127833', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11789', 'old_price', '原价', 'int(10) NULL', 'num', '', '', '1', '', '1197', '0', '1', '1423132272', '1423132272', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11790', 'type', '商品类型', 'tinyint(2) NULL', 'bool', '0', '注：虚拟商品不支持货到付款', '0', '0:实物商品（需要快递）\r\n1:虚拟商品（不需要快递）', '1197', '0', '1', '1439549244', '1439458735', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11791', 'category_id', '商品分类', 'char(50) NULL', 'select', '', '', '1', '', '1197', '0', '1', '1440126604', '1440066901', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11792', 'uid', '使用UID', 'int(10) NULL', 'num', '', '', '0', '', '1198', '0', '1', '1423471296', '1423471296', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11793', 'goods_id', '商品ID', 'int(10) NULL', 'num', '', '', '0', '', '1198', '0', '1', '1423471321', '1423471321', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11794', 'cTime', '收藏时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1198', '0', '1', '1423471348', '1423471348', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11795', 'uid', '用户ID', 'int(10) UNSIGNED NOT NULL', 'num', '', '', '0', '', '1199', '0', '1', '1419577913', '1419577913', '', '3', '', 'regex', 'get_mid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11796', 'shop_id', '商店id', 'varchar(255) NOT NULL', 'string', '', '', '0', '', '1199', '0', '1', '1419578098', '1419577949', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11797', 'goods_id', '商品id', 'varchar(255) NOT NULL', 'string', '', '', '0', '', '1199', '0', '1', '1419578025', '1419578025', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11798', 'num', '数量', 'int(10) UNSIGNED NOT NULL', 'num', '', '', '1', '', '1199', '0', '1', '1419578075', '1419578075', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11799', 'price', '单价', 'varchar(30) NOT NULL', 'num', '', '', '0', '', '1199', '0', '1', '1419578162', '1419578154', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11800', 'goods_type', '商品类型', 'tinyint(2) NOT NULL', 'bool', '0', '', '1', '', '1199', '0', '1', '1420551825', '1420551825', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11801', 'openid', 'openid', 'varchar(255) NOT NULL', 'string', '', '', '0', '', '1199', '0', '1', '1420195356', '1420195356', '', '3', '', 'regex', 'get_openid', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11802', 'uid', '用户ID', 'int(10) NULL', 'num', '', '', '0', '', '1200', '1', '1', '1429522999', '1423477509', '', '3', '', 'regex', 'get_mid', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11803', 'truename', '收货人姓名', 'varchar(100) NULL', 'string', '', '', '1', '', '1200', '1', '1', '1423477690', '1423477548', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11804', 'mobile', '手机号码', 'varchar(50) NULL', 'string', '', '', '1', '', '1200', '1', '1', '1423477580', '1423477580', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11805', 'city', '城市', 'varchar(255) NULL', 'cascade', '', '', '1', 'module=city', '1200', '1', '1', '1423477660', '1423477660', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11806', 'address', '具体地址', 'varchar(255) NULL', 'string', '', '', '1', '', '1200', '1', '1', '1423477681', '1423477681', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11807', 'is_use', '是否设置为默认', 'tinyint(2) NULL', 'bool', '0', '', '1', '0:否\r\n1:是', '1200', '0', '1', '1423536697', '1423477729', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11808', 'title', '标题', 'varchar(255) NULL', 'string', '', '可为空', '1', '', '1201', '0', '1', '1396098316', '1396098316', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11809', 'img', '图片', 'int(10) unsigned NOT NULL ', 'picture', '', '', '1', '', '1201', '1', '1', '1396098349', '1396098349', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11810', 'url', '链接地址', 'varchar(255) NULL', 'string', '', '', '1', '', '1201', '0', '1', '1396098380', '1396098380', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11811', 'is_show', '是否显示', 'tinyint(2) NULL', 'bool', '1', '', '1', '0:不显示\r\n1:显示', '1201', '0', '1', '1396098464', '1396098464', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11812', 'sort', '排序', 'int(10) unsigned NULL ', 'num', '0', '值越小越靠前', '1', '', '1201', '0', '1', '1396098682', '1396098682', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11813', 'token', 'Token', 'varchar(100) NULL', 'string', '', '', '0', '', '1201', '0', '1', '1396098747', '1396098747', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11814', 'shop_id', '商店ID', 'int(10) NULL', 'num', '0', '', '4', '', '1201', '0', '1', '1422934490', '1422932093', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11815', 'order_id', '订单ID', 'int(10) NULL', 'num', '', '', '0', '', '1202', '0', '1', '1439525588', '1439525588', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11816', 'status_code', '状态码', 'char(50) NULL', 'select', '0', '', '0', '0:待支付\r\n1:待商家确认\r\n2:待发货\r\n3:配送中\r\n4:确认已收货\r\n5:确认已收款\r\n6:待评价\r\n7:已评价', '1202', '0', '1', '1439536678', '1439525934', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11817', 'remark', '备注内容', 'varchar(255) NULL', 'string', '', '', '0', '', '1202', '0', '1', '1439525979', '1439525979', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11818', 'cTime', '时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1202', '0', '1', '1439526002', '1439526002', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11819', 'extend', '扩展信息', 'varchar(255) NULL', 'string', '', '', '0', '', '1202', '0', '1', '1439526038', '1439526038', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11820', 'goods_datas', '商品序列化数据', 'text NOT NULL', 'textarea', '', '', '1', '', '1203', '0', '1', '1423534050', '1420269321', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11821', 'uid', '用户id', 'int(10) UNSIGNED NOT NULL', 'num', '', '', '1', '', '1203', '0', '1', '1420269348', '1420269348', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11822', 'remark', '备注', 'text NOT NULL', 'textarea', '', '', '1', '', '1203', '0', '1', '1423534071', '1420269399', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11823', 'order_number', '订单编号', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1203', '0', '1', '1423534179', '1420269451', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11824', 'cTime', '订单时间', 'int(10) NOT NULL', 'datetime', '', '', '1', '', '1203', '0', '1', '1423534102', '1420269666', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11825', 'total_price', '总价', 'decimal(10,2) NULL', 'num', '', '', '1', '', '1203', '0', '1', '1439812371', '1420272711', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11826', 'openid', 'OpenID', 'varchar(255) NOT NULL', 'string', '', '', '0', '', '1203', '0', '1', '1420526437', '1420526437', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11827', 'pay_status', '支付状态', 'int(10)  NULL', 'num', '', '', '0', '', '1203', '0', '1', '1423537847', '1420596969', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11828', 'pay_type', '支付类型', 'int(10) NULL', 'num', '', '', '0', '', '1203', '0', '1', '1423537868', '1420596998', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11829', 'address_id', '配送信息', 'int(10) NULL', 'num', '', '', '1', '', '1203', '0', '1', '1423534264', '1423534264', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11830', 'is_send', '是否发货', 'int(10) NULL', 'num', '0', '', '1', '', '1203', '0', '1', '1438336095', '1438336095', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11831', 'send_code', '快递公司编号', 'varchar(255) NULL', 'string', '', '', '1', '', '1203', '0', '1', '1438336511', '1438336511', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11832', 'send_number', '快递单号', 'varchar(255) NULL', 'string', '', '', '1', '', '1203', '0', '1', '1438336556', '1438336556', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11833', 'send_type', '发货类型', 'char(10) NULL', 'radio', '', '', '1', '0|线上发货\r\n1|物流公司发货', '1203', '0', '1', '1438336756', '1438336756', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11834', 'is_new', '是否为新订单', 'tinyint(2) NULL', 'bool', '1', '', '0', '0:否\r\n1:是', '1203', '0', '1', '1439435979', '1439435969', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11835', 'shop_id', '商店编号', 'int(10) NULL', 'num', '0', '', '1', '', '1203', '0', '1', '1439455026', '1439455026', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11836', 'status_code', '订单跟踪状态码', 'char(50) NULL', 'select', '0', '', '0', '0:待支付\r\n1:待商家确认\r\n2:待发货\r\n3:配送中\r\n4:确认已收货\r\n5:确认已收款\r\n6:待评价\r\n7:已评价', '1203', '0', '1', '1439536746', '1439526095', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11837', 'uid', '用户ID', 'int(10) NULL', 'num', '', '', '0', '', '1204', '0', '1', '1422931055', '1422930936', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11838', 'goods_id', '商品ID', 'int(10) NULL', 'num', '', '', '0', '', '1204', '0', '1', '1422930970', '1422930970', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11839', 'score', '得分', 'int(10) NULL', 'num', '0', '', '0', '', '1204', '0', '1', '1422931004', '1422931004', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11840', 'cTime', '创建时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1204', '0', '1', '1422931044', '1422931044', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11841', 'title', '分类标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1205', '1', '1', '1397529407', '1397529407', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11842', 'icon', '分类图标', 'int(10) unsigned NULL ', 'picture', '', '建议上传100X100的正方形图片', '1', '', '1205', '0', '1', '1431072029', '1397529461', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11843', 'pid', '上一级分类', 'int(10) unsigned NULL ', 'select', '0', '如果你要增加一级分类，这里选择“无”即可', '0', '0:无', '1205', '0', '1', '1422934148', '1397529555', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11844', 'path', '分类路径', 'varchar(255) NULL', 'string', '', '', '0', '', '1205', '0', '1', '1397529604', '1397529604', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11845', 'sort', '排序号', 'int(10) unsigned NULL ', 'num', '0', '数值越小越靠前', '1', '', '1205', '0', '1', '1397529705', '1397529705', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11846', 'is_show', '是否显示', 'tinyint(2) NULL', 'bool', '1', '', '1', '0:不显示\r\n1:显示', '1205', '0', '1', '1397532496', '1397529809', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11847', 'shop_id', '商店ID', 'int(10) NOT NULL', 'num', '0', '', '4', '', '1205', '0', '1', '1422934193', '1422672025', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11848', 'is_recommend', '是否推荐', 'tinyint(2) NULL', 'bool', '0', '', '1', '0:否\r\n1:是', '1205', '0', '1', '1423106432', '1423106432', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11849', 'send_name', '发送人', 'varchar(255) NULL', 'string', '', '', '1', '', '1206', '1', '1', '1429346507', '1429346507', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11850', 'receive_name', '接收人', 'varchar(255) NULL', 'string', '', '', '1', '', '1206', '1', '1', '1429346556', '1429346556', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11851', 'content', '祝福语', 'text NULL', 'textarea', '', '', '1', '', '1206', '1', '1', '1429346679', '1429346679', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11852', 'create_time', ' 创建时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1206', '0', '1', '1429604045', '1429346729', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11853', 'template', '模板', 'char(50) NULL', 'string', '', '模板的文件夹名称，不能为中文', '1', '', '1206', '1', '1', '1429348371', '1429346979', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11854', 'template_cate', '模板分类', 'varchar(255) NULL', 'string', '', '', '4', '', '1206', '1', '1', '1429348355', '1429347540', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11855', 'read_count', '浏览次数', 'int(10) NULL', 'num', '0', '', '0', '', '1206', '0', '1', '1429348951', '1429348951', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11856', 'mid', '用户Id', 'varchar(255) NULL', 'num', '', '', '0', '', '1206', '0', '1', '1429673299', '1429512603', '', '3', '', 'regex', 'get_mid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11857', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1206', '0', '1', '1429764969', '1429764969', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11858', 'content_cate_id', '祝福语类别Id', 'int(10) NULL', 'num', '0', '', '4', '', '1207', '1', '1', '1429349347', '1429349074', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11859', 'content', '祝福语', 'text NULL', 'textarea', '', '', '1', '', '1207', '1', '1', '1429349162', '1429349162', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11860', 'content_cate', '类别', 'varchar(255) NULL', 'select', '', '', '1', '', '1207', '0', '1', '1429522282', '1429350568', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11861', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1207', '0', '1', '1429523422', '1429512730', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11862', 'content_cate_name', '祝福语类别', 'varchar(255) NULL', 'string', '', '', '1', '', '1208', '1', '1', '1429349396', '1429349396', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11863', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1208', '0', '1', '1429520955', '1429512697', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11864', 'content_cate_icon', '类别图标', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '1208', '0', '1', '1429597855', '1429597855', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11865', 'addon', '来源插件', 'varchar(255) NULL', 'string', 'Scratch', '', '0', '', '1209', '0', '1', '1399348676', '1399348676', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11866', 'target_id', '来源ID', 'int(10) unsigned NULL ', '', '', '', '1', '', '1209', '0', '1', '1420980352', '1399348699', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11738', 'plat_type', '平台标识', 'int(10) NULL', 'num', '', '', '1', '', '1192', '0', '1', '1446110716', '1446110716', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11737', 'status', '使用状态', 'int(10) NULL', 'num', '', '', '1', '', '1192', '0', '1', '1446110690', '1446110690', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11715', 'title', '题目标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1190', '1', '1', '1397037377', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11716', 'intro', '题目描述', 'text NOT NULL', 'textarea', '', '', '1', '', '1190', '0', '1', '1396954176', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11717', 'cTime', '发布时间', 'int(10) UNSIGNED NOT NULL', 'datetime', '', '', '0', '', '1190', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11718', 'token', 'Token', 'varchar(255) NOT NULL', 'string', '', '', '0', '', '1190', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11719', 'is_must', '是否必填', 'tinyint(2) NOT NULL', 'bool', '1', '', '0', '0:否\r\n1:是', '1190', '0', '1', '1397035513', '1396954649', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11720', 'extra', '参数', 'text NOT NULL', 'textarea', '', '输入格式见上面的提示', '1', '', '1190', '0', '1', '1397142592', '1396954558', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11721', 'type', '题目类型', 'char(50) NOT NULL', 'radio', 'radio', '', '0', 'radio:单选题', '1190', '1', '1', '1397142548', '1396954463', '', '3', '', 'regex', 'radio', '1', 'string');
INSERT INTO `wp_attribute` VALUES ('11722', 'test_id', 'test_id', 'int(10) UNSIGNED NOT NULL', 'num', '', '', '4', '', '1190', '1', '1', '1396954240', '1396954240', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11723', 'sort', '排序号', 'int(10) UNSIGNED NOT NULL', 'num', '0', '值越小越靠前', '1', '', '1190', '0', '1', '1396955010', '1396955010', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11724', 'answer', '回答内容', 'text NOT NULL', 'textarea', '', '', '0', '', '1191', '0', '1', '1396955766', '1396955766', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11725', 'openid', 'OpenId', 'varchar(255) NOT NULL', 'string', '', '', '0', '', '1191', '0', '1', '1396955581', '1396955581', '', '3', '', 'regex', 'get_openid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11726', 'uid', '用户UID', 'int(10) NOT NULL', 'num', '', '', '0', '', '1191', '0', '1', '1396955530', '1396955530', '', '3', '', 'regex', 'get_mid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11727', 'question_id', 'question_id', 'int(10) UNSIGNED NOT NULL', 'num', '', '', '4', '', '1191', '1', '1', '1396955412', '1396955392', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11728', 'cTime', '发布时间', 'int(10) UNSIGNED NOT NULL', 'datetime', '', '', '0', '', '1191', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11729', 'token', 'Token', 'varchar(255) NOT NULL', 'string', '', '', '0', '', '1191', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11730', 'test_id', 'test_id', 'int(10) UNSIGNED NOT NULL', 'num', '', '', '4', '', '1191', '1', '1', '1396955403', '1396955369', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11731', 'score', '得分', 'int(10) UNSIGNED NOT NULL', 'num', '0', '', '0', '', '1191', '0', '1', '1397040133', '1397040133', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11732', 'from_type', '用途', 'varchar(255) NULL', 'string', '', '', '1', '', '1192', '0', '1', '1446107717', '1446107717', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11733', 'code', '验证码', 'varchar(255) NULL', 'string', '', '', '1', '', '1192', '0', '1', '1446110095', '1446110095', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11734', 'smsId', '短信唯一标识', 'varchar(255) NULL', 'string', '', '', '1', '', '1192', '0', '1', '1446110244', '1446110244', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11735', 'phone', '手机号', 'varchar(255) NULL', 'string', '', '', '1', '', '1192', '0', '1', '1446110276', '1446110276', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11736', 'cTime', '创建时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1192', '0', '1', '1446110405', '1446110405', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11287', 'keyword_type', '关键词类型', 'tinyint(2) NULL', 'select', '0', '', '1', '0:完全匹配\r\n1:左边匹配\r\n2:右边匹配\r\n3:模糊匹配\r\n4:正则匹配\r\n5:随机匹配', '1145', '0', '1', '1396623302', '1396578249', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11286', 'keyword', '关键词', 'varchar(255) NULL', 'string', '', '多个关键词请用空格分开：例如: 高 富 帅', '1', '', '1145', '0', '1', '1396578460', '1396578212', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11285', 'author', '作者', 'varchar(50) NULL', 'string', '', '为空时取当前用户名', '1', '', '1144', '0', '1', '1437988055', '1437988055', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11284', 'jump_url', '外链', 'varchar(255) NULL', 'string', '', '如需跳转填写网址(记住必须有http://)如果填写了图文详细内容，这里请留空，不要设置！', '1', '', '1144', '0', '1', '1402482073', '1402482073', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11283', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1144', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11282', 'view_count', '浏览数', 'int(10) unsigned NULL ', 'num', '0', '', '0', '', '1144', '0', '1', '1396510630', '1396510630', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11281', 'sort', '排序号', 'int(10) unsigned NULL ', 'num', '0', '数值越小越靠前', '1', '', '1144', '0', '1', '1396510508', '1396510508', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11280', 'cTime', '发布时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1144', '0', '1', '1396075102', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11279', 'content', '内容', 'text NULL', 'editor', '', '', '1', '', '1144', '0', '1', '1396062146', '1396062146', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11278', 'cover', '封面图片', 'int(10) unsigned NULL ', 'picture', '', '', '1', '', '1144', '0', '1', '1396062093', '1396062093', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11277', 'cate_id', '所属类别', 'int(10) unsigned NULL ', 'select', '0', '要先在微官网分类里配置好分类才可选择', '1', '0:请选择分类', '1144', '0', '1', '1396078914', '1396062003', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11268', 'jump_type', '推送类型', 'char(10) NULL', 'radio', '0', '', '1', '1:URL|keyword@hide,url@show\r\n0:关键词|keyword@show,url@hide', '1142', '0', '1', '1447208981', '1447208981', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11267', 'sucai_type', '素材类型', 'char(50) NULL', 'select', '0', '', '1', '0:请选择\r\n1:图文\r\n2:文本\r\n3:图片\r\n4:语音\r\n5:视频', '1142', '0', '1', '1447208890', '1447208890', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11266', 'target_id', '选择内容', 'int(10) NULL', 'num', '', '', '4', '0:请选择', '1142', '0', '1', '1447208825', '1447208825', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11265', 'addon', '选择插件', 'char(50) NULL', 'select', '0', '', '1', '0:请选择', '1142', '0', '1', '1447208750', '1447208750', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11264', 'from_type', '配置动作', 'char(50) NULL', 'select', '-1', '', '1', '0:站内信息|keyword@hide,url@hide,type@hide,sucai_type@hide,addon@show,jump_type@show\r\n1:站内素材|keyword@hide,url@hide,type@hide,sucai_type@show,addon@hide,jump_type@hide\r\n9:自定义|keyword@show,url@hide,type@show,addon@hide,sucai_type@hide,jump_type@hide\r\n-1:请选择|keyword@hide,url@hide,type@hide,addon@hide,sucai_type@hide,jump_type@hide', '1142', '0', '1', '1447318552', '1447208677', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11275', 'title', '标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1144', '1', '1', '1396061877', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11276', 'intro', '简介', 'text NULL', 'textarea', '', '', '1', '', '1144', '0', '1', '1396061947', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11959', 'prize_image', '奖品图片', 'varchar(255) NULL', 'picture', '上传奖品图片', '', '1', '', '1220', '1', '1', '1429756675', '1429516329', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11958', 'prize_count', '奖品个数', 'int(10) NULL', 'num', '', '', '1', '', '1220', '1', '1', '1429779465', '1429516109', '/^[0-9]*$/', '3', '奖品个数不能小于0', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11957', 'prize_conditions', '活动说明', 'text NULL', 'textarea', '', '奖品说明', '1', '', '1220', '1', '1', '1429756762', '1429516052', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11955', 'prizeid', '奖品编号', 'int(10) NULL', 'num', '', '', '4', '', '1219', '0', '1', '1447832021', '1429607543', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11956', 'prize_name', '奖品名称', 'varchar(255) NULL', 'string', '', '', '1', '', '1220', '1', '1', '1429515512', '1429515512', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11953', 'uid', '用户id', 'int(10) NULL', 'num', '', '', '0', '', '1219', '0', '1', '1429673948', '1429522086', '', '3', '', 'regex', 'get_mid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11954', 'remark', '备注', 'varchar(255) NULL', 'string', '', '', '1', '', '1219', '0', '1', '1429598446', '1429598446', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11951', 'mobile', '手机', 'varchar(50) NULL', 'string', '', '', '1', '', '1219', '1', '1', '1429521877', '1429521877', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11952', 'turename', '收货人姓名', 'varchar(255) NULL', 'string', '', '', '1', '', '1219', '1', '1', '1429672245', '1429521930', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11950', 'address', '奖品收货地址', 'varchar(255) NULL', 'textarea', '', '', '1', '', '1219', '1', '1', '1429857152', '1429521685', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11885', 'max_num', '每人最多允许抽奖次数', 'int(10) unsigned NULL ', 'num', '1', '0表示不限制数量', '1', '', '1210', '0', '1', '1399260079', '1399260079', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11884', 'predict_num', '预计参与人数', 'int(10) unsigned NOT NULL ', 'num', '', '预计人数直接影响抽奖概率：中奖概率 = 奖品总数/(预估活动人数*每人抽奖次数) 要确保100%中奖可设置为1', '1', '', '1210', '1', '1', '1399710446', '1399259992', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11883', 'end_img', '过期提示图片', 'int(10) unsigned NULL ', 'picture', '', '可为空', '1', '', '1210', '0', '1', '1399712676', '1399711987', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11882', 'end_tips', '过期说明', 'text NULL', 'textarea', '', '活动过期或者结束说明', '1', '', '1210', '0', '1', '1399259570', '1399259570', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11881', 'start_time', '开始时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1210', '0', '1', '1399259416', '1399259416', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11880', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1210', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11879', 'cTime', '发布时间', 'int(10) unsigned NULL ', 'datetime', '', '', '0', '', '1210', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11523', 'keyword', '关键词', 'varchar(100) NULL', 'string', '', '', '0', '', '1172', '0', '1', '1422330526', '1396061575', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11522', 'background', '素材背景图', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '1172', '0', '1', '1422000992', '1422000992', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11521', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1171', '0', '1', '1396690911', '1396690911', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11260', 'keyword', '关联关键词', 'varchar(100) NULL', 'string', '', '', '1', '', '1142', '0', '1', '1416812109', '1394519054', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11261', 'url', '关联URL', 'varchar(255) NULL ', 'string', '', '', '1', '', '1142', '0', '1', '1394519090', '1394519090', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11262', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1142', '0', '1', '1394526820', '1394526820', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11263', 'type', '类型', 'varchar(30) NULL', 'bool', 'click', '', '1', 'click:点击推事件|keyword@show,url@hide\r\nview:跳转URL|keyword@hide,url@show\r\nscancode_push:扫码推事件|keyword@show,url@hide\r\nscancode_waitmsg:扫码带提示|keyword@show,url@hide\r\npic_sysphoto:弹出系统拍照发图|keyword@show,url@hide\r\npic_photo_or_album:弹出拍照或者相册发图|keyword@show,url@hide\r\npic_weixin:弹出微信相册发图器|keyword@show,url@hide\r\nlocation_select:弹出地理位置选择器|keyword@show,url@hide\r\nnone:无事件的一级菜单|keyword@hide,url@hide', '1142', '0', '1', '1416812039', '1416810588', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11519', 'openid', 'OpenId', 'varchar(255) NULL', 'string', '', '', '0', '', '1171', '0', '1', '1396688187', '1396688187', '', '3', '', 'regex', 'get_openid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11520', 'uid', '用户ID', 'int(10) NULL', 'num', '', '', '0', '', '1171', '0', '1', '1396688042', '1396688042', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11274', 'keyword_type', '关键词类型', 'tinyint(2) NULL', 'select', '', '', '1', '0:完全匹配\r\n1:左边匹配\r\n2:右边匹配\r\n3:模糊匹配\r\n4:正则匹配\r\n5:随机匹配', '1144', '0', '1', '1396061814', '1396061765', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11257', 'sort', '排序号', 'tinyint(4) NULL ', 'num', '0', '数值越小越靠前', '1', '', '1142', '0', '1', '1394523288', '1394519175', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11258', 'pid', '一级菜单', 'int(10) NULL', 'select', '0', '如果是一级菜单，选择“无”即可', '1', '0:无', '1142', '0', '1', '1416810279', '1394518930', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11259', 'title', '菜单名', 'varchar(50) NOT NULL', 'string', '', '可创建最多 3 个一级菜单，每个一级菜单下可创建最多 5 个二级菜单。编辑中的菜单不会马上被用户看到，请放心调试。', '1', '', '1142', '1', '1', '1408951570', '1394518988', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11539', 'addon_condition', '插件场景限制', 'varchar(255) NULL', 'string', '', '格式：[插件名:id值]，如[投票:10]表示对ID为10的投票投完才能领取，更多的说明见表单上的提示', '0', '', '1172', '0', '1', '1418885827', '1399261026', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11538', 'credit_bug', '积分消费', 'int(10) unsigned NULL ', 'num', '0', '用积分中的财富兑换、兑换后扣除相应的积分财富', '0', '', '1172', '0', '1', '1418885794', '1399260764', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11537', 'credit_conditon', '积分限制', 'int(10) unsigned NULL ', 'num', '0', '粉丝达到多少积分后才能领取，领取后不扣积分', '0', '', '1172', '0', '1', '1418885804', '1399260618', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11551', 'shop_name', '商家名称', 'varchar(255) NULL', 'string', '优惠商家', '', '1', '', '1172', '0', '1', '1427280255', '1427280255', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11550', 'use_start_time', '使用开始时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1172', '1', '1', '1427280116', '1427280008', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11593', 'is_audit', '是否审核', 'tinyint(2) NULL', 'bool', '0', '', '1', '0:未审核\r\n1:已审核', '1178', '0', '1', '1435031747', '1435029949', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11549', 'over_time', '使用的截止时间', 'int(10) NULL', 'datetime', '', '券的使用截止时间，为空时表示不限制', '1', '', '1172', '0', '1', '1427161334', '1427161118', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11547', 'start_tips', '活动还没开始时的提示语', 'varchar(255) NULL', 'string', '', '', '1', '', '1172', '0', '1', '1423134546', '1423134546', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11548', 'more_button', '其它按钮', 'text NULL', 'textarea', '', '格式：按钮名称|按钮跳转地址，每行一个。如：查看官网|http://weiphp.cn', '1', '', '1172', '0', '1', '1423193853', '1423193853', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11601', 'code', '卡券code码', 'text NULL', 'textarea', '', '指定的卡券code 码，只能被领一次。use_custom_code 字段为true 的卡券必须填写，非自定义code 不必填写', '1', '', '1179', '0', '1', '1421980773', '1421980773', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11600', 'appsecre', '开通卡券的商家公众号密钥', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1179', '1', '1', '1421980516', '1421980516', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11595', 'uid', 'uid', 'int(10) NULL', 'num', '', '', '1', '', '1179', '0', '1', '1430998977', '1430998977', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11596', 'cover', '素材封面', 'int(10) UNSIGNED NULL', 'picture', '', '', '0', '', '1179', '0', '1', '1427435373', '1422000629', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11597', 'balance', '红包余额', 'varchar(30) NULL', 'string', '', '红包余额，以分为单位。红包类型必填 （LUCKY_MONEY），其他卡券类型不填', '0', '', '1179', '0', '1', '1427435295', '1421982394', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11598', 'card_id', '卡券ID', 'varchar(100) NOT NULL', 'string', '', '', '0', '', '1179', '1', '1', '1427435272', '1421980436', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11599', 'openid', 'OpenID', 'text NULL', 'textarea', '', '指定领取者的openid，只有该用户能领取。bind_openid字段为true的卡券必须填写，非自定义openid 不必填写', '0', '', '1179', '0', '1', '1427435344', '1421980851', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1542', 'score', '修改积分', 'int(10) NULL', 'num', '', '', '1', '', '176', '1', '1', '1444302622', '1444302410', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1543', 'branch_id', '修改门店', 'int(10) NULL', 'num', '', '', '1', '', '176', '0', '1', '1444302450', '1444302450', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1544', 'operator', '操作员', 'varchar(255) NULL', 'string', '', '', '1', '', '176', '0', '1', '1444302474', '1444302474', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1545', 'cTime', '修改时间', 'int(10) NULL', 'datetime', '', '', '0', '', '176', '0', '1', '1444302508', '1444302508', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1546', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '1', '', '176', '0', '1', '1444302539', '1444302539', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1547', 'member_id', '会员卡id', 'int(10) NULL', 'num', '', '', '4', '', '176', '0', '1', '1444302566', '1444302566', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1548', 'manager_id', '管理员id', 'int(10) NULL', 'num', '', '', '1', '', '176', '0', '1', '1444302595', '1444302595', '', '3', '', 'regex', 'get_mid', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11610', 'more_button', '添加更多按钮', 'text NULL', 'textarea', '', '', '1', '', '1179', '0', '1', '1427512791', '1427512791', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11609', 'shop_logo', '商家LOGO', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '1179', '0', '1', '1427437781', '1427437781', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11608', 'shop_name', '商家名称', 'varchar(255) NULL', 'string', '', '', '1', '', '1179', '0', '1', '1427438002', '1427438002', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11607', 'head_bg_color', '头部背景颜色', 'varchar(255) NULL', 'string', '#35a2dd', '', '1', '', '1179', '0', '1', '1427435535', '1427435535', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11606', 'button_color', '领取按钮颜色', 'varchar(255) NULL', 'string', '#0dbd02', '', '1', '', '1179', '0', '1', '1427435492', '1427435492', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11602', 'content', '活动介绍', 'text NULL', 'editor', '', '', '1', '', '1179', '0', '1', '1421981078', '1421981078', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11603', 'background', '背景图', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '1179', '0', '1', '1422000931', '1422000931', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11604', 'token', 'token', 'varchar(50) NULL', 'string', '', '', '1', '', '1179', '0', '1', '1430999013', '1430999013', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11605', 'title', '卡券标题', 'varchar(255) NULL', 'string', '卡券', '', '1', '', '1179', '0', '1', '1427435445', '1427435445', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11592', 'content', '评论内容', 'text NULL', 'textarea', '', '', '0', '', '1178', '1', '1', '1432602376', '1432602376', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11530', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1172', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11531', 'start_time', '开始时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1172', '0', '1', '1422330558', '1399259416', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11532', 'end_tips', '领取结束说明', 'text NULL', 'textarea', '', '活动过期或者结束说明', '1', '', '1172', '0', '1', '1427161168', '1399259570', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11533', 'end_img', '领取结束提示图片', 'int(10) unsigned NULL ', 'picture', '', '可为空', '1', '', '1172', '0', '1', '1427161296', '1400989793', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11534', 'num', '优惠券数量', 'int(10) unsigned NULL ', 'num', '0', '0表示不限制数量', '1', '', '1172', '0', '1', '1399259838', '1399259808', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11535', 'max_num', '每人最多允许获取次数', 'int(10) unsigned NULL ', 'num', '1', '0表示不限制数量', '0', '', '1172', '0', '1', '1447758805', '1399260079', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11536', 'follower_condtion', '粉丝状态', 'char(50) NULL', 'select', '1', '粉丝达到设置的状态才能获取', '0', '0:不限制\r\n1:已关注\r\n2:已绑定信息\r\n3:会员卡成员', '1172', '0', '1', '1418885814', '1399260479', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11625', 'card_id', '卡券ID', 'varchar(255) NULL', 'string', '', '可为空', '1', '', '1180', '0', '1', '1421406387', '1421406387', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11624', 'finish_button', '成功抢答完后显示的按钮', 'text NULL', 'textarea', '', '格式：按钮名|跳转链接，如：百度|www.baidu.com 多个时换行分割', '1', '', '1180', '0', '1', '1420857847', '1420857847', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11611', 'template', '素材模板', 'varchar(255) NULL', 'string', 'default', '', '1', '', '1179', '0', '1', '1430129779', '1430129779', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11612', 'keyword', '关键词', 'varchar(100) NOT NULL', 'string', '', '', '1', '', '1180', '1', '1', '1396624337', '1396061575', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11613', 'keyword_type', '关键词类型', 'tinyint(2) NOT NULL', 'select', '0', '', '1', '0:完全匹配\r\n1:左边匹配\r\n2:右边匹配\r\n3:模糊匹配\r\n4:正则匹配\r\n5:随机匹配', '1180', '1', '1', '1396624426', '1396061765', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11614', 'title', '标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1180', '1', '1', '1396624461', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11615', 'intro', '封面简介', 'text NULL', 'textarea', '', '', '1', '', '1180', '1', '1', '1439367292', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11616', 'mTime', '修改时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1180', '0', '1', '1396624664', '1396624664', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11617', 'cover', '封面图片', 'int(10) unsigned NULL ', 'picture', '', '', '1', '', '1180', '0', '1', '1396624534', '1396062093', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11618', 'cTime', '发布时间', 'int(10) unsigned NULL ', 'datetime', '', '', '0', '', '1180', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11619', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1180', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11620', 'finish_tip', '结束语', 'text NULL', 'textarea', '', '为空默认为：抢答完成，谢谢参与', '1', '', '1180', '1', '1', '1439367319', '1396953940', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11621', 'content', '活动介绍', 'text NULL', 'editor', '', '显示在用户进入的开始界面', '1', '', '1180', '0', '1', '1420791982', '1420791908', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11622', 'shop_address', '商家地址', 'text NULL', 'textarea', '', '显示在马上开始的下面，多个地址用英文逗号或者换行分割', '1', '', '1180', '0', '1', '1420798853', '1420794534', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11623', 'appids', '提示关注的公众号', 'text NULL', 'textarea', '', '格式：广东南方卫视|wx2d7ce60bbfc928ef 多个公众号用换行分割', '1', '', '1180', '0', '1', '1420798902', '1420796356', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11558', 'name', '店名', 'varchar(100) NULL', 'string', '', '', '1', '', '1173', '1', '1', '1427164635', '1427164635', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11541', 'view_count', '浏览人数', 'int(10) unsigned NULL ', 'num', '0', '', '0', '', '1172', '0', '1', '1399270926', '1399270926', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11542', 'addon', '插件', 'char(50) NULL', 'select', 'public', '', '0', 'public:通用\r\ninvite:微邀约', '1172', '0', '1', '1418885638', '1418885638', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11543', 'shop_uid', '商家管理员ID', 'varchar(255) NULL', 'string', '', '', '0', '', '1172', '0', '1', '1421750246', '1418900122', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11544', 'use_count', '已使用数', 'int(10) NULL', 'num', '0', '', '0', '', '1172', '0', '1', '1418910237', '1418910237', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11545', 'pay_password', '核销密码', 'varchar(255) NULL', 'string', '', '', '1', '', '1172', '0', '1', '1420875229', '1420875229', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11546', 'empty_prize_tips', '奖品抽完后的提示', 'varchar(255) NULL', 'string', '', '不填写时默认显示：您来晚了，优惠券已经领取完', '1', '', '1172', '0', '1', '1421394437', '1421394267', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11559', 'address', '详细地址', 'varchar(255) NULL', 'string', '', '', '1', '', '1173', '1', '1', '1427164668', '1427164668', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11560', 'phone', '联系电话', 'varchar(30) NULL', 'string', '', '', '1', '', '1173', '0', '1', '1427166529', '1427164707', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11561', 'gps', 'GPS经纬度', 'varchar(50) NULL', 'string', '', '格式：经度,纬度', '1', '', '1173', '0', '1', '1427371523', '1427164833', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11562', 'coupon_id', '所属优惠券编号', 'int(10) NULL', 'num', '', '', '4', '', '1173', '0', '1', '1427165806', '1427165806', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11563', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '0', '', '1173', '0', '1', '1440071867', '1440071805', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11564', 'manager_id', '管理员id', 'int(10) NULL', 'num', '', '', '0', '', '1173', '0', '1', '1440071927', '1440071917', '', '3', '', 'regex', 'get_mid', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11565', 'open_time', '营业时间', 'varchar(50) NULL', 'string', '', '', '1', '', '1173', '0', '1', '1443106576', '1443106576', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11566', 'img', '门店展示图', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '1173', '0', '1', '1447060275', '1447060275', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11567', 'coupon_id', 'coupon_id', 'int(10) NULL', 'num', '', '', '1', '', '1174', '0', '1', '1427356371', '1427356371', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11568', 'shop_id', 'shop_id', 'int(10) NULL', 'num', '', '', '1', '', '1174', '0', '1', '1427356387', '1427356387', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11569', 'title', '竞猜标题', 'varchar(255) NULL', 'string', '', '', '1', '', '1175', '1', '1', '1428655010', '1428655010', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11570', 'desc', '活动说明', 'text NULL', 'textarea', '', '', '1', '', '1175', '0', '1', '1428657017', '1428657017', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11571', 'start_time', '开始时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1175', '1', '1', '1428657086', '1428657086', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11572', 'end_time', '结束时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1175', '1', '1', '1428657122', '1428657122', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11573', 'create_time', '创建时间', 'int(10) NULL', 'datetime', '', '', '4', '', '1175', '0', '1', '1428664508', '1428664122', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11574', 'guess_count', '', 'int(10) unsigned NULL ', 'num', '0', '', '4', '', '1175', '0', '1', '1428718033', '1428717991', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11575', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1175', '0', '1', '1429521291', '1429512366', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11576', 'template', '素材模板', 'varchar(255) NULL', 'string', 'default', '', '1', '', '1175', '0', '1', '1430115411', '1430103969', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11577', 'cover', '主题图片', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '1175', '0', '1', '1430384839', '1430384839', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11578', 'user_id', '用户ID', 'int(10) unsigned NULL', 'num', '0', '', '0', '', '1176', '0', '1', '1428738317', '1428738317', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11579', 'guess_id', '竞猜Id', 'int(10) unsigned NULL', 'num', '0', '', '0', '', '1176', '0', '1', '1428738379', '1428738379', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11580', 'token', '用户token', 'varchar(255) NULL', 'string', '', '', '1', '', '1176', '0', '1', '1428738405', '1428738405', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11581', 'optionIds', '用户猜的选项IDs', 'varchar(255) NULL', 'string', '', '', '0', '', '1176', '0', '1', '1428738522', '1428738522', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11582', 'cTime', '创时间', 'int(10) NULL', 'date', '', '', '0', '', '1176', '0', '1', '1428738552', '1428738552', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11583', 'guess_id', '竞猜活动的Id', 'int(10) NULL', 'num', '0', '', '4', '', '1177', '0', '1', '1428659228', '1428659228', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11584', 'name', '选项名称', 'varchar(255) NULL', 'string', '', '', '1', '', '1177', '1', '1', '1428659270', '1428659270', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11585', 'image', '选项图片', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '1177', '0', '1', '1428659313', '1428659313', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11586', 'order', '选项顺序', 'int(10) NULL', 'num', '0', '', '1', '', '1177', '0', '1', '1428659354', '1428659354', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11587', 'guess_count', '竞猜人数', 'int(10) unsigned NULL ', 'num', '0', '', '0', '', '1177', '0', '1', '1430302786', '1428659432', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11588', 'aim_table', '评论关联数据表', 'varchar(30) NULL', 'string', '', '', '0', '', '1178', '0', '1', '1432602501', '1432602501', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11589', 'aim_id', '评论关联ID', 'int(10) NULL', 'num', '', '', '0', '', '1178', '0', '1', '1432602466', '1432602466', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11590', 'cTime', '评论时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1178', '0', '1', '1432602404', '1432602404', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11591', 'follow_id', 'follow_id', 'int(10) NULL', 'num', '', '', '0', '', '1178', '1', '1', '1432602345', '1432602345', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11540', 'collect_count', '已领取数', 'int(10) unsigned NULL ', 'num', '0', '', '0', '', '1172', '0', '1', '1400992246', '1399270900', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11524', 'use_tips', '使用说明', 'text NULL', 'editor', '', '用户获取优惠券后显示的提示信息', '1', '', '1172', '1', '1', '1420868972', '1399259489', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11525', 'title', '标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1172', '1', '1', '1396624461', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11526', 'intro', '封面简介', 'text NULL', 'textarea', '', '', '0', '', '1172', '0', '1', '1418885972', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11527', 'end_time', '领取结束时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1172', '0', '1', '1427161023', '1399259433', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11528', 'cover', '优惠券图片', 'int(10) unsigned NULL ', 'picture', '', '', '1', '', '1172', '0', '1', '1418886050', '1396062093', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11529', 'cTime', '发布时间', 'int(10) unsigned NULL ', 'datetime', '', '', '0', '', '1172', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('1663', 'credit_title', '积分标题', 'varchar(50) NULL', 'string', '', '', '0', '', '15', '0', '1', '1444731976', '1444731976', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11714', 'finish_tip', '评论语', 'text NOT NULL', 'textarea', '', '详细说明见上面的提示，配置格式：[0-59]不合格', '1', '', '1189', '0', '1', '1397142371', '1396953940', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11713', 'token', 'Token', 'varchar(255) NOT NULL', 'string', '', '', '0', '', '1189', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11712', 'cover', '封面图片', 'int(10) UNSIGNED NOT NULL', 'picture', '', '', '1', '', '1189', '0', '1', '1396624534', '1396062093', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11626', 'appsecre', '卡券对应的appsecre', 'varchar(255) NULL', 'string', '', '', '1', '', '1180', '0', '1', '1421406470', '1421406470', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11627', 'template', '素材模板', 'varchar(255) NULL', 'string', 'default', '', '1', '', '1180', '0', '1', '1430210161', '1430210161', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11628', 'answer', '回答内容', 'text NULL', 'textarea', '', '', '0', '', '1181', '0', '1', '1396955766', '1396955766', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11629', 'openid', 'OpenId', 'varchar(255) NULL', 'string', '', '', '0', '', '1181', '0', '1', '1430286439', '1396955581', '', '3', '', 'regex', 'get_openid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11630', 'uid', '用户UID', 'int(10) NULL ', 'num', '', '', '0', '', '1181', '0', '1', '1396955530', '1396955530', '', '3', '', 'regex', 'get_mid', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11631', 'question_id', 'question_id', 'int(10) unsigned NOT NULL ', 'num', '', '', '4', '', '1181', '1', '1', '1396955412', '1396955392', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11632', 'cTime', '发布时间', 'int(10) unsigned NULL ', 'datetime', '', '', '0', '', '1181', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11633', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1181', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11634', 'ask_id', 'ask_id', 'int(10) unsigned NOT NULL ', 'num', '', '', '4', '', '1181', '1', '1', '1396955403', '1396955369', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11635', 'is_correct', '是否回答正确', 'tinyint(2) NULL', 'bool', '1', '', '0', '0:不正确\r\n1:正确', '1181', '0', '1', '1420685956', '1420685956', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11636', 'times', '次数', 'int(4) NULL', 'num', '0', '', '0', '', '1181', '0', '1', '1420965038', '1420965038', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11637', 'title', '标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1182', '1', '1', '1396624461', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11638', 'intro', '问题描述', 'text NULL', 'textarea', '', '', '1', '', '1182', '0', '1', '1396954176', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11639', 'cTime', '发布时间', 'int(10) unsigned NULL ', 'datetime', '', '', '0', '', '1182', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11640', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1182', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11641', 'is_must', '是否必填', 'tinyint(2) NULL', 'bool', '1', '', '0', '0:否\r\n1:是', '1182', '0', '1', '1420686586', '1396954649', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11642', 'extra', '参数', 'text NOT NULL', 'textarea', '', '类型为单选、多选时的定义数据，格式见上面的提示', '1', '', '1182', '1', '1', '1421749164', '1396954558', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11643', 'type', '问题类型', 'char(50) NOT NULL', 'radio', 'radio', '', '1', 'radio:单选题\r\ncheckbox:多选题', '1182', '1', '1', '1420689062', '1396954463', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11644', 'ask_id', 'ask_id', 'int(10) unsigned NOT NULL ', 'num', '', '', '4', '', '1182', '1', '1', '1396954240', '1396954240', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11645', 'sort', '排序号', 'int(10) unsigned NULL ', 'num', '0', '值越小越靠前', '1', '', '1182', '0', '1', '1420689390', '1396955010', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11646', 'answer', '正确答案', 'varchar(255) NOT NULL', 'string', '', '多个答案用空格分开，如： A B C', '1', '', '1182', '1', '1', '1421749143', '1420685041', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11647', 'is_last', '是否最后一题', 'tinyint(2) NULL', 'bool', '0', '如设置为最后一题，用户回答后进入完成页面，否则进入等待下一题提示页面', '0', '0:否\r\n1:是', '1182', '0', '1', '1421749096', '1420686448', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11648', 'wait_time', '等待时间', 'int(10) NULL', 'num', '0', '单位为秒，表示答题后进入下一题的间隔时间', '1', '', '1182', '0', '1', '1420688805', '1420688703', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11649', 'percent', '抢中概率', 'int(10) NULL', 'num', '100', '抢到题目的百分比，请填写0~100之间的整数，如填写50表示概率为50%', '1', '', '1182', '0', '1', '1420855970', '1420855970', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11650', 'answer_time', '答题时间', 'int(10) NULL', 'num', '', '不填则为无答题时间限制', '1', '', '1182', '0', '1', '1427541360', '1427541360', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11651', 'permission', '权限设置', 'char(50) NULL', 'select', '1', '', '1', '1:完全公开(公众人物)\r\n2:群友可见(商务交往)\r\n3:交换名片可见(私人来往)\r\n4:仅自己可见(绝密保存)', '1183', '0', '1', '1438945015', '1438945015', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11652', 'intro', '个人介绍', 'text NULL', 'textarea', '', '', '1', '', '1183', '0', '1', '1438944828', '1438944828', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11653', 'wishing', '希望结交', 'varchar(100) NULL', 'string', '', '', '1', '', '1183', '0', '1', '1438942908', '1438942908', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11654', 'wechat', '微信号', 'varchar(50) NULL', 'string', '', '', '1', '', '1183', '0', '1', '1438942392', '1438942392', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11655', 'Email', '邮箱', 'varchar(100) NULL', 'string', '', '', '1', '', '1183', '0', '1', '1438942359', '1438942359', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11656', 'telephone', '座机', 'varchar(30) NULL', 'string', '', '', '1', '', '1183', '0', '1', '1438942330', '1438942330', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11657', 'address', '地址', 'varchar(255) NULL', 'string', '', '', '1', '', '1183', '0', '1', '1438933681', '1438933681', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11658', 'company_url', '公司网址', 'varchar(255) NULL', 'string', '', '', '1', '', '1183', '0', '1', '1438933650', '1438933650', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11659', 'department', '所属部门', 'varchar(50) NULL', 'string', '', '', '1', '', '1183', '0', '1', '1438933471', '1438933471', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11660', 'company', '公司名称', 'varchar(100) NULL', 'string', '', '', '1', '', '1183', '1', '1', '1438933418', '1438933418', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11661', 'mobile', '手机', 'varchar(30) NULL', 'string', '', '', '1', '', '1183', '1', '1', '1438933381', '1438933381', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11662', 'position', '职位头衔', 'varchar(50) NULL', 'string', '', '', '1', '如：XX创始人、xx级教师、xx投资顾问、XX爸爸、XX达人', '1183', '0', '1', '1438933330', '1438933330', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11663', 'headface', '头像', 'int(10) UNSIGNED NULL', 'picture', '', '', '0', '', '1183', '0', '1', '1439175454', '1438944864', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11664', 'personal_url', '个人主页', 'varchar(255) NULL', 'string', '', '', '1', '', '1183', '0', '1', '1438944804', '1438944804', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11665', 'interest', '兴趣', 'varchar(255) NULL', 'string', '', '', '1', '', '1183', '0', '1', '1438942945', '1438942945', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11666', 'tag', '人物标签', 'varchar(255) NULL', 'string', '', '多个用逗号分开', '1', '', '1183', '0', '1', '1438942491', '1438942491', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11667', 'weibo', '微博', 'varchar(255) NULL', 'string', '', '', '1', '', '1183', '0', '1', '1438942443', '1438942443', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11668', 'qq', 'QQ号', 'varchar(30) NULL', 'string', '', '', '1', '', '1183', '0', '1', '1438942418', '1438942418', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11669', 'service', '产品服务', 'text NULL', 'textarea', '', '', '1', '', '1183', '1', '1', '1438933623', '1438933623', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11670', 'truename', '真实姓名', 'varchar(50) NULL', 'string', '', '', '1', '', '1183', '1', '1', '1438931443', '1438931443', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11671', 'uid', '用户ID', 'int(10) NULL', 'num', '', '', '0', '', '1183', '0', '1', '1438931293', '1438931293', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11672', 'template', '选择的模板', 'varchar(50) NULL', 'string', '', '', '0', '', '1183', '0', '1', '1438947089', '1438947089', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11673', 'token', 'Token', 'varchar(100) NULL', 'string', '', '', '0', '', '1183', '0', '1', '1439869080', '1439290478', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11674', 'from_uid', '收藏人ID', 'int(10) NULL', 'num', '', '', '0', '', '1184', '0', '1', '1439188549', '1439188462', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11675', 'to_uid', '被收藏人的ID', 'int(10) NULL', 'num', '', '', '0', '', '1184', '0', '1', '1439188512', '1439188512', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11676', 'cTime', '收藏时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1184', '0', '1', '1439188537', '1439188537', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11677', 'business_card_id', '名片id', 'int(10) NULL', 'num', '', '', '4', '', '1185', '0', '1', '1441779829', '1441522726', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11678', 'type', '栏目类型', 'char(10) NULL', 'select', '0', '', '1', '0:自定义|cate_id@hide,title@show,url@show\r\n1:文章分类|cate_id@show,title@hide,url@hide', '1185', '0', '1', '1441525619', '1441512922', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11679', 'cate_id', '分类', 'varchar(100) NULL', 'dynamic_select', '0', '', '1', 'table=we_media_category&value_field=id', '1185', '0', '1', '1441525628', '1441513085', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11680', 'title', '栏目名称', 'varchar(255) NULL', 'string', '', '', '1', '', '1185', '0', '1', '1441525667', '1441513114', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11681', 'url', '跳转url', 'varchar(255) NULL', 'string', '', '', '1', '', '1185', '0', '1', '1441525683', '1441520141', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11682', 'sort', '排序', 'int(10) NULL', 'num', '0', '', '1', '', '1185', '0', '1', '1441520666', '1441520666', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11683', 'uid', '用户id', 'int(10) NULL', 'num', '', '', '0', '', '1185', '0', '1', '1441781769', '1441528808', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11684', 'keyword', '关键词', 'varchar(100) NOT NULL', 'string', '', '', '1', '', '1186', '1', '1', '1396624337', '1396061575', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11685', 'keyword_type', '关键词类型', 'tinyint(2) NOT NULL', 'select', '0', '', '1', '0:完全匹配\r\n1:左边匹配\r\n2:右边匹配\r\n3:模糊匹配', '1186', '1', '1', '1396624426', '1396061765', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11686', 'title', '标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1186', '1', '1', '1396624461', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11687', 'intro', '封面简介', 'text NULL', 'textarea', '', '', '1', '', '1186', '1', '1', '1447826199', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11688', 'mTime', '修改时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1186', '0', '1', '1396624664', '1396624664', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11689', 'cover', '封面图片', 'int(10) UNSIGNED NOT NULL', 'picture', '', '', '1', '', '1186', '1', '1', '1418266006', '1396062093', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11690', 'experience', '消耗经验值', 'int(10) NULL', 'num', '0', '', '1', '', '1186', '0', '1', '1418180506', '1418180506', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11691', 'cTime', '发布时间', 'int(10) UNSIGNED NULL', 'datetime', '', '', '0', '', '1186', '0', '1', '1396624612', '1396075102', '', '3', '', 'regex', 'time', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11692', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1186', '0', '1', '1396602871', '1396602859', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11693', 'num', '邀请人数', 'int(10) NULL', 'num', '0', '邀请多少人后才能用优惠券', '1', '', '1186', '1', '1', '1447826376', '1418180590', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11694', 'coupon_id', '优惠券编号', 'int(10) NULL', 'num', '', '可以在优惠券列表中找到对应的编号', '1', '', '1186', '1', '1', '1447826355', '1418180739', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11695', 'coupon_num', '优惠券数', 'int(10) NULL', 'num', '0', '赠送多少张优惠券', '0', '', '1186', '0', '1', '1418959022', '1418180812', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11696', 'receive_num', '已领取优惠券数', 'int(10) NULL', 'num', '0', '', '0', '', '1186', '0', '1', '1418181528', '1418181528', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11697', 'content', '邀约介绍', 'text NULL', 'editor', '', '', '1', '', '1186', '1', '1', '1447826165', '1418265599', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11698', 'template', '模板名称', 'varchar(255) NULL', 'string', 'default', '', '1', '', '1186', '0', '1', '1430122784', '1430122766', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11699', 'token', 'Token', 'varchar(255) NULL', 'string', '', '', '0', '', '1187', '0', '1', '1418192408', '1418192408', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11700', 'uid', '用户ID', 'int(10) NULL', 'num', '', '', '0', '', '1187', '0', '1', '1418192629', '1418192629', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11701', 'invite_id', '邀约ID', 'int(10) NULL', 'num', '', '', '1', '', '1187', '0', '1', '1418192878', '1418192878', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11702', 'invite_num', '已邀请人数', 'int(10) NULL', 'num', '', '', '0', '', '1187', '0', '1', '1418192971', '1418192971', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11703', 'token', 'Token', 'varchar(255) NOT NULL', 'string', '', '', '0', '', '1188', '0', '1', '1401371165', '1401371165', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('11704', 'month', '月份', 'int(10) NOT NULL', 'num', '', '', '1', '', '1188', '0', '1', '1401371192', '1401371192', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11705', 'day', '日期', 'int(10) NOT NULL', 'num', '', '', '1', '', '1188', '0', '1', '1401371209', '1401371209', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11706', 'content', '统计数据', 'text NOT NULL', 'textarea', '', '', '1', '', '1188', '0', '1', '1401371292', '1401371292', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11707', 'keyword', '关键词', 'varchar(100) NOT NULL', 'string', '', '', '1', '', '1189', '1', '1', '1396624337', '1396061575', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11708', 'keyword_type', '关键词匹配类型', 'tinyint(2) NOT NULL', 'select', '0', '', '1', '0:完全匹配\r\n1:左边匹配\r\n2:右边匹配\r\n3:模糊匹配', '1189', '1', '1', '1396624426', '1396061765', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11709', 'title', '问卷标题', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1189', '1', '1', '1396624461', '1396061859', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11710', 'intro', '封面简介', 'text NOT NULL', 'textarea', '', '', '1', '', '1189', '0', '1', '1396624505', '1396061947', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11711', 'mTime', '修改时间', 'int(10) NOT NULL', 'datetime', '', '', '0', '', '1189', '0', '1', '1396624664', '1396624664', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11552', 'shop_logo', '商家LOGO', 'int(10) UNSIGNED NULL', 'picture', '', '', '1', '', '1172', '0', '1', '1427280293', '1427280293', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11553', 'head_bg_color', '头部背景颜色', 'varchar(255) NULL', 'string', '#35a2dd', '', '1', '', '1172', '0', '1', '1427282839', '1427282785', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11554', 'button_color', '按钮颜色', 'varchar(255) NULL', 'string', '#0dbd02', '', '1', '', '1172', '0', '1', '1427282886', '1427282886', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11555', 'template', '素材模板', 'varchar(255) NULL', 'string', 'default', '', '1', '', '1172', '0', '1', '1430127336', '1430127336', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11556', 'member', '选择人群', 'varchar(100) NULL', 'checkbox', '0', '', '1', '0:所有用户\r\n-1:所有会员', '1172', '0', '1', '1444821380', '1444821380', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11557', 'is_del', '是否删除', 'int(10) NULL', 'num', '0', '', '0', '', '1172', '0', '1', '1446119564', '1446119564', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11594', 'uid', 'uid', 'int(10) NULL', 'num', '', '', '0', '', '1178', '0', '1', '1435561416', '1435561392', '', '3', '', 'regex', 'get_mid', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1823', 'is_material', '设置为文本素材', 'int(10) NULL', 'num', '0', '', '0', '0:不设置\r\n1:设置', '103', '0', '1', '1445497359', '1445497359', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1824', 'admin_uid', '核销管理员ID', 'int(10) NULL', 'num', '', '', '0', '', '81', '0', '1', '1445504807', '1445504807', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1839', 'msgtype', '消息类型', 'varchar(255) NULL', 'string', '', '', '1', '', '18', '0', '1', '1445833955', '1445833955', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1840', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '1', '', '18', '0', '1', '1445834006', '1445834006', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1841', 'appmsg_id', '图文id', 'int(10) NULL', 'num', '', '', '1', '', '18', '0', '1', '1445840292', '1445834101', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1842', 'voice_id', '语音id', 'int(10) NULL', 'num', '', '', '1', '', '18', '0', '1', '1445834144', '1445834144', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1843', 'video_id', '视频id', 'int(10) NULL', 'num', '', '', '1', '', '18', '0', '1', '1445834174', '1445834174', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('1851', 'cTime', '群发时间', 'int(10) NULL', 'datetime', '', '', '1', '', '18', '0', '1', '1445856491', '1445856442', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11886', 'follower_condtion', '粉丝状态', 'char(50) NULL', 'select', '1', '粉丝达到设置的状态才能获取', '1', '0:不限制\r\n1:已关注\r\n2:已绑定信息\r\n3:会员卡成员', '1210', '0', '1', '1399260479', '1399260479', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11887', 'credit_conditon', '积分限制', 'int(10) unsigned NULL ', 'num', '0', '粉丝达到多少积分后才能领取，领取后不扣积分', '1', '', '1210', '0', '1', '1399260618', '1399260618', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11888', 'credit_bug', '积分消费', 'int(10) unsigned NULL ', 'num', '0', '用积分中的财富兑换、兑换后扣除相应的积分财富', '1', '', '1210', '0', '1', '1399260764', '1399260764', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11889', 'addon_condition', '插件场景限制', 'varchar(255) NULL', 'string', '', '格式：[插件名:id值]，如[投票:10]表示对ID为10的投票投完才能领取，更多的说明见表单上的提示', '1', '', '1210', '0', '1', '1399274022', '1399261026', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11890', 'collect_count', '已领取人数', 'int(10) unsigned NULL ', 'num', '0', '', '1', '', '1210', '0', '1', '1420980201', '1399270900', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11891', 'view_count', '浏览人数', 'int(10) unsigned NULL ', 'num', '0', '', '1', '', '1210', '0', '1', '1420980183', '1399270926', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11892', 'update_time', '更新时间', 'int(10) NULL', 'datetime', '', '', '0', '', '1210', '0', '1', '1399562468', '1399359204', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11893', 'template', '素材模板', 'varchar(255) NULL', 'string', 'default', '', '1', '', '1210', '0', '1', '1430201266', '1430201266', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11894', 'fid', '', 'int(11) NULL ', 'string', '', '', '1', '', '1211', '0', '1', '1404033503', '1404033503', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11895', 'token', '', 'varchar(60) NULL ', 'string', '', '', '1', '', '1211', '0', '1', '1404033503', '1404033503', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11896', 'openid', '', 'varchar(60) NULL ', 'string', '', '', '1', '', '1211', '0', '1', '1404033503', '1404033503', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11897', 'date', '', 'varchar(11) NULL ', 'string', '', '', '1', '', '1211', '0', '1', '1404033504', '1404033504', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11898', 'enddate', '', 'int(11) NULL ', 'string', '', '', '1', '', '1211', '0', '1', '1404033504', '1404033504', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11899', 'model', '', 'varchar(60) NULL ', 'string', '', '', '1', '', '1211', '0', '1', '1404033504', '1404033504', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11900', 'num', '', 'int(11) NULL ', 'string', '', '', '1', '', '1211', '0', '1', '1404033505', '1404033505', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11901', 'keyword', '', 'varchar(60) NULL ', 'string', '', '', '1', '', '1211', '0', '1', '1404033505', '1404033505', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11902', 'type', '', 'tinyint(1) NULL ', 'string', '', '', '1', '', '1211', '0', '1', '1404033505', '1404033505', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11903', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '0', '', '1212', '0', '1', '1404485505', '1404475530', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11904', 'groupname', '分组名称', 'varchar(255) NULL', 'string', '', '', '1', '', '1212', '0', '1', '1404475556', '1404475556', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11905', 'groupdata', '分组数据源', 'text NULL', 'textarea', '', '', '0', '', '1212', '0', '1', '1404476127', '1404476127', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11906', 'msgkeyword', '消息关键字', 'varchar(555) NULL', 'string', '', '当用户发送的消息中含有关键字时,将自动转到分配的客服人员', '1', '', '1213', '0', '1', '1404399336', '1404399336', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11907', 'msgkeyword_type', '关键字类型', 'char(50) NULL', 'select', '3', '选择关键字匹配的类型', '1', '0:完全匹配\r\n1:左边匹配\r\n2:右边匹配\r\n3:模糊匹配\r\n4:正则匹配\r\n5:随机匹配', '1213', '0', '1', '1404399466', '1404399466', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11908', 'msgkfaccount', '接待的客服人员', 'varchar(255) NULL', 'string', '', '', '0', '', '1213', '0', '1', '1404403340', '1404399587', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11909', 'cTime', '创建时间', 'int(10) NULL', 'date', '', '', '0', '', '1213', '0', '1', '1404399629', '1404399629', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11910', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '0', '', '1213', '0', '1', '1404399656', '1404399656', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11911', 'msgstate', '关键字状态', 'tinyint(2) NULL', 'bool', '1', '停用后用户将不会触发此关键词', '1', '0:停用\r\n1:启用', '1213', '0', '1', '1404399749', '1404399749', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11912', 'zjnum', '转接次数', 'int(10) NULL', 'num', '', '', '0', '', '1213', '0', '1', '1404399784', '1404399784', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11913', 'zdtype', '指定类型', 'char(10) NULL', 'radio', '0', '选择关键字匹配时是按指定人员或者指定客服组', '1', '0:指定客服人员\r\n1:指定客服组', '1213', '0', '1', '1404474672', '1404474672', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11914', 'kfgroupid', '客服分组id', 'int(10) NULL', 'num', '0', '', '0', '', '1213', '0', '1', '1404474777', '1404474777', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11915', 'pid', '', 'int(11) NULL ', 'string', '', '', '1', '', '1214', '0', '1', '1403947272', '1403947272', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11916', 'openid', '', 'varchar(60) NULL ', 'string', '', '', '1', '', '1214', '0', '1', '1403947273', '1403947273', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11917', 'enddate', '', 'int(11) NULL ', 'string', '', '', '1', '', '1214', '0', '1', '1403947273', '1403947273', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11918', 'keyword', '', 'varchar(200) NULL ', 'string', '', '', '1', '', '1214', '0', '1', '1403947274', '1403947274', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11919', 'status', '', 'tinyint(1) NULL ', 'string', '2', '', '1', '', '1214', '0', '1', '1403947274', '1403947274', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11920', 'name', '客服昵称', 'varchar(60) NULL ', 'string', '', '', '1', '', '1215', '0', '1', '1403959775', '1403947255', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('11921', 'token', 'token', 'varchar(60) NULL ', 'string', '', '', '0', '', '1215', '0', '1', '1403959638', '1403947256', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11922', 'userName', '客服帐号', 'varchar(60) NULL ', 'string', '', '', '1', '', '1215', '0', '1', '1403959752', '1403947256', '', '3', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('11923', 'userPwd', '客服密码', 'varchar(32) NULL ', 'string', '', '', '1', '', '1215', '0', '1', '1403959722', '1403947257', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('11924', 'endJoinDate', '客服加入时间', 'int(11) NULL ', 'string', '', '', '0', '', '1215', '0', '1', '1403959825', '1403947257', '', '3', '', 'regex', 'time', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11925', 'status', '客服在线状态', 'tinyint(1) NULL ', 'bool', '0', '', '0', '0:离线\r\n1:在线', '1215', '0', '1', '1404016782', '1403947258', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `wp_attribute` VALUES ('11926', 'state', '客服状态', 'tinyint(2) NULL', 'bool', '0', '', '1', '0:停用\r\n1:启用', '1215', '0', '1', '1404016877', '1404016877', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11927', 'isdelete', '是否删除', 'tinyint(2) NULL', 'bool', '0', '', '0', '0:正常\r\n1:已被删除', '1215', '0', '1', '1404016931', '1404016931', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11928', 'kfid', '客服编号', 'varchar(255) NULL', 'string', '', '', '1', '', '1215', '0', '1', '1404398387', '1404398387', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11929', 'openid', '', 'varchar(60) NULL ', 'string', '', '', '1', '', '1216', '0', '1', '1404026716', '1404026716', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11930', 'enddate', '', 'int(11) NULL ', 'string', '', '', '1', '', '1216', '0', '1', '1404026716', '1404026716', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11931', 'joinUpDate', '', 'int(11) NULL ', 'string', '0', '', '1', '', '1216', '0', '1', '1404026716', '1404026716', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11932', 'uid', '', 'int(11) NULL ', 'string', '0', '', '1', '', '1216', '0', '1', '1404026717', '1404026717', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11933', 'token', '', 'varchar(40) NULL ', 'string', '', '', '1', '', '1216', '0', '1', '1404026717', '1404026717', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11934', 'g_id', '', 'varchar(20) NULL ', 'string', '', '', '1', '', '1217', '0', '1', '1404027302', '1404027302', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11935', 'nickname', '', 'varchar(60) NULL ', 'string', '', '', '1', '', '1217', '0', '1', '1404027302', '1404027302', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11936', 'sex', '', 'tinyint(1) NULL ', 'string', '', '', '1', '', '1217', '0', '1', '1404027303', '1404027303', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11937', 'province', '', 'varchar(20) NULL ', 'string', '', '', '1', '', '1217', '0', '1', '1404027303', '1404027303', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11938', 'city', '', 'varchar(30) NULL ', 'string', '', '', '1', '', '1217', '0', '1', '1404027303', '1404027303', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11939', 'headimgurl', '', 'varchar(200) NULL ', 'string', '', '', '1', '', '1217', '0', '1', '1404027304', '1404027304', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11940', 'subscribe_time', '', 'int(11) NULL ', 'string', '', '', '1', '', '1217', '0', '1', '1404027304', '1404027304', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11941', 'token', '', 'varchar(30) NULL ', 'string', '', '', '1', '', '1217', '0', '1', '1404027305', '1404027305', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11942', 'openid', '', 'varchar(60) NULL ', 'string', '', '', '1', '', '1217', '0', '1', '1404027305', '1404027305', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11943', 'status', '', 'tinyint(1) NULL ', 'string', '', '', '1', '', '1217', '0', '1', '1404027305', '1404027305', '', '0', '', '', '', '0', '');
INSERT INTO `wp_attribute` VALUES ('11944', 'opercode', '会话状态', 'int(10) NULL', 'num', '', '', '1', '', '1218', '0', '1', '1406094322', '1406094322', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11945', 'text', '消息', 'text NULL', 'textarea', '', '', '1', '', '1218', '0', '1', '1406094387', '1406094387', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11946', 'time', '时间', 'int(10) NULL', 'datetime', '', '', '1', '', '1218', '0', '1', '1406094341', '1406094341', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11947', 'openid', 'openid', 'varchar(255) NULL', 'string', '', '', '1', '', '1218', '0', '1', '1406094276', '1406094276', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11948', 'token', 'token', 'varchar(255) NULL', 'string', '', '', '0', '', '1218', '0', '1', '1406094177', '1406094177', '', '3', '', 'regex', 'get_token', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11949', 'worker', '客服名称', 'varchar(255) NULL', 'string', '', '', '1', '', '1218', '0', '1', '1406094257', '1406094257', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11242', 'is_use', '可否使用', 'int(10) NULL', 'num', '1', '', '0', '0:不可用\r\n1:可用', '149', '0', '1', '1447405173', '1447403730', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11243', 'aim_id', '添加来源标识id', 'int(10) NULL', 'num', '', '', '0', '', '149', '0', '1', '1447404930', '1447404930', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11244', 'aim_table', '来源表名', 'varchar(255) NULL', 'string', '', '', '1', '', '149', '0', '1', '1447405156', '1447405156', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11245', 'is_use', '可否使用', 'int(10) NULL', 'num', '1', '', '0', '0:不可用\r\n1:可用', '16', '0', '1', '1447405234', '1447405234', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11246', 'aim_id', '添加来源标识id', 'int(10) NULL', 'num', '', '', '0', '', '16', '0', '1', '1447405283', '1447405283', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11247', 'aim_table', '来源表名', 'varchar(255) NULL', 'string', '', '', '1', '', '16', '0', '1', '1447405301', '1447405301', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11248', 'is_use', '可否使用', 'int(10) NULL', 'num', '1', '', '0', '0:不可用\r\n1:可用', '17', '0', '1', '1447405553', '1447405510', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11249', 'aim_id', '添加来源标识id', 'int(10) NULL', 'num', '', '', '0', '', '17', '0', '1', '1447405545', '1447405545', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('11250', 'aim_table', '来源表名', 'varchar(255) NULL', 'string', '', '', '0', '', '17', '0', '1', '1447405577', '1447405577', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12135', 'title', '分类标题', 'varchar(100) NOT NULL', 'string', '', '', '1', '', '1238', '0', '1', '1395988016', '1395988016', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12136', 'icon', '分类图片', 'int(10) UNSIGNED  NULL', 'picture', '', '', '1', '', '1238', '0', '1', '1395988966', '1395988966', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12137', 'url', '外链', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '1238', '0', '1', '1395989660', '1395989660', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12138', 'is_show', '显示', 'tinyint(2) NOT NULL', 'bool', '1', '', '1', '0: 不显示\r\n1: 显示', '1238', '0', '1', '1395989709', '1395989709', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12139', 'token', 'Token', 'varchar(100)  NULL', 'string', '', '', '0', '', '1238', '0', '1', '1395989760', '1395989760', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('12140', 'sort', '排序号', 'int(10)  NULL', 'num', '0', '数值越小越靠前', '1', '', '1238', '0', '1', '1396340334', '1396340334', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12141', 'title', '标题', 'varchar(255) NULL', 'string', '', '可为空', '1', '', '1239', '0', '1', '1396098316', '1396098316', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12142', 'img', '图片', 'int(10) UNSIGNED NOT NULL', 'picture', '', '', '1', '', '1239', '1', '1', '1396098349', '1396098349', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12143', 'url', '链接地址', 'varchar(255) NULL', 'string', '', '', '1', '', '1239', '0', '1', '1396098380', '1396098380', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12144', 'is_show', '是否显示', 'tinyint(2) NULL', 'bool', '1', '', '1', '0:不显示\r\n1:显示', '1239', '0', '1', '1396098464', '1396098464', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12145', 'sort', '排序', 'int(10) UNSIGNED NULL', 'num', '0', '值越小越靠前', '1', '', '1239', '0', '1', '1396098682', '1396098682', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12146', 'token', 'Token', 'varchar(100) NULL', 'string', '', '', '0', '', '1239', '0', '1', '1396098747', '1396098747', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('12147', 'url', '关联URL', 'varchar(255)   NULL', 'string', '', '', '1', '', '1240', '0', '1', '1394519090', '1394519090', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12148', 'title', '菜单名', 'varchar(50) NOT NULL', 'string', '', '可创建最多 3 个一级菜单，每个一级菜单下可创建最多 5 个二级菜单。编辑中的菜单不会马上被用户看到，请放心调试。', '1', '', '1240', '0', '1', '1394519941', '1394518988', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12149', 'pid', '一级菜单', 'tinyint(2) NULL', 'select', '0', '如果是一级菜单，选择“无”即可', '1', '0:无', '1240', '0', '1', '1394519296', '1394518930', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12150', 'sort', '排序号', 'tinyint(4)  NULL', 'num', '0', '数值越小越靠前', '1', '', '1240', '0', '1', '1394523288', '1394519175', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `wp_attribute` VALUES ('12151', 'token', 'Token', 'varchar(255) NOT NULL', 'string', '', '', '0', '', '1240', '0', '1', '1394526820', '1394526820', '', '3', '', 'regex', 'get_token', '1', 'function');
INSERT INTO `wp_attribute` VALUES ('12152', 'icon', '图标', 'int(10) UNSIGNED NULL', 'picture', '', '根据选择的底部模板决定是否需要上传图标', '1', '', '1240', '0', '1', '1396506297', '1396506297', '', '3', '', 'regex', '', '3', 'function');

-- ----------------------------
-- Table structure for wp_auth_extend
-- ----------------------------
DROP TABLE IF EXISTS `wp_auth_extend`;
CREATE TABLE `wp_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

-- ----------------------------
-- Records of wp_auth_extend
-- ----------------------------

-- ----------------------------
-- Table structure for wp_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `wp_auth_group`;
CREATE TABLE `wp_auth_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(30) DEFAULT NULL COMMENT '分组名称',
  `icon` int(10) unsigned DEFAULT NULL COMMENT '图标',
  `description` text COMMENT '描述信息',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态',
  `type` tinyint(2) DEFAULT '1' COMMENT '类型',
  `rules` text COMMENT '权限',
  `manager_id` int(10) DEFAULT '0' COMMENT '管理员ID',
  `token` varchar(100) DEFAULT NULL COMMENT 'Token',
  `is_default` tinyint(1) DEFAULT '0' COMMENT '是否默认自动加入',
  `qr_code` varchar(255) DEFAULT NULL COMMENT '微信二维码',
  `wechat_group_id` int(10) DEFAULT '-1' COMMENT '微信端的分组ID',
  `wechat_group_name` varchar(100) DEFAULT NULL COMMENT '微信端的分组名',
  `wechat_group_count` int(10) DEFAULT NULL COMMENT '微信端用户数',
  `is_del` tinyint(1) DEFAULT '0' COMMENT '是否已删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_auth_group
-- ----------------------------
INSERT INTO `wp_auth_group` VALUES ('1', '默认用户组', null, '通用的用户组', '1', '0', '1,2,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,81,82,83,84,86,87,88,89,90,91,92,93,94,95,96,97,100,102,103,105,106', '0', '', '0', '', null, '', null, '0');
INSERT INTO `wp_auth_group` VALUES ('2', '公众号粉丝组', null, '所有从公众号自动注册的粉丝用户都会自动加入这个用户组', '1', '0', '1,2,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,82,83,84,88,89,90,91,92,93,96,97,100,102,103,195', '0', '', '0', '', null, '', null, '0');
INSERT INTO `wp_auth_group` VALUES ('3', '公众号管理组', null, '公众号管理员注册时会自动加入这个用户组', '1', '0', '', '0', '', '0', '', null, '', null, '0');

-- ----------------------------
-- Table structure for wp_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `wp_auth_group_access`;
CREATE TABLE `wp_auth_group_access` (
  `uid` int(10) DEFAULT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_auth_group_access
-- ----------------------------
INSERT INTO `wp_auth_group_access` VALUES ('1', '3');

-- ----------------------------
-- Table structure for wp_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `wp_auth_rule`;
CREATE TABLE `wp_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(100) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  `group` char(30) DEFAULT '默认分组',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=280 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_auth_rule
-- ----------------------------
INSERT INTO `wp_auth_rule` VALUES ('241', 'Admin/Rule/createRule', '权限节点管理', '1', '', '默认分组');
INSERT INTO `wp_auth_rule` VALUES ('242', 'Admin/AuthManager/index', '用户组管理', '1', '', '默认分组');
INSERT INTO `wp_auth_rule` VALUES ('243', 'Admin/User/index', '用户信息', '1', '', '用户管理');

-- ----------------------------
-- Table structure for wp_auto_reply
-- ----------------------------
DROP TABLE IF EXISTS `wp_auto_reply`;
CREATE TABLE `wp_auto_reply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` varchar(255) DEFAULT NULL COMMENT '关键词',
  `msg_type` char(50) DEFAULT 'text' COMMENT '消息类型',
  `content` text COMMENT '文本内容',
  `group_id` int(10) DEFAULT NULL COMMENT '图文',
  `image_id` int(10) unsigned DEFAULT NULL COMMENT '上传图片',
  `manager_id` int(10) DEFAULT NULL COMMENT '管理员ID',
  `token` varchar(50) DEFAULT NULL COMMENT 'Token',
  `image_material` int(10) DEFAULT NULL COMMENT '素材图片id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_auto_reply
-- ----------------------------

-- ----------------------------
-- Table structure for wp_business_card
-- ----------------------------
DROP TABLE IF EXISTS `wp_business_card`;
CREATE TABLE `wp_business_card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `permission` char(50) DEFAULT '1' COMMENT '权限设置',
  `intro` text COMMENT '个人介绍',
  `wishing` varchar(100) DEFAULT NULL COMMENT '希望结交',
  `wechat` varchar(50) DEFAULT NULL COMMENT '微信号',
  `Email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `telephone` varchar(30) DEFAULT NULL COMMENT '座机',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `company_url` varchar(255) DEFAULT NULL COMMENT '公司网址',
  `department` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `company` varchar(100) DEFAULT NULL COMMENT '公司名称',
  `mobile` varchar(30) DEFAULT NULL COMMENT '手机',
  `position` varchar(50) DEFAULT NULL COMMENT '职位头衔',
  `headface` int(10) unsigned DEFAULT NULL COMMENT '头像',
  `personal_url` varchar(255) DEFAULT NULL COMMENT '个人主页',
  `interest` varchar(255) DEFAULT NULL COMMENT '兴趣',
  `tag` varchar(255) DEFAULT NULL COMMENT '人物标签',
  `weibo` varchar(255) DEFAULT NULL COMMENT '微博',
  `qq` varchar(30) DEFAULT NULL COMMENT 'QQ号',
  `service` text COMMENT '产品服务',
  `truename` varchar(50) DEFAULT NULL COMMENT '真实姓名',
  `uid` int(10) DEFAULT NULL COMMENT '用户ID',
  `template` varchar(50) DEFAULT NULL COMMENT '选择的模板',
  `token` varchar(100) DEFAULT NULL COMMENT 'Token',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_business_card
-- ----------------------------

-- ----------------------------
-- Table structure for wp_business_card_collect
-- ----------------------------
DROP TABLE IF EXISTS `wp_business_card_collect`;
CREATE TABLE `wp_business_card_collect` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `from_uid` int(10) DEFAULT NULL COMMENT '收藏人ID',
  `to_uid` int(10) DEFAULT NULL COMMENT '被收藏人的ID',
  `cTime` int(10) DEFAULT NULL COMMENT '收藏时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_business_card_collect
-- ----------------------------

-- ----------------------------
-- Table structure for wp_business_card_column
-- ----------------------------
DROP TABLE IF EXISTS `wp_business_card_column`;
CREATE TABLE `wp_business_card_column` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `business_card_id` int(10) DEFAULT NULL COMMENT '名片id',
  `type` char(10) DEFAULT '0' COMMENT '栏目类型',
  `cate_id` varchar(100) DEFAULT '0' COMMENT '分类',
  `title` varchar(255) DEFAULT NULL COMMENT '栏目名称',
  `url` varchar(255) DEFAULT NULL COMMENT '跳转url',
  `sort` int(10) DEFAULT '0' COMMENT '排序',
  `uid` int(10) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_business_card_column
-- ----------------------------

-- ----------------------------
-- Table structure for wp_card_vouchers
-- ----------------------------
DROP TABLE IF EXISTS `wp_card_vouchers`;
CREATE TABLE `wp_card_vouchers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(10) DEFAULT NULL COMMENT 'uid',
  `cover` int(10) unsigned DEFAULT NULL COMMENT '素材封面',
  `balance` varchar(30) DEFAULT NULL COMMENT '红包余额',
  `card_id` varchar(100) NOT NULL COMMENT '卡券ID',
  `openid` text COMMENT 'OpenID',
  `appsecre` varchar(255) NOT NULL COMMENT '开通卡券的商家公众号密钥',
  `code` text COMMENT '卡券code码',
  `content` text COMMENT '活动介绍',
  `background` int(10) unsigned DEFAULT NULL COMMENT '背景图',
  `token` varchar(50) DEFAULT NULL COMMENT 'token',
  `title` varchar(255) DEFAULT '卡券' COMMENT '卡券标题',
  `button_color` varchar(255) DEFAULT '#0dbd02' COMMENT '领取按钮颜色',
  `head_bg_color` varchar(255) DEFAULT '#35a2dd' COMMENT '头部背景颜色',
  `shop_name` varchar(255) DEFAULT NULL COMMENT '商家名称',
  `shop_logo` int(10) unsigned DEFAULT NULL COMMENT '商家LOGO',
  `more_button` text COMMENT '添加更多按钮',
  `template` varchar(255) DEFAULT 'default' COMMENT '素材模板',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_card_vouchers
-- ----------------------------

-- ----------------------------
-- Table structure for wp_channel
-- ----------------------------
DROP TABLE IF EXISTS `wp_channel`;
CREATE TABLE `wp_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_channel
-- ----------------------------

-- ----------------------------
-- Table structure for wp_comment
-- ----------------------------
DROP TABLE IF EXISTS `wp_comment`;
CREATE TABLE `wp_comment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `aim_table` varchar(30) DEFAULT NULL COMMENT '评论关联数据表',
  `aim_id` int(10) DEFAULT NULL COMMENT '评论关联ID',
  `cTime` int(10) DEFAULT NULL COMMENT '评论时间',
  `follow_id` int(10) DEFAULT NULL COMMENT 'follow_id',
  `content` text COMMENT '评论内容',
  `is_audit` tinyint(2) DEFAULT '0' COMMENT '是否审核',
  `uid` int(10) DEFAULT NULL COMMENT 'uid',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_comment
-- ----------------------------

-- ----------------------------
-- Table structure for wp_common_category
-- ----------------------------
DROP TABLE IF EXISTS `wp_common_category`;
CREATE TABLE `wp_common_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '分类标识',
  `title` varchar(255) NOT NULL COMMENT '分类标题',
  `icon` int(10) unsigned DEFAULT NULL COMMENT '分类图标',
  `pid` int(10) unsigned DEFAULT '0' COMMENT '上一级分类',
  `path` varchar(255) DEFAULT NULL COMMENT '分类路径',
  `module` varchar(255) DEFAULT NULL COMMENT '分类所属功能',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序号',
  `is_show` tinyint(2) DEFAULT '1' COMMENT '是否显示',
  `intro` varchar(255) DEFAULT NULL COMMENT '分类描述',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `code` varchar(255) DEFAULT NULL COMMENT '分类扩展编号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_common_category
-- ----------------------------

-- ----------------------------
-- Table structure for wp_common_category_group
-- ----------------------------
DROP TABLE IF EXISTS `wp_common_category_group`;
CREATE TABLE `wp_common_category_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '分组标识',
  `title` varchar(255) NOT NULL COMMENT '分组标题',
  `cTime` int(10) unsigned DEFAULT NULL COMMENT '发布时间',
  `token` varchar(100) DEFAULT NULL COMMENT 'Token',
  `level` tinyint(1) unsigned DEFAULT '3' COMMENT '最多级数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_common_category_group
-- ----------------------------

-- ----------------------------
-- Table structure for wp_config
-- ----------------------------
DROP TABLE IF EXISTS `wp_config`;
CREATE TABLE `wp_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text NOT NULL COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='系统配置表';

-- ----------------------------
-- Records of wp_config
-- ----------------------------
INSERT INTO `wp_config` VALUES ('1', 'WEB_SITE_TITLE', '1', '网站标题', '1', '', '网站标题前台显示标题', '1378898976', '1430825115', '1', 'weiphp3.0', '0');
INSERT INTO `wp_config` VALUES ('2', 'WEB_SITE_DESCRIPTION', '2', '网站描述', '1', '', '网站搜索引擎描述', '1378898976', '1379235841', '1', 'weiphp是互联网+的IT综合解决方案', '1');
INSERT INTO `wp_config` VALUES ('3', 'WEB_SITE_KEYWORD', '2', '网站关键字', '1', '', '网站搜索引擎关键字', '1378898976', '1381390100', '1', 'weiphp,互联网+,微信开源开发框架', '8');
INSERT INTO `wp_config` VALUES ('4', 'WEB_SITE_CLOSE', '4', '关闭站点', '1', '0:关闭\r\n1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', '1378898976', '1406859591', '1', '1', '1');
INSERT INTO `wp_config` VALUES ('9', 'CONFIG_TYPE_LIST', '3', '配置类型列表', '4', '', '主要用于数据解析和页面表单的生成', '1378898976', '1379235348', '1', '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', '2');
INSERT INTO `wp_config` VALUES ('10', 'WEB_SITE_ICP', '1', '网站备案号', '1', '', '设置在网站底部显示的备案号，如“沪ICP备12007941号-2', '1378900335', '1379235859', '1', '', '9');
INSERT INTO `wp_config` VALUES ('11', 'DOCUMENT_POSITION', '3', '文档推荐位', '2', '', '文档推荐位，推荐到多个位置KEY值相加即可', '1379053380', '1379235329', '1', '1:列表页推荐\r\n2:频道页推荐\r\n4:网站首页推荐', '3');
INSERT INTO `wp_config` VALUES ('12', 'DOCUMENT_DISPLAY', '3', '文档可见性', '2', '', '文章可见性仅影响前台显示，后台不收影响', '1379056370', '1379235322', '1', '0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见', '4');
INSERT INTO `wp_config` VALUES ('13', 'COLOR_STYLE', '4', '后台色系', '1', 'default_color:默认\r\nblue_color:紫罗兰', '后台颜色风格', '1379122533', '1379235904', '1', 'default_color', '10');
INSERT INTO `wp_config` VALUES ('20', 'CONFIG_GROUP_LIST', '3', '配置分组', '4', '', '配置分组', '1379228036', '1384418383', '1', '1:基本\r\n3:用户\r\n4:系统\r\n5:站点', '4');
INSERT INTO `wp_config` VALUES ('21', 'HOOKS_TYPE', '3', '钩子的类型', '4', '', '类型 1-用于扩展显示内容，2-用于扩展业务处理', '1379313397', '1379313407', '1', '1:视图\r\n2:控制器', '6');
INSERT INTO `wp_config` VALUES ('22', 'AUTH_CONFIG', '3', 'Auth配置', '4', '', '自定义Auth.class.php类配置', '1379409310', '1379409564', '1', 'AUTH_ON:1\r\nAUTH_TYPE:2', '8');
INSERT INTO `wp_config` VALUES ('23', 'OPEN_DRAFTBOX', '4', '是否开启草稿功能', '2', '0:关闭草稿功能\r\n1:开启草稿功能\r\n', '新增文章时的草稿功能配置', '1379484332', '1379484591', '1', '1', '1');
INSERT INTO `wp_config` VALUES ('24', 'DRAFT_AOTOSAVE_INTERVAL', '0', '自动保存草稿时间', '2', '', '自动保存草稿的时间间隔，单位：秒', '1379484574', '1386143323', '1', '60', '2');
INSERT INTO `wp_config` VALUES ('25', 'LIST_ROWS', '0', '后台每页记录数', '4', '', '后台数据每页显示记录数', '1379503896', '1391938052', '1', '20', '10');
INSERT INTO `wp_config` VALUES ('26', 'USER_ALLOW_REGISTER', '4', '是否允许用户注册', '3', '0:关闭注册\r\n1:允许注册', '是否开放用户注册', '1379504487', '1379504580', '1', '0', '0');
INSERT INTO `wp_config` VALUES ('27', 'CODEMIRROR_THEME', '4', '预览插件的CodeMirror主题', '4', '3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight', '详情见CodeMirror官网', '1379814385', '1384740813', '1', 'ambiance', '3');
INSERT INTO `wp_config` VALUES ('28', 'DATA_BACKUP_PATH', '1', '数据库备份根路径', '4', '', '路径必须以 / 结尾', '1381482411', '1381482411', '1', './Data/', '5');
INSERT INTO `wp_config` VALUES ('29', 'DATA_BACKUP_PART_SIZE', '0', '数据库备份卷大小', '4', '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', '1381482488', '1381729564', '1', '20971520', '7');
INSERT INTO `wp_config` VALUES ('30', 'DATA_BACKUP_COMPRESS', '4', '数据库备份文件是否启用压缩', '4', '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', '1381713345', '1381729544', '1', '1', '9');
INSERT INTO `wp_config` VALUES ('31', 'DATA_BACKUP_COMPRESS_LEVEL', '4', '数据库备份文件压缩级别', '4', '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', '1381713408', '1381713408', '1', '9', '10');
INSERT INTO `wp_config` VALUES ('32', 'DEVELOP_MODE', '4', '开启开发者模式', '4', '0:关闭\r\n1:开启', '是否开启开发者模式', '1383105995', '1440555973', '1', '0', '0');
INSERT INTO `wp_config` VALUES ('33', 'ALLOW_VISIT', '3', '不受限控制器方法', '0', '', '', '1386644047', '1386644741', '1', '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname', '0');
INSERT INTO `wp_config` VALUES ('34', 'DENY_VISIT', '3', '超管专限控制器方法', '0', '', '仅超级管理员可访问的控制器方法', '1386644141', '1386644659', '1', '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', '0');
INSERT INTO `wp_config` VALUES ('35', 'REPLY_LIST_ROWS', '0', '回复列表每页条数', '2', '', '', '1386645376', '1387178083', '1', '20', '0');
INSERT INTO `wp_config` VALUES ('36', 'ADMIN_ALLOW_IP', '2', '后台允许访问IP', '4', '', '多个用逗号分隔，如果不配置表示不限制IP访问', '1387165454', '1387165553', '1', '', '12');
INSERT INTO `wp_config` VALUES ('37', 'SHOW_PAGE_TRACE', '4', '是否显示页面Trace', '4', '0:关闭\r\n1:开启', '是否显示页面Trace信息', '1387165685', '1387165685', '1', '0', '1');
INSERT INTO `wp_config` VALUES ('38', 'WEB_SITE_VERIFY', '4', '登录验证码', '1', '0:关闭\r\n1:开启', '登录时是否需要验证码', '1378898976', '1406859544', '1', '1', '2');
INSERT INTO `wp_config` VALUES ('42', 'ACCESS', '2', '未登录时可访问的页面', '4', '', '不区分大小写', '1390656601', '1390664079', '1', 'Home/User/*\r\nHome/Index/*\r\nhome/weixin/*\r\nadmin/File/*\r\nhome/File/*\r\nhome/Forum/*\r\nHome/Material/detail', '0');
INSERT INTO `wp_config` VALUES ('44', 'DEFAULT_PUBLIC_GROUP_ID', '0', '公众号默认等级ID', '3', '', '前台新增加的公众号的默认等级，值为0表示不做权限控制，公众号拥有全部插件的权限', '1393759885', '1393759981', '1', '0', '2');
INSERT INTO `wp_config` VALUES ('45', 'SYSTEM_UPDATE_REMIND', '4', '系统升级提醒', '4', '0:关闭\r\n1:开启', '开启后官方有新升级信息会及时在后台的网站设置页面头部显示升级提醒', '1393764263', '1393764263', '1', '0', '5');
INSERT INTO `wp_config` VALUES ('46', 'SYSTEM_UPDATRE_VERSION', '0', '系统升级最新版本号', '4', '', '记录当前系统的版本号，这是与官方比较是否有升级包的唯一标识，不熟悉者只勿改变其数值', '1393764702', '1394337646', '1', '20150826', '0');
INSERT INTO `wp_config` VALUES ('47', 'FOLLOW_YOUKE_UID', '0', '粉丝游客ID', '0', '', '', '1398927704', '1398927704', '1', '-11909', '0');
INSERT INTO `wp_config` VALUES ('48', 'DEFAULT_PUBLIC', '0', '注册后默认可管理的公众号ID', '3', '', '可为空。配置用户注册后即可管理的公众号ID，多个时用英文逗号分割', '1398928794', '1398929088', '1', '', '3');
INSERT INTO `wp_config` VALUES ('49', 'DEFAULT_PUBLIC_CREATE_MAX_NUMB', '0', '默认用户最多可创建的公众号数', '3', '', '注册用户最多的创建数，也可以在用户管理里对每个用户设置不同的值', '1398949652', '1398950115', '1', '5', '4');
INSERT INTO `wp_config` VALUES ('50', 'COPYRIGHT', '1', '版权信息', '1', '', '', '1401018910', '1401018910', '1', '版本由圆梦云科技有限公司所有', '3');
INSERT INTO `wp_config` VALUES ('51', 'WEIPHP_STORE_LICENSE', '1', '应用商店授权许可证', '1', '', '要与 应用商店》网站信息 里的授权许可证保持一致', '1402972720', '1402977473', '1', '', '0');
INSERT INTO `wp_config` VALUES ('52', 'SYSTEM_LOGO', '1', '网站LOGO', '5', '', '填写LOGO的网址，为空时默认显示weiphp的logo', '1403566699', '1403566746', '1', '', '0');
INSERT INTO `wp_config` VALUES ('53', 'SYSTEM_CLOSE_REGISTER', '4', '前台注册开关', '5', '0:不关闭\r\n1:关闭', '关闭后在登录页面不再显示注册链接', '1403568006', '1403568006', '1', '0', '0');
INSERT INTO `wp_config` VALUES ('54', 'SYSTEM_CLOSE_ADMIN', '4', '后台管理开关', '5', '0:不关闭\r\n1:关闭', '关闭后在登录页面不再显示后台登录链接', '1403568006', '1403568006', '1', '0', '0');
INSERT INTO `wp_config` VALUES ('55', 'SYSTEM_CLOSE_WIKI', '4', '二次开发开关', '5', '0:不关闭\r\n1:关闭', '关闭后在登录页面不再显示二次开发链接', '1403568006', '1403568006', '1', '0', '0');
INSERT INTO `wp_config` VALUES ('56', 'SYSTEM_CLOSE_BBS', '4', '官方论坛开关', '5', '0:不关闭\r\n1:关闭', '关闭后在登录页面不再显示官方论坛链接', '1403568006', '1403568006', '1', '0', '0');
INSERT INTO `wp_config` VALUES ('57', 'LOGIN_BACKGROUP', '1', '登录界面背景图', '5', '', '请输入图片网址，为空时默认使用自带的背景图', '1403568006', '1403570059', '1', '', '0');
INSERT INTO `wp_config` VALUES ('60', 'TONGJI_CODE', '2', '第三方统计JS代码', '5', '', '', '1428634717', '1428634717', '1', '', '0');
INSERT INTO `wp_config` VALUES ('61', 'SENSITIVE_WORDS', '1', '敏感词', '0', '', '当出现有敏感词的地方，会用*号代替, (多个敏感词用 , 隔开 )', '1433125977', '1435062628', '1', 'bitch,shit', '0');
INSERT INTO `wp_config` VALUES ('63', 'PUBLIC_BIND', '4', '公众号第三方平台', '5', '0:关闭\r\n1:开启', '申请审核通过微信开放平台里的公众号第三方平台账号后，就可以开启体验了', '1434542818', '1434542818', '1', '0', '0');
INSERT INTO `wp_config` VALUES ('64', 'COMPONENT_APPID', '1', '公众号开放平台的AppID', '5', '', '公众号第三方平台开启后必填的参数', '1434542891', '1434542975', '1', '', '0');
INSERT INTO `wp_config` VALUES ('65', 'COMPONENT_APPSECRET', '1', '公众号开放平台的AppSecret', '5', '', '公众号第三方平台开启后必填的参数', '1434542936', '1434542984', '1', '', '0');
INSERT INTO `wp_config` VALUES ('62', 'REG_AUDIT', '4', '注册审核', '3', '0:需要审核\r\n1:不需要审核', '', '1439811099', '1439811099', '1', '1', '1');

-- ----------------------------
-- Table structure for wp_coupon
-- ----------------------------
DROP TABLE IF EXISTS `wp_coupon`;
CREATE TABLE `wp_coupon` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `background` int(10) unsigned DEFAULT NULL COMMENT '素材背景图',
  `keyword` varchar(100) DEFAULT NULL COMMENT '关键词',
  `use_tips` text COMMENT '使用说明',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `intro` text COMMENT '封面简介',
  `end_time` int(10) DEFAULT NULL COMMENT '领取结束时间',
  `cover` int(10) unsigned DEFAULT NULL COMMENT '优惠券图片',
  `cTime` int(10) unsigned DEFAULT NULL COMMENT '发布时间',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `start_time` int(10) DEFAULT NULL COMMENT '开始时间',
  `end_tips` text COMMENT '领取结束说明',
  `end_img` int(10) unsigned DEFAULT NULL COMMENT '领取结束提示图片',
  `num` int(10) unsigned DEFAULT '0' COMMENT '优惠券数量',
  `max_num` int(10) unsigned DEFAULT '1' COMMENT '每人最多允许获取次数',
  `follower_condtion` char(50) DEFAULT '1' COMMENT '粉丝状态',
  `credit_conditon` int(10) unsigned DEFAULT '0' COMMENT '积分限制',
  `credit_bug` int(10) unsigned DEFAULT '0' COMMENT '积分消费',
  `addon_condition` varchar(255) DEFAULT NULL COMMENT '插件场景限制',
  `collect_count` int(10) unsigned DEFAULT '0' COMMENT '已领取数',
  `view_count` int(10) unsigned DEFAULT '0' COMMENT '浏览人数',
  `addon` char(50) DEFAULT 'public' COMMENT '插件',
  `shop_uid` varchar(255) DEFAULT NULL COMMENT '商家管理员ID',
  `use_count` int(10) DEFAULT '0' COMMENT '已使用数',
  `pay_password` varchar(255) DEFAULT NULL COMMENT '核销密码',
  `empty_prize_tips` varchar(255) DEFAULT NULL COMMENT '奖品抽完后的提示',
  `start_tips` varchar(255) DEFAULT NULL COMMENT '活动还没开始时的提示语',
  `more_button` text COMMENT '其它按钮',
  `over_time` int(10) DEFAULT NULL COMMENT '使用的截止时间',
  `use_start_time` int(10) DEFAULT NULL COMMENT '使用开始时间',
  `shop_name` varchar(255) DEFAULT '优惠商家' COMMENT '商家名称',
  `shop_logo` int(10) unsigned DEFAULT NULL COMMENT '商家LOGO',
  `head_bg_color` varchar(255) DEFAULT '#35a2dd' COMMENT '头部背景颜色',
  `button_color` varchar(255) DEFAULT '#0dbd02' COMMENT '按钮颜色',
  `template` varchar(255) DEFAULT 'default' COMMENT '素材模板',
  `member` varchar(100) DEFAULT '0' COMMENT '选择人群',
  `is_del` int(10) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_coupon
-- ----------------------------

-- ----------------------------
-- Table structure for wp_coupon_shop
-- ----------------------------
DROP TABLE IF EXISTS `wp_coupon_shop`;
CREATE TABLE `wp_coupon_shop` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) DEFAULT NULL COMMENT '店名',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `phone` varchar(30) DEFAULT NULL COMMENT '联系电话',
  `gps` varchar(50) DEFAULT NULL COMMENT 'GPS经纬度',
  `coupon_id` int(10) DEFAULT NULL COMMENT '所属优惠券编号',
  `token` varchar(255) DEFAULT NULL COMMENT 'token',
  `manager_id` int(10) DEFAULT NULL COMMENT '管理员id',
  `open_time` varchar(50) DEFAULT NULL COMMENT '营业时间',
  `img` int(10) unsigned DEFAULT NULL COMMENT '门店展示图',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_coupon_shop
-- ----------------------------

-- ----------------------------
-- Table structure for wp_coupon_shop_link
-- ----------------------------
DROP TABLE IF EXISTS `wp_coupon_shop_link`;
CREATE TABLE `wp_coupon_shop_link` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `coupon_id` int(10) DEFAULT NULL COMMENT 'coupon_id',
  `shop_id` int(10) DEFAULT NULL COMMENT 'shop_id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_coupon_shop_link
-- ----------------------------

-- ----------------------------
-- Table structure for wp_credit_config
-- ----------------------------
DROP TABLE IF EXISTS `wp_credit_config`;
CREATE TABLE `wp_credit_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL COMMENT '积分描述',
  `name` varchar(50) DEFAULT NULL COMMENT '积分标识',
  `mTime` int(10) DEFAULT NULL COMMENT '修改时间',
  `experience` varchar(30) DEFAULT '0' COMMENT '经验值',
  `score` varchar(30) DEFAULT '0' COMMENT '金币值',
  `token` varchar(255) DEFAULT '0' COMMENT 'Token',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_credit_config
-- ----------------------------
INSERT INTO `wp_credit_config` VALUES ('1', '关注公众号', 'subscribe', '1438587911', '100', '100', '0');
INSERT INTO `wp_credit_config` VALUES ('2', '取消关注公众号', 'unsubscribe', '1438596459', '-100', '-100', '0');
INSERT INTO `wp_credit_config` VALUES ('3', '参与投票', 'vote', '1398565597', '0', '0', '0');
INSERT INTO `wp_credit_config` VALUES ('4', '参与调研', 'survey', '1398565640', '0', '0', '0');
INSERT INTO `wp_credit_config` VALUES ('5', '参与考试', 'exam', '1398565659', '0', '0', '0');
INSERT INTO `wp_credit_config` VALUES ('6', '参与测试', 'test', '1398565681', '0', '0', '0');
INSERT INTO `wp_credit_config` VALUES ('7', '微信聊天', 'chat', '1398565740', '0', '0', '0');
INSERT INTO `wp_credit_config` VALUES ('8', '建议意见反馈', 'suggestions', '1398565798', '0', '0', '0');
INSERT INTO `wp_credit_config` VALUES ('9', '会员卡绑定', 'card_bind', '1438596438', '0', '0', '0');
INSERT INTO `wp_credit_config` VALUES ('10', '获取优惠卷', 'coupons', '1398565926', '0', '0', '0');
INSERT INTO `wp_credit_config` VALUES ('11', '访问微网站', 'weisite', '1398565973', '0', '0', '0');
INSERT INTO `wp_credit_config` VALUES ('12', '查看自定义回复内容', 'custom_reply', '1398566068', '0', '0', '0');
INSERT INTO `wp_credit_config` VALUES ('13', '填写通用表单', 'forms', '1398566118', '0', '0', '0');
INSERT INTO `wp_credit_config` VALUES ('14', '访问微商店', 'shop', '1398566206', '0', '0', '0');
INSERT INTO `wp_credit_config` VALUES ('32', '程序自由增加', 'auto_add', '1442659667', '￥', '￥', '0');

-- ----------------------------
-- Table structure for wp_credit_data
-- ----------------------------
DROP TABLE IF EXISTS `wp_credit_data`;
CREATE TABLE `wp_credit_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(10) DEFAULT '0' COMMENT '用户ID',
  `credit_name` varchar(50) DEFAULT NULL COMMENT '积分标识',
  `experience` int(10) DEFAULT '0' COMMENT '体力值',
  `score` int(10) DEFAULT '0' COMMENT '积分值',
  `cTime` int(10) DEFAULT NULL COMMENT '记录时间',
  `admin_uid` int(10) DEFAULT '0' COMMENT '操作者UID',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `credit_title` varchar(50) DEFAULT NULL COMMENT '积分标题',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_credit_data
-- ----------------------------

-- ----------------------------
-- Table structure for wp_customer
-- ----------------------------
DROP TABLE IF EXISTS `wp_customer`;
CREATE TABLE `wp_customer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT '',
  `sex` varchar(4) DEFAULT '',
  `mobile` varchar(200) DEFAULT '',
  `tel` varchar(200) DEFAULT '',
  `email` varchar(200) DEFAULT '',
  `company` varchar(100) DEFAULT '',
  `job` varchar(20) DEFAULT '',
  `address` varchar(120) DEFAULT '',
  `website` varchar(200) DEFAULT '',
  `qq` varchar(16) DEFAULT '',
  `weixin` varchar(50) DEFAULT '',
  `yixin` varchar(50) DEFAULT '',
  `weibo` varchar(50) DEFAULT '',
  `laiwang` varchar(50) DEFAULT '',
  `remark` varchar(255) DEFAULT '',
  `origin` bigint(20) unsigned NOT NULL DEFAULT '0',
  `originName` varchar(50) NOT NULL DEFAULT '',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `createUser` varchar(32) NOT NULL DEFAULT '',
  `createTime` int(10) unsigned NOT NULL DEFAULT '0',
  `groupId` varchar(20) NOT NULL DEFAULT '',
  `groupName` varchar(200) DEFAULT '',
  `group` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_customer
-- ----------------------------

-- ----------------------------
-- Table structure for wp_custom_menu
-- ----------------------------
DROP TABLE IF EXISTS `wp_custom_menu`;
CREATE TABLE `wp_custom_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sort` tinyint(4) DEFAULT '0' COMMENT '排序号',
  `pid` int(10) DEFAULT '0' COMMENT '一级菜单',
  `title` varchar(50) NOT NULL COMMENT '菜单名',
  `keyword` varchar(100) DEFAULT NULL COMMENT '关联关键词',
  `url` varchar(255) DEFAULT NULL COMMENT '关联URL',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `type` varchar(30) DEFAULT 'click' COMMENT '类型',
  `from_type` char(50) DEFAULT '-1' COMMENT '配置动作',
  `addon` char(50) DEFAULT '0' COMMENT '选择插件',
  `target_id` int(10) DEFAULT NULL COMMENT '选择内容',
  `sucai_type` char(50) DEFAULT '0' COMMENT '素材类型',
  `jump_type` char(10) DEFAULT '0' COMMENT '推送类型',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_custom_menu
-- ----------------------------

-- ----------------------------
-- Table structure for wp_custom_reply_mult
-- ----------------------------
DROP TABLE IF EXISTS `wp_custom_reply_mult`;
CREATE TABLE `wp_custom_reply_mult` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` varchar(255) DEFAULT NULL COMMENT '关键词',
  `keyword_type` tinyint(2) DEFAULT '0' COMMENT '关键词类型',
  `mult_ids` varchar(255) DEFAULT NULL COMMENT '多图文ID',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_custom_reply_mult
-- ----------------------------

-- ----------------------------
-- Table structure for wp_custom_reply_news
-- ----------------------------
DROP TABLE IF EXISTS `wp_custom_reply_news`;
CREATE TABLE `wp_custom_reply_news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` varchar(100) NOT NULL COMMENT '关键词',
  `keyword_type` tinyint(2) DEFAULT NULL COMMENT '关键词类型',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `intro` text COMMENT '简介',
  `cate_id` int(10) unsigned DEFAULT '0' COMMENT '所属类别',
  `cover` int(10) unsigned DEFAULT NULL COMMENT '封面图片',
  `content` text COMMENT '内容',
  `cTime` int(10) DEFAULT NULL COMMENT '发布时间',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序号',
  `view_count` int(10) unsigned DEFAULT '0' COMMENT '浏览数',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `jump_url` varchar(255) DEFAULT NULL COMMENT '外链',
  `author` varchar(50) DEFAULT NULL COMMENT '作者',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_custom_reply_news
-- ----------------------------

-- ----------------------------
-- Table structure for wp_custom_reply_text
-- ----------------------------
DROP TABLE IF EXISTS `wp_custom_reply_text`;
CREATE TABLE `wp_custom_reply_text` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` varchar(255) DEFAULT NULL COMMENT '关键词',
  `keyword_type` tinyint(2) DEFAULT '0' COMMENT '关键词类型',
  `content` text COMMENT '回复内容',
  `view_count` int(10) unsigned DEFAULT '0' COMMENT '浏览数',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序号',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_custom_reply_text
-- ----------------------------

-- ----------------------------
-- Table structure for wp_custom_sendall
-- ----------------------------
DROP TABLE IF EXISTS `wp_custom_sendall`;
CREATE TABLE `wp_custom_sendall` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ToUserName` varchar(255) DEFAULT NULL COMMENT 'token',
  `FromUserName` varchar(255) DEFAULT NULL COMMENT 'openid',
  `cTime` int(10) DEFAULT NULL COMMENT '创建时间',
  `msgType` varchar(255) DEFAULT NULL COMMENT '消息类型',
  `manager_id` int(10) DEFAULT NULL COMMENT '管理员id',
  `content` text COMMENT '内容',
  `media_id` varchar(255) DEFAULT NULL COMMENT '多媒体文件id',
  `is_send` int(10) DEFAULT NULL COMMENT '是否已经发送',
  `uid` int(10) DEFAULT NULL COMMENT '粉丝uid',
  `news_group_id` varchar(10) DEFAULT NULL COMMENT '图文组id',
  `video_title` varchar(255) DEFAULT NULL COMMENT '视频标题',
  `video_description` text COMMENT '视频描述',
  `video_thumb` varchar(255) DEFAULT NULL COMMENT '视频缩略图',
  `voice_id` int(10) DEFAULT NULL COMMENT '语音id',
  `image_id` int(10) DEFAULT NULL COMMENT '图片id',
  `video_id` int(10) DEFAULT NULL COMMENT '视频id',
  `send_type` int(10) DEFAULT NULL COMMENT '发送方式',
  `send_opends` text COMMENT '指定用户',
  `group_id` int(10) DEFAULT NULL COMMENT '分组id',
  `diff` int(10) DEFAULT '0' COMMENT '区分消息标识',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_custom_sendall
-- ----------------------------

-- ----------------------------
-- Table structure for wp_draw_follow_log
-- ----------------------------
DROP TABLE IF EXISTS `wp_draw_follow_log`;
CREATE TABLE `wp_draw_follow_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `follow_id` int(10) DEFAULT NULL COMMENT '粉丝id',
  `sports_id` int(10) DEFAULT NULL COMMENT '场次id',
  `count` int(10) DEFAULT '0' COMMENT '抽奖次数',
  `uid` int(10) DEFAULT NULL COMMENT 'uid',
  `cTime` int(10) DEFAULT NULL COMMENT '支持时间',
  `token` varchar(255) DEFAULT NULL COMMENT 'token',
  PRIMARY KEY (`id`),
  KEY `sports_id` (`sports_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_draw_follow_log
-- ----------------------------

-- ----------------------------
-- Table structure for wp_exam
-- ----------------------------
DROP TABLE IF EXISTS `wp_exam`;
CREATE TABLE `wp_exam` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` varchar(100) NOT NULL COMMENT '关键词',
  `keyword_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '关键词匹配类型',
  `title` varchar(255) NOT NULL COMMENT '试卷标题',
  `intro` text NOT NULL COMMENT '封面简介',
  `mTime` int(10) NOT NULL COMMENT '修改时间',
  `cover` int(10) unsigned NOT NULL COMMENT '封面图片',
  `cTime` int(10) unsigned NOT NULL COMMENT '发布时间',
  `token` varchar(255) NOT NULL COMMENT 'Token',
  `finish_tip` text NOT NULL COMMENT '结束语',
  `start_time` int(10) DEFAULT NULL COMMENT '考试开始时间',
  `end_time` int(10) DEFAULT NULL COMMENT '考试结束时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_exam
-- ----------------------------

-- ----------------------------
-- Table structure for wp_exam_answer
-- ----------------------------
DROP TABLE IF EXISTS `wp_exam_answer`;
CREATE TABLE `wp_exam_answer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `answer` text NOT NULL COMMENT '回答内容',
  `openid` varchar(255) NOT NULL COMMENT 'OpenId',
  `uid` int(10) unsigned NOT NULL COMMENT '用户UID',
  `question_id` int(10) unsigned NOT NULL COMMENT 'question_id',
  `cTime` int(10) unsigned NOT NULL COMMENT '发布时间',
  `token` varchar(255) NOT NULL COMMENT 'Token',
  `exam_id` int(10) unsigned NOT NULL COMMENT 'exam_id',
  `score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '得分',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_exam_answer
-- ----------------------------

-- ----------------------------
-- Table structure for wp_exam_question
-- ----------------------------
DROP TABLE IF EXISTS `wp_exam_question`;
CREATE TABLE `wp_exam_question` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL COMMENT '题目标题',
  `intro` text NOT NULL COMMENT '题目描述',
  `cTime` int(10) unsigned NOT NULL COMMENT '发布时间',
  `token` varchar(255) NOT NULL COMMENT 'Token',
  `is_must` tinyint(2) NOT NULL DEFAULT '1' COMMENT '是否必填',
  `extra` text NOT NULL COMMENT '参数',
  `type` char(50) NOT NULL DEFAULT 'radio' COMMENT '题目类型',
  `exam_id` int(10) unsigned NOT NULL COMMENT 'exam_id',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序号',
  `score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分值',
  `answer` varchar(255) NOT NULL COMMENT '标准答案',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_exam_question
-- ----------------------------

-- ----------------------------
-- Table structure for wp_extensions
-- ----------------------------
DROP TABLE IF EXISTS `wp_extensions`;
CREATE TABLE `wp_extensions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword_type` tinyint(2) DEFAULT '0' COMMENT '关键词匹配类型',
  `api_token` varchar(255) NOT NULL COMMENT 'Token',
  `cTime` int(10) NOT NULL COMMENT '创建时间',
  `api_url` varchar(255) NOT NULL COMMENT '第三方URL',
  `output_format` tinyint(1) DEFAULT '0' COMMENT '数据输出格式',
  `keyword_filter` tinyint(2) NOT NULL DEFAULT '0' COMMENT '关键词过滤',
  `keyword` varchar(255) NOT NULL COMMENT '关键词',
  `token` varchar(255) NOT NULL COMMENT 'Token',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_extensions
-- ----------------------------

-- ----------------------------
-- Table structure for wp_file
-- ----------------------------
DROP TABLE IF EXISTS `wp_file`;
CREATE TABLE `wp_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `create_time` int(10) unsigned NOT NULL COMMENT '上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文件表';

-- ----------------------------
-- Records of wp_file
-- ----------------------------

-- ----------------------------
-- Table structure for wp_forms
-- ----------------------------
DROP TABLE IF EXISTS `wp_forms`;
CREATE TABLE `wp_forms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `cTime` int(10) unsigned DEFAULT NULL COMMENT '发布时间',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `password` varchar(255) DEFAULT NULL COMMENT '表单密码',
  `keyword_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '关键词类型',
  `jump_url` varchar(255) DEFAULT NULL COMMENT '提交后跳转的地址',
  `content` text COMMENT '详细介绍',
  `finish_tip` text COMMENT '用户提交后提示内容',
  `can_edit` tinyint(2) DEFAULT '0' COMMENT '是否允许编辑',
  `intro` text COMMENT '封面简介',
  `mTime` int(10) DEFAULT NULL COMMENT '修改时间',
  `cover` int(10) unsigned DEFAULT NULL COMMENT '封面图片',
  `keyword` varchar(100) NOT NULL COMMENT '关键词',
  `template` varchar(255) DEFAULT 'default' COMMENT '模板',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_forms
-- ----------------------------

-- ----------------------------
-- Table structure for wp_forms_attribute
-- ----------------------------
DROP TABLE IF EXISTS `wp_forms_attribute`;
CREATE TABLE `wp_forms_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `is_show` tinyint(2) DEFAULT '1' COMMENT '是否显示',
  `forms_id` int(10) unsigned DEFAULT NULL COMMENT '表单ID',
  `error_info` varchar(255) DEFAULT NULL COMMENT '出错提示',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序号',
  `validate_rule` varchar(255) DEFAULT NULL COMMENT '正则验证',
  `is_must` tinyint(2) DEFAULT NULL COMMENT '是否必填',
  `remark` varchar(255) DEFAULT NULL COMMENT '字段备注',
  `name` varchar(100) DEFAULT NULL COMMENT '字段名',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `title` varchar(255) NOT NULL COMMENT '字段标题',
  `mTime` int(10) DEFAULT NULL COMMENT '修改时间',
  `extra` text COMMENT '参数',
  `type` char(50) NOT NULL DEFAULT 'string' COMMENT '字段类型',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_forms_attribute
-- ----------------------------

-- ----------------------------
-- Table structure for wp_forms_value
-- ----------------------------
DROP TABLE IF EXISTS `wp_forms_value`;
CREATE TABLE `wp_forms_value` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `forms_id` int(10) unsigned DEFAULT NULL COMMENT '表单ID',
  `value` text COMMENT '表单值',
  `cTime` int(10) DEFAULT NULL COMMENT '增加时间',
  `openid` varchar(255) DEFAULT NULL COMMENT 'OpenId',
  `uid` int(10) DEFAULT NULL COMMENT '用户ID',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_forms_value
-- ----------------------------

-- ----------------------------
-- Table structure for wp_forum
-- ----------------------------
DROP TABLE IF EXISTS `wp_forum`;
CREATE TABLE `wp_forum` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `uid` int(10) DEFAULT '0' COMMENT '用户ID',
  `content` text COMMENT '内容',
  `cTime` int(10) DEFAULT NULL COMMENT '发布时间',
  `attach` varchar(255) DEFAULT NULL COMMENT '附件',
  `is_top` int(10) DEFAULT '0' COMMENT '置顶',
  `cid` tinyint(4) DEFAULT NULL COMMENT '分类',
  `view_count` int(11) unsigned DEFAULT '0' COMMENT '浏览数',
  `reply_count` int(11) unsigned DEFAULT '0' COMMENT '回复数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_forum
-- ----------------------------

-- ----------------------------
-- Table structure for wp_guess
-- ----------------------------
DROP TABLE IF EXISTS `wp_guess`;
CREATE TABLE `wp_guess` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) DEFAULT NULL COMMENT '竞猜标题',
  `desc` text COMMENT '活动说明',
  `start_time` int(10) DEFAULT NULL COMMENT '开始时间',
  `end_time` int(10) DEFAULT NULL COMMENT '结束时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `guess_count` int(10) unsigned DEFAULT '0',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `template` varchar(255) DEFAULT 'default' COMMENT '素材模板',
  `cover` int(10) unsigned DEFAULT NULL COMMENT '主题图片',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_guess
-- ----------------------------

-- ----------------------------
-- Table structure for wp_guess_log
-- ----------------------------
DROP TABLE IF EXISTS `wp_guess_log`;
CREATE TABLE `wp_guess_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) unsigned DEFAULT '0' COMMENT '用户ID',
  `guess_id` int(10) unsigned DEFAULT '0' COMMENT '竞猜Id',
  `token` varchar(255) DEFAULT NULL COMMENT '用户token',
  `optionIds` varchar(255) DEFAULT NULL COMMENT '用户猜的选项IDs',
  `cTime` int(10) DEFAULT NULL COMMENT '创时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_guess_log
-- ----------------------------

-- ----------------------------
-- Table structure for wp_guess_option
-- ----------------------------
DROP TABLE IF EXISTS `wp_guess_option`;
CREATE TABLE `wp_guess_option` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `guess_id` int(10) DEFAULT '0' COMMENT '竞猜活动的Id',
  `name` varchar(255) DEFAULT NULL COMMENT '选项名称',
  `image` int(10) unsigned DEFAULT NULL COMMENT '选项图片',
  `order` int(10) DEFAULT '0' COMMENT '选项顺序',
  `guess_count` int(10) unsigned DEFAULT '0' COMMENT '竞猜人数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_guess_option
-- ----------------------------

-- ----------------------------
-- Table structure for wp_hooks
-- ----------------------------
DROP TABLE IF EXISTS `wp_hooks`;
CREATE TABLE `wp_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text NOT NULL COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` text NOT NULL COMMENT '钩子挂载的插件 ''，''分割',
  PRIMARY KEY (`id`),
  UNIQUE KEY `搜索索引` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='插件钩子表';

-- ----------------------------
-- Records of wp_hooks
-- ----------------------------
INSERT INTO `wp_hooks` VALUES ('1', 'pageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', '1', '0', '');
INSERT INTO `wp_hooks` VALUES ('2', 'pageFooter', '页面footer钩子，一般用于加载插件JS文件和JS代码', '1', '0', 'ReturnTop');
INSERT INTO `wp_hooks` VALUES ('3', 'documentEditForm', '添加编辑表单的 扩展内容钩子', '1', '0', '');
INSERT INTO `wp_hooks` VALUES ('4', 'documentDetailAfter', '文档末尾显示', '1', '0', 'SocialComment');
INSERT INTO `wp_hooks` VALUES ('5', 'documentDetailBefore', '页面内容前显示用钩子', '1', '0', '');
INSERT INTO `wp_hooks` VALUES ('6', 'documentSaveComplete', '保存文档数据后的扩展钩子', '2', '0', '');
INSERT INTO `wp_hooks` VALUES ('7', 'documentEditFormContent', '添加编辑表单的内容显示钩子', '1', '0', 'Editor');
INSERT INTO `wp_hooks` VALUES ('8', 'adminArticleEdit', '后台内容编辑页编辑器', '1', '1378982734', 'EditorForAdmin');
INSERT INTO `wp_hooks` VALUES ('13', 'AdminIndex', '首页小格子个性化显示', '1', '1382596073', 'SiteStat,SystemInfo,DevTeam');
INSERT INTO `wp_hooks` VALUES ('14', 'topicComment', '评论提交方式扩展钩子。', '1', '1380163518', 'Editor');
INSERT INTO `wp_hooks` VALUES ('16', 'app_begin', '应用开始', '2', '1384481614', '');
INSERT INTO `wp_hooks` VALUES ('17', 'weixin', '微信插件必须加载的钩子', '1', '1388810858', 'Hitegg,Diy,RedBag,WeMedia,ShopCoupon,Card,SingIn,Seckill,CustomMenu,CustomReply,AutoReply,WeiSite,UserCenter,Exam,Draw,Extensions,Forms,Coupon,Guess,Comment,Game,ConfigureAccount,Chat,CardVouchers,Ask,BusinessCard,HelloWorld,Invite,Tongji,Test,Vote,Sms,Survey,Shop,Wecome,WishCard,Scratch,Robot,YouaskService,RealPrize,Xydzp,Reserve,PublicBind,Payment,Leaflets,NoAnswer');
INSERT INTO `wp_hooks` VALUES ('18', 'cascade', '级联菜单', '1', '1398694587', 'Cascade');
INSERT INTO `wp_hooks` VALUES ('19', 'page_diy', '万能页面的钩子', '1', '1399040364', 'Diy');
INSERT INTO `wp_hooks` VALUES ('20', 'dynamic_select', '动态下拉菜单', '1', '1435223189', 'DynamicSelect');
INSERT INTO `wp_hooks` VALUES ('21', 'news', '图文素材选择', '1', '1439196828', 'News');

-- ----------------------------
-- Table structure for wp_import
-- ----------------------------
DROP TABLE IF EXISTS `wp_import`;
CREATE TABLE `wp_import` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `attach` int(10) unsigned NOT NULL COMMENT '上传文件',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_import
-- ----------------------------

-- ----------------------------
-- Table structure for wp_invite
-- ----------------------------
DROP TABLE IF EXISTS `wp_invite`;
CREATE TABLE `wp_invite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` varchar(100) NOT NULL COMMENT '关键词',
  `keyword_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '关键词类型',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `intro` text COMMENT '封面简介',
  `mTime` int(10) DEFAULT NULL COMMENT '修改时间',
  `cover` int(10) unsigned NOT NULL COMMENT '封面图片',
  `experience` int(10) DEFAULT '0' COMMENT '消耗经验值',
  `cTime` int(10) unsigned DEFAULT NULL COMMENT '发布时间',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `num` int(10) DEFAULT '0' COMMENT '邀请人数',
  `coupon_id` int(10) DEFAULT NULL COMMENT '优惠券编号',
  `coupon_num` int(10) DEFAULT '0' COMMENT '优惠券数',
  `receive_num` int(10) DEFAULT '0' COMMENT '已领取优惠券数',
  `content` text COMMENT '邀约介绍',
  `template` varchar(255) DEFAULT 'default' COMMENT '模板名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_invite
-- ----------------------------

-- ----------------------------
-- Table structure for wp_invite_code
-- ----------------------------
DROP TABLE IF EXISTS `wp_invite_code`;
CREATE TABLE `wp_invite_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openid` varchar(100) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_invite_code
-- ----------------------------

-- ----------------------------
-- Table structure for wp_invite_user
-- ----------------------------
DROP TABLE IF EXISTS `wp_invite_user`;
CREATE TABLE `wp_invite_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `uid` int(10) DEFAULT NULL COMMENT '用户ID',
  `invite_id` int(10) DEFAULT NULL COMMENT '邀约ID',
  `invite_num` int(10) DEFAULT NULL COMMENT '已邀请人数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_invite_user
-- ----------------------------

-- ----------------------------
-- Table structure for wp_join_count
-- ----------------------------
DROP TABLE IF EXISTS `wp_join_count`;
CREATE TABLE `wp_join_count` (
  `follow_id` int(10) DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `aim_id` int(10) DEFAULT NULL,
  `count` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fid_aim` (`follow_id`,`aim_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_join_count
-- ----------------------------

-- ----------------------------
-- Table structure for wp_keyword
-- ----------------------------
DROP TABLE IF EXISTS `wp_keyword`;
CREATE TABLE `wp_keyword` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` varchar(100) NOT NULL COMMENT '关键词',
  `token` varchar(100) DEFAULT NULL COMMENT 'Token',
  `addon` varchar(255) NOT NULL COMMENT '关键词所属插件',
  `aim_id` int(10) unsigned NOT NULL COMMENT '插件表里的ID值',
  `cTime` int(10) DEFAULT NULL COMMENT '创建时间',
  `keyword_length` int(10) unsigned DEFAULT '0' COMMENT '关键词长度',
  `keyword_type` tinyint(2) DEFAULT '0' COMMENT '匹配类型',
  `extra_text` text COMMENT '文本扩展',
  `extra_int` int(10) DEFAULT NULL COMMENT '数字扩展',
  `request_count` int(10) DEFAULT '0' COMMENT '请求数',
  PRIMARY KEY (`id`),
  KEY `keyword_token` (`keyword`,`token`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_keyword
-- ----------------------------
INSERT INTO `wp_keyword` VALUES ('1', '机器人学习时间', '0', 'Robot', '0', '1393210483', '7', '0', '', '0', '0');
INSERT INTO `wp_keyword` VALUES ('5', '', '3123', 'Shop', '1', '1459914252', '0', '0', 'custom_reply_news', '0', '0');
INSERT INTO `wp_keyword` VALUES ('6', '', '3123', 'Shop', '42', '1461562313', '0', '0', 'custom_reply_news', '0', '0');
INSERT INTO `wp_keyword` VALUES ('7', '', '3123', 'Shop', '43', '1461562331', '0', '0', 'custom_reply_news', '0', '0');
INSERT INTO `wp_keyword` VALUES ('8', '', '3123', 'Shop', '44', '1461566033', '0', '0', 'custom_reply_news', '0', '0');
INSERT INTO `wp_keyword` VALUES ('9', '', '3123', 'Shop', '45', '1461566090', '0', '0', 'custom_reply_news', '0', '0');
INSERT INTO `wp_keyword` VALUES ('10', '', '3123', 'Shop', '46', '1461642471', '0', '0', 'custom_reply_news', '0', '0');
INSERT INTO `wp_keyword` VALUES ('11', '', '3123', 'Shop', '47', '1461642554', '0', '0', 'custom_reply_news', '0', '0');
INSERT INTO `wp_keyword` VALUES ('12', '', '3123', 'Shop', '51', '1461728524', '0', '0', 'custom_reply_news', '0', '0');

-- ----------------------------
-- Table structure for wp_lottery_games
-- ----------------------------
DROP TABLE IF EXISTS `wp_lottery_games`;
CREATE TABLE `wp_lottery_games` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) DEFAULT NULL COMMENT '活动名称',
  `game_type` char(10) DEFAULT '1' COMMENT '游戏类型',
  `status` char(10) DEFAULT '1' COMMENT '状态',
  `start_time` int(10) DEFAULT NULL COMMENT '开始时间',
  `end_time` int(10) DEFAULT NULL COMMENT '结束时间',
  `day_attend_limit` int(10) DEFAULT '0' COMMENT '每人每天抽奖次数',
  `attend_limit` int(10) DEFAULT '0' COMMENT '每人总共抽奖次数',
  `day_win_limit` int(10) DEFAULT '0' COMMENT '每人每天中奖次数',
  `win_limit` int(10) DEFAULT '0' COMMENT '每人总共中奖次数',
  `day_winners_count` int(10) DEFAULT '0' COMMENT '每天最多中奖人数',
  `url` varchar(300) DEFAULT NULL COMMENT '关注链接',
  `remark` text COMMENT '活动说明',
  `keyword` varchar(255) DEFAULT NULL COMMENT '微信关键词',
  `attend_num` int(10) DEFAULT '0' COMMENT '参与总人数',
  `token` varchar(255) DEFAULT NULL COMMENT 'token',
  `manager_id` int(10) DEFAULT NULL COMMENT '管理员id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_lottery_games
-- ----------------------------

-- ----------------------------
-- Table structure for wp_lottery_games_award_link
-- ----------------------------
DROP TABLE IF EXISTS `wp_lottery_games_award_link`;
CREATE TABLE `wp_lottery_games_award_link` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `award_id` int(10) DEFAULT NULL COMMENT '奖品id',
  `games_id` int(10) DEFAULT NULL COMMENT '抽奖游戏id',
  `grade` varchar(255) DEFAULT NULL COMMENT '中奖等级',
  `num` int(10) DEFAULT NULL COMMENT '奖品数量',
  `max_count` int(10) DEFAULT NULL COMMENT '最多抽奖',
  `token` varchar(255) DEFAULT NULL COMMENT 'token',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_lottery_games_award_link
-- ----------------------------

-- ----------------------------
-- Table structure for wp_lottery_prize_list
-- ----------------------------
DROP TABLE IF EXISTS `wp_lottery_prize_list`;
CREATE TABLE `wp_lottery_prize_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sports_id` int(10) DEFAULT NULL COMMENT '活动编号',
  `award_id` varchar(255) DEFAULT NULL COMMENT '奖品编号',
  `award_num` int(10) DEFAULT NULL COMMENT '奖品数量',
  `uid` int(10) DEFAULT NULL COMMENT 'uid',
  PRIMARY KEY (`id`),
  KEY `sports_id` (`sports_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_lottery_prize_list
-- ----------------------------

-- ----------------------------
-- Table structure for wp_lucky_follow
-- ----------------------------
DROP TABLE IF EXISTS `wp_lucky_follow`;
CREATE TABLE `wp_lucky_follow` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(10) DEFAULT NULL COMMENT 'uid',
  `draw_id` int(10) DEFAULT NULL COMMENT '活动编号',
  `sport_id` int(10) DEFAULT NULL COMMENT '场次编号',
  `award_id` int(10) DEFAULT NULL COMMENT '奖品编号',
  `follow_id` int(10) DEFAULT NULL COMMENT '粉丝id',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `num` int(10) DEFAULT '0' COMMENT '获奖数',
  `state` tinyint(2) DEFAULT '0' COMMENT '兑奖状态',
  `zjtime` int(10) DEFAULT NULL COMMENT '中奖时间',
  `djtime` int(10) DEFAULT NULL COMMENT '兑奖时间',
  `remark` text COMMENT '备注',
  `aim_table` varchar(255) DEFAULT NULL COMMENT '活动标识',
  `token` varchar(255) DEFAULT NULL COMMENT 'token',
  `scan_code` varchar(255) DEFAULT NULL COMMENT '核销码',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_lucky_follow
-- ----------------------------

-- ----------------------------
-- Table structure for wp_lzwg_activities
-- ----------------------------
DROP TABLE IF EXISTS `wp_lzwg_activities`;
CREATE TABLE `wp_lzwg_activities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) DEFAULT NULL COMMENT '活动名称',
  `remark` text COMMENT '活动描述',
  `logo_img` int(10) unsigned DEFAULT NULL COMMENT '活动LOGO',
  `start_time` int(10) DEFAULT NULL COMMENT '开始时间',
  `end_time` int(10) DEFAULT NULL COMMENT '结束时间',
  `get_prize_tip` varchar(255) DEFAULT NULL COMMENT '中奖提示信息',
  `no_prize_tip` varchar(255) DEFAULT NULL COMMENT '未中奖提示信息',
  `ctime` int(10) DEFAULT NULL COMMENT '活动创建时间',
  `uid` int(10) DEFAULT NULL COMMENT 'uid',
  `lottery_number` int(10) DEFAULT '1' COMMENT '抽奖次数',
  `comment_status` char(10) DEFAULT '0' COMMENT '评论是否需要审核',
  `get_prize_count` int(10) DEFAULT '1' COMMENT '中奖次数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_lzwg_activities
-- ----------------------------

-- ----------------------------
-- Table structure for wp_lzwg_activities_vote
-- ----------------------------
DROP TABLE IF EXISTS `wp_lzwg_activities_vote`;
CREATE TABLE `wp_lzwg_activities_vote` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `lzwg_id` int(10) DEFAULT NULL COMMENT '活动编号',
  `lzwg_type` char(10) DEFAULT '0' COMMENT '活动类型',
  `vote_id` int(10) DEFAULT NULL COMMENT '题目编号',
  `vote_type` char(10) DEFAULT '1' COMMENT '问题类型',
  `vote_limit` int(10) DEFAULT NULL COMMENT '最多选择几项',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_lzwg_activities_vote
-- ----------------------------

-- ----------------------------
-- Table structure for wp_manager
-- ----------------------------
DROP TABLE IF EXISTS `wp_manager`;
CREATE TABLE `wp_manager` (
  `uid` int(10) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `has_public` tinyint(2) DEFAULT '0' COMMENT '是否配置公众号',
  `headface_url` int(10) unsigned DEFAULT NULL COMMENT '管理员头像',
  `GammaAppId` varchar(30) DEFAULT NULL COMMENT '摇电视的AppId',
  `GammaSecret` varchar(100) DEFAULT NULL COMMENT '摇电视的Secret',
  `copy_right` varchar(255) DEFAULT NULL COMMENT '授权信息',
  `tongji_code` text COMMENT '统计代码',
  `website_logo` int(10) unsigned DEFAULT NULL COMMENT '网站LOGO',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_manager
-- ----------------------------
INSERT INTO `wp_manager` VALUES ('1', '1', '0', null, null, '', '', '0');

-- ----------------------------
-- Table structure for wp_manager_menu
-- ----------------------------
DROP TABLE IF EXISTS `wp_manager_menu`;
CREATE TABLE `wp_manager_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `menu_type` tinyint(2) DEFAULT '0' COMMENT '菜单类型',
  `pid` varchar(50) DEFAULT '0' COMMENT '上级菜单',
  `title` varchar(50) DEFAULT NULL COMMENT '菜单名',
  `url_type` tinyint(2) DEFAULT '0' COMMENT '链接类型',
  `addon_name` varchar(30) DEFAULT NULL COMMENT '插件名',
  `url` varchar(255) DEFAULT NULL COMMENT '外链',
  `target` char(50) DEFAULT '_self' COMMENT '打开方式',
  `is_hide` tinyint(2) DEFAULT '0' COMMENT '是否隐藏',
  `sort` int(10) DEFAULT '0' COMMENT '排序号',
  `uid` int(10) DEFAULT NULL COMMENT '管理员ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=356 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_manager_menu
-- ----------------------------
INSERT INTO `wp_manager_menu` VALUES ('14', '0', '', '首页', '1', '', 'home/index/main', '_self', '0', '0', '1');
INSERT INTO `wp_manager_menu` VALUES ('15', '0', '', '用户管理', '0', 'UserCenter', '', '_self', '0', '1', '1');
INSERT INTO `wp_manager_menu` VALUES ('16', '1', '15', '微信用户', '0', 'UserCenter', '', '_self', '0', '0', '1');
INSERT INTO `wp_manager_menu` VALUES ('17', '0', '', '互动应用', '0', 'Vote', '', '_self', '0', '2', '1');
INSERT INTO `wp_manager_menu` VALUES ('18', '1', '17', '普通投票', '0', 'Vote', '', '_self', '0', '0', '1');
INSERT INTO `wp_manager_menu` VALUES ('19', '1', '17', '微调研', '0', 'Survey', '', '_self', '0', '1', '1');
INSERT INTO `wp_manager_menu` VALUES ('20', '1', '17', '刮刮卡', '0', 'Scratch', '', '_self', '0', '2', '1');
INSERT INTO `wp_manager_menu` VALUES ('30', '1', '17', '微邀约', '0', 'Invite', '', '_self', '0', '12', '1');
INSERT INTO `wp_manager_menu` VALUES ('22', '1', '17', '大转盘', '0', 'Xydzp', '', '_self', '0', '4', '1');
INSERT INTO `wp_manager_menu` VALUES ('23', '1', '17', '通用表单', '0', 'Forms', '', '_self', '0', '5', '1');
INSERT INTO `wp_manager_menu` VALUES ('24', '1', '17', '竞猜', '0', 'Guess', '', '_self', '0', '6', '1');
INSERT INTO `wp_manager_menu` VALUES ('25', '1', '17', '微贺卡', '0', 'WishCard', '', '_self', '0', '7', '1');
INSERT INTO `wp_manager_menu` VALUES ('26', '1', '17', '微信卡券', '0', 'CardVouchers', '', '_self', '0', '8', '1');
INSERT INTO `wp_manager_menu` VALUES ('27', '1', '17', '优惠券', '0', 'Coupon', '', '_self', '0', '9', '1');
INSERT INTO `wp_manager_menu` VALUES ('29', '1', '17', '实物奖励', '0', 'RealPrize', '', '_self', '0', '11', '1');
INSERT INTO `wp_manager_menu` VALUES ('31', '0', '', '微网站', '0', 'WeiSite', '', '_self', '0', '3', '1');
INSERT INTO `wp_manager_menu` VALUES ('32', '1', '31', '微网设置', '1', '', 'WeiSite://WeiSite/config', '_self', '0', '0', '1');
INSERT INTO `wp_manager_menu` VALUES ('46', '1', '45', '欢迎语设置', '0', 'Wecome', '', '_self', '0', '0', '1');
INSERT INTO `wp_manager_menu` VALUES ('33', '1', '31', '分类管理', '1', '', 'WeiSite://Category/lists', '_self', '0', '2', '1');
INSERT INTO `wp_manager_menu` VALUES ('34', '1', '31', '幻灯片', '1', '', 'WeiSite://Slideshow/lists', '_self', '0', '3', '1');
INSERT INTO `wp_manager_menu` VALUES ('35', '1', '31', '底部导航', '1', '', 'WeiSite://Footer/lists', '_self', '0', '4', '1');
INSERT INTO `wp_manager_menu` VALUES ('36', '1', '31', '文章管理', '1', '', 'WeiSite://Cms/lists', '_self', '0', '5', '1');
INSERT INTO `wp_manager_menu` VALUES ('44', '1', '15', '微信咨询', '1', '', 'home/WeixinMessage/lists', '_self', '0', '0', '1');
INSERT INTO `wp_manager_menu` VALUES ('37', '1', '31', '模版管理', '1', '', 'WeiSite://Template/index', '_self', '0', '6', '1');
INSERT INTO `wp_manager_menu` VALUES ('45', '0', '', '公众号功能', '0', 'Wecome', '', '_self', '0', '1', '1');
INSERT INTO `wp_manager_menu` VALUES ('38', '0', '', '微商城', '1', '', 'Shop://Shop/summary', '_self', '0', '4', '1');
INSERT INTO `wp_manager_menu` VALUES ('41', '1', '15', '用户分组', '1', '', 'home/AuthGroup/lists', '_self', '0', '2', '1');
INSERT INTO `wp_manager_menu` VALUES ('42', '1', '15', '用户积分', '1', '', 'home/CreditConfig/lists', '_self', '0', '3', '1');
INSERT INTO `wp_manager_menu` VALUES ('43', '1', '15', '群发消息', '1', '', 'home/Message/add', '_self', '0', '4', '1');
INSERT INTO `wp_manager_menu` VALUES ('47', '1', '45', '自定义菜单', '0', 'CustomMenu', '', '_self', '0', '1', '1');
INSERT INTO `wp_manager_menu` VALUES ('48', '1', '45', '自动回复', '0', 'AutoReply', '', '_self', '0', '2', '1');
INSERT INTO `wp_manager_menu` VALUES ('49', '1', '45', '微信宣传页', '0', 'Leaflets', '', '_self', '0', '3', '1');
INSERT INTO `wp_manager_menu` VALUES ('51', '1', '38', '店铺汇总', '1', '', 'Shop://Shop/summary', '_self', '0', '0', '1');
INSERT INTO `wp_manager_menu` VALUES ('52', '1', '38', '基本信息', '1', '', 'Shop://Shop/edit', '_self', '0', '1', '1');
INSERT INTO `wp_manager_menu` VALUES ('53', '1', '38', '商品分类', '1', '', 'Shop://Category/lists', '_self', '0', '4', '1');
INSERT INTO `wp_manager_menu` VALUES ('56', '1', '38', '首页幻灯片', '1', '', 'Shop://Slideshow/lists', '_self', '0', '7', '1');
INSERT INTO `wp_manager_menu` VALUES ('55', '1', '38', '商品管理', '1', '', 'Shop://Goods/lists', '_self', '0', '2', '1');
INSERT INTO `wp_manager_menu` VALUES ('57', '1', '38', '订单管理', '1', '', 'Shop://Order/lists', '_self', '0', '3', '1');
INSERT INTO `wp_manager_menu` VALUES ('58', '1', '38', '模板管理', '1', '', 'Shop://Template/lists', '_self', '1', '5', '1');
INSERT INTO `wp_manager_menu` VALUES ('59', '1', '38', '支付配置', '1', '', 'Payment://Payment/lists', '_self', '0', '9', '1');
INSERT INTO `wp_manager_menu` VALUES ('60', '0', '', '素材管理', '1', '', 'Home/Material/material_lists', '_self', '0', '0', '1');
INSERT INTO `wp_manager_menu` VALUES ('339', '1', '45', '未识别回复', '0', 'NoAnswer', '', '_self', '0', '1', '1');
INSERT INTO `wp_manager_menu` VALUES ('340', '1', '45', '融合第三方', '0', 'Extensions', '', '_self', '0', '5', '1');
INSERT INTO `wp_manager_menu` VALUES ('345', '1', '17', '比赛投票', '1', '', 'Vote://ShopVote/lists', '_self', '0', '1', '1');
INSERT INTO `wp_manager_menu` VALUES ('348', '1', '38', '门店管理', '1', '', 'Coupon://Shop/lists', '_self', '0', '13', '1');
INSERT INTO `wp_manager_menu` VALUES ('349', '1', '17', '微预约', '0', 'Reserve', '', '_self', '0', '9', '1');
INSERT INTO `wp_manager_menu` VALUES ('350', '1', '17', '抽奖游戏', '1', '', 'Draw://Games/lists', '_self', '0', '19', '1');
INSERT INTO `wp_manager_menu` VALUES ('351', '1', '17', '微考试', '0', 'Exam', '', '_self', '0', '4', '1');
INSERT INTO `wp_manager_menu` VALUES ('352', '1', '17', '微测试', '0', 'Test', '', '_self', '0', '5', '1');
INSERT INTO `wp_manager_menu` VALUES ('353', '1', '17', '微抢答', '0', 'Ask', '', '_self', '0', '12', '1');
INSERT INTO `wp_manager_menu` VALUES ('354', '1', '45', '机器学习', '0', 'Robot', '', '_self', '0', '7', '1');
INSERT INTO `wp_manager_menu` VALUES ('355', '1', '45', '智能聊天', '0', 'Chat', '', '_self', '0', '8', '1');

-- ----------------------------
-- Table structure for wp_material_file
-- ----------------------------
DROP TABLE IF EXISTS `wp_material_file`;
CREATE TABLE `wp_material_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `file_id` int(10) DEFAULT NULL COMMENT '上传文件',
  `cover_url` varchar(255) DEFAULT NULL COMMENT '本地URL',
  `media_id` varchar(100) DEFAULT '0' COMMENT '微信端图文消息素材的media_id',
  `wechat_url` varchar(255) DEFAULT NULL COMMENT '微信端的文件地址',
  `cTime` int(10) DEFAULT NULL COMMENT '创建时间',
  `manager_id` int(10) DEFAULT NULL COMMENT '管理员ID',
  `token` varchar(100) DEFAULT NULL COMMENT 'Token',
  `title` varchar(100) DEFAULT NULL COMMENT '素材名称',
  `type` int(10) DEFAULT NULL COMMENT '类型',
  `introduction` text COMMENT '描述',
  `is_use` int(10) DEFAULT '1' COMMENT '可否使用',
  `aim_id` int(10) DEFAULT NULL COMMENT '添加来源标识id',
  `aim_table` varchar(255) DEFAULT NULL COMMENT '来源表名',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_material_file
-- ----------------------------

-- ----------------------------
-- Table structure for wp_material_image
-- ----------------------------
DROP TABLE IF EXISTS `wp_material_image`;
CREATE TABLE `wp_material_image` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cover_id` int(10) DEFAULT NULL COMMENT '图片在本地的ID',
  `cover_url` varchar(255) DEFAULT NULL COMMENT '本地URL',
  `media_id` varchar(100) DEFAULT '0' COMMENT '微信端图文消息素材的media_id',
  `wechat_url` varchar(255) DEFAULT NULL COMMENT '微信端的图片地址',
  `cTime` int(10) DEFAULT NULL COMMENT '创建时间',
  `manager_id` int(10) DEFAULT NULL COMMENT '管理员ID',
  `token` varchar(100) DEFAULT NULL COMMENT 'Token',
  `is_use` int(10) DEFAULT '1' COMMENT '可否使用',
  `aim_id` int(10) DEFAULT NULL COMMENT '添加来源标识id',
  `aim_table` varchar(255) DEFAULT NULL COMMENT '来源表名',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_material_image
-- ----------------------------

-- ----------------------------
-- Table structure for wp_material_news
-- ----------------------------
DROP TABLE IF EXISTS `wp_material_news`;
CREATE TABLE `wp_material_news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `author` varchar(30) DEFAULT NULL COMMENT '作者',
  `cover_id` int(10) unsigned DEFAULT NULL COMMENT '封面',
  `intro` varchar(255) DEFAULT NULL COMMENT '摘要',
  `content` longtext COMMENT '内容',
  `link` varchar(255) DEFAULT NULL COMMENT '外链',
  `group_id` int(10) DEFAULT '0' COMMENT '多图文组的ID',
  `thumb_media_id` varchar(100) DEFAULT NULL COMMENT '图文消息的封面图片素材id（必须是永久mediaID）',
  `media_id` varchar(100) DEFAULT '0' COMMENT '微信端图文消息素材的media_id',
  `manager_id` int(10) DEFAULT NULL COMMENT '管理员ID',
  `token` varchar(100) DEFAULT NULL COMMENT 'Token',
  `cTime` int(10) DEFAULT NULL COMMENT '发布时间',
  `url` varchar(255) DEFAULT NULL COMMENT '图文页url',
  `is_use` int(10) DEFAULT '1' COMMENT '可否使用',
  `aim_id` int(10) DEFAULT NULL COMMENT '添加来源标识id',
  `aim_table` varchar(255) DEFAULT NULL COMMENT '来源表名',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_material_news
-- ----------------------------

-- ----------------------------
-- Table structure for wp_material_text
-- ----------------------------
DROP TABLE IF EXISTS `wp_material_text`;
CREATE TABLE `wp_material_text` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `content` text COMMENT '文本内容',
  `token` varchar(50) DEFAULT NULL COMMENT 'Token',
  `uid` int(10) DEFAULT NULL COMMENT 'uid',
  `is_use` int(10) DEFAULT '1' COMMENT '可否使用',
  `aim_id` int(10) DEFAULT NULL COMMENT '添加来源标识id',
  `aim_table` varchar(255) DEFAULT NULL COMMENT '来源表名',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_material_text
-- ----------------------------

-- ----------------------------
-- Table structure for wp_menu
-- ----------------------------
DROP TABLE IF EXISTS `wp_menu`;
CREATE TABLE `wp_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=153 DEFAULT CHARSET=utf8 COMMENT='后台导航数据表';

-- ----------------------------
-- Records of wp_menu
-- ----------------------------
INSERT INTO `wp_menu` VALUES ('4', '新增', '3', '0', 'article/add', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('5', '编辑', '3', '0', 'article/edit', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('6', '改变状态', '3', '0', 'article/setStatus', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('7', '保存', '3', '0', 'article/update', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('8', '保存草稿', '3', '0', 'article/autoSave', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('9', '移动', '3', '0', 'article/move', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('10', '复制', '3', '0', 'article/copy', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('11', '粘贴', '3', '0', 'article/paste', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('12', '导入', '3', '0', 'article/batchOperate', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('14', '还原', '13', '0', 'article/permit', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('15', '清空', '13', '0', 'article/clear', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('16', '用户', '0', '2', 'User/index', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('17', '用户信息', '16', '0', 'User/index', '0', '', '用户管理', '0');
INSERT INTO `wp_menu` VALUES ('18', '新增用户', '17', '0', 'User/add', '0', '添加新用户', '', '0');
INSERT INTO `wp_menu` VALUES ('19', '用户行为', '16', '0', 'User/action', '0', '', '行为管理', '0');
INSERT INTO `wp_menu` VALUES ('20', '新增用户行为', '19', '0', 'User/addaction', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('21', '编辑用户行为', '19', '0', 'User/editaction', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('22', '保存用户行为', '19', '0', 'User/saveAction', '0', '\"用户->用户行为\"保存编辑和新增的用户行为', '', '0');
INSERT INTO `wp_menu` VALUES ('23', '变更行为状态', '19', '0', 'User/setStatus', '0', '\"用户->用户行为\"中的启用,禁用和删除权限', '', '0');
INSERT INTO `wp_menu` VALUES ('24', '禁用会员', '19', '0', 'User/changeStatus?method=forbidUser', '0', '\"用户->用户信息\"中的禁用', '', '0');
INSERT INTO `wp_menu` VALUES ('25', '启用会员', '19', '0', 'User/changeStatus?method=resumeUser', '0', '\"用户->用户信息\"中的启用', '', '0');
INSERT INTO `wp_menu` VALUES ('26', '删除会员', '19', '0', 'User/changeStatus?method=deleteUser', '0', '\"用户->用户信息\"中的删除', '', '0');
INSERT INTO `wp_menu` VALUES ('27', '用户组管理', '16', '0', 'AuthManager/index', '0', '', '用户管理', '0');
INSERT INTO `wp_menu` VALUES ('28', '删除', '27', '0', 'AuthManager/changeStatus?method=deleteGroup', '0', '删除用户组', '', '0');
INSERT INTO `wp_menu` VALUES ('29', '禁用', '27', '0', 'AuthManager/changeStatus?method=forbidGroup', '0', '禁用用户组', '', '0');
INSERT INTO `wp_menu` VALUES ('30', '恢复', '27', '0', 'AuthManager/changeStatus?method=resumeGroup', '0', '恢复已禁用的用户组', '', '0');
INSERT INTO `wp_menu` VALUES ('31', '新增', '27', '0', 'AuthManager/createGroup', '0', '创建新的用户组', '', '0');
INSERT INTO `wp_menu` VALUES ('32', '编辑', '27', '0', 'AuthManager/editGroup', '0', '编辑用户组名称和描述', '', '0');
INSERT INTO `wp_menu` VALUES ('33', '保存用户组', '27', '0', 'AuthManager/writeGroup', '0', '新增和编辑用户组的\"保存\"按钮', '', '0');
INSERT INTO `wp_menu` VALUES ('34', '授权', '27', '0', 'AuthManager/group', '0', '\"后台 \\ 用户 \\ 用户信息\"列表页的\"授权\"操作按钮,用于设置用户所属用户组', '', '0');
INSERT INTO `wp_menu` VALUES ('35', '访问授权', '27', '0', 'AuthManager/access', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"访问授权\"操作按钮', '', '0');
INSERT INTO `wp_menu` VALUES ('36', '成员授权', '27', '0', 'AuthManager/user', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"成员授权\"操作按钮', '', '0');
INSERT INTO `wp_menu` VALUES ('37', '解除授权', '27', '0', 'AuthManager/removeFromGroup', '0', '\"成员授权\"列表页内的解除授权操作按钮', '', '0');
INSERT INTO `wp_menu` VALUES ('38', '保存成员授权', '27', '0', 'AuthManager/addToGroup', '0', '\"用户信息\"列表页\"授权\"时的\"保存\"按钮和\"成员授权\"里右上角的\"添加\"按钮)', '', '0');
INSERT INTO `wp_menu` VALUES ('39', '分类授权', '27', '0', 'AuthManager/category', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"分类授权\"操作按钮', '', '0');
INSERT INTO `wp_menu` VALUES ('40', '保存分类授权', '27', '0', 'AuthManager/addToCategory', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `wp_menu` VALUES ('41', '模型授权', '27', '0', 'AuthManager/modelauth', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"模型授权\"操作按钮', '', '0');
INSERT INTO `wp_menu` VALUES ('42', '保存模型授权', '27', '0', 'AuthManager/addToModel', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `wp_menu` VALUES ('43', '插件管理', '0', '7', 'Addons/index', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('44', '插件管理', '43', '1', 'Admin/Plugin/index', '0', '', '扩展', '0');
INSERT INTO `wp_menu` VALUES ('45', '创建', '44', '0', 'Addons/create', '0', '服务器上创建插件结构向导', '', '0');
INSERT INTO `wp_menu` VALUES ('46', '检测创建', '44', '0', 'Addons/checkForm', '0', '检测插件是否可以创建', '', '0');
INSERT INTO `wp_menu` VALUES ('47', '预览', '44', '0', 'Addons/preview', '0', '预览插件定义类文件', '', '0');
INSERT INTO `wp_menu` VALUES ('48', '快速生成插件', '44', '0', 'Addons/build', '0', '开始生成插件结构', '', '0');
INSERT INTO `wp_menu` VALUES ('49', '设置', '44', '0', 'Addons/config', '0', '设置插件配置', '', '0');
INSERT INTO `wp_menu` VALUES ('50', '禁用', '44', '0', 'Addons/disable', '0', '禁用插件', '', '0');
INSERT INTO `wp_menu` VALUES ('51', '启用', '44', '0', 'Addons/enable', '0', '启用插件', '', '0');
INSERT INTO `wp_menu` VALUES ('52', '安装', '44', '0', 'Addons/install', '0', '安装插件', '', '0');
INSERT INTO `wp_menu` VALUES ('53', '卸载', '44', '0', 'Addons/uninstall', '0', '卸载插件', '', '0');
INSERT INTO `wp_menu` VALUES ('54', '更新配置', '44', '0', 'Addons/saveconfig', '0', '更新插件配置处理', '', '0');
INSERT INTO `wp_menu` VALUES ('55', '插件后台列表', '44', '0', 'Addons/adminList', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('56', 'URL方式访问插件', '44', '0', 'Addons/execute', '0', '控制是否有权限通过url访问插件控制器方法', '', '0');
INSERT INTO `wp_menu` VALUES ('57', '钩子管理', '43', '3', 'Addons/hooks', '0', '', '扩展', '0');
INSERT INTO `wp_menu` VALUES ('58', '模型管理', '68', '3', 'Model/index', '0', '', '系统设置', '0');
INSERT INTO `wp_menu` VALUES ('59', '新增', '58', '0', 'model/add', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('60', '编辑', '58', '0', 'model/edit', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('61', '改变状态', '58', '0', 'model/setStatus', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('62', '保存数据', '58', '0', 'model/update', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('64', '新增', '63', '0', 'Attribute/add', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('65', '编辑', '63', '0', 'Attribute/edit', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('66', '改变状态', '63', '0', 'Attribute/setStatus', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('67', '保存数据', '63', '0', 'Attribute/update', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('68', '系统', '0', '1', 'Config/group', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('69', '网站设置', '68', '1', 'Config/group', '0', '', '系统设置', '0');
INSERT INTO `wp_menu` VALUES ('70', '配置管理', '68', '4', 'Config/index', '0', '', '系统设置', '0');
INSERT INTO `wp_menu` VALUES ('71', '编辑', '70', '0', 'Config/edit', '0', '新增编辑和保存配置', '', '0');
INSERT INTO `wp_menu` VALUES ('72', '删除', '70', '0', 'Config/del', '0', '删除配置', '', '0');
INSERT INTO `wp_menu` VALUES ('73', '新增', '70', '0', 'Config/add', '0', '新增配置', '', '0');
INSERT INTO `wp_menu` VALUES ('74', '保存', '70', '0', 'Config/save', '0', '保存配置', '', '0');
INSERT INTO `wp_menu` VALUES ('75', '菜单管理', '68', '5', 'Menu/index', '0', '', '系统设置', '0');
INSERT INTO `wp_menu` VALUES ('76', '导航管理', '68', '6', 'Channel/index', '0', '', '系统设置', '0');
INSERT INTO `wp_menu` VALUES ('77', '新增', '76', '0', 'Channel/add', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('78', '编辑', '76', '0', 'Channel/edit', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('79', '删除', '76', '0', 'Channel/del', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('146', '权限节点', '16', '0', 'Admin/Rule/index', '0', '', '用户管理', '1');
INSERT INTO `wp_menu` VALUES ('81', '编辑', '80', '0', 'Category/edit', '0', '编辑和保存栏目分类', '', '0');
INSERT INTO `wp_menu` VALUES ('82', '新增', '80', '0', 'Category/add', '0', '新增栏目分类', '', '0');
INSERT INTO `wp_menu` VALUES ('83', '删除', '80', '0', 'Category/remove', '0', '删除栏目分类', '', '0');
INSERT INTO `wp_menu` VALUES ('84', '移动', '80', '0', 'Category/operate/type/move', '0', '移动栏目分类', '', '0');
INSERT INTO `wp_menu` VALUES ('85', '合并', '80', '0', 'Category/operate/type/merge', '0', '合并栏目分类', '', '0');
INSERT INTO `wp_menu` VALUES ('86', '备份数据库', '68', '0', 'Database/index?type=export', '0', '', '数据备份', '0');
INSERT INTO `wp_menu` VALUES ('87', '备份', '86', '0', 'Database/export', '0', '备份数据库', '', '0');
INSERT INTO `wp_menu` VALUES ('88', '优化表', '86', '0', 'Database/optimize', '0', '优化数据表', '', '0');
INSERT INTO `wp_menu` VALUES ('89', '修复表', '86', '0', 'Database/repair', '0', '修复数据表', '', '0');
INSERT INTO `wp_menu` VALUES ('90', '还原数据库', '68', '0', 'Database/index?type=import', '0', '', '数据备份', '0');
INSERT INTO `wp_menu` VALUES ('91', '恢复', '90', '0', 'Database/import', '0', '数据库恢复', '', '0');
INSERT INTO `wp_menu` VALUES ('92', '删除', '90', '0', 'Database/del', '0', '删除备份文件', '', '0');
INSERT INTO `wp_menu` VALUES ('96', '新增', '75', '0', 'Menu/add', '0', '', '系统设置', '0');
INSERT INTO `wp_menu` VALUES ('98', '编辑', '75', '0', 'Menu/edit', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('104', '下载管理', '102', '0', 'Think/lists?model=download', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('105', '配置管理', '102', '0', 'Think/lists?model=config', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('106', '行为日志', '16', '0', 'Action/actionlog', '0', '', '行为管理', '0');
INSERT INTO `wp_menu` VALUES ('108', '修改密码', '16', '0', 'User/updatePassword', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('109', '修改昵称', '16', '0', 'User/updateNickname', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('110', '查看行为日志', '106', '0', 'action/edit', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('112', '新增数据', '58', '0', 'think/add', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('113', '编辑数据', '58', '0', 'think/edit', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('114', '导入', '75', '0', 'Menu/import', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('115', '生成', '58', '0', 'Model/generate', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('116', '新增钩子', '57', '0', 'Addons/addHook', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('117', '编辑钩子', '57', '0', 'Addons/edithook', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('118', '文档排序', '3', '0', 'Article/sort', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('119', '排序', '70', '0', 'Config/sort', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('120', '排序', '75', '0', 'Menu/sort', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('121', '排序', '76', '0', 'Channel/sort', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('124', '微信插件', '43', '0', 'Admin/Addons/index', '0', '', '扩展', '0');
INSERT INTO `wp_menu` VALUES ('126', '公众号等级', '16', '0', 'admin/PublicGroup/PublicGroup', '0', '', '公众号管理', '0');
INSERT INTO `wp_menu` VALUES ('127', '公众号管理', '16', '1', 'admin/PublicGroup/PublicAdmin', '0', '', '公众号管理', '0');
INSERT INTO `wp_menu` VALUES ('128', '在线升级', '68', '5', 'Admin/Update/index', '0', '', '系统设置', '0');
INSERT INTO `wp_menu` VALUES ('129', '清除缓存', '68', '10', 'Admin/Update/delcache', '0', '', '系统设置', '0');
INSERT INTO `wp_menu` VALUES ('130', '应用商店', '0', '8', 'admin/store/index', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('131', '素材图标', '130', '2', 'admin/store/index?type=material', '0', '', '应用类型', '0');
INSERT INTO `wp_menu` VALUES ('132', '微站模板', '130', '1', 'admin/store/index?type=template', '0', '', '应用类型', '0');
INSERT INTO `wp_menu` VALUES ('133', '我是开发者', '130', '1', '/index.php?s=/home/developer/myApps', '0', '', '开发者', '0');
INSERT INTO `wp_menu` VALUES ('134', '新手安装指南', '130', '0', 'admin/store/index?type=help', '0', '', '我是站长', '0');
INSERT INTO `wp_menu` VALUES ('135', '万能页面', '130', '3', 'admin/store/index?type=diy', '0', '', '应用类型', '0');
INSERT INTO `wp_menu` VALUES ('136', '上传新应用', '130', '2', '/index.php?s=/home/developer/submitApp', '0', '', '开发者', '0');
INSERT INTO `wp_menu` VALUES ('137', '二次开发教程', '130', '3', '/wiki', '0', '', '开发者', '0');
INSERT INTO `wp_menu` VALUES ('138', '网站信息', '130', '0', 'admin/store/index?type=home', '0', '', '我是站长', '0');
INSERT INTO `wp_menu` VALUES ('139', '充值记录', '130', '0', 'admin/store/index?type=recharge', '0', '', '我是站长', '0');
INSERT INTO `wp_menu` VALUES ('140', '消费记录', '130', '0', 'admin/store/index?type=bug', '0', '', '我是站长', '0');
INSERT INTO `wp_menu` VALUES ('141', '官方交流论坛', '130', '4', '/bbs', '0', '', '开发者', '0');
INSERT INTO `wp_menu` VALUES ('142', '在线充值', '130', '0', 'admin/store/index?type=online_recharge', '0', '', '我是站长', '0');
INSERT INTO `wp_menu` VALUES ('143', '微信插件', '130', '0', 'admin/store/index?type=addon', '0', '', '应用类型', '0');
INSERT INTO `wp_menu` VALUES ('144', '公告管理', '68', '4', 'Notice/lists', '0', '', '系统设置', '0');
INSERT INTO `wp_menu` VALUES ('147', '图文样式编辑', '68', '4', 'ArticleStyle/lists', '0', '', '系统设置', '0');
INSERT INTO `wp_menu` VALUES ('148', '增加', '147', '0', 'ArticleStyle/add', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('149', '分组管理', '147', '0', 'ArticleStyle/group', '0', '', '', '0');
INSERT INTO `wp_menu` VALUES ('150', '微信接口节点', '16', '0', 'Admin/Rule/wechat', '0', '', '用户管理', '0');
INSERT INTO `wp_menu` VALUES ('151', '公众号组管理', '16', '0', 'Admin/AuthManager/wechat', '0', '', '用户管理', '0');
INSERT INTO `wp_menu` VALUES ('152', '积分选项管理', '16', '6', 'Admin/Credit/lists', '0', '', '用户管理', '1');

-- ----------------------------
-- Table structure for wp_message
-- ----------------------------
DROP TABLE IF EXISTS `wp_message`;
CREATE TABLE `wp_message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `bind_keyword` varchar(50) DEFAULT NULL COMMENT '关联关键词',
  `preview_openids` text COMMENT '预览人OPENID',
  `group_id` int(10) DEFAULT '0' COMMENT '群发对象',
  `type` tinyint(2) DEFAULT '0' COMMENT '素材来源',
  `media_id` varchar(100) DEFAULT NULL COMMENT '微信素材ID',
  `send_type` tinyint(1) DEFAULT '0' COMMENT '发送方式',
  `send_openids` text COMMENT '要发送的OpenID',
  `msg_id` varchar(255) DEFAULT NULL COMMENT 'msg_id',
  `content` text COMMENT '文本消息内容',
  `msgtype` varchar(255) DEFAULT NULL COMMENT '消息类型',
  `token` varchar(255) DEFAULT NULL COMMENT 'token',
  `appmsg_id` int(10) DEFAULT NULL COMMENT '图文id',
  `voice_id` int(10) DEFAULT NULL COMMENT '语音id',
  `video_id` int(10) DEFAULT NULL COMMENT '视频id',
  `cTime` int(10) DEFAULT NULL COMMENT '群发时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_message
-- ----------------------------

-- ----------------------------
-- Table structure for wp_model
-- ----------------------------
DROP TABLE IF EXISTS `wp_model`;
CREATE TABLE `wp_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text COMMENT '表单字段排序',
  `field_group` varchar(255) DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text COMMENT '属性列表（表的字段）',
  `template_list` varchar(100) DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) DEFAULT '' COMMENT '编辑模板',
  `list_grid` text COMMENT '列表定义',
  `list_row` smallint(2) unsigned DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) DEFAULT 'MyISAM' COMMENT '数据库引擎',
  `addon` varchar(50) DEFAULT NULL COMMENT '所属插件',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=1241 DEFAULT CHARSET=utf8 COMMENT='系统模型表';

-- ----------------------------
-- Records of wp_model
-- ----------------------------
INSERT INTO `wp_model` VALUES ('1', 'user', '用户信息表', '0', '', '0', '[\"come_from\",\"nickname\",\"password\",\"truename\",\"mobile\",\"email\",\"sex\",\"headimgurl\",\"city\",\"province\",\"country\",\"language\",\"score\",\"experience\",\"unionid\",\"login_count\",\"reg_ip\",\"reg_time\",\"last_login_ip\",\"last_login_time\",\"status\",\"is_init\",\"is_audit\"]', '1:基础', '', '', '', '', 'headimgurl|url_img_html:头像\r\nlogin_name:登录账号\r\nlogin_password:登录密码\r\nnickname|deal_emoji:用户昵称\r\nsex|get_name_by_status:性别\r\ngroup:分组\r\nscore:金币值\r\nexperience:经历值\r\nids:操作:set_login?uid=[uid]|设置登录账号,detail?uid=[uid]|详细资料,[EDIT]|编辑', '20', '', '', '1436929111', '1441187405', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('2', 'manager', '公众号管理员配置', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1436932532', '1436942362', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('3', 'manager_menu', '公众号管理员菜单', '0', '', '1', '[\"menu_type\",\"pid\",\"title\",\"url_type\",\"addon_name\",\"url\",\"target\",\"is_hide\",\"sort\"]', '1:基础', '', '', '', '', 'title:菜单名\r\nmenu_type|get_name_by_status:菜单类型\r\naddon_name:插件名\r\nurl:外链\r\ntarget|get_name_by_status:打开方式\r\nis_hide|get_name_by_status:隐藏\r\nsort:排序号\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', '', '', '1435215960', '1437623073', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('4', 'keyword', '关键词表', '0', '', '1', '[\"keyword\",\"keyword_type\",\"addon\",\"aim_id\",\"keyword_length\",\"cTime\",\"extra_text\",\"extra_int\"]', '1:基础', '', '', '', '', 'id:编号\r\nkeyword:关键词\r\naddon:所属插件\r\naim_id:插件数据ID\r\ncTime|time_format:增加时间\r\nrequest_count|intval:请求数\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'keyword', '', '1388815871', '1407251192', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('5', 'qr_code', '二维码表', '0', '', '1', '[\"qr_code\",\"addon\",\"aim_id\",\"cTime\",\"extra_text\",\"extra_int\",\"scene_id\",\"action_name\"]', '1:基础', '', '', '', '', 'scene_id:事件KEY值\r\nqr_code|get_code_img:二维码\r\naction_name|get_name_by_status: 	二维码类型\r\naddon:所属插件\r\naim_id:插件数据ID\r\ncTime|time_format:增加时间\r\nrequest_count|intval:请求数\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'qr_code', '', '1388815871', '1406130247', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('6', 'public', '公众号管理', '0', '', '1', '[\"public_name\",\"public_id\",\"wechat\",\"headface_url\",\"type\",\"appid\",\"secret\",\"encodingaeskey\",\"tips_url\",\"GammaAppId\",\"GammaSecret\",\"public_copy_right\"]', '1:基础', '', '', '', '', 'id:公众号ID\r\npublic_name:公众号名称\r\ntoken:Token\r\ncount:管理员数\r\nids:操作:[EDIT]|编辑,[DELETE]|删除,main&public_id=[id]|进入管理', '20', 'public_name', '', '1391575109', '1447231672', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('7', 'public_group', '公众号等级', '0', '', '1', '[\"title\",\"addon_status\"]', '1:基础', '', '', '', '', 'id:等级ID\r\ntitle:等级名\r\naddon_status:授权的插件\r\npublic_count:公众号数\r\nids:操作:editPublicGroup&id=[id]|编辑,delPublicGroup&id=[id]|删除', '20', 'title', '', '1393724788', '1393730663', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('8', 'public_link', '公众号与管理员的关联关系', '0', '', '1', '[\"uid\",\"addon_status\"]', '1:基础', '', '', '', '', 'uid|get_nickname|deal_emoji:15%管理员(不包括创始人)\r\naddon_status:授权的插件\r\nids:10%操作:[EDIT]|编辑,[DELETE]|删除', '20', '', '', '1398933192', '1447233745', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('9', 'import', '导入数据', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1407554076', '1407554076', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('10', 'addon_category', '插件分类', '0', '', '1', '[\"icon\",\"title\",\"sort\"]', '1:基础', '', '', '', '', 'icon|get_img_html:分类图标\r\ntitle:分类名\r\nsort:排序号\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'title', '', '1400047655', '1437451028', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('12', 'common_category', '通用分类', '0', '', '1', '[\"pid\",\"title\",\"icon\",\"intro\",\"sort\",\"is_show\"]', '1:基础', '', '', '', '', 'code:编号\r\ntitle:标题\r\nicon|get_img_html:图标\r\nsort:排序号\r\nis_show|get_name_by_status:显示\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'title', '', '1397529095', '1404182789', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('13', 'common_category_group', '通用分类分组', '0', '', '1', '[\"name\",\"title\"]', '1:基础', '', '', '', '', 'name:分组标识\r\ntitle:分组标题\r\nids:操作:cascade?target=_blank&module=[name]|数据管理,[EDIT]|编辑,[DELETE]|删除', '20', 'title', '', '1396061373', '1403664378', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('14', 'credit_config', '积分配置', '0', '', '1', '[\"name\",\"title\",\"score\",\"experience\"]', '1:基础', '', '', '', '', 'title:积分描述\r\nname:积分标识\r\nexperience:经验值\r\nscore:金币值\r\nids:操作:[EDIT]|配置', '20', 'title', '', '1396061373', '1438591151', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('15', 'credit_data', '用户积分记录', '0', '', '1', '[\"uid\",\"experience\",\"score\",\"credit_name\"]', '1:基础', '', '', '', '', 'uid:用户\r\ncredit_title:积分来源\r\nexperience:经验值\r\nscore:金币值\r\ncTime|time_format:记录时间\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'uid', '', '1398564291', '1447250833', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('16', 'material_image', '图片素材', '0', '', '1', '', '1:基础', '', '', '', '', '', '10', '', '', '1438684613', '1438684613', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('17', 'material_news', '图文素材', '0', '', '1', '', '1:基础', '', '', '', '', '', '10', '', '', '1438670890', '1438670890', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('18', 'message', '群发消息', '0', '', '1', '[\"type\",\"bind_keyword\",\"media_id\",\"openid\",\"send_type\",\"group_id\",\"send_openids\"]', '1:基础', '', '', '', '', '', '20', '', '', '1437984111', '1438049406', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('19', 'visit_log', '网站访问日志', '0', '', '1', '', '1:基础', '', '', '', '', '', '10', '', '', '1439448351', '1439448351', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('20', 'auth_group', '用户组', '0', '', '1', '[\"title\",\"description\"]', '1:基础', '', '', '', '', 'title:分组名称\r\ndescription:描述\r\nqr_code:二维码\r\nids:操作:export?id=[id]|导出用户,[EDIT]|编辑,[DELETE]|删除', '20', 'title', '', '1437633503', '1447660681', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('21', 'analysis', '统计分析', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1432806941', '1432806941', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('22', 'article_style', '图文样式', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1436845488', '1436845488', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('23', 'article_style_group', '图文样式分组', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1436845186', '1436845186', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('1217', 'youaskservice_wechat_grouplist', 'youaskservice_wechat_grouplist', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1404027300', '1404027300', '1', 'MyISAM', 'YouaskService');
INSERT INTO `wp_model` VALUES ('1218', 'youaskservice_wxlogs', '你问我答- 微信聊天记录', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1406094050', '1406094093', '1', 'MyISAM', 'YouaskService');
INSERT INTO `wp_model` VALUES ('1219', 'prize_address', '奖品收货地址', '0', '', '1', '[\"address\",\"mobile\",\"turename\",\"remark\"]', '1:基础', '', '', '', '', 'prizeid:奖品名称\r\nturename:收货人\r\nmobile:联系方式\r\naddress:收货地址\r\nremark:备注\r\nids:操作:address_edit&id=[id]&_controller=RealPrize&_addons=RealPrize|编辑,[DELETE]|删除', '20', '', '', '1429521514', '1447831599', '1', 'MyISAM', 'RealPrize');
INSERT INTO `wp_model` VALUES ('1220', 'real_prize', '实物奖励', '0', '', '1', '[\"prize_title\",\"prize_name\",\"prize_conditions\",\"prize_count\",\"prize_image\",\"prize_type\",\"use_content\",\"fail_content\",\"template\"]', '1:基础', '', '', '', '', 'prize_name:20%奖品名称\r\nprize_conditions:20%活动说明\r\nprize_count:10%奖品个数\r\nprize_type|get_name_by_status:10%奖品类型\r\nuse_content:20%使用说明\r\nid:20%操作:[EDIT]|编辑,[DELETE]|删除,address_lists?target_id=[id]|查看数据,preview?id=[id]&target=_blank|预览', '20', '', '', '1429515376', '1437452269', '1', 'MyISAM', 'RealPrize');
INSERT INTO `wp_model` VALUES ('1221', 'xydzp', '幸运大转盘', '0', '', '1', '[\"keyword\",\"title\",\"picurl\",\"des_jj\",\"guiz\",\"choujnum\",\"start_date\",\"end_date\",\"experience\",\"background\",\"template\"]', '1:基础', '', '', '', '', 'id:编号\r\nkeyword:触发关键词\r\ntitle:标题\r\nstart_date|time_format:开始时间\r\nend_date|time_format:结束日期\r\nchoujnum:每日抽奖次数\r\nids:操作:[EDIT]|编辑,[DELETE]|删除,zjloglists?id=[id]|中奖记录,jplists?xydzp_id=[id]|奖品设置,preview?id=[id]&target=_blank|预览', '20', 'title', 'des', '1395395179', '1437449460', '1', 'MyISAM', 'Xydzp');
INSERT INTO `wp_model` VALUES ('1222', 'xydzp_jplist', '幸运大转盘奖品列表', '0', '', '1', '[\"gailv\",\"gailv_maxnum\"]', '1:基础', '', '', '', '', 'xydzp_option_id:奖品名称\r\ngailv:中奖概率（0-100）\r\ngailv_maxnum:单日发放上限\r\nids:操作:jpedit?id=[id]|编辑,jpdel?id=[id]|删除', '20', '', '', '1395554963', '1419305652', '1', 'MyISAM', 'Xydzp');
INSERT INTO `wp_model` VALUES ('1223', 'xydzp_log', '幸运大转盘中奖列表', '0', '', '1', '[\"xydzp_id\",\"xydzp_option_id\",\"zip\",\"iphone\",\"address\",\"message\"]', '1:基础', '', '', '', '', 'id:编号\r\ntruename:用户名称\r\nopenid:用户ID\r\nmobile:联系电话\r\ntitle:奖品名称\r\nstate|get_name_by_status:领奖状态\r\nzjdate|time_format:中奖时间\r\nid:标记:ylingqu?id=[id]|已领取,wlingqu?id=[id]|未领取', '20', '', '', '1395395200', '1420358394', '1', 'MyISAM', 'Xydzp');
INSERT INTO `wp_model` VALUES ('1224', 'xydzp_option', '幸运大转盘奖品库设置', '0', '', '1', '[\"title\",\"jptype\",\"coupon_id\",\"experience\",\"num\",\"pic\",\"miaoshu\"]', '1:基础', '', '', '', '', 'pic|get_img_html:奖品图片\r\ntitle:奖品名称\r\njptype|get_name_by_status:奖品类型\r\nnum:库存数量\r\nids:操作:jpopedit?id=[id]|编辑,jpopdel?id=[id]|删除', '20', 'title', '', '1395395190', '1419303406', '1', 'MyISAM', 'Xydzp');
INSERT INTO `wp_model` VALUES ('1225', 'xydzp_userlog', '幸运大转盘用户抽奖记录', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1395567366', '1395567366', '1', 'MyISAM', 'Xydzp');
INSERT INTO `wp_model` VALUES ('1226', 'reserve', '微预约', '0', '', '1', '[\"title\",\"intro\",\"cover\",\"can_edit\",\"finish_tip\",\"jump_url\",\"content\",\"template\",\"status\",\"start_time\",\"end_time\",\"pay_online\"]', '1:基础', '', '', '', '', 'title:标题\r\nstatus|get_name_by_status:状态\r\nstart_time:报名时间\r\nids:操作:preview&id=[id]|预览,[EDIT]|编辑,reserve_value&id=[id]|预约列表,[DELETE]|删除,index&_addons=Reserve&_controller=Wap&reserve_id=[id]|复制链接', '20', 'title', '', '1396061373', '1445409060', '1', 'MyISAM', 'Reserve');
INSERT INTO `wp_model` VALUES ('1227', 'reserve_attribute', '微预约字段', '0', '', '1', '[\"name\",\"title\",\"type\",\"extra\",\"value\",\"remark\",\"is_must\",\"validate_rule\",\"error_info\",\"sort\"]', '1:基础', '', '', '', '', 'title:字段标题\r\nname:字段名\r\ntype|get_name_by_status:字段类型\r\nids:操作:[EDIT]&reserve_id=[reserve_id]|编辑,[DELETE]|删除', '20', 'title', '', '1396061373', '1396710959', '1', 'MyISAM', 'Reserve');
INSERT INTO `wp_model` VALUES ('1228', 'reserve_value', '微预约数据', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1396687959', '1396687959', '1', 'MyISAM', 'Reserve');
INSERT INTO `wp_model` VALUES ('1229', 'reserve_option', '预约选项', '0', '', '1', '', '1:基础', '', '', '', '', '', '10', '', '', '1444962050', '1444962050', '1', 'MyISAM', 'Reserve');
INSERT INTO `wp_model` VALUES ('1230', 'payment_order', '订单支付记录', '0', '', '1', '[\"from\",\"orderName\",\"single_orderid\",\"price\",\"token\",\"wecha_id\",\"paytype\",\"showwxpaytitle\",\"status\"]', '1:基础', '', '', '', '', '', '20', '', '', '1420596259', '1423534012', '1', 'MyISAM', 'Payment');
INSERT INTO `wp_model` VALUES ('1231', 'payment_set', '支付配置', '0', '', '1', '[\"wxappid\",\"wxappsecret\",\"wxpaysignkey\",\"zfbname\",\"pid\",\"key\",\"partnerid\",\"partnerkey\",\"wappartnerid\",\"wappartnerkey\",\"quick_security_key\",\"quick_merid\",\"quick_merabbr\",\"wxmchid\"]', '1:基础', '', '', '', '', '', '10', '', '', '1406958084', '1439364636', '1', 'MyISAM', 'Payment');
INSERT INTO `wp_model` VALUES ('1232', 'vote', '投票', '0', '', '1', '[\"keyword\",\"title\",\"description\",\"picurl\",\"start_date\",\"end_date\",\"template\"]', '1:基础', '', '', '', '', 'id:投票ID\r\nkeyword:关键词\r\ntitle:投票标题\r\ntype|get_name_by_status:类型\r\nis_img|get_name_by_status:状态\r\nvote_count:投票数\r\nids:操作:[EDIT]&id=[id]|编辑,[DELETE]|删除,showLog&id=[id]|投票记录,showCount&id=[id]|选项票数,preview?id=[id]&target=_blank|预览', '20', 'title', 'description', '1388930292', '1437446751', '1', 'MyISAM', 'Vote');
INSERT INTO `wp_model` VALUES ('1233', 'vote_log', '投票记录', '0', '', '1', '[\"vote_id\",\"user_id\",\"options\"]', '1:基础', '', '', '', '', 'vote_id:25%用户头像\r\nuser_id:25%用户\r\noptions:25%投票选项\r\ncTime|time_format:25%创建时间\r\n\r\n\r\n\r\n', '20', '', '', '1388934136', '1447743392', '1', 'MyISAM', 'Vote');
INSERT INTO `wp_model` VALUES ('1234', 'vote_option', '投票选项', '0', '', '1', '[\"name\",\"opt_count\",\"order\"]', '1:基础', '', '', '', '', 'image|get_img_html:选项图片\r\nname:选项标题\r\nopt_count:投票数', '20', '', '', '1388933346', '1447745055', '1', 'MyISAM', 'Vote');
INSERT INTO `wp_model` VALUES ('1235', 'shop_vote', '商城微投票', '0', '', '1', '[\"title\",\"select_type\",\"multi_num\",\"start_time\",\"end_time\",\"is_verify\",\"remark\"]', '1:基础', '', '', '', '', 'title:活动名称\r\nselect_type|get_name_by_status:投票类型\r\nstart_time|time_format:开始时间\r\nend_time|time_format:结束时间\r\nremark:活动说明\r\nids:操作:[EDIT]&id=[id]|编辑,[DELETE]|删除,option_lists&vote_id=[id]|投票选项,show_log&vote_id=[id]|投票记录,preview&vote_id=[id]|预览,index&_addons=Vote&_controller=Wap&vote_id=[id]|复制链接', '10', 'title:请输入活动名称', '', '1443148496', '1445997045', '1', 'MyISAM', 'Vote');
INSERT INTO `wp_model` VALUES ('1236', 'shop_vote_option', '投票选项表', '0', '', '1', '[\"truename\",\"image\",\"manifesto\",\"introduce\"]', '1:基础', '', '', '', '', 'truename:10%参赛者\r\nimage|get_img_html:10%参赛图片\r\nmanifesto:30%参赛宣言\r\nintroduce:25%选手介绍\r\nopt_count:8%得票数\r\nids:17%操作:option_edit&id=[id]|编辑,option_del&id=[id]|删除,show_log&option_id=[id]|投票记录', '10', 'truename:请输入姓名', '', '1443149182', '1447817257', '1', 'MyISAM', 'Vote');
INSERT INTO `wp_model` VALUES ('1237', 'shop_vote_log', '商城投票记录', '0', '', '1', '[\"vote_id\",\"option_id\",\"uid\"]', '1:基础', '', '', '', '', 'vote_id:25%用户头像\r\nuid:25%用户\r\noption_id:25%投票选项\r\nctime|time_format:25%投票时间', '10', 'truename:请输入用户名字', '', '1443150057', '1447749584', '1', 'MyISAM', 'Vote');
INSERT INTO `wp_model` VALUES ('1209', 'prize', '奖项设置', '0', '', '1', '[\"title\",\"name\",\"num\",\"img\",\"sort\"]', '1:基础', '', '', '', '', 'title:奖项标题\r\nname:奖项\r\nnum:名额数量\r\nimg|get_img_html:奖品图片\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'title', '', '1399348610', '1399702991', '1', 'MyISAM', 'Scratch');
INSERT INTO `wp_model` VALUES ('1210', 'scratch', '刮刮卡', '0', '', '1', '[\"keyword\",\"title\",\"intro\",\"cover\",\"use_tips\",\"start_time\",\"end_time\",\"end_tips\",\"end_img\",\"predict_num\",\"max_num\",\"follower_condtion\",\"credit_conditon\",\"credit_bug\",\"addon_condition\",\"collect_count\",\"view_count\",\"template\"]', '1:基础', '', '', '', '', 'id:刮刮卡ID\r\nkeyword:关键词\r\ntitle:标题\r\ncollect_count:获取人数\r\ncTime|time_format:发布时间\r\nids:操作:[EDIT]|编辑,[DELETE]|删除,lists?target_id=[id]&target=_blank&_controller=Sn|中奖管理,lists?target_id=[id]&target=_blank&_controller=Prize|奖品管理,preview?id=[id]&target=_blank|预览', '20', 'title', '', '1396061373', '1437035669', '1', 'MyISAM', 'Scratch');
INSERT INTO `wp_model` VALUES ('1200', 'shop_address', '收货地址', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1423477477', '1423477477', '1', 'MyISAM', null);
INSERT INTO `wp_model` VALUES ('1201', 'shop_slideshow', '幻灯片', '0', '', '1', '[\"title\",\"img\",\"url\",\"is_show\",\"sort\"]', '1:基础', '', '', '', '', 'title:标题\r\nimg:图片\r\nurl:链接地址\r\nis_show|get_name_by_status:显示\r\nsort:排序\r\nids:操作:[EDIT]&module_id=[pid]|编辑,[DELETE]|删除', '20', 'title', '', '1396098264', '1408323347', '1', 'MyISAM', null);
INSERT INTO `wp_model` VALUES ('1202', 'shop_order_log', '订单跟踪', '0', '', '1', '', '1:基础', '', '', '', '', '', '10', '', '', '1439525562', '1439525562', '1', 'MyISAM', null);
INSERT INTO `wp_model` VALUES ('1203', 'shop_order', '订单记录', '0', '', '1', '[\"uid\",\"goods_datas\",\"remark\",\"order_number\",\"cTime\",\"total_price\",\"address_id\",\"is_send\",\"send_code\",\"send_number\",\"send_type\",\"shop_id\"]', '1:基础', '', '', '', '', 'order_number:15%订单编号\r\ngoods:20%下单商品\r\nuid:10%客户\r\ntotal_price:7%总价\r\ncTime|time_format:17%下单时间\r\ncommon|get_name_by_status:10%支付类型\r\nstatus_code|get_name_by_status:10%订单跟踪\r\naction:11%操作', '20', 'order_number:请输入订单编号 或 客户昵称', '', '1420269240', '1440147136', '1', 'MyISAM', null);
INSERT INTO `wp_model` VALUES ('1204', 'shop_goods_score', '商品评分记录', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1422930901', '1422930901', '1', 'MyISAM', null);
INSERT INTO `wp_model` VALUES ('1205', 'shop_goods_category', '商品分类', '0', '', '1', '[\"title\",\"icon\",\"sort\",\"is_show\",\"is_recommend\"]', '1:基础', '', '', '', '', 'title:20%分组\r\nicon|get_img_html:20%图标\r\nsort:20%排序号\r\nis_show|get_name_by_status:20%显示\r\nids:20%操作:[EDIT]|编辑,[DELETE]|删除', '20', 'title', '', '1397529095', '1438326713', '1', 'MyISAM', null);
INSERT INTO `wp_model` VALUES ('1206', 'wish_card', '微贺卡', '0', '', '1', '[\"send_name\",\"receive_name\",\"content\",\"template\"]', '1:基础', '', '', '', '', 'send_name:10%发送人\r\nreceive_name:10%接收人\r\ncontent:40%祝福语\r\ncreate_time|time_format:15%创建时间\r\nread_count:10%浏览次数\r\nid:15%操作:[EDIT]|编辑,card_show?id=[id]&target=_blank&_controller=Wap|预览,[DELETE]|删除', '20', 'content:祝福语', '', '1429346197', '1429760720', '1', 'MyISAM', 'WishCard');
INSERT INTO `wp_model` VALUES ('1207', 'wish_card_content', '祝福语', '0', '', '1', '[\"content_cate\",\"content\"]', '1:基础', '', '', '', '', 'content_cate_id:10%类别Id\r\ncontent_cate:20%类别\r\ncontent:50%祝福语\r\nid:20%操作:[EDIT]|编辑,[DELETE]|删除', '20', '', '', '1429348863', '1429841596', '1', 'MyISAM', 'WishCard');
INSERT INTO `wp_model` VALUES ('1208', 'wish_card_content_cate', '祝福语类别', '0', '', '1', '[\"content_cate_name\",\"content_cate_icon\"]', '1:基础', '', '', '', '', 'content_cate_name:类别\r\ncontent_cate_icon|get_img_html:图标\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'content_cate_name:类别', '', '1429348818', '1429598114', '1', 'MyISAM', 'WishCard');
INSERT INTO `wp_model` VALUES ('81', 'sn_code', 'SN码', '0', '', '1', '[\"prize_title\"]', '1:基础', '', '', '', '', 'sn:SN码\r\nuid|get_nickname|deal_emoji:昵称\r\nprize_title:奖项\r\ncTime|time_format:创建时间\r\nis_use|get_name_by_status:是否已使用\r\nuse_time|time_format:使用时间\r\nids:操作:[DELETE]|删除,set_use?id=[id]|改变使用状态', '20', 'sn', '', '1399272054', '1401013099', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('87', 'store', '应用商店', '0', '', '1', '[\"type\",\"title\",\"price\",\"attach\",\"logo\",\"content\",\"img_1\",\"img_2\",\"img_3\",\"img_4\",\"is_top\",\"audit\",\"audit_time\"]', '1:基础', '', '', '', '', 'id:ID值\r\ntype|get_name_by_status:应用类型\r\ntitle:应用标题\r\nprice:价格\r\nlogo|get_img_html:应用LOGO\r\nmTime|time_format:更新时间\r\naudit|get_name_by_status:审核状态\r\naudit_time|time_format:审核时间\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'title', '', '1394033250', '1402885526', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('88', 'sucai', '素材管理', '0', '', '1', '[\"name\",\"status\",\"cTime\",\"url\",\"type\",\"detail\",\"reason\",\"create_time\",\"checked_time\",\"source\",\"source_id\"]', '1:基础', '', '', '', '', 'name:素材名称\r\nstatus|get_name_by_status:状态\r\nurl:页面URL\r\ncreate_time|time_format:申请时间\r\nchecked_time|time_format:入库时间\r\nids:操作', '20', 'name', '', '1424611702', '1425386629', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('89', 'sucai_template', '素材模板库', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1431575544', '1431575544', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('93', 'system_notice', '系统公告表', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1431141043', '1431141043', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('94', 'update_version', '系统版本升级', '0', '', '1', '[\"version\",\"title\",\"description\",\"create_date\",\"package\"]', '1:基础', '', '', '', '', 'version:版本号\r\ntitle:升级包名\r\ndescription:描述\r\ncreate_date|time_format:创建时间\r\ndownload_count:下载统计数\r\nids:操作:[EDIT]&id=[id]|编辑,[DELETE]&id=[id]|删除', '20', '', '', '1393770420', '1393771807', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('1197', 'shop_goods', '商品列表', '0', '', '1', '[\"title\",\"imgs\",\"category_id\",\"price\",\"is_recommend\",\"content\",\"cover\",\"inventory\",\"is_show\",\"old_price\"]', '1:基础', '', '', '', '', 'category_id:商品分类\r\ncover|get_img_html:封面图\r\ntitle:商品名称\r\nprice:价格\r\ninventory:库存量\r\nsale_count:销售量\r\nis_show|get_name_by_status:是否上架\r\nids:操作:set_show?id=[id]&is_show=[is_show]|改变上架状态,[EDIT]|编辑,[DELETE]|删除', '20', 'title:请输入商品名称', '', '1422672084', '1440124560', '1', 'MyISAM', null);
INSERT INTO `wp_model` VALUES ('1196', 'shop', '微商城', '0', '', '1', '[\"title\",\"logo\",\"intro\",\"mobile\",\"qq\",\"wechat\",\"content\"]', '1:基础', '', '', '', '', 'title:商店名称\r\nlogo|get_img_html:商店LOGO\r\nmobile:联系电话\r\nqq:QQ号\r\nwechat:微信号\r\nids:操作:[EDIT]&id=[id]|编辑,lists&_controller=Category&target=_blank&shop_id=[id]|商品分类,lists&_controller=Slideshow&target=_blank&shop_id=[id]|幻灯片,lists&_controller=Goods&target=_blank&shop_id=[id]|商品管理,lists&_controller=Order&target=_blank&shop_id=[id]|订单管理,lists&_addons=Payment&_controller=Payment&target=_blank&shop_id=[id]|支付配置,lists&_controller=Template&target=_blank&shop_id=[id]|模板选择,[DELETE]|删除,index&_controller=Wap&target=_blank&shop_id=[id]|预览', '20', 'title:请输入商店名称', '', '1422670956', '1423640744', '1', 'MyISAM', null);
INSERT INTO `wp_model` VALUES ('103', 'weixin_message', '微信消息管理', '0', '', '1', '', '1:基础', '', '', '', '', 'FromUserName:用户\r\ncontent:内容\r\nCreateTime:时间', '20', '', '', '1438142999', '1438151555', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('1211', 'youaskservice_behavior', 'youaskservice_behavior', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1404033501', '1404033501', '1', 'MyISAM', 'YouaskService');
INSERT INTO `wp_model` VALUES ('1212', 'youaskservice_group', '你问我答-客服分组', '0', '', '1', '[\"groupname\"]', '1:基础', '', '', '', '', 'id:编号\r\ngroupname:分组名称\r\ntoken:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'groupname', '', '1404475456', '1404491410', '1', 'MyISAM', 'YouaskService');
INSERT INTO `wp_model` VALUES ('1213', 'youaskservice_keyword', '你问我答-关键词指配', '0', '', '1', '[\"msgkeyword\",\"msgkeyword_type\",\"zdtype\",\"msgstate\"]', '1:基础', '', '', '', '', 'id:编号\r\nmsgkeyword:关键字\r\nmsgkeyword_type|get_name_by_status:匹配类型\r\nmsgkfaccount:指定的接待客服或分组\r\nmsgstate|get_name_by_status:状态\r\nzdtype:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'msgkeyword', '', '1404399143', '1404493938', '1', 'MyISAM', 'YouaskService');
INSERT INTO `wp_model` VALUES ('1214', 'youaskservice_logs', '你问我答-聊天记录管理', '0', '', '1', '[\"pid\",\"openid\",\"enddate\",\"keyword\",\"status\"]', '1:基础', '', '', '', '', 'id:编号\r\nkeyword:回复内容\r\nenddate:回复时间', '20', 'keyword', '', '1403947270', '1404060187', '1', 'MyISAM', 'YouaskService');
INSERT INTO `wp_model` VALUES ('1215', 'youaskservice_user', '你问我答-客服工号', '0', '', '1', '[\"name\",\"userName\",\"userPwd\",\"state\",\"kfid\"]', '1:基础', '', '', '', '', 'kfid:编号\r\nname:客服昵称\r\nuserName:客服帐号', '20', 'name', 'userName', '1403947253', '1404398415', '1', 'MyISAM', 'YouaskService');
INSERT INTO `wp_model` VALUES ('1192', 'sms', '短信记录', '0', '', '1', '', '1:基础', '', '', '', '', '', '10', '', '', '1446107661', '1446107661', '1', 'MyISAM', 'Sms');
INSERT INTO `wp_model` VALUES ('1193', 'survey', '调研问卷', '0', '', '1', '[\"keyword\",\"keyword_type\",\"title\",\"cover\",\"intro\",\"finish_tip\",\"template\",\"start_time\",\"end_time\"]', '1:基础', '', '', '', '', 'id:微调研ID\r\nkeyword:关键词\r\nkeyword_type|get_name_by_status:关键词类型\r\ntitle:标题\r\ncTime|time_format:发布时间\r\nids:操作:[EDIT]|编辑,[DELETE]|删除,survey_answer&id=[id]|数据管理,preview?id=[id]&target=_blank|预览', '20', 'title', '', '1396061373', '1447640225', '1', 'MyISAM', 'Survey');
INSERT INTO `wp_model` VALUES ('1194', 'survey_answer', '调研回答', '0', '', '1', '', '1:基础', '', '', '', '', 'openid:OpenId\r\nnickname:昵称\r\nmobile:手机号\r\ncTime|time_format:参与时间\r\nids:操作:detail?uid=[uid]&survey_id=[survey_id]|回答内容', '20', 'title', '', '1396061373', '1447645551', '1', 'MyISAM', 'Survey');
INSERT INTO `wp_model` VALUES ('201', 'custom_sendall', '客服群发消息', '0', '', '1', '', '1:基础', null, '', '', '', null, '10', '', '', '1447241925', '1447241925', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('148', 'material_text', '文本素材', '0', '', '1', '[\"content\"]', '1:基础', '', '', '', '', 'id:编号\r\ncontent:文本内容\r\nids:操作:text_edit?id=[id]|编辑,text_del?id=[id]|删除', '10', 'content:请输入文本内容搜索', '', '1442976119', '1442977453', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('149', 'material_file', '文件素材', '0', '', '1', '[\"title\",\"file_id\"]', '1:基础', '', '', '', '', '', '10', '', '', '1438684613', '1442982212', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('1190', 'test_question', '测试题目', '0', '', '1', '{\"1\":[\"title\",\"extra\",\"intro\",\"sort\"]}', '1:基础', '', '', '', '', 'id:问题编号\r\ntitle:标题\r\nextra:参数\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '10', 'title', '', '1396061373', '1397145854', '1', 'MyISAM', 'Test');
INSERT INTO `wp_model` VALUES ('1177', 'guess_option', '竞猜项目', '0', '', '1', '[\"name\",\"image\",\"order\"]', '1:基础', '', '', '', '', 'title:活动名称\r\nname:选项名称\r\nimage|get_img_html:选项图片\r\norder:选项顺序\r\nguess_count:竞猜人数\r\nids:操作:optionLog&guess_id=[guess_id]&option_id=[id]|查看选项竞猜记录', '20', '', '', '1428659140', '1430374342', '1', 'MyISAM', 'Guess');
INSERT INTO `wp_model` VALUES ('1178', 'comment', '评论互动', '0', '', '1', '[\"is_audit\"]', '1:基础', '', '', '', '', 'headimgurl|url_img_html:用户头像\r\nnickname|deal_emoji:用户姓名\r\ncontent:评论内容\r\ncTime|time_format:评论时间\r\nis_audit|get_name_by_status:审核状态\r\nids:操作:[DELETE]|删除', '20', 'content:请输入评论内容', '', '1432602310', '1435310857', '1', 'MyISAM', 'Comment');
INSERT INTO `wp_model` VALUES ('1179', 'card_vouchers', '微信卡券', '0', '', '1', '[\"appsecre\",\"code\",\"content\",\"background\",\"title\",\"button_color\",\"head_bg_color\",\"shop_name\",\"uid\",\"token\",\"shop_logo\",\"more_button\",\"template\"]', '1:基础', '', '', '', '', 'title:卡券名称\r\ncard_id:卡券ID\r\nappsecre:商家公众号密钥\r\nids:操作:[EDIT]|编辑,[DELETE]|删除,preview?id=[id]&target=_blank|预览', '20', 'card_id', '', '1421980317', '1437451096', '1', 'MyISAM', 'CardVouchers');
INSERT INTO `wp_model` VALUES ('1180', 'ask', '抢答问卷', '0', '', '1', '[\"keyword\",\"keyword_type\",\"title\",\"cover\",\"intro\",\"finish_tip\",\"shop_address\",\"appids\",\"finish_button\",\"content\",\"card_id\",\"appsecre\",\"template\"]', '1:基础', '', '', '', '', 'id:微抢答ID\r\nkeyword:关键词\r\ntitle:标题\r\ncTime|time_format:发布时间\r\nids:操作:[EDIT]|编辑,[DELETE]|删除,ask_question&id=[id]|问题管理,ask_answer&id=[id]|数据管理,preview&id=[id]&target=_blank|预览', '20', 'title', '', '1396061373', '1437449751', '1', 'MyISAM', 'Ask');
INSERT INTO `wp_model` VALUES ('1181', 'ask_answer', '抢答回答', '0', '', '1', '', '1:基础', '', '', '', '', 'uid:用户ID\r\nnickname|deal_emoji:昵称\r\nquestion_id:问题\r\nanswer:回答\r\nis_correct:是否正确\r\ntrue_answer:正确答案\r\ntimes:第几轮\r\ncTime|time_format:回答时间', '20', 'uid:请输入用户ID', '', '1396061373', '1430290975', '1', 'MyISAM', 'Ask');
INSERT INTO `wp_model` VALUES ('1182', 'ask_question', '抢答问题', '0', '', '1', '[\"title\",\"type\",\"extra\",\"answer\",\"wait_time\",\"sort\",\"percent\",\"intro\"]', '1:基础', '', '', '', '', 'title:标题\r\ntype|get_name_by_status:问题类型\r\nwait_time:时间间隔\r\npercent:抢中概率\r\nanswer:正确答案\r\nsort:排序号\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'title', '', '1396061373', '1421749210', '1', 'MyISAM', 'Ask');
INSERT INTO `wp_model` VALUES ('1183', 'business_card', '微名片', '0', '', '1', '[\"truename\",\"mobile\",\"company\",\"service\",\"position\",\"department\",\"company_url\",\"address\",\"telephone\",\"Email\",\"wechat\",\"qq\",\"weibo\",\"tag\",\"wishing\",\"interest\",\"personal_url\",\"intro\",\"permission\",\"token\"]', '1:基础', '', '', '', '', 'uid:用户ID\r\ntruename:名称\r\nposition:职位\r\naddress:地址\r\nmobile:电话\r\ncompany:公司\r\nqq:QQ号\r\nwechat:微信号\r\nemail:邮箱\r\nqrcode:二维码\r\nids:操作:[EDIT]|编辑', '10', 'truename:请输入名称搜索', '', '1438931238', '1439291025', '1', 'MyISAM', 'BusinessCard');
INSERT INTO `wp_model` VALUES ('1184', 'business_card_collect', '名片收藏', '0', '', '1', '', '1:基础', '', '', '', '', '', '10', '', '', '1439188441', '1439188441', '1', 'MyISAM', 'BusinessCard');
INSERT INTO `wp_model` VALUES ('1185', 'business_card_column', '名片栏目', '0', '', '1', '[\"type\",\"cate_id\",\"title\",\"url\",\"sort\"]', '1:基础', '', '', '', '', 'type|get_name_by_status:栏目类型\r\ncate_id:分类名\r\ntitle:标题\r\nurl:url\r\nsort:排序\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', '10', '', '', '1441511425', '1441782615', '1', 'MyISAM', 'BusinessCard');
INSERT INTO `wp_model` VALUES ('1186', 'invite', '微邀约', '0', '', '1', '[\"keyword\",\"keyword_type\",\"title\",\"intro\",\"cover\",\"experience\",\"num\",\"coupon_id\",\"content\",\"template\"]', '1:基础', '', '', '', '', 'keyword:关键词\r\ntitle:标题\r\nexperience:消耗经验值\r\ncoupon_id:优惠券编号\r\ncoupon_name:优惠券标题\r\nids:操作:[EDIT]|编辑,[DELETE]|删除,lists?target_id=[coupon_id]&target=_blank&_addons=Coupon&_controller=Sn|领取记录,preview?id=[id]&target=_blank|预览', '20', 'title', '', '1396061373', '1437448319', '1', 'MyISAM', 'Invite');
INSERT INTO `wp_model` VALUES ('1187', 'invite_user', '微邀约用户记录', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1418192328', '1418192328', '1', 'MyISAM', 'Invite');
INSERT INTO `wp_model` VALUES ('1188', 'tongji', '运营统计', '0', '', '1', '{\"1\":[\"month\",\"day\",\"content\"]}', '1:基础', '', '', '', '', 'day:日期', '10', 'day', '', '1401371050', '1401371409', '1', 'MyISAM', 'Tongji');
INSERT INTO `wp_model` VALUES ('1189', 'test', '测试问卷', '0', '', '1', '[\"keyword\",\"keyword_type\",\"title\",\"intro\",\"cover\",\"finish_tip\"]', '1:基础', '', '', '', '', 'keyword:关键词\r\nkeyword_type|get_name_by_status:关键词匹配类型\r\ntitle:问卷标题\r\nid:操作:[EDIT]|编辑,[DELETE]|删除,test_question&target=_blank&id=[id]|题目管理,test_answer&target=_blank&id=[id]|用户记录,preview&target=_blank&id=[id]|问卷预览', '10', 'title', '', '1396061373', '1448248071', '1', 'MyISAM', 'Test');
INSERT INTO `wp_model` VALUES ('1173', 'coupon_shop', '适用门店', '0', '', '1', '[\"name\",\"address\",\"gps\",\"phone\"]', '1:基础', '', '', '', '', 'name:店名\r\nphone:联系电话\r\naddress:详细地址\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'name:店名搜索', '', '1427164604', '1439465222', '1', 'MyISAM', 'Coupon');
INSERT INTO `wp_model` VALUES ('1174', 'coupon_shop_link', '门店关联', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1427356350', '1427356350', '1', 'MyISAM', 'Coupon');
INSERT INTO `wp_model` VALUES ('1175', 'guess', '竞猜', '0', '', '1', '[\"title\",\"desc\",\"start_time\",\"end_time\",\"template\",\"cover\"]', '1:基础', '', '', '', '', 'title:活动名称\r\nstart_time|time_format:开始时间\r\nend_time|time_format:结束时间\r\nguess_count:参与人数\r\nids:操作:[EDIT]|编辑,[DELETE]|删除,guessOption&guess_id=[id]&target=_blank|竞猜选项,guessLog&guess_id=[id]&target=_blank|竞猜记录,preview?id=[id]&target=_blank|预览', '20', 'title:活动名称', '', '1428654951', '1437450636', '1', 'MyISAM', 'Guess');
INSERT INTO `wp_model` VALUES ('1176', 'guess_log', '竞猜记录', '0', '', '1', '[\"token\"]', '1:基础', '', '', '', '', 'optionIds:竞猜选项\r\nuser_id:用户id\r\nuser_name:用户昵称\r\ntoken:用户token\r\ncTime|time_format:竞猜时间\r\n', '20', '', '', '1428738271', '1430374436', '1', 'MyISAM', 'Guess');
INSERT INTO `wp_model` VALUES ('176', 'update_score_log', '修改积分记录', '0', '', '1', '', '1:基础', null, '', '', '', null, '10', '', '', '1444302325', '1444302325', '1', 'MyISAM', 'Core');
INSERT INTO `wp_model` VALUES ('1171', 'forms_value', '通用表单数据', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1396687959', '1396687959', '1', 'MyISAM', 'Forms');
INSERT INTO `wp_model` VALUES ('1172', 'coupon', '优惠券', '0', '', '1', '[\"title\",\"cover\",\"use_tips\",\"start_time\",\"start_tips\",\"end_time\",\"end_tips\",\"end_img\",\"num\",\"max_num\",\"over_time\",\"empty_prize_tips\",\"pay_password\",\"background\",\"more_button\",\"use_start_time\",\"shop_name\",\"shop_logo\",\"head_bg_color\",\"button_color\",\"template\",\"member\"]', '1:基础', '', '', '', '', 'id:优惠券编号\r\ntitle:标题\r\nnum:计划发送数\r\ncollect_count:已领取数\r\nuse_count:已使用数\r\nstart_time|time_format:开始时间\r\nend_time|time_format:结束时间\r\nids:操作:[EDIT]|编辑,[DELETE]|删除,lists?target_id=[id]&target=_blank&_controller=Sn|成员管理,preview?id=[id]&target=_blank|预览', '20', 'title', '', '1396061373', '1447756274', '1', 'MyISAM', 'Coupon');
INSERT INTO `wp_model` VALUES ('1170', 'forms_attribute', '表单字段', '0', '', '1', '[\"name\",\"title\",\"type\",\"extra\",\"value\",\"remark\",\"is_must\",\"validate_rule\",\"error_info\",\"sort\"]', '1:基础', '', '', '', '', 'title:字段标题\r\nname:字段名\r\ntype|get_name_by_status:字段类型\r\nids:操作:[EDIT]&forms_id=[forms_id]|编辑,[DELETE]|删除', '20', 'title', '', '1396061373', '1396710959', '1', 'MyISAM', 'Forms');
INSERT INTO `wp_model` VALUES ('1166', 'lottery_games_award_link', '抽奖游戏奖品设置', '0', '', '1', '', '1:基础', '', '', '', '', '', '10', '', '', '1444900969', '1444900969', '1', 'MyISAM', 'Draw');
INSERT INTO `wp_model` VALUES ('1167', 'draw_follow_log', '粉丝抽奖记录', '0', '', '1', '[\"follow_id\",\"sports_id\",\"count\",\"cTime\"]', '1:基础', '', '', '', '', '', '20', '', '', '1432619171', '1432719012', '1', 'MyISAM', 'Draw');
INSERT INTO `wp_model` VALUES ('1168', 'extensions', '融合第三方', '0', '', '1', '', '1:基础', '', '', '', '', 'keyword:关键词\r\nkeyword_filter|get_name_by_status:关键词过滤\r\noutput_format|get_name_by_status:数据输出格式\r\napi_url:第三方地址\r\napi_token:Token\r\ncTime|time_format:增加时间\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', '10', 'keyword', '', '1393911774', '1394267850', '1', 'MyISAM', 'Extensions');
INSERT INTO `wp_model` VALUES ('1169', 'forms', '通用表单', '0', '', '1', '[\"keyword\",\"keyword_type\",\"title\",\"intro\",\"cover\",\"can_edit\",\"finish_tip\",\"jump_url\",\"content\",\"template\"]', '1:基础', '', '', '', '', 'id:通用表单ID\r\nkeyword:关键词\r\nkeyword_type|get_name_by_status:关键词类型\r\ntitle:标题\r\ncTime|time_format:发布时间\r\nids:操作:[EDIT]|编辑,[DELETE]|删除,forms_attribute&id=[id]|字段管理,forms_value&id=[id]|数据管理,preview&id=[id]|预览', '20', 'title', '', '1396061373', '1437450012', '1', 'MyISAM', 'Forms');
INSERT INTO `wp_model` VALUES ('1143', 'custom_reply_mult', '多图文配置', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1396602475', '1396602475', '1', 'MyISAM', 'CustomReply');
INSERT INTO `wp_model` VALUES ('1144', 'custom_reply_news', '图文回复', '0', '', '1', '[\"keyword\",\"keyword_type\",\"title\",\"intro\",\"cate_id\",\"cover\",\"content\",\"sort\"]', '1:基础', '', '', '', '', 'id:5%ID\r\nkeyword:10%关键词\r\nkeyword_type|get_name_by_status:20%关键词类型\r\ntitle:30%标题\r\ncate_id:10%所属分类\r\nsort:7%排序号\r\nview_count:8%浏览数\r\nid:10%操作:[EDIT]|编辑,[DELETE]|删除', '20', 'title', '', '1396061373', '1401368247', '1', 'MyISAM', 'CustomReply');
INSERT INTO `wp_model` VALUES ('1145', 'custom_reply_text', '文本回复', '0', '', '1', '[\"keyword\",\"keyword_type\",\"content\",\"sort\"]', '1:基础', '', '', '', '', 'id:ID\r\nkeyword:关键词\r\nkeyword_type|get_name_by_status:关键词类型\r\nsort:排序号\r\nview_count:浏览数\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'keyword', '', '1396578172', '1401017369', '1', 'MyISAM', 'CustomReply');
INSERT INTO `wp_model` VALUES ('1147', 'auto_reply', '自动回复', '0', '', '1', '[\"keyword\",\"content\",\"group_id\",\"image_id\"]', '1:基础', '', '', '', '', 'keyword:关键词\r\ncontent:文件内容\r\ngroup_id:图文\r\nimage_id:图片\r\nids:操作:[EDIT]&type=[msg_type]|编辑,[DELETE]|删除', '10', 'keyword:请输入关键词', '', '1439194522', '1439258843', '1', 'MyISAM', 'AutoReply');
INSERT INTO `wp_model` VALUES ('1148', 'weisite_category', '微官网分类', '0', '', '1', '[\"title\",\"icon\",\"url\",\"is_show\",\"sort\",\"pid\"]', '1:基础', '', '', '', '', 'title:15%分类标题\r\nicon|get_img_html:分类图片\r\nurl:30%外链\r\nsort:10%排序号\r\npid:10%一级目录\r\nis_show|get_name_by_status:10%显示\r\nid:10%操作:[EDIT]|编辑,[DELETE]|删除', '20', 'title', '', '1395987942', '1439522869', '1', 'MyISAM', 'WeiSite');
INSERT INTO `wp_model` VALUES ('1149', 'weisite_cms', '文章管理', '0', '', '1', '[\"keyword\",\"keyword_type\",\"title\",\"intro\",\"cate_id\",\"cover\",\"content\",\"sort\"]', '1:基础', '', '', '', '', 'keyword:关键词\r\nkeyword_type|get_name_by_status:关键词类型\r\ntitle:标题\r\ncate_id:所属分类\r\nsort:排序号\r\nview_count:浏览数\r\nids:操作:[EDIT]&module_id=[pid]|编辑,[DELETE]|删除', '20', 'title', '', '1396061373', '1408326292', '1', 'MyISAM', 'WeiSite');
INSERT INTO `wp_model` VALUES ('1150', 'weisite_footer', '底部导航', '0', '', '1', '[\"pid\",\"title\",\"url\",\"sort\"]', '1:基础', '', '', '', '', 'title:菜单名\r\nicon:图标\r\nurl:关联URL\r\nsort:排序号\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'title', '', '1394518309', '1396507698', '1', 'MyISAM', 'WeiSite');
INSERT INTO `wp_model` VALUES ('1151', 'weisite_slideshow', '幻灯片', '0', '', '1', '[\"title\",\"img\",\"url\",\"is_show\",\"sort\"]', '1:基础', '', '', '', '', 'title:标题\r\nimg:图片\r\nurl:链接地址\r\nis_show|get_name_by_status:显示\r\nsort:排序\r\nids:操作:[EDIT]&module_id=[pid]|编辑,[DELETE]|删除', '20', 'title', '', '1396098264', '1408323347', '1', 'MyISAM', 'WeiSite');
INSERT INTO `wp_model` VALUES ('1152', 'exam', '考试试卷', '0', '', '1', '[\"keyword\",\"keyword_type\",\"title\",\"intro\",\"cover\",\"finish_tip\"]', '1:基础', '', '', '', '', 'keyword:关键词\r\nkeyword_type|get_name_by_status:关键词匹配类型\r\ntitle:试卷标题\r\nstart_time|time_format:开始时间\r\nend_time|time_format:结束时间\r\nid:操作:[EDIT]|编辑,[DELETE]|删除,exam_question&target=_blank&id=[id]|题目管理,exam_answer&target=_blank&id=[id]|考生成绩,preview&id=[id]&target=_blank|试卷预览', '10', 'title:请输入试卷标题搜索', '', '1396061373', '1447755312', '1', 'MyISAM', 'Exam');
INSERT INTO `wp_model` VALUES ('1153', 'exam_question', '考试题目', '0', '', '1', '{\"1\":[\"title\",\"type\",\"extra\",\"intro\",\"is_must\",\"sort\"]}', '1:基础', '', '', '', '', 'title:标题\r\ntype|get_name_by_status:题目类型\r\nscore:分值\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', '10', 'title', '', '1396061373', '1397035409', '1', 'MyISAM', 'Exam');
INSERT INTO `wp_model` VALUES ('1154', 'exam_answer', '考试回答', '0', '', '1', '', '1:基础', '', '', '', '', 'openid:OpenId\r\ntruename:姓名\r\nmobile:手机号\r\nscore:成绩\r\ncTime|time_format:考试时间\r\nid:操作:detail?uid=[uid]&exam_id=[exam_id]|答题详情', '10', 'title', '', '1396061373', '1397036455', '1', 'MyISAM', 'Exam');
INSERT INTO `wp_model` VALUES ('1155', 'draw_follow_log', '粉丝抽奖记录', '0', '', '1', '[\"follow_id\",\"sports_id\",\"count\",\"cTime\"]', '1:基础', '', '', '', '', '', '20', '', '', '1432619171', '1432719012', '1', 'MyISAM', 'Draw');
INSERT INTO `wp_model` VALUES ('1156', 'lottery_prize_list', '抽奖奖品列表', '0', '', '1', '[\"sports_id\",\"award_id\",\"award_num\"]', '1:基础', '', '', '', '', 'sports_id:比赛场次\r\naward_id:奖品名称\r\naward_num:奖品数量\r\nid:编辑:[EDIT]|编辑,[DELETE]|删除,add?sports_id=[sports_id]|添加', '20', '', '', '1432613700', '1432710817', '1', 'MyISAM', 'Draw');
INSERT INTO `wp_model` VALUES ('1157', 'lucky_follow', '中奖者信息', '0', '', '1', '[\"draw_id\",\"sport_id\",\"award_id\",\"follow_id\",\"address\",\"num\",\"state\",\"zjtime\",\"djtime\"]', '1:基础', '', '', '', '', 'nickname|deal_emoji:8%微信昵称\r\narea:6%地区\r\nmobile:12%手机号\r\ntruename:7%姓名\r\naddress:6%地址\r\naward_id:10%中奖奖品\r\nnum:5%数量\r\nsport_id:9%中奖场次\r\nzjtime|time_format:8%中奖时间\r\nstate|get_name_by_status:6%兑奖状态\r\ndjtime|time_format:9%兑奖时间\r\ndrum_count:7%擂鼓次数\r\nid:8%中奖人其他信息:luckyFollowDetail?id=[id]|查看\r\n\r\n\r\n', '20', 'award_id:输入奖品名称', '', '1432618091', '1435031703', '1', 'MyISAM', 'Draw');
INSERT INTO `wp_model` VALUES ('1158', 'lzwg_activities', '靓妆活动', '0', '', '1', '[\"title\",\"remark\",\"logo_img\",\"start_time\",\"end_time\",\"get_prize_tip\",\"no_prize_tip\",\"lottery_number\",\"get_prize_count\",\"comment_status\"]', '1:基础', '', '', '', '', 'title:活动名称\r\nremark:活动描述\r\nlogo_img|get_img_html:活动LOGO\r\nactivitie_time:活动时间\r\nget_prize_tip:中将提示信息\r\nno_prize_tip:未中将提示信息\r\ncomment_list:评论列表\r\nset_vote:设置投票\r\nset_award:设置奖品\r\nget_prize_list:中奖列表\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', '', '', '1435306468', '1436181872', '1', 'MyISAM', 'Draw');
INSERT INTO `wp_model` VALUES ('1159', 'lzwg_activities_vote', '投票答题活动', '0', '', '1', '[\"lzwg_id\",\"vote_type\",\"vote_limit\",\"lzwg_type\",\"vote_id\"]', '1:基础', '', '', '', '', 'lzwg_name:活动名称\r\nstart_time|time_format:活动开始时间\r\nend_time|time_format:活动结束时间\r\nlzwg_type|get_name_by_status:活动类型\r\nvote_title:题目\r\nids:操作:[EDIT]|编辑,[DELETE]|删除,tongji&id=[id]|用户参与分析\r\n', '20', 'lzwg_id:活动名称', '', '1435734819', '1435825972', '1', 'MyISAM', 'Draw');
INSERT INTO `wp_model` VALUES ('1160', 'sport_award', '抽奖奖品', '0', '', '1', '[\"award_type\",\"name\",\"count\",\"img\",\"price\",\"score\",\"explain\"]', '1:基础', '', '', '', '', 'id:6%编号\r\nname:23%奖项名称\r\nimg|get_img_html:8%商品图片\r\nprice:8%商品价格\r\nexplain:24%奖品说明\r\ncount:8%奖品数量\r\nid:20%操作:[EDIT]|编辑,[DELETE]|删除,getlistByAwardId?awardId=[id]&_controller=LuckyFollow|中奖者列表', '20', 'name:请输入抽奖名称', '', '1432607100', '1433312389', '1', 'MyISAM', 'Draw');
INSERT INTO `wp_model` VALUES ('1161', 'sports', '体育赛事', '0', '', '1', '[\"home_team\",\"visit_team\",\"start_time\",\"score\",\"content\",\"countdown\",\"comment_status\"]', '1:基础', '', '', '', '', 'start_time|time_format:20%比赛场次\r\nvs_team:20%对战球队（主场VS客场）\r\nscore_title:8%比分\r\ncontent|lists_msubstr:27%对战球队的介绍\r\nids:23%操作:add?sports_id=[id]&_controller=LotteryPrizeList&_addons=Draw&target=_blank|奖品配置,lists?sports_id=[id]&_addons=Draw&_controller=LuckyFollow&target=_blank|中奖列表,lists?sports_id=[id]&_addons=Comment&_controller=Comment&target=_blank|评论列表,package?id=[id]&_controller=Sucai&_addons=Sucai&source=Sports&is_preview=1&target=_blank|预览,package?id=[id]&_controller=Sucai&_addons=Sucai&source=Sports&is_download=1&target=_blank|下载素材,[EDIT]|编辑,[DELETE]|删除', '20', 'home_team:请输入球队名', '', '1432556238', '1436173617', '1', 'MyISAM', 'Draw');
INSERT INTO `wp_model` VALUES ('1162', 'sports_drum', '擂鼓记录', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1432642253', '1432642253', '1', 'MyISAM', 'Draw');
INSERT INTO `wp_model` VALUES ('1163', 'sports_support', '球队支持记录', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1432635084', '1432635084', '1', 'MyISAM', 'Draw');
INSERT INTO `wp_model` VALUES ('1164', 'sports_team', '比赛球队', '0', '', '1', '[\"title\",\"logo\",\"intro\"]', '1:基础', '', '', '', '', 'logo|get_img_html:球队图标\r\ntitle:球队名称\r\nintro|lists_msubstr:球队说明\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'title:请输入球队名', '', '1432556797', '1432886417', '1', 'MyISAM', 'Draw');
INSERT INTO `wp_model` VALUES ('1198', 'shop_collect', '商品收藏', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1423471275', '1423471275', '1', 'MyISAM', null);
INSERT INTO `wp_model` VALUES ('1199', 'shop_cart', '购物车', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1419577864', '1419577864', '1', 'MyISAM', null);
INSERT INTO `wp_model` VALUES ('1216', 'youaskservice_wechat_enddate', 'youaskservice_wechat_enddate', '0', '', '1', '', '1:基础', '', '', '', '', '', '20', '', '', '1404026714', '1404026714', '1', 'MyISAM', 'YouaskService');
INSERT INTO `wp_model` VALUES ('1191', 'test_answer', '测试回答', '0', '', '1', '', '1:基础', '', '', '', '', 'openid:OpenId\r\ntruename:姓名\r\nmobile:手机号\r\nscore:得分\r\ncTime|time_format:测试时间\r\nid:操作:detail?uid=[uid]&test_id=[test_id]|答题详情', '10', 'title', '', '1396061373', '1397145984', '1', 'MyISAM', 'Test');
INSERT INTO `wp_model` VALUES ('1165', 'lottery_games', '抽奖游戏', '0', '', '1', '[\"title\",\"keyword\",\"game_type\",\"start_time\",\"end_time\",\"status\",\"day_attend_limit\",\"attend_limit\",\"day_win_limit\",\"win_limit\",\"day_winners_count\",\"remark\"]', '1:基础', '', '', '', '', 'id:序号\r\ntitle:活动名称\r\ngame_type|get_name_by_status:游戏类型\r\nkeyword:关键词\r\nstart_time|time_format:开始时间\r\nend_time|time_format:结束时间\r\nstatus:活动状态\r\nattend_num:参与人数\r\nwinners_list:中奖人列表\r\nids:操作:[EDIT]|编辑,[DELETE]|删除,preview&games_id=[id]|预览,index&_addons=Draw&_controller=Wap&games_id=[id]|复制链接', '10', '', '', '1444877287', '1445482517', '1', 'MyISAM', 'Draw');
INSERT INTO `wp_model` VALUES ('1195', 'survey_question', '调研问题', '0', '', '1', '[\"title\",\"type\",\"extra\",\"intro\",\"is_must\",\"sort\"]', '1:基础', '', '', '', '', 'title:标题\r\ntype|get_name_by_status:问题类型\r\nis_must|get_name_by_status:是否必填\r\nids:操作:[EDIT]|编辑,[DELETE]|删除', '20', 'title', '', '1396061373', '1396955090', '1', 'MyISAM', 'Survey');
INSERT INTO `wp_model` VALUES ('1142', 'custom_menu', '自定义菜单', '0', '', '1', '[\"pid\",\"title\",\"from_type\",\"type\",\"jump_type\",\"addon\",\"sucai_type\",\"keyword\",\"url\",\"sort\"]', '1:基础', '', '', '', '', 'title:10%菜单名\r\nkeyword:10%关联关键词\r\nurl:50%关联URL\r\nsort:5%排序号\r\nid:10%操作:[EDIT]|编辑,[DELETE]|删除', '20', 'title', '', '1394518309', '1447317015', '1', 'MyISAM', 'CustomMenu');
INSERT INTO `wp_model` VALUES ('1238', 'weisite_category', '微官网分类', '0', '', '1', '{\"1\":[\"title\",\"icon\",\"url\",\"is_show\"]}', '1:基础', '', '', '', '', 'title:分类标题\r\nicon:分类图片\r\nurl:外链\r\nsort:排序号\r\nis_show|get_name_by_status:显示\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', '10', 'title', '', '1395987942', '1396340374', '1', 'MyISAM', null);
INSERT INTO `wp_model` VALUES ('1239', 'weisite_slideshow', '幻灯片', '0', '', '1', '{\"1\":[\"title\",\"img\",\"url\",\"is_show\",\"sort\"]}', '1:基础', '', '', '', '', 'title:标题\r\nimg:图片\r\nurl:链接地址\r\nis_show|get_name_by_status:显示\r\nsort:排序\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', '10', 'title', '', '1396098264', '1396099200', '1', 'MyISAM', null);
INSERT INTO `wp_model` VALUES ('1240', 'weisite_footer', '底部导航', '0', '', '1', '{\"1\":[\"pid\",\"title\",\"url\",\"sort\"]}', '1:基础', '', '', '', '', 'title:菜单名\r\nicon:图标\r\nurl:关联URL\r\nsort:排序号\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', '10', 'title', '', '1394518309', '1396507698', '1', 'MyISAM', null);

-- ----------------------------
-- Table structure for wp_notify
-- ----------------------------
DROP TABLE IF EXISTS `wp_notify`;
CREATE TABLE `wp_notify` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `test` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_notify
-- ----------------------------

-- ----------------------------
-- Table structure for wp_online_count
-- ----------------------------
DROP TABLE IF EXISTS `wp_online_count`;
CREATE TABLE `wp_online_count` (
  `publicid` int(11) DEFAULT NULL,
  `addon` varchar(30) DEFAULT NULL,
  `aim_id` int(11) DEFAULT NULL,
  `time` bigint(12) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  KEY `tc` (`time`,`count`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_online_count
-- ----------------------------

-- ----------------------------
-- Table structure for wp_payment_order
-- ----------------------------
DROP TABLE IF EXISTS `wp_payment_order`;
CREATE TABLE `wp_payment_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `from` varchar(50) NOT NULL COMMENT '回调地址',
  `orderName` varchar(255) DEFAULT NULL COMMENT '订单名称',
  `single_orderid` varchar(100) NOT NULL COMMENT '订单号',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `token` varchar(100) NOT NULL COMMENT 'Token',
  `wecha_id` varchar(200) NOT NULL COMMENT 'OpenID',
  `paytype` varchar(30) NOT NULL COMMENT '支付方式',
  `showwxpaytitle` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否显示标题',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '支付状态',
  `uid` int(10) DEFAULT NULL COMMENT '用户uid',
  `aim_id` int(10) DEFAULT NULL COMMENT 'aim_id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_payment_order
-- ----------------------------
INSERT INTO `wp_payment_order` VALUES ('1', 'Payment:__Payment_playok', '%E6%B5%8B%E8%AF%95%E5%95%86%E5%93%81', '20160322155101f9659fcd4', '1.00', '3123', '-1', 'Weixin', '1', '0', '1', null);
INSERT INTO `wp_payment_order` VALUES ('2', 'Payment:__Payment_playok', '%E6%B5%8B%E8%AF%95%E5%95%86%E5%93%81', '2016032216482306d7ae6b6', '1.00', '-1', '-1', 'Weixin', '1', '0', '1', null);
INSERT INTO `wp_payment_order` VALUES ('3', 'Payment:__Payment_playok', '%E6%B5%8B%E8%AF%95%E5%95%86%E5%93%81', '201604130848039743256be', '1.00', '3123', '-1', 'Weixin', '1', '0', '1', null);
INSERT INTO `wp_payment_order` VALUES ('4', 'Payment:__Payment_playok', '%E6%B5%8B%E8%AF%95%E5%95%86%E5%93%81', '201604151110355bab447d3', '1.00', '3123', '-1', 'Weixin', '1', '0', '1', null);
INSERT INTO `wp_payment_order` VALUES ('5', 'Payment:__Payment_playok', '%E6%B5%8B%E8%AF%95%E5%95%86%E5%93%81', '201604181016394387b7ddb', '1.00', '3123', '-1', 'Weixin', '1', '0', '1', null);
INSERT INTO `wp_payment_order` VALUES ('6', 'http://www.lao337.com/pay/weixin', '%E6%B5%8B%E8%AF%95%E5%95%86%E5%93%81', '20160421154455599332', '1.00', '123456', '45', '0', '1', '0', null, null);
INSERT INTO `wp_payment_order` VALUES ('7', 'http://www.lao337.com/pay/weixin', '%E6%B5%8B%E8%AF%95%E5%95%86%E5%93%81', '20160421155002417958', '1.00', '123456', '45', '0', '1', '0', null, null);
INSERT INTO `wp_payment_order` VALUES ('8', 'http://www.lao337.com/pay/weixin', '%E6%B5%8B%E8%AF%95%E5%95%86%E5%93%81', '201604211637219141723cd', '1.00', '123456', '45', '0', '1', '0', null, null);
INSERT INTO `wp_payment_order` VALUES ('9', 'Payment:__Payment_playok', '%E6%B5%8B%E8%AF%95%E5%95%86%E5%93%81', '2016042117141499e663f92', '1.00', '3123', '-1', 'Weixin', '1', '0', '1', null);
INSERT INTO `wp_payment_order` VALUES ('10', 'http%3A%2F%2Fwww.lao337.com%2Fpay%2Fweixin', '%E6%B5%8B%E8%AF%95%E5%95%86%E5%93%81', '20160421171849704181', '1.00', '123456', '45', '0', '1', '0', null, null);
INSERT INTO `wp_payment_order` VALUES ('11', 'http%3A%2F%2Fwww.lao337.com%2Fpay%2Fweixin', '%E6%B5%8B%E8%AF%95%E5%95%86%E5%93%81', '20160422093486542658', '1.00', '123456', 'o1teys0U4AM_Ex-buqh9BJhJHIjw', '0', '1', '0', null, null);
INSERT INTO `wp_payment_order` VALUES ('12', 'Payment:__Payment_playok', '%E6%B5%8B%E8%AF%95%E4%B8%8B%E4%B8%8B', '20160426114933e54d7fb74', '1.00', '3123', '-1', 'Weixin', '1', '0', '1', null);
INSERT INTO `wp_payment_order` VALUES ('13', 'Payment:__Payment_playok', '%E6%B5%8B%E8%AF%95%E4%B8%8B%E4%B8%8B', '20160426151944169075c7e', '1.00', '3123', '-1', 'Weixin', '1', '0', '1', null);
INSERT INTO `wp_payment_order` VALUES ('14', 'Payment:__Payment_playok', '%E6%B5%8B%E8%AF%95%E4%B8%8B%E4%B8%8B', '201604261622412551a42d9', '1.00', '3123', '-1', 'Weixin', '1', '0', '1', null);
INSERT INTO `wp_payment_order` VALUES ('15', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E7%81%B5%E8%8A%9D%E9%B8%A1%E8%9B%8B', '20160503162433344177', '0.01', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('16', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E7%81%B5%E8%8A%9D%E9%B8%A1%E8%9B%8B', '20160503162865738570', '0.01', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('17', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E7%81%B5%E8%8A%9D%E9%B8%A1%E8%9B%8B', '20160503163276726605', '0.01', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('18', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E8%8A%92%E6%9E%9C', '20160503164135807889', '0.01', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('19', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E7%81%B5%E8%8A%9D%E9%B8%A1%E8%9B%8B', '20160503165292917175', '0.01', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('20', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E7%81%B5%E8%8A%9D%E9%B8%A1%E8%9B%8B', '20160503161915331039', '0.01', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('21', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E7%81%B5%E8%8A%9D%E9%B8%A1%E8%9B%8B', '20160503161634280404', '0.01', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('22', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E8%8A%92%E6%9E%9C', '20160504100918704283', '1.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('23', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E8%8A%92%E6%9E%9C', '20160504102035698700', '1.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('24', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E8%8A%92%E6%9E%9C', '20160504103156746245', '1.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('25', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E7%81%B5%E8%8A%9D%E9%B8%A1%E8%9B%8B', '20160504103474271258', '0.01', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('26', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E7%81%B5%E8%8A%9D%E9%B8%A1%E8%9B%8B', '20160504103518704283', '0.01', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('27', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E8%8A%92%E6%9E%9C', '20160505161166642624', '1.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('28', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E8%8A%92%E6%9E%9C', '20160505162334280404', '1.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('29', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E8%8A%92%E6%9E%9C', '20160505164565738570', '1.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('30', 'http%3A%2F%2Flao337.nsfuu.com%2Fpay%2Fweixin', '%E8%8A%92%E6%9E%9C', '20160505170515694876', '1.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('31', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%87%8E%E7%94%9F%E5%85%9A%E5%8F%82+%E5%9C%9F%E5%85%9A%E5%8F%82+%E4%B8%80%E6%89%8E%E5%9D%87%E9%87%8D%E7%BA%A61%E6%96%A4+20%E5%85%83%2F%E6%89%8E', '20160517124543369594', '20.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '0', null, null);
INSERT INTO `wp_payment_order` VALUES ('32', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%87%8E%E7%94%9F%E5%85%9A%E5%8F%82+%E5%9C%9F%E5%85%9A%E5%8F%82+%E4%B8%80%E6%89%8E%E5%9D%87%E9%87%8D%E7%BA%A61%E6%96%A4+20%E5%85%83%2F%E6%89%8E', '20160517125402716045', '20.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('33', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E7%BA%A2%E7%81%AF%E6%A8%B1%E6%A1%83+%E5%B1%B1%E4%B8%9C%E4%B8%80%E7%BA%A7%E6%A8%B1%E6%A1%83+%E5%85%A8%E7%A8%8B%E5%86%B7%E9%93%BE%E7%A9%BA%E8%BF%90135%E5%85%83%2F5%E6%96%A4', '20160517182515331039', '135.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys39jDjN56TGWhmKib6Awjek', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('34', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E7%BA%A2%E7%81%AF%E6%A8%B1%E6%A1%83+%E5%B1%B1%E4%B8%9C%E4%B8%80%E7%BA%A7%E6%A8%B1%E6%A1%83+%E5%85%A8%E7%A8%8B%E5%86%B7%E9%93%BE%E7%A9%BA%E8%BF%90135%E5%85%83%2F5%E6%96%A4', '20160517215553984005', '135.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys7tALk-MME7nA-xm97bmNz4', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('35', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E7%BA%A2%E7%81%AF%E6%A8%B1%E6%A1%83+%E5%B1%B1%E4%B8%9C%E4%B8%80%E7%BA%A7%E6%A8%B1%E6%A1%83+%E5%85%A8%E7%A8%8B%E5%86%B7%E9%93%BE%E7%A9%BA%E8%BF%90135%E5%85%83%2F5%E6%96%A4', '20160517222620013767', '135.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teysy_HdOBTKvdeMMDViaby4d4', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('36', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E7%BA%A2%E7%81%AF%E6%A8%B1%E6%A1%83+%E5%B1%B1%E4%B8%9C%E4%B8%80%E7%BA%A7%E6%A8%B1%E6%A1%83+%E5%85%A8%E7%A8%8B%E5%86%B7%E9%93%BE%E7%A9%BA%E8%BF%90135%E5%85%83%2F5%E6%96%A4', '20160517223791610150', '135.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teysy_HdOBTKvdeMMDViaby4d4', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('37', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%BB%84%E8%9C%9C%E6%A8%B1%E6%A1%83+%E5%B1%B1%E4%B8%9C%E4%B8%80%E7%BA%A7%E6%A8%B1%E6%A1%83+%E5%85%A8%E7%A8%8B%E5%86%B7%E9%93%BE%E7%A9%BA%E8%BF%90155%E5%85%83%2F5%E6%96%A4', '20160517233233344177', '155.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teysy_HdOBTKvdeMMDViaby4d4', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('38', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E7%BA%A2%E7%81%AF%E6%A8%B1%E6%A1%83+%E5%B1%B1%E4%B8%9C%E4%B8%80%E7%BA%A7%E6%A8%B1%E6%A1%83+%E5%85%A8%E7%A8%8B%E5%86%B7%E9%93%BE%E7%A9%BA%E8%BF%90135%E5%85%83%2F5%E6%96%A4', '20160519212578426291', '135.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys_KAj3bWXOvJsK4cLyvrwnQ', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('39', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%BB%84%E8%9C%9C%E6%A8%B1%E6%A1%83+%E5%B1%B1%E4%B8%9C%E4%B8%80%E7%BA%A7%E6%A8%B1%E6%A1%83+%E5%85%A8%E7%A8%8B%E5%86%B7%E9%93%BE%E7%A9%BA%E8%BF%90155%E5%85%83%2F5%E6%96%A4', '20160520124412557431', '155.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teysxlDFWiy_rC-XKu4cE_blUM', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('40', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E7%BA%A2%E7%81%AF%E6%A8%B1%E6%A1%83+%E5%B1%B1%E4%B8%9C%E4%B8%80%E7%BA%A7%E6%A8%B1%E6%A1%83+%E5%85%A8%E7%A8%8B%E5%86%B7%E9%93%BE%E7%A9%BA%E8%BF%90135%E5%85%83%2F5%E6%96%A4', '20160520142171394789', '135.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys-7KnJ2Yn0hyRz6w6zx32Qc', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('41', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1-%E9%A1%B9%E9%B8%A1+%E5%9D%87%E9%87%8D3%E6%96%A4+99%E5%85%83%2F%E5%8F%AA+%E4%B8%80%E5%8F%AA%E8%B5%B7%E9%80%81+%E5%8F%AF%E5%85%8D%E8%B4%B9%E6%9D%80%E5%A5%BD', '20160521162478426291', '99.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys6MbkbmRJ6DfshJCw8AMWmw', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('42', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%BB%84%E8%9C%9C%E6%A8%B1%E6%A1%83+%E5%B1%B1%E4%B8%9C%E4%B8%80%E7%BA%A7%E6%A8%B1%E6%A1%83+%E5%85%A8%E7%A8%8B%E5%86%B7%E9%93%BE%E7%A9%BA%E8%BF%90155%E5%85%83%2F5%E6%96%A4', '20160521164243611184', '155.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys6MbkbmRJ6DfshJCw8AMWmw', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('43', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E7%BA%A2%E7%81%AF%E6%A8%B1%E6%A1%83+%E5%B1%B1%E4%B8%9C%E4%B8%80%E7%BA%A7%E6%A8%B1%E6%A1%83+%E5%85%A8%E7%A8%8B%E5%86%B7%E9%93%BE%E7%A9%BA%E8%BF%90135%E5%85%83%2F5%E6%96%A4', '20160521192851814697', '135.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys_6ezIuNEUwpLrH7g0_boiE', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('44', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1%E8%9B%8B+%E8%81%AA%E6%98%8E%E8%9B%8B+%E7%BE%8E%E5%AE%B9%E8%9B%8B+10%E6%9E%9A%E8%A3%8525%E5%85%83', '20160526195276726605', '25.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8yfbfHOhCIXHgpTrV_IumU', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('45', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1-%E9%A1%B9%E9%B8%A1+%E5%9D%87%E9%87%8D3%E6%96%A4+99%E5%85%83%2F%E5%8F%AA+%E4%B8%80%E5%8F%AA%E8%B5%B7%E9%80%81+%E5%8F%AF%E5%85%8D%E8%B4%B9%E6%9D%80%E5%A5%BD', '20160527155144886591', '198.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teysxSSrfPUmb_WELwwDSalNQY', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('46', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1-%E9%A1%B9%E9%B8%A1+%E5%9D%87%E9%87%8D3%E6%96%A499%E5%85%83%2F%E5%8F%AA+%E5%8F%AF%E5%B8%AE%E6%9D%80%E5%A5%BD', '20160528094903752755', '144.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys7HBU9b78_Tr5PZps5G-5WQ', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('47', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1-%E9%A1%B9%E9%B8%A1+%E5%9D%87%E9%87%8D3%E6%96%A499%E5%85%83%2F%E5%8F%AA+%E5%8F%AF%E5%B8%AE%E6%9D%80%E5%A5%BD', '20160528210843611184', '297.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teysxSSrfPUmb_WELwwDSalNQY', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('48', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%BB%84%E8%9C%9C%E6%A8%B1%E6%A1%83+%E5%B1%B1%E4%B8%9C%E4%B8%80%E7%BA%A7%E6%A8%B1%E6%A1%83%E5%85%A8%E7%A8%8B%E5%86%B7%E9%93%BE%E7%A9%BA%E8%BF%90155%E5%85%83%2F5%E6%96%A4', '20160528221915694876', '155.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teysyjFEoTsZRRVprjExU6w4EE', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('49', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1-%E9%A1%B9%E9%B8%A1+%E5%9D%87%E9%87%8D3%E6%96%A499%E5%85%83%2F%E5%8F%AA+%E5%8F%AF%E5%B8%AE%E6%9D%80%E5%A5%BD', '20160530092043611184', '198.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys2974CfTGblkN_hHwur6_6c', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('50', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1-%E9%A1%B9%E9%B8%A1+%E5%9D%87%E9%87%8D3%E6%96%A499%E5%85%83%2F%E5%8F%AA+%E5%8F%AF%E5%B8%AE%E6%9D%80%E5%A5%BD', '20160530130486634339', '99.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys2974CfTGblkN_hHwur6_6c', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('51', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1-%E9%A1%B9%E9%B8%A1+%E5%9D%87%E9%87%8D3%E6%96%A499%E5%85%83%2F%E5%8F%AA+%E5%8F%AF%E5%B8%AE%E6%9D%80%E5%A5%BD', '20160530184651814697', '99.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys7HBU9b78_Tr5PZps5G-5WQ', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('52', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1-%E9%A1%B9%E9%B8%A1+%E5%9D%87%E9%87%8D3%E6%96%A499%E5%85%83%2F%E5%8F%AA+%E5%8F%AF%E5%B8%AE%E6%9D%80%E5%A5%BD', '20160603115812678982', '99.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8yfbfHOhCIXHgpTrV_IumU', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('53', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E6%B8%85%E6%B0%B4%E9%B8%AD%E6%AD%A3%E5%AE%97%E5%9C%9F%E9%B8%AD+%E5%9D%87%E9%87%8D4.5%7E5%E6%96%A4118%E5%85%83%2F%E5%8F%AA', '20160603145331585363', '118.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys6MbkbmRJ6DfshJCw8AMWmw', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('54', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1-%E9%A1%B9%E9%B8%A1+%E5%9D%87%E9%87%8D3%E6%96%A499%E5%85%83%2F%E5%8F%AA+%E5%8F%AF%E5%B8%AE%E6%9D%80%E5%A5%BD', '20160607132235698700', '693.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teysynlx0Cz1NwrKIoNDHFIjXQ', '0', '1', '0', null, null);
INSERT INTO `wp_payment_order` VALUES ('55', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1-%E9%A1%B9%E9%B8%A1+%E5%9D%87%E9%87%8D3%E6%96%A499%E5%85%83%2F%E5%8F%AA+%E5%8F%AF%E5%B8%AE%E6%9D%80%E5%A5%BD', '20160608121712186261', '99.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys_TnbMJ08GlKeTruOaIdkgA', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('56', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1-%E9%A1%B9%E9%B8%A1+%E5%9D%87%E9%87%8D3%E6%96%A499%E5%85%83%2F%E5%8F%AA+%E5%8F%AF%E5%B8%AE%E6%9D%80%E5%A5%BD', '20160609161165738570', '217.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys_65crDgTKTG3dN4NoZBlBE', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('57', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E6%B8%85%E6%B0%B4%E9%B8%AD%E6%AD%A3%E5%AE%97%E5%9C%9F%E9%B8%AD+%E5%9D%87%E9%87%8D4.5%7E5%E6%96%A4118%E5%85%83%2F%E5%8F%AA', '20160616103691610150', '118.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys_65crDgTKTG3dN4NoZBlBE', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('58', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E5%B0%8F%E9%87%91%E7%85%8C%E8%8A%92%E6%9E%9C+%E6%99%AE%E9%80%9A10%E6%96%A4%E8%A3%85%E7%94%B0%E4%B8%9C%E8%8A%92%E6%9E%9C66%E5%85%83%E5%8C%85%E9%82%AE', '20160621103086135475', '66.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('59', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E6%AD%A3%E5%AE%97%E9%87%8E%E7%94%9F%E8%9C%82%E8%9C%9C+%E5%B2%91%E7%8E%8B%E8%80%81%E5%B1%B1%E5%8E%9F%E5%A7%8B%E6%A3%AE%E6%9E%97%E7%99%BE%E8%8A%B1%E8%9C%9C79%E5%85%83%2F%E6%96%A4', '20160622230403035417', '158.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys2-EY3G0TPDPALNveLoeKFY', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('60', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E5%B0%8F%E9%87%91%E7%85%8C%E8%8A%92%E6%9E%9C+10%E6%96%A4%E7%B2%BE%E8%A3%85%E7%99%BE%E8%89%B2%E7%94%B0%E4%B8%9C%E8%8A%92%E6%9E%9C76%E5%85%83%E5%8C%85%E9%82%AE', '20160623183883571477', '76.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys1RcnZoDK3AMPSkidL8UvNU', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('61', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E6%AD%A3%E5%AE%97%E9%87%8E%E7%94%9F%E8%9C%82%E8%9C%9C+%E5%B2%91%E7%8E%8B%E8%80%81%E5%B1%B1%E5%8E%9F%E5%A7%8B%E6%A3%AE%E6%9E%97%E7%99%BE%E8%8A%B1%E8%9C%9C79%E5%85%83%2F%E6%96%A4', '20160624200688705148', '158.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys1hJM4kKnk4ts3Zd_TQVl5A', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('62', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E5%A4%A7%E9%87%91%E7%85%8C%E8%8A%92%E6%9E%9C+10%E6%96%A4%E7%B2%BE%E8%A3%85%E7%94%B0%E4%B8%9C%E8%8A%92%E6%9E%9C80%E5%85%83%E5%85%A8%E5%9B%BD%E5%8C%85%E9%82%AE', '20160625114124967108', '80.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teysyEa4ZLo9kQTJ6WJQT5Dkik', '0', '1', '0', null, null);
INSERT INTO `wp_payment_order` VALUES ('63', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E5%A4%A7%E9%87%91%E7%85%8C%E8%8A%92%E6%9E%9C+10%E6%96%A4%E7%B2%BE%E8%A3%85%E7%94%B0%E4%B8%9C%E8%8A%92%E6%9E%9C80%E5%85%83%E5%85%A8%E5%9B%BD%E5%8C%85%E9%82%AE', '20160625114255355124', '80.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teysyEa4ZLo9kQTJ6WJQT5Dkik', '0', '1', '0', null, null);
INSERT INTO `wp_payment_order` VALUES ('64', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1-%E9%A1%B9%E9%B8%A1+%E5%9D%87%E9%87%8D3%E6%96%A499%E5%85%83%2F%E5%8F%AA+%E5%8F%AF%E5%B8%AE%E6%9D%80%E5%A5%BD', '20160626211859958578', '198.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8yfbfHOhCIXHgpTrV_IumU', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('65', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E6%AD%A3%E5%AE%97%E9%87%8E%E7%94%9F%E8%9C%82%E8%9C%9C+%E5%B2%91%E7%8E%8B%E8%80%81%E5%B1%B1%E5%8E%9F%E5%A7%8B%E6%A3%AE%E6%9E%97%E7%99%BE%E8%8A%B1%E8%9C%9C79%E5%85%83%2F%E6%96%A4', '20160701181933857627', '237.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys0DOh_5vUtHwRGwpw_OQ1qQ', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('66', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%AD%E6%AD%A3%E5%AE%97%E5%9C%9F%E9%B8%AD+%E5%9D%87%E9%87%8D4.5%7E5%E6%96%A4118%E5%85%83%2F%E5%8F%AA', '20160701200133857627', '118.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teysxSSrfPUmb_WELwwDSalNQY', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('67', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1-%E9%A1%B9%E9%B8%A1+%E5%9D%87%E9%87%8D3%E6%96%A499%E5%85%83%2F%E5%8F%AA+%E5%8F%AF%E5%B8%AE%E6%9D%80%E5%A5%BD', '20160703113832936508', '297.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teysxSSrfPUmb_WELwwDSalNQY', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('68', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E6%AD%A3%E5%AE%97%E9%87%8E%E7%94%9F%E8%9C%82%E8%9C%9C+%E5%B2%91%E7%8E%8B%E8%80%81%E5%B1%B1%E5%8E%9F%E5%A7%8B%E6%A3%AE%E6%9E%97%E7%99%BE%E8%8A%B1%E8%9C%9C79%E5%85%83%2F%E6%96%A4', '20160704172904955117', '158.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys9AsS4YBkYvA9wxKrBNTb3Y', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('69', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E5%8C%97%E6%B5%B7%E6%B5%B7%E9%B8%AD%E8%9B%8B+%E8%87%AA%E5%AE%B6%E7%86%9F%E5%92%B8%E7%83%A4%E6%B5%B7%E9%B8%AD%E8%9B%8B20%E6%9E%9A%E8%A3%8558%E5%85%83%E5%8C%85%E9%82%AE', '20160705180295654989', '58.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys2fjdJbcE--zaLdyFTJl2lg', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('70', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E6%AD%A3%E5%AE%97%E9%87%8E%E7%94%9F%E8%9C%82%E8%9C%9C+%E5%B2%91%E7%8E%8B%E8%80%81%E5%B1%B1%E5%8E%9F%E5%A7%8B%E6%A3%AE%E6%9E%97%E7%99%BE%E8%8A%B1%E8%9C%9C79%E5%85%83%2F%E6%96%A4', '20160707085184016079', '158.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys6Nhr6G85mVmP6UIPXS0VKQ', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('71', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E5%8C%97%E6%B5%B7%E6%B5%B7%E9%B8%AD%E8%9B%8B+%E8%87%AA%E5%AE%B6%E7%86%9F%E5%92%B8%E7%83%A4%E6%B5%B7%E9%B8%AD%E8%9B%8B20%E6%9E%9A%E8%A3%8558%E5%85%83%E5%8C%85%E9%82%AE', '20160707115456620203', '58.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys7tvZwviGDUf_-y3rZIfpsY', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('72', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E5%A4%A7%E9%87%91%E7%85%8C%E8%8A%92%E6%9E%9C+10%E6%96%A4%E7%B2%BE%E8%A3%85%E7%94%B0%E4%B8%9C%E8%8A%92%E6%9E%9C89%E5%85%83%E5%85%A8%E5%9B%BD%E5%8C%85%E9%82%AE', '20160707165847099322', '89.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teysyGg8_ckqJzKeAweCzI8kwI', '0', '1', '0', null, null);
INSERT INTO `wp_payment_order` VALUES ('73', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1-%E9%A1%B9%E9%B8%A1+%E5%9D%87%E9%87%8D3%E6%96%A499%E5%85%83%2F%E5%8F%AA+%E5%8F%AF%E5%B8%AE%E6%9D%80%E5%A5%BD', '20160719130174787550', '198.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8o3MGF2OU6V5Zo5njN5i8s', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('74', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E7%94%B0%E4%B8%9C%E6%A1%82%E4%B8%83%E9%A6%99%E8%8A%92+%E5%8D%81%E6%96%A4%E7%B2%BE%E8%A3%85108%E5%85%83%2F%E4%BB%B6%E5%85%A8%E5%9B%BD%E5%8C%85%E9%82%AE', '20160725155501368922', '108.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys7_0roOxVUrgEVypmLCuMvg', '0', '1', '0', null, null);
INSERT INTO `wp_payment_order` VALUES ('75', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E7%94%B0%E4%B8%9C%E6%A1%82%E4%B8%83%E9%A6%99%E8%8A%92+%E5%8D%81%E6%96%A4%E7%B2%BE%E8%A3%85108%E5%85%83%2F%E4%BB%B6%E5%85%A8%E5%9B%BD%E5%8C%85%E9%82%AE', '20160725162469985966', '108.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys7_0roOxVUrgEVypmLCuMvg', '0', '1', '0', null, null);
INSERT INTO `wp_payment_order` VALUES ('76', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E7%94%B0%E4%B8%9C%E6%A1%82%E4%B8%83%E9%A6%99%E8%8A%92+%E5%8D%81%E6%96%A4%E7%B2%BE%E8%A3%85108%E5%85%83%2F%E4%BB%B6%E5%85%A8%E5%9B%BD%E5%8C%85%E9%82%AE', '20160725163261280460', '108.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys7_0roOxVUrgEVypmLCuMvg', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('77', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E7%94%B0%E4%B8%9C%E6%A1%82%E4%B8%83%E9%A6%99%E8%8A%92+%E5%8D%81%E6%96%A4%E7%B2%BE%E8%A3%85%E5%B9%BF%E8%A5%BF%E5%8C%BA%E5%86%8598%E5%85%83%2F%E4%BB%B6%E5%8C%85%E9%82%AE', '20160725163565253693', '98.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys7_0roOxVUrgEVypmLCuMvg', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('78', 'http%3A%2F%2Flao337.zinongweb.com%2Fpay%2Fweixin', '%E9%99%88%E7%8E%8B%E5%B1%B1%E7%81%B5%E8%8A%9D%E9%B8%A1-%E9%A1%B9%E9%B8%A1+%E5%9D%87%E9%87%8D3%E6%96%A499%E5%85%83%2F%E5%8F%AA+%E5%8F%AF%E5%B8%AE%E6%9D%80%E5%A5%BD', '20160728160286852689', '198.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8yfbfHOhCIXHgpTrV_IumU', '0', '1', '1', null, null);
INSERT INTO `wp_payment_order` VALUES ('79', 'http%3A%2F%2Fwww.lao337.com%2Fpay%2Fweixin', '%E7%94%B0%E4%B8%9C%E6%A1%82%E4%B8%83%E9%A6%99%E8%8A%92+%E5%8D%81%E6%96%A4%E7%B2%BE%E8%A3%85%E5%B9%BF%E8%A5%BF%E5%8C%BA%E5%86%85105%E5%85%83%2F%E4%BB%B6%E5%8C%85%E9%82%AE', '20160803204549639389', '105.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0', '1', '0', null, null);
INSERT INTO `wp_payment_order` VALUES ('80', 'http%3A%2F%2Fwww.lao337.com%2Fpay%2Fweixin', '%E7%94%B0%E4%B8%9C%E6%A1%82%E4%B8%83%E9%A6%99%E8%8A%92+%E5%8D%81%E6%96%A4%E7%B2%BE%E8%A3%85%E5%B9%BF%E8%A5%BF%E5%8C%BA%E5%86%85105%E5%85%83%2F%E4%BB%B6%E5%8C%85%E9%82%AE', '20160808212801696068', '105.00', '1d8a2d970e7e48d7d0ec919112bc6c9d', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '11', '1', '0', null, null);

-- ----------------------------
-- Table structure for wp_payment_set
-- ----------------------------
DROP TABLE IF EXISTS `wp_payment_set`;
CREATE TABLE `wp_payment_set` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `wxmchid` varchar(255) DEFAULT NULL COMMENT '微信支付商户号',
  `shop_id` int(10) DEFAULT '0' COMMENT '商店ID',
  `quick_merid` varchar(255) DEFAULT NULL COMMENT '银联在线merid',
  `quick_merabbr` varchar(255) DEFAULT NULL COMMENT '商户名称',
  `wxpartnerid` varchar(255) DEFAULT NULL COMMENT '微信partnerid',
  `wxpartnerkey` varchar(255) DEFAULT NULL COMMENT '微信partnerkey',
  `partnerid` varchar(255) DEFAULT NULL COMMENT '财付通标识',
  `key` varchar(255) DEFAULT NULL COMMENT 'KEY',
  `ctime` int(10) DEFAULT NULL COMMENT '创建时间',
  `quick_security_key` varchar(255) DEFAULT NULL COMMENT '银联在线Key',
  `wappartnerkey` varchar(255) DEFAULT NULL COMMENT 'WAP财付通Key',
  `wappartnerid` varchar(255) DEFAULT NULL COMMENT '财付通标识WAP',
  `partnerkey` varchar(255) DEFAULT NULL COMMENT '财付通Key',
  `pid` varchar(255) DEFAULT NULL COMMENT 'PID',
  `zfbname` varchar(255) DEFAULT NULL COMMENT '帐号',
  `wxappsecret` varchar(255) DEFAULT NULL COMMENT 'AppSecret',
  `wxpaysignkey` varchar(255) DEFAULT NULL COMMENT '支付密钥',
  `wxappid` varchar(255) DEFAULT NULL COMMENT 'AppID',
  `token` varchar(255) DEFAULT NULL COMMENT 'token',
  `wx_cert_pem` int(10) unsigned DEFAULT NULL COMMENT '上传证书',
  `wx_key_pem` int(10) unsigned DEFAULT NULL COMMENT '上传密匙',
  `shop_pay_score` int(10) DEFAULT '0' COMMENT '支付返积分',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_payment_set
-- ----------------------------

-- ----------------------------
-- Table structure for wp_picture
-- ----------------------------
DROP TABLE IF EXISTS `wp_picture`;
CREATE TABLE `wp_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `status` (`id`,`status`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_picture
-- ----------------------------
INSERT INTO `wp_picture` VALUES ('1', '/Uploads/Picture/2016-03-22/56f0f1a5cece8.png', '', 'aaf4949c47cf35175eba4bc7247530a0', 'f91f19da0976955256e2d93fa50de00a3c75dc66', '1', '1458631077');
INSERT INTO `wp_picture` VALUES ('2', '/Uploads/Picture/2016-03-22/56f0f918c2dc8.png', '', '4b3eb5cac7391bc10fa695d5dbb2d3eb', '719020117b327dbae30aa9867790b7e8b78fc323', '1', '1458632984');
INSERT INTO `wp_picture` VALUES ('3', '/Uploads/Picture/2016-03-22/56f1065b6e6db.png', '', 'ac1944ec7633549136f83ddeb671112d', 'cd933a270bceafb3321b2f9d36fc3b841adf513c', '1', '1458636378');
INSERT INTO `wp_picture` VALUES ('4', '/Uploads/Picture/2016-03-22/56f10d5313db5.gif', '', 'bc4b3e6e70839293f241b2051a463e55', 'a807855964c674c838446eceba94d29d1a25891b', '1', '1458638162');
INSERT INTO `wp_picture` VALUES ('5', '/Uploads/Picture/2016-04-06/57048607afc09.png', '', '81d1ed457704f2927b4de76352d00099', 'dd37fce70fe28b78032397c4f7876c106a099ab7', '1', '1459914247');
INSERT INTO `wp_picture` VALUES ('6', '/Uploads/Picture/2016-04-06/5704afc8e494d.png', '', 'f887783ed94aeddc0d994a977d84cb76', '9905529e1112debd162cc3b144aa8ebd25a8f805', '1', '1459924936');

-- ----------------------------
-- Table structure for wp_plugin
-- ----------------------------
DROP TABLE IF EXISTS `wp_plugin`;
CREATE TABLE `wp_plugin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  `cate_id` int(11) DEFAULT NULL,
  `is_show` tinyint(2) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `sti` (`status`,`is_show`)
) ENGINE=MyISAM AUTO_INCREMENT=126 DEFAULT CHARSET=utf8 COMMENT='系统插件表';

-- ----------------------------
-- Records of wp_plugin
-- ----------------------------
INSERT INTO `wp_plugin` VALUES ('15', 'EditorForAdmin', '后台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"2\",\"editor_height\":\"500px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1383126253', '0', null, '1');
INSERT INTO `wp_plugin` VALUES ('2', 'SiteStat', '站点统计信息', '统计站点的基础信息', '0', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512015', '0', null, '1');
INSERT INTO `wp_plugin` VALUES ('22', 'DevTeam', '开发团队信息', '开发团队成员信息', '0', '{\"title\":\"OneThink\\u5f00\\u53d1\\u56e2\\u961f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1391687096', '0', null, '1');
INSERT INTO `wp_plugin` VALUES ('4', 'SystemInfo', '系统环境信息', '用于显示一些服务器的信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512036', '0', null, '1');
INSERT INTO `wp_plugin` VALUES ('5', 'Editor', '前台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"300px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1379830910', '0', null, '1');
INSERT INTO `wp_plugin` VALUES ('9', 'SocialComment', '通用社交化评论', '集成了各种社交化评论插件，轻松集成到系统中。', '1', '{\"comment_type\":\"1\",\"comment_uid_youyan\":\"1669260\",\"comment_short_name_duoshuo\":\"\",\"comment_form_pos_duoshuo\":\"buttom\",\"comment_data_list_duoshuo\":\"10\",\"comment_data_order_duoshuo\":\"asc\"}', 'thinkphp', '0.1', '1380273962', '0', null, '1');
INSERT INTO `wp_plugin` VALUES ('58', 'Cascade', '级联菜单', '支持无级级联菜单，用于地区选择、多层分类选择等场景。菜单的数据来源支持查询数据库和直接用户按格式输入两种方式', '1', 'null', '凡星', '0.1', '1398694996', '0', null, '1');
INSERT INTO `wp_plugin` VALUES ('120', 'DynamicSelect', '动态下拉菜单', '支持动态从数据库里取值显示', '1', 'null', '凡星', '0.1', '1435223177', '0', null, '1');
INSERT INTO `wp_plugin` VALUES ('125', 'News', '图文素材选择器', '', '1', 'null', '凡星', '0.1', '1439198046', '0', null, '1');

-- ----------------------------
-- Table structure for wp_prize
-- ----------------------------
DROP TABLE IF EXISTS `wp_prize`;
CREATE TABLE `wp_prize` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addon` varchar(255) DEFAULT 'Scratch' COMMENT '来源插件',
  `target_id` int(10) unsigned DEFAULT NULL COMMENT '来源ID',
  `title` varchar(255) DEFAULT NULL COMMENT '奖项标题',
  `name` varchar(255) DEFAULT NULL COMMENT '奖项',
  `num` int(10) unsigned DEFAULT NULL COMMENT '名额数量',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序号',
  `img` int(10) unsigned DEFAULT NULL COMMENT '奖品图片',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_prize
-- ----------------------------

-- ----------------------------
-- Table structure for wp_prize_address
-- ----------------------------
DROP TABLE IF EXISTS `wp_prize_address`;
CREATE TABLE `wp_prize_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `address` varchar(255) DEFAULT NULL COMMENT '奖品收货地址',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机',
  `turename` varchar(255) DEFAULT NULL COMMENT '收货人姓名',
  `uid` int(10) DEFAULT NULL COMMENT '用户id',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `prizeid` int(10) DEFAULT NULL COMMENT '奖品编号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_prize_address
-- ----------------------------

-- ----------------------------
-- Table structure for wp_public
-- ----------------------------
DROP TABLE IF EXISTS `wp_public`;
CREATE TABLE `wp_public` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(10) DEFAULT NULL COMMENT '用户ID',
  `public_name` varchar(50) DEFAULT NULL COMMENT '公众号名称',
  `public_id` varchar(100) DEFAULT NULL COMMENT '公众号原始id',
  `wechat` varchar(100) DEFAULT NULL COMMENT '微信号',
  `interface_url` varchar(255) DEFAULT NULL COMMENT '接口地址',
  `headface_url` varchar(255) DEFAULT NULL COMMENT '公众号头像',
  `area` varchar(50) DEFAULT NULL COMMENT '地区',
  `addon_config` text COMMENT '插件配置',
  `addon_status` text COMMENT '插件状态',
  `token` varchar(100) DEFAULT NULL COMMENT 'Token',
  `is_use` tinyint(2) DEFAULT '0' COMMENT '是否为当前公众号',
  `type` char(10) DEFAULT '0' COMMENT '公众号类型',
  `appid` varchar(255) DEFAULT NULL COMMENT 'AppID',
  `secret` varchar(255) DEFAULT NULL COMMENT 'AppSecret',
  `group_id` int(10) unsigned DEFAULT '0' COMMENT '等级',
  `encodingaeskey` varchar(255) DEFAULT NULL COMMENT 'EncodingAESKey',
  `tips_url` varchar(255) DEFAULT NULL COMMENT '提示关注公众号的文章地址',
  `domain` varchar(30) DEFAULT NULL COMMENT '自定义域名',
  `is_bind` tinyint(2) DEFAULT '0' COMMENT '是否为微信开放平台绑定账号',
  PRIMARY KEY (`id`),
  KEY `token` (`token`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_public
-- ----------------------------
INSERT INTO `wp_public` VALUES ('1', '1', '阿斯顿发份', '3123', '地方撒的', null, null, null, null, null, '3123', '0', '3', '123', '双方各得发给', '0', '隧道股份返单个', null, null, '0');
INSERT INTO `wp_public` VALUES ('2', '1', '123123', '12312', '3123', null, null, null, null, null, '12312', '0', '3', '123123', '123123', '0', '123123', null, null, '0');

-- ----------------------------
-- Table structure for wp_public_auth
-- ----------------------------
DROP TABLE IF EXISTS `wp_public_auth`;
CREATE TABLE `wp_public_auth` (
  `name` char(50) NOT NULL,
  `title` varchar(100) NOT NULL,
  `type_0` tinyint(1) DEFAULT '0' COMMENT '普通订阅号的开关',
  `type_1` tinyint(1) DEFAULT '0' COMMENT '微信认证订阅号的开关',
  `type_2` tinyint(1) DEFAULT '0' COMMENT '普通服务号的开关',
  `type_3` tinyint(1) DEFAULT '0' COMMENT '微信认证服务号的开关',
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_public_auth
-- ----------------------------
INSERT INTO `wp_public_auth` VALUES ('GET_ACCESS_TOKEN', '基础支持-获取access_token', '1', '1', '1', '1');
INSERT INTO `wp_public_auth` VALUES ('GET_WECHAT_IP', '基础支持-获取微信服务器IP地址', '1', '1', '1', '1');
INSERT INTO `wp_public_auth` VALUES ('GET_MSG', '接收消息-验证消息真实性、接收普通消息、接收事件推送、接收语音识别结果', '1', '1', '1', '1');
INSERT INTO `wp_public_auth` VALUES ('SEND_REPLY_MSG', '发送消息-被动回复消息', '1', '1', '1', '1');
INSERT INTO `wp_public_auth` VALUES ('SEND_CUSTOM_MSG', '发送消息-客服接口', '0', '1', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('SEND_GROUP_MSG', '发送消息-群发接口', '0', '1', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('SEND_NOTICE', '发送消息-模板消息接口（发送业务通知）', '0', '0', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('USER_GROUP', '用户管理-用户分组管理', '0', '1', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('USER_REMARK', '用户管理-设置用户备注名', '0', '1', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('USER_BASE_INFO', '用户管理-获取用户基本信息', '0', '1', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('USER_LIST', '用户管理-获取用户列表', '0', '1', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('USER_LOCATION', '用户管理-获取用户地理位置', '0', '0', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('USER_OAUTH', '用户管理-网页授权获取用户openid/用户基本信息', '0', '0', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('QRCODE', '推广支持-生成带参数二维码', '0', '0', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('LONG_URL', '推广支持-长链接转短链接口', '0', '0', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('MENU', '界面丰富-自定义菜单', '0', '1', '1', '1');
INSERT INTO `wp_public_auth` VALUES ('MATERIAL', '素材管理-素材管理接口', '0', '1', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('SEMANTIC', '智能接口-语义理解接口', '0', '0', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('CUSTOM_SERVICE', '多客服-获取多客服消息记录、客服管理', '0', '0', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('PAYMENT', '微信支付接口', '0', '0', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('SHOP', '微信小店接口', '0', '0', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('CARD', '微信卡券接口', '0', '1', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('DEVICE', '微信设备功能接口', '0', '0', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('JSSKD_BASE', '微信JS-SDK-基础接口', '1', '1', '1', '1');
INSERT INTO `wp_public_auth` VALUES ('JSSKD_SHARE', '微信JS-SDK-分享接口', '0', '1', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('JSSKD_IMG', '微信JS-SDK-图像接口', '1', '1', '1', '1');
INSERT INTO `wp_public_auth` VALUES ('JSSKD_AUDIO', '微信JS-SDK-音频接口', '1', '1', '1', '1');
INSERT INTO `wp_public_auth` VALUES ('JSSKD_SEMANTIC', '微信JS-SDK-智能接口（网页语音识别）', '1', '1', '1', '1');
INSERT INTO `wp_public_auth` VALUES ('JSSKD_DEVICE', '微信JS-SDK-设备信息', '1', '1', '1', '1');
INSERT INTO `wp_public_auth` VALUES ('JSSKD_LOCATION', '微信JS-SDK-地理位置', '1', '1', '1', '1');
INSERT INTO `wp_public_auth` VALUES ('JSSKD_MENU', '微信JS-SDK-界面操作', '1', '1', '1', '1');
INSERT INTO `wp_public_auth` VALUES ('JSSKD_SCAN', '微信JS-SDK-微信扫一扫', '1', '1', '1', '1');
INSERT INTO `wp_public_auth` VALUES ('JSSKD_SHOP', '微信JS-SDK-微信小店', '0', '0', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('JSSKD_CARD', '微信JS-SDK-微信卡券', '0', '1', '0', '1');
INSERT INTO `wp_public_auth` VALUES ('JSSKD_PAYMENT', '微信JS-SDK-微信支付', '0', '0', '0', '1');

-- ----------------------------
-- Table structure for wp_public_follow
-- ----------------------------
DROP TABLE IF EXISTS `wp_public_follow`;
CREATE TABLE `wp_public_follow` (
  `openid` varchar(100) NOT NULL,
  `token` varchar(100) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `has_subscribe` tinyint(1) DEFAULT '0',
  `syc_status` tinyint(1) DEFAULT '2' COMMENT '0 开始同步中 1 更新用户信息中 2 完成同步',
  `remark` varchar(100) DEFAULT NULL,
  UNIQUE KEY `openid` (`openid`,`token`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_public_follow
-- ----------------------------

-- ----------------------------
-- Table structure for wp_public_group
-- ----------------------------
DROP TABLE IF EXISTS `wp_public_group`;
CREATE TABLE `wp_public_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) DEFAULT NULL COMMENT '等级名',
  `addon_status` text COMMENT '插件权限',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_public_group
-- ----------------------------

-- ----------------------------
-- Table structure for wp_public_link
-- ----------------------------
DROP TABLE IF EXISTS `wp_public_link`;
CREATE TABLE `wp_public_link` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(10) DEFAULT NULL COMMENT '管理员UID',
  `mp_id` int(10) unsigned NOT NULL COMMENT '公众号ID',
  `is_creator` tinyint(2) DEFAULT '0' COMMENT '是否为创建者',
  `addon_status` text COMMENT '插件权限',
  `is_use` tinyint(2) DEFAULT '0' COMMENT '是否为当前管理的公众号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `um` (`uid`,`mp_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_public_link
-- ----------------------------
INSERT INTO `wp_public_link` VALUES ('1', '1', '1', '1', null, '0');
INSERT INTO `wp_public_link` VALUES ('2', '1', '2', '1', null, '0');

-- ----------------------------
-- Table structure for wp_qr_code
-- ----------------------------
DROP TABLE IF EXISTS `wp_qr_code`;
CREATE TABLE `wp_qr_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `qr_code` varchar(255) NOT NULL COMMENT '二维码',
  `addon` varchar(255) NOT NULL COMMENT '二维码所属插件',
  `aim_id` int(10) unsigned NOT NULL COMMENT '插件表里的ID值',
  `cTime` int(10) DEFAULT NULL COMMENT '创建时间',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `action_name` char(30) DEFAULT 'QR_SCENE' COMMENT '二维码类型',
  `extra_text` text COMMENT '文本扩展',
  `extra_int` int(10) DEFAULT NULL COMMENT '数字扩展',
  `request_count` int(10) DEFAULT '0' COMMENT '请求数',
  `scene_id` int(10) DEFAULT '0' COMMENT '场景ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_qr_code
-- ----------------------------

-- ----------------------------
-- Table structure for wp_real_prize
-- ----------------------------
DROP TABLE IF EXISTS `wp_real_prize`;
CREATE TABLE `wp_real_prize` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `prize_name` varchar(255) DEFAULT NULL COMMENT '奖品名称',
  `prize_conditions` text COMMENT '活动说明',
  `prize_count` int(10) DEFAULT NULL COMMENT '奖品个数',
  `prize_image` varchar(255) DEFAULT '上传奖品图片' COMMENT '奖品图片',
  `token` varchar(255) DEFAULT NULL COMMENT 'token',
  `fail_content` text COMMENT '领取失败提示',
  `prize_type` tinyint(2) DEFAULT '1' COMMENT '奖品类型',
  `use_content` text COMMENT '使用说明',
  `prize_title` varchar(255) DEFAULT NULL COMMENT '活动标题',
  `template` varchar(255) DEFAULT 'default' COMMENT '素材模板',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_real_prize
-- ----------------------------

-- ----------------------------
-- Table structure for wp_reserve
-- ----------------------------
DROP TABLE IF EXISTS `wp_reserve`;
CREATE TABLE `wp_reserve` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `cTime` int(10) unsigned DEFAULT NULL COMMENT '发布时间',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `password` varchar(255) DEFAULT NULL COMMENT '微预约密码',
  `jump_url` varchar(255) DEFAULT NULL COMMENT '提交后跳转的地址',
  `content` text COMMENT '详细介绍',
  `finish_tip` text COMMENT '用户提交后提示内容',
  `can_edit` tinyint(2) DEFAULT '0' COMMENT '是否允许编辑',
  `intro` text COMMENT '封面简介',
  `mTime` int(10) DEFAULT NULL COMMENT '修改时间',
  `cover` int(10) unsigned DEFAULT NULL COMMENT '封面图片',
  `template` varchar(255) DEFAULT 'default' COMMENT '模板',
  `status` tinyint(2) DEFAULT '0' COMMENT '状态',
  `start_time` int(10) DEFAULT NULL COMMENT '报名开始时间',
  `end_time` int(10) DEFAULT NULL COMMENT '报名结束时间',
  `pay_online` tinyint(2) DEFAULT '0' COMMENT '是否支持在线支付',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_reserve
-- ----------------------------

-- ----------------------------
-- Table structure for wp_reserve_attribute
-- ----------------------------
DROP TABLE IF EXISTS `wp_reserve_attribute`;
CREATE TABLE `wp_reserve_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `is_show` tinyint(2) DEFAULT '1' COMMENT '是否显示',
  `reserve_id` int(10) unsigned DEFAULT NULL COMMENT '微预约ID',
  `error_info` varchar(255) DEFAULT NULL COMMENT '出错提示',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序号',
  `validate_rule` varchar(255) DEFAULT NULL COMMENT '正则验证',
  `is_must` tinyint(2) DEFAULT NULL COMMENT '是否必填',
  `remark` varchar(255) DEFAULT NULL COMMENT '字段备注',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `title` varchar(255) NOT NULL COMMENT '字段标题',
  `mTime` int(10) DEFAULT NULL COMMENT '修改时间',
  `extra` text COMMENT '参数',
  `type` char(50) NOT NULL DEFAULT 'string' COMMENT '字段类型',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_reserve_attribute
-- ----------------------------

-- ----------------------------
-- Table structure for wp_reserve_option
-- ----------------------------
DROP TABLE IF EXISTS `wp_reserve_option`;
CREATE TABLE `wp_reserve_option` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `reserve_id` int(10) DEFAULT NULL COMMENT '预约活动ID',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `money` decimal(11,2) DEFAULT '0.00' COMMENT '报名费用',
  `max_limit` int(10) DEFAULT '0' COMMENT '最大预约数',
  `init_count` int(10) DEFAULT '0' COMMENT '初始化预约数',
  `join_count` int(10) DEFAULT '0' COMMENT '参加人数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_reserve_option
-- ----------------------------

-- ----------------------------
-- Table structure for wp_reserve_value
-- ----------------------------
DROP TABLE IF EXISTS `wp_reserve_value`;
CREATE TABLE `wp_reserve_value` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `is_check` int(10) DEFAULT '0' COMMENT '验证是否成功',
  `reserve_id` int(10) unsigned DEFAULT NULL COMMENT '微预约ID',
  `value` text COMMENT '微预约值',
  `cTime` int(10) DEFAULT NULL COMMENT '增加时间',
  `openid` varchar(255) DEFAULT NULL COMMENT 'OpenId',
  `uid` int(10) DEFAULT NULL COMMENT '用户ID',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `is_pay` int(10) DEFAULT '0' COMMENT '是否支付',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_reserve_value
-- ----------------------------

-- ----------------------------
-- Table structure for wp_scratch
-- ----------------------------
DROP TABLE IF EXISTS `wp_scratch`;
CREATE TABLE `wp_scratch` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` varchar(100) NOT NULL COMMENT '关键词',
  `use_tips` varchar(255) NOT NULL COMMENT '使用说明',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `intro` text COMMENT '封面简介',
  `end_time` int(10) DEFAULT NULL COMMENT '结束时间',
  `cover` int(10) unsigned DEFAULT NULL COMMENT '封面图片',
  `cTime` int(10) unsigned DEFAULT NULL COMMENT '发布时间',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `start_time` int(10) DEFAULT NULL COMMENT '开始时间',
  `end_tips` text COMMENT '过期说明',
  `end_img` int(10) unsigned DEFAULT NULL COMMENT '过期提示图片',
  `predict_num` int(10) unsigned NOT NULL COMMENT '预计参与人数',
  `max_num` int(10) unsigned DEFAULT '1' COMMENT '每人最多允许抽奖次数',
  `follower_condtion` char(50) DEFAULT '1' COMMENT '粉丝状态',
  `credit_conditon` int(10) unsigned DEFAULT '0' COMMENT '积分限制',
  `credit_bug` int(10) unsigned DEFAULT '0' COMMENT '积分消费',
  `addon_condition` varchar(255) DEFAULT NULL COMMENT '插件场景限制',
  `collect_count` int(10) unsigned DEFAULT '0' COMMENT '已领取人数',
  `view_count` int(10) unsigned DEFAULT '0' COMMENT '浏览人数',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  `template` varchar(255) DEFAULT 'default' COMMENT '素材模板',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_scratch
-- ----------------------------

-- ----------------------------
-- Table structure for wp_shop
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop`;
CREATE TABLE `wp_shop` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL COMMENT '商店名称',
  `logo` int(10) DEFAULT NULL COMMENT '商店LOGO',
  `intro` text COMMENT '店铺简介',
  `mobile` varchar(30) DEFAULT NULL COMMENT '联系电话',
  `qq` int(10) DEFAULT NULL COMMENT 'QQ',
  `wechat` varchar(50) DEFAULT NULL COMMENT '微信',
  `template` varchar(30) DEFAULT NULL COMMENT '模板',
  `content` text COMMENT '店铺介绍',
  `token` varchar(100) DEFAULT NULL COMMENT 'Token',
  `manager_id` int(10) DEFAULT NULL COMMENT '管理员ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop
-- ----------------------------

-- ----------------------------
-- Table structure for wp_shop_address
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_address`;
CREATE TABLE `wp_shop_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` varchar(255) DEFAULT NULL COMMENT '用户ID',
  `truename` varchar(100) DEFAULT NULL COMMENT '收货人姓名',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机号码',
  `city` varchar(255) DEFAULT NULL COMMENT '城市',
  `address` varchar(255) DEFAULT NULL COMMENT '具体地址',
  `is_use` tinyint(2) DEFAULT '0' COMMENT '是否设置为默认',
  `region_id` int(10) unsigned DEFAULT NULL,
  `region_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_address
-- ----------------------------
INSERT INTO `wp_shop_address` VALUES ('13', 'o1teys0U4AM_Ex-buqh9BJhJHIjw', '王立', '15240681423', null, '高新大道62号 光辉大楼602', '0', '2290', '广西壮族自治区 南宁市 西乡塘区');
INSERT INTO `wp_shop_address` VALUES ('14', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '李金官', '18007800880', null, '科德路', '1', '2290', '广西壮族自治区 南宁市 西乡塘区');
INSERT INTO `wp_shop_address` VALUES ('15', 'o1teys39jDjN56TGWhmKib6Awjek', '黄璟一', '13807765679', null, '乐里镇财富商城小广场家家乐经营部', '0', '2384', '广西壮族自治区 百色市 田林县');
INSERT INTO `wp_shop_address` VALUES ('16', 'o1teys39jDjN56TGWhmKib6Awjek', '黄璟一', '13807765679', null, '乐里镇财富商城小广场家家乐经营部', '1', '2384', '广西壮族自治区 百色市 田林县');
INSERT INTO `wp_shop_address` VALUES ('17', 'o1teys7tALk-MME7nA-xm97bmNz4', '王苏妍', '18707861600', null, '广西南宁市青秀区云景路东景花园2栋2223', '1', '2288', '广西壮族自治区 南宁市 青秀区');
INSERT INTO `wp_shop_address` VALUES ('18', 'o1teys7tALk-MME7nA-xm97bmNz4', '王苏妍', '18707861600', null, '广西南宁市青秀区云景路东景花园2栋2223', '1', '2288', '广西壮族自治区 南宁市 青秀区');
INSERT INTO `wp_shop_address` VALUES ('19', 'o1teysy_HdOBTKvdeMMDViaby4d4', '邓棋文', '13507710688', null, '南宁北湖北路69号荣宝龙市场36栋广西宝航', '0', '2290', '广西壮族自治区 南宁市 西乡塘区');
INSERT INTO `wp_shop_address` VALUES ('20', 'o1teysy_HdOBTKvdeMMDViaby4d4', '翁玉贤', '13077778110', null, '南宁秀安路虎邱城北钢材市场K42(太阳公司) ', '0', '2290', '广西壮族自治区 南宁市 西乡塘区');
INSERT INTO `wp_shop_address` VALUES ('21', 'o1teysy_HdOBTKvdeMMDViaby4d4', '向朝辉', '13367570521', null, '贵港市平南县月亮湾城市花园丽苑16座1梯603 ', '0', '2290', '广西壮族自治区 南宁市 西乡塘区');
INSERT INTO `wp_shop_address` VALUES ('22', 'o1teys_KAj3bWXOvJsK4cLyvrwnQ', '罗佳慧', '13878126519', null, '高新区科园大道嘉华绿洲D栋', '1', '2290', '广西壮族自治区 南宁市 西乡塘区');
INSERT INTO `wp_shop_address` VALUES ('23', 'o1teysxlDFWiy_rC-XKu4cE_blUM', '陈怡', '15677137010', null, '大学东路100号广西大学东校园东高4栋301', '1', '2290', '广西壮族自治区 南宁市 西乡塘区');
INSERT INTO `wp_shop_address` VALUES ('24', 'o1teys-7KnJ2Yn0hyRz6w6zx32Qc', '黄丽娟', '18078619658', null, '新市街209号，交通局对面农行。', '0', '2384', '广西壮族自治区 百色市 田林县');
INSERT INTO `wp_shop_address` VALUES ('25', 'o1teys-7KnJ2Yn0hyRz6w6zx32Qc', '黄丽娟', '18078619658', null, '新市街209号，交通局对面农行。', '0', '2384', '广西壮族自治区 百色市 田林县');
INSERT INTO `wp_shop_address` VALUES ('26', 'o1teys6MbkbmRJ6DfshJCw8AMWmw', '赵', '18172331682', null, '南宁市五一中路丽江村小区16栋3单元908', '0', '2289', '广西壮族自治区 南宁市 江南区');
INSERT INTO `wp_shop_address` VALUES ('27', 'o1teys_6ezIuNEUwpLrH7g0_boiE', '梁冬梅', '13627883911', null, '大学东路98号世贸西城D2205', '1', '2290', '广西壮族自治区 南宁市 西乡塘区');
INSERT INTO `wp_shop_address` VALUES ('28', 'o1teys8yfbfHOhCIXHgpTrV_IumU', '刘红娜', '15296281306', null, '广西民族大学', '1', '2290', '广西壮族自治区 南宁市 西乡塘区');
INSERT INTO `wp_shop_address` VALUES ('29', 'o1teysxSSrfPUmb_WELwwDSalNQY', '曹晓瑞', '13878118855', null, '长湖路62号凤景湾小区商铺2楼仙茗寿域茶楼', '1', '2288', '广西壮族自治区 南宁市 青秀区');
INSERT INTO `wp_shop_address` VALUES ('30', 'o1teys7HBU9b78_Tr5PZps5G-5WQ', '黄姐', '13977117205', null, '民族大道153号（逸园小区）9栋102', '1', '2288', '广西壮族自治区 南宁市 青秀区');
INSERT INTO `wp_shop_address` VALUES ('31', 'o1teysyjFEoTsZRRVprjExU6w4EE', '赵劲贝', '13005925270', null, '宁明', '0', '2286', '广西壮族自治区 南宁市 市辖区');
INSERT INTO `wp_shop_address` VALUES ('32', 'o1teys2974CfTGblkN_hHwur6_6c', '赖丽萍', '13707760848', null, '祥周镇新州村田东电厂宿舍', '1', '2377', '广西壮族自治区 百色市 田东县');
INSERT INTO `wp_shop_address` VALUES ('33', 'o1teysynlx0Cz1NwrKIoNDHFIjXQ', '董长俊', '18697985728', null, '长堽路一里官桥三组76号', '1', '2287', '广西壮族自治区 南宁市 兴宁区');
INSERT INTO `wp_shop_address` VALUES ('34', 'o1teys_TnbMJ08GlKeTruOaIdkgA', '黄华娟', '13907714376', null, '大学西路广西民族大学西校区东盟楼', '1', '2290', '广西壮族自治区 南宁市 西乡塘区');
INSERT INTO `wp_shop_address` VALUES ('35', 'o1teys_TnbMJ08GlKeTruOaIdkgA', '黄华娟', '13907714376', null, '大学西路广西民族大学西校区东盟楼', '1', '2290', '广西壮族自治区 南宁市 西乡塘区');
INSERT INTO `wp_shop_address` VALUES ('36', 'o1teys9dSCNTujeoSUHOilFKpjSc', '王女士', '18977773086', null, '五一中路4一2号丽江村小区', '1', '2289', '广西壮族自治区 南宁市 江南区');
INSERT INTO `wp_shop_address` VALUES ('37', 'o1teys_65crDgTKTG3dN4NoZBlBE', '苏老师', '15977185008', null, '广西大学西校园北区16', '1', '2290', '广西壮族自治区 南宁市 西乡塘区');
INSERT INTO `wp_shop_address` VALUES ('38', 'o1teys2-EY3G0TPDPALNveLoeKFY', '韦柳', '15289694711', null, '宜州市新中医医院针灸科', '1', '2406', '广西壮族自治区 河池市 宜州市');
INSERT INTO `wp_shop_address` VALUES ('39', 'o1teys2RfggczG3hE1skdoDC8n0Q', '凌立文', '18677753114', null, '大垌镇农村信用社', '0', '2354', '广西壮族自治区 钦州市 钦北区');
INSERT INTO `wp_shop_address` VALUES ('40', 'o1teys2RfggczG3hE1skdoDC8n0Q', '凌立文', '18677753114', null, '大垌镇农村信用社', '1', '2354', '广西壮族自治区 钦州市 钦北区');
INSERT INTO `wp_shop_address` VALUES ('41', 'o1teys2RfggczG3hE1skdoDC8n0Q', '凌立文', '18677753114', null, '大垌镇农村信用社', '0', '2354', '广西壮族自治区 钦州市 钦北区');
INSERT INTO `wp_shop_address` VALUES ('42', 'o1teys1RcnZoDK3AMPSkidL8UvNU', '凌立文', '18677753114', null, '大垌信用社', '1', '2354', '广西壮族自治区 钦州市 钦北区');
INSERT INTO `wp_shop_address` VALUES ('43', 'o1teys1hJM4kKnk4ts3Zd_TQVl5A', '韦双', '18775829717', null, '庆远镇九龙路南新中医院内一科', '1', '2406', '广西壮族自治区 河池市 宜州市');
INSERT INTO `wp_shop_address` VALUES ('44', 'o1teysyEa4ZLo9kQTJ6WJQT5Dkik', '谭海娘', '13737047821', null, '车公庄大街4号院3号楼305室(北京文化创新工场) ', '0', '3', '北京市 北京 西城区');
INSERT INTO `wp_shop_address` VALUES ('45', 'o1teys0DOh_5vUtHwRGwpw_OQ1qQ', '赵韩', '18377616929', null, '新州镇民生街243号工商银行', '1', '2386', '广西壮族自治区 百色市 隆林各族自治县');
INSERT INTO `wp_shop_address` VALUES ('46', 'o1teys9AsS4YBkYvA9wxKrBNTb3Y', '杨凤媛', '13317768939', null, '民主路35号', '0', '2287', '广西壮族自治区 南宁市 兴宁区');
INSERT INTO `wp_shop_address` VALUES ('47', 'o1teys2fjdJbcE--zaLdyFTJl2lg', '万紫晶', '15577728507', null, '鹅山路菜市区23号建行(鹅山公园对面)', '1', '2303', '广西壮族自治区 柳州市 柳南区');
INSERT INTO `wp_shop_address` VALUES ('48', 'o1teys2fjdJbcE--zaLdyFTJl2lg', '万紫晶', '15577728507', null, '鹅山路菜市区23号建行(鹅山公园对面)', '1', '2303', '广西壮族自治区 柳州市 柳南区');
INSERT INTO `wp_shop_address` VALUES ('49', 'o1teys6Nhr6G85mVmP6UIPXS0VKQ', '李忠明', '13687412899', null, '已送', '0', '2130', '广东省 广州市 天河区');
INSERT INTO `wp_shop_address` VALUES ('50', 'o1teys7tvZwviGDUf_-y3rZIfpsY', '高炜', '18677161617', null, '昆仑大道嘉和城温莎南郡7栋1705', '1', '2287', '广西壮族自治区 南宁市 兴宁区');
INSERT INTO `wp_shop_address` VALUES ('51', 'o1teys7tvZwviGDUf_-y3rZIfpsY', '高炜', '18677161617', null, '昆仑大道嘉和城温莎南郡7栋1705', '1', '2287', '广西壮族自治区 南宁市 兴宁区');
INSERT INTO `wp_shop_address` VALUES ('52', 'o1teysyGg8_ckqJzKeAweCzI8kwI', '吕奔', '18648965031', null, '科德路7号402', '1', '2290', '广西壮族自治区 南宁市 西乡塘区');
INSERT INTO `wp_shop_address` VALUES ('53', 'o1teys8o3MGF2OU6V5Zo5njN5i8s', '马婕', '13507717326', null, '南宁市大学东路188号广西民族大学5坡29栋2603房', '1', '2290', '广西壮族自治区 南宁市 西乡塘区');
INSERT INTO `wp_shop_address` VALUES ('54', 'o1teys8o3MGF2OU6V5Zo5njN5i8s', '马婕', '13507717326', null, '南宁市大学东路188号广西民族大学5坡29栋2603房', '1', '2290', '广西壮族自治区 南宁市 西乡塘区');
INSERT INTO `wp_shop_address` VALUES ('55', 'o1teys7_0roOxVUrgEVypmLCuMvg', '李秋群', '18778835131', null, '进港三路盐田港物流中心六楼', '0', '2157', '广东省 深圳市 盐田区');
INSERT INTO `wp_shop_address` VALUES ('56', 'o1teys7_0roOxVUrgEVypmLCuMvg', '李镇', '13517641335', null, '沙田镇沙田街', '1', '2390', '广西壮族自治区 贺州市 平桂管理区');

-- ----------------------------
-- Table structure for wp_shop_agent_balance
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_agent_balance`;
CREATE TABLE `wp_shop_agent_balance` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `agent_openid` varchar(255) NOT NULL,
  `balance` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_agent_balance
-- ----------------------------
INSERT INTO `wp_shop_agent_balance` VALUES ('1', 'o1teysxaWmeTjW6HoDruIYb004SU', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('2', 'o1teys2GjrPml9z27-qTlc3Qad14', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('3', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('4', 'o1teysyjFEoTsZRRVprjExU6w4EE', '0.40');
INSERT INTO `wp_shop_agent_balance` VALUES ('5', 'o1teys0U4AM_Ex-buqh9BJhJHIjw', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('6', 'o1teysz6mc08bAuPr5APGSW20dnU', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('7', 'o1teysy_HdOBTKvdeMMDViaby4d4', '34.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('8', 'o1teys-hETQ5mZIHGRdDwnbMbiyw', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('9', 'o1teys_1XikMm-IDIowP9lbcfudw', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('10', 'o1teysxq-w7epKRySMZ6bmtV75HQ', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('11', 'o1teysyBZtb9ykG_73aU-5atgsXo', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('12', 'o1teys39jDjN56TGWhmKib6Awjek', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('13', 'o1teys_s-cEvLcqQEJiYHWntIjSk', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('14', 'o1teys4SeyMfFj49664lIN-9_C_k', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('15', 'o1teys8MFXzN79qLlnXrfgT1tBMI', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('16', 'o1teyswiajvwzepp1umQUAHqUVmg', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('17', 'o1teys0wkRQRAcwEnUDPFY0Eic_g', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('18', 'o1teys--QgpSDXlTwHqBcEWKJTfY', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('19', 'o1teys7n2VqVKXbF_i7LDfT8zCaM', '12.40');
INSERT INTO `wp_shop_agent_balance` VALUES ('20', 'o1teys4N2zQTvic-Jg1erEi3bxYA', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('21', 'o1teys_TnbMJ08GlKeTruOaIdkgA', '0.90');
INSERT INTO `wp_shop_agent_balance` VALUES ('22', 'o1teyszPS7rS6126eDZb2TqpS8DA', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('23', 'o1teys36GpmIA-wcalnS_IQpqHWo', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('24', 'o1teyswwqiSYDhR0leTUOREhoEI8', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('25', 'o1teys-3TogDgP5YRIF1mEP6bfko', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('26', 'o1teys56D1mJMn4phbY3K7rYoVBI', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('27', 'o1teysxSSrfPUmb_WELwwDSalNQY', '89.82');
INSERT INTO `wp_shop_agent_balance` VALUES ('28', 'o1teys2Kdb7MBU_pXW2voOm47Z6I', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('29', 'o1teys3Upifr-eineGRs_ExJ8Ts0', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('30', 'o1teys8yfbfHOhCIXHgpTrV_IumU', '21.80');
INSERT INTO `wp_shop_agent_balance` VALUES ('31', 'o1teys1pVoyU_tMSrf-Tw03gEH1g', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('32', 'o1teys0RqQStJpR9Q9t5-HMRNSZg', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('33', 'o1teys_RpX3iYldXit-seIl15Na4', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('34', 'o1teys5-BrWVIgFFBcgDI-E05Dr0', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('35', 'o1teyszzLV1ixOahZY0Q4yv1QjMU', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('36', 'o1teysxKg681M1gWXGMhDhMjDIiE', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('37', 'o1teys4ZEUzcYSwNHyuhGMFHqPdQ', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('38', 'o1teys-NeHNWytkAxk-OTvWxavbM', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('39', 'o1teys1U82NCJnKnMnRAWozW9erY', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('40', 'o1teys-gDeWFtcTHcoadItuuhSso', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('41', 'o1teys8HieiDbuSvhK7Y2DbIuOpA', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('42', 'o1teyszu1qNiSJJwai60rOo4UW1A', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('43', 'o1teys8SxM-wMMbCapqQhhg_CRVU', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('44', 'o1teysyP2u3i5FLLOsBywnlK8Sa8', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('45', 'o1teys37ATpSz5BK5HeiSQ6OAIZ4', '0.00');
INSERT INTO `wp_shop_agent_balance` VALUES ('46', 'o1teys2fjdJbcE--zaLdyFTJl2lg', '0.64');

-- ----------------------------
-- Table structure for wp_shop_bind
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_bind`;
CREATE TABLE `wp_shop_bind` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `agent_openid` varchar(255) NOT NULL,
  `from_user_openid` varchar(255) NOT NULL,
  `bind_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_bind
-- ----------------------------
INSERT INTO `wp_shop_bind` VALUES ('1', 'o1teysxaWmeTjW6HoDruIYb004SU', 'o1teysxaWmeTjW6HoDruIYb004SU', '1463371871');
INSERT INTO `wp_shop_bind` VALUES ('2', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teyszSz1iwGZGYto452Ss2E-G4', '1463473307');
INSERT INTO `wp_shop_bind` VALUES ('4', 'o1teysy_HdOBTKvdeMMDViaby4d4', 'o1teys5yiq_zyvlYGCWPC444KMSs', '1463490659');
INSERT INTO `wp_shop_bind` VALUES ('75', 'o1teys1pVoyU_tMSrf-Tw03gEH1g', 'o1teyszBbcucUQFghyC7qVoWgW2I', '1465752971');
INSERT INTO `wp_shop_bind` VALUES ('6', 'o1teysy_HdOBTKvdeMMDViaby4d4', 'o1teys3pHcjpvHRGDfSuTeauftbQ', '1463494088');
INSERT INTO `wp_shop_bind` VALUES ('7', 'o1teysy_HdOBTKvdeMMDViaby4d4', 'o1teysy_HdOBTKvdeMMDViaby4d4', '1463495044');
INSERT INTO `wp_shop_bind` VALUES ('93', 'o1teys36GpmIA-wcalnS_IQpqHWo', 'o1teysx0ng6wyQd5UyaJglXUCtCw', '1467879855');
INSERT INTO `wp_shop_bind` VALUES ('15', 'o1teysz6mc08bAuPr5APGSW20dnU', 'o1teyswndRCyFmFOMiuV2Sw7c44o', '1463657303');
INSERT INTO `wp_shop_bind` VALUES ('10', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys3DmVII6NSHNIOVwgbxWRls', '1463546086');
INSERT INTO `wp_shop_bind` VALUES ('92', 'o1teys2fjdJbcE--zaLdyFTJl2lg', 'o1teys2fjdJbcE--zaLdyFTJl2lg', '1467712782');
INSERT INTO `wp_shop_bind` VALUES ('77', 'o1teys1pVoyU_tMSrf-Tw03gEH1g', 'o1teys0tShPb74WCRF7yL_RKB4Xo', '1465798804');
INSERT INTO `wp_shop_bind` VALUES ('13', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys2RfggczG3hE1skdoDC8n0Q', '1463583609');
INSERT INTO `wp_shop_bind` VALUES ('14', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys9uQ52zn4LzaI91MBhCfhMU', '1463585436');
INSERT INTO `wp_shop_bind` VALUES ('16', 'o1teys0wkRQRAcwEnUDPFY0Eic_g', 'o1teys3axOTidEd72U5DKjPAtY1M', '1463665016');
INSERT INTO `wp_shop_bind` VALUES ('17', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys5Gzp44gvjNqHUk5T4w_txQ', '1463709904');
INSERT INTO `wp_shop_bind` VALUES ('18', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teysyC6qywiU2O5foBNABJj2XA', '1463709952');
INSERT INTO `wp_shop_bind` VALUES ('19', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys-FBScmod3T6ngHoNaq44QE', '1463710786');
INSERT INTO `wp_shop_bind` VALUES ('20', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys5BRYmOxaZOkE5pkqI_zo5o', '1463710879');
INSERT INTO `wp_shop_bind` VALUES ('21', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys5ZFNmWcABCtpRn-GPaD1oc', '1463710963');
INSERT INTO `wp_shop_bind` VALUES ('22', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys_BsoZTCEx-iDj8zOf7mwqs', '1463711344');
INSERT INTO `wp_shop_bind` VALUES ('23', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teyswp4iI3yKa3c0cvSj0w1XHU', '1463712234');
INSERT INTO `wp_shop_bind` VALUES ('24', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teysyxoHk6f01-OBtnSROC-kkA', '1463712489');
INSERT INTO `wp_shop_bind` VALUES ('25', 'o1teys7n2VqVKXbF_i7LDfT8zCaM', 'o1teysxlDFWiy_rC-XKu4cE_blUM', '1463718969');
INSERT INTO `wp_shop_bind` VALUES ('26', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys0iihNsvAHywPPbOWug71_g', '1463720032');
INSERT INTO `wp_shop_bind` VALUES ('27', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys0alUg_Axz7mQr9CSyFNOzA', '1463759227');
INSERT INTO `wp_shop_bind` VALUES ('28', 'o1teysy_HdOBTKvdeMMDViaby4d4', 'o1teys2T0osgfDhf8rutldKOAc9U', '1463824171');
INSERT INTO `wp_shop_bind` VALUES ('29', 'o1teysy_HdOBTKvdeMMDViaby4d4', 'o1teys1OVtmWRDEjdAOYpxGlffRU', '1463824571');
INSERT INTO `wp_shop_bind` VALUES ('30', 'o1teys_TnbMJ08GlKeTruOaIdkgA', 'o1teys_TnbMJ08GlKeTruOaIdkgA', '1464002623');
INSERT INTO `wp_shop_bind` VALUES ('63', 'o1teys3Upifr-eineGRs_ExJ8Ts0', 'o1teys6VEmXsXZGCMVf9KCsJ8H0k', '1464759757');
INSERT INTO `wp_shop_bind` VALUES ('32', 'o1teys0U4AM_Ex-buqh9BJhJHIjw', 'o1teys72jrKg78CNelsmVLI1ZXFY', '1464057242');
INSERT INTO `wp_shop_bind` VALUES ('33', 'o1teys0U4AM_Ex-buqh9BJhJHIjw', 'o1teys7QfOtoIBPiZ84sYOWOg_y0', '1464065233');
INSERT INTO `wp_shop_bind` VALUES ('34', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys5Y4XrO6KgXPOrTrDTv9JQw', '1464081212');
INSERT INTO `wp_shop_bind` VALUES ('68', 'o1teys8yfbfHOhCIXHgpTrV_IumU', 'o1teys8yfbfHOhCIXHgpTrV_IumU', '1465112632');
INSERT INTO `wp_shop_bind` VALUES ('83', 'o1teys8HieiDbuSvhK7Y2DbIuOpA', 'o1teys3gugBUjzvsIs_yYRVqQiec', '1466082004');
INSERT INTO `wp_shop_bind` VALUES ('37', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys36eMDBSEDPCjgS39KsG8qk', '1464092801');
INSERT INTO `wp_shop_bind` VALUES ('38', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys1yYbpaCVyFLym5QcYYaR7E', '1464107740');
INSERT INTO `wp_shop_bind` VALUES ('39', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys61leYs012eQKeR0GJ5On_o', '1464138481');
INSERT INTO `wp_shop_bind` VALUES ('40', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teysy5IKlvItP0Vr9aToLJ9n5o', '1464139222');
INSERT INTO `wp_shop_bind` VALUES ('94', 'o1teys56D1mJMn4phbY3K7rYoVBI', 'o1teys-nD4dA_l_SgrpssdmdFXsM', '1468831152');
INSERT INTO `wp_shop_bind` VALUES ('43', 'o1teys_TnbMJ08GlKeTruOaIdkgA', 'o1teys6xG_jEEjPkb8GsT07GMIH8', '1464164727');
INSERT INTO `wp_shop_bind` VALUES ('51', 'o1teysxSSrfPUmb_WELwwDSalNQY', 'o1teysxSSrfPUmb_WELwwDSalNQY', '1464335295');
INSERT INTO `wp_shop_bind` VALUES ('52', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys7iKjxuIfWQhiCoNitetymM', '1464406952');
INSERT INTO `wp_shop_bind` VALUES ('53', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys7iKjxuIfWQhiCoNitetymM', '1464406952');
INSERT INTO `wp_shop_bind` VALUES ('54', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teyszqt430syX1aOmRHJ8yUztw', '1464410346');
INSERT INTO `wp_shop_bind` VALUES ('90', 'o1teys3Upifr-eineGRs_ExJ8Ts0', 'o1teysyP2u3i5FLLOsBywnlK8Sa8', '1466766255');
INSERT INTO `wp_shop_bind` VALUES ('64', 'o1teys3Upifr-eineGRs_ExJ8Ts0', 'o1teysypHT8s8M4Sf9sdftRBF_8I', '1464759779');
INSERT INTO `wp_shop_bind` VALUES ('58', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys39FFycm4Qy_sPa0tx8Bzq0', '1464427338');
INSERT INTO `wp_shop_bind` VALUES ('67', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teyswvB2-fybWygES0m1L1000I', '1464781291');
INSERT INTO `wp_shop_bind` VALUES ('65', 'o1teys3Upifr-eineGRs_ExJ8Ts0', 'o1teys3Upifr-eineGRs_ExJ8Ts0', '1464760010');
INSERT INTO `wp_shop_bind` VALUES ('62', 'o1teysyjFEoTsZRRVprjExU6w4EE', 'o1teys_sqb6X5xFiS88-bxQKtLM8', '1464531145');
INSERT INTO `wp_shop_bind` VALUES ('69', 'o1teys1pVoyU_tMSrf-Tw03gEH1g', 'o1teys1pVoyU_tMSrf-Tw03gEH1g', '1465199843');
INSERT INTO `wp_shop_bind` VALUES ('70', 'o1teys1pVoyU_tMSrf-Tw03gEH1g', 'o1teys-dQ6UOOlVHXQzc_izg4edk', '1465203463');
INSERT INTO `wp_shop_bind` VALUES ('71', 'o1teys1pVoyU_tMSrf-Tw03gEH1g', 'o1teys5GyQxnX15SY60hoJy_PKi4', '1465203721');
INSERT INTO `wp_shop_bind` VALUES ('76', 'o1teys-gDeWFtcTHcoadItuuhSso', 'o1teys2fk0PhENqXR59AWleIdkv0', '1465791756');
INSERT INTO `wp_shop_bind` VALUES ('73', 'o1teys5-BrWVIgFFBcgDI-E05Dr0', 'o1teys2XWqUBdZcND9gaBMtx_kaA', '1465209908');
INSERT INTO `wp_shop_bind` VALUES ('74', 'o1teys36GpmIA-wcalnS_IQpqHWo', 'o1teyswq3Af75RIKjlUQGje0834E', '1465282003');
INSERT INTO `wp_shop_bind` VALUES ('78', 'o1teys3Upifr-eineGRs_ExJ8Ts0', 'o1teys8ChYMWJuzBXZu9sPkZnlL0', '1465813207');
INSERT INTO `wp_shop_bind` VALUES ('79', 'o1teys8HieiDbuSvhK7Y2DbIuOpA', 'o1teysymZwrgy-PTDX2mcHLq8P68', '1465975400');
INSERT INTO `wp_shop_bind` VALUES ('80', 'o1teys8HieiDbuSvhK7Y2DbIuOpA', 'o1teys-3NDf73oDn0QsHEYw7HxIY', '1465977789');
INSERT INTO `wp_shop_bind` VALUES ('82', 'o1teys8HieiDbuSvhK7Y2DbIuOpA', 'o1teysxWLujlCXKgIytuZT7cW53M', '1466039233');
INSERT INTO `wp_shop_bind` VALUES ('84', 'o1teys8SxM-wMMbCapqQhhg_CRVU', 'o1teys9NfTF9lg8JL2D8E3m76MGo', '1466089076');
INSERT INTO `wp_shop_bind` VALUES ('85', 'o1teys8SxM-wMMbCapqQhhg_CRVU', 'o1teys4h3NFuLLGzHxOf_6hMK8uU', '1466090428');
INSERT INTO `wp_shop_bind` VALUES ('86', 'o1teys8HieiDbuSvhK7Y2DbIuOpA', 'o1teys_CkUS7jGQLTwjIJ2CUd1QA', '1466140588');
INSERT INTO `wp_shop_bind` VALUES ('88', 'o1teys8HieiDbuSvhK7Y2DbIuOpA', 'o1teysy5hNKQj34ThFwT_4Vf90Rg', '1466382481');
INSERT INTO `wp_shop_bind` VALUES ('95', 'o1teys56D1mJMn4phbY3K7rYoVBI', 'o1teys-nD4dA_l_SgrpssdmdFXsM', '1468831152');
INSERT INTO `wp_shop_bind` VALUES ('96', 'o1teys56D1mJMn4phbY3K7rYoVBI', 'o1teyswP2ImN11vuwmd0_5Yf6Woc', '1469273401');
INSERT INTO `wp_shop_bind` VALUES ('97', 'o1teys56D1mJMn4phbY3K7rYoVBI', 'o1teys5mjA4aY8G35U7iTjKAPt00', '1469359300');

-- ----------------------------
-- Table structure for wp_shop_cart
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_cart`;
CREATE TABLE `wp_shop_cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` varchar(255) NOT NULL COMMENT '用户ID',
  `shop_id` varchar(255) NOT NULL COMMENT '商店id',
  `goods_id` varchar(255) NOT NULL COMMENT '商品id',
  `num` int(10) unsigned NOT NULL COMMENT '数量',
  `price` varchar(30) NOT NULL COMMENT '单价',
  `goods_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '商品类型',
  `openid` varchar(255) NOT NULL COMMENT 'openid',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_cart
-- ----------------------------
INSERT INTO `wp_shop_cart` VALUES ('3', 'o1teys08rLgEASYGgweWJoH1Xsao', '', '3', '1', '99.00', '0', '');
INSERT INTO `wp_shop_cart` VALUES ('2', 'o1teysz6mc08bAuPr5APGSW20dnU', '', '3', '1', '99.00', '0', '');
INSERT INTO `wp_shop_cart` VALUES ('17', 'o1teys2fk0PhENqXR59AWleIdkv0', '', '6', '1', '25.00', '0', '');
INSERT INTO `wp_shop_cart` VALUES ('14', 'o1teys5WETDTlnfskYEoNXS2IZss', '', '3', '2', '99.00', '0', '');
INSERT INTO `wp_shop_cart` VALUES ('18', 'o1teys2fk0PhENqXR59AWleIdkv0', '', '3', '1', '99.00', '0', '');
INSERT INTO `wp_shop_cart` VALUES ('19', 'o1teys3gugBUjzvsIs_yYRVqQiec', '', '22', '1', '66.00', '0', '');
INSERT INTO `wp_shop_cart` VALUES ('21', 'o1teyszu1qNiSJJwai60rOo4UW1A', '', '15', '1', '79.00', '0', '');
INSERT INTO `wp_shop_cart` VALUES ('23', 'o1teysyEa4ZLo9kQTJ6WJQT5Dkik', '', '24', '1', '76.00', '0', '');
INSERT INTO `wp_shop_cart` VALUES ('24', 'o1teysyEa4ZLo9kQTJ6WJQT5Dkik', '', '22', '1', '80.00', '0', '');
INSERT INTO `wp_shop_cart` VALUES ('25', 'o1teyszW7o7sQ4z37yPI6yN5IPn4', '', '3', '1', '99.00', '0', '');
INSERT INTO `wp_shop_cart` VALUES ('26', 'o1teys_Mcpj-ydMdrWihu7_gKFsk', '', '3', '1', '99.00', '0', '');
INSERT INTO `wp_shop_cart` VALUES ('27', 'o1teysyGg8_ckqJzKeAweCzI8kwI', '', '3', '1', '99.00', '0', '');
INSERT INTO `wp_shop_cart` VALUES ('28', 'o1teys5Gzp44gvjNqHUk5T4w_txQ', '', '25', '1', '88.00', '0', '');

-- ----------------------------
-- Table structure for wp_shop_cash
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_cash`;
CREATE TABLE `wp_shop_cash` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `openid` varchar(255) NOT NULL,
  `apply_time` int(10) unsigned NOT NULL,
  `alipay` varchar(255) NOT NULL,
  `apply_money` decimal(10,2) unsigned NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `dateline` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_cash
-- ----------------------------
INSERT INTO `wp_shop_cash` VALUES ('1', 'o1teysyjFEoTsZRRVprjExU6w4EE', '1467771584', '13005925270', '12.00', '2', null);
INSERT INTO `wp_shop_cash` VALUES ('2', 'o1teys_TnbMJ08GlKeTruOaIdkgA', '1467948078', 'weixiuxi@163.com', '9.00', '2', null);
INSERT INTO `wp_shop_cash` VALUES ('3', 'o1teys2fjdJbcE--zaLdyFTJl2lg', '1469169855', '284838030@qq.com', '4.00', '2', null);

-- ----------------------------
-- Table structure for wp_shop_collect
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_collect`;
CREATE TABLE `wp_shop_collect` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` varchar(255) DEFAULT NULL COMMENT '使用UID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `cTime` int(10) DEFAULT NULL COMMENT '收藏时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_collect
-- ----------------------------

-- ----------------------------
-- Table structure for wp_shop_commission_log
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_commission_log`;
CREATE TABLE `wp_shop_commission_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `agent_openid` varchar(255) NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `msg` varchar(255) NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_commission_log
-- ----------------------------
INSERT INTO `wp_shop_commission_log` VALUES ('1', 'o1teysy_HdOBTKvdeMMDViaby4d4', '9', '您从*4177订单中获得12.40元佣金', '1463822880');
INSERT INTO `wp_shop_commission_log` VALUES ('2', 'o1teysy_HdOBTKvdeMMDViaby4d4', '8', '您从*0150订单中获得10.80元佣金', '1463843476');
INSERT INTO `wp_shop_commission_log` VALUES ('3', 'o1teysy_HdOBTKvdeMMDViaby4d4', '7', '您从*3767订单中获得10.80元佣金', '1463843488');
INSERT INTO `wp_shop_commission_log` VALUES ('4', 'o1teysxSSrfPUmb_WELwwDSalNQY', '17', '您从*6591订单中获得19.80元佣金', '1464709502');
INSERT INTO `wp_shop_commission_log` VALUES ('5', 'o1teys7n2VqVKXbF_i7LDfT8zCaM', '11', '您从*7431订单中获得12.40元佣金', '1465279987');
INSERT INTO `wp_shop_commission_log` VALUES ('6', 'o1teysyjFEoTsZRRVprjExU6w4EE', '24', '您从*4876订单中获得12.40元佣金', '1465705718');
INSERT INTO `wp_shop_commission_log` VALUES ('7', 'o1teys8yfbfHOhCIXHgpTrV_IumU', '16', '您从*6605订单中获得2.00元佣金', '1465725170');
INSERT INTO `wp_shop_commission_log` VALUES ('8', 'o1teysxSSrfPUmb_WELwwDSalNQY', '19', '您从*1184订单中获得29.70元佣金', '1465791202');
INSERT INTO `wp_shop_commission_log` VALUES ('9', 'o1teys_TnbMJ08GlKeTruOaIdkgA', '34', '您从*6261订单中获得9.90元佣金', '1466731405');
INSERT INTO `wp_shop_commission_log` VALUES ('10', 'o1teys8yfbfHOhCIXHgpTrV_IumU', '43', '您从*8578订单中获得19.80元佣金', '1467455641');
INSERT INTO `wp_shop_commission_log` VALUES ('11', 'o1teysxSSrfPUmb_WELwwDSalNQY', '45', '您从*7627订单中获得10.62元佣金', '1468133187');
INSERT INTO `wp_shop_commission_log` VALUES ('12', 'o1teysxSSrfPUmb_WELwwDSalNQY', '48', '您从*6508订单中获得29.70元佣金', '1468133209');
INSERT INTO `wp_shop_commission_log` VALUES ('13', 'o1teys2fjdJbcE--zaLdyFTJl2lg', '50', '您从*4989订单中获得4.64元佣金', '1468228977');

-- ----------------------------
-- Table structure for wp_shop_coupon
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_coupon`;
CREATE TABLE `wp_shop_coupon` (
  `coupon_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` varchar(255) NOT NULL,
  `sign` varchar(32) NOT NULL,
  `from` varchar(255) DEFAULT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  `get_time` int(10) unsigned DEFAULT NULL,
  `use_time` int(10) unsigned DEFAULT NULL,
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '0未使用，1已使用，2已赠送',
  PRIMARY KEY (`coupon_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_coupon
-- ----------------------------
INSERT INTO `wp_shop_coupon` VALUES ('1', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '07008d590e38616dc558f5d4164380db', null, '61', '1470664175', null, '0');

-- ----------------------------
-- Table structure for wp_shop_daili_store
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_daili_store`;
CREATE TABLE `wp_shop_daili_store` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `open_id` varchar(255) NOT NULL COMMENT '代理人微信ID',
  `provinces` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `county` varchar(100) NOT NULL,
  `address` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_daili_store
-- ----------------------------
INSERT INTO `wp_shop_daili_store` VALUES ('1', 'o1teys2GjrPml9z27-qTlc3Qad14', '', '', '', null);

-- ----------------------------
-- Table structure for wp_shop_daili_store_goods
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_daili_store_goods`;
CREATE TABLE `wp_shop_daili_store_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `daili_id` int(11) unsigned NOT NULL COMMENT 'daili_store表关联ID',
  `goods_id` int(11) unsigned NOT NULL COMMENT '商品ID',
  `number` int(11) unsigned NOT NULL COMMENT '商品数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_daili_store_goods
-- ----------------------------
INSERT INTO `wp_shop_daili_store_goods` VALUES ('1', '1', '3', '9');

-- ----------------------------
-- Table structure for wp_shop_evaluation
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_evaluation`;
CREATE TABLE `wp_shop_evaluation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  `buyer_openid` varchar(255) NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL,
  `msg` varchar(500) NOT NULL,
  `datetime` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_evaluation
-- ----------------------------
INSERT INTO `wp_shop_evaluation` VALUES ('3', '8', '4', 'o1teys39jDjN56TGWhmKib6Awjek', '林夕梦', '2', '发货很快，第二天就到了，同省收货哈！樱桃', '1463556169');
INSERT INTO `wp_shop_evaluation` VALUES ('2', '5', '2', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '大官人', '2', '发货好快', '1463461058');
INSERT INTO `wp_shop_evaluation` VALUES ('5', '11', '9', 'o1teysy_HdOBTKvdeMMDViaby4d4', '小潘潘', '2', '个头大，超级新鲜，没有让我失望，推荐大家放心购买', '1463843663');
INSERT INTO `wp_shop_evaluation` VALUES ('6', '8', '8', 'o1teysy_HdOBTKvdeMMDViaby4d4', '小潘潘', '2', '朋友推荐购买的，值得信赖，很好吃', '1463843816');
INSERT INTO `wp_shop_evaluation` VALUES ('7', '8', '10', 'o1teys_KAj3bWXOvJsK4cLyvrwnQ', 'sSVv', '2', '老板人超好的，樱桃酸酸甜甜，好吃', '1463994918');
INSERT INTO `wp_shop_evaluation` VALUES ('8', '8', '10', 'o1teys_KAj3bWXOvJsK4cLyvrwnQ', 'sSVv', '2', '老板人超好的，樱桃酸酸甜甜，好吃', '1463994923');
INSERT INTO `wp_shop_evaluation` VALUES ('9', '8', '7', 'o1teysy_HdOBTKvdeMMDViaby4d4', '小潘潘', '2', '好的不要不要的', '1464012619');
INSERT INTO `wp_shop_evaluation` VALUES ('10', '8', '7', 'o1teysy_HdOBTKvdeMMDViaby4d4', '小潘潘', '2', '好的不要不要的', '1464012629');
INSERT INTO `wp_shop_evaluation` VALUES ('11', '8', '7', 'o1teysy_HdOBTKvdeMMDViaby4d4', '小潘潘', '2', '好的不要不要的', '1464012632');
INSERT INTO `wp_shop_evaluation` VALUES ('12', '3', '19', 'o1teysxSSrfPUmb_WELwwDSalNQY', '蓝心怡', '2', '肉质非常好，汤鲜甜。值得拥有', '1465811545');
INSERT INTO `wp_shop_evaluation` VALUES ('13', '3', '19', 'o1teysxSSrfPUmb_WELwwDSalNQY', '蓝心怡', '2', '肉质非常好，汤鲜甜。值得拥有', '1465811703');
INSERT INTO `wp_shop_evaluation` VALUES ('14', '3', '19', 'o1teysxSSrfPUmb_WELwwDSalNQY', '蓝心怡', '2', '肉质非常好，汤鲜甜。值得拥有', '1465811722');
INSERT INTO `wp_shop_evaluation` VALUES ('15', '11', '24', 'o1teysyjFEoTsZRRVprjExU6w4EE', '苏映云', '2', '虽然颜色不是很红，但是好甜好甜的樱桃，个头均匀，没有烂果，好评！还会再来的(^o^)', '1466667991');
INSERT INTO `wp_shop_evaluation` VALUES ('16', '11', '24', 'o1teysyjFEoTsZRRVprjExU6w4EE', '苏映云', '2', '虽然颜色不是很红，但是好甜好甜的樱桃，个头均匀，没有烂果，好评！还会再来的(^o^)', '1466668001');

-- ----------------------------
-- Table structure for wp_shop_goods
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_goods`;
CREATE TABLE `wp_shop_goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cover` varchar(255) DEFAULT NULL COMMENT '商品封面图',
  `content` text NOT NULL COMMENT '商品介绍',
  `title` varchar(255) NOT NULL COMMENT '商品名称',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '价格',
  `commission` tinyint(7) unsigned DEFAULT NULL,
  `imgs` varchar(255) NOT NULL COMMENT '商品图片',
  `inventory` int(10) DEFAULT '0' COMMENT '库存数量',
  `shop_id` int(10) DEFAULT '0' COMMENT '商店ID',
  `is_show` tinyint(2) DEFAULT '0' COMMENT '是否上架',
  `sale_count` int(10) DEFAULT '0' COMMENT '销售量',
  `is_recommend` tinyint(2) DEFAULT NULL COMMENT '是否推荐',
  `rank` int(10) DEFAULT '0' COMMENT '热销度',
  `show_time` int(10) DEFAULT '0' COMMENT '上架时间',
  `old_price` int(10) DEFAULT NULL COMMENT '原价',
  `type` tinyint(2) DEFAULT '0' COMMENT '商品类型',
  `category_id` char(50) DEFAULT NULL COMMENT '商品分类',
  `sort` int(10) DEFAULT '0',
  `reserve` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '预定1',
  `reserve_time` int(10) unsigned DEFAULT NULL COMMENT '领取时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_goods
-- ----------------------------
INSERT INTO `wp_shop_goods` VALUES ('3', 'goods/2016/05/28/201605281114021850.jpg', '<p>\r\n 订购须知：\r\n</p>\r\n<p>\r\n 1、<span [removed]>该产品目前只在广西南宁市、百色市内免费配送，其他地区购买前请咨询客服。</span> \r\n</p>\r\n<p>\r\n <span [removed]>2、如需杀好请在下单时给我们留言，不另收费用。</span>\r\n</p>\r\n<p>\r\n <span [removed]>3、陈王山灵芝鸡（项鸡）一只均重为3斤。</span> \r\n</p>\r\n<p>\r\n <span [removed]>4、当天18：00前下单正常第二天送达，由于该产品都是下单后直接从基地发货，会因天气等原因造成延迟发货，但我们承诺三天内送达。</span> \r\n</p>\r\n<p>\r\n <span [removed]><br />\r\n</span> \r\n</p>\r\n<h3>\r\n <span [removed]>前100名买一只灵芝鸡送一个野生黑灵芝，送完即止！</span> \r\n</h3>\r\n<p>\r\n <span [removed]><img src=\"/imgs/goods/2016/05/16/201605161432213953.jpg\" alt=\"\"><br />\r\n</span> \r\n</p>\r\n<img src=\"/imgs/goods/2016/05/16/201605161432582131.jpg\" alt=\"\"><br />\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/16/201605161433228999.jpg\" alt=\"\"> \r\n</p>', '陈王山灵芝鸡-项鸡 均重3斤99元/只 可帮杀好', '99.00', '10', 'goods/2016/05/28/201605281114021850.jpg,goods/2016/05/28/201605281114027457.jpg,goods/2016/05/28/201605281114027877.jpg,goods/2016/05/28/201605281114028018.jpg,goods/2016/05/28/201605281114031990.jpg', '999', '0', '1', '58', '1', '0', '0', '119', '0', '1', '2', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('4', 'goods/2016/06/03/201606031414501010.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1、本品目前只支持广西南宁市、百色市内免费配送，其他地区下单前请咨询客服。\r\n</p>\r\n<p>\r\n 2、当天18:00前下单正常第二天送达，因本品均是下单后直接从基地发货，会因天气等原因延迟发货，但我们承诺三天内送达，望知悉。\r\n</p>\r\n<p>\r\n <br />\r\n</p>\r\n<h3>\r\n 产品简介：\r\n</h3>\r\n<p class=\"MsoNormal\">\r\n 老山香鸭产于“百色清水麻鸭之乡”的利周瑶族乡，全程自然放养，养殖周期长达<span>150</span>天。喂玉米<span>,</span>青菜等纯天然，无公害，无激素的食物。另外凭借岑王老山国家级自然保护区优越的地理位置，无污染的水资源和清新的空气等条件，享有得天独厚的养殖环境优势。\r\n</p>\r\n<p class=\"MsoNormal\">\r\n <img src=\"/imgs/goods/2016/05/16/201605161410356056.jpg\" alt=\"\"> \r\n</p>\r\n<p [removed]>\r\n <span [removed]></span><span [removed]>优质的养殖环境</span> \r\n </p>\r\n<p [removed]><span [removed]><img src=\"/imgs/goods/2016/05/16/201605161412116616.jpg\" alt=\"\"><br />\r\n</span> \r\n</p>\r\n<p [removed]>\r\n <span [removed]>清水中自然放养</span> \r\n </p>\r\n<p [removed]><img src=\"/imgs/goods/2016/05/16/201605161412344514.jpg\" alt=\"\"> \r\n</p>\r\n<p [removed]><br />\r\n </p>\r\n<p [removed]>\r\n <span [removed]>清蒸白切鸭</span> \r\n</p>\r\n<p [removed]><span [removed]><img src=\"/imgs/goods/2016/05/16/201605161412518859.jpg\" alt=\"\"><br />\r\n</span> \r\n </p>\r\n<p [removed]><span [removed]>荣誉实至名归</span> \r\n</p>', '老山香鸭 正宗土鸭 均重4.5~5斤118元/只', '118.00', '9', 'goods/2016/06/03/201606031414501010.jpg,goods/2016/06/03/201606031414575915.jpg,goods/2016/06/03/201606031415078157.jpg,goods/2016/06/03/201606031415079139.jpg,goods/2016/06/03/201606031415079839.jpg', '999', '0', '1', '13', '1', '0', '0', '139', '0', '1', '3', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('5', 'goods/2016/05/23/201605231134495354.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1、本品目前只在广西南宁市、百色市内免费配送，其他地区购买前请咨询客服。\r\n</p>\r\n<p>\r\n 2、本品下单后三天内送达。\r\n</p>\r\n<h3>\r\n 简介：\r\n</h3>\r\n<p>\r\n 野生党参又叫土党参，味香甜，可生吃。常用于炖骨头、炖鸡汤、泡药酒等。\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/16/201605161406121290.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n 自然生长，非种植\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/16/201605161406334374.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n 清洗后的鲜党参\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/16/201605161406532551.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n 一扎约1斤\r\n</p>', '野生党参 土党参 一扎均重约1斤 20元/扎', '20.00', '10', 'goods/2016/05/23/201605231134495354.jpg,goods/2016/05/23/201605231134496616.jpg,goods/2016/05/23/201605231134496756.jpg,goods/2016/05/23/201605231134497317.jpg', '500', '0', '1', '1', '1', '0', '0', '25', '0', '2', '14', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('6', 'goods/2016/05/23/201605231132499839.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1、本品目前只支持广西南宁市、百色市内免费配送，其他地区请在购买前咨询客服。\r\n</p>\r\n<p>\r\n 2.本品一盒10枚装，净重约0.8斤。\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/16/201605161435176056.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/16/201605161435395495.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/16/201605161435571990.jpg\" alt=\"\"> \r\n</p>', '灵芝鸡蛋 聪明蛋美容蛋 10枚装重约0.8斤25元', '25.00', '8', 'goods/2016/05/23/201605231132499839.jpg,goods/2016/05/23/201605231132499699.jpg,goods/2016/05/23/201605231132503532.jpg,goods/2016/05/23/201605231132506475.jpg', '1000', '0', '1', '4', '1', '0', '0', '29', '0', '1', '16', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('7', 'goods/2016/05/16/201605161352344233.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1、本品目前只支持在广西南宁市、百色市内免费配送。\r\n</p>\r\n<p>\r\n 2、本品现挖现卖，下单后1~2天内发货。\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/16/201605161353181850.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n 刚挖出来的野生淮山\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/16/201605161353388298.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n 削皮后洗净的野生淮山\r\n</p>', '野生淮山 现挖现卖 20元/斤 一斤起定', '20.00', '8', 'goods/2016/05/16/201605161352344233.jpg,goods/2016/05/16/201605161352344514.jpg,goods/2016/05/16/201605161352347877.jpg', '1000', '0', '0', '1', '0', '0', '0', '25', '0', '2', '12', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('8', 'goods/2016/05/16/201605162223096756.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1、该品目前只支持在广西南宁市内免费配送，其他地区顺丰到付，不包邮。\r\n</p>\r\n<p>\r\n 2、该品没有库存，下单后直接从山东基地空运而来，下单后请耐心等待数日。\r\n</p>\r\n<p>\r\n <br />\r\n</p>\r\n<h3>\r\n 产品简介：\r\n</h3>\r\n<p>\r\n 口感：酸甜\r\n</p>\r\n<p>\r\n 特征：果个大，果实椭圆，外观色泽艳丽，甜，带少许酸，汁多肉厚，风味好、品质佳\r\n</p>\r\n<p>\r\n <br />\r\n</p>\r\n<h3>\r\n 我们承诺：\r\n</h3>\r\n<p class=\"MsoNormal\">\r\n 全程空运，冷链运输。从下树到客户手中，不超过<span>24</span>小时。\r\n</p>\r\n<p class=\"MsoNormal\">\r\n <img src=\"/imgs/goods/2016/05/16/201605162236258859.jpg\" alt=\"\"> \r\n</p>\r\n<p class=\"MsoNormal\">\r\n <img src=\"/imgs/goods/2016/05/16/201605162236523392.jpg\" alt=\"\"> \r\n</p>\r\n<p class=\"MsoNormal\">\r\n <img src=\"/imgs/goods/2016/05/16/201605162237119139.jpg\" alt=\"\"> \r\n</p>\r\n<p class=\"MsoNormal\">\r\n <img src=\"/imgs/goods/2016/05/16/201605162237281010.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n <br />\r\n</p>', '红灯樱桃 山东一级樱桃全程冷链空运135元/5斤', '135.00', '8', 'goods/2016/05/16/201605162223096756.jpg,goods/2016/05/16/201605162223099559.jpg,goods/2016/05/16/201605162223099839.jpg,goods/2016/05/16/201605162223117738.jpg', '1000', '0', '0', '14', '1', '0', '0', '168', '0', '3', '15', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('9', 'goods/2016/05/16/201605162240253112.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1、该品目前只支持在广西南宁市免费配送，其他地区购买前请咨询客服。\r\n</p>\r\n<p>\r\n 2、该品没有库存，购买后直接从山东基地空运而来，下单后请耐心等待数日。\r\n</p>\r\n<p>\r\n <br />\r\n</p>\r\n<h3>\r\n 产品简介：\r\n</h3>\r\n<p>\r\n 口感：脆甜\r\n</p>\r\n<p>\r\n 特征：果实大型，果型肾脏性，果皮红色，光泽艳丽，肉质脆硬、肥厚，汁多，风味好，品质佳。\r\n</p>\r\n<p>\r\n <br />\r\n</p>\r\n<h3>\r\n 我们承诺：\r\n</h3>\r\n<p>\r\n <p class=\"MsoNormal\">\r\n  全程空运，冷链运输。从下树到客户手中，不超过<span>24</span>小时\r\n </p>\r\n<img src=\"/imgs/goods/2016/05/16/201605162247062271.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/16/201605162247213392.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/16/201605162247383953.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n <br />\r\n</p>', '山东樱桃 先锋 基地直发 全程冷链 50元/斤', '50.00', '10', 'goods/2016/05/16/201605162240253112.jpg,goods/2016/05/16/201605162240253813.jpg,goods/2016/05/16/201605162240384654.jpg', '1000', '0', '0', '0', '0', '0', '0', '60', '0', '3', null, '0', null);
INSERT INTO `wp_shop_goods` VALUES ('10', 'goods/2016/05/16/201605162251318859.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n <p [removed]>\r\n  1、该品目前只支持在广西南宁市免费配送，其他地区购买前请咨询客服。\r\n </p>\r\n <p>\r\n  2、该品没有库存，购买后直接从山东基地空运而来，下单后请耐心等待数日。\r\n </p>\r\n <p>\r\n  <br />\r\n </p>\r\n <h3>\r\n  产品简介：\r\n </h3>\r\n <p>\r\n  口感：甜\r\n </p>\r\n <p>\r\n  特征：果个大，色泽艳丽，果肉肥厚，耐运输，果皮呈紫红色，外形美观，果肉紫红，口感脆甜爽口，号称樱桃之王，与进口顶级车厘子口感一致。 \r\n </p>\r\n <p>\r\n  <br />\r\n </p>\r\n <h3>\r\n  我们承诺：\r\n </h3>\r\n <p>\r\n  <p class=\"MsoNormal\">\r\n   全程空运，冷链运输。从下树到客户手中，不超过<span>24</span>小时\r\n  </p>\r\n<img src=\"/imgs/goods/2016/05/16/201605162254451290.jpg\" alt=\"\">\r\n </p>\r\n <p>\r\n  <img src=\"/imgs/goods/2016/05/16/201605162254592832.jpg\" alt=\"\">\r\n </p>\r\n <p>\r\n  <img src=\"/imgs/goods/2016/05/16/201605162255232551.jpg\" alt=\"\">\r\n </p>\r\n <p>\r\n  <img src=\"/imgs/goods/2016/05/16/201605162255445074.png\" alt=\"\"><br />\r\n </p>\r\n</p>', '山东樱桃 美早 基地直发 全程空运 50元/斤', '50.00', '10', 'goods/2016/05/16/201605162251318859.jpg,goods/2016/05/16/201605162251319139.jpg,goods/2016/05/16/201605162251319420.jpg,goods/2016/05/16/201605162251357036.png', '1000', '0', '0', '0', '0', '0', '0', '60', '0', '3', null, '0', null);
INSERT INTO `wp_shop_goods` VALUES ('11', 'goods/2016/05/23/201605231131265495.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n <br />\r\n</p>\r\n<p [removed]>\r\n  1、该品目前只支持在广西南宁市免费配送，其他地区顺丰到付，不包邮。\r\n </p>\r\n <p>\r\n  2、该品没有库存，购买后直接从山东基地空运而来，下单后请耐心等待数日。\r\n </p>\r\n <p>\r\n  <br />\r\n </p>\r\n <h3>\r\n  产品简介：\r\n </h3>\r\n <p>\r\n  口感：甜\r\n </p>\r\n <p>\r\n  特征：果实为黄色，晶莹剔透非常可爱，皮薄柔软，汁多，是所有大樱桃品种中口感最好，甜度最高的品种，缺点不耐贮存 。\r\n </p>\r\n <p>\r\n  <br />\r\n </p>\r\n <h3>\r\n  我们承诺：\r\n </h3>\r\n <p>\r\n  <br />\r\n </p>\r\n <p class=\"MsoNormal\">\r\n  全程空运，冷链运输。从下树到客户手中，不超过<span>24</span>小时\r\n </p>\r\n <p class=\"MsoNormal\">\r\n  <img src=\"/imgs/goods/2016/05/17/201605171021128438.jpg\" alt=\"\"> \r\n </p>\r\n <p class=\"MsoNormal\">\r\n  <br />\r\n </p>\r\n <p class=\"MsoNormal\">\r\n  <img src=\"/imgs/goods/2016/05/16/201605162302339420.jpg\" alt=\"\"> \r\n </p>\r\n <p class=\"MsoNormal\">\r\n  <img src=\"/imgs/goods/2016/05/16/201605162302548999.jpg\" alt=\"\"> \r\n </p>\r\n <p class=\"MsoNormal\">\r\n  <img src=\"/imgs/goods/2016/05/16/201605162303152271.jpg\" alt=\"\"> \r\n </p>\r\n <p class=\"MsoNormal\">\r\n  <br />\r\n </p>\r\n <p>\r\n  <br />\r\n </p>\r\n <p>\r\n  <br />\r\n </p>', '黄蜜樱桃 山东一级樱桃全程冷链空运155元/5斤', '155.00', '8', 'goods/2016/05/23/201605231131265495.jpg,goods/2016/05/23/201605231131266756.jpg,goods/2016/05/23/201605231131269420.jpg,goods/2016/05/23/201605231131269839.jpg', '1000', '0', '0', '6', '1', '0', '0', '200', '0', '3', '12', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('13', 'goods/2016/05/24/201605240018544934.jpg', '<p class=\"MsoNormal\">\r\n 灵芝药用在我国已有2000多年的历史，被历代医药家视为滋补强壮、扶正固本的神奇珍品。经过大量临床研究，灵芝对神经衰弱、高脂血症、冠心病心绞痛、心律失常、克山病、高原不适症、肝炎、出血热、消化不良、气管炎、等各有不同程度的疗效。\r\n</p>\r\n<p class=\"MsoNormal\">\r\n <img src=\"/imgs/goods/2016/05/24/201605240003018578.jpg\" alt=\"\">\r\n</p>\r\n<p class=\"MsoNormal\">\r\n <strong>灵芝可保肝解毒：</strong><span [removed]>灵芝对多种理化及生物因素引起的肝损伤有保护作用。无论在肝脏损害发生前还是发生后，服用灵芝都可保护肝脏，减轻肝损伤。灵芝还能促进肝脏对药物、毒物的代谢，对于中毒性肝炎</span><span [removed]>有确切的疗效。尤其是慢性肝炎，灵芝可明显消除头晕、乏力、恶心、肝区不适等症状，并可有效地改善肝功能，使各项指标趋于正常。所以，灵芝可用于治疗慢性中毒、各类慢性肝炎、肝硬化、肝功能障碍。</span>\r\n</p>\r\n<p class=\"MsoNormal\">\r\n <span [removed]><img src=\"/imgs/goods/2016/05/24/201605240007164514.jpg\" alt=\"\"></span>\r\n</p>\r\n<p class=\"MsoNormal\">\r\n <strong>灵芝可治疗糖尿病：</strong><span [removed]>灵芝降血糖之原理是由于促进组织对糖的利用。服用灵芝后可取代胰岛素抑制脂肪酸的释出，可改善血糖、尿糖等症状。灵芝中的水溶性多糖，可减轻非胰岛素依赖型糖尿病的发病程度。</span>\r\n</p>\r\n<p class=\"MsoNormal\">\r\n <span [removed]><img src=\"/imgs/goods/2016/05/24/201605240008291850.jpg\" alt=\"\"></span>\r\n</p>\r\n<p class=\"MsoNormal\">\r\n <strong>灵芝可改善心血管系统：</strong><span [removed]>动物实验和临床试验均表明，灵芝可有效地扩张冠状动脉，</span><span [removed]>增加冠脉血流量，改善心肌微循环，增强心肌氧和能量的供给，因此，对心肌缺血具有保护作用，可广泛用于冠心病、心绞痛等的治疗和预防。对高血脂病患者，灵芝可明显降低血胆固醇、脂蛋白和甘油三脂，并能预防动脉粥样硬化斑块的形成。对于粥样硬化斑块已经形成者，则有降低动脉壁胆固醇含量、软化血管、防止进一步损伤的作用。并可改善局部微循环，阻止血小板聚集。这些功效对于多种类型的中风有良好的防治作用。</span>\r\n</p>\r\n<p class=\"MsoNormal\">\r\n <span [removed]><img src=\"/imgs/goods/2016/05/24/201605240009381010.jpg\" alt=\"\"></span>\r\n</p>\r\n<p class=\"MsoNormal\">\r\n <strong>灵芝可肌肤美白：</strong><span [removed]>李时珍在《本草纲目》中就指出灵芝有“增智慧，好颜色”，灵芝是一种具有抗皱、消炎、清除色斑、保护皮肤。灵芝含有抑制黑色素的成分及多种对皮肤有益的微量元素等，这些成分能够通过减少人体自由基，加速细胞的再生，增加皮肤的厚度并增加胶原质，达到丰润皮肤、消除细纹与皱纹的效果。其中的多糖成分能够通过保持和调节皮肤水性，恢复皮肤弹性，使皮肤湿润、细腻。</span>\r\n</p>\r\n<p class=\"MsoNormal\">\r\n <span [removed]><img src=\"/imgs/goods/2016/05/24/201605240011181990.jpg\" alt=\"\"><br />\r\n</span>\r\n</p>\r\n<p class=\"MsoNormal\">\r\n <span [removed]><br />\r\n</span>\r\n</p>\r\n<p class=\"MsoNormal\">\r\n <span [removed]>\r\n <p [removed]>\r\n  <br />\r\n </p>\r\n</span>\r\n</p>\r\n<p class=\"MsoNormal\">\r\n <span [removed]><br />\r\n</span>\r\n</p>\r\n<p class=\"MsoNormal\">\r\n</p>', '野生黑灵芝 采自岑王老山原始森林  258元/斤 ', '258.00', '8', 'goods/2016/05/24/201605240018544934.jpg,goods/2016/05/24/201605240019058157.jpg,goods/2016/05/24/201605240019191150.jpg,goods/2016/05/24/201605240019343392.jpg', '100', '0', '1', '0', '0', '0', '0', '300', '0', '2', '8', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('14', 'goods/2016/05/27/201605271033189559.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1.本品在广西南宁市内包邮，其他地区邮费到付。\r\n</p>\r\n<p>\r\n 2.下单后3~4天发货。\r\n</p>\r\n<h3>\r\n 产品介绍：\r\n</h3>\r\n<p>\r\n 此山茶油为自家自产自榨，父辈种的茶籽树，树龄已有30多年，属传统的野山茶树品种，非改良非嫁接品种。每年除了采收前去砍一次草，平时不做任何护理。\r\n</p>\r\n<h3>\r\n 保健作用：\r\n</h3>\r\n<p>\r\n 1.<span [removed]>孕妇在孕期食用山茶油不仅可以增加母乳，而且对胎儿的正常发育十分有益。</span> \r\n</p>\r\n<p>\r\n 2.孕妇<span [removed]>后期皮肤拉伸，易出现瘙痒和干裂现象，每天清晨用山茶油涂抹，可预防缓解。</span> \r\n</p>\r\n<p>\r\n <span [removed]>3.婴儿尿疹、湿疹，用山茶油直接涂于患处，安全有效。</span> \r\n</p>\r\n<p>\r\n <span [removed]>4.老年人食用茶油可以去火、养颜、明目、乌发、抑制衰老、长寿健康。</span> \r\n</p>\r\n<p>\r\n <span [removed]><img src=\"/imgs/goods/2016/05/27/201605271059111990.jpg\" alt=\"\"><br />\r\n</span> \r\n</p>\r\n<p>\r\n <span [removed]>高山上自然生长</span> \r\n</p>\r\n<p>\r\n <span [removed]><img src=\"/imgs/goods/2016/05/27/201605271100004794.jpg\" alt=\"\"><br />\r\n</span> \r\n</p>\r\n<p>\r\n <span [removed]>手工采摘后自然晾晒</span><span [removed]></span> \r\n</p>\r\n<p>\r\n <span [removed]><img src=\"/imgs/goods/2016/05/27/201605271101123532.jpg\" alt=\"\"><br />\r\n</span> \r\n</p>\r\n<p>\r\n <span [removed]>手工去壳<br />\r\n</span> \r\n</p>\r\n<p>\r\n <span [removed]><img src=\"/imgs/goods/2016/05/27/201605271101435214.jpg\" alt=\"\"><br />\r\n</span> \r\n</p>\r\n<p>\r\n <span [removed]>全物理压榨</span> \r\n</p>\r\n<p>\r\n <span [removed]><img src=\"/imgs/goods/2016/05/27/201605271102311150.jpg\" alt=\"\"><br />\r\n</span> \r\n</p>\r\n<p>\r\n <span [removed]>手工装桶</span> \r\n</p>', '自榨山茶油茶籽油30年老树物理压榨39.9元/斤', '39.90', '8', 'goods/2016/05/27/201605271033189559.jpg,goods/2016/05/27/201605271033194233.jpg,goods/2016/05/27/201605271033196056.jpg,goods/2016/05/27/201605271033197036.jpg,goods/2016/05/27/201605271033201711.jpg', '100', '0', '1', '0', '0', '0', '0', '58', '0', '2', '7', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('15', 'goods/2016/05/27/201605271203483532.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1.本品为正宗广西田林县岑王老山原始森林野生百花蜜，请放心购买。\r\n</p>\r\n<p>\r\n 2.本品全国包邮（<span [removed]>港澳台，新疆、西藏、内蒙古、甘肃、宁夏、青海、吉林、黑龙江等偏远地区除外）</span> \r\n</p>\r\n<p>\r\n 3.下单后2~3天发货。\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/27/201605271149224514.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 本人正在挖地下的蜂蜜，有图有真相\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/27/201605271152158298.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 悬崖上的野蜂蜜\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/27/201605271153154093.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 树洞中的野蜂蜜\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/27/201605271158164233.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 石缝中的野蜂蜜\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/05/27/201605271159405074.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 刚刚出土的野蜂蜜\r\n</p>', '正宗野生蜂蜜 岑王老山原始森林百花蜜79元/斤', '79.00', '15', 'goods/2016/05/27/201605271203483532.jpg,goods/2016/05/27/201605271204156756.jpg,goods/2016/05/27/201605271204159699.jpg,goods/2016/05/27/201605271204161430.jpg,goods/2016/05/27/201605271204161990.jpg', '100', '0', '1', '41', '0', '0', '0', '120', '0', '2', '5', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('16', 'goods/2016/06/01/201606011605497177.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1.本品全国包邮（新疆、西藏、内蒙古、青海、黑龙江等偏远地区除外）\r\n</p>\r\n<p>\r\n 2。拍一件发五斤（装3~4个），拍两件发10斤，以此类推。。。\r\n</p>\r\n<h3>\r\n 产品简介：\r\n</h3>\r\n<p>\r\n 本品为荔浦县产地农场直供，自家农场，农家肥种植，农家的，最好的，有机荔浦芋头，吃得放心。\r\n</p>\r\n<p>\r\n 荔浦芋头中品种之差异为【最次品大仔竽】【居中为排】【极品为紫藤芋】。发货芋头为荔浦芋头极品——紫藤芋！香！粉！糯！俱全——原产地荔浦县发货。\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/01/201606011537121010.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 三包承诺：\r\n</p>\r\n<p>\r\n 1.包正宗，不正宗包退。\r\n</p>\r\n<p>\r\n 2.包香粉糯好吃，不香粉糯包退。\r\n</p>\r\n<p>\r\n 3.收到芋头24小时内反馈有坏包赔（需要拍照）\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/01/201606011541213252.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 每个芋头都是经过我们精心挑选送到您手上的\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/01/201606011543065915.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 真正的桂林荔浦芋头外形要素：中间大，两头小，尾巴歪，表面粗糙；口味特点：粉，香，糯\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/01/201606011546394374.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/01/201606011547337457.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/01/201606011548091990.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/01/201606011548416475.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/01/201606011549003532.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/01/201606011549355495.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/01/201606011550068859.jpg\" alt=\"\"> \r\n</p>', '桂林荔浦芋头 5斤装 正宗皇室贡品50元包邮', '50.00', '1', 'goods/2016/06/01/201606011605497177.jpg,goods/2016/06/01/201606011606036896.jpg,goods/2016/06/01/201606011606036616.jpg,goods/2016/06/01/201606011606049699.jpg,goods/2016/06/01/201606011606051850.jpg', '100', '0', '1', '0', '0', '0', '0', '68', '0', '2', '13', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('17', 'goods/2016/06/01/201606011636542972.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1.本品全国包邮（新疆、西藏、青海、内蒙古等偏远地区除外）\r\n</p>\r\n<p>\r\n 2.本品为自家熟咸烤海鸭蛋，非蛋厂生产。\r\n</p>\r\n<h3>\r\n 产品简介：\r\n</h3>\r\n<p>\r\n 自己腌制的海鸭选用海鸭蛋精品作为腌制主材料，采用传统草木灰进行腌制，咸香味正，鲜细嫩松沙软，口感比蛋厂生产的更好。\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/01/201606011650565214.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 多油，夏季吃粥好伴侣\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/01/201606011652176056.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/01/201606011652459559.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 个大，精选海鸭蛋比一般的鸭蛋要大得多\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/01/201606011653402692.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 营养价值高，蛋白质是普通鸡蛋的2倍\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/01/201606011655058999.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 20枚装，人性化包装，经济实惠\r\n</p>', '北海海鸭蛋 自家熟咸烤海鸭蛋20枚装58元包邮', '58.00', '8', 'goods/2016/06/01/201606011636542972.jpg,goods/2016/06/01/201606011637298999.jpg,goods/2016/06/01/201606011637308859.jpg,goods/2016/06/01/201606011637312832.jpg,goods/2016/06/01/201606011637313813.jpg', '100', '0', '1', '9', '0', '0', '0', '65', '0', '1', '9', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('18', 'goods/2016/06/13/201606131457512972.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1.本品一件5斤，全国包邮（新疆、西藏、内蒙古及港澳台除外）。\r\n</p>\r\n<p>\r\n 2.本品为果园现摘先发，下单后24小时内发货，如遇雨天顺延（雨天摘的果不能装箱，易坏）\r\n</p>\r\n<p>\r\n 3.默认发圆通快递和宅急送，如需发其他快递请联系客服并补差价。\r\n</p>\r\n<h3>\r\n 产品简介：\r\n</h3>\r\n<p>\r\n <p class=\"MsoNormal\">\r\n  小台农俗称鸡蛋芒，果实为扁卵形，果皮黄绿色，果肩带粉红色，成熟后黄色或黄色带粉红；果肉橙黄色，肉质细嫩、纤维少、清甜香味特浓，核薄。可食率为<span>68.1%</span><span>～</span><span>72.5% </span>\r\n </p>\r\n <p class=\"MsoNormal\">\r\n  <span><img src=\"/imgs/goods/2016/06/13/201606131506099420.jpg\" alt=\"\"><br />\r\n</span>\r\n </p>\r\n <p class=\"MsoNormal\">\r\n  <span>中国芒果之乡果园新鲜采摘</span>\r\n </p>\r\n <p class=\"MsoNormal\">\r\n  <span><img src=\"/imgs/goods/2016/06/13/201606131508019559.jpg\" alt=\"\"><br />\r\n</span>\r\n </p>\r\n成熟后的小台农，看着都要流口水了\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/13/201606131509239420.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n 个子虽小，果肉却一点不含糊\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/13/201606131510088438.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n 果核薄如纸\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/13/201606131510513532.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/13/201606131511255775.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n 除了解馋，小台农还有利尿消暑的作用哦\r\n</p>', '小台农芒果 5斤装 百色芒果 36元全国包邮', '36.00', '10', 'goods/2016/06/13/201606131457512972.jpg,goods/2016/06/13/201606131458329559.jpg,goods/2016/06/13/201606131458332551.jpg,goods/2016/06/13/201606131458332832.jpg,goods/2016/06/13/201606131458333532.jpg', '1000', '0', '0', '0', '0', '0', '0', '46', '0', '2', '18', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('19', 'goods/2016/06/13/201606131521475635.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1.本品一件10斤，全国包邮（新疆、西藏、内蒙古及港澳台除外）\r\n</p>\r\n<p>\r\n 2.本品为果园现摘先发，下单后24小时内发货，如遇雨天顺延（雨天摘的果不能装箱，易坏）\r\n</p>\r\n<p>\r\n 3.默认发圆通快递和宅急送，如需发其他快递请联系客服并补差价。\r\n</p>\r\n<h3>\r\n 产品简介：\r\n</h3>\r\n<p>\r\n <p class=\"MsoNormal\">\r\n  小台农俗称鸡蛋芒，果实为扁卵形，果皮黄绿色，果肩带粉红色，成熟后黄色或黄色带粉红；果肉橙黄色，肉质细嫩、纤维少、清甜香味特浓，核薄。可食率为<span>68.1%</span><span>～</span><span>72.5%</span><span>。</span>\r\n </p>\r\n <p class=\"MsoNormal\">\r\n  <span><img src=\"/imgs/goods/2016/06/13/201606131526191571.jpg\" alt=\"\"><br />\r\n</span>\r\n </p>\r\n中国芒果之乡果园新鲜采摘\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/13/201606131526501290.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n 成熟后的小台农，看着都要流口水了\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/13/201606131527266896.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n 个子虽小，果肉却一点不含糊\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/13/201606131527597177.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n 果核薄如纸\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/13/201606131528291711.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/13/201606131528426336.jpg\" alt=\"\">\r\n</p>\r\n<p>\r\n 除了解馋，小台农还有利尿解暑的作用哦\r\n</p>', '小台农芒果 10斤装 百色芒果 62元全国包邮', '62.00', '10', 'goods/2016/06/13/201606131521475635.jpg,goods/2016/06/13/201606131522099699.jpg,goods/2016/06/13/201606131522102411.jpg,goods/2016/06/13/201606131522104233.jpg,goods/2016/06/13/201606131522105915.jpg', '1000', '0', '1', '0', '0', '0', '0', '76', '0', '3', '12', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('20', 'goods/2016/06/13/201606131601267877.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1.本品6斤起售（每条大鲵/娃娃鱼重量在6斤以上）\r\n</p>\r\n<p>\r\n 2.本品为人工饲养，具有相关的资质证件，可办理托运，请放心购买；\r\n</p>\r\n<h3>\r\n 产品简介：\r\n</h3>\r\n<p>\r\n <span [removed]>大鲵是一种食用价值极高的动物，其肉质细嫩、味道鲜美，含有优质蛋白质、丰富的氨基酸和微量元素”，<span [removed]>营养价值极高，被誉为“水中人参”</span></span>\r\n</p>\r\n<p>\r\n <span [removed]><img src=\"/imgs/goods/2016/06/13/201606131611399699.jpg\" alt=\"\"><br />\r\n</span>\r\n</p>\r\n<p>\r\n <span [removed]><span [removed]>大鲵肌肉蛋白是一种优质蛋白，必需氨基酸含量高，组成比例好，完全符合人体需要量模式。</span><br />\r\n</span>\r\n</p>\r\n<p>\r\n <span [removed]><img src=\"/imgs/goods/2016/06/13/201606131612445074.jpg\" alt=\"\"><br />\r\n</span>\r\n</p>\r\n<p>\r\n <span [removed]><span [removed]>大鲵肌肉蛋白富含18种氨基酸，其中6种呈味氨基酸占氨基酸总量的42.77 %，8种人体必需氨基酸占氨基酸总量的40.72 %，必需氨基酸与非必需氨基酸比值为68.68 %，均符合FAO/WHO的理想模式；</span></span>\r\n</p>\r\n<p>\r\n <span [removed]><img src=\"/imgs/goods/2016/06/13/201606131613368859.jpg\" alt=\"\"><br />\r\n</span>\r\n</p>\r\n<p>\r\n <span [removed]>大鲵<span [removed]>在中国香港、台湾及东南亚市场上被视为珍稀补品</span></span>\r\n</p>\r\n<p>\r\n <span [removed]><img src=\"/imgs/goods/2016/06/13/201606131615383953.jpg\" alt=\"\"><br />\r\n</span>\r\n</p>\r\n<p>\r\n <span [removed]>本店出售的大鲵是在广西岑王老山泉中生长的，水质清晰，环境美不胜收</span>\r\n</p>\r\n<p>\r\n <span [removed]><img src=\"/imgs/goods/2016/06/13/201606131617091990.jpg\" alt=\"\"><br />\r\n</span>\r\n</p>', '大鲵 娃娃鱼 原始森林放养280元/斤全国包邮', '280.00', '10', 'goods/2016/06/13/201606131601267877.jpg,goods/2016/06/13/201606131601472832.jpg,goods/2016/06/13/201606131601475214.jpg,goods/2016/06/13/201606131601483112.jpg,goods/2016/06/13/201606131601483252.jpg', '500', '0', '1', '0', '0', '0', '0', '390', '0', '2', '10', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('21', 'goods/2016/06/16/201606161800003252.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n1.本品为百色田东精选一级果，精美礼品盒包装。<br />\r\n2.全国包邮（新疆、西藏、内蒙古及港澳台除外）。<br />\r\n3.下单后24小时内发货，遇到下雨天顺延（下雨天摘果不能装箱，易坏）<br />\r\n<h3>\r\n 产品简介：\r\n</h3>\r\n小金煌芒果肉特厚，口感超好，是送礼的佳品。本品均为中国芒果之乡百色田东果园现摘先发，保证新鲜。<br />\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/16/201606161802225915.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 果肉超级厚\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/16/201606161803105635.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 现切先拍，实物拍摄\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/16/201606161804089139.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 精选一级大果，单独套袋\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/16/201606161805044514.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 精美礼盒装，送礼佳品\r\n</p>', '小金煌芒果 10斤精装百色田东芒果76元包邮', '76.00', '7', 'goods/2016/06/16/201606161800003252.jpg,goods/2016/06/16/201606161800198718.jpg,goods/2016/06/16/201606161800204093.jpg,goods/2016/06/16/201606161800314654.jpg,goods/2016/06/16/201606161800315214.jpg', '1000', '0', '0', '4', '0', '0', '0', '98', '0', '3', '6', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('22', 'goods/2016/06/16/201606161814274374.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n1.本品全国包邮（新疆、西藏、内蒙古及港澳台除外）。<br />\r\n2.下单后24小时内发货，遇到下雨天顺延（下雨天摘果不能装箱，易坏）<br />\r\n<h3>\r\n 产品简介：\r\n</h3>\r\n<p>\r\n 大金煌芒果肉特厚，口感超好，是送礼的佳品。本品均为中国芒果之乡百色田东果园现摘先发，保证新鲜。\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/16/201606161817152832.jpg\" alt=\"\"><img src=\"/imgs/goods/2016/06/16/201606161817529279.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 果肉超厚，口感超甜\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/16/201606161818391430.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 现切现排，实物拍摄\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/16/201606161819254654.jpg\" alt=\"\"><img src=\"/imgs/goods/2016/06/16/201606161819386896.jpg\" alt=\"\"> \r\n</p>\r\n<p>\r\n 精美礼盒包装\r\n</p>', '大金煌芒果 10斤精装田东芒果89元全国包邮', '89.00', '7', 'goods/2016/06/16/201606161814274374.jpg,goods/2016/06/16/201606161814428859.jpg,goods/2016/06/16/201606161814429699.jpg,goods/2016/06/25/201606251118551827.png', '1000', '0', '0', '4', '0', '0', '0', '110', '0', '3', '4', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('23', 'goods/2016/06/21/201606211135331546.png', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1.本品广西区内包邮；\r\n</p>\r\n<p>\r\n 2.本品均为果园现摘现发，下单后24小时内发货，如遇雨天顺延。\r\n</p>\r\n<h3>\r\n 产品简介：\r\n</h3>\r\n<p>\r\n <span [removed]>台农芒果色、香、味俱佳，营养丰富，每百克果肉含维生素C56．4—137．5毫克</span>，<span [removed]>果肉多汁，鲜美可口</span>。<span [removed]>盛夏吃上几个，能生津止渴，消暑舒神。</span>\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/21/201606211123351967.png\" alt=\"\">\r\n</p>\r\n<p>\r\n 源于芒果之乡田东，品质有保证\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/21/201606211125052388.png\" alt=\"\">\r\n</p>\r\n<p>\r\n 果园现摘现发，新鲜\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/21/201606211125553369.png\" alt=\"\">\r\n</p>\r\n<p>\r\n 肉厚多汁，美味\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/21/201606211126263789.png\" alt=\"\">\r\n</p>\r\n<p>\r\n 新鲜芒果，多种吃法\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/06/21/201606211128018555.png\" alt=\"\">\r\n</p>\r\n<p>\r\n 精美包装，送礼有面子\r\n</p>', '大台农芒果 8斤精品装 广西区内65元包邮', '65.00', '8', 'goods/2016/06/21/201606211135331546.png,goods/2016/06/21/201606211135553369.png,goods/2016/06/21/201606211135557153.png,goods/2016/06/21/201606211135558695.png,goods/2016/06/21/201606211135563369.png', '1000', '0', '1', '0', '0', '0', '0', '88', '0', '3', '17', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('24', 'goods/2016/06/21/201606211138175471.png', '<h3>\r\n <b>购买须知：</b>\r\n</h3>\r\n<p class=\"MsoNormal\" align=\"left\">\r\n <b></b>\r\n</p>\r\n<p class=\"MsoNormal\" align=\"left\">\r\n 1.本品全国包邮（新疆、西藏、内蒙古及港澳台除外）\r\n</p>\r\n<p class=\"MsoNormal\" align=\"left\">\r\n 2.本品均为果园现摘现发，下单后24小时内发货，如遇雨天顺延。\r\n</p>\r\n<p class=\"MsoNormal\" align=\"left\">\r\n <h3>\r\n  <b>产品简介：</b>\r\n </h3>\r\n <p class=\"MsoNormal\" align=\"left\">\r\n  <b></b>\r\n </p>\r\n <p class=\"MsoNormal\" align=\"left\">\r\n  台农芒果色、香、味俱佳，营养丰富，每百克果肉含维生素C56．4—137．5毫克，果肉多汁，鲜美可口。盛夏吃上几个，能生津止渴，消暑舒神。\r\n </p>\r\n <p class=\"MsoNormal\" align=\"left\">\r\n  <img src=\"/imgs/goods/2016/06/21/201606211141151127.png\" alt=\"\">\r\n </p>\r\n <p class=\"MsoNormal\" align=\"left\">\r\n  源于芒果之乡田东，品质有保证\r\n </p>\r\n <p class=\"MsoNormal\" align=\"left\">\r\n  <img src=\"/imgs/goods/2016/06/21/201606211141578555.png\" alt=\"\">\r\n </p>\r\n <p class=\"MsoNormal\" align=\"left\">\r\n  果园现摘现发，新鲜\r\n </p>\r\n <p class=\"MsoNormal\" align=\"left\">\r\n  <img src=\"/imgs/goods/2016/06/21/201606211142293509.png\" alt=\"\">\r\n </p>\r\n <p class=\"MsoNormal\">\r\n  <span> </span><span [removed]>肉厚多汁，美味</span>\r\n </p>\r\n <p class=\"MsoNormal\">\r\n  <span [removed]><img src=\"/imgs/goods/2016/06/21/201606211142591687.png\" alt=\"\"><br />\r\n</span>\r\n </p>\r\n <p class=\"MsoNormal\">\r\n  <span [removed]>新鲜芒果，多种吃法</span>\r\n </p>\r\n <p class=\"MsoNormal\">\r\n  <span [removed]><img src=\"/imgs/goods/2016/06/21/201606211143322809.png\" alt=\"\"><br />\r\n</span>\r\n </p>\r\n <p class=\"MsoNormal\">\r\n  <span [removed]>精美包装，送礼有面子</span>\r\n </p>\r\n</p>', '大台农芒果 10斤精品装 广西区外76元包邮', '76.00', '7', 'goods/2016/06/21/201606211138175471.png,goods/2016/06/21/201606211138366172.png,goods/2016/06/21/201606211138366733.png,goods/2016/06/21/201606211138374350.png,goods/2016/06/21/201606211138376032.png', '1000', '0', '1', '0', '0', '0', '0', '98', '0', '3', '16', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('25', 'goods/2016/07/15/201607151612411594.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1.本品广西区内包邮。\r\n</p>\r\n<p>\r\n 2.本品均为果园现摘现发，下单后24小时内发货，如遇雨天顺延。\r\n</p>\r\n<h3>\r\n 产品介绍：\r\n</h3>\r\n<p>\r\n 桂七香芒有芒果之王的美誉，单果重250~600克。其色、香、味俱全，营养丰富，果肉多汁，鲜美可口。盛夏吃上几个，能生津止渴，消暑舒神。\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/07/15/201607151625258041.png\" alt=\"\">\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/07/15/201607151625582855.png\" alt=\"\">\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/07/15/201607151626171454.png\" alt=\"\">\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/07/15/201607151626377901.png\" alt=\"\">\r\n</p>', '田东桂七香芒 十斤精装广西区内105元/件包邮', '105.00', '7', 'goods/2016/07/15/201607151612411594.jpg,goods/2016/07/15/201607151613232855.png,goods/2016/07/15/201607151613238182.png,goods/2016/07/15/201607151613239303.png,goods/2016/07/15/201607151613244677.png', '1000', '0', '1', '4', '0', '0', '0', '125', '0', '3', '1', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('26', 'goods/2016/07/15/201607151629556359.jpg', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1.本品全国包邮（新疆、西藏、内蒙古及港澳台除外）\r\n</p>\r\n<p>\r\n 2.本品均为果园现摘现发，下单后24小时内发货，如遇雨天顺延。\r\n</p>\r\n<h3>\r\n 产品介绍：\r\n</h3>\r\n<p>\r\n 桂七香芒有芒果之王的美誉，单果重250~600克。其色、香、味俱全，营养丰富，果肉多汁，鲜美可口。盛夏吃上几个能生津止渴，消暑舒神。\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/07/15/201607151639353416.png\" alt=\"\">\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/07/15/201607151639535658.png\" alt=\"\">\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/07/15/201607151640142715.png\" alt=\"\">\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/07/15/201607151640356920.png\" alt=\"\">\r\n</p>\r\n<p>\r\n <img src=\"/imgs/goods/2016/07/15/201607151640501734.png\" alt=\"\">\r\n</p>', '田东桂七香芒 十斤精装112元/件全国包邮', '112.00', '5', 'goods/2016/07/15/201607151629556359.jpg,goods/2016/07/15/201607151630182434.png,goods/2016/07/15/201607151630184958.png,goods/2016/07/15/201607151630189162.png,goods/2016/07/15/201607151630489022.png', '1000', '0', '1', '1', '0', '0', '0', '135', '0', '3', '4', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('27', 'goods/2016/07/28/201607281753475798.png', '<h3>\r\n 购买须知：\r\n</h3>\r\n<p>\r\n 1.本品默认为散装，最低起定量为一斤。\r\n</p>\r\n<p>\r\n 2.南宁市区内免费送货上门，其他地区邮费到付。\r\n</p>\r\n<h3>\r\n 产品简介：\r\n</h3>\r\n<p>\r\n <span [removed]>八渡笋是广西省百色地区田林县著名的土特产品</span>，<span [removed]>属天然绿色食品，其特点为甜脆可口，味美清香，营养丰富。<span [removed]>该笋与全国各地生产的竹笋有所不同，在我国已饮誉数百年的历史，据《西林县志》记载，正宗八渡笋在清朝时曾被列入十大贡品之一。</span></span> \r\n</p>\r\n<p>\r\n <span [removed]><span [removed]><img src=\"/imgs/goods/2016/07/28/201607281807595518.png\" alt=\"\"><br />\r\n</span></span>\r\n</p>\r\n<p>\r\n <span [removed]><span [removed]><img src=\"/imgs/goods/2016/07/28/201607281808255238.png\" alt=\"\"><br />\r\n</span></span>\r\n</p>\r\n<p>\r\n <span [removed]><span [removed]><img src=\"/imgs/goods/2016/07/28/201607281808389022.png\" alt=\"\"><br />\r\n</span></span>\r\n</p>\r\n<p>\r\n <span [removed]></span> \r\n</p>', '田林八渡笋 笋丝 山珍佳品 30元/斤', '30.00', '7', 'goods/2016/07/28/201607281753475798.png,goods/2016/07/28/201607281754115798.png,goods/2016/07/28/201607281754122155.png,goods/2016/07/28/201607281754122855.png', '100', '0', '1', '0', '0', '0', '0', '48', '0', '2', '6', '0', null);
INSERT INTO `wp_shop_goods` VALUES ('28', 'goods/2016/08/30/201608302110073042.jpg', '', '测试2323', '12.00', '1', 'goods/2016/08/30/201608302110073042.jpg', '231', '0', '1', '0', '1', '0', '0', '100', '0', '2', '0', '1', '1475078400');

-- ----------------------------
-- Table structure for wp_shop_goods_category
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_goods_category`;
CREATE TABLE `wp_shop_goods_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL COMMENT '分类标题',
  `icon` varchar(255) DEFAULT NULL COMMENT '分类图标',
  `pid` int(10) unsigned DEFAULT '0' COMMENT '上一级分类',
  `path` varchar(255) DEFAULT NULL COMMENT '分类路径',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序号',
  `is_show` tinyint(2) DEFAULT '1' COMMENT '是否显示',
  `shop_id` int(10) NOT NULL DEFAULT '0' COMMENT '商店ID',
  `is_recommend` tinyint(2) DEFAULT '0' COMMENT '是否推荐',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_goods_category
-- ----------------------------
INSERT INTO `wp_shop_goods_category` VALUES ('1', '土鸡土鸭', null, '0', null, '0', '1', '0', '0');
INSERT INTO `wp_shop_goods_category` VALUES ('2', '土货山货', null, '0', null, '2', '1', '0', '1');
INSERT INTO `wp_shop_goods_category` VALUES ('3', '水果', null, '0', null, '1', '1', '0', '1');

-- ----------------------------
-- Table structure for wp_shop_goods_evaluation
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_goods_evaluation`;
CREATE TABLE `wp_shop_goods_evaluation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(10) unsigned NOT NULL,
  `score` int(10) unsigned NOT NULL DEFAULT '0',
  `best` int(10) unsigned NOT NULL DEFAULT '0',
  `normal` int(10) unsigned NOT NULL DEFAULT '0',
  `bad` int(10) unsigned NOT NULL DEFAULT '0',
  `people` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_goods_evaluation
-- ----------------------------
INSERT INTO `wp_shop_goods_evaluation` VALUES ('1', '1', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('2', '2', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('3', '3', '18', '9', '0', '0', '9');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('4', '4', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('5', '5', '2', '1', '0', '0', '1');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('6', '6', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('7', '7', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('8', '8', '14', '7', '0', '0', '7');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('9', '9', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('10', '10', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('11', '11', '6', '3', '0', '0', '3');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('12', '12', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('13', '13', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('14', '14', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('15', '15', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('16', '16', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('17', '17', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('18', '18', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('19', '19', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('20', '20', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('21', '21', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('22', '22', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('23', '23', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('24', '24', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('25', '25', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('26', '26', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('27', '27', '0', '0', '0', '0', '0');
INSERT INTO `wp_shop_goods_evaluation` VALUES ('28', '28', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for wp_shop_goods_score
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_goods_score`;
CREATE TABLE `wp_shop_goods_score` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` varchar(255) DEFAULT NULL COMMENT '用户ID',
  `goods_id` int(10) DEFAULT NULL COMMENT '商品ID',
  `score` int(10) DEFAULT '0' COMMENT '得分',
  `cTime` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_goods_score
-- ----------------------------

-- ----------------------------
-- Table structure for wp_shop_nation
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_nation`;
CREATE TABLE `wp_shop_nation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(6) DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3926 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_nation
-- ----------------------------
INSERT INTO `wp_shop_nation` VALUES ('1', '110000', '北京市', '0');
INSERT INTO `wp_shop_nation` VALUES ('2', '110101', '东城区', '3923');
INSERT INTO `wp_shop_nation` VALUES ('3', '110102', '西城区', '3923');
INSERT INTO `wp_shop_nation` VALUES ('4', '110105', '朝阳区', '3923');
INSERT INTO `wp_shop_nation` VALUES ('5', '110106', '丰台区', '3923');
INSERT INTO `wp_shop_nation` VALUES ('6', '110107', '石景山区', '3923');
INSERT INTO `wp_shop_nation` VALUES ('7', '110108', '海淀区', '3923');
INSERT INTO `wp_shop_nation` VALUES ('8', '110109', '门头沟区', '3923');
INSERT INTO `wp_shop_nation` VALUES ('9', '110111', '房山区', '3923');
INSERT INTO `wp_shop_nation` VALUES ('10', '110112', '通州区', '3923');
INSERT INTO `wp_shop_nation` VALUES ('11', '110113', '顺义区', '3923');
INSERT INTO `wp_shop_nation` VALUES ('12', '110114', '昌平区', '3923');
INSERT INTO `wp_shop_nation` VALUES ('13', '110115', '大兴区', '3923');
INSERT INTO `wp_shop_nation` VALUES ('14', '110116', '怀柔区', '3923');
INSERT INTO `wp_shop_nation` VALUES ('15', '110117', '平谷区', '3923');
INSERT INTO `wp_shop_nation` VALUES ('16', '110228', '密云县', '3923');
INSERT INTO `wp_shop_nation` VALUES ('17', '110229', '延庆县', '3923');
INSERT INTO `wp_shop_nation` VALUES ('18', '120000', '天津市', '0');
INSERT INTO `wp_shop_nation` VALUES ('19', '120101', '和平区', '3924');
INSERT INTO `wp_shop_nation` VALUES ('20', '120102', '河东区', '3924');
INSERT INTO `wp_shop_nation` VALUES ('21', '120103', '河西区', '3924');
INSERT INTO `wp_shop_nation` VALUES ('22', '120104', '南开区', '3924');
INSERT INTO `wp_shop_nation` VALUES ('23', '120105', '河北区', '3924');
INSERT INTO `wp_shop_nation` VALUES ('24', '120106', '红桥区', '3924');
INSERT INTO `wp_shop_nation` VALUES ('25', '120110', '东丽区', '3924');
INSERT INTO `wp_shop_nation` VALUES ('26', '120111', '西青区', '3924');
INSERT INTO `wp_shop_nation` VALUES ('27', '120112', '津南区', '3924');
INSERT INTO `wp_shop_nation` VALUES ('28', '120113', '北辰区', '3924');
INSERT INTO `wp_shop_nation` VALUES ('29', '120114', '武清区', '3924');
INSERT INTO `wp_shop_nation` VALUES ('30', '120115', '宝坻区', '3924');
INSERT INTO `wp_shop_nation` VALUES ('31', '120116', '滨海新区', '3924');
INSERT INTO `wp_shop_nation` VALUES ('32', '120221', '宁河县', '3924');
INSERT INTO `wp_shop_nation` VALUES ('33', '120223', '静海县', '3924');
INSERT INTO `wp_shop_nation` VALUES ('34', '120225', '蓟县', '3924');
INSERT INTO `wp_shop_nation` VALUES ('35', '130000', '河北省', '0');
INSERT INTO `wp_shop_nation` VALUES ('36', '130100', '石家庄市', '35');
INSERT INTO `wp_shop_nation` VALUES ('37', '130101', '市辖区', '36');
INSERT INTO `wp_shop_nation` VALUES ('38', '130102', '长安区', '36');
INSERT INTO `wp_shop_nation` VALUES ('39', '130104', '桥西区', '36');
INSERT INTO `wp_shop_nation` VALUES ('40', '130105', '新华区', '36');
INSERT INTO `wp_shop_nation` VALUES ('41', '130107', '井陉矿区', '36');
INSERT INTO `wp_shop_nation` VALUES ('42', '130108', '裕华区', '36');
INSERT INTO `wp_shop_nation` VALUES ('43', '130109', '藁城区', '36');
INSERT INTO `wp_shop_nation` VALUES ('44', '130110', '鹿泉区', '36');
INSERT INTO `wp_shop_nation` VALUES ('45', '130111', '栾城区', '36');
INSERT INTO `wp_shop_nation` VALUES ('46', '130121', '井陉县', '36');
INSERT INTO `wp_shop_nation` VALUES ('47', '130123', '正定县', '36');
INSERT INTO `wp_shop_nation` VALUES ('48', '130125', '行唐县', '36');
INSERT INTO `wp_shop_nation` VALUES ('49', '130126', '灵寿县', '36');
INSERT INTO `wp_shop_nation` VALUES ('50', '130127', '高邑县', '36');
INSERT INTO `wp_shop_nation` VALUES ('51', '130128', '深泽县', '36');
INSERT INTO `wp_shop_nation` VALUES ('52', '130129', '赞皇县', '36');
INSERT INTO `wp_shop_nation` VALUES ('53', '130130', '无极县', '36');
INSERT INTO `wp_shop_nation` VALUES ('54', '130131', '平山县', '36');
INSERT INTO `wp_shop_nation` VALUES ('55', '130132', '元氏县', '36');
INSERT INTO `wp_shop_nation` VALUES ('56', '130133', '赵县', '36');
INSERT INTO `wp_shop_nation` VALUES ('57', '130181', '辛集市', '36');
INSERT INTO `wp_shop_nation` VALUES ('58', '130183', '晋州市', '36');
INSERT INTO `wp_shop_nation` VALUES ('59', '130184', '新乐市', '36');
INSERT INTO `wp_shop_nation` VALUES ('60', '130200', '唐山市', '35');
INSERT INTO `wp_shop_nation` VALUES ('61', '130201', '市辖区', '60');
INSERT INTO `wp_shop_nation` VALUES ('62', '130202', '路南区', '60');
INSERT INTO `wp_shop_nation` VALUES ('63', '130203', '路北区', '60');
INSERT INTO `wp_shop_nation` VALUES ('64', '130204', '古冶区', '60');
INSERT INTO `wp_shop_nation` VALUES ('65', '130205', '开平区', '60');
INSERT INTO `wp_shop_nation` VALUES ('66', '130207', '丰南区', '60');
INSERT INTO `wp_shop_nation` VALUES ('67', '130208', '丰润区', '60');
INSERT INTO `wp_shop_nation` VALUES ('68', '130209', '曹妃甸区', '60');
INSERT INTO `wp_shop_nation` VALUES ('69', '130223', '滦县', '60');
INSERT INTO `wp_shop_nation` VALUES ('70', '130224', '滦南县', '60');
INSERT INTO `wp_shop_nation` VALUES ('71', '130225', '乐亭县', '60');
INSERT INTO `wp_shop_nation` VALUES ('72', '130227', '迁西县', '60');
INSERT INTO `wp_shop_nation` VALUES ('73', '130229', '玉田县', '60');
INSERT INTO `wp_shop_nation` VALUES ('74', '130281', '遵化市', '60');
INSERT INTO `wp_shop_nation` VALUES ('75', '130283', '迁安市', '60');
INSERT INTO `wp_shop_nation` VALUES ('76', '130300', '秦皇岛市', '35');
INSERT INTO `wp_shop_nation` VALUES ('77', '130301', '市辖区', '76');
INSERT INTO `wp_shop_nation` VALUES ('78', '130302', '海港区', '76');
INSERT INTO `wp_shop_nation` VALUES ('79', '130303', '山海关区', '76');
INSERT INTO `wp_shop_nation` VALUES ('80', '130304', '北戴河区', '76');
INSERT INTO `wp_shop_nation` VALUES ('81', '130321', '青龙满族自治县', '76');
INSERT INTO `wp_shop_nation` VALUES ('82', '130322', '昌黎县', '76');
INSERT INTO `wp_shop_nation` VALUES ('83', '130323', '抚宁县', '76');
INSERT INTO `wp_shop_nation` VALUES ('84', '130324', '卢龙县', '76');
INSERT INTO `wp_shop_nation` VALUES ('85', '130400', '邯郸市', '35');
INSERT INTO `wp_shop_nation` VALUES ('86', '130401', '市辖区', '85');
INSERT INTO `wp_shop_nation` VALUES ('87', '130402', '邯山区', '85');
INSERT INTO `wp_shop_nation` VALUES ('88', '130403', '丛台区', '85');
INSERT INTO `wp_shop_nation` VALUES ('89', '130404', '复兴区', '85');
INSERT INTO `wp_shop_nation` VALUES ('90', '130406', '峰峰矿区', '85');
INSERT INTO `wp_shop_nation` VALUES ('91', '130421', '邯郸县', '85');
INSERT INTO `wp_shop_nation` VALUES ('92', '130423', '临漳县', '85');
INSERT INTO `wp_shop_nation` VALUES ('93', '130424', '成安县', '85');
INSERT INTO `wp_shop_nation` VALUES ('94', '130425', '大名县', '85');
INSERT INTO `wp_shop_nation` VALUES ('95', '130426', '涉县', '85');
INSERT INTO `wp_shop_nation` VALUES ('96', '130427', '磁县', '85');
INSERT INTO `wp_shop_nation` VALUES ('97', '130428', '肥乡县', '85');
INSERT INTO `wp_shop_nation` VALUES ('98', '130429', '永年县', '85');
INSERT INTO `wp_shop_nation` VALUES ('99', '130430', '邱县', '85');
INSERT INTO `wp_shop_nation` VALUES ('100', '130431', '鸡泽县', '85');
INSERT INTO `wp_shop_nation` VALUES ('101', '130432', '广平县', '85');
INSERT INTO `wp_shop_nation` VALUES ('102', '130433', '馆陶县', '85');
INSERT INTO `wp_shop_nation` VALUES ('103', '130434', '魏县', '85');
INSERT INTO `wp_shop_nation` VALUES ('104', '130435', '曲周县', '85');
INSERT INTO `wp_shop_nation` VALUES ('105', '130481', '武安市', '85');
INSERT INTO `wp_shop_nation` VALUES ('106', '130500', '邢台市', '35');
INSERT INTO `wp_shop_nation` VALUES ('107', '130501', '市辖区', '106');
INSERT INTO `wp_shop_nation` VALUES ('108', '130502', '桥东区', '106');
INSERT INTO `wp_shop_nation` VALUES ('109', '130503', '桥西区', '106');
INSERT INTO `wp_shop_nation` VALUES ('110', '130521', '邢台县', '106');
INSERT INTO `wp_shop_nation` VALUES ('111', '130522', '临城县', '106');
INSERT INTO `wp_shop_nation` VALUES ('112', '130523', '内丘县', '106');
INSERT INTO `wp_shop_nation` VALUES ('113', '130524', '柏乡县', '106');
INSERT INTO `wp_shop_nation` VALUES ('114', '130525', '隆尧县', '106');
INSERT INTO `wp_shop_nation` VALUES ('115', '130526', '任县', '106');
INSERT INTO `wp_shop_nation` VALUES ('116', '130527', '南和县', '106');
INSERT INTO `wp_shop_nation` VALUES ('117', '130528', '宁晋县', '106');
INSERT INTO `wp_shop_nation` VALUES ('118', '130529', '巨鹿县', '106');
INSERT INTO `wp_shop_nation` VALUES ('119', '130530', '新河县', '106');
INSERT INTO `wp_shop_nation` VALUES ('120', '130531', '广宗县', '106');
INSERT INTO `wp_shop_nation` VALUES ('121', '130532', '平乡县', '106');
INSERT INTO `wp_shop_nation` VALUES ('122', '130533', '威县', '106');
INSERT INTO `wp_shop_nation` VALUES ('123', '130534', '清河县', '106');
INSERT INTO `wp_shop_nation` VALUES ('124', '130535', '临西县', '106');
INSERT INTO `wp_shop_nation` VALUES ('125', '130581', '南宫市', '106');
INSERT INTO `wp_shop_nation` VALUES ('126', '130582', '沙河市', '106');
INSERT INTO `wp_shop_nation` VALUES ('127', '130600', '保定市', '35');
INSERT INTO `wp_shop_nation` VALUES ('128', '130601', '市辖区', '127');
INSERT INTO `wp_shop_nation` VALUES ('129', '130602', '新市区', '127');
INSERT INTO `wp_shop_nation` VALUES ('130', '130603', '北市区', '127');
INSERT INTO `wp_shop_nation` VALUES ('131', '130604', '南市区', '127');
INSERT INTO `wp_shop_nation` VALUES ('132', '130621', '满城县', '127');
INSERT INTO `wp_shop_nation` VALUES ('133', '130622', '清苑县', '127');
INSERT INTO `wp_shop_nation` VALUES ('134', '130623', '涞水县', '127');
INSERT INTO `wp_shop_nation` VALUES ('135', '130624', '阜平县', '127');
INSERT INTO `wp_shop_nation` VALUES ('136', '130625', '徐水县', '127');
INSERT INTO `wp_shop_nation` VALUES ('137', '130626', '定兴县', '127');
INSERT INTO `wp_shop_nation` VALUES ('138', '130627', '唐县', '127');
INSERT INTO `wp_shop_nation` VALUES ('139', '130628', '高阳县', '127');
INSERT INTO `wp_shop_nation` VALUES ('140', '130629', '容城县', '127');
INSERT INTO `wp_shop_nation` VALUES ('141', '130630', '涞源县', '127');
INSERT INTO `wp_shop_nation` VALUES ('142', '130631', '望都县', '127');
INSERT INTO `wp_shop_nation` VALUES ('143', '130632', '安新县', '127');
INSERT INTO `wp_shop_nation` VALUES ('144', '130633', '易县', '127');
INSERT INTO `wp_shop_nation` VALUES ('145', '130634', '曲阳县', '127');
INSERT INTO `wp_shop_nation` VALUES ('146', '130635', '蠡县', '127');
INSERT INTO `wp_shop_nation` VALUES ('147', '130636', '顺平县', '127');
INSERT INTO `wp_shop_nation` VALUES ('148', '130637', '博野县', '127');
INSERT INTO `wp_shop_nation` VALUES ('149', '130638', '雄县', '127');
INSERT INTO `wp_shop_nation` VALUES ('150', '130681', '涿州市', '127');
INSERT INTO `wp_shop_nation` VALUES ('151', '130682', '定州市', '127');
INSERT INTO `wp_shop_nation` VALUES ('152', '130683', '安国市', '127');
INSERT INTO `wp_shop_nation` VALUES ('153', '130684', '高碑店市', '127');
INSERT INTO `wp_shop_nation` VALUES ('154', '130700', '张家口市', '35');
INSERT INTO `wp_shop_nation` VALUES ('155', '130701', '市辖区', '154');
INSERT INTO `wp_shop_nation` VALUES ('156', '130702', '桥东区', '154');
INSERT INTO `wp_shop_nation` VALUES ('157', '130703', '桥西区', '154');
INSERT INTO `wp_shop_nation` VALUES ('158', '130705', '宣化区', '154');
INSERT INTO `wp_shop_nation` VALUES ('159', '130706', '下花园区', '154');
INSERT INTO `wp_shop_nation` VALUES ('160', '130721', '宣化县', '154');
INSERT INTO `wp_shop_nation` VALUES ('161', '130722', '张北县', '154');
INSERT INTO `wp_shop_nation` VALUES ('162', '130723', '康保县', '154');
INSERT INTO `wp_shop_nation` VALUES ('163', '130724', '沽源县', '154');
INSERT INTO `wp_shop_nation` VALUES ('164', '130725', '尚义县', '154');
INSERT INTO `wp_shop_nation` VALUES ('165', '130726', '蔚县', '154');
INSERT INTO `wp_shop_nation` VALUES ('166', '130727', '阳原县', '154');
INSERT INTO `wp_shop_nation` VALUES ('167', '130728', '怀安县', '154');
INSERT INTO `wp_shop_nation` VALUES ('168', '130729', '万全县', '154');
INSERT INTO `wp_shop_nation` VALUES ('169', '130730', '怀来县', '154');
INSERT INTO `wp_shop_nation` VALUES ('170', '130731', '涿鹿县', '154');
INSERT INTO `wp_shop_nation` VALUES ('171', '130732', '赤城县', '154');
INSERT INTO `wp_shop_nation` VALUES ('172', '130733', '崇礼县', '154');
INSERT INTO `wp_shop_nation` VALUES ('173', '130800', '承德市', '35');
INSERT INTO `wp_shop_nation` VALUES ('174', '130801', '市辖区', '173');
INSERT INTO `wp_shop_nation` VALUES ('175', '130802', '双桥区', '173');
INSERT INTO `wp_shop_nation` VALUES ('176', '130803', '双滦区', '173');
INSERT INTO `wp_shop_nation` VALUES ('177', '130804', '鹰手营子矿区', '173');
INSERT INTO `wp_shop_nation` VALUES ('178', '130821', '承德县', '173');
INSERT INTO `wp_shop_nation` VALUES ('179', '130822', '兴隆县', '173');
INSERT INTO `wp_shop_nation` VALUES ('180', '130823', '平泉县', '173');
INSERT INTO `wp_shop_nation` VALUES ('181', '130824', '滦平县', '173');
INSERT INTO `wp_shop_nation` VALUES ('182', '130825', '隆化县', '173');
INSERT INTO `wp_shop_nation` VALUES ('183', '130826', '丰宁满族自治县', '173');
INSERT INTO `wp_shop_nation` VALUES ('184', '130827', '宽城满族自治县', '173');
INSERT INTO `wp_shop_nation` VALUES ('185', '130828', '围场满族蒙古族自治县', '173');
INSERT INTO `wp_shop_nation` VALUES ('186', '130900', '沧州市', '35');
INSERT INTO `wp_shop_nation` VALUES ('187', '130901', '市辖区', '186');
INSERT INTO `wp_shop_nation` VALUES ('188', '130902', '新华区', '186');
INSERT INTO `wp_shop_nation` VALUES ('189', '130903', '运河区', '186');
INSERT INTO `wp_shop_nation` VALUES ('190', '130921', '沧县', '186');
INSERT INTO `wp_shop_nation` VALUES ('191', '130922', '青县', '186');
INSERT INTO `wp_shop_nation` VALUES ('192', '130923', '东光县', '186');
INSERT INTO `wp_shop_nation` VALUES ('193', '130924', '海兴县', '186');
INSERT INTO `wp_shop_nation` VALUES ('194', '130925', '盐山县', '186');
INSERT INTO `wp_shop_nation` VALUES ('195', '130926', '肃宁县', '186');
INSERT INTO `wp_shop_nation` VALUES ('196', '130927', '南皮县', '186');
INSERT INTO `wp_shop_nation` VALUES ('197', '130928', '吴桥县', '186');
INSERT INTO `wp_shop_nation` VALUES ('198', '130929', '献县', '186');
INSERT INTO `wp_shop_nation` VALUES ('199', '130930', '孟村回族自治县', '186');
INSERT INTO `wp_shop_nation` VALUES ('200', '130981', '泊头市', '186');
INSERT INTO `wp_shop_nation` VALUES ('201', '130982', '任丘市', '186');
INSERT INTO `wp_shop_nation` VALUES ('202', '130983', '黄骅市', '186');
INSERT INTO `wp_shop_nation` VALUES ('203', '130984', '河间市', '186');
INSERT INTO `wp_shop_nation` VALUES ('204', '131000', '廊坊市', '35');
INSERT INTO `wp_shop_nation` VALUES ('205', '131001', '市辖区', '204');
INSERT INTO `wp_shop_nation` VALUES ('206', '131002', '安次区', '204');
INSERT INTO `wp_shop_nation` VALUES ('207', '131003', '广阳区', '204');
INSERT INTO `wp_shop_nation` VALUES ('208', '131022', '固安县', '204');
INSERT INTO `wp_shop_nation` VALUES ('209', '131023', '永清县', '204');
INSERT INTO `wp_shop_nation` VALUES ('210', '131024', '香河县', '204');
INSERT INTO `wp_shop_nation` VALUES ('211', '131025', '大城县', '204');
INSERT INTO `wp_shop_nation` VALUES ('212', '131026', '文安县', '204');
INSERT INTO `wp_shop_nation` VALUES ('213', '131028', '大厂回族自治县', '204');
INSERT INTO `wp_shop_nation` VALUES ('214', '131081', '霸州市', '204');
INSERT INTO `wp_shop_nation` VALUES ('215', '131082', '三河市', '204');
INSERT INTO `wp_shop_nation` VALUES ('216', '131100', '衡水市', '35');
INSERT INTO `wp_shop_nation` VALUES ('217', '131101', '市辖区', '216');
INSERT INTO `wp_shop_nation` VALUES ('218', '131102', '桃城区', '216');
INSERT INTO `wp_shop_nation` VALUES ('219', '131121', '枣强县', '216');
INSERT INTO `wp_shop_nation` VALUES ('220', '131122', '武邑县', '216');
INSERT INTO `wp_shop_nation` VALUES ('221', '131123', '武强县', '216');
INSERT INTO `wp_shop_nation` VALUES ('222', '131124', '饶阳县', '216');
INSERT INTO `wp_shop_nation` VALUES ('223', '131125', '安平县', '216');
INSERT INTO `wp_shop_nation` VALUES ('224', '131126', '故城县', '216');
INSERT INTO `wp_shop_nation` VALUES ('225', '131127', '景县', '216');
INSERT INTO `wp_shop_nation` VALUES ('226', '131128', '阜城县', '216');
INSERT INTO `wp_shop_nation` VALUES ('227', '131181', '冀州市', '216');
INSERT INTO `wp_shop_nation` VALUES ('228', '131182', '深州市', '216');
INSERT INTO `wp_shop_nation` VALUES ('229', '140000', '山西省', '0');
INSERT INTO `wp_shop_nation` VALUES ('230', '140100', '太原市', '229');
INSERT INTO `wp_shop_nation` VALUES ('231', '140101', '市辖区', '230');
INSERT INTO `wp_shop_nation` VALUES ('232', '140105', '小店区', '230');
INSERT INTO `wp_shop_nation` VALUES ('233', '140106', '迎泽区', '230');
INSERT INTO `wp_shop_nation` VALUES ('234', '140107', '杏花岭区', '230');
INSERT INTO `wp_shop_nation` VALUES ('235', '140108', '尖草坪区', '230');
INSERT INTO `wp_shop_nation` VALUES ('236', '140109', '万柏林区', '230');
INSERT INTO `wp_shop_nation` VALUES ('237', '140110', '晋源区', '230');
INSERT INTO `wp_shop_nation` VALUES ('238', '140121', '清徐县', '230');
INSERT INTO `wp_shop_nation` VALUES ('239', '140122', '阳曲县', '230');
INSERT INTO `wp_shop_nation` VALUES ('240', '140123', '娄烦县', '230');
INSERT INTO `wp_shop_nation` VALUES ('241', '140181', '古交市', '230');
INSERT INTO `wp_shop_nation` VALUES ('242', '140200', '大同市', '229');
INSERT INTO `wp_shop_nation` VALUES ('243', '140201', '市辖区', '242');
INSERT INTO `wp_shop_nation` VALUES ('244', '140202', '城区', '242');
INSERT INTO `wp_shop_nation` VALUES ('245', '140203', '矿区', '242');
INSERT INTO `wp_shop_nation` VALUES ('246', '140211', '南郊区', '242');
INSERT INTO `wp_shop_nation` VALUES ('247', '140212', '新荣区', '242');
INSERT INTO `wp_shop_nation` VALUES ('248', '140221', '阳高县', '242');
INSERT INTO `wp_shop_nation` VALUES ('249', '140222', '天镇县', '242');
INSERT INTO `wp_shop_nation` VALUES ('250', '140223', '广灵县', '242');
INSERT INTO `wp_shop_nation` VALUES ('251', '140224', '灵丘县', '242');
INSERT INTO `wp_shop_nation` VALUES ('252', '140225', '浑源县', '242');
INSERT INTO `wp_shop_nation` VALUES ('253', '140226', '左云县', '242');
INSERT INTO `wp_shop_nation` VALUES ('254', '140227', '大同县', '242');
INSERT INTO `wp_shop_nation` VALUES ('255', '140300', '阳泉市', '229');
INSERT INTO `wp_shop_nation` VALUES ('256', '140301', '市辖区', '255');
INSERT INTO `wp_shop_nation` VALUES ('257', '140302', '城区', '255');
INSERT INTO `wp_shop_nation` VALUES ('258', '140303', '矿区', '255');
INSERT INTO `wp_shop_nation` VALUES ('259', '140311', '郊区', '255');
INSERT INTO `wp_shop_nation` VALUES ('260', '140321', '平定县', '255');
INSERT INTO `wp_shop_nation` VALUES ('261', '140322', '盂县', '255');
INSERT INTO `wp_shop_nation` VALUES ('262', '140400', '长治市', '229');
INSERT INTO `wp_shop_nation` VALUES ('263', '140401', '市辖区', '262');
INSERT INTO `wp_shop_nation` VALUES ('264', '140402', '城区', '262');
INSERT INTO `wp_shop_nation` VALUES ('265', '140411', '郊区', '262');
INSERT INTO `wp_shop_nation` VALUES ('266', '140421', '长治县', '262');
INSERT INTO `wp_shop_nation` VALUES ('267', '140423', '襄垣县', '262');
INSERT INTO `wp_shop_nation` VALUES ('268', '140424', '屯留县', '262');
INSERT INTO `wp_shop_nation` VALUES ('269', '140425', '平顺县', '262');
INSERT INTO `wp_shop_nation` VALUES ('270', '140426', '黎城县', '262');
INSERT INTO `wp_shop_nation` VALUES ('271', '140427', '壶关县', '262');
INSERT INTO `wp_shop_nation` VALUES ('272', '140428', '长子县', '262');
INSERT INTO `wp_shop_nation` VALUES ('273', '140429', '武乡县', '262');
INSERT INTO `wp_shop_nation` VALUES ('274', '140430', '沁县', '262');
INSERT INTO `wp_shop_nation` VALUES ('275', '140431', '沁源县', '262');
INSERT INTO `wp_shop_nation` VALUES ('276', '140481', '潞城市', '262');
INSERT INTO `wp_shop_nation` VALUES ('277', '140500', '晋城市', '229');
INSERT INTO `wp_shop_nation` VALUES ('278', '140501', '市辖区', '277');
INSERT INTO `wp_shop_nation` VALUES ('279', '140502', '城区', '277');
INSERT INTO `wp_shop_nation` VALUES ('280', '140521', '沁水县', '277');
INSERT INTO `wp_shop_nation` VALUES ('281', '140522', '阳城县', '277');
INSERT INTO `wp_shop_nation` VALUES ('282', '140524', '陵川县', '277');
INSERT INTO `wp_shop_nation` VALUES ('283', '140525', '泽州县', '277');
INSERT INTO `wp_shop_nation` VALUES ('284', '140581', '高平市', '277');
INSERT INTO `wp_shop_nation` VALUES ('285', '140600', '朔州市', '229');
INSERT INTO `wp_shop_nation` VALUES ('286', '140601', '市辖区', '285');
INSERT INTO `wp_shop_nation` VALUES ('287', '140602', '朔城区', '285');
INSERT INTO `wp_shop_nation` VALUES ('288', '140603', '平鲁区', '285');
INSERT INTO `wp_shop_nation` VALUES ('289', '140621', '山阴县', '285');
INSERT INTO `wp_shop_nation` VALUES ('290', '140622', '应县', '285');
INSERT INTO `wp_shop_nation` VALUES ('291', '140623', '右玉县', '285');
INSERT INTO `wp_shop_nation` VALUES ('292', '140624', '怀仁县', '285');
INSERT INTO `wp_shop_nation` VALUES ('293', '140700', '晋中市', '229');
INSERT INTO `wp_shop_nation` VALUES ('294', '140701', '市辖区', '293');
INSERT INTO `wp_shop_nation` VALUES ('295', '140702', '榆次区', '293');
INSERT INTO `wp_shop_nation` VALUES ('296', '140721', '榆社县', '293');
INSERT INTO `wp_shop_nation` VALUES ('297', '140722', '左权县', '293');
INSERT INTO `wp_shop_nation` VALUES ('298', '140723', '和顺县', '293');
INSERT INTO `wp_shop_nation` VALUES ('299', '140724', '昔阳县', '293');
INSERT INTO `wp_shop_nation` VALUES ('300', '140725', '寿阳县', '293');
INSERT INTO `wp_shop_nation` VALUES ('301', '140726', '太谷县', '293');
INSERT INTO `wp_shop_nation` VALUES ('302', '140727', '祁县', '293');
INSERT INTO `wp_shop_nation` VALUES ('303', '140728', '平遥县', '293');
INSERT INTO `wp_shop_nation` VALUES ('304', '140729', '灵石县', '293');
INSERT INTO `wp_shop_nation` VALUES ('305', '140781', '介休市', '293');
INSERT INTO `wp_shop_nation` VALUES ('306', '140800', '运城市', '229');
INSERT INTO `wp_shop_nation` VALUES ('307', '140801', '市辖区', '306');
INSERT INTO `wp_shop_nation` VALUES ('308', '140802', '盐湖区', '306');
INSERT INTO `wp_shop_nation` VALUES ('309', '140821', '临猗县', '306');
INSERT INTO `wp_shop_nation` VALUES ('310', '140822', '万荣县', '306');
INSERT INTO `wp_shop_nation` VALUES ('311', '140823', '闻喜县', '306');
INSERT INTO `wp_shop_nation` VALUES ('312', '140824', '稷山县', '306');
INSERT INTO `wp_shop_nation` VALUES ('313', '140825', '新绛县', '306');
INSERT INTO `wp_shop_nation` VALUES ('314', '140826', '绛县', '306');
INSERT INTO `wp_shop_nation` VALUES ('315', '140827', '垣曲县', '306');
INSERT INTO `wp_shop_nation` VALUES ('316', '140828', '夏县', '306');
INSERT INTO `wp_shop_nation` VALUES ('317', '140829', '平陆县', '306');
INSERT INTO `wp_shop_nation` VALUES ('318', '140830', '芮城县', '306');
INSERT INTO `wp_shop_nation` VALUES ('319', '140881', '永济市', '306');
INSERT INTO `wp_shop_nation` VALUES ('320', '140882', '河津市', '306');
INSERT INTO `wp_shop_nation` VALUES ('321', '140900', '忻州市', '229');
INSERT INTO `wp_shop_nation` VALUES ('322', '140901', '市辖区', '321');
INSERT INTO `wp_shop_nation` VALUES ('323', '140902', '忻府区', '321');
INSERT INTO `wp_shop_nation` VALUES ('324', '140921', '定襄县', '321');
INSERT INTO `wp_shop_nation` VALUES ('325', '140922', '五台县', '321');
INSERT INTO `wp_shop_nation` VALUES ('326', '140923', '代县', '321');
INSERT INTO `wp_shop_nation` VALUES ('327', '140924', '繁峙县', '321');
INSERT INTO `wp_shop_nation` VALUES ('328', '140925', '宁武县', '321');
INSERT INTO `wp_shop_nation` VALUES ('329', '140926', '静乐县', '321');
INSERT INTO `wp_shop_nation` VALUES ('330', '140927', '神池县', '321');
INSERT INTO `wp_shop_nation` VALUES ('331', '140928', '五寨县', '321');
INSERT INTO `wp_shop_nation` VALUES ('332', '140929', '岢岚县', '321');
INSERT INTO `wp_shop_nation` VALUES ('333', '140930', '河曲县', '321');
INSERT INTO `wp_shop_nation` VALUES ('334', '140931', '保德县', '321');
INSERT INTO `wp_shop_nation` VALUES ('335', '140932', '偏关县', '321');
INSERT INTO `wp_shop_nation` VALUES ('336', '140981', '原平市', '321');
INSERT INTO `wp_shop_nation` VALUES ('337', '141000', '临汾市', '229');
INSERT INTO `wp_shop_nation` VALUES ('338', '141001', '市辖区', '337');
INSERT INTO `wp_shop_nation` VALUES ('339', '141002', '尧都区', '337');
INSERT INTO `wp_shop_nation` VALUES ('340', '141021', '曲沃县', '337');
INSERT INTO `wp_shop_nation` VALUES ('341', '141022', '翼城县', '337');
INSERT INTO `wp_shop_nation` VALUES ('342', '141023', '襄汾县', '337');
INSERT INTO `wp_shop_nation` VALUES ('343', '141024', '洪洞县', '337');
INSERT INTO `wp_shop_nation` VALUES ('344', '141025', '古县', '337');
INSERT INTO `wp_shop_nation` VALUES ('345', '141026', '安泽县', '337');
INSERT INTO `wp_shop_nation` VALUES ('346', '141027', '浮山县', '337');
INSERT INTO `wp_shop_nation` VALUES ('347', '141028', '吉县', '337');
INSERT INTO `wp_shop_nation` VALUES ('348', '141029', '乡宁县', '337');
INSERT INTO `wp_shop_nation` VALUES ('349', '141030', '大宁县', '337');
INSERT INTO `wp_shop_nation` VALUES ('350', '141031', '隰县', '337');
INSERT INTO `wp_shop_nation` VALUES ('351', '141032', '永和县', '337');
INSERT INTO `wp_shop_nation` VALUES ('352', '141033', '蒲县', '337');
INSERT INTO `wp_shop_nation` VALUES ('353', '141034', '汾西县', '337');
INSERT INTO `wp_shop_nation` VALUES ('354', '141081', '侯马市', '337');
INSERT INTO `wp_shop_nation` VALUES ('355', '141082', '霍州市', '337');
INSERT INTO `wp_shop_nation` VALUES ('356', '141100', '吕梁市', '229');
INSERT INTO `wp_shop_nation` VALUES ('357', '141101', '市辖区', '356');
INSERT INTO `wp_shop_nation` VALUES ('358', '141102', '离石区', '356');
INSERT INTO `wp_shop_nation` VALUES ('359', '141121', '文水县', '356');
INSERT INTO `wp_shop_nation` VALUES ('360', '141122', '交城县', '356');
INSERT INTO `wp_shop_nation` VALUES ('361', '141123', '兴县', '356');
INSERT INTO `wp_shop_nation` VALUES ('362', '141124', '临县', '356');
INSERT INTO `wp_shop_nation` VALUES ('363', '141125', '柳林县', '356');
INSERT INTO `wp_shop_nation` VALUES ('364', '141126', '石楼县', '356');
INSERT INTO `wp_shop_nation` VALUES ('365', '141127', '岚县', '356');
INSERT INTO `wp_shop_nation` VALUES ('366', '141128', '方山县', '356');
INSERT INTO `wp_shop_nation` VALUES ('367', '141129', '中阳县', '356');
INSERT INTO `wp_shop_nation` VALUES ('368', '141130', '交口县', '356');
INSERT INTO `wp_shop_nation` VALUES ('369', '141181', '孝义市', '356');
INSERT INTO `wp_shop_nation` VALUES ('370', '141182', '汾阳市', '356');
INSERT INTO `wp_shop_nation` VALUES ('371', '150000', '内蒙古自治区', '0');
INSERT INTO `wp_shop_nation` VALUES ('372', '150100', '呼和浩特市', '371');
INSERT INTO `wp_shop_nation` VALUES ('373', '150101', '市辖区', '372');
INSERT INTO `wp_shop_nation` VALUES ('374', '150102', '新城区', '372');
INSERT INTO `wp_shop_nation` VALUES ('375', '150103', '回民区', '372');
INSERT INTO `wp_shop_nation` VALUES ('376', '150104', '玉泉区', '372');
INSERT INTO `wp_shop_nation` VALUES ('377', '150105', '赛罕区', '372');
INSERT INTO `wp_shop_nation` VALUES ('378', '150121', '土默特左旗', '372');
INSERT INTO `wp_shop_nation` VALUES ('379', '150122', '托克托县', '372');
INSERT INTO `wp_shop_nation` VALUES ('380', '150123', '和林格尔县', '372');
INSERT INTO `wp_shop_nation` VALUES ('381', '150124', '清水河县', '372');
INSERT INTO `wp_shop_nation` VALUES ('382', '150125', '武川县', '372');
INSERT INTO `wp_shop_nation` VALUES ('383', '150200', '包头市', '371');
INSERT INTO `wp_shop_nation` VALUES ('384', '150201', '市辖区', '383');
INSERT INTO `wp_shop_nation` VALUES ('385', '150202', '东河区', '383');
INSERT INTO `wp_shop_nation` VALUES ('386', '150203', '昆都仑区', '383');
INSERT INTO `wp_shop_nation` VALUES ('387', '150204', '青山区', '383');
INSERT INTO `wp_shop_nation` VALUES ('388', '150205', '石拐区', '383');
INSERT INTO `wp_shop_nation` VALUES ('389', '150206', '白云鄂博矿区', '383');
INSERT INTO `wp_shop_nation` VALUES ('390', '150207', '九原区', '383');
INSERT INTO `wp_shop_nation` VALUES ('391', '150221', '土默特右旗', '383');
INSERT INTO `wp_shop_nation` VALUES ('392', '150222', '固阳县', '383');
INSERT INTO `wp_shop_nation` VALUES ('393', '150223', '达尔罕茂明安联合旗', '383');
INSERT INTO `wp_shop_nation` VALUES ('394', '150300', '乌海市', '371');
INSERT INTO `wp_shop_nation` VALUES ('395', '150301', '市辖区', '394');
INSERT INTO `wp_shop_nation` VALUES ('396', '150302', '海勃湾区', '394');
INSERT INTO `wp_shop_nation` VALUES ('397', '150303', '海南区', '394');
INSERT INTO `wp_shop_nation` VALUES ('398', '150304', '乌达区', '394');
INSERT INTO `wp_shop_nation` VALUES ('399', '150400', '赤峰市', '371');
INSERT INTO `wp_shop_nation` VALUES ('400', '150401', '市辖区', '399');
INSERT INTO `wp_shop_nation` VALUES ('401', '150402', '红山区', '399');
INSERT INTO `wp_shop_nation` VALUES ('402', '150403', '元宝山区', '399');
INSERT INTO `wp_shop_nation` VALUES ('403', '150404', '松山区', '399');
INSERT INTO `wp_shop_nation` VALUES ('404', '150421', '阿鲁科尔沁旗', '399');
INSERT INTO `wp_shop_nation` VALUES ('405', '150422', '巴林左旗', '399');
INSERT INTO `wp_shop_nation` VALUES ('406', '150423', '巴林右旗', '399');
INSERT INTO `wp_shop_nation` VALUES ('407', '150424', '林西县', '399');
INSERT INTO `wp_shop_nation` VALUES ('408', '150425', '克什克腾旗', '399');
INSERT INTO `wp_shop_nation` VALUES ('409', '150426', '翁牛特旗', '399');
INSERT INTO `wp_shop_nation` VALUES ('410', '150428', '喀喇沁旗', '399');
INSERT INTO `wp_shop_nation` VALUES ('411', '150429', '宁城县', '399');
INSERT INTO `wp_shop_nation` VALUES ('412', '150430', '敖汉旗', '399');
INSERT INTO `wp_shop_nation` VALUES ('413', '150500', '通辽市', '371');
INSERT INTO `wp_shop_nation` VALUES ('414', '150501', '市辖区', '413');
INSERT INTO `wp_shop_nation` VALUES ('415', '150502', '科尔沁区', '413');
INSERT INTO `wp_shop_nation` VALUES ('416', '150521', '科尔沁左翼中旗', '413');
INSERT INTO `wp_shop_nation` VALUES ('417', '150522', '科尔沁左翼后旗', '413');
INSERT INTO `wp_shop_nation` VALUES ('418', '150523', '开鲁县', '413');
INSERT INTO `wp_shop_nation` VALUES ('419', '150524', '库伦旗', '413');
INSERT INTO `wp_shop_nation` VALUES ('420', '150525', '奈曼旗', '413');
INSERT INTO `wp_shop_nation` VALUES ('421', '150526', '扎鲁特旗', '413');
INSERT INTO `wp_shop_nation` VALUES ('422', '150581', '霍林郭勒市', '413');
INSERT INTO `wp_shop_nation` VALUES ('423', '150600', '鄂尔多斯市', '371');
INSERT INTO `wp_shop_nation` VALUES ('424', '150601', '市辖区', '423');
INSERT INTO `wp_shop_nation` VALUES ('425', '150602', '东胜区', '423');
INSERT INTO `wp_shop_nation` VALUES ('426', '150621', '达拉特旗', '423');
INSERT INTO `wp_shop_nation` VALUES ('427', '150622', '准格尔旗', '423');
INSERT INTO `wp_shop_nation` VALUES ('428', '150623', '鄂托克前旗', '423');
INSERT INTO `wp_shop_nation` VALUES ('429', '150624', '鄂托克旗', '423');
INSERT INTO `wp_shop_nation` VALUES ('430', '150625', '杭锦旗', '423');
INSERT INTO `wp_shop_nation` VALUES ('431', '150626', '乌审旗', '423');
INSERT INTO `wp_shop_nation` VALUES ('432', '150627', '伊金霍洛旗', '423');
INSERT INTO `wp_shop_nation` VALUES ('433', '150700', '呼伦贝尔市', '371');
INSERT INTO `wp_shop_nation` VALUES ('434', '150701', '市辖区', '433');
INSERT INTO `wp_shop_nation` VALUES ('435', '150702', '海拉尔区', '433');
INSERT INTO `wp_shop_nation` VALUES ('436', '150703', '扎赉诺尔区', '433');
INSERT INTO `wp_shop_nation` VALUES ('437', '150721', '阿荣旗', '433');
INSERT INTO `wp_shop_nation` VALUES ('438', '150722', '莫力达瓦达斡尔族自治旗', '433');
INSERT INTO `wp_shop_nation` VALUES ('439', '150723', '鄂伦春自治旗', '433');
INSERT INTO `wp_shop_nation` VALUES ('440', '150724', '鄂温克族自治旗', '433');
INSERT INTO `wp_shop_nation` VALUES ('441', '150725', '陈巴尔虎旗', '433');
INSERT INTO `wp_shop_nation` VALUES ('442', '150726', '新巴尔虎左旗', '433');
INSERT INTO `wp_shop_nation` VALUES ('443', '150727', '新巴尔虎右旗', '433');
INSERT INTO `wp_shop_nation` VALUES ('444', '150781', '满洲里市', '433');
INSERT INTO `wp_shop_nation` VALUES ('445', '150782', '牙克石市', '433');
INSERT INTO `wp_shop_nation` VALUES ('446', '150783', '扎兰屯市', '433');
INSERT INTO `wp_shop_nation` VALUES ('447', '150784', '额尔古纳市', '433');
INSERT INTO `wp_shop_nation` VALUES ('448', '150785', '根河市', '433');
INSERT INTO `wp_shop_nation` VALUES ('449', '150800', '巴彦淖尔市', '371');
INSERT INTO `wp_shop_nation` VALUES ('450', '150801', '市辖区', '449');
INSERT INTO `wp_shop_nation` VALUES ('451', '150802', '临河区', '449');
INSERT INTO `wp_shop_nation` VALUES ('452', '150821', '五原县', '449');
INSERT INTO `wp_shop_nation` VALUES ('453', '150822', '磴口县', '449');
INSERT INTO `wp_shop_nation` VALUES ('454', '150823', '乌拉特前旗', '449');
INSERT INTO `wp_shop_nation` VALUES ('455', '150824', '乌拉特中旗', '449');
INSERT INTO `wp_shop_nation` VALUES ('456', '150825', '乌拉特后旗', '449');
INSERT INTO `wp_shop_nation` VALUES ('457', '150826', '杭锦后旗', '449');
INSERT INTO `wp_shop_nation` VALUES ('458', '150900', '乌兰察布市', '371');
INSERT INTO `wp_shop_nation` VALUES ('459', '150901', '市辖区', '458');
INSERT INTO `wp_shop_nation` VALUES ('460', '150902', '集宁区', '458');
INSERT INTO `wp_shop_nation` VALUES ('461', '150921', '卓资县', '458');
INSERT INTO `wp_shop_nation` VALUES ('462', '150922', '化德县', '458');
INSERT INTO `wp_shop_nation` VALUES ('463', '150923', '商都县', '458');
INSERT INTO `wp_shop_nation` VALUES ('464', '150924', '兴和县', '458');
INSERT INTO `wp_shop_nation` VALUES ('465', '150925', '凉城县', '458');
INSERT INTO `wp_shop_nation` VALUES ('466', '150926', '察哈尔右翼前旗', '458');
INSERT INTO `wp_shop_nation` VALUES ('467', '150927', '察哈尔右翼中旗', '458');
INSERT INTO `wp_shop_nation` VALUES ('468', '150928', '察哈尔右翼后旗', '458');
INSERT INTO `wp_shop_nation` VALUES ('469', '150929', '四子王旗', '458');
INSERT INTO `wp_shop_nation` VALUES ('470', '150981', '丰镇市', '458');
INSERT INTO `wp_shop_nation` VALUES ('471', '152200', '兴安盟', '371');
INSERT INTO `wp_shop_nation` VALUES ('472', '152201', '乌兰浩特市', '471');
INSERT INTO `wp_shop_nation` VALUES ('473', '152202', '阿尔山市', '471');
INSERT INTO `wp_shop_nation` VALUES ('474', '152221', '科尔沁右翼前旗', '471');
INSERT INTO `wp_shop_nation` VALUES ('475', '152222', '科尔沁右翼中旗', '471');
INSERT INTO `wp_shop_nation` VALUES ('476', '152223', '扎赉特旗', '471');
INSERT INTO `wp_shop_nation` VALUES ('477', '152224', '突泉县', '471');
INSERT INTO `wp_shop_nation` VALUES ('478', '152500', '锡林郭勒盟', '371');
INSERT INTO `wp_shop_nation` VALUES ('479', '152501', '二连浩特市', '478');
INSERT INTO `wp_shop_nation` VALUES ('480', '152502', '锡林浩特市', '478');
INSERT INTO `wp_shop_nation` VALUES ('481', '152522', '阿巴嘎旗', '478');
INSERT INTO `wp_shop_nation` VALUES ('482', '152523', '苏尼特左旗', '478');
INSERT INTO `wp_shop_nation` VALUES ('483', '152524', '苏尼特右旗', '478');
INSERT INTO `wp_shop_nation` VALUES ('484', '152525', '东乌珠穆沁旗', '478');
INSERT INTO `wp_shop_nation` VALUES ('485', '152526', '西乌珠穆沁旗', '478');
INSERT INTO `wp_shop_nation` VALUES ('486', '152527', '太仆寺旗', '478');
INSERT INTO `wp_shop_nation` VALUES ('487', '152528', '镶黄旗', '478');
INSERT INTO `wp_shop_nation` VALUES ('488', '152529', '正镶白旗', '478');
INSERT INTO `wp_shop_nation` VALUES ('489', '152530', '正蓝旗', '478');
INSERT INTO `wp_shop_nation` VALUES ('490', '152531', '多伦县', '478');
INSERT INTO `wp_shop_nation` VALUES ('491', '152900', '阿拉善盟', '371');
INSERT INTO `wp_shop_nation` VALUES ('492', '152921', '阿拉善左旗', '491');
INSERT INTO `wp_shop_nation` VALUES ('493', '152922', '阿拉善右旗', '491');
INSERT INTO `wp_shop_nation` VALUES ('494', '152923', '额济纳旗', '491');
INSERT INTO `wp_shop_nation` VALUES ('495', '210000', '辽宁省', '0');
INSERT INTO `wp_shop_nation` VALUES ('496', '210100', '沈阳市', '495');
INSERT INTO `wp_shop_nation` VALUES ('497', '210101', '市辖区', '496');
INSERT INTO `wp_shop_nation` VALUES ('498', '210102', '和平区', '496');
INSERT INTO `wp_shop_nation` VALUES ('499', '210103', '沈河区', '496');
INSERT INTO `wp_shop_nation` VALUES ('500', '210104', '大东区', '496');
INSERT INTO `wp_shop_nation` VALUES ('501', '210105', '皇姑区', '496');
INSERT INTO `wp_shop_nation` VALUES ('502', '210106', '铁西区', '496');
INSERT INTO `wp_shop_nation` VALUES ('503', '210111', '苏家屯区', '496');
INSERT INTO `wp_shop_nation` VALUES ('504', '210112', '浑南区', '496');
INSERT INTO `wp_shop_nation` VALUES ('505', '210113', '沈北新区', '496');
INSERT INTO `wp_shop_nation` VALUES ('506', '210114', '于洪区', '496');
INSERT INTO `wp_shop_nation` VALUES ('507', '210122', '辽中县', '496');
INSERT INTO `wp_shop_nation` VALUES ('508', '210123', '康平县', '496');
INSERT INTO `wp_shop_nation` VALUES ('509', '210124', '法库县', '496');
INSERT INTO `wp_shop_nation` VALUES ('510', '210181', '新民市', '496');
INSERT INTO `wp_shop_nation` VALUES ('511', '210200', '大连市', '495');
INSERT INTO `wp_shop_nation` VALUES ('512', '210201', '市辖区', '511');
INSERT INTO `wp_shop_nation` VALUES ('513', '210202', '中山区', '511');
INSERT INTO `wp_shop_nation` VALUES ('514', '210203', '西岗区', '511');
INSERT INTO `wp_shop_nation` VALUES ('515', '210204', '沙河口区', '511');
INSERT INTO `wp_shop_nation` VALUES ('516', '210211', '甘井子区', '511');
INSERT INTO `wp_shop_nation` VALUES ('517', '210212', '旅顺口区', '511');
INSERT INTO `wp_shop_nation` VALUES ('518', '210213', '金州区', '511');
INSERT INTO `wp_shop_nation` VALUES ('519', '210224', '长海县', '511');
INSERT INTO `wp_shop_nation` VALUES ('520', '210281', '瓦房店市', '511');
INSERT INTO `wp_shop_nation` VALUES ('521', '210282', '普兰店市', '511');
INSERT INTO `wp_shop_nation` VALUES ('522', '210283', '庄河市', '511');
INSERT INTO `wp_shop_nation` VALUES ('523', '210300', '鞍山市', '495');
INSERT INTO `wp_shop_nation` VALUES ('524', '210301', '市辖区', '523');
INSERT INTO `wp_shop_nation` VALUES ('525', '210302', '铁东区', '523');
INSERT INTO `wp_shop_nation` VALUES ('526', '210303', '铁西区', '523');
INSERT INTO `wp_shop_nation` VALUES ('527', '210304', '立山区', '523');
INSERT INTO `wp_shop_nation` VALUES ('528', '210311', '千山区', '523');
INSERT INTO `wp_shop_nation` VALUES ('529', '210321', '台安县', '523');
INSERT INTO `wp_shop_nation` VALUES ('530', '210323', '岫岩满族自治县', '523');
INSERT INTO `wp_shop_nation` VALUES ('531', '210381', '海城市', '523');
INSERT INTO `wp_shop_nation` VALUES ('532', '210400', '抚顺市', '495');
INSERT INTO `wp_shop_nation` VALUES ('533', '210401', '市辖区', '532');
INSERT INTO `wp_shop_nation` VALUES ('534', '210402', '新抚区', '532');
INSERT INTO `wp_shop_nation` VALUES ('535', '210403', '东洲区', '532');
INSERT INTO `wp_shop_nation` VALUES ('536', '210404', '望花区', '532');
INSERT INTO `wp_shop_nation` VALUES ('537', '210411', '顺城区', '532');
INSERT INTO `wp_shop_nation` VALUES ('538', '210421', '抚顺县', '532');
INSERT INTO `wp_shop_nation` VALUES ('539', '210422', '新宾满族自治县', '532');
INSERT INTO `wp_shop_nation` VALUES ('540', '210423', '清原满族自治县', '532');
INSERT INTO `wp_shop_nation` VALUES ('541', '210500', '本溪市', '495');
INSERT INTO `wp_shop_nation` VALUES ('542', '210501', '市辖区', '541');
INSERT INTO `wp_shop_nation` VALUES ('543', '210502', '平山区', '541');
INSERT INTO `wp_shop_nation` VALUES ('544', '210503', '溪湖区', '541');
INSERT INTO `wp_shop_nation` VALUES ('545', '210504', '明山区', '541');
INSERT INTO `wp_shop_nation` VALUES ('546', '210505', '南芬区', '541');
INSERT INTO `wp_shop_nation` VALUES ('547', '210521', '本溪满族自治县', '541');
INSERT INTO `wp_shop_nation` VALUES ('548', '210522', '桓仁满族自治县', '541');
INSERT INTO `wp_shop_nation` VALUES ('549', '210600', '丹东市', '495');
INSERT INTO `wp_shop_nation` VALUES ('550', '210601', '市辖区', '549');
INSERT INTO `wp_shop_nation` VALUES ('551', '210602', '元宝区', '549');
INSERT INTO `wp_shop_nation` VALUES ('552', '210603', '振兴区', '549');
INSERT INTO `wp_shop_nation` VALUES ('553', '210604', '振安区', '549');
INSERT INTO `wp_shop_nation` VALUES ('554', '210624', '宽甸满族自治县', '549');
INSERT INTO `wp_shop_nation` VALUES ('555', '210681', '东港市', '549');
INSERT INTO `wp_shop_nation` VALUES ('556', '210682', '凤城市', '549');
INSERT INTO `wp_shop_nation` VALUES ('557', '210700', '锦州市', '495');
INSERT INTO `wp_shop_nation` VALUES ('558', '210701', '市辖区', '557');
INSERT INTO `wp_shop_nation` VALUES ('559', '210702', '古塔区', '557');
INSERT INTO `wp_shop_nation` VALUES ('560', '210703', '凌河区', '557');
INSERT INTO `wp_shop_nation` VALUES ('561', '210711', '太和区', '557');
INSERT INTO `wp_shop_nation` VALUES ('562', '210726', '黑山县', '557');
INSERT INTO `wp_shop_nation` VALUES ('563', '210727', '义县', '557');
INSERT INTO `wp_shop_nation` VALUES ('564', '210781', '凌海市', '557');
INSERT INTO `wp_shop_nation` VALUES ('565', '210782', '北镇市', '557');
INSERT INTO `wp_shop_nation` VALUES ('566', '210800', '营口市', '495');
INSERT INTO `wp_shop_nation` VALUES ('567', '210801', '市辖区', '566');
INSERT INTO `wp_shop_nation` VALUES ('568', '210802', '站前区', '566');
INSERT INTO `wp_shop_nation` VALUES ('569', '210803', '西市区', '566');
INSERT INTO `wp_shop_nation` VALUES ('570', '210804', '鲅鱼圈区', '566');
INSERT INTO `wp_shop_nation` VALUES ('571', '210811', '老边区', '566');
INSERT INTO `wp_shop_nation` VALUES ('572', '210881', '盖州市', '566');
INSERT INTO `wp_shop_nation` VALUES ('573', '210882', '大石桥市', '566');
INSERT INTO `wp_shop_nation` VALUES ('574', '210900', '阜新市', '495');
INSERT INTO `wp_shop_nation` VALUES ('575', '210901', '市辖区', '574');
INSERT INTO `wp_shop_nation` VALUES ('576', '210902', '海州区', '574');
INSERT INTO `wp_shop_nation` VALUES ('577', '210903', '新邱区', '574');
INSERT INTO `wp_shop_nation` VALUES ('578', '210904', '太平区', '574');
INSERT INTO `wp_shop_nation` VALUES ('579', '210905', '清河门区', '574');
INSERT INTO `wp_shop_nation` VALUES ('580', '210911', '细河区', '574');
INSERT INTO `wp_shop_nation` VALUES ('581', '210921', '阜新蒙古族自治县', '574');
INSERT INTO `wp_shop_nation` VALUES ('582', '210922', '彰武县', '574');
INSERT INTO `wp_shop_nation` VALUES ('583', '211000', '辽阳市', '495');
INSERT INTO `wp_shop_nation` VALUES ('584', '211001', '市辖区', '583');
INSERT INTO `wp_shop_nation` VALUES ('585', '211002', '白塔区', '583');
INSERT INTO `wp_shop_nation` VALUES ('586', '211003', '文圣区', '583');
INSERT INTO `wp_shop_nation` VALUES ('587', '211004', '宏伟区', '583');
INSERT INTO `wp_shop_nation` VALUES ('588', '211005', '弓长岭区', '583');
INSERT INTO `wp_shop_nation` VALUES ('589', '211011', '太子河区', '583');
INSERT INTO `wp_shop_nation` VALUES ('590', '211021', '辽阳县', '583');
INSERT INTO `wp_shop_nation` VALUES ('591', '211081', '灯塔市', '583');
INSERT INTO `wp_shop_nation` VALUES ('592', '211100', '盘锦市', '495');
INSERT INTO `wp_shop_nation` VALUES ('593', '211101', '市辖区', '592');
INSERT INTO `wp_shop_nation` VALUES ('594', '211102', '双台子区', '592');
INSERT INTO `wp_shop_nation` VALUES ('595', '211103', '兴隆台区', '592');
INSERT INTO `wp_shop_nation` VALUES ('596', '211121', '大洼县', '592');
INSERT INTO `wp_shop_nation` VALUES ('597', '211122', '盘山县', '592');
INSERT INTO `wp_shop_nation` VALUES ('598', '211200', '铁岭市', '495');
INSERT INTO `wp_shop_nation` VALUES ('599', '211201', '市辖区', '598');
INSERT INTO `wp_shop_nation` VALUES ('600', '211202', '银州区', '598');
INSERT INTO `wp_shop_nation` VALUES ('601', '211204', '清河区', '598');
INSERT INTO `wp_shop_nation` VALUES ('602', '211221', '铁岭县', '598');
INSERT INTO `wp_shop_nation` VALUES ('603', '211223', '西丰县', '598');
INSERT INTO `wp_shop_nation` VALUES ('604', '211224', '昌图县', '598');
INSERT INTO `wp_shop_nation` VALUES ('605', '211281', '调兵山市', '598');
INSERT INTO `wp_shop_nation` VALUES ('606', '211282', '开原市', '598');
INSERT INTO `wp_shop_nation` VALUES ('607', '211300', '朝阳市', '495');
INSERT INTO `wp_shop_nation` VALUES ('608', '211301', '市辖区', '607');
INSERT INTO `wp_shop_nation` VALUES ('609', '211302', '双塔区', '607');
INSERT INTO `wp_shop_nation` VALUES ('610', '211303', '龙城区', '607');
INSERT INTO `wp_shop_nation` VALUES ('611', '211321', '朝阳县', '607');
INSERT INTO `wp_shop_nation` VALUES ('612', '211322', '建平县', '607');
INSERT INTO `wp_shop_nation` VALUES ('613', '211324', '喀喇沁左翼蒙古族自治县', '607');
INSERT INTO `wp_shop_nation` VALUES ('614', '211381', '北票市', '607');
INSERT INTO `wp_shop_nation` VALUES ('615', '211382', '凌源市', '607');
INSERT INTO `wp_shop_nation` VALUES ('616', '211400', '葫芦岛市', '495');
INSERT INTO `wp_shop_nation` VALUES ('617', '211401', '市辖区', '616');
INSERT INTO `wp_shop_nation` VALUES ('618', '211402', '连山区', '616');
INSERT INTO `wp_shop_nation` VALUES ('619', '211403', '龙港区', '616');
INSERT INTO `wp_shop_nation` VALUES ('620', '211404', '南票区', '616');
INSERT INTO `wp_shop_nation` VALUES ('621', '211421', '绥中县', '616');
INSERT INTO `wp_shop_nation` VALUES ('622', '211422', '建昌县', '616');
INSERT INTO `wp_shop_nation` VALUES ('623', '211481', '兴城市', '616');
INSERT INTO `wp_shop_nation` VALUES ('624', '220000', '吉林省', '0');
INSERT INTO `wp_shop_nation` VALUES ('625', '220100', '长春市', '624');
INSERT INTO `wp_shop_nation` VALUES ('626', '220101', '市辖区', '625');
INSERT INTO `wp_shop_nation` VALUES ('627', '220102', '南关区', '625');
INSERT INTO `wp_shop_nation` VALUES ('628', '220103', '宽城区', '625');
INSERT INTO `wp_shop_nation` VALUES ('629', '220104', '朝阳区', '625');
INSERT INTO `wp_shop_nation` VALUES ('630', '220105', '二道区', '625');
INSERT INTO `wp_shop_nation` VALUES ('631', '220106', '绿园区', '625');
INSERT INTO `wp_shop_nation` VALUES ('632', '220112', '双阳区', '625');
INSERT INTO `wp_shop_nation` VALUES ('633', '220113', '九台区', '625');
INSERT INTO `wp_shop_nation` VALUES ('634', '220122', '农安县', '625');
INSERT INTO `wp_shop_nation` VALUES ('635', '220182', '榆树市', '625');
INSERT INTO `wp_shop_nation` VALUES ('636', '220183', '德惠市', '625');
INSERT INTO `wp_shop_nation` VALUES ('637', '220200', '吉林市', '624');
INSERT INTO `wp_shop_nation` VALUES ('638', '220201', '市辖区', '637');
INSERT INTO `wp_shop_nation` VALUES ('639', '220202', '昌邑区', '637');
INSERT INTO `wp_shop_nation` VALUES ('640', '220203', '龙潭区', '637');
INSERT INTO `wp_shop_nation` VALUES ('641', '220204', '船营区', '637');
INSERT INTO `wp_shop_nation` VALUES ('642', '220211', '丰满区', '637');
INSERT INTO `wp_shop_nation` VALUES ('643', '220221', '永吉县', '637');
INSERT INTO `wp_shop_nation` VALUES ('644', '220281', '蛟河市', '637');
INSERT INTO `wp_shop_nation` VALUES ('645', '220282', '桦甸市', '637');
INSERT INTO `wp_shop_nation` VALUES ('646', '220283', '舒兰市', '637');
INSERT INTO `wp_shop_nation` VALUES ('647', '220284', '磐石市', '637');
INSERT INTO `wp_shop_nation` VALUES ('648', '220300', '四平市', '624');
INSERT INTO `wp_shop_nation` VALUES ('649', '220301', '市辖区', '648');
INSERT INTO `wp_shop_nation` VALUES ('650', '220302', '铁西区', '648');
INSERT INTO `wp_shop_nation` VALUES ('651', '220303', '铁东区', '648');
INSERT INTO `wp_shop_nation` VALUES ('652', '220322', '梨树县', '648');
INSERT INTO `wp_shop_nation` VALUES ('653', '220323', '伊通满族自治县', '648');
INSERT INTO `wp_shop_nation` VALUES ('654', '220381', '公主岭市', '648');
INSERT INTO `wp_shop_nation` VALUES ('655', '220382', '双辽市', '648');
INSERT INTO `wp_shop_nation` VALUES ('656', '220400', '辽源市', '624');
INSERT INTO `wp_shop_nation` VALUES ('657', '220401', '市辖区', '656');
INSERT INTO `wp_shop_nation` VALUES ('658', '220402', '龙山区', '656');
INSERT INTO `wp_shop_nation` VALUES ('659', '220403', '西安区', '656');
INSERT INTO `wp_shop_nation` VALUES ('660', '220421', '东丰县', '656');
INSERT INTO `wp_shop_nation` VALUES ('661', '220422', '东辽县', '656');
INSERT INTO `wp_shop_nation` VALUES ('662', '220500', '通化市', '624');
INSERT INTO `wp_shop_nation` VALUES ('663', '220501', '市辖区', '662');
INSERT INTO `wp_shop_nation` VALUES ('664', '220502', '东昌区', '662');
INSERT INTO `wp_shop_nation` VALUES ('665', '220503', '二道江区', '662');
INSERT INTO `wp_shop_nation` VALUES ('666', '220521', '通化县', '662');
INSERT INTO `wp_shop_nation` VALUES ('667', '220523', '辉南县', '662');
INSERT INTO `wp_shop_nation` VALUES ('668', '220524', '柳河县', '662');
INSERT INTO `wp_shop_nation` VALUES ('669', '220581', '梅河口市', '662');
INSERT INTO `wp_shop_nation` VALUES ('670', '220582', '集安市', '662');
INSERT INTO `wp_shop_nation` VALUES ('671', '220600', '白山市', '624');
INSERT INTO `wp_shop_nation` VALUES ('672', '220601', '市辖区', '671');
INSERT INTO `wp_shop_nation` VALUES ('673', '220602', '浑江区', '671');
INSERT INTO `wp_shop_nation` VALUES ('674', '220605', '江源区', '671');
INSERT INTO `wp_shop_nation` VALUES ('675', '220621', '抚松县', '671');
INSERT INTO `wp_shop_nation` VALUES ('676', '220622', '靖宇县', '671');
INSERT INTO `wp_shop_nation` VALUES ('677', '220623', '长白朝鲜族自治县', '671');
INSERT INTO `wp_shop_nation` VALUES ('678', '220681', '临江市', '671');
INSERT INTO `wp_shop_nation` VALUES ('679', '220700', '松原市', '624');
INSERT INTO `wp_shop_nation` VALUES ('680', '220701', '市辖区', '679');
INSERT INTO `wp_shop_nation` VALUES ('681', '220702', '宁江区', '679');
INSERT INTO `wp_shop_nation` VALUES ('682', '220721', '前郭尔罗斯蒙古族自治县', '679');
INSERT INTO `wp_shop_nation` VALUES ('683', '220722', '长岭县', '679');
INSERT INTO `wp_shop_nation` VALUES ('684', '220723', '乾安县', '679');
INSERT INTO `wp_shop_nation` VALUES ('685', '220781', '扶余市', '679');
INSERT INTO `wp_shop_nation` VALUES ('686', '220800', '白城市', '624');
INSERT INTO `wp_shop_nation` VALUES ('687', '220801', '市辖区', '686');
INSERT INTO `wp_shop_nation` VALUES ('688', '220802', '洮北区', '686');
INSERT INTO `wp_shop_nation` VALUES ('689', '220821', '镇赉县', '686');
INSERT INTO `wp_shop_nation` VALUES ('690', '220822', '通榆县', '686');
INSERT INTO `wp_shop_nation` VALUES ('691', '220881', '洮南市', '686');
INSERT INTO `wp_shop_nation` VALUES ('692', '220882', '大安市', '686');
INSERT INTO `wp_shop_nation` VALUES ('693', '222400', '延边朝鲜族自治州', '624');
INSERT INTO `wp_shop_nation` VALUES ('694', '222401', '延吉市', '693');
INSERT INTO `wp_shop_nation` VALUES ('695', '222402', '图们市', '693');
INSERT INTO `wp_shop_nation` VALUES ('696', '222403', '敦化市', '693');
INSERT INTO `wp_shop_nation` VALUES ('697', '222404', '珲春市', '693');
INSERT INTO `wp_shop_nation` VALUES ('698', '222405', '龙井市', '693');
INSERT INTO `wp_shop_nation` VALUES ('699', '222406', '和龙市', '693');
INSERT INTO `wp_shop_nation` VALUES ('700', '222424', '汪清县', '693');
INSERT INTO `wp_shop_nation` VALUES ('701', '222426', '安图县', '693');
INSERT INTO `wp_shop_nation` VALUES ('702', '230000', '黑龙江省', '0');
INSERT INTO `wp_shop_nation` VALUES ('703', '230100', '哈尔滨市', '702');
INSERT INTO `wp_shop_nation` VALUES ('704', '230101', '市辖区', '703');
INSERT INTO `wp_shop_nation` VALUES ('705', '230102', '道里区', '703');
INSERT INTO `wp_shop_nation` VALUES ('706', '230103', '南岗区', '703');
INSERT INTO `wp_shop_nation` VALUES ('707', '230104', '道外区', '703');
INSERT INTO `wp_shop_nation` VALUES ('708', '230108', '平房区', '703');
INSERT INTO `wp_shop_nation` VALUES ('709', '230109', '松北区', '703');
INSERT INTO `wp_shop_nation` VALUES ('710', '230110', '香坊区', '703');
INSERT INTO `wp_shop_nation` VALUES ('711', '230111', '呼兰区', '703');
INSERT INTO `wp_shop_nation` VALUES ('712', '230112', '阿城区', '703');
INSERT INTO `wp_shop_nation` VALUES ('713', '230113', '双城区', '703');
INSERT INTO `wp_shop_nation` VALUES ('714', '230123', '依兰县', '703');
INSERT INTO `wp_shop_nation` VALUES ('715', '230124', '方正县', '703');
INSERT INTO `wp_shop_nation` VALUES ('716', '230125', '宾县', '703');
INSERT INTO `wp_shop_nation` VALUES ('717', '230126', '巴彦县', '703');
INSERT INTO `wp_shop_nation` VALUES ('718', '230127', '木兰县', '703');
INSERT INTO `wp_shop_nation` VALUES ('719', '230128', '通河县', '703');
INSERT INTO `wp_shop_nation` VALUES ('720', '230129', '延寿县', '703');
INSERT INTO `wp_shop_nation` VALUES ('721', '230183', '尚志市', '703');
INSERT INTO `wp_shop_nation` VALUES ('722', '230184', '五常市', '703');
INSERT INTO `wp_shop_nation` VALUES ('723', '230200', '齐齐哈尔市', '702');
INSERT INTO `wp_shop_nation` VALUES ('724', '230201', '市辖区', '723');
INSERT INTO `wp_shop_nation` VALUES ('725', '230202', '龙沙区', '723');
INSERT INTO `wp_shop_nation` VALUES ('726', '230203', '建华区', '723');
INSERT INTO `wp_shop_nation` VALUES ('727', '230204', '铁锋区', '723');
INSERT INTO `wp_shop_nation` VALUES ('728', '230205', '昂昂溪区', '723');
INSERT INTO `wp_shop_nation` VALUES ('729', '230206', '富拉尔基区', '723');
INSERT INTO `wp_shop_nation` VALUES ('730', '230207', '碾子山区', '723');
INSERT INTO `wp_shop_nation` VALUES ('731', '230208', '梅里斯达斡尔族区', '723');
INSERT INTO `wp_shop_nation` VALUES ('732', '230221', '龙江县', '723');
INSERT INTO `wp_shop_nation` VALUES ('733', '230223', '依安县', '723');
INSERT INTO `wp_shop_nation` VALUES ('734', '230224', '泰来县', '723');
INSERT INTO `wp_shop_nation` VALUES ('735', '230225', '甘南县', '723');
INSERT INTO `wp_shop_nation` VALUES ('736', '230227', '富裕县', '723');
INSERT INTO `wp_shop_nation` VALUES ('737', '230229', '克山县', '723');
INSERT INTO `wp_shop_nation` VALUES ('738', '230230', '克东县', '723');
INSERT INTO `wp_shop_nation` VALUES ('739', '230231', '拜泉县', '723');
INSERT INTO `wp_shop_nation` VALUES ('740', '230281', '讷河市', '723');
INSERT INTO `wp_shop_nation` VALUES ('741', '230300', '鸡西市', '702');
INSERT INTO `wp_shop_nation` VALUES ('742', '230301', '市辖区', '741');
INSERT INTO `wp_shop_nation` VALUES ('743', '230302', '鸡冠区', '741');
INSERT INTO `wp_shop_nation` VALUES ('744', '230303', '恒山区', '741');
INSERT INTO `wp_shop_nation` VALUES ('745', '230304', '滴道区', '741');
INSERT INTO `wp_shop_nation` VALUES ('746', '230305', '梨树区', '741');
INSERT INTO `wp_shop_nation` VALUES ('747', '230306', '城子河区', '741');
INSERT INTO `wp_shop_nation` VALUES ('748', '230307', '麻山区', '741');
INSERT INTO `wp_shop_nation` VALUES ('749', '230321', '鸡东县', '741');
INSERT INTO `wp_shop_nation` VALUES ('750', '230381', '虎林市', '741');
INSERT INTO `wp_shop_nation` VALUES ('751', '230382', '密山市', '741');
INSERT INTO `wp_shop_nation` VALUES ('752', '230400', '鹤岗市', '702');
INSERT INTO `wp_shop_nation` VALUES ('753', '230401', '市辖区', '752');
INSERT INTO `wp_shop_nation` VALUES ('754', '230402', '向阳区', '752');
INSERT INTO `wp_shop_nation` VALUES ('755', '230403', '工农区', '752');
INSERT INTO `wp_shop_nation` VALUES ('756', '230404', '南山区', '752');
INSERT INTO `wp_shop_nation` VALUES ('757', '230405', '兴安区', '752');
INSERT INTO `wp_shop_nation` VALUES ('758', '230406', '东山区', '752');
INSERT INTO `wp_shop_nation` VALUES ('759', '230407', '兴山区', '752');
INSERT INTO `wp_shop_nation` VALUES ('760', '230421', '萝北县', '752');
INSERT INTO `wp_shop_nation` VALUES ('761', '230422', '绥滨县', '752');
INSERT INTO `wp_shop_nation` VALUES ('762', '230500', '双鸭山市', '702');
INSERT INTO `wp_shop_nation` VALUES ('763', '230501', '市辖区', '762');
INSERT INTO `wp_shop_nation` VALUES ('764', '230502', '尖山区', '762');
INSERT INTO `wp_shop_nation` VALUES ('765', '230503', '岭东区', '762');
INSERT INTO `wp_shop_nation` VALUES ('766', '230505', '四方台区', '762');
INSERT INTO `wp_shop_nation` VALUES ('767', '230506', '宝山区', '762');
INSERT INTO `wp_shop_nation` VALUES ('768', '230521', '集贤县', '762');
INSERT INTO `wp_shop_nation` VALUES ('769', '230522', '友谊县', '762');
INSERT INTO `wp_shop_nation` VALUES ('770', '230523', '宝清县', '762');
INSERT INTO `wp_shop_nation` VALUES ('771', '230524', '饶河县', '762');
INSERT INTO `wp_shop_nation` VALUES ('772', '230600', '大庆市', '702');
INSERT INTO `wp_shop_nation` VALUES ('773', '230601', '市辖区', '772');
INSERT INTO `wp_shop_nation` VALUES ('774', '230602', '萨尔图区', '772');
INSERT INTO `wp_shop_nation` VALUES ('775', '230603', '龙凤区', '772');
INSERT INTO `wp_shop_nation` VALUES ('776', '230604', '让胡路区', '772');
INSERT INTO `wp_shop_nation` VALUES ('777', '230605', '红岗区', '772');
INSERT INTO `wp_shop_nation` VALUES ('778', '230606', '大同区', '772');
INSERT INTO `wp_shop_nation` VALUES ('779', '230621', '肇州县', '772');
INSERT INTO `wp_shop_nation` VALUES ('780', '230622', '肇源县', '772');
INSERT INTO `wp_shop_nation` VALUES ('781', '230623', '林甸县', '772');
INSERT INTO `wp_shop_nation` VALUES ('782', '230624', '杜尔伯特蒙古族自治县', '772');
INSERT INTO `wp_shop_nation` VALUES ('783', '230700', '伊春市', '702');
INSERT INTO `wp_shop_nation` VALUES ('784', '230701', '市辖区', '783');
INSERT INTO `wp_shop_nation` VALUES ('785', '230702', '伊春区', '783');
INSERT INTO `wp_shop_nation` VALUES ('786', '230703', '南岔区', '783');
INSERT INTO `wp_shop_nation` VALUES ('787', '230704', '友好区', '783');
INSERT INTO `wp_shop_nation` VALUES ('788', '230705', '西林区', '783');
INSERT INTO `wp_shop_nation` VALUES ('789', '230706', '翠峦区', '783');
INSERT INTO `wp_shop_nation` VALUES ('790', '230707', '新青区', '783');
INSERT INTO `wp_shop_nation` VALUES ('791', '230708', '美溪区', '783');
INSERT INTO `wp_shop_nation` VALUES ('792', '230709', '金山屯区', '783');
INSERT INTO `wp_shop_nation` VALUES ('793', '230710', '五营区', '783');
INSERT INTO `wp_shop_nation` VALUES ('794', '230711', '乌马河区', '783');
INSERT INTO `wp_shop_nation` VALUES ('795', '230712', '汤旺河区', '783');
INSERT INTO `wp_shop_nation` VALUES ('796', '230713', '带岭区', '783');
INSERT INTO `wp_shop_nation` VALUES ('797', '230714', '乌伊岭区', '783');
INSERT INTO `wp_shop_nation` VALUES ('798', '230715', '红星区', '783');
INSERT INTO `wp_shop_nation` VALUES ('799', '230716', '上甘岭区', '783');
INSERT INTO `wp_shop_nation` VALUES ('800', '230722', '嘉荫县', '783');
INSERT INTO `wp_shop_nation` VALUES ('801', '230781', '铁力市', '783');
INSERT INTO `wp_shop_nation` VALUES ('802', '230800', '佳木斯市', '702');
INSERT INTO `wp_shop_nation` VALUES ('803', '230801', '市辖区', '802');
INSERT INTO `wp_shop_nation` VALUES ('804', '230803', '向阳区', '802');
INSERT INTO `wp_shop_nation` VALUES ('805', '230804', '前进区', '802');
INSERT INTO `wp_shop_nation` VALUES ('806', '230805', '东风区', '802');
INSERT INTO `wp_shop_nation` VALUES ('807', '230811', '郊区', '802');
INSERT INTO `wp_shop_nation` VALUES ('808', '230822', '桦南县', '802');
INSERT INTO `wp_shop_nation` VALUES ('809', '230826', '桦川县', '802');
INSERT INTO `wp_shop_nation` VALUES ('810', '230828', '汤原县', '802');
INSERT INTO `wp_shop_nation` VALUES ('811', '230833', '抚远县', '802');
INSERT INTO `wp_shop_nation` VALUES ('812', '230881', '同江市', '802');
INSERT INTO `wp_shop_nation` VALUES ('813', '230882', '富锦市', '802');
INSERT INTO `wp_shop_nation` VALUES ('814', '230900', '七台河市', '702');
INSERT INTO `wp_shop_nation` VALUES ('815', '230901', '市辖区', '814');
INSERT INTO `wp_shop_nation` VALUES ('816', '230902', '新兴区', '814');
INSERT INTO `wp_shop_nation` VALUES ('817', '230903', '桃山区', '814');
INSERT INTO `wp_shop_nation` VALUES ('818', '230904', '茄子河区', '814');
INSERT INTO `wp_shop_nation` VALUES ('819', '230921', '勃利县', '814');
INSERT INTO `wp_shop_nation` VALUES ('820', '231000', '牡丹江市', '702');
INSERT INTO `wp_shop_nation` VALUES ('821', '231001', '市辖区', '820');
INSERT INTO `wp_shop_nation` VALUES ('822', '231002', '东安区', '820');
INSERT INTO `wp_shop_nation` VALUES ('823', '231003', '阳明区', '820');
INSERT INTO `wp_shop_nation` VALUES ('824', '231004', '爱民区', '820');
INSERT INTO `wp_shop_nation` VALUES ('825', '231005', '西安区', '820');
INSERT INTO `wp_shop_nation` VALUES ('826', '231024', '东宁县', '820');
INSERT INTO `wp_shop_nation` VALUES ('827', '231025', '林口县', '820');
INSERT INTO `wp_shop_nation` VALUES ('828', '231081', '绥芬河市', '820');
INSERT INTO `wp_shop_nation` VALUES ('829', '231083', '海林市', '820');
INSERT INTO `wp_shop_nation` VALUES ('830', '231084', '宁安市', '820');
INSERT INTO `wp_shop_nation` VALUES ('831', '231085', '穆棱市', '820');
INSERT INTO `wp_shop_nation` VALUES ('832', '231100', '黑河市', '702');
INSERT INTO `wp_shop_nation` VALUES ('833', '231101', '市辖区', '832');
INSERT INTO `wp_shop_nation` VALUES ('834', '231102', '爱辉区', '832');
INSERT INTO `wp_shop_nation` VALUES ('835', '231121', '嫩江县', '832');
INSERT INTO `wp_shop_nation` VALUES ('836', '231123', '逊克县', '832');
INSERT INTO `wp_shop_nation` VALUES ('837', '231124', '孙吴县', '832');
INSERT INTO `wp_shop_nation` VALUES ('838', '231181', '北安市', '832');
INSERT INTO `wp_shop_nation` VALUES ('839', '231182', '五大连池市', '832');
INSERT INTO `wp_shop_nation` VALUES ('840', '231200', '绥化市', '702');
INSERT INTO `wp_shop_nation` VALUES ('841', '231201', '市辖区', '840');
INSERT INTO `wp_shop_nation` VALUES ('842', '231202', '北林区', '840');
INSERT INTO `wp_shop_nation` VALUES ('843', '231221', '望奎县', '840');
INSERT INTO `wp_shop_nation` VALUES ('844', '231222', '兰西县', '840');
INSERT INTO `wp_shop_nation` VALUES ('845', '231223', '青冈县', '840');
INSERT INTO `wp_shop_nation` VALUES ('846', '231224', '庆安县', '840');
INSERT INTO `wp_shop_nation` VALUES ('847', '231225', '明水县', '840');
INSERT INTO `wp_shop_nation` VALUES ('848', '231226', '绥棱县', '840');
INSERT INTO `wp_shop_nation` VALUES ('849', '231281', '安达市', '840');
INSERT INTO `wp_shop_nation` VALUES ('850', '231282', '肇东市', '840');
INSERT INTO `wp_shop_nation` VALUES ('851', '231283', '海伦市', '840');
INSERT INTO `wp_shop_nation` VALUES ('852', '232700', '大兴安岭地区', '702');
INSERT INTO `wp_shop_nation` VALUES ('853', '232721', '呼玛县', '852');
INSERT INTO `wp_shop_nation` VALUES ('854', '232722', '塔河县', '852');
INSERT INTO `wp_shop_nation` VALUES ('855', '232723', '漠河县', '852');
INSERT INTO `wp_shop_nation` VALUES ('856', '310000', '上海市', '0');
INSERT INTO `wp_shop_nation` VALUES ('857', '310101', '黄浦区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('858', '310104', '徐汇区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('859', '310105', '长宁区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('860', '310106', '静安区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('861', '310107', '普陀区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('862', '310108', '闸北区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('863', '310109', '虹口区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('864', '310110', '杨浦区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('865', '310112', '闵行区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('866', '310113', '宝山区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('867', '310114', '嘉定区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('868', '310115', '浦东新区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('869', '310116', '金山区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('870', '310117', '松江区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('871', '310118', '青浦区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('872', '310120', '奉贤区', '3925');
INSERT INTO `wp_shop_nation` VALUES ('873', '310230', '崇明县', '3925');
INSERT INTO `wp_shop_nation` VALUES ('874', '320000', '江苏省', '0');
INSERT INTO `wp_shop_nation` VALUES ('875', '320100', '南京市', '874');
INSERT INTO `wp_shop_nation` VALUES ('876', '320101', '市辖区', '875');
INSERT INTO `wp_shop_nation` VALUES ('877', '320102', '玄武区', '875');
INSERT INTO `wp_shop_nation` VALUES ('878', '320104', '秦淮区', '875');
INSERT INTO `wp_shop_nation` VALUES ('879', '320105', '建邺区', '875');
INSERT INTO `wp_shop_nation` VALUES ('880', '320106', '鼓楼区', '875');
INSERT INTO `wp_shop_nation` VALUES ('881', '320111', '浦口区', '875');
INSERT INTO `wp_shop_nation` VALUES ('882', '320113', '栖霞区', '875');
INSERT INTO `wp_shop_nation` VALUES ('883', '320114', '雨花台区', '875');
INSERT INTO `wp_shop_nation` VALUES ('884', '320115', '江宁区', '875');
INSERT INTO `wp_shop_nation` VALUES ('885', '320116', '六合区', '875');
INSERT INTO `wp_shop_nation` VALUES ('886', '320117', '溧水区', '875');
INSERT INTO `wp_shop_nation` VALUES ('887', '320118', '高淳区', '875');
INSERT INTO `wp_shop_nation` VALUES ('888', '320200', '无锡市', '874');
INSERT INTO `wp_shop_nation` VALUES ('889', '320201', '市辖区', '888');
INSERT INTO `wp_shop_nation` VALUES ('890', '320202', '崇安区', '888');
INSERT INTO `wp_shop_nation` VALUES ('891', '320203', '南长区', '888');
INSERT INTO `wp_shop_nation` VALUES ('892', '320204', '北塘区', '888');
INSERT INTO `wp_shop_nation` VALUES ('893', '320205', '锡山区', '888');
INSERT INTO `wp_shop_nation` VALUES ('894', '320206', '惠山区', '888');
INSERT INTO `wp_shop_nation` VALUES ('895', '320211', '滨湖区', '888');
INSERT INTO `wp_shop_nation` VALUES ('896', '320281', '江阴市', '888');
INSERT INTO `wp_shop_nation` VALUES ('897', '320282', '宜兴市', '888');
INSERT INTO `wp_shop_nation` VALUES ('898', '320300', '徐州市', '874');
INSERT INTO `wp_shop_nation` VALUES ('899', '320301', '市辖区', '898');
INSERT INTO `wp_shop_nation` VALUES ('900', '320302', '鼓楼区', '898');
INSERT INTO `wp_shop_nation` VALUES ('901', '320303', '云龙区', '898');
INSERT INTO `wp_shop_nation` VALUES ('902', '320305', '贾汪区', '898');
INSERT INTO `wp_shop_nation` VALUES ('903', '320311', '泉山区', '898');
INSERT INTO `wp_shop_nation` VALUES ('904', '320312', '铜山区', '898');
INSERT INTO `wp_shop_nation` VALUES ('905', '320321', '丰县', '898');
INSERT INTO `wp_shop_nation` VALUES ('906', '320322', '沛县', '898');
INSERT INTO `wp_shop_nation` VALUES ('907', '320324', '睢宁县', '898');
INSERT INTO `wp_shop_nation` VALUES ('908', '320381', '新沂市', '898');
INSERT INTO `wp_shop_nation` VALUES ('909', '320382', '邳州市', '898');
INSERT INTO `wp_shop_nation` VALUES ('910', '320400', '常州市', '874');
INSERT INTO `wp_shop_nation` VALUES ('911', '320401', '市辖区', '910');
INSERT INTO `wp_shop_nation` VALUES ('912', '320402', '天宁区', '910');
INSERT INTO `wp_shop_nation` VALUES ('913', '320404', '钟楼区', '910');
INSERT INTO `wp_shop_nation` VALUES ('914', '320405', '戚墅堰区', '910');
INSERT INTO `wp_shop_nation` VALUES ('915', '320411', '新北区', '910');
INSERT INTO `wp_shop_nation` VALUES ('916', '320412', '武进区', '910');
INSERT INTO `wp_shop_nation` VALUES ('917', '320481', '溧阳市', '910');
INSERT INTO `wp_shop_nation` VALUES ('918', '320482', '金坛市', '910');
INSERT INTO `wp_shop_nation` VALUES ('919', '320500', '苏州市', '874');
INSERT INTO `wp_shop_nation` VALUES ('920', '320501', '市辖区', '919');
INSERT INTO `wp_shop_nation` VALUES ('921', '320505', '虎丘区', '919');
INSERT INTO `wp_shop_nation` VALUES ('922', '320506', '吴中区', '919');
INSERT INTO `wp_shop_nation` VALUES ('923', '320507', '相城区', '919');
INSERT INTO `wp_shop_nation` VALUES ('924', '320508', '姑苏区', '919');
INSERT INTO `wp_shop_nation` VALUES ('925', '320509', '吴江区', '919');
INSERT INTO `wp_shop_nation` VALUES ('926', '320581', '常熟市', '919');
INSERT INTO `wp_shop_nation` VALUES ('927', '320582', '张家港市', '919');
INSERT INTO `wp_shop_nation` VALUES ('928', '320583', '昆山市', '919');
INSERT INTO `wp_shop_nation` VALUES ('929', '320585', '太仓市', '919');
INSERT INTO `wp_shop_nation` VALUES ('930', '320600', '南通市', '874');
INSERT INTO `wp_shop_nation` VALUES ('931', '320601', '市辖区', '930');
INSERT INTO `wp_shop_nation` VALUES ('932', '320602', '崇川区', '930');
INSERT INTO `wp_shop_nation` VALUES ('933', '320611', '港闸区', '930');
INSERT INTO `wp_shop_nation` VALUES ('934', '320612', '通州区', '930');
INSERT INTO `wp_shop_nation` VALUES ('935', '320621', '海安县', '930');
INSERT INTO `wp_shop_nation` VALUES ('936', '320623', '如东县', '930');
INSERT INTO `wp_shop_nation` VALUES ('937', '320681', '启东市', '930');
INSERT INTO `wp_shop_nation` VALUES ('938', '320682', '如皋市', '930');
INSERT INTO `wp_shop_nation` VALUES ('939', '320684', '海门市', '930');
INSERT INTO `wp_shop_nation` VALUES ('940', '320700', '连云港市', '874');
INSERT INTO `wp_shop_nation` VALUES ('941', '320701', '市辖区', '940');
INSERT INTO `wp_shop_nation` VALUES ('942', '320703', '连云区', '940');
INSERT INTO `wp_shop_nation` VALUES ('943', '320706', '海州区', '940');
INSERT INTO `wp_shop_nation` VALUES ('944', '320707', '赣榆区', '940');
INSERT INTO `wp_shop_nation` VALUES ('945', '320722', '东海县', '940');
INSERT INTO `wp_shop_nation` VALUES ('946', '320723', '灌云县', '940');
INSERT INTO `wp_shop_nation` VALUES ('947', '320724', '灌南县', '940');
INSERT INTO `wp_shop_nation` VALUES ('948', '320800', '淮安市', '874');
INSERT INTO `wp_shop_nation` VALUES ('949', '320801', '市辖区', '948');
INSERT INTO `wp_shop_nation` VALUES ('950', '320802', '清河区', '948');
INSERT INTO `wp_shop_nation` VALUES ('951', '320803', '淮安区', '948');
INSERT INTO `wp_shop_nation` VALUES ('952', '320804', '淮阴区', '948');
INSERT INTO `wp_shop_nation` VALUES ('953', '320811', '清浦区', '948');
INSERT INTO `wp_shop_nation` VALUES ('954', '320826', '涟水县', '948');
INSERT INTO `wp_shop_nation` VALUES ('955', '320829', '洪泽县', '948');
INSERT INTO `wp_shop_nation` VALUES ('956', '320830', '盱眙县', '948');
INSERT INTO `wp_shop_nation` VALUES ('957', '320831', '金湖县', '948');
INSERT INTO `wp_shop_nation` VALUES ('958', '320900', '盐城市', '874');
INSERT INTO `wp_shop_nation` VALUES ('959', '320901', '市辖区', '958');
INSERT INTO `wp_shop_nation` VALUES ('960', '320902', '亭湖区', '958');
INSERT INTO `wp_shop_nation` VALUES ('961', '320903', '盐都区', '958');
INSERT INTO `wp_shop_nation` VALUES ('962', '320921', '响水县', '958');
INSERT INTO `wp_shop_nation` VALUES ('963', '320922', '滨海县', '958');
INSERT INTO `wp_shop_nation` VALUES ('964', '320923', '阜宁县', '958');
INSERT INTO `wp_shop_nation` VALUES ('965', '320924', '射阳县', '958');
INSERT INTO `wp_shop_nation` VALUES ('966', '320925', '建湖县', '958');
INSERT INTO `wp_shop_nation` VALUES ('967', '320981', '东台市', '958');
INSERT INTO `wp_shop_nation` VALUES ('968', '320982', '大丰市', '958');
INSERT INTO `wp_shop_nation` VALUES ('969', '321000', '扬州市', '874');
INSERT INTO `wp_shop_nation` VALUES ('970', '321001', '市辖区', '969');
INSERT INTO `wp_shop_nation` VALUES ('971', '321002', '广陵区', '969');
INSERT INTO `wp_shop_nation` VALUES ('972', '321003', '邗江区', '969');
INSERT INTO `wp_shop_nation` VALUES ('973', '321012', '江都区', '969');
INSERT INTO `wp_shop_nation` VALUES ('974', '321023', '宝应县', '969');
INSERT INTO `wp_shop_nation` VALUES ('975', '321081', '仪征市', '969');
INSERT INTO `wp_shop_nation` VALUES ('976', '321084', '高邮市', '969');
INSERT INTO `wp_shop_nation` VALUES ('977', '321100', '镇江市', '874');
INSERT INTO `wp_shop_nation` VALUES ('978', '321101', '市辖区', '977');
INSERT INTO `wp_shop_nation` VALUES ('979', '321102', '京口区', '977');
INSERT INTO `wp_shop_nation` VALUES ('980', '321111', '润州区', '977');
INSERT INTO `wp_shop_nation` VALUES ('981', '321112', '丹徒区', '977');
INSERT INTO `wp_shop_nation` VALUES ('982', '321181', '丹阳市', '977');
INSERT INTO `wp_shop_nation` VALUES ('983', '321182', '扬中市', '977');
INSERT INTO `wp_shop_nation` VALUES ('984', '321183', '句容市', '977');
INSERT INTO `wp_shop_nation` VALUES ('985', '321200', '泰州市', '874');
INSERT INTO `wp_shop_nation` VALUES ('986', '321201', '市辖区', '985');
INSERT INTO `wp_shop_nation` VALUES ('987', '321202', '海陵区', '985');
INSERT INTO `wp_shop_nation` VALUES ('988', '321203', '高港区', '985');
INSERT INTO `wp_shop_nation` VALUES ('989', '321204', '姜堰区', '985');
INSERT INTO `wp_shop_nation` VALUES ('990', '321281', '兴化市', '985');
INSERT INTO `wp_shop_nation` VALUES ('991', '321282', '靖江市', '985');
INSERT INTO `wp_shop_nation` VALUES ('992', '321283', '泰兴市', '985');
INSERT INTO `wp_shop_nation` VALUES ('993', '321300', '宿迁市', '874');
INSERT INTO `wp_shop_nation` VALUES ('994', '321301', '市辖区', '993');
INSERT INTO `wp_shop_nation` VALUES ('995', '321302', '宿城区', '993');
INSERT INTO `wp_shop_nation` VALUES ('996', '321311', '宿豫区', '993');
INSERT INTO `wp_shop_nation` VALUES ('997', '321322', '沭阳县', '993');
INSERT INTO `wp_shop_nation` VALUES ('998', '321323', '泗阳县', '993');
INSERT INTO `wp_shop_nation` VALUES ('999', '321324', '泗洪县', '993');
INSERT INTO `wp_shop_nation` VALUES ('1000', '330000', '浙江省', '0');
INSERT INTO `wp_shop_nation` VALUES ('1001', '330100', '杭州市', '1000');
INSERT INTO `wp_shop_nation` VALUES ('1002', '330101', '市辖区', '1001');
INSERT INTO `wp_shop_nation` VALUES ('1003', '330102', '上城区', '1001');
INSERT INTO `wp_shop_nation` VALUES ('1004', '330103', '下城区', '1001');
INSERT INTO `wp_shop_nation` VALUES ('1005', '330104', '江干区', '1001');
INSERT INTO `wp_shop_nation` VALUES ('1006', '330105', '拱墅区', '1001');
INSERT INTO `wp_shop_nation` VALUES ('1007', '330106', '西湖区', '1001');
INSERT INTO `wp_shop_nation` VALUES ('1008', '330108', '滨江区', '1001');
INSERT INTO `wp_shop_nation` VALUES ('1009', '330109', '萧山区', '1001');
INSERT INTO `wp_shop_nation` VALUES ('1010', '330110', '余杭区', '1001');
INSERT INTO `wp_shop_nation` VALUES ('1011', '330111', '富阳区', '1001');
INSERT INTO `wp_shop_nation` VALUES ('1012', '330122', '桐庐县', '1001');
INSERT INTO `wp_shop_nation` VALUES ('1013', '330127', '淳安县', '1001');
INSERT INTO `wp_shop_nation` VALUES ('1014', '330182', '建德市', '1001');
INSERT INTO `wp_shop_nation` VALUES ('1015', '330185', '临安市', '1001');
INSERT INTO `wp_shop_nation` VALUES ('1016', '330200', '宁波市', '1000');
INSERT INTO `wp_shop_nation` VALUES ('1017', '330201', '市辖区', '1016');
INSERT INTO `wp_shop_nation` VALUES ('1018', '330203', '海曙区', '1016');
INSERT INTO `wp_shop_nation` VALUES ('1019', '330204', '江东区', '1016');
INSERT INTO `wp_shop_nation` VALUES ('1020', '330205', '江北区', '1016');
INSERT INTO `wp_shop_nation` VALUES ('1021', '330206', '北仑区', '1016');
INSERT INTO `wp_shop_nation` VALUES ('1022', '330211', '镇海区', '1016');
INSERT INTO `wp_shop_nation` VALUES ('1023', '330212', '鄞州区', '1016');
INSERT INTO `wp_shop_nation` VALUES ('1024', '330225', '象山县', '1016');
INSERT INTO `wp_shop_nation` VALUES ('1025', '330226', '宁海县', '1016');
INSERT INTO `wp_shop_nation` VALUES ('1026', '330281', '余姚市', '1016');
INSERT INTO `wp_shop_nation` VALUES ('1027', '330282', '慈溪市', '1016');
INSERT INTO `wp_shop_nation` VALUES ('1028', '330283', '奉化市', '1016');
INSERT INTO `wp_shop_nation` VALUES ('1029', '330300', '温州市', '1000');
INSERT INTO `wp_shop_nation` VALUES ('1030', '330301', '市辖区', '1029');
INSERT INTO `wp_shop_nation` VALUES ('1031', '330302', '鹿城区', '1029');
INSERT INTO `wp_shop_nation` VALUES ('1032', '330303', '龙湾区', '1029');
INSERT INTO `wp_shop_nation` VALUES ('1033', '330304', '瓯海区', '1029');
INSERT INTO `wp_shop_nation` VALUES ('1034', '330322', '洞头县', '1029');
INSERT INTO `wp_shop_nation` VALUES ('1035', '330324', '永嘉县', '1029');
INSERT INTO `wp_shop_nation` VALUES ('1036', '330326', '平阳县', '1029');
INSERT INTO `wp_shop_nation` VALUES ('1037', '330327', '苍南县', '1029');
INSERT INTO `wp_shop_nation` VALUES ('1038', '330328', '文成县', '1029');
INSERT INTO `wp_shop_nation` VALUES ('1039', '330329', '泰顺县', '1029');
INSERT INTO `wp_shop_nation` VALUES ('1040', '330381', '瑞安市', '1029');
INSERT INTO `wp_shop_nation` VALUES ('1041', '330382', '乐清市', '1029');
INSERT INTO `wp_shop_nation` VALUES ('1042', '330400', '嘉兴市', '1000');
INSERT INTO `wp_shop_nation` VALUES ('1043', '330401', '市辖区', '1042');
INSERT INTO `wp_shop_nation` VALUES ('1044', '330402', '南湖区', '1042');
INSERT INTO `wp_shop_nation` VALUES ('1045', '330411', '秀洲区', '1042');
INSERT INTO `wp_shop_nation` VALUES ('1046', '330421', '嘉善县', '1042');
INSERT INTO `wp_shop_nation` VALUES ('1047', '330424', '海盐县', '1042');
INSERT INTO `wp_shop_nation` VALUES ('1048', '330481', '海宁市', '1042');
INSERT INTO `wp_shop_nation` VALUES ('1049', '330482', '平湖市', '1042');
INSERT INTO `wp_shop_nation` VALUES ('1050', '330483', '桐乡市', '1042');
INSERT INTO `wp_shop_nation` VALUES ('1051', '330500', '湖州市', '1000');
INSERT INTO `wp_shop_nation` VALUES ('1052', '330501', '市辖区', '1051');
INSERT INTO `wp_shop_nation` VALUES ('1053', '330502', '吴兴区', '1051');
INSERT INTO `wp_shop_nation` VALUES ('1054', '330503', '南浔区', '1051');
INSERT INTO `wp_shop_nation` VALUES ('1055', '330521', '德清县', '1051');
INSERT INTO `wp_shop_nation` VALUES ('1056', '330522', '长兴县', '1051');
INSERT INTO `wp_shop_nation` VALUES ('1057', '330523', '安吉县', '1051');
INSERT INTO `wp_shop_nation` VALUES ('1058', '330600', '绍兴市', '1000');
INSERT INTO `wp_shop_nation` VALUES ('1059', '330601', '市辖区', '1058');
INSERT INTO `wp_shop_nation` VALUES ('1060', '330602', '越城区', '1058');
INSERT INTO `wp_shop_nation` VALUES ('1061', '330603', '柯桥区', '1058');
INSERT INTO `wp_shop_nation` VALUES ('1062', '330604', '上虞区', '1058');
INSERT INTO `wp_shop_nation` VALUES ('1063', '330624', '新昌县', '1058');
INSERT INTO `wp_shop_nation` VALUES ('1064', '330681', '诸暨市', '1058');
INSERT INTO `wp_shop_nation` VALUES ('1065', '330683', '嵊州市', '1058');
INSERT INTO `wp_shop_nation` VALUES ('1066', '330700', '金华市', '1000');
INSERT INTO `wp_shop_nation` VALUES ('1067', '330701', '市辖区', '1066');
INSERT INTO `wp_shop_nation` VALUES ('1068', '330702', '婺城区', '1066');
INSERT INTO `wp_shop_nation` VALUES ('1069', '330703', '金东区', '1066');
INSERT INTO `wp_shop_nation` VALUES ('1070', '330723', '武义县', '1066');
INSERT INTO `wp_shop_nation` VALUES ('1071', '330726', '浦江县', '1066');
INSERT INTO `wp_shop_nation` VALUES ('1072', '330727', '磐安县', '1066');
INSERT INTO `wp_shop_nation` VALUES ('1073', '330781', '兰溪市', '1066');
INSERT INTO `wp_shop_nation` VALUES ('1074', '330782', '义乌市', '1066');
INSERT INTO `wp_shop_nation` VALUES ('1075', '330783', '东阳市', '1066');
INSERT INTO `wp_shop_nation` VALUES ('1076', '330784', '永康市', '1066');
INSERT INTO `wp_shop_nation` VALUES ('1077', '330800', '衢州市', '1000');
INSERT INTO `wp_shop_nation` VALUES ('1078', '330801', '市辖区', '1077');
INSERT INTO `wp_shop_nation` VALUES ('1079', '330802', '柯城区', '1077');
INSERT INTO `wp_shop_nation` VALUES ('1080', '330803', '衢江区', '1077');
INSERT INTO `wp_shop_nation` VALUES ('1081', '330822', '常山县', '1077');
INSERT INTO `wp_shop_nation` VALUES ('1082', '330824', '开化县', '1077');
INSERT INTO `wp_shop_nation` VALUES ('1083', '330825', '龙游县', '1077');
INSERT INTO `wp_shop_nation` VALUES ('1084', '330881', '江山市', '1077');
INSERT INTO `wp_shop_nation` VALUES ('1085', '330900', '舟山市', '1000');
INSERT INTO `wp_shop_nation` VALUES ('1086', '330901', '市辖区', '1085');
INSERT INTO `wp_shop_nation` VALUES ('1087', '330902', '定海区', '1085');
INSERT INTO `wp_shop_nation` VALUES ('1088', '330903', '普陀区', '1085');
INSERT INTO `wp_shop_nation` VALUES ('1089', '330921', '岱山县', '1085');
INSERT INTO `wp_shop_nation` VALUES ('1090', '330922', '嵊泗县', '1085');
INSERT INTO `wp_shop_nation` VALUES ('1091', '331000', '台州市', '1000');
INSERT INTO `wp_shop_nation` VALUES ('1092', '331001', '市辖区', '1091');
INSERT INTO `wp_shop_nation` VALUES ('1093', '331002', '椒江区', '1091');
INSERT INTO `wp_shop_nation` VALUES ('1094', '331003', '黄岩区', '1091');
INSERT INTO `wp_shop_nation` VALUES ('1095', '331004', '路桥区', '1091');
INSERT INTO `wp_shop_nation` VALUES ('1096', '331021', '玉环县', '1091');
INSERT INTO `wp_shop_nation` VALUES ('1097', '331022', '三门县', '1091');
INSERT INTO `wp_shop_nation` VALUES ('1098', '331023', '天台县', '1091');
INSERT INTO `wp_shop_nation` VALUES ('1099', '331024', '仙居县', '1091');
INSERT INTO `wp_shop_nation` VALUES ('1100', '331081', '温岭市', '1091');
INSERT INTO `wp_shop_nation` VALUES ('1101', '331082', '临海市', '1091');
INSERT INTO `wp_shop_nation` VALUES ('1102', '331100', '丽水市', '1000');
INSERT INTO `wp_shop_nation` VALUES ('1103', '331101', '市辖区', '1102');
INSERT INTO `wp_shop_nation` VALUES ('1104', '331102', '莲都区', '1102');
INSERT INTO `wp_shop_nation` VALUES ('1105', '331121', '青田县', '1102');
INSERT INTO `wp_shop_nation` VALUES ('1106', '331122', '缙云县', '1102');
INSERT INTO `wp_shop_nation` VALUES ('1107', '331123', '遂昌县', '1102');
INSERT INTO `wp_shop_nation` VALUES ('1108', '331124', '松阳县', '1102');
INSERT INTO `wp_shop_nation` VALUES ('1109', '331125', '云和县', '1102');
INSERT INTO `wp_shop_nation` VALUES ('1110', '331126', '庆元县', '1102');
INSERT INTO `wp_shop_nation` VALUES ('1111', '331127', '景宁畲族自治县', '1102');
INSERT INTO `wp_shop_nation` VALUES ('1112', '331181', '龙泉市', '1102');
INSERT INTO `wp_shop_nation` VALUES ('1113', '340000', '安徽省', '0');
INSERT INTO `wp_shop_nation` VALUES ('1114', '340100', '合肥市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1115', '340101', '市辖区', '1114');
INSERT INTO `wp_shop_nation` VALUES ('1116', '340102', '瑶海区', '1114');
INSERT INTO `wp_shop_nation` VALUES ('1117', '340103', '庐阳区', '1114');
INSERT INTO `wp_shop_nation` VALUES ('1118', '340104', '蜀山区', '1114');
INSERT INTO `wp_shop_nation` VALUES ('1119', '340111', '包河区', '1114');
INSERT INTO `wp_shop_nation` VALUES ('1120', '340121', '长丰县', '1114');
INSERT INTO `wp_shop_nation` VALUES ('1121', '340122', '肥东县', '1114');
INSERT INTO `wp_shop_nation` VALUES ('1122', '340123', '肥西县', '1114');
INSERT INTO `wp_shop_nation` VALUES ('1123', '340124', '庐江县', '1114');
INSERT INTO `wp_shop_nation` VALUES ('1124', '340181', '巢湖市', '1114');
INSERT INTO `wp_shop_nation` VALUES ('1125', '340200', '芜湖市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1126', '340201', '市辖区', '1125');
INSERT INTO `wp_shop_nation` VALUES ('1127', '340202', '镜湖区', '1125');
INSERT INTO `wp_shop_nation` VALUES ('1128', '340203', '弋江区', '1125');
INSERT INTO `wp_shop_nation` VALUES ('1129', '340207', '鸠江区', '1125');
INSERT INTO `wp_shop_nation` VALUES ('1130', '340208', '三山区', '1125');
INSERT INTO `wp_shop_nation` VALUES ('1131', '340221', '芜湖县', '1125');
INSERT INTO `wp_shop_nation` VALUES ('1132', '340222', '繁昌县', '1125');
INSERT INTO `wp_shop_nation` VALUES ('1133', '340223', '南陵县', '1125');
INSERT INTO `wp_shop_nation` VALUES ('1134', '340225', '无为县', '1125');
INSERT INTO `wp_shop_nation` VALUES ('1135', '340300', '蚌埠市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1136', '340301', '市辖区', '1135');
INSERT INTO `wp_shop_nation` VALUES ('1137', '340302', '龙子湖区', '1135');
INSERT INTO `wp_shop_nation` VALUES ('1138', '340303', '蚌山区', '1135');
INSERT INTO `wp_shop_nation` VALUES ('1139', '340304', '禹会区', '1135');
INSERT INTO `wp_shop_nation` VALUES ('1140', '340311', '淮上区', '1135');
INSERT INTO `wp_shop_nation` VALUES ('1141', '340321', '怀远县', '1135');
INSERT INTO `wp_shop_nation` VALUES ('1142', '340322', '五河县', '1135');
INSERT INTO `wp_shop_nation` VALUES ('1143', '340323', '固镇县', '1135');
INSERT INTO `wp_shop_nation` VALUES ('1144', '340400', '淮南市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1145', '340401', '市辖区', '1144');
INSERT INTO `wp_shop_nation` VALUES ('1146', '340402', '大通区', '1144');
INSERT INTO `wp_shop_nation` VALUES ('1147', '340403', '田家庵区', '1144');
INSERT INTO `wp_shop_nation` VALUES ('1148', '340404', '谢家集区', '1144');
INSERT INTO `wp_shop_nation` VALUES ('1149', '340405', '八公山区', '1144');
INSERT INTO `wp_shop_nation` VALUES ('1150', '340406', '潘集区', '1144');
INSERT INTO `wp_shop_nation` VALUES ('1151', '340421', '凤台县', '1144');
INSERT INTO `wp_shop_nation` VALUES ('1152', '340500', '马鞍山市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1153', '340501', '市辖区', '1152');
INSERT INTO `wp_shop_nation` VALUES ('1154', '340503', '花山区', '1152');
INSERT INTO `wp_shop_nation` VALUES ('1155', '340504', '雨山区', '1152');
INSERT INTO `wp_shop_nation` VALUES ('1156', '340506', '博望区', '1152');
INSERT INTO `wp_shop_nation` VALUES ('1157', '340521', '当涂县', '1152');
INSERT INTO `wp_shop_nation` VALUES ('1158', '340522', '含山县', '1152');
INSERT INTO `wp_shop_nation` VALUES ('1159', '340523', '和县', '1152');
INSERT INTO `wp_shop_nation` VALUES ('1160', '340600', '淮北市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1161', '340601', '市辖区', '1160');
INSERT INTO `wp_shop_nation` VALUES ('1162', '340602', '杜集区', '1160');
INSERT INTO `wp_shop_nation` VALUES ('1163', '340603', '相山区', '1160');
INSERT INTO `wp_shop_nation` VALUES ('1164', '340604', '烈山区', '1160');
INSERT INTO `wp_shop_nation` VALUES ('1165', '340621', '濉溪县', '1160');
INSERT INTO `wp_shop_nation` VALUES ('1166', '340700', '铜陵市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1167', '340701', '市辖区', '1166');
INSERT INTO `wp_shop_nation` VALUES ('1168', '340702', '铜官山区', '1166');
INSERT INTO `wp_shop_nation` VALUES ('1169', '340703', '狮子山区', '1166');
INSERT INTO `wp_shop_nation` VALUES ('1170', '340711', '郊区', '1166');
INSERT INTO `wp_shop_nation` VALUES ('1171', '340721', '铜陵县', '1166');
INSERT INTO `wp_shop_nation` VALUES ('1172', '340800', '安庆市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1173', '340801', '市辖区', '1172');
INSERT INTO `wp_shop_nation` VALUES ('1174', '340802', '迎江区', '1172');
INSERT INTO `wp_shop_nation` VALUES ('1175', '340803', '大观区', '1172');
INSERT INTO `wp_shop_nation` VALUES ('1176', '340811', '宜秀区', '1172');
INSERT INTO `wp_shop_nation` VALUES ('1177', '340822', '怀宁县', '1172');
INSERT INTO `wp_shop_nation` VALUES ('1178', '340823', '枞阳县', '1172');
INSERT INTO `wp_shop_nation` VALUES ('1179', '340824', '潜山县', '1172');
INSERT INTO `wp_shop_nation` VALUES ('1180', '340825', '太湖县', '1172');
INSERT INTO `wp_shop_nation` VALUES ('1181', '340826', '宿松县', '1172');
INSERT INTO `wp_shop_nation` VALUES ('1182', '340827', '望江县', '1172');
INSERT INTO `wp_shop_nation` VALUES ('1183', '340828', '岳西县', '1172');
INSERT INTO `wp_shop_nation` VALUES ('1184', '340881', '桐城市', '1172');
INSERT INTO `wp_shop_nation` VALUES ('1185', '341000', '黄山市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1186', '341001', '市辖区', '1185');
INSERT INTO `wp_shop_nation` VALUES ('1187', '341002', '屯溪区', '1185');
INSERT INTO `wp_shop_nation` VALUES ('1188', '341003', '黄山区', '1185');
INSERT INTO `wp_shop_nation` VALUES ('1189', '341004', '徽州区', '1185');
INSERT INTO `wp_shop_nation` VALUES ('1190', '341021', '歙县', '1185');
INSERT INTO `wp_shop_nation` VALUES ('1191', '341022', '休宁县', '1185');
INSERT INTO `wp_shop_nation` VALUES ('1192', '341023', '黟县', '1185');
INSERT INTO `wp_shop_nation` VALUES ('1193', '341024', '祁门县', '1185');
INSERT INTO `wp_shop_nation` VALUES ('1194', '341100', '滁州市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1195', '341101', '市辖区', '1194');
INSERT INTO `wp_shop_nation` VALUES ('1196', '341102', '琅琊区', '1194');
INSERT INTO `wp_shop_nation` VALUES ('1197', '341103', '南谯区', '1194');
INSERT INTO `wp_shop_nation` VALUES ('1198', '341122', '来安县', '1194');
INSERT INTO `wp_shop_nation` VALUES ('1199', '341124', '全椒县', '1194');
INSERT INTO `wp_shop_nation` VALUES ('1200', '341125', '定远县', '1194');
INSERT INTO `wp_shop_nation` VALUES ('1201', '341126', '凤阳县', '1194');
INSERT INTO `wp_shop_nation` VALUES ('1202', '341181', '天长市', '1194');
INSERT INTO `wp_shop_nation` VALUES ('1203', '341182', '明光市', '1194');
INSERT INTO `wp_shop_nation` VALUES ('1204', '341200', '阜阳市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1205', '341201', '市辖区', '1204');
INSERT INTO `wp_shop_nation` VALUES ('1206', '341202', '颍州区', '1204');
INSERT INTO `wp_shop_nation` VALUES ('1207', '341203', '颍东区', '1204');
INSERT INTO `wp_shop_nation` VALUES ('1208', '341204', '颍泉区', '1204');
INSERT INTO `wp_shop_nation` VALUES ('1209', '341221', '临泉县', '1204');
INSERT INTO `wp_shop_nation` VALUES ('1210', '341222', '太和县', '1204');
INSERT INTO `wp_shop_nation` VALUES ('1211', '341225', '阜南县', '1204');
INSERT INTO `wp_shop_nation` VALUES ('1212', '341226', '颍上县', '1204');
INSERT INTO `wp_shop_nation` VALUES ('1213', '341282', '界首市', '1204');
INSERT INTO `wp_shop_nation` VALUES ('1214', '341300', '宿州市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1215', '341301', '市辖区', '1214');
INSERT INTO `wp_shop_nation` VALUES ('1216', '341302', '埇桥区', '1214');
INSERT INTO `wp_shop_nation` VALUES ('1217', '341321', '砀山县', '1214');
INSERT INTO `wp_shop_nation` VALUES ('1218', '341322', '萧县', '1214');
INSERT INTO `wp_shop_nation` VALUES ('1219', '341323', '灵璧县', '1214');
INSERT INTO `wp_shop_nation` VALUES ('1220', '341324', '泗县', '1214');
INSERT INTO `wp_shop_nation` VALUES ('1221', '341500', '六安市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1222', '341501', '市辖区', '1221');
INSERT INTO `wp_shop_nation` VALUES ('1223', '341502', '金安区', '1221');
INSERT INTO `wp_shop_nation` VALUES ('1224', '341503', '裕安区', '1221');
INSERT INTO `wp_shop_nation` VALUES ('1225', '341521', '寿县', '1221');
INSERT INTO `wp_shop_nation` VALUES ('1226', '341522', '霍邱县', '1221');
INSERT INTO `wp_shop_nation` VALUES ('1227', '341523', '舒城县', '1221');
INSERT INTO `wp_shop_nation` VALUES ('1228', '341524', '金寨县', '1221');
INSERT INTO `wp_shop_nation` VALUES ('1229', '341525', '霍山县', '1221');
INSERT INTO `wp_shop_nation` VALUES ('1230', '341600', '亳州市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1231', '341601', '市辖区', '1230');
INSERT INTO `wp_shop_nation` VALUES ('1232', '341602', '谯城区', '1230');
INSERT INTO `wp_shop_nation` VALUES ('1233', '341621', '涡阳县', '1230');
INSERT INTO `wp_shop_nation` VALUES ('1234', '341622', '蒙城县', '1230');
INSERT INTO `wp_shop_nation` VALUES ('1235', '341623', '利辛县', '1230');
INSERT INTO `wp_shop_nation` VALUES ('1236', '341700', '池州市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1237', '341701', '市辖区', '1236');
INSERT INTO `wp_shop_nation` VALUES ('1238', '341702', '贵池区', '1236');
INSERT INTO `wp_shop_nation` VALUES ('1239', '341721', '东至县', '1236');
INSERT INTO `wp_shop_nation` VALUES ('1240', '341722', '石台县', '1236');
INSERT INTO `wp_shop_nation` VALUES ('1241', '341723', '青阳县', '1236');
INSERT INTO `wp_shop_nation` VALUES ('1242', '341800', '宣城市', '1113');
INSERT INTO `wp_shop_nation` VALUES ('1243', '341801', '市辖区', '1242');
INSERT INTO `wp_shop_nation` VALUES ('1244', '341802', '宣州区', '1242');
INSERT INTO `wp_shop_nation` VALUES ('1245', '341821', '郎溪县', '1242');
INSERT INTO `wp_shop_nation` VALUES ('1246', '341822', '广德县', '1242');
INSERT INTO `wp_shop_nation` VALUES ('1247', '341823', '泾县', '1242');
INSERT INTO `wp_shop_nation` VALUES ('1248', '341824', '绩溪县', '1242');
INSERT INTO `wp_shop_nation` VALUES ('1249', '341825', '旌德县', '1242');
INSERT INTO `wp_shop_nation` VALUES ('1250', '341881', '宁国市', '1242');
INSERT INTO `wp_shop_nation` VALUES ('1251', '350000', '福建省', '0');
INSERT INTO `wp_shop_nation` VALUES ('1252', '350100', '福州市', '1251');
INSERT INTO `wp_shop_nation` VALUES ('1253', '350101', '市辖区', '1252');
INSERT INTO `wp_shop_nation` VALUES ('1254', '350102', '鼓楼区', '1252');
INSERT INTO `wp_shop_nation` VALUES ('1255', '350103', '台江区', '1252');
INSERT INTO `wp_shop_nation` VALUES ('1256', '350104', '仓山区', '1252');
INSERT INTO `wp_shop_nation` VALUES ('1257', '350105', '马尾区', '1252');
INSERT INTO `wp_shop_nation` VALUES ('1258', '350111', '晋安区', '1252');
INSERT INTO `wp_shop_nation` VALUES ('1259', '350121', '闽侯县', '1252');
INSERT INTO `wp_shop_nation` VALUES ('1260', '350122', '连江县', '1252');
INSERT INTO `wp_shop_nation` VALUES ('1261', '350123', '罗源县', '1252');
INSERT INTO `wp_shop_nation` VALUES ('1262', '350124', '闽清县', '1252');
INSERT INTO `wp_shop_nation` VALUES ('1263', '350125', '永泰县', '1252');
INSERT INTO `wp_shop_nation` VALUES ('1264', '350128', '平潭县', '1252');
INSERT INTO `wp_shop_nation` VALUES ('1265', '350181', '福清市', '1252');
INSERT INTO `wp_shop_nation` VALUES ('1266', '350182', '长乐市', '1252');
INSERT INTO `wp_shop_nation` VALUES ('1267', '350200', '厦门市', '1251');
INSERT INTO `wp_shop_nation` VALUES ('1268', '350201', '市辖区', '1267');
INSERT INTO `wp_shop_nation` VALUES ('1269', '350203', '思明区', '1267');
INSERT INTO `wp_shop_nation` VALUES ('1270', '350205', '海沧区', '1267');
INSERT INTO `wp_shop_nation` VALUES ('1271', '350206', '湖里区', '1267');
INSERT INTO `wp_shop_nation` VALUES ('1272', '350211', '集美区', '1267');
INSERT INTO `wp_shop_nation` VALUES ('1273', '350212', '同安区', '1267');
INSERT INTO `wp_shop_nation` VALUES ('1274', '350213', '翔安区', '1267');
INSERT INTO `wp_shop_nation` VALUES ('1275', '350300', '莆田市', '1251');
INSERT INTO `wp_shop_nation` VALUES ('1276', '350301', '市辖区', '1275');
INSERT INTO `wp_shop_nation` VALUES ('1277', '350302', '城厢区', '1275');
INSERT INTO `wp_shop_nation` VALUES ('1278', '350303', '涵江区', '1275');
INSERT INTO `wp_shop_nation` VALUES ('1279', '350304', '荔城区', '1275');
INSERT INTO `wp_shop_nation` VALUES ('1280', '350305', '秀屿区', '1275');
INSERT INTO `wp_shop_nation` VALUES ('1281', '350322', '仙游县', '1275');
INSERT INTO `wp_shop_nation` VALUES ('1282', '350400', '三明市', '1251');
INSERT INTO `wp_shop_nation` VALUES ('1283', '350401', '市辖区', '1282');
INSERT INTO `wp_shop_nation` VALUES ('1284', '350402', '梅列区', '1282');
INSERT INTO `wp_shop_nation` VALUES ('1285', '350403', '三元区', '1282');
INSERT INTO `wp_shop_nation` VALUES ('1286', '350421', '明溪县', '1282');
INSERT INTO `wp_shop_nation` VALUES ('1287', '350423', '清流县', '1282');
INSERT INTO `wp_shop_nation` VALUES ('1288', '350424', '宁化县', '1282');
INSERT INTO `wp_shop_nation` VALUES ('1289', '350425', '大田县', '1282');
INSERT INTO `wp_shop_nation` VALUES ('1290', '350426', '尤溪县', '1282');
INSERT INTO `wp_shop_nation` VALUES ('1291', '350427', '沙县', '1282');
INSERT INTO `wp_shop_nation` VALUES ('1292', '350428', '将乐县', '1282');
INSERT INTO `wp_shop_nation` VALUES ('1293', '350429', '泰宁县', '1282');
INSERT INTO `wp_shop_nation` VALUES ('1294', '350430', '建宁县', '1282');
INSERT INTO `wp_shop_nation` VALUES ('1295', '350481', '永安市', '1282');
INSERT INTO `wp_shop_nation` VALUES ('1296', '350500', '泉州市', '1251');
INSERT INTO `wp_shop_nation` VALUES ('1297', '350501', '市辖区', '1296');
INSERT INTO `wp_shop_nation` VALUES ('1298', '350502', '鲤城区', '1296');
INSERT INTO `wp_shop_nation` VALUES ('1299', '350503', '丰泽区', '1296');
INSERT INTO `wp_shop_nation` VALUES ('1300', '350504', '洛江区', '1296');
INSERT INTO `wp_shop_nation` VALUES ('1301', '350505', '泉港区', '1296');
INSERT INTO `wp_shop_nation` VALUES ('1302', '350521', '惠安县', '1296');
INSERT INTO `wp_shop_nation` VALUES ('1303', '350524', '安溪县', '1296');
INSERT INTO `wp_shop_nation` VALUES ('1304', '350525', '永春县', '1296');
INSERT INTO `wp_shop_nation` VALUES ('1305', '350526', '德化县', '1296');
INSERT INTO `wp_shop_nation` VALUES ('1306', '350527', '金门县', '1296');
INSERT INTO `wp_shop_nation` VALUES ('1307', '350581', '石狮市', '1296');
INSERT INTO `wp_shop_nation` VALUES ('1308', '350582', '晋江市', '1296');
INSERT INTO `wp_shop_nation` VALUES ('1309', '350583', '南安市', '1296');
INSERT INTO `wp_shop_nation` VALUES ('1310', '350600', '漳州市', '1251');
INSERT INTO `wp_shop_nation` VALUES ('1311', '350601', '市辖区', '1310');
INSERT INTO `wp_shop_nation` VALUES ('1312', '350602', '芗城区', '1310');
INSERT INTO `wp_shop_nation` VALUES ('1313', '350603', '龙文区', '1310');
INSERT INTO `wp_shop_nation` VALUES ('1314', '350622', '云霄县', '1310');
INSERT INTO `wp_shop_nation` VALUES ('1315', '350623', '漳浦县', '1310');
INSERT INTO `wp_shop_nation` VALUES ('1316', '350624', '诏安县', '1310');
INSERT INTO `wp_shop_nation` VALUES ('1317', '350625', '长泰县', '1310');
INSERT INTO `wp_shop_nation` VALUES ('1318', '350626', '东山县', '1310');
INSERT INTO `wp_shop_nation` VALUES ('1319', '350627', '南靖县', '1310');
INSERT INTO `wp_shop_nation` VALUES ('1320', '350628', '平和县', '1310');
INSERT INTO `wp_shop_nation` VALUES ('1321', '350629', '华安县', '1310');
INSERT INTO `wp_shop_nation` VALUES ('1322', '350681', '龙海市', '1310');
INSERT INTO `wp_shop_nation` VALUES ('1323', '350700', '南平市', '1251');
INSERT INTO `wp_shop_nation` VALUES ('1324', '350701', '市辖区', '1323');
INSERT INTO `wp_shop_nation` VALUES ('1325', '350702', '延平区', '1323');
INSERT INTO `wp_shop_nation` VALUES ('1326', '350703', '建阳区', '1323');
INSERT INTO `wp_shop_nation` VALUES ('1327', '350721', '顺昌县', '1323');
INSERT INTO `wp_shop_nation` VALUES ('1328', '350722', '浦城县', '1323');
INSERT INTO `wp_shop_nation` VALUES ('1329', '350723', '光泽县', '1323');
INSERT INTO `wp_shop_nation` VALUES ('1330', '350724', '松溪县', '1323');
INSERT INTO `wp_shop_nation` VALUES ('1331', '350725', '政和县', '1323');
INSERT INTO `wp_shop_nation` VALUES ('1332', '350781', '邵武市', '1323');
INSERT INTO `wp_shop_nation` VALUES ('1333', '350782', '武夷山市', '1323');
INSERT INTO `wp_shop_nation` VALUES ('1334', '350783', '建瓯市', '1323');
INSERT INTO `wp_shop_nation` VALUES ('1335', '350800', '龙岩市', '1251');
INSERT INTO `wp_shop_nation` VALUES ('1336', '350801', '市辖区', '1335');
INSERT INTO `wp_shop_nation` VALUES ('1337', '350802', '新罗区', '1335');
INSERT INTO `wp_shop_nation` VALUES ('1338', '350803', '永定区', '1335');
INSERT INTO `wp_shop_nation` VALUES ('1339', '350821', '长汀县', '1335');
INSERT INTO `wp_shop_nation` VALUES ('1340', '350823', '上杭县', '1335');
INSERT INTO `wp_shop_nation` VALUES ('1341', '350824', '武平县', '1335');
INSERT INTO `wp_shop_nation` VALUES ('1342', '350825', '连城县', '1335');
INSERT INTO `wp_shop_nation` VALUES ('1343', '350881', '漳平市', '1335');
INSERT INTO `wp_shop_nation` VALUES ('1344', '350900', '宁德市', '1251');
INSERT INTO `wp_shop_nation` VALUES ('1345', '350901', '市辖区', '1344');
INSERT INTO `wp_shop_nation` VALUES ('1346', '350902', '蕉城区', '1344');
INSERT INTO `wp_shop_nation` VALUES ('1347', '350921', '霞浦县', '1344');
INSERT INTO `wp_shop_nation` VALUES ('1348', '350922', '古田县', '1344');
INSERT INTO `wp_shop_nation` VALUES ('1349', '350923', '屏南县', '1344');
INSERT INTO `wp_shop_nation` VALUES ('1350', '350924', '寿宁县', '1344');
INSERT INTO `wp_shop_nation` VALUES ('1351', '350925', '周宁县', '1344');
INSERT INTO `wp_shop_nation` VALUES ('1352', '350926', '柘荣县', '1344');
INSERT INTO `wp_shop_nation` VALUES ('1353', '350981', '福安市', '1344');
INSERT INTO `wp_shop_nation` VALUES ('1354', '350982', '福鼎市', '1344');
INSERT INTO `wp_shop_nation` VALUES ('1355', '360000', '江西省', '0');
INSERT INTO `wp_shop_nation` VALUES ('1356', '360100', '南昌市', '1355');
INSERT INTO `wp_shop_nation` VALUES ('1357', '360101', '市辖区', '1356');
INSERT INTO `wp_shop_nation` VALUES ('1358', '360102', '东湖区', '1356');
INSERT INTO `wp_shop_nation` VALUES ('1359', '360103', '西湖区', '1356');
INSERT INTO `wp_shop_nation` VALUES ('1360', '360104', '青云谱区', '1356');
INSERT INTO `wp_shop_nation` VALUES ('1361', '360105', '湾里区', '1356');
INSERT INTO `wp_shop_nation` VALUES ('1362', '360111', '青山湖区', '1356');
INSERT INTO `wp_shop_nation` VALUES ('1363', '360121', '南昌县', '1356');
INSERT INTO `wp_shop_nation` VALUES ('1364', '360122', '新建县', '1356');
INSERT INTO `wp_shop_nation` VALUES ('1365', '360123', '安义县', '1356');
INSERT INTO `wp_shop_nation` VALUES ('1366', '360124', '进贤县', '1356');
INSERT INTO `wp_shop_nation` VALUES ('1367', '360200', '景德镇市', '1355');
INSERT INTO `wp_shop_nation` VALUES ('1368', '360201', '市辖区', '1367');
INSERT INTO `wp_shop_nation` VALUES ('1369', '360202', '昌江区', '1367');
INSERT INTO `wp_shop_nation` VALUES ('1370', '360203', '珠山区', '1367');
INSERT INTO `wp_shop_nation` VALUES ('1371', '360222', '浮梁县', '1367');
INSERT INTO `wp_shop_nation` VALUES ('1372', '360281', '乐平市', '1367');
INSERT INTO `wp_shop_nation` VALUES ('1373', '360300', '萍乡市', '1355');
INSERT INTO `wp_shop_nation` VALUES ('1374', '360301', '市辖区', '1373');
INSERT INTO `wp_shop_nation` VALUES ('1375', '360302', '安源区', '1373');
INSERT INTO `wp_shop_nation` VALUES ('1376', '360313', '湘东区', '1373');
INSERT INTO `wp_shop_nation` VALUES ('1377', '360321', '莲花县', '1373');
INSERT INTO `wp_shop_nation` VALUES ('1378', '360322', '上栗县', '1373');
INSERT INTO `wp_shop_nation` VALUES ('1379', '360323', '芦溪县', '1373');
INSERT INTO `wp_shop_nation` VALUES ('1380', '360400', '九江市', '1355');
INSERT INTO `wp_shop_nation` VALUES ('1381', '360401', '市辖区', '1380');
INSERT INTO `wp_shop_nation` VALUES ('1382', '360402', '庐山区', '1380');
INSERT INTO `wp_shop_nation` VALUES ('1383', '360403', '浔阳区', '1380');
INSERT INTO `wp_shop_nation` VALUES ('1384', '360421', '九江县', '1380');
INSERT INTO `wp_shop_nation` VALUES ('1385', '360423', '武宁县', '1380');
INSERT INTO `wp_shop_nation` VALUES ('1386', '360424', '修水县', '1380');
INSERT INTO `wp_shop_nation` VALUES ('1387', '360425', '永修县', '1380');
INSERT INTO `wp_shop_nation` VALUES ('1388', '360426', '德安县', '1380');
INSERT INTO `wp_shop_nation` VALUES ('1389', '360427', '星子县', '1380');
INSERT INTO `wp_shop_nation` VALUES ('1390', '360428', '都昌县', '1380');
INSERT INTO `wp_shop_nation` VALUES ('1391', '360429', '湖口县', '1380');
INSERT INTO `wp_shop_nation` VALUES ('1392', '360430', '彭泽县', '1380');
INSERT INTO `wp_shop_nation` VALUES ('1393', '360481', '瑞昌市', '1380');
INSERT INTO `wp_shop_nation` VALUES ('1394', '360482', '共青城市', '1380');
INSERT INTO `wp_shop_nation` VALUES ('1395', '360500', '新余市', '1355');
INSERT INTO `wp_shop_nation` VALUES ('1396', '360501', '市辖区', '1395');
INSERT INTO `wp_shop_nation` VALUES ('1397', '360502', '渝水区', '1395');
INSERT INTO `wp_shop_nation` VALUES ('1398', '360521', '分宜县', '1395');
INSERT INTO `wp_shop_nation` VALUES ('1399', '360600', '鹰潭市', '1355');
INSERT INTO `wp_shop_nation` VALUES ('1400', '360601', '市辖区', '1399');
INSERT INTO `wp_shop_nation` VALUES ('1401', '360602', '月湖区', '1399');
INSERT INTO `wp_shop_nation` VALUES ('1402', '360622', '余江县', '1399');
INSERT INTO `wp_shop_nation` VALUES ('1403', '360681', '贵溪市', '1399');
INSERT INTO `wp_shop_nation` VALUES ('1404', '360700', '赣州市', '1355');
INSERT INTO `wp_shop_nation` VALUES ('1405', '360701', '市辖区', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1406', '360702', '章贡区', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1407', '360703', '南康区', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1408', '360721', '赣县', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1409', '360722', '信丰县', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1410', '360723', '大余县', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1411', '360724', '上犹县', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1412', '360725', '崇义县', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1413', '360726', '安远县', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1414', '360727', '龙南县', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1415', '360728', '定南县', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1416', '360729', '全南县', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1417', '360730', '宁都县', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1418', '360731', '于都县', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1419', '360732', '兴国县', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1420', '360733', '会昌县', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1421', '360734', '寻乌县', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1422', '360735', '石城县', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1423', '360781', '瑞金市', '1404');
INSERT INTO `wp_shop_nation` VALUES ('1424', '360800', '吉安市', '1355');
INSERT INTO `wp_shop_nation` VALUES ('1425', '360801', '市辖区', '1424');
INSERT INTO `wp_shop_nation` VALUES ('1426', '360802', '吉州区', '1424');
INSERT INTO `wp_shop_nation` VALUES ('1427', '360803', '青原区', '1424');
INSERT INTO `wp_shop_nation` VALUES ('1428', '360821', '吉安县', '1424');
INSERT INTO `wp_shop_nation` VALUES ('1429', '360822', '吉水县', '1424');
INSERT INTO `wp_shop_nation` VALUES ('1430', '360823', '峡江县', '1424');
INSERT INTO `wp_shop_nation` VALUES ('1431', '360824', '新干县', '1424');
INSERT INTO `wp_shop_nation` VALUES ('1432', '360825', '永丰县', '1424');
INSERT INTO `wp_shop_nation` VALUES ('1433', '360826', '泰和县', '1424');
INSERT INTO `wp_shop_nation` VALUES ('1434', '360827', '遂川县', '1424');
INSERT INTO `wp_shop_nation` VALUES ('1435', '360828', '万安县', '1424');
INSERT INTO `wp_shop_nation` VALUES ('1436', '360829', '安福县', '1424');
INSERT INTO `wp_shop_nation` VALUES ('1437', '360830', '永新县', '1424');
INSERT INTO `wp_shop_nation` VALUES ('1438', '360881', '井冈山市', '1424');
INSERT INTO `wp_shop_nation` VALUES ('1439', '360900', '宜春市', '1355');
INSERT INTO `wp_shop_nation` VALUES ('1440', '360901', '市辖区', '1439');
INSERT INTO `wp_shop_nation` VALUES ('1441', '360902', '袁州区', '1439');
INSERT INTO `wp_shop_nation` VALUES ('1442', '360921', '奉新县', '1439');
INSERT INTO `wp_shop_nation` VALUES ('1443', '360922', '万载县', '1439');
INSERT INTO `wp_shop_nation` VALUES ('1444', '360923', '上高县', '1439');
INSERT INTO `wp_shop_nation` VALUES ('1445', '360924', '宜丰县', '1439');
INSERT INTO `wp_shop_nation` VALUES ('1446', '360925', '靖安县', '1439');
INSERT INTO `wp_shop_nation` VALUES ('1447', '360926', '铜鼓县', '1439');
INSERT INTO `wp_shop_nation` VALUES ('1448', '360981', '丰城市', '1439');
INSERT INTO `wp_shop_nation` VALUES ('1449', '360982', '樟树市', '1439');
INSERT INTO `wp_shop_nation` VALUES ('1450', '360983', '高安市', '1439');
INSERT INTO `wp_shop_nation` VALUES ('1451', '361000', '抚州市', '1355');
INSERT INTO `wp_shop_nation` VALUES ('1452', '361001', '市辖区', '1451');
INSERT INTO `wp_shop_nation` VALUES ('1453', '361002', '临川区', '1451');
INSERT INTO `wp_shop_nation` VALUES ('1454', '361021', '南城县', '1451');
INSERT INTO `wp_shop_nation` VALUES ('1455', '361022', '黎川县', '1451');
INSERT INTO `wp_shop_nation` VALUES ('1456', '361023', '南丰县', '1451');
INSERT INTO `wp_shop_nation` VALUES ('1457', '361024', '崇仁县', '1451');
INSERT INTO `wp_shop_nation` VALUES ('1458', '361025', '乐安县', '1451');
INSERT INTO `wp_shop_nation` VALUES ('1459', '361026', '宜黄县', '1451');
INSERT INTO `wp_shop_nation` VALUES ('1460', '361027', '金溪县', '1451');
INSERT INTO `wp_shop_nation` VALUES ('1461', '361028', '资溪县', '1451');
INSERT INTO `wp_shop_nation` VALUES ('1462', '361029', '东乡县', '1451');
INSERT INTO `wp_shop_nation` VALUES ('1463', '361030', '广昌县', '1451');
INSERT INTO `wp_shop_nation` VALUES ('1464', '361100', '上饶市', '1355');
INSERT INTO `wp_shop_nation` VALUES ('1465', '361101', '市辖区', '1464');
INSERT INTO `wp_shop_nation` VALUES ('1466', '361102', '信州区', '1464');
INSERT INTO `wp_shop_nation` VALUES ('1467', '361121', '上饶县', '1464');
INSERT INTO `wp_shop_nation` VALUES ('1468', '361122', '广丰县', '1464');
INSERT INTO `wp_shop_nation` VALUES ('1469', '361123', '玉山县', '1464');
INSERT INTO `wp_shop_nation` VALUES ('1470', '361124', '铅山县', '1464');
INSERT INTO `wp_shop_nation` VALUES ('1471', '361125', '横峰县', '1464');
INSERT INTO `wp_shop_nation` VALUES ('1472', '361126', '弋阳县', '1464');
INSERT INTO `wp_shop_nation` VALUES ('1473', '361127', '余干县', '1464');
INSERT INTO `wp_shop_nation` VALUES ('1474', '361128', '鄱阳县', '1464');
INSERT INTO `wp_shop_nation` VALUES ('1475', '361129', '万年县', '1464');
INSERT INTO `wp_shop_nation` VALUES ('1476', '361130', '婺源县', '1464');
INSERT INTO `wp_shop_nation` VALUES ('1477', '361181', '德兴市', '1464');
INSERT INTO `wp_shop_nation` VALUES ('1478', '370000', '山东省', '0');
INSERT INTO `wp_shop_nation` VALUES ('1479', '370100', '济南市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1480', '370101', '市辖区', '1479');
INSERT INTO `wp_shop_nation` VALUES ('1481', '370102', '历下区', '1479');
INSERT INTO `wp_shop_nation` VALUES ('1482', '370103', '市中区', '1479');
INSERT INTO `wp_shop_nation` VALUES ('1483', '370104', '槐荫区', '1479');
INSERT INTO `wp_shop_nation` VALUES ('1484', '370105', '天桥区', '1479');
INSERT INTO `wp_shop_nation` VALUES ('1485', '370112', '历城区', '1479');
INSERT INTO `wp_shop_nation` VALUES ('1486', '370113', '长清区', '1479');
INSERT INTO `wp_shop_nation` VALUES ('1487', '370124', '平阴县', '1479');
INSERT INTO `wp_shop_nation` VALUES ('1488', '370125', '济阳县', '1479');
INSERT INTO `wp_shop_nation` VALUES ('1489', '370126', '商河县', '1479');
INSERT INTO `wp_shop_nation` VALUES ('1490', '370181', '章丘市', '1479');
INSERT INTO `wp_shop_nation` VALUES ('1491', '370200', '青岛市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1492', '370201', '市辖区', '1491');
INSERT INTO `wp_shop_nation` VALUES ('1493', '370202', '市南区', '1491');
INSERT INTO `wp_shop_nation` VALUES ('1494', '370203', '市北区', '1491');
INSERT INTO `wp_shop_nation` VALUES ('1495', '370211', '黄岛区', '1491');
INSERT INTO `wp_shop_nation` VALUES ('1496', '370212', '崂山区', '1491');
INSERT INTO `wp_shop_nation` VALUES ('1497', '370213', '李沧区', '1491');
INSERT INTO `wp_shop_nation` VALUES ('1498', '370214', '城阳区', '1491');
INSERT INTO `wp_shop_nation` VALUES ('1499', '370281', '胶州市', '1491');
INSERT INTO `wp_shop_nation` VALUES ('1500', '370282', '即墨市', '1491');
INSERT INTO `wp_shop_nation` VALUES ('1501', '370283', '平度市', '1491');
INSERT INTO `wp_shop_nation` VALUES ('1502', '370285', '莱西市', '1491');
INSERT INTO `wp_shop_nation` VALUES ('1503', '370300', '淄博市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1504', '370301', '市辖区', '1503');
INSERT INTO `wp_shop_nation` VALUES ('1505', '370302', '淄川区', '1503');
INSERT INTO `wp_shop_nation` VALUES ('1506', '370303', '张店区', '1503');
INSERT INTO `wp_shop_nation` VALUES ('1507', '370304', '博山区', '1503');
INSERT INTO `wp_shop_nation` VALUES ('1508', '370305', '临淄区', '1503');
INSERT INTO `wp_shop_nation` VALUES ('1509', '370306', '周村区', '1503');
INSERT INTO `wp_shop_nation` VALUES ('1510', '370321', '桓台县', '1503');
INSERT INTO `wp_shop_nation` VALUES ('1511', '370322', '高青县', '1503');
INSERT INTO `wp_shop_nation` VALUES ('1512', '370323', '沂源县', '1503');
INSERT INTO `wp_shop_nation` VALUES ('1513', '370400', '枣庄市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1514', '370401', '市辖区', '1513');
INSERT INTO `wp_shop_nation` VALUES ('1515', '370402', '市中区', '1513');
INSERT INTO `wp_shop_nation` VALUES ('1516', '370403', '薛城区', '1513');
INSERT INTO `wp_shop_nation` VALUES ('1517', '370404', '峄城区', '1513');
INSERT INTO `wp_shop_nation` VALUES ('1518', '370405', '台儿庄区', '1513');
INSERT INTO `wp_shop_nation` VALUES ('1519', '370406', '山亭区', '1513');
INSERT INTO `wp_shop_nation` VALUES ('1520', '370481', '滕州市', '1513');
INSERT INTO `wp_shop_nation` VALUES ('1521', '370500', '东营市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1522', '370501', '市辖区', '1521');
INSERT INTO `wp_shop_nation` VALUES ('1523', '370502', '东营区', '1521');
INSERT INTO `wp_shop_nation` VALUES ('1524', '370503', '河口区', '1521');
INSERT INTO `wp_shop_nation` VALUES ('1525', '370521', '垦利县', '1521');
INSERT INTO `wp_shop_nation` VALUES ('1526', '370522', '利津县', '1521');
INSERT INTO `wp_shop_nation` VALUES ('1527', '370523', '广饶县', '1521');
INSERT INTO `wp_shop_nation` VALUES ('1528', '370600', '烟台市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1529', '370601', '市辖区', '1528');
INSERT INTO `wp_shop_nation` VALUES ('1530', '370602', '芝罘区', '1528');
INSERT INTO `wp_shop_nation` VALUES ('1531', '370611', '福山区', '1528');
INSERT INTO `wp_shop_nation` VALUES ('1532', '370612', '牟平区', '1528');
INSERT INTO `wp_shop_nation` VALUES ('1533', '370613', '莱山区', '1528');
INSERT INTO `wp_shop_nation` VALUES ('1534', '370634', '长岛县', '1528');
INSERT INTO `wp_shop_nation` VALUES ('1535', '370681', '龙口市', '1528');
INSERT INTO `wp_shop_nation` VALUES ('1536', '370682', '莱阳市', '1528');
INSERT INTO `wp_shop_nation` VALUES ('1537', '370683', '莱州市', '1528');
INSERT INTO `wp_shop_nation` VALUES ('1538', '370684', '蓬莱市', '1528');
INSERT INTO `wp_shop_nation` VALUES ('1539', '370685', '招远市', '1528');
INSERT INTO `wp_shop_nation` VALUES ('1540', '370686', '栖霞市', '1528');
INSERT INTO `wp_shop_nation` VALUES ('1541', '370687', '海阳市', '1528');
INSERT INTO `wp_shop_nation` VALUES ('1542', '370700', '潍坊市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1543', '370701', '市辖区', '1542');
INSERT INTO `wp_shop_nation` VALUES ('1544', '370702', '潍城区', '1542');
INSERT INTO `wp_shop_nation` VALUES ('1545', '370703', '寒亭区', '1542');
INSERT INTO `wp_shop_nation` VALUES ('1546', '370704', '坊子区', '1542');
INSERT INTO `wp_shop_nation` VALUES ('1547', '370705', '奎文区', '1542');
INSERT INTO `wp_shop_nation` VALUES ('1548', '370724', '临朐县', '1542');
INSERT INTO `wp_shop_nation` VALUES ('1549', '370725', '昌乐县', '1542');
INSERT INTO `wp_shop_nation` VALUES ('1550', '370781', '青州市', '1542');
INSERT INTO `wp_shop_nation` VALUES ('1551', '370782', '诸城市', '1542');
INSERT INTO `wp_shop_nation` VALUES ('1552', '370783', '寿光市', '1542');
INSERT INTO `wp_shop_nation` VALUES ('1553', '370784', '安丘市', '1542');
INSERT INTO `wp_shop_nation` VALUES ('1554', '370785', '高密市', '1542');
INSERT INTO `wp_shop_nation` VALUES ('1555', '370786', '昌邑市', '1542');
INSERT INTO `wp_shop_nation` VALUES ('1556', '370800', '济宁市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1557', '370801', '市辖区', '1556');
INSERT INTO `wp_shop_nation` VALUES ('1558', '370811', '任城区', '1556');
INSERT INTO `wp_shop_nation` VALUES ('1559', '370812', '兖州区', '1556');
INSERT INTO `wp_shop_nation` VALUES ('1560', '370826', '微山县', '1556');
INSERT INTO `wp_shop_nation` VALUES ('1561', '370827', '鱼台县', '1556');
INSERT INTO `wp_shop_nation` VALUES ('1562', '370828', '金乡县', '1556');
INSERT INTO `wp_shop_nation` VALUES ('1563', '370829', '嘉祥县', '1556');
INSERT INTO `wp_shop_nation` VALUES ('1564', '370830', '汶上县', '1556');
INSERT INTO `wp_shop_nation` VALUES ('1565', '370831', '泗水县', '1556');
INSERT INTO `wp_shop_nation` VALUES ('1566', '370832', '梁山县', '1556');
INSERT INTO `wp_shop_nation` VALUES ('1567', '370881', '曲阜市', '1556');
INSERT INTO `wp_shop_nation` VALUES ('1568', '370883', '邹城市', '1556');
INSERT INTO `wp_shop_nation` VALUES ('1569', '370900', '泰安市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1570', '370901', '市辖区', '1569');
INSERT INTO `wp_shop_nation` VALUES ('1571', '370902', '泰山区', '1569');
INSERT INTO `wp_shop_nation` VALUES ('1572', '370911', '岱岳区', '1569');
INSERT INTO `wp_shop_nation` VALUES ('1573', '370921', '宁阳县', '1569');
INSERT INTO `wp_shop_nation` VALUES ('1574', '370923', '东平县', '1569');
INSERT INTO `wp_shop_nation` VALUES ('1575', '370982', '新泰市', '1569');
INSERT INTO `wp_shop_nation` VALUES ('1576', '370983', '肥城市', '1569');
INSERT INTO `wp_shop_nation` VALUES ('1577', '371000', '威海市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1578', '371001', '市辖区', '1577');
INSERT INTO `wp_shop_nation` VALUES ('1579', '371002', '环翠区', '1577');
INSERT INTO `wp_shop_nation` VALUES ('1580', '371081', '文登市', '1577');
INSERT INTO `wp_shop_nation` VALUES ('1581', '371082', '荣成市', '1577');
INSERT INTO `wp_shop_nation` VALUES ('1582', '371083', '乳山市', '1577');
INSERT INTO `wp_shop_nation` VALUES ('1583', '371100', '日照市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1584', '371101', '市辖区', '1583');
INSERT INTO `wp_shop_nation` VALUES ('1585', '371102', '东港区', '1583');
INSERT INTO `wp_shop_nation` VALUES ('1586', '371103', '岚山区', '1583');
INSERT INTO `wp_shop_nation` VALUES ('1587', '371121', '五莲县', '1583');
INSERT INTO `wp_shop_nation` VALUES ('1588', '371122', '莒县', '1583');
INSERT INTO `wp_shop_nation` VALUES ('1589', '371200', '莱芜市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1590', '371201', '市辖区', '1589');
INSERT INTO `wp_shop_nation` VALUES ('1591', '371202', '莱城区', '1589');
INSERT INTO `wp_shop_nation` VALUES ('1592', '371203', '钢城区', '1589');
INSERT INTO `wp_shop_nation` VALUES ('1593', '371300', '临沂市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1594', '371301', '市辖区', '1593');
INSERT INTO `wp_shop_nation` VALUES ('1595', '371302', '兰山区', '1593');
INSERT INTO `wp_shop_nation` VALUES ('1596', '371311', '罗庄区', '1593');
INSERT INTO `wp_shop_nation` VALUES ('1597', '371312', '河东区', '1593');
INSERT INTO `wp_shop_nation` VALUES ('1598', '371321', '沂南县', '1593');
INSERT INTO `wp_shop_nation` VALUES ('1599', '371322', '郯城县', '1593');
INSERT INTO `wp_shop_nation` VALUES ('1600', '371323', '沂水县', '1593');
INSERT INTO `wp_shop_nation` VALUES ('1601', '371324', '兰陵县', '1593');
INSERT INTO `wp_shop_nation` VALUES ('1602', '371325', '费县', '1593');
INSERT INTO `wp_shop_nation` VALUES ('1603', '371326', '平邑县', '1593');
INSERT INTO `wp_shop_nation` VALUES ('1604', '371327', '莒南县', '1593');
INSERT INTO `wp_shop_nation` VALUES ('1605', '371328', '蒙阴县', '1593');
INSERT INTO `wp_shop_nation` VALUES ('1606', '371329', '临沭县', '1593');
INSERT INTO `wp_shop_nation` VALUES ('1607', '371400', '德州市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1608', '371401', '市辖区', '1607');
INSERT INTO `wp_shop_nation` VALUES ('1609', '371402', '德城区', '1607');
INSERT INTO `wp_shop_nation` VALUES ('1610', '371403', '陵城区', '1607');
INSERT INTO `wp_shop_nation` VALUES ('1611', '371422', '宁津县', '1607');
INSERT INTO `wp_shop_nation` VALUES ('1612', '371423', '庆云县', '1607');
INSERT INTO `wp_shop_nation` VALUES ('1613', '371424', '临邑县', '1607');
INSERT INTO `wp_shop_nation` VALUES ('1614', '371425', '齐河县', '1607');
INSERT INTO `wp_shop_nation` VALUES ('1615', '371426', '平原县', '1607');
INSERT INTO `wp_shop_nation` VALUES ('1616', '371427', '夏津县', '1607');
INSERT INTO `wp_shop_nation` VALUES ('1617', '371428', '武城县', '1607');
INSERT INTO `wp_shop_nation` VALUES ('1618', '371481', '乐陵市', '1607');
INSERT INTO `wp_shop_nation` VALUES ('1619', '371482', '禹城市', '1607');
INSERT INTO `wp_shop_nation` VALUES ('1620', '371500', '聊城市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1621', '371501', '市辖区', '1620');
INSERT INTO `wp_shop_nation` VALUES ('1622', '371502', '东昌府区', '1620');
INSERT INTO `wp_shop_nation` VALUES ('1623', '371521', '阳谷县', '1620');
INSERT INTO `wp_shop_nation` VALUES ('1624', '371522', '莘县', '1620');
INSERT INTO `wp_shop_nation` VALUES ('1625', '371523', '茌平县', '1620');
INSERT INTO `wp_shop_nation` VALUES ('1626', '371524', '东阿县', '1620');
INSERT INTO `wp_shop_nation` VALUES ('1627', '371525', '冠县', '1620');
INSERT INTO `wp_shop_nation` VALUES ('1628', '371526', '高唐县', '1620');
INSERT INTO `wp_shop_nation` VALUES ('1629', '371581', '临清市', '1620');
INSERT INTO `wp_shop_nation` VALUES ('1630', '371600', '滨州市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1631', '371601', '市辖区', '1630');
INSERT INTO `wp_shop_nation` VALUES ('1632', '371602', '滨城区', '1630');
INSERT INTO `wp_shop_nation` VALUES ('1633', '371603', '沾化区', '1630');
INSERT INTO `wp_shop_nation` VALUES ('1634', '371621', '惠民县', '1630');
INSERT INTO `wp_shop_nation` VALUES ('1635', '371622', '阳信县', '1630');
INSERT INTO `wp_shop_nation` VALUES ('1636', '371623', '无棣县', '1630');
INSERT INTO `wp_shop_nation` VALUES ('1637', '371625', '博兴县', '1630');
INSERT INTO `wp_shop_nation` VALUES ('1638', '371626', '邹平县', '1630');
INSERT INTO `wp_shop_nation` VALUES ('1639', '371700', '菏泽市', '1478');
INSERT INTO `wp_shop_nation` VALUES ('1640', '371701', '市辖区', '1639');
INSERT INTO `wp_shop_nation` VALUES ('1641', '371702', '牡丹区', '1639');
INSERT INTO `wp_shop_nation` VALUES ('1642', '371721', '曹县', '1639');
INSERT INTO `wp_shop_nation` VALUES ('1643', '371722', '单县', '1639');
INSERT INTO `wp_shop_nation` VALUES ('1644', '371723', '成武县', '1639');
INSERT INTO `wp_shop_nation` VALUES ('1645', '371724', '巨野县', '1639');
INSERT INTO `wp_shop_nation` VALUES ('1646', '371725', '郓城县', '1639');
INSERT INTO `wp_shop_nation` VALUES ('1647', '371726', '鄄城县', '1639');
INSERT INTO `wp_shop_nation` VALUES ('1648', '371727', '定陶县', '1639');
INSERT INTO `wp_shop_nation` VALUES ('1649', '371728', '东明县', '1639');
INSERT INTO `wp_shop_nation` VALUES ('1650', '410000', '河南省', '0');
INSERT INTO `wp_shop_nation` VALUES ('1651', '410100', '郑州市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1652', '410101', '市辖区', '1651');
INSERT INTO `wp_shop_nation` VALUES ('1653', '410102', '中原区', '1651');
INSERT INTO `wp_shop_nation` VALUES ('1654', '410103', '二七区', '1651');
INSERT INTO `wp_shop_nation` VALUES ('1655', '410104', '管城回族区', '1651');
INSERT INTO `wp_shop_nation` VALUES ('1656', '410105', '金水区', '1651');
INSERT INTO `wp_shop_nation` VALUES ('1657', '410106', '上街区', '1651');
INSERT INTO `wp_shop_nation` VALUES ('1658', '410108', '惠济区', '1651');
INSERT INTO `wp_shop_nation` VALUES ('1659', '410122', '中牟县', '1651');
INSERT INTO `wp_shop_nation` VALUES ('1660', '410181', '巩义市', '1651');
INSERT INTO `wp_shop_nation` VALUES ('1661', '410182', '荥阳市', '1651');
INSERT INTO `wp_shop_nation` VALUES ('1662', '410183', '新密市', '1651');
INSERT INTO `wp_shop_nation` VALUES ('1663', '410184', '新郑市', '1651');
INSERT INTO `wp_shop_nation` VALUES ('1664', '410185', '登封市', '1651');
INSERT INTO `wp_shop_nation` VALUES ('1665', '410200', '开封市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1666', '410201', '市辖区', '1665');
INSERT INTO `wp_shop_nation` VALUES ('1667', '410202', '龙亭区', '1665');
INSERT INTO `wp_shop_nation` VALUES ('1668', '410203', '顺河回族区', '1665');
INSERT INTO `wp_shop_nation` VALUES ('1669', '410204', '鼓楼区', '1665');
INSERT INTO `wp_shop_nation` VALUES ('1670', '410205', '禹王台区', '1665');
INSERT INTO `wp_shop_nation` VALUES ('1671', '410212', '祥符区', '1665');
INSERT INTO `wp_shop_nation` VALUES ('1672', '410221', '杞县', '1665');
INSERT INTO `wp_shop_nation` VALUES ('1673', '410222', '通许县', '1665');
INSERT INTO `wp_shop_nation` VALUES ('1674', '410223', '尉氏县', '1665');
INSERT INTO `wp_shop_nation` VALUES ('1675', '410225', '兰考县', '1665');
INSERT INTO `wp_shop_nation` VALUES ('1676', '410300', '洛阳市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1677', '410301', '市辖区', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1678', '410302', '老城区', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1679', '410303', '西工区', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1680', '410304', '瀍河回族区', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1681', '410305', '涧西区', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1682', '410306', '吉利区', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1683', '410311', '洛龙区', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1684', '410322', '孟津县', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1685', '410323', '新安县', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1686', '410324', '栾川县', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1687', '410325', '嵩县', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1688', '410326', '汝阳县', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1689', '410327', '宜阳县', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1690', '410328', '洛宁县', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1691', '410329', '伊川县', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1692', '410381', '偃师市', '1676');
INSERT INTO `wp_shop_nation` VALUES ('1693', '410400', '平顶山市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1694', '410401', '市辖区', '1693');
INSERT INTO `wp_shop_nation` VALUES ('1695', '410402', '新华区', '1693');
INSERT INTO `wp_shop_nation` VALUES ('1696', '410403', '卫东区', '1693');
INSERT INTO `wp_shop_nation` VALUES ('1697', '410404', '石龙区', '1693');
INSERT INTO `wp_shop_nation` VALUES ('1698', '410411', '湛河区', '1693');
INSERT INTO `wp_shop_nation` VALUES ('1699', '410421', '宝丰县', '1693');
INSERT INTO `wp_shop_nation` VALUES ('1700', '410422', '叶县', '1693');
INSERT INTO `wp_shop_nation` VALUES ('1701', '410423', '鲁山县', '1693');
INSERT INTO `wp_shop_nation` VALUES ('1702', '410425', '郏县', '1693');
INSERT INTO `wp_shop_nation` VALUES ('1703', '410481', '舞钢市', '1693');
INSERT INTO `wp_shop_nation` VALUES ('1704', '410482', '汝州市', '1693');
INSERT INTO `wp_shop_nation` VALUES ('1705', '410500', '安阳市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1706', '410501', '市辖区', '1705');
INSERT INTO `wp_shop_nation` VALUES ('1707', '410502', '文峰区', '1705');
INSERT INTO `wp_shop_nation` VALUES ('1708', '410503', '北关区', '1705');
INSERT INTO `wp_shop_nation` VALUES ('1709', '410505', '殷都区', '1705');
INSERT INTO `wp_shop_nation` VALUES ('1710', '410506', '龙安区', '1705');
INSERT INTO `wp_shop_nation` VALUES ('1711', '410522', '安阳县', '1705');
INSERT INTO `wp_shop_nation` VALUES ('1712', '410523', '汤阴县', '1705');
INSERT INTO `wp_shop_nation` VALUES ('1713', '410526', '滑县', '1705');
INSERT INTO `wp_shop_nation` VALUES ('1714', '410527', '内黄县', '1705');
INSERT INTO `wp_shop_nation` VALUES ('1715', '410581', '林州市', '1705');
INSERT INTO `wp_shop_nation` VALUES ('1716', '410600', '鹤壁市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1717', '410601', '市辖区', '1716');
INSERT INTO `wp_shop_nation` VALUES ('1718', '410602', '鹤山区', '1716');
INSERT INTO `wp_shop_nation` VALUES ('1719', '410603', '山城区', '1716');
INSERT INTO `wp_shop_nation` VALUES ('1720', '410611', '淇滨区', '1716');
INSERT INTO `wp_shop_nation` VALUES ('1721', '410621', '浚县', '1716');
INSERT INTO `wp_shop_nation` VALUES ('1722', '410622', '淇县', '1716');
INSERT INTO `wp_shop_nation` VALUES ('1723', '410700', '新乡市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1724', '410701', '市辖区', '1723');
INSERT INTO `wp_shop_nation` VALUES ('1725', '410702', '红旗区', '1723');
INSERT INTO `wp_shop_nation` VALUES ('1726', '410703', '卫滨区', '1723');
INSERT INTO `wp_shop_nation` VALUES ('1727', '410704', '凤泉区', '1723');
INSERT INTO `wp_shop_nation` VALUES ('1728', '410711', '牧野区', '1723');
INSERT INTO `wp_shop_nation` VALUES ('1729', '410721', '新乡县', '1723');
INSERT INTO `wp_shop_nation` VALUES ('1730', '410724', '获嘉县', '1723');
INSERT INTO `wp_shop_nation` VALUES ('1731', '410725', '原阳县', '1723');
INSERT INTO `wp_shop_nation` VALUES ('1732', '410726', '延津县', '1723');
INSERT INTO `wp_shop_nation` VALUES ('1733', '410727', '封丘县', '1723');
INSERT INTO `wp_shop_nation` VALUES ('1734', '410728', '长垣县', '1723');
INSERT INTO `wp_shop_nation` VALUES ('1735', '410781', '卫辉市', '1723');
INSERT INTO `wp_shop_nation` VALUES ('1736', '410782', '辉县市', '1723');
INSERT INTO `wp_shop_nation` VALUES ('1737', '410800', '焦作市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1738', '410801', '市辖区', '1737');
INSERT INTO `wp_shop_nation` VALUES ('1739', '410802', '解放区', '1737');
INSERT INTO `wp_shop_nation` VALUES ('1740', '410803', '中站区', '1737');
INSERT INTO `wp_shop_nation` VALUES ('1741', '410804', '马村区', '1737');
INSERT INTO `wp_shop_nation` VALUES ('1742', '410811', '山阳区', '1737');
INSERT INTO `wp_shop_nation` VALUES ('1743', '410821', '修武县', '1737');
INSERT INTO `wp_shop_nation` VALUES ('1744', '410822', '博爱县', '1737');
INSERT INTO `wp_shop_nation` VALUES ('1745', '410823', '武陟县', '1737');
INSERT INTO `wp_shop_nation` VALUES ('1746', '410825', '温县', '1737');
INSERT INTO `wp_shop_nation` VALUES ('1747', '410882', '沁阳市', '1737');
INSERT INTO `wp_shop_nation` VALUES ('1748', '410883', '孟州市', '1737');
INSERT INTO `wp_shop_nation` VALUES ('1749', '410900', '濮阳市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1750', '410901', '市辖区', '1749');
INSERT INTO `wp_shop_nation` VALUES ('1751', '410902', '华龙区', '1749');
INSERT INTO `wp_shop_nation` VALUES ('1752', '410922', '清丰县', '1749');
INSERT INTO `wp_shop_nation` VALUES ('1753', '410923', '南乐县', '1749');
INSERT INTO `wp_shop_nation` VALUES ('1754', '410926', '范县', '1749');
INSERT INTO `wp_shop_nation` VALUES ('1755', '410927', '台前县', '1749');
INSERT INTO `wp_shop_nation` VALUES ('1756', '410928', '濮阳县', '1749');
INSERT INTO `wp_shop_nation` VALUES ('1757', '411000', '许昌市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1758', '411001', '市辖区', '1757');
INSERT INTO `wp_shop_nation` VALUES ('1759', '411002', '魏都区', '1757');
INSERT INTO `wp_shop_nation` VALUES ('1760', '411023', '许昌县', '1757');
INSERT INTO `wp_shop_nation` VALUES ('1761', '411024', '鄢陵县', '1757');
INSERT INTO `wp_shop_nation` VALUES ('1762', '411025', '襄城县', '1757');
INSERT INTO `wp_shop_nation` VALUES ('1763', '411081', '禹州市', '1757');
INSERT INTO `wp_shop_nation` VALUES ('1764', '411082', '长葛市', '1757');
INSERT INTO `wp_shop_nation` VALUES ('1765', '411100', '漯河市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1766', '411101', '市辖区', '1765');
INSERT INTO `wp_shop_nation` VALUES ('1767', '411102', '源汇区', '1765');
INSERT INTO `wp_shop_nation` VALUES ('1768', '411103', '郾城区', '1765');
INSERT INTO `wp_shop_nation` VALUES ('1769', '411104', '召陵区', '1765');
INSERT INTO `wp_shop_nation` VALUES ('1770', '411121', '舞阳县', '1765');
INSERT INTO `wp_shop_nation` VALUES ('1771', '411122', '临颍县', '1765');
INSERT INTO `wp_shop_nation` VALUES ('1772', '411200', '三门峡市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1773', '411201', '市辖区', '1772');
INSERT INTO `wp_shop_nation` VALUES ('1774', '411202', '湖滨区', '1772');
INSERT INTO `wp_shop_nation` VALUES ('1775', '411221', '渑池县', '1772');
INSERT INTO `wp_shop_nation` VALUES ('1776', '411222', '陕县', '1772');
INSERT INTO `wp_shop_nation` VALUES ('1777', '411224', '卢氏县', '1772');
INSERT INTO `wp_shop_nation` VALUES ('1778', '411281', '义马市', '1772');
INSERT INTO `wp_shop_nation` VALUES ('1779', '411282', '灵宝市', '1772');
INSERT INTO `wp_shop_nation` VALUES ('1780', '411300', '南阳市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1781', '411301', '市辖区', '1780');
INSERT INTO `wp_shop_nation` VALUES ('1782', '411302', '宛城区', '1780');
INSERT INTO `wp_shop_nation` VALUES ('1783', '411303', '卧龙区', '1780');
INSERT INTO `wp_shop_nation` VALUES ('1784', '411321', '南召县', '1780');
INSERT INTO `wp_shop_nation` VALUES ('1785', '411322', '方城县', '1780');
INSERT INTO `wp_shop_nation` VALUES ('1786', '411323', '西峡县', '1780');
INSERT INTO `wp_shop_nation` VALUES ('1787', '411324', '镇平县', '1780');
INSERT INTO `wp_shop_nation` VALUES ('1788', '411325', '内乡县', '1780');
INSERT INTO `wp_shop_nation` VALUES ('1789', '411326', '淅川县', '1780');
INSERT INTO `wp_shop_nation` VALUES ('1790', '411327', '社旗县', '1780');
INSERT INTO `wp_shop_nation` VALUES ('1791', '411328', '唐河县', '1780');
INSERT INTO `wp_shop_nation` VALUES ('1792', '411329', '新野县', '1780');
INSERT INTO `wp_shop_nation` VALUES ('1793', '411330', '桐柏县', '1780');
INSERT INTO `wp_shop_nation` VALUES ('1794', '411381', '邓州市', '1780');
INSERT INTO `wp_shop_nation` VALUES ('1795', '411400', '商丘市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1796', '411401', '市辖区', '1795');
INSERT INTO `wp_shop_nation` VALUES ('1797', '411402', '梁园区', '1795');
INSERT INTO `wp_shop_nation` VALUES ('1798', '411403', '睢阳区', '1795');
INSERT INTO `wp_shop_nation` VALUES ('1799', '411421', '民权县', '1795');
INSERT INTO `wp_shop_nation` VALUES ('1800', '411422', '睢县', '1795');
INSERT INTO `wp_shop_nation` VALUES ('1801', '411423', '宁陵县', '1795');
INSERT INTO `wp_shop_nation` VALUES ('1802', '411424', '柘城县', '1795');
INSERT INTO `wp_shop_nation` VALUES ('1803', '411425', '虞城县', '1795');
INSERT INTO `wp_shop_nation` VALUES ('1804', '411426', '夏邑县', '1795');
INSERT INTO `wp_shop_nation` VALUES ('1805', '411481', '永城市', '1795');
INSERT INTO `wp_shop_nation` VALUES ('1806', '411500', '信阳市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1807', '411501', '市辖区', '1806');
INSERT INTO `wp_shop_nation` VALUES ('1808', '411502', '浉河区', '1806');
INSERT INTO `wp_shop_nation` VALUES ('1809', '411503', '平桥区', '1806');
INSERT INTO `wp_shop_nation` VALUES ('1810', '411521', '罗山县', '1806');
INSERT INTO `wp_shop_nation` VALUES ('1811', '411522', '光山县', '1806');
INSERT INTO `wp_shop_nation` VALUES ('1812', '411523', '新县', '1806');
INSERT INTO `wp_shop_nation` VALUES ('1813', '411524', '商城县', '1806');
INSERT INTO `wp_shop_nation` VALUES ('1814', '411525', '固始县', '1806');
INSERT INTO `wp_shop_nation` VALUES ('1815', '411526', '潢川县', '1806');
INSERT INTO `wp_shop_nation` VALUES ('1816', '411527', '淮滨县', '1806');
INSERT INTO `wp_shop_nation` VALUES ('1817', '411528', '息县', '1806');
INSERT INTO `wp_shop_nation` VALUES ('1818', '411600', '周口市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1819', '411601', '市辖区', '1818');
INSERT INTO `wp_shop_nation` VALUES ('1820', '411602', '川汇区', '1818');
INSERT INTO `wp_shop_nation` VALUES ('1821', '411621', '扶沟县', '1818');
INSERT INTO `wp_shop_nation` VALUES ('1822', '411622', '西华县', '1818');
INSERT INTO `wp_shop_nation` VALUES ('1823', '411623', '商水县', '1818');
INSERT INTO `wp_shop_nation` VALUES ('1824', '411624', '沈丘县', '1818');
INSERT INTO `wp_shop_nation` VALUES ('1825', '411625', '郸城县', '1818');
INSERT INTO `wp_shop_nation` VALUES ('1826', '411626', '淮阳县', '1818');
INSERT INTO `wp_shop_nation` VALUES ('1827', '411627', '太康县', '1818');
INSERT INTO `wp_shop_nation` VALUES ('1828', '411628', '鹿邑县', '1818');
INSERT INTO `wp_shop_nation` VALUES ('1829', '411681', '项城市', '1818');
INSERT INTO `wp_shop_nation` VALUES ('1830', '411700', '驻马店市', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1831', '411701', '市辖区', '1830');
INSERT INTO `wp_shop_nation` VALUES ('1832', '411702', '驿城区', '1830');
INSERT INTO `wp_shop_nation` VALUES ('1833', '411721', '西平县', '1830');
INSERT INTO `wp_shop_nation` VALUES ('1834', '411722', '上蔡县', '1830');
INSERT INTO `wp_shop_nation` VALUES ('1835', '411723', '平舆县', '1830');
INSERT INTO `wp_shop_nation` VALUES ('1836', '411724', '正阳县', '1830');
INSERT INTO `wp_shop_nation` VALUES ('1837', '411725', '确山县', '1830');
INSERT INTO `wp_shop_nation` VALUES ('1838', '411726', '泌阳县', '1830');
INSERT INTO `wp_shop_nation` VALUES ('1839', '411727', '汝南县', '1830');
INSERT INTO `wp_shop_nation` VALUES ('1840', '411728', '遂平县', '1830');
INSERT INTO `wp_shop_nation` VALUES ('1841', '411729', '新蔡县', '1830');
INSERT INTO `wp_shop_nation` VALUES ('1842', '419000', '省直辖县级行政区划', '1650');
INSERT INTO `wp_shop_nation` VALUES ('1843', '419001', '济源市', '1842');
INSERT INTO `wp_shop_nation` VALUES ('1844', '420000', '湖北省', '0');
INSERT INTO `wp_shop_nation` VALUES ('1845', '420100', '武汉市', '1844');
INSERT INTO `wp_shop_nation` VALUES ('1846', '420101', '市辖区', '1845');
INSERT INTO `wp_shop_nation` VALUES ('1847', '420102', '江岸区', '1845');
INSERT INTO `wp_shop_nation` VALUES ('1848', '420103', '江汉区', '1845');
INSERT INTO `wp_shop_nation` VALUES ('1849', '420104', '硚口区', '1845');
INSERT INTO `wp_shop_nation` VALUES ('1850', '420105', '汉阳区', '1845');
INSERT INTO `wp_shop_nation` VALUES ('1851', '420106', '武昌区', '1845');
INSERT INTO `wp_shop_nation` VALUES ('1852', '420107', '青山区', '1845');
INSERT INTO `wp_shop_nation` VALUES ('1853', '420111', '洪山区', '1845');
INSERT INTO `wp_shop_nation` VALUES ('1854', '420112', '东西湖区', '1845');
INSERT INTO `wp_shop_nation` VALUES ('1855', '420113', '汉南区', '1845');
INSERT INTO `wp_shop_nation` VALUES ('1856', '420114', '蔡甸区', '1845');
INSERT INTO `wp_shop_nation` VALUES ('1857', '420115', '江夏区', '1845');
INSERT INTO `wp_shop_nation` VALUES ('1858', '420116', '黄陂区', '1845');
INSERT INTO `wp_shop_nation` VALUES ('1859', '420117', '新洲区', '1845');
INSERT INTO `wp_shop_nation` VALUES ('1860', '420200', '黄石市', '1844');
INSERT INTO `wp_shop_nation` VALUES ('1861', '420201', '市辖区', '1860');
INSERT INTO `wp_shop_nation` VALUES ('1862', '420202', '黄石港区', '1860');
INSERT INTO `wp_shop_nation` VALUES ('1863', '420203', '西塞山区', '1860');
INSERT INTO `wp_shop_nation` VALUES ('1864', '420204', '下陆区', '1860');
INSERT INTO `wp_shop_nation` VALUES ('1865', '420205', '铁山区', '1860');
INSERT INTO `wp_shop_nation` VALUES ('1866', '420222', '阳新县', '1860');
INSERT INTO `wp_shop_nation` VALUES ('1867', '420281', '大冶市', '1860');
INSERT INTO `wp_shop_nation` VALUES ('1868', '420300', '十堰市', '1844');
INSERT INTO `wp_shop_nation` VALUES ('1869', '420301', '市辖区', '1868');
INSERT INTO `wp_shop_nation` VALUES ('1870', '420302', '茅箭区', '1868');
INSERT INTO `wp_shop_nation` VALUES ('1871', '420303', '张湾区', '1868');
INSERT INTO `wp_shop_nation` VALUES ('1872', '420304', '郧阳区', '1868');
INSERT INTO `wp_shop_nation` VALUES ('1873', '420322', '郧西县', '1868');
INSERT INTO `wp_shop_nation` VALUES ('1874', '420323', '竹山县', '1868');
INSERT INTO `wp_shop_nation` VALUES ('1875', '420324', '竹溪县', '1868');
INSERT INTO `wp_shop_nation` VALUES ('1876', '420325', '房县', '1868');
INSERT INTO `wp_shop_nation` VALUES ('1877', '420381', '丹江口市', '1868');
INSERT INTO `wp_shop_nation` VALUES ('1878', '420500', '宜昌市', '1844');
INSERT INTO `wp_shop_nation` VALUES ('1879', '420501', '市辖区', '1878');
INSERT INTO `wp_shop_nation` VALUES ('1880', '420502', '西陵区', '1878');
INSERT INTO `wp_shop_nation` VALUES ('1881', '420503', '伍家岗区', '1878');
INSERT INTO `wp_shop_nation` VALUES ('1882', '420504', '点军区', '1878');
INSERT INTO `wp_shop_nation` VALUES ('1883', '420505', '猇亭区', '1878');
INSERT INTO `wp_shop_nation` VALUES ('1884', '420506', '夷陵区', '1878');
INSERT INTO `wp_shop_nation` VALUES ('1885', '420525', '远安县', '1878');
INSERT INTO `wp_shop_nation` VALUES ('1886', '420526', '兴山县', '1878');
INSERT INTO `wp_shop_nation` VALUES ('1887', '420527', '秭归县', '1878');
INSERT INTO `wp_shop_nation` VALUES ('1888', '420528', '长阳土家族自治县', '1878');
INSERT INTO `wp_shop_nation` VALUES ('1889', '420529', '五峰土家族自治县', '1878');
INSERT INTO `wp_shop_nation` VALUES ('1890', '420581', '宜都市', '1878');
INSERT INTO `wp_shop_nation` VALUES ('1891', '420582', '当阳市', '1878');
INSERT INTO `wp_shop_nation` VALUES ('1892', '420583', '枝江市', '1878');
INSERT INTO `wp_shop_nation` VALUES ('1893', '420600', '襄阳市', '1844');
INSERT INTO `wp_shop_nation` VALUES ('1894', '420601', '市辖区', '1893');
INSERT INTO `wp_shop_nation` VALUES ('1895', '420602', '襄城区', '1893');
INSERT INTO `wp_shop_nation` VALUES ('1896', '420606', '樊城区', '1893');
INSERT INTO `wp_shop_nation` VALUES ('1897', '420607', '襄州区', '1893');
INSERT INTO `wp_shop_nation` VALUES ('1898', '420624', '南漳县', '1893');
INSERT INTO `wp_shop_nation` VALUES ('1899', '420625', '谷城县', '1893');
INSERT INTO `wp_shop_nation` VALUES ('1900', '420626', '保康县', '1893');
INSERT INTO `wp_shop_nation` VALUES ('1901', '420682', '老河口市', '1893');
INSERT INTO `wp_shop_nation` VALUES ('1902', '420683', '枣阳市', '1893');
INSERT INTO `wp_shop_nation` VALUES ('1903', '420684', '宜城市', '1893');
INSERT INTO `wp_shop_nation` VALUES ('1904', '420700', '鄂州市', '1844');
INSERT INTO `wp_shop_nation` VALUES ('1905', '420701', '市辖区', '1904');
INSERT INTO `wp_shop_nation` VALUES ('1906', '420702', '梁子湖区', '1904');
INSERT INTO `wp_shop_nation` VALUES ('1907', '420703', '华容区', '1904');
INSERT INTO `wp_shop_nation` VALUES ('1908', '420704', '鄂城区', '1904');
INSERT INTO `wp_shop_nation` VALUES ('1909', '420800', '荆门市', '1844');
INSERT INTO `wp_shop_nation` VALUES ('1910', '420801', '市辖区', '1909');
INSERT INTO `wp_shop_nation` VALUES ('1911', '420802', '东宝区', '1909');
INSERT INTO `wp_shop_nation` VALUES ('1912', '420804', '掇刀区', '1909');
INSERT INTO `wp_shop_nation` VALUES ('1913', '420821', '京山县', '1909');
INSERT INTO `wp_shop_nation` VALUES ('1914', '420822', '沙洋县', '1909');
INSERT INTO `wp_shop_nation` VALUES ('1915', '420881', '钟祥市', '1909');
INSERT INTO `wp_shop_nation` VALUES ('1916', '420900', '孝感市', '1844');
INSERT INTO `wp_shop_nation` VALUES ('1917', '420901', '市辖区', '1916');
INSERT INTO `wp_shop_nation` VALUES ('1918', '420902', '孝南区', '1916');
INSERT INTO `wp_shop_nation` VALUES ('1919', '420921', '孝昌县', '1916');
INSERT INTO `wp_shop_nation` VALUES ('1920', '420922', '大悟县', '1916');
INSERT INTO `wp_shop_nation` VALUES ('1921', '420923', '云梦县', '1916');
INSERT INTO `wp_shop_nation` VALUES ('1922', '420981', '应城市', '1916');
INSERT INTO `wp_shop_nation` VALUES ('1923', '420982', '安陆市', '1916');
INSERT INTO `wp_shop_nation` VALUES ('1924', '420984', '汉川市', '1916');
INSERT INTO `wp_shop_nation` VALUES ('1925', '421000', '荆州市', '1844');
INSERT INTO `wp_shop_nation` VALUES ('1926', '421001', '市辖区', '1925');
INSERT INTO `wp_shop_nation` VALUES ('1927', '421002', '沙市区', '1925');
INSERT INTO `wp_shop_nation` VALUES ('1928', '421003', '荆州区', '1925');
INSERT INTO `wp_shop_nation` VALUES ('1929', '421022', '公安县', '1925');
INSERT INTO `wp_shop_nation` VALUES ('1930', '421023', '监利县', '1925');
INSERT INTO `wp_shop_nation` VALUES ('1931', '421024', '江陵县', '1925');
INSERT INTO `wp_shop_nation` VALUES ('1932', '421081', '石首市', '1925');
INSERT INTO `wp_shop_nation` VALUES ('1933', '421083', '洪湖市', '1925');
INSERT INTO `wp_shop_nation` VALUES ('1934', '421087', '松滋市', '1925');
INSERT INTO `wp_shop_nation` VALUES ('1935', '421100', '黄冈市', '1844');
INSERT INTO `wp_shop_nation` VALUES ('1936', '421101', '市辖区', '1935');
INSERT INTO `wp_shop_nation` VALUES ('1937', '421102', '黄州区', '1935');
INSERT INTO `wp_shop_nation` VALUES ('1938', '421121', '团风县', '1935');
INSERT INTO `wp_shop_nation` VALUES ('1939', '421122', '红安县', '1935');
INSERT INTO `wp_shop_nation` VALUES ('1940', '421123', '罗田县', '1935');
INSERT INTO `wp_shop_nation` VALUES ('1941', '421124', '英山县', '1935');
INSERT INTO `wp_shop_nation` VALUES ('1942', '421125', '浠水县', '1935');
INSERT INTO `wp_shop_nation` VALUES ('1943', '421126', '蕲春县', '1935');
INSERT INTO `wp_shop_nation` VALUES ('1944', '421127', '黄梅县', '1935');
INSERT INTO `wp_shop_nation` VALUES ('1945', '421181', '麻城市', '1935');
INSERT INTO `wp_shop_nation` VALUES ('1946', '421182', '武穴市', '1935');
INSERT INTO `wp_shop_nation` VALUES ('1947', '421200', '咸宁市', '1844');
INSERT INTO `wp_shop_nation` VALUES ('1948', '421201', '市辖区', '1947');
INSERT INTO `wp_shop_nation` VALUES ('1949', '421202', '咸安区', '1947');
INSERT INTO `wp_shop_nation` VALUES ('1950', '421221', '嘉鱼县', '1947');
INSERT INTO `wp_shop_nation` VALUES ('1951', '421222', '通城县', '1947');
INSERT INTO `wp_shop_nation` VALUES ('1952', '421223', '崇阳县', '1947');
INSERT INTO `wp_shop_nation` VALUES ('1953', '421224', '通山县', '1947');
INSERT INTO `wp_shop_nation` VALUES ('1954', '421281', '赤壁市', '1947');
INSERT INTO `wp_shop_nation` VALUES ('1955', '421300', '随州市', '1844');
INSERT INTO `wp_shop_nation` VALUES ('1956', '421301', '市辖区', '1955');
INSERT INTO `wp_shop_nation` VALUES ('1957', '421303', '曾都区', '1955');
INSERT INTO `wp_shop_nation` VALUES ('1958', '421321', '随县', '1955');
INSERT INTO `wp_shop_nation` VALUES ('1959', '421381', '广水市', '1955');
INSERT INTO `wp_shop_nation` VALUES ('1960', '422800', '恩施土家族苗族自治州', '1844');
INSERT INTO `wp_shop_nation` VALUES ('1961', '422801', '恩施市', '1960');
INSERT INTO `wp_shop_nation` VALUES ('1962', '422802', '利川市', '1960');
INSERT INTO `wp_shop_nation` VALUES ('1963', '422822', '建始县', '1960');
INSERT INTO `wp_shop_nation` VALUES ('1964', '422823', '巴东县', '1960');
INSERT INTO `wp_shop_nation` VALUES ('1965', '422825', '宣恩县', '1960');
INSERT INTO `wp_shop_nation` VALUES ('1966', '422826', '咸丰县', '1960');
INSERT INTO `wp_shop_nation` VALUES ('1967', '422827', '来凤县', '1960');
INSERT INTO `wp_shop_nation` VALUES ('1968', '422828', '鹤峰县', '1960');
INSERT INTO `wp_shop_nation` VALUES ('1969', '429000', '省直辖县级行政区划', '1844');
INSERT INTO `wp_shop_nation` VALUES ('1970', '429004', '仙桃市', '1969');
INSERT INTO `wp_shop_nation` VALUES ('1971', '429005', '潜江市', '1969');
INSERT INTO `wp_shop_nation` VALUES ('1972', '429006', '天门市', '1969');
INSERT INTO `wp_shop_nation` VALUES ('1973', '429021', '神农架林区', '1969');
INSERT INTO `wp_shop_nation` VALUES ('1974', '430000', '湖南省', '0');
INSERT INTO `wp_shop_nation` VALUES ('1975', '430100', '长沙市', '1974');
INSERT INTO `wp_shop_nation` VALUES ('1976', '430101', '市辖区', '1975');
INSERT INTO `wp_shop_nation` VALUES ('1977', '430102', '芙蓉区', '1975');
INSERT INTO `wp_shop_nation` VALUES ('1978', '430103', '天心区', '1975');
INSERT INTO `wp_shop_nation` VALUES ('1979', '430104', '岳麓区', '1975');
INSERT INTO `wp_shop_nation` VALUES ('1980', '430105', '开福区', '1975');
INSERT INTO `wp_shop_nation` VALUES ('1981', '430111', '雨花区', '1975');
INSERT INTO `wp_shop_nation` VALUES ('1982', '430112', '望城区', '1975');
INSERT INTO `wp_shop_nation` VALUES ('1983', '430121', '长沙县', '1975');
INSERT INTO `wp_shop_nation` VALUES ('1984', '430124', '宁乡县', '1975');
INSERT INTO `wp_shop_nation` VALUES ('1985', '430181', '浏阳市', '1975');
INSERT INTO `wp_shop_nation` VALUES ('1986', '430200', '株洲市', '1974');
INSERT INTO `wp_shop_nation` VALUES ('1987', '430201', '市辖区', '1986');
INSERT INTO `wp_shop_nation` VALUES ('1988', '430202', '荷塘区', '1986');
INSERT INTO `wp_shop_nation` VALUES ('1989', '430203', '芦淞区', '1986');
INSERT INTO `wp_shop_nation` VALUES ('1990', '430204', '石峰区', '1986');
INSERT INTO `wp_shop_nation` VALUES ('1991', '430211', '天元区', '1986');
INSERT INTO `wp_shop_nation` VALUES ('1992', '430221', '株洲县', '1986');
INSERT INTO `wp_shop_nation` VALUES ('1993', '430223', '攸县', '1986');
INSERT INTO `wp_shop_nation` VALUES ('1994', '430224', '茶陵县', '1986');
INSERT INTO `wp_shop_nation` VALUES ('1995', '430225', '炎陵县', '1986');
INSERT INTO `wp_shop_nation` VALUES ('1996', '430281', '醴陵市', '1986');
INSERT INTO `wp_shop_nation` VALUES ('1997', '430300', '湘潭市', '1974');
INSERT INTO `wp_shop_nation` VALUES ('1998', '430301', '市辖区', '1997');
INSERT INTO `wp_shop_nation` VALUES ('1999', '430302', '雨湖区', '1997');
INSERT INTO `wp_shop_nation` VALUES ('2000', '430304', '岳塘区', '1997');
INSERT INTO `wp_shop_nation` VALUES ('2001', '430321', '湘潭县', '1997');
INSERT INTO `wp_shop_nation` VALUES ('2002', '430381', '湘乡市', '1997');
INSERT INTO `wp_shop_nation` VALUES ('2003', '430382', '韶山市', '1997');
INSERT INTO `wp_shop_nation` VALUES ('2004', '430400', '衡阳市', '1974');
INSERT INTO `wp_shop_nation` VALUES ('2005', '430401', '市辖区', '2004');
INSERT INTO `wp_shop_nation` VALUES ('2006', '430405', '珠晖区', '2004');
INSERT INTO `wp_shop_nation` VALUES ('2007', '430406', '雁峰区', '2004');
INSERT INTO `wp_shop_nation` VALUES ('2008', '430407', '石鼓区', '2004');
INSERT INTO `wp_shop_nation` VALUES ('2009', '430408', '蒸湘区', '2004');
INSERT INTO `wp_shop_nation` VALUES ('2010', '430412', '南岳区', '2004');
INSERT INTO `wp_shop_nation` VALUES ('2011', '430421', '衡阳县', '2004');
INSERT INTO `wp_shop_nation` VALUES ('2012', '430422', '衡南县', '2004');
INSERT INTO `wp_shop_nation` VALUES ('2013', '430423', '衡山县', '2004');
INSERT INTO `wp_shop_nation` VALUES ('2014', '430424', '衡东县', '2004');
INSERT INTO `wp_shop_nation` VALUES ('2015', '430426', '祁东县', '2004');
INSERT INTO `wp_shop_nation` VALUES ('2016', '430481', '耒阳市', '2004');
INSERT INTO `wp_shop_nation` VALUES ('2017', '430482', '常宁市', '2004');
INSERT INTO `wp_shop_nation` VALUES ('2018', '430500', '邵阳市', '1974');
INSERT INTO `wp_shop_nation` VALUES ('2019', '430501', '市辖区', '2018');
INSERT INTO `wp_shop_nation` VALUES ('2020', '430502', '双清区', '2018');
INSERT INTO `wp_shop_nation` VALUES ('2021', '430503', '大祥区', '2018');
INSERT INTO `wp_shop_nation` VALUES ('2022', '430511', '北塔区', '2018');
INSERT INTO `wp_shop_nation` VALUES ('2023', '430521', '邵东县', '2018');
INSERT INTO `wp_shop_nation` VALUES ('2024', '430522', '新邵县', '2018');
INSERT INTO `wp_shop_nation` VALUES ('2025', '430523', '邵阳县', '2018');
INSERT INTO `wp_shop_nation` VALUES ('2026', '430524', '隆回县', '2018');
INSERT INTO `wp_shop_nation` VALUES ('2027', '430525', '洞口县', '2018');
INSERT INTO `wp_shop_nation` VALUES ('2028', '430527', '绥宁县', '2018');
INSERT INTO `wp_shop_nation` VALUES ('2029', '430528', '新宁县', '2018');
INSERT INTO `wp_shop_nation` VALUES ('2030', '430529', '城步苗族自治县', '2018');
INSERT INTO `wp_shop_nation` VALUES ('2031', '430581', '武冈市', '2018');
INSERT INTO `wp_shop_nation` VALUES ('2032', '430600', '岳阳市', '1974');
INSERT INTO `wp_shop_nation` VALUES ('2033', '430601', '市辖区', '2032');
INSERT INTO `wp_shop_nation` VALUES ('2034', '430602', '岳阳楼区', '2032');
INSERT INTO `wp_shop_nation` VALUES ('2035', '430603', '云溪区', '2032');
INSERT INTO `wp_shop_nation` VALUES ('2036', '430611', '君山区', '2032');
INSERT INTO `wp_shop_nation` VALUES ('2037', '430621', '岳阳县', '2032');
INSERT INTO `wp_shop_nation` VALUES ('2038', '430623', '华容县', '2032');
INSERT INTO `wp_shop_nation` VALUES ('2039', '430624', '湘阴县', '2032');
INSERT INTO `wp_shop_nation` VALUES ('2040', '430626', '平江县', '2032');
INSERT INTO `wp_shop_nation` VALUES ('2041', '430681', '汨罗市', '2032');
INSERT INTO `wp_shop_nation` VALUES ('2042', '430682', '临湘市', '2032');
INSERT INTO `wp_shop_nation` VALUES ('2043', '430700', '常德市', '1974');
INSERT INTO `wp_shop_nation` VALUES ('2044', '430701', '市辖区', '2043');
INSERT INTO `wp_shop_nation` VALUES ('2045', '430702', '武陵区', '2043');
INSERT INTO `wp_shop_nation` VALUES ('2046', '430703', '鼎城区', '2043');
INSERT INTO `wp_shop_nation` VALUES ('2047', '430721', '安乡县', '2043');
INSERT INTO `wp_shop_nation` VALUES ('2048', '430722', '汉寿县', '2043');
INSERT INTO `wp_shop_nation` VALUES ('2049', '430723', '澧县', '2043');
INSERT INTO `wp_shop_nation` VALUES ('2050', '430724', '临澧县', '2043');
INSERT INTO `wp_shop_nation` VALUES ('2051', '430725', '桃源县', '2043');
INSERT INTO `wp_shop_nation` VALUES ('2052', '430726', '石门县', '2043');
INSERT INTO `wp_shop_nation` VALUES ('2053', '430781', '津市市', '2043');
INSERT INTO `wp_shop_nation` VALUES ('2054', '430800', '张家界市', '1974');
INSERT INTO `wp_shop_nation` VALUES ('2055', '430801', '市辖区', '2054');
INSERT INTO `wp_shop_nation` VALUES ('2056', '430802', '永定区', '2054');
INSERT INTO `wp_shop_nation` VALUES ('2057', '430811', '武陵源区', '2054');
INSERT INTO `wp_shop_nation` VALUES ('2058', '430821', '慈利县', '2054');
INSERT INTO `wp_shop_nation` VALUES ('2059', '430822', '桑植县', '2054');
INSERT INTO `wp_shop_nation` VALUES ('2060', '430900', '益阳市', '1974');
INSERT INTO `wp_shop_nation` VALUES ('2061', '430901', '市辖区', '2060');
INSERT INTO `wp_shop_nation` VALUES ('2062', '430902', '资阳区', '2060');
INSERT INTO `wp_shop_nation` VALUES ('2063', '430903', '赫山区', '2060');
INSERT INTO `wp_shop_nation` VALUES ('2064', '430921', '南县', '2060');
INSERT INTO `wp_shop_nation` VALUES ('2065', '430922', '桃江县', '2060');
INSERT INTO `wp_shop_nation` VALUES ('2066', '430923', '安化县', '2060');
INSERT INTO `wp_shop_nation` VALUES ('2067', '430981', '沅江市', '2060');
INSERT INTO `wp_shop_nation` VALUES ('2068', '431000', '郴州市', '1974');
INSERT INTO `wp_shop_nation` VALUES ('2069', '431001', '市辖区', '2068');
INSERT INTO `wp_shop_nation` VALUES ('2070', '431002', '北湖区', '2068');
INSERT INTO `wp_shop_nation` VALUES ('2071', '431003', '苏仙区', '2068');
INSERT INTO `wp_shop_nation` VALUES ('2072', '431021', '桂阳县', '2068');
INSERT INTO `wp_shop_nation` VALUES ('2073', '431022', '宜章县', '2068');
INSERT INTO `wp_shop_nation` VALUES ('2074', '431023', '永兴县', '2068');
INSERT INTO `wp_shop_nation` VALUES ('2075', '431024', '嘉禾县', '2068');
INSERT INTO `wp_shop_nation` VALUES ('2076', '431025', '临武县', '2068');
INSERT INTO `wp_shop_nation` VALUES ('2077', '431026', '汝城县', '2068');
INSERT INTO `wp_shop_nation` VALUES ('2078', '431027', '桂东县', '2068');
INSERT INTO `wp_shop_nation` VALUES ('2079', '431028', '安仁县', '2068');
INSERT INTO `wp_shop_nation` VALUES ('2080', '431081', '资兴市', '2068');
INSERT INTO `wp_shop_nation` VALUES ('2081', '431100', '永州市', '1974');
INSERT INTO `wp_shop_nation` VALUES ('2082', '431101', '市辖区', '2081');
INSERT INTO `wp_shop_nation` VALUES ('2083', '431102', '零陵区', '2081');
INSERT INTO `wp_shop_nation` VALUES ('2084', '431103', '冷水滩区', '2081');
INSERT INTO `wp_shop_nation` VALUES ('2085', '431121', '祁阳县', '2081');
INSERT INTO `wp_shop_nation` VALUES ('2086', '431122', '东安县', '2081');
INSERT INTO `wp_shop_nation` VALUES ('2087', '431123', '双牌县', '2081');
INSERT INTO `wp_shop_nation` VALUES ('2088', '431124', '道县', '2081');
INSERT INTO `wp_shop_nation` VALUES ('2089', '431125', '江永县', '2081');
INSERT INTO `wp_shop_nation` VALUES ('2090', '431126', '宁远县', '2081');
INSERT INTO `wp_shop_nation` VALUES ('2091', '431127', '蓝山县', '2081');
INSERT INTO `wp_shop_nation` VALUES ('2092', '431128', '新田县', '2081');
INSERT INTO `wp_shop_nation` VALUES ('2093', '431129', '江华瑶族自治县', '2081');
INSERT INTO `wp_shop_nation` VALUES ('2094', '431200', '怀化市', '1974');
INSERT INTO `wp_shop_nation` VALUES ('2095', '431201', '市辖区', '2094');
INSERT INTO `wp_shop_nation` VALUES ('2096', '431202', '鹤城区', '2094');
INSERT INTO `wp_shop_nation` VALUES ('2097', '431221', '中方县', '2094');
INSERT INTO `wp_shop_nation` VALUES ('2098', '431222', '沅陵县', '2094');
INSERT INTO `wp_shop_nation` VALUES ('2099', '431223', '辰溪县', '2094');
INSERT INTO `wp_shop_nation` VALUES ('2100', '431224', '溆浦县', '2094');
INSERT INTO `wp_shop_nation` VALUES ('2101', '431225', '会同县', '2094');
INSERT INTO `wp_shop_nation` VALUES ('2102', '431226', '麻阳苗族自治县', '2094');
INSERT INTO `wp_shop_nation` VALUES ('2103', '431227', '新晃侗族自治县', '2094');
INSERT INTO `wp_shop_nation` VALUES ('2104', '431228', '芷江侗族自治县', '2094');
INSERT INTO `wp_shop_nation` VALUES ('2105', '431229', '靖州苗族侗族自治县', '2094');
INSERT INTO `wp_shop_nation` VALUES ('2106', '431230', '通道侗族自治县', '2094');
INSERT INTO `wp_shop_nation` VALUES ('2107', '431281', '洪江市', '2094');
INSERT INTO `wp_shop_nation` VALUES ('2108', '431300', '娄底市', '1974');
INSERT INTO `wp_shop_nation` VALUES ('2109', '431301', '市辖区', '2108');
INSERT INTO `wp_shop_nation` VALUES ('2110', '431302', '娄星区', '2108');
INSERT INTO `wp_shop_nation` VALUES ('2111', '431321', '双峰县', '2108');
INSERT INTO `wp_shop_nation` VALUES ('2112', '431322', '新化县', '2108');
INSERT INTO `wp_shop_nation` VALUES ('2113', '431381', '冷水江市', '2108');
INSERT INTO `wp_shop_nation` VALUES ('2114', '431382', '涟源市', '2108');
INSERT INTO `wp_shop_nation` VALUES ('2115', '433100', '湘西土家族苗族自治州', '1974');
INSERT INTO `wp_shop_nation` VALUES ('2116', '433101', '吉首市', '2115');
INSERT INTO `wp_shop_nation` VALUES ('2117', '433122', '泸溪县', '2115');
INSERT INTO `wp_shop_nation` VALUES ('2118', '433123', '凤凰县', '2115');
INSERT INTO `wp_shop_nation` VALUES ('2119', '433124', '花垣县', '2115');
INSERT INTO `wp_shop_nation` VALUES ('2120', '433125', '保靖县', '2115');
INSERT INTO `wp_shop_nation` VALUES ('2121', '433126', '古丈县', '2115');
INSERT INTO `wp_shop_nation` VALUES ('2122', '433127', '永顺县', '2115');
INSERT INTO `wp_shop_nation` VALUES ('2123', '433130', '龙山县', '2115');
INSERT INTO `wp_shop_nation` VALUES ('2124', '440000', '广东省', '0');
INSERT INTO `wp_shop_nation` VALUES ('2125', '440100', '广州市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2126', '440101', '市辖区', '2125');
INSERT INTO `wp_shop_nation` VALUES ('2127', '440103', '荔湾区', '2125');
INSERT INTO `wp_shop_nation` VALUES ('2128', '440104', '越秀区', '2125');
INSERT INTO `wp_shop_nation` VALUES ('2129', '440105', '海珠区', '2125');
INSERT INTO `wp_shop_nation` VALUES ('2130', '440106', '天河区', '2125');
INSERT INTO `wp_shop_nation` VALUES ('2131', '440111', '白云区', '2125');
INSERT INTO `wp_shop_nation` VALUES ('2132', '440112', '黄埔区', '2125');
INSERT INTO `wp_shop_nation` VALUES ('2133', '440113', '番禺区', '2125');
INSERT INTO `wp_shop_nation` VALUES ('2134', '440114', '花都区', '2125');
INSERT INTO `wp_shop_nation` VALUES ('2135', '440115', '南沙区', '2125');
INSERT INTO `wp_shop_nation` VALUES ('2136', '440117', '从化区', '2125');
INSERT INTO `wp_shop_nation` VALUES ('2137', '440118', '增城区', '2125');
INSERT INTO `wp_shop_nation` VALUES ('2138', '440200', '韶关市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2139', '440201', '市辖区', '2138');
INSERT INTO `wp_shop_nation` VALUES ('2140', '440203', '武江区', '2138');
INSERT INTO `wp_shop_nation` VALUES ('2141', '440204', '浈江区', '2138');
INSERT INTO `wp_shop_nation` VALUES ('2142', '440205', '曲江区', '2138');
INSERT INTO `wp_shop_nation` VALUES ('2143', '440222', '始兴县', '2138');
INSERT INTO `wp_shop_nation` VALUES ('2144', '440224', '仁化县', '2138');
INSERT INTO `wp_shop_nation` VALUES ('2145', '440229', '翁源县', '2138');
INSERT INTO `wp_shop_nation` VALUES ('2146', '440232', '乳源瑶族自治县', '2138');
INSERT INTO `wp_shop_nation` VALUES ('2147', '440233', '新丰县', '2138');
INSERT INTO `wp_shop_nation` VALUES ('2148', '440281', '乐昌市', '2138');
INSERT INTO `wp_shop_nation` VALUES ('2149', '440282', '南雄市', '2138');
INSERT INTO `wp_shop_nation` VALUES ('2150', '440300', '深圳市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2151', '440301', '市辖区', '2150');
INSERT INTO `wp_shop_nation` VALUES ('2152', '440303', '罗湖区', '2150');
INSERT INTO `wp_shop_nation` VALUES ('2153', '440304', '福田区', '2150');
INSERT INTO `wp_shop_nation` VALUES ('2154', '440305', '南山区', '2150');
INSERT INTO `wp_shop_nation` VALUES ('2155', '440306', '宝安区', '2150');
INSERT INTO `wp_shop_nation` VALUES ('2156', '440307', '龙岗区', '2150');
INSERT INTO `wp_shop_nation` VALUES ('2157', '440308', '盐田区', '2150');
INSERT INTO `wp_shop_nation` VALUES ('2158', '440400', '珠海市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2159', '440401', '市辖区', '2158');
INSERT INTO `wp_shop_nation` VALUES ('2160', '440402', '香洲区', '2158');
INSERT INTO `wp_shop_nation` VALUES ('2161', '440403', '斗门区', '2158');
INSERT INTO `wp_shop_nation` VALUES ('2162', '440404', '金湾区', '2158');
INSERT INTO `wp_shop_nation` VALUES ('2163', '440500', '汕头市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2164', '440501', '市辖区', '2163');
INSERT INTO `wp_shop_nation` VALUES ('2165', '440507', '龙湖区', '2163');
INSERT INTO `wp_shop_nation` VALUES ('2166', '440511', '金平区', '2163');
INSERT INTO `wp_shop_nation` VALUES ('2167', '440512', '濠江区', '2163');
INSERT INTO `wp_shop_nation` VALUES ('2168', '440513', '潮阳区', '2163');
INSERT INTO `wp_shop_nation` VALUES ('2169', '440514', '潮南区', '2163');
INSERT INTO `wp_shop_nation` VALUES ('2170', '440515', '澄海区', '2163');
INSERT INTO `wp_shop_nation` VALUES ('2171', '440523', '南澳县', '2163');
INSERT INTO `wp_shop_nation` VALUES ('2172', '440600', '佛山市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2173', '440601', '市辖区', '2172');
INSERT INTO `wp_shop_nation` VALUES ('2174', '440604', '禅城区', '2172');
INSERT INTO `wp_shop_nation` VALUES ('2175', '440605', '南海区', '2172');
INSERT INTO `wp_shop_nation` VALUES ('2176', '440606', '顺德区', '2172');
INSERT INTO `wp_shop_nation` VALUES ('2177', '440607', '三水区', '2172');
INSERT INTO `wp_shop_nation` VALUES ('2178', '440608', '高明区', '2172');
INSERT INTO `wp_shop_nation` VALUES ('2179', '440700', '江门市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2180', '440701', '市辖区', '2179');
INSERT INTO `wp_shop_nation` VALUES ('2181', '440703', '蓬江区', '2179');
INSERT INTO `wp_shop_nation` VALUES ('2182', '440704', '江海区', '2179');
INSERT INTO `wp_shop_nation` VALUES ('2183', '440705', '新会区', '2179');
INSERT INTO `wp_shop_nation` VALUES ('2184', '440781', '台山市', '2179');
INSERT INTO `wp_shop_nation` VALUES ('2185', '440783', '开平市', '2179');
INSERT INTO `wp_shop_nation` VALUES ('2186', '440784', '鹤山市', '2179');
INSERT INTO `wp_shop_nation` VALUES ('2187', '440785', '恩平市', '2179');
INSERT INTO `wp_shop_nation` VALUES ('2188', '440800', '湛江市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2189', '440801', '市辖区', '2188');
INSERT INTO `wp_shop_nation` VALUES ('2190', '440802', '赤坎区', '2188');
INSERT INTO `wp_shop_nation` VALUES ('2191', '440803', '霞山区', '2188');
INSERT INTO `wp_shop_nation` VALUES ('2192', '440804', '坡头区', '2188');
INSERT INTO `wp_shop_nation` VALUES ('2193', '440811', '麻章区', '2188');
INSERT INTO `wp_shop_nation` VALUES ('2194', '440823', '遂溪县', '2188');
INSERT INTO `wp_shop_nation` VALUES ('2195', '440825', '徐闻县', '2188');
INSERT INTO `wp_shop_nation` VALUES ('2196', '440881', '廉江市', '2188');
INSERT INTO `wp_shop_nation` VALUES ('2197', '440882', '雷州市', '2188');
INSERT INTO `wp_shop_nation` VALUES ('2198', '440883', '吴川市', '2188');
INSERT INTO `wp_shop_nation` VALUES ('2199', '440900', '茂名市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2200', '440901', '市辖区', '2199');
INSERT INTO `wp_shop_nation` VALUES ('2201', '440902', '茂南区', '2199');
INSERT INTO `wp_shop_nation` VALUES ('2202', '440904', '电白区', '2199');
INSERT INTO `wp_shop_nation` VALUES ('2203', '440981', '高州市', '2199');
INSERT INTO `wp_shop_nation` VALUES ('2204', '440982', '化州市', '2199');
INSERT INTO `wp_shop_nation` VALUES ('2205', '440983', '信宜市', '2199');
INSERT INTO `wp_shop_nation` VALUES ('2206', '441200', '肇庆市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2207', '441201', '市辖区', '2206');
INSERT INTO `wp_shop_nation` VALUES ('2208', '441202', '端州区', '2206');
INSERT INTO `wp_shop_nation` VALUES ('2209', '441203', '鼎湖区', '2206');
INSERT INTO `wp_shop_nation` VALUES ('2210', '441223', '广宁县', '2206');
INSERT INTO `wp_shop_nation` VALUES ('2211', '441224', '怀集县', '2206');
INSERT INTO `wp_shop_nation` VALUES ('2212', '441225', '封开县', '2206');
INSERT INTO `wp_shop_nation` VALUES ('2213', '441226', '德庆县', '2206');
INSERT INTO `wp_shop_nation` VALUES ('2214', '441283', '高要市', '2206');
INSERT INTO `wp_shop_nation` VALUES ('2215', '441284', '四会市', '2206');
INSERT INTO `wp_shop_nation` VALUES ('2216', '441300', '惠州市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2217', '441301', '市辖区', '2216');
INSERT INTO `wp_shop_nation` VALUES ('2218', '441302', '惠城区', '2216');
INSERT INTO `wp_shop_nation` VALUES ('2219', '441303', '惠阳区', '2216');
INSERT INTO `wp_shop_nation` VALUES ('2220', '441322', '博罗县', '2216');
INSERT INTO `wp_shop_nation` VALUES ('2221', '441323', '惠东县', '2216');
INSERT INTO `wp_shop_nation` VALUES ('2222', '441324', '龙门县', '2216');
INSERT INTO `wp_shop_nation` VALUES ('2223', '441400', '梅州市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2224', '441401', '市辖区', '2223');
INSERT INTO `wp_shop_nation` VALUES ('2225', '441402', '梅江区', '2223');
INSERT INTO `wp_shop_nation` VALUES ('2226', '441403', '梅县区', '2223');
INSERT INTO `wp_shop_nation` VALUES ('2227', '441422', '大埔县', '2223');
INSERT INTO `wp_shop_nation` VALUES ('2228', '441423', '丰顺县', '2223');
INSERT INTO `wp_shop_nation` VALUES ('2229', '441424', '五华县', '2223');
INSERT INTO `wp_shop_nation` VALUES ('2230', '441426', '平远县', '2223');
INSERT INTO `wp_shop_nation` VALUES ('2231', '441427', '蕉岭县', '2223');
INSERT INTO `wp_shop_nation` VALUES ('2232', '441481', '兴宁市', '2223');
INSERT INTO `wp_shop_nation` VALUES ('2233', '441500', '汕尾市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2234', '441501', '市辖区', '2233');
INSERT INTO `wp_shop_nation` VALUES ('2235', '441502', '城区', '2233');
INSERT INTO `wp_shop_nation` VALUES ('2236', '441521', '海丰县', '2233');
INSERT INTO `wp_shop_nation` VALUES ('2237', '441523', '陆河县', '2233');
INSERT INTO `wp_shop_nation` VALUES ('2238', '441581', '陆丰市', '2233');
INSERT INTO `wp_shop_nation` VALUES ('2239', '441600', '河源市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2240', '441601', '市辖区', '2239');
INSERT INTO `wp_shop_nation` VALUES ('2241', '441602', '源城区', '2239');
INSERT INTO `wp_shop_nation` VALUES ('2242', '441621', '紫金县', '2239');
INSERT INTO `wp_shop_nation` VALUES ('2243', '441622', '龙川县', '2239');
INSERT INTO `wp_shop_nation` VALUES ('2244', '441623', '连平县', '2239');
INSERT INTO `wp_shop_nation` VALUES ('2245', '441624', '和平县', '2239');
INSERT INTO `wp_shop_nation` VALUES ('2246', '441625', '东源县', '2239');
INSERT INTO `wp_shop_nation` VALUES ('2247', '441700', '阳江市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2248', '441701', '市辖区', '2247');
INSERT INTO `wp_shop_nation` VALUES ('2249', '441702', '江城区', '2247');
INSERT INTO `wp_shop_nation` VALUES ('2250', '441704', '阳东区', '2247');
INSERT INTO `wp_shop_nation` VALUES ('2251', '441721', '阳西县', '2247');
INSERT INTO `wp_shop_nation` VALUES ('2252', '441781', '阳春市', '2247');
INSERT INTO `wp_shop_nation` VALUES ('2253', '441800', '清远市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2254', '441801', '市辖区', '2253');
INSERT INTO `wp_shop_nation` VALUES ('2255', '441802', '清城区', '2253');
INSERT INTO `wp_shop_nation` VALUES ('2256', '441803', '清新区', '2253');
INSERT INTO `wp_shop_nation` VALUES ('2257', '441821', '佛冈县', '2253');
INSERT INTO `wp_shop_nation` VALUES ('2258', '441823', '阳山县', '2253');
INSERT INTO `wp_shop_nation` VALUES ('2259', '441825', '连山壮族瑶族自治县', '2253');
INSERT INTO `wp_shop_nation` VALUES ('2260', '441826', '连南瑶族自治县', '2253');
INSERT INTO `wp_shop_nation` VALUES ('2261', '441881', '英德市', '2253');
INSERT INTO `wp_shop_nation` VALUES ('2262', '441882', '连州市', '2253');
INSERT INTO `wp_shop_nation` VALUES ('2263', '441900', '东莞市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2264', '442000', '中山市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2265', '445100', '潮州市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2266', '445101', '市辖区', '2265');
INSERT INTO `wp_shop_nation` VALUES ('2267', '445102', '湘桥区', '2265');
INSERT INTO `wp_shop_nation` VALUES ('2268', '445103', '潮安区', '2265');
INSERT INTO `wp_shop_nation` VALUES ('2269', '445122', '饶平县', '2265');
INSERT INTO `wp_shop_nation` VALUES ('2270', '445200', '揭阳市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2271', '445201', '市辖区', '2270');
INSERT INTO `wp_shop_nation` VALUES ('2272', '445202', '榕城区', '2270');
INSERT INTO `wp_shop_nation` VALUES ('2273', '445203', '揭东区', '2270');
INSERT INTO `wp_shop_nation` VALUES ('2274', '445222', '揭西县', '2270');
INSERT INTO `wp_shop_nation` VALUES ('2275', '445224', '惠来县', '2270');
INSERT INTO `wp_shop_nation` VALUES ('2276', '445281', '普宁市', '2270');
INSERT INTO `wp_shop_nation` VALUES ('2277', '445300', '云浮市', '2124');
INSERT INTO `wp_shop_nation` VALUES ('2278', '445301', '市辖区', '2277');
INSERT INTO `wp_shop_nation` VALUES ('2279', '445302', '云城区', '2277');
INSERT INTO `wp_shop_nation` VALUES ('2280', '445303', '云安区', '2277');
INSERT INTO `wp_shop_nation` VALUES ('2281', '445321', '新兴县', '2277');
INSERT INTO `wp_shop_nation` VALUES ('2282', '445322', '郁南县', '2277');
INSERT INTO `wp_shop_nation` VALUES ('2283', '445381', '罗定市', '2277');
INSERT INTO `wp_shop_nation` VALUES ('2284', '450000', '广西壮族自治区', '0');
INSERT INTO `wp_shop_nation` VALUES ('2285', '450100', '南宁市', '2284');
INSERT INTO `wp_shop_nation` VALUES ('2286', '450101', '市辖区', '2285');
INSERT INTO `wp_shop_nation` VALUES ('2287', '450102', '兴宁区', '2285');
INSERT INTO `wp_shop_nation` VALUES ('2288', '450103', '青秀区', '2285');
INSERT INTO `wp_shop_nation` VALUES ('2289', '450105', '江南区', '2285');
INSERT INTO `wp_shop_nation` VALUES ('2290', '450107', '西乡塘区', '2285');
INSERT INTO `wp_shop_nation` VALUES ('2291', '450108', '良庆区', '2285');
INSERT INTO `wp_shop_nation` VALUES ('2292', '450109', '邕宁区', '2285');
INSERT INTO `wp_shop_nation` VALUES ('2293', '450122', '武鸣县', '2285');
INSERT INTO `wp_shop_nation` VALUES ('2294', '450123', '隆安县', '2285');
INSERT INTO `wp_shop_nation` VALUES ('2295', '450124', '马山县', '2285');
INSERT INTO `wp_shop_nation` VALUES ('2296', '450125', '上林县', '2285');
INSERT INTO `wp_shop_nation` VALUES ('2297', '450126', '宾阳县', '2285');
INSERT INTO `wp_shop_nation` VALUES ('2298', '450127', '横县', '2285');
INSERT INTO `wp_shop_nation` VALUES ('2299', '450200', '柳州市', '2284');
INSERT INTO `wp_shop_nation` VALUES ('2300', '450201', '市辖区', '2299');
INSERT INTO `wp_shop_nation` VALUES ('2301', '450202', '城中区', '2299');
INSERT INTO `wp_shop_nation` VALUES ('2302', '450203', '鱼峰区', '2299');
INSERT INTO `wp_shop_nation` VALUES ('2303', '450204', '柳南区', '2299');
INSERT INTO `wp_shop_nation` VALUES ('2304', '450205', '柳北区', '2299');
INSERT INTO `wp_shop_nation` VALUES ('2305', '450221', '柳江县', '2299');
INSERT INTO `wp_shop_nation` VALUES ('2306', '450222', '柳城县', '2299');
INSERT INTO `wp_shop_nation` VALUES ('2307', '450223', '鹿寨县', '2299');
INSERT INTO `wp_shop_nation` VALUES ('2308', '450224', '融安县', '2299');
INSERT INTO `wp_shop_nation` VALUES ('2309', '450225', '融水苗族自治县', '2299');
INSERT INTO `wp_shop_nation` VALUES ('2310', '450226', '三江侗族自治县', '2299');
INSERT INTO `wp_shop_nation` VALUES ('2311', '450300', '桂林市', '2284');
INSERT INTO `wp_shop_nation` VALUES ('2312', '450301', '市辖区', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2313', '450302', '秀峰区', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2314', '450303', '叠彩区', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2315', '450304', '象山区', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2316', '450305', '七星区', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2317', '450311', '雁山区', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2318', '450312', '临桂区', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2319', '450321', '阳朔县', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2320', '450323', '灵川县', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2321', '450324', '全州县', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2322', '450325', '兴安县', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2323', '450326', '永福县', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2324', '450327', '灌阳县', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2325', '450328', '龙胜各族自治县', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2326', '450329', '资源县', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2327', '450330', '平乐县', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2328', '450331', '荔浦县', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2329', '450332', '恭城瑶族自治县', '2311');
INSERT INTO `wp_shop_nation` VALUES ('2330', '450400', '梧州市', '2284');
INSERT INTO `wp_shop_nation` VALUES ('2331', '450401', '市辖区', '2330');
INSERT INTO `wp_shop_nation` VALUES ('2332', '450403', '万秀区', '2330');
INSERT INTO `wp_shop_nation` VALUES ('2333', '450405', '长洲区', '2330');
INSERT INTO `wp_shop_nation` VALUES ('2334', '450406', '龙圩区', '2330');
INSERT INTO `wp_shop_nation` VALUES ('2335', '450421', '苍梧县', '2330');
INSERT INTO `wp_shop_nation` VALUES ('2336', '450422', '藤县', '2330');
INSERT INTO `wp_shop_nation` VALUES ('2337', '450423', '蒙山县', '2330');
INSERT INTO `wp_shop_nation` VALUES ('2338', '450481', '岑溪市', '2330');
INSERT INTO `wp_shop_nation` VALUES ('2339', '450500', '北海市', '2284');
INSERT INTO `wp_shop_nation` VALUES ('2340', '450501', '市辖区', '2339');
INSERT INTO `wp_shop_nation` VALUES ('2341', '450502', '海城区', '2339');
INSERT INTO `wp_shop_nation` VALUES ('2342', '450503', '银海区', '2339');
INSERT INTO `wp_shop_nation` VALUES ('2343', '450512', '铁山港区', '2339');
INSERT INTO `wp_shop_nation` VALUES ('2344', '450521', '合浦县', '2339');
INSERT INTO `wp_shop_nation` VALUES ('2345', '450600', '防城港市', '2284');
INSERT INTO `wp_shop_nation` VALUES ('2346', '450601', '市辖区', '2345');
INSERT INTO `wp_shop_nation` VALUES ('2347', '450602', '港口区', '2345');
INSERT INTO `wp_shop_nation` VALUES ('2348', '450603', '防城区', '2345');
INSERT INTO `wp_shop_nation` VALUES ('2349', '450621', '上思县', '2345');
INSERT INTO `wp_shop_nation` VALUES ('2350', '450681', '东兴市', '2345');
INSERT INTO `wp_shop_nation` VALUES ('2351', '450700', '钦州市', '2284');
INSERT INTO `wp_shop_nation` VALUES ('2352', '450701', '市辖区', '2351');
INSERT INTO `wp_shop_nation` VALUES ('2353', '450702', '钦南区', '2351');
INSERT INTO `wp_shop_nation` VALUES ('2354', '450703', '钦北区', '2351');
INSERT INTO `wp_shop_nation` VALUES ('2355', '450721', '灵山县', '2351');
INSERT INTO `wp_shop_nation` VALUES ('2356', '450722', '浦北县', '2351');
INSERT INTO `wp_shop_nation` VALUES ('2357', '450800', '贵港市', '2284');
INSERT INTO `wp_shop_nation` VALUES ('2358', '450801', '市辖区', '2357');
INSERT INTO `wp_shop_nation` VALUES ('2359', '450802', '港北区', '2357');
INSERT INTO `wp_shop_nation` VALUES ('2360', '450803', '港南区', '2357');
INSERT INTO `wp_shop_nation` VALUES ('2361', '450804', '覃塘区', '2357');
INSERT INTO `wp_shop_nation` VALUES ('2362', '450821', '平南县', '2357');
INSERT INTO `wp_shop_nation` VALUES ('2363', '450881', '桂平市', '2357');
INSERT INTO `wp_shop_nation` VALUES ('2364', '450900', '玉林市', '2284');
INSERT INTO `wp_shop_nation` VALUES ('2365', '450901', '市辖区', '2364');
INSERT INTO `wp_shop_nation` VALUES ('2366', '450902', '玉州区', '2364');
INSERT INTO `wp_shop_nation` VALUES ('2367', '450903', '福绵区', '2364');
INSERT INTO `wp_shop_nation` VALUES ('2368', '450921', '容县', '2364');
INSERT INTO `wp_shop_nation` VALUES ('2369', '450922', '陆川县', '2364');
INSERT INTO `wp_shop_nation` VALUES ('2370', '450923', '博白县', '2364');
INSERT INTO `wp_shop_nation` VALUES ('2371', '450924', '兴业县', '2364');
INSERT INTO `wp_shop_nation` VALUES ('2372', '450981', '北流市', '2364');
INSERT INTO `wp_shop_nation` VALUES ('2373', '451000', '百色市', '2284');
INSERT INTO `wp_shop_nation` VALUES ('2374', '451001', '市辖区', '2373');
INSERT INTO `wp_shop_nation` VALUES ('2375', '451002', '右江区', '2373');
INSERT INTO `wp_shop_nation` VALUES ('2376', '451021', '田阳县', '2373');
INSERT INTO `wp_shop_nation` VALUES ('2377', '451022', '田东县', '2373');
INSERT INTO `wp_shop_nation` VALUES ('2378', '451023', '平果县', '2373');
INSERT INTO `wp_shop_nation` VALUES ('2379', '451024', '德保县', '2373');
INSERT INTO `wp_shop_nation` VALUES ('2380', '451025', '靖西县', '2373');
INSERT INTO `wp_shop_nation` VALUES ('2381', '451026', '那坡县', '2373');
INSERT INTO `wp_shop_nation` VALUES ('2382', '451027', '凌云县', '2373');
INSERT INTO `wp_shop_nation` VALUES ('2383', '451028', '乐业县', '2373');
INSERT INTO `wp_shop_nation` VALUES ('2384', '451029', '田林县', '2373');
INSERT INTO `wp_shop_nation` VALUES ('2385', '451030', '西林县', '2373');
INSERT INTO `wp_shop_nation` VALUES ('2386', '451031', '隆林各族自治县', '2373');
INSERT INTO `wp_shop_nation` VALUES ('2387', '451100', '贺州市', '2284');
INSERT INTO `wp_shop_nation` VALUES ('2388', '451101', '市辖区', '2387');
INSERT INTO `wp_shop_nation` VALUES ('2389', '451102', '八步区', '2387');
INSERT INTO `wp_shop_nation` VALUES ('2390', '451119', '平桂管理区', '2387');
INSERT INTO `wp_shop_nation` VALUES ('2391', '451121', '昭平县', '2387');
INSERT INTO `wp_shop_nation` VALUES ('2392', '451122', '钟山县', '2387');
INSERT INTO `wp_shop_nation` VALUES ('2393', '451123', '富川瑶族自治县', '2387');
INSERT INTO `wp_shop_nation` VALUES ('2394', '451200', '河池市', '2284');
INSERT INTO `wp_shop_nation` VALUES ('2395', '451201', '市辖区', '2394');
INSERT INTO `wp_shop_nation` VALUES ('2396', '451202', '金城江区', '2394');
INSERT INTO `wp_shop_nation` VALUES ('2397', '451221', '南丹县', '2394');
INSERT INTO `wp_shop_nation` VALUES ('2398', '451222', '天峨县', '2394');
INSERT INTO `wp_shop_nation` VALUES ('2399', '451223', '凤山县', '2394');
INSERT INTO `wp_shop_nation` VALUES ('2400', '451224', '东兰县', '2394');
INSERT INTO `wp_shop_nation` VALUES ('2401', '451225', '罗城仫佬族自治县', '2394');
INSERT INTO `wp_shop_nation` VALUES ('2402', '451226', '环江毛南族自治县', '2394');
INSERT INTO `wp_shop_nation` VALUES ('2403', '451227', '巴马瑶族自治县', '2394');
INSERT INTO `wp_shop_nation` VALUES ('2404', '451228', '都安瑶族自治县', '2394');
INSERT INTO `wp_shop_nation` VALUES ('2405', '451229', '大化瑶族自治县', '2394');
INSERT INTO `wp_shop_nation` VALUES ('2406', '451281', '宜州市', '2394');
INSERT INTO `wp_shop_nation` VALUES ('2407', '451300', '来宾市', '2284');
INSERT INTO `wp_shop_nation` VALUES ('2408', '451301', '市辖区', '2407');
INSERT INTO `wp_shop_nation` VALUES ('2409', '451302', '兴宾区', '2407');
INSERT INTO `wp_shop_nation` VALUES ('2410', '451321', '忻城县', '2407');
INSERT INTO `wp_shop_nation` VALUES ('2411', '451322', '象州县', '2407');
INSERT INTO `wp_shop_nation` VALUES ('2412', '451323', '武宣县', '2407');
INSERT INTO `wp_shop_nation` VALUES ('2413', '451324', '金秀瑶族自治县', '2407');
INSERT INTO `wp_shop_nation` VALUES ('2414', '451381', '合山市', '2407');
INSERT INTO `wp_shop_nation` VALUES ('2415', '451400', '崇左市', '2284');
INSERT INTO `wp_shop_nation` VALUES ('2416', '451401', '市辖区', '2415');
INSERT INTO `wp_shop_nation` VALUES ('2417', '451402', '江州区', '2415');
INSERT INTO `wp_shop_nation` VALUES ('2418', '451421', '扶绥县', '2415');
INSERT INTO `wp_shop_nation` VALUES ('2419', '451422', '宁明县', '2415');
INSERT INTO `wp_shop_nation` VALUES ('2420', '451423', '龙州县', '2415');
INSERT INTO `wp_shop_nation` VALUES ('2421', '451424', '大新县', '2415');
INSERT INTO `wp_shop_nation` VALUES ('2422', '451425', '天等县', '2415');
INSERT INTO `wp_shop_nation` VALUES ('2423', '451481', '凭祥市', '2415');
INSERT INTO `wp_shop_nation` VALUES ('2424', '460000', '海南省', '0');
INSERT INTO `wp_shop_nation` VALUES ('2425', '460100', '海口市', '2424');
INSERT INTO `wp_shop_nation` VALUES ('2426', '460101', '市辖区', '2425');
INSERT INTO `wp_shop_nation` VALUES ('2427', '460105', '秀英区', '2425');
INSERT INTO `wp_shop_nation` VALUES ('2428', '460106', '龙华区', '2425');
INSERT INTO `wp_shop_nation` VALUES ('2429', '460107', '琼山区', '2425');
INSERT INTO `wp_shop_nation` VALUES ('2430', '460108', '美兰区', '2425');
INSERT INTO `wp_shop_nation` VALUES ('2431', '460200', '三亚市', '2424');
INSERT INTO `wp_shop_nation` VALUES ('2432', '460201', '市辖区', '2431');
INSERT INTO `wp_shop_nation` VALUES ('2433', '460202', '海棠区', '2431');
INSERT INTO `wp_shop_nation` VALUES ('2434', '460203', '吉阳区', '2431');
INSERT INTO `wp_shop_nation` VALUES ('2435', '460204', '天涯区', '2431');
INSERT INTO `wp_shop_nation` VALUES ('2436', '460205', '崖州区', '2431');
INSERT INTO `wp_shop_nation` VALUES ('2437', '460300', '三沙市', '2424');
INSERT INTO `wp_shop_nation` VALUES ('2438', '460321', '西沙群岛', '2437');
INSERT INTO `wp_shop_nation` VALUES ('2439', '460322', '南沙群岛', '2437');
INSERT INTO `wp_shop_nation` VALUES ('2440', '460323', '中沙群岛的岛礁及其海域', '2437');
INSERT INTO `wp_shop_nation` VALUES ('2441', '469000', '省直辖县级行政区划', '2424');
INSERT INTO `wp_shop_nation` VALUES ('2442', '469001', '五指山市', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2443', '469002', '琼海市', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2444', '469003', '儋州市', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2445', '469005', '文昌市', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2446', '469006', '万宁市', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2447', '469007', '东方市', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2448', '469021', '定安县', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2449', '469022', '屯昌县', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2450', '469023', '澄迈县', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2451', '469024', '临高县', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2452', '469025', '白沙黎族自治县', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2453', '469026', '昌江黎族自治县', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2454', '469027', '乐东黎族自治县', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2455', '469028', '陵水黎族自治县', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2456', '469029', '保亭黎族苗族自治县', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2457', '469030', '琼中黎族苗族自治县', '2441');
INSERT INTO `wp_shop_nation` VALUES ('2458', '500000', '重庆市', '0');
INSERT INTO `wp_shop_nation` VALUES ('2459', '500101', '万州区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2460', '500102', '涪陵区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2461', '500103', '渝中区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2462', '500104', '大渡口区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2463', '500105', '江北区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2464', '500106', '沙坪坝区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2465', '500107', '九龙坡区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2466', '500108', '南岸区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2467', '500109', '北碚区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2468', '500110', '綦江区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2469', '500111', '大足区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2470', '500112', '渝北区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2471', '500113', '巴南区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2472', '500114', '黔江区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2473', '500115', '长寿区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2474', '500116', '江津区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2475', '500117', '合川区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2476', '500118', '永川区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2477', '500119', '南川区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2478', '500120', '璧山区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2479', '500151', '铜梁区', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2480', '500223', '潼南县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2481', '500226', '荣昌县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2482', '500228', '梁平县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2483', '500229', '城口县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2484', '500230', '丰都县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2485', '500231', '垫江县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2486', '500232', '武隆县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2487', '500233', '忠县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2488', '500234', '开县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2489', '500235', '云阳县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2490', '500236', '奉节县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2491', '500237', '巫山县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2492', '500238', '巫溪县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2493', '500240', '石柱土家族自治县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2494', '500241', '秀山土家族苗族自治县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2495', '500242', '酉阳土家族苗族自治县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2496', '500243', '彭水苗族土家族自治县', '2458');
INSERT INTO `wp_shop_nation` VALUES ('2497', '510000', '四川省', '0');
INSERT INTO `wp_shop_nation` VALUES ('2498', '510100', '成都市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2499', '510101', '市辖区', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2500', '510104', '锦江区', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2501', '510105', '青羊区', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2502', '510106', '金牛区', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2503', '510107', '武侯区', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2504', '510108', '成华区', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2505', '510112', '龙泉驿区', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2506', '510113', '青白江区', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2507', '510114', '新都区', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2508', '510115', '温江区', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2509', '510121', '金堂县', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2510', '510122', '双流县', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2511', '510124', '郫县', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2512', '510129', '大邑县', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2513', '510131', '蒲江县', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2514', '510132', '新津县', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2515', '510181', '都江堰市', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2516', '510182', '彭州市', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2517', '510183', '邛崃市', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2518', '510184', '崇州市', '2498');
INSERT INTO `wp_shop_nation` VALUES ('2519', '510300', '自贡市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2520', '510301', '市辖区', '2519');
INSERT INTO `wp_shop_nation` VALUES ('2521', '510302', '自流井区', '2519');
INSERT INTO `wp_shop_nation` VALUES ('2522', '510303', '贡井区', '2519');
INSERT INTO `wp_shop_nation` VALUES ('2523', '510304', '大安区', '2519');
INSERT INTO `wp_shop_nation` VALUES ('2524', '510311', '沿滩区', '2519');
INSERT INTO `wp_shop_nation` VALUES ('2525', '510321', '荣县', '2519');
INSERT INTO `wp_shop_nation` VALUES ('2526', '510322', '富顺县', '2519');
INSERT INTO `wp_shop_nation` VALUES ('2527', '510400', '攀枝花市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2528', '510401', '市辖区', '2527');
INSERT INTO `wp_shop_nation` VALUES ('2529', '510402', '东区', '2527');
INSERT INTO `wp_shop_nation` VALUES ('2530', '510403', '西区', '2527');
INSERT INTO `wp_shop_nation` VALUES ('2531', '510411', '仁和区', '2527');
INSERT INTO `wp_shop_nation` VALUES ('2532', '510421', '米易县', '2527');
INSERT INTO `wp_shop_nation` VALUES ('2533', '510422', '盐边县', '2527');
INSERT INTO `wp_shop_nation` VALUES ('2534', '510500', '泸州市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2535', '510501', '市辖区', '2534');
INSERT INTO `wp_shop_nation` VALUES ('2536', '510502', '江阳区', '2534');
INSERT INTO `wp_shop_nation` VALUES ('2537', '510503', '纳溪区', '2534');
INSERT INTO `wp_shop_nation` VALUES ('2538', '510504', '龙马潭区', '2534');
INSERT INTO `wp_shop_nation` VALUES ('2539', '510521', '泸县', '2534');
INSERT INTO `wp_shop_nation` VALUES ('2540', '510522', '合江县', '2534');
INSERT INTO `wp_shop_nation` VALUES ('2541', '510524', '叙永县', '2534');
INSERT INTO `wp_shop_nation` VALUES ('2542', '510525', '古蔺县', '2534');
INSERT INTO `wp_shop_nation` VALUES ('2543', '510600', '德阳市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2544', '510601', '市辖区', '2543');
INSERT INTO `wp_shop_nation` VALUES ('2545', '510603', '旌阳区', '2543');
INSERT INTO `wp_shop_nation` VALUES ('2546', '510623', '中江县', '2543');
INSERT INTO `wp_shop_nation` VALUES ('2547', '510626', '罗江县', '2543');
INSERT INTO `wp_shop_nation` VALUES ('2548', '510681', '广汉市', '2543');
INSERT INTO `wp_shop_nation` VALUES ('2549', '510682', '什邡市', '2543');
INSERT INTO `wp_shop_nation` VALUES ('2550', '510683', '绵竹市', '2543');
INSERT INTO `wp_shop_nation` VALUES ('2551', '510700', '绵阳市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2552', '510701', '市辖区', '2551');
INSERT INTO `wp_shop_nation` VALUES ('2553', '510703', '涪城区', '2551');
INSERT INTO `wp_shop_nation` VALUES ('2554', '510704', '游仙区', '2551');
INSERT INTO `wp_shop_nation` VALUES ('2555', '510722', '三台县', '2551');
INSERT INTO `wp_shop_nation` VALUES ('2556', '510723', '盐亭县', '2551');
INSERT INTO `wp_shop_nation` VALUES ('2557', '510724', '安县', '2551');
INSERT INTO `wp_shop_nation` VALUES ('2558', '510725', '梓潼县', '2551');
INSERT INTO `wp_shop_nation` VALUES ('2559', '510726', '北川羌族自治县', '2551');
INSERT INTO `wp_shop_nation` VALUES ('2560', '510727', '平武县', '2551');
INSERT INTO `wp_shop_nation` VALUES ('2561', '510781', '江油市', '2551');
INSERT INTO `wp_shop_nation` VALUES ('2562', '510800', '广元市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2563', '510801', '市辖区', '2562');
INSERT INTO `wp_shop_nation` VALUES ('2564', '510802', '利州区', '2562');
INSERT INTO `wp_shop_nation` VALUES ('2565', '510811', '昭化区', '2562');
INSERT INTO `wp_shop_nation` VALUES ('2566', '510812', '朝天区', '2562');
INSERT INTO `wp_shop_nation` VALUES ('2567', '510821', '旺苍县', '2562');
INSERT INTO `wp_shop_nation` VALUES ('2568', '510822', '青川县', '2562');
INSERT INTO `wp_shop_nation` VALUES ('2569', '510823', '剑阁县', '2562');
INSERT INTO `wp_shop_nation` VALUES ('2570', '510824', '苍溪县', '2562');
INSERT INTO `wp_shop_nation` VALUES ('2571', '510900', '遂宁市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2572', '510901', '市辖区', '2571');
INSERT INTO `wp_shop_nation` VALUES ('2573', '510903', '船山区', '2571');
INSERT INTO `wp_shop_nation` VALUES ('2574', '510904', '安居区', '2571');
INSERT INTO `wp_shop_nation` VALUES ('2575', '510921', '蓬溪县', '2571');
INSERT INTO `wp_shop_nation` VALUES ('2576', '510922', '射洪县', '2571');
INSERT INTO `wp_shop_nation` VALUES ('2577', '510923', '大英县', '2571');
INSERT INTO `wp_shop_nation` VALUES ('2578', '511000', '内江市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2579', '511001', '市辖区', '2578');
INSERT INTO `wp_shop_nation` VALUES ('2580', '511002', '市中区', '2578');
INSERT INTO `wp_shop_nation` VALUES ('2581', '511011', '东兴区', '2578');
INSERT INTO `wp_shop_nation` VALUES ('2582', '511024', '威远县', '2578');
INSERT INTO `wp_shop_nation` VALUES ('2583', '511025', '资中县', '2578');
INSERT INTO `wp_shop_nation` VALUES ('2584', '511028', '隆昌县', '2578');
INSERT INTO `wp_shop_nation` VALUES ('2585', '511100', '乐山市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2586', '511101', '市辖区', '2585');
INSERT INTO `wp_shop_nation` VALUES ('2587', '511102', '市中区', '2585');
INSERT INTO `wp_shop_nation` VALUES ('2588', '511111', '沙湾区', '2585');
INSERT INTO `wp_shop_nation` VALUES ('2589', '511112', '五通桥区', '2585');
INSERT INTO `wp_shop_nation` VALUES ('2590', '511113', '金口河区', '2585');
INSERT INTO `wp_shop_nation` VALUES ('2591', '511123', '犍为县', '2585');
INSERT INTO `wp_shop_nation` VALUES ('2592', '511124', '井研县', '2585');
INSERT INTO `wp_shop_nation` VALUES ('2593', '511126', '夹江县', '2585');
INSERT INTO `wp_shop_nation` VALUES ('2594', '511129', '沐川县', '2585');
INSERT INTO `wp_shop_nation` VALUES ('2595', '511132', '峨边彝族自治县', '2585');
INSERT INTO `wp_shop_nation` VALUES ('2596', '511133', '马边彝族自治县', '2585');
INSERT INTO `wp_shop_nation` VALUES ('2597', '511181', '峨眉山市', '2585');
INSERT INTO `wp_shop_nation` VALUES ('2598', '511300', '南充市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2599', '511301', '市辖区', '2598');
INSERT INTO `wp_shop_nation` VALUES ('2600', '511302', '顺庆区', '2598');
INSERT INTO `wp_shop_nation` VALUES ('2601', '511303', '高坪区', '2598');
INSERT INTO `wp_shop_nation` VALUES ('2602', '511304', '嘉陵区', '2598');
INSERT INTO `wp_shop_nation` VALUES ('2603', '511321', '南部县', '2598');
INSERT INTO `wp_shop_nation` VALUES ('2604', '511322', '营山县', '2598');
INSERT INTO `wp_shop_nation` VALUES ('2605', '511323', '蓬安县', '2598');
INSERT INTO `wp_shop_nation` VALUES ('2606', '511324', '仪陇县', '2598');
INSERT INTO `wp_shop_nation` VALUES ('2607', '511325', '西充县', '2598');
INSERT INTO `wp_shop_nation` VALUES ('2608', '511381', '阆中市', '2598');
INSERT INTO `wp_shop_nation` VALUES ('2609', '511400', '眉山市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2610', '511401', '市辖区', '2609');
INSERT INTO `wp_shop_nation` VALUES ('2611', '511402', '东坡区', '2609');
INSERT INTO `wp_shop_nation` VALUES ('2612', '511403', '彭山区', '2609');
INSERT INTO `wp_shop_nation` VALUES ('2613', '511421', '仁寿县', '2609');
INSERT INTO `wp_shop_nation` VALUES ('2614', '511423', '洪雅县', '2609');
INSERT INTO `wp_shop_nation` VALUES ('2615', '511424', '丹棱县', '2609');
INSERT INTO `wp_shop_nation` VALUES ('2616', '511425', '青神县', '2609');
INSERT INTO `wp_shop_nation` VALUES ('2617', '511500', '宜宾市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2618', '511501', '市辖区', '2617');
INSERT INTO `wp_shop_nation` VALUES ('2619', '511502', '翠屏区', '2617');
INSERT INTO `wp_shop_nation` VALUES ('2620', '511503', '南溪区', '2617');
INSERT INTO `wp_shop_nation` VALUES ('2621', '511521', '宜宾县', '2617');
INSERT INTO `wp_shop_nation` VALUES ('2622', '511523', '江安县', '2617');
INSERT INTO `wp_shop_nation` VALUES ('2623', '511524', '长宁县', '2617');
INSERT INTO `wp_shop_nation` VALUES ('2624', '511525', '高县', '2617');
INSERT INTO `wp_shop_nation` VALUES ('2625', '511526', '珙县', '2617');
INSERT INTO `wp_shop_nation` VALUES ('2626', '511527', '筠连县', '2617');
INSERT INTO `wp_shop_nation` VALUES ('2627', '511528', '兴文县', '2617');
INSERT INTO `wp_shop_nation` VALUES ('2628', '511529', '屏山县', '2617');
INSERT INTO `wp_shop_nation` VALUES ('2629', '511600', '广安市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2630', '511601', '市辖区', '2629');
INSERT INTO `wp_shop_nation` VALUES ('2631', '511602', '广安区', '2629');
INSERT INTO `wp_shop_nation` VALUES ('2632', '511603', '前锋区', '2629');
INSERT INTO `wp_shop_nation` VALUES ('2633', '511621', '岳池县', '2629');
INSERT INTO `wp_shop_nation` VALUES ('2634', '511622', '武胜县', '2629');
INSERT INTO `wp_shop_nation` VALUES ('2635', '511623', '邻水县', '2629');
INSERT INTO `wp_shop_nation` VALUES ('2636', '511681', '华蓥市', '2629');
INSERT INTO `wp_shop_nation` VALUES ('2637', '511700', '达州市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2638', '511701', '市辖区', '2637');
INSERT INTO `wp_shop_nation` VALUES ('2639', '511702', '通川区', '2637');
INSERT INTO `wp_shop_nation` VALUES ('2640', '511703', '达川区', '2637');
INSERT INTO `wp_shop_nation` VALUES ('2641', '511722', '宣汉县', '2637');
INSERT INTO `wp_shop_nation` VALUES ('2642', '511723', '开江县', '2637');
INSERT INTO `wp_shop_nation` VALUES ('2643', '511724', '大竹县', '2637');
INSERT INTO `wp_shop_nation` VALUES ('2644', '511725', '渠县', '2637');
INSERT INTO `wp_shop_nation` VALUES ('2645', '511781', '万源市', '2637');
INSERT INTO `wp_shop_nation` VALUES ('2646', '511800', '雅安市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2647', '511801', '市辖区', '2646');
INSERT INTO `wp_shop_nation` VALUES ('2648', '511802', '雨城区', '2646');
INSERT INTO `wp_shop_nation` VALUES ('2649', '511803', '名山区', '2646');
INSERT INTO `wp_shop_nation` VALUES ('2650', '511822', '荥经县', '2646');
INSERT INTO `wp_shop_nation` VALUES ('2651', '511823', '汉源县', '2646');
INSERT INTO `wp_shop_nation` VALUES ('2652', '511824', '石棉县', '2646');
INSERT INTO `wp_shop_nation` VALUES ('2653', '511825', '天全县', '2646');
INSERT INTO `wp_shop_nation` VALUES ('2654', '511826', '芦山县', '2646');
INSERT INTO `wp_shop_nation` VALUES ('2655', '511827', '宝兴县', '2646');
INSERT INTO `wp_shop_nation` VALUES ('2656', '511900', '巴中市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2657', '511901', '市辖区', '2656');
INSERT INTO `wp_shop_nation` VALUES ('2658', '511902', '巴州区', '2656');
INSERT INTO `wp_shop_nation` VALUES ('2659', '511903', '恩阳区', '2656');
INSERT INTO `wp_shop_nation` VALUES ('2660', '511921', '通江县', '2656');
INSERT INTO `wp_shop_nation` VALUES ('2661', '511922', '南江县', '2656');
INSERT INTO `wp_shop_nation` VALUES ('2662', '511923', '平昌县', '2656');
INSERT INTO `wp_shop_nation` VALUES ('2663', '512000', '资阳市', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2664', '512001', '市辖区', '2663');
INSERT INTO `wp_shop_nation` VALUES ('2665', '512002', '雁江区', '2663');
INSERT INTO `wp_shop_nation` VALUES ('2666', '512021', '安岳县', '2663');
INSERT INTO `wp_shop_nation` VALUES ('2667', '512022', '乐至县', '2663');
INSERT INTO `wp_shop_nation` VALUES ('2668', '512081', '简阳市', '2663');
INSERT INTO `wp_shop_nation` VALUES ('2669', '513200', '阿坝藏族羌族自治州', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2670', '513221', '汶川县', '2669');
INSERT INTO `wp_shop_nation` VALUES ('2671', '513222', '理县', '2669');
INSERT INTO `wp_shop_nation` VALUES ('2672', '513223', '茂县', '2669');
INSERT INTO `wp_shop_nation` VALUES ('2673', '513224', '松潘县', '2669');
INSERT INTO `wp_shop_nation` VALUES ('2674', '513225', '九寨沟县', '2669');
INSERT INTO `wp_shop_nation` VALUES ('2675', '513226', '金川县', '2669');
INSERT INTO `wp_shop_nation` VALUES ('2676', '513227', '小金县', '2669');
INSERT INTO `wp_shop_nation` VALUES ('2677', '513228', '黑水县', '2669');
INSERT INTO `wp_shop_nation` VALUES ('2678', '513229', '马尔康县', '2669');
INSERT INTO `wp_shop_nation` VALUES ('2679', '513230', '壤塘县', '2669');
INSERT INTO `wp_shop_nation` VALUES ('2680', '513231', '阿坝县', '2669');
INSERT INTO `wp_shop_nation` VALUES ('2681', '513232', '若尔盖县', '2669');
INSERT INTO `wp_shop_nation` VALUES ('2682', '513233', '红原县', '2669');
INSERT INTO `wp_shop_nation` VALUES ('2683', '513300', '甘孜藏族自治州', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2684', '513321', '康定县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2685', '513322', '泸定县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2686', '513323', '丹巴县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2687', '513324', '九龙县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2688', '513325', '雅江县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2689', '513326', '道孚县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2690', '513327', '炉霍县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2691', '513328', '甘孜县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2692', '513329', '新龙县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2693', '513330', '德格县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2694', '513331', '白玉县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2695', '513332', '石渠县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2696', '513333', '色达县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2697', '513334', '理塘县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2698', '513335', '巴塘县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2699', '513336', '乡城县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2700', '513337', '稻城县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2701', '513338', '得荣县', '2683');
INSERT INTO `wp_shop_nation` VALUES ('2702', '513400', '凉山彝族自治州', '2497');
INSERT INTO `wp_shop_nation` VALUES ('2703', '513401', '西昌市', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2704', '513422', '木里藏族自治县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2705', '513423', '盐源县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2706', '513424', '德昌县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2707', '513425', '会理县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2708', '513426', '会东县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2709', '513427', '宁南县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2710', '513428', '普格县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2711', '513429', '布拖县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2712', '513430', '金阳县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2713', '513431', '昭觉县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2714', '513432', '喜德县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2715', '513433', '冕宁县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2716', '513434', '越西县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2717', '513435', '甘洛县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2718', '513436', '美姑县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2719', '513437', '雷波县', '2702');
INSERT INTO `wp_shop_nation` VALUES ('2720', '520000', '贵州省', '0');
INSERT INTO `wp_shop_nation` VALUES ('2721', '520100', '贵阳市', '2720');
INSERT INTO `wp_shop_nation` VALUES ('2722', '520101', '市辖区', '2721');
INSERT INTO `wp_shop_nation` VALUES ('2723', '520102', '南明区', '2721');
INSERT INTO `wp_shop_nation` VALUES ('2724', '520103', '云岩区', '2721');
INSERT INTO `wp_shop_nation` VALUES ('2725', '520111', '花溪区', '2721');
INSERT INTO `wp_shop_nation` VALUES ('2726', '520112', '乌当区', '2721');
INSERT INTO `wp_shop_nation` VALUES ('2727', '520113', '白云区', '2721');
INSERT INTO `wp_shop_nation` VALUES ('2728', '520115', '观山湖区', '2721');
INSERT INTO `wp_shop_nation` VALUES ('2729', '520121', '开阳县', '2721');
INSERT INTO `wp_shop_nation` VALUES ('2730', '520122', '息烽县', '2721');
INSERT INTO `wp_shop_nation` VALUES ('2731', '520123', '修文县', '2721');
INSERT INTO `wp_shop_nation` VALUES ('2732', '520181', '清镇市', '2721');
INSERT INTO `wp_shop_nation` VALUES ('2733', '520200', '六盘水市', '2720');
INSERT INTO `wp_shop_nation` VALUES ('2734', '520201', '钟山区', '2733');
INSERT INTO `wp_shop_nation` VALUES ('2735', '520203', '六枝特区', '2733');
INSERT INTO `wp_shop_nation` VALUES ('2736', '520221', '水城县', '2733');
INSERT INTO `wp_shop_nation` VALUES ('2737', '520222', '盘县', '2733');
INSERT INTO `wp_shop_nation` VALUES ('2738', '520300', '遵义市', '2720');
INSERT INTO `wp_shop_nation` VALUES ('2739', '520301', '市辖区', '2738');
INSERT INTO `wp_shop_nation` VALUES ('2740', '520302', '红花岗区', '2738');
INSERT INTO `wp_shop_nation` VALUES ('2741', '520303', '汇川区', '2738');
INSERT INTO `wp_shop_nation` VALUES ('2742', '520321', '遵义县', '2738');
INSERT INTO `wp_shop_nation` VALUES ('2743', '520322', '桐梓县', '2738');
INSERT INTO `wp_shop_nation` VALUES ('2744', '520323', '绥阳县', '2738');
INSERT INTO `wp_shop_nation` VALUES ('2745', '520324', '正安县', '2738');
INSERT INTO `wp_shop_nation` VALUES ('2746', '520325', '道真仡佬族苗族自治县', '2738');
INSERT INTO `wp_shop_nation` VALUES ('2747', '520326', '务川仡佬族苗族自治县', '2738');
INSERT INTO `wp_shop_nation` VALUES ('2748', '520327', '凤冈县', '2738');
INSERT INTO `wp_shop_nation` VALUES ('2749', '520328', '湄潭县', '2738');
INSERT INTO `wp_shop_nation` VALUES ('2750', '520329', '余庆县', '2738');
INSERT INTO `wp_shop_nation` VALUES ('2751', '520330', '习水县', '2738');
INSERT INTO `wp_shop_nation` VALUES ('2752', '520381', '赤水市', '2738');
INSERT INTO `wp_shop_nation` VALUES ('2753', '520382', '仁怀市', '2738');
INSERT INTO `wp_shop_nation` VALUES ('2754', '520400', '安顺市', '2720');
INSERT INTO `wp_shop_nation` VALUES ('2755', '520401', '市辖区', '2754');
INSERT INTO `wp_shop_nation` VALUES ('2756', '520402', '西秀区', '2754');
INSERT INTO `wp_shop_nation` VALUES ('2757', '520403', '平坝区', '2754');
INSERT INTO `wp_shop_nation` VALUES ('2758', '520422', '普定县', '2754');
INSERT INTO `wp_shop_nation` VALUES ('2759', '520423', '镇宁布依族苗族自治县', '2754');
INSERT INTO `wp_shop_nation` VALUES ('2760', '520424', '关岭布依族苗族自治县', '2754');
INSERT INTO `wp_shop_nation` VALUES ('2761', '520425', '紫云苗族布依族自治县', '2754');
INSERT INTO `wp_shop_nation` VALUES ('2762', '520500', '毕节市', '2720');
INSERT INTO `wp_shop_nation` VALUES ('2763', '520501', '市辖区', '2762');
INSERT INTO `wp_shop_nation` VALUES ('2764', '520502', '七星关区', '2762');
INSERT INTO `wp_shop_nation` VALUES ('2765', '520521', '大方县', '2762');
INSERT INTO `wp_shop_nation` VALUES ('2766', '520522', '黔西县', '2762');
INSERT INTO `wp_shop_nation` VALUES ('2767', '520523', '金沙县', '2762');
INSERT INTO `wp_shop_nation` VALUES ('2768', '520524', '织金县', '2762');
INSERT INTO `wp_shop_nation` VALUES ('2769', '520525', '纳雍县', '2762');
INSERT INTO `wp_shop_nation` VALUES ('2770', '520526', '威宁彝族回族苗族自治县', '2762');
INSERT INTO `wp_shop_nation` VALUES ('2771', '520527', '赫章县', '2762');
INSERT INTO `wp_shop_nation` VALUES ('2772', '520600', '铜仁市', '2720');
INSERT INTO `wp_shop_nation` VALUES ('2773', '520601', '市辖区', '2772');
INSERT INTO `wp_shop_nation` VALUES ('2774', '520602', '碧江区', '2772');
INSERT INTO `wp_shop_nation` VALUES ('2775', '520603', '万山区', '2772');
INSERT INTO `wp_shop_nation` VALUES ('2776', '520621', '江口县', '2772');
INSERT INTO `wp_shop_nation` VALUES ('2777', '520622', '玉屏侗族自治县', '2772');
INSERT INTO `wp_shop_nation` VALUES ('2778', '520623', '石阡县', '2772');
INSERT INTO `wp_shop_nation` VALUES ('2779', '520624', '思南县', '2772');
INSERT INTO `wp_shop_nation` VALUES ('2780', '520625', '印江土家族苗族自治县', '2772');
INSERT INTO `wp_shop_nation` VALUES ('2781', '520626', '德江县', '2772');
INSERT INTO `wp_shop_nation` VALUES ('2782', '520627', '沿河土家族自治县', '2772');
INSERT INTO `wp_shop_nation` VALUES ('2783', '520628', '松桃苗族自治县', '2772');
INSERT INTO `wp_shop_nation` VALUES ('2784', '522300', '黔西南布依族苗族自治州', '2720');
INSERT INTO `wp_shop_nation` VALUES ('2785', '522301', '兴义市', '2784');
INSERT INTO `wp_shop_nation` VALUES ('2786', '522322', '兴仁县', '2784');
INSERT INTO `wp_shop_nation` VALUES ('2787', '522323', '普安县', '2784');
INSERT INTO `wp_shop_nation` VALUES ('2788', '522324', '晴隆县', '2784');
INSERT INTO `wp_shop_nation` VALUES ('2789', '522325', '贞丰县', '2784');
INSERT INTO `wp_shop_nation` VALUES ('2790', '522326', '望谟县', '2784');
INSERT INTO `wp_shop_nation` VALUES ('2791', '522327', '册亨县', '2784');
INSERT INTO `wp_shop_nation` VALUES ('2792', '522328', '安龙县', '2784');
INSERT INTO `wp_shop_nation` VALUES ('2793', '522600', '黔东南苗族侗族自治州', '2720');
INSERT INTO `wp_shop_nation` VALUES ('2794', '522601', '凯里市', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2795', '522622', '黄平县', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2796', '522623', '施秉县', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2797', '522624', '三穗县', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2798', '522625', '镇远县', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2799', '522626', '岑巩县', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2800', '522627', '天柱县', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2801', '522628', '锦屏县', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2802', '522629', '剑河县', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2803', '522630', '台江县', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2804', '522631', '黎平县', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2805', '522632', '榕江县', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2806', '522633', '从江县', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2807', '522634', '雷山县', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2808', '522635', '麻江县', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2809', '522636', '丹寨县', '2793');
INSERT INTO `wp_shop_nation` VALUES ('2810', '522700', '黔南布依族苗族自治州', '2720');
INSERT INTO `wp_shop_nation` VALUES ('2811', '522701', '都匀市', '2810');
INSERT INTO `wp_shop_nation` VALUES ('2812', '522702', '福泉市', '2810');
INSERT INTO `wp_shop_nation` VALUES ('2813', '522722', '荔波县', '2810');
INSERT INTO `wp_shop_nation` VALUES ('2814', '522723', '贵定县', '2810');
INSERT INTO `wp_shop_nation` VALUES ('2815', '522725', '瓮安县', '2810');
INSERT INTO `wp_shop_nation` VALUES ('2816', '522726', '独山县', '2810');
INSERT INTO `wp_shop_nation` VALUES ('2817', '522727', '平塘县', '2810');
INSERT INTO `wp_shop_nation` VALUES ('2818', '522728', '罗甸县', '2810');
INSERT INTO `wp_shop_nation` VALUES ('2819', '522729', '长顺县', '2810');
INSERT INTO `wp_shop_nation` VALUES ('2820', '522730', '龙里县', '2810');
INSERT INTO `wp_shop_nation` VALUES ('2821', '522731', '惠水县', '2810');
INSERT INTO `wp_shop_nation` VALUES ('2822', '522732', '三都水族自治县', '2810');
INSERT INTO `wp_shop_nation` VALUES ('2823', '530000', '云南省', '0');
INSERT INTO `wp_shop_nation` VALUES ('2824', '530100', '昆明市', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2825', '530101', '市辖区', '2824');
INSERT INTO `wp_shop_nation` VALUES ('2826', '530102', '五华区', '2824');
INSERT INTO `wp_shop_nation` VALUES ('2827', '530103', '盘龙区', '2824');
INSERT INTO `wp_shop_nation` VALUES ('2828', '530111', '官渡区', '2824');
INSERT INTO `wp_shop_nation` VALUES ('2829', '530112', '西山区', '2824');
INSERT INTO `wp_shop_nation` VALUES ('2830', '530113', '东川区', '2824');
INSERT INTO `wp_shop_nation` VALUES ('2831', '530114', '呈贡区', '2824');
INSERT INTO `wp_shop_nation` VALUES ('2832', '530122', '晋宁县', '2824');
INSERT INTO `wp_shop_nation` VALUES ('2833', '530124', '富民县', '2824');
INSERT INTO `wp_shop_nation` VALUES ('2834', '530125', '宜良县', '2824');
INSERT INTO `wp_shop_nation` VALUES ('2835', '530126', '石林彝族自治县', '2824');
INSERT INTO `wp_shop_nation` VALUES ('2836', '530127', '嵩明县', '2824');
INSERT INTO `wp_shop_nation` VALUES ('2837', '530128', '禄劝彝族苗族自治县', '2824');
INSERT INTO `wp_shop_nation` VALUES ('2838', '530129', '寻甸回族彝族自治县', '2824');
INSERT INTO `wp_shop_nation` VALUES ('2839', '530181', '安宁市', '2824');
INSERT INTO `wp_shop_nation` VALUES ('2840', '530300', '曲靖市', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2841', '530301', '市辖区', '2840');
INSERT INTO `wp_shop_nation` VALUES ('2842', '530302', '麒麟区', '2840');
INSERT INTO `wp_shop_nation` VALUES ('2843', '530321', '马龙县', '2840');
INSERT INTO `wp_shop_nation` VALUES ('2844', '530322', '陆良县', '2840');
INSERT INTO `wp_shop_nation` VALUES ('2845', '530323', '师宗县', '2840');
INSERT INTO `wp_shop_nation` VALUES ('2846', '530324', '罗平县', '2840');
INSERT INTO `wp_shop_nation` VALUES ('2847', '530325', '富源县', '2840');
INSERT INTO `wp_shop_nation` VALUES ('2848', '530326', '会泽县', '2840');
INSERT INTO `wp_shop_nation` VALUES ('2849', '530328', '沾益县', '2840');
INSERT INTO `wp_shop_nation` VALUES ('2850', '530381', '宣威市', '2840');
INSERT INTO `wp_shop_nation` VALUES ('2851', '530400', '玉溪市', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2852', '530401', '市辖区', '2851');
INSERT INTO `wp_shop_nation` VALUES ('2853', '530402', '红塔区', '2851');
INSERT INTO `wp_shop_nation` VALUES ('2854', '530421', '江川县', '2851');
INSERT INTO `wp_shop_nation` VALUES ('2855', '530422', '澄江县', '2851');
INSERT INTO `wp_shop_nation` VALUES ('2856', '530423', '通海县', '2851');
INSERT INTO `wp_shop_nation` VALUES ('2857', '530424', '华宁县', '2851');
INSERT INTO `wp_shop_nation` VALUES ('2858', '530425', '易门县', '2851');
INSERT INTO `wp_shop_nation` VALUES ('2859', '530426', '峨山彝族自治县', '2851');
INSERT INTO `wp_shop_nation` VALUES ('2860', '530427', '新平彝族傣族自治县', '2851');
INSERT INTO `wp_shop_nation` VALUES ('2861', '530428', '元江哈尼族彝族傣族自治县', '2851');
INSERT INTO `wp_shop_nation` VALUES ('2862', '530500', '保山市', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2863', '530501', '市辖区', '2862');
INSERT INTO `wp_shop_nation` VALUES ('2864', '530502', '隆阳区', '2862');
INSERT INTO `wp_shop_nation` VALUES ('2865', '530521', '施甸县', '2862');
INSERT INTO `wp_shop_nation` VALUES ('2866', '530522', '腾冲县', '2862');
INSERT INTO `wp_shop_nation` VALUES ('2867', '530523', '龙陵县', '2862');
INSERT INTO `wp_shop_nation` VALUES ('2868', '530524', '昌宁县', '2862');
INSERT INTO `wp_shop_nation` VALUES ('2869', '530600', '昭通市', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2870', '530601', '市辖区', '2869');
INSERT INTO `wp_shop_nation` VALUES ('2871', '530602', '昭阳区', '2869');
INSERT INTO `wp_shop_nation` VALUES ('2872', '530621', '鲁甸县', '2869');
INSERT INTO `wp_shop_nation` VALUES ('2873', '530622', '巧家县', '2869');
INSERT INTO `wp_shop_nation` VALUES ('2874', '530623', '盐津县', '2869');
INSERT INTO `wp_shop_nation` VALUES ('2875', '530624', '大关县', '2869');
INSERT INTO `wp_shop_nation` VALUES ('2876', '530625', '永善县', '2869');
INSERT INTO `wp_shop_nation` VALUES ('2877', '530626', '绥江县', '2869');
INSERT INTO `wp_shop_nation` VALUES ('2878', '530627', '镇雄县', '2869');
INSERT INTO `wp_shop_nation` VALUES ('2879', '530628', '彝良县', '2869');
INSERT INTO `wp_shop_nation` VALUES ('2880', '530629', '威信县', '2869');
INSERT INTO `wp_shop_nation` VALUES ('2881', '530630', '水富县', '2869');
INSERT INTO `wp_shop_nation` VALUES ('2882', '530700', '丽江市', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2883', '530701', '市辖区', '2882');
INSERT INTO `wp_shop_nation` VALUES ('2884', '530702', '古城区', '2882');
INSERT INTO `wp_shop_nation` VALUES ('2885', '530721', '玉龙纳西族自治县', '2882');
INSERT INTO `wp_shop_nation` VALUES ('2886', '530722', '永胜县', '2882');
INSERT INTO `wp_shop_nation` VALUES ('2887', '530723', '华坪县', '2882');
INSERT INTO `wp_shop_nation` VALUES ('2888', '530724', '宁蒗彝族自治县', '2882');
INSERT INTO `wp_shop_nation` VALUES ('2889', '530800', '普洱市', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2890', '530801', '市辖区', '2889');
INSERT INTO `wp_shop_nation` VALUES ('2891', '530802', '思茅区', '2889');
INSERT INTO `wp_shop_nation` VALUES ('2892', '530821', '宁洱哈尼族彝族自治县', '2889');
INSERT INTO `wp_shop_nation` VALUES ('2893', '530822', '墨江哈尼族自治县', '2889');
INSERT INTO `wp_shop_nation` VALUES ('2894', '530823', '景东彝族自治县', '2889');
INSERT INTO `wp_shop_nation` VALUES ('2895', '530824', '景谷傣族彝族自治县', '2889');
INSERT INTO `wp_shop_nation` VALUES ('2896', '530825', '镇沅彝族哈尼族拉祜族自治县', '2889');
INSERT INTO `wp_shop_nation` VALUES ('2897', '530826', '江城哈尼族彝族自治县', '2889');
INSERT INTO `wp_shop_nation` VALUES ('2898', '530827', '孟连傣族拉祜族佤族自治县', '2889');
INSERT INTO `wp_shop_nation` VALUES ('2899', '530828', '澜沧拉祜族自治县', '2889');
INSERT INTO `wp_shop_nation` VALUES ('2900', '530829', '西盟佤族自治县', '2889');
INSERT INTO `wp_shop_nation` VALUES ('2901', '530900', '临沧市', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2902', '530901', '市辖区', '2901');
INSERT INTO `wp_shop_nation` VALUES ('2903', '530902', '临翔区', '2901');
INSERT INTO `wp_shop_nation` VALUES ('2904', '530921', '凤庆县', '2901');
INSERT INTO `wp_shop_nation` VALUES ('2905', '530922', '云县', '2901');
INSERT INTO `wp_shop_nation` VALUES ('2906', '530923', '永德县', '2901');
INSERT INTO `wp_shop_nation` VALUES ('2907', '530924', '镇康县', '2901');
INSERT INTO `wp_shop_nation` VALUES ('2908', '530925', '双江拉祜族佤族布朗族傣族自治县', '2901');
INSERT INTO `wp_shop_nation` VALUES ('2909', '530926', '耿马傣族佤族自治县', '2901');
INSERT INTO `wp_shop_nation` VALUES ('2910', '530927', '沧源佤族自治县', '2901');
INSERT INTO `wp_shop_nation` VALUES ('2911', '532300', '楚雄彝族自治州', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2912', '532301', '楚雄市', '2911');
INSERT INTO `wp_shop_nation` VALUES ('2913', '532322', '双柏县', '2911');
INSERT INTO `wp_shop_nation` VALUES ('2914', '532323', '牟定县', '2911');
INSERT INTO `wp_shop_nation` VALUES ('2915', '532324', '南华县', '2911');
INSERT INTO `wp_shop_nation` VALUES ('2916', '532325', '姚安县', '2911');
INSERT INTO `wp_shop_nation` VALUES ('2917', '532326', '大姚县', '2911');
INSERT INTO `wp_shop_nation` VALUES ('2918', '532327', '永仁县', '2911');
INSERT INTO `wp_shop_nation` VALUES ('2919', '532328', '元谋县', '2911');
INSERT INTO `wp_shop_nation` VALUES ('2920', '532329', '武定县', '2911');
INSERT INTO `wp_shop_nation` VALUES ('2921', '532331', '禄丰县', '2911');
INSERT INTO `wp_shop_nation` VALUES ('2922', '532500', '红河哈尼族彝族自治州', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2923', '532501', '个旧市', '2922');
INSERT INTO `wp_shop_nation` VALUES ('2924', '532502', '开远市', '2922');
INSERT INTO `wp_shop_nation` VALUES ('2925', '532503', '蒙自市', '2922');
INSERT INTO `wp_shop_nation` VALUES ('2926', '532504', '弥勒市', '2922');
INSERT INTO `wp_shop_nation` VALUES ('2927', '532523', '屏边苗族自治县', '2922');
INSERT INTO `wp_shop_nation` VALUES ('2928', '532524', '建水县', '2922');
INSERT INTO `wp_shop_nation` VALUES ('2929', '532525', '石屏县', '2922');
INSERT INTO `wp_shop_nation` VALUES ('2930', '532527', '泸西县', '2922');
INSERT INTO `wp_shop_nation` VALUES ('2931', '532528', '元阳县', '2922');
INSERT INTO `wp_shop_nation` VALUES ('2932', '532529', '红河县', '2922');
INSERT INTO `wp_shop_nation` VALUES ('2933', '532530', '金平苗族瑶族傣族自治县', '2922');
INSERT INTO `wp_shop_nation` VALUES ('2934', '532531', '绿春县', '2922');
INSERT INTO `wp_shop_nation` VALUES ('2935', '532532', '河口瑶族自治县', '2922');
INSERT INTO `wp_shop_nation` VALUES ('2936', '532600', '文山壮族苗族自治州', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2937', '532601', '文山市', '2936');
INSERT INTO `wp_shop_nation` VALUES ('2938', '532622', '砚山县', '2936');
INSERT INTO `wp_shop_nation` VALUES ('2939', '532623', '西畴县', '2936');
INSERT INTO `wp_shop_nation` VALUES ('2940', '532624', '麻栗坡县', '2936');
INSERT INTO `wp_shop_nation` VALUES ('2941', '532625', '马关县', '2936');
INSERT INTO `wp_shop_nation` VALUES ('2942', '532626', '丘北县', '2936');
INSERT INTO `wp_shop_nation` VALUES ('2943', '532627', '广南县', '2936');
INSERT INTO `wp_shop_nation` VALUES ('2944', '532628', '富宁县', '2936');
INSERT INTO `wp_shop_nation` VALUES ('2945', '532800', '西双版纳傣族自治州', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2946', '532801', '景洪市', '2945');
INSERT INTO `wp_shop_nation` VALUES ('2947', '532822', '勐海县', '2945');
INSERT INTO `wp_shop_nation` VALUES ('2948', '532823', '勐腊县', '2945');
INSERT INTO `wp_shop_nation` VALUES ('2949', '532900', '大理白族自治州', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2950', '532901', '大理市', '2949');
INSERT INTO `wp_shop_nation` VALUES ('2951', '532922', '漾濞彝族自治县', '2949');
INSERT INTO `wp_shop_nation` VALUES ('2952', '532923', '祥云县', '2949');
INSERT INTO `wp_shop_nation` VALUES ('2953', '532924', '宾川县', '2949');
INSERT INTO `wp_shop_nation` VALUES ('2954', '532925', '弥渡县', '2949');
INSERT INTO `wp_shop_nation` VALUES ('2955', '532926', '南涧彝族自治县', '2949');
INSERT INTO `wp_shop_nation` VALUES ('2956', '532927', '巍山彝族回族自治县', '2949');
INSERT INTO `wp_shop_nation` VALUES ('2957', '532928', '永平县', '2949');
INSERT INTO `wp_shop_nation` VALUES ('2958', '532929', '云龙县', '2949');
INSERT INTO `wp_shop_nation` VALUES ('2959', '532930', '洱源县', '2949');
INSERT INTO `wp_shop_nation` VALUES ('2960', '532931', '剑川县', '2949');
INSERT INTO `wp_shop_nation` VALUES ('2961', '532932', '鹤庆县', '2949');
INSERT INTO `wp_shop_nation` VALUES ('2962', '533100', '德宏傣族景颇族自治州', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2963', '533102', '瑞丽市', '2962');
INSERT INTO `wp_shop_nation` VALUES ('2964', '533103', '芒市', '2962');
INSERT INTO `wp_shop_nation` VALUES ('2965', '533122', '梁河县', '2962');
INSERT INTO `wp_shop_nation` VALUES ('2966', '533123', '盈江县', '2962');
INSERT INTO `wp_shop_nation` VALUES ('2967', '533124', '陇川县', '2962');
INSERT INTO `wp_shop_nation` VALUES ('2968', '533300', '怒江傈僳族自治州', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2969', '533321', '泸水县', '2968');
INSERT INTO `wp_shop_nation` VALUES ('2970', '533323', '福贡县', '2968');
INSERT INTO `wp_shop_nation` VALUES ('2971', '533324', '贡山独龙族怒族自治县', '2968');
INSERT INTO `wp_shop_nation` VALUES ('2972', '533325', '兰坪白族普米族自治县', '2968');
INSERT INTO `wp_shop_nation` VALUES ('2973', '533400', '迪庆藏族自治州', '2823');
INSERT INTO `wp_shop_nation` VALUES ('2974', '533401', '香格里拉市', '2973');
INSERT INTO `wp_shop_nation` VALUES ('2975', '533422', '德钦县', '2973');
INSERT INTO `wp_shop_nation` VALUES ('2976', '533423', '维西傈僳族自治县', '2973');
INSERT INTO `wp_shop_nation` VALUES ('2977', '540000', '西藏自治区', '0');
INSERT INTO `wp_shop_nation` VALUES ('2978', '540100', '拉萨市', '2977');
INSERT INTO `wp_shop_nation` VALUES ('2979', '540101', '市辖区', '2978');
INSERT INTO `wp_shop_nation` VALUES ('2980', '540102', '城关区', '2978');
INSERT INTO `wp_shop_nation` VALUES ('2981', '540121', '林周县', '2978');
INSERT INTO `wp_shop_nation` VALUES ('2982', '540122', '当雄县', '2978');
INSERT INTO `wp_shop_nation` VALUES ('2983', '540123', '尼木县', '2978');
INSERT INTO `wp_shop_nation` VALUES ('2984', '540124', '曲水县', '2978');
INSERT INTO `wp_shop_nation` VALUES ('2985', '540125', '堆龙德庆县', '2978');
INSERT INTO `wp_shop_nation` VALUES ('2986', '540126', '达孜县', '2978');
INSERT INTO `wp_shop_nation` VALUES ('2987', '540127', '墨竹工卡县', '2978');
INSERT INTO `wp_shop_nation` VALUES ('2988', '540200', '日喀则市', '2977');
INSERT INTO `wp_shop_nation` VALUES ('2989', '540201', '市辖区', '2988');
INSERT INTO `wp_shop_nation` VALUES ('2990', '540202', '桑珠孜区', '2988');
INSERT INTO `wp_shop_nation` VALUES ('2991', '540221', '南木林县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('2992', '540222', '江孜县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('2993', '540223', '定日县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('2994', '540224', '萨迦县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('2995', '540225', '拉孜县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('2996', '540226', '昂仁县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('2997', '540227', '谢通门县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('2998', '540228', '白朗县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('2999', '540229', '仁布县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('3000', '540230', '康马县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('3001', '540231', '定结县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('3002', '540232', '仲巴县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('3003', '540233', '亚东县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('3004', '540234', '吉隆县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('3005', '540235', '聂拉木县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('3006', '540236', '萨嘎县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('3007', '540237', '岗巴县', '2988');
INSERT INTO `wp_shop_nation` VALUES ('3008', '540300', '昌都市', '2977');
INSERT INTO `wp_shop_nation` VALUES ('3009', '540301', '市辖区', '3008');
INSERT INTO `wp_shop_nation` VALUES ('3010', '540302', '卡若区', '3008');
INSERT INTO `wp_shop_nation` VALUES ('3011', '540321', '江达县', '3008');
INSERT INTO `wp_shop_nation` VALUES ('3012', '540322', '贡觉县', '3008');
INSERT INTO `wp_shop_nation` VALUES ('3013', '540323', '类乌齐县', '3008');
INSERT INTO `wp_shop_nation` VALUES ('3014', '540324', '丁青县', '3008');
INSERT INTO `wp_shop_nation` VALUES ('3015', '540325', '察雅县', '3008');
INSERT INTO `wp_shop_nation` VALUES ('3016', '540326', '八宿县', '3008');
INSERT INTO `wp_shop_nation` VALUES ('3017', '540327', '左贡县', '3008');
INSERT INTO `wp_shop_nation` VALUES ('3018', '540328', '芒康县', '3008');
INSERT INTO `wp_shop_nation` VALUES ('3019', '540329', '洛隆县', '3008');
INSERT INTO `wp_shop_nation` VALUES ('3020', '540330', '边坝县', '3008');
INSERT INTO `wp_shop_nation` VALUES ('3021', '542200', '山南地区', '2977');
INSERT INTO `wp_shop_nation` VALUES ('3022', '542221', '乃东县', '3021');
INSERT INTO `wp_shop_nation` VALUES ('3023', '542222', '扎囊县', '3021');
INSERT INTO `wp_shop_nation` VALUES ('3024', '542223', '贡嘎县', '3021');
INSERT INTO `wp_shop_nation` VALUES ('3025', '542224', '桑日县', '3021');
INSERT INTO `wp_shop_nation` VALUES ('3026', '542225', '琼结县', '3021');
INSERT INTO `wp_shop_nation` VALUES ('3027', '542226', '曲松县', '3021');
INSERT INTO `wp_shop_nation` VALUES ('3028', '542227', '措美县', '3021');
INSERT INTO `wp_shop_nation` VALUES ('3029', '542228', '洛扎县', '3021');
INSERT INTO `wp_shop_nation` VALUES ('3030', '542229', '加查县', '3021');
INSERT INTO `wp_shop_nation` VALUES ('3031', '542231', '隆子县', '3021');
INSERT INTO `wp_shop_nation` VALUES ('3032', '542232', '错那县', '3021');
INSERT INTO `wp_shop_nation` VALUES ('3033', '542233', '浪卡子县', '3021');
INSERT INTO `wp_shop_nation` VALUES ('3034', '542400', '那曲地区', '2977');
INSERT INTO `wp_shop_nation` VALUES ('3035', '542421', '那曲县', '3034');
INSERT INTO `wp_shop_nation` VALUES ('3036', '542422', '嘉黎县', '3034');
INSERT INTO `wp_shop_nation` VALUES ('3037', '542423', '比如县', '3034');
INSERT INTO `wp_shop_nation` VALUES ('3038', '542424', '聂荣县', '3034');
INSERT INTO `wp_shop_nation` VALUES ('3039', '542425', '安多县', '3034');
INSERT INTO `wp_shop_nation` VALUES ('3040', '542426', '申扎县', '3034');
INSERT INTO `wp_shop_nation` VALUES ('3041', '542427', '索县', '3034');
INSERT INTO `wp_shop_nation` VALUES ('3042', '542428', '班戈县', '3034');
INSERT INTO `wp_shop_nation` VALUES ('3043', '542429', '巴青县', '3034');
INSERT INTO `wp_shop_nation` VALUES ('3044', '542430', '尼玛县', '3034');
INSERT INTO `wp_shop_nation` VALUES ('3045', '542431', '双湖县', '3034');
INSERT INTO `wp_shop_nation` VALUES ('3046', '542500', '阿里地区', '2977');
INSERT INTO `wp_shop_nation` VALUES ('3047', '542521', '普兰县', '3046');
INSERT INTO `wp_shop_nation` VALUES ('3048', '542522', '札达县', '3046');
INSERT INTO `wp_shop_nation` VALUES ('3049', '542523', '噶尔县', '3046');
INSERT INTO `wp_shop_nation` VALUES ('3050', '542524', '日土县', '3046');
INSERT INTO `wp_shop_nation` VALUES ('3051', '542525', '革吉县', '3046');
INSERT INTO `wp_shop_nation` VALUES ('3052', '542526', '改则县', '3046');
INSERT INTO `wp_shop_nation` VALUES ('3053', '542527', '措勤县', '3046');
INSERT INTO `wp_shop_nation` VALUES ('3054', '542600', '林芝地区', '2977');
INSERT INTO `wp_shop_nation` VALUES ('3055', '542621', '林芝县', '3054');
INSERT INTO `wp_shop_nation` VALUES ('3056', '542622', '工布江达县', '3054');
INSERT INTO `wp_shop_nation` VALUES ('3057', '542623', '米林县', '3054');
INSERT INTO `wp_shop_nation` VALUES ('3058', '542624', '墨脱县', '3054');
INSERT INTO `wp_shop_nation` VALUES ('3059', '542625', '波密县', '3054');
INSERT INTO `wp_shop_nation` VALUES ('3060', '542626', '察隅县', '3054');
INSERT INTO `wp_shop_nation` VALUES ('3061', '542627', '朗县', '3054');
INSERT INTO `wp_shop_nation` VALUES ('3062', '610000', '陕西省', '0');
INSERT INTO `wp_shop_nation` VALUES ('3063', '610100', '西安市', '3062');
INSERT INTO `wp_shop_nation` VALUES ('3064', '610101', '市辖区', '3063');
INSERT INTO `wp_shop_nation` VALUES ('3065', '610102', '新城区', '3063');
INSERT INTO `wp_shop_nation` VALUES ('3066', '610103', '碑林区', '3063');
INSERT INTO `wp_shop_nation` VALUES ('3067', '610104', '莲湖区', '3063');
INSERT INTO `wp_shop_nation` VALUES ('3068', '610111', '灞桥区', '3063');
INSERT INTO `wp_shop_nation` VALUES ('3069', '610112', '未央区', '3063');
INSERT INTO `wp_shop_nation` VALUES ('3070', '610113', '雁塔区', '3063');
INSERT INTO `wp_shop_nation` VALUES ('3071', '610114', '阎良区', '3063');
INSERT INTO `wp_shop_nation` VALUES ('3072', '610115', '临潼区', '3063');
INSERT INTO `wp_shop_nation` VALUES ('3073', '610116', '长安区', '3063');
INSERT INTO `wp_shop_nation` VALUES ('3074', '610117', '高陵区', '3063');
INSERT INTO `wp_shop_nation` VALUES ('3075', '610122', '蓝田县', '3063');
INSERT INTO `wp_shop_nation` VALUES ('3076', '610124', '周至县', '3063');
INSERT INTO `wp_shop_nation` VALUES ('3077', '610125', '户县', '3063');
INSERT INTO `wp_shop_nation` VALUES ('3078', '610200', '铜川市', '3062');
INSERT INTO `wp_shop_nation` VALUES ('3079', '610201', '市辖区', '3078');
INSERT INTO `wp_shop_nation` VALUES ('3080', '610202', '王益区', '3078');
INSERT INTO `wp_shop_nation` VALUES ('3081', '610203', '印台区', '3078');
INSERT INTO `wp_shop_nation` VALUES ('3082', '610204', '耀州区', '3078');
INSERT INTO `wp_shop_nation` VALUES ('3083', '610222', '宜君县', '3078');
INSERT INTO `wp_shop_nation` VALUES ('3084', '610300', '宝鸡市', '3062');
INSERT INTO `wp_shop_nation` VALUES ('3085', '610301', '市辖区', '3084');
INSERT INTO `wp_shop_nation` VALUES ('3086', '610302', '渭滨区', '3084');
INSERT INTO `wp_shop_nation` VALUES ('3087', '610303', '金台区', '3084');
INSERT INTO `wp_shop_nation` VALUES ('3088', '610304', '陈仓区', '3084');
INSERT INTO `wp_shop_nation` VALUES ('3089', '610322', '凤翔县', '3084');
INSERT INTO `wp_shop_nation` VALUES ('3090', '610323', '岐山县', '3084');
INSERT INTO `wp_shop_nation` VALUES ('3091', '610324', '扶风县', '3084');
INSERT INTO `wp_shop_nation` VALUES ('3092', '610326', '眉县', '3084');
INSERT INTO `wp_shop_nation` VALUES ('3093', '610327', '陇县', '3084');
INSERT INTO `wp_shop_nation` VALUES ('3094', '610328', '千阳县', '3084');
INSERT INTO `wp_shop_nation` VALUES ('3095', '610329', '麟游县', '3084');
INSERT INTO `wp_shop_nation` VALUES ('3096', '610330', '凤县', '3084');
INSERT INTO `wp_shop_nation` VALUES ('3097', '610331', '太白县', '3084');
INSERT INTO `wp_shop_nation` VALUES ('3098', '610400', '咸阳市', '3062');
INSERT INTO `wp_shop_nation` VALUES ('3099', '610401', '市辖区', '3098');
INSERT INTO `wp_shop_nation` VALUES ('3100', '610402', '秦都区', '3098');
INSERT INTO `wp_shop_nation` VALUES ('3101', '610403', '杨陵区', '3098');
INSERT INTO `wp_shop_nation` VALUES ('3102', '610404', '渭城区', '3098');
INSERT INTO `wp_shop_nation` VALUES ('3103', '610422', '三原县', '3098');
INSERT INTO `wp_shop_nation` VALUES ('3104', '610423', '泾阳县', '3098');
INSERT INTO `wp_shop_nation` VALUES ('3105', '610424', '乾县', '3098');
INSERT INTO `wp_shop_nation` VALUES ('3106', '610425', '礼泉县', '3098');
INSERT INTO `wp_shop_nation` VALUES ('3107', '610426', '永寿县', '3098');
INSERT INTO `wp_shop_nation` VALUES ('3108', '610427', '彬县', '3098');
INSERT INTO `wp_shop_nation` VALUES ('3109', '610428', '长武县', '3098');
INSERT INTO `wp_shop_nation` VALUES ('3110', '610429', '旬邑县', '3098');
INSERT INTO `wp_shop_nation` VALUES ('3111', '610430', '淳化县', '3098');
INSERT INTO `wp_shop_nation` VALUES ('3112', '610431', '武功县', '3098');
INSERT INTO `wp_shop_nation` VALUES ('3113', '610481', '兴平市', '3098');
INSERT INTO `wp_shop_nation` VALUES ('3114', '610500', '渭南市', '3062');
INSERT INTO `wp_shop_nation` VALUES ('3115', '610501', '市辖区', '3114');
INSERT INTO `wp_shop_nation` VALUES ('3116', '610502', '临渭区', '3114');
INSERT INTO `wp_shop_nation` VALUES ('3117', '610521', '华县', '3114');
INSERT INTO `wp_shop_nation` VALUES ('3118', '610522', '潼关县', '3114');
INSERT INTO `wp_shop_nation` VALUES ('3119', '610523', '大荔县', '3114');
INSERT INTO `wp_shop_nation` VALUES ('3120', '610524', '合阳县', '3114');
INSERT INTO `wp_shop_nation` VALUES ('3121', '610525', '澄城县', '3114');
INSERT INTO `wp_shop_nation` VALUES ('3122', '610526', '蒲城县', '3114');
INSERT INTO `wp_shop_nation` VALUES ('3123', '610527', '白水县', '3114');
INSERT INTO `wp_shop_nation` VALUES ('3124', '610528', '富平县', '3114');
INSERT INTO `wp_shop_nation` VALUES ('3125', '610581', '韩城市', '3114');
INSERT INTO `wp_shop_nation` VALUES ('3126', '610582', '华阴市', '3114');
INSERT INTO `wp_shop_nation` VALUES ('3127', '610600', '延安市', '3062');
INSERT INTO `wp_shop_nation` VALUES ('3128', '610601', '市辖区', '3127');
INSERT INTO `wp_shop_nation` VALUES ('3129', '610602', '宝塔区', '3127');
INSERT INTO `wp_shop_nation` VALUES ('3130', '610621', '延长县', '3127');
INSERT INTO `wp_shop_nation` VALUES ('3131', '610622', '延川县', '3127');
INSERT INTO `wp_shop_nation` VALUES ('3132', '610623', '子长县', '3127');
INSERT INTO `wp_shop_nation` VALUES ('3133', '610624', '安塞县', '3127');
INSERT INTO `wp_shop_nation` VALUES ('3134', '610625', '志丹县', '3127');
INSERT INTO `wp_shop_nation` VALUES ('3135', '610626', '吴起县', '3127');
INSERT INTO `wp_shop_nation` VALUES ('3136', '610627', '甘泉县', '3127');
INSERT INTO `wp_shop_nation` VALUES ('3137', '610628', '富县', '3127');
INSERT INTO `wp_shop_nation` VALUES ('3138', '610629', '洛川县', '3127');
INSERT INTO `wp_shop_nation` VALUES ('3139', '610630', '宜川县', '3127');
INSERT INTO `wp_shop_nation` VALUES ('3140', '610631', '黄龙县', '3127');
INSERT INTO `wp_shop_nation` VALUES ('3141', '610632', '黄陵县', '3127');
INSERT INTO `wp_shop_nation` VALUES ('3142', '610700', '汉中市', '3062');
INSERT INTO `wp_shop_nation` VALUES ('3143', '610701', '市辖区', '3142');
INSERT INTO `wp_shop_nation` VALUES ('3144', '610702', '汉台区', '3142');
INSERT INTO `wp_shop_nation` VALUES ('3145', '610721', '南郑县', '3142');
INSERT INTO `wp_shop_nation` VALUES ('3146', '610722', '城固县', '3142');
INSERT INTO `wp_shop_nation` VALUES ('3147', '610723', '洋县', '3142');
INSERT INTO `wp_shop_nation` VALUES ('3148', '610724', '西乡县', '3142');
INSERT INTO `wp_shop_nation` VALUES ('3149', '610725', '勉县', '3142');
INSERT INTO `wp_shop_nation` VALUES ('3150', '610726', '宁强县', '3142');
INSERT INTO `wp_shop_nation` VALUES ('3151', '610727', '略阳县', '3142');
INSERT INTO `wp_shop_nation` VALUES ('3152', '610728', '镇巴县', '3142');
INSERT INTO `wp_shop_nation` VALUES ('3153', '610729', '留坝县', '3142');
INSERT INTO `wp_shop_nation` VALUES ('3154', '610730', '佛坪县', '3142');
INSERT INTO `wp_shop_nation` VALUES ('3155', '610800', '榆林市', '3062');
INSERT INTO `wp_shop_nation` VALUES ('3156', '610801', '市辖区', '3155');
INSERT INTO `wp_shop_nation` VALUES ('3157', '610802', '榆阳区', '3155');
INSERT INTO `wp_shop_nation` VALUES ('3158', '610821', '神木县', '3155');
INSERT INTO `wp_shop_nation` VALUES ('3159', '610822', '府谷县', '3155');
INSERT INTO `wp_shop_nation` VALUES ('3160', '610823', '横山县', '3155');
INSERT INTO `wp_shop_nation` VALUES ('3161', '610824', '靖边县', '3155');
INSERT INTO `wp_shop_nation` VALUES ('3162', '610825', '定边县', '3155');
INSERT INTO `wp_shop_nation` VALUES ('3163', '610826', '绥德县', '3155');
INSERT INTO `wp_shop_nation` VALUES ('3164', '610827', '米脂县', '3155');
INSERT INTO `wp_shop_nation` VALUES ('3165', '610828', '佳县', '3155');
INSERT INTO `wp_shop_nation` VALUES ('3166', '610829', '吴堡县', '3155');
INSERT INTO `wp_shop_nation` VALUES ('3167', '610830', '清涧县', '3155');
INSERT INTO `wp_shop_nation` VALUES ('3168', '610831', '子洲县', '3155');
INSERT INTO `wp_shop_nation` VALUES ('3169', '610900', '安康市', '3062');
INSERT INTO `wp_shop_nation` VALUES ('3170', '610901', '市辖区', '3169');
INSERT INTO `wp_shop_nation` VALUES ('3171', '610902', '汉滨区', '3169');
INSERT INTO `wp_shop_nation` VALUES ('3172', '610921', '汉阴县', '3169');
INSERT INTO `wp_shop_nation` VALUES ('3173', '610922', '石泉县', '3169');
INSERT INTO `wp_shop_nation` VALUES ('3174', '610923', '宁陕县', '3169');
INSERT INTO `wp_shop_nation` VALUES ('3175', '610924', '紫阳县', '3169');
INSERT INTO `wp_shop_nation` VALUES ('3176', '610925', '岚皋县', '3169');
INSERT INTO `wp_shop_nation` VALUES ('3177', '610926', '平利县', '3169');
INSERT INTO `wp_shop_nation` VALUES ('3178', '610927', '镇坪县', '3169');
INSERT INTO `wp_shop_nation` VALUES ('3179', '610928', '旬阳县', '3169');
INSERT INTO `wp_shop_nation` VALUES ('3180', '610929', '白河县', '3169');
INSERT INTO `wp_shop_nation` VALUES ('3181', '611000', '商洛市', '3062');
INSERT INTO `wp_shop_nation` VALUES ('3182', '611001', '市辖区', '3181');
INSERT INTO `wp_shop_nation` VALUES ('3183', '611002', '商州区', '3181');
INSERT INTO `wp_shop_nation` VALUES ('3184', '611021', '洛南县', '3181');
INSERT INTO `wp_shop_nation` VALUES ('3185', '611022', '丹凤县', '3181');
INSERT INTO `wp_shop_nation` VALUES ('3186', '611023', '商南县', '3181');
INSERT INTO `wp_shop_nation` VALUES ('3187', '611024', '山阳县', '3181');
INSERT INTO `wp_shop_nation` VALUES ('3188', '611025', '镇安县', '3181');
INSERT INTO `wp_shop_nation` VALUES ('3189', '611026', '柞水县', '3181');
INSERT INTO `wp_shop_nation` VALUES ('3190', '620000', '甘肃省', '0');
INSERT INTO `wp_shop_nation` VALUES ('3191', '620100', '兰州市', '3190');
INSERT INTO `wp_shop_nation` VALUES ('3192', '620101', '市辖区', '3191');
INSERT INTO `wp_shop_nation` VALUES ('3193', '620102', '城关区', '3191');
INSERT INTO `wp_shop_nation` VALUES ('3194', '620103', '七里河区', '3191');
INSERT INTO `wp_shop_nation` VALUES ('3195', '620104', '西固区', '3191');
INSERT INTO `wp_shop_nation` VALUES ('3196', '620105', '安宁区', '3191');
INSERT INTO `wp_shop_nation` VALUES ('3197', '620111', '红古区', '3191');
INSERT INTO `wp_shop_nation` VALUES ('3198', '620121', '永登县', '3191');
INSERT INTO `wp_shop_nation` VALUES ('3199', '620122', '皋兰县', '3191');
INSERT INTO `wp_shop_nation` VALUES ('3200', '620123', '榆中县', '3191');
INSERT INTO `wp_shop_nation` VALUES ('3201', '620200', '嘉峪关市', '3190');
INSERT INTO `wp_shop_nation` VALUES ('3202', '620201', '市辖区', '3201');
INSERT INTO `wp_shop_nation` VALUES ('3203', '620300', '金昌市', '3190');
INSERT INTO `wp_shop_nation` VALUES ('3204', '620301', '市辖区', '3203');
INSERT INTO `wp_shop_nation` VALUES ('3205', '620302', '金川区', '3203');
INSERT INTO `wp_shop_nation` VALUES ('3206', '620321', '永昌县', '3203');
INSERT INTO `wp_shop_nation` VALUES ('3207', '620400', '白银市', '3190');
INSERT INTO `wp_shop_nation` VALUES ('3208', '620401', '市辖区', '3207');
INSERT INTO `wp_shop_nation` VALUES ('3209', '620402', '白银区', '3207');
INSERT INTO `wp_shop_nation` VALUES ('3210', '620403', '平川区', '3207');
INSERT INTO `wp_shop_nation` VALUES ('3211', '620421', '靖远县', '3207');
INSERT INTO `wp_shop_nation` VALUES ('3212', '620422', '会宁县', '3207');
INSERT INTO `wp_shop_nation` VALUES ('3213', '620423', '景泰县', '3207');
INSERT INTO `wp_shop_nation` VALUES ('3214', '620500', '天水市', '3190');
INSERT INTO `wp_shop_nation` VALUES ('3215', '620501', '市辖区', '3214');
INSERT INTO `wp_shop_nation` VALUES ('3216', '620502', '秦州区', '3214');
INSERT INTO `wp_shop_nation` VALUES ('3217', '620503', '麦积区', '3214');
INSERT INTO `wp_shop_nation` VALUES ('3218', '620521', '清水县', '3214');
INSERT INTO `wp_shop_nation` VALUES ('3219', '620522', '秦安县', '3214');
INSERT INTO `wp_shop_nation` VALUES ('3220', '620523', '甘谷县', '3214');
INSERT INTO `wp_shop_nation` VALUES ('3221', '620524', '武山县', '3214');
INSERT INTO `wp_shop_nation` VALUES ('3222', '620525', '张家川回族自治县', '3214');
INSERT INTO `wp_shop_nation` VALUES ('3223', '620600', '武威市', '3190');
INSERT INTO `wp_shop_nation` VALUES ('3224', '620601', '市辖区', '3223');
INSERT INTO `wp_shop_nation` VALUES ('3225', '620602', '凉州区', '3223');
INSERT INTO `wp_shop_nation` VALUES ('3226', '620621', '民勤县', '3223');
INSERT INTO `wp_shop_nation` VALUES ('3227', '620622', '古浪县', '3223');
INSERT INTO `wp_shop_nation` VALUES ('3228', '620623', '天祝藏族自治县', '3223');
INSERT INTO `wp_shop_nation` VALUES ('3229', '620700', '张掖市', '3190');
INSERT INTO `wp_shop_nation` VALUES ('3230', '620701', '市辖区', '3229');
INSERT INTO `wp_shop_nation` VALUES ('3231', '620702', '甘州区', '3229');
INSERT INTO `wp_shop_nation` VALUES ('3232', '620721', '肃南裕固族自治县', '3229');
INSERT INTO `wp_shop_nation` VALUES ('3233', '620722', '民乐县', '3229');
INSERT INTO `wp_shop_nation` VALUES ('3234', '620723', '临泽县', '3229');
INSERT INTO `wp_shop_nation` VALUES ('3235', '620724', '高台县', '3229');
INSERT INTO `wp_shop_nation` VALUES ('3236', '620725', '山丹县', '3229');
INSERT INTO `wp_shop_nation` VALUES ('3237', '620800', '平凉市', '3190');
INSERT INTO `wp_shop_nation` VALUES ('3238', '620801', '市辖区', '3237');
INSERT INTO `wp_shop_nation` VALUES ('3239', '620802', '崆峒区', '3237');
INSERT INTO `wp_shop_nation` VALUES ('3240', '620821', '泾川县', '3237');
INSERT INTO `wp_shop_nation` VALUES ('3241', '620822', '灵台县', '3237');
INSERT INTO `wp_shop_nation` VALUES ('3242', '620823', '崇信县', '3237');
INSERT INTO `wp_shop_nation` VALUES ('3243', '620824', '华亭县', '3237');
INSERT INTO `wp_shop_nation` VALUES ('3244', '620825', '庄浪县', '3237');
INSERT INTO `wp_shop_nation` VALUES ('3245', '620826', '静宁县', '3237');
INSERT INTO `wp_shop_nation` VALUES ('3246', '620900', '酒泉市', '3190');
INSERT INTO `wp_shop_nation` VALUES ('3247', '620901', '市辖区', '3246');
INSERT INTO `wp_shop_nation` VALUES ('3248', '620902', '肃州区', '3246');
INSERT INTO `wp_shop_nation` VALUES ('3249', '620921', '金塔县', '3246');
INSERT INTO `wp_shop_nation` VALUES ('3250', '620922', '瓜州县', '3246');
INSERT INTO `wp_shop_nation` VALUES ('3251', '620923', '肃北蒙古族自治县', '3246');
INSERT INTO `wp_shop_nation` VALUES ('3252', '620924', '阿克塞哈萨克族自治县', '3246');
INSERT INTO `wp_shop_nation` VALUES ('3253', '620981', '玉门市', '3246');
INSERT INTO `wp_shop_nation` VALUES ('3254', '620982', '敦煌市', '3246');
INSERT INTO `wp_shop_nation` VALUES ('3255', '621000', '庆阳市', '3190');
INSERT INTO `wp_shop_nation` VALUES ('3256', '621001', '市辖区', '3255');
INSERT INTO `wp_shop_nation` VALUES ('3257', '621002', '西峰区', '3255');
INSERT INTO `wp_shop_nation` VALUES ('3258', '621021', '庆城县', '3255');
INSERT INTO `wp_shop_nation` VALUES ('3259', '621022', '环县', '3255');
INSERT INTO `wp_shop_nation` VALUES ('3260', '621023', '华池县', '3255');
INSERT INTO `wp_shop_nation` VALUES ('3261', '621024', '合水县', '3255');
INSERT INTO `wp_shop_nation` VALUES ('3262', '621025', '正宁县', '3255');
INSERT INTO `wp_shop_nation` VALUES ('3263', '621026', '宁县', '3255');
INSERT INTO `wp_shop_nation` VALUES ('3264', '621027', '镇原县', '3255');
INSERT INTO `wp_shop_nation` VALUES ('3265', '621100', '定西市', '3190');
INSERT INTO `wp_shop_nation` VALUES ('3266', '621101', '市辖区', '3265');
INSERT INTO `wp_shop_nation` VALUES ('3267', '621102', '安定区', '3265');
INSERT INTO `wp_shop_nation` VALUES ('3268', '621121', '通渭县', '3265');
INSERT INTO `wp_shop_nation` VALUES ('3269', '621122', '陇西县', '3265');
INSERT INTO `wp_shop_nation` VALUES ('3270', '621123', '渭源县', '3265');
INSERT INTO `wp_shop_nation` VALUES ('3271', '621124', '临洮县', '3265');
INSERT INTO `wp_shop_nation` VALUES ('3272', '621125', '漳县', '3265');
INSERT INTO `wp_shop_nation` VALUES ('3273', '621126', '岷县', '3265');
INSERT INTO `wp_shop_nation` VALUES ('3274', '621200', '陇南市', '3190');
INSERT INTO `wp_shop_nation` VALUES ('3275', '621201', '市辖区', '3274');
INSERT INTO `wp_shop_nation` VALUES ('3276', '621202', '武都区', '3274');
INSERT INTO `wp_shop_nation` VALUES ('3277', '621221', '成县', '3274');
INSERT INTO `wp_shop_nation` VALUES ('3278', '621222', '文县', '3274');
INSERT INTO `wp_shop_nation` VALUES ('3279', '621223', '宕昌县', '3274');
INSERT INTO `wp_shop_nation` VALUES ('3280', '621224', '康县', '3274');
INSERT INTO `wp_shop_nation` VALUES ('3281', '621225', '西和县', '3274');
INSERT INTO `wp_shop_nation` VALUES ('3282', '621226', '礼县', '3274');
INSERT INTO `wp_shop_nation` VALUES ('3283', '621227', '徽县', '3274');
INSERT INTO `wp_shop_nation` VALUES ('3284', '621228', '两当县', '3274');
INSERT INTO `wp_shop_nation` VALUES ('3285', '622900', '临夏回族自治州', '3190');
INSERT INTO `wp_shop_nation` VALUES ('3286', '622901', '临夏市', '3285');
INSERT INTO `wp_shop_nation` VALUES ('3287', '622921', '临夏县', '3285');
INSERT INTO `wp_shop_nation` VALUES ('3288', '622922', '康乐县', '3285');
INSERT INTO `wp_shop_nation` VALUES ('3289', '622923', '永靖县', '3285');
INSERT INTO `wp_shop_nation` VALUES ('3290', '622924', '广河县', '3285');
INSERT INTO `wp_shop_nation` VALUES ('3291', '622925', '和政县', '3285');
INSERT INTO `wp_shop_nation` VALUES ('3292', '622926', '东乡族自治县', '3285');
INSERT INTO `wp_shop_nation` VALUES ('3293', '622927', '积石山保安族东乡族撒拉族自治县', '3285');
INSERT INTO `wp_shop_nation` VALUES ('3294', '623000', '甘南藏族自治州', '3190');
INSERT INTO `wp_shop_nation` VALUES ('3295', '623001', '合作市', '3294');
INSERT INTO `wp_shop_nation` VALUES ('3296', '623021', '临潭县', '3294');
INSERT INTO `wp_shop_nation` VALUES ('3297', '623022', '卓尼县', '3294');
INSERT INTO `wp_shop_nation` VALUES ('3298', '623023', '舟曲县', '3294');
INSERT INTO `wp_shop_nation` VALUES ('3299', '623024', '迭部县', '3294');
INSERT INTO `wp_shop_nation` VALUES ('3300', '623025', '玛曲县', '3294');
INSERT INTO `wp_shop_nation` VALUES ('3301', '623026', '碌曲县', '3294');
INSERT INTO `wp_shop_nation` VALUES ('3302', '623027', '夏河县', '3294');
INSERT INTO `wp_shop_nation` VALUES ('3303', '630000', '青海省', '0');
INSERT INTO `wp_shop_nation` VALUES ('3304', '630100', '西宁市', '3303');
INSERT INTO `wp_shop_nation` VALUES ('3305', '630101', '市辖区', '3304');
INSERT INTO `wp_shop_nation` VALUES ('3306', '630102', '城东区', '3304');
INSERT INTO `wp_shop_nation` VALUES ('3307', '630103', '城中区', '3304');
INSERT INTO `wp_shop_nation` VALUES ('3308', '630104', '城西区', '3304');
INSERT INTO `wp_shop_nation` VALUES ('3309', '630105', '城北区', '3304');
INSERT INTO `wp_shop_nation` VALUES ('3310', '630121', '大通回族土族自治县', '3304');
INSERT INTO `wp_shop_nation` VALUES ('3311', '630122', '湟中县', '3304');
INSERT INTO `wp_shop_nation` VALUES ('3312', '630123', '湟源县', '3304');
INSERT INTO `wp_shop_nation` VALUES ('3313', '630200', '海东市', '3303');
INSERT INTO `wp_shop_nation` VALUES ('3314', '630201', '市辖区', '3313');
INSERT INTO `wp_shop_nation` VALUES ('3315', '630202', '乐都区', '3313');
INSERT INTO `wp_shop_nation` VALUES ('3316', '630221', '平安县', '3313');
INSERT INTO `wp_shop_nation` VALUES ('3317', '630222', '民和回族土族自治县', '3313');
INSERT INTO `wp_shop_nation` VALUES ('3318', '630223', '互助土族自治县', '3313');
INSERT INTO `wp_shop_nation` VALUES ('3319', '630224', '化隆回族自治县', '3313');
INSERT INTO `wp_shop_nation` VALUES ('3320', '630225', '循化撒拉族自治县', '3313');
INSERT INTO `wp_shop_nation` VALUES ('3321', '632200', '海北藏族自治州', '3303');
INSERT INTO `wp_shop_nation` VALUES ('3322', '632221', '门源回族自治县', '3321');
INSERT INTO `wp_shop_nation` VALUES ('3323', '632222', '祁连县', '3321');
INSERT INTO `wp_shop_nation` VALUES ('3324', '632223', '海晏县', '3321');
INSERT INTO `wp_shop_nation` VALUES ('3325', '632224', '刚察县', '3321');
INSERT INTO `wp_shop_nation` VALUES ('3326', '632300', '黄南藏族自治州', '3303');
INSERT INTO `wp_shop_nation` VALUES ('3327', '632321', '同仁县', '3326');
INSERT INTO `wp_shop_nation` VALUES ('3328', '632322', '尖扎县', '3326');
INSERT INTO `wp_shop_nation` VALUES ('3329', '632323', '泽库县', '3326');
INSERT INTO `wp_shop_nation` VALUES ('3330', '632324', '河南蒙古族自治县', '3326');
INSERT INTO `wp_shop_nation` VALUES ('3331', '632500', '海南藏族自治州', '3303');
INSERT INTO `wp_shop_nation` VALUES ('3332', '632521', '共和县', '3331');
INSERT INTO `wp_shop_nation` VALUES ('3333', '632522', '同德县', '3331');
INSERT INTO `wp_shop_nation` VALUES ('3334', '632523', '贵德县', '3331');
INSERT INTO `wp_shop_nation` VALUES ('3335', '632524', '兴海县', '3331');
INSERT INTO `wp_shop_nation` VALUES ('3336', '632525', '贵南县', '3331');
INSERT INTO `wp_shop_nation` VALUES ('3337', '632600', '果洛藏族自治州', '3303');
INSERT INTO `wp_shop_nation` VALUES ('3338', '632621', '玛沁县', '3337');
INSERT INTO `wp_shop_nation` VALUES ('3339', '632622', '班玛县', '3337');
INSERT INTO `wp_shop_nation` VALUES ('3340', '632623', '甘德县', '3337');
INSERT INTO `wp_shop_nation` VALUES ('3341', '632624', '达日县', '3337');
INSERT INTO `wp_shop_nation` VALUES ('3342', '632625', '久治县', '3337');
INSERT INTO `wp_shop_nation` VALUES ('3343', '632626', '玛多县', '3337');
INSERT INTO `wp_shop_nation` VALUES ('3344', '632700', '玉树藏族自治州', '3303');
INSERT INTO `wp_shop_nation` VALUES ('3345', '632701', '玉树市', '3344');
INSERT INTO `wp_shop_nation` VALUES ('3346', '632722', '杂多县', '3344');
INSERT INTO `wp_shop_nation` VALUES ('3347', '632723', '称多县', '3344');
INSERT INTO `wp_shop_nation` VALUES ('3348', '632724', '治多县', '3344');
INSERT INTO `wp_shop_nation` VALUES ('3349', '632725', '囊谦县', '3344');
INSERT INTO `wp_shop_nation` VALUES ('3350', '632726', '曲麻莱县', '3344');
INSERT INTO `wp_shop_nation` VALUES ('3351', '632800', '海西蒙古族藏族自治州', '3303');
INSERT INTO `wp_shop_nation` VALUES ('3352', '632801', '格尔木市', '3351');
INSERT INTO `wp_shop_nation` VALUES ('3353', '632802', '德令哈市', '3351');
INSERT INTO `wp_shop_nation` VALUES ('3354', '632821', '乌兰县', '3351');
INSERT INTO `wp_shop_nation` VALUES ('3355', '632822', '都兰县', '3351');
INSERT INTO `wp_shop_nation` VALUES ('3356', '632823', '天峻县', '3351');
INSERT INTO `wp_shop_nation` VALUES ('3357', '640000', '宁夏回族自治区', '0');
INSERT INTO `wp_shop_nation` VALUES ('3358', '640100', '银川市', '3357');
INSERT INTO `wp_shop_nation` VALUES ('3359', '640101', '市辖区', '3358');
INSERT INTO `wp_shop_nation` VALUES ('3360', '640104', '兴庆区', '3358');
INSERT INTO `wp_shop_nation` VALUES ('3361', '640105', '西夏区', '3358');
INSERT INTO `wp_shop_nation` VALUES ('3362', '640106', '金凤区', '3358');
INSERT INTO `wp_shop_nation` VALUES ('3363', '640121', '永宁县', '3358');
INSERT INTO `wp_shop_nation` VALUES ('3364', '640122', '贺兰县', '3358');
INSERT INTO `wp_shop_nation` VALUES ('3365', '640181', '灵武市', '3358');
INSERT INTO `wp_shop_nation` VALUES ('3366', '640200', '石嘴山市', '3357');
INSERT INTO `wp_shop_nation` VALUES ('3367', '640201', '市辖区', '3366');
INSERT INTO `wp_shop_nation` VALUES ('3368', '640202', '大武口区', '3366');
INSERT INTO `wp_shop_nation` VALUES ('3369', '640205', '惠农区', '3366');
INSERT INTO `wp_shop_nation` VALUES ('3370', '640221', '平罗县', '3366');
INSERT INTO `wp_shop_nation` VALUES ('3371', '640300', '吴忠市', '3357');
INSERT INTO `wp_shop_nation` VALUES ('3372', '640301', '市辖区', '3371');
INSERT INTO `wp_shop_nation` VALUES ('3373', '640302', '利通区', '3371');
INSERT INTO `wp_shop_nation` VALUES ('3374', '640303', '红寺堡区', '3371');
INSERT INTO `wp_shop_nation` VALUES ('3375', '640323', '盐池县', '3371');
INSERT INTO `wp_shop_nation` VALUES ('3376', '640324', '同心县', '3371');
INSERT INTO `wp_shop_nation` VALUES ('3377', '640381', '青铜峡市', '3371');
INSERT INTO `wp_shop_nation` VALUES ('3378', '640400', '固原市', '3357');
INSERT INTO `wp_shop_nation` VALUES ('3379', '640401', '市辖区', '3378');
INSERT INTO `wp_shop_nation` VALUES ('3380', '640402', '原州区', '3378');
INSERT INTO `wp_shop_nation` VALUES ('3381', '640422', '西吉县', '3378');
INSERT INTO `wp_shop_nation` VALUES ('3382', '640423', '隆德县', '3378');
INSERT INTO `wp_shop_nation` VALUES ('3383', '640424', '泾源县', '3378');
INSERT INTO `wp_shop_nation` VALUES ('3384', '640425', '彭阳县', '3378');
INSERT INTO `wp_shop_nation` VALUES ('3385', '640500', '中卫市', '3357');
INSERT INTO `wp_shop_nation` VALUES ('3386', '640501', '市辖区', '3385');
INSERT INTO `wp_shop_nation` VALUES ('3387', '640502', '沙坡头区', '3385');
INSERT INTO `wp_shop_nation` VALUES ('3388', '640521', '中宁县', '3385');
INSERT INTO `wp_shop_nation` VALUES ('3389', '640522', '海原县', '3385');
INSERT INTO `wp_shop_nation` VALUES ('3390', '650000', '新疆维吾尔自治区', '0');
INSERT INTO `wp_shop_nation` VALUES ('3391', '650100', '乌鲁木齐市', '3390');
INSERT INTO `wp_shop_nation` VALUES ('3392', '650101', '市辖区', '3391');
INSERT INTO `wp_shop_nation` VALUES ('3393', '650102', '天山区', '3391');
INSERT INTO `wp_shop_nation` VALUES ('3394', '650103', '沙依巴克区', '3391');
INSERT INTO `wp_shop_nation` VALUES ('3395', '650104', '新市区', '3391');
INSERT INTO `wp_shop_nation` VALUES ('3396', '650105', '水磨沟区', '3391');
INSERT INTO `wp_shop_nation` VALUES ('3397', '650106', '头屯河区', '3391');
INSERT INTO `wp_shop_nation` VALUES ('3398', '650107', '达坂城区', '3391');
INSERT INTO `wp_shop_nation` VALUES ('3399', '650109', '米东区', '3391');
INSERT INTO `wp_shop_nation` VALUES ('3400', '650121', '乌鲁木齐县', '3391');
INSERT INTO `wp_shop_nation` VALUES ('3401', '650200', '克拉玛依市', '3390');
INSERT INTO `wp_shop_nation` VALUES ('3402', '650201', '市辖区', '3401');
INSERT INTO `wp_shop_nation` VALUES ('3403', '650202', '独山子区', '3401');
INSERT INTO `wp_shop_nation` VALUES ('3404', '650203', '克拉玛依区', '3401');
INSERT INTO `wp_shop_nation` VALUES ('3405', '650204', '白碱滩区', '3401');
INSERT INTO `wp_shop_nation` VALUES ('3406', '650205', '乌尔禾区', '3401');
INSERT INTO `wp_shop_nation` VALUES ('3407', '652100', '吐鲁番地区', '3390');
INSERT INTO `wp_shop_nation` VALUES ('3408', '652101', '吐鲁番市', '3407');
INSERT INTO `wp_shop_nation` VALUES ('3409', '652122', '鄯善县', '3407');
INSERT INTO `wp_shop_nation` VALUES ('3410', '652123', '托克逊县', '3407');
INSERT INTO `wp_shop_nation` VALUES ('3411', '652200', '哈密地区', '3390');
INSERT INTO `wp_shop_nation` VALUES ('3412', '652201', '哈密市', '3411');
INSERT INTO `wp_shop_nation` VALUES ('3413', '652222', '巴里坤哈萨克自治县', '3411');
INSERT INTO `wp_shop_nation` VALUES ('3414', '652223', '伊吾县', '3411');
INSERT INTO `wp_shop_nation` VALUES ('3415', '652300', '昌吉回族自治州', '3390');
INSERT INTO `wp_shop_nation` VALUES ('3416', '652301', '昌吉市', '3415');
INSERT INTO `wp_shop_nation` VALUES ('3417', '652302', '阜康市', '3415');
INSERT INTO `wp_shop_nation` VALUES ('3418', '652323', '呼图壁县', '3415');
INSERT INTO `wp_shop_nation` VALUES ('3419', '652324', '玛纳斯县', '3415');
INSERT INTO `wp_shop_nation` VALUES ('3420', '652325', '奇台县', '3415');
INSERT INTO `wp_shop_nation` VALUES ('3421', '652327', '吉木萨尔县', '3415');
INSERT INTO `wp_shop_nation` VALUES ('3422', '652328', '木垒哈萨克自治县', '3415');
INSERT INTO `wp_shop_nation` VALUES ('3423', '652700', '博尔塔拉蒙古自治州', '3390');
INSERT INTO `wp_shop_nation` VALUES ('3424', '652701', '博乐市', '3423');
INSERT INTO `wp_shop_nation` VALUES ('3425', '652702', '阿拉山口市', '3423');
INSERT INTO `wp_shop_nation` VALUES ('3426', '652722', '精河县', '3423');
INSERT INTO `wp_shop_nation` VALUES ('3427', '652723', '温泉县', '3423');
INSERT INTO `wp_shop_nation` VALUES ('3428', '652800', '巴音郭楞蒙古自治州', '3390');
INSERT INTO `wp_shop_nation` VALUES ('3429', '652801', '库尔勒市', '3428');
INSERT INTO `wp_shop_nation` VALUES ('3430', '652822', '轮台县', '3428');
INSERT INTO `wp_shop_nation` VALUES ('3431', '652823', '尉犁县', '3428');
INSERT INTO `wp_shop_nation` VALUES ('3432', '652824', '若羌县', '3428');
INSERT INTO `wp_shop_nation` VALUES ('3433', '652825', '且末县', '3428');
INSERT INTO `wp_shop_nation` VALUES ('3434', '652826', '焉耆回族自治县', '3428');
INSERT INTO `wp_shop_nation` VALUES ('3435', '652827', '和静县', '3428');
INSERT INTO `wp_shop_nation` VALUES ('3436', '652828', '和硕县', '3428');
INSERT INTO `wp_shop_nation` VALUES ('3437', '652829', '博湖县', '3428');
INSERT INTO `wp_shop_nation` VALUES ('3438', '652900', '阿克苏地区', '3390');
INSERT INTO `wp_shop_nation` VALUES ('3439', '652901', '阿克苏市', '3438');
INSERT INTO `wp_shop_nation` VALUES ('3440', '652922', '温宿县', '3438');
INSERT INTO `wp_shop_nation` VALUES ('3441', '652923', '库车县', '3438');
INSERT INTO `wp_shop_nation` VALUES ('3442', '652924', '沙雅县', '3438');
INSERT INTO `wp_shop_nation` VALUES ('3443', '652925', '新和县', '3438');
INSERT INTO `wp_shop_nation` VALUES ('3444', '652926', '拜城县', '3438');
INSERT INTO `wp_shop_nation` VALUES ('3445', '652927', '乌什县', '3438');
INSERT INTO `wp_shop_nation` VALUES ('3446', '652928', '阿瓦提县', '3438');
INSERT INTO `wp_shop_nation` VALUES ('3447', '652929', '柯坪县', '3438');
INSERT INTO `wp_shop_nation` VALUES ('3448', '653000', '克孜勒苏柯尔克孜自治州', '3390');
INSERT INTO `wp_shop_nation` VALUES ('3449', '653001', '阿图什市', '3448');
INSERT INTO `wp_shop_nation` VALUES ('3450', '653022', '阿克陶县', '3448');
INSERT INTO `wp_shop_nation` VALUES ('3451', '653023', '阿合奇县', '3448');
INSERT INTO `wp_shop_nation` VALUES ('3452', '653024', '乌恰县', '3448');
INSERT INTO `wp_shop_nation` VALUES ('3453', '653100', '喀什地区', '3390');
INSERT INTO `wp_shop_nation` VALUES ('3454', '653101', '喀什市', '3453');
INSERT INTO `wp_shop_nation` VALUES ('3455', '653121', '疏附县', '3453');
INSERT INTO `wp_shop_nation` VALUES ('3456', '653122', '疏勒县', '3453');
INSERT INTO `wp_shop_nation` VALUES ('3457', '653123', '英吉沙县', '3453');
INSERT INTO `wp_shop_nation` VALUES ('3458', '653124', '泽普县', '3453');
INSERT INTO `wp_shop_nation` VALUES ('3459', '653125', '莎车县', '3453');
INSERT INTO `wp_shop_nation` VALUES ('3460', '653126', '叶城县', '3453');
INSERT INTO `wp_shop_nation` VALUES ('3461', '653127', '麦盖提县', '3453');
INSERT INTO `wp_shop_nation` VALUES ('3462', '653128', '岳普湖县', '3453');
INSERT INTO `wp_shop_nation` VALUES ('3463', '653129', '伽师县', '3453');
INSERT INTO `wp_shop_nation` VALUES ('3464', '653130', '巴楚县', '3453');
INSERT INTO `wp_shop_nation` VALUES ('3465', '653131', '塔什库尔干塔吉克自治县', '3453');
INSERT INTO `wp_shop_nation` VALUES ('3466', '653200', '和田地区', '3390');
INSERT INTO `wp_shop_nation` VALUES ('3467', '653201', '和田市', '3466');
INSERT INTO `wp_shop_nation` VALUES ('3468', '653221', '和田县', '3466');
INSERT INTO `wp_shop_nation` VALUES ('3469', '653222', '墨玉县', '3466');
INSERT INTO `wp_shop_nation` VALUES ('3470', '653223', '皮山县', '3466');
INSERT INTO `wp_shop_nation` VALUES ('3471', '653224', '洛浦县', '3466');
INSERT INTO `wp_shop_nation` VALUES ('3472', '653225', '策勒县', '3466');
INSERT INTO `wp_shop_nation` VALUES ('3473', '653226', '于田县', '3466');
INSERT INTO `wp_shop_nation` VALUES ('3474', '653227', '民丰县', '3466');
INSERT INTO `wp_shop_nation` VALUES ('3475', '654000', '伊犁哈萨克自治州', '3390');
INSERT INTO `wp_shop_nation` VALUES ('3476', '654002', '伊宁市', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3477', '654003', '奎屯市', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3478', '654004', '霍尔果斯市', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3479', '654021', '伊宁县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3480', '654022', '察布查尔锡伯自治县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3481', '654023', '霍城县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3482', '654024', '巩留县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3483', '654025', '新源县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3484', '654026', '昭苏县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3485', '654027', '特克斯县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3486', '654028', '尼勒克县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3487', '654200', '塔城地区', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3488', '654201', '塔城市', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3489', '654202', '乌苏市', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3490', '654221', '额敏县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3491', '654223', '沙湾县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3492', '654224', '托里县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3493', '654225', '裕民县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3494', '654226', '和布克赛尔蒙古自治县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3495', '654300', '阿勒泰地区', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3496', '654301', '阿勒泰市', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3497', '654321', '布尔津县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3498', '654322', '富蕴县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3499', '654323', '福海县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3500', '654324', '哈巴河县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3501', '654325', '青河县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3502', '654326', '吉木乃县', '3475');
INSERT INTO `wp_shop_nation` VALUES ('3503', '659000', '自治区直辖县级行政区划', '3390');
INSERT INTO `wp_shop_nation` VALUES ('3504', '659001', '石河子市', '3503');
INSERT INTO `wp_shop_nation` VALUES ('3505', '659002', '阿拉尔市', '3503');
INSERT INTO `wp_shop_nation` VALUES ('3506', '659003', '图木舒克市', '3503');
INSERT INTO `wp_shop_nation` VALUES ('3507', '659004', '五家渠市', '3503');
INSERT INTO `wp_shop_nation` VALUES ('3508', '659005', '北屯市', '3503');
INSERT INTO `wp_shop_nation` VALUES ('3509', '659006', '铁门关市', '3503');
INSERT INTO `wp_shop_nation` VALUES ('3510', '659007', '双河市', '3503');
INSERT INTO `wp_shop_nation` VALUES ('3511', '710000', '台湾省', '0');
INSERT INTO `wp_shop_nation` VALUES ('3512', '710100', '台北市', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3513', '710101', '松山区', '3512');
INSERT INTO `wp_shop_nation` VALUES ('3514', '710102', '信义区', '3512');
INSERT INTO `wp_shop_nation` VALUES ('3515', '710103', '大安区', '3512');
INSERT INTO `wp_shop_nation` VALUES ('3516', '710104', '中山区', '3512');
INSERT INTO `wp_shop_nation` VALUES ('3517', '710105', '中正区', '3512');
INSERT INTO `wp_shop_nation` VALUES ('3518', '710106', '大同区', '3512');
INSERT INTO `wp_shop_nation` VALUES ('3519', '710107', '万华区', '3512');
INSERT INTO `wp_shop_nation` VALUES ('3520', '710108', '文山区', '3512');
INSERT INTO `wp_shop_nation` VALUES ('3521', '710109', '南港区', '3512');
INSERT INTO `wp_shop_nation` VALUES ('3522', '710110', '内湖区', '3512');
INSERT INTO `wp_shop_nation` VALUES ('3523', '710111', '士林区', '3512');
INSERT INTO `wp_shop_nation` VALUES ('3524', '710112', '北投区', '3512');
INSERT INTO `wp_shop_nation` VALUES ('3525', '710200', '高雄市', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3526', '710201', '盐埕区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3527', '710202', '鼓山区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3528', '710203', '左营区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3529', '710204', '楠梓区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3530', '710205', '三民区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3531', '710206', '新兴区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3532', '710207', '前金区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3533', '710208', '苓雅区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3534', '710209', '前镇区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3535', '710210', '旗津区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3536', '710211', '小港区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3537', '710212', '凤山区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3538', '710213', '林园区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3539', '710214', '大寮区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3540', '710215', '大树区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3541', '710216', '大社区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3542', '710217', '仁武区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3543', '710218', '鸟松区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3544', '710219', '冈山区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3545', '710220', '桥头区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3546', '710221', '燕巢区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3547', '710222', '田寮区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3548', '710223', '阿莲区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3549', '710224', '路竹区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3550', '710225', '湖内区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3551', '710226', '茄萣区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3552', '710227', '永安区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3553', '710228', '弥陀区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3554', '710229', '梓官区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3555', '710230', '旗山区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3556', '710231', '美浓区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3557', '710232', '六龟区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3558', '710233', '甲仙区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3559', '710234', '杉林区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3560', '710235', '内门区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3561', '710236', '茂林区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3562', '710237', '桃源区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3563', '710238', '那玛夏区', '3525');
INSERT INTO `wp_shop_nation` VALUES ('3564', '710300', '基隆市', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3565', '710301', '中正区', '3564');
INSERT INTO `wp_shop_nation` VALUES ('3566', '710302', '七堵区', '3564');
INSERT INTO `wp_shop_nation` VALUES ('3567', '710303', '暖暖区', '3564');
INSERT INTO `wp_shop_nation` VALUES ('3568', '710304', '仁爱区', '3564');
INSERT INTO `wp_shop_nation` VALUES ('3569', '710305', '中山区', '3564');
INSERT INTO `wp_shop_nation` VALUES ('3570', '710306', '安乐区', '3564');
INSERT INTO `wp_shop_nation` VALUES ('3571', '710307', '信义区', '3564');
INSERT INTO `wp_shop_nation` VALUES ('3572', '710400', '台中市', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3573', '710401', '中区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3574', '710402', '东区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3575', '710403', '南区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3576', '710404', '西区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3577', '710405', '北区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3578', '710406', '西屯区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3579', '710407', '南屯区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3580', '710408', '北屯区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3581', '710409', '丰原区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3582', '710410', '东势区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3583', '710411', '大甲区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3584', '710412', '清水区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3585', '710413', '沙鹿区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3586', '710414', '梧栖区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3587', '710415', '后里区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3588', '710416', '神冈区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3589', '710417', '潭子区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3590', '710418', '大雅区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3591', '710419', '新社区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3592', '710420', '石冈区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3593', '710421', '外埔区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3594', '710422', '大安区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3595', '710423', '乌日区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3596', '710424', '大肚区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3597', '710425', '龙井区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3598', '710426', '雾峰区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3599', '710427', '太平区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3600', '710428', '大里区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3601', '710429', '和平区', '3572');
INSERT INTO `wp_shop_nation` VALUES ('3602', '710500', '台南市', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3603', '710501', '东区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3604', '710502', '南区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3605', '710504', '北区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3606', '710506', '安南区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3607', '710507', '安平区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3608', '710508', '中西区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3609', '710509', '新营区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3610', '710510', '盐水区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3611', '710511', '白河区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3612', '710512', '柳营区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3613', '710513', '后壁区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3614', '710514', '东山区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3615', '710515', '麻豆区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3616', '710516', '下营区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3617', '710517', '六甲区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3618', '710518', '官田区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3619', '710519', '大内区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3620', '710520', '佳里区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3621', '710521', '学甲区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3622', '710522', '西港区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3623', '710523', '七股区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3624', '710524', '将军区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3625', '710525', '北门区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3626', '710526', '新化区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3627', '710527', '善化区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3628', '710528', '新市区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3629', '710529', '安定区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3630', '710530', '山上区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3631', '710531', '玉井区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3632', '710532', '楠西区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3633', '710533', '南化区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3634', '710534', '左镇区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3635', '710535', '仁德区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3636', '710536', '归仁区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3637', '710537', '关庙区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3638', '710538', '龙崎区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3639', '710539', '永康区', '3602');
INSERT INTO `wp_shop_nation` VALUES ('3640', '710600', '新竹市', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3641', '710601', '东区', '3640');
INSERT INTO `wp_shop_nation` VALUES ('3642', '710602', '北区', '3640');
INSERT INTO `wp_shop_nation` VALUES ('3643', '710603', '香山区', '3640');
INSERT INTO `wp_shop_nation` VALUES ('3644', '710700', '嘉义市', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3645', '710701', '东区', '3644');
INSERT INTO `wp_shop_nation` VALUES ('3646', '710702', '西区', '3644');
INSERT INTO `wp_shop_nation` VALUES ('3647', '710800', '新北市', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3648', '710801', '板桥区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3649', '710802', '三重区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3650', '710803', '中和区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3651', '710804', '永和区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3652', '710805', '新庄区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3653', '710806', '新店区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3654', '710807', '树林区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3655', '710808', '莺歌区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3656', '710809', '三峡区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3657', '710810', '淡水区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3658', '710811', '汐止区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3659', '710812', '瑞芳区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3660', '710813', '土城区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3661', '710814', '芦洲区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3662', '710815', '五股区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3663', '710816', '泰山区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3664', '710817', '林口区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3665', '710818', '深坑区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3666', '710819', '石碇区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3667', '710820', '坪林区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3668', '710821', '三芝区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3669', '710822', '石门区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3670', '710823', '八里区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3671', '710824', '平溪区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3672', '710825', '双溪区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3673', '710826', '贡寮区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3674', '710827', '金山区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3675', '710828', '万里区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3676', '710829', '乌来区', '3647');
INSERT INTO `wp_shop_nation` VALUES ('3677', '712200', '宜兰县', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3678', '712201', '宜兰市', '3677');
INSERT INTO `wp_shop_nation` VALUES ('3679', '712221', '罗东镇', '3677');
INSERT INTO `wp_shop_nation` VALUES ('3680', '712222', '苏澳镇', '3677');
INSERT INTO `wp_shop_nation` VALUES ('3681', '712223', '头城镇', '3677');
INSERT INTO `wp_shop_nation` VALUES ('3682', '712224', '礁溪乡', '3677');
INSERT INTO `wp_shop_nation` VALUES ('3683', '712225', '壮围乡', '3677');
INSERT INTO `wp_shop_nation` VALUES ('3684', '712226', '员山乡', '3677');
INSERT INTO `wp_shop_nation` VALUES ('3685', '712227', '冬山乡', '3677');
INSERT INTO `wp_shop_nation` VALUES ('3686', '712228', '五结乡', '3677');
INSERT INTO `wp_shop_nation` VALUES ('3687', '712229', '三星乡', '3677');
INSERT INTO `wp_shop_nation` VALUES ('3688', '712230', '大同乡', '3677');
INSERT INTO `wp_shop_nation` VALUES ('3689', '712231', '南澳乡', '3677');
INSERT INTO `wp_shop_nation` VALUES ('3690', '712300', '桃园县', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3691', '712301', '桃园市', '3690');
INSERT INTO `wp_shop_nation` VALUES ('3692', '712302', '中坜市', '3690');
INSERT INTO `wp_shop_nation` VALUES ('3693', '712303', '平镇市', '3690');
INSERT INTO `wp_shop_nation` VALUES ('3694', '712304', '八德市', '3690');
INSERT INTO `wp_shop_nation` VALUES ('3695', '712305', '杨梅市', '3690');
INSERT INTO `wp_shop_nation` VALUES ('3696', '712321', '大溪镇', '3690');
INSERT INTO `wp_shop_nation` VALUES ('3697', '712323', '芦竹乡', '3690');
INSERT INTO `wp_shop_nation` VALUES ('3698', '712324', '大园乡', '3690');
INSERT INTO `wp_shop_nation` VALUES ('3699', '712325', '龟山乡', '3690');
INSERT INTO `wp_shop_nation` VALUES ('3700', '712327', '龙潭乡', '3690');
INSERT INTO `wp_shop_nation` VALUES ('3701', '712329', '新屋乡', '3690');
INSERT INTO `wp_shop_nation` VALUES ('3702', '712330', '观音乡', '3690');
INSERT INTO `wp_shop_nation` VALUES ('3703', '712331', '复兴乡', '3690');
INSERT INTO `wp_shop_nation` VALUES ('3704', '712400', '新竹县', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3705', '712401', '竹北市', '3704');
INSERT INTO `wp_shop_nation` VALUES ('3706', '712421', '竹东镇', '3704');
INSERT INTO `wp_shop_nation` VALUES ('3707', '712422', '新埔镇', '3704');
INSERT INTO `wp_shop_nation` VALUES ('3708', '712423', '关西镇', '3704');
INSERT INTO `wp_shop_nation` VALUES ('3709', '712424', '湖口乡', '3704');
INSERT INTO `wp_shop_nation` VALUES ('3710', '712425', '新丰乡', '3704');
INSERT INTO `wp_shop_nation` VALUES ('3711', '712426', '芎林乡', '3704');
INSERT INTO `wp_shop_nation` VALUES ('3712', '712427', '橫山乡', '3704');
INSERT INTO `wp_shop_nation` VALUES ('3713', '712428', '北埔乡', '3704');
INSERT INTO `wp_shop_nation` VALUES ('3714', '712429', '宝山乡', '3704');
INSERT INTO `wp_shop_nation` VALUES ('3715', '712430', '峨眉乡', '3704');
INSERT INTO `wp_shop_nation` VALUES ('3716', '712431', '尖石乡', '3704');
INSERT INTO `wp_shop_nation` VALUES ('3717', '712432', '五峰乡', '3704');
INSERT INTO `wp_shop_nation` VALUES ('3718', '712500', '苗栗县', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3719', '712501', '苗栗市', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3720', '712521', '苑里镇', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3721', '712522', '通霄镇', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3722', '712523', '竹南镇', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3723', '712524', '头份镇', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3724', '712525', '后龙镇', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3725', '712526', '卓兰镇', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3726', '712527', '大湖乡', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3727', '712528', '公馆乡', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3728', '712529', '铜锣乡', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3729', '712530', '南庄乡', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3730', '712531', '头屋乡', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3731', '712532', '三义乡', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3732', '712533', '西湖乡', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3733', '712534', '造桥乡', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3734', '712535', '三湾乡', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3735', '712536', '狮潭乡', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3736', '712537', '泰安乡', '3718');
INSERT INTO `wp_shop_nation` VALUES ('3737', '712700', '彰化县', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3738', '712701', '彰化市', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3739', '712721', '鹿港镇', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3740', '712722', '和美镇', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3741', '712723', '线西乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3742', '712724', '伸港乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3743', '712725', '福兴乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3744', '712726', '秀水乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3745', '712727', '花坛乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3746', '712728', '芬园乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3747', '712729', '员林镇', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3748', '712730', '溪湖镇', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3749', '712731', '田中镇', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3750', '712732', '大村乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3751', '712733', '埔盐乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3752', '712734', '埔心乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3753', '712735', '永靖乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3754', '712736', '社头乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3755', '712737', '二水乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3756', '712738', '北斗镇', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3757', '712739', '二林镇', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3758', '712740', '田尾乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3759', '712741', '埤头乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3760', '712742', '芳苑乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3761', '712743', '大城乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3762', '712744', '竹塘乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3763', '712745', '溪州乡', '3737');
INSERT INTO `wp_shop_nation` VALUES ('3764', '712800', '南投县', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3765', '712801', '南投市', '3764');
INSERT INTO `wp_shop_nation` VALUES ('3766', '712821', '埔里镇', '3764');
INSERT INTO `wp_shop_nation` VALUES ('3767', '712822', '草屯镇', '3764');
INSERT INTO `wp_shop_nation` VALUES ('3768', '712823', '竹山镇', '3764');
INSERT INTO `wp_shop_nation` VALUES ('3769', '712824', '集集镇', '3764');
INSERT INTO `wp_shop_nation` VALUES ('3770', '712825', '名间乡', '3764');
INSERT INTO `wp_shop_nation` VALUES ('3771', '712826', '鹿谷乡', '3764');
INSERT INTO `wp_shop_nation` VALUES ('3772', '712827', '中寮乡', '3764');
INSERT INTO `wp_shop_nation` VALUES ('3773', '712828', '鱼池乡', '3764');
INSERT INTO `wp_shop_nation` VALUES ('3774', '712829', '国姓乡', '3764');
INSERT INTO `wp_shop_nation` VALUES ('3775', '712830', '水里乡', '3764');
INSERT INTO `wp_shop_nation` VALUES ('3776', '712831', '信义乡', '3764');
INSERT INTO `wp_shop_nation` VALUES ('3777', '712832', '仁爱乡', '3764');
INSERT INTO `wp_shop_nation` VALUES ('3778', '712900', '云林县', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3779', '712901', '斗六市', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3780', '712921', '斗南镇', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3781', '712922', '虎尾镇', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3782', '712923', '西螺镇', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3783', '712924', '土库镇', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3784', '712925', '北港镇', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3785', '712926', '古坑乡', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3786', '712927', '大埤乡', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3787', '712928', '莿桐乡', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3788', '712929', '林内乡', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3789', '712930', '二仑乡', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3790', '712931', '仑背乡', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3791', '712932', '麦寮乡', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3792', '712933', '东势乡', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3793', '712934', '褒忠乡', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3794', '712935', '台西乡', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3795', '712936', '元长乡', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3796', '712937', '四湖乡', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3797', '712938', '口湖乡', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3798', '712939', '水林乡', '3778');
INSERT INTO `wp_shop_nation` VALUES ('3799', '713000', '嘉义县', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3800', '713001', '太保市', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3801', '713002', '朴子市', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3802', '713023', '布袋镇', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3803', '713024', '大林镇', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3804', '713025', '民雄乡', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3805', '713026', '溪口乡', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3806', '713027', '新港乡', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3807', '713028', '六脚乡', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3808', '713029', '东石乡', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3809', '713030', '义竹乡', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3810', '713031', '鹿草乡', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3811', '713032', '水上乡', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3812', '713033', '中埔乡', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3813', '713034', '竹崎乡', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3814', '713035', '梅山乡', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3815', '713036', '番路乡', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3816', '713037', '大埔乡', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3817', '713038', '阿里山乡', '3799');
INSERT INTO `wp_shop_nation` VALUES ('3818', '713300', '屏东县', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3819', '713301', '屏东市', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3820', '713321', '潮州镇', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3821', '713322', '东港镇', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3822', '713323', '恒春镇', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3823', '713324', '万丹乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3824', '713325', '长治乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3825', '713326', '麟洛乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3826', '713327', '九如乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3827', '713328', '里港乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3828', '713329', '盐埔乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3829', '713330', '高树乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3830', '713331', '万峦乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3831', '713332', '内埔乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3832', '713333', '竹田乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3833', '713334', '新埤乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3834', '713335', '枋寮乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3835', '713336', '新园乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3836', '713337', '崁顶乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3837', '713338', '林边乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3838', '713339', '南州乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3839', '713340', '佳冬乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3840', '713341', '琉球乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3841', '713342', '车城乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3842', '713343', '满州乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3843', '713344', '枋山乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3844', '713345', '三地门乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3845', '713346', '雾台乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3846', '713347', '玛家乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3847', '713348', '泰武乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3848', '713349', '来义乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3849', '713350', '春日乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3850', '713351', '狮子乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3851', '713352', '牡丹乡', '3818');
INSERT INTO `wp_shop_nation` VALUES ('3852', '713400', '台东县', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3853', '713401', '台东市', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3854', '713421', '成功镇', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3855', '713422', '关山镇', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3856', '713423', '卑南乡', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3857', '713424', '鹿野乡', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3858', '713425', '池上乡', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3859', '713426', '东河乡', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3860', '713427', '长滨乡', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3861', '713428', '太麻里乡', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3862', '713429', '大武乡', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3863', '713430', '绿岛乡', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3864', '713431', '海端乡', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3865', '713432', '延平乡', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3866', '713433', '金峰乡', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3867', '713434', '达仁乡', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3868', '713435', '兰屿乡', '3852');
INSERT INTO `wp_shop_nation` VALUES ('3869', '713500', '花莲县', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3870', '713501', '花莲市', '3869');
INSERT INTO `wp_shop_nation` VALUES ('3871', '713521', '凤林镇', '3869');
INSERT INTO `wp_shop_nation` VALUES ('3872', '713522', '玉里镇', '3869');
INSERT INTO `wp_shop_nation` VALUES ('3873', '713523', '新城乡', '3869');
INSERT INTO `wp_shop_nation` VALUES ('3874', '713524', '吉安乡', '3869');
INSERT INTO `wp_shop_nation` VALUES ('3875', '713525', '寿丰乡', '3869');
INSERT INTO `wp_shop_nation` VALUES ('3876', '713526', '光复乡', '3869');
INSERT INTO `wp_shop_nation` VALUES ('3877', '713527', '丰滨乡', '3869');
INSERT INTO `wp_shop_nation` VALUES ('3878', '713528', '瑞穗乡', '3869');
INSERT INTO `wp_shop_nation` VALUES ('3879', '713529', '富里乡', '3869');
INSERT INTO `wp_shop_nation` VALUES ('3880', '713530', '秀林乡', '3869');
INSERT INTO `wp_shop_nation` VALUES ('3881', '713531', '万荣乡', '3869');
INSERT INTO `wp_shop_nation` VALUES ('3882', '713532', '卓溪乡', '3869');
INSERT INTO `wp_shop_nation` VALUES ('3883', '713600', '澎湖县', '3511');
INSERT INTO `wp_shop_nation` VALUES ('3884', '713601', '马公市', '3883');
INSERT INTO `wp_shop_nation` VALUES ('3885', '713621', '湖西乡', '3883');
INSERT INTO `wp_shop_nation` VALUES ('3886', '713622', '白沙乡', '3883');
INSERT INTO `wp_shop_nation` VALUES ('3887', '713623', '西屿乡', '3883');
INSERT INTO `wp_shop_nation` VALUES ('3888', '713624', '望安乡', '3883');
INSERT INTO `wp_shop_nation` VALUES ('3889', '713625', '七美乡', '3883');
INSERT INTO `wp_shop_nation` VALUES ('3890', '810000', '香港特别行政区', '0');
INSERT INTO `wp_shop_nation` VALUES ('3891', '810100', '香港岛', '3890');
INSERT INTO `wp_shop_nation` VALUES ('3892', '810101', '中西区', '3891');
INSERT INTO `wp_shop_nation` VALUES ('3893', '810102', '湾仔区', '3891');
INSERT INTO `wp_shop_nation` VALUES ('3894', '810103', '东区', '3891');
INSERT INTO `wp_shop_nation` VALUES ('3895', '810104', '南区', '3891');
INSERT INTO `wp_shop_nation` VALUES ('3896', '810200', '九龙', '3890');
INSERT INTO `wp_shop_nation` VALUES ('3897', '810201', '油尖旺区', '3896');
INSERT INTO `wp_shop_nation` VALUES ('3898', '810202', '深水埗区', '3896');
INSERT INTO `wp_shop_nation` VALUES ('3899', '810203', '九龙城区', '3896');
INSERT INTO `wp_shop_nation` VALUES ('3900', '810204', '黄大仙区', '3896');
INSERT INTO `wp_shop_nation` VALUES ('3901', '810205', '观塘区', '3896');
INSERT INTO `wp_shop_nation` VALUES ('3902', '810300', '新界', '3890');
INSERT INTO `wp_shop_nation` VALUES ('3903', '810301', '荃湾区', '3902');
INSERT INTO `wp_shop_nation` VALUES ('3904', '810302', '屯门区', '3902');
INSERT INTO `wp_shop_nation` VALUES ('3905', '810303', '元朗区', '3902');
INSERT INTO `wp_shop_nation` VALUES ('3906', '810304', '北区', '3902');
INSERT INTO `wp_shop_nation` VALUES ('3907', '810305', '大埔区', '3902');
INSERT INTO `wp_shop_nation` VALUES ('3908', '810306', '西贡区', '3902');
INSERT INTO `wp_shop_nation` VALUES ('3909', '810307', '沙田区', '3902');
INSERT INTO `wp_shop_nation` VALUES ('3910', '810308', '葵青区', '3902');
INSERT INTO `wp_shop_nation` VALUES ('3911', '810309', '离岛区', '3902');
INSERT INTO `wp_shop_nation` VALUES ('3912', '820000', '澳门特别行政区', '0');
INSERT INTO `wp_shop_nation` VALUES ('3913', '820100', '澳门半岛', '3912');
INSERT INTO `wp_shop_nation` VALUES ('3914', '820101', '花地玛堂区', '3913');
INSERT INTO `wp_shop_nation` VALUES ('3915', '820102', '圣安多尼堂区', '3913');
INSERT INTO `wp_shop_nation` VALUES ('3916', '820103', '大堂区', '3913');
INSERT INTO `wp_shop_nation` VALUES ('3917', '820104', '望德堂区', '3913');
INSERT INTO `wp_shop_nation` VALUES ('3918', '820105', '风顺堂区', '3913');
INSERT INTO `wp_shop_nation` VALUES ('3919', '820200', '氹仔岛', '3912');
INSERT INTO `wp_shop_nation` VALUES ('3920', '820201', '嘉模堂区', '3919');
INSERT INTO `wp_shop_nation` VALUES ('3921', '820300', '路环岛', '3912');
INSERT INTO `wp_shop_nation` VALUES ('3922', '820301', '圣方济各堂区', '3921');
INSERT INTO `wp_shop_nation` VALUES ('3923', '110000', '北京', '1');
INSERT INTO `wp_shop_nation` VALUES ('3924', '120000', '天津', '18');
INSERT INTO `wp_shop_nation` VALUES ('3925', '310000', '上海', '856');

-- ----------------------------
-- Table structure for wp_shop_order
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_order`;
CREATE TABLE `wp_shop_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_datas` text NOT NULL COMMENT '商品序列化数据',
  `username` varchar(255) DEFAULT NULL,
  `uid` varchar(255) NOT NULL COMMENT '用户id',
  `remark` text NOT NULL COMMENT '备注',
  `order_number` varchar(255) NOT NULL COMMENT '订单编号',
  `cTime` int(10) NOT NULL COMMENT '订单时间',
  `total_price` decimal(10,2) DEFAULT NULL COMMENT '总价',
  `wages` decimal(10,2) unsigned DEFAULT NULL,
  `openid` varchar(255) NOT NULL COMMENT 'OpenID',
  `pay_status` int(10) DEFAULT NULL COMMENT '支付状态',
  `pay_type` int(10) DEFAULT NULL COMMENT '支付类型',
  `address_id` int(10) DEFAULT NULL COMMENT '配送信息',
  `is_send` int(10) DEFAULT '0' COMMENT '是否发货',
  `send_code` varchar(255) DEFAULT NULL COMMENT '快递公司编号',
  `send_number` varchar(255) DEFAULT NULL COMMENT '快递单号',
  `send_type` char(10) DEFAULT NULL COMMENT '发货类型',
  `is_new` tinyint(2) DEFAULT '1' COMMENT '是否为新订单',
  `shop_id` int(10) DEFAULT '0' COMMENT '商店编号',
  `status_code` char(50) DEFAULT '0' COMMENT '订单跟踪状态码',
  `coupon` tinyint(1) unsigned DEFAULT '0' COMMENT '0单纯订单，1转兑换券',
  `reserve` tinyint(1) unsigned DEFAULT '0',
  `reserve_time` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_order
-- ----------------------------
INSERT INTO `wp_shop_order` VALUES ('1', '[{\"id\":\"5\",\"cover\":\"goods\\/2016\\/05\\/15\\/201605152244088718.jpg\",\"title\":\"\\u91ce\\u751f\\u515a\\u53c2 \\u571f\\u515a\\u53c2 \\u4e00\\u624e\\u5747\\u91cd\\u7ea61\\u65a4 20\\u5143\\/\\u624e\",\"price\":\"20.00\",\"commission\":\"10\",\"num\":1}]', '大官人', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '', '20160517124543369594', '1463460333', '20.00', '2.00', '', '0', '0', '14', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('2', '[{\"id\":\"5\",\"cover\":\"goods\\/2016\\/05\\/15\\/201605152244088718.jpg\",\"title\":\"\\u91ce\\u751f\\u515a\\u53c2 \\u571f\\u515a\\u53c2 \\u4e00\\u624e\\u5747\\u91cd\\u7ea61\\u65a4 20\\u5143\\/\\u624e\",\"price\":\"20.00\",\"commission\":\"10\",\"num\":1,\"evaluation\":{\"status\":\"2\",\"msg\":\"\\u53d1\\u8d27\\u597d\\u5feb\\ud83d\\ude42\"}}]', '大官人', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '送货上门', '20160517125402716045', '1463460868', '20.00', '2.00', '', '1', '0', '14', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('3', '[{\"id\":\"5\",\"cover\":\"goods\\/2016\\/05\\/15\\/201605152244088718.jpg\",\"title\":\"\\u91ce\\u751f\\u515a\\u53c2 \\u571f\\u515a\\u53c2 \\u4e00\\u624e\\u5747\\u91cd\\u7ea61\\u65a4 20\\u5143\\/\\u624e\",\"price\":\"20.00\",\"commission\":\"10\",\"num\":1}]', '（●—●）', 'o1teys0U4AM_Ex-buqh9BJhJHIjw', '', '20160517133616383090', '1463463391', '20.00', '2.00', '', '0', null, '13', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('4', '[{\"id\":\"8\",\"cover\":\"goods\\/2016\\/05\\/16\\/201605162223096756.jpg\",\"title\":\"\\u7ea2\\u706f\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843 \\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0135\\u5143\\/5\\u65a4\",\"price\":\"135.00\",\"commission\":\"8\",\"num\":\"1\",\"evaluation\":{\"status\":\"2\",\"msg\":\"\\u53d1\\u8d27\\u5f88\\u5feb\\uff0c\\u7b2c\\u4e8c\\u5929\\u5c31\\u5230\\u4e86\\uff0c\\u540c\\u7701\\u6536\\u8d27\\u54c8\\uff01\\u6a31\\u6843\\ud83c\\udf52\\u9178\\u9178\\u751c\\u751c\\u6ef4\\uff0c\\u51b0\\u8d77\\u6765\\u5403\\u53e3\\u611f\\u66f4\\u597d\\u3002\"}}]', '林夕梦', 'o1teys39jDjN56TGWhmKib6Awjek', '希望没有损坏哦\n', '20160517182515331039', '1463480746', '135.00', '10.80', '', '1', '0', '15', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('5', '[{\"id\":\"8\",\"cover\":\"goods\\/2016\\/05\\/16\\/201605162223096756.jpg\",\"title\":\"\\u7ea2\\u706f\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843 \\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0135\\u5143\\/5\\u65a4\",\"price\":\"135.00\",\"commission\":\"8\",\"num\":1}]', '李顾城', 'o1teys7tALk-MME7nA-xm97bmNz4', '', '20160517215415331039', '1463493283', '135.00', '10.80', '', '0', null, '17', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('6', '[{\"id\":\"8\",\"cover\":\"goods\\/2016\\/05\\/16\\/201605162223096756.jpg\",\"title\":\"\\u7ea2\\u706f\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843 \\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0135\\u5143\\/5\\u65a4\",\"price\":\"135.00\",\"commission\":\"8\",\"num\":1}]', '李顾城', 'o1teys7tALk-MME7nA-xm97bmNz4', '', '20160517215553984005', '1463493302', '135.00', '10.80', '', '1', '0', '17', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('7', '[{\"id\":\"8\",\"cover\":\"goods\\/2016\\/05\\/16\\/201605162223096756.jpg\",\"title\":\"\\u7ea2\\u706f\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843 \\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0135\\u5143\\/5\\u65a4\",\"price\":\"135.00\",\"commission\":\"8\",\"num\":1,\"evaluation\":{\"status\":\"2\",\"msg\":\"\\u597d\\u7684\\u4e0d\\u8981\\u4e0d\\u8981\\u7684\"}}]', '小潘潘', 'o1teysy_HdOBTKvdeMMDViaby4d4', '', '20160517222620013767', '1463495170', '135.00', '10.80', '', '1', '0', '19', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('8', '[{\"id\":\"8\",\"cover\":\"goods\\/2016\\/05\\/16\\/201605162223096756.jpg\",\"title\":\"\\u7ea2\\u706f\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843 \\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0135\\u5143\\/5\\u65a4\",\"price\":\"135.00\",\"commission\":\"8\",\"num\":1,\"evaluation\":{\"status\":\"2\",\"msg\":\"\\u670b\\u53cb\\u63a8\\u8350\\u8d2d\\u4e70\\u7684\\uff0c\\u503c\\u5f97\\u4fe1\\u8d56\\uff0c\\u5f88\\u597d\\u5403\"}}]', '小潘潘', 'o1teysy_HdOBTKvdeMMDViaby4d4', '', '20160517223791610150', '1463495872', '135.00', '10.80', '', '1', '0', '20', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('9', '[{\"id\":\"11\",\"cover\":\"goods\\/2016\\/05\\/17\\/201605171019442271.jpg\",\"title\":\"\\u9ec4\\u871c\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843 \\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0155\\u5143\\/5\\u65a4\",\"price\":\"155.00\",\"commission\":\"8\",\"num\":1,\"evaluation\":{\"status\":\"2\",\"msg\":\"\\u4e2a\\u5934\\u5927\\uff0c\\u8d85\\u7ea7\\u65b0\\u9c9c\\uff0c\\u6ca1\\u6709\\u8ba9\\u6211\\u5931\\u671b\\uff0c\\u63a8\\u8350\\u5927\\u5bb6\\u653e\\u5fc3\\u8d2d\\u4e70\"}}]', '小潘潘', 'o1teysy_HdOBTKvdeMMDViaby4d4', '', '20160517233233344177', '1463499134', '155.00', '12.40', '', '1', '0', '21', '2', 'sf', '934450842516', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('10', '[{\"id\":\"8\",\"cover\":\"goods\\/2016\\/05\\/16\\/201605162223096756.jpg\",\"title\":\"\\u7ea2\\u706f\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843 \\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0135\\u5143\\/5\\u65a4\",\"price\":\"135.00\",\"commission\":\"8\",\"num\":1,\"evaluation\":{\"status\":\"2\",\"msg\":\"\\u8001\\u677f\\u4eba\\u8d85\\u597d\\u7684\\uff0c\\u6a31\\u6843\\u9178\\u9178\\u751c\\u751c\\uff0c\\u597d\\u5403\"}}]', 'sSVv', 'o1teys_KAj3bWXOvJsK4cLyvrwnQ', '要帅哥送货上门', '20160519212578426291', '1463664346', '135.00', '10.80', '', '1', '0', '22', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('11', '[{\"id\":\"11\",\"cover\":\"goods\\/2016\\/05\\/17\\/201605171019442271.jpg\",\"title\":\"\\u9ec4\\u871c\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843 \\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0155\\u5143\\/5\\u65a4\",\"price\":\"155.00\",\"commission\":\"8\",\"num\":\"1\"}]', '陈怡', 'o1teysxlDFWiy_rC-XKu4cE_blUM', '', '20160520124412557431', '1463719467', '155.00', '12.40', '', '1', '0', '23', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('12', '[{\"id\":\"8\",\"cover\":\"goods\\/2016\\/05\\/16\\/201605162223096756.jpg\",\"title\":\"\\u7ea2\\u706f\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843 \\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0135\\u5143\\/5\\u65a4\",\"price\":\"135.00\",\"commission\":\"8\",\"num\":\"1\"}]', '娟~~', 'o1teys-7KnJ2Yn0hyRz6w6zx32Qc', '我要好吃的樱桃', '20160520142171394789', '1463725264', '135.00', '10.80', '', '1', '0', '24', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('13', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/14\\/201605141114416616.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a4 99\\u5143\\/\\u53ea \\u4e00\\u53ea\\u8d77\\u9001 \\u53ef\\u514d\\u8d39\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":1}]', '呵呵', 'o1teys6MbkbmRJ6DfshJCw8AMWmw', '', '20160521162478426291', '1463819054', '99.00', '9.90', '', '1', '0', '26', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('14', '[{\"id\":\"11\",\"cover\":\"goods\\/2016\\/05\\/17\\/201605171019442271.jpg\",\"title\":\"\\u9ec4\\u871c\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843 \\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0155\\u5143\\/5\\u65a4\",\"price\":\"155.00\",\"commission\":\"8\",\"num\":1}]', '呵呵', 'o1teys6MbkbmRJ6DfshJCw8AMWmw', '', '20160521164243611184', '1463820172', '155.00', '12.40', '', '1', '0', '26', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('15', '[{\"id\":\"8\",\"cover\":\"goods\\/2016\\/05\\/16\\/201605162223096756.jpg\",\"title\":\"\\u7ea2\\u706f\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843 \\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0135\\u5143\\/5\\u65a4\",\"price\":\"135.00\",\"commission\":\"8\",\"num\":\"1\"}]', 'L冬梅', 'o1teys_6ezIuNEUwpLrH7g0_boiE', '', '20160521192851814697', '1463830130', '135.00', '10.80', '', '1', '0', '27', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('16', '[{\"id\":\"6\",\"cover\":\"goods\\/2016\\/05\\/23\\/201605231132499839.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21\\u86cb \\u806a\\u660e\\u86cb \\u7f8e\\u5bb9\\u86cb 10\\u679a\\u88c525\\u5143\",\"price\":\"25.00\",\"commission\":\"8\",\"num\":\"1\"}]', '刘红娜', 'o1teys8yfbfHOhCIXHgpTrV_IumU', '', '20160526195276726605', '1464263526', '25.00', '2.00', '', '1', '0', '28', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('17', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/14\\/201605141114416616.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a4 99\\u5143\\/\\u53ea \\u4e00\\u53ea\\u8d77\\u9001 \\u53ef\\u514d\\u8d39\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":2,\"evaluation\":{\"status\":\"2\",\"msg\":\"\"}}]', '蓝心怡', 'o1teysxSSrfPUmb_WELwwDSalNQY', '', '20160527155144886591', '1464335497', '198.00', '19.80', '', '1', '0', '29', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('18', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/14\\/201605141114416616.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a499\\u5143\\/\\u53ea \\u53ef\\u5e2e\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":\"1\"},{\"id\":\"6\",\"cover\":\"goods\\/2016\\/05\\/23\\/201605231132499839.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21\\u86cb \\u806a\\u660e\\u86cb \\u7f8e\\u5bb9\\u86cb 10\\u679a\\u88c525\\u5143\",\"price\":\"25.00\",\"commission\":\"8\",\"num\":\"1\"},{\"id\":\"7\",\"cover\":\"goods\\/2016\\/05\\/16\\/201605161352344233.jpg\",\"title\":\"\\u91ce\\u751f\\u6dee\\u5c71 \\u73b0\\u6316\\u73b0\\u5356 20\\u5143\\/\\u65a4 \\u4e00\\u65a4\\u8d77\\u5b9a\",\"price\":\"20.00\",\"commission\":\"8\",\"num\":\"1\"}]', '西池', 'o1teys7HBU9b78_Tr5PZps5G-5WQ', '', '20160528094903752755', '1464400194', '144.00', '31.34', '', '1', '0', '30', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('19', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/28\\/201605281114021850.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a499\\u5143\\/\\u53ea \\u53ef\\u5e2e\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":3,\"evaluation\":{\"status\":\"2\",\"msg\":\"\\u8089\\u8d28\\u975e\\u5e38\\u597d\\uff0c\\u6c64\\u9c9c\\u751c\\u3002\\u503c\\u5f97\\u62e5\\u6709\"}}]', '蓝心怡', 'o1teysxSSrfPUmb_WELwwDSalNQY', '', '20160528210843611184', '1464440907', '297.00', '29.70', '', '1', '0', '29', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('20', '[{\"id\":\"11\",\"cover\":\"goods\\/2016\\/05\\/23\\/201605231131265495.jpg\",\"title\":\"\\u9ec4\\u871c\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843\\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0155\\u5143\\/5\\u65a4\",\"price\":\"155.00\",\"commission\":\"8\",\"num\":1}]', '苏映云', 'o1teysyjFEoTsZRRVprjExU6w4EE', '', '20160528221905361225', '1464445185', '155.00', '12.40', '', '0', null, '31', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('21', '[{\"id\":\"11\",\"cover\":\"goods\\/2016\\/05\\/23\\/201605231131265495.jpg\",\"title\":\"\\u9ec4\\u871c\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843\\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0155\\u5143\\/5\\u65a4\",\"price\":\"155.00\",\"commission\":\"8\",\"num\":1}]', '苏映云', 'o1teysyjFEoTsZRRVprjExU6w4EE', '', '20160528221953984005', '1464445185', '155.00', '12.40', '', '0', null, '31', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('22', '[{\"id\":\"11\",\"cover\":\"goods\\/2016\\/05\\/23\\/201605231131265495.jpg\",\"title\":\"\\u9ec4\\u871c\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843\\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0155\\u5143\\/5\\u65a4\",\"price\":\"155.00\",\"commission\":\"8\",\"num\":1}]', '苏映云', 'o1teysyjFEoTsZRRVprjExU6w4EE', '', '20160528221943611184', '1464445185', '155.00', '12.40', '', '0', null, '31', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('23', '[{\"id\":\"11\",\"cover\":\"goods\\/2016\\/05\\/23\\/201605231131265495.jpg\",\"title\":\"\\u9ec4\\u871c\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843\\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0155\\u5143\\/5\\u65a4\",\"price\":\"155.00\",\"commission\":\"8\",\"num\":1}]', '苏映云', 'o1teysyjFEoTsZRRVprjExU6w4EE', '', '20160528221972894159', '1464445185', '155.00', '12.40', '', '0', null, '31', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('24', '[{\"id\":\"11\",\"cover\":\"goods\\/2016\\/05\\/23\\/201605231131265495.jpg\",\"title\":\"\\u9ec4\\u871c\\u6a31\\u6843 \\u5c71\\u4e1c\\u4e00\\u7ea7\\u6a31\\u6843\\u5168\\u7a0b\\u51b7\\u94fe\\u7a7a\\u8fd0155\\u5143\\/5\\u65a4\",\"price\":\"155.00\",\"commission\":\"8\",\"num\":1,\"evaluation\":{\"status\":\"2\",\"msg\":\"\\u867d\\u7136\\u989c\\u8272\\u4e0d\\u662f\\u5f88\\u7ea2\\uff0c\\u4f46\\u662f\\u597d\\u751c\\u597d\\u751c\\u7684\\u6a31\\u6843\\uff0c\\u4e2a\\u5934\\u5747\\u5300\\uff0c\\u6ca1\\u6709\\u70c2\\u679c\\uff0c\\u597d\\u8bc4\\uff01\\u8fd8\\u4f1a\\u518d\\u6765\\u7684(^o^)\"}}]', '苏映云', 'o1teysyjFEoTsZRRVprjExU6w4EE', '', '20160528221915694876', '1464445185', '155.00', '12.40', '', '1', '0', '31', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('25', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/28\\/201605281114021850.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a499\\u5143\\/\\u53ea \\u53ef\\u5e2e\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":2}]', '快乐天使', 'o1teys2974CfTGblkN_hHwur6_6c', '公母各一只', '20160530092043611184', '1464571253', '198.00', '19.80', '', '1', '0', '32', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('26', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/28\\/201605281114021850.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a499\\u5143\\/\\u53ea \\u53ef\\u5e2e\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":1}]', '快乐天使', 'o1teys2974CfTGblkN_hHwur6_6c', '芦花公鸡一只，加早上拍的共两只公鸡一只母鸡，都要芦花鸡。', '20160530130486634339', '1464584657', '99.00', '9.90', '', '1', '0', '32', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('31', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/28\\/201605281114021850.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a499\\u5143\\/\\u53ea \\u53ef\\u5e2e\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":1}]', '刘红娜', 'o1teys8yfbfHOhCIXHgpTrV_IumU', '', '20160603115812678982', '1464926286', '99.00', '9.90', '', '1', '0', '28', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('30', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/28\\/201605281114021850.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a499\\u5143\\/\\u53ea \\u53ef\\u5e2e\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":\"1\"}]', '西池', 'o1teys7HBU9b78_Tr5PZps5G-5WQ', '', '20160530184651814697', '1464605211', '99.00', '9.90', '', '1', '0', '30', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('32', '[{\"id\":\"4\",\"cover\":\"goods\\/2016\\/06\\/03\\/201606031414501010.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u6e05\\u6c34\\u9e2d\\u6b63\\u5b97\\u571f\\u9e2d \\u5747\\u91cd4.5~5\\u65a4118\\u5143\\/\\u53ea\",\"price\":\"118.00\",\"commission\":\"9\",\"num\":1}]', '呵呵', 'o1teys6MbkbmRJ6DfshJCw8AMWmw', '', '20160603145331585363', '1464936816', '118.00', '10.62', '', '1', '0', '26', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('33', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/28\\/201605281114021850.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a499\\u5143\\/\\u53ea \\u53ef\\u5e2e\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":7}]', '董-长俊', 'o1teysynlx0Cz1NwrKIoNDHFIjXQ', '', '20160607132235698700', '1465276937', '693.00', '69.30', '', '0', '0', '33', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('34', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/28\\/201605281114021850.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a499\\u5143\\/\\u53ea \\u53ef\\u5e2e\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":1}]', '喜洋洋', 'o1teys_TnbMJ08GlKeTruOaIdkgA', '请帮杀好。', '20160608121712186261', '1465359425', '99.00', '9.90', '', '1', '0', '35', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('35', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/28\\/201605281114021850.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a499\\u5143\\/\\u53ea \\u53ef\\u5e2e\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":\"1\"},{\"id\":\"4\",\"cover\":\"goods\\/2016\\/06\\/03\\/201606031414501010.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u6e05\\u6c34\\u9e2d\\u6b63\\u5b97\\u571f\\u9e2d \\u5747\\u91cd4.5~5\\u65a4118\\u5143\\/\\u53ea\",\"price\":\"118.00\",\"commission\":\"9\",\"num\":\"1\"}]', 'Xjsu', 'o1teys_65crDgTKTG3dN4NoZBlBE', '', '20160609161165738570', '1465459869', '217.00', '29.43', '', '1', '0', '37', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('36', '[{\"id\":\"4\",\"cover\":\"goods\\/2016\\/06\\/03\\/201606031414501010.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u6e05\\u6c34\\u9e2d\\u6b63\\u5b97\\u571f\\u9e2d \\u5747\\u91cd4.5~5\\u65a4118\\u5143\\/\\u53ea\",\"price\":\"118.00\",\"commission\":\"9\",\"num\":1}]', 'Xjsu', 'o1teys_65crDgTKTG3dN4NoZBlBE', '', '20160616103691610150', '1466044594', '118.00', '10.62', '', '1', '0', '37', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('37', '[{\"id\":\"22\",\"cover\":\"goods\\/2016\\/06\\/16\\/201606161814274374.jpg\",\"title\":\"\\u5c0f\\u91d1\\u714c\\u8292\\u679c \\u666e\\u901a10\\u65a4\\u88c5\\u7530\\u4e1c\\u8292\\u679c66\\u5143\\u5305\\u90ae\",\"price\":\"66.00\",\"commission\":\"7\",\"num\":1}]', '大官人', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '', '20160621103086135475', '1466476258', '66.00', '4.62', '', '1', '0', '14', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('38', '[{\"id\":\"15\",\"cover\":\"goods\\/2016\\/05\\/27\\/201605271203483532.jpg\",\"title\":\"\\u6b63\\u5b97\\u91ce\\u751f\\u8702\\u871c \\u5c91\\u738b\\u8001\\u5c71\\u539f\\u59cb\\u68ee\\u6797\\u767e\\u82b1\\u871c79\\u5143\\/\\u65a4\",\"price\":\"79.00\",\"commission\":\"20\",\"num\":\"2\"}]', '韦柳', 'o1teys2-EY3G0TPDPALNveLoeKFY', '', '20160622230403035417', '1466607868', '158.00', '31.60', '', '1', '0', '38', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('39', '[{\"id\":\"21\",\"cover\":\"goods\\/2016\\/06\\/16\\/201606161800003252.jpg\",\"title\":\"\\u5c0f\\u91d1\\u714c\\u8292\\u679c 10\\u65a4\\u7cbe\\u88c5\\u767e\\u8272\\u7530\\u4e1c\\u8292\\u679c76\\u5143\\u5305\\u90ae\",\"price\":\"76.00\",\"commission\":\"7\",\"num\":1}]', '绿鲤鱼与驴', 'o1teys1RcnZoDK3AMPSkidL8UvNU', '', '20160623183883571477', '1466678284', '76.00', '5.32', '', '1', '0', '42', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('40', '[{\"id\":\"15\",\"cover\":\"goods\\/2016\\/05\\/27\\/201605271203483532.jpg\",\"title\":\"\\u6b63\\u5b97\\u91ce\\u751f\\u8702\\u871c \\u5c91\\u738b\\u8001\\u5c71\\u539f\\u59cb\\u68ee\\u6797\\u767e\\u82b1\\u871c79\\u5143\\/\\u65a4\",\"price\":\"79.00\",\"commission\":\"15\",\"num\":\"2\"}]', '内科医生韦双', 'o1teys1hJM4kKnk4ts3Zd_TQVl5A', '', '20160624200688705148', '1466769973', '158.00', '23.70', '', '1', '0', '43', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('41', '[{\"id\":\"22\",\"cover\":\"goods\\/2016\\/06\\/16\\/201606161814274374.jpg\",\"title\":\"\\u5927\\u91d1\\u714c\\u8292\\u679c 10\\u65a4\\u7cbe\\u88c5\\u7530\\u4e1c\\u8292\\u679c80\\u5143\\u5168\\u56fd\\u5305\\u90ae\",\"price\":\"80.00\",\"commission\":\"7\",\"num\":1}]', '海蓝蓝', 'o1teysyEa4ZLo9kQTJ6WJQT5Dkik', '', '20160625114124967108', '1466826112', '80.00', '5.60', '', '0', '0', '44', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('42', '[{\"id\":\"22\",\"cover\":\"goods\\/2016\\/06\\/16\\/201606161814274374.jpg\",\"title\":\"\\u5927\\u91d1\\u714c\\u8292\\u679c 10\\u65a4\\u7cbe\\u88c5\\u7530\\u4e1c\\u8292\\u679c80\\u5143\\u5168\\u56fd\\u5305\\u90ae\",\"price\":\"80.00\",\"commission\":\"7\",\"num\":1}]', '海蓝蓝', 'o1teysyEa4ZLo9kQTJ6WJQT5Dkik', '', '20160625114255355124', '1466826141', '80.00', '5.60', '', '0', '0', '44', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('43', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/28\\/201605281114021850.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a499\\u5143\\/\\u53ea \\u53ef\\u5e2e\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":2}]', '刘红娜', 'o1teys8yfbfHOhCIXHgpTrV_IumU', '', '20160626211859958578', '1466947090', '198.00', '19.80', '', '1', '0', '28', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('44', '[{\"id\":\"15\",\"cover\":\"goods\\/2016\\/05\\/27\\/201605271203483532.jpg\",\"title\":\"\\u6b63\\u5b97\\u91ce\\u751f\\u8702\\u871c \\u5c91\\u738b\\u8001\\u5c71\\u539f\\u59cb\\u68ee\\u6797\\u767e\\u82b1\\u871c79\\u5143\\/\\u65a4\",\"price\":\"79.00\",\"commission\":\"15\",\"num\":3}]', '韩MM', 'o1teys0DOh_5vUtHwRGwpw_OQ1qQ', '', '20160701181933857627', '1467368343', '237.00', '35.55', '', '1', '0', '45', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('45', '[{\"id\":\"4\",\"cover\":\"goods\\/2016\\/06\\/03\\/201606031414501010.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e2d\\u6b63\\u5b97\\u571f\\u9e2d \\u5747\\u91cd4.5~5\\u65a4118\\u5143\\/\\u53ea\",\"price\":\"118.00\",\"commission\":\"9\",\"num\":1}]', '蓝心怡', 'o1teysxSSrfPUmb_WELwwDSalNQY', '', '20160701200133857627', '1467374517', '118.00', '10.62', '', '1', '0', '29', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('46', '[{\"id\":\"4\",\"cover\":\"goods\\/2016\\/06\\/03\\/201606031414501010.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e2d\\u6b63\\u5b97\\u571f\\u9e2d \\u5747\\u91cd4.5~5\\u65a4118\\u5143\\/\\u53ea\",\"price\":\"118.00\",\"commission\":\"9\",\"num\":1}]', '蓝心怡', 'o1teysxSSrfPUmb_WELwwDSalNQY', '', '20160701200238927981', '1467374550', '118.00', '10.62', '', '0', null, '29', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('47', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/28\\/201605281114021850.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a499\\u5143\\/\\u53ea \\u53ef\\u5e2e\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":2}]', '蓝心怡', 'o1teysxSSrfPUmb_WELwwDSalNQY', '', '20160701200356186316', '1467374581', '198.00', '19.80', '', '0', null, '29', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('48', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/28\\/201605281114021850.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a499\\u5143\\/\\u53ea \\u53ef\\u5e2e\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":3}]', '蓝心怡', 'o1teysxSSrfPUmb_WELwwDSalNQY', '', '20160703113832936508', '1467517089', '297.00', '29.70', '', '1', '0', '29', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('49', '[{\"id\":\"15\",\"cover\":\"goods\\/2016\\/05\\/27\\/201605271203483532.jpg\",\"title\":\"\\u6b63\\u5b97\\u91ce\\u751f\\u8702\\u871c \\u5c91\\u738b\\u8001\\u5c71\\u539f\\u59cb\\u68ee\\u6797\\u767e\\u82b1\\u871c79\\u5143\\/\\u65a4\",\"price\":\"79.00\",\"commission\":\"15\",\"num\":2}]', '凤媛', 'o1teys9AsS4YBkYvA9wxKrBNTb3Y', '', '20160704172904955117', '1467624565', '158.00', '23.70', '', '1', '0', '46', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('50', '[{\"id\":\"17\",\"cover\":\"goods\\/2016\\/06\\/01\\/201606011636542972.jpg\",\"title\":\"\\u5317\\u6d77\\u6d77\\u9e2d\\u86cb \\u81ea\\u5bb6\\u719f\\u54b8\\u70e4\\u6d77\\u9e2d\\u86cb20\\u679a\\u88c558\\u5143\\u5305\\u90ae\",\"price\":\"58.00\",\"commission\":\"8\",\"num\":1}]', '紫水晶', 'o1teys2fjdJbcE--zaLdyFTJl2lg', '', '20160705180295654989', '1467712927', '58.00', '4.64', '', '1', '0', '47', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('51', '[{\"id\":\"15\",\"cover\":\"goods\\/2016\\/05\\/27\\/201605271203483532.jpg\",\"title\":\"\\u6b63\\u5b97\\u91ce\\u751f\\u8702\\u871c \\u5c91\\u738b\\u8001\\u5c71\\u539f\\u59cb\\u68ee\\u6797\\u767e\\u82b1\\u871c79\\u5143\\/\\u65a4\",\"price\":\"79.00\",\"commission\":\"15\",\"num\":2}]', 'a李R', 'o1teys6Nhr6G85mVmP6UIPXS0VKQ', '已送', '20160707085184016079', '1467852672', '158.00', '23.70', '', '1', '0', '49', '1', 'intra-city', '', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('52', '[{\"id\":\"17\",\"cover\":\"goods\\/2016\\/06\\/01\\/201606011636542972.jpg\",\"title\":\"\\u5317\\u6d77\\u6d77\\u9e2d\\u86cb \\u81ea\\u5bb6\\u719f\\u54b8\\u70e4\\u6d77\\u9e2d\\u86cb20\\u679a\\u88c558\\u5143\\u5305\\u90ae\",\"price\":\"58.00\",\"commission\":\"8\",\"num\":1}]', '紫气东来', 'o1teys7tvZwviGDUf_-y3rZIfpsY', '', '20160707115456620203', '1467863650', '58.00', '4.64', '', '1', '0', '50', '2', 'ht', '70290503088599', null, '1', '0', '4', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('53', '[{\"id\":\"22\",\"cover\":\"goods\\/2016\\/06\\/16\\/201606161814274374.jpg\",\"title\":\"\\u5927\\u91d1\\u714c\\u8292\\u679c 10\\u65a4\\u7cbe\\u88c5\\u7530\\u4e1c\\u8292\\u679c89\\u5143\\u5168\\u56fd\\u5305\\u90ae\",\"price\":\"89.00\",\"commission\":\"7\",\"num\":1}]', '问道知真—吕奔', 'o1teysyGg8_ckqJzKeAweCzI8kwI', '', '20160707165847099322', '1467881889', '89.00', '6.23', '', '0', '0', '52', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('54', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/28\\/201605281114021850.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a499\\u5143\\/\\u53ea \\u53ef\\u5e2e\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":2}]', '飞舞', 'o1teys8o3MGF2OU6V5Zo5njN5i8s', '活鸡2只', '20160719130174787550', '1468904480', '198.00', '19.80', '', '1', '0', '54', '1', 'intra-city', '', null, '1', '0', '3', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('55', '[{\"id\":\"26\",\"cover\":\"goods\\/2016\\/07\\/15\\/201607151629556359.jpg\",\"title\":\"\\u7530\\u4e1c\\u6842\\u4e03\\u9999\\u8292 \\u5341\\u65a4\\u7cbe\\u88c5108\\u5143\\/\\u4ef6\\u5168\\u56fd\\u5305\\u90ae\",\"price\":\"108.00\",\"commission\":\"5\",\"num\":1}]', '晓峰', 'o1teys7_0roOxVUrgEVypmLCuMvg', '', '20160725155501368922', '1469433353', '108.00', '5.40', '', '0', '0', '55', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('56', '[{\"id\":\"26\",\"cover\":\"goods\\/2016\\/07\\/15\\/201607151629556359.jpg\",\"title\":\"\\u7530\\u4e1c\\u6842\\u4e03\\u9999\\u8292 \\u5341\\u65a4\\u7cbe\\u88c5108\\u5143\\/\\u4ef6\\u5168\\u56fd\\u5305\\u90ae\",\"price\":\"108.00\",\"commission\":\"5\",\"num\":1}]', '晓峰', 'o1teys7_0roOxVUrgEVypmLCuMvg', '', '20160725162469985966', '1469435073', '108.00', '5.40', '', '0', '0', '55', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('57', '[{\"id\":\"26\",\"cover\":\"goods\\/2016\\/07\\/15\\/201607151629556359.jpg\",\"title\":\"\\u7530\\u4e1c\\u6842\\u4e03\\u9999\\u8292 \\u5341\\u65a4\\u7cbe\\u88c5108\\u5143\\/\\u4ef6\\u5168\\u56fd\\u5305\\u90ae\",\"price\":\"108.00\",\"commission\":\"5\",\"num\":1}]', '晓峰', 'o1teys7_0roOxVUrgEVypmLCuMvg', '', '20160725163261280460', '1469435549', '108.00', '5.40', '', '1', '0', '55', '1', 'intra-city', '', null, '1', '0', '3', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('58', '[{\"id\":\"25\",\"cover\":\"goods\\/2016\\/07\\/15\\/201607151612411594.jpg\",\"title\":\"\\u7530\\u4e1c\\u6842\\u4e03\\u9999\\u8292 \\u5341\\u65a4\\u7cbe\\u88c5\\u5e7f\\u897f\\u533a\\u518598\\u5143\\/\\u4ef6\\u5305\\u90ae\",\"price\":\"98.00\",\"commission\":\"7\",\"num\":1}]', '晓峰', 'o1teys7_0roOxVUrgEVypmLCuMvg', '', '20160725163565253693', '1469435711', '98.00', '6.86', '', '1', '0', '56', '1', 'intra-city', '', null, '1', '0', '3', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('59', '[{\"id\":\"3\",\"cover\":\"goods\\/2016\\/05\\/28\\/201605281114021850.jpg\",\"title\":\"\\u9648\\u738b\\u5c71\\u7075\\u829d\\u9e21-\\u9879\\u9e21 \\u5747\\u91cd3\\u65a499\\u5143\\/\\u53ea \\u53ef\\u5e2e\\u6740\\u597d\",\"price\":\"99.00\",\"commission\":\"10\",\"num\":2}]', '刘红娜', 'o1teys8yfbfHOhCIXHgpTrV_IumU', '', '20160728160286852689', '1469692977', '198.00', '19.80', '', '1', '0', '28', '1', 'intra-city', '', null, '1', '0', '3', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('60', '[{\"id\":\"25\",\"cover\":\"goods\\/2016\\/07\\/15\\/201607151612411594.jpg\",\"title\":\"\\u7530\\u4e1c\\u6842\\u4e03\\u9999\\u8292 \\u5341\\u65a4\\u7cbe\\u88c5\\u5e7f\\u897f\\u533a\\u5185105\\u5143\\/\\u4ef6\\u5305\\u90ae\",\"price\":\"105.00\",\"commission\":\"7\",\"num\":1}]', '（●—●）', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '', '20160803204549639389', '1470228304', '105.00', '7.35', '', '0', '11', '14', '0', null, null, null, '1', '0', '0', null, '0', null);
INSERT INTO `wp_shop_order` VALUES ('61', '[{\"id\":\"25\",\"cover\":\"goods\\/2016\\/07\\/15\\/201607151612411594.jpg\",\"title\":\"\\u7530\\u4e1c\\u6842\\u4e03\\u9999\\u8292 \\u5341\\u65a4\\u7cbe\\u88c5\\u5e7f\\u897f\\u533a\\u5185105\\u5143\\/\\u4ef6\\u5305\\u90ae\",\"price\":\"105.00\",\"commission\":\"7\",\"num\":1}]', '（●—●）', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '', '20160808212801696068', '1470662935', '105.00', '7.35', '', '0', '11', '14', '0', null, null, null, '1', '0', '0', null, '1', '1475078400');
INSERT INTO `wp_shop_order` VALUES ('62', '[{\"id\":\"28\",\"cover\":\"goods\\/2016\\/08\\/30\\/201608302110073042.jpg\",\"title\":\"\\u6d4b\\u8bd52323\",\"price\":\"12.00\",\"commission\":\"1\",\"num\":1}]', '（●—●）', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '', '20160830214302459142', '1472564624', '12.00', '0.12', '', '0', null, '14', '0', null, null, null, '1', '0', '0', '0', '0', null);
INSERT INTO `wp_shop_order` VALUES ('63', '[{\"id\":\"28\",\"cover\":\"goods\\/2016\\/08\\/30\\/201608302110073042.jpg\",\"title\":\"\\u6d4b\\u8bd52323\",\"price\":\"12.00\",\"commission\":\"1\",\"reserve\":\"1\",\"reserve_time\":\"1475078400\",\"num\":1}]', '（●—●）', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '', '20160903114664530177', '1472874417', '12.00', '0.12', '', '0', null, '14', '0', null, null, null, '1', '0', '0', '0', '1', '1475078400');

-- ----------------------------
-- Table structure for wp_shop_order_log
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_order_log`;
CREATE TABLE `wp_shop_order_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` int(10) DEFAULT NULL COMMENT '订单ID',
  `status_code` char(50) DEFAULT '0' COMMENT '状态码',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注内容',
  `cTime` int(10) DEFAULT NULL COMMENT '时间',
  `extend` varchar(255) DEFAULT NULL COMMENT '扩展信息',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_order_log
-- ----------------------------
INSERT INTO `wp_shop_order_log` VALUES ('1', '2', '1', '您提交了订单，请等待商家确认', '1463460886', null);
INSERT INTO `wp_shop_order_log` VALUES ('2', '2', '4', '确认已收货', '1463460989', null);
INSERT INTO `wp_shop_order_log` VALUES ('3', '4', '1', '您提交了订单，请等待商家确认', '1463480767', null);
INSERT INTO `wp_shop_order_log` VALUES ('4', '6', '1', '您提交了订单，请等待商家确认', '1463493315', null);
INSERT INTO `wp_shop_order_log` VALUES ('5', '7', '1', '您提交了订单，请等待商家确认', '1463495184', null);
INSERT INTO `wp_shop_order_log` VALUES ('6', '8', '1', '您提交了订单，请等待商家确认', '1463495886', null);
INSERT INTO `wp_shop_order_log` VALUES ('7', '9', '1', '您提交了订单，请等待商家确认', '1463499145', null);
INSERT INTO `wp_shop_order_log` VALUES ('8', '4', '4', '确认已收货', '1463555891', null);
INSERT INTO `wp_shop_order_log` VALUES ('9', '9', '1', '您提交了订单，请等待商家确认', '1463572489', null);
INSERT INTO `wp_shop_order_log` VALUES ('10', '9', '1', '您提交了订单，请等待商家确认', '1463584570', null);
INSERT INTO `wp_shop_order_log` VALUES ('11', '10', '1', '您提交了订单，请等待商家确认', '1463664364', null);
INSERT INTO `wp_shop_order_log` VALUES ('12', '11', '1', '您提交了订单，请等待商家确认', '1463719489', null);
INSERT INTO `wp_shop_order_log` VALUES ('13', '12', '1', '您提交了订单，请等待商家确认', '1463725280', null);
INSERT INTO `wp_shop_order_log` VALUES ('14', '10', '1', '您提交了订单，请等待商家确认', '1463738900', null);
INSERT INTO `wp_shop_order_log` VALUES ('15', '10', '1', '您提交了订单，请等待商家确认', '1463742013', null);
INSERT INTO `wp_shop_order_log` VALUES ('16', '10', '1', '您提交了订单，请等待商家确认', '1463754287', null);
INSERT INTO `wp_shop_order_log` VALUES ('17', '13', '1', '您提交了订单，请等待商家确认', '1463819080', null);
INSERT INTO `wp_shop_order_log` VALUES ('18', '14', '1', '您提交了订单，请等待商家确认', '1463820191', null);
INSERT INTO `wp_shop_order_log` VALUES ('19', '9', '4', '确认已收货', '1463822880', null);
INSERT INTO `wp_shop_order_log` VALUES ('20', '15', '1', '您提交了订单，请等待商家确认', '1463830154', null);
INSERT INTO `wp_shop_order_log` VALUES ('21', '8', '4', '确认已收货', '1463843476', null);
INSERT INTO `wp_shop_order_log` VALUES ('22', '7', '4', '确认已收货', '1463843488', null);
INSERT INTO `wp_shop_order_log` VALUES ('23', '12', '1', '您提交了订单，请等待商家确认', '1463884707', null);
INSERT INTO `wp_shop_order_log` VALUES ('24', '12', '1', '您提交了订单，请等待商家确认', '1463897136', null);
INSERT INTO `wp_shop_order_log` VALUES ('25', '15', '1', '您提交了订单，请等待商家确认', '1463919705', null);
INSERT INTO `wp_shop_order_log` VALUES ('26', '15', '1', '您提交了订单，请等待商家确认', '1463930864', null);
INSERT INTO `wp_shop_order_log` VALUES ('27', '10', '4', '确认已收货', '1463994884', null);
INSERT INTO `wp_shop_order_log` VALUES ('28', '6', '4', '确认已收货', '1464104953', null);
INSERT INTO `wp_shop_order_log` VALUES ('29', '16', '1', '您提交了订单，请等待商家确认', '1464263748', null);
INSERT INTO `wp_shop_order_log` VALUES ('30', '17', '1', '您提交了订单，请等待商家确认', '1464335556', null);
INSERT INTO `wp_shop_order_log` VALUES ('31', '16', '1', '您提交了订单，请等待商家确认', '1464354589', null);
INSERT INTO `wp_shop_order_log` VALUES ('32', '16', '1', '您提交了订单，请等待商家确认', '1464368949', null);
INSERT INTO `wp_shop_order_log` VALUES ('33', '18', '1', '您提交了订单，请等待商家确认', '1464400232', null);
INSERT INTO `wp_shop_order_log` VALUES ('34', '17', '1', '您提交了订单，请等待商家确认', '1464440719', null);
INSERT INTO `wp_shop_order_log` VALUES ('35', '17', '1', '您提交了订单，请等待商家确认', '1464440719', null);
INSERT INTO `wp_shop_order_log` VALUES ('36', '19', '1', '您提交了订单，请等待商家确认', '1464440924', null);
INSERT INTO `wp_shop_order_log` VALUES ('37', '24', '1', '您提交了订单，请等待商家确认', '1464445222', null);
INSERT INTO `wp_shop_order_log` VALUES ('38', '17', '1', '您提交了订单，请等待商家确认', '1464454327', null);
INSERT INTO `wp_shop_order_log` VALUES ('39', '17', '1', '您提交了订单，请等待商家确认', '1464454328', null);
INSERT INTO `wp_shop_order_log` VALUES ('40', '24', '1', '您提交了订单，请等待商家确认', '1464527302', null);
INSERT INTO `wp_shop_order_log` VALUES ('41', '24', '1', '您提交了订单，请等待商家确认', '1464540465', null);
INSERT INTO `wp_shop_order_log` VALUES ('42', '25', '1', '您提交了订单，请等待商家确认', '1464571308', null);
INSERT INTO `wp_shop_order_log` VALUES ('43', '26', '1', '您提交了订单，请等待商家确认', '1464584703', null);
INSERT INTO `wp_shop_order_log` VALUES ('44', '26', '1', '您提交了订单，请等待商家确认', '1464584719', null);
INSERT INTO `wp_shop_order_log` VALUES ('45', '30', '1', '您提交了订单，请等待商家确认', '1464605231', null);
INSERT INTO `wp_shop_order_log` VALUES ('46', '17', '4', '确认已收货', '1464709502', null);
INSERT INTO `wp_shop_order_log` VALUES ('47', '31', '1', '您提交了订单，请等待商家确认', '1464926348', null);
INSERT INTO `wp_shop_order_log` VALUES ('48', '32', '1', '您提交了订单，请等待商家确认', '1464936851', null);
INSERT INTO `wp_shop_order_log` VALUES ('49', '32', '1', '您提交了订单，请等待商家确认', '1464936864', null);
INSERT INTO `wp_shop_order_log` VALUES ('50', '32', '1', '您提交了订单，请等待商家确认', '1465045487', null);
INSERT INTO `wp_shop_order_log` VALUES ('51', '32', '1', '您提交了订单，请等待商家确认', '1465059789', null);
INSERT INTO `wp_shop_order_log` VALUES ('52', '31', '4', '确认已收货', '1465112489', null);
INSERT INTO `wp_shop_order_log` VALUES ('53', '34', '1', '您提交了订单，请等待商家确认', '1465360078', null);
INSERT INTO `wp_shop_order_log` VALUES ('54', '35', '1', '您提交了订单，请等待商家确认', '1465459884', null);
INSERT INTO `wp_shop_order_log` VALUES ('55', '35', '1', '您提交了订单，请等待商家确认', '1465576215', null);
INSERT INTO `wp_shop_order_log` VALUES ('56', '35', '1', '您提交了订单，请等待商家确认', '1465576215', null);
INSERT INTO `wp_shop_order_log` VALUES ('57', '24', '4', '确认已收货', '1465705718', null);
INSERT INTO `wp_shop_order_log` VALUES ('58', '36', '1', '您提交了订单，请等待商家确认', '1466044612', null);
INSERT INTO `wp_shop_order_log` VALUES ('59', '36', '1', '您提交了订单，请等待商家确认', '1466169033', null);
INSERT INTO `wp_shop_order_log` VALUES ('60', '36', '1', '您提交了订单，请等待商家确认', '1466184367', null);
INSERT INTO `wp_shop_order_log` VALUES ('61', '36', '1', '您提交了订单，请等待商家确认', '1466184367', null);
INSERT INTO `wp_shop_order_log` VALUES ('62', '37', '1', '您提交了订单，请等待商家确认', '1466476276', null);
INSERT INTO `wp_shop_order_log` VALUES ('63', '37', '4', '确认已收货', '1466476437', null);
INSERT INTO `wp_shop_order_log` VALUES ('64', '37', '1', '您提交了订单，请等待商家确认', '1466600693', null);
INSERT INTO `wp_shop_order_log` VALUES ('65', '38', '1', '您提交了订单，请等待商家确认', '1466607884', null);
INSERT INTO `wp_shop_order_log` VALUES ('66', '38', '1', '您提交了订单，请等待商家确认', '1466607902', null);
INSERT INTO `wp_shop_order_log` VALUES ('67', '37', '1', '您提交了订单，请等待商家确认', '1466614935', null);
INSERT INTO `wp_shop_order_log` VALUES ('68', '37', '1', '您提交了订单，请等待商家确认', '1466614935', null);
INSERT INTO `wp_shop_order_log` VALUES ('69', '39', '1', '您提交了订单，请等待商家确认', '1466678298', null);
INSERT INTO `wp_shop_order_log` VALUES ('70', '38', '1', '您提交了订单，请等待商家确认', '1466687261', null);
INSERT INTO `wp_shop_order_log` VALUES ('71', '38', '1', '您提交了订单，请等待商家确认', '1466701825', null);
INSERT INTO `wp_shop_order_log` VALUES ('72', '38', '1', '您提交了订单，请等待商家确认', '1466701825', null);
INSERT INTO `wp_shop_order_log` VALUES ('73', '40', '1', '您提交了订单，请等待商家确认', '1466770004', null);
INSERT INTO `wp_shop_order_log` VALUES ('74', '39', '1', '您提交了订单，请等待商家确认', '1466773695', null);
INSERT INTO `wp_shop_order_log` VALUES ('75', '39', '1', '您提交了订单，请等待商家确认', '1466788963', null);
INSERT INTO `wp_shop_order_log` VALUES ('76', '39', '1', '您提交了订单，请等待商家确认', '1466788963', null);
INSERT INTO `wp_shop_order_log` VALUES ('77', '40', '1', '您提交了订单，请等待商家确认', '1466859908', null);
INSERT INTO `wp_shop_order_log` VALUES ('78', '40', '1', '您提交了订单，请等待商家确认', '1466859909', null);
INSERT INTO `wp_shop_order_log` VALUES ('79', '40', '1', '您提交了订单，请等待商家确认', '1466874837', null);
INSERT INTO `wp_shop_order_log` VALUES ('80', '43', '1', '您提交了订单，请等待商家确认', '1466947232', null);
INSERT INTO `wp_shop_order_log` VALUES ('81', '43', '1', '您提交了订单，请等待商家确认', '1467032701', null);
INSERT INTO `wp_shop_order_log` VALUES ('82', '43', '1', '您提交了订单，请等待商家确认', '1467046388', null);
INSERT INTO `wp_shop_order_log` VALUES ('83', '44', '1', '您提交了订单，请等待商家确认', '1467368356', null);
INSERT INTO `wp_shop_order_log` VALUES ('84', '43', '4', '确认已收货', '1467455641', null);
INSERT INTO `wp_shop_order_log` VALUES ('85', '44', '1', '您提交了订单，请等待商家确认', '1467464720', null);
INSERT INTO `wp_shop_order_log` VALUES ('86', '44', '1', '您提交了订单，请等待商家确认', '1467464720', null);
INSERT INTO `wp_shop_order_log` VALUES ('87', '44', '1', '您提交了订单，请等待商家确认', '1467479768', null);
INSERT INTO `wp_shop_order_log` VALUES ('88', '44', '1', '您提交了订单，请等待商家确认', '1467479768', null);
INSERT INTO `wp_shop_order_log` VALUES ('89', '45', '1', '您提交了订单，请等待商家确认', '1467517060', null);
INSERT INTO `wp_shop_order_log` VALUES ('90', '45', '1', '您提交了订单，请等待商家确认', '1467517072', null);
INSERT INTO `wp_shop_order_log` VALUES ('91', '48', '1', '您提交了订单，请等待商家确认', '1467517104', null);
INSERT INTO `wp_shop_order_log` VALUES ('92', '49', '1', '您提交了订单，请等待商家确认', '1467625336', null);
INSERT INTO `wp_shop_order_log` VALUES ('93', '48', '1', '您提交了订单，请等待商家确认', '1467637488', null);
INSERT INTO `wp_shop_order_log` VALUES ('94', '48', '1', '您提交了订单，请等待商家确认', '1467637488', null);
INSERT INTO `wp_shop_order_log` VALUES ('95', '48', '1', '您提交了订单，请等待商家确认', '1467650758', null);
INSERT INTO `wp_shop_order_log` VALUES ('96', '48', '1', '您提交了订单，请等待商家确认', '1467650759', null);
INSERT INTO `wp_shop_order_log` VALUES ('97', '50', '1', '您提交了订单，请等待商家确认', '1467712954', null);
INSERT INTO `wp_shop_order_log` VALUES ('98', '49', '1', '您提交了订单，请等待商家确认', '1467723917', null);
INSERT INTO `wp_shop_order_log` VALUES ('99', '49', '1', '您提交了订单，请等待商家确认', '1467738460', null);
INSERT INTO `wp_shop_order_log` VALUES ('100', '50', '1', '您提交了订单，请等待商家确认', '1467810419', null);
INSERT INTO `wp_shop_order_log` VALUES ('101', '50', '1', '您提交了订单，请等待商家确认', '1467825139', null);
INSERT INTO `wp_shop_order_log` VALUES ('102', '50', '1', '您提交了订单，请等待商家确认', '1467825139', null);
INSERT INTO `wp_shop_order_log` VALUES ('103', '51', '1', '您提交了订单，请等待商家确认', '1467854055', null);
INSERT INTO `wp_shop_order_log` VALUES ('104', '52', '1', '您提交了订单，请等待商家确认', '1467863665', null);
INSERT INTO `wp_shop_order_log` VALUES ('105', '52', '1', '您提交了订单，请等待商家确认', '1467983165', null);
INSERT INTO `wp_shop_order_log` VALUES ('106', '52', '1', '您提交了订单，请等待商家确认', '1467983166', null);
INSERT INTO `wp_shop_order_log` VALUES ('107', '52', '1', '您提交了订单，请等待商家确认', '1467998123', null);
INSERT INTO `wp_shop_order_log` VALUES ('108', '52', '1', '您提交了订单，请等待商家确认', '1467998123', null);
INSERT INTO `wp_shop_order_log` VALUES ('109', '45', '4', '确认已收货', '1468133187', null);
INSERT INTO `wp_shop_order_log` VALUES ('110', '48', '4', '确认已收货', '1468133209', null);
INSERT INTO `wp_shop_order_log` VALUES ('111', '50', '4', '确认已收货', '1468228977', null);
INSERT INTO `wp_shop_order_log` VALUES ('112', '54', '1', '您提交了订单，请等待商家确认', '1468904506', null);
INSERT INTO `wp_shop_order_log` VALUES ('113', '54', '1', '您提交了订单，请等待商家确认', '1469019900', null);
INSERT INTO `wp_shop_order_log` VALUES ('114', '54', '1', '您提交了订单，请等待商家确认', '1469019900', null);
INSERT INTO `wp_shop_order_log` VALUES ('115', '54', '1', '您提交了订单，请等待商家确认', '1469035341', null);
INSERT INTO `wp_shop_order_log` VALUES ('116', '54', '1', '您提交了订单，请等待商家确认', '1469035341', null);
INSERT INTO `wp_shop_order_log` VALUES ('117', '57', '1', '您提交了订单，请等待商家确认', '1469435560', null);
INSERT INTO `wp_shop_order_log` VALUES ('118', '58', '1', '您提交了订单，请等待商家确认', '1469435723', null);
INSERT INTO `wp_shop_order_log` VALUES ('119', '58', '1', '您提交了订单，请等待商家确认', '1469538443', null);
INSERT INTO `wp_shop_order_log` VALUES ('120', '58', '1', '您提交了订单，请等待商家确认', '1469538443', null);
INSERT INTO `wp_shop_order_log` VALUES ('121', '58', '1', '您提交了订单，请等待商家确认', '1469554250', null);
INSERT INTO `wp_shop_order_log` VALUES ('122', '59', '1', '您提交了订单，请等待商家确认', '1469693015', null);

-- ----------------------------
-- Table structure for wp_shop_qrcode
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_qrcode`;
CREATE TABLE `wp_shop_qrcode` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `openid` varchar(255) NOT NULL,
  `agenttime` int(10) unsigned NOT NULL,
  `focus_url` varchar(255) NOT NULL,
  `agent_url` varchar(255) NOT NULL,
  `ticket` varchar(255) NOT NULL,
  `cTime` int(10) unsigned NOT NULL,
  `remark` varchar(255) NOT NULL,
  `mobile` bigint(11) unsigned NOT NULL,
  `activatcode` varchar(255) NOT NULL,
  `super` tinyint(1) unsigned DEFAULT '0' COMMENT '1为代理点',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_qrcode
-- ----------------------------
INSERT INTO `wp_shop_qrcode` VALUES ('1', 'o1teys2GjrPml9z27-qTlc3Qad14', '1463372421', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQES8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3VFaHJ5R3prLURXRnNlLUFsMkFTAAIE0HUgVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/1/tM7PDzU58m', 'gQES8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3VFaHJ5R3prLURXRnNlLUFsMkFTAAIE0HUgVwMEAAAAAA==', '1463314400', '', '15578881007', 'tM7PDzU58m', '1');
INSERT INTO `wp_shop_qrcode` VALUES ('2', 'o1teysxaWmeTjW6HoDruIYb004SU', '1463371311', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQG_8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzAwaGxQWkRrLWpXSDA0UTVtV0FTAAIE3nUgVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/2/82Bm99VNUG', 'gQG_8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzAwaGxQWkRrLWpXSDA0UTVtV0FTAAIE3nUgVwMEAAAAAA==', '1463364267', '', '13877152546', '82Bm99VNUG', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('3', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '1463384257', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFI7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2hVaHdxVHprNERXWnZkS21qR0FTAAIEDXsgVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/3/fJD7v8v0tB', 'gQFI7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2hVaHdxVHprNERXWnZkS21qR0FTAAIEDXsgVwMEAAAAAA==', '1463384225', '', '18007800880', 'fJD7v8v0tB', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('4', 'o1teysyjFEoTsZRRVprjExU6w4EE', '1463389252', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEW8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzJVZ0dRSWJrN3pXV3NvNDJfbUFTAAIE4XwgVwMEAAAAAA==', '', 'gQEW8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzJVZ0dRSWJrN3pXV3NvNDJfbUFTAAIE4XwgVwMEAAAAAA==', '1463389252', '', '13005925270', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('5', 'o1teys0U4AM_Ex-buqh9BJhJHIjw', '1463389719', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQE57zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2xraHh5WGprN3pXV2lzSElqV0FTAAIE43wgVwMEAAAAAA==', '', 'gQE57zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2xraHh5WGprN3pXV2lzSElqV0FTAAIE43wgVwMEAAAAAA==', '1463389718', '', '15240681423', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('6', 'o1teysz6mc08bAuPr5APGSW20dnU', '1463459273', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQG/7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3hFaEZ5LXJrMnpXaVdKUEt1V0FTAAIE5XwgVwMEAAAAAA==', '', 'gQG/7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3hFaEZ5LXJrMnpXaVdKUEt1V0FTAAIE5XwgVwMEAAAAAA==', '1463459273', '', '14777363078', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('7', 'o1teysy_HdOBTKvdeMMDViaby4d4', '1463489390', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHL7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzNFaEZhVWprb1RYWVVJc1N1V0FTAAIE5nwgVwMEAAAAAA==', '', 'gQHL7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzNFaEZhVWprb1RYWVVJc1N1V0FTAAIE5nwgVwMEAAAAAA==', '1463489389', '', '15676766951', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('8', 'o1teys-hETQ5mZIHGRdDwnbMbiyw', '1463489408', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFw7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3BraFUzcFBreURXeFJ2SGRxR0FTAAIE6HwgVwMEAAAAAA==', '', 'gQFw7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3BraFUzcFBreURXeFJ2SGRxR0FTAAIE6HwgVwMEAAAAAA==', '1463489408', '', '18077112342', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('9', 'o1teys_1XikMm-IDIowP9lbcfudw', '1463503233', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFA8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL28waTZiV2prTWpWTEMtUjZSbUFTAAIE6nwgVwMEAAAAAA==', '', 'gQFA8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL28waTZiV2prTWpWTEMtUjZSbUFTAAIE6nwgVwMEAAAAAA==', '1463503233', '', '15177783245', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('10', 'o1teysxq-w7epKRySMZ6bmtV75HQ', '1463573332', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEU7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2FFaHFlem5rNXpXZWh6OXBsbUFTAAIE7HwgVwMEAAAAAA==', '', 'gQEU7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2FFaHFlem5rNXpXZWh6OXBsbUFTAAIE7HwgVwMEAAAAAA==', '1463573332', '', '13907716972', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('11', 'o1teysyBZtb9ykG_73aU-5atgsXo', '1463577819', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEQ8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3BrZ1JraTdrakRYMXQtR1E3V0FTAAIE7nwgVwMEAAAAAA==', '', 'gQEQ8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3BrZ1JraTdrakRYMXQtR1E3V0FTAAIE7nwgVwMEAAAAAA==', '1463577818', '', '18078106598', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('12', 'o1teys39jDjN56TGWhmKib6Awjek', '1463583876', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQE/7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzdraHdKOWJrbnpYbXNybFhqR0FTAAIE73wgVwMEAAAAAA==', '', 'gQE/7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzdraHdKOWJrbnpYbXNybFhqR0FTAAIE73wgVwMEAAAAAA==', '1463583876', '', '13807765679', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('13', 'o1teys_s-cEvLcqQEJiYHWntIjSk', '1463586278', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEl8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzlVaVdEQmprRHpWMlRLSUthbUFTAAIE8XwgVwMEAAAAAA==', '', 'gQEl8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzlVaVdEQmprRHpWMlRLSUthbUFTAAIE8XwgVwMEAAAAAA==', '1463586278', '', '18677182856', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('14', 'o1teys4SeyMfFj49664lIN-9_C_k', '1463631509', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQF/7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3RraVhhVnZrQ1RWd0tlRm9hMkFTAAIE83wgVwMEAAAAAA==', '', 'gQF/7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3RraVhhVnZrQ1RWd0tlRm9hMkFTAAIE83wgVwMEAAAAAA==', '1463631508', '', '13878261985', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('15', 'o1teys8MFXzN79qLlnXrfgT1tBMI', '1463633043', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQE97zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3lVaFZ1eUhreURXeC1wNjVxV0FTAAIEP30gVwMEAAAAAA==', '', 'gQE97zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3lVaFZ1eUhreURXeC1wNjVxV0FTAAIEP30gVwMEAAAAAA==', '1463633042', '', '18377741787', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('16', 'o1teyswiajvwzepp1umQUAHqUVmg', '1463649614', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQH27zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0wwZzA5Ni1rMWpXdjJuaUt5R0FTAAIEeX0gVwMEAAAAAA==', '', 'gQH27zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0wwZzA5Ni1rMWpXdjJuaUt5R0FTAAIEeX0gVwMEAAAAAA==', '1463649613', '', '18007717627', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('17', 'o1teys0wkRQRAcwEnUDPFY0Eic_g', '1463662669', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQE/8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3ZFZ1FyTURrakRYMWZldXY3R0FTAAIEbokgVwMEAAAAAA==', '', 'gQE/8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3ZFZ1FyTURrakRYMWZldXY3R0FTAAIEbokgVwMEAAAAAA==', '1463662668', '', '13878119113', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('18', 'o1teys8SxM-wMMbCapqQhhg_CRVU', '1466068356', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFw8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2ZVZ09MYVBrbGpYdlhpb3E4bUFTAAIExokgVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/18/rCE8Norflm', 'gQFw8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2ZVZ09MYVBrbGpYdlhpb3E4bUFTAAIExokgVwMEAAAAAA==', '1463710422', '', '18826090296', 'rCE8Norflm', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('19', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQH18DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0FVaWg3RUxrTVRWSUFsYmpYV0FTAAIEAYogVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/19/AtS1D8aVTF', 'gQH18DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0FVaWg3RUxrTVRWSUFsYmpYV0FTAAIEAYogVwMEAAAAAA==', '1463710429', '', '0', 'AtS1D8aVTF', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('20', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQGv8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2UwaDlnVDNrNkRXUmFpeUxnV0FTAAIESoogVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/20/41Ulak1dPn', 'gQGv8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2UwaDlnVDNrNkRXUmFpeUxnV0FTAAIESoogVwMEAAAAAA==', '1463710433', '', '0', '41Ulak1dPn', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('21', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFr8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3BrZ0JsMGZra3pYcTItR2EtV0FTAAIEY4ogVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/21/b2IzqW1GwI', 'gQFr8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3BrZ0JsMGZra3pYcTItR2EtV0FTAAIEY4ogVwMEAAAAAA==', '1463710438', '', '0', 'b2IzqW1GwI', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('22', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEM8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0xFZ2xpUjdrdVRYQUZudUsyV0FTAAIEzGw_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/22/GcRYUlgkVb', 'gQEM8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0xFZ2xpUjdrdVRYQUZudUsyV0FTAAIEzGw_VwMEAAAAAA==', '1463710442', '', '0', 'GcRYUlgkVb', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('23', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHX8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1ZFZ0F2YnJrbXpYaS1nTzUtR0FTAAIE9YogVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/23/wIafwVQYCr', 'gQHX8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1ZFZ0F2YnJrbXpYaS1nTzUtR0FTAAIE9YogVwMEAAAAAA==', '1463710446', '', '0', 'wIafwVQYCr', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('24', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQGD8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3JraVMwVVBrZXpVQ2tmbW5ibUFTAAIEqYsgVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/24/MMWwIcVrup', 'gQGD8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3JraVMwVVBrZXpVQ2tmbW5ibUFTAAIEqYsgVwMEAAAAAA==', '1463710451', '', '0', 'MMWwIcVrup', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('25', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQGH8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0FFZ00zem5rbnpYbVMxZlQ4R0FTAAIED8IgVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/25/7ouxhvN0Wc', 'gQGH8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0FFZ00zem5rbnpYbVMxZlQ4R0FTAAIED8IgVwMEAAAAAA==', '1463710455', '', '0', '7ouxhvN0Wc', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('26', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEb8ToAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0VVaE5PNFhrMkRXaEFrWXhzV0FTAAIEhdAgVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/26/uhTOblYmtX', 'gQEb8ToAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0VVaE5PNFhrMkRXaEFrWXhzV0FTAAIEhdAgVwMEAAAAAA==', '1463710466', '', '0', 'uhTOblYmtX', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('27', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQGt8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3pFZ0pQWURrblRYazNKczI5V0FTAAIETYghVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/27/56m1agdwhJ', 'gQGt8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3pFZ0pQWURrblRYazNKczI5V0FTAAIETYghVwMEAAAAAA==', '1463710470', '', '0', '56m1agdwhJ', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('28', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQH28DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0VrZ0hEakxrbkRYbGcwVUtfMkFTAAIEAIkhVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/28/BdS5AN3KaS', 'gQH28DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0VrZ0hEakxrbkRYbGcwVUtfMkFTAAIEAIkhVwMEAAAAAA==', '1463710474', '', '0', 'BdS5AN3KaS', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('29', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQF77zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0JVaG11SHprOHpXS2JGS3ltbUFTAAIEBlEoVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/29/8WiyaWZUNp', 'gQF77zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0JVaG11SHprOHpXS2JGS3ltbUFTAAIEBlEoVwMEAAAAAA==', '1463710492', '', '0', '8WiyaWZUNp', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('30', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHF7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0hrZ0hjdlBrOURXTk1ra2VfMkFTAAIEMVMoVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/30/s04N8TPnR0', 'gQHF7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0hrZ0hjdlBrOURXTk1ra2VfMkFTAAIEMVMoVwMEAAAAAA==', '1463710496', '', '0', 's04N8TPnR0', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('31', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFu7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1lFZ3JsdjNrdWpYRHBqZVkxMkFTAAIEMm0oVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/31/HAZxq1kohM', 'gQFu7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1lFZ3JsdjNrdWpYRHBqZVkxMkFTAAIEMm0oVwMEAAAAAA==', '1463710500', '', '0', 'HAZxq1kohM', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('32', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEi7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL05rZ2VkWWZrbHpYdWFXRmo0bUFTAAIEOU8pVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/32/gEjZyzZ2La', 'gQEi7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL05rZ2VkWWZrbHpYdWFXRmo0bUFTAAIEOU8pVwMEAAAAAA==', '1463710504', '', '0', 'gEjZyzZ2La', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('33', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFI8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2pFZ1hhcUxrOWpXUDZkc1U2MkFTAAIE1lApVwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/33/fA1S3NcL5w', 'gQFI8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2pFZ1hhcUxrOWpXUDZkc1U2MkFTAAIE1lApVwMEAAAAAA==', '1463710510', '', '0', 'fA1S3NcL5w', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('34', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHB7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzcwaVM0MlBrZmpVSHdyaVFibUFTAAIEE20_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/34/6xBF6kyH2s', 'gQHB7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzcwaVM0MlBrZmpVSHdyaVFibUFTAAIEE20_VwMEAAAAAA==', '1463710514', '', '0', '6xBF6kyH2s', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('35', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFD8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1dVaGpmNVhrLURXRkhnNS1uMkFTAAIEGW0_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/35/Kn3nd1KebJ', 'gQFD8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1dVaGpmNVhrLURXRkhnNS1uMkFTAAIEGW0_VwMEAAAAAA==', '1463710519', '', '0', 'Kn3nd1KebJ', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('36', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEX8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3pFaWctLTNrUXpVNlk1dURYR0FTAAIEHW0_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/36/BCRbYaqQsp', 'gQEX8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3pFaWctLTNrUXpVNlk1dURYR0FTAAIEHW0_VwMEAAAAAA==', '1463710523', '', '0', 'BCRbYaqQsp', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('37', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFi7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2pVaFJaV2JrdERYTkk5b2ZyV0FTAAIEIG0_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/37/t4CLG7RZpM', 'gQFi7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2pVaFJaV2JrdERYTkk5b2ZyV0FTAAIEIG0_VwMEAAAAAA==', '1463710527', '', '0', 't4CLG7RZpM', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('38', 'o1teys--QgpSDXlTwHqBcEWKJTfY', '1463712298', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFT7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0FFaGJ1a1hrMWpXdlVsZW9wMkFTAAIEC3Q_VwMEAAAAAA==', '', 'gQFT7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0FFaGJ1a1hrMWpXdlVsZW9wMkFTAAIEC3Q_VwMEAAAAAA==', '1463712297', '', '18007801742', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('39', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFL8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2MwaFljNVRrM0RXbE9TUm9wR0FTAAIEnX0_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/39/8EdJluufMf', 'gQFL8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2MwaFljNVRrM0RXbE9TUm9wR0FTAAIEnX0_VwMEAAAAAA==', '1463714747', '', '0', '8EdJluufMf', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('40', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQGX8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzVVZy0yN2prcWpYVEs3TFJ3MkFTAAIEpH0_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/40/FNtXdDKIXR', 'gQGX8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzVVZy0yN2prcWpYVEs3TFJ3MkFTAAIEpH0_VwMEAAAAAA==', '1463714754', '', '0', 'FNtXdDKIXR', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('41', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHq7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3JVaW8zbi1rUFRWRW9mclVWR0FTAAIErX0_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/41/HXnCnOWCVw', 'gQHq7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3JVaW8zbi1rUFRWRW9mclVWR0FTAAIErX0_VwMEAAAAAA==', '1463714763', '', '0', 'HXnCnOWCVw', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('42', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQG17zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL01FaGNPQnZrMURXdHZtY3ZvR0FTAAIEsX0_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/42/jfDt36C9Jy', 'gQG17zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL01FaGNPQnZrMURXdHZtY3ZvR0FTAAIEsX0_VwMEAAAAAA==', '1463714767', '', '0', 'jfDt36C9Jy', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('43', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQER8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1FraXM2SkxrSWpWYmxSWDVVR0FTAAIEtX0_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/43/tZWQxWeoiU', 'gQER8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1FraXM2SkxrSWpWYmxSWDVVR0FTAAIEtX0_VwMEAAAAAA==', '1463714771', '', '0', 'tZWQxWeoiU', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('44', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHk7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1hVaVkwdEhrZlRVRTh3cW9aR0FTAAIEuX0_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/44/m7gjH0qj5a', 'gQHk7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1hVaVkwdEhrZlRVRTh3cW9aR0FTAAIEuX0_VwMEAAAAAA==', '1463714775', '', '0', 'm7gjH0qj5a', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('45', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHJ7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2hVaHFhaDdrNFRXWVhOSl9sbUFTAAIEvX0_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/45/XDdVhElyYS', 'gQHJ7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2hVaHFhaDdrNFRXWVhOSl9sbUFTAAIEvX0_VwMEAAAAAA==', '1463714779', '', '0', 'XDdVhElyYS', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('46', '', '0', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHq7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2NFaUVSSWJrQ0RWeEh5ZFhlR0FTAAIEwX0_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/46/sRs2IwwNI4', 'gQHq7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2NFaUVSSWJrQ0RWeEh5ZFhlR0FTAAIEwX0_VwMEAAAAAA==', '1463714783', '', '0', 'sRs2IwwNI4', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('47', 'o1teys3Upifr-eineGRs_ExJ8Ts0', '1464759582', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQGb7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3RraXhpWERrTHpWVzR1R0lUV0FTAAIExX0_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/47/UfPO3eT6BR', 'gQGb7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3RraXhpWERrTHpWVzR1R0lUV0FTAAIExX0_VwMEAAAAAA==', '1463714787', '', '13237711900', 'UfPO3eT6BR', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('48', 'o1teys36GpmIA-wcalnS_IQpqHWo', '1464074447', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQG67zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3VFaDBsN1Bra3pYcU1lLXZpR0FTAAIEyn0_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/48/tsNPvEaEEK', 'gQG67zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3VFaDBsN1Bra3pYcU1lLXZpR0FTAAIEyn0_VwMEAAAAAA==', '1463714792', '', '18269023280', 'tsNPvEaEEK', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('49', 'o1teys56D1mJMn4phbY3K7rYoVBI', '1464237065', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQF87zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzRVaFJObS1reXpXeUZiWXpyV0FTAAIEzn0_VwMEAAAAAA==', 'http://pan.baidu.com/share/qrcode?w=430&h=430&url=http://lao337.zinongweb.com/agent/activat/49/vkqpMyMQaI', 'gQF87zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzRVaFJObS1reXpXeUZiWXpyV0FTAAIEzn0_VwMEAAAAAA==', '1463714797', '', '18007800880', 'vkqpMyMQaI', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('50', 'o1teys7n2VqVKXbF_i7LDfT8zCaM', '1463718867', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEn8ToAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0RVaVRkVW5rQmpWLW5GcC1iMkFTAAIEtI0_VwMEAAAAAA==', '', 'gQEn8ToAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0RVaVRkVW5rQmpWLW5GcC1iMkFTAAIEtI0_VwMEAAAAAA==', '1463718866', '', '18934715979', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('51', 'o1teys4N2zQTvic-Jg1erEi3bxYA', '1463799415', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEd7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1pFaGVPcmpreWpXelN6TXhvbUFTAAIEWsg/VwMEAAAAAA==', '', 'gQEd7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1pFaGVPcmpreWpXelN6TXhvbUFTAAIEWsg/VwMEAAAAAA==', '1463799414', '', '18677686783', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('52', 'o1teys_TnbMJ08GlKeTruOaIdkgA', '1464002466', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHm7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3kwZ1pQMlRraURYeFBad3g1V0FTAAIETOFCVwMEAAAAAA==', '', 'gQHm7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3kwZ1pQMlRraURYeFBad3g1V0FTAAIETOFCVwMEAAAAAA==', '1464002466', '', '13907714376', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('53', 'o1teyszPS7rS6126eDZb2TqpS8DA', '1464074420', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHe7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0VraDJHQWprNWpXZnIwVVhpbUFTAAIEX/pDVwMEAAAAAA==', '', 'gQHe7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0VraDJHQWprNWpXZnIwVVhpbUFTAAIEX/pDVwMEAAAAAA==', '1464074420', '', '15159806569', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('54', 'o1teyswwqiSYDhR0leTUOREhoEI8', '1464074629', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQF/7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3dVajZ2SFhrY3pVS3BaYXFCbUFTAAIEMPtDVwMEAAAAAA==', '', 'gQF/7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3dVajZ2SFhrY3pVS3BaYXFCbUFTAAIEMPtDVwMEAAAAAA==', '1464074629', '', '15159806569', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('55', 'o1teys-3TogDgP5YRIF1mEP6bfko', '1464086940', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQGe7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2xFakc0UXJrSXpWYTBzT2JPbUFTAAIERytEVwMEAAAAAA==', '', 'gQGe7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2xFakc0UXJrSXpWYTBzT2JPbUFTAAIERytEVwMEAAAAAA==', '1464086939', '', '18777161857', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('56', 'o1teysxSSrfPUmb_WELwwDSalNQY', '1464334829', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEv8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL18wZ283ai1rc3pYS2g2enExR0FTAAIEA/pHVwMEAAAAAA==', '', 'gQEv8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL18wZ283ai1rc3pYS2g2enExR0FTAAIEA/pHVwMEAAAAAA==', '1464334829', '', '13878118855', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('57', 'o1teys2Kdb7MBU_pXW2voOm47Z6I', '1464446037', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEr8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzAwaF94S3ZrNVRXY0VZVEFnbUFTAAIEbaxJVwMEAAAAAA==', '', 'gQEr8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzAwaF94S3ZrNVRXY0VZVEFnbUFTAAIEbaxJVwMEAAAAAA==', '1464446037', '', '13087900925', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('58', 'o1teys8yfbfHOhCIXHgpTrV_IumU', '1464849970', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFX7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3FFaGRmeFRreHpXX2J2OTZvV0FTAAIEUtZPVwMEAAAAAA==', '', 'gQFX7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3FFaGRmeFRreHpXX2J2OTZvV0FTAAIEUtZPVwMEAAAAAA==', '1464849969', '', '15296281306', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('59', 'o1teys1pVoyU_tMSrf-Tw03gEH1g', '1465199618', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFe7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3lraHVNeDdrX3pXQ1NwMDVrbUFTAAIEKCxVVwMEAAAAAA==', '', 'gQFe7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3lraHVNeDdrX3pXQ1NwMDVrbUFTAAIEKCxVVwMEAAAAAA==', '1465199617', '', '18877160061', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('60', 'o1teys0RqQStJpR9Q9t5-HMRNSZg', '1465203699', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQGt7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3dFajVqZkxrY1RVSUVwZWFCV0FTAAIEGTxVVwMEAAAAAA==', '', 'gQGt7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3dFajVqZkxrY1RVSUVwZWFCV0FTAAIEGTxVVwMEAAAAAA==', '1465203699', '', '18677630103', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('61', 'o1teys_RpX3iYldXit-seIl15Na4', '1465205858', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFj8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3pFalhWS0RrUERWRmxac2dLMkFTAAIEiERVVwMEAAAAAA==', '', 'gQFj8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3pFalhWS0RrUERWRmxac2dLMkFTAAIEiERVVwMEAAAAAA==', '1465205858', '', '18198359715', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('62', 'o1teys5-BrWVIgFFBcgDI-E05Dr0', '1465209572', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQH37zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0ZFaFpIYy1rMXpXdWEwTU1wV0FTAAIEClNVVwMEAAAAAA==', '', 'gQH37zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0ZFaFpIYy1rMXpXdWEwTU1wV0FTAAIEClNVVwMEAAAAAA==', '1465209571', '', '13647813677', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('63', 'o1teyszzLV1ixOahZY0Q4yv1QjMU', '1465273116', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFq7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1pFZ05BU2ZraXpYeTd6TVk4V0FTAAIEREtWVwMEAAAAAA==', '', 'gQFq7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1pFZ05BU2ZraXpYeTd6TVk4V0FTAAIEREtWVwMEAAAAAA==', '1465273115', '', '13481170558', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('64', 'o1teysxKg681M1gWXGMhDhMjDIiE', '1465721672', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFy7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2pFZ00tUlhrbFRYc3lkdjc4R0FTAAIEdyNdVwMEAAAAAA==', '', 'gQFy7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2pFZ00tUlhrbFRYc3lkdjc4R0FTAAIEdyNdVwMEAAAAAA==', '1465721671', '', '13307816690', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('65', 'o1teys4ZEUzcYSwNHyuhGMFHqPdQ', '1465721940', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQED8ToAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0YwZzNmVi1rcURYUm1FQjl5MkFTAAIEgyRdVwMEAAAAAA==', '', 'gQED8ToAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0YwZzNmVi1rcURYUm1FQjl5MkFTAAIEgyRdVwMEAAAAAA==', '1465721940', '', '18320865848', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('66', 'o1teys-NeHNWytkAxk-OTvWxavbM', '1465779252', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQGv7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzdValdDVWprTURWSkFicHdLbUFTAAIEZAReVwMEAAAAAA==', '', 'gQGv7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xLzdValdDVWprTURWSkFicHdLbUFTAAIEZAReVwMEAAAAAA==', '1465779252', '', '18249948911', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('67', 'o1teys1U82NCJnKnMnRAWozW9erY', '1465789061', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQF38DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0YwaERXWXprMGpXcmIwQlh2MkFTAAIEtSpeVwMEAAAAAA==', '', 'gQF38DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0YwaERXWXprMGpXcmIwQlh2MkFTAAIEtSpeVwMEAAAAAA==', '1465789061', '', '18076522824', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('68', 'o1teys-gDeWFtcTHcoadItuuhSso', '1465791135', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQFR8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1IwZ0cxOXZrNGpXYjVoQ3NfbUFTAAIE0DJeVwMEAAAAAA==', '', 'gQFR8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL1IwZ0cxOXZrNGpXYjVoQ3NfbUFTAAIE0DJeVwMEAAAAAA==', '1465791135', '', '18275858128', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('69', 'o1teys8HieiDbuSvhK7Y2DbIuOpA', '1465809190', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHK7joAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3VrandyV25rYnpVVzBfMnRER0FTAAIEVnleVwMEAAAAAA==', '', 'gQHK7joAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3VrandyV25rYnpVVzBfMnRER0FTAAIEVnleVwMEAAAAAA==', '1465809189', '', '15677627830', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('70', 'o1teyszu1qNiSJJwai60rOo4UW1A', '1466058636', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQGM7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2MwZ2llbVRrdHpYT3dDUnczbUFTAAIEwUdiVwMEAAAAAA==', '', 'gQGM7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2MwZ2llbVRrdHpYT3dDUnczbUFTAAIEwUdiVwMEAAAAAA==', '1466058635', '', '18286475246', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('71', 'o1teysyP2u3i5FLLOsBywnlK8Sa8', '1466766672', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHz7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0NFaGpLNFRrLXpXR0NsOG9uMkFTAAIEWhVtVwMEAAAAAA==', '', 'gQHz7zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0NFaGpLNFRrLXpXR0NsOG9uMkFTAAIEWhVtVwMEAAAAAA==', '1466766672', '', '18578987026', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('72', 'o1teys37ATpSz5BK5HeiSQ6OAIZ4', '1467040903', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQG17zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2VrZ1JhbC1rOERXSjRpMFU3V0FTAAIEfURxVwMEAAAAAA==', '', 'gQG17zoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2VrZ1JhbC1rOERXSjRpMFU3V0FTAAIEfURxVwMEAAAAAA==', '1467040903', '', '18878656929', '', '0');
INSERT INTO `wp_shop_qrcode` VALUES ('73', 'o1teys2fjdJbcE--zaLdyFTJl2lg', '1467712438', 'https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHk8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3FVaGZkTC1rMFRXb3otNWxvMkFTAAIEsYN7VwMEAAAAAA==', '', 'gQHk8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3FVaGZkTC1rMFRXb3otNWxvMkFTAAIEsYN7VwMEAAAAAA==', '1467712438', '', '15577728507', '', '0');

-- ----------------------------
-- Table structure for wp_shop_slideshow
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_slideshow`;
CREATE TABLE `wp_shop_slideshow` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `img` varchar(255) NOT NULL COMMENT '图片',
  `url` varchar(255) DEFAULT NULL COMMENT '链接地址',
  `is_show` tinyint(2) DEFAULT '1' COMMENT '是否显示',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序',
  `token` varchar(100) DEFAULT NULL COMMENT 'Token',
  `shop_id` int(10) DEFAULT '0' COMMENT '商店ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_slideshow
-- ----------------------------
INSERT INTO `wp_shop_slideshow` VALUES ('1', '红灯樱桃', 'goods/2016/05/23/201605231024225214.jpg', 'http://lao337.zinongweb.com/mall/detail/8', '0', '2', null, '0');
INSERT INTO `wp_shop_slideshow` VALUES ('3', '灵芝鸡', 'goods/2016/05/23/201605231023564233.jpg', 'http://lao337.zinongweb.com/mall/detail/3', '1', '1', null, '0');
INSERT INTO `wp_shop_slideshow` VALUES ('4', '黄蜜樱桃', 'goods/2016/05/23/201605231023342131.jpg', 'http://lao337.zinongweb.com/mall/detail/19', '1', '0', null, '0');

-- ----------------------------
-- Table structure for wp_shop_source
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_source`;
CREATE TABLE `wp_shop_source` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `product_cource` varchar(500) DEFAULT NULL COMMENT '种苗及来源',
  `product_trait` varchar(500) DEFAULT NULL COMMENT '产品特点',
  `farm` varchar(500) DEFAULT NULL COMMENT '养殖场介绍',
  `node` varchar(500) DEFAULT NULL COMMENT '重要节点',
  `importance` varchar(500) DEFAULT NULL COMMENT '重要事件',
  `farmer_movie` varchar(500) DEFAULT NULL COMMENT '农夫视频',
  `farmer_picture` varchar(500) DEFAULT NULL,
  `farmer_info` varchar(500) DEFAULT NULL COMMENT '农夫文字信息',
  `report` varchar(500) DEFAULT NULL COMMENT '报告图片上传',
  `cook` varchar(50) DEFAULT NULL COMMENT '图文推荐吃法',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_source
-- ----------------------------

-- ----------------------------
-- Table structure for wp_shop_voucherinfo
-- ----------------------------
DROP TABLE IF EXISTS `wp_shop_voucherinfo`;
CREATE TABLE `wp_shop_voucherinfo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) unsigned NOT NULL COMMENT '商品ID',
  `number` int(10) unsigned DEFAULT NULL COMMENT '数量',
  `sign` varchar(32) DEFAULT NULL COMMENT '签名md5(goods_id+addtime)',
  `addtime` int(10) DEFAULT NULL,
  `owner_id` varchar(255) DEFAULT NULL COMMENT '电子券拥有者微信ID',
  `get_time` varchar(255) DEFAULT NULL COMMENT '转电子券时间',
  `use_time` int(10) unsigned DEFAULT NULL COMMENT '使用时间',
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '券状态：0未使用，1转电子券，2已使用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_shop_voucherinfo
-- ----------------------------
INSERT INTO `wp_shop_voucherinfo` VALUES ('1', '3', '1', 'af2739acc53da4f300d42dc96f8e07df', '1472967113', 'o1teys8ZQeB8kfP7UQe3NHTI-d6w', '1472977167', null, '1');

-- ----------------------------
-- Table structure for wp_smalltools
-- ----------------------------
DROP TABLE IF EXISTS `wp_smalltools`;
CREATE TABLE `wp_smalltools` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tooltype` tinyint(2) DEFAULT '0' COMMENT '工具类型',
  `keyword` varchar(255) DEFAULT NULL COMMENT ' 关键词 ',
  `cTime` int(10) DEFAULT NULL COMMENT '创建时间',
  `toolname` varchar(255) DEFAULT NULL COMMENT '工具名称',
  `tooldes` text COMMENT '工具描述',
  `toolnum` varchar(255) DEFAULT NULL COMMENT '工具唯一编号',
  `toolstate` tinyint(2) DEFAULT '0' COMMENT '工具状态',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_smalltools
-- ----------------------------

-- ----------------------------
-- Table structure for wp_sms
-- ----------------------------
DROP TABLE IF EXISTS `wp_sms`;
CREATE TABLE `wp_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `from_type` varchar(255) DEFAULT NULL COMMENT '用途',
  `code` varchar(255) DEFAULT NULL COMMENT '验证码',
  `smsId` varchar(255) DEFAULT NULL COMMENT '短信唯一标识',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机号',
  `cTime` int(10) DEFAULT NULL COMMENT '创建时间',
  `status` int(10) DEFAULT NULL COMMENT '使用状态',
  `plat_type` int(10) DEFAULT NULL COMMENT '平台标识',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_sms
-- ----------------------------

-- ----------------------------
-- Table structure for wp_sn_code
-- ----------------------------
DROP TABLE IF EXISTS `wp_sn_code`;
CREATE TABLE `wp_sn_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sn` varchar(255) DEFAULT NULL COMMENT 'SN码',
  `uid` int(10) DEFAULT NULL COMMENT '粉丝UID',
  `cTime` int(10) DEFAULT NULL COMMENT '创建时间',
  `is_use` tinyint(2) DEFAULT '0' COMMENT '是否已使用',
  `use_time` int(10) DEFAULT NULL COMMENT '使用时间',
  `addon` varchar(255) DEFAULT 'Coupon' COMMENT '来自的插件',
  `target_id` int(10) unsigned DEFAULT NULL COMMENT '来源ID',
  `prize_id` int(10) unsigned DEFAULT NULL COMMENT '奖项ID',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `prize_title` varchar(255) DEFAULT NULL COMMENT '奖项',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `can_use` tinyint(2) DEFAULT '1' COMMENT '是否可用',
  `server_addr` varchar(50) DEFAULT NULL COMMENT '服务器IP',
  `admin_uid` int(10) DEFAULT NULL COMMENT '核销管理员ID',
  PRIMARY KEY (`id`),
  KEY `id` (`uid`,`target_id`,`addon`),
  KEY `addon` (`target_id`,`addon`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_sn_code
-- ----------------------------

-- ----------------------------
-- Table structure for wp_sports
-- ----------------------------
DROP TABLE IF EXISTS `wp_sports`;
CREATE TABLE `wp_sports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `score` varchar(30) DEFAULT NULL COMMENT '比分',
  `content` text COMMENT '说明',
  `start_time` int(10) DEFAULT NULL COMMENT '时间',
  `visit_team` varchar(255) DEFAULT NULL COMMENT '客场球队',
  `home_team` varchar(255) DEFAULT NULL COMMENT '主场球队',
  `countdown` int(10) DEFAULT '60' COMMENT '擂鼓时长',
  `drum_count` int(10) DEFAULT '0' COMMENT '擂鼓次数',
  `drum_follow_count` int(10) DEFAULT '0' COMMENT '擂鼓人数',
  `home_team_support_count` int(10) DEFAULT '0' COMMENT '主场球队支持数',
  `visit_team_support_count` int(10) DEFAULT '0' COMMENT '客场球队支持人数',
  `home_team_drum_count` int(10) DEFAULT '0' COMMENT '主场球队擂鼓数',
  `visit_team_drum_count` int(10) DEFAULT '0' COMMENT '客场球队擂鼓数',
  `yaotv_count` int(10) DEFAULT '0' COMMENT '摇一摇总次',
  `draw_count` int(10) DEFAULT '0' COMMENT '抽奖总次数',
  `is_finish` tinyint(2) DEFAULT '0' COMMENT '是否已结束',
  `yaotv_follow_count` int(10) DEFAULT '0' COMMENT '摇电视总人数',
  `draw_follow_count` int(10) DEFAULT '0' COMMENT '抽奖总人数',
  `comment_status` tinyint(2) DEFAULT '0' COMMENT '评论是否需要审核',
  PRIMARY KEY (`id`),
  KEY `start_time` (`start_time`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_sports
-- ----------------------------

-- ----------------------------
-- Table structure for wp_sports_drum
-- ----------------------------
DROP TABLE IF EXISTS `wp_sports_drum`;
CREATE TABLE `wp_sports_drum` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sports_id` int(10) DEFAULT NULL COMMENT '场次ID',
  `team_id` int(10) DEFAULT NULL COMMENT '球队ID',
  `follow_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `drum_count` int(10) DEFAULT NULL COMMENT '擂鼓次数',
  `cTime` int(10) DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`),
  KEY `ctime` (`sports_id`,`cTime`),
  KEY `team_id` (`sports_id`,`team_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_sports_drum
-- ----------------------------

-- ----------------------------
-- Table structure for wp_sports_support
-- ----------------------------
DROP TABLE IF EXISTS `wp_sports_support`;
CREATE TABLE `wp_sports_support` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sports_id` int(10) DEFAULT NULL COMMENT '场次ID',
  `team_id` int(10) DEFAULT NULL COMMENT '球队ID',
  `follow_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `cTime` int(10) DEFAULT NULL COMMENT '支持时间',
  PRIMARY KEY (`id`),
  KEY `sf` (`sports_id`,`follow_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_sports_support
-- ----------------------------

-- ----------------------------
-- Table structure for wp_sports_team
-- ----------------------------
DROP TABLE IF EXISTS `wp_sports_team`;
CREATE TABLE `wp_sports_team` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sort` int(10) DEFAULT '0' COMMENT '排序号',
  `intro` text COMMENT '球队说明',
  `pid` int(10) DEFAULT '0' COMMENT 'pid',
  `logo` int(10) unsigned DEFAULT NULL COMMENT '球队图标',
  `title` varchar(100) DEFAULT NULL COMMENT '球队名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_sports_team
-- ----------------------------

-- ----------------------------
-- Table structure for wp_sport_award
-- ----------------------------
DROP TABLE IF EXISTS `wp_sport_award`;
CREATE TABLE `wp_sport_award` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `img` int(10) NOT NULL COMMENT '奖品图片',
  `name` varchar(255) NOT NULL COMMENT '奖项名称',
  `score` int(10) DEFAULT '0' COMMENT '积分数',
  `award_type` varchar(30) DEFAULT '1' COMMENT '奖品类型',
  `price` float DEFAULT '0' COMMENT '商品价格',
  `explain` text COMMENT '奖品说明',
  `count` int(10) NOT NULL COMMENT '奖品数量',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序号',
  `uid` int(10) DEFAULT NULL COMMENT 'uid',
  `token` varchar(255) DEFAULT NULL COMMENT 'token',
  `coupon_id` char(50) DEFAULT NULL COMMENT '选择赠送券',
  `money` float DEFAULT NULL COMMENT '返现金额',
  `aim_table` varchar(255) DEFAULT NULL COMMENT '活动标识',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_sport_award
-- ----------------------------

-- ----------------------------
-- Table structure for wp_store
-- ----------------------------
DROP TABLE IF EXISTS `wp_store`;
CREATE TABLE `wp_store` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `uid` int(10) DEFAULT '0' COMMENT '用户ID',
  `content` text COMMENT '内容',
  `cTime` int(10) DEFAULT NULL COMMENT '发布时间',
  `attach` varchar(255) DEFAULT NULL COMMENT '插件安装包',
  `is_top` int(10) DEFAULT '0' COMMENT '置顶',
  `cid` tinyint(4) DEFAULT NULL COMMENT '分类',
  `view_count` int(11) unsigned DEFAULT '0' COMMENT '浏览数',
  `img_1` int(10) unsigned DEFAULT NULL COMMENT '插件截图1',
  `img_2` int(10) unsigned DEFAULT NULL COMMENT '插件截图2',
  `img_3` int(10) unsigned DEFAULT NULL COMMENT '插件截图3',
  `img_4` int(10) unsigned DEFAULT NULL COMMENT '插件截图4',
  `download_count` int(10) unsigned DEFAULT '0' COMMENT '下载数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_store
-- ----------------------------

-- ----------------------------
-- Table structure for wp_sucai
-- ----------------------------
DROP TABLE IF EXISTS `wp_sucai`;
CREATE TABLE `wp_sucai` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) DEFAULT NULL COMMENT '素材名称',
  `status` char(10) DEFAULT 'UnSubmit' COMMENT '状态',
  `cTime` int(10) DEFAULT NULL COMMENT '提交时间',
  `url` varchar(255) DEFAULT NULL COMMENT '实际摇一摇所使用的页面URL',
  `type` varchar(255) DEFAULT NULL COMMENT '素材类型',
  `detail` text COMMENT '素材内容',
  `reason` text COMMENT '入库失败的原因',
  `create_time` int(10) DEFAULT NULL COMMENT '申请时间',
  `checked_time` int(10) DEFAULT NULL COMMENT '入库时间',
  `source` varchar(50) DEFAULT NULL COMMENT '来源',
  `source_id` int(10) DEFAULT NULL COMMENT '来源ID',
  `wechat_id` int(10) DEFAULT NULL COMMENT '微信端的素材ID',
  `uid` int(10) DEFAULT NULL COMMENT 'uid',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_sucai
-- ----------------------------

-- ----------------------------
-- Table structure for wp_sucai_template
-- ----------------------------
DROP TABLE IF EXISTS `wp_sucai_template`;
CREATE TABLE `wp_sucai_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(10) DEFAULT NULL COMMENT '管理员id',
  `token` varchar(255) DEFAULT NULL COMMENT '用户token',
  `addons` varchar(255) DEFAULT NULL COMMENT '插件名称',
  `template` varchar(255) DEFAULT NULL COMMENT '模版名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_sucai_template
-- ----------------------------

-- ----------------------------
-- Table structure for wp_survey
-- ----------------------------
DROP TABLE IF EXISTS `wp_survey`;
CREATE TABLE `wp_survey` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` varchar(100) NOT NULL COMMENT '关键词',
  `keyword_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '关键词类型',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `intro` text COMMENT '封面简介',
  `mTime` int(10) DEFAULT NULL COMMENT '修改时间',
  `cover` int(10) unsigned DEFAULT NULL COMMENT '封面图片',
  `cTime` int(10) unsigned DEFAULT NULL COMMENT '发布时间',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `finish_tip` text COMMENT '结束语',
  `template` varchar(255) DEFAULT 'default' COMMENT '素材模板',
  `start_time` int(10) DEFAULT NULL COMMENT '开始时间',
  `end_time` int(10) DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_survey
-- ----------------------------

-- ----------------------------
-- Table structure for wp_survey_answer
-- ----------------------------
DROP TABLE IF EXISTS `wp_survey_answer`;
CREATE TABLE `wp_survey_answer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `answer` text COMMENT '回答内容',
  `openid` varchar(255) DEFAULT NULL COMMENT 'OpenId',
  `uid` int(10) DEFAULT NULL COMMENT '用户UID',
  `question_id` int(10) unsigned NOT NULL COMMENT 'question_id',
  `cTime` int(10) unsigned DEFAULT NULL COMMENT '发布时间',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `survey_id` int(10) unsigned NOT NULL COMMENT 'survey_id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_survey_answer
-- ----------------------------

-- ----------------------------
-- Table structure for wp_survey_question
-- ----------------------------
DROP TABLE IF EXISTS `wp_survey_question`;
CREATE TABLE `wp_survey_question` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `intro` text COMMENT '问题描述',
  `cTime` int(10) unsigned DEFAULT NULL COMMENT '发布时间',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `is_must` tinyint(2) DEFAULT '0' COMMENT '是否必填',
  `extra` text COMMENT '参数',
  `type` char(50) NOT NULL DEFAULT 'radio' COMMENT '问题类型',
  `survey_id` int(10) unsigned NOT NULL COMMENT 'survey_id',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_survey_question
-- ----------------------------

-- ----------------------------
-- Table structure for wp_system_notice
-- ----------------------------
DROP TABLE IF EXISTS `wp_system_notice`;
CREATE TABLE `wp_system_notice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) DEFAULT NULL COMMENT '公告标题',
  `content` text COMMENT '公告内容',
  `create_time` int(10) DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_system_notice
-- ----------------------------

-- ----------------------------
-- Table structure for wp_test
-- ----------------------------
DROP TABLE IF EXISTS `wp_test`;
CREATE TABLE `wp_test` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` varchar(100) NOT NULL COMMENT '关键词',
  `keyword_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '关键词匹配类型',
  `title` varchar(255) NOT NULL COMMENT '问卷标题',
  `intro` text NOT NULL COMMENT '封面简介',
  `mTime` int(10) NOT NULL COMMENT '修改时间',
  `cover` int(10) unsigned NOT NULL COMMENT '封面图片',
  `token` varchar(255) NOT NULL COMMENT 'Token',
  `finish_tip` text NOT NULL COMMENT '评论语',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_test
-- ----------------------------

-- ----------------------------
-- Table structure for wp_test_answer
-- ----------------------------
DROP TABLE IF EXISTS `wp_test_answer`;
CREATE TABLE `wp_test_answer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `answer` text NOT NULL COMMENT '回答内容',
  `openid` varchar(255) NOT NULL COMMENT 'OpenId',
  `uid` int(10) NOT NULL COMMENT '用户UID',
  `question_id` int(10) unsigned NOT NULL COMMENT 'question_id',
  `cTime` int(10) unsigned NOT NULL COMMENT '发布时间',
  `token` varchar(255) NOT NULL COMMENT 'Token',
  `test_id` int(10) unsigned NOT NULL COMMENT 'test_id',
  `score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '得分',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_test_answer
-- ----------------------------

-- ----------------------------
-- Table structure for wp_test_question
-- ----------------------------
DROP TABLE IF EXISTS `wp_test_question`;
CREATE TABLE `wp_test_question` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL COMMENT '题目标题',
  `intro` text NOT NULL COMMENT '题目描述',
  `cTime` int(10) unsigned NOT NULL COMMENT '发布时间',
  `token` varchar(255) NOT NULL COMMENT 'Token',
  `is_must` tinyint(2) NOT NULL DEFAULT '1' COMMENT '是否必填',
  `extra` text NOT NULL COMMENT '参数',
  `type` char(50) NOT NULL DEFAULT 'radio' COMMENT '题目类型',
  `test_id` int(10) unsigned NOT NULL COMMENT 'test_id',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_test_question
-- ----------------------------

-- ----------------------------
-- Table structure for wp_tongji
-- ----------------------------
DROP TABLE IF EXISTS `wp_tongji`;
CREATE TABLE `wp_tongji` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `token` varchar(255) NOT NULL COMMENT 'Token',
  `month` int(10) NOT NULL COMMENT '月份',
  `day` int(10) NOT NULL COMMENT '日期',
  `content` text NOT NULL COMMENT '统计数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_tongji
-- ----------------------------

-- ----------------------------
-- Table structure for wp_update_score_log
-- ----------------------------
DROP TABLE IF EXISTS `wp_update_score_log`;
CREATE TABLE `wp_update_score_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `score` int(10) DEFAULT NULL COMMENT '修改积分',
  `branch_id` int(10) DEFAULT NULL COMMENT '修改门店',
  `operator` varchar(255) DEFAULT NULL COMMENT '操作员',
  `cTime` int(10) DEFAULT NULL COMMENT '修改时间',
  `token` varchar(255) DEFAULT NULL COMMENT 'token',
  `member_id` int(10) DEFAULT NULL COMMENT '会员卡id',
  `manager_id` int(10) DEFAULT NULL COMMENT '管理员id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_update_score_log
-- ----------------------------

-- ----------------------------
-- Table structure for wp_update_version
-- ----------------------------
DROP TABLE IF EXISTS `wp_update_version`;
CREATE TABLE `wp_update_version` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `version` int(10) unsigned NOT NULL COMMENT '版本号',
  `title` varchar(50) NOT NULL COMMENT '升级包名',
  `description` text COMMENT '描述',
  `create_date` int(10) DEFAULT NULL COMMENT '创建时间',
  `download_count` int(10) unsigned DEFAULT '0' COMMENT '下载统计',
  `package` varchar(255) NOT NULL COMMENT '升级包地址',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_update_version
-- ----------------------------

-- ----------------------------
-- Table structure for wp_user
-- ----------------------------
DROP TABLE IF EXISTS `wp_user`;
CREATE TABLE `wp_user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` text COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '登录密码',
  `truename` varchar(30) DEFAULT NULL COMMENT '真实姓名',
  `mobile` varchar(30) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱地址',
  `sex` tinyint(2) DEFAULT NULL COMMENT '性别',
  `headimgurl` varchar(255) DEFAULT NULL COMMENT '头像地址',
  `city` varchar(30) DEFAULT NULL COMMENT '城市',
  `province` varchar(30) DEFAULT NULL COMMENT '省份',
  `country` varchar(30) DEFAULT NULL COMMENT '国家',
  `language` varchar(20) DEFAULT 'zh-cn' COMMENT '语言',
  `score` int(10) DEFAULT '0' COMMENT '金币值',
  `experience` int(10) DEFAULT '0' COMMENT '经验值',
  `unionid` varchar(50) DEFAULT NULL COMMENT '微信第三方ID',
  `login_count` int(10) DEFAULT '0' COMMENT '登录次数',
  `reg_ip` varchar(30) DEFAULT NULL COMMENT '注册IP',
  `reg_time` int(10) DEFAULT NULL COMMENT '注册时间',
  `last_login_ip` varchar(30) DEFAULT NULL COMMENT '最近登录IP',
  `last_login_time` int(10) DEFAULT NULL COMMENT '最近登录时间',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态',
  `is_init` tinyint(2) DEFAULT '0' COMMENT '初始化状态',
  `is_audit` tinyint(2) DEFAULT '0' COMMENT '审核状态',
  `subscribe_time` int(10) DEFAULT NULL COMMENT '用户关注公众号时间',
  `remark` varchar(100) DEFAULT NULL COMMENT '微信用户备注',
  `groupid` int(10) DEFAULT NULL COMMENT '微信端的分组ID',
  `come_from` tinyint(1) DEFAULT '0' COMMENT '来源',
  `login_name` varchar(100) DEFAULT NULL COMMENT 'login_name',
  `login_password` varchar(255) DEFAULT NULL COMMENT '登录密码',
  `manager_id` int(10) DEFAULT '0' COMMENT '公众号管理员ID',
  `level` tinyint(2) DEFAULT '0' COMMENT '管理等级',
  `membership` char(50) DEFAULT '0' COMMENT '会员等级',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_user
-- ----------------------------
INSERT INTO `wp_user` VALUES ('1', 'admin', '64bdd3a4c4b7b63c602900aaa813636d', null, '', '213123@qq.com', null, null, null, null, null, 'zh-cn', '0', '0', null, '21', '2130706433', '1458630456', '2130706433', '1462951623', '1', '1', '1', null, null, null, '0', 'admin', null, '0', '0', '0');

-- ----------------------------
-- Table structure for wp_user_follow
-- ----------------------------
DROP TABLE IF EXISTS `wp_user_follow`;
CREATE TABLE `wp_user_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `publicid` int(11) DEFAULT NULL,
  `follow_id` int(11) DEFAULT NULL,
  `url` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_user_follow
-- ----------------------------

-- ----------------------------
-- Table structure for wp_visit_log
-- ----------------------------
DROP TABLE IF EXISTS `wp_visit_log`;
CREATE TABLE `wp_visit_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `publicid` int(10) DEFAULT '0' COMMENT 'publicid',
  `module_name` varchar(30) DEFAULT NULL COMMENT 'module_name',
  `controller_name` varchar(30) DEFAULT NULL COMMENT 'controller_name',
  `action_name` varchar(30) DEFAULT NULL COMMENT 'action_name',
  `uid` varchar(255) DEFAULT '0' COMMENT 'uid',
  `ip` varchar(30) DEFAULT NULL COMMENT 'ip',
  `brower` varchar(30) DEFAULT NULL COMMENT 'brower',
  `param` text COMMENT 'param',
  `referer` varchar(255) DEFAULT NULL COMMENT 'referer',
  `cTime` int(10) DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=571 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_visit_log
-- ----------------------------
INSERT INTO `wp_visit_log` VALUES ('502', '1', 'Shop', 'Shop', 'edit', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Shop/edit.html&mdm=38|52', '1461718217');
INSERT INTO `wp_visit_log` VALUES ('501', '1', 'Shop', 'Shop', 'summary', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Shop/summary.html&mdm=38|51', '1461718210');
INSERT INTO `wp_visit_log` VALUES ('500', '1', 'Home', 'Index', 'main', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/Home/Index/main/publicid/1.html', '1461718206');
INSERT INTO `wp_visit_log` VALUES ('499', '1', 'Shop', 'Wap', 'orderDetail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"32\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/orderDetail/id/32/shop_id/1.html', '1461663454');
INSERT INTO `wp_visit_log` VALUES ('498', '1', 'Shop', 'Wap', 'orderDetail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"32\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/orderDetail/id/32/shop_id/1.html', '1461663436');
INSERT INTO `wp_visit_log` VALUES ('497', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461663393');
INSERT INTO `wp_visit_log` VALUES ('496', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461663385');
INSERT INTO `wp_visit_log` VALUES ('495', '1', 'Shop', 'Wap', 'orderDetail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"35\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/orderDetail/id/35/shop_id/1.html', '1461663379');
INSERT INTO `wp_visit_log` VALUES ('494', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461663373');
INSERT INTO `wp_visit_log` VALUES ('493', '1', 'Shop', 'Wap', 'orderDetail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"35\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/orderDetail/id/35/shop_id/1.html', '1461663372');
INSERT INTO `wp_visit_log` VALUES ('492', '1', 'Shop', 'Wap', 'orderDetail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"35\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/orderDetail/id/35/shop_id/1.html', '1461663360');
INSERT INTO `wp_visit_log` VALUES ('491', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461663354');
INSERT INTO `wp_visit_log` VALUES ('490', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461663328');
INSERT INTO `wp_visit_log` VALUES ('489', '1', 'Shop', 'Wap', 'user_center', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/user_center/shop_id/1.html', '1461663325');
INSERT INTO `wp_visit_log` VALUES ('488', '1', 'Shop', 'Wap', 'index', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/index/shop_id/1.html', '1461663315');
INSERT INTO `wp_visit_log` VALUES ('487', '1', 'Shop', 'Wap', 'index', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/index/shop_id/1.html', '1461663292');
INSERT INTO `wp_visit_log` VALUES ('486', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461659398');
INSERT INTO `wp_visit_log` VALUES ('485', '1', 'Shop', 'Order', 'detail', '1', '127.0.0.1', 'Google', '{\"id\":\"33\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/detail/id/33.html', '1461659307');
INSERT INTO `wp_visit_log` VALUES ('484', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461659304');
INSERT INTO `wp_visit_log` VALUES ('483', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461659291');
INSERT INTO `wp_visit_log` VALUES ('482', '1', 'Shop', 'Shop', 'summary', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Shop/summary.html&mdm=38|51', '1461659288');
INSERT INTO `wp_visit_log` VALUES ('481', '1', 'Home', 'Index', 'main', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/Home/Index/main/publicid/1.html', '1461659285');
INSERT INTO `wp_visit_log` VALUES ('480', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461659193');
INSERT INTO `wp_visit_log` VALUES ('479', '1', 'Shop', 'Order', 'detail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"35\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/detail/id/35.html', '1461659191');
INSERT INTO `wp_visit_log` VALUES ('478', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461659185');
INSERT INTO `wp_visit_log` VALUES ('477', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461659028');
INSERT INTO `wp_visit_log` VALUES ('476', '1', 'Shop', 'Wap', 'detail', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\",\"id\":\"47\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/detail/shop_id/1/id/47.html', '1461658954');
INSERT INTO `wp_visit_log` VALUES ('475', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461658951');
INSERT INTO `wp_visit_log` VALUES ('474', '1', 'Shop', 'Order', 'detail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"33\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/detail/id/33.html', '1461658833');
INSERT INTO `wp_visit_log` VALUES ('473', '1', 'Shop', 'Order', 'detail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"33\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/detail/id/33.html', '1461656766');
INSERT INTO `wp_visit_log` VALUES ('472', '1', 'Shop', 'Order', 'detail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"33\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/detail/id/33.html', '1461655946');
INSERT INTO `wp_visit_log` VALUES ('471', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461655490');
INSERT INTO `wp_visit_log` VALUES ('470', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461655297');
INSERT INTO `wp_visit_log` VALUES ('469', '1', 'Shop', 'Order', 'detail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"34\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/detail/id/34.html', '1461655292');
INSERT INTO `wp_visit_log` VALUES ('468', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461655263');
INSERT INTO `wp_visit_log` VALUES ('467', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461655247');
INSERT INTO `wp_visit_log` VALUES ('466', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461655244');
INSERT INTO `wp_visit_log` VALUES ('465', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461655201');
INSERT INTO `wp_visit_log` VALUES ('464', '1', 'Shop', 'Wap', 'detail', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\",\"id\":\"47\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/detail/shop_id/1/id/47.html', '1461655177');
INSERT INTO `wp_visit_log` VALUES ('463', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461655093');
INSERT INTO `wp_visit_log` VALUES ('461', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461654963');
INSERT INTO `wp_visit_log` VALUES ('462', '1', 'Shop', 'Order', 'detail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"33\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/detail/id/33.html', '1461655086');
INSERT INTO `wp_visit_log` VALUES ('460', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461654892');
INSERT INTO `wp_visit_log` VALUES ('459', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_order\",\"order_number\":\"132\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists/mdm/38%7C57/model/shop_order.html&order_number=132', '1461653769');
INSERT INTO `wp_visit_log` VALUES ('458', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461651510');
INSERT INTO `wp_visit_log` VALUES ('457', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461651503');
INSERT INTO `wp_visit_log` VALUES ('455', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461651497');
INSERT INTO `wp_visit_log` VALUES ('456', '1', 'Shop', 'Wap', 'orderDetail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"33\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/orderDetail/id/33/shop_id/1.html', '1461651500');
INSERT INTO `wp_visit_log` VALUES ('454', '1', 'Shop', 'Wap', 'orderDetail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"31\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/orderDetail/id/31/shop_id/1.html', '1461651495');
INSERT INTO `wp_visit_log` VALUES ('453', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461651490');
INSERT INTO `wp_visit_log` VALUES ('452', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461651485');
INSERT INTO `wp_visit_log` VALUES ('451', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461651471');
INSERT INTO `wp_visit_log` VALUES ('450', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461651461');
INSERT INTO `wp_visit_log` VALUES ('449', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461651457');
INSERT INTO `wp_visit_log` VALUES ('448', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461651453');
INSERT INTO `wp_visit_log` VALUES ('446', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461651441');
INSERT INTO `wp_visit_log` VALUES ('447', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461651447');
INSERT INTO `wp_visit_log` VALUES ('445', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461651433');
INSERT INTO `wp_visit_log` VALUES ('444', '1', 'Shop', 'Wap', 'user_center', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/user_center/shop_id/1.html', '1461651429');
INSERT INTO `wp_visit_log` VALUES ('443', '1', 'Shop', 'Wap', 'index', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/index/shop_id/1.html', '1461651415');
INSERT INTO `wp_visit_log` VALUES ('442', '1', 'Shop', 'Wap', 'detail', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\",\"id\":\"47\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/detail/shop_id/1/id/47.html', '1461651389');
INSERT INTO `wp_visit_log` VALUES ('441', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461651378');
INSERT INTO `wp_visit_log` VALUES ('439', '1', 'Shop', 'Order', 'detail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"32\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/detail/id/32.html', '1461651262');
INSERT INTO `wp_visit_log` VALUES ('440', '1', 'Shop', 'Order', 'detail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"32\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/detail/id/32.html', '1461651273');
INSERT INTO `wp_visit_log` VALUES ('438', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461649836');
INSERT INTO `wp_visit_log` VALUES ('437', '1', 'Shop', 'Wap', 'index', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/index/shop_id/1.html', '1461649832');
INSERT INTO `wp_visit_log` VALUES ('435', '1', 'Shop', 'Wap', 'detail', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\",\"id\":\"47\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/detail/shop_id/1/id/47.html', '1461649808');
INSERT INTO `wp_visit_log` VALUES ('436', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461649827');
INSERT INTO `wp_visit_log` VALUES ('434', '1', 'Shop', 'Wap', 'index', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/index/shop_id/1/publicid/1.html', '1461649805');
INSERT INTO `wp_visit_log` VALUES ('432', '1', 'Shop', 'Wap', 'index', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/index/shop_id/1/publicid/1.html', '1461649794');
INSERT INTO `wp_visit_log` VALUES ('433', '1', 'Shop', 'Wap', 'detail', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\",\"id\":\"46\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/detail/shop_id/1/id/46.html', '1461649798');
INSERT INTO `wp_visit_log` VALUES ('431', '1', 'Shop', 'Wap', 'detail', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\",\"id\":\"47\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/detail/shop_id/1/id/47.html', '1461649790');
INSERT INTO `wp_visit_log` VALUES ('429', '1', 'Shop', 'Wap', 'orderDetail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"32\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/orderDetail/id/32/shop_id/1.html', '1461649781');
INSERT INTO `wp_visit_log` VALUES ('430', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461649787');
INSERT INTO `wp_visit_log` VALUES ('428', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461643251');
INSERT INTO `wp_visit_log` VALUES ('427', '1', 'Shop', 'Order', 'detail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"32\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/detail/id/32.html', '1461643231');
INSERT INTO `wp_visit_log` VALUES ('426', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461643225');
INSERT INTO `wp_visit_log` VALUES ('425', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461643210');
INSERT INTO `wp_visit_log` VALUES ('424', '1', 'Shop', 'Order', 'detail', '1', '127.0.0.1', 'Firefox', '{\"id\":\"32\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/detail/id/32.html', '1461643205');
INSERT INTO `wp_visit_log` VALUES ('422', '1', 'Shop', 'Wap', 'myOrder', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myOrder/shop_id/1.html', '1461642594');
INSERT INTO `wp_visit_log` VALUES ('423', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461642600');
INSERT INTO `wp_visit_log` VALUES ('421', '1', 'Shop', 'Wap', 'detail', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\",\"id\":\"47\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/detail/shop_id/1/id/47.html', '1461642583');
INSERT INTO `wp_visit_log` VALUES ('420', '1', 'Shop', 'Wap', 'detail', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\",\"id\":\"47\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/detail/shop_id/1/id/47.html', '1461642567');
INSERT INTO `wp_visit_log` VALUES ('419', '1', 'Shop', 'Wap', 'index', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/index/shop_id/1/publicid/1.html', '1461642563');
INSERT INTO `wp_visit_log` VALUES ('418', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists/model/shop_goods/shop_id/1.html', '1461642559');
INSERT INTO `wp_visit_log` VALUES ('416', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"1197\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/1197/mdm/38%7C55.html', '1461642533');
INSERT INTO `wp_visit_log` VALUES ('417', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"1197\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/1197/mdm/38|55.html', '1461642542');
INSERT INTO `wp_visit_log` VALUES ('415', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"1197\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/1197/mdm/38%7C55.html', '1461642454');
INSERT INTO `wp_visit_log` VALUES ('414', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists.html&mdm=38|55', '1461642450');
INSERT INTO `wp_visit_log` VALUES ('412', '1', 'Shop', 'Shop', 'summary', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Shop/summary.html&mdm=38|51', '1461642427');
INSERT INTO `wp_visit_log` VALUES ('413', '1', 'Shop', 'Wap', 'index', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/index/shop_id/1/publicid/1.html', '1461642444');
INSERT INTO `wp_visit_log` VALUES ('411', '1', 'Home', 'Index', 'main', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/Home/Index/main/publicid/1.html', '1461642424');
INSERT INTO `wp_visit_log` VALUES ('410', '2', 'Home', 'Public', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/Home/Public/lists.html', '1461642418');
INSERT INTO `wp_visit_log` VALUES ('409', '2', 'Shop', 'Shop', 'summary', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Shop/summary.html', '1461642409');
INSERT INTO `wp_visit_log` VALUES ('408', '2', 'Shop', 'Shop', 'summary', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Shop/summary.html', '1461642406');
INSERT INTO `wp_visit_log` VALUES ('407', '2', 'Shop', 'Shop', 'summary', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Shop/summary.html&mdm=38|51', '1461642402');
INSERT INTO `wp_visit_log` VALUES ('406', '2', 'Home', 'Index', 'main', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/Home/Index/main/publicid/2.html', '1461642398');
INSERT INTO `wp_visit_log` VALUES ('405', '1', 'Home', 'Public', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/Home/Public/lists.html', '1461642393');
INSERT INTO `wp_visit_log` VALUES ('404', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461642381');
INSERT INTO `wp_visit_log` VALUES ('402', '1', 'Shop', 'Slideshow', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"1201\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Slideshow/add/model/1201/mdm/38%7C56.html', '1461637416');
INSERT INTO `wp_visit_log` VALUES ('403', '1', 'Shop', 'Category', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Category/lists.html&mdm=38|53', '1461641941');
INSERT INTO `wp_visit_log` VALUES ('401', '1', 'Shop', 'Slideshow', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"1201\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Slideshow/add/model/1201/mdm/38%7C56.html', '1461637372');
INSERT INTO `wp_visit_log` VALUES ('400', '1', 'Shop', 'Slideshow', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Slideshow/lists.html&mdm=38|56', '1461636691');
INSERT INTO `wp_visit_log` VALUES ('399', '1', 'Shop', 'Slideshow', 'edit', '1', '127.0.0.1', 'Firefox', '{\"id\":\"1\",\"model\":\"1201\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Slideshow/edit/id/1/model/1201/mdm/38|56.html', '1461636476');
INSERT INTO `wp_visit_log` VALUES ('398', '1', 'Shop', 'Slideshow', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Slideshow/lists.html&mdm=38|56', '1461636458');
INSERT INTO `wp_visit_log` VALUES ('397', '1', 'Shop', 'Slideshow', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"1201\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Slideshow/add/model/1201/mdm/38%7C56.html', '1461636209');
INSERT INTO `wp_visit_log` VALUES ('396', '1', 'Shop', 'Slideshow', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Slideshow/lists.html&mdm=38|56', '1461636204');
INSERT INTO `wp_visit_log` VALUES ('395', '1', 'Shop', 'Shop', 'summary', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Shop/summary.html&mdm=38|51', '1461636198');
INSERT INTO `wp_visit_log` VALUES ('393', '1', 'Home', 'Public', 'lists', '1', '127.0.0.1', 'Firefox', '{\"from\":\"5\"}', 'http://www.wxphp.com/index.php?s=/Home/Public/lists/from/5.html', '1461636172');
INSERT INTO `wp_visit_log` VALUES ('394', '1', 'Home', 'Index', 'main', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/Home/Index/main/publicid/1.html', '1461636194');
INSERT INTO `wp_visit_log` VALUES ('392', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/shop_goods/shop_id/1.html', '1461568867');
INSERT INTO `wp_visit_log` VALUES ('390', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/shop_goods/shop_id/1.html', '1461568056');
INSERT INTO `wp_visit_log` VALUES ('391', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/shop_goods/shop_id/1.html', '1461568846');
INSERT INTO `wp_visit_log` VALUES ('389', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/shop_goods/shop_id/1.html', '1461566963');
INSERT INTO `wp_visit_log` VALUES ('387', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists/model/shop_goods/shop_id/1.html', '1461566095');
INSERT INTO `wp_visit_log` VALUES ('388', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists/model/shop_goods/shop_id/1.html', '1461566102');
INSERT INTO `wp_visit_log` VALUES ('386', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"1197\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/1197/mdm/38|55.html', '1461566085');
INSERT INTO `wp_visit_log` VALUES ('385', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"1197\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/1197/mdm/38|55.html', '1461566060');
INSERT INTO `wp_visit_log` VALUES ('384', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"1197\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/1197/mdm/38%7C55.html', '1461566052');
INSERT INTO `wp_visit_log` VALUES ('383', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"1197\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/1197/mdm/38%7C55.html', '1461566028');
INSERT INTO `wp_visit_log` VALUES ('381', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists.html&mdm=38|55', '1461565980');
INSERT INTO `wp_visit_log` VALUES ('382', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists.html&mdm=38|55', '1461566018');
INSERT INTO `wp_visit_log` VALUES ('380', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists.html&mdm=38|55', '1461565965');
INSERT INTO `wp_visit_log` VALUES ('379', '1', 'Shop', 'Shop', 'summary', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Shop/summary.html&mdm=38|51', '1461565959');
INSERT INTO `wp_visit_log` VALUES ('378', '1', 'Home', 'Index', 'main', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/Home/Index/main/publicid/1.html', '1461565952');
INSERT INTO `wp_visit_log` VALUES ('377', '1', 'Home', 'Public', 'lists', '1', '127.0.0.1', 'Firefox', '{\"from\":\"5\"}', 'http://www.wxphp.com/index.php?s=/Home/Public/lists/from/5.html', '1461565944');
INSERT INTO `wp_visit_log` VALUES ('376', '1', 'Shop', 'Wap', 'lists', '1', '127.0.0.1', 'Firefox', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/lists/shop_id/1.html', '1461565936');
INSERT INTO `wp_visit_log` VALUES ('375', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists/model/shop_goods/shop_id/1.html', '1461565643');
INSERT INTO `wp_visit_log` VALUES ('374', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists/model/shop_goods/shop_id/1.html', '1461564047');
INSERT INTO `wp_visit_log` VALUES ('373', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists/model/shop_goods/shop_id/1.html', '1461563820');
INSERT INTO `wp_visit_log` VALUES ('372', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists/model/shop_goods/shop_id/1.html', '1461563749');
INSERT INTO `wp_visit_log` VALUES ('371', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists/model/shop_goods/shop_id/1.html', '1461562335');
INSERT INTO `wp_visit_log` VALUES ('370', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/shop_goods/shop_id/1.html', '1461562322');
INSERT INTO `wp_visit_log` VALUES ('369', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists/model/shop_goods/shop_id/1.html', '1461562317');
INSERT INTO `wp_visit_log` VALUES ('368', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"1197\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/1197/mdm/38%7C55.html', '1461562308');
INSERT INTO `wp_visit_log` VALUES ('367', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists.html&mdm=38|55', '1461561062');
INSERT INTO `wp_visit_log` VALUES ('365', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists.html&mdm=38|55', '1461551986');
INSERT INTO `wp_visit_log` VALUES ('366', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists.html&mdm=38|55', '1461554180');
INSERT INTO `wp_visit_log` VALUES ('364', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461550316');
INSERT INTO `wp_visit_log` VALUES ('363', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461550312');
INSERT INTO `wp_visit_log` VALUES ('362', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists.html&mdm=38|55', '1461549912');
INSERT INTO `wp_visit_log` VALUES ('360', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists.html&mdm=38|55', '1461549674');
INSERT INTO `wp_visit_log` VALUES ('361', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"1197\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/1197/mdm/38%7C55.html', '1461549735');
INSERT INTO `wp_visit_log` VALUES ('359', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"1197\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/1197/mdm/38%7C55.html', '1461549671');
INSERT INTO `wp_visit_log` VALUES ('358', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists.html&mdm=38|55', '1461549669');
INSERT INTO `wp_visit_log` VALUES ('357', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/shop_goods/mdm/38%7C55.html', '1461549664');
INSERT INTO `wp_visit_log` VALUES ('356', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists/mdm/38%7C55/model/shop_goods.html', '1461549455');
INSERT INTO `wp_visit_log` VALUES ('355', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists/mdm/38%7C55/model/shop_goods.html', '1461549446');
INSERT INTO `wp_visit_log` VALUES ('354', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists/mdm/38%7C55/model/shop_goods.html', '1461549332');
INSERT INTO `wp_visit_log` VALUES ('352', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists.html&mdm=38|55', '1461549325');
INSERT INTO `wp_visit_log` VALUES ('353', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '{\"model\":\"shop_goods\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists/mdm/38%7C55/model/shop_goods.html', '1461549329');
INSERT INTO `wp_visit_log` VALUES ('351', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Firefox', '{\"model\":\"1197\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/1197/mdm/38%7C55.html', '1461548938');
INSERT INTO `wp_visit_log` VALUES ('350', '1', 'Home', 'Public', 'lists', '1', '127.0.0.1', 'Firefox', '{\"from\":\"5\"}', 'http://www.wxphp.com/index.php?s=/Home/Public/lists/from/5.html', '1461548488');
INSERT INTO `wp_visit_log` VALUES ('349', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists.html&mdm=38|55', '1461547456');
INSERT INTO `wp_visit_log` VALUES ('347', '1', 'Shop', 'Shop', 'summary', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Shop/summary.html&mdm=38|51', '1461545148');
INSERT INTO `wp_visit_log` VALUES ('348', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists.html&mdm=38|55', '1461546572');
INSERT INTO `wp_visit_log` VALUES ('346', '1', 'Home', 'Index', 'main', '1', '127.0.0.1', 'Firefox', '[]', 'http://www.wxphp.com/index.php?s=/Home/Index/main/publicid/1.html', '1461545142');
INSERT INTO `wp_visit_log` VALUES ('563', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1461896313');
INSERT INTO `wp_visit_log` VALUES ('562', '1', 'Shop', 'Shop', 'summary', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Shop/summary.html&mdm=38|51', '1461896296');
INSERT INTO `wp_visit_log` VALUES ('560', '1', 'Home', 'Public', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/Home/Public/lists.html', '1461896287');
INSERT INTO `wp_visit_log` VALUES ('561', '1', 'Home', 'Index', 'main', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/Home/Index/main/publicid/1.html', '1461896292');
INSERT INTO `wp_visit_log` VALUES ('503', '1', 'Shop', 'Shop', 'summary', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Shop/summary.html&mdm=38|51', '1461725075');
INSERT INTO `wp_visit_log` VALUES ('504', '1', 'Shop', 'Wap', 'index', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/index/shop_id/1/publicid/1.html', '1461725094');
INSERT INTO `wp_visit_log` VALUES ('505', '1', 'Shop', 'Wap', 'lists', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/lists/shop_id/1.html&', '1461725100');
INSERT INTO `wp_visit_log` VALUES ('506', '1', 'Shop', 'Wap', 'lists', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\",\"order_key\":\"id\",\"order_type\":\"asc\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/lists/shop_id/1/order_key/id/order_type/asc.html', '1461725136');
INSERT INTO `wp_visit_log` VALUES ('507', '1', 'Shop', 'Wap', 'lists', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\",\"order_key\":\"rank\",\"order_type\":\"desc\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/lists/shop_id/1/order_key/rank/order_type/desc.html', '1461725138');
INSERT INTO `wp_visit_log` VALUES ('508', '1', 'Shop', 'Wap', 'lists', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\",\"order_key\":\"rank\",\"order_type\":\"asc\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/lists/shop_id/1/order_key/rank/order_type/asc.html', '1461725141');
INSERT INTO `wp_visit_log` VALUES ('509', '1', 'Shop', 'Wap', 'lists', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\",\"order_key\":\"sale_count\",\"order_type\":\"desc\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/lists/shop_id/1/order_key/sale_count/order_type/desc.html', '1461725143');
INSERT INTO `wp_visit_log` VALUES ('510', '1', 'Shop', 'Wap', 'lists', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\",\"order_key\":\"sale_count\",\"order_type\":\"asc\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/lists/shop_id/1/order_key/sale_count/order_type/asc.html', '1461725144');
INSERT INTO `wp_visit_log` VALUES ('511', '1', 'Shop', 'Wap', 'detail', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\",\"id\":\"46\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/detail/shop_id/1/id/46.html', '1461728483');
INSERT INTO `wp_visit_log` VALUES ('512', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists.html&mdm=38|55', '1461728489');
INSERT INTO `wp_visit_log` VALUES ('513', '1', 'Shop', 'Goods', 'add', '1', '127.0.0.1', 'Google', '{\"model\":\"1197\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/add/model/1197/mdm/38%7C55.html', '1461728494');
INSERT INTO `wp_visit_log` VALUES ('514', '1', 'Shop', 'Wap', 'detail', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\",\"id\":\"46\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/detail/shop_id/1/id/46.html', '1461728526');
INSERT INTO `wp_visit_log` VALUES ('515', '1', 'Shop', 'Wap', 'lists', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\",\"order_key\":\"sale_count\",\"order_type\":\"asc\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/lists/shop_id/1/order_key/sale_count/order_type/asc.html', '1461728527');
INSERT INTO `wp_visit_log` VALUES ('516', '1', 'Shop', 'Goods', 'lists', '1', '127.0.0.1', 'Google', '{\"model\":\"shop_goods\",\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Goods/lists/model/shop_goods/shop_id/1.html', '1461728527');
INSERT INTO `wp_visit_log` VALUES ('517', '1', 'Shop', 'Wap', 'lists', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\",\"order_key\":\"sale_count\",\"order_type\":\"asc\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/lists/shop_id/1/order_key/sale_count/order_type/asc.html', '1461728529');
INSERT INTO `wp_visit_log` VALUES ('518', '1', 'Shop', 'Wap', 'detail', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\",\"id\":\"51\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/detail/shop_id/1/id/51.html', '1461728530');
INSERT INTO `wp_visit_log` VALUES ('519', '1', 'Shop', 'Wap', 'detail', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\",\"id\":\"51\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/detail/shop_id/1/id/51.html', '1461728941');
INSERT INTO `wp_visit_log` VALUES ('520', '1', 'Shop', 'Wap', 'goodsListsByCategory', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\",\"cid0\":\"2\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/goodsListsByCategory/shop_id/1/cid0/2.html', '1461729274');
INSERT INTO `wp_visit_log` VALUES ('521', '1', 'Home', 'Index', 'main', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/Home/Index/main/publicid/1.html', '1461804894');
INSERT INTO `wp_visit_log` VALUES ('522', '1', 'WishCard', 'WishCard', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/WishCard/WishCard/lists.html', '1461804904');
INSERT INTO `wp_visit_log` VALUES ('523', '1', 'Draw', 'Games', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Draw/Games/lists.html&mdm=17|350', '1461804911');
INSERT INTO `wp_visit_log` VALUES ('524', '1', 'Shop', 'Shop', 'summary', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Shop/summary.html&mdm=38|51', '1461804916');
INSERT INTO `wp_visit_log` VALUES ('525', '1', 'Shop', 'Wap', 'index', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/index/shop_id/1/publicid/1.html', '1461804945');
INSERT INTO `wp_visit_log` VALUES ('526', '1', 'Shop', 'Wap', 'user_center', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/user_center/shop_id/1.html', '1461804949');
INSERT INTO `wp_visit_log` VALUES ('527', '1', 'Shop', 'Wap', 'myAddress', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myAddress/shop_id/1.html', '1461804955');
INSERT INTO `wp_visit_log` VALUES ('528', '1', 'Shop', 'Wap', 'myAddress', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myAddress/shop_id/1.html', '1461804963');
INSERT INTO `wp_visit_log` VALUES ('529', '1', 'Shop', 'Wap', 'user_center', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/user_center/shop_id/1.html', '1461804967');
INSERT INTO `wp_visit_log` VALUES ('530', '1', 'Shop', 'Wap', 'myCollect', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myCollect/shop_id/1.html', '1461804970');
INSERT INTO `wp_visit_log` VALUES ('531', '1', 'Shop', 'Slideshow', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Slideshow/lists.html&mdm=38|56', '1461804999');
INSERT INTO `wp_visit_log` VALUES ('532', '1', 'Shop', 'Wap', 'detail', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\",\"id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/detail/shop_id/1/id/1.html', '1461805015');
INSERT INTO `wp_visit_log` VALUES ('533', '1', 'Shop', 'Wap', 'myCollect', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myCollect/shop_id/1.html', '1461805017');
INSERT INTO `wp_visit_log` VALUES ('534', '1', 'Shop', 'Wap', 'user_center', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/user_center/shop_id/1.html', '1461805018');
INSERT INTO `wp_visit_log` VALUES ('535', '1', 'Shop', 'Wap', 'index', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/index/shop_id/1.html', '1461805020');
INSERT INTO `wp_visit_log` VALUES ('536', '1', 'Shop', 'Wap', 'detail', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\",\"id\":\"51\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/detail/shop_id/1/id/51.html', '1461805022');
INSERT INTO `wp_visit_log` VALUES ('537', '1', 'Home', 'Public', 'add', '1', '127.0.0.1', 'Google', '{\"from\":\"6\"}', 'http://www.wxphp.com/index.php?s=/home/Public/add/from/6.html', '1461806918');
INSERT INTO `wp_visit_log` VALUES ('538', '1', 'Home', 'Public', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/Home/Public/lists.html', '1461806924');
INSERT INTO `wp_visit_log` VALUES ('539', '1', 'Home', 'Index', 'main', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/Home/Index/main/publicid/1.html', '1461806958');
INSERT INTO `wp_visit_log` VALUES ('540', '1', 'Leaflets', 'Leaflets', 'config', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Leaflets/Leaflets/config.html', '1461807090');
INSERT INTO `wp_visit_log` VALUES ('541', '1', 'Home', 'Index', 'main', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/Home/Index/main/publicid/1.html', '1461807096');
INSERT INTO `wp_visit_log` VALUES ('542', '1', 'Scratch', 'Scratch', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Scratch/Scratch/lists.html', '1461807105');
INSERT INTO `wp_visit_log` VALUES ('543', '1', 'Home', 'Index', 'main', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/Home/Index/main/publicid/1.html', '1461807109');
INSERT INTO `wp_visit_log` VALUES ('544', '1', 'Shop', 'Shop', 'summary', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Shop/summary.html', '1461807117');
INSERT INTO `wp_visit_log` VALUES ('545', '1', 'Shop', 'Wap', 'index', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/index/shop_id/1/publicid/1.html', '1461807129');
INSERT INTO `wp_visit_log` VALUES ('546', '1', 'Shop', 'Wap', 'cart', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/cart/shop_id/1.html', '1461807137');
INSERT INTO `wp_visit_log` VALUES ('547', '1', 'Shop', 'Wap', 'user_center', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/user_center/shop_id/1.html', '1461807142');
INSERT INTO `wp_visit_log` VALUES ('548', '1', 'Shop', 'Wap', 'myAddress', '1', '127.0.0.1', 'Google', '{\"shop_id\":\"1\"}', 'http://www.wxphp.com/index.php?s=/addon/Shop/Wap/myAddress/shop_id/1.html', '1461807149');
INSERT INTO `wp_visit_log` VALUES ('549', '1', 'Home', 'Index', 'main', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/Home/Index/main/publicid/1.html', '1461826753');
INSERT INTO `wp_visit_log` VALUES ('550', '1', 'Wecome', 'Wecome', 'config', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Wecome/Wecome/config.html&mdm=45', '1461826758');
INSERT INTO `wp_visit_log` VALUES ('551', '1', 'CustomMenu', 'CustomMenu', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/CustomMenu/CustomMenu/lists.html&mdm=45|47', '1461826763');
INSERT INTO `wp_visit_log` VALUES ('552', '1', 'Wecome', 'Wecome', 'config', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Wecome/Wecome/config.html&mdm=45|46', '1461826770');
INSERT INTO `wp_visit_log` VALUES ('553', '1', 'Home', 'Material', 'material_lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/Home/Material/material_lists.html', '1461826791');
INSERT INTO `wp_visit_log` VALUES ('554', '1', 'Home', 'Material', 'picture_lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/Home/Material/picture_lists.html', '1461826809');
INSERT INTO `wp_visit_log` VALUES ('555', '1', 'Wecome', 'Wecome', 'config', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Wecome/Wecome/config.html&mdm=45', '1461827180');
INSERT INTO `wp_visit_log` VALUES ('556', '1', 'UserCenter', 'UserCenter', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/UserCenter/UserCenter/lists.html&mdm=15', '1461829850');
INSERT INTO `wp_visit_log` VALUES ('557', '1', 'UserCenter', 'UserCenter', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/UserCenter/UserCenter/lists.html&mdm=15', '1461829856');
INSERT INTO `wp_visit_log` VALUES ('558', '1', 'Wecome', 'Wecome', 'config', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Wecome/Wecome/config.html&mdm=45', '1461829859');
INSERT INTO `wp_visit_log` VALUES ('559', '1', 'Home', 'Public', 'add', '1', '127.0.0.1', 'Google', '{\"from\":\"6\"}', 'http://www.wxphp.com/index.php?s=/home/Public/add/from/6.html', '1461896283');
INSERT INTO `wp_visit_log` VALUES ('564', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1462524770');
INSERT INTO `wp_visit_log` VALUES ('565', '1', 'Shop', 'Order', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Order/lists.html&mdm=38|57', '1462524972');
INSERT INTO `wp_visit_log` VALUES ('566', '1', 'Home', 'Index', 'main', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/Home/Index/main/publicid/1.html', '1462951633');
INSERT INTO `wp_visit_log` VALUES ('567', '1', 'Shop', 'Shop', 'summary', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Shop/summary.html&mdm=38|51', '1462951640');
INSERT INTO `wp_visit_log` VALUES ('568', '1', 'Shop', 'Category', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Category/lists.html&mdm=38|53', '1462951664');
INSERT INTO `wp_visit_log` VALUES ('569', '1', 'Shop', 'Category', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Category/lists.html&mdm=38|53', '1462952121');
INSERT INTO `wp_visit_log` VALUES ('570', '1', 'Shop', 'Category', 'lists', '1', '127.0.0.1', 'Google', '[]', 'http://www.wxphp.com/index.php?s=/addon/Shop/Category/lists.html&mdm=38|53', '1462952243');

-- ----------------------------
-- Table structure for wp_weisite_category
-- ----------------------------
DROP TABLE IF EXISTS `wp_weisite_category`;
CREATE TABLE `wp_weisite_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(100) NOT NULL COMMENT '分类标题',
  `icon` int(10) unsigned DEFAULT NULL COMMENT '分类图片',
  `url` varchar(255) DEFAULT NULL COMMENT '外链',
  `is_show` tinyint(2) DEFAULT '1' COMMENT '显示',
  `token` varchar(100) DEFAULT NULL COMMENT 'Token',
  `sort` int(10) DEFAULT '0' COMMENT '排序号',
  `pid` int(10) DEFAULT '0' COMMENT '一级目录',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_weisite_category
-- ----------------------------

-- ----------------------------
-- Table structure for wp_weisite_cms
-- ----------------------------
DROP TABLE IF EXISTS `wp_weisite_cms`;
CREATE TABLE `wp_weisite_cms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` varchar(100) NOT NULL COMMENT '关键词',
  `keyword_type` tinyint(2) DEFAULT NULL COMMENT '关键词类型',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `intro` text COMMENT '简介',
  `cate_id` int(10) unsigned DEFAULT '0' COMMENT '所属类别',
  `cover` int(10) unsigned DEFAULT NULL COMMENT '封面图片',
  `content` text COMMENT '内容',
  `cTime` int(10) DEFAULT NULL COMMENT '发布时间',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序号',
  `view_count` int(10) unsigned DEFAULT '0' COMMENT '浏览数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_weisite_cms
-- ----------------------------

-- ----------------------------
-- Table structure for wp_weisite_footer
-- ----------------------------
DROP TABLE IF EXISTS `wp_weisite_footer`;
CREATE TABLE `wp_weisite_footer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `url` varchar(255) DEFAULT NULL COMMENT '关联URL',
  `title` varchar(50) NOT NULL COMMENT '菜单名',
  `pid` tinyint(2) DEFAULT '0' COMMENT '一级菜单',
  `sort` tinyint(4) DEFAULT '0' COMMENT '排序号',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `icon` int(10) unsigned DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`),
  KEY `token` (`token`,`pid`,`sort`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_weisite_footer
-- ----------------------------

-- ----------------------------
-- Table structure for wp_weisite_slideshow
-- ----------------------------
DROP TABLE IF EXISTS `wp_weisite_slideshow`;
CREATE TABLE `wp_weisite_slideshow` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `img` int(10) unsigned NOT NULL COMMENT '图片',
  `url` varchar(255) DEFAULT NULL COMMENT '链接地址',
  `is_show` tinyint(2) DEFAULT '1' COMMENT '是否显示',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序',
  `token` varchar(100) DEFAULT NULL COMMENT 'Token',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_weisite_slideshow
-- ----------------------------

-- ----------------------------
-- Table structure for wp_weixin_log
-- ----------------------------
DROP TABLE IF EXISTS `wp_weixin_log`;
CREATE TABLE `wp_weixin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cTime` int(11) DEFAULT NULL,
  `cTime_format` varchar(30) DEFAULT NULL,
  `data` text,
  `data_post` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_weixin_log
-- ----------------------------

-- ----------------------------
-- Table structure for wp_weixin_message
-- ----------------------------
DROP TABLE IF EXISTS `wp_weixin_message`;
CREATE TABLE `wp_weixin_message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ToUserName` varchar(100) DEFAULT NULL COMMENT 'Token',
  `FromUserName` varchar(100) DEFAULT NULL COMMENT 'OpenID',
  `CreateTime` int(10) DEFAULT NULL COMMENT '创建时间',
  `MsgType` varchar(30) DEFAULT NULL COMMENT '消息类型',
  `MsgId` varchar(100) DEFAULT NULL COMMENT '消息ID',
  `Content` text COMMENT '文本消息内容',
  `PicUrl` varchar(255) DEFAULT NULL COMMENT '图片链接',
  `MediaId` varchar(100) DEFAULT NULL COMMENT '多媒体文件ID',
  `Format` varchar(30) DEFAULT NULL COMMENT '语音格式',
  `ThumbMediaId` varchar(30) DEFAULT NULL COMMENT '缩略图的媒体id',
  `Title` varchar(100) DEFAULT NULL COMMENT '消息标题',
  `Description` text COMMENT '消息描述',
  `Url` varchar(255) DEFAULT NULL COMMENT 'Url',
  `collect` tinyint(1) DEFAULT '0' COMMENT '收藏状态',
  `deal` tinyint(1) DEFAULT '0' COMMENT '处理状态',
  `is_read` tinyint(1) DEFAULT '0' COMMENT '是否已读',
  `type` tinyint(1) DEFAULT '0' COMMENT '消息分类',
  `is_material` int(10) DEFAULT '0' COMMENT '设置为文本素材',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_weixin_message
-- ----------------------------

-- ----------------------------
-- Table structure for wp_wish_card
-- ----------------------------
DROP TABLE IF EXISTS `wp_wish_card`;
CREATE TABLE `wp_wish_card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `send_name` varchar(255) DEFAULT NULL COMMENT '发送人',
  `receive_name` varchar(255) DEFAULT NULL COMMENT '接收人',
  `content` text COMMENT '祝福语',
  `create_time` int(10) DEFAULT NULL COMMENT ' 创建时间',
  `template` char(50) DEFAULT NULL COMMENT '模板',
  `template_cate` varchar(255) DEFAULT NULL COMMENT '模板分类',
  `read_count` int(10) DEFAULT '0' COMMENT '浏览次数',
  `mid` varchar(255) DEFAULT NULL COMMENT '用户Id',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_wish_card
-- ----------------------------

-- ----------------------------
-- Table structure for wp_wish_card_content
-- ----------------------------
DROP TABLE IF EXISTS `wp_wish_card_content`;
CREATE TABLE `wp_wish_card_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `content_cate_id` int(10) DEFAULT '0' COMMENT '祝福语类别Id',
  `content` text COMMENT '祝福语',
  `content_cate` varchar(255) DEFAULT NULL COMMENT '类别',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_wish_card_content
-- ----------------------------

-- ----------------------------
-- Table structure for wp_wish_card_content_cate
-- ----------------------------
DROP TABLE IF EXISTS `wp_wish_card_content_cate`;
CREATE TABLE `wp_wish_card_content_cate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `content_cate_name` varchar(255) DEFAULT NULL COMMENT '祝福语类别',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `content_cate_icon` int(10) unsigned DEFAULT NULL COMMENT '类别图标',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_wish_card_content_cate
-- ----------------------------

-- ----------------------------
-- Table structure for wp_xdlog
-- ----------------------------
DROP TABLE IF EXISTS `wp_xdlog`;
CREATE TABLE `wp_xdlog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid_int` int(11) NOT NULL,
  `biztitle` text,
  `biztype` int(11) NOT NULL DEFAULT '0',
  `opttime` bigint(20) DEFAULT NULL,
  `xd` bigint(20) DEFAULT NULL,
  `sceneid` bigint(20) DEFAULT '0',
  `remark` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_xdlog
-- ----------------------------

-- ----------------------------
-- Table structure for wp_xydzp
-- ----------------------------
DROP TABLE IF EXISTS `wp_xydzp`;
CREATE TABLE `wp_xydzp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `end_date` int(10) DEFAULT NULL COMMENT '结束日期',
  `cTime` int(10) DEFAULT NULL COMMENT '活动创建时间',
  `states` char(10) DEFAULT '0' COMMENT '活动状态',
  `picurl` int(10) unsigned DEFAULT NULL COMMENT '封面图片',
  `title` varchar(255) DEFAULT NULL COMMENT '活动标题',
  `guiz` text COMMENT '活动规则',
  `choujnum` int(10) unsigned DEFAULT '0' COMMENT '每日抽奖次数',
  `des` text COMMENT '活动介绍',
  `des_jj` text COMMENT '活动介绍',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `keyword` varchar(255) DEFAULT NULL COMMENT '关键词',
  `start_date` int(10) DEFAULT NULL COMMENT '开始时间',
  `experience` int(10) DEFAULT '0' COMMENT '消耗经验值',
  `background` int(10) unsigned DEFAULT NULL COMMENT '背景图',
  `template` varchar(255) DEFAULT 'default' COMMENT '素材模板',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_xydzp
-- ----------------------------

-- ----------------------------
-- Table structure for wp_xydzp_jplist
-- ----------------------------
DROP TABLE IF EXISTS `wp_xydzp_jplist`;
CREATE TABLE `wp_xydzp_jplist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `gailv` int(10) unsigned DEFAULT '0' COMMENT '中奖概率',
  `gailv_str` varchar(255) DEFAULT NULL COMMENT '参数',
  `xydzp_id` int(10) unsigned DEFAULT '0' COMMENT '幸运大转盘关联的活动id',
  `jlnum` int(10) unsigned DEFAULT '1' COMMENT '奖励数量',
  `type` char(50) DEFAULT '0' COMMENT '奖品中奖方式',
  `gailv_maxnum` int(10) unsigned DEFAULT '0' COMMENT '单日发放上限',
  `xydzp_option_id` int(10) unsigned DEFAULT NULL COMMENT '幸运大转盘关联的全局奖品id',
  PRIMARY KEY (`id`),
  KEY `xydzp_id` (`xydzp_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_xydzp_jplist
-- ----------------------------

-- ----------------------------
-- Table structure for wp_xydzp_log
-- ----------------------------
DROP TABLE IF EXISTS `wp_xydzp_log`;
CREATE TABLE `wp_xydzp_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` varchar(255) DEFAULT NULL COMMENT '用户openid',
  `message` text COMMENT '留言',
  `address` text COMMENT '收件地址',
  `iphone` varchar(255) DEFAULT NULL COMMENT '电话',
  `zip` int(10) unsigned DEFAULT NULL COMMENT '邮编',
  `state` tinyint(2) DEFAULT '0' COMMENT '领奖状态',
  `xydzp_option_id` int(10) unsigned DEFAULT '0' COMMENT '奖品id',
  `xydzp_id` int(10) unsigned DEFAULT '0' COMMENT '活动id',
  `zjdate` int(10) unsigned DEFAULT NULL COMMENT '中奖时间',
  PRIMARY KEY (`id`),
  KEY `xydzp_id` (`uid`,`xydzp_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_xydzp_log
-- ----------------------------

-- ----------------------------
-- Table structure for wp_xydzp_option
-- ----------------------------
DROP TABLE IF EXISTS `wp_xydzp_option`;
CREATE TABLE `wp_xydzp_option` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `jptype` char(10) DEFAULT '0' COMMENT '奖品类型',
  `duijma` text COMMENT '兑奖码',
  `title` varchar(255) DEFAULT NULL COMMENT '奖品名称',
  `pic` int(10) unsigned DEFAULT NULL COMMENT '奖品图片',
  `miaoshu` text COMMENT '奖品描述',
  `num` int(10) unsigned DEFAULT '0' COMMENT '库存数量',
  `isdf` tinyint(2) DEFAULT '0' COMMENT '是否为谢谢惠顾类',
  `token` varchar(255) DEFAULT NULL COMMENT 'Token',
  `coupon_id` int(10) DEFAULT NULL COMMENT '优惠券编号',
  `experience` int(10) DEFAULT '0' COMMENT '奖励经验值',
  `card_url` varchar(255) DEFAULT NULL COMMENT '领取卡券的地址',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_xydzp_option
-- ----------------------------

-- ----------------------------
-- Table structure for wp_xydzp_userlog
-- ----------------------------
DROP TABLE IF EXISTS `wp_xydzp_userlog`;
CREATE TABLE `wp_xydzp_userlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` varchar(255) DEFAULT NULL COMMENT '用户id',
  `xydzp_id` int(10) unsigned DEFAULT NULL COMMENT '幸运大转盘关联的活动id',
  `num` int(10) unsigned DEFAULT '0' COMMENT '已经抽奖的次数',
  `cjdate` int(10) DEFAULT NULL COMMENT '抽奖日期',
  PRIMARY KEY (`id`),
  KEY `xydzp_id` (`uid`,`xydzp_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_xydzp_userlog
-- ----------------------------

-- ----------------------------
-- Table structure for wp_youaskservice_behavior
-- ----------------------------
DROP TABLE IF EXISTS `wp_youaskservice_behavior`;
CREATE TABLE `wp_youaskservice_behavior` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `fid` int(11) DEFAULT NULL,
  `token` varchar(60) DEFAULT NULL,
  `openid` varchar(60) DEFAULT NULL,
  `date` varchar(11) DEFAULT NULL,
  `enddate` int(11) DEFAULT NULL,
  `model` varchar(60) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `keyword` varchar(60) DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `openid` (`openid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_youaskservice_behavior
-- ----------------------------

-- ----------------------------
-- Table structure for wp_youaskservice_group
-- ----------------------------
DROP TABLE IF EXISTS `wp_youaskservice_group`;
CREATE TABLE `wp_youaskservice_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `token` varchar(255) DEFAULT NULL COMMENT 'token',
  `groupname` varchar(255) DEFAULT NULL COMMENT '分组名称',
  `groupdata` text COMMENT '分组数据源',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_youaskservice_group
-- ----------------------------

-- ----------------------------
-- Table structure for wp_youaskservice_keyword
-- ----------------------------
DROP TABLE IF EXISTS `wp_youaskservice_keyword`;
CREATE TABLE `wp_youaskservice_keyword` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `msgkeyword` varchar(555) DEFAULT NULL COMMENT '消息关键字',
  `msgkeyword_type` char(50) DEFAULT '3' COMMENT '关键字类型',
  `msgkfaccount` varchar(255) DEFAULT NULL COMMENT '接待的客服人员',
  `cTime` int(10) DEFAULT NULL COMMENT '创建时间',
  `token` varchar(255) DEFAULT NULL COMMENT 'token',
  `msgstate` tinyint(2) DEFAULT '1' COMMENT '关键字状态',
  `zjnum` int(10) DEFAULT NULL COMMENT '转接次数',
  `zdtype` char(10) DEFAULT '0' COMMENT '指定类型',
  `kfgroupid` int(10) DEFAULT '0' COMMENT '客服分组id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_youaskservice_keyword
-- ----------------------------

-- ----------------------------
-- Table structure for wp_youaskservice_logs
-- ----------------------------
DROP TABLE IF EXISTS `wp_youaskservice_logs`;
CREATE TABLE `wp_youaskservice_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) DEFAULT NULL,
  `openid` varchar(60) DEFAULT NULL,
  `enddate` int(11) DEFAULT NULL,
  `keyword` varchar(200) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '2',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_youaskservice_logs
-- ----------------------------

-- ----------------------------
-- Table structure for wp_youaskservice_user
-- ----------------------------
DROP TABLE IF EXISTS `wp_youaskservice_user`;
CREATE TABLE `wp_youaskservice_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(60) DEFAULT NULL COMMENT '客服昵称',
  `token` varchar(60) DEFAULT NULL COMMENT 'token',
  `userName` varchar(60) DEFAULT NULL COMMENT '客服帐号',
  `userPwd` varchar(32) DEFAULT NULL COMMENT '客服密码',
  `endJoinDate` int(11) DEFAULT NULL COMMENT '客服加入时间',
  `status` tinyint(1) DEFAULT '0' COMMENT '客服在线状态',
  `state` tinyint(2) DEFAULT '0' COMMENT '客服状态',
  `isdelete` tinyint(2) DEFAULT '0' COMMENT '是否删除',
  `kfid` varchar(255) DEFAULT NULL COMMENT '客服编号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_youaskservice_user
-- ----------------------------

-- ----------------------------
-- Table structure for wp_youaskservice_wechat_enddate
-- ----------------------------
DROP TABLE IF EXISTS `wp_youaskservice_wechat_enddate`;
CREATE TABLE `wp_youaskservice_wechat_enddate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `openid` varchar(60) DEFAULT NULL,
  `enddate` int(11) DEFAULT NULL,
  `joinUpDate` int(11) DEFAULT '0',
  `uid` int(11) DEFAULT '0',
  `token` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_youaskservice_wechat_enddate
-- ----------------------------

-- ----------------------------
-- Table structure for wp_youaskservice_wechat_grouplist
-- ----------------------------
DROP TABLE IF EXISTS `wp_youaskservice_wechat_grouplist`;
CREATE TABLE `wp_youaskservice_wechat_grouplist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `g_id` varchar(20) DEFAULT NULL,
  `nickname` varchar(60) DEFAULT NULL,
  `sex` tinyint(1) DEFAULT NULL,
  `province` varchar(20) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `headimgurl` varchar(200) DEFAULT NULL,
  `subscribe_time` int(11) DEFAULT NULL,
  `token` varchar(30) DEFAULT NULL,
  `openid` varchar(60) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_youaskservice_wechat_grouplist
-- ----------------------------

-- ----------------------------
-- Table structure for wp_youaskservice_wxlogs
-- ----------------------------
DROP TABLE IF EXISTS `wp_youaskservice_wxlogs`;
CREATE TABLE `wp_youaskservice_wxlogs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `opercode` int(10) DEFAULT NULL COMMENT '会话状态',
  `text` text COMMENT '消息',
  `time` int(10) DEFAULT NULL COMMENT '时间',
  `openid` varchar(255) DEFAULT NULL COMMENT 'openid',
  `token` varchar(255) DEFAULT NULL COMMENT 'token',
  `worker` varchar(255) DEFAULT NULL COMMENT '客服名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wp_youaskservice_wxlogs
-- ----------------------------
