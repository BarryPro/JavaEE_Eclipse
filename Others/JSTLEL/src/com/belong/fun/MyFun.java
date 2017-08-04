package com.belong.fun;

public class MyFun {
	public static String converse(String txt){
		return new StringBuffer(txt).reverse().toString();
	}
	public static int count(String txt){
		return txt.length();
	}
}

