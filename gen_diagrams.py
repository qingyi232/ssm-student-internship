# -*- coding: utf-8 -*-
"""生成毕业论文所需的所有图表（白底黑字黑线）"""
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
from matplotlib.patches import FancyBboxPatch, FancyArrowPatch
import numpy as np
import os

IMG_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'thesis_images')
os.makedirs(IMG_DIR, exist_ok=True)

plt.rcParams['font.sans-serif'] = ['SimHei', 'Microsoft YaHei']
plt.rcParams['axes.unicode_minus'] = False
plt.rcParams['figure.facecolor'] = 'white'
plt.rcParams['savefig.facecolor'] = 'white'
plt.rcParams['savefig.dpi'] = 200


def _save(fig, name):
    fig.savefig(os.path.join(IMG_DIR, name), bbox_inches='tight', pad_inches=0.3)
    plt.close(fig)
    print(f'  [OK] {name}')


# ========== 绘图工具 ==========
def _draw_actor(ax, x, y, label):
    head = plt.Circle((x, y + 0.35), 0.12, fill=False, ec='black', lw=1.5)
    ax.add_patch(head)
    ax.plot([x, x], [y + 0.23, y - 0.05], 'k-', lw=1.5)
    ax.plot([x - 0.18, x + 0.18], [y + 0.12, y + 0.12], 'k-', lw=1.5)
    ax.plot([x, x - 0.15], [y - 0.05, y - 0.3], 'k-', lw=1.5)
    ax.plot([x, x + 0.15], [y - 0.05, y - 0.3], 'k-', lw=1.5)
    ax.text(x, y - 0.45, label, ha='center', va='top', fontsize=10, fontweight='bold')


def _draw_ellipse(ax, x, y, text, w=1.6, h=0.45):
    e = mpatches.Ellipse((x, y), w, h, fill=False, ec='black', lw=1.2)
    ax.add_patch(e)
    ax.text(x, y, text, ha='center', va='center', fontsize=8)
    return x, y


def _draw_box(ax, x, y, text, w=1.8, h=0.5, fs=9, bold=False):
    rect = FancyBboxPatch((x - w/2, y - h/2), w, h,
                          boxstyle="round,pad=0.05", fill=False, ec='black', lw=1.2)
    ax.add_patch(rect)
    fw = 'bold' if bold else 'normal'
    ax.text(x, y, text, ha='center', va='center', fontsize=fs, fontweight=fw)


def _draw_diamond(ax, x, y, text, s=0.35):
    diamond = plt.Polygon([(x, y+s), (x+s*1.5, y), (x, y-s), (x-s*1.5, y)],
                          fill=False, ec='black', lw=1.2)
    ax.add_patch(diamond)
    ax.text(x, y, text, ha='center', va='center', fontsize=8)


def _arrow(ax, x1, y1, x2, y2, style='->', lw=1.2):
    ax.annotate('', xy=(x2, y2), xytext=(x1, y1),
                arrowprops=dict(arrowstyle=style, color='black', lw=lw))


def _line(ax, x1, y1, x2, y2, lw=1.0):
    ax.plot([x1, x2], [y1, y2], 'k-', lw=lw)


