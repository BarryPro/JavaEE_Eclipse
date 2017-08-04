package com.belong.string;

import java.io.*;
import java.net.URL;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by belong on 2016/12/19.
 */
public class Abbr {
    public static void main(String[] args) {
        new Abbr().run();
    }

    public void run(){
        try {
            InputStream is = null;
            InputStream is2 = null;
            URL path = Abbr.class.getClassLoader().getResource("abbr.txt");
            URL path2 = Abbr.class.getClassLoader().getResource("chinaAbbr.txt");
            is = new FileInputStream(path.getPath());
            is2 = new FileInputStream(path2.getPath());
            BufferedReader reader = new BufferedReader(new InputStreamReader(is));
            BufferedReader reader2 = new BufferedReader(new InputStreamReader(is2));
            String text = null;
            String text2 = null;
            int index = 0;
            int index2 = 0;
            String [] word = new String[75];
            String [] word2 = new String[200];
            String out[] = new String [75];
            while((text = reader.readLine()) != null){
                //System.out.println(text);//text就是一行的数据
                word[index++] = text;
            }
            while((text = reader2.readLine()) != null){
                word2[index2++] = text;
            }

            String [] out2 = new String [75];
            String [] result = null;
            StringBuffer sb = new StringBuffer();
            int j = 0;
            for(int i = 0;i<word.length;i++){
                out[i] = word[i].replaceAll("[\\u4e00-\\u9fa5]", "");
                out2[i] = out[i].substring(5).
                        replaceAll("[\\:\\|\\:\\|\\,\\|\\,]+", "").replaceFirst("[\\w]+", "").replaceAll("\\W", " ");
                sb.append(out2[i]);
            }
            result = sb.toString().split(" ");
            int num = 0;
            for (int i = 0;i<26;i++) {
                String L = (char)(i+65)+"";
                Set<String> set = new HashSet<String>();
                for(String s:result){
                    if(s.startsWith(L)){
                        set.add(s);
                    }
                }
                int m = 0;
                if(!set.isEmpty()){
                    System.out.println(L+": 表示的是");
                }
                for(String s:set){
                    //System.out.println("("+(++m)+")"+s+": ");
                    System.out.println("("+(++m)+")"+s+": "+word2[num++]);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
