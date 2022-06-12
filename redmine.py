import pandas as __pd__
import numpy as __np__
import os as __os__
import platform as __platform__
from datetime import datetime as __datetime__
from dateutil.relativedelta import relativedelta

CHOOSE_SET = {"1"}
status = "状态"
create_time = "创建于"
update_time = "更新于"
finish_status = ["已关闭", "暂停", "已拒绝"]
CURRENT_DIRECTORY_NAME = __os__.path.dirname(__file__)
DOT = "."
SUFFIX = "xlsx"
DEFAULT_NAME = "Redmine"
DEFAULT_EXCEL_NAME = "%s%s%s" % (DEFAULT_NAME, DOT, SUFFIX)

FMT_TIM = "%Y-%m"
CURRENT_RATE = 100
WINDOWS = "Windows"
LINUX = "Linux"
UNIX_SEPARATOR = "/"
WINDOWS_SEPARATOR = "\\"
DEFAULT_EXCEL_PATH = __os__.path.join(CURRENT_DIRECTORY_NAME, DEFAULT_EXCEL_NAME)
excel_path = DEFAULT_EXCEL_PATH
default_sheet_name = "Sheet1"

def initialize_variable():
    global excel_path
    global default_sheet_name
    in_excel_path = input("请输入Redmine Excel路径[默认 %s]: " % DEFAULT_EXCEL_PATH)
    in_default_sheet_name = input("请输入需要解析的Sheet名称[默认 Sheet1]: ")
    if in_excel_path != "":
        excel_path = in_excel_path
    elif in_default_sheet_name != "":
        default_sheet_name = in_default_sheet_name


"""输入Excel路径"""
def type_path():
    retval = __pd__.DataFrame(__pd__.read_excel(excel_path, sheet_name=default_sheet_name, index_col=0))
    return retval


"""菜单"""
def start_menu():
    while True:
        print("1. redmine工单解析")
        choice = input("请选择: ")
        if choice != "1":
            continue
        return choice


"""获取工单创建时间"""
def crt_tim(DataFrame):
    df = DataFrame[create_time]
    return df


"""获取工单状态"""
def redmine_state(DateFrame):
    df = DateFrame[status]
    return df


"""获取工单创建月份"""
def crt_tim_of_month(DataFrame):
    df = crt_tim(DataFrame).dt.strftime(FMT_TIM)
    return df


"""获取统计月份, 返回Set"""
def statistics_month_of_crt(DataFrame):
    s = set()
    for m in crt_tim_of_month(DataFrame):
        s.add(m)
    return sorted(s)


"""获取完成状态的工单"""
def done_state(DateFrame):
    df = redmine_state(DateFrame).isin(finish_status)
    return df



"""获取总记录数"""
def total(DataFrame):
    t = len(DataFrame)
    return t


"""获取每月工单数量, 返回数据字典"""
def toto_works(DataFrame):
    d = {}
    for m in statistics_month_of_crt(DataFrame):
        k = m
        v = len(DataFrame[crt_tim_of_month(DataFrame) == m])
        d.update({k: v})
    return d


"""获取更新于(交付时间)"""
def updt_tim(DataFrame):
    df = DataFrame[update_time]
    return df


"""获取工单交付月份"""
def updt_tim_of_month(DataFrame):
    df = updt_tim(DataFrame).dt.strftime(FMT_TIM)
    return df


"""获取交付月份, 返回Set"""
def statistics_month_of_updt(DataFrame):
    s = set()
    for m in updt_tim_of_month(DataFrame):
        s.add(m)
    return sorted(s)


"""获取下个月的时间的格式化字符串"""
def next_month(dtim):
    ptime = __datetime__.strptime(dtim, FMT_TIM)
    nxt_month = ptime + relativedelta(months=1)
    stime = __datetime__.strftime(nxt_month, FMT_TIM)
    return stime


"""获取创建时间的最大日期"""
def max_month_of_crt(DataFrame):
    mlist = statistics_month_of_crt(DataFrame)
    pos = len(mlist) - 1
    mm = mlist[pos]
    return mm


"""获取更新时间的最大日期"""
def max_month_of_updt(DataFrame):
    mlist = statistics_month_of_updt(DataFrame)
    pos = len(mlist) - 1
    mm = mlist[pos]
    return mm



"""获取当月创建,当月完成的工单数量, 返回数据字典"""
def perfect_works(DataFrame):
    d = {}
    for m in statistics_month_of_crt(DataFrame):
        k = m
        # 完成状态为 finish_status 并且 创建日期为当月 and 完成日期为当月的工单数量
        v = len(DataFrame[(done_state(DataFrame)) & (updt_tim_of_month(DataFrame) == m) & (crt_tim_of_month(DataFrame) == m)])
        d.update({k: v})
    return d



