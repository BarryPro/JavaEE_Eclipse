package com.belong.vo;

import java.io.Serializable;
/*
 * 用户
 */
public class BBSUser implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;//id号
	private String username;//用户名
	private String password;//用户密码
	private int pagenum;//帖子的默认行数
	private String path;//存放图片的路径（服务器tomcat中存放的路径）
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getPagenum() {
		return pagenum;
	}
	public void setPagenum(int pagenum) {
		this.pagenum = pagenum;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}	
}
