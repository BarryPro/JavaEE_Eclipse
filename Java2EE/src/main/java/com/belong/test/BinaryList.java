package com.belong.test;

import static java.lang.Math.pow;

/**
 * Created by belong on 2016/12/4.
 */
public class BinaryList {

    public static void main(String[] args) {
        new BinaryList().show(40);
    }

    public void show(int n){
        for(int i = 0 ; i < n ;i++){
            System.out.println("2pow("+i+"):"+pow(2,i));
        }
    }
}
