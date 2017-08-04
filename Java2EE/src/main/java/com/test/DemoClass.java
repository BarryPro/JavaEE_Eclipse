package com.test;

public class DemoClass implements InterD{

	static InterD df = new DemoClass();
	public static void main(String[] args) {
		df.funTest();
	}

	public void funTest(){
		System.out.println("belong");
	}
}

interface InterD{
	void funTest();
}