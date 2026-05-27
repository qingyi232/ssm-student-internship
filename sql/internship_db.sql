-- ====================================================
-- 学生实习管理系统 - 完整数据库脚本
-- 每次执行自动删除旧库并重建，可反复导入
-- ====================================================

-- 关闭外键检查，确保可以顺利删除和重建
SET FOREIGN_KEY_CHECKS = 0;

-- 删除旧数据库并重建
DROP DATABASE IF EXISTS internship_db;
CREATE DATABASE internship_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE internship_db;

SET FOREIGN_KEY_CHECKS = 1;

-- ====================================================
-- 一、表结构
-- ====================================================

-- 1. 系统用户表
CREATE TABLE sys_user (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(64) NOT NULL COMMENT '密码(MD5加密)',
    real_name VARCHAR(50) NOT NULL COMMENT '真实姓名',
    role INT NOT NULL DEFAULT 3 COMMENT '角色：1-管理员 2-教师 3-学生',
    phone VARCHAR(20) DEFAULT NULL COMMENT '联系电话',
    email VARCHAR(100) DEFAULT NULL COMMENT '邮箱',
    status INT NOT NULL DEFAULT 1 COMMENT '状态：0-禁用 1-启用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统用户表';

-- 2. 学生信息表
CREATE TABLE student (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '学生ID',
    user_id INT NOT NULL COMMENT '关联用户ID',
    student_no VARCHAR(30) NOT NULL UNIQUE COMMENT '学号',
    name VARCHAR(50) NOT NULL COMMENT '姓名',
    gender VARCHAR(4) DEFAULT NULL COMMENT '性别',
    age INT DEFAULT NULL COMMENT '年龄',
    class_name VARCHAR(50) DEFAULT NULL COMMENT '班级',
    major VARCHAR(100) DEFAULT NULL COMMENT '专业',
    college VARCHAR(100) DEFAULT NULL COMMENT '学院',
    phone VARCHAR(20) DEFAULT NULL COMMENT '联系电话',
    email VARCHAR(100) DEFAULT NULL COMMENT '邮箱',
    address VARCHAR(255) DEFAULT NULL COMMENT '家庭住址',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES sys_user(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生信息表';

-- 3. 教师信息表
CREATE TABLE teacher (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '教师ID',
    user_id INT NOT NULL COMMENT '关联用户ID',
    teacher_no VARCHAR(30) NOT NULL UNIQUE COMMENT '工号',
    name VARCHAR(50) NOT NULL COMMENT '姓名',
    gender VARCHAR(4) DEFAULT NULL COMMENT '性别',
    title VARCHAR(50) DEFAULT NULL COMMENT '职称',
    college VARCHAR(100) DEFAULT NULL COMMENT '所属学院',
    phone VARCHAR(20) DEFAULT NULL COMMENT '联系电话',
    email VARCHAR(100) DEFAULT NULL COMMENT '邮箱',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES sys_user(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师信息表';

-- 4. 实习单位表
CREATE TABLE company (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '单位ID',
    name VARCHAR(200) NOT NULL COMMENT '单位名称',
    contact_person VARCHAR(50) DEFAULT NULL COMMENT '联系人',
    contact_phone VARCHAR(20) DEFAULT NULL COMMENT '联系电话',
    address VARCHAR(255) DEFAULT NULL COMMENT '单位地址',
    description TEXT DEFAULT NULL COMMENT '单位简介',
    status INT NOT NULL DEFAULT 1 COMMENT '状态：0-停用 1-启用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='实习单位表';

-- 5. 实习记录表
CREATE TABLE internship (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '实习ID',
    student_id INT NOT NULL COMMENT '学生ID',
    company_id INT NOT NULL COMMENT '实习单位ID',
    teacher_id INT DEFAULT NULL COMMENT '指导教师ID',
    position VARCHAR(100) DEFAULT NULL COMMENT '实习岗位',
    start_date DATE DEFAULT NULL COMMENT '开始日期',
    end_date DATE DEFAULT NULL COMMENT '结束日期',
    status INT NOT NULL DEFAULT 0 COMMENT '状态：0-待审核 1-进行中 2-已完成 3-已取消',
    remark TEXT DEFAULT NULL COMMENT '备注',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (company_id) REFERENCES company(id),
    FOREIGN KEY (teacher_id) REFERENCES teacher(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='实习记录表';

-- 6. 实习任务表
CREATE TABLE internship_task (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '任务ID',
    internship_id INT NOT NULL COMMENT '实习ID',
    title VARCHAR(200) NOT NULL COMMENT '任务标题',
    content TEXT DEFAULT NULL COMMENT '任务内容',
    deadline DATE DEFAULT NULL COMMENT '截止日期',
    status INT NOT NULL DEFAULT 0 COMMENT '状态：0-未开始 1-进行中 2-已完成',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (internship_id) REFERENCES internship(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='实习任务表';

-- 7. 实习报告表
CREATE TABLE internship_report (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '报告ID',
    internship_id INT NOT NULL COMMENT '实习ID',
    student_id INT NOT NULL COMMENT '学生ID',
    title VARCHAR(200) NOT NULL COMMENT '报告标题',
    content TEXT DEFAULT NULL COMMENT '报告内容',
    file_path VARCHAR(500) DEFAULT NULL COMMENT '附件路径',
    status INT NOT NULL DEFAULT 0 COMMENT '状态：0-待审核 1-已通过 2-已退回',
    feedback TEXT DEFAULT NULL COMMENT '审核反馈',
    score INT DEFAULT NULL COMMENT '评分',
    submit_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
    review_time DATETIME DEFAULT NULL COMMENT '审核时间',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (internship_id) REFERENCES internship(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='实习报告表';

-- 8. 实习日志表
CREATE TABLE internship_log (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '日志ID',
    internship_id INT NOT NULL COMMENT '实习ID',
    student_id INT NOT NULL COMMENT '学生ID',
    title VARCHAR(200) DEFAULT NULL COMMENT '日志标题',
    content TEXT NOT NULL COMMENT '日志内容',
    log_date DATE NOT NULL COMMENT '日志日期',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (internship_id) REFERENCES internship(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='实习日志表';

-- 9. 系统公告表
CREATE TABLE announcement (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '公告ID',
    title VARCHAR(200) NOT NULL COMMENT '公告标题',
    content TEXT NOT NULL COMMENT '公告内容',
    publisher_id INT DEFAULT NULL COMMENT '发布人ID',
    status INT NOT NULL DEFAULT 1 COMMENT '状态：0-草稿 1-已发布',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (publisher_id) REFERENCES sys_user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统公告表';


-- ====================================================
-- 二、初始数据
-- ====================================================
-- 密码说明：
--   admin123   → MD5: 0192023a7bbd73250516f069df18b500
--   teacher123 → MD5: a426dcf72ba25d046591f81a5495eab7
--   student123 → MD5: ad6a280417a0f533d8b670c61667e1a0
--   123456     → MD5: e10adc3949ba59abbe56e057f20f883e
-- ====================================================

-- ---------- 系统用户 ----------

-- id=1 管理员
INSERT INTO sys_user (username, password, real_name, role, phone, email, status)
VALUES ('admin', '0192023a7bbd73250516f069df18b500', '系统管理员', 1, '13800000000', 'admin@example.com', 1);

-- id=2,3 教师
INSERT INTO sys_user (username, password, real_name, role, phone, email, status)
VALUES ('teacher01', 'a426dcf72ba25d046591f81a5495eab7', '王春水', 2, '13800000001', 'wangcs@example.com', 1);
INSERT INTO sys_user (username, password, real_name, role, phone, email, status)
VALUES ('teacher02', 'a426dcf72ba25d046591f81a5495eab7', '李明华', 2, '13800000002', 'limh@example.com', 1);

-- id=4~11 学生
INSERT INTO sys_user (username, password, real_name, role, phone, email, status)
VALUES ('student01', 'ad6a280417a0f533d8b670c61667e1a0', '陈思梦', 3, '13800000003', 'chensm@example.com', 1);
INSERT INTO sys_user (username, password, real_name, role, phone, email, status)
VALUES ('student02', 'ad6a280417a0f533d8b670c61667e1a0', '张伟',   3, '13800000004', 'zhangw@example.com', 1);
INSERT INTO sys_user (username, password, real_name, role, phone, email, status)
VALUES ('student03', 'ad6a280417a0f533d8b670c61667e1a0', '刘芳',   3, '13800000005', 'liuf@example.com', 1);
INSERT INTO sys_user (username, password, real_name, role, phone, email, status)
VALUES ('student04', 'ad6a280417a0f533d8b670c61667e1a0', '赵强',   3, '13800000006', 'zhaoq@example.com', 1);
INSERT INTO sys_user (username, password, real_name, role, phone, email, status)
VALUES ('student05', 'ad6a280417a0f533d8b670c61667e1a0', '孙丽',   3, '13800000007', 'sunl@example.com', 1);
INSERT INTO sys_user (username, password, real_name, role, phone, email, status)
VALUES ('student06', 'ad6a280417a0f533d8b670c61667e1a0', '周杰',   3, '13800000008', 'zhouj@example.com', 1);
INSERT INTO sys_user (username, password, real_name, role, phone, email, status)
VALUES ('student07', 'ad6a280417a0f533d8b670c61667e1a0', '吴敏',   3, '13800000009', 'wum@example.com', 1);
INSERT INTO sys_user (username, password, real_name, role, phone, email, status)
VALUES ('student08', 'ad6a280417a0f533d8b670c61667e1a0', '郑浩',   3, '13800000010', 'zhengh@example.com', 1);

-- ---------- 教师信息 ----------
INSERT INTO teacher (user_id, teacher_no, name, gender, title, college, phone, email)
VALUES (2, 'T20210001', '王春水', '男', '讲师',   '工学部', '13800000001', 'wangcs@example.com');
INSERT INTO teacher (user_id, teacher_no, name, gender, title, college, phone, email)
VALUES (3, 'T20210002', '李明华', '女', '副教授', '工学部', '13800000002', 'limh@example.com');

-- ---------- 学生信息 ----------
INSERT INTO student (user_id, student_no, name, gender, age, class_name, major, college, phone, email, address) VALUES
(4,  '2201010535', '陈思梦', '女', 22, '软件工程2201',   '软件工程',         '工学部', '13800000003', 'chensm@example.com', '安徽省合肥市蜀山区'),
(5,  '2201010536', '张伟',   '男', 22, '软件工程2201',   '软件工程',         '工学部', '13800000004', 'zhangw@example.com', '安徽省芜湖市镜湖区'),
(6,  '2201010537', '刘芳',   '女', 21, '软件工程2202',   '软件工程',         '工学部', '13800000005', 'liuf@example.com',   '安徽省安庆市迎江区'),
(7,  '2201010538', '赵强',   '男', 22, '软件工程2201',   '软件工程',         '工学部', '13800000006', 'zhaoq@example.com',  '安徽省蚌埠市蚌山区'),
(8,  '2201010539', '孙丽',   '女', 21, '软件工程2202',   '软件工程',         '工学部', '13800000007', 'sunl@example.com',   '安徽省阜阳市颍州区'),
(9,  '2201020501', '周杰',   '男', 22, '计算机科学2201', '计算机科学与技术', '工学部', '13800000008', 'zhouj@example.com',  '安徽省马鞍山市花山区'),
(10, '2201020502', '吴敏',   '女', 21, '计算机科学2201', '计算机科学与技术', '工学部', '13800000009', 'wum@example.com',    '安徽省黄山市屯溪区'),
(11, '2201030501', '郑浩',   '男', 23, '信息安全2201',   '信息安全',         '工学部', '13800000010', 'zhengh@example.com', '安徽省六安市金安区');

-- ---------- 实习单位 ----------
INSERT INTO company (name, contact_person, contact_phone, address, description, status) VALUES
('合肥科大讯飞信息科技股份有限公司', '张经理', '0551-65331234', '安徽省合肥市高新区望江西路666号',   '科大讯飞是一家专业从事智能语音及语言技术研究的国家级骨干软件企业', 1),
('安徽华米信息科技有限公司',         '李经理', '0551-65335678', '安徽省合肥市高新区创新大道2800号', '华米科技是一家生物传感和活动数据驱动的人工智能公司', 1),
('合肥美的电器有限公司',             '王经理', '0551-63801234', '安徽省合肥市经开区紫云路99号',     '美的集团是一家覆盖智能家居的消费电器企业', 1),
('合肥中科软科技有限公司',           '赵经理', '0551-65339876', '安徽省合肥市蜀山区长江西路3号',   '专注于软件外包和信息技术服务的高新技术企业', 1),
('安徽国泰信息技术有限公司',         '陈经理', '0551-65337654', '安徽省合肥市政务区天鹅湖路198号', '提供IT基础设施和软件开发服务的综合型科技公司', 1),
('合肥联宝电子科技有限公司',         '刘经理', '0551-62188888', '安徽省合肥市经开区宝塔路399号',   '联想集团全球最大的PC研发和制造基地', 1);

-- ---------- 实习记录 ----------
INSERT INTO internship (student_id, company_id, teacher_id, position, start_date, end_date, status, remark) VALUES
(1, 1, 1, 'Java开发实习生',     '2025-07-01', '2025-12-31', 1, '负责后端微服务模块开发'),
(2, 2, 1, '前端开发实习生',     '2025-07-01', '2025-12-31', 1, '参与智能穿戴平台前端开发'),
(3, 3, 2, '软件测试实习生',     '2025-08-01', '2026-01-31', 0, '申请中，待指导教师审核'),
(4, 4, 1, 'Python后端开发实习生','2025-07-15', '2025-12-31', 1, '负责后端API开发工作'),
(5, 5, 2, '数据分析实习生',     '2025-08-01', '2026-01-31', 1, '参与数据清洗和分析工作'),
(6, 6, 1, '嵌入式开发实习生',   '2025-09-01', '2026-02-28', 0, '待审核中'),
(7, 1, 2, 'Android开发实习生',  '2025-07-01', '2025-11-30', 2, '实习已顺利完成'),
(8, 2, 1, 'UI设计实习生',       '2025-10-01', '2026-03-31', 0, '申请中');

-- ---------- 实习任务 ----------
INSERT INTO internship_task (internship_id, title, content, deadline, status) VALUES
-- 陈思梦的任务 (实习1)
(1, '熟悉开发环境',       '搭建本地开发环境，了解公司项目架构和编码规范', '2025-07-15', 2),
(1, '参与项目开发',       '参与公司实际项目的模块开发工作', '2025-09-30', 1),
(1, '撰写实习总结报告',   '根据实习期间的工作内容，撰写一份不少于3000字的实习总结报告', '2025-12-20', 0),
-- 张伟的任务 (实习2)
(2, '学习前端框架',       '学习Vue.js框架并完成练习项目', '2025-07-31', 2),
(2, '参与公司OA系统开发', '负责公司OA系统中考勤模块的前端页面开发', '2025-10-31', 1),
(2, '完成前端性能优化',   '对公司官网进行性能分析和优化，提升页面加载速度', '2025-11-30', 0),
(2, '学习Vue.js组件开发', '深入学习Vue.js组件化开发方式，完成一个个人博客前端页面', '2025-08-15', 2),
-- 赵强的任务 (实习4)
(4, '搭建Python开发环境', '配置本地Python开发环境，安装Django框架和相关依赖', '2025-07-25', 2),
(4, '开发用户认证模块',   '使用Django REST Framework实现用户注册、登录、权限验证接口', '2025-09-15', 2),
(4, '编写API文档',        '使用Swagger为已完成的API接口编写完整的接口文档', '2025-10-15', 1),
-- 孙丽的任务 (实习5)
(5, '学习数据分析工具',       '学习掌握Python Pandas、NumPy等数据分析库的使用方法', '2025-08-31', 2),
(5, '完成销售数据分析报告',   '对公司近一年的销售数据进行清洗和分析，输出可视化报告', '2025-10-30', 1),
-- 赵强(Android)的任务 (实习7, student_id=7)
(7, '学习Android基础开发',   '掌握Android Studio开发工具和Activity生命周期', '2025-07-20', 2),
(7, '开发天气查询APP',       '独立开发一个天气查询APP，实现定位和天气展示功能', '2025-09-30', 2),
(7, '项目上线与维护',        '协助主管完成公司APP的版本更新和Bug修复', '2025-11-15', 2);

-- ---------- 实习报告 ----------
INSERT INTO internship_report (internship_id, student_id, title, content, status, feedback, score, submit_time, review_time) VALUES
(1, 1, '第一阶段实习报告 — 环境搭建与基础学习',
'在实习的第一个月，我主要完成了开发环境的搭建和公司项目架构的学习。通过阅读项目文档和代码，我了解了公司采用的Spring Cloud微服务架构。在导师的指导下，我成功搭建了本地开发环境，并熟悉了Git版本管理流程和代码审查机制。此外，我还参加了公司组织的新人培训，学习了编码规范和项目管理流程。',
1, '报告内容详实，对实习第一阶段的工作做了很好的总结。建议后续报告中可以加入更多技术细节和个人思考。', 85, '2025-08-01 10:30:00', '2025-08-05 14:20:00'),

(1, 1, '第二阶段实习报告 — 项目开发实践',
'在第二阶段的实习中，我正式参与了公司语音识别项目的后端开发工作。主要负责数据接口的开发和优化，使用MyBatis进行数据持久化操作。期间遇到了SQL性能问题，通过添加索引和优化查询语句，将接口响应时间从2秒降低到200毫秒。同时也参与了代码评审，从中学到了很多编码的最佳实践。',
1, '很好地记录了实习中的技术实践。SQL优化的案例很有价值，说明你具备了独立解决问题的能力。', 90, '2025-10-01 09:15:00', '2025-10-03 16:30:00'),

(2, 2, '前端开发实习第一阶段报告',
'入职华米科技后，我被分配到前端开发团队。第一个月主要学习了Vue.js框架和公司的前端技术栈。通过完成一个练习项目（个人博客），我掌握了Vue组件化开发、Vuex状态管理和Vue Router路由配置。同时也学习了Element UI组件库的使用，为后续的项目开发打下了基础。',
1, '基础学习阶段完成得不错，Vue.js技术栈的掌握程度良好。', 82, '2025-08-20 11:00:00', '2025-08-22 09:45:00'),

(2, 2, '前端开发实习第二阶段报告',
'在实习的第二阶段，我正式参与了公司智能穿戴设备管理平台的前端开发。主要负责考勤管理模块的页面开发，包括考勤列表、考勤统计图表、异常处理等功能。使用ECharts实现了数据可视化，学会了处理大量数据的前端性能优化方法。',
0, NULL, NULL, '2025-11-15 14:30:00', NULL),

(4, 4, 'Python后端开发实习报告 — 第一阶段',
'在中科软实习的第一阶段，我完成了Python开发环境搭建和Django框架的深入学习。独立完成了用户认证模块的开发，包括注册、登录、Token刷新等API接口。使用Django REST Framework的序列化器和视图集简化了开发流程，并通过单元测试保证了代码质量。',
1, '接口开发规范，测试覆盖充分，继续保持！', 88, '2025-09-20 10:00:00', '2025-09-22 15:00:00'),

(5, 5, '数据分析实习月度报告',
'本月主要完成了对公司产品销售数据的清洗和初步分析。使用Python Pandas处理了超过10万条销售记录，解决了数据缺失、格式不统一等问题。通过Matplotlib和Seaborn完成了销售趋势图、区域分布图等可视化展示，为市场部提供了有价值的分析报告。',
2, '报告中的数据分析结论缺少支撑依据，建议补充详细的分析过程和统计方法说明后重新提交。', NULL, '2025-10-25 16:20:00', '2025-10-28 11:10:00'),

(7, 7, 'Android开发实习总结报告',
'在科大讯飞的实习圆满结束。在为期五个月的实习中，我独立开发了天气查询APP，参与了公司移动端产品的迭代开发和Bug修复。通过这段实习经历，我深入掌握了Android开发技术，包括Material Design设计规范、网络请求（Retrofit）、本地数据存储（Room）等。最大的收获是学会了如何在团队中协作开发，以及如何编写可维护的高质量代码。',
1, '实习表现优秀，综合报告内容全面，技术成长明显。祝前程似锦！', 95, '2025-12-05 09:00:00', '2025-12-06 10:30:00');

-- ---------- 实习日志 ----------
INSERT INTO internship_log (internship_id, student_id, title, content, log_date) VALUES
-- 陈思梦日志
(1, 1, '入职第一天',       '今天是到科大讯飞实习的第一天。上午办理了入职手续，领取了工牌和电脑。下午参加了部门迎新会议，认识了导师和团队成员。导师安排了第一周的学习计划，主要是了解公司的技术架构和开发流程。', '2025-07-01'),
(1, 1, '搭建开发环境',     '今天主要完成了本地开发环境的搭建，安装了JDK、Maven、IntelliJ IDEA等工具，并成功拉取了项目代码。跟着文档配置了数据库连接和Redis缓存，项目能够在本地正常运行了。', '2025-07-02'),
(1, 1, '学习项目架构',     '今天花了一整天时间阅读项目的架构设计文档。项目采用Spring Cloud微服务架构，包含网关服务、用户服务、语音服务等多个模块。画了一张架构图来帮助理解各服务之间的调用关系。', '2025-07-03'),
(1, 1, '参加技术分享会',   '今天下午参加了团队的技术分享会，主题是"微服务中的分布式事务处理"。虽然很多内容还不太理解，但开阔了视野。会后向分享者请教了几个问题，收获很大。', '2025-07-08'),
(1, 1, '完成第一个需求',   '今天提交了入职以来的第一个代码PR！是一个简单的数据查询接口。导师Review后提出了几点修改意见，关于异常处理和日志打印规范。修改后通过了Review，合并到了开发分支。非常有成就感！', '2025-07-15'),
(1, 1, 'SQL性能优化实践',  '今天在开发新接口时发现一个查询特别慢，用了接近3秒。通过EXPLAIN分析发现是全表扫描导致的。添加了联合索引后，查询时间降到了50ms以内。导师表扬了我的排查能力！', '2025-08-20'),
-- 张伟日志
(2, 2, '实习第一天',       '到华米科技报到，接受了新员工培训。了解了公司的产品线和技术团队架构。被分配到前端开发组，工位在一群大佬旁边，有点紧张但很期待。', '2025-07-01'),
(2, 2, 'Vue.js入门学习',  '今天开始系统学习Vue.js。之前只学过一点基础，今天深入学习了响应式原理和组件生命周期。跟着Vue官方文档做了几个小例子，感觉很有意思。', '2025-07-05'),
(2, 2, '完成博客项目',     '花了两周时间完成了个人博客练习项目。实现了文章列表、文章详情、评论功能。使用Vuex管理全局状态，用Vue Router做路由配置。导师说做得不错，可以进入正式项目了。', '2025-07-18'),
(2, 2, '参加代码评审',     '今天第一次参加团队的代码评审会议，学到了很多编码规范和最佳实践。比如组件拆分原则、CSS命名规范、Git提交信息规范等。', '2025-08-10'),
-- 赵强日志
(4, 4, 'Django框架学习',  '今天深入学习了Django的MTV架构模式，理解了Model、Template、View的工作原理。完成了一个简单的Todo List应用作为练习。', '2025-07-16'),
(4, 4, 'REST API设计',    '学习了RESTful API设计规范，包括URL命名、HTTP方法使用、状态码约定等。开始使用Django REST Framework开发用户认证模块。', '2025-07-22'),
(4, 4, '单元测试编写',     '今天学习了Python的unittest框架和Django的测试工具。为已完成的API接口编写了单元测试，覆盖了正常流程和异常场景。测试覆盖率达到了85%。', '2025-08-10'),
-- 孙丽日志
(5, 5, 'Pandas数据处理',  '今天主要学习了Pandas的数据读取、清洗和转换操作。处理了一份包含缺失值和异常值的销售数据样本，学会了fillna、dropna等方法。', '2025-08-05'),
(5, 5, '数据可视化实践',   '使用Matplotlib和Seaborn对上周清洗的数据进行了可视化展示。绘制了销售趋势折线图、区域分布饼图和产品销量柱状图，效果很不错。', '2025-08-15');

-- ---------- 系统公告 ----------
INSERT INTO announcement (title, content, publisher_id, status, create_time) VALUES
('关于2025年暑期实习安排的通知',
'各位同学：2025年暑期实习即将开始，请同学们尽快联系实习单位并提交实习申请。实习时间为2025年7月1日至2025年12月31日。请各位同学认真对待实习环节，按时完成各项任务。',
1, 1, '2025-06-15 09:00:00'),

('实习报告提交截止日期提醒',
'请各位同学在实习结束后两周内提交实习报告，逾期将影响实习成绩评定。报告要求不少于3000字，需包含实习内容、心得体会和自我评价等内容。',
1, 1, '2025-06-20 10:00:00'),

('关于规范实习日志填写的通知',
'各位同学：为了更好地记录实习过程，请大家严格按照要求填写实习日志。日志内容应包括：当日工作内容、学习心得、遇到的问题及解决方案。每周至少填写3篇实习日志，指导教师将定期检查。',
1, 1, '2025-07-01 08:30:00'),

('2025年实习单位信息更新公告',
'经学院与多家企业协商，新增以下实习合作单位：合肥中科软科技有限公司、安徽国泰信息技术有限公司、合肥联宝电子科技有限公司。有意向的同学可以通过系统查看详细信息并提交实习申请。',
1, 1, '2025-07-10 14:00:00'),

('实习安全注意事项',
'各位实习同学请注意：1. 遵守实习单位的规章制度和安全操作规程；2. 注意交通安全，特别是上下班途中；3. 保管好个人财物和重要资料；4. 遇到问题及时与指导教师沟通。祝大家实习顺利！',
1, 1, '2025-07-15 09:00:00'),

('关于实习成绩评定标准的说明',
'实习成绩由以下几部分组成：1. 实习态度与表现（20%）；2. 实习任务完成情况（30%）；3. 实习报告质量（30%）；4. 实习日志记录（20%）。最终成绩由指导教师综合评定，请同学们认真对待每个环节。',
1, 1, '2025-08-01 10:00:00'),

('系统维护通知',
'系统将于2025年12月20日（周六）22:00至次日02:00进行例行维护升级，届时系统将暂时无法访问。请提前做好相关工作安排，给您带来不便敬请谅解。',
1, 1, '2025-12-18 16:00:00');
