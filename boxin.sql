/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : boxin

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2021-11-09 17:48:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for s_advertisement
-- ----------------------------
DROP TABLE IF EXISTS `s_advertisement`;
CREATE TABLE `s_advertisement` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `obj_type` tinyint(4) DEFAULT NULL COMMENT '1=>联盟首页广告位          平台发布\r\n2=>艺人排行广告位          平台发布\r\n3=>经纪公司排行广告位    平台发布\r\n\r\n4=>后援会详情广告位       后援会长发布\r\n5=>艺人详情广告位          后援会长发布\r\n6=>经纪详情广告位          经纪公司发布\r\n\r\n7=>抢单                         平台发布\r\n\r\ntype为1,2,3,7无表',
  `obj_id` int(11) DEFAULT '0' COMMENT '谁的广告位, \r\n根据obj_type内容来的\r\n type为1,2,3,7无表 ,为平台 0\r\n\r\n4 后援会id\r\n5 用户id (明星id)\r\n6 经纪公司id\r\n',
  `user_id` int(11) DEFAULT '0' COMMENT '发布者 0=>平台发布 \r\nobj_type \r\n为 4 时,后援会创建者 id\r\n为 5 时,是后援会(s_star_backup 表)的id\r\n为 6 时,经纪公司创建者 id',
  `stage` tinyint(4) DEFAULT NULL COMMENT '总共4期广告 1=>一期 2=>二期 3=>三期 4=>四期',
  `position` tinyint(4) DEFAULT NULL COMMENT '广告位置 1=>第一  2=>第二  3=>第三',
  `order_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '订单号(订单表)',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '价格',
  `status` tinyint(4) DEFAULT '0' COMMENT '0=>待购买  1=>已购买 2=>过期',
  `start_time` datetime DEFAULT NULL COMMENT '广告开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '广告结束时间',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='发布广告位';

-- ----------------------------
-- Records of s_advertisement
-- ----------------------------
INSERT INTO `s_advertisement` VALUES ('1', '5', '5', '6', '4', '1', '526', '10.00', '1', '2021-10-24 00:00:01', '2021-10-31 23:59:59', '1635916657', '1635323420');
INSERT INTO `s_advertisement` VALUES ('2', '5', '5', '6', '4', '2', 'BX2021102749070', '10.00', '1', '2021-10-24 00:00:00', '2021-10-31 23:59:59', '1635916657', '1635323809');
INSERT INTO `s_advertisement` VALUES ('3', '5', '5', '1', '4', '3', 'BX2021102711565', '10.00', '1', '2021-10-24 00:00:00', '2021-10-31 23:59:59', '1635916657', '1635584701');
INSERT INTO `s_advertisement` VALUES ('4', '5', '5', '6', '3', '1', 'BX2021102778654', '10.00', '0', '2021-10-24 00:00:00', '2021-10-31 23:59:59', '1635916657', '1635325879');
INSERT INTO `s_advertisement` VALUES ('5', '4', '6', '6', '4', '1', 'BX2021102781266', '11.00', '1', '2021-10-01 00:00:00', '2021-10-07 23:59:59', '1635916657', '1635585098');
INSERT INTO `s_advertisement` VALUES ('6', '5', '5', '6', '1', '3', 'BX2021102877959', '10.00', '0', '2021-10-01 00:00:00', '2021-10-07 23:59:59', '1635916657', '1635401417');
INSERT INTO `s_advertisement` VALUES ('7', '4', '6', '1', '1', '3', 'BX2021102866305', '10.00', '0', '2021-10-01 00:00:00', '2021-10-07 23:59:59', '1635916657', '1635401863');
INSERT INTO `s_advertisement` VALUES ('8', '4', '6', '1', '1', '3', 'BX2021102827349', '10.00', '1', '2021-10-01 00:00:00', '2021-10-07 23:59:59', '1635916657', '1635401901');
INSERT INTO `s_advertisement` VALUES ('9', '6', '1', '1', '4', '1', 'BX2021102894919', '10.00', '0', '2021-10-01 00:00:00', '2021-10-07 23:59:59', '1635916657', '1635585419');
INSERT INTO `s_advertisement` VALUES ('10', '6', '1', '1', '1', '2', 'BX2021102899868', '10.00', '0', '2021-10-01 00:00:00', '2021-10-07 23:59:59', '1635916657', '1635411666');
INSERT INTO `s_advertisement` VALUES ('11', '6', '1', '1', '1', '3', 'BX2021102888310', '10.00', '0', '2021-10-01 00:00:00', '2021-10-07 23:59:59', '1635916657', '1635411669');
INSERT INTO `s_advertisement` VALUES ('12', '6', '1', '1', '1', '1', 'BX2021102887237', '10.00', '0', '2021-10-01 00:00:00', '2021-10-07 23:59:59', '1635916657', '1635411671');
INSERT INTO `s_advertisement` VALUES ('13', '6', '1', '1', '4', '2', 'BX2021102868753', '10.00', '0', '2021-10-24 00:00:00', '2021-10-31 23:59:59', '1635916657', '1635411706');
INSERT INTO `s_advertisement` VALUES ('14', '6', '1', '1', '4', '3', 'BX2021102807363', '10.00', '0', '2021-10-24 00:00:00', '2021-10-31 23:59:59', '1635916657', '1635411709');
INSERT INTO `s_advertisement` VALUES ('15', '1', null, '0', null, null, null, '0.00', '0', null, null, '1635916657', null);
INSERT INTO `s_advertisement` VALUES ('16', '4', '1', '1', '1', '3', 'BX2021110485354', '10.00', '0', '2021-11-01 00:00:00', '2021-11-07 23:59:59', '1635995027', '1635995027');
INSERT INTO `s_advertisement` VALUES ('17', '3', '0', '0', '1', '1', null, '10.00', '1', '2021-11-01 00:00:00', '2021-11-07 23:59:59', '1635995027', null);
INSERT INTO `s_advertisement` VALUES ('18', '6', '2', '1', '1', '1', 'BX2021110551581', '10.00', '0', '2021-11-01 00:00:00', '2021-11-07 23:59:59', '1636099358', '1636099358');
INSERT INTO `s_advertisement` VALUES ('19', '6', '2', '1', '1', '2', 'BX2021110570561', '10.00', '0', '2021-11-01 00:00:00', '2021-11-07 23:59:59', '1636099362', '1636099362');
INSERT INTO `s_advertisement` VALUES ('20', '6', '2', '1', '1', '3', 'BX2021110520212', '10.00', '0', '2021-11-01 00:00:00', '2021-11-07 23:59:59', '1636099364', '1636099364');

-- ----------------------------
-- Table structure for s_advertisement_default
-- ----------------------------
DROP TABLE IF EXISTS `s_advertisement_default`;
CREATE TABLE `s_advertisement_default` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '1=>联盟首页广告位    \r\n2=>明星排行广告位   \r\n3=>经纪公司排行广告位    \r\n4=>后援会详情广告位    \r\n5=>明星详情广告位        \r\n6=>经纪详情广告位    \r\n7=>抢单                     \r\n8=>明星详情页背景图     ',
  `img` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '图片链接',
  `jump_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '跳转链接',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='广告默认图';

