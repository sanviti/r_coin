/*
Navicat MySQL Data Transfer

Source Server         : 富链测试47.74.254.250
Source Server Version : 50637
Source Host           : 47.74.254.250:3306
Source Database       : liantong_yohomm

Target Server Type    : MYSQL
Target Server Version : 50637
File Encoding         : 65001

Date: 2018-08-08 17:33:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for data_admin
-- ----------------------------
DROP TABLE IF EXISTS `data_admin`;
CREATE TABLE `data_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(10) DEFAULT NULL COMMENT '显示名称',
  `user` varchar(255) NOT NULL COMMENT '账号',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `userimg` varchar(64) DEFAULT NULL COMMENT '头像',
  `role` int(11) DEFAULT '0',
  `note` varchar(255) DEFAULT NULL,
  `add_time` varchar(255) NOT NULL,
  `update_time` varchar(255) NOT NULL,
  `state` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0:停用 1 正常',
  `last_loginip` varchar(255) DEFAULT NULL,
  `last_logintime` varchar(255) DEFAULT NULL,
  `salt` char(6) NOT NULL COMMENT '盐',
  `login_token` char(32) NOT NULL COMMENT '登录令牌',
  `auth_list` varchar(1024) DEFAULT NULL COMMENT '权限列表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='管理员';

-- ----------------------------
-- Records of data_admin
-- ----------------------------
INSERT INTO `data_admin` VALUES ('53', 'admin', 'admin', 'ce7df3a5ff65d271dd2335518defacdd', '', '0', '', '', '1501236801', '1', '183.159.126.73', '1533715461', '99CD38', 'e215d40de29817fde2fee3949bbf2098', 'a:21:{i:0;s:1:\"1\";i:1;s:1:\"5\";i:2;s:1:\"8\";i:3;s:2:\"10\";i:4;s:2:\"11\";i:5;s:2:\"12\";i:6;s:2:\"13\";i:7;s:2:\"14\";i:8;s:2:\"15\";i:9;s:2:\"22\";i:10;s:2:\"23\";i:11;s:1:\"6\";i:12;s:1:\"9\";i:13;s:2:\"16\";i:14;s:2:\"17\";i:15;s:2:\"18\";i:16;s:2:\"20\";i:17;s:3:\"123\";i:18;s:1:\"7\";i:19;s:2:\"19\";i:20;s:2:\"21\";}');

-- ----------------------------
-- Table structure for data_admin_act_logs
-- ----------------------------
DROP TABLE IF EXISTS `data_admin_act_logs`;
CREATE TABLE `data_admin_act_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logtype` tinyint(2) DEFAULT NULL COMMENT '操作类型 1登录 2后台操作',
  `subtype` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '操作子类型 login_fail login_success add edit del charge',
  `memo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '信息描述',
  `adminid` tinyint(4) DEFAULT NULL,
  `adminname` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '后台用户名',
  `ip` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ctime` int(10) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7327 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='后台操作日志';

-- ----------------------------
-- Records of data_admin_act_logs
-- ----------------------------
INSERT INTO `data_admin_act_logs` VALUES ('7235', '1', 'login_success', '登录成功', '53', 'admin', '127.0.0.1', '1521201990');
INSERT INTO `data_admin_act_logs` VALUES ('7236', '1', 'login_success', '登录成功', '53', 'admin', '127.0.0.1', '1521202286');
INSERT INTO `data_admin_act_logs` VALUES ('7237', '1', 'login_success', '登录成功', '53', 'admin', '127.0.0.1', '1521455368');
INSERT INTO `data_admin_act_logs` VALUES ('7238', '1', 'login_success', '登录成功', '53', 'admin', '127.0.0.1', '1521559741');
INSERT INTO `data_admin_act_logs` VALUES ('7239', '1', 'login_success', '登录成功', '53', 'admin', '127.0.0.1', '1521601084');
INSERT INTO `data_admin_act_logs` VALUES ('7240', '1', 'login_success', '登录成功', '53', 'admin', '127.0.0.1', '1521641263');
INSERT INTO `data_admin_act_logs` VALUES ('7241', '1', 'login_success', '登录成功', '53', 'admin', '127.0.0.1', '1521645880');
INSERT INTO `data_admin_act_logs` VALUES ('7242', '2', 'batch_confirm', '批量确认付款，处理ID[3,2]。', '53', 'admin', '127.0.0.1', '1521647931');
INSERT INTO `data_admin_act_logs` VALUES ('7243', '2', 'batch_confirm', '批量确认付款，处理ID[]。', '53', 'admin', '127.0.0.1', '1521647987');
INSERT INTO `data_admin_act_logs` VALUES ('7244', '2', 'batch_confirm', '批量确认付款，处理ID[]。', '53', 'admin', '127.0.0.1', '1521648009');
INSERT INTO `data_admin_act_logs` VALUES ('7245', '2', 'batch_confirm', '批量确认付款，处理ID[3,2]。', '53', 'admin', '127.0.0.1', '1521648037');
INSERT INTO `data_admin_act_logs` VALUES ('7246', '2', 'batch_confirm', '批量确认付款，处理ID[]。', '53', 'admin', '127.0.0.1', '1521648093');
INSERT INTO `data_admin_act_logs` VALUES ('7247', '2', 'batch_confirm', '批量确认付款，处理ID[]。', '53', 'admin', '127.0.0.1', '1521648102');
INSERT INTO `data_admin_act_logs` VALUES ('7248', '2', 'batch_confirm', '批量确认付款，处理ID[]。', '53', 'admin', '127.0.0.1', '1521648221');
INSERT INTO `data_admin_act_logs` VALUES ('7249', '1', 'login_success', '登录成功', '53', 'admin', '127.0.0.1', '1521707240');
INSERT INTO `data_admin_act_logs` VALUES ('7250', '1', 'login_success', '登录成功', '53', 'admin', '127.0.0.1', '1522931943');
INSERT INTO `data_admin_act_logs` VALUES ('7251', '1', 'login_success', '登录成功', '53', 'admin', '127.0.0.1', '1522997762');
INSERT INTO `data_admin_act_logs` VALUES ('7252', '1', 'login_fail', '密码输入错误：尝试密码 *admin1*', null, 'admin', '127.0.0.1', '1523000673');
INSERT INTO `data_admin_act_logs` VALUES ('7253', '1', 'login_success', '登录成功', '53', 'admin', '127.0.0.1', '1523000683');
INSERT INTO `data_admin_act_logs` VALUES ('7254', '1', 'login_fail', '密码输入错误：尝试密码 *admin1*', null, 'admin', '127.0.0.1', '1523001241');
INSERT INTO `data_admin_act_logs` VALUES ('7255', '1', 'login_success', '登录成功', '53', 'admin', '127.0.0.1', '1523001245');
INSERT INTO `data_admin_act_logs` VALUES ('7256', '2', 'edit', '修改用户[ID:103]备注。', '53', 'admin', '127.0.0.1', '1523001757');
INSERT INTO `data_admin_act_logs` VALUES ('7257', '1', 'login_success', '登录成功', '53', 'admin', '123.117.127.49', '1523520895');
INSERT INTO `data_admin_act_logs` VALUES ('7258', '1', 'login_success', '登录成功', '53', 'admin', '127.0.0.1', '1523527213');
INSERT INTO `data_admin_act_logs` VALUES ('7259', '1', 'login_success', '登录成功', '53', 'admin', '111.197.242.179', '1524740413');
INSERT INTO `data_admin_act_logs` VALUES ('7260', '1', 'login_success', '登录成功', '53', 'admin', '111.197.242.179', '1524768285');
INSERT INTO `data_admin_act_logs` VALUES ('7261', '1', 'login_success', '登录成功', '53', 'admin', '123.116.248.221', '1524821216');
INSERT INTO `data_admin_act_logs` VALUES ('7262', '1', 'login_success', '登录成功', '53', 'admin', '175.188.162.80', '1525141540');
INSERT INTO `data_admin_act_logs` VALUES ('7263', '1', 'login_success', '登录成功', '53', 'admin', '111.197.241.214', '1527431079');
INSERT INTO `data_admin_act_logs` VALUES ('7264', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1530517816');
INSERT INTO `data_admin_act_logs` VALUES ('7265', '1', 'login_fail', '密码输入错误：尝试密码 *123456*', null, 'admin', '114.241.105.148', '1530604528');
INSERT INTO `data_admin_act_logs` VALUES ('7266', '1', 'login_fail', '密码输入错误：尝试密码 *admin123*', null, 'admin', '114.241.105.148', '1530604538');
INSERT INTO `data_admin_act_logs` VALUES ('7267', '1', 'login_fail', '密码输入错误：尝试密码 *xiaoyu19911201.*', null, 'admin', '114.241.105.148', '1530604551');
INSERT INTO `data_admin_act_logs` VALUES ('7268', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1530605278');
INSERT INTO `data_admin_act_logs` VALUES ('7269', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1530627740');
INSERT INTO `data_admin_act_logs` VALUES ('7270', '1', 'login_success', '登录成功', '53', 'admin', '114.241.105.148', '1530679259');
INSERT INTO `data_admin_act_logs` VALUES ('7271', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1530680215');
INSERT INTO `data_admin_act_logs` VALUES ('7272', '1', 'login_success', '登录成功', '53', 'admin', '192.168.1.117', '1530681539');
INSERT INTO `data_admin_act_logs` VALUES ('7273', '1', 'login_fail', '密码输入错误：尝试密码 *new_bcadd*', null, 'admin', '114.241.105.148', '1530723857');
INSERT INTO `data_admin_act_logs` VALUES ('7274', '1', 'login_fail', '密码输入错误：尝试密码 *new_bcadd*', null, 'admin', '114.241.105.148', '1530723860');
INSERT INTO `data_admin_act_logs` VALUES ('7275', '1', 'login_success', '登录成功', '53', 'admin', '114.241.105.148', '1530723868');
INSERT INTO `data_admin_act_logs` VALUES ('7276', '1', 'login_success', '登录成功', '53', 'admin', '114.241.104.143', '1530769987');
INSERT INTO `data_admin_act_logs` VALUES ('7277', '1', 'login_success', '登录成功', '53', 'admin', '114.241.104.143', '1530841204');
INSERT INTO `data_admin_act_logs` VALUES ('7278', '1', 'login_success', '登录成功', '53', 'admin', '114.241.106.64', '1530865839');
INSERT INTO `data_admin_act_logs` VALUES ('7279', '1', 'login_success', '登录成功', '53', 'admin', '114.241.106.64', '1530866221');
INSERT INTO `data_admin_act_logs` VALUES ('7280', '1', 'login_success', '登录成功', '53', 'admin', '114.241.106.64', '1530866430');
INSERT INTO `data_admin_act_logs` VALUES ('7281', '1', 'login_success', '登录成功', '53', 'admin', '114.241.106.64', '1530868651');
INSERT INTO `data_admin_act_logs` VALUES ('7282', '1', 'login_success', '登录成功', '53', 'admin', '114.241.106.64', '1530869546');
INSERT INTO `data_admin_act_logs` VALUES ('7283', '1', 'login_success', '登录成功', '53', 'admin', '114.241.106.64', '1530869751');
INSERT INTO `data_admin_act_logs` VALUES ('7284', '1', 'login_success', '登录成功', '53', 'admin', '114.241.106.64', '1530870823');
INSERT INTO `data_admin_act_logs` VALUES ('7285', '1', 'login_success', '登录成功', '53', 'admin', '114.241.106.64', '1530942327');
INSERT INTO `data_admin_act_logs` VALUES ('7286', '1', 'login_success', '登录成功', '53', 'admin', '114.241.106.64', '1531114978');
INSERT INTO `data_admin_act_logs` VALUES ('7287', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1531118458');
INSERT INTO `data_admin_act_logs` VALUES ('7288', '1', 'login_fail', '密码输入错误：尝试密码 *admin123*', null, 'admin', '::1', '1531123869');
INSERT INTO `data_admin_act_logs` VALUES ('7289', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1531123884');
INSERT INTO `data_admin_act_logs` VALUES ('7290', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1531187498');
INSERT INTO `data_admin_act_logs` VALUES ('7291', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1531389271');
INSERT INTO `data_admin_act_logs` VALUES ('7292', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1531648263');
INSERT INTO `data_admin_act_logs` VALUES ('7293', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1531708754');
INSERT INTO `data_admin_act_logs` VALUES ('7294', '1', 'login_success', '登录成功', '53', 'admin', '127.0.0.1', '1531989457');
INSERT INTO `data_admin_act_logs` VALUES ('7295', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1532058746');
INSERT INTO `data_admin_act_logs` VALUES ('7296', '1', 'login_fail', '密码输入错误：尝试密码 *admin123*', null, 'admin', '::1', '1532075031');
INSERT INTO `data_admin_act_logs` VALUES ('7297', '1', 'login_fail', '密码输入错误：尝试密码 *123456*', null, 'admin', '::1', '1532075037');
INSERT INTO `data_admin_act_logs` VALUES ('7298', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1532075042');
INSERT INTO `data_admin_act_logs` VALUES ('7299', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1532313866');
INSERT INTO `data_admin_act_logs` VALUES ('7300', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1532399582');
INSERT INTO `data_admin_act_logs` VALUES ('7301', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1532430686');
INSERT INTO `data_admin_act_logs` VALUES ('7302', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1532656163');
INSERT INTO `data_admin_act_logs` VALUES ('7303', '1', 'login_fail', '密码输入错误：尝试密码 *admin123*', null, 'admin', '::1', '1532916726');
INSERT INTO `data_admin_act_logs` VALUES ('7304', '1', 'login_fail', '密码输入错误：尝试密码 *admin123*', null, 'admin', '::1', '1532916733');
INSERT INTO `data_admin_act_logs` VALUES ('7305', '1', 'login_fail', '密码输入错误：尝试密码 *admin123*', null, 'admin', '::1', '1532916755');
INSERT INTO `data_admin_act_logs` VALUES ('7306', '1', 'login_fail', '密码输入错误：尝试密码 *123456*', null, 'admin', '::1', '1532916765');
INSERT INTO `data_admin_act_logs` VALUES ('7307', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1532916779');
INSERT INTO `data_admin_act_logs` VALUES ('7308', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1533379091');
INSERT INTO `data_admin_act_logs` VALUES ('7309', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1533443759');
INSERT INTO `data_admin_act_logs` VALUES ('7310', '1', 'login_fail', '密码输入错误：尝试密码 *admin123*', null, 'admin', '::1', '1533449117');
INSERT INTO `data_admin_act_logs` VALUES ('7311', '1', 'login_fail', '密码输入错误：尝试密码 *admin123*', null, 'admin', '::1', '1533449121');
INSERT INTO `data_admin_act_logs` VALUES ('7312', '1', 'login_fail', '密码输入错误：尝试密码 *admin123*', null, 'admin', '::1', '1533449127');
INSERT INTO `data_admin_act_logs` VALUES ('7313', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1533449137');
INSERT INTO `data_admin_act_logs` VALUES ('7314', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1533520787');
INSERT INTO `data_admin_act_logs` VALUES ('7315', '1', 'login_success', '登录成功', '53', 'admin', '192.168.0.129', '1533534709');
INSERT INTO `data_admin_act_logs` VALUES ('7316', '1', 'login_success', '登录成功', '53', 'admin', '192.168.0.129', '1533535007');
INSERT INTO `data_admin_act_logs` VALUES ('7317', '1', 'login_success', '登录成功', '53', 'admin', '::1', '1533535338');
INSERT INTO `data_admin_act_logs` VALUES ('7318', '1', 'login_success', '登录成功', '53', 'admin', '222.128.127.218', '1533553612');
INSERT INTO `data_admin_act_logs` VALUES ('7319', '1', 'login_success', '登录成功', '53', 'admin', '222.128.127.218', '1533640380');
INSERT INTO `data_admin_act_logs` VALUES ('7320', '1', 'login_success', '登录成功', '53', 'admin', '117.136.38.169', '1533645965');
INSERT INTO `data_admin_act_logs` VALUES ('7321', '1', 'login_success', '登录成功', '53', 'admin', '36.24.18.78', '1533646013');
INSERT INTO `data_admin_act_logs` VALUES ('7322', '1', 'login_success', '登录成功', '53', 'admin', '115.196.22.69', '1533646449');
INSERT INTO `data_admin_act_logs` VALUES ('7323', '1', 'login_success', '登录成功', '53', 'admin', '115.196.22.69', '1533646573');
INSERT INTO `data_admin_act_logs` VALUES ('7324', '1', 'login_success', '登录成功', '53', 'admin', '115.196.22.69', '1533646817');
INSERT INTO `data_admin_act_logs` VALUES ('7325', '1', 'login_success', '登录成功', '53', 'admin', '183.159.126.73', '1533701795');
INSERT INTO `data_admin_act_logs` VALUES ('7326', '1', 'login_success', '登录成功', '53', 'admin', '183.159.126.73', '1533715461');

-- ----------------------------
-- Table structure for data_auths
-- ----------------------------
DROP TABLE IF EXISTS `data_auths`;
CREATE TABLE `data_auths` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `idcard` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '身份证号',
  `rname` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '姓名',
  `photo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '手持身份证',
  `type` tinyint(1) DEFAULT NULL COMMENT '认证类型  1 c1  2 c2',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态 -1认证失败  0未审核  1已通过',
  `ctime` int(10) unsigned DEFAULT NULL COMMENT '申请时间',
  `admin` int(10) unsigned DEFAULT NULL COMMENT '管理员ID',
  `ptime` int(10) unsigned DEFAULT NULL COMMENT '处理时间',
  `remark` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '失败原因',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户认证';

-- ----------------------------
-- Records of data_auths
-- ----------------------------

-- ----------------------------
-- Table structure for data_banner
-- ----------------------------
DROP TABLE IF EXISTS `data_banner`;
CREATE TABLE `data_banner` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `pic_url` varchar(512) DEFAULT NULL COMMENT '图片',
  `sort` int(4) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `url` varchar(512) DEFAULT NULL COMMENT '链接地址',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建时间',
  `last_time` int(10) unsigned NOT NULL COMMENT '更新时间',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_banner
-- ----------------------------
INSERT INTO `data_banner` VALUES ('6', 'banner3', '/Public/Wap/img/lb_02.png', '0', '', '1497006312', '1524740530', '53');
INSERT INTO `data_banner` VALUES ('5', 'banner2', '/Public/Wap/img/lb_02.png', '0', '', '1497006301', '1524740542', '53');
INSERT INTO `data_banner` VALUES ('4', 'banner1', '/Public/Wap/img/jpg4.jpg', '1', '', '1496991510', '1524740553', '53');

-- ----------------------------
-- Table structure for data_category
-- ----------------------------
DROP TABLE IF EXISTS `data_category`;
CREATE TABLE `data_category` (
  `cat_id` smallint(4) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品分类ID ',
  `cat_name` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品名称',
  `cat_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '分类描述',
  `keywords` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '关键字',
  `parent_id` smallint(4) DEFAULT '0' COMMENT '分类父ID',
  `order` tinyint(4) unsigned DEFAULT NULL COMMENT '排序',
  `dateline` int(10) unsigned DEFAULT NULL,
  `admin_id` tinyint(4) DEFAULT NULL COMMENT '管理员',
  `cat_role` tinyint(4) DEFAULT '0' COMMENT '分类隶属 0 普通 1 夺宝 2 兑换',
  `update_time` int(10) unsigned DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='新闻分类';

-- ----------------------------
-- Records of data_category
-- ----------------------------
INSERT INTO `data_category` VALUES ('39', '最新资讯', null, null, '0', '4', '1493916415', null, '1', '1523702404');
INSERT INTO `data_category` VALUES ('50', '关于我们', null, null, '0', '2', '1531992808', null, '0', '1531992808');
INSERT INTO `data_category` VALUES ('62', '新手帮助', null, '/Uploads/images/2017-05-16/591aa98880ce3.png', '0', '4', '1494919562', null, '0', '1523702426');
INSERT INTO `data_category` VALUES ('63', '公告', null, null, '0', '1', '1531992808', null, '0', null);

-- ----------------------------
-- Table structure for data_chain_total
-- ----------------------------
DROP TABLE IF EXISTS `data_chain_total`;
CREATE TABLE `data_chain_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ctime` int(11) DEFAULT NULL,
  `etime` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_chain_total
-- ----------------------------

-- ----------------------------
-- Table structure for data_feedback
-- ----------------------------
DROP TABLE IF EXISTS `data_feedback`;
CREATE TABLE `data_feedback` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `problem_type` varchar(255) NOT NULL DEFAULT '' COMMENT '问题类型',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '问题描述',
  `screen_img` varchar(500) NOT NULL DEFAULT '' COMMENT '截图',
  `add_time` int(10) unsigned NOT NULL COMMENT '提交时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_feedback
-- ----------------------------
INSERT INTO `data_feedback` VALUES ('1', '111', '2222', '11111', '', '1533377402');
INSERT INTO `data_feedback` VALUES ('2', '111', '2222', '1233314444', '', '1533526846');
INSERT INTO `data_feedback` VALUES ('3', '111', '2222', '11111111111', '', '1533526855');
INSERT INTO `data_feedback` VALUES ('4', '108', '2222', 'aaaa', '', '1533538611');
INSERT INTO `data_feedback` VALUES ('5', '188', '2222', '111', '', '1533640213');

-- ----------------------------
-- Table structure for data_members
-- ----------------------------
DROP TABLE IF EXISTS `data_members`;
CREATE TABLE `data_members` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID ',
  `token` varchar(42) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '唯一主键',
  `userid` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户对外ID ',
  `recom_lid_token` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '左节点推荐码',
  `recom_rid_token` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '右节点推荐码',
  `rname` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '真实姓名',
  `auth_c1` tinyint(1) unsigned DEFAULT '0' COMMENT '个人认证 1是 0否',
  `auth_c2` tinyint(1) unsigned DEFAULT '0' COMMENT 'c2认证 0否 1是',
  `phone` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '手机号',
  `username` varchar(32) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '用户名',
  `exp_mills` decimal(20,8) DEFAULT '0.00000000' COMMENT '赠送矿机票',
  `mills` decimal(20,8) DEFAULT '0.00000000' COMMENT '矿机票',
  `mills_lock` decimal(20,8) DEFAULT '0.00000000' COMMENT '矿机票冻结',
  `ore` decimal(20,8) DEFAULT '0.00000000' COMMENT '矿石',
  `score` decimal(20,8) DEFAULT '0.00000000' COMMENT 'RC积分',
  `score_lock` decimal(20,8) DEFAULT '0.00000000' COMMENT 'RC锁定积分',
  `reg_time` int(10) DEFAULT NULL COMMENT '注册时间',
  `login_time` int(10) DEFAULT NULL COMMENT '登录时间',
  `pwd` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '登录密码',
  `salt` char(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '盐',
  `pay_pwd` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '二级密码',
  `pay_salt` char(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '支付密码盐',
  `is_lock` tinyint(1) unsigned DEFAULT '0' COMMENT '锁定账户 0 否 1 是',
  `is_freeze` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0-正常   1-冻结',
  `path` text COLLATE utf8_unicode_ci COMMENT '用户推荐路径',
  `power` decimal(20,8) DEFAULT '0.00000000' COMMENT '个人算力',
  `children_num` int(10) DEFAULT '0' COMMENT '直推人数',
  `team_power` decimal(20,8) DEFAULT '0.00000000' COMMENT '团队算例',
  `team_people_num` int(10) DEFAULT '0' COMMENT '团队人数',
  `nickname` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户名/昵称',
  `member_tag` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '富人生，链天下' COMMENT '个性签名',
  `headimg` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '头像',
  `leadid` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '推荐人ID',
  `memo` varchar(128) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '账户备注',
  `last_cal_time` int(10) unsigned DEFAULT '0' COMMENT '最后返利时间',
  `login_ip` varchar(24) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '登录IP',
  `sign` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '账户签名',
  `sex` int(11) DEFAULT '0' COMMENT '性别，默认0男，1女',
  PRIMARY KEY (`id`),
  KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户表';

-- ----------------------------
-- Records of data_members
-- ----------------------------
INSERT INTO `data_members` VALUES ('108', 'hcImx4yCAIKP21SbBIbJ1aEu', 'U000108', 'left', 'right', null, '1', '1', '15901259081', '11aaaaaaassvv', '0.00000000', '511000.00000000', '0.00000000', '4694.53644560', '4786.20000000', '7.80000000', '1523070733', '1533712475', '5bfdc460844911293348edfeecbf5aff', 'B3592B07', '08659bbdaf81835d2e42de97957d8968', '749B3DEC', '0', '0', '108', '42.11000000', '5', '41.13000000', '21', '11111', '1111', '/Uploads/authc2/2018-08-07/5b697979980f5.jpg', '0', '', '1531987742', '114.241.109.130', 'cef627bccd02704569221a2e14114efb71bf021b', '0');
INSERT INTO `data_members` VALUES ('111', 'hcImx4yCAIKP21SbBIbJ1aEu', 'U000111', 'left', 'right', '', '0', '1', '15901259081', '熊姓名', '0.00000000', '516.00000000', '1000.00000000', '888.82400000', '1068.00000000', '0.00000000', '1523070733', '1524820892', '5bfdc460844911293348edfeecbf5aff', 'B3592B07', '3e19423cc82a6722c4546a82e7459045', '2C6A0BAE', '0', '0', '108', '1.00000000', '2', '0.00000000', '5', '熊昵称', '', '/Uploads/authc2/2018-08-01/5b6112322e8a0.jpg', '0', '', '1531987742', '114.248.159.141', '68e8d624b09e7372350e84ad754f26d9fda65f16', null);
INSERT INTO `data_members` VALUES ('112', 'hcImx4yCAIKP21SbBIbJ1aEu', 'U000112', 'left', 'right', '', '1', '1', '15901259081', '熊一', '0.00000000', '1506.00000000', '1000.00000000', '888.82400000', '1068.00000000', '0.00000000', '1523070733', '1524820892', '5bfdc460844911293348edfeecbf5aff', 'B3592B07', '08659bbdaf81835d2e42de97957d8968', '749B3DEC', '0', '0', '108', '1.00000000', '2', '0.00000000', '5', '熊昵称', '', '', '0', '', '1531987742', '114.248.159.141', '381d25339525312636fe36080f446966d4c292ab', null);
INSERT INTO `data_members` VALUES ('188', '0x9d6cac18d564621e8b55b98b928c35e68cc567b9', 'U000188', 'PVIJKUT3', 'ODYQXPCU', null, '0', '0', '15210298032', '11aaaaaaassv', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1531987255', '1533639282', 'db51e3d90e4e952d382d0e9b67596977', '5EC829DE', '8331abcacfcf63e324dfee353159a40a', '24BFDE45', '0', '0', '108,188', '0.00000000', '0', '1.02000000', '15', '王赛', '富人生，链天下', null, '108', '', '0', '114.241.109.130', '0e693d35c543c3c1400866498e668fe0218e9eda', null);
INSERT INTO `data_members` VALUES ('189', '0x09ab04ef8ad7642dd239eb644ebbe1b6244a5aff', 'U000189', 'M8ZGIWTA', 'XZAVP7QS', null, '0', '0', '15210298032', '11aaaaaaassvs', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1531987309', '1533641442', '49b0d44b2516542d003a5e0315b658e5', '676B5876', '5bfdc460844911293348edfeecbf5aff', 'B3592B07', '0', '0', '108,189', '0.00000000', '3', '1.00000000', '5', '王赛', '富人生，链天下', null, '108', '', '0', '114.241.109.130', '2994831afbcf902b1acf98b5690612d25a197768', null);
INSERT INTO `data_members` VALUES ('190', '0xd690ee4e88e3fc795549d99ef7df00ec6a40b7bd', 'U000190', 'KN4YO5PV', 'EWKAWJJT', null, '0', '0', '15210298032', '11aaaaaaassvss', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1531987348', null, '59e300e000e2ca77c58a31e6a8fbe102', '2EACC822', 'b73183eaf0449c237e239eacaeb301a8', '6C0958D8', '0', '0', '108,189,190', '0.00000000', '0', '0.00000000', '2', '王赛', '富人生，链天下', null, '189', '', '0', null, '95846a2c8a69f9cc3f203bdac23c8ae90c72d783', null);
INSERT INTO `data_members` VALUES ('191', '0x4d441b44337b0f7c0760f79ad1c8bb112faa418a', 'U000191', '1JTUY8JS', 'BE03A598', null, '0', '0', '15210298032', '11aaaaaaassvsss', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1531987560', null, 'a3a42c594f15145c26d5563a72fa5bc5', '4AC77841', '34339310bba28174e3f2bb7c910f5359', '1BAFF70E', '0', '0', '108,189,191', '0.00000000', '0', '1.00000000', '2', '王赛', '富人生，链天下', null, '189', '', '0', null, 'cdd456f1eaf6fc6a8be1124f2a7e857217b6b97e', null);
INSERT INTO `data_members` VALUES ('192', 'hcImx4yCAIKP21SbBIbJ1aEu1', 'U000192', 'left', 'right', '', '1', '1', '15901259081', '熊姓名2', '0.00000000', '0.00000000', '0.00000000', '0.09200000', '4794.00000000', '0.00000000', '1523070733', '1524820892', '5bfdc460844911293348edfeecbf5aff', 'B3592B07', '08659bbdaf81835d2e42de97957d8968', '749B3DEC', '0', '0', '108', '1.00000000', '2', '0.00000000', '5', '熊昵称', '', '', '0', '', '1531987742', '114.248.159.141', 'da38aaa79437918cbb85f48132bcb51060a15af9', null);
INSERT INTO `data_members` VALUES ('193', '0x91b4f83cdbe6de19913cc92c81ef3b33e59da96e', 'U000193', '0WQTBNXO', 'AAGN9RLB', null, '0', '0', '15210298032', '11aaaaaaassvvv', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533286701', null, '4ba9e4071cdad4365d92e84ca9fe2189', 'BB57DB42', '1b7fbaecca39318a685aaa6ea01ffe52', 'A0DC078C', '0', '0', '108,189,190,193', '0.00000000', '0', '0.00000000', '1', '小王', '富人生，链天下', null, '108', '', '0', null, 'd0a1a6877e385e65ee1affbcf572b5ea8e93acdf', '0');
INSERT INTO `data_members` VALUES ('194', '0x4d7fc4c3c99309eac760d2ef4e3b1e8f14952020', 'U000194', 'UDSMBNRA', 'GVRU0JO1', null, '0', '0', '15210298032', '111111', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533287130', null, '7b75a0b7c66fc8b3ad4bd2ef44768521', '8D9766A6', '14589c7809e7687d34e3811d882513c2', '7A2347D9', '0', '0', '108,188,194', '0.00000000', '0', '0.02000000', '14', '11111', '富人生，链天下', null, '108', '', '0', null, 'd1f7aea4fc42424c90fd9f3246617c8021ae3e5d', '0');
INSERT INTO `data_members` VALUES ('195', '0xfddae382eeb32ddd761cc586da028a311c33a6a9', 'U000195', '9E0SSSWG', 'KPIXRIAZ', null, '0', '0', '15210298032', '11111', '0.00000000', '464.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533287716', '1533641354', '07f8ce0e43f5caa508f68745d6757daf', '3E5190EE', '7a4d84d19d2cc362a1fa9c2b5d49e83f', '25F09E44', '0', '0', '108,188,194,195', '0.00000000', '1', '0.02000000', '13', '1111', '富人生，链天下', null, '108', '', '0', '114.241.109.130', '063efaf9540c971c047ab274dd34cacfae84d4ef', '0');
INSERT INTO `data_members` VALUES ('196', '0xa46b611b99b449da4ace5b24cd44b6530c053ca8', 'U000196', 'Z4WBBJ27', 'PSZ37GN7', null, '0', '0', '15210298032', 'ceshi', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533640469', '1533645352', '4d1a48f2d7f99470aa2ac8919806aff6', '50E207AB', '0c6922c7117ebbf5dfb9ce59e341f247', 'C0279F73', '0', '0', '108,188,194,195,196', '0.01000000', '2', '0.02000000', '12', '测试', '富人生，链天下', null, '195', '', '0', '117.136.38.169', '9ad34d73251d2803d833a0b77bde9e7039110e1c', '0');
INSERT INTO `data_members` VALUES ('197', '0x75617281c96b41f7a21f21d6986d4b95504537d0', 'U000197', '4ISJE42H', '98E5PG3C', null, '0', '0', '15210298032', 'ceshi2', '100.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533641585', null, 'cd25cf37825ad23fe2e0e8683d0638c8', '9001CA42', '785a56df25acd0b2531ba1e563b9172a', '9087CD8B', '0', '0', '108,189,191,197', '0.00000000', '0', '0.00000000', '1', 'ceshi2', '富人生，链天下', null, '189', '', '0', null, '5da3d619590f55fb78a86076b91775ecb71f2029', '0');
INSERT INTO `data_members` VALUES ('198', '0xa4e01e6b65b9fc75723a580275ff482dc4379eeb', 'U000198', 'P58O6IHO', 'SVCO0JGI', null, '0', '0', '13368090901', 'zct001', '0.00000000', '10100000.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533645543', '1533645737', '2ea00eb5a0650698592f3ff2e0582bdb', '71DD9B48', 'b1ac9961dd3aaf0f50421395e7279766', '0D59701B', '0', '0', '108,188,194,195,196,198', '0.01000000', '0', '0.01000000', '11', '搞活经济', '富人生，链天下', null, '196', '', '0', '119.85.26.202', '375a07e29e928c965c6fc24692460d279124abbd', '0');
INSERT INTO `data_members` VALUES ('199', '0x9a9c2b62cd69deea4b7bbf6621cd782e4b9db3bb', 'U000199', 'MUJO5AIS', 'E5R401OG', null, '0', '0', '18005889257', 'qq351536', '100.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533645757', '1533717571', '082020940cd41fd4b9696fd591f9ebb3', '801FD8C2', 'f498a6a9a8692a7099279b48481bafba', '2CD2915E', '0', '0', '108,188,194,195,196,198,199', '0.00000000', '9', '0.00000000', '10', 'qq351536', '富人生，链天下', null, '196', '', '0', '183.159.126.73', '0aadd00176bc5e8f2277147e7e992f0807bc2c70', '0');
INSERT INTO `data_members` VALUES ('200', '0x7680ca5204ff71e2b0e6576fadf42bec7fe756d8', 'U000200', '7FBABTBA', 'GS12B38D', null, '0', '0', '18005889257', 'test001', '100.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533698295', null, '85574000b37e4e7ac739e3d056b1f3c9', 'D94FD74D', '8cadcae521718273597b5340aab5c361', '761B42CF', '0', '0', '108,188,194,195,196,198,199,200', '0.00000000', '0', '0.00000000', '4', 'test001', '富人生，链天下', null, '199', '', '0', null, '9b42e8794eb0e3c82c08353dbbcd3188bba1b623', '0');
INSERT INTO `data_members` VALUES ('201', '0x44cb0b9ebd08531dd68e528d4faff7003b67398f', 'U000201', 'PO3VFRFA', 'BQUUV5BX', null, '0', '0', '18005889257', 'test002', '100.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533698418', null, '325d2ec4be8cbfaa96a96a9306d06983', '96A93BA8', '783adbe5bff210bcd2314512e24ea357', 'FB2606A5', '0', '0', '108,188,194,195,196,198,199,201', '0.00000000', '0', '0.00000000', '5', 'test002', '富人生，链天下', null, '199', '', '0', null, '5ef7e1924821668a610d5ba5548b55e7e6301b59', '0');
INSERT INTO `data_members` VALUES ('202', '0xbbf63a71f875f61fcf06f4cf62ac2783045fb6a3', 'U000202', 'M3VHFTWQ', 'FCVSVILO', null, '0', '0', '18005889257', 'test003', '100.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533698565', null, '74be132e9203b021f0bb5e99590a0d3d', '9C449771', 'b4fd47fd2faa8ae6f03cb5d567da27e9', 'A9DF2255', '0', '0', '108,188,194,195,196,198,199,201,202', '0.00000000', '0', '0.00000000', '4', 'test003', '富人生，链天下', null, '199', '', '0', null, '80d702749ba55f2e30215ba50d486c8502414109', '0');
INSERT INTO `data_members` VALUES ('203', '0xe8e306021d19167abd32d5a3c8736a4ffcaf1c2e', 'U000203', 'NB5NIHMD', 'OQGKANTB', null, '0', '0', '18005889257', 'test004', '100.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533698691', null, '8b0688e67920a12749b755e690ab190e', 'A8C6DD98', '60b6aceff1bc9b03ae286abbbee56679', 'A0BA2648', '0', '0', '108,188,194,195,196,198,199,200,203', '0.00000000', '0', '0.00000000', '3', 'test004', '富人生，链天下', null, '199', '', '0', null, 'f15cd5137d141fc8c24c4022c157a4f8fd48e9ac', '0');
INSERT INTO `data_members` VALUES ('204', '0xbca968b67dfdc7513899a644c39bd2a150b31eb7', 'U000204', 'XZRHRRV0', 'KLSEGIOJ', null, '0', '0', '18005889257', 'test005', '100.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533698829', null, '06bd42524321009d22b30bd3a1ba69a9', '3EB414BF', '6dbbcdc0195e0dcd69d64a206c130c3d', 'E00944D5', '0', '0', '108,188,194,195,196,198,199,200,203,204', '0.00000000', '0', '0.00000000', '2', '005', '富人生，链天下', null, '199', '', '0', null, '55bb49c4364b38e67610281652b0c642756ba567', '0');
INSERT INTO `data_members` VALUES ('205', '0x5d9aff81bd8a55197d444bc0788df22d10f19035', 'U000205', 'AQN7RVXB', 'YQIRM5WU', null, '0', '0', '18005889257', 'test006', '100.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533698949', null, '9e40306cded812409c9b9621aa5898f5', 'A92C274B', '658f408e8cdcd931625cceeb9159bce8', '0044DEEE', '0', '0', '108,188,194,195,196,198,199,200,203,204,205', '0.00000000', '0', '0.00000000', '1', '006', '富人生，链天下', null, '199', '', '0', null, 'fed783d7fc79b9d17b34877116de1610d4f27430', '0');
INSERT INTO `data_members` VALUES ('206', '0xce6445d959b5cd68d5279d04ef93fb5a2e1a7d98', 'U000206', '3V4URTIJ', 'YADNMLOR', null, '0', '0', '18005889257', 'test007', '100.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533699071', null, '02dc059464ae60af96f3ded9680c603c', '4670C078', 'dc5d0cebc6b3729f3461f46f453fa5ca', '61B1FB3F', '0', '0', '108,188,194,195,196,198,199,201,202,206', '0.00000000', '0', '0.00000000', '3', '007', '富人生，链天下', null, '199', '', '0', null, '06bdb07c24b02aff61ed773d3e580650099171bd', '0');
INSERT INTO `data_members` VALUES ('207', '0xf60dd213e13ea3e3cf83038c16a2154e73351296', 'U000207', 'YF6INP8Z', 'B1ODXO95', null, '0', '0', '18005889257', 'test008', '100.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533701415', null, '54ab1f6c4e477d3e0e3f83aa7ed01ad1', '98CAC9D3', '296e047cfd53ccf5a23d714196382f0e', 'F9BE311E', '0', '0', '108,188,194,195,196,198,199,201,202,206,207', '0.00000000', '0', '0.00000000', '2', '008', '富人生，链天下', null, '199', '', '0', null, 'baf9c6e3ba4e1e9dd941142b2c10c28cc527bccc', '0');
INSERT INTO `data_members` VALUES ('208', '0xfd93dd31472f0d102adeed492d3c2c4f4b5bc79c', 'U000208', 'ZAS8BNPM', 'T39MVS2W', null, '0', '0', '18005889257', 'test009', '100.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '0.00000000', '1533701504', null, '15875b0adc14d493a027c50fbb07c867', 'E68A8337', '1a01ee1af36e991c282de1de85109f98', '5538AA8F', '0', '0', '108,188,194,195,196,198,199,201,202,206,207,208', '0.00000000', '0', '0.00000000', '1', '009', '富人生，链天下', null, '199', '', '0', null, 'b337b6f9db735b971ccc44a3b1a439ac3453cff6', '0');

-- ----------------------------
-- Table structure for data_members_dep
-- ----------------------------
DROP TABLE IF EXISTS `data_members_dep`;
CREATE TABLE `data_members_dep` (
  `uid` int(10) unsigned NOT NULL COMMENT '会员ID',
  `bank_name` varchar(80) NOT NULL DEFAULT '' COMMENT '开户行',
  `card_number` varchar(20) NOT NULL DEFAULT '' COMMENT '银行卡号',
  `card_name` varchar(30) NOT NULL DEFAULT '' COMMENT '持卡人姓名',
  `alipay_account` varchar(255) NOT NULL DEFAULT '' COMMENT '支付宝账号',
  `weixin_account` varchar(255) NOT NULL DEFAULT '' COMMENT '微信号',
  `declaration` varchar(255) NOT NULL DEFAULT '' COMMENT '富链宣言',
  `group_name` varchar(255) DEFAULT '富链子' COMMENT '工会名称',
  `group_logo` varchar(255) DEFAULT '' COMMENT '工会头像',
  `qq_group` varchar(16) NOT NULL DEFAULT '' COMMENT 'QQ群',
  `qrcode_lid_rec` varchar(255) DEFAULT '' COMMENT '左节点推广二维码',
  `qrcode_rid_rec` varchar(255) DEFAULT '' COMMENT '右节点推广二维码',
  `other_payment` varchar(255) DEFAULT '' COMMENT '其他支付方式',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员副表';

-- ----------------------------
-- Records of data_members_dep
-- ----------------------------
INSERT INTO `data_members_dep` VALUES ('108', 'beijign', '421181199401015312', 'xiongshaung', '111', '1122', '', '富链子', '', '', '/Uploads/qrcode/2018-08-06/033c0ae544c809e235bebeb1f0b61fdb.png', '/Uploads/qrcode/2018-08-06/65aa6e98350bf16b1728cca4e5d9d56b.png', '222');
INSERT INTO `data_members_dep` VALUES ('111', 'beijign', '421181199465665', '熊爽', '11111222', '1122111', '', '富链子', '', '', '', '', '22211455551111111111qq');
INSERT INTO `data_members_dep` VALUES ('188', '', '', '', '', '', '', '富链子', '', '', '', '/Uploads/qrcode/2018-08-07/072820a2e125820a145d1bdb7a78db06.png', '');
INSERT INTO `data_members_dep` VALUES ('189', '', '', '', '', '', '', '富链子', '', '', '', '/Uploads/qrcode/2018-08-07/92c673da257f0ed7f42f69c5d41213f8.png', '');
INSERT INTO `data_members_dep` VALUES ('190', '', '', '', '', '', '', '富链子', '', '', '', '', '');
INSERT INTO `data_members_dep` VALUES ('193', '', '', '', '', '', '', '富链子', '', '', '', '', '');
INSERT INTO `data_members_dep` VALUES ('194', '', '', '', '', '', '', '富链子', '', '', '', '', '');
INSERT INTO `data_members_dep` VALUES ('195', '', '', '', '', '', '', '富链子', '', '', '', '', '');
INSERT INTO `data_members_dep` VALUES ('196', '', '', '', '', '', '', '富链子', '', '', '/Uploads/qrcode/2018-08-07/6fee0ebb490c6a338ffdb535fdc18d4d.png', '/Uploads/qrcode/2018-08-07/272bef7ea64f1a4234395bc6f25e70f5.png', '');
INSERT INTO `data_members_dep` VALUES ('197', '', '', '', '', '', '', '富链子', '', '', '', '', '');
INSERT INTO `data_members_dep` VALUES ('198', '', '', '', '', '', '', '富链子', '', '', '', '', '');
INSERT INTO `data_members_dep` VALUES ('199', '', '', '', '', '', '', '富链子', '', '', '/Uploads/qrcode/2018-08-08/d1c8b5891068c088a486038d4eb22677.png', '/Uploads/qrcode/2018-08-07/34b4d4ffe8777857124ba1b02bb3d2a6.png', '');
INSERT INTO `data_members_dep` VALUES ('200', '', '', '', '', '', '', '富链子', '', '', '', '', '');
INSERT INTO `data_members_dep` VALUES ('201', '', '', '', '', '', '', '富链子', '', '', '', '', '');
INSERT INTO `data_members_dep` VALUES ('202', '', '', '', '', '', '', '富链子', '', '', '', '', '');
INSERT INTO `data_members_dep` VALUES ('203', '', '', '', '', '', '', '富链子', '', '', '', '', '');
INSERT INTO `data_members_dep` VALUES ('204', '', '', '', '', '', '', '富链子', '', '', '', '', '');
INSERT INTO `data_members_dep` VALUES ('205', '', '', '', '', '', '', '富链子', '', '', '', '', '');
INSERT INTO `data_members_dep` VALUES ('206', '', '', '', '', '', '', '富链子', '', '', '', '', '');
INSERT INTO `data_members_dep` VALUES ('207', '', '', '', '', '', '', '富链子', '', '', '', '', '');
INSERT INTO `data_members_dep` VALUES ('208', '', '', '', '', '', '', '富链子', '', '', '', '', '');

-- ----------------------------
-- Table structure for data_members_region
-- ----------------------------
DROP TABLE IF EXISTS `data_members_region`;
CREATE TABLE `data_members_region` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '用户ID',
  `pid` int(11) DEFAULT NULL COMMENT '父级ID',
  `lid` int(11) DEFAULT NULL COMMENT '左节点ID',
  `rid` int(11) DEFAULT NULL COMMENT '右节点ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_members_region
-- ----------------------------
INSERT INTO `data_members_region` VALUES ('1', '108', '0', '188', '189');
INSERT INTO `data_members_region` VALUES ('34', '188', '108', '194', null);
INSERT INTO `data_members_region` VALUES ('35', '189', '108', '190', '191');
INSERT INTO `data_members_region` VALUES ('36', '190', '189', '193', null);
INSERT INTO `data_members_region` VALUES ('37', '191', '189', '197', null);
INSERT INTO `data_members_region` VALUES ('38', '193', '190', null, null);
INSERT INTO `data_members_region` VALUES ('39', '194', '188', '195', null);
INSERT INTO `data_members_region` VALUES ('40', '195', '194', '196', null);
INSERT INTO `data_members_region` VALUES ('41', '196', '195', '198', null);
INSERT INTO `data_members_region` VALUES ('42', '197', '191', null, null);
INSERT INTO `data_members_region` VALUES ('43', '198', '196', '199', null);
INSERT INTO `data_members_region` VALUES ('44', '199', '198', '200', '201');
INSERT INTO `data_members_region` VALUES ('45', '200', '199', '203', null);
INSERT INTO `data_members_region` VALUES ('46', '201', '199', '202', null);
INSERT INTO `data_members_region` VALUES ('47', '202', '201', '206', null);
INSERT INTO `data_members_region` VALUES ('48', '203', '200', '204', null);
INSERT INTO `data_members_region` VALUES ('49', '204', '203', '205', null);
INSERT INTO `data_members_region` VALUES ('50', '205', '204', null, null);
INSERT INTO `data_members_region` VALUES ('51', '206', '202', '207', null);
INSERT INTO `data_members_region` VALUES ('52', '207', '206', '208', null);
INSERT INTO `data_members_region` VALUES ('53', '208', '207', null, null);

-- ----------------------------
-- Table structure for data_members_score_log
-- ----------------------------
DROP TABLE IF EXISTS `data_members_score_log`;
CREATE TABLE `data_members_score_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '用户ID',
  `changeform` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '变动类型 in 收入 out 支出',
  `subtype` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `money_type` tinyint(1) unsigned NOT NULL COMMENT '1预存余额 2可提现余额 3源积分 4云积分 5惠积分',
  `money` decimal(15,2) NOT NULL DEFAULT '0.00' COMMENT '余额变动',
  `ctime` int(10) NOT NULL,
  `describes` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '说明',
  `balance` decimal(15,2) DEFAULT '0.00' COMMENT '操作后余额',
  `extends` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '扩展字段 推荐激励 fromuid 受赠 fromuid 转增 touid ',
  `sign` varchar(32) DEFAULT NULL COMMENT '签名',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `sub_money_ctime` (`subtype`,`ctime`)
) ENGINE=InnoDB AUTO_INCREMENT=331 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_members_score_log
-- ----------------------------
INSERT INTO `data_members_score_log` VALUES ('10', '14', 'in', '2', '0', '100.00', '1513341993', null, '100.00', 'T51F109182767F34A587EB8F511568A51', null);
INSERT INTO `data_members_score_log` VALUES ('11', '13', 'out', '3', '0', '100.00', '1513341993', null, '900.00', 'T51F109182767F34A587EB8F511568A51', null);
INSERT INTO `data_members_score_log` VALUES ('12', '18', 'in', '2', '0', '100.00', '1513437961', null, '3400.00', 'TD6A71590BBE831B85909C10EFF86EC4B', null);
INSERT INTO `data_members_score_log` VALUES ('13', '18', 'out', '3', '0', '100.00', '1513437961', null, '3200.00', 'TD6A71590BBE831B85909C10EFF86EC4B', null);
INSERT INTO `data_members_score_log` VALUES ('14', '18', 'in', '2', '0', '100.00', '1513479001', null, '3400.00', 'T7BA022D628FE6E676D58F9A6BED1C638', null);
INSERT INTO `data_members_score_log` VALUES ('15', '18', 'out', '3', '0', '100.00', '1513479001', null, '3200.00', 'T7BA022D628FE6E676D58F9A6BED1C638', null);
INSERT INTO `data_members_score_log` VALUES ('16', '18', 'in', '2', '0', '100.00', '1513479482', null, '3400.00', 'T18F211D67FD78F11406D90C06D375D5F', null);
INSERT INTO `data_members_score_log` VALUES ('17', '18', 'out', '3', '0', '100.00', '1513479482', null, '3200.00', 'T18F211D67FD78F11406D90C06D375D5F', null);
INSERT INTO `data_members_score_log` VALUES ('18', '19', 'in', '2', '0', '100.00', '1513481401', null, '100.00', 'T19A7FEB51CB6B9FCF9B972228A8162A5', null);
INSERT INTO `data_members_score_log` VALUES ('19', '18', 'out', '3', '0', '100.00', '1513481401', null, '3200.00', 'T19A7FEB51CB6B9FCF9B972228A8162A5', null);
INSERT INTO `data_members_score_log` VALUES ('20', '19', 'in', '2', '0', '100.00', '1513490041', null, '200.00', 'T2843C6A1EDA3617DC313C93C5ED5AA87', null);
INSERT INTO `data_members_score_log` VALUES ('21', '18', 'out', '3', '0', '100.00', '1513490041', null, '3100.00', 'T2843C6A1EDA3617DC313C93C5ED5AA87', null);
INSERT INTO `data_members_score_log` VALUES ('22', '46', 'in', '1', '0', '9700000.00', '1515937097', null, '9700000.00', null, null);
INSERT INTO `data_members_score_log` VALUES ('23', '63', 'in', '1', '0', '2000000.00', '1516766593', null, '2000000.00', null, null);
INSERT INTO `data_members_score_log` VALUES ('24', '34', 'in', '1', '0', '3000000.00', '1516766597', null, '3000000.00', null, null);
INSERT INTO `data_members_score_log` VALUES ('65', '85', 'in', '51', '5', '40.00', '1520440515', null, '40.00', null, '5007474d057fbb54303b016fb0ef4ed9');
INSERT INTO `data_members_score_log` VALUES ('66', '85', 'out', '46', '4', '40.00', '1520440515', null, '199960.00', null, '5007474d057fbb54303b016fb0ef4ed9');
INSERT INTO `data_members_score_log` VALUES ('67', '85', 'in', '51', '5', '39.99', '1520440546', null, '79.99', null, '4a03c40188d226f5544f1eda082ae2ed');
INSERT INTO `data_members_score_log` VALUES ('68', '85', 'out', '46', '4', '39.99', '1520440546', null, '199920.02', null, '4a03c40188d226f5544f1eda082ae2ed');
INSERT INTO `data_members_score_log` VALUES ('69', '85', 'in', '51', '5', '39.98', '1520440569', null, '119.97', null, 'b9c9c7fb6bcc7d080cdcbe58d865b7ed');
INSERT INTO `data_members_score_log` VALUES ('70', '85', 'out', '46', '4', '39.98', '1520440569', null, '199880.03', null, 'b9c9c7fb6bcc7d080cdcbe58d865b7ed');
INSERT INTO `data_members_score_log` VALUES ('71', '85', 'in', '51', '5', '39.97', '1520440597', null, '159.94', null, 'cef0cd5884288413d6704505845b8e04');
INSERT INTO `data_members_score_log` VALUES ('72', '85', 'out', '46', '4', '39.97', '1520440597', null, '199840.06', null, 'cef0cd5884288413d6704505845b8e04');
INSERT INTO `data_members_score_log` VALUES ('73', '85', 'in', '13', '1', '0.00', '1520581616', null, '1.00', null, '62790226ce91df27764de201f089cc39');
INSERT INTO `data_members_score_log` VALUES ('74', '85', 'in', '13', '1', '1.00', '1520582743', null, '2.00', null, 'd03a877327642324fedbcca82a474089');
INSERT INTO `data_members_score_log` VALUES ('75', '85', 'in', '13', '1', '3.00', '1520582749', null, '5.00', null, '5454c096d83ba60c9f64c1dd52492eed');
INSERT INTO `data_members_score_log` VALUES ('76', '85', 'in', '13', '1', '1.00', '1520590999', null, '6.00', null, '27778e23855b33aa4aa151ac3875aba9');
INSERT INTO `data_members_score_log` VALUES ('77', '85', 'in', '13', '1', '1.00', '1520591005', null, '7.00', null, '4dcfded285ed4f1fe0c7f83c165ad703');
INSERT INTO `data_members_score_log` VALUES ('78', '85', 'in', '12', '1', '1.00', '1520912418', null, '6.00', null, '9c537abf1fe1e8133d4876d1ea90e061');
INSERT INTO `data_members_score_log` VALUES ('79', '85', 'out', '31', '3', '100.00', '1520912418', null, '100.00', null, '9c537abf1fe1e8133d4876d1ea90e061');
INSERT INTO `data_members_score_log` VALUES ('80', '85', 'in', '12', '1', '1.00', '1520912982', null, '5.00', null, 'a4c473004f6343de279a646054668b81');
INSERT INTO `data_members_score_log` VALUES ('81', '85', 'out', '31', '3', '100.00', '1520912982', null, '200.00', null, 'a4c473004f6343de279a646054668b81');
INSERT INTO `data_members_score_log` VALUES ('82', '85', 'in', '12', '1', '1.00', '1520912996', null, '4.00', null, 'ef71ba174f5178d930b1bef20ac6952a');
INSERT INTO `data_members_score_log` VALUES ('83', '85', 'out', '31', '3', '100.00', '1520912996', null, '300.00', null, 'ef71ba174f5178d930b1bef20ac6952a');
INSERT INTO `data_members_score_log` VALUES ('84', '85', 'in', '12', '1', '1.00', '1520913059', null, '3.00', null, '5be74306bdd71773e3af6a6f4842af15');
INSERT INTO `data_members_score_log` VALUES ('85', '85', 'out', '31', '3', '100.00', '1520913059', null, '400.00', null, '5be74306bdd71773e3af6a6f4842af15');
INSERT INTO `data_members_score_log` VALUES ('86', '85', 'in', '12', '1', '1.00', '1520913072', null, '2.00', null, '70095870ff5a14c023fcd22ac8028ae0');
INSERT INTO `data_members_score_log` VALUES ('87', '85', 'out', '31', '3', '100.00', '1520913072', null, '500.00', null, '70095870ff5a14c023fcd22ac8028ae0');
INSERT INTO `data_members_score_log` VALUES ('88', '85', 'in', '12', '1', '1.00', '1520913157', null, '1.00', null, '5ab2eeb5bedbad5bada5004f4b56ae85');
INSERT INTO `data_members_score_log` VALUES ('89', '85', 'out', '31', '3', '100.00', '1520913157', null, '600.00', null, '5ab2eeb5bedbad5bada5004f4b56ae85');
INSERT INTO `data_members_score_log` VALUES ('90', '85', 'in', '12', '1', '1.00', '1520913200', null, '0.00', null, '3b72ce72756b3511968a2dd640d01600');
INSERT INTO `data_members_score_log` VALUES ('91', '85', 'out', '31', '3', '100.00', '1520913200', null, '700.00', null, '3b72ce72756b3511968a2dd640d01600');
INSERT INTO `data_members_score_log` VALUES ('93', '85', 'in', '11', '1', '10000.00', '1521016933', null, '10000.00', null, '726d9f744a7ac71affa4a50ab59443c1');
INSERT INTO `data_members_score_log` VALUES ('94', '85', 'in', '11', '1', '10000.00', '1521016955', null, '20000.00', null, '71f4c926703379ad9e93f5f8a3598338');
INSERT INTO `data_members_score_log` VALUES ('95', '85', 'in', '11', '1', '10000.00', '1521017061', null, '30000.00', null, 'e5b76713ee9546bb10dc17c1c590ac36');
INSERT INTO `data_members_score_log` VALUES ('96', '85', 'in', '13', '1', '1000.00', '1521017138', null, '31000.00', null, '14f86bee0d58f546599a88d9c4034f26');
INSERT INTO `data_members_score_log` VALUES ('97', '85', 'in', '11', '1', '10000.00', '1521017224', null, '41000.00', null, '15377f6a4b11d593540225a2f6baa73b');
INSERT INTO `data_members_score_log` VALUES ('98', '85', 'in', '13', '1', '100.00', '1521017229', null, '41100.00', null, '85ace54c1430cd612a8ca7390669eb27');
INSERT INTO `data_members_score_log` VALUES ('99', '85', 'in', '11', '1', '10000.00', '1521017310', null, '51100.00', null, 'ae1f5d62e99a48f16396bcc33a6fcc08');
INSERT INTO `data_members_score_log` VALUES ('100', '85', 'in', '12', '1', '1.00', '1521017858', null, '51099.00', null, '76379b6044d161212c3508fa9fe1d315');
INSERT INTO `data_members_score_log` VALUES ('101', '85', 'out', '31', '3', '100.00', '1521017858', null, '800.00', null, '76379b6044d161212c3508fa9fe1d315');
INSERT INTO `data_members_score_log` VALUES ('102', '85', 'in', '12', '1', '10000.00', '1521017910', null, '41099.00', null, 'd9821b6d03a7cca8768d875d68457a95');
INSERT INTO `data_members_score_log` VALUES ('103', '85', 'out', '31', '3', '1000000.00', '1521017910', null, '1000800.00', null, 'd9821b6d03a7cca8768d875d68457a95');
INSERT INTO `data_members_score_log` VALUES ('125', '85', 'out', '33', '3', '100000.00', '1521027088', null, '900800.00', null, 'be20f6b0f4a4a0a6f5a7f176356c20b0');
INSERT INTO `data_members_score_log` VALUES ('126', '85', 'in', '41', '4', '100000.00', '1521027088', null, '299840.06', null, 'be20f6b0f4a4a0a6f5a7f176356c20b0');
INSERT INTO `data_members_score_log` VALUES ('127', '103', 'in', '42', '4', '1000000.00', '1521027088', null, '1000000.00', null, 'd591c6aeecdb131ddccbb3612ba8198b');
INSERT INTO `data_members_score_log` VALUES ('128', '85', 'out', '33', '3', '5000.00', '1521027463', null, '895800.00', null, '599113a10d737a6de7d9f36f392e49bf');
INSERT INTO `data_members_score_log` VALUES ('129', '85', 'in', '41', '4', '5000.00', '1521027463', null, '304840.06', null, '599113a10d737a6de7d9f36f392e49bf');
INSERT INTO `data_members_score_log` VALUES ('130', '103', 'in', '42', '4', '50000.00', '1521027463', null, '1050000.00', null, 'da1abe373eca6d8b429af0014e5a2f39');
INSERT INTO `data_members_score_log` VALUES ('131', '85', 'out', '33', '3', '5000.00', '1521027587', null, '890800.00', null, 'bc96287b4ac1d966555bc12dc90f0074');
INSERT INTO `data_members_score_log` VALUES ('132', '85', 'in', '41', '4', '5000.00', '1521027587', null, '309840.06', null, 'bc96287b4ac1d966555bc12dc90f0074');
INSERT INTO `data_members_score_log` VALUES ('133', '102', 'in', '42', '4', '50000.00', '1521027587', null, '50000.00', null, '88b9c9b5b2a328a491973304f61033d1');
INSERT INTO `data_members_score_log` VALUES ('134', '85', 'out', '33', '3', '5000.00', '1521027599', null, '885800.00', null, '02edf5877c5992fd59e0dd05036884d0');
INSERT INTO `data_members_score_log` VALUES ('135', '85', 'in', '41', '4', '5000.00', '1521027599', null, '314840.06', null, '02edf5877c5992fd59e0dd05036884d0');
INSERT INTO `data_members_score_log` VALUES ('136', '102', 'in', '42', '4', '50000.00', '1521027599', null, '100000.00', null, '351063966cbe2183967c095a0af9394e');
INSERT INTO `data_members_score_log` VALUES ('143', '85', 'out', '33', '3', '5000.00', '1521027833', null, '880800.00', null, 'b884d03202b433e05fe5984f3cb89168');
INSERT INTO `data_members_score_log` VALUES ('144', '85', 'in', '41', '4', '5000.00', '1521027833', null, '319840.06', null, 'b884d03202b433e05fe5984f3cb89168');
INSERT INTO `data_members_score_log` VALUES ('145', '102', 'in', '42', '4', '50000.00', '1521027833', null, '150000.00', null, '06aeac18208ad57d739f1341525ba08c');
INSERT INTO `data_members_score_log` VALUES ('155', '85', 'out', '33', '3', '5000.00', '1521027944', null, '875800.00', null, '1576fde382ce0894916efeccb40b5c4f');
INSERT INTO `data_members_score_log` VALUES ('156', '85', 'in', '41', '4', '5000.00', '1521027944', null, '324840.06', null, '1576fde382ce0894916efeccb40b5c4f');
INSERT INTO `data_members_score_log` VALUES ('157', '102', 'in', '42', '4', '50000.00', '1521027944', null, '200000.00', null, '28b54e8bf75187972e79da6207a911e1');
INSERT INTO `data_members_score_log` VALUES ('158', '85', 'out', '33', '3', '5000.00', '1521027978', null, '870800.00', null, 'bd630bd6d32e3f31a4132166fc0dd5b8');
INSERT INTO `data_members_score_log` VALUES ('159', '85', 'in', '41', '4', '5000.00', '1521027978', null, '329840.06', null, 'bd630bd6d32e3f31a4132166fc0dd5b8');
INSERT INTO `data_members_score_log` VALUES ('160', '102', 'in', '42', '4', '50000.00', '1521027978', null, '250000.00', null, 'a3aefcfb49a6cd29d0172776c8af610d');
INSERT INTO `data_members_score_log` VALUES ('161', '94', 'in', '43', '4', '50.00', '1521027978', null, '50.00', null, '4ea62caf4170d52fc1eb0f0c60bd0429');
INSERT INTO `data_members_score_log` VALUES ('162', '85', 'out', '33', '3', '5000.00', '1521028374', null, '865800.00', null, 'cdfb73cc7d0877b26816902b157ed268');
INSERT INTO `data_members_score_log` VALUES ('163', '85', 'in', '41', '4', '5000.00', '1521028374', null, '334840.06', null, 'cdfb73cc7d0877b26816902b157ed268');
INSERT INTO `data_members_score_log` VALUES ('164', '101', 'in', '42', '4', '50000.00', '1521028374', null, '50000.00', null, '8e1f94cda5bae4827342f37900141615');
INSERT INTO `data_members_score_log` VALUES ('165', '85', 'out', '33', '3', '5000.00', '1521028384', null, '860800.00', null, '9ed5ea08e481d10da407bf46f846d18f');
INSERT INTO `data_members_score_log` VALUES ('166', '85', 'in', '41', '4', '5000.00', '1521028384', null, '339840.06', null, '9ed5ea08e481d10da407bf46f846d18f');
INSERT INTO `data_members_score_log` VALUES ('167', '101', 'in', '42', '4', '50000.00', '1521028384', null, '100000.00', null, '113acf71e3b257a50fde7db84f05f3af');
INSERT INTO `data_members_score_log` VALUES ('168', '85', 'out', '33', '3', '10000.00', '1521028420', null, '850800.00', null, '25433f8e0ba62ad2ca77b45aab843b2c');
INSERT INTO `data_members_score_log` VALUES ('169', '85', 'in', '41', '4', '10000.00', '1521028420', null, '349840.06', null, '25433f8e0ba62ad2ca77b45aab843b2c');
INSERT INTO `data_members_score_log` VALUES ('170', '100', 'in', '42', '4', '100000.00', '1521028420', null, '100000.00', null, 'e2fe2380cf4a8fe688de0353f029dd41');
INSERT INTO `data_members_score_log` VALUES ('171', '85', 'out', '33', '3', '10000.00', '1521028611', null, '840800.00', null, '15f6d0f32a043a2675f05ea786da6e72');
INSERT INTO `data_members_score_log` VALUES ('172', '85', 'in', '41', '4', '10000.00', '1521028611', null, '359840.06', null, '15f6d0f32a043a2675f05ea786da6e72');
INSERT INTO `data_members_score_log` VALUES ('173', '98', 'in', '42', '4', '100000.00', '1521028611', null, '100000.00', null, '37c0e8352b419324302246195d8f3611');
INSERT INTO `data_members_score_log` VALUES ('174', '85', 'out', '33', '3', '10000.00', '1521028626', null, '830800.00', null, 'ae06fdbc6b76bc714bd11673d3a5c310');
INSERT INTO `data_members_score_log` VALUES ('175', '85', 'in', '41', '4', '10000.00', '1521028626', null, '369840.06', null, 'ae06fdbc6b76bc714bd11673d3a5c310');
INSERT INTO `data_members_score_log` VALUES ('176', '97', 'in', '42', '4', '100000.00', '1521028626', null, '100000.00', null, '8de9bd20edc7cd39f136ea815fcf2b5a');
INSERT INTO `data_members_score_log` VALUES ('177', '85', 'out', '33', '3', '10000.00', '1521028641', null, '820800.00', null, '16ffbd500f59b929cb1c090bfe16d8bd');
INSERT INTO `data_members_score_log` VALUES ('178', '85', 'in', '41', '4', '10000.00', '1521028641', null, '379840.06', null, '16ffbd500f59b929cb1c090bfe16d8bd');
INSERT INTO `data_members_score_log` VALUES ('179', '96', 'in', '42', '4', '100000.00', '1521028641', null, '100000.00', null, 'a25b113c5e86564902f1590a64206ecd');
INSERT INTO `data_members_score_log` VALUES ('180', '85', 'out', '33', '3', '10000.00', '1521028645', null, '810800.00', null, '59aa0732f6c67692fa48dc6308ff124d');
INSERT INTO `data_members_score_log` VALUES ('181', '85', 'in', '41', '4', '10000.00', '1521028645', null, '389840.06', null, '59aa0732f6c67692fa48dc6308ff124d');
INSERT INTO `data_members_score_log` VALUES ('182', '95', 'in', '42', '4', '100000.00', '1521028645', null, '100000.00', null, '7f3792460ec6eca96b344114f9956d55');
INSERT INTO `data_members_score_log` VALUES ('183', '85', 'out', '33', '3', '10000.00', '1521028699', null, '800800.00', null, '36ba9ae8686e165d743c0fa8c77b9133');
INSERT INTO `data_members_score_log` VALUES ('184', '85', 'in', '41', '4', '10000.00', '1521028699', null, '399840.06', null, '36ba9ae8686e165d743c0fa8c77b9133');
INSERT INTO `data_members_score_log` VALUES ('185', '95', 'in', '42', '4', '100000.00', '1521028699', null, '200000.00', null, '65b817f414d6a5a2c0b551c3b830fe7f');
INSERT INTO `data_members_score_log` VALUES ('186', '91', 'in', '43', '4', '100.00', '1521028699', null, '100.00', null, '8b6e3b3bb702d67a4a76c97a9dd994f2');
INSERT INTO `data_members_score_log` VALUES ('187', '89', 'in', '43', '4', '200.00', '1521028699', null, '200.00', null, '4142d78398d4f830a2e239ebf942d198');
INSERT INTO `data_members_score_log` VALUES ('188', '87', 'in', '43', '4', '400.00', '1521028699', null, '400.00', null, 'f108c294f875d03d6336a2bd9cfae132');
INSERT INTO `data_members_score_log` VALUES ('189', '85', 'out', '33', '3', '10000.00', '1521029770', null, '790800.00', null, '3a6e2eef83d5a02c0c8c76263d1ddcdf');
INSERT INTO `data_members_score_log` VALUES ('190', '85', 'in', '41', '4', '10000.00', '1521029770', null, '409840.06', null, '3a6e2eef83d5a02c0c8c76263d1ddcdf');
INSERT INTO `data_members_score_log` VALUES ('191', '95', 'in', '42', '4', '100000.00', '1521029770', null, '300000.00', null, 'dd36252967ed5ce0e8cea00c2e28f4fa');
INSERT INTO `data_members_score_log` VALUES ('192', '91', 'in', '43', '4', '100.00', '1521029770', null, '200.00', null, '8b84bf9f3a8c72f5f91d25b80f0dba62');
INSERT INTO `data_members_score_log` VALUES ('193', '89', 'in', '43', '4', '200.00', '1521029770', null, '400.00', null, 'a621d9ce0567b6e83cb3424bc39d0e63');
INSERT INTO `data_members_score_log` VALUES ('194', '87', 'in', '43', '4', '400.00', '1521029770', null, '800.00', null, '1b54a50ce413c231349f113cd6c8aefc');
INSERT INTO `data_members_score_log` VALUES ('201', '85', 'in', '23', '2', '0.90', '1521174281', null, '0.90', null, 'ded028b57619965cb58e1a3cf1f66e34');
INSERT INTO `data_members_score_log` VALUES ('202', '85', 'out', '52', '5', '100.00', '1521174281', null, '59.94', null, 'ded028b57619965cb58e1a3cf1f66e34');
INSERT INTO `data_members_score_log` VALUES ('203', '85', 'in', '51', '5', '81.96', '1521174484', null, '141.90', null, 'cf68e5a94c39f5ae99ee8700d1aa8712');
INSERT INTO `data_members_score_log` VALUES ('204', '85', 'out', '46', '4', '81.96', '1521174484', null, '409758.10', null, 'cf68e5a94c39f5ae99ee8700d1aa8712');
INSERT INTO `data_members_score_log` VALUES ('205', '87', 'in', '51', '5', '0.16', '1521174484', null, '0.16', null, '463ae480beedec045a1bd0cfd0388972');
INSERT INTO `data_members_score_log` VALUES ('206', '87', 'out', '46', '4', '0.16', '1521174484', null, '799.84', null, '463ae480beedec045a1bd0cfd0388972');
INSERT INTO `data_members_score_log` VALUES ('207', '89', 'in', '51', '5', '0.08', '1521174484', null, '0.08', null, '646dc5983ec8306aa1351706920027ed');
INSERT INTO `data_members_score_log` VALUES ('208', '89', 'out', '46', '4', '0.08', '1521174484', null, '399.92', null, '646dc5983ec8306aa1351706920027ed');
INSERT INTO `data_members_score_log` VALUES ('209', '91', 'in', '51', '5', '0.04', '1521174484', null, '0.04', null, 'b395349d45ed5b7f6e2da628fed17cb3');
INSERT INTO `data_members_score_log` VALUES ('210', '91', 'out', '46', '4', '0.04', '1521174484', null, '199.96', null, 'b395349d45ed5b7f6e2da628fed17cb3');
INSERT INTO `data_members_score_log` VALUES ('211', '94', 'in', '51', '5', '0.01', '1521174484', null, '0.01', null, '51a41c43655de10b568e60a4025d974a');
INSERT INTO `data_members_score_log` VALUES ('212', '94', 'out', '46', '4', '0.01', '1521174484', null, '49.99', null, '51a41c43655de10b568e60a4025d974a');
INSERT INTO `data_members_score_log` VALUES ('213', '95', 'in', '51', '5', '60.00', '1521174484', null, '60.00', null, '1eec57877ca245dd44c28e7302c34d64');
INSERT INTO `data_members_score_log` VALUES ('214', '95', 'out', '46', '4', '60.00', '1521174484', null, '299940.00', null, '1eec57877ca245dd44c28e7302c34d64');
INSERT INTO `data_members_score_log` VALUES ('215', '96', 'in', '51', '5', '20.00', '1521174484', null, '20.00', null, 'b5c5b90d97be3537d708971509dce0be');
INSERT INTO `data_members_score_log` VALUES ('216', '96', 'out', '46', '4', '20.00', '1521174484', null, '99980.00', null, 'b5c5b90d97be3537d708971509dce0be');
INSERT INTO `data_members_score_log` VALUES ('217', '97', 'in', '51', '5', '20.00', '1521174484', null, '20.00', null, 'e248035c72a1a199c7c9318e1c07b3f1');
INSERT INTO `data_members_score_log` VALUES ('218', '97', 'out', '46', '4', '20.00', '1521174484', null, '99980.00', null, 'e248035c72a1a199c7c9318e1c07b3f1');
INSERT INTO `data_members_score_log` VALUES ('219', '98', 'in', '51', '5', '20.00', '1521174484', null, '20.00', null, '37b0ee0c54b9e5bea00b56bd01cb8983');
INSERT INTO `data_members_score_log` VALUES ('220', '98', 'out', '46', '4', '20.00', '1521174484', null, '99980.00', null, '37b0ee0c54b9e5bea00b56bd01cb8983');
INSERT INTO `data_members_score_log` VALUES ('221', '100', 'in', '51', '5', '20.00', '1521174484', null, '20.00', null, 'afa6669fa198a1148e306d76db8a8a55');
INSERT INTO `data_members_score_log` VALUES ('222', '100', 'out', '46', '4', '20.00', '1521174484', null, '99980.00', null, 'afa6669fa198a1148e306d76db8a8a55');
INSERT INTO `data_members_score_log` VALUES ('223', '101', 'in', '51', '5', '20.00', '1521174484', null, '20.00', null, '3321c55bb87e057bc0d4fcca702cb014');
INSERT INTO `data_members_score_log` VALUES ('224', '101', 'out', '46', '4', '20.00', '1521174484', null, '99980.00', null, '3321c55bb87e057bc0d4fcca702cb014');
INSERT INTO `data_members_score_log` VALUES ('225', '102', 'in', '51', '5', '50.00', '1521174484', null, '50.00', null, '68b7882fcde228ca55a3362453a9db01');
INSERT INTO `data_members_score_log` VALUES ('226', '102', 'out', '46', '4', '50.00', '1521174484', null, '249950.00', null, '68b7882fcde228ca55a3362453a9db01');
INSERT INTO `data_members_score_log` VALUES ('227', '103', 'in', '51', '5', '210.00', '1521174484', null, '210.00', null, '6597212420d82ce4b8f76f21b15f20cd');
INSERT INTO `data_members_score_log` VALUES ('228', '103', 'out', '46', '4', '210.00', '1521174484', null, '1049790.00', null, '6597212420d82ce4b8f76f21b15f20cd');
INSERT INTO `data_members_score_log` VALUES ('229', '85', 'in', '23', '2', '1.80', '1521174506', null, '1.80', null, '351c5f39e60e94d35fcd08a4073c60f5');
INSERT INTO `data_members_score_log` VALUES ('230', '85', 'out', '52', '5', '100.00', '1521174506', null, '41.90', null, '351c5f39e60e94d35fcd08a4073c60f5');
INSERT INTO `data_members_score_log` VALUES ('231', '85', 'in', '51', '5', '81.95', '1521174562', null, '123.85', null, '72fbc0e73466ab30099acfbffc6c3857');
INSERT INTO `data_members_score_log` VALUES ('232', '85', 'out', '46', '4', '81.95', '1521174562', null, '409676.15', null, '72fbc0e73466ab30099acfbffc6c3857');
INSERT INTO `data_members_score_log` VALUES ('233', '85', 'in', '23', '2', '0.90', '1521174573', null, '2.70', null, '152328023faef1eb9be539da47e88da3');
INSERT INTO `data_members_score_log` VALUES ('234', '85', 'out', '52', '5', '100.00', '1521174573', null, '23.85', null, '152328023faef1eb9be539da47e88da3');
INSERT INTO `data_members_score_log` VALUES ('235', '85', 'out', '33', '3', '790000.00', '1521178132', null, '800.00', null, '8c6a6de817165d63aead85316d8577a3');
INSERT INTO `data_members_score_log` VALUES ('236', '85', 'in', '41', '4', '790000.00', '1521178132', null, '1199676.15', null, '8c6a6de817165d63aead85316d8577a3');
INSERT INTO `data_members_score_log` VALUES ('237', '85', 'in', '42', '4', '7900000.00', '1521178132', null, '8309676.15', null, '2c9b8c90e5eba12269908da31d674d10');
INSERT INTO `data_members_score_log` VALUES ('238', '85', 'in', '51', '5', '1661.93', '1521178877', null, '1685.78', null, '1b17ae8ebd60db071abb0364059ade67');
INSERT INTO `data_members_score_log` VALUES ('239', '85', 'out', '46', '4', '1661.93', '1521178877', null, '8308014.22', null, '1b17ae8ebd60db071abb0364059ade67');
INSERT INTO `data_members_score_log` VALUES ('240', '85', 'in', '51', '5', '1661.60', '1521178945', null, '3347.38', null, '714c04eaa68a23c0e2290fa727d5b340');
INSERT INTO `data_members_score_log` VALUES ('241', '85', 'out', '46', '4', '1661.60', '1521178945', null, '8306352.62', null, '714c04eaa68a23c0e2290fa727d5b340');
INSERT INTO `data_members_score_log` VALUES ('242', '85', 'in', '51', '5', '1661.27', '1521179005', null, '5008.65', null, '0a3cc997d10247db084ad618fff10ec4');
INSERT INTO `data_members_score_log` VALUES ('243', '85', 'out', '46', '4', '1661.27', '1521179005', null, '8304691.35', null, '0a3cc997d10247db084ad618fff10ec4');
INSERT INTO `data_members_score_log` VALUES ('244', '85', 'in', '51', '5', '1660.93', '1521179051', null, '6669.58', null, 'e028d73b25d1e5c681b521f8d88378aa');
INSERT INTO `data_members_score_log` VALUES ('245', '85', 'out', '46', '4', '1660.93', '1521179051', null, '8303030.42', null, 'e028d73b25d1e5c681b521f8d88378aa');
INSERT INTO `data_members_score_log` VALUES ('246', '85', 'in', '51', '5', '1660.60', '1521179054', null, '8330.18', null, '06829480cd487b6f853d5cdc2977a646');
INSERT INTO `data_members_score_log` VALUES ('247', '85', 'out', '46', '4', '1660.60', '1521179054', null, '8301369.82', null, '06829480cd487b6f853d5cdc2977a646');
INSERT INTO `data_members_score_log` VALUES ('248', '85', 'in', '51', '5', '1660.27', '1521179056', null, '9990.45', null, '7168faf440f77e72ff62846c8a4d55d3');
INSERT INTO `data_members_score_log` VALUES ('249', '85', 'out', '46', '4', '1660.27', '1521179056', null, '8299709.55', null, '7168faf440f77e72ff62846c8a4d55d3');
INSERT INTO `data_members_score_log` VALUES ('250', '85', 'in', '51', '5', '1659.94', '1521179059', null, '11650.39', null, 'a46c44378ab7e38e8e7790799cf6fb5e');
INSERT INTO `data_members_score_log` VALUES ('251', '85', 'out', '46', '4', '1659.94', '1521179059', null, '8298049.61', null, 'a46c44378ab7e38e8e7790799cf6fb5e');
INSERT INTO `data_members_score_log` VALUES ('252', '85', 'in', '51', '5', '1659.60', '1521179061', null, '13309.99', null, '3604990e57698610c08d06b2702aca96');
INSERT INTO `data_members_score_log` VALUES ('253', '85', 'out', '46', '4', '1659.60', '1521179061', null, '8296390.01', null, '3604990e57698610c08d06b2702aca96');
INSERT INTO `data_members_score_log` VALUES ('254', '85', 'in', '51', '5', '1659.27', '1521179064', null, '14969.26', null, '4f315a64aa1e0c93d63bc61da48466f6');
INSERT INTO `data_members_score_log` VALUES ('255', '85', 'out', '46', '4', '1659.27', '1521179064', null, '8294730.74', null, '4f315a64aa1e0c93d63bc61da48466f6');
INSERT INTO `data_members_score_log` VALUES ('256', '85', 'in', '51', '5', '1658.94', '1521179068', null, '16628.20', null, 'd568b0649720a4340879c49584a0f641');
INSERT INTO `data_members_score_log` VALUES ('257', '85', 'out', '46', '4', '1658.94', '1521179068', null, '8293071.80', null, 'd568b0649720a4340879c49584a0f641');
INSERT INTO `data_members_score_log` VALUES ('258', '85', 'in', '23', '2', '157.70', '1521179138', null, '160.40', null, '80d3de15fa6572e3aabbc90926bc0b3d');
INSERT INTO `data_members_score_log` VALUES ('259', '85', 'out', '52', '5', '16600.00', '1521179138', null, '28.20', null, '80d3de15fa6572e3aabbc90926bc0b3d');
INSERT INTO `data_members_score_log` VALUES ('260', '85', 'in', '51', '5', '1658.61', '1521179214', null, '1686.81', null, 'bbe1926485d24924a75a4bc4121f1169');
INSERT INTO `data_members_score_log` VALUES ('261', '85', 'out', '46', '4', '1658.61', '1521179214', null, '8291413.19', null, 'bbe1926485d24924a75a4bc4121f1169');
INSERT INTO `data_members_score_log` VALUES ('262', '85', 'in', '51', '5', '1658.28', '1521179226', null, '3345.09', null, 'b363b8c7e0032a4e0596b1185967d3fb');
INSERT INTO `data_members_score_log` VALUES ('263', '85', 'out', '46', '4', '1658.28', '1521179226', null, '8289754.91', null, 'b363b8c7e0032a4e0596b1185967d3fb');
INSERT INTO `data_members_score_log` VALUES ('264', '85', 'in', '51', '5', '1657.95', '1521179231', null, '5003.04', null, '2a6e5ddae664475db94cf831cf97cd54');
INSERT INTO `data_members_score_log` VALUES ('265', '85', 'out', '46', '4', '1657.95', '1521179231', null, '8288096.96', null, '2a6e5ddae664475db94cf831cf97cd54');
INSERT INTO `data_members_score_log` VALUES ('266', '85', 'in', '51', '5', '1657.61', '1521179233', null, '6660.65', null, 'c91811da0980fcf8a239a55aa02be7a5');
INSERT INTO `data_members_score_log` VALUES ('267', '85', 'out', '46', '4', '1657.61', '1521179233', null, '8286439.35', null, 'c91811da0980fcf8a239a55aa02be7a5');
INSERT INTO `data_members_score_log` VALUES ('268', '85', 'in', '51', '5', '1657.28', '1521179235', null, '8317.93', null, '8d08345f252431fbdc39779f0735b9e2');
INSERT INTO `data_members_score_log` VALUES ('269', '85', 'out', '46', '4', '1657.28', '1521179235', null, '8284782.07', null, '8d08345f252431fbdc39779f0735b9e2');
INSERT INTO `data_members_score_log` VALUES ('270', '85', 'in', '51', '5', '1656.95', '1521179238', null, '9974.88', null, '09fc258621469abe1bf3c2185c83c134');
INSERT INTO `data_members_score_log` VALUES ('271', '85', 'out', '46', '4', '1656.95', '1521179238', null, '8283125.12', null, '09fc258621469abe1bf3c2185c83c134');
INSERT INTO `data_members_score_log` VALUES ('272', '85', 'in', '51', '5', '1656.62', '1521179242', null, '11631.50', null, '07b143096df09bce20391cc38933229f');
INSERT INTO `data_members_score_log` VALUES ('273', '85', 'out', '46', '4', '1656.62', '1521179242', null, '8281468.50', null, '07b143096df09bce20391cc38933229f');
INSERT INTO `data_members_score_log` VALUES ('274', '85', 'in', '51', '5', '1656.29', '1521179246', null, '13287.79', null, '1eec289efff7b8d718927f9f113bf975');
INSERT INTO `data_members_score_log` VALUES ('275', '85', 'out', '46', '4', '1656.29', '1521179246', null, '8279812.21', null, '1eec289efff7b8d718927f9f113bf975');
INSERT INTO `data_members_score_log` VALUES ('276', '85', 'in', '51', '5', '1655.96', '1521179249', null, '14943.75', null, 'a72130669350efe021de8f5c0874fdf9');
INSERT INTO `data_members_score_log` VALUES ('277', '85', 'out', '46', '4', '1655.96', '1521179249', null, '8278156.25', null, 'a72130669350efe021de8f5c0874fdf9');
INSERT INTO `data_members_score_log` VALUES ('278', '85', 'in', '51', '5', '1655.63', '1521179251', null, '16599.38', null, 'bd7bc15df2d7b3bff0ea5eb93e95db56');
INSERT INTO `data_members_score_log` VALUES ('279', '85', 'out', '46', '4', '1655.63', '1521179251', null, '8276500.62', null, 'bd7bc15df2d7b3bff0ea5eb93e95db56');
INSERT INTO `data_members_score_log` VALUES ('280', '85', 'in', '51', '5', '1655.30', '1521179254', null, '18254.68', null, '986db97eab336e951bc700f0de11da27');
INSERT INTO `data_members_score_log` VALUES ('281', '85', 'out', '46', '4', '1655.30', '1521179254', null, '8274845.32', null, '986db97eab336e951bc700f0de11da27');
INSERT INTO `data_members_score_log` VALUES ('282', '85', 'in', '51', '5', '1654.96', '1521179256', null, '19909.64', null, '538d54dc71115c49b7ed8521b4fda53e');
INSERT INTO `data_members_score_log` VALUES ('283', '85', 'out', '46', '4', '1654.96', '1521179256', null, '8273190.36', null, '538d54dc71115c49b7ed8521b4fda53e');
INSERT INTO `data_members_score_log` VALUES ('284', '85', 'in', '51', '5', '1654.63', '1521179258', null, '21564.27', null, 'd6098b5426881d56604a894840cb7a4e');
INSERT INTO `data_members_score_log` VALUES ('285', '85', 'out', '46', '4', '1654.63', '1521179258', null, '8271535.73', null, 'd6098b5426881d56604a894840cb7a4e');
INSERT INTO `data_members_score_log` VALUES ('286', '85', 'in', '51', '5', '1654.30', '1521179261', null, '23218.57', null, '55dcea2ac468769def9f2287b0b1533a');
INSERT INTO `data_members_score_log` VALUES ('287', '85', 'out', '46', '4', '1654.30', '1521179261', null, '8269881.43', null, '55dcea2ac468769def9f2287b0b1533a');
INSERT INTO `data_members_score_log` VALUES ('288', '85', 'in', '51', '5', '1653.97', '1521179263', null, '24872.54', null, '15f5de0484130e91601df88fdca4cbbf');
INSERT INTO `data_members_score_log` VALUES ('289', '85', 'out', '46', '4', '1653.97', '1521179263', null, '8268227.46', null, '15f5de0484130e91601df88fdca4cbbf');
INSERT INTO `data_members_score_log` VALUES ('290', '85', 'in', '51', '5', '1653.64', '1521179265', null, '26526.18', null, 'a54f8651b87e1174f330e9eef64958d4');
INSERT INTO `data_members_score_log` VALUES ('291', '85', 'out', '46', '4', '1653.64', '1521179265', null, '8266573.82', null, 'a54f8651b87e1174f330e9eef64958d4');
INSERT INTO `data_members_score_log` VALUES ('292', '85', 'in', '51', '5', '1653.31', '1521179268', null, '28179.49', null, '1ea2a50382e51c82db97b20d0cabc403');
INSERT INTO `data_members_score_log` VALUES ('293', '85', 'out', '46', '4', '1653.31', '1521179268', null, '8264920.51', null, '1ea2a50382e51c82db97b20d0cabc403');
INSERT INTO `data_members_score_log` VALUES ('294', '85', 'in', '51', '5', '1652.98', '1521179285', null, '29832.47', null, '3647a8e18565186f0c9e94cfef178370');
INSERT INTO `data_members_score_log` VALUES ('295', '85', 'out', '46', '4', '1652.98', '1521179285', null, '8263267.53', null, '3647a8e18565186f0c9e94cfef178370');
INSERT INTO `data_members_score_log` VALUES ('296', '85', 'in', '51', '5', '1652.65', '1521179287', null, '31485.12', null, '17aaecaeb6cb274ccc37dba59fb4c080');
INSERT INTO `data_members_score_log` VALUES ('297', '85', 'out', '46', '4', '1652.65', '1521179287', null, '8261614.88', null, '17aaecaeb6cb274ccc37dba59fb4c080');
INSERT INTO `data_members_score_log` VALUES ('298', '85', 'in', '51', '5', '1652.32', '1521179289', null, '33137.44', null, '0f47c853f787834a8f5f265bde4e4208');
INSERT INTO `data_members_score_log` VALUES ('299', '85', 'out', '46', '4', '1652.32', '1521179289', null, '8259962.56', null, '0f47c853f787834a8f5f265bde4e4208');
INSERT INTO `data_members_score_log` VALUES ('300', '85', 'in', '51', '5', '1651.99', '1521179291', null, '34789.43', null, '0f111baef2b46abdc56097314788d1fd');
INSERT INTO `data_members_score_log` VALUES ('301', '85', 'out', '46', '4', '1651.99', '1521179291', null, '8258310.57', null, '0f111baef2b46abdc56097314788d1fd');
INSERT INTO `data_members_score_log` VALUES ('302', '85', 'in', '51', '5', '1651.66', '1521179293', null, '36441.09', null, 'f6754c6defae54194b37447c038c9f82');
INSERT INTO `data_members_score_log` VALUES ('303', '85', 'out', '46', '4', '1651.66', '1521179293', null, '8256658.91', null, 'f6754c6defae54194b37447c038c9f82');
INSERT INTO `data_members_score_log` VALUES ('304', '85', 'in', '51', '5', '1651.33', '1521179295', null, '38092.42', null, '53d4124511f55d8d8914acf6ccefcc93');
INSERT INTO `data_members_score_log` VALUES ('305', '85', 'out', '46', '4', '1651.33', '1521179295', null, '8255007.58', null, '53d4124511f55d8d8914acf6ccefcc93');
INSERT INTO `data_members_score_log` VALUES ('306', '85', 'in', '51', '5', '1651.00', '1521179297', null, '39743.42', null, 'f165cf9ab7fcbe6c7c30619d71c1e674');
INSERT INTO `data_members_score_log` VALUES ('307', '85', 'out', '46', '4', '1651.00', '1521179297', null, '8253356.58', null, 'f165cf9ab7fcbe6c7c30619d71c1e674');
INSERT INTO `data_members_score_log` VALUES ('308', '85', 'in', '51', '5', '1650.67', '1521179299', null, '41394.09', null, '5a053d4b5b28af974b2dc82b5ba29244');
INSERT INTO `data_members_score_log` VALUES ('309', '85', 'out', '46', '4', '1650.67', '1521179299', null, '8251705.91', null, '5a053d4b5b28af974b2dc82b5ba29244');
INSERT INTO `data_members_score_log` VALUES ('310', '85', 'in', '51', '5', '1650.34', '1521179301', null, '43044.43', null, '89c4f317d523adab2893235c6b62b646');
INSERT INTO `data_members_score_log` VALUES ('311', '85', 'out', '46', '4', '1650.34', '1521179301', null, '8250055.57', null, '89c4f317d523adab2893235c6b62b646');
INSERT INTO `data_members_score_log` VALUES ('312', '85', 'in', '51', '5', '1650.01', '1521179303', null, '44694.44', null, '8ec42e0beef2de87538c1b188c2c10bf');
INSERT INTO `data_members_score_log` VALUES ('313', '85', 'out', '46', '4', '1650.01', '1521179303', null, '8248405.56', null, '8ec42e0beef2de87538c1b188c2c10bf');
INSERT INTO `data_members_score_log` VALUES ('314', '85', 'in', '51', '5', '1649.68', '1521179306', null, '46344.12', null, '8cd213c693feb9eb6eae5955c23b18fb');
INSERT INTO `data_members_score_log` VALUES ('315', '85', 'out', '46', '4', '1649.68', '1521179306', null, '8246755.88', null, '8cd213c693feb9eb6eae5955c23b18fb');
INSERT INTO `data_members_score_log` VALUES ('316', '85', 'in', '51', '5', '1649.35', '1521179308', null, '47993.47', null, 'fdfe406823015a67b7229e5986ba217c');
INSERT INTO `data_members_score_log` VALUES ('317', '85', 'out', '46', '4', '1649.35', '1521179308', null, '8245106.53', null, 'fdfe406823015a67b7229e5986ba217c');
INSERT INTO `data_members_score_log` VALUES ('318', '85', 'in', '51', '5', '1649.02', '1521179310', null, '49642.49', null, 'f16d603f0ef10481a5a0ae8cc72eb60b');
INSERT INTO `data_members_score_log` VALUES ('319', '85', 'out', '46', '4', '1649.02', '1521179310', null, '8243457.51', null, 'f16d603f0ef10481a5a0ae8cc72eb60b');
INSERT INTO `data_members_score_log` VALUES ('320', '85', 'in', '51', '5', '1648.69', '1521179312', null, '51291.18', null, '0b544a45e17deff8391b0692217e7019');
INSERT INTO `data_members_score_log` VALUES ('321', '85', 'out', '46', '4', '1648.69', '1521179312', null, '8241808.82', null, '0b544a45e17deff8391b0692217e7019');
INSERT INTO `data_members_score_log` VALUES ('322', '85', 'in', '51', '5', '1648.36', '1521179314', null, '52939.54', null, '094acf21e66672592a5e96ae22d7bf1e');
INSERT INTO `data_members_score_log` VALUES ('323', '85', 'out', '46', '4', '1648.36', '1521179314', null, '8240160.46', null, '094acf21e66672592a5e96ae22d7bf1e');
INSERT INTO `data_members_score_log` VALUES ('324', '85', 'in', '51', '5', '1648.03', '1521179316', null, '54587.57', null, '0473286babfb3bb41b14091689248471');
INSERT INTO `data_members_score_log` VALUES ('325', '85', 'out', '46', '4', '1648.03', '1521179316', null, '8238512.43', null, '0473286babfb3bb41b14091689248471');
INSERT INTO `data_members_score_log` VALUES ('327', '85', 'out', '22', '2', '100.00', '1521179316', null, '60.40', null, 'bad14187bd280335deb0b879256785a2');
INSERT INTO `data_members_score_log` VALUES ('328', '85', 'in', '23', '2', '517.75', '1521181110', null, '578.15', null, '1e84ab6e2ad025dcaac968a92f76e84a');
INSERT INTO `data_members_score_log` VALUES ('329', '85', 'out', '52', '5', '54500.00', '1521181110', null, '87.57', null, '1e84ab6e2ad025dcaac968a92f76e84a');
INSERT INTO `data_members_score_log` VALUES ('330', '85', 'out', '22', '2', '100.00', '1521181169', null, '478.15', null, '9426cf00c12810b4c4c259f4e63810b1');

-- ----------------------------
-- Table structure for data_members_sign
-- ----------------------------
DROP TABLE IF EXISTS `data_members_sign`;
CREATE TABLE `data_members_sign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_sign` char(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户token',
  `upd_time` int(10) DEFAULT NULL COMMENT '修改时间',
  `user_token` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户token',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of data_members_sign
-- ----------------------------
INSERT INTO `data_members_sign` VALUES ('9', '9426cf00c12810b4c4c259f4e63810b1', '1521179316', 'onsK4YWMS7KyKSe5lcb7Boq1');
INSERT INTO `data_members_sign` VALUES ('10', '463ae480beedec045a1bd0cfd0388972', '1521174484', 'vLk9mcpP1bn2nnmorkyz7oF1');
INSERT INTO `data_members_sign` VALUES ('11', '646dc5983ec8306aa1351706920027ed', '1521174484', '7YLv4nyUGiHfBdq1iqu6ygwT');
INSERT INTO `data_members_sign` VALUES ('12', '4328f95f36d5b90be963489a4ac03195', '1521026081', '45wvdP6KejKmYGOPhWgsda1U');
INSERT INTO `data_members_sign` VALUES ('13', 'b395349d45ed5b7f6e2da628fed17cb3', '1521174484', 'YGRkZLA6RQL9S6AGVgKHsw3y');
INSERT INTO `data_members_sign` VALUES ('14', '4bad15c1d0c964e953c9725d1b1bb01f', '1521026155', 'cnmTPVioTtUdA4ZNxmpnIILA');
INSERT INTO `data_members_sign` VALUES ('15', '625f9ae004c6b1dc3b12673a752acd13', '1521026166', 'OCV5HFjXh2E8lGMsNCRZqdDY');
INSERT INTO `data_members_sign` VALUES ('16', '51a41c43655de10b568e60a4025d974a', '1521174484', 'G5MiCLskT7S0gr8O2u02l9Be');
INSERT INTO `data_members_sign` VALUES ('17', '1eec57877ca245dd44c28e7302c34d64', '1521174484', 'xfCqxeQ1SojKyLEN4sQCLVc2');
INSERT INTO `data_members_sign` VALUES ('18', 'b5c5b90d97be3537d708971509dce0be', '1521174484', 'oJsk0sJdJBPNpTV7lS8SDu2G');
INSERT INTO `data_members_sign` VALUES ('19', 'e248035c72a1a199c7c9318e1c07b3f1', '1521174484', 'XyjNYaoCuaK6DgkCKlZDKq4L');
INSERT INTO `data_members_sign` VALUES ('20', '37b0ee0c54b9e5bea00b56bd01cb8983', '1521174484', 'cCAkNZeRU8oJYnTMqnFDkJKX');
INSERT INTO `data_members_sign` VALUES ('21', 'afa6669fa198a1148e306d76db8a8a55', '1521174484', 'axzKjokpi9MQOE7EoYuBa2LV');
INSERT INTO `data_members_sign` VALUES ('22', '3321c55bb87e057bc0d4fcca702cb014', '1521174484', 'Wx5PwEbq285KAicWA5CTY76h');
INSERT INTO `data_members_sign` VALUES ('23', '68b7882fcde228ca55a3362453a9db01', '1521174484', '1SxNSVWuf2EbumPnq89Ub99d');
INSERT INTO `data_members_sign` VALUES ('24', '6597212420d82ce4b8f76f21b15f20cd', '1521174484', 'bgYsg8qpoVVjoXtn1tUvUhui');
INSERT INTO `data_members_sign` VALUES ('25', '1c4dc94a6c29a05f4ebd051cb21e12d8', '1523070186', 'iei3h5mF2an6iQVOVqZyiQnQ');
INSERT INTO `data_members_sign` VALUES ('28', '7c5b5c00de1eba744aff5b1c94a813b0', '1523070733', 'hcImx4yCAIKP21SbBIbJ1aEu');
INSERT INTO `data_members_sign` VALUES ('30', 'ebe9794a335a7a54bae4cd6129507b2f', '1523070832', '2CFGljkOe4puRjyGNEPBUvyO');
INSERT INTO `data_members_sign` VALUES ('31', '05bd1c9837d82a59534231a820ca0295', '1523070932', 'T6L0aItUFYNVLZqJ8Y6nVVEK');
INSERT INTO `data_members_sign` VALUES ('37', '380389e0cc0780c2a3e58e4d663dc672', '1523071531', 'bUwYDOXcQSJK0C79bGu5PHkQ');

-- ----------------------------
-- Table structure for data_members_sign_err
-- ----------------------------
DROP TABLE IF EXISTS `data_members_sign_err`;
CREATE TABLE `data_members_sign_err` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `ctime` int(10) DEFAULT NULL COMMENT '失败时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of data_members_sign_err
-- ----------------------------
INSERT INTO `data_members_sign_err` VALUES ('1', '85', '1520438344');
INSERT INTO `data_members_sign_err` VALUES ('2', '85', '1520438357');
INSERT INTO `data_members_sign_err` VALUES ('3', '85', '1520438384');
INSERT INTO `data_members_sign_err` VALUES ('4', '85', '1520438386');
INSERT INTO `data_members_sign_err` VALUES ('5', '85', '1520438388');
INSERT INTO `data_members_sign_err` VALUES ('6', '85', '1520438466');
INSERT INTO `data_members_sign_err` VALUES ('7', '85', '1520438723');
INSERT INTO `data_members_sign_err` VALUES ('8', '85', '1520438765');
INSERT INTO `data_members_sign_err` VALUES ('9', '85', '1520438866');
INSERT INTO `data_members_sign_err` VALUES ('10', '85', '1520438916');
INSERT INTO `data_members_sign_err` VALUES ('11', '85', '1520438967');
INSERT INTO `data_members_sign_err` VALUES ('12', '85', '1520439020');
INSERT INTO `data_members_sign_err` VALUES ('13', '85', '1520439022');
INSERT INTO `data_members_sign_err` VALUES ('14', '85', '1520439378');
INSERT INTO `data_members_sign_err` VALUES ('15', '85', '1520439853');
INSERT INTO `data_members_sign_err` VALUES ('16', '85', '1520439920');
INSERT INTO `data_members_sign_err` VALUES ('17', '85', '1520440159');
INSERT INTO `data_members_sign_err` VALUES ('18', '85', '1520440197');
INSERT INTO `data_members_sign_err` VALUES ('19', '85', '1520440223');
INSERT INTO `data_members_sign_err` VALUES ('20', '85', '1520440424');
INSERT INTO `data_members_sign_err` VALUES ('21', '85', '1520440496');
INSERT INTO `data_members_sign_err` VALUES ('22', '85', '1521016992');
INSERT INTO `data_members_sign_err` VALUES ('23', '85', '1521017001');
INSERT INTO `data_members_sign_err` VALUES ('24', '85', '1521017040');
INSERT INTO `data_members_sign_err` VALUES ('25', '85', '1521017045');
INSERT INTO `data_members_sign_err` VALUES ('26', '3', '1521018532');
INSERT INTO `data_members_sign_err` VALUES ('27', '103', '1521026471');
INSERT INTO `data_members_sign_err` VALUES ('28', '103', '1521026526');
INSERT INTO `data_members_sign_err` VALUES ('29', '103', '1521026593');
INSERT INTO `data_members_sign_err` VALUES ('30', '103', '1521026657');
INSERT INTO `data_members_sign_err` VALUES ('31', '103', '1521026663');
INSERT INTO `data_members_sign_err` VALUES ('32', '103', '1521026737');
INSERT INTO `data_members_sign_err` VALUES ('33', '103', '1521026814');
INSERT INTO `data_members_sign_err` VALUES ('34', '103', '1521026877');
INSERT INTO `data_members_sign_err` VALUES ('35', '103', '1521026914');
INSERT INTO `data_members_sign_err` VALUES ('36', '85', '1521178231');
INSERT INTO `data_members_sign_err` VALUES ('37', '85', '1521180894');

-- ----------------------------
-- Table structure for data_message
-- ----------------------------
DROP TABLE IF EXISTS `data_message`;
CREATE TABLE `data_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '标题',
  `describe` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '描述',
  `type` tinyint(1) DEFAULT NULL COMMENT '消息类型 1 系统消息 2物流信息',
  `ctime` int(10) DEFAULT NULL COMMENT '创建时间',
  `uid` int(10) DEFAULT NULL COMMENT '用户ID',
  `extends` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '扩展字段 存入 物流号 订单号 可用于系统更新功能',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户消息';

-- ----------------------------
-- Records of data_message
-- ----------------------------

-- ----------------------------
-- Table structure for data_mills
-- ----------------------------
DROP TABLE IF EXISTS `data_mills`;
CREATE TABLE `data_mills` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL COMMENT '1微型 2小型 3中型 4大型 5超级',
  `last_time` int(10) unsigned DEFAULT NULL COMMENT '最后领取时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) unsigned DEFAULT NULL COMMENT '状态 1运行中 0已过期',
  `mill_value` decimal(16,8) DEFAULT NULL COMMENT '矿机剩余产出',
  `mill_sn` char(18) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '矿机号',
  `get_way` char(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '获取方式 reg 注册 buy 购买 uplevel1 1星会长 uplevel2 2星会长 uplevel3 三星会长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='矿机表';

-- ----------------------------
-- Records of data_mills
-- ----------------------------

-- ----------------------------
-- Table structure for data_mills_00
-- ----------------------------
DROP TABLE IF EXISTS `data_mills_00`;
CREATE TABLE `data_mills_00` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL COMMENT '1体验矿机  2微型 3小型 4中型 5大型 6超级',
  `last_time` int(10) unsigned DEFAULT NULL COMMENT '最后领取时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) unsigned DEFAULT NULL COMMENT '状态 1运行中 0已过期',
  `mill_value` decimal(16,8) DEFAULT NULL COMMENT '矿机剩余产出',
  `mill_sn` char(18) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '矿机号',
  `get_way` char(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '获取方式 reg 注册 buy 购买 uplevel1 1星会长 uplevel2 2星会长 uplevel3 三星会长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='矿机表0';

-- ----------------------------
-- Records of data_mills_00
-- ----------------------------

-- ----------------------------
-- Table structure for data_mills_01
-- ----------------------------
DROP TABLE IF EXISTS `data_mills_01`;
CREATE TABLE `data_mills_01` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL COMMENT '1微型 2小型 3中型 4大型 5超级',
  `last_time` int(10) unsigned DEFAULT NULL COMMENT '最后领取时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) unsigned DEFAULT NULL COMMENT '状态 1运行中 0已过期',
  `mill_value` decimal(16,8) DEFAULT NULL COMMENT '矿机剩余产出',
  `mill_sn` char(18) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '矿机号',
  `get_way` char(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '获取方式 reg 注册 buy 购买 uplevel1 1星会长 uplevel2 2星会长 uplevel3 三星会长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='矿机表1';

-- ----------------------------
-- Records of data_mills_01
-- ----------------------------
INSERT INTO `data_mills_01` VALUES ('1', '131', '1', '1524770612', '1524770612', '1', '11.00000160', 'ew2b6fe3ccff48719e', 'reg');

-- ----------------------------
-- Table structure for data_mills_02
-- ----------------------------
DROP TABLE IF EXISTS `data_mills_02`;
CREATE TABLE `data_mills_02` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL COMMENT '1微型 2小型 3中型 4大型 5超级',
  `last_time` int(10) unsigned DEFAULT NULL COMMENT '最后领取时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) unsigned DEFAULT NULL COMMENT '状态 1运行中 0已过期',
  `mill_value` decimal(16,8) DEFAULT NULL COMMENT '矿机剩余产出',
  `mill_sn` char(18) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '矿机号',
  `get_way` char(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '获取方式 reg 注册 buy 购买 uplevel1 1星会长 uplevel2 2星会长 uplevel3 三星会长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='矿机表2';

-- ----------------------------
-- Records of data_mills_02
-- ----------------------------

-- ----------------------------
-- Table structure for data_mills_03
-- ----------------------------
DROP TABLE IF EXISTS `data_mills_03`;
CREATE TABLE `data_mills_03` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL COMMENT '1微型 2小型 3中型 4大型 5超级',
  `last_time` int(10) unsigned DEFAULT NULL COMMENT '最后领取时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) unsigned DEFAULT NULL COMMENT '状态 1运行中 0已过期',
  `mill_value` decimal(16,8) DEFAULT NULL COMMENT '矿机剩余产出',
  `mill_sn` char(18) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '矿机号',
  `get_way` char(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '获取方式 reg 注册 buy 购买 uplevel1 1星会长 uplevel2 2星会长 uplevel3 三星会长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='矿机表3';

-- ----------------------------
-- Records of data_mills_03
-- ----------------------------

-- ----------------------------
-- Table structure for data_mills_04
-- ----------------------------
DROP TABLE IF EXISTS `data_mills_04`;
CREATE TABLE `data_mills_04` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL COMMENT '1微型 2小型 3中型 4大型 5超级',
  `last_time` int(10) unsigned DEFAULT NULL COMMENT '最后领取时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) unsigned DEFAULT NULL COMMENT '状态 1运行中 0已过期',
  `mill_value` decimal(16,8) DEFAULT NULL COMMENT '矿机剩余产出',
  `mill_sn` char(18) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '矿机号',
  `get_way` char(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '获取方式 reg 注册 buy 购买 uplevel1 1星会长 uplevel2 2星会长 uplevel3 三星会长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='矿机表4';

-- ----------------------------
-- Records of data_mills_04
-- ----------------------------

-- ----------------------------
-- Table structure for data_mills_05
-- ----------------------------
DROP TABLE IF EXISTS `data_mills_05`;
CREATE TABLE `data_mills_05` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL COMMENT '1微型 2小型 3中型 4大型 5超级',
  `last_time` int(10) unsigned DEFAULT NULL COMMENT '最后领取时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) unsigned DEFAULT NULL COMMENT '状态 1运行中 0已过期',
  `mill_value` decimal(16,8) DEFAULT NULL COMMENT '矿机剩余产出',
  `mill_sn` char(18) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '矿机号',
  `get_way` char(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '获取方式 reg 注册 buy 购买 uplevel1 1星会长 uplevel2 2星会长 uplevel3 三星会长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='矿机表5';

-- ----------------------------
-- Records of data_mills_05
-- ----------------------------

-- ----------------------------
-- Table structure for data_mills_06
-- ----------------------------
DROP TABLE IF EXISTS `data_mills_06`;
CREATE TABLE `data_mills_06` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL COMMENT '1微型 2小型 3中型 4大型 5超级',
  `last_time` int(10) unsigned DEFAULT NULL COMMENT '最后领取时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) unsigned DEFAULT NULL COMMENT '状态 1运行中 0已过期',
  `mill_value` decimal(16,8) DEFAULT NULL COMMENT '矿机剩余产出',
  `mill_sn` char(18) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '矿机号',
  `get_way` char(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '获取方式 reg 注册 buy 购买 uplevel1 1星会长 uplevel2 2星会长 uplevel3 三星会长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='矿机表6';

-- ----------------------------
-- Records of data_mills_06
-- ----------------------------
INSERT INTO `data_mills_06` VALUES ('13', '196', '1', '1533641773', '1533641773', '1', '104.00004000', 'pw827cc18b1acae758', 'buy');

-- ----------------------------
-- Table structure for data_mills_07
-- ----------------------------
DROP TABLE IF EXISTS `data_mills_07`;
CREATE TABLE `data_mills_07` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL COMMENT '1微型 2小型 3中型 4大型 5超级',
  `last_time` int(10) unsigned DEFAULT NULL COMMENT '最后领取时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) unsigned DEFAULT NULL COMMENT '状态 1运行中 0已过期',
  `mill_value` decimal(16,8) DEFAULT NULL COMMENT '矿机剩余产出',
  `mill_sn` char(18) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '矿机号',
  `get_way` char(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '获取方式 reg 注册 buy 购买 uplevel1 1星会长 uplevel2 2星会长 uplevel3 三星会长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='矿机表7';

-- ----------------------------
-- Records of data_mills_07
-- ----------------------------

-- ----------------------------
-- Table structure for data_mills_08
-- ----------------------------
DROP TABLE IF EXISTS `data_mills_08`;
CREATE TABLE `data_mills_08` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL COMMENT '1微型 2小型 3中型 4大型 5超级',
  `last_time` int(10) unsigned DEFAULT NULL COMMENT '最后领取时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) unsigned DEFAULT NULL COMMENT '状态 1运行中 0已过期',
  `mill_value` decimal(16,8) DEFAULT NULL COMMENT '矿机剩余产出',
  `mill_sn` char(18) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '矿机号',
  `get_way` char(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '获取方式 reg 注册 buy 购买 uplevel1 1星会长 uplevel2 2星会长 uplevel3 三星会长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='矿机表8';

-- ----------------------------
-- Records of data_mills_08
-- ----------------------------
INSERT INTO `data_mills_08` VALUES ('7', '108', '6', '1533554594', '1533554594', '1', '130000.00003200', 't81ea6b86a3e66858', 'buy');
INSERT INTO `data_mills_08` VALUES ('8', '108', '6', '1533555857', '1533555857', '1', '130000.00003200', 't547ebb65ee41d278', 'buy');
INSERT INTO `data_mills_08` VALUES ('9', '108', '4', '1533555863', '1533555863', '1', '11800.00000800', 'td779cf44618bafffe', 'buy');
INSERT INTO `data_mills_08` VALUES ('10', '108', '6', '1533639326', '1533639326', '1', '130000.00003200', 't0931a75e0e3825f1', 'buy');
INSERT INTO `data_mills_08` VALUES ('12', '198', '1', '1533647613', '1533647613', '1', '104.00004000', 'tw1322ffc3d559d059', 'buy');

-- ----------------------------
-- Table structure for data_mills_09
-- ----------------------------
DROP TABLE IF EXISTS `data_mills_09`;
CREATE TABLE `data_mills_09` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `type` tinyint(4) unsigned DEFAULT NULL COMMENT '1微型 2小型 3中型 4大型 5超级',
  `last_time` int(10) unsigned DEFAULT NULL COMMENT '最后领取时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(4) unsigned DEFAULT NULL COMMENT '状态 1运行中 0已过期',
  `mill_value` decimal(16,8) DEFAULT NULL COMMENT '矿机剩余产出',
  `mill_sn` char(18) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '矿机号',
  `get_way` char(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '获取方式 reg 注册 buy 购买 uplevel1 1星会长 uplevel2 2星会长 uplevel3 三星会长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='矿机表9';

-- ----------------------------
-- Records of data_mills_09
-- ----------------------------

-- ----------------------------
-- Table structure for data_news
-- ----------------------------
DROP TABLE IF EXISTS `data_news`;
CREATE TABLE `data_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章逻辑ID',
  `title` varchar(128) NOT NULL COMMENT '文章标题',
  `cate_id` int(11) NOT NULL DEFAULT '1' COMMENT '文章类别',
  `create_time` int(10) NOT NULL COMMENT '文章发表时间',
  `last_time` int(10) DEFAULT NULL,
  `content` text NOT NULL COMMENT '文章内容',
  `from` varchar(64) NOT NULL DEFAULT '' COMMENT '来源',
  `create_ip` varchar(16) NOT NULL,
  `picurl` varchar(255) DEFAULT NULL COMMENT '图片路径',
  `view` int(10) DEFAULT '0' COMMENT '展示次数',
  `des` varchar(255) DEFAULT NULL COMMENT '简介',
  `admin_id` int(4) DEFAULT NULL COMMENT '管理员ID',
  `state` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态 0 审核失败 1 审核通过',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='文章表';

-- ----------------------------
-- Records of data_news
-- ----------------------------
INSERT INTO `data_news` VALUES ('3', '加密货币矿业：大型矿商或将变身为游戏改变者', '39', '1524769549', '1524769549', '<p><br/></p><p>由于挖掘比特币等加密货币所需的复杂计算需要工业规模的采矿能力，大型企业在矿业的优势越来越明显。随着采矿业的成熟，预期的整合可能会将使用个人电脑挖矿的“普通人”淘汰出局。</p><center><img src=\"http://kj.finance18.com/Uploads/ueditor/2018-04-27/1524769515880778.jpg\" title=\"1524769515880778.jpg\" alt=\"图片1.jpg\" style=\"white-space: normal;\"/></center><p>加密货币采矿设备供应商Bitfury Group Ltd.北美分公司Hut 8 Mining Corp.的董事长Bill \r\nTai预计，只有五到十家最大矿商能够存活并获利。Bill Tai告诉彭博社：</p><p>今年与去年完全不同，比特币采矿业正在成长，并将在各个层面上具有机构可扩展性的元素。</p><p>Digital Asset Research的高级分析师Lucas \r\nNuzzi表示，考虑到矿工持有20%至30%的比特币，出售比特币以支付运营成本可能会压低以比特币为代表的虚拟货币的价格。采矿权的集中可能会将采矿业推向一个新时代。在这个新时代，少数参与者将有足够的控制权来决定区块链生态系统的发展。Lucas \r\nNuzzi评论道：</p><p>从安全角度来看，这种情况可能会很危险。因为单个实体可以利用它的“hash计算力(hashpower)”(数据挖掘使用的计算资源)来破坏网络。</p><p>小规模矿工从制造商那里购买芯片和机器，有时会遇到零件短缺的情况。然而行业规模大的矿工设计和制造自己的硬件。规模经济使他们能够批量下订单，以折扣购买电力，即使比特币视之为8000美元也能盈利。Bill \r\nTai补充说：</p><p>我们可以大批量购买产品和硅片，以折扣购买电力。我们也有足够的周转资金。</p><p>该采矿权力在少数企业实体的手中是很多人不愿意看到的，因为这样有违去中心化的本质。垄断寡头的51%攻击将使得他们能控制足够多的交易来改变区块链技术的发展方向。这虽然是最糟糕的设想，但距离我们并不像以前那么遥远。</p><p><br/></p>', '', '111.197.242.179', '/Public/Wap/img/lb_02.png', '0', '', '53', '1');
INSERT INTO `data_news` VALUES ('4', '关于我们', '50', '1524769631', '1524769631', '关于我们<p>泰国财政部已经向该国国会提交了《数字资产业务紧急法案草案》和《收入法修正案草案》，并且启动了公告流程。一旦通过，泰国加密货币交易将会被征收15%的预扣税。</p><center><img src=\"/Uploads/ueditor/2018-04-27/1524769625122492.jpg\" title=\"1524769625122492.jpg\" alt=\"图片2.jpg\"/></center><p>此外，泰国区块链协会曾致信该国财政部收入署主管巴拉松•博塔尼特(Prasong \r\nPoontaneat)，建议政府修改草案不要收取高达15%的预扣税。但根据巴拉松•博塔尼特提交给泰国副总理Somkid \r\nJatusripitak的回信中透露，他们已经寻求了很多加密货币业内人士的意见，而且参考了泰国存款税率，认为这一费率是合理的，因此否决了泰国区块链协会的建议。</p><p>巴拉松•博塔尼特称，目前泰国财政部长Apisak \r\nTantivorawong已经要求继续执行该法案草案，同时按其中规定的费率征收预扣税。不仅如此，在现阶段包括泰国在内的很多国家都没有合法接受数字货币的大环境下，巴拉松•博塔尼特还希望相关法规能够保护散户投资人，避免欺诈风险。他说道：</p><p>“本次推出的法律草案，目的就是为了防止人们受到加密货币欺诈损失，同时也希望进一步预防洗钱风险。根据相关法律草案的要求，所有加密货币发行人必须要声明自己的身份，而且必须要向税务部门纳税。”</p><p>有消息称，泰国区块链协会认为，相比于新加坡，泰国15%的加密货币税费过高，但监管机构认为，这一税率并不是仅局限于加密货币，还覆盖到存款和其他领域，因此相对比较公平。不仅如此，根据一位泰国财政部的匿名消息人士透露，一旦该法案生效，泰国证券交易委员会就将出台针对管理数字货币及其承销商的法律法规。此外，所有运营数字资产业务的公司必须在九十天内通知泰国证券交易委员会。关于我们', '', '111.197.242.179', '/Public/Wap/img/lb_02.png', '0', '关于我们', '53', '1');
INSERT INTO `data_news` VALUES ('5', '马昊伯：80%的互联网平台会被区块链取代', '39', '1524769755', '1524769755', '<p style=\"text-align: center;\"><img src=\"/Uploads/ueditor/2018-04-27/1524769727461287.png\" title=\"1524769727461287.png\" alt=\"图片5.png\"/>2</p><p>018年4月23日，aelf创始人马昊伯受邀前往澳门参加WBS 2018澳门第一届世界区块链大会·三点钟峰会。</p><p>本次大会由中国最具影响力的区块链社群“三点钟无眠区块链”、深创学院及世界区块链大会组委会联合主办，邀请了各国的区块链国际组织负责人、行业领军人物、名人、专家学者、技术极客、关联媒体、上下游产品及设备供应商、区块链各领域个体以及各大投资机构等。</p><center><img src=\"/Uploads/ueditor/2018-04-27/1524769714109904.png\" title=\"1524769714109904.png\" alt=\"图片3.png\"/></center><p>会上，aelf创始人马昊伯重点为大家分享了aelf在区块链生态中的价值及项目社区建设情况。</p><p>在谈到区块链行业未来的发展趋势时，马昊伯指出：“未来80%的互联网平台将会被区块链所取代。”</p><center><img src=\"/Uploads/ueditor/2018-04-27/1524769719814375.png\" title=\"1524769719814375.png\" alt=\"图片4.png\"/></center><p>“区块链已经发展了近10年之久，但与未来的预期相比，当前行业的整体水平还处于起步阶段。此时的区块链技术相当于互联网行业的1993年，距大规模的商业落地，还需要经过长时间的验证。”针对区块链行业的现状，马昊伯提出了这样的看法。</p><center><br/></center><p>谈及到aelf项目时，马昊伯表明：“如果去中心化是未来的发展趋势，那么去中心化网络的基础设施，就会像亚马逊、阿里云一样重要，所以aelf将持续深耕底层公链技术，为将后来更多的商业场景提供必要的技术支持，aelf要做去中心化的亚马逊。”</p><p><br/></p>', '', '111.197.242.179', '/Public/Wap/img/lb_02.png', '0', '', '53', '1');
INSERT INTO `data_news` VALUES ('6', '区块链和生活会擦出怎样的火花？', '39', '1524769811', '1524769811', '<p></p><p>我经常会花费很多时间来寻找能够影响我们生活方式的创新方案。其实我开始不知道如何才能缩小寻找的范围。这意味着你需要去寻找几乎我们参与转账和活动的每种技术。</p><center><img src=\"http://kj.finance18.com/Uploads/ueditor/2018-04-27/1524769783596582.jpg\" title=\"1524769783596582.jpg\" alt=\"图片6.jpg\" style=\"white-space: normal;\"/></center><p>随着寻找的深入，最终的结果是区块链。有些人会误认为区块链和加密货币几乎不可能成为我们日常生活中的主流。其他人会认为区块链意味着是的很多公司和消费者会因为它而消失。但是核心思想就是，这项技术对于每个人来说都是不可忽视的!</p><p>于是我们开始去寻找区块链在我们生活中的意义，但是等等，首先我们需要明白什么是区块链以及为什么我们需要它?</p><p>所以，到底什么是区块链?</p><p>区块链的发明原先是作为比特币转账使用的账本。但是很快大家都很清楚，区块链去中心化，不可篡改，匿名的特性可以在很多行业有效地使用。很快就出现了革命式创新，以太坊，从而区块链技术也被完全改变了。以太坊让开发人员可以在区块链上可以无限制地创造各类软件。</p><p>于是我开始尝试去进行虚拟币交易，但是这在我们的生活中真的有用吗?区块链真地解决了什么问题吗?它比现在的技术能更好地解决问题吗?如果真是这样，区块链技术有多可靠呢?</p><p>我们真地需要区块链吗?</p><p>加密货币经常被提到，但是主要是解决金融方面的问题。法币的问题在于它总是会奖励那些会运作资本的人，但是会愚弄那些拼命工作存钱的人。现在几乎每个国家都有政府发出的没有任何资产背书的法币作为税收信用。对于商业银行来说，很难去忽视这项比他们现有数据库更加安全和稳定的技术。区块链真正的潜力在各行业的投资人开始发现区块链技术可以从数字货币中分离开来，并对各个行业进行改革。首先，区块链匿名的特性可以终结身份诈骗。其次，区块链的去中心化特性可以完成两个中心化系统间无法想象的支付速度。</p><p>●所以简单来说，区块链将会：</p><p>●降低成本</p><p>●有更好的信息安全性</p><p>●更快的处理时间</p><p>●更好的信息收集和研究能力</p><p>对于传统货币最根本的问题在于需要信任才能正常工作。中央银行一定要能被信任，从而不至于货币会贬值，但是法币的历史却充满了信任危机。银行一定要被信任才能让我们存钱并且进行电子转账，但是它们却可以在信任泡沫的时候借出钱，最后却所剩无几。我们也要相信银行会保管我们的隐私，相信它们不会让身份信息小偷去盗取你的账户。</p><p>有些区块链速度很慢，但是有些却很快，快速可以让银行转账更有效率。使用智能合约可以为银行大幅降低成本。几家大型银行已经开始像使用区块链靠拢，并且瑞士银行已经在领先使用以太坊来提高他们参考数据的质量。</p><p>区块链真地那么好吗?</p><p>区块链绝对是很大的发展但是就像他们说的“每种优势都有一些劣势”。不出意外地是，很多中央政府都在尽力去限制加密货币的发展。但是区块链也有无法解决的问题。</p><p>区块链主要的限制是：</p><p>●复杂性</p><p>●网络规模</p><p>●安全问题</p><p>●存储限制</p><p>●不可持续发展的共识机制</p><p>区块链协议能够让管理模式数字化，而且由于矿工正在进行另外一个激励的自制模式，在不同的社区之间也会有很多的不同意见。这些争论是非常专业，并且有时候会非常火热，但是对那些对区块链正在打开的民主，共识以及治理方式感兴趣的人却提供了很多信息。</p><p>数字货币目前的问题是现在并没有被广泛接受。现在的情况是加密货币的价格被定义了，但是没有和资产和服务的价格相对应。加密货币价值的波动是因为没有中央机构来管制它的价格。由于越来越多的投资者涌入，这种波动性会越来越强。</p><p>很多热衷于数字货币的人都只是为了赚快钱而已。网络论坛上很多的讨论都是关于虚拟币价格什么时候会涨，并且这些讨论越来越多，很少有人会讨论比特币在现实生活中有什么用。如果很多人都在收集没有任何明显好处的资产，而不是将它以更加价格卖出，长期肯定会出现问题。人们存发币是因为他们认为这是一种储蓄，但是现在数字货币却没有同样的功效。通过数字货币一夜之间成为百万富翁的梦想已经逐渐吞噬了真实投资者构建的原生市场。法币仍然很有价值因为它是由国家背书，并且由央行来控制价格和可用性。</p><p>也许区块链最大的威胁–数字货币对政府和传统金融系统造成的威胁就是破坏了他们的权威以及长久的控制和强权。同时，数字货币站在区块链的基础上来规避传统银行的流程。</p><p>区块链的全部只是用来代替法币吗?</p><p>现在很明显，区块链这项技术已经远不止是比特币了。从金融，医疗，媒体，政府还有其他版块，各种用户媒体都在出现。区块链除了数字货币以为还有很多可以改变我们的生活。区块链技术的各种应用使得全世界的金融和银行机构，医院，法律系统，企业和政府的运作更加容易。区块链技术难以想象地具有弹性。它可以被塑造成不同的方式来符合不同的流程。</p><p>对于区块链的探寻之旅还在继续，因为它还在持续改变我们的生活。我们需要注意任何区块链带来的创新。但是我们也不知道区块链需要多久才能被接受，甚至是企业更需要哪种区块链技术，尝试给区块链来定价值是没有意义的。世界上每个公司都必须要想办法来利用区块链的改革能力。当金融领域已经在过去几十年占据了头条，其他行业也开始使用区块链技术来占据市场。当然，区块链也需要解决其他的障碍，至少是很慢的转账速度以及价值大幅波动。尽管有这些优势，有些人仍然认为加密货币是破坏性的。但是，最好的年轻区块链企业家可以发现能够帮助企业运行更加有效的办法。区块链仍然有很多挑战。但是这些挑战和如果在产业参与者组成的社区中标准化网络解决方案比起来没有这样专业。无论主流的比特币会发生什么，都不能改变区块链能够给我们生活带来的优势和好处。</p><p><br/></p>', '', '111.197.242.179', '/Public/Wap/img/lb_02.png', '0', '', '53', '1');
INSERT INTO `data_news` VALUES ('7', '测试测试测试测试测试11111', '39', '1531992665', '1531992665', '<p>测试测试测试测试测试11111测试测试测试测试测试11111测试测试测试测试测试11111测试测试测试测试测试11111测试测试测试测试测试11111</p>', '', '0.0.0.0', '', '0', '测试测试测试测试测试11111测试测试测试测试测试1111121314444', '53', '1');
INSERT INTO `data_news` VALUES ('8', '测试测试测试测试测试2222', '62', '1531992709', '1531992709', '<p>222222222222222<br/></p>', '', '0.0.0.0', '', '0', '测试测试测试测试测试2222222', '53', '1');
INSERT INTO `data_news` VALUES ('9', '7月28号开始正式内测了！', '63', '1531992869', '1531992869', '7月28号开始正式内测了！7月28号开始正式内测了！7月28号开始正式内测了！7月28号开始正式内测了！', '', '0.0.0.0', '', '0', '7月28号开始正式内测了！', '53', '1');
INSERT INTO `data_news` VALUES ('10', '分析师揭秘比特币大额转账背后玄机', '39', '1533640521', '1533640521', '<p>在不足两周的时间里，比特币已从8600多美元跌到不足7000美元，各种悲观论调一时甚嚣尘上。与此同时，比特币每一次大额转账都成为市场关注的焦点。</p><p>昨晚（8月6日）22点00分，据searchain.io数据显示：3JL6FwvpGc1rensTJ1bjpP5YtxWUFLpLk8向Xapo.com钱包地址转入13376.436枚BTC。</p><p>其中，3JL开头的资金来源是今年2月从3Em、3Qd、37C、3BX等四个地址转入，该四个地址同为Xapo.com钱包地址。</p><p>此前不久，金色财经同样观察到，比特币富豪榜上第1名地址3D2oetdNuZUqQHPJmcMDDHYoqkyNVsFk9r从7月24日至27日05:39:24共陆续转出10000枚比特币。当时市场正处于震荡中，随后不久就出现了下跌。</p><p><img src=\"/Uploads/2018-08-07/1533640502624386.png\" title=\"8wGOPgyutXBafLuSYmLhnxS6CsgK6Yp2rNwZ4pSY.jpeg\" alt=\"8wGOPgyutXBafLuSYmLhnxS6CsgK6Yp2rNwZ4pSY.jpeg\"/></p><p>那么，大额转账跟币价波动到底是什么关系？这里面又有多少玄机呢？</p><p><strong>主流币种转账存在多种可能性</strong></p><p>按照一般的逻辑，比特币出现大额转账一般是为了卖出做准备，这显然会对市场构成抛压，币价因此多会出现下跌走势。</p><p>但是，实际情况远非如此简单。“比特币转入后，不仅可以用于卖出，还可以用于买入其他币种。因此很难据此判断市场走势。”金色财经特约分析师柯光超分析说。</p><p>根据柯光超的长期观察和分析，不仅是比特币，包括ETH、EOS在内的主流币种都是如此，因为他们之间都存在交易对，所以每一种主流币种的大额转入，未来都存在多种交易可能。因此，仅仅据此判断市场走势会存在很大的偏差。</p><p>事实上，即使大额转账的目的就是用于套现砸盘，也很难据此判断市场未来走势。</p><p>因为既然是市场公开信息，就存在被利用和操纵的可能性。如果大众普遍认为大额转账意味着市场下跌，一旦这种思维惯性形成，很容易被主力利用。</p><p>比如，主力可以配合大额转账的发生故意渲染恐慌气氛，诱使小散割肉出局，借机大量买进吸筹。</p><p><strong>小币种大额转账要结合消息面具体分析</strong></p><p>相比比特币，很多小币种的情况则略有不同。</p><p>因为小币种大多存在主力控盘、市场交投不活跃、项目方有相当的主导能力等特点。</p><p><img src=\"/Uploads/2018-08-07/1533640502350741.png\" title=\"xPaxtW2K9yJXPojnjLH7plHL00YEEyD4jsnfF5gq.png\" alt=\"xPaxtW2K9yJXPojnjLH7plHL00YEEyD4jsnfF5gq.png\"/></p><p>对此，柯光超举例说：“6月14日的时候，我开始关注WFEE。当时BTC正在下跌中，WFEE却在逆势拉升，我看到后就想探寻背后的原因。查看相关资讯，发现它竟然要自建交易所，希望成为币圈第一个由项目代币转为平台币的币种。并且，在6月15日，我查到WFEE疑似项目方的钱包地址向交易所转入了数笔大额代币。而它计划上线自建交易所的日期就定在6月19日。我因此猜测它很可能在上线之前再拉一波，然后再出货。因为这是庄家惯用的伎俩。事后看，果然如此。”</p><p>然而，事情到此并没有结束。</p><p>据柯光超介绍，就在此后不久的7月9日，有多个场外地址向OKEX转入了累计8.5亿WFEE代币，接近它流通量的1/3，显然，WFEE又要“搞事情”。</p><p>原来，就在此时，项目方给大家发了一个通告：WFEE换了全新的团队，这是一个做实事的团队。之前团队做出的龌龊事，将在此终结。然后接连着还有WFEE大生态全球共赢计划、高管增持计划等所谓的利好。</p><p>与此同时，在社群里也是一片看多，只要一有人发出看空的言论，就立马会被骂空狗。</p><p>不久之后，神秘的庄家Tom喊出了挂单60，干翻空军等等口号。</p><p>然后呢？就没有然后了。</p><p>由此可见，大额转账这类所谓的主力公开信息必须结合其他因素加以分析，才能得出正确结论。</p><p><br/></p>', '金色财经', '222.128.127.218', '/Uploads/images/2018-08-07/5b697f2335802.png', '1231', '分析师揭秘比特币大额转账背后玄机.分析师揭秘比特币大额转账背后玄机', '53', '1');
INSERT INTO `data_news` VALUES ('11', '多个地址清空ZIL 转向交易所是拉是砸', '39', '1533640629', '1533640639', '<p>交易所数据有刷的可能性，但链上数据做不得假。从链上数据分析持币者的行为，为大家提供多维度的投资分析。</p><p><strong>GTC</strong></p><p>OKEX发布下架GTC的公告，虽然导致GTC当日价格大幅下跌，但并没有压垮它。GTC目前仍坚挺地活在其他交易所上。</p><p>8月4日0时到8时，共发生了四起从OKEX向gate.io的大额转账，累计转入9,748,504枚GTC。</p><p style=\"text-align: center;\"><img src=\"https://img.jinse.com/1027468_image3.png\" alt=\"多个地址清空ZIL 转向交易所是拉是砸\"/></p><p>目前，GTC的流通量约为7.6亿，此次转账占据其流通量的1.2%。</p><p>不过，此次有可能是GTC下架OKEX引起的恐慌性抛售，诸多大户低价购买到大量GTC，随即转入到其他支持GTC的交易所。</p><p>8月5日9时57分，某个场外地址向gate.io转入了2,000,000枚GTC。</p><p style=\"text-align: center;\"><img src=\"https://img.jinse.com/1027469_image3.png\" alt=\"多个地址清空ZIL 转向交易所是拉是砸\"/></p><p>经确认，该笔大额转账是Fcoin钱包地址转出，期间经过两个中间地址才流入gate.io。</p><p>8月6日又发生了数笔从OKEX离场，充入如火币、gate.io等交易所的转账。</p><p style=\"text-align: center;\"><img src=\"https://img.jinse.com/1027470_image3.png\" alt=\"多个地址清空ZIL 转向交易所是拉是砸\"/></p><p>不过转账数额一般，疑似某些散户的动作。</p><p><br/></p><p style=\"text-align: center;\"><br/></p><p style=\"text-align: center;\"><br/></p><p style=\"text-align: center;\"><strong><img src=\"https://img.jinse.com/1027518_image3.png\" alt=\"多个地址清空ZIL 转向交易所是拉是砸\"/></strong></p><p><strong>ZIL</strong></p><p>8月7日上午2时，发生了两起转入币安的ZIL大额转账，累计转入10,413,000枚ZIL。</p><p style=\"text-align: center;\"><img src=\"https://img.jinse.com/1027474_image3.png\" alt=\"多个地址清空ZIL 转向交易所是拉是砸\"/></p><p>据调查，这两个钱包地址目前已清空所有ZIL，也就是说它所持有的ZIL均已转入币安。</p><p>8月7日上午5时59分，某场外地址向币安钱包地址转入1,772,534枚ZIL。</p><p style=\"text-align: center;\"><img src=\"https://img.jinse.com/1027476_image3.png\" alt=\"多个地址清空ZIL 转向交易所是拉是砸\"/></p><p>经分析，此钱包地址ZIL的来源是3月25日5时59分从另一地址转入的。</p><p>此外，在本月向交易所发起的所有大额转账中，场外钱包地址基本清空了所有ZIL，各位投资者需谨慎。</p><p style=\"text-align: center;\"><img src=\"https://img.jinse.com/1027547_image3.png\" alt=\"多个地址清空ZIL 转向交易所是拉是砸\"/></p><p><strong>OMG</strong></p><p>8月5日发生了数笔转向币安与Bitfinex的OMG大额转账。</p><p>其中，流入币安的有一笔，数额为50,000枚OMG；</p><p style=\"text-align: center;\"><img src=\"https://img.jinse.com/1027478_image3.png\" alt=\"多个地址清空ZIL 转向交易所是拉是砸\"/></p><p>流入Bitfinex的共有三笔，累计86,043枚OMG。</p><p style=\"text-align: center;\"><img src=\"https://img.jinse.com/1027481_image3.png\" alt=\"多个地址清空ZIL 转向交易所是拉是砸\"/></p><p>进一步分析，流入Bitfinex的三笔转账为同一地址不同时间的转账。该地址转账频率高，疑似持币大户。</p><p>此外，8月6日，OMG还发生了一笔由火币转向Bitfinex的转账，转账金额为100,000枚OMG。</p><p style=\"text-align: center;\"><img src=\"https://img.jinse.com/1027482_image3.png\" alt=\"多个地址清空ZIL 转向交易所是拉是砸\"/></p><p>而目前，OMG在火币上的成交量占比远大于Bitfinex，需密切关注。</p><p style=\"text-align: center;\"><img src=\"https://img.jinse.com/1027550_image3.png\" alt=\"多个地址清空ZIL 转向交易所是拉是砸\"/></p><p><br/></p>', '', '222.128.127.218', '', '0', '多个地址清空ZIL 转向交易所是拉是砸', '53', '1');

-- ----------------------------
-- Table structure for data_notice
-- ----------------------------
DROP TABLE IF EXISTS `data_notice`;
CREATE TABLE `data_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `info` text,
  `add_time` varchar(15) DEFAULT NULL,
  `update_time` varchar(15) DEFAULT NULL,
  `dialog` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否弹出 1是 0否',
  `forever` tinyint(1) DEFAULT '0' COMMENT '是否每次弹出',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='公告通知';

-- ----------------------------
-- Records of data_notice
-- ----------------------------
INSERT INTO `data_notice` VALUES ('29', '重磅来袭2', '&lt;p style=&quot;text-align: justify; text-indent: 2em;&quot;&gt;在公司积极的推动下，前期为债权人提供的六款汽车73辆已于2018年1月22日全部置换完毕，更大程度的为债权人止损提供了有效的途径。为了减轻债权人的资金压力，我公司已于保险公司洽谈，以最少的现金分期置换车辆这一方案。&lt;span style=&quot;text-indent: 2em;&quot;&gt;如正需要新车置换的朋友可以先行预定，车型近日将推出。&lt;/span&gt;&lt;span style=&quot;text-indent: 2em;&quot;&gt;预定请发送邮箱&lt;strong&gt;zcsybl@aliyun.com&lt;/strong&gt;或微信号&lt;strong&gt;da20130706&lt;/strong&gt;。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align: justify; text-indent: 2em;&quot;&gt;&lt;span style=&quot;text-indent: 2em;&quot;&gt;敬请期待！&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align: right;&quot;&gt;&lt;span style=&quot;text-align: right;&quot;&gt;阳光・易换城&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align: right;&quot;&gt;2018年1月23日&lt;/p&gt;&lt;p&gt;&lt;br style=&quot;text-align: left;&quot;/&gt;&lt;/p&gt;', '1488261140', '1523689577', '2', '0');
INSERT INTO `data_notice` VALUES ('30', '111111111111', '&lt;p&gt;1111111111111111111111111222222&lt;/p&gt;', '1523689588', '1523689595', '0', '0');

-- ----------------------------
-- Table structure for data_orders
-- ----------------------------
DROP TABLE IF EXISTS `data_orders`;
CREATE TABLE `data_orders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(2) unsigned NOT NULL COMMENT '订单类型 1 买入  2卖出',
  `opc` decimal(20,8) DEFAULT NULL COMMENT 'opc数量',
  `price` decimal(20,8) DEFAULT NULL COMMENT '单价',
  `total_cny` decimal(20,8) DEFAULT NULL COMMENT 'rmb',
  `sell_uid` int(11) DEFAULT NULL COMMENT '卖家ID ',
  `buy_uid` int(11) DEFAULT NULL COMMENT '买家ID',
  `appeal` tinyint(1) unsigned DEFAULT '0' COMMENT '申诉 0否 1是',
  `status` tinyint(3) NOT NULL COMMENT '01买家发布 02卖家发布 03匹配成功 04买家已标记 05交易成功 -1卖家撤单  -2买家撤单  ',
  `create_time` int(10) NOT NULL COMMENT '创建时间',
  `match_time` int(10) DEFAULT NULL COMMENT '匹配时间',
  `pay_time` int(10) unsigned DEFAULT NULL COMMENT '买家支付时间',
  `confirm_time` int(10) DEFAULT NULL COMMENT '卖家确认时间',
  `cancel_time` int(10) unsigned DEFAULT NULL COMMENT '取消时间',
  `sell_zfb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sell_wx` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sell_bank` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sell_other` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `order_sn` char(32) COLLATE utf8_unicode_ci NOT NULL COMMENT '订单号',
  `message` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '买方留言',
  `cert_img` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '凭证截图',
  `admin` tinyint(4) unsigned DEFAULT NULL COMMENT '管理员ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of data_orders
-- ----------------------------
INSERT INTO `data_orders` VALUES ('1', '1', '100.00000000', '0.00000001', '0.00000700', '108', '118', '0', '5', '1523802553', '1523849430', '1523849447', '1523849507', null, null, null, null, null, '2018041510055992', '', '', null);
INSERT INTO `data_orders` VALUES ('4', '2', '100.00000000', '0.00000001', '0.00000700', '108', null, '0', '2', '32767', null, null, null, null, null, null, null, null, '', '', '', null);
INSERT INTO `data_orders` VALUES ('6', '2', '100.00000000', '0.00000001', '0.00000700', '108', null, '0', '2', '32767', null, null, null, null, null, null, null, null, '', '', '', null);
INSERT INTO `data_orders` VALUES ('7', '2', '100.00000000', '0.00000001', '0.00000700', '108', null, '0', '2', '32767', null, null, null, null, null, null, null, null, '2018041510055991', '', '', null);
INSERT INTO `data_orders` VALUES ('8', '2', '100.00000000', '0.00000001', '0.00000700', '108', null, '0', '2', '32767', null, null, null, null, null, null, null, null, '2018041552489951', '', '', null);
INSERT INTO `data_orders` VALUES ('9', '2', '100.00000000', '0.00000001', '0.00000700', '108', null, '0', '2', '32767', null, null, null, null, null, null, null, null, '2018041598100971', '', '', null);
INSERT INTO `data_orders` VALUES ('10', '2', '100.00000000', '0.00000001', '0.00000700', '108', null, '0', '2', '32767', null, null, null, null, null, null, null, null, '2018041548495110', '', '', null);
INSERT INTO `data_orders` VALUES ('11', '2', '100.00000000', '0.00000001', '0.00000700', '108', '136', '0', '-2', '32767', '1524912119', '1524912155', null, '1525192970', null, null, null, null, '2018041555101995', '', '/Uploads/authc2/2018-04-28/5ae4501a3f9e6.jpg', null);
INSERT INTO `data_orders` VALUES ('12', '2', '100.00000000', '0.00000001', '0.00000700', '108', null, '0', '2', '32767', null, null, null, null, null, null, null, null, '2018041597525710', '', '', null);
INSERT INTO `data_orders` VALUES ('13', '2', '100.00000000', '0.00000001', '0.00000700', '108', '146', '0', '-2', '1523802553', '1524988802', null, null, '1524988871', null, null, null, null, '2018041557539753', '', '', null);
INSERT INTO `data_orders` VALUES ('14', '2', '100.00000000', '0.00000001', '0.00000700', '108', '146', '0', '-2', '1523802553', '1524989006', null, null, '1524989202', null, null, null, null, '2018041557100485', '', '', null);
INSERT INTO `data_orders` VALUES ('15', '2', '100.00000000', '0.00000001', '0.00000700', '108', '146', '0', '-2', '1523802554', '1524988591', null, null, '1524988681', null, null, null, null, '2018041597501015', '', '', null);
INSERT INTO `data_orders` VALUES ('16', '2', '100.00000000', '0.00000001', '0.00000700', '121', '131', '0', '3', '1523802554', '1524740152', null, null, null, null, null, null, null, '2018041597565555', '', '', null);
INSERT INTO `data_orders` VALUES ('17', '2', '100.00000000', '0.00000001', '0.00000700', '121', null, '0', '-1', '1523802554', null, null, null, '1523851153', null, null, null, null, '2018041597100485', '', '', null);
INSERT INTO `data_orders` VALUES ('18', '2', '100.00000000', '0.00000001', '0.00000700', '121', '118', '0', '5', '1523802555', '1523802619', '1523805603', '1523808345', null, null, null, null, null, '2018041598519748', '', '', null);
INSERT INTO `data_orders` VALUES ('19', '2', '100.00000000', '50.00000000', '35000.00000000', '118', '139', '0', '101', '1523852008', '1524822709', '1524936298', '1531138770', null, null, null, null, null, '2018041656514953', '', '/Uploads/authc2/2018-04-29/5ae4ae67c6925.jpg', null);
INSERT INTO `data_orders` VALUES ('22', '1', '100.00000000', '5.00000000', '3500.00000000', '121', '118', '0', '-2', '1523852625', '1523852774', null, null, '1523853041', null, null, null, null, '2018041649535751', '', '', null);
INSERT INTO `data_orders` VALUES ('23', '1', '100.00000000', '5.00000000', '3500.00000000', null, '118', '0', '-2', '1523852627', null, null, null, '1523852671', null, null, null, null, '2018041651515710', '', '', null);
INSERT INTO `data_orders` VALUES ('24', '1', '100.00000000', '1.00000000', '700.00000000', '136', '139', '0', '-1', '1524811745', '1525192390', null, null, '1525224187', null, null, null, null, '2018042749102519', '', '', null);
INSERT INTO `data_orders` VALUES ('25', '1', '1.00000000', '1.00000000', '7.00000000', '139', '108', '0', '-1', '1524822793', '1524823035', null, null, '1525241498', '132693620001', '13269362000wj', '招商银行,6214850239893529,何永清', null, '2018042757991005', '', '', null);
INSERT INTO `data_orders` VALUES ('26', '2', '7.00000000', '7.00000000', '343.00000000', '139', '108', '0', '4', '1524823160', '1524823176', '1533192083', null, null, '132693620001', '13269362000wj', '招商银行,6214850239893529,何永清', null, '2018042756511024', '111', '/Uploads/authc2/2018-08-02/5b62a79241439.jpg', null);
INSERT INTO `data_orders` VALUES ('27', '1', '1232.00000000', '1.00000000', '8624.00000000', '139', '140', '0', '-2', '1524824323', '1524825069', null, null, '1525348591', '132693620001', '13269362000wj', '招商银行,6214850239893529,何永清', null, '2018042751505351', '', '', null);
INSERT INTO `data_orders` VALUES ('28', '2', '100.00000000', '5.00000000', '3500.00000000', '139', '143', '0', '3', '1524837335', '1524887666', null, null, null, '132693620001', '13269362000wj', null, null, '2018042755975797', '', '', null);
INSERT INTO `data_orders` VALUES ('29', '1', '1000.00000000', '0.10000000', '700.00000000', '139', '144', '0', '5', '1524886810', '1524886842', '1524886912', '1524886936', null, '132693620001', '13269362000wj', '招商银行,6214850239893529,何永清', null, '2018042897100525', '专科完成', '/Uploads/authc2/2018-04-28/5ae3ed7c1cd3c.jpg', null);
INSERT INTO `data_orders` VALUES ('30', '2', '10000.00000000', '0.10000000', '7000.00000000', '139', '140', '0', '-2', '1524887200', '1524887747', null, null, '1525348600', null, null, '招商银行,6214850239893529,何永清', null, '2018042848575049', '', '', null);
INSERT INTO `data_orders` VALUES ('31', '1', '10000.00000000', '0.10000000', '7000.00000000', '139', '140', '0', '-2', '1524887253', '1524887295', null, null, '1525348595', '132693620001', '13269362000wj', null, null, '2018042853985199', '', '', null);
INSERT INTO `data_orders` VALUES ('32', '1', '50.00000000', '0.10000000', '35.00000000', '139', '143', '0', '3', '1524887341', '1524887435', null, null, null, '132693620001', '13269362000wj', '招商银行,6214850239893529,何永清', null, '2018042810051545', '', '', null);
INSERT INTO `data_orders` VALUES ('33', '2', '10000.00000000', '0.10000000', '7000.00000000', '139', '136', '0', '5', '1524887737', '1524888980', '1524889099', '1524889181', null, '132693620001', '13269362000wj', null, null, '2018042857555550', '', '/Uploads/authc2/2018-04-28/5ae3f60a7f8a7.jpg', null);
INSERT INTO `data_orders` VALUES ('34', '2', '50.00000000', '1000.00000000', '350000.00000000', '136', '146', '0', '5', '1524910462', '1524912050', '1524912219', '1524912271', null, null, null, null, null, '2018042810198979', '', '/Uploads/authc2/2018-04-28/5ae4505a89c0c.jpg', null);
INSERT INTO `data_orders` VALUES ('35', '2', '2.00000000', '10.00000000', '140.00000000', '146', '136', '0', '5', '1524912342', '1524912370', '1524912418', '1524912456', null, null, null, null, null, '2018042854971025', '马哥最骚', '/Uploads/authc2/2018-04-28/5ae45113c939b.jpg', null);
INSERT INTO `data_orders` VALUES ('36', '1', '99.00000000', '0.01000000', '6.93000000', null, '108', '0', '1', '1525368033', null, null, null, null, null, null, null, null, '2018050449539898', '', '', null);
INSERT INTO `data_orders` VALUES ('37', '1', '1.00000000', '0.00800000', '0.00800000', null, '108', '0', '1', '1533020791', null, null, null, null, null, null, null, null, '20180731150631555350545548501004', '', '', null);
INSERT INTO `data_orders` VALUES ('38', '1', '1.00000000', '0.00800000', '0.00800000', null, '108', '0', '1', '1533021256', null, null, null, null, null, null, null, null, '20180731151416505449575453575292', '', '', null);
INSERT INTO `data_orders` VALUES ('39', '1', '2.00000000', '0.00800000', '0.01600000', null, '108', '0', '1', '1533021261', null, null, null, null, null, null, null, null, '20180731151421574857565652541930', '', '', null);
INSERT INTO `data_orders` VALUES ('40', '1', '3.00000000', '0.00800000', '0.02400000', null, '108', '0', '1', '1533021269', null, null, null, null, null, null, null, null, '20180731151429505656505051502975', '', '', null);
INSERT INTO `data_orders` VALUES ('41', '1', '4.00000000', '0.00800000', '0.03200000', null, '108', '0', '1', '1533021279', null, null, null, null, null, null, null, null, '20180731151439505153545351545581', '', '', null);
INSERT INTO `data_orders` VALUES ('42', '1', '4.00000000', '0.00800000', '0.03200000', null, '108', '0', '1', '1533021301', null, null, null, null, null, null, null, null, '20180731151501514950555050557742', '', '', null);
INSERT INTO `data_orders` VALUES ('43', '1', '5.00000000', '0.00800000', '0.04000000', null, '108', '0', '1', '1533021309', null, null, null, null, null, null, null, null, '20180731151509505554565350526050', '', '', null);
INSERT INTO `data_orders` VALUES ('44', '1', '5.00000000', '0.00800000', '0.04000000', '108', '111', '0', '-2', '1533021357', '1533026833', null, null, '1533201738', null, null, null, null, '20180731151557555355515157522437', '', '', null);
INSERT INTO `data_orders` VALUES ('45', '2', '1.00000000', '0.00800000', '0.00800000', '111', '108', '0', '4', '1533021944', '1533024875', '1533190950', null, null, '11111222', '1122111', 'beijign,421181199465665,熊爽', '11111', '20180731152544495251485156575318', '1111', '/Uploads/authc2/2018-08-02/5b62a30aba307.jpg', null);
INSERT INTO `data_orders` VALUES ('46', '2', '1.00000000', '0.00800000', '0.00800000', '108', null, '0', '-1', '1533021953', null, null, null, '1533111552', null, null, null, null, '20180731152553535252525052525485', '', '', null);
INSERT INTO `data_orders` VALUES ('47', '1', '1.00000000', '2.00000000', '2.00000000', null, '108', '0', '1', '1533535333', null, null, null, null, null, null, null, null, '20180806140213515052515753552325', '', '', null);

-- ----------------------------
-- Table structure for data_orders_appeal
-- ----------------------------
DROP TABLE IF EXISTS `data_orders_appeal`;
CREATE TABLE `data_orders_appeal` (
  `id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '申诉标题',
  `content` varchar(500) NOT NULL DEFAULT '' COMMENT '详情描述',
  `imgs` varchar(255) NOT NULL DEFAULT '' COMMENT '相关截图',
  `add_time` int(10) unsigned NOT NULL COMMENT '申诉时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单申诉';

-- ----------------------------
-- Records of data_orders_appeal
-- ----------------------------
INSERT INTO `data_orders_appeal` VALUES ('0', '1', '121', 'aaadf', 'werwerz', '/Uploads/Problem/2018-04-27/5ae2c53fae510.png,,,,', '1524811100');

-- ----------------------------
-- Table structure for data_price
-- ----------------------------
DROP TABLE IF EXISTS `data_price`;
CREATE TABLE `data_price` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` int(10) NOT NULL COMMENT '日期',
  `price` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '开盘价格',
  `high` decimal(20,3) NOT NULL,
  `low` decimal(20,3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of data_price
-- ----------------------------
INSERT INTO `data_price` VALUES ('1', '1532361600', '1.000', '1.000', '1.000');
INSERT INTO `data_price` VALUES ('2', '1532361600', '1.000', '1.000', '1.000');
INSERT INTO `data_price` VALUES ('3', '1532361600', '0.004', '0.004', '0.002');
INSERT INTO `data_price` VALUES ('4', '1532448000', '0.005', '0.005', '0.004');
INSERT INTO `data_price` VALUES ('5', '1532534400', '0.006', '0.006', '0.005');
INSERT INTO `data_price` VALUES ('6', '1532620800', '0.007', '0.007', '0.005');
INSERT INTO `data_price` VALUES ('10', '1533398400', '1.000', '1.000', '1.000');
INSERT INTO `data_price` VALUES ('11', '1533484800', '3.000', '6.000', '5.000');
INSERT INTO `data_price` VALUES ('12', '1533571200', '2.000', '3.000', '5.000');

-- ----------------------------
-- Table structure for data_release
-- ----------------------------
DROP TABLE IF EXISTS `data_release`;
CREATE TABLE `data_release` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) DEFAULT NULL COMMENT 'members.id',
  `wallet_lock` int(11) DEFAULT '0' COMMENT '还剩释放数量',
  `lock_total` int(11) DEFAULT '0' COMMENT '总冻结数量',
  `last_rel_date` int(11) DEFAULT '0' COMMENT '最后一次释放时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_release
-- ----------------------------

-- ----------------------------
-- Table structure for data_treenode
-- ----------------------------
DROP TABLE IF EXISTS `data_treenode`;
CREATE TABLE `data_treenode` (
  `id` int(11) unsigned NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `show_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 过渡菜单 2 功能菜单 3 ajax功能 4 公共方法',
  `menu_class` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '菜单分类 用于区分头部菜单左侧菜单',
  `is_hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `icon` varchar(124) DEFAULT NULL COMMENT '菜单icon css样式',
  `m` varchar(124) DEFAULT NULL COMMENT '模块',
  `c` varchar(124) DEFAULT NULL COMMENT '控制器',
  `a` varchar(124) DEFAULT NULL COMMENT '方法',
  `menuflag` tinyint(4) DEFAULT '1' COMMENT '菜单 0: 否 1 是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of data_treenode
-- ----------------------------
INSERT INTO `data_treenode` VALUES ('1', '全选', '0', '0', '0', '0', null, 'DataAdmin', null, '', '0');
INSERT INTO `data_treenode` VALUES ('5', '系统管理', '1', '0', '0', '0', null, 'DataAdmin', 'System', 'index', '1');
INSERT INTO `data_treenode` VALUES ('8', '账号管理', '5', '0', '0', '0', 'glyphicon-user', 'DataAdmin', 'system', 'userList', '1');
INSERT INTO `data_treenode` VALUES ('9', '系统公告', '5', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'System', 'indexNotice', '1');
INSERT INTO `data_treenode` VALUES ('10', '新增', '5', '0', '0', '0', 'glyphicon-plus', 'DataAdmin', 'System', 'userAdd', '0');
INSERT INTO `data_treenode` VALUES ('11', '修改状态', '5', '0', '0', '0', null, 'DataAdmin', 'System', 'batchChangeUser', '0');
INSERT INTO `data_treenode` VALUES ('12', '删除账号', '5', '0', '0', '0', null, 'DataAdmin', 'System', 'delUser', '0');
INSERT INTO `data_treenode` VALUES ('13', '系统设置', '5', '0', '0', '0', 'glyphicon-wrench', 'DataAdmin', 'System', 'index', '1');
INSERT INTO `data_treenode` VALUES ('14', '导航设置', '5', '0', '0', '0', 'glyphicon glyphicon-new-window', 'DataAdmin', 'System', 'nav', '0');
INSERT INTO `data_treenode` VALUES ('15', '修改密码', '5', '0', '0', '0', null, 'DataAdmin', 'System', 'pwdEdit', '0');
INSERT INTO `data_treenode` VALUES ('16', 'APP版本', '1', '0', '0', '0', null, 'DataAdmin', 'Version', null, '0');
INSERT INTO `data_treenode` VALUES ('22', '批量删除账号', '5', '0', '0', '0', null, 'DataAdmin', 'System', 'BatchDelUser', '0');
INSERT INTO `data_treenode` VALUES ('23', '编辑账号信息', '5', '0', '0', '0', null, 'DataAdmin', 'System', 'edituser', '0');
INSERT INTO `data_treenode` VALUES ('24', '商家管理', '1', '0', '0', '0', null, 'DataAdmin', 'Merchant', '', '0');
INSERT INTO `data_treenode` VALUES ('26', '商品管理', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Goods', 'index', '0');
INSERT INTO `data_treenode` VALUES ('29', '首页', '1', '0', '0', '0', null, 'DataAdmin', 'Index', 'index', '0');
INSERT INTO `data_treenode` VALUES ('34', '订单管理', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Order', 'index', '1');
INSERT INTO `data_treenode` VALUES ('38', '商品添加', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Goods', 'add', '0');
INSERT INTO `data_treenode` VALUES ('39', '商品修改', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Goods', 'edit', '0');
INSERT INTO `data_treenode` VALUES ('40', '商品图片添加', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Goods', 'act_do', '0');
INSERT INTO `data_treenode` VALUES ('49', '订单管理详情', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Order', 'orderprocess', '0');
INSERT INTO `data_treenode` VALUES ('50', '订单管理取消', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Order', 'cancel', '0');
INSERT INTO `data_treenode` VALUES ('51', '拒绝商品上架', '24', '0', '0', '0', null, 'DataAdmin', 'Goods', 'set_refuse', '0');
INSERT INTO `data_treenode` VALUES ('58', '商品下架', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Goods', 'status', '0');
INSERT INTO `data_treenode` VALUES ('61', '设置可上传商品数量', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Merchant', 'set_nums', '0');
INSERT INTO `data_treenode` VALUES ('62', '添加App首页推荐', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Goods', 'addRecommend', '0');
INSERT INTO `data_treenode` VALUES ('63', '执行添加App首页推荐', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Goods', 'addRe_to', '0');
INSERT INTO `data_treenode` VALUES ('64', '取消App首页推荐', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Goods', 'delRecommend', '0');
INSERT INTO `data_treenode` VALUES ('65', '商品导出', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Exp', 'ShopOrder', '0');
INSERT INTO `data_treenode` VALUES ('66', '店铺导出', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Exp', 'GoodsOrder', '0');
INSERT INTO `data_treenode` VALUES ('67', '订单导出', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Exp', 'Orders', '0');
INSERT INTO `data_treenode` VALUES ('74', '添加电商商品参考价', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Goods', 'set_lookprice', '0');
INSERT INTO `data_treenode` VALUES ('75', '售后管理', '24', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Aftersale', 'index', '1');
INSERT INTO `data_treenode` VALUES ('78', '订单数据', '77', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Data', 'order_index', '1');
INSERT INTO `data_treenode` VALUES ('79', '商品数据', '77', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Data', 'goods_index', '1');
INSERT INTO `data_treenode` VALUES ('125', '会员管理', '1', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Members', null, '1');
INSERT INTO `data_treenode` VALUES ('126', '会员列表', '125', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Members', 'members', '1');
INSERT INTO `data_treenode` VALUES ('127', 'C1认证', '125', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Members', 'auths_c1', '1');
INSERT INTO `data_treenode` VALUES ('128', '广告管理', '1', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Other', '', '1');
INSERT INTO `data_treenode` VALUES ('129', '认证审核', '125', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Members', 'auth_confirm', '0');
INSERT INTO `data_treenode` VALUES ('130', 'C2认证', '125', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Members', 'auths', '1');
INSERT INTO `data_treenode` VALUES ('161', '版本管理', '16', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Version', 'index', '1');
INSERT INTO `data_treenode` VALUES ('180', '订单管理', '1', '0', '0', '0', null, 'DataAdmin', 'Orders', '', '1');
INSERT INTO `data_treenode` VALUES ('181', '订单列表', '180', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Orders', 'index', '1');
INSERT INTO `data_treenode` VALUES ('182', '管理', '180', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Orders', 'appeal', '0');
INSERT INTO `data_treenode` VALUES ('190', '矿机管理', '1', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Mills', null, '1');
INSERT INTO `data_treenode` VALUES ('191', '矿机列表', '190', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Mills', 'index', '1');
INSERT INTO `data_treenode` VALUES ('192', '设置比率', '190', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'ReturnScore', 'set', '0');
INSERT INTO `data_treenode` VALUES ('200', '文章管理', '1', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'News', 'newsList', '1');
INSERT INTO `data_treenode` VALUES ('201', '文章管理', '200', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'News', 'newsList', '1');
INSERT INTO `data_treenode` VALUES ('202', '分类管理', '200', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'News', 'category', '1');
INSERT INTO `data_treenode` VALUES ('204', '矿机票管理', '1', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'MinerTicket', 'orderList', '1');
INSERT INTO `data_treenode` VALUES ('205', '价格管理', '1', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Price', 'priceList', '1');
INSERT INTO `data_treenode` VALUES ('1281', '轮播列表', '128', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Other', 'bannerList', '1');
INSERT INTO `data_treenode` VALUES ('1290', '内部报单', '204', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'MinerTicket', 'reportOrder', '1');
INSERT INTO `data_treenode` VALUES ('1291', '奖励发放', '204', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'MinerTicket', 'giveAward', '1');
INSERT INTO `data_treenode` VALUES ('1292', '报单列表', '204', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'MinerTicket', 'orderList', '1');
INSERT INTO `data_treenode` VALUES ('1293', '价格列表', '205', '0', '0', '0', 'glyphicon-list', 'DataAdmin', 'Price', 'priceList', '1');

-- ----------------------------
-- Table structure for data_user_score_log
-- ----------------------------
DROP TABLE IF EXISTS `data_user_score_log`;
CREATE TABLE `data_user_score_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '用户ID',
  `changeform` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '变动类型 in 收入 out 支出',
  `subtype` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '1买入 2卖出 3矿机产出 4小区分红 5 推荐奖励 7购买矿机 8 矿石兑换富链 9 富链兑换矿机票 10转赠矿机票 11奖励矿机票',
  `num` decimal(20,8) NOT NULL DEFAULT '0.00000000' COMMENT '余额变动',
  `ctime` int(10) NOT NULL,
  `describes` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '说明',
  `balance` decimal(20,8) DEFAULT '0.00000000' COMMENT '操作后余额',
  `extends` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '扩展字段 推荐激励 fromuid 受赠 fromuid 转增 touid ',
  `money_type` tinyint(1) DEFAULT NULL COMMENT '1 矿石  2 矿机票  3 RC',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_user_score_log
-- ----------------------------
INSERT INTO `data_user_score_log` VALUES ('1', '108', 'in', '4', '0.03000000', '1531986596', null, '0.03000000', '1531929600', '1');
INSERT INTO `data_user_score_log` VALUES ('2', '108', 'in', '4', '0.03000000', '1531986753', null, '0.06000000', '1531929600', '1');
INSERT INTO `data_user_score_log` VALUES ('3', '108', 'in', '4', '0.03000000', '1531986766', null, '0.09000000', '1531929600', '1');
INSERT INTO `data_user_score_log` VALUES ('4', '108', 'in', '4', '0.00200000', '1531987742', '', '0.09200000', '1531929600', '1');
INSERT INTO `data_user_score_log` VALUES ('5', '108', 'in', '14', '0.00200000', '1531987742', '', '0.09200000', '1531929600', '1');
INSERT INTO `data_user_score_log` VALUES ('6', '192', 'in', '14', '0.00200000', '1531987742', '', '0.09200000', '1531929600', '1');
INSERT INTO `data_user_score_log` VALUES ('7', '111', 'out', '12', '1.00000000', '1532932279', null, '1010.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('8', '112', 'in', '13', '1.00000000', '1532932279', null, '1012.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('9', '111', 'out', '12', '1.00000000', '1532932281', null, '1009.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('10', '112', 'in', '13', '1.00000000', '1532932281', null, '1013.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('11', '111', 'out', '12', '111.00000000', '1532932667', null, '898.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('12', '112', 'in', '13', '111.00000000', '1532932667', null, '1124.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('13', '111', 'out', '12', '111.00000000', '1532932669', null, '787.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('14', '112', 'in', '13', '111.00000000', '1532932669', null, '1235.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('15', '111', 'out', '12', '111.00000000', '1532932670', null, '676.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('16', '112', 'in', '13', '111.00000000', '1532932670', null, '1346.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('17', '111', 'out', '12', '111.00000000', '1532932671', null, '565.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('18', '112', 'in', '13', '111.00000000', '1532932671', null, '1457.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('19', '111', 'out', '12', '2.00000000', '1532932801', null, '563.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('20', '112', 'in', '13', '2.00000000', '1532932801', null, '1459.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('21', '111', 'out', '12', '2.00000000', '1532932823', null, '561.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('22', '112', 'in', '13', '2.00000000', '1532932823', null, '1461.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('23', '111', 'out', '12', '2.00000000', '1532932884', null, '559.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('24', '112', 'in', '13', '2.00000000', '1532932884', null, '1463.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('25', '111', 'out', '12', '2.00000000', '1532932911', null, '557.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('26', '112', 'in', '13', '2.00000000', '1532932911', null, '1465.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('27', '111', 'out', '12', '3.00000000', '1532933001', null, '554.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('28', '112', 'in', '13', '3.00000000', '1532933001', null, '1468.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('29', '111', 'out', '12', '3.00000000', '1532933004', null, '551.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('30', '112', 'in', '13', '3.00000000', '1532933004', null, '1471.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('31', '111', 'out', '12', '3.00000000', '1532933005', null, '548.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('32', '112', 'in', '13', '3.00000000', '1532933005', null, '1474.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('33', '111', 'out', '12', '3.00000000', '1532933007', null, '545.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('34', '112', 'in', '13', '3.00000000', '1532933007', null, '1477.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('35', '111', 'out', '12', '3.00000000', '1532933008', null, '542.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('36', '112', 'in', '13', '3.00000000', '1532933008', null, '1480.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('37', '111', 'out', '12', '3.00000000', '1532933008', null, '539.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('38', '112', 'in', '13', '3.00000000', '1532933008', null, '1483.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('39', '111', 'out', '12', '3.00000000', '1532933008', null, '536.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('40', '112', 'in', '13', '3.00000000', '1532933008', null, '1486.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('41', '111', 'out', '12', '3.00000000', '1532933009', null, '533.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('42', '112', 'in', '13', '3.00000000', '1532933009', null, '1489.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('43', '111', 'out', '12', '3.00000000', '1532933012', null, '530.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('44', '112', 'in', '13', '3.00000000', '1532933012', null, '1492.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('45', '111', 'in', '12', '2.00000000', '1532933076', null, '527.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('46', '112', 'in', '13', '3.00000000', '1532933076', null, '1495.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('47', '111', 'in', '12', '2.00000000', '1532933097', null, '524.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('48', '112', 'in', '13', '3.00000000', '1532933097', null, '1498.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('49', '111', 'in', '12', '1.00000000', '1532933118', null, '523.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('50', '112', 'in', '13', '1.00000000', '1532933118', null, '1499.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('51', '111', 'in', '11', '1.00000000', '1532933164', null, '522.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('52', '112', 'in', '13', '1.00000000', '1532933164', null, '1500.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('53', '111', 'in', '11', '5.00000000', '1532933164', '', '522.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('54', '111', 'out', '10', '1.00000000', '1532934659', null, '521.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('55', '112', 'in', '10', '1.00000000', '1532934659', null, '1501.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('56', '111', 'out', '10', '1.00000000', '1532934661', null, '520.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('57', '112', 'in', '10', '1.00000000', '1532934661', null, '1502.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('58', '111', 'out', '10', '4.00000000', '1532934668', null, '519.00000000', '112', '2');
INSERT INTO `data_user_score_log` VALUES ('59', '112', 'in', '10', '1.00000000', '1532934668', null, '1503.00000000', '111', '2');
INSERT INTO `data_user_score_log` VALUES ('60', '111', 'in', '10', '1.00000000', '1532934669', null, '518.00000000', '112', '1');
INSERT INTO `data_user_score_log` VALUES ('61', '112', 'in', '10', '1.00000000', '1532934669', null, '1504.00000000', '111', '1');
INSERT INTO `data_user_score_log` VALUES ('62', '111', 'in', '10', '1.00000000', '1532934671', null, '517.00000000', '112', '1');
INSERT INTO `data_user_score_log` VALUES ('63', '112', 'in', '10', '1.00000000', '1532934671', null, '1505.00000000', '111', '1');
INSERT INTO `data_user_score_log` VALUES ('64', '111', 'in', '10', '3.00000000', '1532934671', null, '516.00000000', '112', '1');
INSERT INTO `data_user_score_log` VALUES ('65', '112', 'in', '10', '1.00000000', '1532934671', null, '1506.00000000', '111', '1');
INSERT INTO `data_user_score_log` VALUES ('66', '111', 'in', '10', '1.00000000', '1532934671', '', '1506.00000000', '111', '1');
INSERT INTO `data_user_score_log` VALUES ('67', '108', 'out', '7', '100000.00000000', '1533366981', null, '0.00000000', 't460d9bff59f53018', '2');
INSERT INTO `data_user_score_log` VALUES ('68', '195', 'in', '11', '122.00000000', '1533379329', null, '122.00000000', '1', '2');
INSERT INTO `data_user_score_log` VALUES ('69', '195', 'in', '11', '122.00000000', '1533379393', null, '244.00000000', '1', '2');
INSERT INTO `data_user_score_log` VALUES ('70', '195', 'in', '11', '200.00000000', '1533379635', null, '444.00000000', '100', '2');
INSERT INTO `data_user_score_log` VALUES ('71', '195', 'in', '11', '20.00000000', '1533379850', null, '464.00000000', '100', '2');
INSERT INTO `data_user_score_log` VALUES ('72', '108', 'in', '3', '270.83333340', '1533379970', null, '270.92533340', 't460d9bff59f53018', '1');
INSERT INTO `data_user_score_log` VALUES ('73', '108', 'in', '3', '361.11111120', '1533380109', null, '632.03644460', 't460d9bff59f53018', '1');
INSERT INTO `data_user_score_log` VALUES ('74', '108', 'in', '3', '3881.94444540', '1533535523', null, '4513.98089000', 't460d9bff59f53018', '1');
INSERT INTO `data_user_score_log` VALUES ('75', '108', 'out', '7', '1000.00000000', '1533544531', null, '199000.00000000', 'tx7f16feffeaf2b78e', '2');
INSERT INTO `data_user_score_log` VALUES ('76', '108', 'out', '7', '100.00000000', '1533544543', null, '0.00000000', 'tw4eae243312737863', '4');
INSERT INTO `data_user_score_log` VALUES ('77', '108', 'in', '3', '180.55555560', '1533544744', null, '4694.53644560', 't460d9bff59f53018', '1');
INSERT INTO `data_user_score_log` VALUES ('78', '108', 'out', '7', '100000.00000000', '1533554594', null, '101000.00000000', 't81ea6b86a3e66858', '2');
INSERT INTO `data_user_score_log` VALUES ('79', '108', 'out', '7', '100000.00000000', '1533555857', null, '201000.00000000', 't547ebb65ee41d278', '2');
INSERT INTO `data_user_score_log` VALUES ('80', '108', 'out', '7', '10000.00000000', '1533555863', null, '391000.00000000', 'td779cf44618bafffe', '2');
INSERT INTO `data_user_score_log` VALUES ('81', '108', 'out', '7', '100000.00000000', '1533639326', null, '311000.00000000', 't0931a75e0e3825f1', '2');
INSERT INTO `data_user_score_log` VALUES ('82', '196', 'out', '7', '100.00000000', '1533641773', null, '0.00000000', 'pw827cc18b1acae758', '4');
INSERT INTO `data_user_score_log` VALUES ('83', '198', 'in', '11', '10100000.00000000', '1533646285', null, '10100000.00000000', '模糊', '2');
INSERT INTO `data_user_score_log` VALUES ('84', '198', 'out', '7', '100.00000000', '1533647613', null, '0.00000000', 'tw1322ffc3d559d059', '4');

-- ----------------------------
-- Table structure for data_validcode
-- ----------------------------
DROP TABLE IF EXISTS `data_validcode`;
CREATE TABLE `data_validcode` (
  `codeid` int(11) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(11) COLLATE utf8_unicode_ci NOT NULL COMMENT '手机号',
  `code` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '验证码',
  `expires_in` int(10) DEFAULT NULL COMMENT '过期时间',
  `range` tinyint(6) unsigned DEFAULT '0' COMMENT '验证范围',
  `ip` int(10) NOT NULL DEFAULT '0' COMMENT '客户端IP',
  PRIMARY KEY (`codeid`)
) ENGINE=InnoDB AUTO_INCREMENT=975166 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of data_validcode
-- ----------------------------
INSERT INTO `data_validcode` VALUES ('975118', '13031007801', '6280', '1523068104', '1', '2130706433');
INSERT INTO `data_validcode` VALUES ('975119', '13031007801', '1379', '1523070221', '1', '2130706433');
INSERT INTO `data_validcode` VALUES ('975120', '13031007802', '1479', '1523070784', '1', '2130706433');
INSERT INTO `data_validcode` VALUES ('975121', '13031007803', '0384', '1523071104', '1', '2130706433');
INSERT INTO `data_validcode` VALUES ('975122', '13031007804', '5070', '1523071217', '1', '2130706433');
INSERT INTO `data_validcode` VALUES ('975123', '13031007805', '5051', '1523071302', '1', '2130706433');
INSERT INTO `data_validcode` VALUES ('975124', '13031007805', '8811', '1523071783', '1', '2130706433');
INSERT INTO `data_validcode` VALUES ('975125', '13031007801', '4353', '1524738648', '1', '1875243699');
INSERT INTO `data_validcode` VALUES ('975126', '13269362000', '8401', '1524739514', '1', '1928526127');
INSERT INTO `data_validcode` VALUES ('975127', '13031007801', '5251', '1524739757', '1', '1875243699');
INSERT INTO `data_validcode` VALUES ('975128', '13031007801', '5843', '1524760089', '1', '1875243699');
INSERT INTO `data_validcode` VALUES ('975129', '13888984985', '4280', '1524771135', '1', '30199776');
INSERT INTO `data_validcode` VALUES ('975130', '15223010288', '5875', '1524795807', '1', '1971855058');
INSERT INTO `data_validcode` VALUES ('975131', '13340228886', '7221', '1524800469', '1', '2002134363');
INSERT INTO `data_validcode` VALUES ('975132', '13269362000', '4460', '1524808711', '1', '1033172310');
INSERT INTO `data_validcode` VALUES ('975133', '18500900315', '9328', '1524824245', '1', '1033172055');
INSERT INTO `data_validcode` VALUES ('975134', '13368090901', '3784', '1524854185', '1', '241756714');
INSERT INTO `data_validcode` VALUES ('975135', '13720034015', '8632', '1524884052', '1', '1928896397');
INSERT INTO `data_validcode` VALUES ('975136', '18584665688', '2965', '1524886246', '1', '2073294365');
INSERT INTO `data_validcode` VALUES ('975137', '13110155556', '7514', '1524887028', '1', '1928896397');
INSERT INTO `data_validcode` VALUES ('975138', '18645199945', '0536', '1524898849', '1', '1928526046');
INSERT INTO `data_validcode` VALUES ('975139', '13608779158', '7672', '1524912088', '1', '1971865906');
INSERT INTO `data_validcode` VALUES ('975144', '15210298032', '5940', '1533285443', '1', '0');
INSERT INTO `data_validcode` VALUES ('975145', '15210298032', '7533', '1533285650', '1', '0');
INSERT INTO `data_validcode` VALUES ('975146', '15210298032', '1879', '1533285820', '1', '0');
INSERT INTO `data_validcode` VALUES ('975147', '15210298032', '5212', '1533286990', '1', '0');
INSERT INTO `data_validcode` VALUES ('975148', '15210298032', '4406', '1533287416', '1', '0');
INSERT INTO `data_validcode` VALUES ('975149', '15210298032', '4345', '1533287991', '1', '0');
INSERT INTO `data_validcode` VALUES ('975150', '15901259081', '0998', '1533363280', '3', '0');
INSERT INTO `data_validcode` VALUES ('975151', '15901259081', '7772', '1533363405', '3', '0');
INSERT INTO `data_validcode` VALUES ('975152', '15210298032', '5274', '1533640752', '1', '1928424834');
INSERT INTO `data_validcode` VALUES ('975153', '15210298032', '6503', '1533641861', '1', '1928424834');
INSERT INTO `data_validcode` VALUES ('975154', '13368090901', '5225', '1533645522', '1', '2002066122');
INSERT INTO `data_validcode` VALUES ('975155', '13368090901', '1482', '1533645765', '1', '2002066122');
INSERT INTO `data_validcode` VALUES ('975156', '18005889257', '9905', '1533646001', '1', '605557326');
INSERT INTO `data_validcode` VALUES ('975157', '18005889257', '0431', '1533698536', '1', '605508269');
INSERT INTO `data_validcode` VALUES ('975158', '18005889257', '2374', '1533698691', '1', '605508269');
INSERT INTO `data_validcode` VALUES ('975159', '18005889257', '2708', '1533698841', '1', '605508269');
INSERT INTO `data_validcode` VALUES ('975160', '18005889257', '8212', '1533698967', '1', '605508269');
INSERT INTO `data_validcode` VALUES ('975161', '18005889257', '5174', '1533699109', '1', '605508269');
INSERT INTO `data_validcode` VALUES ('975162', '18005889257', '2514', '1533699227', '1', '605508269');
INSERT INTO `data_validcode` VALUES ('975163', '18005889257', '7074', '1533699356', '1', '605508269');
INSERT INTO `data_validcode` VALUES ('975164', '18005889257', '7226', '1533701694', '1', '605508269');
INSERT INTO `data_validcode` VALUES ('975165', '18005889257', '5894', '1533701779', '1', '605508269');
