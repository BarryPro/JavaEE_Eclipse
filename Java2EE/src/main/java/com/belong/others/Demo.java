package com.belong.others;

/**
 * Created by belong on 2017/4/5.
 */
public class Demo {
    private int a = 1;
    protected void testMethod(){}
}

class Main {
    public static void main(String[] args) {
        Demo demo = new Demo();
        Demo demo1 = new Demo();
        System.out.println(demo.hashCode());
        System.out.println(demo1.hashCode());
        String str1 = "123";
        String str2 = new String("123");
        System.out.println(str1.equals(str2));
        System.out.println(str1.hashCode());
        System.out.println(str2.hashCode());
        System.out.println(str1 == str2);
    }
}
