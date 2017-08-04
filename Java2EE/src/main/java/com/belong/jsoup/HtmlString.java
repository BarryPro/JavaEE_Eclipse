package com.belong.jsoup;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import java.io.File;
import java.io.IOException;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/4/26.
 */
public class HtmlString {
    public static void main(String[] args) {
        String html = "<html><head><title>First parse</title></head>"
                + "<body><p>Parsed HTML into a doc.</p></body></html>";
        String url = null;

        //url = HtmlString.class.getClassLoader().getResource("file/soup.txt").getPath();

        //System.out.println(url);
        File file = new File("D:\\logs\\tmp.html");
        try {
            Document doc4 = Jsoup.parse(file,"utf-8");
            System.out.println(doc4);
        } catch (IOException e) {
            e.printStackTrace();
        }
        Document doc = Jsoup.parse(html);
        Document doc3 = Jsoup.parseBodyFragment(html);
        //System.out.println(doc3);
        Elements elements = doc.getAllElements();
        try {
            Document doc2 = Jsoup.connect("http://example.com")
                    .data("query", "Java")
                    .userAgent("Mozilla")
                    .cookie("auth", "token")
                    .timeout(3000)
                    .post();
            //System.out.println(doc2);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
