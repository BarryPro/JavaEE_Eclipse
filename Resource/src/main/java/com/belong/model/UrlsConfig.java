package com.belong.model;

public class UrlsConfig {
    private String url;

    private String typrName;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getTyprName() {
        return typrName;
    }

    public void setTyprName(String typrName) {
        this.typrName = typrName == null ? null : typrName.trim();
    }
}