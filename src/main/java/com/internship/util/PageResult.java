package com.internship.util;

import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * 分页结果封装类
 */
public class PageResult {

    private long total;
    private int pageNum;
    private int pageSize;
    private int pages;
    private List<?> list;

    public PageResult() {
    }

    /**
     * 从PageHelper的PageInfo中构造分页结果
     *
     * @param pageInfo PageHelper的PageInfo对象
     */
    public PageResult(PageInfo<?> pageInfo) {
        this.total = pageInfo.getTotal();
        this.pageNum = pageInfo.getPageNum();
        this.pageSize = pageInfo.getPageSize();
        this.pages = pageInfo.getPages();
        this.list = pageInfo.getList();
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPages() {
        return pages;
    }

    public void setPages(int pages) {
        this.pages = pages;
    }

    public List<?> getList() {
        return list;
    }

    public void setList(List<?> list) {
        this.list = list;
    }
}
