package com.belong.model;

import java.util.Date;

public class ClassifyDetailConfig {
    private String typeDtlhref;

    private String typeDtlname;

    private String typeName;

    private Date opTime;

    private String pager;

    public String getTypeDtlhref() {
        return typeDtlhref;
    }

    public void setTypeDtlhref(String typeDtlhref) {
        this.typeDtlhref = typeDtlhref == null ? null : typeDtlhref.trim();
    }

    public String getTypeDtlname() {
        return typeDtlname;
    }

    public void setTypeDtlname(String typeDtlname) {
        this.typeDtlname = typeDtlname == null ? null : typeDtlname.trim();
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName == null ? null : typeName.trim();
    }

    public Date getOpTime() {
        return opTime;
    }

    public void setOpTime(Date opTime) {
        this.opTime = opTime;
    }

    public String getPager() {
        return pager;
    }

    public void setPager(String pager) {
        this.pager = pager == null ? null : pager.trim();
    }
}