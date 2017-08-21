package com.belong.net.jsoup;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.File;
import java.io.IOException;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/4/26.
 */
public class Tranveral {
    public static void main(String[] args) {
        File file = new File("D:\\logs\\tmp.html");
        try {
            Document doc = Jsoup.parse(file,"utf-8");
            Elements elements = doc.getAllElements();
            // 每一层都是逐级递减（由外层到里层）
            for(Element element:elements){
                System.out.println(element.getElementsByTag("tr"));
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
