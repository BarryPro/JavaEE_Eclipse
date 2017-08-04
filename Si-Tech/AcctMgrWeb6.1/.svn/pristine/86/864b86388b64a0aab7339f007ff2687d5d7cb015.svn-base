package com.sitech.acctmgr.atom.domains.detail;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.List;

/**
 * @author 外部渠道详单查询
 */
public class ChannelDetail implements Serializable {
    @JSONField(name = "COUNT")
    @ParamDesc(path = "COUNT", len = "", cons = ConsType.CT001, type = "int", desc = "详单记录数", memo = "")
    private int count;

    @JSONField(name = "QUERY_TYPE")
    @ParamDesc(path = "QUERY_TYPE", len = "", cons = ConsType.CT001, type = "string", desc = "查询类型", memo = "")
    private String queryType;

    @JSONField(name = "GLOBAL_LIST")
    @ParamDesc(path = "GLOBAL_LIST", len = "", cons = ConsType.CT001, type = "complex", desc = "展示全局信息", memo = "List<String>")
    private List<String> globalList; /*定义List ，是因为共享4G流量也要展示在头部*/

    @JSONField(name = "TITLE_INFO")
    @ParamDesc(path = "TITLE_INFO", len = "", cons = ConsType.CT001, type = "string", desc = "详单标题", memo = "")
    private String titleInfo;

    @JSONField(name = "HEAD_LIST")
    @ParamDesc(path = "HEAD_LIST", len = "", cons = ConsType.CT001, type = "complex", desc = "详单头信息列表", memo = "List<String>")
    private List<String> headList;

    @JSONField(serialize = false)
    @ParamDesc(path="HEAD_COL_NUM", len= "", cons = ConsType.CT001, type="int", desc="详单10大类展示时，title上面展示表格的列数", memo="")
    private int headColNum;

    @JSONField(name = "DETAIL_LINES")
    @ParamDesc(path = "DETAIL_LINES", len = "", cons = ConsType.CT001, type = "complex", desc = "详单行", memo = "List<String>")
    private List<String> detailLines;

    @JSONField(name = "FOOT_INFO")
    @ParamDesc(path = "FOOT_INFO", len = "", cons = ConsType.CT001, type = "string", desc = "详单foot信息", memo = "存放详单合计")
    private String footInfo;

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getQueryType() {
        return queryType;
    }

    public void setQueryType(String queryType) {
        this.queryType = queryType;
    }

    public List<String> getGlobalList() {
        return globalList;
    }

    public void setGlobalList(List<String> globalList) {
        this.globalList = globalList;
    }

    public String getTitleInfo() {
        return titleInfo;
    }

    public void setTitleInfo(String titleInfo) {
        this.titleInfo = titleInfo;
    }

    public List<String> getHeadList() {
        return headList;
    }

    public void setHeadList(List<String> headList) {
        this.headList = headList;
    }

    public List<String> getDetailLines() {
        return detailLines;
    }

    public void setDetailLines(List<String> detailLines) {
        this.detailLines = detailLines;
    }

    public String getFootInfo() {
        return footInfo;
    }

    public void setFootInfo(String footInfo) {
        this.footInfo = footInfo;
    }

    public int getHeadColNum() {
        return headColNum;
    }

    public void setHeadColNum(int headColNum) {
        this.headColNum = headColNum;
    }

    @Override
    public String toString() {
        return "ChannelDetail{" +
                "count=" + count +
                ", queryType='" + queryType + '\'' +
                ", globalList=" + globalList +
                ", titleInfo='" + titleInfo + '\'' +
                ", headList=" + headList +
                ", detailLines=" + detailLines +
                ", footInfo='" + footInfo + '\'' +
                '}';
    }
}
