package com.test;

public class Test {
    public static void main(String[] args) {
    	String ch = "ABC";
      	int a[] = new int [10];
    } 
    Test(){
    	System.out.println("belong");
    }
    static {
    	String ch2 = "123";
    }
    public interface ITests{

    }
}

class BaseClass{
    public static void test(){

    }
}

class SubClass extends BaseClass{
    public static void test(){}
}
