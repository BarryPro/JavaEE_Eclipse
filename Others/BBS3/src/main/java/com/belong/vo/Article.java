package com.belong.vo;

import java.io.Serializable;

public class Article implements Serializable {
	private int id;
	private int rootid;
	private String title;
	private String content;
	private BBSUser user;
	private String dateTime;
	public String getDateTime() {
		return dateTime;
	}
	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
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
	public BBSUser getUser() {
		return user;
	}
	public void setUser(BBSUser user) {
		this.user = user;
	}
}
