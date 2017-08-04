package com.belong.test;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/13.
 */
public class ConstructTest {
    public static void main(String[] args) {

    }
}

class Base{
    Base(String string){
        System.out.println(string);
    }
}

class Son extends Base{

    Son(String string) {
        super(string);
    }
}
