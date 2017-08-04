package com.belong.string;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by belong on 2017/3/11.
 */
public class ValueReg {
    public static void main(String[] args) {
        keyValue();
    }

    private static void keyValue() {
        Map<String,String> map = new HashMap();
        String [] list = new String[2];
        URL path = SQL.class.getClassLoader().getResource("key-value.txt");
        URL pathList = SQL.class.getClassLoader().getResource("list.txt");
        try {
            BufferedReader reader =
                    new BufferedReader(new InputStreamReader(new FileInputStream(path.getPath())));
            BufferedReader readerList =
                    new BufferedReader(new InputStreamReader(new FileInputStream(pathList.getPath())));
            String text = "";
            while ((text = (reader.readLine())) != null){
                list = (text.substring(0,text.length()-4).replaceAll("[】]"," ").split("【"));
                if(list.length>1){
                    map.put(list[0],list[1]);
                }
            }
            //while ((text = (reader.readLine())) != null){
            //
            //    list = (text.replaceAll("[【】]"," ").split(" "));
            //    map.put(list[0],list[1]);
            //}
            List<String> stringList = new ArrayList();
            while ((text = (readerList.readLine())) != null){
                stringList.add(text);
            }
            for(String str: stringList){
                if(map.get(str) != null){
                    System.out.println(map.get(str));
                } else {
                    System.out.println(" ");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
