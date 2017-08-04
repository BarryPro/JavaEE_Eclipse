package com.belong.demo;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.RandomAccessFile;

/**
 * @Author: belong.
 * @Description:
 * @Date: 2017/4/19.
 */
public class Demo5 {
    public static void main(String[] args) {
        try {
            FileInputStream fileInputStream = new FileInputStream("D:\\logs\\tmp.txt");
            RandomAccessFile file = new RandomAccessFile("D:\\logs\\tmp.txt","rw");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

    }
}
