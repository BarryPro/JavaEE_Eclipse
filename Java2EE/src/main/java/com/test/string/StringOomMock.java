package com.test.string;

import java.util.ArrayList;
import java.util.List;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/14.
 */
public class StringOomMock {
    static String  base = "string";
    public static void main(String[] args) {
        List<String> list = new ArrayList<String>();
        for (int i=0;i< Integer.MAX_VALUE;i++){
            String str = base + base;
            base = str;
            list.add(str.intern());
        }
    }
}
