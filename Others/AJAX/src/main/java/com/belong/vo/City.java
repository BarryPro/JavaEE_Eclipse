package com.belong.vo;

import java.io.Serializable;

public class City implements Serializable {
	private String no;//城市编号
	private String name;//城市的名字
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public City(String no, String name) {
		super();
		this.no = no;
		this.name = name;
	}
	
}
