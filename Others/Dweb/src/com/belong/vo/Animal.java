package com.belong.vo;//visual object

import java.io.Serializable;

/*
 * 实体bean（正常封装不带主函数的叫实体bean，带主函数的叫业务bean）
 */
public class Animal implements Serializable{
	private String name;
	private int age;
	public void setName(String name){
		this.name = name;
	}
	public String getName(){
		return this.name;
	}
	public void setAge(int age){
		this.age = age;
	}
	public int getAge(){
		return this.age;
	}
}
