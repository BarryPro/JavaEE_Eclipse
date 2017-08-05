package com.belong.model;

import java.util.Date;

public class ClassifyConfig {
    private String typeHref;

    private String typeName;

    private Date opTime;

    private String pager;

    public String getTypeHref() {
        return typeHref;
    }

    public void setTypeHref(String typeHref) {
        this.typeHref = typeHref == null ? null : typeHref.trim();
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