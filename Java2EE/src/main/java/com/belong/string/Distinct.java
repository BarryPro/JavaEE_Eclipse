package com.belong.string;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.*;

/**
 * src.txt:是内容少的
 * out.txt:是内容多的
 * Created by belong on 2017/3/11.
 */
public class Distinct {
    public static void main(String[] args) {
        ditinct();
    }

    public static void ditinct(){
        URL pathSrc = SQL.class.getClassLoader().getResource("file/src.txt");
        URL pathOut = SQL.class.getClassLoader().getResource("file/out.txt");
        Set<String> src = null;
        //List<String> out = null;
        try {
            BufferedReader readerSrc =
                    new BufferedReader(new InputStreamReader(new FileInputStream(pathSrc.getPath())));
            BufferedReader readerOut =
                    new BufferedReader(new InputStreamReader(new FileInputStream(pathOut.getPath())));
            String text = "";
            src = new HashSet<>();
            //out = new ArrayList();
            while ((text = (readerSrc.readLine())) != null){
                src.add(text.replaceAll(" ","").replaceAll("onFileCreate:",""));
            }
            //while ((text = (readerOut.readLine())) != null){
            //    out.add(text);
            //}
            //int count = 0;
            //for (int i = 0; i < src.size(); i++) {
            //    for(int j = 0; j < out.size(); j++){
            //        if(src.get(i).equals(out.get(j))){
            //            System.out.println((count++)+src.remove(i));
            //        }
            //    }
            //}
            List<String> out = new ArrayList<>();
            out.addAll(src);
            Collections.sort(out);
            int count = 0;
            for(String str:out){
                System.out.println(++count+"  "+str);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
