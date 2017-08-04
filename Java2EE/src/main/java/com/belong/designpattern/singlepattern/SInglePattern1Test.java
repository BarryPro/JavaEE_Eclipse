package com.belong.designpattern.singlepattern;

/**
 * Created by belong on 2016/12/11.
 */
public class SInglePattern1Test {
    public static void main(String[] args) {
        SinglePattern1 singlePattern1 = SinglePattern1.getInstance();
        SinglePattern1 singlePattern2 = SinglePattern1.getInstance();
        System.out.println(singlePattern1==singlePattern2);
    }
}
