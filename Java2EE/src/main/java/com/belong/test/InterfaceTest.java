package com.belong.test;

/**
 * @Description: <p>接口中可以有实体方法但是必须是static，并且属于整个接口</p>
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
