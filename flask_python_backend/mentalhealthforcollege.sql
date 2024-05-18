/*
 Navicat Premium Data Transfer

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 80035
 Source Host           : localhost:3306
 Source Schema         : mentalhealthforcollege

 Target Server Type    : MySQL
 Target Server Version : 80035
 File Encoding         : 65001

 Date: 17/05/2024 17:08:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for administrator
-- ----------------------------
DROP TABLE IF EXISTS `administrator`;
CREATE TABLE `administrator`  (
  `a_id` int NOT NULL COMMENT '管理员账号',
  `a_password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '管理员密码',
  `a_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `a_sex` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `a_age` int NULL DEFAULT NULL COMMENT '年龄',
  `a_route` set('CollegeMentalState','Counseling','MentalScaleTest','Phq9','Csmhss','Sas','Sds','RecordsCounselor','Prebook','MentalStateCollege','Acl','User') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'CollegeMentalState,Counseling,MentalScaleTest,Phq9,Csmhss,Sas,Sds,RecordsCounselor,Prebook,MentalStateCollege,Acl,User' COMMENT '路由',
  PRIMARY KEY (`a_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of administrator
-- ----------------------------
INSERT INTO `administrator` VALUES (1100, '123456', 'Tom', '男', 30, 'CollegeMentalState,Counseling,MentalScaleTest,Phq9,Csmhss,Sas,Sds,RecordsCounselor,Prebook,MentalStateCollege,Acl,User');
INSERT INTO `administrator` VALUES (1101, '123456', 'Mary', '女', 30, 'CollegeMentalState,Counseling,MentalScaleTest,Phq9,Csmhss,Sas,Sds,RecordsCounselor,Prebook,MentalStateCollege,Acl,User');
INSERT INTO `administrator` VALUES (1102, '1234567', '大大怪将军', '男', 27, 'CollegeMentalState,Counseling,MentalScaleTest,Phq9,Csmhss,Sas,Sds,RecordsCounselor,Prebook,MentalStateCollege,Acl,User');
INSERT INTO `administrator` VALUES (1141, '123456', NULL, NULL, NULL, 'CollegeMentalState,Counseling,MentalScaleTest,Phq9,Csmhss,Sas,Sds,RecordsCounselor,Prebook,MentalStateCollege,Acl,User');

-- ----------------------------
-- Table structure for college
-- ----------------------------
DROP TABLE IF EXISTS `college`;
CREATE TABLE `college`  (
  `s_id` int NOT NULL COMMENT '学生登录账号，主键',
  `s_password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生登录密码',
  `s_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学生姓名',
  `s_sex` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学生性别',
  `s_age` int NULL DEFAULT NULL COMMENT '学生年龄',
  `s_p_id` int NULL DEFAULT NULL COMMENT '学生的心理辅导师的id号',
  `s_route` set('CollegeMentalState','MentalStateCollege','Counseling','RecordsCollege','MentalScaleTest','Phq9','Csmhss','Sas','Sds','Prebook') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'CollegeMentalState,MentalStateCollege,Counseling,RecordsCollege,MentalScaleTest,Phq9,Csmhss,Sas,Sds,Prebook' COMMENT '路由',
  PRIMARY KEY (`s_id`) USING BTREE,
  INDEX `s_route`(`s_route` ASC) USING BTREE,
  INDEX `s_id_p_id`(`s_p_id` ASC) USING BTREE,
  CONSTRAINT `s_id_p_id` FOREIGN KEY (`s_p_id`) REFERENCES `counselor` (`p_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of college
-- ----------------------------
INSERT INTO `college` VALUES (3100, '123456', '张零', '男', 20, 2100, 'CollegeMentalState,MentalStateCollege,Counseling,RecordsCollege,MentalScaleTest,Phq9,Csmhss,Sas,Sds,Prebook');
INSERT INTO `college` VALUES (3101, '1234567', '张一', '男', 20, 2104, 'CollegeMentalState,MentalStateCollege,Counseling,RecordsCollege,MentalScaleTest,Phq9,Csmhss,Sas,Sds,Prebook');
INSERT INTO `college` VALUES (3102, '123456', '张二', '男', 20, 2101, 'CollegeMentalState,MentalStateCollege,Counseling,RecordsCollege,MentalScaleTest,Phq9,Csmhss,Sas,Sds,Prebook');
INSERT INTO `college` VALUES (3103, '123456', '张三', '男', 18, 2101, 'CollegeMentalState,MentalStateCollege,Counseling,RecordsCollege,MentalScaleTest,Phq9,Csmhss,Sas,Sds,Prebook');
INSERT INTO `college` VALUES (3105, '123456', '张五', '女', 23, 2100, 'CollegeMentalState,MentalStateCollege,Counseling,RecordsCollege,MentalScaleTest,Phq9,Csmhss,Sas,Sds,Prebook');
INSERT INTO `college` VALUES (3106, '123456', '张六', '女', 22, 2100, 'CollegeMentalState,MentalStateCollege,Counseling,RecordsCollege,MentalScaleTest,Phq9,Csmhss,Sas,Sds,Prebook');
INSERT INTO `college` VALUES (3107, '123456', '张七', '女', 20, 2101, 'CollegeMentalState,MentalStateCollege,Counseling,RecordsCollege,MentalScaleTest,Phq9,Csmhss,Sas,Sds,Prebook');
INSERT INTO `college` VALUES (3108, '123456', '张八', '女', 22, 2102, 'CollegeMentalState,MentalStateCollege,Counseling,RecordsCollege,MentalScaleTest,Phq9,Csmhss,Sas,Sds,Prebook');
INSERT INTO `college` VALUES (3109, '123456', '张九', '男', 20, 2102, 'CollegeMentalState,MentalStateCollege,Counseling,RecordsCollege,MentalScaleTest,Phq9,Csmhss,Sas,Sds,Prebook');
INSERT INTO `college` VALUES (3121, '1234567', 'test', '男', 20, 2103, 'CollegeMentalState,MentalStateCollege,Counseling,RecordsCollege,MentalScaleTest,Phq9,Csmhss,Sas,Sds,Prebook');

-- ----------------------------
-- Table structure for counseling
-- ----------------------------
DROP TABLE IF EXISTS `counseling`;
CREATE TABLE `counseling`  (
  `c_count` int NOT NULL COMMENT '次数',
  `c_s_id` int NOT NULL COMMENT '学生id',
  `c_p_id` int NOT NULL COMMENT '心理辅导师id',
  `c_time` datetime NOT NULL COMMENT '辅导时间',
  `c_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '辅导内容',
  `c_situation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '辅导情况',
  `c_advice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '辅导建议',
  PRIMARY KEY (`c_s_id`, `c_p_id`, `c_time`) USING BTREE,
  INDEX `c_p_id`(`c_p_id` ASC) USING BTREE,
  CONSTRAINT `counseling_ibfk_1` FOREIGN KEY (`c_s_id`) REFERENCES `college` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `counseling_ibfk_2` FOREIGN KEY (`c_p_id`) REFERENCES `counselor` (`p_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of counseling
-- ----------------------------
INSERT INTO `counseling` VALUES (1, 3100, 2100, '2023-12-06 16:00:00', '抑郁症方面辅导', '学生无抑郁情况', '学生心理健康，无建议');
INSERT INTO `counseling` VALUES (22, 3101, 2100, '2024-05-15 15:00:00', NULL, NULL, NULL);
INSERT INTO `counseling` VALUES (25, 3101, 2101, '2024-05-16 00:00:00', NULL, NULL, NULL);
INSERT INTO `counseling` VALUES (15, 3101, 2102, '2023-12-15 10:00:00', '抑郁症方面辅导', '学生情况有所好转', '试着“走出去”，扩大社交圈子，参加社交活动，寻找有趣的灵魂，人际交流总能带来意想不到的收获。');
INSERT INTO `counseling` VALUES (18, 3101, 2102, '2023-12-29 10:00:00', '抑郁症方面辅导', '学生抑郁倾向减少', '抑郁症是发作性疾病，间歇期可以完全恢复正常。如果你感觉自己好起来了，能做事儿了，相信自己，你就是好了，不要怀疑，也不要刻意去找寻消失的抑郁症状。');
INSERT INTO `counseling` VALUES (6, 3102, 2101, '2023-10-15 10:30:00', '自杀的方式与痛苦', '学生有明显的自杀倾向', '自杀其实是很痛苦的事情，不如想想开心的事情');
INSERT INTO `counseling` VALUES (11, 3102, 2101, '2023-12-10 10:30:00', '如何正确的看待压力的好与坏', '该生从严重心理问题转变为一般心理问题，自杀倾向有所减弱，但仍存在', '第一，还是要按时吃饭吃药。\n第二，多陪陪家人或者朋友，出去走走，找人聊天。\n第三，有压力就释放出来。');
INSERT INTO `counseling` VALUES (14, 3102, 2101, '2024-05-12 13:53:25', '222', '222', '222');
INSERT INTO `counseling` VALUES (24, 3102, 2101, '2024-05-15 16:38:00', '666', '666', '666');
INSERT INTO `counseling` VALUES (7, 3103, 2101, '2023-12-08 08:30:00', '常见的心理疾病问题', '该生心理健康，无心理问题', '建议规律作息');
INSERT INTO `counseling` VALUES (5, 3105, 2100, '2023-12-11 11:30:00', '如何正确对待就业压力', '该生有严重的就业焦虑症状', '学习深呼吸和冥想技巧，这些技巧可以帮助你放松身体和缓解紧张感。');
INSERT INTO `counseling` VALUES (20, 3105, 2100, '2023-12-29 10:30:00', '焦虑方面辅导', '学生焦虑情况减轻', '处理你的热点想法： “热点想法”是指自动进入大脑的负性想法，例如“我太笨了”“我不值得被爱”等。不要一直向着负面的事情');
INSERT INTO `counseling` VALUES (3, 3106, 2100, '2023-12-13 11:00:00', '常规心理健康辅导', '学生心理正常', '学生心理健康，无建议');
INSERT INTO `counseling` VALUES (9, 3107, 2101, '2023-12-20 10:30:00', '如何预防心理疾病', '该生心理健康', '无建议');
INSERT INTO `counseling` VALUES (12, 3107, 2101, '2024-05-03 11:00:00', '111', '111', '1111');
INSERT INTO `counseling` VALUES (16, 3108, 2102, '2023-12-20 10:30:00', '如何预防心理疾病', '该生心理健康', '无建议');
INSERT INTO `counseling` VALUES (17, 3109, 2102, '2023-12-20 20:30:00', '抑郁症方面辅导', '学生有轻度抑郁症状和轻度焦虑症状', '1.抑郁症是发作性疾病，间歇期可以完全恢复正常。如果你感觉自己好起来了，能做事儿了，相信自己，你就是好了，不要怀疑，也不要刻意去找寻消失的抑郁症状。\n2.学习深呼吸和冥想技巧，这些技巧可以帮助你放松身体和缓解焦虑感。');

-- ----------------------------
-- Table structure for counselor
-- ----------------------------
DROP TABLE IF EXISTS `counselor`;
CREATE TABLE `counselor`  (
  `p_id` int NOT NULL COMMENT '登录账号',
  `p_password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录密码',
  `p_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `p_sex` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `p_age` int NULL DEFAULT NULL COMMENT '年龄',
  `p_routes` set('CollegeMentalState','MentalStateCounselor','Counseling','RecordsCounselor','Prebook') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'CollegeMentalState,MentalStateCounselor,Counseling,RecordsCounselor,Prebook',
  PRIMARY KEY (`p_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of counselor
-- ----------------------------
INSERT INTO `counselor` VALUES (2100, '1234567', '李一', '女', 31, 'CollegeMentalState,MentalStateCounselor,Counseling,RecordsCounselor,Prebook');
INSERT INTO `counselor` VALUES (2101, '1234567', '李二', '女', 30, 'CollegeMentalState,MentalStateCounselor,Counseling,RecordsCounselor,Prebook');
INSERT INTO `counselor` VALUES (2102, '1234567', '李三', '男', 40, 'CollegeMentalState,MentalStateCounselor,Counseling,RecordsCounselor,Prebook');
INSERT INTO `counselor` VALUES (2103, '1234567', '李四', '女', 30, 'CollegeMentalState,MentalStateCounselor,Counseling,RecordsCounselor,Prebook');
INSERT INTO `counselor` VALUES (2104, '1234567', 'test', '女', 40, 'CollegeMentalState,MentalStateCounselor,Counseling,RecordsCounselor,Prebook');

-- ----------------------------
-- Table structure for prebook
-- ----------------------------
DROP TABLE IF EXISTS `prebook`;
CREATE TABLE `prebook`  (
  `count` int NOT NULL COMMENT '次数',
  `s_id` int NOT NULL COMMENT '大学生id',
  `p_id` int NOT NULL COMMENT '心理辅导员id',
  `time` datetime NOT NULL COMMENT '预约时间',
  `state` enum('未开始','已结束') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '未开始' COMMENT '是否过了预约时间',
  PRIMARY KEY (`p_id`, `s_id`, `time`) USING BTREE,
  INDEX `c_id`(`s_id` ASC) USING BTREE,
  INDEX `time`(`time` ASC) USING BTREE,
  CONSTRAINT `prebook_ibfk_1` FOREIGN KEY (`s_id`) REFERENCES `college` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `prebook_ibfk_2` FOREIGN KEY (`p_id`) REFERENCES `counselor` (`p_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of prebook
-- ----------------------------
INSERT INTO `prebook` VALUES (11, 3101, 2100, '2024-05-18 09:00:00', '未开始');
INSERT INTO `prebook` VALUES (2, 3101, 2100, '2024-05-21 09:00:00', '未开始');
INSERT INTO `prebook` VALUES (8, 3101, 2101, '2024-05-16 00:00:00', '已结束');
INSERT INTO `prebook` VALUES (10, 3102, 2101, '2024-05-15 16:38:00', '已结束');
INSERT INTO `prebook` VALUES (12, 3101, 2102, '2024-05-24 00:00:00', '未开始');
INSERT INTO `prebook` VALUES (14, 3101, 2104, '2024-05-23 00:00:00', '未开始');
INSERT INTO `prebook` VALUES (15, 3109, 2104, '2024-05-24 13:00:00', '未开始');

-- ----------------------------
-- Table structure for routes
-- ----------------------------
DROP TABLE IF EXISTS `routes`;
CREATE TABLE `routes`  (
  `id` int NOT NULL COMMENT '路由id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由名称',
  `role` set('college','counselor','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '角色拥有的路由',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of routes
-- ----------------------------
INSERT INTO `routes` VALUES (1, 'CollegeMentalState', 'college,counselor,admin');
INSERT INTO `routes` VALUES (2, 'MentalStateCollege', 'college');
INSERT INTO `routes` VALUES (3, 'MentalStateCounselor', 'counselor');
INSERT INTO `routes` VALUES (4, 'Counseling', 'college,counselor,admin');
INSERT INTO `routes` VALUES (5, 'RecordsCollege', 'college');
INSERT INTO `routes` VALUES (6, 'RecordsCounselor', 'counselor');
INSERT INTO `routes` VALUES (7, 'MentalScaleTest', 'college');
INSERT INTO `routes` VALUES (8, 'Phq9', 'college');
INSERT INTO `routes` VALUES (9, 'Csmhss', 'college');
INSERT INTO `routes` VALUES (10, 'Sas', 'college');
INSERT INTO `routes` VALUES (11, 'Sds', 'college');
INSERT INTO `routes` VALUES (12, 'Prebook', 'college,counselor');

-- ----------------------------
-- Table structure for s1_phq9
-- ----------------------------
DROP TABLE IF EXISTS `s1_phq9`;
CREATE TABLE `s1_phq9`  (
  `type` int NOT NULL COMMENT '量表类型，9项患者健康问卷，0-27分',
  `num` int NOT NULL COMMENT '量表序号',
  `question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '量表题目',
  `choiceA` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '量表选项',
  `choiceB` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '量表选项',
  `choiceC` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '量表选项',
  `choiceD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '量表选项',
  PRIMARY KEY (`type`, `num`) USING BTREE,
  INDEX `type`(`type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of s1_phq9
-- ----------------------------
INSERT INTO `s1_phq9` VALUES (1, 1, '做事时提不起劲或没有兴趣', 'A.完全不会', 'B.好几天', 'C.一半以上的天数', 'D.几乎每天');
INSERT INTO `s1_phq9` VALUES (1, 2, '感到心情低落，沮丧或绝望', 'A.完全不会', 'B.好几天', 'C.一半以上的天数', 'D.几乎每天');
INSERT INTO `s1_phq9` VALUES (1, 3, '入睡困难，睡不安稳或睡眠过多', 'A.完全不会', 'B.好几天', 'C.一半以上的天数', 'D.几乎每天');
INSERT INTO `s1_phq9` VALUES (1, 4, '感觉疲倦或没有活力', 'A.完全不会', 'B.好几天', 'C.一半以上的天数', 'D.几乎每天');
INSERT INTO `s1_phq9` VALUES (1, 5, '食欲不振或吃太多', 'A.完全不会', 'B.好几天', 'C.一半以上的天数', 'D.几乎每天');
INSERT INTO `s1_phq9` VALUES (1, 6, '觉得自己很糟或觉得自己很失败，或让自己或家人失望', 'A.完全不会', 'B.好几天', 'C.一半以上的天数', 'D.几乎每天');
INSERT INTO `s1_phq9` VALUES (1, 7, '对事物专注有困难，例如阅读报纸或看电视时', 'A.完全不会', 'B.好几天', 'C.一半以上的天数', 'D.几乎每天');
INSERT INTO `s1_phq9` VALUES (1, 8, '动作或说话速度缓慢到别人已经察觉？或正好相反，烦躁或坐立不安、动来动去的情况更胜于平常', 'A.完全不会', 'B.好几天', 'C.一半以上的天数', 'D.几乎每天');
INSERT INTO `s1_phq9` VALUES (1, 9, '有不如死掉或用某种方式伤害自己的念头', 'A.完全不会', 'B.好几天', 'C.一半以上的天数', 'D.几乎每天');

-- ----------------------------
-- Table structure for s2_csmhss
-- ----------------------------
DROP TABLE IF EXISTS `s2_csmhss`;
CREATE TABLE `s2_csmhss`  (
  `type` int NOT NULL COMMENT '中国大学生心理健康筛查量表，96-384分',
  `num` int NOT NULL,
  `question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `choiceA` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `choiceB` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `choiceC` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `choiceD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`type`, `num`) USING BTREE,
  INDEX `type`(`type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of s2_csmhss
-- ----------------------------
INSERT INTO `s2_csmhss` VALUES (2, 1, '不适应大学的生活方式', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 2, '担心找不到好工作', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 3, '感觉学习有困难', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 4, '感觉为恋爱所累', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 5, '不习惯大学班集体的氛围', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 6, '挑剔学校的饮食或住宿条件', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 7, '担心在学习上落后于其他同学', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 8, '感觉不受同学欢迎', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 9, '和班里同学相处不愉快', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 10, '对自己的求职能力没有信心', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 11, '跟周围人有矛盾', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 12, '在恋爱方面受到家人的阻碍', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 13, '总担心自己找不到合适的男/女朋友', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 14, '付出很大努力却仍跟不上学习进度', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 15, '很多时候感觉不被周围人理解', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 16, '担心考试', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 17, '为不知该做哪些就业准备而迷茫', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 18, '害怕面对就业问题', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 19, '谈恋爱对学习、生活造成负面影响', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 20, '不喜欢现在的学校', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 21, '与别人相处时常感到委屈', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 22, '过分在意别人的评价', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 23, '控制不了自己的进食量', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 24, '经常感到别人要欺骗、利用自己', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 25, '经常无法控制自己激动的情绪', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 26, '顽固地遵守某些规则或习惯，害怕改变', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 27, '故意阻止伤口愈合', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 28, '早上醒来情绪就很低落', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 29, '害怕与人交往', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 30, '经常莫名其妙对别人发火', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 31, '常常自责内疚', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 32, '经常想打人、骂人或毁坏东西', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 33, '身体发麻或刺痛', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 34, '时刻都离不开网络', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 35, '感觉自己在各方面都很失败', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 36, '无法忍受不能上网的生活', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 37, '反应迟钝，注意力不集中', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 38, '有催吐或绝食的行为', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 39, '总是责怪别人造成麻烦', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 40, '感觉自己毫无价值', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 41, '忍不住攻击那些令我不满的人', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 42, '总觉得别人比自己好', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 43, '上网过度影响到正常学习生活', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 44, '没有人安排就不知道该做什么', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 45, '总担心会有不好的事情发生而内心不安', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 46, '总感觉有人在针对我', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 47, '感觉大多数人不可信任', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 48, '总觉得自己不如别人', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 49, '故意抓、戳、咬、撕皮肤至流血', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 50, '常常刚做完一件事就后悔了', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 51, '故意虐待自己', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 52, '经常无缘无故地对别人发火', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 53, '时常因小事而坐立难安', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 54, '凡事需要有人替自己做决定', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 55, '容易被别人的言行伤害', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 56, '睡眠过浅、易醒', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 57, '如果不反复想和做某些事情，就无法继续其他的事', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 58, '做任何事都希望能够获得别人的帮助', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 59, '常常没考虑清楚就做决定', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 60, '回避与异性交往', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 61, '感觉自己再努力也无法成功', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 62, '故意烧、烫伤自己', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 63, '为脑海中总是抹不去的想法或字句所困扰', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 64, '觉得生活无意义，对任何事都不感兴趣', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 65, '言行常常不考虑后果', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 66, '食欲和进食行为异常，如：吞咽困难、恶心、呕吐等', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 67, '入睡困难或早醒', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 68, '胸闷、呼吸困难', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 69, '与人交谈时过分紧张', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 70, '恶心或胃痛', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 71, '头痛或头晕', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 72, '一旦开始上网就很难停下来', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 73, '没理由地害怕、心神不宁', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 74, '感觉别人都看不起自己', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 75, '在网络上花费了过多的时间', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 76, '别人的言行很容易让我感到受伤', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 77, '经常控制不住自己的手或身体发抖、僵直', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 78, '如果不重复做某件事情，如检查/核对/洗涤或问询，就会觉得很焦虑', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 79, '过度嗜睡', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 80, '避免与别人眼神接触', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 81, '经常和人产生争执', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 82, '对别人都不在意的事情很在意', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 83, '当和别人观点不一致时会感到焦虑', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 84, '做任何事都离不开别人的帮助', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 85, '不敢正视别人的目光', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 86, '过度节食', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 87, '很多事情都无法自己独立处理', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 88, '睡醒后依然感到疲乏', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 89, '能听到旁人听不到的言语声（不是指听力好）', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 90, '总感觉有人要害我', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 91, '考虑过自杀的方式或时机', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 92, '想结束生命', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 93, '曾经有过自杀行为', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 94, '曾经羡慕自杀成功的人', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 95, '总感觉有人在监视我', '1', '2', '3', '4');
INSERT INTO `s2_csmhss` VALUES (2, 96, '感觉别人能操控我的思想（不是指自身言行受他人言行影响）', '1', '2', '3', '4');

-- ----------------------------
-- Table structure for s3_sds
-- ----------------------------
DROP TABLE IF EXISTS `s3_sds`;
CREATE TABLE `s3_sds`  (
  `type` int NOT NULL COMMENT 'SDS抑郁自评量表，，20-80分',
  `num` int NOT NULL,
  `question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `choiceA` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `choiceB` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `choiceC` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `choiceD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`type`, `num`) USING BTREE,
  INDEX `type`(`type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of s3_sds
-- ----------------------------
INSERT INTO `s3_sds` VALUES (3, 1, '我感到情绪沮丧，郁闷', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 2, '我感到早晨心情最好', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 3, '我一阵阵哭出来或觉得想哭', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 4, '我晚上睡眠不好', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 5, '我吃的跟平常一样多', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 6, '我与异性密切接触时和以往一样感到愉快', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 7, '我发觉我的体重在下降', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 8, '我有便秘的苦恼', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 9, '我心跳比平时快', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 10, '我无缘无故感到疲乏', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 11, '我的头脑跟平常一样清楚', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 12, '我觉得经常做的事并没有困难', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 13, '我坐卧不安，难以保持平静', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 14, '我对将来抱有希望', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 15, '我比平常容易激动', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 16, '我觉得作出决定是容易的', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 17, '我觉得自己是个有用的人，有人需要我', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 18, '我的生活过得很有意思', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 19, '我认为如果我死了别人会生活得好些', '很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s3_sds` VALUES (3, 20, '平常感兴趣的事我仍然照样感兴趣', '很少有', '有时有', '大部分时间有', '绝大部分时间有');

-- ----------------------------
-- Table structure for s4_sas
-- ----------------------------
DROP TABLE IF EXISTS `s4_sas`;
CREATE TABLE `s4_sas`  (
  `type` int NOT NULL COMMENT 'SAS焦虑自评量表，20-80分',
  `num` int NOT NULL,
  `question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `choiceA` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `choiceB` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `choiceC` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `choiceD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`type`, `num`) USING BTREE,
  INDEX `type`(`type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of s4_sas
-- ----------------------------
INSERT INTO `s4_sas` VALUES (4, 1, '我觉得比平常容易紧张或着急', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 2, '我无缘无故地感到害怕', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 3, '我容易心里烦乱或觉得惊恐', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 4, '我觉得我可能将要发疯', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 5, '我觉得一切都很好，也不会发生什么不幸', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 6, '我手脚发抖打颤', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 7, '我因为头痛、颈痛和背痛而苦恼', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 8, '我感觉容易衰弱和疲乏', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 9, '我得心平气和，并且容易安静坐着', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 10, '我觉得心跳得很快', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 11, '我因为一阵阵头晕而苦恼', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 12, '我有晕倒发作，或觉得要晕倒似的', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 13, '我吸气呼气都感到很容易', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 14, '我的手脚麻木和刺痛', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 15, '我因为胃痛和消化不良而苦恼', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 16, '我常常要小便', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 17, '我的手脚常常是干燥温暖的', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 18, '我脸红发热', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 19, '我容易入睡并且一夜睡得很好', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');
INSERT INTO `s4_sas` VALUES (4, 20, '我做恶梦', '没有或很少有', '有时有', '大部分时间有', '绝大部分时间有');

-- ----------------------------
-- Table structure for testoutcome
-- ----------------------------
DROP TABLE IF EXISTS `testoutcome`;
CREATE TABLE `testoutcome`  (
  `t_count` int NOT NULL COMMENT '测试次数',
  `t_s_id` int NOT NULL COMMENT '学生账号',
  `t_type` enum('pqh9','csmhss','sas','sds') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '测试类型',
  `t_time` datetime NOT NULL COMMENT '测试时间',
  `t_score` int NULL DEFAULT NULL COMMENT '测试分数',
  `t_outcome` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '健康情况',
  PRIMARY KEY (`t_s_id`, `t_type`, `t_time`) USING BTREE,
  INDEX `t_type`(`t_type` ASC) USING BTREE,
  CONSTRAINT `testoutcome_ibfk_1` FOREIGN KEY (`t_s_id`) REFERENCES `college` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of testoutcome
-- ----------------------------
INSERT INTO `testoutcome` VALUES (1, 3100, 'pqh9', '2023-12-05 18:59:23', 1, '无抑郁');
INSERT INTO `testoutcome` VALUES (3, 3100, 'pqh9', '2023-12-11 22:04:06', 3, '无抑郁');
INSERT INTO `testoutcome` VALUES (4, 3100, 'pqh9', '2024-05-03 00:13:43', 0, '无抑郁');
INSERT INTO `testoutcome` VALUES (5, 3100, 'csmhss', '2023-11-29 22:10:58', 121, '无心理问题');
INSERT INTO `testoutcome` VALUES (6, 3100, 'csmhss', '2023-12-15 19:21:52', 98, '健康');
INSERT INTO `testoutcome` VALUES (7, 3101, 'pqh9', '2023-12-13 19:22:27', 26, '严重抑郁');
INSERT INTO `testoutcome` VALUES (8, 3101, 'pqh9', '2023-12-15 11:02:50', 9, '轻度抑郁');
INSERT INTO `testoutcome` VALUES (9, 3101, 'pqh9', '2023-12-29 19:22:58', 13, '中度抑郁');
INSERT INTO `testoutcome` VALUES (10, 3101, 'pqh9', '2024-01-15 10:27:57', 1, '无抑郁');
INSERT INTO `testoutcome` VALUES (11, 3101, 'pqh9', '2024-01-15 11:01:41', 0, '无抑郁');
INSERT INTO `testoutcome` VALUES (12, 3101, 'pqh9', '2024-05-02 15:01:17', 0, '无抑郁');
INSERT INTO `testoutcome` VALUES (13, 3101, 'pqh9', '2024-05-02 15:20:49', 0, '无抑郁');
INSERT INTO `testoutcome` VALUES (14, 3101, 'pqh9', '2024-05-12 20:38:22', 6, '轻度抑郁');
INSERT INTO `testoutcome` VALUES (51, 3101, 'pqh9', '2024-05-15 13:34:42', 0, '无抑郁');
INSERT INTO `testoutcome` VALUES (15, 3102, 'pqh9', '2023-12-29 19:36:18', 24, '重度抑郁');
INSERT INTO `testoutcome` VALUES (16, 3102, 'pqh9', '2024-05-02 15:23:24', 15, '中重度抑郁');
INSERT INTO `testoutcome` VALUES (17, 3102, 'csmhss', '2023-12-30 19:39:43', 272, '严重心理问题');
INSERT INTO `testoutcome` VALUES (18, 3102, 'csmhss', '2024-05-02 15:33:42', 30, '无心理问题');
INSERT INTO `testoutcome` VALUES (19, 3102, 'sas', '2024-05-02 15:30:36', 35, '无抑郁');
INSERT INTO `testoutcome` VALUES (20, 3102, 'sds', '2024-05-02 15:31:22', 35, '无焦虑');
INSERT INTO `testoutcome` VALUES (21, 3103, 'pqh9', '2023-12-26 19:34:09', 5, '轻度抑郁');
INSERT INTO `testoutcome` VALUES (22, 3103, 'pqh9', '2024-05-02 15:40:21', 1, '无抑郁');
INSERT INTO `testoutcome` VALUES (23, 3103, 'pqh9', '2024-05-03 00:01:39', 0, '无抑郁');
INSERT INTO `testoutcome` VALUES (24, 3103, 'pqh9', '2024-05-03 00:05:24', 6, '轻度抑郁');
INSERT INTO `testoutcome` VALUES (25, 3103, 'csmhss', '2024-05-02 23:58:18', 0, '无抑郁');
INSERT INTO `testoutcome` VALUES (26, 3103, 'sas', '2024-05-02 15:41:41', 59, '轻度抑郁');
INSERT INTO `testoutcome` VALUES (27, 3103, 'sds', '2024-01-03 19:34:51', 51, '轻度焦虑');
INSERT INTO `testoutcome` VALUES (30, 3105, 'pqh9', '2023-12-31 14:52:07', 0, '无抑郁');
INSERT INTO `testoutcome` VALUES (31, 3105, 'sds', '2023-12-31 14:53:10', 36, '无焦虑');
INSERT INTO `testoutcome` VALUES (32, 3106, 'pqh9', '2024-01-02 20:09:37', 0, '无抑郁');
INSERT INTO `testoutcome` VALUES (33, 3106, 'sds', '2024-01-02 20:43:46', 34, '无焦虑');
INSERT INTO `testoutcome` VALUES (34, 3107, 'pqh9', '2024-01-03 00:47:24', 0, '无抑郁');
INSERT INTO `testoutcome` VALUES (35, 3107, 'sas', '2024-01-03 00:48:33', 31, '无抑郁');
INSERT INTO `testoutcome` VALUES (36, 3108, 'pqh9', '2024-01-03 19:31:43', 4, '无抑郁');
INSERT INTO `testoutcome` VALUES (37, 3108, 'csmhss', '2024-01-03 19:31:17', 138, '无心理问题');
INSERT INTO `testoutcome` VALUES (38, 3108, 'sds', '2024-01-03 19:32:18', 41, '无焦虑');
INSERT INTO `testoutcome` VALUES (39, 3109, 'pqh9', '2023-12-31 14:40:43', 8, '轻度抑郁');
INSERT INTO `testoutcome` VALUES (40, 3109, 'sds', '2024-01-03 00:49:39', 59, '轻度焦虑');

SET FOREIGN_KEY_CHECKS = 1;