# ========== 图 3-1 系统总体用例图 ==========
def gen_usecase_overall():
    fig, ax = plt.subplots(1, 1, figsize=(10, 8))
    ax.set_xlim(-1, 11)
    ax.set_ylim(-1, 9)
    ax.set_aspect('equal')
    ax.axis('off')

    # 系统边界
    rect = mpatches.Rectangle((2.5, 0), 6, 8.5, fill=False, ec='black', lw=2, ls='--')
    ax.add_patch(rect)
    ax.text(5.5, 8.8, '学生实习管理系统', ha='center', fontsize=13, fontweight='bold')

    # 管理员
    _draw_actor(ax, 0.8, 6.5, '管理员')
    cases_a = ['用户管理', '学生管理', '教师管理', '实习单位管理', '实习信息管理', '公告管理', '数据统计']
    for i, c in enumerate(cases_a):
        ex, ey = _draw_ellipse(ax, 4.2, 8 - i * 0.65, c, w=1.5, h=0.42)
        _line(ax, 1.1, 6.5, ex - 0.75, ey)

    # 教师
    _draw_actor(ax, 0.8, 2.5, '教师')
    cases_t = ['查看学生列表', '实习过程管理', '任务管理', '报告审核']
    for i, c in enumerate(cases_t):
        ex, ey = _draw_ellipse(ax, 5.5, 3.8 - i * 0.65, c, w=1.5, h=0.42)
        _line(ax, 1.1, 2.5, ex - 0.75, ey)

    # 学生
    _draw_actor(ax, 10, 4, '学生')
    cases_s = ['查看实习信息', '查看任务', '提交报告', '填写日志', '查看公告', '个人信息管理']
    for i, c in enumerate(cases_s):
        ex, ey = _draw_ellipse(ax, 7.2, 5.8 - i * 0.65, c, w=1.5, h=0.42)
        _line(ax, 9.7, 4, ex + 0.75, ey)

    # 公共：登录
    ex, ey = _draw_ellipse(ax, 5.5, 0.4, '登录系统', w=1.4, h=0.42)
    _line(ax, 1.1, 6.2, ex - 0.7, ey)
    _line(ax, 1.1, 2.2, ex - 0.7, ey)
    _line(ax, 9.7, 3.7, ex + 0.7, ey)

    # 修改密码
    ex2, ey2 = _draw_ellipse(ax, 3.5, 0.4, '修改密码', w=1.4, h=0.42)
    _line(ax, 1.1, 6.0, ex2 - 0.7, ey2)
    _line(ax, 1.1, 2.0, ex2 - 0.7, ey2)
    _line(ax, 9.7, 3.5, ex2 + 0.7, ey2 + 0.1)

    _save(fig, 'usecase_overall.png')


# ========== 图 4-1 系统架构图 ==========
def gen_architecture():
    fig, ax = plt.subplots(figsize=(9, 6))
    ax.set_xlim(0, 9)
    ax.set_ylim(0, 7)
    ax.axis('off')

    layers = [
        (6.0, '客户端（浏览器）', 'Web浏览器 / IE / Chrome / Firefox', 7.5),
        (5.0, '表示层（View）', 'JSP + JSTL + jQuery + CSS + Font Awesome', 7.5),
        (4.0, '控制层（Controller）', 'Spring MVC（DispatcherServlet + Controller）', 7.5),
        (3.0, '业务逻辑层（Service）', 'Spring IoC + AOP + 事务管理', 7.5),
        (2.0, '数据访问层（DAO/Mapper）', 'MyBatis（SqlSession + Mapper接口 + XML映射）', 7.5),
        (1.0, '数据库层', 'MySQL 8.0 + Druid连接池', 7.5),
    ]

    for y, title, desc, w in layers:
        rect = FancyBboxPatch((0.75, y - 0.35), w, 0.7,
                              boxstyle="round,pad=0.08", fill=False, ec='black', lw=1.5)
        ax.add_patch(rect)
        ax.text(4.5, y + 0.08, title, ha='center', va='center', fontsize=11, fontweight='bold')
        ax.text(4.5, y - 0.15, desc, ha='center', va='center', fontsize=8, color='black')

    for i in range(5):
        y_top = layers[i][0] - 0.35
        y_bot = layers[i + 1][0] + 0.35
        _arrow(ax, 4.5, y_top, 4.5, y_bot, style='<->')

    _save(fig, 'architecture.png')


