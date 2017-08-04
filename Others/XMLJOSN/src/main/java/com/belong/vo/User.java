package com.belong.vo;

import java.io.Serializable;

public class User implements Serializable{
	private String id;
	public User(String id, String name, int age, Address address) {
		super();
		this.id = id;
		this.name = name;
		this.age = age;
		this.address = address;
	}
	private String name;
	private int age;
	private Address address;
	public String getId() {
		return id;
	}
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public Address getAddress() {
		return address;
	}
	public void setAddress(Address address) {
		this.address = address;
	}
}
