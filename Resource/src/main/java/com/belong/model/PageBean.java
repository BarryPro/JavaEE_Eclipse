package com.belong.model;

import java.util.List;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/5/21.
 */
public class PageBean {
    private Integer total_row;
    private Integer total_page;
    private List<VideoUrlConfig> data;

    public Integer getTotal_row() {
        return total_row;
    }

    public void setTotal_row(Integer total_row) {
        this.total_row = total_row;
    }

    public Integer getTotal_page() {
        return total_page;
    }

    public void setTotal_page(Integer total_page) {
        this.total_page = total_page;
    }

    public List<VideoUrlConfig> getData() {
        return data;
    }

    public void setData(List<VideoUrlConfig> data) {
        this.data = data;
    }


}
