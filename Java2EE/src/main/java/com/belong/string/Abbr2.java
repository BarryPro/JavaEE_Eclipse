package com.belong.string;

import java.io.*;
import java.net.URL;
import java.util.Arrays;

/**
 * Created by belong on 2016/12/28.
 */
public class Abbr2 {
    public static void main(String[] args) {
        Abbr2 abbr2 = new Abbr2();
        abbr2.run1();
    }

    public void run1() {
        try {
            InputStream is = null;
            URL path = Abbr.class.getClassLoader().getResource("abbr.txt");
            is = new FileInputStream(path.getPath());
            BufferedReader reader = new BufferedReader(new InputStreamReader(is));
            String text = null;
            int index = 0;
            String[] word = new String[85];
            String out[] = new String[85];
            while ((text = reader.readLine()) != null) {
                //System.out.println(text);//text就是一行的数据
                word[index++] = text;
            }


            String [] out2 = new String [85];
            String [] result = null;
            StringBuffer sb = new StringBuffer();
            int j = 0;
            for(int i = 0;i<word.length;i++){
                out[i] = word[i];
                out2[i] = out[i].substring(5).
                        replaceAll("[\\:\\|\\:\\|\\,\\|\\，]+","");
                sb.append(out2[i]);
            }
            Arrays.sort(out2);
            int m = 0;
            for(String mm:out2){
                m++;
                System.out.println("("+m+")."+mm);
            }
            //result = sb.toString().split(" ");
            //int num = 0;
            //for (int i = 0;i<26;i++) {
            //    String L = (char)(i+65)+"";
            //    Set<String> set = new HashSet<String>();
            //    for(String s:result){
            //        if(s.startsWith(L)){
            //            set.add(s);
            //        }
            //    }
            //    int m = 0;
            //    if(!set.isEmpty()){
            //        System.out.println(L+": 表示的是");
            //    }
            //    for(String s:set){
            //        //System.out.println("("+(++m)+")"+s+": ");
            //        System.out.println("("+(++m)+")"+s+": "+word2[num++]);
            //    }
            //}
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
