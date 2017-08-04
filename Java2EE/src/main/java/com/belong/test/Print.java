package com.belong.test;

import java.io.File;
import java.util.HashMap;
import java.util.Hashtable;

/**
 * Created by belong on 2016/12/10.
 */
public class Print {
    public static void main(String[] args) {
        System.out.printf("%12.4e\n",1596.16564556);
        File file = new File("BinaryList.java");
        System.out.println(file.lastModified());
        file.setLastModified(123);
        Hashtable hashtable = new Hashtable();
        HashMap map = new HashMap();
    }
}