"""创建时间为当月, 完成时间在当月和其他月的数量"""
def transform_works(DataFrame):
    direct = {}
    for idx in range(0, len(statistics_month_of_crt(DataFrame))):
        interval_direct = {}
        n = statistics_month_of_crt(DataFrame)[idx]
        if __datetime__.strptime(n, FMT_TIM) > __datetime__.strptime(max_month_of_crt(DataFrame), FMT_TIM):
            break
        nm = next_month(statistics_month_of_crt(DataFrame)[idx])
        # nm = statistics_month_of_crt(DataFrame)[idx]
        for idxs in range(0, len(statistics_month_of_updt(DataFrame))):
            ink = nm
            inv = len(DataFrame[(done_state(DataFrame)) & (updt_tim_of_month(DataFrame) == nm) & (
                        crt_tim_of_month(DataFrame) == n)])
            interval_direct.update({ink: inv})
            nm = next_month(nm)
        # print(interval_direct)
        k = n
        v = interval_direct
        direct.update({k: v})
    return direct


""""""
def finish_works(df, DataFrame):
    d = {}
    for m in statistics_month_of_crt(DataFrame):
        k = m
        v = df[m].sum()
        d.update({k: v})
    return d


def running_works(toto_work, finish_work):
    d = {}
    for tk, tv in toto_work.items():
        k = tk
        for fk, fv in finish_work.items():
            if tk != fk:
                continue
            # print("tv: %s, fv: %s" % (tv, fv))
            v = int(tv) - int(fv)
        d.update({k: v})
    return d


def perfect_wk_rate(perfect_work, toto_work):
    d = {}
    for tk, tv in toto_work.items():
        k = tk
        for ink, inv in perfect_work.items():
            if tk != ink:
                continue
            v = str("%.2f%%" % (int(inv) / int(tv) * CURRENT_RATE))
        d.update({k: v})
    return d


def toto_wk_rate(finish_work, toto_work):
    d = {}
    for tk, tv in toto_work.items():
        k = tk
        for ink, inv in finish_work.items():
            if tk != ink:
                continue
            v = str("%.2f%%" % (int(inv) / int(tv) * CURRENT_RATE))
        d.update({k: v})
    return d


def building_struct(DataFrame):
    pft_wk = perfect_works(DataFrame)
    trans_wk = transform_works(DataFrame)
    for k, v in trans_wk.items():
        # print("%s : %s" % (k, v))
        for ink, inv in pft_wk.items():
            if k != ink:
                continue
            v.update({ink: inv})
    df = __pd__.DataFrame(trans_wk, index=statistics_month_of_updt(DataFrame))
    df.fillna(0, inplace=True)
    # df.convert_dtypes()
    df = df.astype(dtype=__np__.int64)
    f_work = finish_works(df, DataFrame)
    t_work = toto_works(DataFrame)
    r_work = running_works(t_work, f_work)
    df.loc["迄今已关闭"] = f_work
    df.loc["迄今未关闭"] = r_work
    df.loc["总计"] = t_work
    df.loc["月交付比例"] = perfect_wk_rate(pft_wk, t_work)
    # df.loc["实际完成比例"] = t_work
    df.loc["总体完成比例"] = toto_wk_rate(f_work, t_work)
    df.index.name = "交付月份\创建月份"
    return df


def check_os():
    os = __platform__.system()
    return os



def get_filename(path):
    word_arr = []
    if WINDOWS == check_os():
        word_arr = path.split(WINDOWS_SEPARATOR)

    if LINUX == check_os():
        word_arr = path.split(UNIX_SEPARATOR)

    idx = len(word_arr) - 1
    filename = word_arr[idx].split(DOT)[0]
    return filename


def renew_excel(DataFrame):
    f_name = "%s_renew" % get_filename(excel_path)
    dir_name = __os__.path.dirname(excel_path)
    opath = __os__.path.join(dir_name, "%s%s%s" % (f_name, DOT, SUFFIX))
    DataFrame.to_excel(opath)
    return opath


def resolve_to_file(DataFrame):
    f_name = "%s_resolve" % get_filename(excel_path)
    dir_name = __os__.path.dirname(excel_path)
    opath = __os__.path.join(dir_name, "%s%s%s" % (f_name, DOT, SUFFIX))
    DataFrame.to_excel(opath)
    return opath


"""Redmine解析"""
def redmine_resolve():
    initialize_variable()
    DataFrame = type_path()
    DataFrame = building_struct(DataFrame)
    opath = resolve_to_file(DataFrame)
    print("解析完成, 输入文件路径为: %s" % opath)


if __name__ == '__main__':
    choose = start_menu()
    if choose.strip() == "1":
        redmine_resolve()
