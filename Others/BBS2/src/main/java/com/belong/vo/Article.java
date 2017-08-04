package com.belong.vo;

public class Article {
	private int id;
	private int rootid;
	private String title;
	private String content;
	private String datetime;
	private BBSUser user;
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
	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}
	public BBSUser getUser() {
		return user;
	}
	public void setUser(BBSUser user) {
		this.user = user;
	}
	
}