# ========== 图 4-2 功能模块图 ==========
def gen_module_structure():
    fig, ax = plt.subplots(figsize=(14, 9))
    ax.set_xlim(0, 14)
    ax.set_ylim(0, 9)
    ax.axis('off')

    # 根节点
    _draw_box(ax, 7, 8.3, '学生实习管理系统', w=3.0, h=0.55, fs=12, bold=True)

    # 三大模块
    modules = [
        (2.5, 7.0, '管理员模块'),
        (7.0, 7.0, '教师模块'),
        (11.5, 7.0, '学生模块'),
    ]
    for mx, my, mt in modules:
        _draw_box(ax, mx, my, mt, w=2.0, h=0.5, fs=10, bold=True)
        _line(ax, 7, 8.03, mx, my + 0.25)

    # 管理员子模块
    admin_subs = ['用户管理', '学生管理', '教师管理', '单位管理', '实习管理', '公告管理', '数据统计']
    for i, s in enumerate(admin_subs):
        sx = 0.5 + i * 0.57 * (4.0 / len(admin_subs)) + 0.2
        sx = 0.3 + i * 0.6
        _draw_box(ax, sx + 0.2, 5.5, s, w=0.95, h=0.45, fs=7)
        _line(ax, 2.5, 6.75, sx + 0.2, 5.73)

    # 教师子模块
    teacher_subs = ['学生列表', '实习管理', '任务管理', '报告审核']
    for i, s in enumerate(teacher_subs):
        sx = 5.5 + i * 1.0
        _draw_box(ax, sx, 5.5, s, w=0.95, h=0.45, fs=8)
        _line(ax, 7.0, 6.75, sx, 5.73)

    # 学生子模块
    student_subs = ['实习信息', '任务查看', '报告提交', '日志管理', '公告查看', '个人信息']
    for i, s in enumerate(student_subs):
        sx = 9.7 + i * 0.8
        _draw_box(ax, sx, 5.5, s, w=0.75, h=0.45, fs=7)
        _line(ax, 11.5, 6.75, sx, 5.73)

    # 公共模块
    _draw_box(ax, 7, 4.2, '公共模块', w=2.0, h=0.5, fs=10, bold=True)
    _line(ax, 7, 8.03, 7, 4.45)
    common_subs = ['登录认证', '密码管理', '权限拦截', '分页处理']
    for i, s in enumerate(common_subs):
        sx = 4.8 + i * 1.5
        _draw_box(ax, sx, 3.2, s, w=1.1, h=0.45, fs=8)
        _line(ax, 7.0, 3.95, sx, 3.43)

    _save(fig, 'module_structure.png')


# ========== 图 4-3 E-R图 ==========
def gen_er_diagram():
    fig, ax = plt.subplots(figsize=(14, 10))
    ax.set_xlim(0, 14)
    ax.set_ylim(0, 10)
    ax.axis('off')

    entities = {
        'sys_user':    (3, 9, '系统用户\n(sys_user)'),
        'student':     (1.5, 6.5, '学生\n(student)'),
        'teacher':     (5, 6.5, '教师\n(teacher)'),
        'company':     (10, 9, '实习单位\n(company)'),
        'internship':  (7, 4.5, '实习记录\n(internship)'),
        'task':        (3, 2, '实习任务\n(internship_task)'),
        'report':      (7, 1.5, '实习报告\n(internship_report)'),
        'log':         (11, 2.5, '实习日志\n(internship_log)'),
        'announcement':(12, 7, '系统公告\n(announcement)'),
    }

    for key, (x, y, label) in entities.items():
        _draw_box(ax, x, y, label, w=2.0, h=0.8, fs=9, bold=True)

    # 关系
    rels = [
        ('sys_user', 'student',  '拥有', '1', 'n'),
        ('sys_user', 'teacher',  '拥有', '1', 'n'),
        ('student',  'internship', '参加', '1', 'n'),
        ('teacher',  'internship', '指导', '1', 'n'),
        ('company',  'internship', '提供', '1', 'n'),
        ('internship','task',     '包含', '1', 'n'),
        ('internship','report',   '包含', '1', 'n'),
        ('internship','log',      '包含', '1', 'n'),
        ('sys_user', 'announcement','发布', '1', 'n'),
    ]

    for e1, e2, rel_name, c1, c2 in rels:
        x1, y1, _ = entities[e1]
        x2, y2, _ = entities[e2]
        mx, my = (x1 + x2) / 2, (y1 + y2) / 2
        _line(ax, x1, y1, x2, y2, lw=1.0)
        _draw_diamond(ax, mx, my, rel_name, s=0.28)
        ox1 = 0.3 if x1 < mx else -0.3
        oy1 = 0.2 if y1 < my else -0.2
        ax.text(x1 + ox1*1.5, y1 + oy1*0.5, c1, fontsize=8, ha='center', fontweight='bold')
        ox2 = 0.3 if x2 < mx else -0.3
        oy2 = 0.2 if y2 < my else -0.2
        ax.text(x2 + ox2*1.5, y2 + oy2*0.5, c2, fontsize=8, ha='center', fontweight='bold')

    _save(fig, 'er_diagram.png')


