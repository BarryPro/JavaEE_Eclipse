package com.belong.demo;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Author: belong.
 * @Description: 爬取网站信息的爬虫
 * @Date: 2017/4/19.
 */
public class Demo7 {
    public static void main(String[] args) {
        BufferedReader bufferedReader = null;
        URL url = Demo7.class.getClassLoader().getResource("file/urls.txt");
        try {
            bufferedReader = new BufferedReader(new InputStreamReader(new FileInputStream(url.getPath())));
            String buffer = "";
            while((buffer = bufferedReader.readLine()) != null){
                //System.out.println(buffer);
                String regex = "[http|https].*163.*";
                Pattern pattern = Pattern.compile(regex);
                Matcher matcher = pattern.matcher(buffer);
                if(matcher.find()){
                    System.out.println(matcher.group(0));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}
