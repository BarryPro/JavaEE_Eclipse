package com.belong.vo;//visual object

import java.io.Serializable;

/*
 * ʵ��bean��������װ�����������Ľ�ʵ��bean�����������Ľ�ҵ��bean��
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
