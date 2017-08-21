package com.belong.jvm;

import java.util.ArrayList;
import java.util.List;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/9.
 */
public class GenericTypes {

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
