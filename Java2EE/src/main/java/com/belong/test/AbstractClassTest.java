package com.belong.test;

/**
 * Created by belong on 2016/12/7.
 */
public class AbstractClassTest {
}

interface IA extends IB {
    int a = 0;
    void fun();
}

interface IB {

}

interface IC extends IB,IA{

}

 abstract class Students{
    private String name;
    public void fun(){

    }
    public abstract void fun2();
}


