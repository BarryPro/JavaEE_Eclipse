package com.belong.string;

import java.io.*;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 用于转换sql脚本的表空间替换实现类
 * 用法：
 * 将要替换的表空间到src下的cmd.txt中一句是一行分开
 * 将要替换的源字符创放到src下的sql.txt中
 * outSQL.txt是想要的输出文件
 * Created by belong on 2017/3/10.
 */
public class SQL {

    public static void main(String[] args) {
        cmd();
    }

    public static List<String> cmd(){
        List<String> cmd = new ArrayList();
        URL path = SQL.class.getClassLoader().getResource("file/cmd.txt");
        try {
            BufferedReader reader =
                    new BufferedReader(new InputStreamReader(new FileInputStream(path.getPath())));
            String text = "";
            String reg = ".*DBACCADM\\.(.*)";
            Pattern pattern = Pattern.compile(reg);
            while ((text = (reader.readLine())) != null){
                Matcher matcher = pattern.matcher(text);
                if(matcher.find()){
                    System.out.println(matcher.group(1));
                }
                //cmd.add(text);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmd;
    }

    public static void replace(List<String> cmd){
        URL path = SQL.class.getClassLoader().getResource("sql.txt");
        try {
            //  用于存放文件
            String text = "";
            //  存放操作的文件
            List<String> tmp_Text = new ArrayList();
            //  得到文件输入流
            BufferedReader reader =
                    new BufferedReader(new InputStreamReader(new FileInputStream(path.getPath())));
            BufferedWriter writer =
                    new BufferedWriter(new OutputStreamWriter(new FileOutputStream("outSQL.txt")));
            while ((text = (reader.readLine())) != null){
                tmp_Text.add(text);
            }
            for(int i = 0;i<tmp_Text.size();i++){
                text = tmp_Text.get(i).replace(cmd.get(0),cmd.get(1));
                writer.write(text+"\n");
                System.out.println(text);
            }
            writer.flush();
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
