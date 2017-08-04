package com.test.quick;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/16.
 */
public class ReadSample {
    public static void main(String[] args) {
        new ReadSample().readNum();
    }

    public ArrayList<Integer> readNum() {
        ArrayList<Integer> list = new ArrayList<>();
        FileInputStream fileInputStream = null;
        BufferedReader reader = null;
        URL path = ReadSample.class.getClassLoader().getResource("file/num.txt");
        try {
            fileInputStream = new FileInputStream(path.getPath());
            reader = new BufferedReader(new InputStreamReader(fileInputStream));
            String buffer = null;
            while ((buffer = reader.readLine()) != null) {
                list.add(Integer.parseInt(buffer));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (fileInputStream != null) {
                try {
                    fileInputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }
}