# ========== 图 5-1 登录流程图 ==========
def gen_login_flow():
    fig, ax = plt.subplots(figsize=(6, 10))
    ax.set_xlim(0, 6)
    ax.set_ylim(0, 11)
    ax.axis('off')

    # 开始
    start = plt.Circle((3, 10.3), 0.3, fill=False, ec='black', lw=1.5)
    ax.add_patch(start)
    ax.text(3, 10.3, '开始', ha='center', va='center', fontsize=9)

    # 输入用户名密码
    _draw_box(ax, 3, 9.2, '输入用户名和密码', w=2.5, h=0.5, fs=9)
    _arrow(ax, 3, 10.0, 3, 9.45)

    # 提交登录请求
    _draw_box(ax, 3, 8.2, '提交登录请求', w=2.5, h=0.5, fs=9)
    _arrow(ax, 3, 8.95, 3, 8.45)

    # MD5加密
    _draw_box(ax, 3, 7.2, '对密码进行MD5加密', w=2.5, h=0.5, fs=9)
    _arrow(ax, 3, 7.95, 3, 7.45)

    # 判断用户是否存在
    _draw_diamond(ax, 3, 6.1, '用户名密码\n是否正确?', s=0.45)
    _arrow(ax, 3, 6.95, 3, 6.55)

    # 否 -> 返回错误
    _draw_box(ax, 0.8, 6.1, '提示错误\n信息', w=1.3, h=0.5, fs=8)
    ax.annotate('', xy=(1.45, 6.1), xytext=(2.2, 6.1),
                arrowprops=dict(arrowstyle='->', color='black', lw=1.2))
    ax.text(1.8, 6.3, '否', fontsize=8)
    _arrow(ax, 0.8, 6.35, 0.8, 9.2)
    _line(ax, 0.8, 9.2, 1.75, 9.2)

    # 是 -> 判断状态
    _draw_diamond(ax, 3, 4.8, '账号状态\n是否正常?', s=0.45)
    _arrow(ax, 3, 5.65, 3, 5.25)
    ax.text(3.15, 5.5, '是', fontsize=8)

    # 否 -> 提示禁用
    _draw_box(ax, 5.2, 4.8, '提示账号\n已禁用', w=1.3, h=0.5, fs=8)
    ax.annotate('', xy=(4.55, 4.8), xytext=(3.8, 4.8),
                arrowprops=dict(arrowstyle='<-', color='black', lw=1.2))
    ax.text(4.1, 5.0, '否', fontsize=8)

    # 是 -> 保存session
    _draw_box(ax, 3, 3.6, '保存用户信息到Session', w=2.5, h=0.5, fs=9)
    _arrow(ax, 3, 4.35, 3, 3.85)
    ax.text(3.15, 4.15, '是', fontsize=8)

    # 判断角色跳转
    _draw_diamond(ax, 3, 2.5, '判断\n用户角色', s=0.4)
    _arrow(ax, 3, 3.35, 3, 2.9)

    # 跳转
    _draw_box(ax, 1, 1.3, '管理员\n首页', w=1.2, h=0.45, fs=8)
    _draw_box(ax, 3, 1.3, '教师\n首页', w=1.2, h=0.45, fs=8)
    _draw_box(ax, 5, 1.3, '学生\n首页', w=1.2, h=0.45, fs=8)
    _arrow(ax, 2.3, 2.3, 1.3, 1.53)
    _arrow(ax, 3, 2.1, 3, 1.53)
    _arrow(ax, 3.7, 2.3, 4.7, 1.53)

    # 结束
    end = plt.Circle((3, 0.4), 0.3, fill=False, ec='black', lw=1.5)
    ax.add_patch(end)
    ax.text(3, 0.4, '结束', ha='center', va='center', fontsize=9)
    _arrow(ax, 1, 1.08, 1, 0.7)
    _line(ax, 1, 0.7, 3, 0.7)
    _arrow(ax, 3, 1.08, 3, 0.7)
    _arrow(ax, 5, 1.08, 5, 0.7)
    _line(ax, 5, 0.7, 3, 0.7)

    _save(fig, 'login_flow.png')


