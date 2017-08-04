package com.belong.designpattern.singlepattern;

/**
 * Created by belong on 2016/12/11.
 */
public class SinglePattern4 {
    private volatile static SinglePattern4 sp;
    private SinglePattern4() {

    }

    public static SinglePattern4 getInstance() {
        if(sp == null){
            synchronized (SinglePattern4.class) {
                sp = new SinglePattern4();
            }
        }
        return sp;
    }
}