-- ----------------------------
-- Records of s_advertisement_default
-- ----------------------------
INSERT INTO `s_advertisement_default` VALUES ('1', '联盟首页广告(默认图)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '', null, null);
INSERT INTO `s_advertisement_default` VALUES ('2', '明星排行广告(默认图)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '', null, null);
INSERT INTO `s_advertisement_default` VALUES ('3', '经纪公司排行广告(默认图)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '', null, null);
INSERT INTO `s_advertisement_default` VALUES ('4', '后援会详情广告(默认图)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '', null, null);
INSERT INTO `s_advertisement_default` VALUES ('5', '明星详情广告(默认图)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '', null, null);
INSERT INTO `s_advertisement_default` VALUES ('6', '经纪详情广告(默认图)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '', null, null);
INSERT INTO `s_advertisement_default` VALUES ('7', '抢单(默认图)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '', null, null);
INSERT INTO `s_advertisement_default` VALUES ('8', '明星详情页背景(默认图)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '', null, null);
INSERT INTO `s_advertisement_default` VALUES ('9', '广告位招商(默认图)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '', null, null);

-- ----------------------------
-- Table structure for s_advertisement_examine
-- ----------------------------
DROP TABLE IF EXISTS `s_advertisement_examine`;
CREATE TABLE `s_advertisement_examine` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `a_id` int(11) DEFAULT NULL COMMENT '广告位的id (advertisement 表) 针对那条广告发布的',
  `user_id` int(11) DEFAULT NULL COMMENT '购买广告的商户id(s_business 表)',
  `offer` decimal(10,2) DEFAULT NULL COMMENT '报价  (明星详情广告位,需要)',
  `img` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '上传广告图片链接',
  `jump_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '上传广告跳转网址',
  `status` tinyint(4) DEFAULT '0' COMMENT '0=>待审核 1=>同意(合作) 2=>拒绝(未合作)',
  `is_admin` tinyint(4) DEFAULT '0' COMMENT '后台审核 0=>待审 1=>同意 2=>驳回(给出理由)',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='广告位审核表(发布者审核)';

-- ----------------------------
-- Records of s_advertisement_examine
-- ----------------------------
INSERT INTO `s_advertisement_examine` VALUES ('1', '1', '1', '11.00', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', 'https://www.baidu.com/', '1', '1', '1635323420', '1635323420');
INSERT INTO `s_advertisement_examine` VALUES ('2', '2', '2', '11.00', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', 'https://www.baidu.com/', '1', '0', '1635323420', null);
INSERT INTO `s_advertisement_examine` VALUES ('3', '3', '1', '15.00', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', 'https://www.baidu.com/', '1', '0', '1635323420', '1635584701');
INSERT INTO `s_advertisement_examine` VALUES ('4', '4', '4', '12.00', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', 'https://www.baidu.com/', '2', '0', '1635323420', null);
INSERT INTO `s_advertisement_examine` VALUES ('5', '6', '5', '12.00', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', 'https://www.baidu.com/', '2', '0', '1635323420', null);
INSERT INTO `s_advertisement_examine` VALUES ('6', '5', '1', '15.00', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', 'https://www.baidu.com/', '1', '0', '1635323420', '1635585098');
INSERT INTO `s_advertisement_examine` VALUES ('7', '5', '2', '15.00', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', 'https://www.baidu.com/', '2', '0', '1635323420', null);
INSERT INTO `s_advertisement_examine` VALUES ('8', '8', '1', '15.00', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', 'https://www.baidu.com/', '1', '1', '1635323420', null);
INSERT INTO `s_advertisement_examine` VALUES ('9', '9', '1', '15.00', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', 'https://www.baidu.com/', '1', '0', '1635323420', '1635588353');
INSERT INTO `s_advertisement_examine` VALUES ('10', '9', '2', '15.00', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', 'https://www.baidu.com/', '2', '0', '1635323420', '1635587621');
INSERT INTO `s_advertisement_examine` VALUES ('11', '3', '2', '15.00', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', 'https://www.baidu.com/', '2', '0', '1635323420', null);
INSERT INTO `s_advertisement_examine` VALUES ('12', '17', '1', '15.00', 'uploads/home/img/20211025/4146546546.jpg', 'https://www.baidu.com/123132', '1', '1', null, null);

-- ----------------------------
-- Table structure for s_agreement
-- ----------------------------
DROP TABLE IF EXISTS `s_agreement`;
CREATE TABLE `s_agreement` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='各种协议表';

-- ----------------------------
-- Records of s_agreement
-- ----------------------------
INSERT INTO `s_agreement` VALUES ('1', '用户协议', '<p></p>');
INSERT INTO `s_agreement` VALUES ('2', '隐私协议', '<p></p>');
INSERT INTO `s_agreement` VALUES ('3', '1', '1');
INSERT INTO `s_agreement` VALUES ('4', '4', '4');
INSERT INTO `s_agreement` VALUES ('5', '4', '4');

-- ----------------------------
-- Table structure for s_brokerage_agency
-- ----------------------------
DROP TABLE IF EXISTS `s_brokerage_agency`;
CREATE TABLE `s_brokerage_agency` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id 创建者',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '公司名称',
  `only` int(11) DEFAULT NULL COMMENT 'ID 经纪公司唯一ID',
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '经纪公司头像',
  `people` int(11) DEFAULT '0' COMMENT '艺人数量',
  `introduce` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '公司介绍',
  `notice` text COLLATE utf8_unicode_ci COMMENT '公告 json数据, 最多10个公告',
  `other_logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '平台小标志',
  `other` text COLLATE utf8_unicode_ci COMMENT '经纪公司其他平台链接（最多五个链接） 合成1个json数据\r\n例子',
  `pwd` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '经纪公司内部艺人申请加入密码（或无密码 为 空）',
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '经纪公司联系方式',
  `three_syndromes_in_one` tinyint(4) DEFAULT NULL COMMENT '三证合一 0=>否 1=>是',
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '统一社会信用代码',
  `corporate_charter` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '营业执照-正面',
  `corporate_charter_term` tinyint(4) DEFAULT NULL COMMENT '营业执照期限 0=>无限 1=>有限',
  `corporate_charter_validity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '营业执照的有效期  举例 2021-11-08',
  `education` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '学历照片',
  `work` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '工作证明图片',
  `identity_card_a` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '身份证-正面',
  `identity_card_b` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '身份证-反面',
  `identity_card_term` tinyint(4) DEFAULT NULL COMMENT '身份证期限 0=>无限 1=>有限',
  `identity_card_validity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '身份证的有效期  举例 2021-11-08',
  `resident_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '入驻人姓名',
  `identity_card` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '身份证号',
  `status` tinyint(4) DEFAULT '0' COMMENT '0=>待审 1=>成功 2=>失败',
  `is_display` tinyint(4) DEFAULT '1' COMMENT '0=>隐藏 1=>展示',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='经纪公司表';

-- ----------------------------
-- Records of s_brokerage_agency
-- ----------------------------
INSERT INTO `s_brokerage_agency` VALUES ('1', '9', '鹏飞经纪公司', '13123123', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '0', '<p>啦啦啦啦,</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', '328.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', 'lk32l32', '18332255366', null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '1', null, '1636104271');
INSERT INTO `s_brokerage_agency` VALUES ('2', '10', '宏图经纪公司', '4841326', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '0', '<p>公司介绍</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', '', '18332255366', null, '', '', null, '', null, null, '', '', null, '', '', '', '1', '1', null, null);

-- ----------------------------
-- Table structure for s_brokerage_agency_member
-- ----------------------------
DROP TABLE IF EXISTS `s_brokerage_agency_member`;
CREATE TABLE `s_brokerage_agency_member` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `b_id` int(11) DEFAULT NULL COMMENT '经纪公司id(s_brokerage_agency 表)',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id(明星id)',
  `type` tinyint(4) DEFAULT NULL COMMENT '1=>内艺人 2=>外艺人   (明星)',
  `status` tinyint(4) DEFAULT '0' COMMENT '0=>待审核 1=>已同意 2=>未同意',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `b_id` (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='经纪公司艺人成员表';

-- ----------------------------
-- Records of s_brokerage_agency_member
-- ----------------------------
INSERT INTO `s_brokerage_agency_member` VALUES ('1', '1', '1', '2', '1', '1635696000', '1636095629');
INSERT INTO `s_brokerage_agency_member` VALUES ('2', '1', '5', '2', '1', '1635696000', '1636092877');
INSERT INTO `s_brokerage_agency_member` VALUES ('3', '1', '6', '1', '2', '1635696000', '1636093067');
INSERT INTO `s_brokerage_agency_member` VALUES ('4', '1', '2', '1', '2', '1636110737', '1636110737');
INSERT INTO `s_brokerage_agency_member` VALUES ('5', '1', '2', '2', '2', '1636110762', '1636110762');
INSERT INTO `s_brokerage_agency_member` VALUES ('6', '1', '2', '1', '2', '1636113620', '1636113620');
INSERT INTO `s_brokerage_agency_member` VALUES ('8', '2', '2', '2', '0', '1636190446', '1636190446');
INSERT INTO `s_brokerage_agency_member` VALUES ('9', '1', '2', '2', '2', '1636190580', '1636190580');
INSERT INTO `s_brokerage_agency_member` VALUES ('10', '1', '2', '2', '1', '1636190633', '1636193819');
INSERT INTO `s_brokerage_agency_member` VALUES ('11', '1', '2', '1', '0', '1636190654', '1636193830');
INSERT INTO `s_brokerage_agency_member` VALUES ('12', '2', '1', '1', '2', null, null);

-- ----------------------------
-- Table structure for s_business
-- ----------------------------
DROP TABLE IF EXISTS `s_business`;
CREATE TABLE `s_business` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `b_id` int(11) DEFAULT NULL COMMENT '商家经营类别id(s_commodity_class 表 一级分类)',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '店铺名称',
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '店铺 logo',
  `only` int(11) DEFAULT NULL COMMENT '店铺的唯一id',
  `class` tinyint(4) DEFAULT NULL COMMENT '店铺分类: 1=>个体工商户店 2=>普通企业店',
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '店铺类别:1=>线上商家 2=>线下商家',
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '店铺地址 xx省-xx市-xx区(县)',
  `three_syndromes_in_one` tinyint(4) DEFAULT NULL COMMENT '三证合一 0=>否 1=>是',
  `corporate_charter` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '营业执照-正面',
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '统一社会信用代码',
  `corporate_charter_term` tinyint(4) DEFAULT NULL COMMENT '营业执照期限 0=>无限 1=>有限',
  `corporate_charter_validity` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '营业执照的有效期  举例 2021-11-08',
  `identity_card_a` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '身份证-正面',
  `identity_card_b` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '身份证-反面',
  `identity_card_term` tinyint(4) DEFAULT NULL COMMENT '身份证期限 0=>无限 1=>有限',
  `identity_card_validity` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '身份证的有效期  举例 2021-11-08',
  `resident_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '入驻人姓名',
  `identity_card` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '身份证号',
  `card_num` int(11) DEFAULT NULL COMMENT '本商铺联盟卡使用次数',
  `goods_num` int(11) DEFAULT '0' COMMENT '商品数量',
  `settled_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '入驻人手机号',
  `after_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '售后电话  3个电话,逗号隔开 ',
  `status` tinyint(4) DEFAULT '0' COMMENT '商家审核: 0=>待审 1=>成功 2=>失败',
  `fail_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '失败理由',
  `is_display` tinyint(4) DEFAULT '1' COMMENT '后台操作,商家显示 1=>显示  0=>不显示',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='b 端 店铺表';

-- ----------------------------
-- Records of s_business
-- ----------------------------
INSERT INTO `s_business` VALUES ('1', '1', '3', '天天', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '1235456', '1', '1', '河北省石家庄市裕华区xx街xxx号', null, null, null, null, null, null, null, null, null, null, null, '2', '1000', null, '[65331395,53650153,54913833]', null, '', '1', null, null);
INSERT INTO `s_business` VALUES ('2', '2', '3', '哈哈', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '79799879', '1', '1', '河北省石家庄市裕华区xx街xxx号', null, null, null, null, null, null, null, null, null, null, null, '2', '1000', null, '[65331395,53650153,54913833]', null, '', '1', null, null);
INSERT INTO `s_business` VALUES ('3', '3', '6', '周日日小卖铺', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '79799812', '1', '2', '河北省石家庄市裕华区xx街xxx号', null, null, null, null, null, null, null, null, null, null, null, '2', '1000', null, '[65331395,53650153,54913833]', null, '', '1', null, null);
INSERT INTO `s_business` VALUES ('4', '4', '7', '离别天小卖铺', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '79799813', '1', '2', '河北省石家庄市裕华区xx街xxx号', null, null, null, null, null, null, null, null, null, null, null, '2', '1000', null, '[65331395,53650153,54913833]', null, '', '1', null, null);
INSERT INTO `s_business` VALUES ('5', '5', '1', '收到小卖铺', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '79799814', '1', '1', '北京市长安区xx街xx号', null, null, null, null, null, null, null, null, null, null, null, '2', '1000', null, '[65331395,53650153,54913833]', null, '', '1', null, null);
INSERT INTO `s_business` VALUES ('6', '6', '2', '王老师小卖铺', 'FsFERvbw47mezL241SwvGobjGuna', '79799816', '1', '2', '北京市哈哈区xx街xx号', null, null, null, null, null, null, null, null, null, null, null, '2', '1000', null, '[65331395,53650153,54913833]', null, '', '1', null, null);
INSERT INTO `s_business` VALUES ('7', '7', '5', '是否小卖铺', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '79799817', '1', '2', '河北省石家庄市裕华区xx街xxx号', null, null, null, null, null, null, null, null, null, null, null, '2', '1000', null, '[65331395,53650153,54913833]', null, '', '1', null, null);
INSERT INTO `s_business` VALUES ('8', '8', '6', '周第d天小卖铺', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '79799818', '1', '2', '河北省石家庄市裕华区xx街xxx号', null, null, null, null, null, null, null, null, null, null, null, '2', '1000', null, '[65331395,53650153,54913833]', null, '', '1', null, null);
INSERT INTO `s_business` VALUES ('9', '9', '4', '周第a天小卖铺', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '79799819', '1', '1', '河北省石家庄市裕华区xx街xxx号', null, null, null, null, null, null, null, null, null, null, null, '2', '1000', null, '[65331395,53650153,54913833]', null, '', '1', null, null);
INSERT INTO `s_business` VALUES ('10', '10', '5', '周第b天小卖铺', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '79799820', '1', '1', '河北省石家庄市裕华区xx街xxx号', null, null, null, null, null, null, null, null, null, null, null, '2', '1000', null, '[65331395,53650153,54913833]', null, '', '1', null, null);
INSERT INTO `s_business` VALUES ('11', '11', '2', '周第c天小卖铺', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '79799821', '1', '1', '河北省石家庄市裕华区xx街xxx号', null, null, null, null, null, null, null, null, null, null, null, '2', '1000', null, '[65331395,53650153,54913833]', null, '', '1', null, null);
INSERT INTO `s_business` VALUES ('12', '12', '6', '周第d天小卖铺', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '79799822', '1', '2', '河北省石家庄市裕华区xx街xxx号', null, null, null, null, null, null, null, null, null, null, null, '2', '1000', null, '[65331395,53650153,54913833]', null, '', '1', null, null);
INSERT INTO `s_business` VALUES ('13', '13', '7', '周第e天小卖铺', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '79799823', '1', '2', '河北省石家庄市裕华区xx街xxx号', null, null, null, null, null, null, null, null, null, null, null, '2', '1000', null, '[65331395,53650153,54913833]', null, '', '1', null, null);
INSERT INTO `s_business` VALUES ('14', '14', '1', '周第g天小卖铺', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '79799824', '1', '1', '河北省石家庄市裕华区xx街xxx号', null, null, null, null, null, null, null, null, null, null, null, '2', '1000', null, '[65331395,53650153,54913833]', null, '', '1', null, null);
INSERT INTO `s_business` VALUES ('15', '15', '7', '周第h天小卖铺', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '79799825', '1', '2', '河北省石家庄市裕华区xx街xxx号', null, null, null, null, null, null, null, null, null, null, null, '2', '1000', null, '[65331395,53650153,54913833]', null, '', '1', null, null);

-- ----------------------------
-- Table structure for s_business_card_num
-- ----------------------------
DROP TABLE IF EXISTS `s_business_card_num`;
CREATE TABLE `s_business_card_num` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `b_id` int(11) DEFAULT NULL COMMENT '商家 id(s_business 表)',
  `number` int(11) DEFAULT '0' COMMENT '用户在某个商家消费的联盟卡次数',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `b_id` (`b_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户在商家消费的联盟卡次数记录';

-- ----------------------------
-- Records of s_business_card_num
-- ----------------------------

-- ----------------------------
-- Table structure for s_business_cooperation
-- ----------------------------
DROP TABLE IF EXISTS `s_business_cooperation`;
CREATE TABLE `s_business_cooperation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `obj_type` tinyint(4) DEFAULT NULL COMMENT '1=>针对明星的 \r\n2=>针对后援会的 \r\n3=>针对经纪公司的 \r\n4=>针对平台的,后台管理查看',
  `obj_id` int(11) DEFAULT NULL COMMENT '根据obj_type 来的 : 明星id/后援会id/经纪公司id\r\n\r\nobj_type 为4时 是 0',
  `company` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '公司名称',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '联系人',
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '电话',
  `content` text COLLATE utf8_unicode_ci COMMENT '合作内容',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='商务合作';

-- ----------------------------
-- Records of s_business_cooperation
-- ----------------------------
INSERT INTO `s_business_cooperation` VALUES ('1', '1', '1', '32公司', '32搜索搜索', '18332255387', '<p>1231414143421</p>', '1635226518', '1635226518');
INSERT INTO `s_business_cooperation` VALUES ('2', '1', '1', '小小系哦啊公司', '小小系哦啊', '18332255387', '<p>1231414143421</p>', '1635226613', '1635226613');
INSERT INTO `s_business_cooperation` VALUES ('3', '1', '1', '32公司', '32', '18332255387', '<p>1231414143421</p>', '1635226870', '1635226870');
INSERT INTO `s_business_cooperation` VALUES ('4', '2', '1', '32公司', '32', '18332255387', '<p>1231414143421</p>', '1635226873', '1635226873');
INSERT INTO `s_business_cooperation` VALUES ('5', '2', '6', '32公司', '32', '18332255387', '<p>1231414143421</p>', '1635227129', '1635227129');
INSERT INTO `s_business_cooperation` VALUES ('6', '1', '2', '32123124公司', '32123', '18332255387', '<p>1231414143421</p>', '1635227168', '1635227168');
INSERT INTO `s_business_cooperation` VALUES ('7', '3', '1', '32123124公司', '32123', '18332255387', '<p>1231414143421</p>', '1635297016', '1635297016');
INSERT INTO `s_business_cooperation` VALUES ('8', '3', '1', '32123124公司', '32123', '18332255387', '<p>1231414143421</p>', '1635297116', '1635297116');
INSERT INTO `s_business_cooperation` VALUES ('9', '3', '1', '32123124公司', '32123', '18332255387', '<p>1231414143421</p>', '1635297125', '1635297125');
INSERT INTO `s_business_cooperation` VALUES ('10', '3', '1', '32123124公司', '32123', '18332255387', '<p>1231414143421</p>', '1635297129', '1635297129');
INSERT INTO `s_business_cooperation` VALUES ('11', '4', '0', '32123124公司', '32123', '18332255387', '<p>1少时诵诗书3421</p>', '1635846767', '1635846767');
INSERT INTO `s_business_cooperation` VALUES ('12', '3', '1', '局举报', '32123', '18332255387', '<p>1少时诵诗书3421</p>', '1636107266', '1636107266');

-- ----------------------------
-- Table structure for s_ceshi
-- ----------------------------
DROP TABLE IF EXISTS `s_ceshi`;
CREATE TABLE `s_ceshi` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='测试的.废弃的--------------------------------';

-- ----------------------------
-- Records of s_ceshi
-- ----------------------------
INSERT INTO `s_ceshi` VALUES ('1', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]');
INSERT INTO `s_ceshi` VALUES ('2', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]');
INSERT INTO `s_ceshi` VALUES ('3', '[1,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8,9,2,3,4]');
INSERT INTO `s_ceshi` VALUES ('4', '[1,2,3]');
INSERT INTO `s_ceshi` VALUES ('16', '[1,2,32]');
INSERT INTO `s_ceshi` VALUES ('17', '[{\"logo\":\"https:\\/\\/alifei04.cfp.cn\\/creative\\/vcg\\/veer\\/1600water\\/veer-305055283.jpg\",\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"logo\":\"https:\\/\\/alifei04.cfp.cn\\/creative\\/vcg\\/veer\\/1600water\\/veer-305055283.jpg\",\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"logo\":\"https:\\/\\/alifei04.cfp.cn\\/creative\\/vcg\\/veer\\/1600water\\/veer-305055283.jpg\",\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"logo\":\"https:\\/\\/alifei04.cfp.cn\\/creative\\/vcg\\/veer\\/1600water\\/veer-305055283.jpg\",\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]');

-- ----------------------------
-- Table structure for s_commodity
-- ----------------------------
DROP TABLE IF EXISTS `s_commodity`;
CREATE TABLE `s_commodity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `b_id` int(11) NOT NULL COMMENT '商家id(s_business 表)',
  `c_id` int(11) NOT NULL COMMENT '商品分类 (s_commodity_class表)',
  `only` int(11) NOT NULL COMMENT '商品的唯一ID',
  `type` tinyint(4) DEFAULT NULL COMMENT '商品 1=>线上 2=>线下',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '商品标题',
  `title_img` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '商品标题,图片 5个图片合1个json',
  `details` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '商品详情,图片 5个图片合1个json',
  `original_price` decimal(10,2) NOT NULL COMMENT '原有价格',
  `favorable_price` decimal(10,2) NOT NULL COMMENT '优惠价格',
  `stock` int(255) NOT NULL COMMENT '库存',
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '网址',
  `api_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '商品api接口 线上 才有这个 (s_commodity_api 表 id 解释待定)',
  `status` tinyint(4) DEFAULT '0' COMMENT '0=>审核中  1=>审核通过 2=>审核失败',
  `fail_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '失败理由',
  `is_display` tinyint(4) DEFAULT '1' COMMENT '0=>不显示 1=>显示',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='商品表,其它表的商品都以它来演变';

-- ----------------------------
-- Records of s_commodity
-- ----------------------------
INSERT INTO `s_commodity` VALUES ('1', '1', '1', '12113456', '1', '四五六一', '[ \"uploads/img/20211020/d3a7ec20399f46ce3913f9f2f64c7e4a.jpeg\", \"uploads/img/20211020/d3a7ec20399f46ce3913f9f2f64c7e4a.jpeg\", \"uploads/img/20211020/d3a7ec20399f46ce3913f9f2f64c7e4a.jpeg\"]', '[ \"uploads/img/20211020/d3a7ec20399f46ce3913f9f2f64c7e4a.jpeg\", \"uploads/img/20211020/d3a7ec20399f46ce3913f9f2f64c7e4a.jpeg\", \"uploads/img/20211020/d3a7ec20399f46ce3913f9f2f64c7e4a.jpeg\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity` VALUES ('2', '2', '1', '12345612', '1', '四五六二', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity` VALUES ('3', '1', '1', '12345613', '1', '四五六三', '[ \"https://img0.baidu.com/it/u=3122136587,3938996930&fm=26&fmt=auto\", \"https://img0.baidu.com/it/u=3122136587,3938996930&fm=26&fmt=auto\", \"https://img0.baidu.com/it/u=3122136587,3938996930&fm=26&fmt=auto\"]', '[ \"https://img0.baidu.com/it/u=3122136587,3938996930&fm=26&fmt=auto\", \"https://img0.baidu.com/it/u=3122136587,3938996930&fm=26&fmt=auto\", \"https://img0.baidu.com/it/u=3122136587,3938996930&fm=26&fmt=auto\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity` VALUES ('4', '1', '1', '12345614', '1', '四五六七', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity` VALUES ('5', '1', '2', '12345615', '1', '四五六七', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity` VALUES ('6', '2', '2', '12345616', '1', '四五六七', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity` VALUES ('7', '2', '2', '12345617', '1', '四五六八', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity` VALUES ('8', '2', '3', '12345618', '1', '四五六八', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity` VALUES ('9', '3', '3', '12345619', '2', '四五六九一', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity` VALUES ('10', '5', '1', '12345620', '1', '四五六九二', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity` VALUES ('11', '5', '3', '12345621', '1', '四五六九三', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity` VALUES ('12', '5', '3', '12345622', '1', '四五六九四', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity` VALUES ('13', '6', '1', '12345623', '1', '四五六九五', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity` VALUES ('14', '15', '1', '12345624', '1', '四五六九六', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);

-- ----------------------------
-- Table structure for s_commodity_api
-- ----------------------------
DROP TABLE IF EXISTS `s_commodity_api`;
CREATE TABLE `s_commodity_api` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'api 的名字',
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'api的图片',
  `link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '链接',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='商品来源api表';

-- ----------------------------
-- Records of s_commodity_api
-- ----------------------------

-- ----------------------------
-- Table structure for s_commodity_api_swap
-- ----------------------------
DROP TABLE IF EXISTS `s_commodity_api_swap`;
CREATE TABLE `s_commodity_api_swap` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `e_commerce_platform` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '电商品台',
  `u_only` int(11) DEFAULT NULL COMMENT '用户的only',
  `b_only` int(11) DEFAULT NULL COMMENT '商家的only(s_business 表)  ',
  `order_no` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '下单记录编号',
  `order_time` int(11) DEFAULT NULL COMMENT '下单时间',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '商品标题',
  `other_order_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '其它电商平台的订单号',
  `number` int(11) DEFAULT NULL COMMENT '购买商品数量',
  `contrast` tinyint(4) DEFAULT '1' COMMENT '对比次数   1=>未对比  0=>已对比',
  `status` tinyint(4) DEFAULT '0' COMMENT '0=>平台判断\r\n1=>商家待审\r\n2=>同意返利 \r\n3=>拒绝返利',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='商品api掉包审核';

-- ----------------------------
-- Records of s_commodity_api_swap
-- ----------------------------

-- ----------------------------
-- Table structure for s_commodity_class
-- ----------------------------
DROP TABLE IF EXISTS `s_commodity_class`;
CREATE TABLE `s_commodity_class` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '共3级',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '标题',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='商品分类';

-- ----------------------------
-- Records of s_commodity_class
-- ----------------------------
INSERT INTO `s_commodity_class` VALUES ('1', '0', '家具生活', null, null);
INSERT INTO `s_commodity_class` VALUES ('2', '0', '数码电器', null, null);
INSERT INTO `s_commodity_class` VALUES ('3', '0', '美妆', null, null);
INSERT INTO `s_commodity_class` VALUES ('4', '0', '电影', null, null);
INSERT INTO `s_commodity_class` VALUES ('5', '0', '五金', null, null);
INSERT INTO `s_commodity_class` VALUES ('6', '0', '保健', null, null);

-- ----------------------------
-- Table structure for s_commodity_jump_log
-- ----------------------------
DROP TABLE IF EXISTS `s_commodity_jump_log`;
CREATE TABLE `s_commodity_jump_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '跳转的用户id',
  `c_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '从那个商品跳转id (s_commodity )',
  `api_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '电商品台,商品api接口 线上 才有这个 (s_commodity_api 表 id)',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户商品跳转记录';

-- ----------------------------
-- Records of s_commodity_jump_log
-- ----------------------------

-- ----------------------------
-- Table structure for s_commodity_rebate_log
-- ----------------------------
DROP TABLE IF EXISTS `s_commodity_rebate_log`;
CREATE TABLE `s_commodity_rebate_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `b_id` int(11) DEFAULT NULL COMMENT '商家id(s_business 表)',
  `c_id` int(11) DEFAULT NULL COMMENT '商品id(s_commodity 表)',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `order_no` int(11) DEFAULT NULL COMMENT '订单号',
  `money` decimal(10,2) DEFAULT NULL COMMENT '钱',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='购买商品返利记录';

-- ----------------------------
-- Records of s_commodity_rebate_log
-- ----------------------------

-- ----------------------------
-- Table structure for s_commodity_temp
-- ----------------------------
DROP TABLE IF EXISTS `s_commodity_temp`;
CREATE TABLE `s_commodity_temp` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `b_id` int(11) NOT NULL COMMENT '商家id(s_business 表)',
  `c_id` int(11) NOT NULL COMMENT '商品分类 (s_commodity_class表)',
  `only` int(11) NOT NULL COMMENT '商品的唯一ID',
  `type` tinyint(4) DEFAULT NULL COMMENT '商品 1=>线上 2=>线下',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '商品标题',
  `title_img` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '商品标题,图片 5个图片合1个json',
  `details` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '商品详情,图片 5个图片合1个json',
  `original_price` decimal(10,2) NOT NULL COMMENT '原有价格',
  `favorable_price` decimal(10,2) NOT NULL COMMENT '优惠价格',
  `stock` int(255) NOT NULL COMMENT '库存',
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '网址',
  `api_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '商品api接口 线上 才有这个 (s_commodity_api 表 id 解释待定)',
  `status` tinyint(4) DEFAULT '0' COMMENT '0=>审核中  1=>审核通过 2=>审核失败',
  `fail_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '失败理由',
  `is_display` tinyint(4) DEFAULT '1' COMMENT '0=>不显示 1=>显示',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='临时商品库表';

-- ----------------------------
-- Records of s_commodity_temp
-- ----------------------------
INSERT INTO `s_commodity_temp` VALUES ('1', '1', '1', '12113456', '1', '四五六一', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity_temp` VALUES ('2', '2', '1', '12345612', '1', '四五六二', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity_temp` VALUES ('3', '1', '1', '12345613', '1', '四五六三', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity_temp` VALUES ('4', '1', '1', '12345614', '1', '四五六七', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity_temp` VALUES ('5', '1', '2', '12345615', '1', '四五六七', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity_temp` VALUES ('6', '2', '2', '12345616', '1', '四五六七', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity_temp` VALUES ('7', '2', '2', '12345617', '1', '四五六八', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity_temp` VALUES ('8', '2', '3', '12345618', '1', '四五六八', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity_temp` VALUES ('9', '3', '3', '12345619', '2', '四五六九一', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity_temp` VALUES ('10', '5', '1', '12345620', '1', '四五六九二', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity_temp` VALUES ('11', '5', '3', '12345621', '1', '四五六九三', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);
INSERT INTO `s_commodity_temp` VALUES ('12', '5', '3', '12345622', '1', '四五六九四', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '100.00', '75.00', '100', null, null, '1', null, '1', null, null);

-- ----------------------------
-- Table structure for s_divide_ad
-- ----------------------------
DROP TABLE IF EXISTS `s_divide_ad`;
CREATE TABLE `s_divide_ad` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) DEFAULT NULL COMMENT '4=>后援会分成 5=>明星详情页分成  6=>经纪公司广告费',
  `month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '产生广告费的月份',
  `star_id` int(11) DEFAULT NULL COMMENT '明星的id',
  `b_id` int(11) DEFAULT NULL COMMENT '后援会id  分成后援会, 会长',
  `ba_id` int(11) DEFAULT NULL COMMENT '经纪公司id,只针对type 为6',
  `money` decimal(10,2) DEFAULT '0.00' COMMENT '广告费用(当前月份总费用)',
  `status` tinyint(4) DEFAULT '0' COMMENT '0=>未分配 1=>已分配',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='分成 - 广告费保存表';

-- ----------------------------
-- Records of s_divide_ad
-- ----------------------------
INSERT INTO `s_divide_ad` VALUES ('1', '4', '2021/10', '8', '1', null, '15.00', '0', '1635583003', '1635583003');
INSERT INTO `s_divide_ad` VALUES ('2', '5', '2021/10', '5', '1', null, '15.00', '0', '1635584701', '1635584701');
INSERT INTO `s_divide_ad` VALUES ('3', '4', '2021/10', '5', '6', null, '15.00', '0', '1635585098', '1635585098');
INSERT INTO `s_divide_ad` VALUES ('4', '6', '2021/10', null, null, '1', '30.00', '0', '1635585269', '1635585269');

-- ----------------------------
-- Table structure for s_divide_union_card
-- ----------------------------
DROP TABLE IF EXISTS `s_divide_union_card`;
CREATE TABLE `s_divide_union_card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `un_id` int(11) DEFAULT NULL COMMENT '联盟id',
  `money` decimal(10,2) DEFAULT '0.00' COMMENT '分成',
  `status` tinyint(4) DEFAULT '0' COMMENT '0=>为分成 1=>已分成',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='分成 - 推广联盟卡的';

-- ----------------------------
-- Records of s_divide_union_card
-- ----------------------------

-- ----------------------------
-- Table structure for s_money_log
-- ----------------------------
DROP TABLE IF EXISTS `s_money_log`;
CREATE TABLE `s_money_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `order_id` int(11) DEFAULT NULL COMMENT '订单id',
  `type` tinyint(4) DEFAULT NULL COMMENT '1=>c 端用户记录 2=>b 端用户记录',
  `money` decimal(10,2) DEFAULT NULL COMMENT '消费的金额',
  `balance` decimal(10,2) DEFAULT '0.00' COMMENT '剩余余额(包含余额,冻结金,促销预付金)',
  `money_type` tinyint(4) DEFAULT NULL COMMENT '1=>余额 2=>冻结金 3=>预付金',
  `order_type` tinyint(4) DEFAULT NULL COMMENT '资金类型 money_type 不展示给用户\r\n1.充值\r\n2.提现\r\n3.购买联盟卡\r\n4.联盟卡分成\r\n5.会员充值\r\n6.抢单资格\r\n7.商品订单\r\n8.购买广告位\r\n9.预付金划转\r\n10.后援会广告分红\r\n11.明星详情页广告分红',
  `operation` tinyint(4) DEFAULT NULL COMMENT 'money 前的加减号 0=>- 1=>+   前端识别用0=>绿色 1=>红色',
  `describe` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '描述',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `type` (`type`),
  KEY `money_type` (`money_type`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='消费记录表';

-- ----------------------------
-- Records of s_money_log
-- ----------------------------
INSERT INTO `s_money_log` VALUES ('1', '1', '10', '2', '15.00', '85.00', '1', '8', '0', '购买广告位(拒绝)', null, null);
INSERT INTO `s_money_log` VALUES ('2', '1', '10', '2', '15.00', '15.00', '2', '8', '1', '购买广告', null, null);
INSERT INTO `s_money_log` VALUES ('3', '2', '10', '2', '15.00', '85.00', '1', '8', '0', '购买广告位(待审核)', null, null);
INSERT INTO `s_money_log` VALUES ('4', '2', '10', '2', '15.00', '15.00', '2', '8', '1', '购买广告', null, null);
INSERT INTO `s_money_log` VALUES ('55', '1', '10', '2', '15.00', '0.00', '2', '8', '0', '退还广告费', '1635588288', '1635588288');
INSERT INTO `s_money_log` VALUES ('56', '1', '10', '2', '15.00', '100.00', '1', '8', '1', '退还广告费', '1635588288', null);
INSERT INTO `s_money_log` VALUES ('57', '1', '10', '2', '15.00', '85.00', '1', '8', '0', '购买广告位(拒绝)', null, null);
INSERT INTO `s_money_log` VALUES ('58', '1', '10', '2', '15.00', '15.00', '2', '8', '1', '购买广告', null, null);
INSERT INTO `s_money_log` VALUES ('59', '1', '10', '2', '15.00', '0.00', '2', '8', '0', '退还广告费', '1635588354', '1635588354');
INSERT INTO `s_money_log` VALUES ('60', '1', '10', '2', '15.00', '100.00', '1', '8', '1', '退还广告费', '1635588354', null);
INSERT INTO `s_money_log` VALUES ('61', '1', '1', '1', '100.00', '100.00', '1', '1', '1', '余额充值', '1635916657', null);
INSERT INTO `s_money_log` VALUES ('62', '1', '2', '1', '10.00', '90.00', '1', '2', '0', '发布消息', '1635916657', null);

-- ----------------------------
-- Table structure for s_notice_backup
-- ----------------------------
DROP TABLE IF EXISTS `s_notice_backup`;
CREATE TABLE `s_notice_backup` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_id` int(11) NOT NULL COMMENT '后援会的id',
  `content` text COLLATE utf8_unicode_ci NOT NULL COMMENT '内容',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='c 端 通知-后援会消息表';

-- ----------------------------
-- Records of s_notice_backup
-- ----------------------------

-- ----------------------------
-- Table structure for s_notice_business
-- ----------------------------
DROP TABLE IF EXISTS `s_notice_business`;
CREATE TABLE `s_notice_business` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL COMMENT '1=>c 端看 2=> b 端看',
  `b_id` int(11) NOT NULL COMMENT '店铺id(s_business 表)',
  `content` text COLLATE utf8_unicode_ci NOT NULL COMMENT '内容',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='c b 端 通知-店铺消息表';

-- ----------------------------
-- Records of s_notice_business
-- ----------------------------

-- ----------------------------
-- Table structure for s_notice_news
-- ----------------------------
DROP TABLE IF EXISTS `s_notice_news`;
CREATE TABLE `s_notice_news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL COMMENT '后台发布的 ,  1=> c 端  2=> b 端',
  `class` tinyint(4) DEFAULT '0' COMMENT '0=>平台发布的(b,c端,所有人接受) 1=>经纪公司发布(c 端) 2=>艺人(c 端)  3=>指针对1个用户的',
  `user_id` int(11) DEFAULT '0' COMMENT '发布者 : 0=>平台发布\r\n非0=>经纪公司,艺人发布的\r\n针对一个用户的通知也是0',
  `to_user_id` int(11) DEFAULT NULL COMMENT '只针对1个用户通知',
  `content` text COLLATE utf8_unicode_ci NOT NULL COMMENT '内容',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='c b 端 通知-重要消息表';

-- ----------------------------
-- Records of s_notice_news
-- ----------------------------
INSERT INTO `s_notice_news` VALUES ('8', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【玲珑是否】明星详情页广告位，发布者已同意，广告费将从冻结金减去。</p>', '1634973894', '1634973894');
INSERT INTO `s_notice_news` VALUES ('9', '2', '3', '0', '2', '<p>尊敬的用户您申请购买的【玲珑是否】明星详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1634973894', null);
INSERT INTO `s_notice_news` VALUES ('10', '2', '3', '0', '3', '<p>尊敬的用户您申请购买的【玲珑是否】明星详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1634973895', null);
INSERT INTO `s_notice_news` VALUES ('11', '2', '3', '0', '4', '<p>尊敬的用户您申请购买的【玲珑是否】明星详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1634973895', null);
INSERT INTO `s_notice_news` VALUES ('12', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【玲珑是否】明星详情页广告位，发布者已同意，广告费将从冻结金减去。</p>', '1635306168', '1635306168');
INSERT INTO `s_notice_news` VALUES ('13', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【石玲珑】明星详情页广告位，发布者已同意，广告费将从冻结金减去。</p>', '1635323420', '1635323420');
INSERT INTO `s_notice_news` VALUES ('14', '2', '3', '0', '2', '<p>尊敬的用户您申请购买的【石玲珑】明星详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1635323421', null);
INSERT INTO `s_notice_news` VALUES ('15', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【石玲珑】明星详情页广告位，发布者已同意，广告费将从冻结金减去。</p>', '1635323810', '1635323810');
INSERT INTO `s_notice_news` VALUES ('16', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【蔡徐坤高后援会】后援会详情页广告位，发布者已同意，广告费将从冻结金减去。</p>', '1635583003', '1635583003');
INSERT INTO `s_notice_news` VALUES ('17', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【蔡徐坤高后援会】后援会详情页广告位，发布者已同意，广告费将从冻结金减去。</p>', '1635583362', '1635583362');
INSERT INTO `s_notice_news` VALUES ('18', '2', '3', '0', '2', '<p>尊敬的用户您申请购买的【蔡徐坤高后援会】后援会详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1635583362', null);
INSERT INTO `s_notice_news` VALUES ('19', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【蔡徐坤高后援会】后援会详情页广告位，发布者已同意，广告费将从冻结金减去。</p>', '1635583685', '1635583685');
INSERT INTO `s_notice_news` VALUES ('20', '2', '3', '0', '2', '<p>尊敬的用户您申请购买的【蔡徐坤高后援会】后援会详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1635583685', null);
INSERT INTO `s_notice_news` VALUES ('21', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【石玲珑】明星详情页广告位，发布者已同意，广告费将从冻结金减去。</p>', '1635584701', '1635584701');
INSERT INTO `s_notice_news` VALUES ('22', '2', '3', '0', '2', '<p>尊敬的用户您申请购买的【石玲珑】明星详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1635584702', null);
INSERT INTO `s_notice_news` VALUES ('23', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【蔡徐坤高后援会】后援会详情页广告位，发布者已同意，广告费将从冻结金减去。</p>', '1635585098', '1635585098');
INSERT INTO `s_notice_news` VALUES ('24', '2', '3', '0', '2', '<p>尊敬的用户您申请购买的【蔡徐坤高后援会】后援会详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1635585099', null);
INSERT INTO `s_notice_news` VALUES ('25', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【鹏飞经纪公司】经纪公司详情页广告位，发布者已同意，广告费将从冻结金减去。</p>', '1635585269', '1635585269');
INSERT INTO `s_notice_news` VALUES ('26', '2', '3', '0', '2', '<p>尊敬的用户您申请购买的【鹏飞经纪公司】经纪公司详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1635585270', null);
INSERT INTO `s_notice_news` VALUES ('27', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【鹏飞经纪公司】经纪公司详情页广告位，发布者已同意，广告费将从冻结金减去。</p>', '1635585419', '1635585419');
INSERT INTO `s_notice_news` VALUES ('28', '2', '3', '0', '2', '<p>尊敬的用户您申请购买的【鹏飞经纪公司】经纪公司详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1635585420', null);
INSERT INTO `s_notice_news` VALUES ('29', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【鹏飞经纪公司】经纪公司详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1635587520', '1635587520');
INSERT INTO `s_notice_news` VALUES ('30', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【鹏飞经纪公司】经纪公司详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1635587547', '1635587547');
INSERT INTO `s_notice_news` VALUES ('31', '2', '3', '0', '2', '<p>尊敬的用户您申请购买的【鹏飞经纪公司】经纪公司详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1635587621', '1635587621');
INSERT INTO `s_notice_news` VALUES ('32', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【鹏飞经纪公司】经纪公司详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1635587755', '1635587755');
INSERT INTO `s_notice_news` VALUES ('33', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【鹏飞经纪公司】经纪公司详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1635588004', '1635588004');
INSERT INTO `s_notice_news` VALUES ('34', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【鹏飞经纪公司】经纪公司详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1635588288', '1635588288');
INSERT INTO `s_notice_news` VALUES ('35', '2', '3', '0', '1', '<p>尊敬的用户您申请购买的【鹏飞经纪公司】经纪公司详情页广告位，被发布者拒绝，支付的广告费原路退还至余额。</p>', '1635588354', '1635588354');
INSERT INTO `s_notice_news` VALUES ('36', '1', '3', '0', '5', '<p> 您好，恭喜您，您加入【鹏飞经纪公司】的申请已被通过。</p>', '1636092878', '1636092878');
INSERT INTO `s_notice_news` VALUES ('37', '1', '3', '0', '6', '<p> 您好，您加入【鹏飞经纪公司】的申请已被拒绝。</p>', '1636093067', '1636093067');
INSERT INTO `s_notice_news` VALUES ('38', '1', '3', '0', '1', '<p> 您好，恭喜您，您加入【鹏飞经纪公司】的申请已被通过。</p>', '1636095629', '1636095629');
INSERT INTO `s_notice_news` VALUES ('39', '1', '3', '0', '2', '<p> 您好，恭喜您，您加入【鹏飞经纪公司】的申请已被通过。</p>', '1636193665', '1636193665');
INSERT INTO `s_notice_news` VALUES ('40', '1', '3', '0', '2', '<p> 您好，您加入【鹏飞经纪公司】的申请已被拒绝。</p>', '1636193819', '1636193819');
INSERT INTO `s_notice_news` VALUES ('41', '1', '3', '0', '2', '<p> 您好，您加入【鹏飞经纪公司】的申请已被拒绝。</p>', '1636193830', '1636193830');

-- ----------------------------
-- Table structure for s_notice_union
-- ----------------------------
DROP TABLE IF EXISTS `s_notice_union`;
CREATE TABLE `s_notice_union` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL COMMENT '1=>c 端看 2=>b 端看',
  `u_id` int(11) NOT NULL COMMENT '联盟id(s_union 表)',
  `content` text COLLATE utf8_unicode_ci COMMENT '内容',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='c b 端 通知-联盟消息表';

-- ----------------------------
-- Records of s_notice_union
-- ----------------------------

-- ----------------------------
-- Table structure for s_notice_user_c
-- ----------------------------
DROP TABLE IF EXISTS `s_notice_user_c`;
CREATE TABLE `s_notice_user_c` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `nn_id` text COLLATE utf8_unicode_ci COMMENT '重要消息表 id (s_notice_news 表)',
  `nbu_id` text COLLATE utf8_unicode_ci COMMENT '后援会消息id (s_notice_backup 表)',
  `nbs_id` text COLLATE utf8_unicode_ci COMMENT '店铺信息表 (s_notice_union 表)',
  `nuu_id` text COLLATE utf8_unicode_ci COMMENT '联盟消息id(s_notice_union 表 type为1时)',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户与消息关系表';

-- ----------------------------
-- Records of s_notice_user_c
-- ----------------------------
INSERT INTO `s_notice_user_c` VALUES ('1', '1', '[]', '[]', '[\"2\"]', '[]', '1632969503', '1635744358');

-- ----------------------------
-- Table structure for s_order
-- ----------------------------
DROP TABLE IF EXISTS `s_order`;
CREATE TABLE `s_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '订单号',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `type` tinyint(4) DEFAULT NULL COMMENT '1=>b端 2=>c端',
  `obj_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '1=>购买联盟卡(s_union表)  2=>购买广告(s_advertisement表)',
  `obj_id` int(11) DEFAULT NULL COMMENT '根据 obj_type 来的\r\n1=>联盟id\r\n2=>广告表id',
  `money` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `pay_type` tinyint(4) DEFAULT NULL COMMENT '支付方式 1=>余额 2=>微信 3=支付宝 4=>银联',
  `pay_status` tinyint(4) DEFAULT '0' COMMENT '0=>未支付 1=>已支付',
  `order_type` tinyint(4) unsigned DEFAULT NULL COMMENT '订单类型 \r\n1.充值订单\r\n2.提现订单\r\n3.消费订单',
  `order_status` tinyint(4) DEFAULT NULL COMMENT '订单状态  1支付 2提现 3充值',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='订单表';

-- ----------------------------
-- Records of s_order
-- ----------------------------
INSERT INTO `s_order` VALUES ('1', 'BX2021102711565', '1', '1', '2', '1', '15.00', '1', '1', '3', '1', '1635318709', '1635584701');
INSERT INTO `s_order` VALUES ('2', 'BX2021102749070', '1', '1', '2', '2', '11.00', '1', '1', '3', '1', '1635318714', '1635323810');
INSERT INTO `s_order` VALUES ('3', 'BX2021102781266', '1', '1', '2', '3', '15.00', '1', '1', '3', '1', '1635318716', '1635585098');
INSERT INTO `s_order` VALUES ('4', 'BX2021102778654', null, '1', '2', '4', '10.00', '1', '0', '3', '1', '1635325879', '1635325879');
INSERT INTO `s_order` VALUES ('5', 'BX2021102713313', null, '1', '2', '5', '10.00', '1', '0', '3', '1', '1635325881', '1635325881');
INSERT INTO `s_order` VALUES ('6', 'BX2021102758356', null, '1', '2', '6', '10.00', '1', '0', '3', '1', '1635325883', '1635325883');
INSERT INTO `s_order` VALUES ('7', 'BX2021102877959', null, '1', '2', '6', '10.00', '1', '0', '3', '1', '1635401417', '1635401417');
INSERT INTO `s_order` VALUES ('8', 'BX2021102866305', null, '1', '2', '7', '10.00', '1', '0', '3', '1', '1635401863', '1635401863');
INSERT INTO `s_order` VALUES ('9', 'BX2021102827349', null, '1', '2', '8', '10.00', '1', '0', '3', '1', '1635401901', '1635401901');
INSERT INTO `s_order` VALUES ('10', 'BX2021102894919', '1', '1', '2', '9', '15.00', '1', '1', '3', '1', '1635403566', '1635585419');
INSERT INTO `s_order` VALUES ('11', 'BX2021102899868', null, '1', '2', '10', '10.00', '1', '0', '3', '1', '1635411666', '1635411666');
INSERT INTO `s_order` VALUES ('12', 'BX2021102888310', null, '1', '2', '11', '10.00', '1', '0', '3', '1', '1635411669', '1635411669');
INSERT INTO `s_order` VALUES ('13', 'BX2021102887237', null, '1', '2', '12', '10.00', '1', '0', '3', '1', '1635411671', '1635411671');
INSERT INTO `s_order` VALUES ('14', 'BX2021102868753', null, '1', '2', '13', '10.00', '1', '0', '3', '1', '1635411707', '1635411707');
INSERT INTO `s_order` VALUES ('15', 'BX2021102807363', null, '1', '2', '14', '10.00', '1', '0', '3', '1', '1635411709', '1635411709');
INSERT INTO `s_order` VALUES ('16', 'BX2021110415198', '1', '2', '1', '1', '20.00', '1', '0', '3', '1', '1635994218', '1635994218');
INSERT INTO `s_order` VALUES ('17', 'BX2021110469762', '1', '2', '1', '1', '20.00', '1', '0', '3', '1', '1635994470', '1635994470');
INSERT INTO `s_order` VALUES ('18', 'BX2021110481885', '1', '2', '1', '1', '20.00', '1', '0', '3', '1', '1635994473', '1635994473');
INSERT INTO `s_order` VALUES ('19', 'BX2021110485354', null, '1', '2', '16', '10.00', '1', '0', '3', '1', '1635995027', '1635995027');
INSERT INTO `s_order` VALUES ('20', 'BX2021110551581', null, '1', '2', '18', '10.00', '1', '0', '3', '1', '1636099358', '1636099358');
INSERT INTO `s_order` VALUES ('21', 'BX2021110570561', null, '1', '2', '19', '10.00', '1', '0', '3', '1', '1636099362', '1636099362');
INSERT INTO `s_order` VALUES ('22', 'BX2021110520212', null, '1', '2', '20', '10.00', '1', '0', '3', '1', '1636099364', '1636099364');

-- ----------------------------
-- Table structure for s_platform
-- ----------------------------
DROP TABLE IF EXISTS `s_platform`;
CREATE TABLE `s_platform` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '1=>促销信息 2=>促销商品',
  `is_user` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户可在此分类下发布信息 0=>不  1=>可',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '显示 0=>不 =>显示',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='平台促销表';

-- ----------------------------
-- Records of s_platform
-- ----------------------------
INSERT INTO `s_platform` VALUES ('1', '平台优惠', '1', '0', '1', null, null);
INSERT INTO `s_platform` VALUES ('2', '商超优惠', '1', '0', '1', null, null);
INSERT INTO `s_platform` VALUES ('3', 'HAO平台', '2', '1', '1', null, null);
INSERT INTO `s_platform` VALUES ('4', 'HAO商铺', '2', '1', '1', null, null);

-- ----------------------------
-- Table structure for s_platform_class
-- ----------------------------
DROP TABLE IF EXISTS `s_platform_class`;
CREATE TABLE `s_platform_class` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `b_id` int(11) DEFAULT NULL COMMENT '所属平台id(s_platform 表)',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '标题',
  `title_logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 's_platform 内 type 为1 才有值,  为2无值  分类logo',
  `is_recom` tinyint(4) DEFAULT NULL COMMENT '推荐促销信息10个 分类\r\ns_platform 内 type 为1 才有值,  为2无值  \r\n推荐  : 0=>不 1=>已推',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `b_id` (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='平台促销信息分类表,没有促销商品的分类,它复用商品分类';

-- ----------------------------
-- Records of s_platform_class
-- ----------------------------
INSERT INTO `s_platform_class` VALUES ('1', '1', '淘宝', null, null, null, null);
INSERT INTO `s_platform_class` VALUES ('2', '1', '美团', null, null, null, null);
INSERT INTO `s_platform_class` VALUES ('3', '1', '京东', null, null, null, null);
INSERT INTO `s_platform_class` VALUES ('4', '1', '拼多多', null, null, null, null);
INSERT INTO `s_platform_class` VALUES ('5', '2', '美食', null, null, null, null);
INSERT INTO `s_platform_class` VALUES ('6', '2', '电影', null, null, null, null);
INSERT INTO `s_platform_class` VALUES ('7', '2', '打车', null, null, null, null);
INSERT INTO `s_platform_class` VALUES ('8', '2', '玩乐', null, null, null, null);

-- ----------------------------
-- Table structure for s_platform_class_log
-- ----------------------------
DROP TABLE IF EXISTS `s_platform_class_log`;
CREATE TABLE `s_platform_class_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `b_id` int(11) NOT NULL COMMENT '所属平台id(s_platform 表)  一级分类',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '搜索的内容,(补充到s_platform_class 表内)  二级分类',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `b_id` (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='促销平台 搜索未果记录 针对的是促销信息';

-- ----------------------------
-- Records of s_platform_class_log
-- ----------------------------
INSERT INTO `s_platform_class_log` VALUES ('1', '3', '自', '1634008291', '1634008291');
INSERT INTO `s_platform_class_log` VALUES ('15', '4', '自', '1634016841', '1634016841');
INSERT INTO `s_platform_class_log` VALUES ('16', '4', '自', '1634016852', '1634016852');
INSERT INTO `s_platform_class_log` VALUES ('17', '4', '自', '1634016853', '1634016853');
INSERT INTO `s_platform_class_log` VALUES ('18', '1', '1', '1634096421', '1634096421');

-- ----------------------------
-- Table structure for s_platform_data
-- ----------------------------
DROP TABLE IF EXISTS `s_platform_data`;
CREATE TABLE `s_platform_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `p_id` int(11) NOT NULL COMMENT '所属平台id (s_platform 表)',
  `pc_id` int(11) NOT NULL COMMENT '平台下分类id (s_platform_class 表)  \r\n只针对促销信息的分类,促销商品的分类,复用商品分类',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '促销信息 开始 标题',
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'logo',
  `position` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '位置',
  `content` text COLLATE utf8_unicode_ci COMMENT '内容',
  `start_time` date DEFAULT NULL COMMENT '开始时间',
  `end_time` date DEFAULT NULL COMMENT '结束时间',
  `jump_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '跳转链接',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  `goods_id` int(11) DEFAULT NULL COMMENT '促销商品开始    商品id (s_commodity 表)',
  `b_id` int(11) DEFAULT NULL COMMENT '商家id(s_business 表)',
  `c_id` int(11) DEFAULT NULL COMMENT '商品分类 (s_commodity_class表)',
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品 1=>线上 2=>线下',
  `only` int(11) DEFAULT NULL COMMENT '商品唯一id',
  `title_img` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品标题,图片 5个图片合1个json',
  `details` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品详情,图片 5个图片合1个json',
  `original_price` decimal(10,2) DEFAULT NULL COMMENT '原有价格',
  `favorable_price` decimal(10,2) DEFAULT NULL COMMENT '优惠价格',
  `stock` int(255) DEFAULT NULL COMMENT '库存  以商品表的库存计算,不能大于商品表的库存',
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '网址',
  `api_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '商品api接口 线上 才有这个 (s_commodity_api 表 id 解释待定)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='平台信息';

-- ----------------------------
-- Records of s_platform_data
-- ----------------------------
INSERT INTO `s_platform_data` VALUES ('1', '1', '1', '测试1', '\r\nFh5QjaEwJJIGmSec7-qB21QCrFkv', '河北省-石家庄市-裕华区', '<p>测试促销信息,</p>', '2021-10-01', '2021-10-08', 'https://www.baidu.com/', '1633665270', '1633672326', null, null, null, null, null, '', '', '0.00', '0.00', '0', '', '');
INSERT INTO `s_platform_data` VALUES ('2', '1', '1', '测试2', 'uploads/img/20211020/d3a7ec20399f46ce3913f9f2f64c7e4a.jpeg', '河北省-石家庄市-裕华区', '测试', '2021-10-01', '2021-10-09', 'https://www.baidu.com/', '1633665270', '1633671837', null, null, null, null, null, '', '', '0.00', '0.00', '0', '', '');
INSERT INTO `s_platform_data` VALUES ('3', '1', '2', '测试3', 'Fh5QjaEwJJIGmSec7-qB21QCrFkv', '河北省-石家庄市-裕华区', '测试', '2021-10-01', '2021-10-08', 'https://www.baidu.com/', '1633665270', '1633672326', null, null, null, null, null, '', '', '0.00', '0.00', '0', '', '');
INSERT INTO `s_platform_data` VALUES ('4', '1', '2', '测试4', 'Fh5QjaEwJJIGmSec7-qB21QCrFkv', '河北省-石家庄市-裕华区', '测试', '2021-10-01', '2021-10-08', 'https://www.baidu.com/', '1633665270', '1633672326', null, null, null, null, null, '', '', '0.00', '0.00', '0', '', '');
INSERT INTO `s_platform_data` VALUES ('5', '1', '6', '测试5', 'Fh5QjaEwJJIGmSec7-qB21QCrFkv', '河北省北京市裕华区', '测试', '2021-10-01', '2021-10-08', 'https://www.baidu.com/', '1633665270', '1633672326', null, null, null, null, null, '', '', '0.00', '0.00', '0', '', '');
INSERT INTO `s_platform_data` VALUES ('6', '3', '4', '四五六九二', null, null, null, null, null, null, null, null, '11', '5', '3', '1', '12345621', '[ \"uploads/img/20211020/d3a7ec20399f46ce3913f9f2f64c7e4a.jpeg\", \"uploads/img/20211020/d3a7ec20399f46ce3913f9f2f64c7e4a.jpeg\", \"uploads/img/20211020/d3a7ec20399f46ce3913f9f2f64c7e4a.jpeg\"]', '[ \"uploads/img/20211020/d3a7ec20399f46ce3913f9f2f64c7e4a.jpeg\", \"uploads/img/20211020/d3a7ec20399f46ce3913f9f2f64c7e4a.jpeg\", \"uploads/img/20211020/d3a7ec20399f46ce3913f9f2f64c7e4a.jpeg\"]', '100.00', '75.00', '50', '', 'https://www.baidu.com/');
INSERT INTO `s_platform_data` VALUES ('7', '3', '4', '四五六九三', null, null, null, null, null, null, null, null, '10', '5', '1', '1', '12345620', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '100.00', '75.00', '50', '', 'https://www.baidu.com/');
INSERT INTO `s_platform_data` VALUES ('8', '3', '4', '四五六九四', null, null, null, null, null, null, null, null, '12', '5', '3', '1', '12345622', '[ \"https://img0.baidu.com/it/u=3122136587,3938996930&fm=26&fmt=auto\", \"https://img0.baidu.com/it/u=3122136587,3938996930&fm=26&fmt=auto\", \"https://img0.baidu.com/it/u=3122136587,3938996930&fm=26&fmt=auto\"]', '[ \"https://img0.baidu.com/it/u=3122136587,3938996930&fm=26&fmt=auto\", \"https://img0.baidu.com/it/u=3122136587,3938996930&fm=26&fmt=auto\", \"https://img0.baidu.com/it/u=3122136587,3938996930&fm=26&fmt=auto\"]', '100.00', '75.00', '50', '', 'https://www.baidu.com/');
INSERT INTO `s_platform_data` VALUES ('9', '3', '4', '四五六九五', null, null, null, null, null, null, null, null, '13', '6', '1', '1', '12345623', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '[ \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\", \"FhHF0AXhZZjVxmNIRTcjfnkNXfxN\"]', '100.00', '75.00', '50', '', 'https://www.baidu.com/');

-- ----------------------------
-- Table structure for s_platform_rules
-- ----------------------------
DROP TABLE IF EXISTS `s_platform_rules`;
CREATE TABLE `s_platform_rules` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text COLLATE utf8_unicode_ci COMMENT '内容',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='各种规则表';

-- ----------------------------
-- Records of s_platform_rules
-- ----------------------------
INSERT INTO `s_platform_rules` VALUES ('1', '联盟卡使用规则', '<p>联盟卡使用规则 1,  2,</p>', null, null);
INSERT INTO `s_platform_rules` VALUES ('2', '联盟码使用规则', '<p>联盟码使用规则 1,  2,</p>', null, null);
INSERT INTO `s_platform_rules` VALUES ('3', '预售规则', '<p>按照每月中七天为期限，分成时间段；\r\n例如：2021.8.1-2021.8.7作为第一次发布广告时间；\r\n假设：广告位没有在2021.8.1-2021.8.7时间中被购买\r\n则此广告位作废取消；\r\n假设：2021.8.2-2021.8.6进行购买还是按照2021.8.7\r\n为截止时间进行计算并支付七天的广告位价格。\r\n</p>', null, null);
INSERT INTO `s_platform_rules` VALUES ('4', '艺人详情广告位预售规则', '<p>\r\n明星详情广告位C端用户预售后，首先B端用户要进\r\n行报价，B端用户报价后返回C端用户进行确认报价\r\n操作，一旦B端用户购买明星详情广告位使用余额支\r\n付，B端用户资金会先进入冻结，然后等待C端用户\r\n发布者进行确认报价，C端用户24小时内必须确认报\r\n价，不进行确认B端用户订单作废，B端用户冻结资\r\n金将返还余额，如B端用户报价被C端用户确认后,B\r\n端用户冻结资金进入C端余额，同时计算也需要符合\r\n预售规则；\r\n</p>', null, null);
INSERT INTO `s_platform_rules` VALUES ('5', '艺人详情后援会粉丝广告分成', '<p>组建明星后援会广告费分成\r\n广告分成规则：平台10%、明星30%、经纪公司\r\n10%，后援会20%、会长30%后援会的份额按月\r\n平均分配给每月表现最好的前三名粉丝如果明星\r\n没有经纪公司，则经纪公司的分成划入明星帐号\r\n明星详情页广告费分成\r\n广告分成规则：平台10%、明星40%、经纪公司\r\n10%，后援会10%、会长30%后援会的份额按月\r\n平均分配给每月表现最好的前三名粉丝如果明星\r\n没有经纪公司，则经纪公司的分成划入明星帐号\r\n</p>', null, null);
INSERT INTO `s_platform_rules` VALUES ('6', '艺人详情后援会推广联盟卡数量', '<p>按照后援会成员推广联盟卡数量进行排名</p>', null, null);
INSERT INTO `s_platform_rules` VALUES ('7', '艺人详情后援会成员数量', '<p>按照后援会成员数量进行排名</p>', null, null);
INSERT INTO `s_platform_rules` VALUES ('8', '艺人详情后援会推广商家数量', '<p>按照后援会成员推广商家数量进行排名</p>', null, null);
INSERT INTO `s_platform_rules` VALUES ('9', '艺人详情投票商品规则', '<p>按照xxx数量进行排名</p>', null, null);
INSERT INTO `s_platform_rules` VALUES ('10', '软件许可', '<p>10按照xxx数量进行排名</p>', null, null);
INSERT INTO `s_platform_rules` VALUES ('11', '隐私政策', '<p>11按照xxx数量进行排名</p>', null, null);

-- ----------------------------
-- Table structure for s_popular_cities
-- ----------------------------
DROP TABLE IF EXISTS `s_popular_cities`;
CREATE TABLE `s_popular_cities` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0=>不显示 1=>展示',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='c 端 首页-选择城市-热门城市';

-- ----------------------------
-- Records of s_popular_cities
-- ----------------------------
INSERT INTO `s_popular_cities` VALUES ('1', '上海市', '1', null, null);
INSERT INTO `s_popular_cities` VALUES ('2', '北京市', '1', null, null);
INSERT INTO `s_popular_cities` VALUES ('3', '深圳', '1', null, null);

-- ----------------------------
-- Table structure for s_ranking_list
-- ----------------------------
DROP TABLE IF EXISTS `s_ranking_list`;
CREATE TABLE `s_ranking_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `obj_type` tinyint(4) DEFAULT NULL COMMENT '1=>合作商家贡献 (s_union 表)\r\n2=>联盟卡销量贡献 (s_union 表)\r\n3=>粉丝数量 (s_user表 )\r\n4=>商品销量贡献 (s_union 表)',
  `obj_id` int(11) DEFAULT NULL COMMENT '根据obj_type 而来',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='首页-排行榜表';

-- ----------------------------
-- Records of s_ranking_list
-- ----------------------------
INSERT INTO `s_ranking_list` VALUES ('127', '1', '3', '1634543242', '1634543242');
INSERT INTO `s_ranking_list` VALUES ('128', '1', '2', '1634543242', '1634543242');
INSERT INTO `s_ranking_list` VALUES ('129', '1', '4', '1634543242', '1634543242');
INSERT INTO `s_ranking_list` VALUES ('130', '2', '4', '1634543242', '1634543242');
INSERT INTO `s_ranking_list` VALUES ('131', '2', '5', '1634543242', '1634543242');
INSERT INTO `s_ranking_list` VALUES ('132', '2', '3', '1634543242', '1634543242');
INSERT INTO `s_ranking_list` VALUES ('133', '3', '2', '1634543242', '1634543242');
INSERT INTO `s_ranking_list` VALUES ('134', '3', '1', '1634543242', '1634543242');
INSERT INTO `s_ranking_list` VALUES ('135', '3', '3', '1634543242', '1634543242');
INSERT INTO `s_ranking_list` VALUES ('136', '4', '5', '1634543242', '1634543242');
INSERT INTO `s_ranking_list` VALUES ('137', '4', '4', '1634543242', '1634543242');
INSERT INTO `s_ranking_list` VALUES ('138', '4', '1', '1634543242', '1634543242');

-- ----------------------------
-- Table structure for s_red_envelopes
-- ----------------------------
DROP TABLE IF EXISTS `s_red_envelopes`;
CREATE TABLE `s_red_envelopes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '标题',
  `money` decimal(10,0) DEFAULT NULL COMMENT '红包数值',
  `expiration_time` date DEFAULT NULL COMMENT '过期时间',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='红包表';

-- ----------------------------
-- Records of s_red_envelopes
-- ----------------------------

-- ----------------------------
-- Table structure for s_red_envelopes_user
-- ----------------------------
DROP TABLE IF EXISTS `s_red_envelopes_user`;
CREATE TABLE `s_red_envelopes_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用id',
  `r_id` int(11) NOT NULL COMMENT '红包表id(s_red_envelopes 表)',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `r_id` (`r_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户与红包关系表';

-- ----------------------------
-- Records of s_red_envelopes_user
-- ----------------------------

-- ----------------------------
-- Table structure for s_share_platform
-- ----------------------------
DROP TABLE IF EXISTS `s_share_platform`;
CREATE TABLE `s_share_platform` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id(被分享者)',
  `pid` int(11) DEFAULT NULL COMMENT '分享者id',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='分享 - c 端平台分享';

-- ----------------------------
-- Records of s_share_platform
-- ----------------------------
INSERT INTO `s_share_platform` VALUES ('2', '1', '3', '1636446599', '1636446599');

-- ----------------------------
-- Table structure for s_share_union_card
-- ----------------------------
DROP TABLE IF EXISTS `s_share_union_card`;
CREATE TABLE `s_share_union_card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id(被分享者)',
  `un_id` int(11) DEFAULT NULL COMMENT '联盟id',
  `pid` int(11) DEFAULT NULL COMMENT '分享者id',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='分享 - 联盟卡推广记录\r\n以被分享者的角度建的表';

-- ----------------------------
-- Records of s_share_union_card
-- ----------------------------

-- ----------------------------
-- Table structure for s_sms
-- ----------------------------
DROP TABLE IF EXISTS `s_sms`;
CREATE TABLE `s_sms` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `phone` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '电话',
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '验证码',
  `is_use` tinyint(255) NOT NULL DEFAULT '0' COMMENT '使用 0=>未用 1=>已用',
  `expiration_time` int(11) NOT NULL COMMENT '过期时间',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='短信验证码表';

-- ----------------------------
-- Records of s_sms
-- ----------------------------
INSERT INTO `s_sms` VALUES ('1', '18332255387', '4665', '0', '1632280462', '1632280162', '1632280162');
INSERT INTO `s_sms` VALUES ('2', '18332255387', '6322', '0', '1632283290', '1632282990', '1632282990');
INSERT INTO `s_sms` VALUES ('3', '18332255387', '2208', '0', '1632290711', '1632290411', '1632290411');
INSERT INTO `s_sms` VALUES ('4', '18332255387', '1234', '1', '1632297557', null, '1632294011');
INSERT INTO `s_sms` VALUES ('5', '18332255387', '2339', '0', '1632987933', '1632987633', '1632987633');

-- ----------------------------
-- Table structure for s_star
-- ----------------------------
DROP TABLE IF EXISTS `s_star`;
CREATE TABLE `s_star` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '艺人的电话',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '明星介绍标题',
  `content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '明星介绍',
  `notice` text COLLATE utf8_unicode_ci COMMENT '公告,json数据',
  `other_logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '艺人其它平台的标志',
  `other` text COLLATE utf8_unicode_ci COMMENT '艺人其它平台  5条合成json数据',
  `fans_number` int(11) DEFAULT '0' COMMENT '明星用户的总粉丝量,(该明星下所有后援会粉丝量的和,用户关注明星的6个次数)',
  `backup_number` int(11) DEFAULT '0' COMMENT '后援会数量',
  `star_number` int(11) DEFAULT '0' COMMENT '建立的明星联盟数量',
  `is_auth` tinyint(4) DEFAULT '0' COMMENT '平台认证 0=>未 1=>已认证',
  `is_company` tinyint(4) DEFAULT '0' COMMENT '经纪公司认证  0=>未认证 1=>已认证',
  `is_display` tinyint(4) DEFAULT '1' COMMENT '1=>显示 2=>搜索隐藏 ,明星角色',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='明星信息表';

-- ----------------------------
-- Records of s_star
-- ----------------------------
INSERT INTO `s_star` VALUES ('1', '5', null, '啦啦啦.卖报小行家', '<p>一个一分钱</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', '101', '0', '0', '0', '0', '1', null, null);
INSERT INTO `s_star` VALUES ('2', '6', null, null, '<p>一个一分钱</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', '190', '0', '0', '0', '0', '1', null, null);
INSERT INTO `s_star` VALUES ('3', '7', null, null, '<p>一个一分钱</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', '101', '0', '0', '0', '0', '1', null, null);
INSERT INTO `s_star` VALUES ('4', '8', null, null, '<p>一个一分钱</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', '14', '0', '0', '0', '0', '1', null, null);
INSERT INTO `s_star` VALUES ('5', '9', null, null, '<p>一个一分钱</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', '2', '0', '0', '0', '0', '1', null, null);
INSERT INTO `s_star` VALUES ('6', '2', null, null, '<p>一个一分钱</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', '0', '0', '0', '0', '0', '1', '1634203001', '1634203001');
INSERT INTO `s_star` VALUES ('7', '1', '18332255333', '12', '21', '21', '21', '12', '0', '0', '0', '0', '0', '1', '1636197498', '1636197498');

-- ----------------------------
-- Table structure for s_star_backup
-- ----------------------------
DROP TABLE IF EXISTS `s_star_backup`;
CREATE TABLE `s_star_backup` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '创建后援会用户id(会长id)',
  `star_id` int(11) DEFAULT NULL COMMENT '后援会的明星id  (s_user 表)',
  `only` int(11) DEFAULT NULL COMMENT '后援会ID',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '后援会名称',
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '后援会头像',
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '后援会联系方式',
  `introduce` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '后援会介绍',
  `notice` text COLLATE utf8_unicode_ci COMMENT '后援会公告 10条合成一个字符串',
  `other_logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '其它平台的标志',
  `other` text COLLATE utf8_unicode_ci COMMENT '后援会其它平台  5条合成json数据',
  `video` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '视频,明星给后援会录制的视频',
  `fans_number` int(11) DEFAULT '0' COMMENT '粉丝数量',
  `card_number` int(11) DEFAULT '0' COMMENT '推广明星下联盟卡的数量',
  `business_number` int(11) DEFAULT '0' COMMENT '推广明星下联盟内的商家数量',
  `purchase_number` int(11) DEFAULT '0' COMMENT '后援会,粉丝商品购买数量',
  `total_ranking` int(11) DEFAULT '0' COMMENT '后援会的总排行\r\n按成员数+联盟卡推广数+介绍商家数的总数进行动态排名，\r\n联盟卡推广数加权数为2，介绍商家数加权数为3，商品购买加权数为4, 成员数加权1',
  `divide` decimal(10,2) DEFAULT '0.00' COMMENT '后援会广告分成, \r\n每月一清\r\n只是为了得出当月分成排行, 不以它来分配广告位\r\n',
  `status` tinyint(4) DEFAULT '0' COMMENT '审核 0=>待审 1=>通过 2=>失败',
  `is_display` tinyint(4) DEFAULT '1' COMMENT '后台操作, 1=>显示 0=>隐藏',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='明星后援会表';

-- ----------------------------
-- Records of s_star_backup
-- ----------------------------
INSERT INTO `s_star_backup` VALUES ('1', '1', '10', '2223452', '蔡徐坤后援会', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '18332255222', '<p>13132</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', '4949', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', 'https://mp4i.vodfile.m1905.com/202110280957/8619e197e1d5292f7be843ddab9f08c6/video/2016/11/02/v2016110231CKL5JQR7VW592L/v2016110231CKL5JQR7VW592L.mp4', '9', '0', '0', '0', '2', '1.50', '1', '1', null, '1636020094');
INSERT INTO `s_star_backup` VALUES ('2', '2', '6', '324346323', '陈奕迅后援会', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, '<p>后援会介绍</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211104/64953a4402690501ef0555161afd7b33.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', 'https://mp4i.vodfile.m1905.com/202110280957/8619e197e1d5292f7be843ddab9f08c6/video/2016/11/02/v2016110231CKL5JQR7VW592L/v2016110231CKL5JQR7VW592L.mp4', '7', '0', '0', '0', '1', '0.00', '1', '1', null, null);
INSERT INTO `s_star_backup` VALUES ('3', '3', '7', '32546532', '黎明后援会', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, '<p>后援会介绍</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211104/64953a4402690501ef0555161afd7b33.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', 'https://mp4i.vodfile.m1905.com/202110280957/8619e197e1d5292f7be843ddab9f08c6/video/2016/11/02/v2016110231CKL5JQR7VW592L/v2016110231CKL5JQR7VW592L.mp4', '17', '0', '0', '0', '11', '0.00', '1', '1', null, null);
INSERT INTO `s_star_backup` VALUES ('4', '4', '8', '329644', '郭富城后援会', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, '<p>后援会介绍</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211104/64953a4402690501ef0555161afd7b33.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', 'https://mp4i.vodfile.m1905.com/202110280957/8619e197e1d5292f7be843ddab9f08c6/video/2016/11/02/v2016110231CKL5JQR7VW592L/v2016110231CKL5JQR7VW592L.mp4', '11', '0', '0', '0', '1', '0.00', '1', '1', null, null);
INSERT INTO `s_star_backup` VALUES ('5', '5', '9', '4387265', '蔡徐坤后援会', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, '<p>后援会介绍</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211104/64953a4402690501ef0555161afd7b33.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', 'https://mp4i.vodfile.m1905.com/202110280957/8619e197e1d5292f7be843ddab9f08c6/video/2016/11/02/v2016110231CKL5JQR7VW592L/v2016110231CKL5JQR7VW592L.mp4', '6', '0', '0', '0', '6', '0.00', '1', '1', null, null);
INSERT INTO `s_star_backup` VALUES ('6', '1', '5', '468464198', '蔡徐坤高后援会', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, '<p>后援会介绍</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211104/64953a4402690501ef0555161afd7b33.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', 'https://mp4i.vodfile.m1905.com/202110280957/8619e197e1d5292f7be843ddab9f08c6/video/2016/11/02/v2016110231CKL5JQR7VW592L/v2016110231CKL5JQR7VW592L.mp4', '99', '6', '1', '0', '23', '4.50', '1', '1', null, '1635323810');
INSERT INTO `s_star_backup` VALUES ('7', '3', '6', '788932632', '陈奕迅后援会', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, '<p>后援会介绍</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211104/64953a4402690501ef0555161afd7b33.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', 'https://mp4i.vodfile.m1905.com/202110280957/8619e197e1d5292f7be843ddab9f08c6/video/2016/11/02/v2016110231CKL5JQR7VW592L/v2016110231CKL5JQR7VW592L.mp4', '10', '0', '0', '0', '8', '0.00', '1', '1', null, null);
INSERT INTO `s_star_backup` VALUES ('8', '2', '8', '655422422', '郭富城后援会', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, '<p>后援会介绍</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211104/64953a4402690501ef0555161afd7b33.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', 'https://mp4i.vodfile.m1905.com/202110280957/8619e197e1d5292f7be843ddab9f08c6/video/2016/11/02/v2016110231CKL5JQR7VW592L/v2016110231CKL5JQR7VW592L.mp4', '2', '0', '0', '0', '8', '0.00', '1', '1', null, null);
INSERT INTO `s_star_backup` VALUES ('9', '13', '5', '63987234', '蔡徐坤后援会', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, '<p>后援会介绍</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211104/64953a4402690501ef0555161afd7b33.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', 'https://mp4i.vodfile.m1905.com/202110280957/8619e197e1d5292f7be843ddab9f08c6/video/2016/11/02/v2016110231CKL5JQR7VW592L/v2016110231CKL5JQR7VW592L.mp4', '9', '9', '41', '0', '4', '3.00', '1', '1', null, null);
INSERT INTO `s_star_backup` VALUES ('10', '4', '5', '23598764', '蔡徐坤后援会', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, '<p>后援会介绍</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211104/64953a4402690501ef0555161afd7b33.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', 'https://mp4i.vodfile.m1905.com/202110280957/8619e197e1d5292f7be843ddab9f08c6/video/2016/11/02/v2016110231CKL5JQR7VW592L/v2016110231CKL5JQR7VW592L.mp4', '7', '2', '6', '0', '2', '2.00', '1', '1', '1632675600', null);
INSERT INTO `s_star_backup` VALUES ('11', '3', '5', '423675', '蔡徐坤抵后援会', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, '<p>后援会介绍</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211104/64953a4402690501ef0555161afd7b33.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', 'https://mp4i.vodfile.m1905.com/202110280957/8619e197e1d5292f7be843ddab9f08c6/video/2016/11/02/v2016110231CKL5JQR7VW592L/v2016110231CKL5JQR7VW592L.mp4', '10', '1', '12', '0', '6', '9.00', '1', '1', null, null);
INSERT INTO `s_star_backup` VALUES ('12', '7', '2', '4325255', 'ppd后援会', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, '<p>后援会介绍</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211104/64953a4402690501ef0555161afd7b33.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', 'https://mp4i.vodfile.m1905.com/202110280957/8619e197e1d5292f7be843ddab9f08c6/video/2016/11/02/v2016110231CKL5JQR7VW592L/v2016110231CKL5JQR7VW592L.mp4', '10', '14', '45', '55', '54', '5.00', '1', '1', null, null);
INSERT INTO `s_star_backup` VALUES ('13', '1', '5', '36604450', '123后援会', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '18332255387', '<p>后援会介绍</p>', '[\"\\u6c34\\u7535\\u8d39\\u51b7\\u6c34\\u7684\\u7406\\u5ff5\\u5f8b\\u5e08\\u4ee3\\u7406\\u8d39\\u7b2c\\u4e09\\u65b9,\\u8bf4\\u6cd5\\u7b2c\\u4e09\\u65b9\\u7b2c\\u4e09\\u65b9\\u79bb\\u5f00\\u80dc\\u591a\\u8d1f\\u5c11\\u7684\",\"\\u662f\\u7684\\u7c89\\u8272\\u5b8c\\u5168\\u662f\\u7684\\u798f\\u5229\\u662f\\u7684\\u5976\\u7c89\\u4e86\\u662f\\u7684\\u8303\\u5fb7\\u8428\\u53d1\\u751f\\u7684\\u53d1\"]', 'uploads/home/img/20211104/64953a4402690501ef0555161afd7b33.jpg', '[{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324},{\"link\":\"https:\\/\\/fanyi.baidu.com\\/\",\"ID\":234324}]', 'https://mp4i.vodfile.m1905.com/202110280957/8619e197e1d5292f7be843ddab9f08c6/video/2016/11/02/v2016110231CKL5JQR7VW592L/v2016110231CKL5JQR7VW592L.mp4', '0', '0', '0', '0', '0', '0.00', '1', '1', '1635230312', '1635230312');

-- ----------------------------
-- Table structure for s_star_backup_member
-- ----------------------------
DROP TABLE IF EXISTS `s_star_backup_member`;
CREATE TABLE `s_star_backup_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_id` int(11) DEFAULT NULL COMMENT '后援会id',
  `user_id` int(11) DEFAULT NULL COMMENT '后援会成员id',
  `goods` int(11) DEFAULT '0' COMMENT '商品购买数量',
  `shop` int(11) DEFAULT '0' COMMENT '介绍商家数',
  `card` int(11) DEFAULT '0' COMMENT '联盟卡推广数',
  `pull` int(11) DEFAULT '0' COMMENT '拉入的消费者, (通过分享平台二维码,拉的)',
  `contribution` int(11) DEFAULT '0' COMMENT '总贡献值',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `s_id` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='后援会成员表';

-- ----------------------------
-- Records of s_star_backup_member
-- ----------------------------
INSERT INTO `s_star_backup_member` VALUES ('1', '10', '2', '0', '0', '0', '0', '0', '1632903494', null);
INSERT INTO `s_star_backup_member` VALUES ('2', '7', '1', '0', '0', '0', '0', '0', '1632903494', null);
INSERT INTO `s_star_backup_member` VALUES ('3', '8', '1', '0', '0', '0', '0', '0', null, null);
INSERT INTO `s_star_backup_member` VALUES ('4', '6', '1', '0', '0', '0', '0', '0', null, null);
INSERT INTO `s_star_backup_member` VALUES ('5', '6', '2', '0', '0', '0', '0', '0', null, null);
INSERT INTO `s_star_backup_member` VALUES ('6', '6', '3', '0', '0', '0', '5', '5', null, null);
INSERT INTO `s_star_backup_member` VALUES ('7', '6', '4', '0', '0', '0', '0', '0', null, null);
INSERT INTO `s_star_backup_member` VALUES ('8', '3', '1', '0', '0', '0', '0', '0', '1635393261', '1635393261');
INSERT INTO `s_star_backup_member` VALUES ('9', '5', '1', '0', '0', '0', '0', '0', '1635393344', '1635393344');

-- ----------------------------
-- Table structure for s_star_entourage
-- ----------------------------
DROP TABLE IF EXISTS `s_star_entourage`;
CREATE TABLE `s_star_entourage` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '明星的id',
  `job` tinyint(4) DEFAULT NULL COMMENT '职位/角色  \r\n1=>艺人经纪人 \r\n2=>艺人助理 \r\n3=>艺人造型师 \r\n4=>艺人文宣',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '名字',
  `head` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '头像',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='明星随从表';

-- ----------------------------
-- Records of s_star_entourage
-- ----------------------------
INSERT INTO `s_star_entourage` VALUES ('1', '5', '1', '张大山', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, null);
INSERT INTO `s_star_entourage` VALUES ('2', '5', '2', '李四', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, null);
INSERT INTO `s_star_entourage` VALUES ('3', '2', '1', '666', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, null);
INSERT INTO `s_star_entourage` VALUES ('4', '6', '1', '2233', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, null);
INSERT INTO `s_star_entourage` VALUES ('5', '2', '2', '666', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, null);
INSERT INTO `s_star_entourage` VALUES ('6', '2', '3', '打托撒', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, null);
INSERT INTO `s_star_entourage` VALUES ('7', '2', '4', '强强', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, null);
INSERT INTO `s_star_entourage` VALUES ('8', '5', '3', '李四', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, null);
INSERT INTO `s_star_entourage` VALUES ('9', '5', '4', '李武', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, null);
INSERT INTO `s_star_entourage` VALUES ('10', '2', '1', '武大', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, null);
INSERT INTO `s_star_entourage` VALUES ('11', '2', '2', '无二', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, null);
INSERT INTO `s_star_entourage` VALUES ('12', '2', '3', '五三', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, null);
INSERT INTO `s_star_entourage` VALUES ('13', '2', '4', '武器', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', null, null);
INSERT INTO `s_star_entourage` VALUES ('14', '1', '1', '经纪', '经纪', '1636197498', '1636369644');
INSERT INTO `s_star_entourage` VALUES ('15', '1', '2', '助理', '助理', '1636197498', '1636369644');
INSERT INTO `s_star_entourage` VALUES ('16', '1', '3', '造型师', '造型师', '1636197498', '1636369644');
INSERT INTO `s_star_entourage` VALUES ('17', '1', '4', '文宣', '文宣', '1636197498', '1636369644');

-- ----------------------------
-- Table structure for s_star_fans_three
-- ----------------------------
DROP TABLE IF EXISTS `s_star_fans_three`;
CREATE TABLE `s_star_fans_three` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sb_id` int(11) DEFAULT NULL COMMENT '后援会id',
  `user_id` int(11) DEFAULT NULL COMMENT '后援会下粉丝,用户id',
  `money` decimal(10,2) DEFAULT '0.00' COMMENT '前三分的广告费用',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='后援会的前3个粉丝记录表';

-- ----------------------------
-- Records of s_star_fans_three
-- ----------------------------

-- ----------------------------
-- Table structure for s_star_program
-- ----------------------------
DROP TABLE IF EXISTS `s_star_program`;
CREATE TABLE `s_star_program` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) DEFAULT NULL COMMENT '1=>行程 2=>作品',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `banner` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '顶部图',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text COLLATE utf8_unicode_ci COMMENT '内容',
  `status` tinyint(4) DEFAULT '0' COMMENT '0=>保存 1=>发布',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='明星节目表';

-- ----------------------------
-- Records of s_star_program
-- ----------------------------
INSERT INTO `s_star_program` VALUES ('1', '1', '5', 'FqxuIqANDDdB8ZXPAOLAqn7TPDeS', '哈喽!大家好?', '<p>1986年至1991年，中华人民共和国在全国范围实行了六年夏令时，每年从4月中旬的第一个星期日2时整(北京时间)到9月中旬第一个星期日的凌晨2时整(北京夏令时)。除1986年因是实行夏令时的第一年，从5月4日开始到9月14日结束外，其它年份均按规定的时段施行。夏令时实施期间，将时间向后调快一小时。1992年4月5日后不再实行。</p>', '1', '1634374381', null);
INSERT INTO `s_star_program` VALUES ('2', '2', '5', 'FqxuIqANDDdB8ZXPAOLAqn7TPDeS', '哈喽!大家好?ljljll', '<p>1986年至1991年，中华人民共和国在全国范围实行了六年夏令时，每年从4月中旬的第一个星期日2时整(北京时间)到9月中旬第一个星期日的凌晨2时整(北京夏令时)。除1986年因是实行夏令时的第一年，从5月4日开始到9月14日结束外，其它年份均按规定的时段施行。夏令时实施期间，将时间向后调快一小时。1992年4月5日后不再实行。</p>', '1', '1634374381', null);

-- ----------------------------
-- Table structure for s_star_sort
-- ----------------------------
DROP TABLE IF EXISTS `s_star_sort`;
CREATE TABLE `s_star_sort` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `star_id` int(11) DEFAULT NULL COMMENT '明星的id',
  `sb_id` int(11) DEFAULT NULL COMMENT '后援会id',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='后援会月结记录表';

-- ----------------------------
-- Records of s_star_sort
-- ----------------------------
INSERT INTO `s_star_sort` VALUES ('1', '2', '12', '1635327635', null);
INSERT INTO `s_star_sort` VALUES ('2', '5', '6', '1632675600', null);
INSERT INTO `s_star_sort` VALUES ('3', '5', '11', '1632675600', null);
INSERT INTO `s_star_sort` VALUES ('4', '5', '9', '1632675600', null);
INSERT INTO `s_star_sort` VALUES ('5', '5', '10', '1632675600', null);
INSERT INTO `s_star_sort` VALUES ('6', '5', '13', '1632675600', null);
INSERT INTO `s_star_sort` VALUES ('7', '6', '7', '1635327635', null);
INSERT INTO `s_star_sort` VALUES ('8', '6', '2', '1635327635', null);
INSERT INTO `s_star_sort` VALUES ('9', '7', '3', '1635327635', null);
INSERT INTO `s_star_sort` VALUES ('10', '8', '8', '1635327635', null);
INSERT INTO `s_star_sort` VALUES ('11', '8', '4', '1635327635', null);
INSERT INTO `s_star_sort` VALUES ('12', '9', '5', '1635327635', null);
INSERT INTO `s_star_sort` VALUES ('13', '2', '12', '1635327976', null);
INSERT INTO `s_star_sort` VALUES ('14', '5', '6', '1635327976', null);
INSERT INTO `s_star_sort` VALUES ('15', '5', '11', '1635327976', null);
INSERT INTO `s_star_sort` VALUES ('16', '5', '9', '1635327976', null);
INSERT INTO `s_star_sort` VALUES ('17', '5', '10', '1635327976', null);
INSERT INTO `s_star_sort` VALUES ('18', '5', '13', '1635327976', null);
INSERT INTO `s_star_sort` VALUES ('19', '6', '7', '1635327976', null);
INSERT INTO `s_star_sort` VALUES ('20', '6', '2', '1635327976', null);
INSERT INTO `s_star_sort` VALUES ('21', '7', '3', '1635327976', null);
INSERT INTO `s_star_sort` VALUES ('22', '8', '8', '1635327976', null);
INSERT INTO `s_star_sort` VALUES ('23', '8', '4', '1635327976', null);
INSERT INTO `s_star_sort` VALUES ('24', '9', '5', '1635327976', null);
INSERT INTO `s_star_sort` VALUES ('25', '2', '12', '1635735500', null);
INSERT INTO `s_star_sort` VALUES ('26', '5', '6', '1635735500', null);
INSERT INTO `s_star_sort` VALUES ('27', '5', '11', '1635735500', null);
INSERT INTO `s_star_sort` VALUES ('28', '5', '9', '1635735500', null);
INSERT INTO `s_star_sort` VALUES ('29', '5', '10', '1635735500', null);
INSERT INTO `s_star_sort` VALUES ('30', '5', '13', '1635735500', null);
INSERT INTO `s_star_sort` VALUES ('31', '6', '7', '1635735500', null);
INSERT INTO `s_star_sort` VALUES ('32', '6', '2', '1635735500', null);
INSERT INTO `s_star_sort` VALUES ('33', '7', '3', '1635735500', null);
INSERT INTO `s_star_sort` VALUES ('34', '8', '8', '1635735500', null);
INSERT INTO `s_star_sort` VALUES ('35', '8', '4', '1635735500', null);
INSERT INTO `s_star_sort` VALUES ('36', '9', '5', '1635735500', null);
INSERT INTO `s_star_sort` VALUES ('37', '2', '12', '1635744358', null);
INSERT INTO `s_star_sort` VALUES ('43', '6', '7', '1635744358', null);
INSERT INTO `s_star_sort` VALUES ('44', '6', '2', '1635744358', null);
INSERT INTO `s_star_sort` VALUES ('45', '7', '3', '1635744358', null);
INSERT INTO `s_star_sort` VALUES ('46', '8', '8', '1635744358', null);
INSERT INTO `s_star_sort` VALUES ('47', '8', '4', '1635744358', null);
INSERT INTO `s_star_sort` VALUES ('48', '9', '5', '1635744358', null);

-- ----------------------------
-- Table structure for s_star_statistics
-- ----------------------------
DROP TABLE IF EXISTS `s_star_statistics`;
CREATE TABLE `s_star_statistics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(255) DEFAULT NULL COMMENT '1=>合作商家 2=>联盟卡销量 3=>粉丝量 4=>商品销量\r\n5=>粉丝分成 6=>联盟卡 7=>后援会成员 8=>推广商家数量\r\n9=>后援会综合\r\n10=>后援会贡献前3粉丝保留, 实时排行',
  `star_id` int(11) DEFAULT NULL COMMENT '明星id',
  `s_id` int(11) DEFAULT NULL COMMENT '后援会id',
  `divide` decimal(10,2) DEFAULT '0.00' COMMENT '后援会广告分成,\r\n',
  `card_number` int(11) DEFAULT '0' COMMENT '推广明星下联盟卡的数量',
  `fans_number` int(11) DEFAULT '0' COMMENT '粉丝数量',
  `business_number` int(11) DEFAULT '0' COMMENT '推广明星下联盟内的商家数量',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='统计图';

-- ----------------------------
-- Records of s_star_statistics
-- ----------------------------

-- ----------------------------
-- Table structure for s_union
-- ----------------------------
DROP TABLE IF EXISTS `s_union`;
CREATE TABLE `s_union` (
  `id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '创建者,用户id,',
  `type` tinyint(4) NOT NULL COMMENT '1=>明星联盟(只有明星才能创建明星联盟) 2=>商家联盟',
  `star_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT '[]' COMMENT '加入明星的id \r\n商家建立的明星联盟,可加入多个明星\r\n还是归属商家联盟\r\n是个json 后的数组\r\n针对type 为2',
  `u_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '联盟类别 id (s_union_class 表)  选定后,无法更改',
  `b_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联盟可加经营分类id (s_commodity_class 表 一级分类) 最多5个  字符串json',
  `only` int(11) DEFAULT NULL COMMENT 'ID 唯一码',
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联盟logo',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '联盟名字',
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联盟面向范围 也可选全国',
  `promote` int(11) DEFAULT '0' COMMENT '联盟促销次数（根据库存来进行确定）',
  `union_consumption` int(11) DEFAULT '0' COMMENT '联盟消费人数',
  `union_card_sell` int(11) DEFAULT '0' COMMENT '联盟卡销量',
  `union_sales` int(11) DEFAULT '0' COMMENT '联盟商品销量',
  `union_type` tinyint(4) NOT NULL COMMENT '联盟分类:1=>线上 2=>线下 3=>综合(上下线都有)',
  `business_number` int(11) DEFAULT '0' COMMENT '加盟商家数量 (满5个,发布联盟或者一周内自动发布)',
  `status` tinyint(4) DEFAULT '0' COMMENT '0=>招募状态(c端不可见) 1=>联盟发布(c端可见)',
  `union_card_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联盟卡名字',
  `union_card_logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联盟卡logo',
  `union_card_price` decimal(10,2) DEFAULT NULL COMMENT '联盟卡价格',
  `union_card_discount` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '联盟卡的折扣百分比',
  `union_card_divide` int(11) DEFAULT NULL COMMENT '联盟当前分成（不超过设定联盟卡价格）\r\n用户推广,给的分佣',
  `union_card_number` int(11) DEFAULT NULL COMMENT '联盟卡使用次数',
  `union_card_style` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '联盟卡样式',
  `union_card_exchange` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '线上联盟卡,一串字符串',
  `union_card_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '线下联盟卡,一个二维码',
  `introduce` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '联盟简介',
  `is_display` tinyint(4) DEFAULT '1' COMMENT '后台操作,商家显示 1=>显示  0=>不显示',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='联盟表';

-- ----------------------------
-- Records of s_union
-- ----------------------------
INSERT INTO `s_union` VALUES ('1', '5', '1', '[]', '1', null, '24032376', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '李云龙明星联盟', '石家庄市', null, '0', '5', '5', '1', '1', '1', '联盟卡名字(美食类)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '20.00', '5', null, '10', '#000000', '123', null, '<p>联盟介绍</p>', '1', '1631150485', null);
INSERT INTO `s_union` VALUES ('2', '6', '1', '[]', '2', null, '240323765', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '二英长明星联盟', '北京市', null, '0', '4', '1', '2', '6', '1', '联盟卡名字(健身类)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '10.00', '5', null, '1', '#000000', null, 'Fr67cUhXF1FHcBIUyhgUU_zq5e3L', '<p>联盟介绍</p>', '1', '1631150485', null);
INSERT INTO `s_union` VALUES ('3', '7', '1', '[]', '3', null, '240323767', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '和尚明星联盟', '东北', null, '0', '6', '3', '3', '9', '1', '联盟卡名字(娱乐类)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '10.00', '5', null, '1', '#000000', null, 'Fr67cUhXF1FHcBIUyhgUU_zq5e3L', '<p>联盟介绍</p>', '1', '1631150485', null);
INSERT INTO `s_union` VALUES ('4', '8', '1', '[]', '4', null, '240323768', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '春晓明星联盟', '上海', null, '0', '9', '7', '2', '5', '1', '联盟卡名字(旅游类)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '10.00', '5', null, '1', '#000000', null, 'Fr67cUhXF1FHcBIUyhgUU_zq5e3L', '<p>联盟介绍</p>', '1', '1631150485', null);
INSERT INTO `s_union` VALUES ('5', '9', '1', '[]', '5', null, '240323769', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '悯农明星联盟', '深圳', null, '0', '8', '9', '1', '4', '1', '联盟卡名字(母婴类)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '10.00', '5', null, '1', '#000000', '123', null, '<p>联盟介绍</p>', '1', '1631150485', null);
INSERT INTO `s_union` VALUES ('6', '1', '2', '[]', '10', null, '240323760', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '礼拜一联盟', null, null, '0', '5', '9', '1', '4', '1', '联盟卡名字(亲子类)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '10.00', '5', null, '1', '#000000', '123', null, '<p>联盟介绍</p>', '1', '1631150400', null);
INSERT INTO `s_union` VALUES ('7', '1', '2', '[1]', '9', null, '124032376', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '礼拜二联盟', null, null, '0', '5', '9', '1', '4', '1', '联盟卡名字(宠物类)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '10.00', '5', null, '1', '#000000', '123', null, '<p>联盟介绍</p>', '1', '1631150400', null);
INSERT INTO `s_union` VALUES ('8', '1', '2', '[]', '8', null, '224032376', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '礼拜三联盟', null, null, '0', '7', '9', '2', '4', '1', '联盟卡名字(婚庆类)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '10.00', '5', null, '1', '#000000', '123', null, '<p>联盟介绍</p>', '1', '1631150400', null);
INSERT INTO `s_union` VALUES ('9', '1', '2', '[]', '11', null, '324032376', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '礼拜四联盟', null, null, '0', '9', '9', '2', '4', '1', '联盟卡名字(家装类)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '10.00', '5', null, '1', '#000000', '123', null, '<p>联盟介绍</p>', '1', '1631150400', null);
INSERT INTO `s_union` VALUES ('10', '1', '2', '[]', '7', null, '424032376', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '礼拜五联盟', null, null, '0', '1', '9', '3', '4', '1', '联盟卡名字(学习类)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '10.00', '5', null, '1', '#000000', '123', null, '<p>联盟介绍</p>', '1', '1631150400', null);
INSERT INTO `s_union` VALUES ('11', '1', '2', '[]', '6', '', '524032376', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '礼拜六联盟', null, null, '0', '2', '9', '3', '4', '1', '联盟卡名字(美容类)', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '10.20', '5', null, '1', '#000000', '123', null, '<p>联盟介绍</p>', '1', '1631150400', null);

-- ----------------------------
-- Table structure for s_union_attract_investment
-- ----------------------------
DROP TABLE IF EXISTS `s_union_attract_investment`;
CREATE TABLE `s_union_attract_investment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `u_id` int(11) NOT NULL COMMENT '发布的联盟id (s_union 表)',
  `user_id` int(11) DEFAULT NULL COMMENT '联盟盟主id 待定',
  `logo` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '招揽的logo',
  `examine` tinyint(255) DEFAULT NULL COMMENT '审核 0=>手动审核 1=>自动加入',
  `join_mode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '加入模式: 0=>联盟给商家钱 1=>商家给联盟钱 2=>免费',
  `join_cost` decimal(10,2) DEFAULT '0.00' COMMENT '加入费用 根据join_mode字段',
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联盟地址要求',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `u_id` (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='联盟主发布招揽需求';

-- ----------------------------
-- Records of s_union_attract_investment
-- ----------------------------

-- ----------------------------
-- Table structure for s_union_business
-- ----------------------------
DROP TABLE IF EXISTS `s_union_business`;
CREATE TABLE `s_union_business` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `u_id` int(11) DEFAULT NULL COMMENT '联盟id (s_union 表)',
  `b_id` int(11) DEFAULT NULL COMMENT '商家 id (s_business 表)',
  `type` tinyint(4) DEFAULT NULL COMMENT '1=>明星联盟 2=>商家联盟',
  `creat_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='联盟内的商家';

-- ----------------------------
-- Records of s_union_business
-- ----------------------------
INSERT INTO `s_union_business` VALUES ('1', '6', '1', '2', null, null);
INSERT INTO `s_union_business` VALUES ('2', '6', '2', '2', null, null);
INSERT INTO `s_union_business` VALUES ('3', '8', '3', '2', null, null);
INSERT INTO `s_union_business` VALUES ('4', '8', '4', '2', null, null);
INSERT INTO `s_union_business` VALUES ('5', '7', '5', '2', null, null);
INSERT INTO `s_union_business` VALUES ('6', '7', '6', '2', null, null);
INSERT INTO `s_union_business` VALUES ('7', '11', '7', '2', null, null);
INSERT INTO `s_union_business` VALUES ('8', '11', '8', '2', null, null);
INSERT INTO `s_union_business` VALUES ('9', '1', '9', '1', null, null);
INSERT INTO `s_union_business` VALUES ('10', '1', '10', '1', null, null);
INSERT INTO `s_union_business` VALUES ('11', '1', '11', '1', null, null);
INSERT INTO `s_union_business` VALUES ('12', '2', '12', '1', null, null);
INSERT INTO `s_union_business` VALUES ('13', '2', '13', '1', null, null);
INSERT INTO `s_union_business` VALUES ('14', '3', '14', '1', null, null);
INSERT INTO `s_union_business` VALUES ('15', '3', '15', '1', null, null);

-- ----------------------------
-- Table structure for s_union_card_style
-- ----------------------------
DROP TABLE IF EXISTS `s_union_card_style`;
CREATE TABLE `s_union_card_style` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) DEFAULT NULL COMMENT '1=>默认 2=>纯色选择 3=>特殊选择',
  `content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='联盟卡的样式';

-- ----------------------------
-- Records of s_union_card_style
-- ----------------------------
INSERT INTO `s_union_card_style` VALUES ('1', '1', '#000000', null, null);
INSERT INTO `s_union_card_style` VALUES ('2', '2', '#2682b0', null, null);
INSERT INTO `s_union_card_style` VALUES ('3', '2', '#8d0fc4', null, null);

-- ----------------------------
-- Table structure for s_union_class
-- ----------------------------
DROP TABLE IF EXISTS `s_union_class`;
CREATE TABLE `s_union_class` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '分类标题',
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '小logo',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='联盟类别表';

-- ----------------------------
-- Records of s_union_class
-- ----------------------------
INSERT INTO `s_union_class` VALUES ('1', '美食类', 'https://alifei02.cfp.cn/creative/vcg/veer/800water/veer-353324011.jpg', null, null);
INSERT INTO `s_union_class` VALUES ('2', '健身类', 'https://alifei02.cfp.cn/creative/vcg/veer/800water/veer-353324011.jpg', null, null);
INSERT INTO `s_union_class` VALUES ('3', '娱乐类', 'https://alifei02.cfp.cn/creative/vcg/veer/800water/veer-353324011.jpg', null, null);
INSERT INTO `s_union_class` VALUES ('4', '旅游类', 'https://alifei02.cfp.cn/creative/vcg/veer/800water/veer-353324011.jpg', null, null);
INSERT INTO `s_union_class` VALUES ('5', '母婴类', 'https://alifei02.cfp.cn/creative/vcg/veer/800water/veer-353324011.jpg', null, null);
INSERT INTO `s_union_class` VALUES ('6', '美容类', 'https://alifei02.cfp.cn/creative/vcg/veer/800water/veer-353324011.jpg', null, null);
INSERT INTO `s_union_class` VALUES ('7', '学习类', 'https://alifei02.cfp.cn/creative/vcg/veer/800water/veer-353324011.jpg', null, null);
INSERT INTO `s_union_class` VALUES ('8', '婚庆类', 'https://alifei02.cfp.cn/creative/vcg/veer/800water/veer-353324011.jpg', null, null);
INSERT INTO `s_union_class` VALUES ('9', '宠物类', 'https://alifei02.cfp.cn/creative/vcg/veer/800water/veer-353324011.jpg', null, null);
INSERT INTO `s_union_class` VALUES ('10', '亲子类', 'https://alifei02.cfp.cn/creative/vcg/veer/800water/veer-353324011.jpg', null, null);
INSERT INTO `s_union_class` VALUES ('11', '家装类', 'https://alifei02.cfp.cn/creative/vcg/veer/800water/veer-353324011.jpg', null, null);
INSERT INTO `s_union_class` VALUES ('12', '商场类', 'https://alifei02.cfp.cn/creative/vcg/veer/800water/veer-353324011.jpg', null, null);

-- ----------------------------
-- Table structure for s_union_commodity
-- ----------------------------
DROP TABLE IF EXISTS `s_union_commodity`;
CREATE TABLE `s_union_commodity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `u_id` int(11) DEFAULT NULL COMMENT '联盟id (s_union 表)',
  `b_id` int(11) DEFAULT NULL COMMENT '商家的id (s_business 表)',
  `cs_id` int(11) DEFAULT NULL COMMENT '商品的id',
  `only` int(11) DEFAULT NULL COMMENT '商品ID',
  `c_id` int(11) DEFAULT NULL COMMENT '商品分类 (s_commodity_class表)',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品标题',
  `title_img` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品标题,图片 5个图片合1个json',
  `details` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品详情,图片 5个图片合1个json',
  `original_price` decimal(10,2) DEFAULT NULL COMMENT '原有价格',
  `favorable_price` decimal(10,2) DEFAULT NULL COMMENT '优惠价格',
  `stock` int(255) DEFAULT NULL COMMENT '库存 同步 s_commodity 表库存(为主)',
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '网址',
  `api_link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品api接口  线上 才有这个',
  `status` tinyint(4) DEFAULT '0' COMMENT '0=>审核中  1=>审核通过 2=>审核失败',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `u_id` (`u_id`),
  KEY `c_id` (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='联盟商品表';

-- ----------------------------
-- Records of s_union_commodity
-- ----------------------------
INSERT INTO `s_union_commodity` VALUES ('1', '6', '1', '9', '12113456', '3', '四五六一', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '0', null, null);
INSERT INTO `s_union_commodity` VALUES ('2', '6', '1', '10', '12345612', '3', '四五六一', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '0', null, null);
INSERT INTO `s_union_commodity` VALUES ('3', '7', '5', '11', '12345612', '3', '四五六九三', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '0', null, null);
INSERT INTO `s_union_commodity` VALUES ('4', '7', '5', '10', '12345612', '1', '四五六九二2', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '0', null, null);
INSERT INTO `s_union_commodity` VALUES ('5', '7', '5', '12', '12345612', '1', '四五六九四', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '0', null, null);
INSERT INTO `s_union_commodity` VALUES ('6', '3', '15', '15', '12345624', '1', '四五六九六', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '[ \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\", \"uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg\"]', '100.00', '75.00', '100', null, null, '0', null, null);

-- ----------------------------
-- Table structure for s_union_vote
-- ----------------------------
DROP TABLE IF EXISTS `s_union_vote`;
CREATE TABLE `s_union_vote` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `star_id` int(11) DEFAULT NULL COMMENT '艺人id',
  `un_id` int(11) DEFAULT NULL COMMENT '分类id(s_union_class 表)',
  `votes` int(11) DEFAULT '0' COMMENT '投票数',
  `status` tinyint(255) DEFAULT '0' COMMENT '0=>投票持续中 1=>结束',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='艺人详情,类别投票记录表';

-- ----------------------------
-- Records of s_union_vote
-- ----------------------------
INSERT INTO `s_union_vote` VALUES ('2', '5', '1', '10', '0', '1633064935', '1635734842');
INSERT INTO `s_union_vote` VALUES ('3', '5', '2', '75', '0', '1633064935', null);
INSERT INTO `s_union_vote` VALUES ('4', '5', '3', '25', '0', '1633064935', '1635744077');
INSERT INTO `s_union_vote` VALUES ('5', '5', '4', '66', '0', '1633064935', '1635744079');
INSERT INTO `s_union_vote` VALUES ('6', '5', '5', '5', '0', '1633064935', '1635744081');
INSERT INTO `s_union_vote` VALUES ('7', '5', '6', '54', '0', '1633064935', '1635744084');
INSERT INTO `s_union_vote` VALUES ('8', '5', '7', '47', '0', '1633064935', '1635744087');
INSERT INTO `s_union_vote` VALUES ('9', '1', '7', '4', '0', '1633064935', '1635744309');

-- ----------------------------
-- Table structure for s_union_vote_log
-- ----------------------------
DROP TABLE IF EXISTS `s_union_vote_log`;
CREATE TABLE `s_union_vote_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `star_id` int(11) NOT NULL COMMENT '明星id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `un_id` int(11) DEFAULT NULL COMMENT '投的id',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='投票关系表,一期投票结束,清空表';

-- ----------------------------
-- Records of s_union_vote_log
-- ----------------------------

-- ----------------------------
-- Table structure for s_user
-- ----------------------------
DROP TABLE IF EXISTS `s_user`;
CREATE TABLE `s_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL COMMENT '上级',
  `money` decimal(10,2) DEFAULT '0.00' COMMENT '账户余额',
  `frozen_money` decimal(10,2) DEFAULT '0.00' COMMENT '冻结的交易金额',
  `promotion_money` decimal(10,2) DEFAULT '0.00' COMMENT '促销预付金',
  `phone` varchar(20) CHARACTER SET utf8 DEFAULT '' COMMENT '手机号（账号）',
  `pwd` varchar(255) COLLATE utf8_unicode_ci DEFAULT '#>_<#73b13b8b4d767f6c3c2953f123d1a721' COMMENT '密码',
  `name_num` int(1) DEFAULT '1' COMMENT '昵称修改次数 1次',
  `nickname` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '昵称',
  `head_num` int(1) DEFAULT '1' COMMENT '头像修改次数 1次',
  `head` varchar(255) CHARACTER SET utf8 DEFAULT 'storage/moren.jpg' COMMENT '头像',
  `is_b_user` tinyint(4) DEFAULT '0' COMMENT 'b 端 0=>游客 1=>正式用户',
  `is_c_user` tinyint(4) DEFAULT '0' COMMENT 'c 端 0=>游客 1=>正式用户',
  `is_business` tinyint(4) DEFAULT '0' COMMENT '商家  0=>否  1=>是  (b端角色)',
  `is_union` tinyint(4) DEFAULT '0' COMMENT '联盟 0=>不是 1=>是  (b端角色,只针对商家建立的联盟,不针对明星联盟)',
  `is_star` tinyint(4) DEFAULT '0' COMMENT '明星 0=>否 1=>是明星角色,未认证  2=>已认证的\r\n(b c 端角色公用,c端成为明星后b端也是了)',
  `is_president` tinyint(4) DEFAULT '0' COMMENT '后援会长 0=>不是 1=>是 (c端角色)',
  `is_company` tinyint(4) DEFAULT '0' COMMENT '经纪公司  0=>否 1=>是 (c 端角色)',
  `only` int(11) DEFAULT NULL COMMENT 'ID号 唯一标识id',
  `login_time` int(11) DEFAULT NULL COMMENT '最后登录时间',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '待定  1=>c端用户 2=>b端用户 3=>两端都有(拥有了明星角色后 )',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户表';

-- ----------------------------
-- Records of s_user
-- ----------------------------
INSERT INTO `s_user` VALUES ('1', null, '100.00', '0.00', '0.00', '18332255387', '#>_<#73b13b8b4d767f6c3c2953f123d1a721', '1', '秦时明月', '1', 'storage/moren.jpg', '0', '0', '0', '0', '1', '0', '0', '88475887', '1628472051', '1632902355', '1636420824', null);
INSERT INTO `s_user` VALUES ('2', null, '85.00', '15.00', '0.00', '18332255381', '#>_<#73b13b8b4d767f6c3c2953f123d1a721', '1', '玲珑是否', '1', 'storage/moren.jpg', '0', '0', '0', '0', '1', '0', '0', '79917388', '1636420851', '1632473471', null, null);
INSERT INTO `s_user` VALUES ('3', null, '89.00', '11.00', '0.00', '18332255382', '#>_<#73b13b8b4d767f6c3c2953f123d1a721', '1', '啦啦啦', '1', 'storage/moren.jpg', '0', '0', '0', '0', '0', '0', '0', '73846287', '1636420851', '1632473471', null, null);
INSERT INTO `s_user` VALUES ('4', null, '100.00', '0.00', '0.00', '18332255383', '#>_<#73b13b8b4d767f6c3c2953f123d1a721', '1', 'BBQ', '1', 'storage/moren.jpg', '0', '0', '0', '0', '0', '0', '0', '44750255', '1636420851', '1632473471', null, null);
INSERT INTO `s_user` VALUES ('5', null, '100.00', '0.00', '0.00', '18332255389', '#>_<#73b13b8b4d767f6c3c2953f123d1a721', '1', '石玲珑', '1', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '0', '0', '0', '0', '1', '0', '0', '38202508', '1636420851', '1632473471', null, null);
INSERT INTO `s_user` VALUES ('6', null, '100.00', '0.00', '0.00', '18332255388', '#>_<#73b13b8b4d767f6c3c2953f123d1a721', '1', '史泰龙', '1', 'storage/moren.jpg', '0', '0', '0', '0', '1', '0', '0', '14879635', '1636420851', '1632473471', null, null);
INSERT INTO `s_user` VALUES ('7', null, '0.00', '0.00', '0.00', '18332255387', '#>_<#73b13b8b4d767f6c3c2953f123d1a721', '1', '史迪龙', '1', 'storage/moren.jpg', '0', '0', '0', '0', '1', '0', '0', '89299399', '1636420851', '1632473471', null, null);
INSERT INTO `s_user` VALUES ('8', null, '0.00', '0.00', '0.00', '18332255386', '#>_<#73b13b8b4d767f6c3c2953f123d1a721', '1', '利郎', '1', 'storage/moren.jpg', '0', '0', '0', '0', '1', '0', '0', '97311626', '1636420851', '1632473471', null, null);
INSERT INTO `s_user` VALUES ('9', null, '0.00', '0.00', '0.00', '18332255385', '#>_<#73b13b8b4d767f6c3c2953f123d1a721', '1', '张惠美', '1', 'storage/moren.jpg', '0', '0', '0', '0', '1', '0', '0', '42074346', '1636420851', '1632452569', '1632452569', null);
INSERT INTO `s_user` VALUES ('10', null, '0.00', '0.00', '0.00', '18332255384', '#>_<#73b13b8b4d767f6c3c2953f123d1a721', '1', '微凉', '1', 'uploads/home/img/20211025/d33eb9c61ad5e0ade994dd7999ab13f8.jpg', '0', '0', '0', '0', '1', '0', '0', '52010241', '1636420851', '1632473471', '1632473471', null);
INSERT INTO `s_user` VALUES ('11', null, '0.00', '0.00', '0.00', '18332255379', '#>_<#73b13b8b4d767f6c3c2953f123d1a721', '1', '若溪', '1', 'storage/moren.jpg', '0', '0', '0', '0', '1', '0', '0', '59430328', '1636420851', '1632473536', '1632473536', null);
INSERT INTO `s_user` VALUES ('12', null, '0.00', '0.00', '0.00', '18332255378', '#>_<#73b13b8b4d767f6c3c2953f123d1a721', '1', '暖阳', '1', 'storage/moren.jpg', '0', '0', '0', '0', '1', '0', '0', '34051214', '1636420851', '1632473540', '1632473540', null);
INSERT INTO `s_user` VALUES ('13', null, '0.00', '0.00', '0.00', '18332255377', '#>_<#73b13b8b4d767f6c3c2953f123d1a721', '1', '沧澜', '1', 'storage/moren.jpg', '0', '0', '0', '0', '1', '0', '0', '41593701', '1636420851', '1632473543', '1632473543', null);

-- ----------------------------
-- Table structure for s_user_collection
-- ----------------------------
DROP TABLE IF EXISTS `s_user_collection`;
CREATE TABLE `s_user_collection` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `obj_type` tinyint(4) DEFAULT NULL COMMENT '1=>店铺(s_business) \r\n2=>明星(s_user)',
  `obj_id` int(11) DEFAULT NULL COMMENT '根据obj_type 来的',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户收藏表';

-- ----------------------------
-- Records of s_user_collection
-- ----------------------------
INSERT INTO `s_user_collection` VALUES ('1', '1', '1', '1', null, null);
INSERT INTO `s_user_collection` VALUES ('2', '1', '1', '2', null, null);
INSERT INTO `s_user_collection` VALUES ('3', '1', '1', '3', null, null);
INSERT INTO `s_user_collection` VALUES ('17', '1', '2', '2', '1634203022', '1634203022');
INSERT INTO `s_user_collection` VALUES ('18', '1', '2', '1', '1634203041', '1634203041');
INSERT INTO `s_user_collection` VALUES ('21', '1', '2', '7', '1634203053', '1634203053');
INSERT INTO `s_user_collection` VALUES ('22', '1', '2', '8', '1634203055', '1634203055');
INSERT INTO `s_user_collection` VALUES ('23', '1', '2', '5', '1634371382', '1634371382');

-- ----------------------------
-- Table structure for s_user_footprint
-- ----------------------------
DROP TABLE IF EXISTS `s_user_footprint`;
CREATE TABLE `s_user_footprint` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `obj_type` tinyint(4) DEFAULT NULL COMMENT '1=>联盟(s_union) 2=>店铺(s_business) 3=>明星(s_user表)',
  `obj_id` int(11) DEFAULT NULL COMMENT '根据obj_type 来的 id',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `day` date DEFAULT NULL COMMENT '那天留的足迹',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户足迹表';

-- ----------------------------
-- Records of s_user_footprint
-- ----------------------------
INSERT INTO `s_user_footprint` VALUES ('2', '1', '2', '1', '2021-11-01', null, null);
INSERT INTO `s_user_footprint` VALUES ('6', '1', '6', '1', '2021-11-02', null, null);
INSERT INTO `s_user_footprint` VALUES ('7', '2', '1', '1', '2021-11-01', null, null);
INSERT INTO `s_user_footprint` VALUES ('8', '2', '2', '1', '2021-11-01', null, null);
INSERT INTO `s_user_footprint` VALUES ('9', '2', '3', '1', '2021-11-02', null, null);
INSERT INTO `s_user_footprint` VALUES ('10', '2', '4', '1', '2021-11-02', null, null);
INSERT INTO `s_user_footprint` VALUES ('11', '2', '5', '1', '2021-11-02', null, null);
INSERT INTO `s_user_footprint` VALUES ('12', '3', '1', '1', '2021-11-01', null, null);
INSERT INTO `s_user_footprint` VALUES ('13', '3', '2', '1', '2021-11-01', null, null);
INSERT INTO `s_user_footprint` VALUES ('14', '3', '3', '1', '2021-11-01', null, null);
INSERT INTO `s_user_footprint` VALUES ('15', '3', '5', '1', '2021-11-02', null, null);
INSERT INTO `s_user_footprint` VALUES ('16', '2', '5', '1', '2021-11-02', null, null);
INSERT INTO `s_user_footprint` VALUES ('17', '1', '1', '1', '2021-11-02', null, null);
INSERT INTO `s_user_footprint` VALUES ('18', '3', '5', '1', '2021-11-04', null, null);
INSERT INTO `s_user_footprint` VALUES ('19', '3', '5', '1', '2021-11-06', null, null);
INSERT INTO `s_user_footprint` VALUES ('20', '3', '5', '1', '2021-11-06', null, null);
INSERT INTO `s_user_footprint` VALUES ('21', '3', '5', '1', '2021-11-06', null, null);

-- ----------------------------
-- Table structure for s_user_qrcode
-- ----------------------------
DROP TABLE IF EXISTS `s_user_qrcode`;
CREATE TABLE `s_user_qrcode` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) DEFAULT NULL COMMENT '1=>c 端 联盟卡推广二维码\r\n2=>c 端 平台推广码',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `img` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '二维码链接',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户二维码表';

-- ----------------------------
-- Records of s_user_qrcode
-- ----------------------------
INSERT INTO `s_user_qrcode` VALUES ('1', '2', '1', 'qrcode/pttgc/1636434529994.png', '1636434529', '1636434529');
INSERT INTO `s_user_qrcode` VALUES ('2', '1', '1', 'qrcode/lmtg/1636450893208.png', '1636450893', '1636450893');

-- ----------------------------
-- Table structure for s_user_search_records
-- ----------------------------
DROP TABLE IF EXISTS `s_user_search_records`;
CREATE TABLE `s_user_search_records` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `type` tinyint(4) DEFAULT NULL COMMENT '1=>c端,首页,搜索里的选择城市的浏览记录\r\n2=>c端,首页,搜索里的商品记录 \r\n3=>c端,首页,搜索里 推荐内容 存储最后一次进入商品详情的分类,(商品分类(s_commodity_class表 的 id), 来推荐分类下的商品\r\n4=>b 端, 首页 店铺认证 搜索 经营分类记录\r\n\r\n(在哪个位置搜索的)',
  `content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '内容',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户搜索/浏览记录';

-- ----------------------------
-- Records of s_user_search_records
-- ----------------------------
INSERT INTO `s_user_search_records` VALUES ('32', '1', '1', '北京市', '1632730839', '1632730839');
INSERT INTO `s_user_search_records` VALUES ('35', '1', '2', '四fsdf', '1632730845', '1632730845');
INSERT INTO `s_user_search_records` VALUES ('36', '1', '1', '菏泽市', '1632730862', '1632730862');
INSERT INTO `s_user_search_records` VALUES ('37', '1', '2', '四fsdf34', '1632730862', '1632730862');
INSERT INTO `s_user_search_records` VALUES ('38', '1', '1', '石家庄市', '1632731941', '1632731941');
INSERT INTO `s_user_search_records` VALUES ('39', '1', '2', '四', '1632731948', '1632731948');
INSERT INTO `s_user_search_records` VALUES ('42', '1', '3', '1', '1632734116', '1634712140');
INSERT INTO `s_user_search_records` VALUES ('43', '1', '2', '', '1634199947', '1634199947');
INSERT INTO `s_user_search_records` VALUES ('44', '1', '2', '史', '1634200625', '1634200625');

-- ----------------------------
-- Table structure for s_user_union_card
-- ----------------------------
DROP TABLE IF EXISTS `s_user_union_card`;
CREATE TABLE `s_user_union_card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `u_id` int(11) NOT NULL COMMENT '联盟的id (s_union 表)',
  `frequency` int(11) NOT NULL DEFAULT '1' COMMENT '联盟卡剩余使用次数',
  `status` tinyint(4) DEFAULT '0' COMMENT '0=>未使用 1=>已使用',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户购买联盟卡表';

-- ----------------------------
-- Records of s_user_union_card
-- ----------------------------
INSERT INTO `s_user_union_card` VALUES ('1', '1', '6', '0', '1', null, '1634287613');
INSERT INTO `s_user_union_card` VALUES ('2', '1', '2', '1', '0', null, null);
INSERT INTO `s_user_union_card` VALUES ('3', '1', '3', '1', '0', null, null);
INSERT INTO `s_user_union_card` VALUES ('4', '1', '4', '1', '0', null, null);
INSERT INTO `s_user_union_card` VALUES ('5', '1', '5', '1', '0', null, null);
INSERT INTO `s_user_union_card` VALUES ('6', '1', '1', '10', '0', '1634289249', '1634289249');

-- ----------------------------
-- Table structure for s_user_vip
-- ----------------------------
DROP TABLE IF EXISTS `s_user_vip`;
CREATE TABLE `s_user_vip` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `establish_frequency` int(11) NOT NULL COMMENT '建立联盟次数',
  `join_frequency` int(11) NOT NULL COMMENT '加入联盟次数',
  `status` tinyint(4) DEFAULT NULL COMMENT '0=>使用中 1=>使用完了 (待定)',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户购买平台会员';

-- ----------------------------
-- Records of s_user_vip
-- ----------------------------

-- ----------------------------
-- Table structure for s_z_admin
-- ----------------------------
DROP TABLE IF EXISTS `s_z_admin`;
CREATE TABLE `s_z_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户账号',
  `pwd` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '密码',
  `head` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '头像',
  `nickname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '昵称',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='后台管理员表';

-- ----------------------------
-- Records of s_z_admin
-- ----------------------------

-- ----------------------------
-- Table structure for s_z_apk
-- ----------------------------
DROP TABLE IF EXISTS `s_z_apk`;
CREATE TABLE `s_z_apk` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) DEFAULT NULL COMMENT '1=>c 端 2=>b 端',
  `client_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1=>Android  2=>IOS',
  `server_version` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'app版本号',
  `app_link` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT 'App链接',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='app 安装包';

-- ----------------------------
-- Records of s_z_apk
-- ----------------------------
INSERT INTO `s_z_apk` VALUES ('1', '1', '1', '1.0.0', 'https://www.baidu.com/', null, null);
INSERT INTO `s_z_apk` VALUES ('2', '1', '2', '1.0.0', 'https://www.baidu.com/', null, null);
INSERT INTO `s_z_apk` VALUES ('3', '2', '1', '1.0.0', 'https://www.baidu.com/', null, null);
INSERT INTO `s_z_apk` VALUES ('4', '2', '2', '1.0.0', 'https://www.baidu.com/', null, null);

-- ----------------------------
-- Table structure for s_z_divide
-- ----------------------------
DROP TABLE IF EXISTS `s_z_divide`;
CREATE TABLE `s_z_divide` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `platform` decimal(10,2) DEFAULT NULL COMMENT '平台分成',
  `star` decimal(10,2) DEFAULT NULL COMMENT '明星分成',
  `company` decimal(10,2) DEFAULT NULL COMMENT '经纪公司分成',
  `backup` decimal(10,2) DEFAULT NULL COMMENT '后援会',
  `backup_p` decimal(10,2) DEFAULT NULL COMMENT '后援会会长',
  `one` decimal(10,2) DEFAULT NULL COMMENT '粉丝分成:第一粉丝',
  `two` decimal(10,2) DEFAULT NULL COMMENT '粉丝分成:第二粉丝',
  `three` decimal(10,0) DEFAULT NULL COMMENT '粉丝分成:第三粉丝',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='设置广告分成,各种分成';

-- ----------------------------
-- Records of s_z_divide
-- ----------------------------
INSERT INTO `s_z_divide` VALUES ('1', '明星后援会广告分成', '10.00', '30.00', '10.00', '20.00', '30.00', '15.00', '11.00', '9', null, null);
INSERT INTO `s_z_divide` VALUES ('2', '明星详情页广告费分成', '10.00', '40.00', '10.00', '10.00', '30.00', '10.00', '9.00', '6', null, null);

-- ----------------------------
-- Table structure for s_z_platform_revenue
-- ----------------------------
DROP TABLE IF EXISTS `s_z_platform_revenue`;
CREATE TABLE `s_z_platform_revenue` (
  `id` int(11) NOT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '1=>组建明星后援会广告分成费用\r\n2=>明星详情页广告费分成费用\r\n3=>用户总充值\r\n4=>用户购买联盟卡分成',
  `money` decimal(10,2) DEFAULT '0.00' COMMENT '分成',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='平台收入记录表';

-- ----------------------------
-- Records of s_z_platform_revenue
-- ----------------------------

-- ----------------------------
-- Table structure for s_z_set
-- ----------------------------
DROP TABLE IF EXISTS `s_z_set`;
CREATE TABLE `s_z_set` (
  `id` int(11) NOT NULL,
  `ad_day` int(11) DEFAULT NULL COMMENT '几号结上个月的广告费',
  `num` int(11) DEFAULT '10' COMMENT '1个用户最多建立后援会数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='设置';

-- ----------------------------
-- Records of s_z_set
-- ----------------------------
INSERT INTO `s_z_set` VALUES ('1', '3', '10');

-- ----------------------------
-- Table structure for s_z_start_auth
-- ----------------------------
DROP TABLE IF EXISTS `s_z_start_auth`;
CREATE TABLE `s_z_start_auth` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `three_syndromes_in_one` tinyint(4) DEFAULT NULL COMMENT '三证合一 0=>否 1=>是',
  `corporate_charter` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '营业执照-正面',
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '统一社会信用代码',
  `corporate_charter_term` tinyint(4) DEFAULT NULL COMMENT '营业执照期限 0=>无限 1=>有限',
  `corporate_charter_validity` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '营业执照的有效期  举例 2021-11-08',
  `education` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '学历图片',
  `work` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '工作证明图片',
  `identity_card_a` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '身份证-正面',
  `identity_card_b` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '身份证-反面',
  `identity_card_term` tinyint(4) DEFAULT NULL COMMENT '身份证期限 0=>无限 1=>有限',
  `identity_card_validity` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '身份证的有效期  举例 2016.8.20-2025.8.20',
  `resident_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '入驻人姓名',
  `identity_card` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '身份证号',
  `status` tinyint(4) DEFAULT '0' COMMENT '0=>待审 1=>成功 2=>失败',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='明星平台认证';

-- ----------------------------
-- Records of s_z_start_auth
-- ----------------------------
INSERT INTO `s_z_start_auth` VALUES ('1', '1', '0', null, '', '1', '2035-11-08', 'img', 'img', 'img', 'img', '1', '2035-11-08', '张三', '513436200011088915', '0', '1636354082', '1636355495');
