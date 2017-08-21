package com.belong.io;

import java.io.*;
import java.net.URL;
import java.util.Arrays;

/**
 * Created by belong on 2016/12/11.
 */
public class PropertiesTest {
    public static void main(String[] args) {
        try {
            InputStream is =
                    new FileInputStream("E:\\Package\\Wiznote_src\\Data\\belong.belong@outlook.com\\My Notes\\Others\\IT_English.ziw");
            URL url = PropertiesTest.class.getClassLoader().getResource("wiz.txt");

            InputStream inputStream = new FileInputStream(url.getPath());
            BufferedInputStream bis = new BufferedInputStream(inputStream);
            BufferedOutputStream bos =
                    new BufferedOutputStream(new FileOutputStream("D:\\outwiz.txt"));
            byte[] buffer = new byte[3048];
            int n = -1;
            String [] data = null;
            String regex = "[\\d\\.]*";
            String list [] = null;
            try {
                while((n = bis.read(buffer))!=-1){
                    String str = new String(buffer);
                    data = str.split("\\r\\n");
                }
                list = new String [data.length];
                int index = 0;
                for(String s:data){
                    list[index++] = s.replaceAll(regex,"").toLowerCase();
                }
                Arrays.sort(list);//排序
                for(int i = 0;i<list.length;i++){
                    System.out.println(list[i]);
                    String string = i+"."+list[i]+"\r\n";
                    bos.write(string.getBytes());
                    bos.flush();
                }



            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }
}
