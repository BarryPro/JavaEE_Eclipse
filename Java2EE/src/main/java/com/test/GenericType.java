package com.test;

import java.util.ArrayList;
import java.util.List;

class GenericTypes {

    //public static String method(List<String> list){
    //    System.out.println("String");
    //    return "";
    //}

    public static int method(List<Integer> list){
        System.out.println("Integer");
        return 1;
    }

    public static void main(String[] args) {
        //method(new ArrayList<String>());
        method(new ArrayList<Integer>());
    }
}
