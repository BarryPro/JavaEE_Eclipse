package com.belong.vo;

import java.io.Serializable;

public class Article implements Serializable {
	private int id;
	private int rootid;
	private String title;
	private String content;
	private String datetime;
	private BBSUser user;
	public BBSUser getUser() {
		return user;
	}
	public void setUser(BBSUser user) {
		this.user = user;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRootid() {
		return rootid;
	}
	public void setRootid(int rootid) {
		this.rootid = rootid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String dateTime) {
		this.datetime = dateTime;
	}

}
