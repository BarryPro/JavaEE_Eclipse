package com.belong.designpattern.singlepattern;

/**
 * Created by belong on 2016/12/11.
 */
public class SinglePattern3 {
    private static class SingletonHolder {
        private static final SinglePattern3 sp = new SinglePattern3();
    }
    private SinglePattern3() {

    }

    public static SinglePattern3 getInstance(){
        return SingletonHolder.sp;
    }
}
