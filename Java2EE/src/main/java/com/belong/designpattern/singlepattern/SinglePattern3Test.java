package com.belong.designpattern.singlepattern;

/**
 * Created by belong on 2016/12/11.
 */
public class SinglePattern3Test {
    public static void main(String[] args) {
        SinglePattern3 singlePattern1 = SinglePattern3.getInstance();
        SinglePattern3 singlePattern2 = SinglePattern3.getInstance();
        System.out.println(singlePattern1==singlePattern2);
    }
}