# ========== 图 5-2 实习申请流程图 ==========
def gen_internship_flow():
    fig, ax = plt.subplots(figsize=(6, 9))
    ax.set_xlim(0, 6)
    ax.set_ylim(0, 10)
    ax.axis('off')

    start = plt.Circle((3, 9.5), 0.28, fill=False, ec='black', lw=1.5)
    ax.add_patch(start)
    ax.text(3, 9.5, '开始', ha='center', va='center', fontsize=9)

    _draw_box(ax, 3, 8.5, '管理员录入实习信息', w=2.8, h=0.5, fs=9)
    _arrow(ax, 3, 9.22, 3, 8.75)

    _draw_box(ax, 3, 7.5, '分配指导教师', w=2.8, h=0.5, fs=9)
    _arrow(ax, 3, 8.25, 3, 7.75)

    _draw_box(ax, 3, 6.5, '教师审核实习申请', w=2.8, h=0.5, fs=9)
    _arrow(ax, 3, 7.25, 3, 6.75)

    _draw_diamond(ax, 3, 5.5, '审核\n通过?', s=0.4)
    _arrow(ax, 3, 6.25, 3, 5.9)

    _draw_box(ax, 0.8, 5.5, '退回修改', w=1.3, h=0.45, fs=8)
    ax.annotate('', xy=(1.45, 5.5), xytext=(2.25, 5.5),
                arrowprops=dict(arrowstyle='->', color='black', lw=1.2))
    ax.text(1.7, 5.7, '否', fontsize=8)
    _arrow(ax, 0.8, 5.73, 0.8, 8.5)
    _line(ax, 0.8, 8.5, 1.6, 8.5)

    _draw_box(ax, 3, 4.3, '实习状态更新为进行中', w=2.8, h=0.5, fs=9)
    _arrow(ax, 3, 5.1, 3, 4.55)
    ax.text(3.15, 4.85, '是', fontsize=8)

    _draw_box(ax, 3, 3.3, '教师发布实习任务', w=2.8, h=0.5, fs=9)
    _arrow(ax, 3, 4.05, 3, 3.55)

    _draw_box(ax, 3, 2.3, '学生完成任务/提交报告/日志', w=2.8, h=0.5, fs=9)
    _arrow(ax, 3, 3.05, 3, 2.55)

    _draw_box(ax, 3, 1.3, '教师审核评分', w=2.8, h=0.5, fs=9)
    _arrow(ax, 3, 2.05, 3, 1.55)

    end = plt.Circle((3, 0.4), 0.28, fill=False, ec='black', lw=1.5)
    ax.add_patch(end)
    ax.text(3, 0.4, '结束', ha='center', va='center', fontsize=9)
    _arrow(ax, 3, 1.05, 3, 0.68)

    _save(fig, 'internship_flow.png')


# ========== 图 6-1 测试结果统计饼图 ==========
def gen_test_result_chart():
    fig, ax = plt.subplots(figsize=(6, 5))
    labels = ['通过', '未通过']
    sizes = [28, 0]
    colors = ['white', 'lightgray']
    wedges, texts, autotexts = ax.pie(sizes if sizes[1] > 0 else [28],
                                       labels=['通过'] if sizes[1] == 0 else labels,
                                       autopct='%1.0f%%', startangle=90,
                                       colors=['white'],
                                       wedgeprops=dict(edgecolor='black', linewidth=1.5))
    ax.set_title('')
    _save(fig, 'test_result.png')


def generate_all():
    print('正在生成论文图表...')
    gen_usecase_overall()
    gen_architecture()
    gen_module_structure()
    gen_er_diagram()
    gen_login_flow()
    gen_internship_flow()
    gen_test_result_chart()
    print('所有图表生成完毕！')


if __name__ == '__main__':
    generate_all()
