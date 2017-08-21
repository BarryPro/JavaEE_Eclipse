package com.belong.io;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.Random;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/7/16.
 */
public class WriteSample {
    public static void main(String[] args) {
        new WriteSample().readNum();
    }

    public void readNum()  {
        FileOutputStream fileOutputStream = null;
        BufferedWriter writer = null;
        URL path = WriteSample.class.getClassLoader().getResource("file/num.txt");
        try {
            fileOutputStream = new FileOutputStream(path.getPath());
            writer = new BufferedWriter(new OutputStreamWriter(fileOutputStream));
            Random random = new Random();
            for (int i = 0; i < 1000000; i++) {
                writer.write(String.valueOf(random.nextInt(20000)));
                writer.write("\r\n");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(writer!=null){
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if(fileOutputStream!=null){
                try {
                    fileOutputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
