package com.test;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/15.
 */
public interface InterfaceTest {
    void fun();
    void fun2();
    static void fun3(){
        System.out.println("hello");
    }

    static void main(String[] args) {
        InterfaceTest.fun3();
    }
}
