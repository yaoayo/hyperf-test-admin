/*
 Navicat MySQL Data Transfer

 Source Server         : 测试服务器
 Source Server Type    : MySQL
 Source Server Version : 50650
 Source Host           : 47.99.195.231:31414
 Source Schema         : agent

 Target Server Type    : MySQL
 Target Server Version : 50650
 File Encoding         : 65001

 Date: 13/03/2023 15:32:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ag_bill_remit_record
-- ----------------------------
DROP TABLE IF EXISTS `ag_bill_remit_record`;
CREATE TABLE `ag_bill_remit_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `bill_id` int(11) NOT NULL COMMENT '账单ID',
  `remit_method` smallint(6) NOT NULL COMMENT '交易方式，REMIT_METHOD字典',
  `remit_no` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '三方平台交易流水号',
  `remit_state` int(11) NULL DEFAULT NULL COMMENT '交易状态，REMIT_STATE枚举',
  `remit_amount` decimal(10, 2) NOT NULL COMMENT '打款金额',
  `receive_user` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收款人',
  `receive_idcard` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款人身份证号',
  `receive_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款卡绑定手机号',
  `receive_bank` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款银行',
  `receive_bank_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '收款卡号',
  `fail_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '失败原因',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ag_bill_remit_record_bill_id_index`(`bill_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '账单打款记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_bill_remit_record
-- ----------------------------
INSERT INTO `ag_bill_remit_record` VALUES (25, 11, 2, 'JHB1678344769422', 1, 0.50, '何益梅', '511325199811064960', '18380138680', '招商银行-银联IC普', '6214832838904527', NULL, '2023-03-09 14:52:49');
INSERT INTO `ag_bill_remit_record` VALUES (26, 11, 2, 'JHB1678345444391', 1, 0.50, '何益梅', '511325199811064960', '18380138680', '招商银行-银联IC普', '6214832838904527', NULL, '2023-03-09 15:04:04');
INSERT INTO `ag_bill_remit_record` VALUES (27, 11, 2, 'JHB1678346050782', 1, 0.50, '何益梅', '511325199811064960', '18380138680', '招商银行-银联IC普', '6214832838904527', NULL, '2023-03-09 15:14:10');
INSERT INTO `ag_bill_remit_record` VALUES (28, 11, 2, 'JHB1678346248896', 1, 0.50, '何益梅', '511325199811064960', '18380138680', '招商银行-银联IC普', '6214832838904527', NULL, '2023-03-09 15:17:28');
INSERT INTO `ag_bill_remit_record` VALUES (29, 11, 2, 'JHB1678346434668', 2, 0.50, '何益梅', '511325199811064960', '18380138680', '招商银行-银联IC普', '6214832838904527', '已发放', '2023-03-09 15:20:50');
INSERT INTO `ag_bill_remit_record` VALUES (30, 11, 2, 'JHB1678347021202', 2, 0.50, '何益梅', '511325199811064960', '18380138680', '招商银行-银联IC普', '6214832838904527', '已发放', '2023-03-09 15:30:38');
INSERT INTO `ag_bill_remit_record` VALUES (31, 10, 2, 'JHB1678348617715', 3, 1.99, '何益梅', '511325199811064960', '18381038680', '招商银行-银联IC普', '6214832838904528', '发放失败-002：银行账号不存在或账号有误', '2023-03-09 15:57:22');
INSERT INTO `ag_bill_remit_record` VALUES (32, 13, 2, 'JHB1678348652121', 3, 9.94, '何益梅', '511325199811064960', '18380138680', '招商银行-银联IC普', '6214832838904521', '发放失败-002：银行账号不存在或账号有误', '2023-03-09 15:57:58');
INSERT INTO `ag_bill_remit_record` VALUES (33, 10, 2, 'JHB1678349003966', 3, 1.99, '何益梅', '511325199811064960', '18381038680', '招商银行-银联IC普', '6214832838904528', '发放失败-002：银行账号不存在或账号有误', '2023-03-09 16:03:48');
INSERT INTO `ag_bill_remit_record` VALUES (34, 10, 2, 'JHB1678349221691', 2, 1.00, '何益梅', '511325199811064960', '18381038680', '招商银行-银联IC普卡-借记卡', '6214832838904527', '已发放', '2023-03-09 16:07:18');
INSERT INTO `ag_bill_remit_record` VALUES (35, 13, 2, 'JHB1678349222449', 2, 9.94, '何益梅', '511325199811064960', '18380138680', '招商银行-银联IC普卡-借记卡', '6214832838904527', '已发放', '2023-03-09 16:07:19');
INSERT INTO `ag_bill_remit_record` VALUES (36, 9, 2, 'JHB1678349940638', 3, 17.90, '何益梅', '511325199811064960', '18380138681', '招商银行-银联IC普', '6214832838904528', '发放失败-002：银行账号不存在或账号有误', '2023-03-09 16:19:26');
INSERT INTO `ag_bill_remit_record` VALUES (37, 11, 2, '123', 2, 1.00, '1', NULL, NULL, '123', '1', '测试', '2023-03-10 11:52:25');
INSERT INTO `ag_bill_remit_record` VALUES (38, 9, 2, '1', 2, 1.00, '1', NULL, NULL, '1', '1', '1', '2023-03-10 11:57:57');
INSERT INTO `ag_bill_remit_record` VALUES (39, 12, 2, '1', 2, 1.00, '1', NULL, NULL, '1', '1', '1', '2023-03-10 11:59:55');
INSERT INTO `ag_bill_remit_record` VALUES (40, 9, 2, '1', 2, 1.00, '1', NULL, NULL, '1', '1', '1', '2023-03-10 12:02:32');
INSERT INTO `ag_bill_remit_record` VALUES (41, 11, 2, '', 2, 0.00, '', NULL, NULL, '', '', '', '2023-03-10 12:13:18');
INSERT INTO `ag_bill_remit_record` VALUES (42, 9, 2, '1', 2, 1.00, '1', NULL, NULL, '1', '1', '1', '2023-03-10 13:26:39');
INSERT INTO `ag_bill_remit_record` VALUES (43, 9, 2, '1', 2, 1.00, '11', NULL, NULL, '1', '1', '1', '2023-03-10 13:26:40');
INSERT INTO `ag_bill_remit_record` VALUES (44, 9, 2, '1', 2, 1.00, '1', NULL, NULL, '1', '1', '1', '2023-03-10 13:26:42');
INSERT INTO `ag_bill_remit_record` VALUES (45, 9, 2, '1', 2, 1.00, '1', NULL, NULL, '1', '1', '1', '2023-03-10 13:26:49');
INSERT INTO `ag_bill_remit_record` VALUES (46, 11, 2, '2123232', 2, 10.00, '13123', NULL, NULL, '2322', '12323322', '12', '2023-03-10 13:36:01');
INSERT INTO `ag_bill_remit_record` VALUES (47, 12, 2, '132432', 2, 10.00, '123', NULL, NULL, '32', '23234324', '1', '2023-03-10 13:38:56');
INSERT INTO `ag_bill_remit_record` VALUES (48, 12, 2, '214234', 2, 2.00, '123', NULL, NULL, '234', '3434', '2', '2023-03-10 13:39:07');
INSERT INTO `ag_bill_remit_record` VALUES (49, 12, 2, '343', 2, 1.00, '123', NULL, NULL, '34', '343', '3', '2023-03-10 13:39:19');
INSERT INTO `ag_bill_remit_record` VALUES (50, 12, 2, 'JHB1678426975594', 3, 0.50, '何益梅', '511325199811064960', '18380138680', '招商银行-银联IC普', '6214832838904524', '发放失败-002：银行账号不存在或账号有误', '2023-03-10 13:43:20');
INSERT INTO `ag_bill_remit_record` VALUES (51, 12, 2, 'JHB1678427037845', 2, 0.50, '何益梅', '511325199811064960', '18380138680', '招商银行-银联IC普卡-借记卡', '6214832838904527', '已发放', '2023-03-10 13:44:14');
INSERT INTO `ag_bill_remit_record` VALUES (52, 13, 2, '122342343', 2, 2.00, '小河', NULL, NULL, '454', '122434', '1', '2023-03-10 13:45:02');
INSERT INTO `ag_bill_remit_record` VALUES (53, 11, 2, '1323', 2, 20.00, '312', NULL, NULL, '232', '3322', '1', '2023-03-10 13:57:16');
INSERT INTO `ag_bill_remit_record` VALUES (54, 9, 2, '13213', 2, 31.00, '232', NULL, NULL, '23', '233', '1', '2023-03-10 13:59:59');
INSERT INTO `ag_bill_remit_record` VALUES (55, 13, 2, '131231', 2, 9.40, '1231', NULL, NULL, '21312', '1241341', '1', '2023-03-10 14:03:40');
INSERT INTO `ag_bill_remit_record` VALUES (56, 10, 2, '1223', 2, 1.00, '123', NULL, NULL, '123', '23123', '123', '2023-03-10 14:14:07');
INSERT INTO `ag_bill_remit_record` VALUES (57, 10, 2, '12311', 2, 1.00, '1231', NULL, NULL, '231', '133', '1', '2023-03-31 00:00:00');
INSERT INTO `ag_bill_remit_record` VALUES (58, 13, 2, '12', 2, 12.00, '等我', NULL, NULL, '12', 's f撒', '1', '2023-03-10 14:19:56');
INSERT INTO `ag_bill_remit_record` VALUES (59, 12, 2, '123', 2, 10.00, '123', NULL, NULL, '123', '123', '1', '2023-03-10 14:20:58');
INSERT INTO `ag_bill_remit_record` VALUES (60, 9, 2, '1231', 2, 34.00, '123', NULL, NULL, '14', '13', '1', '2023-03-10 14:22:46');
INSERT INTO `ag_bill_remit_record` VALUES (61, 11, 2, '232', 2, 2413.00, '123', NULL, NULL, '231', '23', '1', '2023-03-10 00:00:00');

-- ----------------------------
-- Table structure for ag_dist_voucher_rule
-- ----------------------------
DROP TABLE IF EXISTS `ag_dist_voucher_rule`;
CREATE TABLE `ag_dist_voucher_rule`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `agent_id` int(11) NOT NULL,
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `voucher_cat` int(11) NOT NULL COMMENT '发放券类型，VOUCHER_CAT枚举',
  `dist_num` int(11) NOT NULL COMMENT '发券数量',
  `dist_cat` int(11) NOT NULL COMMENT '发券方式,DIST_VOUCHER_CAT枚举',
  `dist_arrival_cat` int(11) NOT NULL COMMENT '发券到账类型，DIST_ARRIVAL_CAT枚举',
  `dist_batch` int(11) NULL DEFAULT NULL COMMENT '发券批次,一次发放为1，多次发放对应次数',
  `dist_interval` int(11) NULL DEFAULT NULL COMMENT '发券间隔，单位天',
  `activate_batch` int(11) NULL DEFAULT NULL COMMENT '激活批次',
  `activate_interval` int(11) NULL DEFAULT NULL COMMENT '激活间隔，单位天',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `creator_id` int(11) NOT NULL COMMENT '创建人ID',
  `creator_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人名称',
  `deleted` datetime NULL DEFAULT NULL COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ag_dist_voucher_rule_agent_id_deleted_index`(`agent_id`, `deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '发券规则' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_dist_voucher_rule
-- ----------------------------

-- ----------------------------
-- Table structure for ag_dist_voucher_task
-- ----------------------------
DROP TABLE IF EXISTS `ag_dist_voucher_task`;
CREATE TABLE `ag_dist_voucher_task`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `rule_id` int(11) NOT NULL COMMENT '规则ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `agent_id` int(11) NOT NULL COMMENT '代理商ID',
  `voucher_cat` tinyint(3) NOT NULL COMMENT '券类型',
  `dist_num` int(11) NOT NULL COMMENT '发放数量',
  `activate_date_limit` date NOT NULL COMMENT '激活时间限制',
  `expect_run_date` date NOT NULL COMMENT '期望运行日期，任务应该运行日期',
  `run_state` int(11) NULL DEFAULT NULL COMMENT '运行状态，1待运行 2运行中 3已运行 4失败 5终止',
  `run_fail_msg` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '运行失败异常信息，主动终止的记录备注',
  `run_time` datetime NULL DEFAULT NULL COMMENT '运行时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ag_dist_voucher_task_rule_id_index`(`rule_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '发券任务' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_dist_voucher_task
-- ----------------------------

-- ----------------------------
-- Table structure for ag_income_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `ag_income_operation_log`;
CREATE TABLE `ag_income_operation_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oper_id` int(11) NOT NULL COMMENT '操作人ID',
  `oper_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作人名称',
  `bind_id` int(11) NULL DEFAULT 0 COMMENT '绑定id ag_user_shop表ID',
  `shop_id` int(11) NULL DEFAULT NULL COMMENT '店铺ID',
  `old_valid_date` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '原有效期',
  `new_valid_date` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改后有效期',
  `old_bonus_limit` int(11) NULL DEFAULT NULL COMMENT '原分成上限',
  `new_bonus_limit` int(11) NULL DEFAULT NULL COMMENT '修改分成上限',
  `content` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '收益操作日志' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_income_operation_log
-- ----------------------------
INSERT INTO `ag_income_operation_log` VALUES (46, 1, 'admin', 34, 11, '永久', '2023-03-09 00:00:00~2023-03-31 23:59:59', 100, 10, '操作ID为34', '2023-03-08 18:21:46');
INSERT INTO `ag_income_operation_log` VALUES (47, 1, 'admin', 33, 10, '永久', '2023-03-08 00:00:00~2023-03-31 23:59:59', 100, 8, '操作ID为33', '2023-03-08 18:22:03');
INSERT INTO `ag_income_operation_log` VALUES (48, 1, 'admin', 32, 9, '永久', '2023-03-09 00:00:00~2023-03-31 23:59:59', 100, 20, '操作ID为32', '2023-03-08 18:22:24');
INSERT INTO `ag_income_operation_log` VALUES (49, 1, 'admin', 31, 8, '永久', '2023-03-08 00:00:00~2023-03-31 23:59:59', 100, 15, '操作ID为31', '2023-03-08 18:22:42');
INSERT INTO `ag_income_operation_log` VALUES (50, 1, 'admin', 25, 1, '永久', '2023-03-08 00:00:00~2025-02-28 23:59:59', 100, 15, '操作ID为25', '2023-03-08 18:23:04');
INSERT INTO `ag_income_operation_log` VALUES (51, 1, 'admin', 26, 3, '永久', '2023-03-08 00:00:00~2023-03-31 23:59:59', 100, 10, '操作ID为26', '2023-03-08 18:23:38');
INSERT INTO `ag_income_operation_log` VALUES (52, 1, 'admin', 27, 4, '永久', '2023-03-08 00:00:00~2023-03-08 23:59:59', 100, 11, '操作ID为27', '2023-03-08 18:24:06');
INSERT INTO `ag_income_operation_log` VALUES (53, 1, 'admin', 28, 5, '永久', '2023-03-08 00:00:00~2024-03-30 23:59:59', 100, 9, '操作ID为28', '2023-03-08 18:24:30');
INSERT INTO `ag_income_operation_log` VALUES (54, 1, 'admin', 29, 6, '永久', '2023-03-08 00:00:00~2023-03-31 23:59:59', 100, 17, '操作ID为29', '2023-03-08 18:25:12');
INSERT INTO `ag_income_operation_log` VALUES (55, 1, 'admin', 30, 7, '永久', '2023-03-08 00:00:00~2023-03-31 23:59:59', 100, 20, '操作ID为30', '2023-03-08 18:26:02');

-- ----------------------------
-- Table structure for ag_shop_del_log
-- ----------------------------
DROP TABLE IF EXISTS `ag_shop_del_log`;
CREATE TABLE `ag_shop_del_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oper_id` int(11) NOT NULL COMMENT '操作人ID',
  `oper_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作人名称',
  `oper_phone` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作人电话',
  `agent_id` int(11) NOT NULL COMMENT '代理商ID',
  `bonus_income` decimal(10, 2) NULL DEFAULT NULL COMMENT '产生收益',
  `mch_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户名称',
  `agent_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代理商名称',
  `shop_id` int(11) NOT NULL COMMENT '门店ID',
  `shop_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '门店名称',
  `content` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '删除时间',
  `agent_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代理商电话',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1代理商删除  2门店池删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '门店删除日志' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_shop_del_log
-- ----------------------------

-- ----------------------------
-- Table structure for ag_user
-- ----------------------------
DROP TABLE IF EXISTS `ag_user`;
CREATE TABLE `ag_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `agent_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代理商名称',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '电话',
  `password` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码,Bcrypt加密，默认手机号后6位',
  `source` int(11) NOT NULL COMMENT '来源，AGENT_SRC枚举',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `state` smallint(6) NOT NULL DEFAULT 1 COMMENT '状态，1正常 2禁用',
  `cumulative_income` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '累计收益',
  `settle_income` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '已结算收益',
  `deleted` datetime NULL DEFAULT NULL COMMENT '软删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_ag_user_phone`(`phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代理商-用户表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_user
-- ----------------------------
INSERT INTO `ag_user` VALUES (9, '代理1', '18380138680', '$2y$10$xjrHFeX7FmPdCrsNdADteeHr7s8P8Awlfj6a72fSnpTpTLdm/RLfi', 1, '2023-03-08 18:15:54', 1, 59.00, 76.00, NULL);
INSERT INTO `ag_user` VALUES (10, '代理2', '18380138681', '$2y$10$xUH.aSwNgPFlM45Qq2rtOOpjAcfCTV/gzjK4OghRwizzH7LoMNuKK', 1, '2023-03-08 18:16:06', 1, 25.00, 15.00, NULL);
INSERT INTO `ag_user` VALUES (11, '代理3', '18380138682', '$2y$10$ZTvxoa/z2BENkN8sskF2nuhwLPPvpD.7lUyVMmPU/4cAhoIqgKy2W', 1, '2023-03-08 18:16:20', 1, 66.12, 186.24, NULL);
INSERT INTO `ag_user` VALUES (12, '代理4', '18380138683', '$2y$10$Jj0a3q3sPVSk6Tvyo1PLWOgiCDihUyKhjg6hTVENuhfjpAz2bT1Fa', 1, '2023-03-08 18:16:33', 1, 39.00, 62.00, NULL);
INSERT INTO `ag_user` VALUES (13, '代理5', '18380138684', '$2y$10$B4mkfkG1ceUJKnz1lUD.jOZxVoM3F9HJOBCOpC/cyeQbwCmeYpi9O', 1, '2023-03-08 18:16:47', 1, 20.00, 52.00, NULL);
INSERT INTO `ag_user` VALUES (14, '谢谢', '13980822826', '$2y$10$Ao8opn4MK7zAYbDF0IWUV.PBzitsm8B/YRsn4t9Y416JEig3pmm4i', 1, '2023-03-10 09:13:00', 1, 6.00, 0.00, NULL);
INSERT INTO `ag_user` VALUES (15, '代理6', '18081238027', '$2y$10$w6pAKXlEOdm6uOeabX8fsOk2zH/zuoj4G4IHBiIntz9.YqTE1iQQC', 1, '2023-03-10 11:57:01', 1, 0.00, 0.00, NULL);

-- ----------------------------
-- Table structure for ag_user_bank
-- ----------------------------
DROP TABLE IF EXISTS `ag_user_bank`;
CREATE TABLE `ag_user_bank`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `agent_id` int(11) NOT NULL COMMENT '代理商ID',
  `holder_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '持卡人名称',
  `reserve_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行预留手机号',
  `bank_no` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '卡号',
  `bank_cat` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '卡类型，BANK_CAT字典',
  `sub_bank` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开户支行',
  `bank_front_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行卡正面',
  `bank_back_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行卡背面',
  `ic_card` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '身份证',
  `id_card_front_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证正面',
  `id_card_back_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证背面',
  `verify_code` int(11) NULL DEFAULT NULL COMMENT '验证码',
  `deleted` datetime NULL DEFAULT NULL COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ag_user_bank_agent_id_index`(`agent_id`) USING BTREE,
  INDEX `ag_user_bank_deleted_index`(`deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代理商银行卡' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_user_bank
-- ----------------------------
INSERT INTO `ag_user_bank` VALUES (2, 13, '何益梅', '18380138680', '6214832838904527', '招商银行-银联IC普', '招商银行', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/640940ed2da80tmp_03e393c87999ac94c73192b99141b858.jpg', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/640940f7dd779tmp_bb48d0bfabfe87c51df0df6c8cd73634.jpg', '511325199811064960', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/640940e18d7batmp_a9560b0c80251e98615c7ddc514d3373.jpg', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/640940e5583aetmp_c8cc744c6c38eecc93c4a23b25945ce1.jpg', NULL, NULL);
INSERT INTO `ag_user_bank` VALUES (3, 12, '何益梅', '18380138680', '6214832838904527', '招商银行-银联IC普', '喊吧', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/64094d830746atmp_eb3d93b9528ccf4d7bbefe49fb39ff95.jpg', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/64094d886dd30tmp_57ae3b42bafdaf4b51f7a6c8d5c5250a.jpg', '511325199811064960', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/64094d7d2ada0tmp_4093971e17a5cbf2ebf01ffbf41ce085.jpg', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/64094d8005e1atmp_3aa87cc061ebb9bcbc8bac3b54cede18.jpg', NULL, NULL);
INSERT INTO `ag_user_bank` VALUES (4, 9, '何益梅', '18380138681', '6214832838904528', '招商银行-银联IC普', '好吧', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/640957638fb6dtmp_85102007875ef8e8e2b9b014fd941585.jpg', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/6409576674625tmp_5705db2daec985c0e64cc669d909e871.jpg', '511325199811064960', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/6409575d3bd3btmp_0153eefe42d1b0076289a90a0a9fbd1d.jpg', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/640957600eb46tmp_c210f0f10f604d896095ea801c1debbc.jpg', NULL, NULL);
INSERT INTO `ag_user_bank` VALUES (5, 10, '何益梅', '18381038680', '6214832838904527', '招商银行-银联IC普', '快看看', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/64095851857e5tmp_1aa03ec6d69d9f23d9191344d076c791.jpg', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/640958543961dtmp_c750ab75e11a774b5890114c5503d584.jpg', '511325199811064960', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/64099115d661btmp_c738c282778965dc7d8f9f4e16e6b563.jpg', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/6409584e67762tmp_0f8b33f0a17b61b3dad593ae9b1a9588.jpg', NULL, NULL);
INSERT INTO `ag_user_bank` VALUES (6, 11, '何益', '18380168680', '6214832838904521', '招商银行-银联IC普', '黑色金属', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/64095afda0125tmp_64b1ccb67c54573396934d7cf3696ea5.jpg', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/64095b008daa1tmp_84a26e71b4e395ff6e8cf04f920fdd82.jpg', '511325199811064960', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/64095af5c28cftmp_e203589bc4163b572efd43e11772db21.jpg', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/64095afa1a0a4tmp_ad3c60fe0da595c62e58d068c98acdfa.jpg', NULL, '2023-03-09 12:15:24');
INSERT INTO `ag_user_bank` VALUES (7, 11, '何益梅', '18380138680', '6214832838904527', '招商银行-银联IC普', '很好', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/6409603a27121tmp_fe6d55730ce0da6ed7b75948a53abcb5.jpg', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/6409603cecaactmp_ab3ff8995c089e453c6e1e5d580e67b9.jpg', '511325199811064960', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/6409602545fedtmp_1600d14049f542515a407b822f34ff6c.jpg', 'https://juhebangoss.oss-cn-hangzhou.aliyuncs.com/bank/2023-03-09/64096036f0582tmp_2cfe352028394fdd4df8367a2bf38adb.jpg', NULL, NULL);

-- ----------------------------
-- Table structure for ag_user_bill
-- ----------------------------
DROP TABLE IF EXISTS `ag_user_bill`;
CREATE TABLE `ag_user_bill`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `agent_id` int(11) NOT NULL COMMENT '代理商ID',
  `agent_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代理商名称',
  `agent_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代理商电话',
  `bill_period` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账期，yyyy-MM',
  `profit_income` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '分润收益',
  `subsidy_income` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '补贴收益',
  `total_income` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '总收益,分润收益+补贴收益',
  `tax_rate` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '税率',
  `real_income` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '实际收益，总收益（1-税率）',
  `state` int(11) NULL DEFAULT NULL COMMENT '状态，AGENT_BILL_STATE枚举',
  `receiver_user` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款人',
  `receiver_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款银行卡预留手机号',
  `receiver_idcard` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款卡持卡人身份证号',
  `receiver_bank` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款银行',
  `sub_bank` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开户支行',
  `receiver_bank_no` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款卡号',
  `remarks` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ag_user_bill_agent_id_bill_period_index`(`agent_id`, `bill_period`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代理商月账单' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_user_bill
-- ----------------------------
INSERT INTO `ag_user_bill` VALUES (9, '2023-03-09 03:00:00', 9, '代理1', '18380138680', '2023-03', 0.00, 59.00, 59.00, 0.60, 34.00, 6, '何益梅', '18380138681', '511325199811064960', '招商银行-银联IC普', '好吧', '6214832838904528', '发放失败-002：银行账号不存在或账号有误');
INSERT INTO `ag_user_bill` VALUES (10, '2023-03-09 03:00:00', 10, '代理2', '18380138681', '2023-03', 0.00, 25.00, 25.00, 0.60, 1.00, 6, '何益梅', '18381038680', '511325199811064960', '招商银行-银联IC普卡-借记卡', '快看看', '6214832838904527', '已发放');
INSERT INTO `ag_user_bill` VALUES (11, '2023-03-09 03:00:00', 11, '代理3', '18380138682', '2023-03', 29.12, 37.00, 66.12, 0.60, 21.38, 6, '何益梅', '18380138680', '511325199811064960', '招商银行-银联IC普', '很好', '6214832838904527', '');
INSERT INTO `ag_user_bill` VALUES (12, '2023-03-09 03:00:00', 12, '代理4', '18380138683', '2023-03', 0.00, 39.00, 39.00, 0.60, 0.50, 6, '何益梅', '18380138680', '511325199811064960', '招商银行-银联IC普卡-借记卡', '喊吧', '6214832838904527', '已发放');
INSERT INTO `ag_user_bill` VALUES (13, '2023-03-09 03:00:00', 13, '代理5', '18380138684', '2023-03', 0.00, 20.00, 20.00, 0.60, 9.94, 6, '何益梅', '18380138680', '511325199811064960', '招商银行-银联IC普', '招商银行', '6214832838904527', '已发放');
INSERT INTO `ag_user_bill` VALUES (14, '2023-03-11 03:00:01', 14, '谢谢', '13980822826', '2023-03', 0.00, 6.00, 6.00, 0.00, 0.00, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_bill` VALUES (15, '2023-03-11 03:00:01', 15, '代理6', '18081238027', '2023-03', 0.00, 0.00, 0.00, 0.00, 0.00, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for ag_user_daily_income_202302
-- ----------------------------
DROP TABLE IF EXISTS `ag_user_daily_income_202302`;
CREATE TABLE `ag_user_daily_income_202302`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `agent_id` int(11) NOT NULL COMMENT '代理商ID',
  `agent_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代理商名称',
  `bill_period` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账期,yyyy-MM-dd',
  `profit_income` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '分润收益',
  `subsidy_income` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '分润收益',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ag_user_daily_income_agent_id_index`(`agent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代理商日收益账单' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_user_daily_income_202302
-- ----------------------------

-- ----------------------------
-- Table structure for ag_user_daily_income_202303
-- ----------------------------
DROP TABLE IF EXISTS `ag_user_daily_income_202303`;
CREATE TABLE `ag_user_daily_income_202303`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `agent_id` int(11) NOT NULL COMMENT '代理商ID',
  `agent_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代理商名称',
  `bill_period` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账期,yyyy-MM-dd',
  `profit_income` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '分润收益',
  `subsidy_income` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '分润收益',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ag_user_daily_income_agent_id_index`(`agent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代理商日收益账单' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_user_daily_income_202303
-- ----------------------------
INSERT INTO `ag_user_daily_income_202303` VALUES (9, '2023-03-09 02:00:00', 9, '代理1', '2023-03-08', 0.00, 18.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (10, '2023-03-09 02:00:00', 10, '代理2', '2023-03-08', 0.00, 2.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (11, '2023-03-09 02:00:00', 11, '代理3', '2023-03-08', 0.00, 21.50);
INSERT INTO `ag_user_daily_income_202303` VALUES (12, '2023-03-09 02:00:00', 12, '代理4', '2023-03-08', 0.00, 11.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (13, '2023-03-09 02:00:00', 13, '代理5', '2023-03-08', 0.00, 10.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (14, '2023-03-10 02:00:00', 9, '代理1', '2023-03-09', 0.00, 17.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (15, '2023-03-10 02:00:00', 10, '代理2', '2023-03-09', 0.00, 11.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (16, '2023-03-10 02:00:00', 11, '代理3', '2023-03-09', 29.12, 15.50);
INSERT INTO `ag_user_daily_income_202303` VALUES (17, '2023-03-10 02:00:00', 12, '代理4', '2023-03-09', 0.00, 13.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (18, '2023-03-10 02:00:00', 13, '代理5', '2023-03-09', 0.00, 10.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (19, '2023-03-11 02:00:00', 9, '代理1', '2023-03-10', 0.00, 8.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (20, '2023-03-11 02:00:00', 10, '代理2', '2023-03-10', 0.00, 4.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (21, '2023-03-11 02:00:00', 11, '代理3', '2023-03-10', 0.00, 0.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (22, '2023-03-11 02:00:00', 12, '代理4', '2023-03-10', 0.00, 5.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (23, '2023-03-11 02:00:00', 13, '代理5', '2023-03-10', 0.00, 0.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (24, '2023-03-11 02:00:00', 14, '谢谢', '2023-03-10', 0.00, 2.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (25, '2023-03-11 02:00:00', 15, '代理6', '2023-03-10', 0.00, 0.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (26, '2023-03-12 02:00:00', 9, '代理1', '2023-03-11', 0.00, 8.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (27, '2023-03-12 02:00:00', 10, '代理2', '2023-03-11', 0.00, 4.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (28, '2023-03-12 02:00:00', 11, '代理3', '2023-03-11', 0.00, 0.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (29, '2023-03-12 02:00:00', 12, '代理4', '2023-03-11', 0.00, 5.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (30, '2023-03-12 02:00:00', 13, '代理5', '2023-03-11', 0.00, 0.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (31, '2023-03-12 02:00:00', 14, '谢谢', '2023-03-11', 0.00, 2.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (32, '2023-03-12 02:00:00', 15, '代理6', '2023-03-11', 0.00, 0.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (33, '2023-03-13 02:00:00', 9, '代理1', '2023-03-12', 0.00, 8.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (34, '2023-03-13 02:00:00', 10, '代理2', '2023-03-12', 0.00, 4.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (35, '2023-03-13 02:00:00', 11, '代理3', '2023-03-12', 0.00, 0.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (36, '2023-03-13 02:00:00', 12, '代理4', '2023-03-12', 0.00, 5.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (37, '2023-03-13 02:00:00', 13, '代理5', '2023-03-12', 0.00, 0.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (38, '2023-03-13 02:00:00', 14, '谢谢', '2023-03-12', 0.00, 2.00);
INSERT INTO `ag_user_daily_income_202303` VALUES (39, '2023-03-13 02:00:00', 15, '代理6', '2023-03-12', 0.00, 0.00);

-- ----------------------------
-- Table structure for ag_user_income_202302
-- ----------------------------
DROP TABLE IF EXISTS `ag_user_income_202302`;
CREATE TABLE `ag_user_income_202302`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `agent_id` int(11) NOT NULL COMMENT '代理商ID',
  `agent_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代理商名称',
  `cat` int(11) NOT NULL COMMENT '收益类型，AGENT_INCOME_CAT枚举',
  `income_amount` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '收益金额，订单分润=profit_base_amount*profit_rate,补贴直接记录补贴金额',
  `profit_order_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联分润订单ID',
  `profit_cat` tinyint(4) NULL DEFAULT NULL COMMENT '分润类型,AGENT_PROFIT_CAT枚举',
  `profit_base_amount` decimal(6, 2) NULL DEFAULT NULL COMMENT '分润基数金额',
  `profit_rate` decimal(6, 2) NULL DEFAULT NULL COMMENT '分润比例',
  `subsidy_shop_id` int(11) NULL DEFAULT NULL COMMENT '补贴门店ID',
  `subsidy_shop_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '补贴门店名称',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ag_user_income_agent_id_index`(`agent_id`) USING BTREE,
  INDEX `ag_user_income_cat_index`(`cat`) USING BTREE,
  INDEX `ag_user_income_profit_order_shop_id_profit_order_id_index`(`profit_order_id`) USING BTREE,
  INDEX `subsidy_shop_id`(`subsidy_shop_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代理商收益表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_user_income_202302
-- ----------------------------

-- ----------------------------
-- Table structure for ag_user_income_202303
-- ----------------------------
DROP TABLE IF EXISTS `ag_user_income_202303`;
CREATE TABLE `ag_user_income_202303`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `agent_id` int(11) NOT NULL COMMENT '代理商ID',
  `agent_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代理商名称',
  `cat` int(11) NOT NULL COMMENT '收益类型，AGENT_INCOME_CAT枚举',
  `income_amount` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '收益金额，订单分润=profit_base_amount*profit_rate,补贴直接记录补贴金额',
  `profit_order_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联分润订单ID',
  `profit_cat` tinyint(4) NULL DEFAULT NULL COMMENT '分润类型,AGENT_PROFIT_CAT枚举',
  `profit_base_amount` decimal(6, 2) NULL DEFAULT NULL COMMENT '分润基数金额',
  `profit_rate` decimal(6, 2) NULL DEFAULT NULL COMMENT '分润比例',
  `subsidy_shop_id` int(11) NULL DEFAULT NULL COMMENT '补贴门店ID',
  `subsidy_shop_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '补贴门店名称',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ag_user_income_agent_id_index`(`agent_id`) USING BTREE,
  INDEX `ag_user_income_cat_index`(`cat`) USING BTREE,
  INDEX `ag_user_income_profit_order_shop_id_profit_order_id_index`(`profit_order_id`) USING BTREE,
  INDEX `subsidy_shop_id`(`subsidy_shop_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代理商收益表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_user_income_202303
-- ----------------------------
INSERT INTO `ag_user_income_202303` VALUES (19, '2023-03-08 23:30:00', 9, '代理1', 1, 8.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (20, '2023-03-08 23:30:00', 11, '代理3', 1, 3.50, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (21, '2023-03-08 23:30:00', 12, '代理4', 1, 5.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (22, '2023-03-08 23:30:00', 13, '代理5', 1, 2.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (23, '2023-03-08 01:00:00', 9, '代理1', 4, 7.00, NULL, 1, NULL, NULL, 1, '一号串串香');
INSERT INTO `ag_user_income_202303` VALUES (24, '2023-03-08 01:00:00', 9, '代理1', 4, 3.00, NULL, 1, NULL, NULL, 3, '三号串串香');
INSERT INTO `ag_user_income_202303` VALUES (25, '2023-03-08 01:00:00', 10, '代理2', 4, 2.00, NULL, 1, NULL, NULL, 5, '五号串串香');
INSERT INTO `ag_user_income_202303` VALUES (26, '2023-03-08 01:00:00', 11, '代理3', 4, 9.00, NULL, 1, NULL, NULL, 6, '六号串串香');
INSERT INTO `ag_user_income_202303` VALUES (27, '2023-03-08 01:00:00', 11, '代理3', 4, 9.00, NULL, 1, NULL, NULL, 7, '七号串串香');
INSERT INTO `ag_user_income_202303` VALUES (28, '2023-03-08 01:00:00', 12, '代理4', 4, 4.00, NULL, 1, NULL, NULL, 8, '八号串串香');
INSERT INTO `ag_user_income_202303` VALUES (29, '2023-03-08 01:00:00', 12, '代理4', 4, 2.00, NULL, 1, NULL, NULL, 9, '农夫果园（整果，切果，果捞）');
INSERT INTO `ag_user_income_202303` VALUES (30, '2023-03-08 01:00:00', 13, '代理5', 4, 5.00, NULL, 1, NULL, NULL, 10, '岚田予果（解放碑店）');
INSERT INTO `ag_user_income_202303` VALUES (31, '2023-03-08 01:00:00', 13, '代理5', 4, 3.00, NULL, 1, NULL, NULL, 11, '爱果匠（解放碑店•整果•果切•果捞）');
INSERT INTO `ag_user_income_202303` VALUES (47, '2023-03-09 18:07:39', 11, '代理3', 3, 6.24, '49239644142423244820230309', 2, 7.10, 88.00, 195, '李帅哥的电力公司');
INSERT INTO `ag_user_income_202303` VALUES (48, '2023-03-09 18:07:46', 11, '代理3', 3, 8.32, '49239646674105139220230309', 2, 16.65, 50.00, 195, '李帅哥的电力公司');
INSERT INTO `ag_user_income_202303` VALUES (49, '2023-03-09 18:07:54', 11, '代理3', 3, 8.32, '49239650217033728020230309', 2, 16.65, 50.00, 195, '李帅哥的电力公司');
INSERT INTO `ag_user_income_202303` VALUES (50, '2023-03-09 18:07:59', 11, '代理3', 3, 6.24, '49239652373325414420230309', 2, 7.10, 88.00, 195, '李帅哥的电力公司');
INSERT INTO `ag_user_income_202303` VALUES (51, '2023-03-09 23:30:00', 9, '代理1', 1, 8.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (52, '2023-03-09 23:30:00', 10, '代理2', 1, 4.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (53, '2023-03-09 23:30:00', 11, '代理3', 1, 3.50, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (54, '2023-03-09 23:30:00', 12, '代理4', 1, 5.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (55, '2023-03-09 01:00:00', 9, '代理1', 4, 5.00, NULL, 1, NULL, NULL, 1, '一号串串香');
INSERT INTO `ag_user_income_202303` VALUES (56, '2023-03-09 01:00:00', 9, '代理1', 4, 4.00, NULL, 1, NULL, NULL, 3, '三号串串香');
INSERT INTO `ag_user_income_202303` VALUES (57, '2023-03-09 01:00:00', 10, '代理2', 4, 7.00, NULL, 1, NULL, NULL, 5, '五号串串香');
INSERT INTO `ag_user_income_202303` VALUES (58, '2023-03-09 01:00:00', 11, '代理3', 4, 4.00, NULL, 1, NULL, NULL, 6, '六号串串香');
INSERT INTO `ag_user_income_202303` VALUES (59, '2023-03-09 01:00:00', 11, '代理3', 4, 1.00, NULL, 1, NULL, NULL, 7, '七号串串香');
INSERT INTO `ag_user_income_202303` VALUES (60, '2023-03-09 01:00:00', 12, '代理4', 4, 3.00, NULL, 1, NULL, NULL, 8, '八号串串香');
INSERT INTO `ag_user_income_202303` VALUES (61, '2023-03-09 01:00:00', 12, '代理4', 4, 5.00, NULL, 1, NULL, NULL, 9, '农夫果园（整果，切果，果捞）');
INSERT INTO `ag_user_income_202303` VALUES (62, '2023-03-09 01:00:00', 13, '代理5', 4, 3.00, NULL, 1, NULL, NULL, 10, '岚田予果（解放碑店）');
INSERT INTO `ag_user_income_202303` VALUES (63, '2023-03-09 01:00:00', 13, '代理5', 4, 7.00, NULL, 1, NULL, NULL, 11, '爱果匠（解放碑店•整果•果切•果捞）');
INSERT INTO `ag_user_income_202303` VALUES (64, '2023-03-09 01:00:00', 11, '代理3', 4, 7.00, NULL, 1, NULL, NULL, 197, '李师傅店铺');
INSERT INTO `ag_user_income_202303` VALUES (65, '2023-03-10 23:30:00', 9, '代理1', 1, 8.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (66, '2023-03-10 23:30:00', 10, '代理2', 1, 4.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (67, '2023-03-10 23:30:00', 12, '代理4', 1, 5.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (68, '2023-03-10 23:30:00', 14, '谢谢', 1, 2.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (69, '2023-03-11 23:30:00', 9, '代理1', 1, 8.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (70, '2023-03-11 23:30:00', 10, '代理2', 1, 4.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (71, '2023-03-11 23:30:00', 12, '代理4', 1, 5.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (72, '2023-03-11 23:30:00', 14, '谢谢', 1, 2.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (73, '2023-03-12 23:30:00', 9, '代理1', 1, 8.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (74, '2023-03-12 23:30:00', 10, '代理2', 1, 4.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (75, '2023-03-12 23:30:00', 12, '代理4', 1, 5.00, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_income_202303` VALUES (76, '2023-03-12 23:30:00', 14, '谢谢', 1, 2.00, NULL, 1, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for ag_user_shop
-- ----------------------------
DROP TABLE IF EXISTS `ag_user_shop`;
CREATE TABLE `ag_user_shop`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `agent_id` int(11) NOT NULL COMMENT '代理商ID',
  `agent_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代理商名称',
  `mch_id` int(11) NOT NULL COMMENT '商户ID',
  `mch_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户名称',
  `shop_id` int(11) NOT NULL COMMENT '门店ID',
  `shop_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '门店名称',
  `voucher_id` int(11) NOT NULL COMMENT '地推券ID',
  `bonus_start_date` date NOT NULL COMMENT '分润开始日期',
  `bonus_valid_date` date NOT NULL COMMENT '分润有效期，建立关系日期+系统配置BONUS_VALID_DAY',
  `bonus_date_limit` tinyint(4) NOT NULL DEFAULT 1 COMMENT '分润是否限制有效期, 0永久，1限制有效期到bonus_valid_date',
  `bonus_limit` decimal(10, 0) NOT NULL COMMENT '分成上限，系统配置',
  `state` smallint(6) NOT NULL COMMENT '状态，AGENT_USER_SHOP_STATE枚举',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `invalid_time` datetime NULL DEFAULT NULL COMMENT '失效时间',
  `complete_time` datetime NULL DEFAULT NULL COMMENT '达标时间',
  `bonus_income` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '累计分润收益',
  `subsidy_income` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '补贴收益',
  `total_order` int(11) NOT NULL DEFAULT 0 COMMENT '累计订单数',
  `bind_type` smallint(6) NOT NULL COMMENT '绑定类型，AGENT_SHOP_BIND_TYPE枚举',
  `deleted` datetime NULL DEFAULT NULL COMMENT '软删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ag_user_shop_agent_id_shop_id_index`(`agent_id`, `shop_id`) USING BTREE,
  INDEX `ag_user_shop_voucher_id_index`(`voucher_id`) USING BTREE,
  INDEX `ag_user_shop_state_deleted_index`(`state`, `deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代理商-门店表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_user_shop
-- ----------------------------
INSERT INTO `ag_user_shop` VALUES (25, 9, '代理1', 1, '六年二班串串香', 1, '一号串串香', 38, '2023-03-08', '2025-02-28', 1, 15, 1, '2023-03-08 18:21:12', NULL, NULL, 0.00, 12.00, 0, 1, NULL);
INSERT INTO `ag_user_shop` VALUES (26, 9, '代理1', 1, '六年二班串串香', 3, '三号串串香', 39, '2023-03-08', '2023-03-31', 1, 10, 1, '2023-03-08 18:21:12', NULL, NULL, 0.00, 7.00, 0, 1, NULL);
INSERT INTO `ag_user_shop` VALUES (27, 10, '代理2', 1, '六年二班串串香', 4, '四号串串香', 40, '2023-03-08', '2023-03-08', 1, 11, 3, '2023-03-08 18:21:12', NULL, '2023-03-09 01:10:00', 0.00, 0.00, 0, 1, NULL);
INSERT INTO `ag_user_shop` VALUES (28, 10, '代理2', 1, '六年二班串串香', 5, '五号串串香', 41, '2023-03-08', '2024-03-30', 1, 9, 4, '2023-03-08 18:21:12', NULL, '2023-03-10 01:00:00', 0.00, 2.00, 0, 1, NULL);
INSERT INTO `ag_user_shop` VALUES (29, 11, '代理3', 1, '六年二班串串香', 6, '六号串串香', 36, '2023-03-08', '2023-03-31', 1, 17, 1, '2023-03-08 18:21:12', NULL, NULL, 0.00, 13.00, 0, 1, NULL);
INSERT INTO `ag_user_shop` VALUES (30, 11, '代理3', 1, '六年二班串串香', 7, '七号串串香', 37, '2023-03-08', '2023-03-31', 1, 20, 1, '2023-03-08 18:21:12', NULL, NULL, 0.00, 10.00, 0, 1, NULL);
INSERT INTO `ag_user_shop` VALUES (31, 12, '代理4', 1, '六年二班串串香', 8, '八号串串香', 34, '2023-03-08', '2023-03-31', 1, 15, 1, '2023-03-08 18:21:12', NULL, NULL, 0.00, 7.00, 0, 1, NULL);
INSERT INTO `ag_user_shop` VALUES (32, 12, '代理4', 2, '农夫果园（整果，切果，果捞）', 9, '农夫果园（整果，切果，果捞）', 35, '2023-03-09', '2023-03-31', 1, 20, 1, '2023-03-08 18:21:12', NULL, NULL, 0.00, 7.00, 0, 1, NULL);
INSERT INTO `ag_user_shop` VALUES (33, 13, '代理5', 2, '农夫果园（整果，切果，果捞）', 10, '岚田予果（解放碑店）', 32, '2023-03-08', '2023-03-31', 1, 8, 4, '2023-03-08 18:21:12', NULL, '2023-03-10 01:00:00', 0.00, 5.00, 0, 1, NULL);
INSERT INTO `ag_user_shop` VALUES (34, 13, '代理5', 2, '农夫果园（整果，切果，果捞）', 11, '爱果匠（解放碑店•整果•果切•果捞）', 33, '2023-03-09', '2023-03-31', 1, 10, 4, '2023-03-08 18:21:12', NULL, '2023-03-10 01:00:00', 0.00, 3.00, 0, 1, NULL);
INSERT INTO `ag_user_shop` VALUES (35, 9, '代理1', 4, '林不商户', 191, '这门店名', 46, '2023-03-10', '2023-03-11', 1, 2400, 3, '2023-03-09 10:06:50', NULL, '2023-03-12 01:10:00', 0.00, 0.00, 0, 2, NULL);
INSERT INTO `ag_user_shop` VALUES (36, 9, '代理1', 4, '林不商户', 191, '这门店名', 46, '2023-03-10', '2023-03-11', 1, 2400, 3, '2023-03-09 14:04:57', NULL, '2023-03-12 01:10:00', 0.00, 0.00, 0, 2, NULL);
INSERT INTO `ag_user_shop` VALUES (37, 11, '代理3', 8, '18380503975', 194, '李永爱的店铺', 49, '2023-03-10', '2023-03-11', 1, 2400, 3, '2023-03-09 14:38:46', NULL, '2023-03-12 01:10:00', 0.00, 0.00, 0, 2, NULL);
INSERT INTO `ag_user_shop` VALUES (38, 11, '代理3', 8, '18380503975', 195, '李公子的电力公司', 49, '2023-03-08', '2023-03-11', 1, 2400, 3, '2023-03-09 14:39:34', NULL, '2023-03-12 01:10:00', 29.12, 0.00, 32, 2, NULL);
INSERT INTO `ag_user_shop` VALUES (39, 13, '代理5', 9, '新的商户', 196, '新的门店', 58, '2023-03-10', '2023-03-11', 1, 2400, 3, '2023-03-09 14:47:36', NULL, '2023-03-12 01:10:00', 0.00, 0.00, 0, 2, NULL);
INSERT INTO `ag_user_shop` VALUES (40, 11, '代理3', 8, '18380503975', 197, '李师傅店铺', 49, '2023-03-08', '2023-03-11', 1, 2400, 3, '2023-03-09 15:07:40', NULL, '2023-03-12 01:10:00', 0.00, 7.00, 0, 2, NULL);
INSERT INTO `ag_user_shop` VALUES (41, 14, '谢谢', 1, '六年二班串串香', 4, '四号串串香', 65, '2023-03-11', '2023-03-15', 0, 100, 1, '2023-03-10 09:17:18', NULL, NULL, 0.00, 0.00, 0, 1, NULL);
INSERT INTO `ag_user_shop` VALUES (42, 14, '谢谢', 1, '六年二班串串香', 5, '五号串串香', 66, '2023-03-11', '2023-03-15', 0, 100, 1, '2023-03-10 09:17:18', NULL, NULL, 0.00, 0.00, 0, 1, NULL);
INSERT INTO `ag_user_shop` VALUES (43, 14, '谢谢', 2, '农夫果园（整果，切果，果捞）', 10, '岚田予果（解放碑店）', 67, '2023-03-11', '2023-03-15', 0, 100, 1, '2023-03-10 09:17:18', NULL, NULL, 0.00, 0.00, 0, 1, NULL);
INSERT INTO `ag_user_shop` VALUES (44, 9, '代理1', 2, '农夫果园（整果，切果，果捞）', 11, '爱果匠（解放碑店•整果•果切•果捞）', 42, '2023-03-11', '2023-03-15', 0, 100, 1, '2023-03-10 10:15:00', NULL, NULL, 0.00, 0.00, 0, 3, NULL);

-- ----------------------------
-- Table structure for ag_user_voucher
-- ----------------------------
DROP TABLE IF EXISTS `ag_user_voucher`;
CREATE TABLE `ag_user_voucher`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `source` smallint(6) NOT NULL COMMENT '来源，VOUCHER_SRC枚举',
  `source_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源系统ID,省赚宝对应订单ID，自动发券对应任务ID',
  `cat` int(11) NOT NULL COMMENT '地推券类型，PROMOTE_VOUCHER_CAT枚举',
  `ag_user_id` int(11) NOT NULL COMMENT '代理商ID',
  `state` smallint(6) NOT NULL COMMENT '地推券状态，PROMOTE_VOUCHER_STATE枚举',
  `voucher_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '券码，暂无业务需要，写入UUID',
  `valid_date` date NOT NULL COMMENT '有效期，生成日期+系统配置PROMOTE_VOUCHER_VALID_DAY',
  `activated_time` datetime NULL DEFAULT NULL COMMENT '激活时间',
  `activate_date_limit` date NULL DEFAULT NULL COMMENT '激活日期限制，必须激活日期大于等于当前时间才能激活',
  `invite_allot_time` datetime NULL DEFAULT NULL COMMENT '邀请/分配时间',
  `create_time` datetime NOT NULL COMMENT '创建日期',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `from_user_id` int(11) NULL DEFAULT NULL COMMENT '赠送用户ID',
  `from_user_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '赠送用户名称',
  `deleted` datetime NULL DEFAULT NULL COMMENT '软删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ag_user_voucher_ag_user_id_index`(`ag_user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代理商-地推券' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_user_voucher
-- ----------------------------
INSERT INTO `ag_user_voucher` VALUES (32, 1, NULL, 2, 13, 4, '6408609674497', '2023-03-11', '2023-03-08 18:19:27', NULL, '2023-03-08 18:21:12', '2023-03-08 18:16:54', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (33, 1, NULL, 2, 13, 4, '6408609674498', '2023-03-11', '2023-03-08 18:19:29', NULL, '2023-03-08 18:21:12', '2023-03-08 18:16:54', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (34, 1, NULL, 2, 12, 4, '6408609d90cf3', '2023-03-11', '2023-03-08 18:19:52', NULL, '2023-03-08 18:21:12', '2023-03-08 18:17:01', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (35, 1, NULL, 2, 12, 4, '6408609d90cf4', '2023-03-11', '2023-03-08 18:19:55', NULL, '2023-03-08 18:21:12', '2023-03-08 18:17:01', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (36, 1, NULL, 2, 11, 4, '640860a4d85d7', '2023-03-11', '2023-03-08 18:20:11', NULL, '2023-03-08 18:21:12', '2023-03-08 18:17:08', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (37, 1, NULL, 2, 11, 4, '640860a4d85d8', '2023-03-11', '2023-03-08 18:20:15', NULL, '2023-03-08 18:21:12', '2023-03-08 18:17:08', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (38, 1, NULL, 2, 9, 4, '640860ab58754', '2023-03-11', '2023-03-08 18:20:42', NULL, '2023-03-08 18:21:12', '2023-03-08 18:17:15', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (39, 1, NULL, 2, 9, 4, '640860ab58755', '2023-03-11', '2023-03-08 18:20:44', NULL, '2023-03-08 18:21:12', '2023-03-08 18:17:15', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (40, 1, NULL, 2, 10, 4, '640860b4ec386', '2023-03-11', '2023-03-08 18:20:28', NULL, '2023-03-08 18:21:12', '2023-03-08 18:17:24', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (41, 1, NULL, 2, 10, 4, '640860b4ec387', '2023-03-11', '2023-03-08 18:20:30', NULL, '2023-03-08 18:21:12', '2023-03-08 18:17:24', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (42, 1, NULL, 2, 9, 4, '6409321cd7156', '2023-03-12', '2023-03-09 09:10:57', NULL, '2023-03-10 10:15:00', '2023-03-09 09:10:52', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (43, 1, NULL, 1, 9, 6, '6409321cd7157', '2023-03-12', NULL, NULL, NULL, '2023-03-09 09:10:52', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (44, 1, NULL, 1, 9, 6, '6409321cd7158', '2023-03-12', NULL, NULL, NULL, '2023-03-09 09:10:52', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (45, 1, NULL, 1, 9, 6, '6409321cd7159', '2023-03-12', NULL, NULL, NULL, '2023-03-09 09:10:52', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (46, 1, NULL, 1, 9, 5, '6409321cd715a', '2023-03-12', NULL, NULL, NULL, '2023-03-09 09:10:52', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (47, 1, NULL, 1, 11, 5, '640944bab9b19', '2023-03-12', '2023-03-09 10:31:47', NULL, NULL, '2023-03-09 10:30:18', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (48, 1, NULL, 1, 11, 5, '640944bab9b1a', '2023-03-12', '2023-03-09 10:54:03', NULL, NULL, '2023-03-09 10:30:18', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (49, 1, NULL, 1, 11, 5, '640944bab9b1b', '2023-03-12', '2023-03-09 13:41:20', NULL, NULL, '2023-03-09 10:30:18', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (50, 1, NULL, 1, 11, 6, '640944bab9b1c', '2023-03-12', NULL, NULL, NULL, '2023-03-09 10:30:18', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (51, 1, NULL, 1, 11, 6, '640944bab9b1d', '2023-03-12', NULL, NULL, NULL, '2023-03-09 10:30:18', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (52, 1, NULL, 1, 12, 2, '64095114eee8e', '2023-03-12', '2023-03-09 11:24:16', NULL, NULL, '2023-03-09 11:23:00', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (53, 1, NULL, 1, 12, 2, '64095114eee8f', '2023-03-12', '2023-03-10 10:46:27', NULL, NULL, '2023-03-09 11:23:00', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (54, 1, NULL, 1, 12, 2, '64095114eee90', '2023-03-12', '2023-03-10 10:49:32', NULL, NULL, '2023-03-09 11:23:00', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (55, 1, NULL, 2, 12, 6, '64095114eee91', '2023-03-12', NULL, NULL, NULL, '2023-03-09 11:23:00', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (56, 1, NULL, 1, 12, 6, '64095114eee92', '2023-03-12', NULL, NULL, NULL, '2023-03-09 11:23:00', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (57, 1, NULL, 1, 13, 5, '6409520f10abf', '2023-03-12', '2023-03-09 11:27:40', NULL, NULL, '2023-03-09 11:27:11', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (58, 1, NULL, 1, 13, 5, '6409520f10ac0', '2023-03-12', '2023-03-09 11:47:13', NULL, NULL, '2023-03-09 11:27:11', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (59, 1, NULL, 1, 13, 6, '6409520f10ac1', '2023-03-12', NULL, NULL, NULL, '2023-03-09 11:27:11', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (60, 1, NULL, 1, 13, 6, '6409520f10ac2', '2023-03-12', NULL, NULL, NULL, '2023-03-09 11:27:11', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (61, 1, NULL, 1, 13, 6, '6409520f10ac3', '2023-03-12', NULL, NULL, NULL, '2023-03-09 11:27:11', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (62, 1, NULL, 1, 14, 2, '640a8425e7a07', '2023-03-13', '2023-03-10 09:14:40', NULL, NULL, '2023-03-10 09:13:09', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (63, 1, NULL, 1, 14, 2, '640a8425e7a09', '2023-03-13', '2023-03-10 09:14:40', NULL, NULL, '2023-03-10 09:13:09', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (64, 1, NULL, 1, 14, 6, '640a8425e7a0a', '2023-03-13', NULL, NULL, NULL, '2023-03-10 09:13:09', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (65, 1, NULL, 2, 14, 4, '640a8425e7a3c', '2023-03-13', '2023-03-10 09:14:08', NULL, '2023-03-10 09:17:18', '2023-03-10 09:13:09', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (66, 1, NULL, 2, 14, 4, '640a8425e7a3d', '2023-03-13', '2023-03-10 09:14:29', NULL, '2023-03-10 09:17:18', '2023-03-10 09:13:09', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (67, 1, NULL, 2, 14, 4, '640a8425e7a3e', '2023-03-13', '2023-03-10 09:14:29', NULL, '2023-03-10 09:17:18', '2023-03-10 09:13:09', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (68, 1, NULL, 1, 9, 6, '640a982887eb8', '2023-03-13', NULL, NULL, NULL, '2023-03-10 10:38:32', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (69, 1, NULL, 2, 9, 6, '640a982887ede', '2023-03-13', NULL, NULL, NULL, '2023-03-10 10:38:32', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (70, 1, NULL, 1, 9, 6, '640aaa4174942', '2023-03-13', NULL, NULL, NULL, '2023-03-10 11:55:45', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (71, 1, NULL, 2, 9, 6, '640aaa4174972', '2023-03-13', NULL, NULL, NULL, '2023-03-10 11:55:45', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (72, 1, NULL, 1, 9, 2, '640e7c904fe9c', '2023-03-16', '2023-03-13 09:30:32', NULL, NULL, '2023-03-13 09:29:52', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (73, 1, NULL, 1, 9, 1, '640e7c904fe9d', '2023-03-16', NULL, NULL, NULL, '2023-03-13 09:29:52', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (74, 1, NULL, 2, 9, 3, '640e7c904febb', '2023-03-16', '2023-03-13 09:30:27', NULL, NULL, '2023-03-13 09:29:52', NULL, NULL, NULL, NULL);
INSERT INTO `ag_user_voucher` VALUES (75, 1, NULL, 2, 9, 1, '640e7c904febc', '2023-03-16', NULL, NULL, NULL, '2023-03-13 09:29:52', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for ag_voucher_bind_log
-- ----------------------------
DROP TABLE IF EXISTS `ag_voucher_bind_log`;
CREATE TABLE `ag_voucher_bind_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oper_id` int(11) NOT NULL COMMENT '操作人ID',
  `oper_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作人名称',
  `agent_id` int(11) NOT NULL COMMENT '代理商ID',
  `agent_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代理商名称',
  `shop_id` int(11) NOT NULL COMMENT '门店ID',
  `shop_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '门店名称',
  `voucher_id` int(11) NOT NULL COMMENT '地推券ID',
  `content` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `agent_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代理商电话',
  `shop_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '店铺电话',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '推券绑定日志' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_voucher_bind_log
-- ----------------------------
INSERT INTO `ag_voucher_bind_log` VALUES (25, 1, 'admin', 9, '代理1', 1, '一号串串香', 38, NULL, '2023-03-08 18:21:12', '18380138680', '18081238028');
INSERT INTO `ag_voucher_bind_log` VALUES (26, 1, 'admin', 9, '代理1', 3, '三号串串香', 39, NULL, '2023-03-08 18:21:12', '18380138680', '18081238030');
INSERT INTO `ag_voucher_bind_log` VALUES (27, 1, 'admin', 10, '代理2', 4, '四号串串香', 40, NULL, '2023-03-08 18:21:12', '18380138681', '18081238031');
INSERT INTO `ag_voucher_bind_log` VALUES (28, 1, 'admin', 10, '代理2', 5, '五号串串香', 41, NULL, '2023-03-08 18:21:12', '18380138681', '18081238032');
INSERT INTO `ag_voucher_bind_log` VALUES (29, 1, 'admin', 11, '代理3', 6, '六号串串香', 36, NULL, '2023-03-08 18:21:12', '18380138682', '18081238033');
INSERT INTO `ag_voucher_bind_log` VALUES (30, 1, 'admin', 11, '代理3', 7, '七号串串香', 37, NULL, '2023-03-08 18:21:12', '18380138682', '18081238034');
INSERT INTO `ag_voucher_bind_log` VALUES (31, 1, 'admin', 12, '代理4', 8, '八号串串香', 34, NULL, '2023-03-08 18:21:12', '18380138683', '18081238035');
INSERT INTO `ag_voucher_bind_log` VALUES (32, 1, 'admin', 12, '代理4', 9, '农夫果园（整果，切果，果捞）', 35, NULL, '2023-03-08 18:21:12', '18380138683', '19922139210');
INSERT INTO `ag_voucher_bind_log` VALUES (33, 1, 'admin', 13, '代理5', 10, '岚田予果（解放碑店）', 32, NULL, '2023-03-08 18:21:12', '18380138684', '19102341285');
INSERT INTO `ag_voucher_bind_log` VALUES (34, 1, 'admin', 13, '代理5', 11, '爱果匠（解放碑店•整果•果切•果捞）', 33, NULL, '2023-03-08 18:21:12', '18380138684', '18223178517');
INSERT INTO `ag_voucher_bind_log` VALUES (35, 1, 'admin', 14, '谢谢', 4, '四号串串香', 65, NULL, '2023-03-10 09:17:18', '13980822826', '18081238031');
INSERT INTO `ag_voucher_bind_log` VALUES (36, 1, 'admin', 14, '谢谢', 5, '五号串串香', 66, NULL, '2023-03-10 09:17:18', '13980822826', '18081238032');
INSERT INTO `ag_voucher_bind_log` VALUES (37, 1, 'admin', 14, '谢谢', 10, '岚田予果（解放碑店）', 67, NULL, '2023-03-10 09:17:18', '13980822826', '19102341285');
INSERT INTO `ag_voucher_bind_log` VALUES (38, 0, '系统自动绑定', 9, '代理1', 11, '爱果匠（解放碑店•整果•果切•果捞）', 42, NULL, '2023-03-10 10:15:00', '18380138680', '18223178517');

-- ----------------------------
-- Table structure for ag_voucher_gift_record
-- ----------------------------
DROP TABLE IF EXISTS `ag_voucher_gift_record`;
CREATE TABLE `ag_voucher_gift_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `from_agent_id` int(11) NOT NULL COMMENT '赠出代理商ID',
  `from_agent_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '赠出代理商名称',
  `to_agent_id` int(11) NOT NULL COMMENT '受赠代理商ID',
  `to_agent_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '受赠代理商名称',
  `voucher_id` int(11) NOT NULL COMMENT '券ID',
  `deleted` datetime NULL DEFAULT NULL COMMENT '软删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ag_voucher_gift_record_from_agent_id_to_agent_id_index`(`from_agent_id`, `to_agent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代理商地推券转增记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_voucher_gift_record
-- ----------------------------

-- ----------------------------
-- Table structure for ag_voucher_invate
-- ----------------------------
DROP TABLE IF EXISTS `ag_voucher_invate`;
CREATE TABLE `ag_voucher_invate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `agent_id` int(11) NOT NULL COMMENT '代理商ID',
  `voucher_id` int(11) NOT NULL COMMENT '券ID',
  `invate_time` datetime NOT NULL COMMENT '邀请成功时间',
  `mch_id` int(11) NOT NULL,
  `mch_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户名称',
  `mch_mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户手机号',
  `deleted` datetime NULL DEFAULT NULL COMMENT '软删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ag_voucher_invate_agent_id_voucher_id_index`(`agent_id`, `voucher_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代理商地推卷邀请记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_voucher_invate
-- ----------------------------
INSERT INTO `ag_voucher_invate` VALUES (2, '2023-03-09 09:35:03', 9, 46, '2023-03-09 09:35:03', 4, '林不商户', '19802851288', NULL);
INSERT INTO `ag_voucher_invate` VALUES (5, '2023-03-09 13:32:17', 11, 48, '2023-03-09 13:32:17', 7, '晴美', '15223510016', NULL);
INSERT INTO `ag_voucher_invate` VALUES (6, '2023-03-09 13:42:48', 11, 49, '2023-03-09 13:42:48', 8, '18380503975', '18380503975', NULL);
INSERT INTO `ag_voucher_invate` VALUES (7, '2023-03-09 14:45:50', 13, 58, '2023-03-09 14:45:50', 9, '新的商户', '19802851285', NULL);

-- ----------------------------
-- Table structure for ag_voucher_log
-- ----------------------------
DROP TABLE IF EXISTS `ag_voucher_log`;
CREATE TABLE `ag_voucher_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oper_id` int(11) NOT NULL COMMENT '操作人ID',
  `oper_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作人名称',
  `oper_cat` int(11) NOT NULL COMMENT '操作人类型，1管理系统 2代理商',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `agent_id` int(11) NOT NULL COMMENT '代理商ID',
  `agent_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代理商名称',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `content` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ag_voucher_log_agent_id_index`(`agent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代理商地推券日志' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of ag_voucher_log
-- ----------------------------
INSERT INTO `ag_voucher_log` VALUES (57, 1, 'admin', 1, '2023-03-08 18:16:54', 13, '代理5 18380138684', '测试', '发放代推2张');
INSERT INTO `ag_voucher_log` VALUES (58, 1, 'admin', 1, '2023-03-08 18:17:01', 12, '代理4 18380138683', '测试', '发放代推2张');
INSERT INTO `ag_voucher_log` VALUES (59, 1, 'admin', 1, '2023-03-08 18:17:08', 11, '代理3 18380138682', '测试', '发放代推2张');
INSERT INTO `ag_voucher_log` VALUES (60, 1, 'admin', 1, '2023-03-08 18:17:15', 9, '代理1 18380138680', '测试', '发放代推2张');
INSERT INTO `ag_voucher_log` VALUES (61, 1, 'admin', 1, '2023-03-08 18:17:24', 10, '代理2 18380138681', '测试', '发放代推2张');
INSERT INTO `ag_voucher_log` VALUES (62, 1, 'admin', 1, '2023-03-09 09:10:52', 9, '代理1 18380138680', '测试', '发放自推5张');
INSERT INTO `ag_voucher_log` VALUES (63, 1, 'admin', 1, '2023-03-09 10:30:18', 11, '代理3 18380138682', '测试', '发放自推5张');
INSERT INTO `ag_voucher_log` VALUES (64, 1, 'admin', 1, '2023-03-09 11:23:00', 12, '代理4 18380138683', '测试', '发放代推5张');
INSERT INTO `ag_voucher_log` VALUES (65, 1, 'admin', 1, '2023-03-09 11:23:27', 12, '代理4', NULL, 'ID:52 券类型由代推切换为 自推');
INSERT INTO `ag_voucher_log` VALUES (66, 1, 'admin', 1, '2023-03-09 11:23:31', 12, '代理4', NULL, 'ID:53 券类型由代推切换为 自推');
INSERT INTO `ag_voucher_log` VALUES (67, 1, 'admin', 1, '2023-03-09 11:23:33', 12, '代理4', NULL, 'ID:54 券类型由代推切换为 自推');
INSERT INTO `ag_voucher_log` VALUES (68, 1, 'admin', 1, '2023-03-09 11:23:36', 12, '代理4', NULL, 'ID:56 券类型由代推切换为 自推');
INSERT INTO `ag_voucher_log` VALUES (69, 1, 'admin', 1, '2023-03-09 11:27:11', 13, '代理5 18380138684', '1', '发放自推5张');
INSERT INTO `ag_voucher_log` VALUES (70, 1, 'admin', 1, '2023-03-10 09:13:09', 14, '谢谢 13980822826', '测试', '发放自推3张');
INSERT INTO `ag_voucher_log` VALUES (71, 1, 'admin', 1, '2023-03-10 09:13:09', 14, '谢谢 13980822826', '测试', '发放代推3张');
INSERT INTO `ag_voucher_log` VALUES (72, 1, 'admin', 1, '2023-03-10 10:14:53', 9, '代理1', NULL, 'ID:42 券类型由自推切换为 代推 券状态由待邀请切换为 待分配');
INSERT INTO `ag_voucher_log` VALUES (73, 1, 'admin', 1, '2023-03-10 10:38:32', 9, '代理1 18380138680', '测试', '发放自推1张');
INSERT INTO `ag_voucher_log` VALUES (74, 1, 'admin', 1, '2023-03-10 10:38:32', 9, '代理1 18380138680', '测试', '发放代推1张');
INSERT INTO `ag_voucher_log` VALUES (75, 1, 'admin', 1, '2023-03-10 11:55:45', 9, '代理1 18380138680', '测试', '发放自推1张');
INSERT INTO `ag_voucher_log` VALUES (76, 1, 'admin', 1, '2023-03-10 11:55:45', 9, '代理1 18380138680', '测试', '发放代推1张');
INSERT INTO `ag_voucher_log` VALUES (77, 1, 'admin', 1, '2023-03-13 09:29:52', 9, '代理1 18380138680', '测试', '发放自推2张');
INSERT INTO `ag_voucher_log` VALUES (78, 1, 'admin', 1, '2023-03-13 09:29:52', 9, '代理1 18380138680', '测试', '发放代推2张');

-- ----------------------------
-- Table structure for mch_logistics_order_202302
-- ----------------------------
DROP TABLE IF EXISTS `mch_logistics_order_202302`;
CREATE TABLE `mch_logistics_order_202302`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID，雪花ID+yyMMdd',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `order_no` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号号',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `order_plat` tinyint(4) NOT NULL COMMENT '订单平台，ORDER_PLAT枚举',
  `logistics_plat` smallint(6) NULL DEFAULT NULL COMMENT '配送平台，LOGISTICS_PLAT枚举',
  `mch_id` int(11) NOT NULL,
  `shop_id` int(11) NOT NULL COMMENT '店铺ID，mch_shop_id,推送数据需要进行一次ID转化，不是第三方系统的订单ID',
  `shop_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '门店电话',
  `shop_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '门店地址',
  `receiver_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收件人',
  `receiver_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件电话',
  `receiver_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收件地址',
  `logistics_fee` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '配送费',
  `service_fee` decimal(6, 2) NULL DEFAULT NULL COMMENT '服务费',
  `agent_id` int(11) NOT NULL COMMENT '代理商ID',
  `agent_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代理商名称',
  `agent_phone` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代理商电话',
  `agent_profit` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '代理商分润金额',
  `agent_subsidy` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '代理商补贴金额',
  `agent_income` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '代理商收益（profit+income）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mch_logistics_order_agent_id_index`(`agent_id`) USING BTREE,
  INDEX `mch_logistics_order_mch_id_shop_id_index`(`mch_id`, `shop_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商户配送订单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of mch_logistics_order_202302
-- ----------------------------

-- ----------------------------
-- Table structure for mch_logistics_order_202303
-- ----------------------------
DROP TABLE IF EXISTS `mch_logistics_order_202303`;
CREATE TABLE `mch_logistics_order_202303`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID，雪花ID+yyMMdd',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `order_no` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号号',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `order_plat` tinyint(4) NOT NULL COMMENT '订单平台，ORDER_PLAT枚举',
  `logistics_plat` smallint(6) NULL DEFAULT NULL COMMENT '配送平台，LOGISTICS_PLAT枚举',
  `mch_id` int(11) NOT NULL,
  `shop_id` int(11) NOT NULL COMMENT '店铺ID，mch_shop_id,推送数据需要进行一次ID转化，不是第三方系统的订单ID',
  `shop_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shop_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '门店电话',
  `shop_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '门店地址',
  `receiver_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收件人',
  `receiver_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件电话',
  `receiver_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收件地址',
  `logistics_fee` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '配送费',
  `service_fee` decimal(6, 2) NULL DEFAULT NULL COMMENT '服务费',
  `agent_id` int(11) NOT NULL COMMENT '代理商ID',
  `agent_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代理商名称',
  `agent_phone` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代理商电话',
  `agent_profit` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '代理商分润金额',
  `agent_subsidy` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '代理商补贴金额',
  `agent_income` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '代理商收益（profit+income）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mch_logistics_order_agent_id_index`(`agent_id`) USING BTREE,
  INDEX `mch_logistics_order_mch_id_shop_id_index`(`mch_id`, `shop_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商户配送订单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of mch_logistics_order_202303
-- ----------------------------
INSERT INTO `mch_logistics_order_202303` VALUES ('49239644142423244820230309', '2023-03-09 18:07:39', '1678356459', '2023-03-09 18:07:39', 1, 3, 1, 195, '李帅哥的电力公司', '15223510017', '金周路地铁站B口', '何老师', '18380138680', '金州路55号', 18.50, 10.00, 11, '代理3', '18380138682', 0.00, 0.00, 0.00);
INSERT INTO `mch_logistics_order_202303` VALUES ('49239646674105139220230309', '2023-03-09 18:07:45', '1678356465', '2023-03-09 18:07:45', 1, 8, 1, 195, '李帅哥的电力公司', '15223510017', '金周路地铁站B口', '何老师', '18380138680', '金州路55号', 18.50, 10.00, 11, '代理3', '18380138682', 0.00, 0.00, 0.00);
INSERT INTO `mch_logistics_order_202303` VALUES ('49239650217033728020230309', '2023-03-09 18:07:54', '1678356474', '2023-03-09 18:07:54', 1, 8, 1, 195, '李帅哥的电力公司', '15223510017', '金周路地铁站B口', '何老师', '18380138680', '金州路55号', 18.50, 10.00, 11, '代理3', '18380138682', 0.00, 0.00, 0.00);
INSERT INTO `mch_logistics_order_202303` VALUES ('49239652373325414420230309', '2023-03-09 18:07:59', '1678356479', '2023-03-09 18:07:59', 1, 2, 1, 195, '李帅哥的电力公司', '15223510017', '金周路地铁站B口', '何老师', '18380138680', '金州路55号', 18.50, 10.00, 11, '代理3', '18380138682', 0.00, 0.00, 0.00);

-- ----------------------------
-- Table structure for mch_merchant
-- ----------------------------
DROP TABLE IF EXISTS `mch_merchant`;
CREATE TABLE `mch_merchant`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `mch_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商户名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `source` smallint(6) NOT NULL COMMENT '商户来源，MCH_SRC枚举',
  `source_mch_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源系统商户ID',
  `addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户地址',
  `phone` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户电话',
  `state` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1正常 2失效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商户表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of mch_merchant
-- ----------------------------
INSERT INTO `mch_merchant` VALUES (1, '六年二班串串香', '2023-03-07 00:00:00', 1, '1', '四川省成都市金牛区派克公馆', '15223510018', 1);
INSERT INTO `mch_merchant` VALUES (2, '农夫果园（整果，切果，果捞）', NULL, 1, '3584', '重庆市,重庆市,渝中区', '13901230196', 1);
INSERT INTO `mch_merchant` VALUES (3, '尚品瓦香鸡', NULL, 1, '81933', '四川省,成都市,新都区', '13402317808', 1);
INSERT INTO `mch_merchant` VALUES (4, '林不商户', NULL, 1, '8199', '城市道路111号', '19802851288', 1);
INSERT INTO `mch_merchant` VALUES (5, '冯瑶', NULL, 1, '81936', '四川省,成都市,金牛区', '18381001233', 1);
INSERT INTO `mch_merchant` VALUES (6, '金有谦', NULL, 1, '81938', '河北省,秦皇岛市,海港区', '19802851285', 1);
INSERT INTO `mch_merchant` VALUES (7, '晴美', NULL, 1, '81940', '四川省,成都市,金牛区', '15223510016', 1);
INSERT INTO `mch_merchant` VALUES (8, '18380503975', NULL, 1, '81942', '四川省,成都市,金牛区', '18380503975', 1);
INSERT INTO `mch_merchant` VALUES (9, '新的商户', NULL, 1, '81945', '湖北省,十堰市,郧阳区', '19802851285', 1);
INSERT INTO `mch_merchant` VALUES (10, '正宗隆江猪脚饭', NULL, 1, '81946', '四川省,成都市,新都区', '18244235958', 1);
INSERT INTO `mch_merchant` VALUES (11, '马师烤肉', NULL, 1, '81947', '四川省,成都市,新都区', '13558673251', 1);
INSERT INTO `mch_merchant` VALUES (12, '骆姐冷淡杯', NULL, 1, '81948', '四川省,成都市,新都区', '13568842861', 1);
INSERT INTO `mch_merchant` VALUES (13, '牧羊人烤羊腿', NULL, 1, '81949', '四川省,成都市,新都区', '18683937988', 1);
INSERT INTO `mch_merchant` VALUES (14, '李福林', NULL, 1, '81950', '四川省,绵阳市,游仙区', '15082170637', 1);
INSERT INTO `mch_merchant` VALUES (15, '黄姐', NULL, 1, '81951', '四川省,成都市,金牛区', '15121474703', 1);
INSERT INTO `mch_merchant` VALUES (16, '黑子', NULL, 1, '81954', '四川省,成都市,新都区', '17781694253', 1);
INSERT INTO `mch_merchant` VALUES (17, '火盆烧烤', NULL, 1, '81956', '四川省,成都市,锦江区', '18227108850', 1);
INSERT INTO `mch_merchant` VALUES (18, '聚友老砂锅', NULL, 1, '81958', '四川省,成都市,新都区', '18030760298', 1);
INSERT INTO `mch_merchant` VALUES (19, '尤卤天府逸家店', NULL, 1, '81961', '四川省,成都市,龙泉驿区', '18908018956', 1);

-- ----------------------------
-- Table structure for mch_shop
-- ----------------------------
DROP TABLE IF EXISTS `mch_shop`;
CREATE TABLE `mch_shop`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `mch_id` int(11) NOT NULL COMMENT '商户ID',
  `shop_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '门店名称',
  `source` smallint(6) NOT NULL COMMENT '门店来源，MCH_SRC枚举',
  `source_shop_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '来源系统门店ID',
  `addr` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '门店地址',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `all_order_num` int(11) NOT NULL DEFAULT 0 COMMENT '总订单数',
  `avg_order_num` int(11) NOT NULL DEFAULT 0 COMMENT '平均N天订单数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `state` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1正常 2失效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 206 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商户门店表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of mch_shop
-- ----------------------------
INSERT INTO `mch_shop` VALUES (1, 1, '一号串串香', 1, '15', '四川省成都市金牛区锦州了', '18081238028', 0, 0, '0000-00-00 00:00:00', 1);
INSERT INTO `mch_shop` VALUES (3, 1, '三号串串香', 1, '11', '四川省成都市金牛区锦州了', '18081238030', 0, 0, '0000-00-00 00:00:00', 1);
INSERT INTO `mch_shop` VALUES (4, 1, '四号串串香', 1, '112', '四川省成都市金牛区锦州了', '18081238031', 0, 0, '0000-00-00 00:00:00', 1);
INSERT INTO `mch_shop` VALUES (5, 1, '五号串串香', 1, '13', '四川省成都市金牛区锦州了', '18081238032', 0, 0, '0000-00-00 00:00:00', 1);
INSERT INTO `mch_shop` VALUES (6, 1, '六号串串香', 1, '2', '四川省成都市金牛区锦州了', '18081238033', 0, 0, '0000-00-00 00:00:00', 1);
INSERT INTO `mch_shop` VALUES (7, 1, '七号串串香', 1, '1', '四川省成都市金牛区锦州了', '18081238034', 0, 0, '0000-00-00 00:00:00', 1);
INSERT INTO `mch_shop` VALUES (8, 1, '八号串串香', 1, '14', '四川省成都市金牛区锦州了', '18081238035', 0, 0, '0000-00-00 00:00:00', 1);
INSERT INTO `mch_shop` VALUES (9, 2, '农夫果园（整果，切果，果捞）', 1, '3466', '重庆市渝中区解放碑街道临江门25号', '19922139210', 0, 0, '2023-03-07 18:31:30', 1);
INSERT INTO `mch_shop` VALUES (10, 2, '岚田予果（解放碑店）', 1, '3467', '重庆市渝中区七星岗街道火药局街23号1-2', '19102341285', 0, 0, '2023-03-07 18:31:31', 1);
INSERT INTO `mch_shop` VALUES (11, 2, '爱果匠（解放碑店•整果•果切•果捞）', 1, '3468', '重庆市渝中区南纪门街道白象街258号附9号', '18223178517', 0, 0, '2023-03-07 18:31:31', 1);
INSERT INTO `mch_shop` VALUES (12, 2, '嗨心果（果切•整果•果捞）', 1, '3469', '重庆市渝中区七星岗街道民安园7号1-10', '13829140371', 0, 0, '2023-03-07 18:31:32', 1);
INSERT INTO `mch_shop` VALUES (13, 2, '故里花园鲜花店（鲜花•向日葵•玫瑰花）', 1, '3470', '重庆市渝中区石油路街道茶亭南路3号平街一层附9号', '17316797802', 0, 0, '2023-03-07 18:31:32', 1);
INSERT INTO `mch_shop` VALUES (14, 2, '简简吟（蛋糕.甜品.饮料）', 1, '3471', '重庆市渝中区南纪门街道渝中区中兴路228号附3-45', '17782037357', 0, 0, '2023-03-07 18:31:32', 1);
INSERT INTO `mch_shop` VALUES (15, 2, '辣呦-品质川菜（安东街店）', 1, '3472', '陕西省西安市碑林区安东街55号门面房', '17791304561', 0, 0, '2023-03-07 18:31:33', 1);
INSERT INTO `mch_shop` VALUES (16, 2, '苏福记•品质中国川菜', 1, '3473', '陕西省西安市碑林区互助路66号电力大厦三楼西侧3001号', '17795616560', 0, 0, '2023-03-07 18:31:33', 1);
INSERT INTO `mch_shop` VALUES (17, 2, '菜很下饭辣椒炒肉（李家村店）', 1, '3474', '陕西省西安市碑林区雁塔北路8号李家村万达广场3层3-30/331A/332A号商铺', '18740671461', 0, 0, '2023-03-07 18:31:33', 1);
INSERT INTO `mch_shop` VALUES (18, 2, '呱呱村长的泡椒牛蛙是招牌', 1, '3475', '陕西省西安市碑林区东关南街大新巷小区5号楼8号门面', '17791409895', 0, 0, '2023-03-07 18:31:34', 1);
INSERT INTO `mch_shop` VALUES (19, 2, '养生鼎•鲍鱼捞饭•滋补炖汤（钟楼店）', 1, '3476', '陕西省西安市碑林区建国路建国二巷16号加利利连锁酒店1楼', '13609158979', 0, 0, '2023-03-07 18:31:34', 1);
INSERT INTO `mch_shop` VALUES (20, 2, '喜汤人•养身炖汤（碑林店）', 1, '3477', '陕西省西安市碑林区建东街7院7号楼5单元1层1号', '13227775952', 0, 0, '2023-03-07 18:31:34', 1);
INSERT INTO `mch_shop` VALUES (21, 2, '金海家肉蟹煲•活蟹现煲（小寨店）', 1, '3478', '陕西省西安市碑林区测绘路4号测绘局甲1号楼丰润广场2F001号', '13669240418', 0, 0, '2023-03-07 18:31:35', 1);
INSERT INTO `mch_shop` VALUES (22, 2, '三阳开泰酒楼（建设路店）', 1, '3479', '陕西省西安市碑林区建设西路65号新旅城小区1号楼2层10202室', '18811403260', 0, 0, '2023-03-07 18:31:35', 1);
INSERT INTO `mch_shop` VALUES (23, 2, '清真.疆客椒麻鸡', 1, '3480', '陕西省西安市碑林区东关南街大新巷小区9号楼1号门店', '13999852058', 0, 0, '2023-03-07 18:31:36', 1);
INSERT INTO `mch_shop` VALUES (24, 2, '鲜尚果园（钟楼店）', 1, '3481', '陕西省西安市碑林区东县门小区2号楼2-30102', '18309256011', 0, 0, '2023-03-07 18:31:36', 1);
INSERT INTO `mch_shop` VALUES (25, 2, '优品生鲜（西安乐居场店）', 1, '3482', '陕西省西安市碑林区乐居场南路56号开心果蔬农贸市场10号商铺', '18840488103', 0, 0, '2023-03-07 18:31:36', 1);
INSERT INTO `mch_shop` VALUES (26, 2, '蜜匠也花艺生活馆', 1, '3483', '陕西省西安市碑林区长安路长安大街3号小区3B2208', '15529515221', 0, 0, '2023-03-07 18:31:37', 1);
INSERT INTO `mch_shop` VALUES (27, 2, '汤小鲜和范小满', 1, '3484', '成都市青白江同华大道199号10幢2单元1层119号', '15882275242', 0, 0, '2023-03-07 18:31:37', 1);
INSERT INTO `mch_shop` VALUES (28, 2, '蟹小煲●肉蟹煲●牛蛙●龙虾\n（青白江店）', 1, '3485', '成都市青白江区政府中路91号4栋附6、7号1层', '18380435386', 0, 0, '2023-03-07 18:31:37', 1);
INSERT INTO `mch_shop` VALUES (29, 2, '鼎鸡.鸡汤局.菌炖鸡汤饭', 1, '3486', '成都市青白江区石家碾东路289号53栋1层9号', '17780693828', 0, 0, '2023-03-07 18:31:38', 1);
INSERT INTO `mch_shop` VALUES (30, 2, '兰州拉面-新疆大盘鸡', 1, '3487', '祥福镇青白江大道899号商业中心A栋1层9号', '13739471852', 0, 0, '2023-03-07 18:31:38', 1);
INSERT INTO `mch_shop` VALUES (31, 2, '向杨·网红定制生日蛋糕\n（青白江店）', 1, '3488', '成都市青白江区杨柳路2号6栋1层7室-8室', '18382431083', 0, 0, '2023-03-07 18:31:38', 1);
INSERT INTO `mch_shop` VALUES (32, 2, '拾亿蛋糕店', 1, '3489', '成都市青白江区杨柳路99号48号1层', '15208137542', 0, 0, '2023-03-07 18:31:39', 1);
INSERT INTO `mch_shop` VALUES (33, 2, 'T3便利（承前超市店）', 1, '3490', '青白江区凤凰西八路250、252、254、256号', '13594765497', 0, 0, '2023-03-07 18:31:39', 1);
INSERT INTO `mch_shop` VALUES (34, 2, '茄猫猫美蛙鱼头火锅', 1, '3491', '成都市青白江区凤祥大道878号附3-4号', '19108222381', 0, 0, '2023-03-07 18:31:40', 1);
INSERT INTO `mch_shop` VALUES (35, 2, '美益水果（凤凰西八路店）', 1, '3492', '成都市青白江区凤凰西八路93号', '13880379605', 0, 0, '2023-03-07 18:31:40', 1);
INSERT INTO `mch_shop` VALUES (36, 2, '新万州烤鱼（青白江店）', 1, '3493', '成都市青白江区政府中路91号3栋7号', '15982263295', 0, 0, '2023-03-07 18:31:40', 1);
INSERT INTO `mch_shop` VALUES (37, 2, '汇百佳便利店（有享福超市店）', 1, '3494', '成都市青白江区凤祥大道80号、82号、84号', '13899557673', 0, 0, '2023-03-07 18:31:41', 1);
INSERT INTO `mch_shop` VALUES (38, 2, '歪火锅（青白江店）', 1, '3495', '成都市青白江区凤祥大道1477、1479号1层', '19008229884', 0, 0, '2023-03-07 18:31:41', 1);
INSERT INTO `mch_shop` VALUES (39, 2, '波娃特色烧烤店\n（海鲜.烤鱼.自贡菜）', 1, '3496', '青白江区石家碾东路289号28栋8、9号', '18117830236', 0, 0, '2023-03-07 18:31:41', 1);
INSERT INTO `mch_shop` VALUES (40, 2, '正宗重庆美蛙鱼·鲜鱼火锅\n（青白江店）', 1, '3497', '成都市青白江区杨柳路2号37栋附23、24号', '17711541198', 0, 0, '2023-03-07 18:31:42', 1);
INSERT INTO `mch_shop` VALUES (41, 2, '沁香格鲜花店', 1, '3498', '青白江区政府南路14号', '17380591837', 0, 0, '2023-03-07 18:31:42', 1);
INSERT INTO `mch_shop` VALUES (42, 2, '邂逅花坊鲜花（花语嫣然花艺）', 1, '3499', '青白江区教育街114号一层', '18030671285', 0, 0, '2023-03-07 18:31:42', 1);
INSERT INTO `mch_shop` VALUES (43, 2, '三只熊の手作卷边披萨（彭州店）', 1, '3500', '成都市彭州市天彭镇天府西路100号1层', '18482320663', 0, 0, '2023-03-07 18:31:43', 1);
INSERT INTO `mch_shop` VALUES (44, 2, '自贡鲜锅兔·干锅·烧烤\n（彭州店）', 1, '3501', '成都市彭州市天彭街道兴隆街57号', '19950389287', 0, 0, '2023-03-07 18:31:43', 1);
INSERT INTO `mch_shop` VALUES (45, 2, '晨曦鲍鱼饭（彭州店）', 1, '3502', '成都市彭州市天彭街道兴盛二巷20号1层', '19150375536', 0, 0, '2023-03-07 18:31:43', 1);
INSERT INTO `mch_shop` VALUES (46, 2, '柚畔鲜果（彭州店）', 1, '3503', '成都市彭州市天彭镇东湖北路216号3栋1层', '18008053410', 0, 0, '2023-03-07 18:31:44', 1);
INSERT INTO `mch_shop` VALUES (47, 2, '有厨（弘大外东菜市场）', 1, '3504', '彭州市天彭镇天府路市场', '13551221589', 0, 0, '2023-03-07 18:31:44', 1);
INSERT INTO `mch_shop` VALUES (48, 2, '尚邻副食店', 1, '3505', '四川省彭州市天彭镇泰安北路64号', '13678096858', 0, 0, '2023-03-07 18:31:45', 1);
INSERT INTO `mch_shop` VALUES (49, 2, '花伴花坊（女神节鲜花）', 1, '3506', '彭州市天彭街道朝阳南路629号2栋305号', '15884567322', 0, 0, '2023-03-07 18:31:45', 1);
INSERT INTO `mch_shop` VALUES (50, 2, '荆都烤鱼·烧烤工坊（创始店）', 1, '3507', '天彭镇西海南街6.8号', '13658034247', 0, 0, '2023-03-07 18:31:45', 1);
INSERT INTO `mch_shop` VALUES (51, 2, 'Dancecream舞动奶油\n（网红生日蛋糕·彭州店）', 1, '3508', '成都市彭州市天彭镇建设巷22号1层', '13438490693', 0, 0, '2023-03-07 18:31:46', 1);
INSERT INTO `mch_shop` VALUES (52, 2, '御用·蟹肉煲·牛蛙煲', 1, '3509', '四川省彭州市致和街道萧公路51号附17号', '15208497188', 0, 0, '2023-03-07 18:31:46', 1);
INSERT INTO `mch_shop` VALUES (53, 2, '晨曦炖汤(彭州店）', 1, '3510', '彭州市天彭街道兴盛二巷20号附1号1层', '19150375536', 0, 0, '2023-03-07 18:31:46', 1);
INSERT INTO `mch_shop` VALUES (54, 2, '乐其cake', 1, '3511', '彭州市天彭镇天府西路88号、90号1栋1楼', '18708252127', 0, 0, '2023-03-07 18:31:47', 1);
INSERT INTO `mch_shop` VALUES (55, 2, '成都烧烤研究所·烤鱼干锅（彭州店）', 1, '3512', '四川省彭州市萧公路67号', '19950389287', 0, 0, '2023-03-07 18:31:47', 1);
INSERT INTO `mch_shop` VALUES (56, 2, '竹一隐叫花鸡·窑鸡·烤鸡\n（东六巷店）', 1, '3513', '四川省成都市彭州市天彭街道新民西街东六巷28号', '17602838280', 0, 0, '2023-03-07 18:31:47', 1);
INSERT INTO `mch_shop` VALUES (57, 2, '本草堂药店（十年店）', 1, '3514', '四川省彭州市致和镇长江路145号', '18328314467', 0, 0, '2023-03-07 18:31:48', 1);
INSERT INTO `mch_shop` VALUES (58, 2, '李小姐的花\n（玫瑰花，生日鲜花，向日葵）', 1, '3515', '彭州市致和镇协和路399号附107号7栋1层', '18123368950', 0, 0, '2023-03-07 18:31:48', 1);
INSERT INTO `mch_shop` VALUES (59, 2, '芝佳基汉堡（锦泰路店）', 1, '3516', '四川省彭州市天彭街道锦泰路124号', '15928531663', 0, 0, '2023-03-07 18:31:49', 1);
INSERT INTO `mch_shop` VALUES (60, 2, '半夏星空', 1, '3517', '彭州市天彭街道龙塔路58号', '17828129030', 0, 0, '2023-03-07 18:31:49', 1);
INSERT INTO `mch_shop` VALUES (61, 2, '四喜烤蹄（烧烤-彭州店）', 1, '3518', '成都市彭州市天彭镇绣城南路109号附104号4栋1层', '19160370030', 0, 0, '2023-03-07 18:31:49', 1);
INSERT INTO `mch_shop` VALUES (62, 2, '一碗盖饭（都江堰店）', 1, '3519', '四川省都江堰市奎光塔街道康复路下街199、201号', '19113507926', 0, 0, '2023-03-07 18:31:50', 1);
INSERT INTO `mch_shop` VALUES (63, 2, '熊福记·麻辣兔头（干锅、烤鱼）', 1, '3520', '都江堰市幸福街道解放社区学府路252号', '15308179438', 0, 0, '2023-03-07 18:31:50', 1);
INSERT INTO `mch_shop` VALUES (64, 2, '尊宝披萨（都江堰店）', 1, '3521', '都江堰市灌口街道柳河社区建设路159号（蒲阳路口）', '18980061436', 0, 0, '2023-03-07 18:31:50', 1);
INSERT INTO `mch_shop` VALUES (65, 2, '京城记·北京烤鸭', 1, '3522', '都江堰市幸福街道翔凤桥社区翔凤路168号5栋附4号', '19008226672', 0, 0, '2023-03-07 18:31:51', 1);
INSERT INTO `mch_shop` VALUES (66, 2, '烤无双苕皮·豆干·炸串（都江堰店）', 1, '3523', '都江堰市幸福街道翔凤桥社区青城路185号附3号', '19160007717', 0, 0, '2023-03-07 18:31:51', 1);
INSERT INTO `mch_shop` VALUES (67, 2, '窑鸡王（都江堰文荟路店）', 1, '3524', '都江堰市幸福街道莲花社区文荟路3号4栋附29号', '17702892723', 0, 0, '2023-03-07 18:31:52', 1);
INSERT INTO `mch_shop` VALUES (68, 2, '小厨房家常菜', 1, '3525', '都江堰市奎光塔街道康复路下街203号', '19113507926', 0, 0, '2023-03-07 18:31:52', 1);
INSERT INTO `mch_shop` VALUES (69, 2, '鲜食惠火锅食材（自煮小火锅、烤肉）', 1, '3526', '都江堰市银杏街道王家桥社区蒲阳河北路中段127号', '15982224228', 0, 0, '2023-03-07 18:31:52', 1);
INSERT INTO `mch_shop` VALUES (70, 2, '大渝人家·火锅专卖店', 1, '3527', '都江堰市幸福街道莲花社区莲花北路68号1栋1层19号', '15184446953', 0, 0, '2023-03-07 18:31:53', 1);
INSERT INTO `mch_shop` VALUES (71, 2, '蟹黄拌饭', 1, '3528', '都江堰市幸福街道幸福社区都江堰大道112号\n大融城美食街弄堂里（外）6号', '18227621314', 0, 0, '2023-03-07 18:31:53', 1);
INSERT INTO `mch_shop` VALUES (72, 2, '京喜便利店（百伦店）', 1, '3529', '都江堰市幸福街道翔凤桥社区景凤街46、44号3栋1层4号', '13548092910', 0, 0, '2023-03-07 18:31:53', 1);
INSERT INTO `mch_shop` VALUES (73, 2, '小马购●生活超市（迎宾大道店）', 1, '3530', '都江堰市迎宾大道416号附5号', '19940707127', 0, 0, '2023-03-07 18:31:54', 1);
INSERT INTO `mch_shop` VALUES (74, 2, '雪菲网红手工艺蛋糕（都江堰店）', 1, '3531', '都江堰市幸福街道解放社区中山北路107号', '18628181801', 0, 0, '2023-03-07 18:31:54', 1);
INSERT INTO `mch_shop` VALUES (75, 2, '芙利来·网红轻奢蛋糕（都江堰店）', 1, '3532', '都江堰市幸福街道社区景凤路69号', '19179438830', 0, 0, '2023-03-07 18:31:55', 1);
INSERT INTO `mch_shop` VALUES (76, 2, '巴黎甜甜生日蛋糕（都江堰店）', 1, '3533', '都江堰市灌口街道玉带桥社区金带路105号', '18782485482', 0, 0, '2023-03-07 18:31:55', 1);
INSERT INTO `mch_shop` VALUES (77, 2, '麦香人家（网红轻奢蛋糕·江安路店）', 1, '3534', '江安路147号（西川尤兔头旁）', '13880349806', 0, 0, '2023-03-07 18:31:55', 1);
INSERT INTO `mch_shop` VALUES (78, 2, '菠拿拿水果（都江堰店）', 1, '3535', '都江堰市幸福街道翔凤桥社区青城路183号附6号', '15388238563', 0, 0, '2023-03-07 18:31:56', 1);
INSERT INTO `mch_shop` VALUES (79, 2, '亦果捞●水果捞●鲜果切（都江堰店）', 1, '3536', '幸福街道莲花社区莲花北路66号', '13688451834', 0, 0, '2023-03-07 18:31:56', 1);
INSERT INTO `mch_shop` VALUES (80, 2, '比邻鲜（高桥商贸市场店）', 1, '3537', '都江堰市银杏街道高桥社区彩虹大道北段396号\n予乐高桥彩虹广场2号楼1层21号', '15295133817', 0, 0, '2023-03-07 18:31:56', 1);
INSERT INTO `mch_shop` VALUES (81, 2, '遇见花开生日花束\n（开业花篮、生日鲜花、玫瑰花）', 1, '3538', '都江堰市幸福街道幸福社区泰和巷60号', '13668137301', 0, 0, '2023-03-07 18:31:57', 1);
INSERT INTO `mch_shop` VALUES (82, 2, '桔子花艺馆（生日鲜花-开业花篮-玫瑰花）', 1, '3539', '都江堰翔凤路246号（丽水印象小区）', '13568966202', 0, 0, '2023-03-07 18:31:57', 1);
INSERT INTO `mch_shop` VALUES (83, 2, '大桔家·川派烤肉（都江堰店）', 1, '3540', '都江堰市灌口街道西川社区江安路183号', '19382108306', 0, 0, '2023-03-07 18:31:57', 1);
INSERT INTO `mch_shop` VALUES (84, 2, '老成都川菜馆（新都店）', 1, '3541', '新都区新都街道清源东路108号静安小区6栋10号', '17882245168', 0, 0, '2023-03-07 18:31:58', 1);
INSERT INTO `mch_shop` VALUES (85, 2, '云南铜锅洋芋饭', 1, '3542', '新都区新都街道育英路91号附14号', '18884780862', 0, 0, '2023-03-07 18:31:58', 1);
INSERT INTO `mch_shop` VALUES (86, 2, '一碗西菜（现炒小碗川菜）', 1, '3543', '新都街道正因南街东七巷24号', '13628207051', 0, 0, '2023-03-07 18:31:59', 1);
INSERT INTO `mch_shop` VALUES (87, 2, '七师兄火锅（新都店）', 1, '3544', '成都市新都区新都街道正因南街西六巷14号', '18875294121', 0, 0, '2023-03-07 18:31:59', 1);
INSERT INTO `mch_shop` VALUES (88, 2, '三顾冒菜（金都街店）', 1, '3545', '新都区桂湖街道金都街87-89号一层', '18030507691', 0, 0, '2023-03-07 18:31:59', 1);
INSERT INTO `mch_shop` VALUES (89, 2, '楚多多·盐帮私房菜', 1, '3546', '新都区桂湖街道炬光路222号8栋1层9号', '18483230457', 0, 0, '2023-03-07 18:32:00', 1);
INSERT INTO `mch_shop` VALUES (90, 2, '纸盒炒饭（新都店）', 1, '3547', '新都区新都街道肖林社区川音五巷141号', '19150346223', 0, 0, '2023-03-07 18:32:00', 1);
INSERT INTO `mch_shop` VALUES (91, 2, '炉匠麻辣干锅坊（育英路店）', 1, '3548', '新都区新都街道育英路99号附21号', '13438136571', 0, 0, '2023-03-07 18:32:00', 1);
INSERT INTO `mch_shop` VALUES (92, 2, '烧火铺·即享火锅（新都店）', 1, '3549', '新都区新都街道静安路149号附19号', '19934496689', 0, 0, '2023-03-07 18:32:01', 1);
INSERT INTO `mch_shop` VALUES (93, 2, '活卤君海鲜辣卤（新都店）', 1, '3550', '新都区马超社区新园路四巷69号', '19827585501', 0, 0, '2023-03-07 18:32:01', 1);
INSERT INTO `mch_shop` VALUES (94, 2, '德信火拼海鲜大咖', 1, '3551', '新都区新都街道工业大道西段69号1栋附203号', '15928510620', 0, 0, '2023-03-07 18:32:02', 1);
INSERT INTO `mch_shop` VALUES (95, 2, '美益水果（新都区店）', 1, '3552', '成都市新都区新都街道育英路87号附17号', '18884505851', 0, 0, '2023-03-07 18:32:02', 1);
INSERT INTO `mch_shop` VALUES (96, 2, '果大全（新都店）', 1, '3553', '成都市新都区新都街道新园路三巷1层91号', '1771613160', 0, 0, '2023-03-07 18:32:02', 1);
INSERT INTO `mch_shop` VALUES (97, 2, '切果NOW！', 1, '3554', '成都市新都区新都街道新园路三巷60号', '15719498285', 0, 0, '2023-03-07 18:32:03', 1);
INSERT INTO `mch_shop` VALUES (98, 2, '焙多星蛋糕（三河场店）', 1, '3555', '成都市新都区三河街道惠民巷85号', '19108231104', 0, 0, '2023-03-07 18:32:03', 1);
INSERT INTO `mch_shop` VALUES (99, 2, '恩焙优品·蛋糕·甜品（新都店）', 1, '3556', '新都区新都街道同心路168号', '18161288394', 0, 0, '2023-03-07 18:32:03', 1);
INSERT INTO `mch_shop` VALUES (100, 2, '优多甜心烘焙蛋糕', 1, '3557', '新都区桂湖街道东街113号', '17790267180', 0, 0, '2023-03-07 18:32:04', 1);
INSERT INTO `mch_shop` VALUES (101, 2, '菜大全（新都钟楼店）', 1, '3558', '新都区新都街道马超农贸市场内（1门市）', '18202834712', 0, 0, '2023-03-07 18:32:04', 1);
INSERT INTO `mch_shop` VALUES (102, 2, '爱鲜爱厨生鲜超市（明康路店）', 1, '3559', '新都区新都街道天缘路三段390号菜摊位附5-6号', '15756570595', 0, 0, '2023-03-07 18:32:05', 1);
INSERT INTO `mch_shop` VALUES (103, 2, '高启强卖猪脚饭养高启兰（新都宝光店）', 1, '3560', '新都区桂湖街道宝光大道南段139号', '13541370985', 0, 0, '2023-03-07 18:32:05', 1);
INSERT INTO `mch_shop` VALUES (104, 2, '蔬菜到家（邛崃中心市场店）', 1, '3561', '邛崃市文君街道文君街63号附21号', '13458659351', 0, 0, '2023-03-07 18:32:05', 1);
INSERT INTO `mch_shop` VALUES (105, 2, '圣乐兰蛋糕店（西街店）', 1, '3562', '西街229号', '13402822478', 0, 0, '2023-03-07 18:32:06', 1);
INSERT INTO `mch_shop` VALUES (106, 2, '袁氏食品店', 1, '3563', '临邛镇大北街199号', '18030603886', 0, 0, '2023-03-07 18:32:06', 1);
INSERT INTO `mch_shop` VALUES (107, 2, '味佳乐·网红创意蛋糕（邛崃总店）', 1, '3564', '邛崃市临邛街道君平大道618号', '15228988812', 0, 0, '2023-03-07 18:32:06', 1);
INSERT INTO `mch_shop` VALUES (108, 2, '乐至烧烤·龙虾·烤鱼（邛崃总店）', 1, '3565', '邛崃市临邛街道棉花街82号附34、35号1层', '19382200197', 0, 0, '2023-03-07 18:32:07', 1);
INSERT INTO `mch_shop` VALUES (109, 2, '重庆万州烤鱼·干锅·烧烤（邛崃店）', 1, '3566', '邛崃市文君街道花园巷19号附1号', '19382200197', 0, 0, '2023-03-07 18:32:07', 1);
INSERT INTO `mch_shop` VALUES (110, 2, '梵花里(情人节鲜花礼物·生日鲜花花束\n·开业花篮）', 1, '3567', '文君街道东街328号', '19802856525', 0, 0, '2023-03-07 18:32:07', 1);
INSERT INTO `mch_shop` VALUES (111, 2, '豪记卤煮龙虾（海鲜·邛崃店）', 1, '3568', '文君街道七星街88号', '15184448678', 0, 0, '2023-03-07 18:32:08', 1);
INSERT INTO `mch_shop` VALUES (112, 2, '1919酒类直供（邛崃东星大道店）', 1, '3569', '邛崃东星大道86号1栋1层86号', '4009991919', 0, 0, '2023-03-07 18:32:08', 1);
INSERT INTO `mch_shop` VALUES (113, 2, '自贡鲜锅兔·干锅·烧烤\n（邛崃店）', 1, '3570', '邛崃市文君街道长松路663号1楼', '19382200197', 0, 0, '2023-03-07 18:32:09', 1);
INSERT INTO `mch_shop` VALUES (114, 2, '我们的小院糟粕醋火锅', 1, '3571', '崇州市崇阳街道西前街28号', '19182170612', 0, 0, '2023-03-07 18:32:09', 1);
INSERT INTO `mch_shop` VALUES (115, 2, '米兰西饼生日蛋糕', 1, '3572', '崇阳街道金带街188号', '17313037424', 0, 0, '2023-03-07 18:32:09', 1);
INSERT INTO `mch_shop` VALUES (116, 2, '舌尖疯狂在成都（崇州店）', 1, '3573', '崇州市鹤风路392-394号', '19182297087', 0, 0, '2023-03-07 18:32:10', 1);
INSERT INTO `mch_shop` VALUES (117, 2, '惠多超市·前置仓', 1, '3574', '崇州市崇庆街道明欣五巷30-32号', '15208497583', 0, 0, '2023-03-07 18:32:10', 1);
INSERT INTO `mch_shop` VALUES (118, 2, '有厨（马甲碾菜场店）', 1, '3575', '崇州市崇阳街道蜀州南路东一巷1号马家碾市场门面蔬菜档C6', '13880380124', 0, 0, '2023-03-08 10:43:26', 1);
INSERT INTO `mch_shop` VALUES (119, 2, '蟹煲王肉蟹煲', 1, '3576', '崇州市崇阳街道唐安西路513号', '13982080392', 0, 0, '2023-03-08 10:43:27', 1);
INSERT INTO `mch_shop` VALUES (120, 2, '董小姐一人一份酸菜鱼（学院北路店）', 1, '3577', '崇州市崇庆街道学苑北路东一巷129号', '19828934352', 0, 0, '2023-03-08 10:43:28', 1);
INSERT INTO `mch_shop` VALUES (121, 2, '来自朴奶奶的爱', 1, '3578', '崇州市崇阳街道东兴北街西四巷55号', '18200313844', 0, 0, '2023-03-08 10:43:29', 1);
INSERT INTO `mch_shop` VALUES (122, 2, '自贡特色干锅', 1, '3579', '成都市崇州市崇庆街道永康西路51号附3号', '18349100650', 0, 0, '2023-03-08 10:43:29', 1);
INSERT INTO `mch_shop` VALUES (123, 2, '米糖烘焙·生日蛋糕（崇州店）', 1, '3580', '龙门南街174号', '15008278001', 0, 0, '2023-03-08 10:43:30', 1);
INSERT INTO `mch_shop` VALUES (124, 2, '嘉里烤肉', 1, '3581', '成都市崇州市蜀庆街178', '18884164167', 0, 0, '2023-03-08 10:43:31', 1);
INSERT INTO `mch_shop` VALUES (125, 2, '鲜果林（异果集市店）', 1, '3582', '崇州市崇阳街道石羊西街175号', '13982184071', 0, 0, '2023-03-08 10:43:31', 1);
INSERT INTO `mch_shop` VALUES (126, 2, '崇州浪漫花语鲜花店', 1, '3583', '崇州市崇阳街道唐安西路180号', '13348887649', 0, 0, '2023-03-08 10:43:32', 1);
INSERT INTO `mch_shop` VALUES (127, 2, '利华串串（火锅冒菜）', 1, '3584', '崇州市崇阳街道晋康北路263、265号', '18982282048', 0, 0, '2023-03-08 10:43:33', 1);
INSERT INTO `mch_shop` VALUES (128, 2, '严记羊棒骨小酒馆', 1, '3585', '崇州市崇阳街道绿荫街82、84号', '18086850672', 0, 0, '2023-03-08 10:43:33', 1);
INSERT INTO `mch_shop` VALUES (129, 2, '崇州完美花艺鲜花店', 1, '3586', '大东街233号', '15397645394', 0, 0, '2023-03-08 10:43:34', 1);
INSERT INTO `mch_shop` VALUES (130, 2, '碗碗香·剁椒木桶饭（穿金路店）', 1, '3587', '云南昆明市盘龙区穿金路20-22号附5号', '13577131380', 0, 0, '2023-03-08 10:43:34', 1);
INSERT INTO `mch_shop` VALUES (131, 2, '八只蛙（招牌紫苏牛蛙·同德店）', 1, '3588', '昆明市五华区莲花街道办事处学府社区莲花池正街122号', '19539961808', 0, 0, '2023-03-08 10:43:35', 1);
INSERT INTO `mch_shop` VALUES (132, 2, '1988韩式拌饭（白云路店）', 1, '3589', '昆明市盘龙区白云路229号附1号万发生鲜农贸市场1-1-8c', '15912426806', 0, 0, '2023-03-08 10:43:36', 1);
INSERT INTO `mch_shop` VALUES (133, 2, '小酱南北烤肉到家·送烤盘（同德广场店）', 1, '3590', '昆明市盘龙区金洲湾蓝屿B区2幢9号商铺', '19988528275', 0, 0, '2023-03-08 10:43:36', 1);
INSERT INTO `mch_shop` VALUES (134, 2, '老长沙湘菜馆（鼓楼店）', 1, '3591', '昆明市盘龙区鼓楼路27号15栋1-2-3-4号', '15911535757', 0, 0, '2023-03-08 10:43:37', 1);
INSERT INTO `mch_shop` VALUES (135, 2, '禾畔家蛋糕（学府路店）', 1, '3592', '学府路674号铺面', '15288338547', 0, 0, '2023-03-08 10:43:38', 1);
INSERT INTO `mch_shop` VALUES (136, 2, '源满Cake蛋糕甜品（金泉店）', 1, '3593', '昆明市盘龙区金泉小区5幢2单元102附2号', '15924731889', 0, 0, '2023-03-08 10:43:38', 1);
INSERT INTO `mch_shop` VALUES (137, 2, '天天领鲜·生鲜到家（北市区店）', 1, '3594', '昆明市盘龙区金辰街道办事处云波社区居委会\n云小路金汁园小区2栋3号商铺', '18250485996', 0, 0, '2023-03-08 10:43:39', 1);
INSERT INTO `mch_shop` VALUES (138, 2, '优品24小时商超（同德店）', 1, '3595', '昆明市盘龙区金辰街道办事处小庄村328号商铺', '13294968129', 0, 0, '2023-03-08 10:43:40', 1);
INSERT INTO `mch_shop` VALUES (139, 2, '美人鱼鲜花店', 1, '3596', '昆明市盘龙区北京路559号1楼102号', '18988271882', 0, 0, '2023-03-08 10:43:40', 1);
INSERT INTO `mch_shop` VALUES (140, 2, '由花有喜（玫瑰花，生日花，鲜花）', 1, '3597', '昆明市盘龙区联盟街道办事处奥斯迪尚义花市停车场J11', '18788452741', 0, 0, '2023-03-08 10:43:41', 1);
INSERT INTO `mch_shop` VALUES (141, 2, '三个年轻人鲜切水果', 1, '3598', '昆明市盘龙区金辰街道办事处罗丈村193号附2号商铺', '18213998503', 0, 0, '2023-03-08 10:43:42', 1);
INSERT INTO `mch_shop` VALUES (142, 2, '一家被炒面耽误的炒饭店（昆明店）', 1, '3599', '昆明市盘龙区白云路东区G-115号商铺', '15368240573', 0, 0, '2023-03-08 10:43:42', 1);
INSERT INTO `mch_shop` VALUES (143, 2, '热火朝天麻辣小嫩牛火锅（新迎新城店）', 1, '3600', '东华街道办事处新迎路182号新迎新城购物中心7栋F4004-4005号', '087163114133', 0, 0, '2023-03-08 10:43:43', 1);
INSERT INTO `mch_shop` VALUES (144, 2, '今日牛坊小火锅（潮汕鲜切牛肉·同德店）', 1, '3601', '盘龙区联盟街道办事处长青社区居委会金洲湾蓝屿B2栋', '18213869184', 0, 0, '2023-03-08 10:43:44', 1);
INSERT INTO `mch_shop` VALUES (145, 2, '旮旯食堂（白塔路店）', 1, '3602', '昆明市盘龙区白塔路311号附11-14号房', '18669268257', 0, 0, '2023-03-08 10:43:44', 1);
INSERT INTO `mch_shop` VALUES (146, 2, '海味鲜湘（同德店·海鲜·龙虾·湘菜）', 1, '3603', '昆明市盘龙区北郊小厂村101号农贸市场A区016-018、021-022号', '18183826967', 0, 0, '2023-03-08 10:43:45', 1);
INSERT INTO `mch_shop` VALUES (147, 2, '小时光麻辣香锅', 1, '3604', '昆明市盘龙区和信花苑二期商铺40号', '15559682007', 0, 0, '2023-03-08 10:43:46', 1);
INSERT INTO `mch_shop` VALUES (148, 2, '老成都川菜', 1, '3605', '贵州省贵阳市南明区花果园街道花果园项目二期B区（南）\n8、9、10号楼2层27号商铺（花果园办事处）', '18285061050', 0, 0, '2023-03-08 10:43:46', 1);
INSERT INTO `mch_shop` VALUES (149, 2, '成都川悦火锅冒菜（贵阳总店）', 1, '3606', '贵州省贵阳市云岩区市西河街道云岩区公山坡12号附12栋', '15685501667', 0, 0, '2023-03-08 10:43:47', 1);
INSERT INTO `mch_shop` VALUES (150, 2, '砂锅猪肚鸡汤饭（花果园店）', 1, '3607', '贵阳市南明区花果园街道花果园彭家湾花果园项目一期\n第14栋3层17号房（花果园办事处）', '19908540163', 0, 0, '2023-03-08 10:43:48', 1);
INSERT INTO `mch_shop` VALUES (151, 2, '青云路留一手烤鱼', 1, '3608', '贵阳市云岩区头桥街道花果园-花果园商铺-A北区-1至10栋负一层102B', '18786726291', 0, 0, '2023-03-08 10:43:48', 1);
INSERT INTO `mch_shop` VALUES (152, 2, '凯辉便利店（中华南路3店）', 1, '3609', '贵阳市南明区中华南路203号海天大厦1层（中南办事处）', '18685182962', 0, 0, '2023-03-08 10:43:49', 1);
INSERT INTO `mch_shop` VALUES (153, 2, '万佳美', 1, '3610', '贵阳市南明区青云路城市方舟D栋一楼9号（新华社区）', '18776141142', 0, 0, '2023-03-08 10:43:50', 1);
INSERT INTO `mch_shop` VALUES (154, 2, '糖老鸭水果（果切·零食·干货）', 1, '3611', '南明区大理石路68号门面糖老鸭水果超市', '17716681782', 0, 0, '2023-03-08 10:43:50', 1);
INSERT INTO `mch_shop` VALUES (155, 2, '都市园田（青云店）', 1, '3612', '贵阳市南明区青云路117号青云都汇新路口农贸市场T069号（兴关社区）', '15285934240', 0, 0, '2023-03-08 10:43:51', 1);
INSERT INTO `mch_shop` VALUES (156, 2, '惠城芝心生日蛋糕', 1, '3613', '南明区中华南路街道办事处市场路6，8号6-12单元1层18号（中南办事处）', '19192556297', 0, 0, '2023-03-08 10:43:51', 1);
INSERT INTO `mch_shop` VALUES (157, 2, '金麦田糕点（肉松小贝·泡芙·蛋挞）', 1, '3614', '贵阳市云岩区文昌阁街道环城东路440号3单元1层2号', '19885535691', 0, 0, '2023-03-08 10:43:52', 1);
INSERT INTO `mch_shop` VALUES (158, 2, '壹品海鲜粥（汇金店）', 1, '3615', '贵阳市云岩区威清门街道山林路30号1.2单元1-3层附7号', '17886298181', 0, 0, '2023-03-08 10:43:53', 1);
INSERT INTO `mch_shop` VALUES (159, 2, '传奇赤水黑豆花火锅', 1, '3616', '黔灵东路133号附11号', '13688518338', 0, 0, '2023-03-08 10:43:53', 1);
INSERT INTO `mch_shop` VALUES (160, 2, '爱尚花艺（生日鲜花.开业花篮.发财树）', 1, '3617', '贵阳市云岩区宝山北路书香门第1-8号', '15885502714', 0, 0, '2023-03-08 10:43:54', 1);
INSERT INTO `mch_shop` VALUES (161, 2, '故里花园鲜花店（贵阳店）', 1, '3618', '贵阳市云岩区福田巷9号1幢13单元2层1号（贵州青旅对面嘉禾路56号）', '18185172758', 0, 0, '2023-03-08 10:43:55', 1);
INSERT INTO `mch_shop` VALUES (162, 2, '江渔子小海鲜（贵阳店）', 1, '3619', '贵阳市贵阳国家高新技术产业开发区长岭街道长岭南路33号\n天一国际广场3-4栋负1层14号', '18085171558', 0, 0, '2023-03-08 10:43:55', 1);
INSERT INTO `mch_shop` VALUES (163, 2, '饭坨坨寿司·便当', 1, '3620', '贵阳市云岩区富水中路104号1单元1层8号', '18685134093', 0, 0, '2023-03-08 10:43:56', 1);
INSERT INTO `mch_shop` VALUES (164, 2, '王真真·烧椒拌饭', 1, '3621', '花果园街道花果园后街彭家湾花果园项目一期第13栋（13）3层39号房', '17585536634', 0, 0, '2023-03-08 10:43:57', 1);
INSERT INTO `mch_shop` VALUES (165, 2, '尚味菜馆（盖饭、木桶饭、炒饭）', 1, '3622', '贵阳市云岩区香狮路196号新里程商城F2层特7号', '17262291516', 0, 0, '2023-03-08 10:43:57', 1);
INSERT INTO `mch_shop` VALUES (166, 2, '有一家排骨饭·小火锅', 1, '3623', '贵州省过样式云岩区合群路D栋1层', '18285636574', 0, 0, '2023-03-08 10:43:58', 1);
INSERT INTO `mch_shop` VALUES (167, 2, '花雕醉鸡', 1, '3624', '金堂县三星镇学府大道279号附38号', '19180824697', 0, 0, '2023-03-08 10:43:59', 1);
INSERT INTO `mch_shop` VALUES (168, 2, '鸡本无敌（大\n盘鸡，椒麻鸡）', 1, '3625', '金堂县栖贤街道学府大道279号附112号10栋1层', '17608016763', 0, 0, '2023-03-08 10:43:59', 1);
INSERT INTO `mch_shop` VALUES (169, 2, '禾昭寿司 元气便当', 1, '3626', '金堂县栖贤街道279号1栋1层118号\n', '13880745153', 0, 0, '2023-03-08 10:44:00', 1);
INSERT INTO `mch_shop` VALUES (170, 2, '青柠。口水鸡。\n柠檬鸡。椒麻鸡', 1, '3627', '金堂县栖贤街道学府大道\n279号3栋1层103号', '17608016763', 0, 0, '2023-03-08 10:44:00', 1);
INSERT INTO `mch_shop` VALUES (171, 2, '张秀梅（烤肉拌饭\n丨脆皮鸡...\n', 1, '3628', '金堂县栖贤街道学府大道655号2栋附\n11号', '13541663496', 0, 0, '2023-03-08 10:44:01', 1);
INSERT INTO `mch_shop` VALUES (172, 2, '晨曦炖汤\n（金堂店）', 1, '3629', '金堂县赵镇永安街一段20号', '17844573436', 0, 0, '2023-03-08 10:44:02', 1);
INSERT INTO `mch_shop` VALUES (173, 2, '壹家手作披萨', 1, '3630', '金堂县栖贤街道学府大道655号11栋\n附206号', '18048086570', 0, 0, '2023-03-08 10:44:02', 1);
INSERT INTO `mch_shop` VALUES (174, 2, '豪一佰·网红芝士\n牛肉卷', 1, '3631', '金堂县栖贤街道学府大道279号', '18980057849', 0, 0, '2023-03-08 10:44:03', 1);
INSERT INTO `mch_shop` VALUES (175, 2, '王子花艺\n（一分店）', 1, '3632', '金堂县赵镇康宁街116-118', '13060086667', 0, 0, '2023-03-08 10:44:04', 1);
INSERT INTO `mch_shop` VALUES (176, 2, '爱琪儿蛋糕', 1, '3633', '金堂县赵镇安康街69号', '18086826426', 0, 0, '2023-03-08 10:44:04', 1);
INSERT INTO `mch_shop` VALUES (177, 2, '甜趣·CaKe', 1, '3634', '金堂县万方街143号', '18881482207', 0, 0, '2023-03-08 10:44:05', 1);
INSERT INTO `mch_shop` VALUES (178, 2, '金堂小吴水果', 1, '3635', '金堂县赵镇泰吉横街100号', '13688355502', 0, 0, '2023-03-08 10:44:06', 1);
INSERT INTO `mch_shop` VALUES (179, 2, '蔬菜鲜生', 1, '3636', '金堂县赵镇金泉路186号8栋1层05号', '18280238907', 0, 0, '2023-03-08 10:44:06', 1);
INSERT INTO `mch_shop` VALUES (180, 2, '故里花园鲜花店（鲜花•向日葵•玫瑰花）', 1, '3637', '重庆市渝中区石油路街道茶亭南路3号平街一层附9号', '17316797802', 0, 0, '2023-03-08 10:44:07', 1);
INSERT INTO `mch_shop` VALUES (181, 2, '简简吟（蛋糕.甜品.饮料）', 1, '3638', '重庆市渝中区南纪门街道渝中区中兴路228号附3-45', '17782037357', 0, 0, '2023-03-08 10:44:08', 1);
INSERT INTO `mch_shop` VALUES (182, 2, '辣呦-品质川菜（安东街店）', 1, '3639', '陕西省西安市碑林区安东街55号门面房', '17791304561', 0, 0, '2023-03-08 10:44:08', 1);
INSERT INTO `mch_shop` VALUES (183, 2, '苏福记•品质中国川菜', 1, '3640', '陕西省西安市碑林区互助路66号电力大厦三楼西侧3001号', '17795616560', 0, 0, '2023-03-08 10:44:09', 1);
INSERT INTO `mch_shop` VALUES (184, 2, '菜很下饭辣椒炒肉（李家村店）', 1, '3641', '陕西省西安市碑林区雁塔北路8号李家村万达广场3层3-30/331A/332A号商铺', '18740671461', 0, 0, '2023-03-08 10:44:09', 1);
INSERT INTO `mch_shop` VALUES (185, 2, '呱呱村长的泡椒牛蛙是招牌', 1, '3642', '陕西省西安市碑林区东关南街大新巷小区5号楼8号门面', '17791409895', 0, 0, '2023-03-08 10:44:10', 1);
INSERT INTO `mch_shop` VALUES (186, 0, '双东来耙耙牛肉', 1, '81502', '四川省成都市金牛区花照壁西顺街358号附213号', '13696271592', 0, 0, '2023-03-08 14:34:41', 1);
INSERT INTO `mch_shop` VALUES (187, 3, '尚品瓦香鸡米饭', 1, '81517', '四川省成都市新都区新都街道正因北街西二巷正因新街', '13402317808', 0, 0, '2023-03-08 17:44:44', 1);
INSERT INTO `mch_shop` VALUES (191, 4, '这门店名', 1, '9', '金州路55号', '18380138680', 0, 0, '2023-03-09 10:19:41', 1);
INSERT INTO `mch_shop` VALUES (192, 0, '我de mend', 1, '80996', '浙江省宁波市江北区', '18081238027', 0, 0, '2023-02-28 16:38:39', 1);
INSERT INTO `mch_shop` VALUES (194, 8, '李永爱的店铺', 1, '81520', '龙泉驿出口(S3天府国际机场高速西北向)', '15223510016', 0, 0, '2023-03-09 13:45:03', 1);
INSERT INTO `mch_shop` VALUES (195, 8, '李帅哥的电力公司', 1, '81523', '金周路地铁站B口', '15223510017', 0, 0, '2023-03-09 14:39:34', 1);
INSERT INTO `mch_shop` VALUES (196, 9, '新的门店', 1, '81524', '小旭家巫山烤鱼', '19802851285', 0, 0, '2023-03-09 14:47:36', 1);
INSERT INTO `mch_shop` VALUES (197, 8, '李师傅店铺', 1, '81525', '青羊区', '18380132932', 0, 0, '2023-03-09 15:07:40', 1);
INSERT INTO `mch_shop` VALUES (198, 11, '马师烤肉', 1, '81526', '四川省成都市新都区新都街道正因北街正因新街', '13558673251', 0, 0, '2023-03-09 16:47:48', 1);
INSERT INTO `mch_shop` VALUES (199, 12, '骆姐冷淡杯', 1, '81527', '四川省成都市新都区新都街道正因南街东九巷1号正因新街', '13568842861', 0, 0, '2023-03-09 17:54:58', 1);
INSERT INTO `mch_shop` VALUES (200, 13, '牧羊人烤羊腿', 1, '81528', '四川省成都市新都区正因南街西八巷1、3号', '18683937988', 0, 0, '2023-03-09 18:37:43', 1);
INSERT INTO `mch_shop` VALUES (201, 0, '邹平小蚂蚁同城', 1, '81529', '山东省滨州市邹平市黛溪街道聚和村', '13256490249', 0, 0, '2023-03-09 20:19:01', 1);
INSERT INTO `mch_shop` VALUES (202, 17, '前锋西线国际', 1, '81532', '四川省成都市金牛区金泉街道正成·拉斐三期正成·拉斐2期', '18227108850', 0, 0, '2023-03-10 15:35:38', 1);
INSERT INTO `mch_shop` VALUES (203, 18, '聚友老砂锅', 1, '81533', '四川省成都市新都区新都镇川音小区川音二巷160号', '18030760298', 0, 0, '2023-03-10 15:35:57', 1);
INSERT INTO `mch_shop` VALUES (204, 0, '斗舌盘盘麻辣烫', 1, '81535', '四川省成都市新都区川音二巷152号', '19381606823', 0, 0, '2023-03-10 15:58:47', 1);
INSERT INTO `mch_shop` VALUES (205, 19, '尤卤天府逸家店', 1, '81537', '四川省成都市龙泉驿区大面街道金槐街158号11栋附116号', '18908018956', 0, 0, '2023-03-10 16:10:03', 1);

-- ----------------------------
-- Table structure for pt_config
-- ----------------------------
DROP TABLE IF EXISTS `pt_config`;
CREATE TABLE `pt_config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '配置key',
  `contens` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统配置表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of pt_config
-- ----------------------------
INSERT INTO `pt_config` VALUES (1, 'vision', '1.1.1');
INSERT INTO `pt_config` VALUES (2, 'Ground', '{\"validity\":3}');
INSERT INTO `pt_config` VALUES (3, 'Store', '{\"type\":\"0\",\"systemDeploy\":100,\"autonomyDeploy\":2400,\"day\":5}');
INSERT INTO `pt_config` VALUES (5, 'StoreShow', '{\"storeName\":true,\"storePhone\":true,\"storeAddress\":true,\"storeMerchant\":true,\"storeDetailed\":true}');
INSERT INTO `pt_config` VALUES (6, 'AutoStoreSet', '{\"activateDay\":1,\"state\":true}');
INSERT INTO `pt_config` VALUES (7, 'OrderMoneySet', '{\"selfBinding\":{\"selfBindingType\":\"1\",\"selfBindingMoney\":3,\"selfBindingCost\":0,\"selfBindingRatio\":0},\"unification\":{\"unificationType\":\"2\",\"unificationMoney\":0,\"unificationCost\":20,\"unificationRatio\":60},\"subsidy\":{\"subsidyOrder\":12,\"subsidyUpperLimit\":20,\"subsidyStore\":12,\"subsidyHighest\":0},\"selfBindingMoney\":0}');
INSERT INTO `pt_config` VALUES (13, 'Taxrate', '{\"taxRateValue\":0.6,\"state\":true}');
INSERT INTO `pt_config` VALUES (16, 'Basics', '{\"url\":\"https://res.juhebang.com.cn/video/202211151737.mp4\",\"phone\":\"1\"}');
INSERT INTO `pt_config` VALUES (20, 'CrontabTask', '{\"VoucherExpireTask\": true,\"VoucherAutoSendTask\": true,\"VoucherAutoBindShopTask\": true,\"IncomeShopTask\": true,\"IncomeAgentTask\": true,\"IncomeDayTask\": true,\"IncomeMonthTask\": true,\"IncomeUserTask\": true,\"IncomeBillTask\": true,\"ShopTmingTask\": true}');
INSERT INTO `pt_config` VALUES (22, 'StoreSubsidySet', '{\"min\":1,\"max\":10,\"state\":true}');
INSERT INTO `pt_config` VALUES (30, 'AgentSubsidy-5', '{\"subsidyTime\":[\"2023-03-07\",\"2023-03-07\"],\"money\":2,\"remarks\":\"测试\",\"agentName\":\"代理5\"}');
INSERT INTO `pt_config` VALUES (31, 'AgentSubsidy-4', '{\"subsidyTime\":[\"2023-03-07\",\"2023-03-31\"],\"money\":5,\"remarks\":\"测试\",\"agentName\":\"代理4\"}');
INSERT INTO `pt_config` VALUES (32, 'AgentSubsidy-3', '{\"subsidyTime\":[\"2023-03-08\",\"2023-04-30\"],\"money\":0.8,\"remarks\":\"测试\",\"agentName\":\"代理3\"}');
INSERT INTO `pt_config` VALUES (33, 'AgentSubsidy-1', '{\"subsidyTime\":[\"2023-03-07\",\"2023-03-10\"],\"money\":3,\"remarks\":\"测试\",\"agentName\":\"代理1\"}');
INSERT INTO `pt_config` VALUES (34, 'AgentSubsidy-2', '{\"subsidyTime\":[\"2023-03-07\",\"2023-03-10\"],\"money\":3,\"remarks\":\"测试\",\"agentName\":\"代理2\"}');
INSERT INTO `pt_config` VALUES (35, 'AgentSubsidy-13', '{\"subsidyTime\":[\"2023-03-08\",\"2023-03-08\"],\"money\":2,\"remarks\":\"测试\",\"agentName\":\"代理5\"}');
INSERT INTO `pt_config` VALUES (36, 'AgentSubsidy-12', '{\"subsidyTime\":[\"2023-03-08\",\"2023-04-30\"],\"money\":5,\"remarks\":\"测试\",\"agentName\":\"代理4\"}');
INSERT INTO `pt_config` VALUES (37, 'AgentSubsidy-11', '{\"subsidyTime\":[\"2023-03-08\",\"2023-03-09\"],\"money\":3.5,\"remarks\":\"测试\",\"agentName\":\"代理3\"}');
INSERT INTO `pt_config` VALUES (38, 'AgentSubsidy-10', '{\"subsidyTime\":[\"2023-03-09\",\"2023-03-31\"],\"money\":4,\"remarks\":\"测试\",\"agentName\":\"代理2\"}');
INSERT INTO `pt_config` VALUES (39, 'AgentSubsidy-9', '{\"subsidyTime\":[\"2023-03-08\",\"2023-03-31\"],\"money\":8,\"remarks\":\"测试\",\"agentName\":\"代理1\"}');
INSERT INTO `pt_config` VALUES (40, 'AgentSubsidy-14', '{\"subsidyTime\":[\"2023-03-10\",\"2023-04-27\"],\"money\":2,\"remarks\":\"测试\",\"agentName\":\"谢谢\"}');

-- ----------------------------
-- Table structure for pt_config_log
-- ----------------------------
DROP TABLE IF EXISTS `pt_config_log`;
CREATE TABLE `pt_config_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'key',
  `front_val` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作前数据',
  `behind_val` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作后数据',
  `create_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 236 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统配置操作记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of pt_config_log
-- ----------------------------
INSERT INTO `pt_config_log` VALUES (193, 'AgentSubsidy-5', '[]', '{\"name\":\"AgentSubsidy-5\",\"contens\":\"{\\\"subsidyTime\\\":[\\\"2023-03-07\\\",\\\"2023-03-07\\\"],\\\"money\\\":2,\\\"remarks\\\":\\\"测试\\\",\\\"agentName\\\":\\\"代理5\\\"}\"}', '2023-03-07 17:38:08', '管理员');
INSERT INTO `pt_config_log` VALUES (194, 'AgentSubsidy-4', '[]', '{\"name\":\"AgentSubsidy-4\",\"contens\":\"{\\\"subsidyTime\\\":[\\\"2023-03-07\\\",\\\"2023-03-31\\\"],\\\"money\\\":5,\\\"remarks\\\":\\\"测试\\\",\\\"agentName\\\":\\\"代理4\\\"}\"}', '2023-03-07 17:38:24', '管理员');
INSERT INTO `pt_config_log` VALUES (195, 'AgentSubsidy-3', '[]', '{\"name\":\"AgentSubsidy-3\",\"contens\":\"{\\\"subsidyTime\\\":[\\\"2023-03-08\\\",\\\"2023-04-30\\\"],\\\"money\\\":0.8,\\\"remarks\\\":\\\"测试\\\",\\\"agentName\\\":\\\"代理3\\\"}\"}', '2023-03-07 17:38:43', '管理员');
INSERT INTO `pt_config_log` VALUES (196, 'AgentSubsidy-1', '[]', '{\"name\":\"AgentSubsidy-1\",\"contens\":\"{\\\"subsidyTime\\\":[\\\"2023-03-07\\\",\\\"2023-03-10\\\"],\\\"money\\\":3,\\\"remarks\\\":\\\"测试\\\",\\\"agentName\\\":\\\"代理1\\\"}\"}', '2023-03-07 17:39:03', '管理员');
INSERT INTO `pt_config_log` VALUES (197, 'AgentSubsidy-2', '[]', '{\"name\":\"AgentSubsidy-2\",\"contens\":\"{\\\"subsidyTime\\\":[\\\"2023-03-07\\\",\\\"2023-03-10\\\"],\\\"money\\\":3,\\\"remarks\\\":\\\"测试\\\",\\\"agentName\\\":\\\"代理2\\\"}\"}', '2023-03-07 17:51:50', '管理员');
INSERT INTO `pt_config_log` VALUES (198, 'Store', '{\"id\":3,\"name\":\"Store\",\"contens\":\"{\\\"type\\\":\\\"1\\\",\\\"systemDeploy\\\":20,\\\"autonomyDeploy\\\":2400,\\\"day\\\":5}\"}', '{\"name\":\"Store\",\"contens\":\"{\\\"type\\\":\\\"1\\\",\\\"systemDeploy\\\":20,\\\"autonomyDeploy\\\":2400,\\\"day\\\":1}\"}', '2023-03-07 17:58:08', '管理员');
INSERT INTO `pt_config_log` VALUES (199, 'StoreSubsidySet', '{\"id\":22,\"name\":\"StoreSubsidySet\",\"contens\":\"{\\\"min\\\":1,\\\"max\\\":20,\\\"state\\\":true}\"}', '{\"name\":\"StoreSubsidySet\",\"contens\":\"{\\\"min\\\":1,\\\"max\\\":50,\\\"state\\\":true}\"}', '2023-03-07 18:10:10', '管理员');
INSERT INTO `pt_config_log` VALUES (200, 'AutoStoreSet', '{\"id\":6,\"name\":\"AutoStoreSet\",\"contens\":\"{\\\"activateDay\\\":0,\\\"state\\\":true}\"}', '{\"name\":\"AutoStoreSet\",\"contens\":\"{\\\"activateDay\\\":1,\\\"state\\\":true}\"}', '2023-03-08 09:05:16', '管理员');
INSERT INTO `pt_config_log` VALUES (201, 'Store', '{\"id\":3,\"name\":\"Store\",\"contens\":\"{\\\"type\\\":\\\"1\\\",\\\"systemDeploy\\\":20,\\\"autonomyDeploy\\\":2400,\\\"day\\\":1}\"}', '{\"name\":\"Store\",\"contens\":\"{\\\"type\\\":\\\"1\\\",\\\"systemDeploy\\\":20,\\\"autonomyDeploy\\\":2400,\\\"day\\\":2}\"}', '2023-03-08 10:18:17', '管理员');
INSERT INTO `pt_config_log` VALUES (202, 'AutoStoreSet', '{\"id\":6,\"name\":\"AutoStoreSet\",\"contens\":\"{\\\"activateDay\\\":1,\\\"state\\\":true}\"}', '{\"name\":\"AutoStoreSet\",\"contens\":\"{\\\"activateDay\\\":3,\\\"state\\\":true}\"}', '2023-03-08 10:27:05', '管理员');
INSERT INTO `pt_config_log` VALUES (203, 'Store', '{\"id\":3,\"name\":\"Store\",\"contens\":\"{\\\"type\\\":\\\"1\\\",\\\"systemDeploy\\\":20,\\\"autonomyDeploy\\\":2400,\\\"day\\\":2}\"}', '{\"name\":\"Store\",\"contens\":\"{\\\"type\\\":\\\"1\\\",\\\"systemDeploy\\\":100,\\\"autonomyDeploy\\\":2400,\\\"day\\\":2}\"}', '2023-03-08 11:15:24', '管理员');
INSERT INTO `pt_config_log` VALUES (204, 'StoreSubsidySet', '{\"id\":22,\"name\":\"StoreSubsidySet\",\"contens\":\"{\\\"min\\\":1,\\\"max\\\":50,\\\"state\\\":true}\"}', '{\"name\":\"StoreSubsidySet\",\"contens\":\"{\\\"min\\\":1,\\\"max\\\":100,\\\"state\\\":true}\"}', '2023-03-08 11:15:32', '管理员');
INSERT INTO `pt_config_log` VALUES (205, 'Store', '{\"id\":3,\"name\":\"Store\",\"contens\":\"{\\\"type\\\":\\\"1\\\",\\\"systemDeploy\\\":100,\\\"autonomyDeploy\\\":2400,\\\"day\\\":2}\"}', '{\"name\":\"Store\",\"contens\":\"{\\\"type\\\":\\\"2\\\",\\\"systemDeploy\\\":100,\\\"autonomyDeploy\\\":2400}\"}', '2023-03-08 13:06:44', '管理员');
INSERT INTO `pt_config_log` VALUES (206, 'Store', '{\"id\":3,\"name\":\"Store\",\"contens\":\"{\\\"type\\\":\\\"2\\\",\\\"systemDeploy\\\":100,\\\"autonomyDeploy\\\":2400}\"}', '{\"name\":\"Store\",\"contens\":\"{\\\"type\\\":\\\"0\\\",\\\"systemDeploy\\\":100,\\\"autonomyDeploy\\\":2400}\"}', '2023-03-08 13:45:23', '管理员');
INSERT INTO `pt_config_log` VALUES (207, 'Store', '{\"id\":3,\"name\":\"Store\",\"contens\":\"{\\\"type\\\":\\\"0\\\",\\\"systemDeploy\\\":100,\\\"autonomyDeploy\\\":2400}\"}', '{\"name\":\"Store\",\"contens\":\"{\\\"type\\\":\\\"1\\\",\\\"systemDeploy\\\":100,\\\"autonomyDeploy\\\":2400,\\\"day\\\":5}\"}', '2023-03-08 13:57:32', '管理员');
INSERT INTO `pt_config_log` VALUES (208, 'StoreSubsidySet', '{\"id\":22,\"name\":\"StoreSubsidySet\",\"contens\":\"{\\\"min\\\":1,\\\"max\\\":100,\\\"state\\\":true}\"}', '{\"name\":\"StoreSubsidySet\",\"contens\":\"{\\\"min\\\":1,\\\"max\\\":10,\\\"state\\\":true}\"}', '2023-03-08 16:04:32', '管理员');
INSERT INTO `pt_config_log` VALUES (209, 'Store', '{\"id\":3,\"name\":\"Store\",\"contens\":\"{\\\"type\\\":\\\"1\\\",\\\"systemDeploy\\\":100,\\\"autonomyDeploy\\\":2400,\\\"day\\\":5}\"}', '{\"name\":\"Store\",\"contens\":\"{\\\"type\\\":\\\"0\\\",\\\"systemDeploy\\\":100,\\\"autonomyDeploy\\\":2400,\\\"day\\\":5}\"}', '2023-03-08 16:08:24', '管理员');
INSERT INTO `pt_config_log` VALUES (210, 'AutoStoreSet', '{\"id\":6,\"name\":\"AutoStoreSet\",\"contens\":\"{\\\"activateDay\\\":3,\\\"state\\\":true}\"}', '{\"name\":\"AutoStoreSet\",\"contens\":\"{\\\"activateDay\\\":1,\\\"state\\\":true}\"}', '2023-03-08 18:15:20', '管理员');
INSERT INTO `pt_config_log` VALUES (211, 'AgentSubsidy-13', '[]', '{\"name\":\"AgentSubsidy-13\",\"contens\":\"{\\\"subsidyTime\\\":[\\\"2023-03-08\\\",\\\"2023-03-08\\\"],\\\"money\\\":2,\\\"remarks\\\":\\\"测试\\\",\\\"agentName\\\":\\\"代理5\\\"}\"}', '2023-03-08 18:18:02', '管理员');
INSERT INTO `pt_config_log` VALUES (212, 'AgentSubsidy-12', '[]', '{\"name\":\"AgentSubsidy-12\",\"contens\":\"{\\\"subsidyTime\\\":[\\\"2023-03-08\\\",\\\"2023-04-30\\\"],\\\"money\\\":5,\\\"remarks\\\":\\\"测试\\\",\\\"agentName\\\":\\\"代理4\\\"}\"}', '2023-03-08 18:18:14', '管理员');
INSERT INTO `pt_config_log` VALUES (213, 'AgentSubsidy-11', '[]', '{\"name\":\"AgentSubsidy-11\",\"contens\":\"{\\\"subsidyTime\\\":[\\\"2023-03-08\\\",\\\"2023-03-09\\\"],\\\"money\\\":3.5,\\\"remarks\\\":\\\"测试\\\",\\\"agentName\\\":\\\"代理3\\\"}\"}', '2023-03-08 18:18:28', '管理员');
INSERT INTO `pt_config_log` VALUES (214, 'AgentSubsidy-10', '[]', '{\"name\":\"AgentSubsidy-10\",\"contens\":\"{\\\"subsidyTime\\\":[\\\"2023-03-09\\\",\\\"2023-03-31\\\"],\\\"money\\\":4,\\\"remarks\\\":\\\"测试\\\",\\\"agentName\\\":\\\"代理2\\\"}\"}', '2023-03-08 18:18:39', '管理员');
INSERT INTO `pt_config_log` VALUES (215, 'AgentSubsidy-9', '[]', '{\"name\":\"AgentSubsidy-9\",\"contens\":\"{\\\"subsidyTime\\\":[\\\"2023-03-08\\\",\\\"2023-03-31\\\"],\\\"money\\\":8,\\\"remarks\\\":\\\"测试\\\",\\\"agentName\\\":\\\"代理1\\\"}\"}', '2023-03-08 18:18:50', '管理员');
INSERT INTO `pt_config_log` VALUES (216, 'StoreShow', '{\"id\":5,\"name\":\"StoreShow\",\"contens\":\"{\\\"storeName\\\":true,\\\"storePhone\\\":true,\\\"storeAddress\\\":true,\\\"storeMerchant\\\":true,\\\"storeDetailed\\\":true}\"}', '{\"name\":\"StoreShow\",\"contens\":\"{\\\"storeName\\\":false,\\\"storePhone\\\":false,\\\"storeAddress\\\":false,\\\"storeMerchant\\\":false,\\\"storeDetailed\\\":false}\"}', '2023-03-09 15:05:12', '管理员');
INSERT INTO `pt_config_log` VALUES (217, 'StoreShow', '{\"id\":5,\"name\":\"StoreShow\",\"contens\":\"{\\\"storeName\\\":false,\\\"storePhone\\\":false,\\\"storeAddress\\\":false,\\\"storeMerchant\\\":false,\\\"storeDetailed\\\":false}\"}', '{\"name\":\"StoreShow\",\"contens\":\"{\\\"storeName\\\":false,\\\"storePhone\\\":false,\\\"storeAddress\\\":false,\\\"storeMerchant\\\":false,\\\"storeDetailed\\\":true}\"}', '2023-03-09 15:05:18', '管理员');
INSERT INTO `pt_config_log` VALUES (218, 'OrderMoneySet', '{\"id\":7,\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"1\\\",\\\"selfBindingMoney\\\":0.5,\\\"selfBindingCost\\\":0,\\\"selfBindingRatio\\\":0},\\\"unification\\\":{\\\"unificationType\\\":\\\"1\\\",\\\"unificationMoney\\\":1,\\\"unificationCost\\\":0,\\\"unificationRatio\\\":0},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '{\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"1\\\",\\\"selfBindingMoney\\\":3,\\\"selfBindingCost\\\":0,\\\"selfBindingRatio\\\":0},\\\"unification\\\":{\\\"unificationType\\\":\\\"1\\\",\\\"unificationMoney\\\":2,\\\"unificationCost\\\":0,\\\"unificationRatio\\\":0},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '2023-03-09 16:39:25', '管理员');
INSERT INTO `pt_config_log` VALUES (219, 'OrderMoneySet', '{\"id\":7,\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"1\\\",\\\"selfBindingMoney\\\":3,\\\"selfBindingCost\\\":0,\\\"selfBindingRatio\\\":0},\\\"unification\\\":{\\\"unificationType\\\":\\\"1\\\",\\\"unificationMoney\\\":2,\\\"unificationCost\\\":0,\\\"unificationRatio\\\":0},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '{\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":30,\\\"selfBindingRatio\\\":60},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":22,\\\"unificationRatio\\\":88},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '2023-03-09 16:43:35', '管理员');
INSERT INTO `pt_config_log` VALUES (220, 'OrderMoneySet', '{\"id\":7,\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":30,\\\"selfBindingRatio\\\":60},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":22,\\\"unificationRatio\\\":88},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '{\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":30,\\\"selfBindingRatio\\\":60},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":22,\\\"unificationRatio\\\":88},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '2023-03-09 16:44:23', '管理员');
INSERT INTO `pt_config_log` VALUES (221, 'OrderMoneySet', '{\"id\":7,\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":30,\\\"selfBindingRatio\\\":60},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":22,\\\"unificationRatio\\\":88},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '{\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"1\\\",\\\"selfBindingMoney\\\":1,\\\"selfBindingCost\\\":0,\\\"selfBindingRatio\\\":0},\\\"unification\\\":{\\\"unificationType\\\":\\\"1\\\",\\\"unificationMoney\\\":0.5,\\\"unificationCost\\\":0,\\\"unificationRatio\\\":0},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '2023-03-09 16:57:10', '管理员');
INSERT INTO `pt_config_log` VALUES (222, 'OrderMoneySet', '{\"id\":7,\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"1\\\",\\\"selfBindingMoney\\\":1,\\\"selfBindingCost\\\":0,\\\"selfBindingRatio\\\":0},\\\"unification\\\":{\\\"unificationType\\\":\\\"1\\\",\\\"unificationMoney\\\":0.5,\\\"unificationCost\\\":0,\\\"unificationRatio\\\":0},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '{\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":22,\\\"selfBindingRatio\\\":80},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":30,\\\"unificationRatio\\\":85},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '2023-03-09 17:00:25', '管理员');
INSERT INTO `pt_config_log` VALUES (223, 'OrderMoneySet', '{\"id\":7,\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":22,\\\"selfBindingRatio\\\":80},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":30,\\\"unificationRatio\\\":85},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '{\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":22,\\\"selfBindingRatio\\\":80},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":30,\\\"unificationRatio\\\":85},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '2023-03-09 17:34:09', '管理员');
INSERT INTO `pt_config_log` VALUES (224, 'OrderMoneySet', '{\"id\":7,\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":22,\\\"selfBindingRatio\\\":80},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":30,\\\"unificationRatio\\\":85},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '{\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":22,\\\"selfBindingRatio\\\":80},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":20,\\\"unificationRatio\\\":88},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '2023-03-09 17:39:41', '管理员');
INSERT INTO `pt_config_log` VALUES (225, 'OrderMoneySet', '{\"id\":7,\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":22,\\\"selfBindingRatio\\\":80},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":20,\\\"unificationRatio\\\":88},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '{\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":22,\\\"selfBindingRatio\\\":80},\\\"unification\\\":{\\\"unificationType\\\":\\\"1\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":0,\\\"unificationRatio\\\":0},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '2023-03-09 17:41:25', '管理员');
INSERT INTO `pt_config_log` VALUES (226, 'OrderMoneySet', '{\"id\":7,\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":22,\\\"selfBindingRatio\\\":80},\\\"unification\\\":{\\\"unificationType\\\":\\\"1\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":0,\\\"unificationRatio\\\":0},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '{\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":22,\\\"selfBindingRatio\\\":80},\\\"unification\\\":{\\\"unificationType\\\":\\\"1\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":0,\\\"unificationRatio\\\":0},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '2023-03-09 17:42:03', '管理员');
INSERT INTO `pt_config_log` VALUES (227, 'OrderMoneySet', '{\"id\":7,\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":22,\\\"selfBindingRatio\\\":80},\\\"unification\\\":{\\\"unificationType\\\":\\\"1\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":0,\\\"unificationRatio\\\":0},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '{\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"1\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":0,\\\"selfBindingRatio\\\":0},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":10,\\\"unificationRatio\\\":50},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '2023-03-09 17:49:27', '管理员');
INSERT INTO `pt_config_log` VALUES (228, 'OrderMoneySet', '{\"id\":7,\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"1\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":0,\\\"selfBindingRatio\\\":0},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":10,\\\"unificationRatio\\\":50},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '{\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"1\\\",\\\"selfBindingMoney\\\":2,\\\"selfBindingCost\\\":0,\\\"selfBindingRatio\\\":0},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":10,\\\"unificationRatio\\\":50},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '2023-03-09 18:06:47', '管理员');
INSERT INTO `pt_config_log` VALUES (229, 'OrderMoneySet', '{\"id\":7,\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"1\\\",\\\"selfBindingMoney\\\":2,\\\"selfBindingCost\\\":0,\\\"selfBindingRatio\\\":0},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":10,\\\"unificationRatio\\\":50},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '{\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":29,\\\"selfBindingRatio\\\":88},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":10,\\\"unificationRatio\\\":50},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '2023-03-09 18:07:23', '管理员');
INSERT INTO `pt_config_log` VALUES (230, 'StoreShow', '{\"id\":5,\"name\":\"StoreShow\",\"contens\":\"{\\\"storeName\\\":false,\\\"storePhone\\\":false,\\\"storeAddress\\\":false,\\\"storeMerchant\\\":false,\\\"storeDetailed\\\":true}\"}', '{\"name\":\"StoreShow\",\"contens\":\"{\\\"storeName\\\":true,\\\"storePhone\\\":true,\\\"storeAddress\\\":true,\\\"storeMerchant\\\":true,\\\"storeDetailed\\\":true}\"}', '2023-03-10 09:18:29', '管理员');
INSERT INTO `pt_config_log` VALUES (231, 'StoreSubsidySet', '{\"id\":22,\"name\":\"StoreSubsidySet\",\"contens\":\"{\\\"min\\\":1,\\\"max\\\":10,\\\"state\\\":true}\"}', '{\"name\":\"StoreSubsidySet\",\"contens\":\"{\\\"min\\\":1,\\\"max\\\":10,\\\"state\\\":false}\"}', '2023-03-10 10:00:41', '管理员');
INSERT INTO `pt_config_log` VALUES (232, 'OrderMoneySet', '{\"id\":7,\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"2\\\",\\\"selfBindingMoney\\\":0,\\\"selfBindingCost\\\":29,\\\"selfBindingRatio\\\":88},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":10,\\\"unificationRatio\\\":50},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '{\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"1\\\",\\\"selfBindingMoney\\\":5,\\\"selfBindingCost\\\":0,\\\"selfBindingRatio\\\":0},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":10,\\\"unificationRatio\\\":50},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '2023-03-10 10:13:58', '管理员');
INSERT INTO `pt_config_log` VALUES (233, 'OrderMoneySet', '{\"id\":7,\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"1\\\",\\\"selfBindingMoney\\\":5,\\\"selfBindingCost\\\":0,\\\"selfBindingRatio\\\":0},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":10,\\\"unificationRatio\\\":50},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '{\"name\":\"OrderMoneySet\",\"contens\":\"{\\\"selfBinding\\\":{\\\"selfBindingType\\\":\\\"1\\\",\\\"selfBindingMoney\\\":3,\\\"selfBindingCost\\\":0,\\\"selfBindingRatio\\\":0},\\\"unification\\\":{\\\"unificationType\\\":\\\"2\\\",\\\"unificationMoney\\\":0,\\\"unificationCost\\\":20,\\\"unificationRatio\\\":60},\\\"subsidy\\\":{\\\"subsidyOrder\\\":12,\\\"subsidyUpperLimit\\\":20,\\\"subsidyStore\\\":12,\\\"subsidyHighest\\\":0},\\\"selfBindingMoney\\\":0}\"}', '2023-03-10 10:20:55', '管理员');
INSERT INTO `pt_config_log` VALUES (234, 'AgentSubsidy-14', '[]', '{\"name\":\"AgentSubsidy-14\",\"contens\":\"{\\\"subsidyTime\\\":[\\\"2023-03-10\\\",\\\"2023-04-27\\\"],\\\"money\\\":2,\\\"remarks\\\":\\\"测试\\\",\\\"agentName\\\":\\\"谢谢\\\"}\"}', '2023-03-10 10:38:05', '管理员');
INSERT INTO `pt_config_log` VALUES (235, 'StoreSubsidySet', '{\"id\":22,\"name\":\"StoreSubsidySet\",\"contens\":\"{\\\"min\\\":1,\\\"max\\\":10,\\\"state\\\":false}\"}', '{\"name\":\"StoreSubsidySet\",\"contens\":\"{\\\"min\\\":1,\\\"max\\\":10,\\\"state\\\":true}\"}', '2023-03-13 09:25:48', '管理员');

-- ----------------------------
-- Table structure for pt_dic
-- ----------------------------
DROP TABLE IF EXISTS `pt_dic`;
CREATE TABLE `pt_dic`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '表ID',
  `title` varchar(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `field` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字段',
  `sort_no` smallint(6) NOT NULL DEFAULT 0 COMMENT '排序号',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `scope` tinyint(4) NOT NULL DEFAULT 0 COMMENT '字典级别：0 全局字典 其余为业务系统字典',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态，1启用 2禁用',
  `deleted` datetime NULL DEFAULT NULL COMMENT '软删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pt_dic_field_index`(`field`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of pt_dic
-- ----------------------------
INSERT INTO `pt_dic` VALUES (1, '新华', 'ssex', 0, NULL, 0, 1, '2023-02-23 15:51:15');
INSERT INTO `pt_dic` VALUES (2, '性别', 'sex', 0, NULL, 0, 1, '2023-02-23 15:51:10');
INSERT INTO `pt_dic` VALUES (3, '性别', '字段', 0, NULL, 0, 1, '2023-02-23 15:51:13');
INSERT INTO `pt_dic` VALUES (4, '券类型', 'type', 0, NULL, 0, 1, '2023-02-23 15:56:44');
INSERT INTO `pt_dic` VALUES (5, '排序', 'sort', 0, NULL, 0, 1, '2023-02-23 15:57:31');
INSERT INTO `pt_dic` VALUES (6, '来源', 'source', 0, NULL, 0, 1, NULL);
INSERT INTO `pt_dic` VALUES (7, '状态', 'state', 0, NULL, 0, 1, '2023-02-23 15:57:29');
INSERT INTO `pt_dic` VALUES (8, '分配方式', 'allocation', 0, NULL, 0, 1, '2023-02-23 10:48:52');
INSERT INTO `pt_dic` VALUES (9, '收益排序', 'IncomeRanking', 0, NULL, 0, 1, '2023-02-23 10:48:47');
INSERT INTO `pt_dic` VALUES (10, '交易方式', 'transaction', 0, NULL, 0, 1, NULL);

-- ----------------------------
-- Table structure for pt_dic_entry
-- ----------------------------
DROP TABLE IF EXISTS `pt_dic_entry`;
CREATE TABLE `pt_dic_entry`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '表ID',
  `did` int(11) NOT NULL COMMENT '字典ID，对应sys_dic表ID',
  `title` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '含义',
  `val` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '键值',
  `sort_no` smallint(6) NOT NULL DEFAULT 0 COMMENT '排序号',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态，1启用 2禁用',
  `deleted` datetime NULL DEFAULT NULL COMMENT '软删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pt_dic_entry_did_index`(`did`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典元素表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of pt_dic_entry
-- ----------------------------
INSERT INTO `pt_dic_entry` VALUES (1, 1, '男', '1', 0, 1, NULL);
INSERT INTO `pt_dic_entry` VALUES (2, 1, '女', '2', 0, 1, NULL);
INSERT INTO `pt_dic_entry` VALUES (3, 1, '男', '1', 0, 1, '2023-02-17 16:50:52');
INSERT INTO `pt_dic_entry` VALUES (4, 2, '猫', '3', 0, 1, '2023-02-17 16:53:31');
INSERT INTO `pt_dic_entry` VALUES (5, 2, '其他', '3', 0, 1, '2023-02-20 10:39:43');
INSERT INTO `pt_dic_entry` VALUES (6, 6, '系统', '1', 0, 1, NULL);
INSERT INTO `pt_dic_entry` VALUES (7, 6, '省赚宝', '2', 0, 1, NULL);
INSERT INTO `pt_dic_entry` VALUES (8, 10, '现金', '1', 0, 1, NULL);
INSERT INTO `pt_dic_entry` VALUES (9, 10, '银行', '2', 0, 1, NULL);

-- ----------------------------
-- Table structure for pt_resource
-- ----------------------------
DROP TABLE IF EXISTS `pt_resource`;
CREATE TABLE `pt_resource`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(11) NOT NULL DEFAULT 0 COMMENT '父ID',
  `system_id` tinyint(4) NOT NULL COMMENT '所属系统',
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `type` smallint(6) NOT NULL COMMENT '类型 0路由 1按钮',
  `url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由',
  `permissions` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '权限',
  `icon` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `sort_no` smallint(6) NOT NULL DEFAULT 0 COMMENT '排序号',
  `keepalive` bit(1) NULL DEFAULT b'0' COMMENT '是否缓存，0否 1是',
  `component` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件',
  `hidden` bit(1) NULL DEFAULT b'0' COMMENT '是否隐藏，0否 1是',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态，1启用 2禁用',
  `creator` varchar(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `deleted` datetime NULL DEFAULT NULL COMMENT '软删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pt_resource_system_index`(`system_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统资源表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of pt_resource
-- ----------------------------
INSERT INTO `pt_resource` VALUES (1, 0, 0, '系统设置', 0, '/sys', 'sys', 'tool', 101, b'0', 'RouteView', b'0', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (2, 0, 0, '首页', 0, '/home', 'home', 'desktop', 0, b'0', 'home/home', b'0', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (3, 0, 0, '权限管理', 0, '/role', 'role', 'highlight', 100, b'0', 'RouteView', b'0', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (4, 1, 0, '菜单管理', 0, '/sys/menu', '/admin/menu/list', NULL, 0, b'0', 'sys/menu', b'0', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (5, 1, 0, '字典管理', 0, '/sys/dict', '/admin/dic/list', NULL, 1, b'0', 'sys/dict', b'0', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (6, 1, 0, '字典元素表', 0, '/sys/dictList', '/admin/dic/entry-list', NULL, 2, b'0', 'sys/dictList', b'1', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (7, 3, 0, '用户管理', 0, '/role/user', '/admin/user/list', NULL, 0, b'0', 'role/user', b'0', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (8, 3, 0, '角色管理', 0, '/role/roleList', '/admin/role/list', NULL, 1, b'0', 'role/RoleList', b'0', NULL, 1, NULL, NULL, NULL, NULL, '2023-02-20 13:32:49');
INSERT INTO `pt_resource` VALUES (9, 0, 0, '聚合账号管理', 0, '/business', 'business', 'user-add', 1, b'0', 'RouteView', b'0', NULL, 1, NULL, NULL, NULL, NULL, '2023-02-17 13:48:07');
INSERT INTO `pt_resource` VALUES (10, 9, 0, '聚合账号', 0, '/business/aggregationAccount', 'admin:business:page', NULL, 3, b'0', 'business/aggregationAccount/index', b'1', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (11, 9, 0, '聚合用户管理', 0, '/business', 'district', '', 1, b'0', 'RouteView', b'0', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (12, 9, 0, '批量城市设置', 0, '/aggregationAccount/modules/BatchCitySet', 'BatchCitySet', NULL, 2, b'0', 'business/aggregationAccount/modules/BatchCitySet', b'1', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (13, 9, 0, '聚合账号管理', 0, '/business/citysetList', 'citysetList', ' ', 0, b'0', 'business/citysetList/index', b'0', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (14, 9, 0, '单个城市设置', 0, '/business/citysetList/modules/singleCitySet', 'singleCitySet', NULL, 4, b'0', 'business/citysetList/modules/singleCitySet', b'1', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (15, 0, 0, '订单列表', 0, '/business/oderList/index', 'oderList', 'barcode', 5, b'0', 'business/oderList/index', b'0', NULL, 1, NULL, NULL, NULL, NULL, '2023-02-17 13:47:48');
INSERT INTO `pt_resource` VALUES (16, 9, 0, '新增订单', 0, '/oderList/modules/accountAdd', 'admin:oderList:add', '', 6, b'0', 'business/oderList/modules/AccountAdd', b'1', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (17, 9, 0, '订单详情', 0, '/oderList/modules/orderDetail', 'admin:oderList:detail', '', 7, b'0', 'business/oderList/modules/orderDetail', b'1', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (18, 29, 0, '聚合用户列表', 0, '/business/district/districtManagement', 'admin:district:list', '', 7, b'0', 'business/district/districtManagement', b'0', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (19, 9, 0, '聚合用户详情', 0, '/business/district/accountDetail', 'admin:district:detail', '', 1, b'0', 'business/district/accountDetail', b'1', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (20, 29, 0, '账单明细', 0, '/business/district/billingDetails', 'admin:district:billingdetails', '', 2, b'0', 'business/district/billingDetails', b'0', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (21, 9, 0, '运力城市列表', 0, '/business/capacityList', 'capacityList', '', 0, b'0', 'business/capacityList/uuCapacityList/index', b'0', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (22, 21, 0, 'UU城市列表', 0, '/business/capacityList/uuCapacityList', 'admin:uuCapacityList', '', 0, b'0', 'business/capacityList/uuCapacityList/index', b'0', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (23, 21, 0, '达达城市列表', 0, '/business/capacityList/dadaCapacityList', 'admin:dadaCapacityList', '', 1, b'0', 'business/capacityList/dadaCapacityList/index', b'0', NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (24, 0, 0, '推送记录1', 0, '/business/pushRecord', '', 'file-excel', 4, b'0', 'business/pushRecord/index', b'0', NULL, 1, NULL, NULL, NULL, NULL, '2023-02-17 13:47:56');
INSERT INTO `pt_resource` VALUES (25, 0, 0, '支付订单列表', 0, '/business/payOrderList', '', 'red-envelope', 5, b'0', 'business/payOrderList/index', b'0', NULL, 1, NULL, NULL, NULL, NULL, '2023-02-17 13:47:44');
INSERT INTO `pt_resource` VALUES (26, 2, 0, '测试按钮', 1, '', 'test-edit', '', 1, b'0', '', b'0', NULL, 1, NULL, NULL, NULL, NULL, '2023-02-20 13:32:05');
INSERT INTO `pt_resource` VALUES (27, 0, 0, '开放平台客户端', 0, '/business/openPlatform', '', 'usergroup-add', 6, b'0', 'business/openPlatform/index', b'0', NULL, 1, NULL, NULL, NULL, NULL, '2023-02-17 13:47:35');
INSERT INTO `pt_resource` VALUES (28, 0, 0, '开放平台客户端详情', 0, '/business/openPlatform/accountDetail', '', '', 0, b'0', 'business/openPlatform/accountDetail', b'1', NULL, 1, NULL, NULL, NULL, NULL, '2023-02-17 13:48:02');
INSERT INTO `pt_resource` VALUES (29, 0, 0, '聚合用户管理', 0, '/business/user', '', 'user', 7, b'0', 'RouteView', b'0', NULL, 1, NULL, NULL, NULL, NULL, '2023-02-17 13:47:30');
INSERT INTO `pt_resource` VALUES (30, 1, 0, '虚拟运力', 0, '/virtualCapacity', '', '', 2, b'0', 'sys/virtualCapacity/index', b'0', NULL, 1, NULL, NULL, NULL, NULL, '2023-02-17 13:48:19');
INSERT INTO `pt_resource` VALUES (31, 0, 0, '新增用户', 1, '', '/admin/user/add', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, '2023-02-17 17:21:22');
INSERT INTO `pt_resource` VALUES (32, 7, 0, '新增用户', 1, '', '/admin/user/add', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (33, 7, 0, '修改用户', 1, '', '/admin/user/save', '', 1, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (34, 3, 0, '角色管理', 0, '/role/rolelist', '/admin/role/list', '', 1, b'0', 'role/RoleList', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (35, 7, 0, '删除用户', 1, '', '/admin/user/del', '', 2, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (36, 7, 0, '用户详情', 1, '', '/admin/user/detail', '', 3, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (37, 34, 0, '新增角色', 1, '', '/admin/role/add', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (38, 34, 0, '修改角色', 1, '', '/admin/role/save', '', 1, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (39, 34, 0, '删除角色', 1, '', '/admin/role/del', '', 2, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (40, 34, 0, '角色详情', 1, '', '/admin/role/detail', '', 3, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (41, 4, 0, '新增菜单', 1, '', '/admin/menu/add', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (42, 4, 0, '修改菜单', 1, '', '/admin/menu/save', '', 1, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (43, 4, 0, '删除菜单', 1, '', '/admin/menu/del', '', 2, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (44, 4, 0, '菜单详情', 1, '', '/admin/menu/detail', '', 3, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (45, 5, 0, '新增字典', 1, '', '/admin/dic/add', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (46, 5, 0, '修改字典', 1, '', '/admin/dic/save', '', 1, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (47, 5, 0, '删除字典', 1, '', '/admin/dic/del', '', 2, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (48, 5, 0, '字典详情', 1, '', '/admin/dic/detail', '', 3, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (49, 6, 0, '新增字典元素', 1, '', '/admin/dic/entry-add', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (50, 6, 0, '修改字典元素', 1, '', '/admin/dic/entry-save', '', 1, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (51, 6, 0, '删除字典元素', 1, '', '/admin/dic/entry-del', '', 2, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (52, 6, 0, '字典元素详情', 1, '', '/admin/dic/entry-detail', '', 3, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, '2023-02-20 13:47:01');
INSERT INTO `pt_resource` VALUES (53, 2, 0, '测试按钮', 1, '', 'test-edit', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, '2023-02-20 14:48:21');
INSERT INTO `pt_resource` VALUES (54, 0, 0, '代理商用户管理', 0, '/agentUser', '/admin/agent/list', 'usergroup-add', 1, b'0', 'agentUser/index', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (55, 0, 0, '门店管理', 0, '/store', 'store', 'bank', 2, b'0', 'RouteView', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (56, 0, 0, '地推券管理', 0, '/coupon', '/admin/voucher/list', 'database', 4, b'0', 'RouteView', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (57, 0, 0, '订单管理', 0, '/order', 'order', 'file-text', 5, b'1', 'RouteView', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (58, 0, 0, '财务管理', 0, '/finance', 'finance', 'pay-circle', 6, b'0', 'finance/index', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (59, 0, 0, '代理商用户管理-增减券', 0, '/agentUse/addMinusVouchers', '', '', 0, b'0', 'agentUser/modules/addMinusVouchers', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (60, 0, 0, '代理商用户管理-增减券日志', 0, '/agentUse/addMinusVouchersLog', '', '', 0, b'0', 'agentUser/modules/addMinusVouchersLog', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (61, 0, 0, '代理商用户管理-补贴操作日志', 0, '/agentUser/operationSubsidyLog', '', '', 0, b'0', 'agentUser/modules/operationSubsidyLog', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (62, 0, 0, '代理商用户管理-补贴记录', 0, '/agentUser/subsidyRecord', '', '', 0, b'0', 'agentUser/modules/subsidyRecord', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (63, 0, 0, '代理商用户管理-补贴设置', 0, '/agentUser/subsidySet', '', '', 0, b'0', 'agentUser/modules/subsidySet', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (64, 0, 0, '代理商用户管理-详情', 0, '/agentUser/agentUserDetails', '', '', 0, b'0', 'agentUser/modules/agentUserDetails', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (65, 55, 0, '门店列表', 0, '/store/storeList', '', '', 0, b'0', 'store/storeList', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (66, 55, 0, '门店收益配置', 0, '/store/storeMoneySet', '/admin/config/storeMoneySet', '', 0, b'0', 'store/storeMoneySet', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (67, 55, 0, '门店信息显示配置', 0, '/store/storeMessageShowSet', '/admin/config/storeMessageShowSet', '', 0, b'0', 'store/storeMessageShowSet', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (68, 55, 0, '自动分配门店配置', 0, '/store/storeAutomaticAllocationSet', '', '', 0, b'0', 'store/storeAutomaticAllocationSet', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (69, 55, 0, '解除绑定日志', 0, '/store/storeDeleteLog', '', '', 0, b'0', 'store/modules/storeDeleteLog', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (70, 55, 0, '查看详情', 0, '/store/storeDetails', '', '', 0, b'0', 'store/modules/storeDetails', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (71, 55, 0, '补贴记录', 0, '/store/subsidyRecord', '', '', 0, b'0', 'store/modules/subsidyRecord', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (72, 55, 0, '修改收益配置', 0, '/store/storeMoneyModify', '', '', 0, b'0', 'store/modules/storeMoneyModify', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (73, 57, 0, '订单列表', 0, '/order/list', '/admin/order/list', '', 0, b'0', 'order/list', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (74, 57, 0, '订单收益配置', 0, '/order/orderSet', '/admin/config/orderSet', '', 1, b'0', 'order/orderSet', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (75, 56, 0, '地推券列表', 0, '/ground/list', '/admin/ground/list', '', 0, b'0', 'ground/list', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (76, 0, 0, '财务管理-收款信息', 0, '/finance/collectMoneyMsg', '', '', 0, b'0', 'finance/modules/collectMoneyMsg', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (77, 0, 0, '财务管理-打款记录', 0, '/finance/drawMoneyLog', '', '', 0, b'0', 'finance/modules/drawMoneyLog', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (78, 56, 0, '门店分配日志', 0, '/ground/storeLog', '/admin/voucher/bind-log', '', 1, b'0', 'ground/modules/storeLog', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (79, 56, 0, '赠券记录', 0, '/ground/giveLog', '/admin/voucher/give-list', '', 2, b'0', 'ground/modules/giveLog', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (80, 56, 0, '邀请详情', 0, '/ground/inviteLog', '/admin/voucher/invate-info', '', 3, b'0', 'ground/modules/inviteLog', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (81, 56, 0, '自动分券配置', 0, '/ground/ticketSet', '/admin/ground/ticketSet', '', 1, b'0', 'ground/ticketSet', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (82, 54, 0, '新增代理商', 1, '', '/admin/agent/add', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (83, 54, 0, '修改代理商', 1, '', '/admin/agent/save', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (84, 54, 0, '重置密码', 1, '', '/admin/agent/mod', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (85, 54, 0, '修改禁用启用', 1, '', '/admin/agent/state', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (86, 54, 0, '代理商用户管理列表', 1, '', '/admin/agent/list', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, '2023-02-22 14:31:28');
INSERT INTO `pt_resource` VALUES (87, 54, 0, '增减券', 1, '', '/admin/voucher/deduct/grant', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (88, 56, 0, '邀请记录', 1, '', '/admin/voucher/invate-list', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, '2023-02-23 16:30:12');
INSERT INTO `pt_resource` VALUES (89, 56, 0, '地推券有效期配置', 0, '/ground/validity', '', '', 0, b'0', 'ground/validity', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (90, 54, 0, '补贴设置', 1, '', '/admin/config/subsidySet', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (91, 54, 0, '增减券日志', 1, '', '/admin/voucher/voucher-log', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (92, 65, 0, '修改收益配置', 1, '', '/admin/voucher/bind-update', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (93, 65, 0, '删除门店', 1, '', '/admin/shop/del', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (94, 65, 0, '删除门店日志', 1, '', '/admin/shop/del-list', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (95, 75, 0, '切换代推/自推', 1, '', '/admin/voucher/switch', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (96, 75, 0, '分配门店/批量分配门店', 1, '', '/admin/voucher/allocation', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (97, 75, 0, '分配详情', 1, '', '/admin/voucher/bind-info', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (98, 54, 0, '查看详情', 1, '', '/admin/agent/detail', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (99, 54, 0, '补贴记录', 1, '', '/admin/agent/log', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (100, 65, 0, '补贴记录', 1, '', '/admin/shop/log', '', 0, b'0', '', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (101, 1, 0, '税率配置', 0, '/sys/taxrate', '', '', 0, b'0', 'sys/taxrate', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (102, 0, 0, '门店池列表', 0, '/assignableStore', '', 'shop', 3, b'0', 'assignableStore/index', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (103, 0, 0, '门店池列表-删除门店日志', 0, '/assignableStore/storeDeleteLog', '', '', 0, b'0', 'assignableStore/modules/storeDeleteLog', b'1', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (104, 1, 0, '基础配置', 0, '/sys/foundationSet', '', '', 0, b'0', 'sys/foundationSet', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_resource` VALUES (105, 55, 0, '门店补贴配置', 0, '/store/subsidySet', '', '', 0, b'0', 'store/subsidySet', b'0', '', 1, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for pt_role
-- ----------------------------
DROP TABLE IF EXISTS `pt_role`;
CREATE TABLE `pt_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编码,默认yyyyMMddHHmmss',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `creator` varchar(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `deleted` datetime NULL DEFAULT NULL COMMENT '软删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pt_role_code_index`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统角色表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of pt_role
-- ----------------------------
INSERT INTO `pt_role` VALUES (1, '超级管理员', '', NULL, NULL, '2023-02-14 16:17:47', NULL, NULL, NULL);
INSERT INTO `pt_role` VALUES (2, '财务', '', NULL, NULL, '2023-02-15 09:22:32', NULL, NULL, '2023-02-17 15:20:53');
INSERT INTO `pt_role` VALUES (3, '经理2', '', NULL, NULL, NULL, NULL, NULL, '2023-02-17 14:24:46');
INSERT INTO `pt_role` VALUES (4, '主管', '', '123456', NULL, NULL, NULL, NULL, '2023-02-17 15:20:47');
INSERT INTO `pt_role` VALUES (5, '系统管理员', '', '系统管理员', NULL, NULL, NULL, NULL, '2023-02-20 13:48:13');
INSERT INTO `pt_role` VALUES (6, '系统管理员', '', '系统管理员', NULL, NULL, NULL, NULL, '2023-02-17 14:27:14');
INSERT INTO `pt_role` VALUES (7, '系统管理员', '', '', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for pt_role_res
-- ----------------------------
DROP TABLE IF EXISTS `pt_role_res`;
CREATE TABLE `pt_role_res`  (
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `res_id` int(11) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `res_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统角色资源表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of pt_role_res
-- ----------------------------
INSERT INTO `pt_role_res` VALUES (1, 1);
INSERT INTO `pt_role_res` VALUES (1, 2);
INSERT INTO `pt_role_res` VALUES (1, 3);
INSERT INTO `pt_role_res` VALUES (1, 4);
INSERT INTO `pt_role_res` VALUES (1, 5);
INSERT INTO `pt_role_res` VALUES (1, 6);
INSERT INTO `pt_role_res` VALUES (1, 7);
INSERT INTO `pt_role_res` VALUES (1, 32);
INSERT INTO `pt_role_res` VALUES (1, 33);
INSERT INTO `pt_role_res` VALUES (1, 34);
INSERT INTO `pt_role_res` VALUES (1, 35);
INSERT INTO `pt_role_res` VALUES (1, 36);
INSERT INTO `pt_role_res` VALUES (1, 37);
INSERT INTO `pt_role_res` VALUES (1, 38);
INSERT INTO `pt_role_res` VALUES (1, 39);
INSERT INTO `pt_role_res` VALUES (1, 40);
INSERT INTO `pt_role_res` VALUES (1, 45);
INSERT INTO `pt_role_res` VALUES (1, 46);
INSERT INTO `pt_role_res` VALUES (1, 47);
INSERT INTO `pt_role_res` VALUES (1, 48);
INSERT INTO `pt_role_res` VALUES (1, 49);
INSERT INTO `pt_role_res` VALUES (1, 50);
INSERT INTO `pt_role_res` VALUES (1, 51);
INSERT INTO `pt_role_res` VALUES (1, 54);
INSERT INTO `pt_role_res` VALUES (1, 55);
INSERT INTO `pt_role_res` VALUES (1, 56);
INSERT INTO `pt_role_res` VALUES (1, 57);
INSERT INTO `pt_role_res` VALUES (1, 58);
INSERT INTO `pt_role_res` VALUES (1, 59);
INSERT INTO `pt_role_res` VALUES (1, 60);
INSERT INTO `pt_role_res` VALUES (1, 61);
INSERT INTO `pt_role_res` VALUES (1, 62);
INSERT INTO `pt_role_res` VALUES (1, 63);
INSERT INTO `pt_role_res` VALUES (1, 64);
INSERT INTO `pt_role_res` VALUES (1, 65);
INSERT INTO `pt_role_res` VALUES (1, 66);
INSERT INTO `pt_role_res` VALUES (1, 67);
INSERT INTO `pt_role_res` VALUES (1, 68);
INSERT INTO `pt_role_res` VALUES (1, 69);
INSERT INTO `pt_role_res` VALUES (1, 70);
INSERT INTO `pt_role_res` VALUES (1, 71);
INSERT INTO `pt_role_res` VALUES (1, 72);
INSERT INTO `pt_role_res` VALUES (1, 73);
INSERT INTO `pt_role_res` VALUES (1, 74);
INSERT INTO `pt_role_res` VALUES (1, 75);
INSERT INTO `pt_role_res` VALUES (1, 76);
INSERT INTO `pt_role_res` VALUES (1, 77);
INSERT INTO `pt_role_res` VALUES (1, 78);
INSERT INTO `pt_role_res` VALUES (1, 79);
INSERT INTO `pt_role_res` VALUES (1, 80);
INSERT INTO `pt_role_res` VALUES (1, 81);
INSERT INTO `pt_role_res` VALUES (1, 82);
INSERT INTO `pt_role_res` VALUES (1, 83);
INSERT INTO `pt_role_res` VALUES (1, 84);
INSERT INTO `pt_role_res` VALUES (1, 85);
INSERT INTO `pt_role_res` VALUES (1, 87);
INSERT INTO `pt_role_res` VALUES (1, 89);
INSERT INTO `pt_role_res` VALUES (1, 90);
INSERT INTO `pt_role_res` VALUES (1, 91);
INSERT INTO `pt_role_res` VALUES (1, 98);
INSERT INTO `pt_role_res` VALUES (1, 99);
INSERT INTO `pt_role_res` VALUES (1, 101);
INSERT INTO `pt_role_res` VALUES (1, 102);
INSERT INTO `pt_role_res` VALUES (1, 103);
INSERT INTO `pt_role_res` VALUES (1, 104);
INSERT INTO `pt_role_res` VALUES (7, 2);
INSERT INTO `pt_role_res` VALUES (7, 3);
INSERT INTO `pt_role_res` VALUES (7, 7);
INSERT INTO `pt_role_res` VALUES (7, 32);
INSERT INTO `pt_role_res` VALUES (7, 33);
INSERT INTO `pt_role_res` VALUES (7, 34);
INSERT INTO `pt_role_res` VALUES (7, 37);
INSERT INTO `pt_role_res` VALUES (7, 38);
INSERT INTO `pt_role_res` VALUES (7, 54);

-- ----------------------------
-- Table structure for pt_system
-- ----------------------------
DROP TABLE IF EXISTS `pt_system`;
CREATE TABLE `pt_system`  (
  `id` tinyint(4) NOT NULL COMMENT 'ID',
  `title` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '系统名称',
  `logo` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'logo, 绝对路径地址',
  `url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '系统访问地址',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `deleted` datetime NULL DEFAULT NULL COMMENT '软删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '平台系统表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of pt_system
-- ----------------------------
INSERT INTO `pt_system` VALUES (1, '后台管理系统', '', 'https://demo.shinrun.cn', '', NULL);

-- ----------------------------
-- Table structure for pt_user
-- ----------------------------
DROP TABLE IF EXISTS `pt_user`;
CREATE TABLE `pt_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
  `header_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `gender` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '性别   0：保密   1：男    2：女',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `super_admin` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '超级管理员   0：否   1：是',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态，1启用 2禁用',
  `creator` varchar(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `deleted` datetime NULL DEFAULT NULL COMMENT '软删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pt_user_username_index`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统用户' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of pt_user
-- ----------------------------
INSERT INTO `pt_user` VALUES (1, 'admin', '$2y$10$EPkoHvxCRWGtwwQ75bFgrODr7gJ6DsCHjIkX8WLBV8cwVc/Higxa6', '管理员', NULL, 0, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pt_user` VALUES (2, 'test', '$2y$10$YJ01X/QQ78BnHHkg4NEn9.66J8XbzpEhT4ZkNK08HNyWKwjhQ3e5W', '真实姓名', '6666666', 1, '', '', 0, NULL, 1, NULL, NULL, NULL, '2023-02-20 13:48:54', '2023-02-20 13:48:54');
INSERT INTO `pt_user` VALUES (3, '18081238027', '$2y$10$pa/yPXQwVg0AvBQQjiWIO.TzUW.XpVFdGgkebCu8amhboahlC2WiC', 'gwj', NULL, 0, '', '', 0, '', 1, 'admin', NULL, NULL, NULL, NULL);
INSERT INTO `pt_user` VALUES (4, 'hymh', '$2y$10$AHLeLh8jMOvfG5xfaqkKveYLUBCuFZ3rQMgQJqQ.7K3JB3UPFT56S', 'hymh', NULL, 1, '', '', 0, '', 1, 'admin', NULL, NULL, '2023-03-03 12:07:33', NULL);

-- ----------------------------
-- Table structure for pt_user_role
-- ----------------------------
DROP TABLE IF EXISTS `pt_user_role`;
CREATE TABLE `pt_user_role`  (
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of pt_user_role
-- ----------------------------
INSERT INTO `pt_user_role` VALUES (1, 1);
INSERT INTO `pt_user_role` VALUES (3, 7);
INSERT INTO `pt_user_role` VALUES (4, 1);

SET FOREIGN_KEY_CHECKS = 1;
