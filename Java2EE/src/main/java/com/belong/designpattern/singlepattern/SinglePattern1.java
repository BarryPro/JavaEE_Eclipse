package com.belong.designpattern.singlepattern;

/**
 * Created by belong on 2016/12/11.
 */
public class SinglePattern1 {
    private static SinglePattern1 sp;

    private SinglePattern1(){

    }

    public static SinglePattern1 getInstance(){
        if(sp == null){
            sp = new SinglePattern1();
        }
        return sp;
    }

}
