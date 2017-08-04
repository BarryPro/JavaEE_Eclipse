package com.belong.test;

/**
 * Created by belong on 2016/12/15.
 */
public class Print3 {
    public static void main(String[] args) {
        Print3 print3 = new Print3();
        print3.fun_1();
    }
    public void fun_1(){
        class A{
            public void b(){
                fun_2();
            }
        }
        new A().b();
}

    public void fun_2(){
        System.out.println("ios");
    }
}
