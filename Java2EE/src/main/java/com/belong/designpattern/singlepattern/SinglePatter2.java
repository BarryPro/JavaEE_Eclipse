package com.belong.designpattern.singlepattern;

/**
 * Created by belong on 2016/12/11.
 */
public class SinglePatter2 {
    private static SinglePatter2 sp;
    private SinglePatter2(){

    }

    public static synchronized SinglePatter2 getInstance(){//加个同步锁
        if(sp == null){
            sp = new SinglePatter2();
        }
        return sp;
    }
}
