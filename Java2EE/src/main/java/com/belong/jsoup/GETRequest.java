package com.belong.jsoup;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/5/12.
 */
public class GETRequest {
    public static void main(String[] args) {
        GETRequest pager = new GETRequest();
        String html = pager.getDecodeHtml();
        System.out.println(html);
        //System.out.println(pager.getVideoDetail(html));
        //System.out.println(html);
        //pager.getPager(html);
        //System.out.println(pager.getSpecificUrl("http://www.80s.tw/movie/list/d----","0"));
        //pager.addVideo(html);
        //System.out.println(pager.getHtml("http://t.dyxz.la/upload/img/201703/poster_20170317_3343682_b.jpg!list","utf-8"));
    }

    public String getEncodeUrl(String html) {
        Document document = Jsoup.parse(html);
        String EncodeUrl = "";
        Elements divs = document.getElementsByClass("url-output");
        if (!divs.isEmpty()) {
            Elements as = divs.get(0).getElementsByTag("a");
            if (!as.isEmpty()) {
                EncodeUrl = as.get(0).attr("href");
            }
        }
        return EncodeUrl;
    }

    public String getDecodeHtml() {
        String root = "http://news.uc.cn/";
        return getHtml(root, "utf-8");
    }

    /**
     * 不需要登录使用GET请求来获取网站数据
     * @param url
     * @param charset
     * @return
     */
    public String getHtml(String url, String charset) {
        String html = null;
        try {
            // 获取客户端,使用客户端来进行网络请求
            HttpClient httpClient = HttpClients.custom()
                    .setDefaultRequestConfig(RequestConfig.custom()
                            .setCookieSpec(CookieSpecs.STANDARD).build())
                    .build();
            // 声明请求方法(相当于request的get请求方式)
            HttpGet httpGet = new HttpGet(url);
            // 返回请求的响应
            HttpResponse response = httpClient.execute(httpGet);
            // 得到响应状态
            StatusLine statusLine = response.getStatusLine();
            // 得到请求响应码
            int code = statusLine.getStatusCode();
            System.out.println("请求返回的状态码是：" + code);
            //判断响应状态码
            if (code == HttpStatus.SC_OK) {
                // 得到网页的实体
                HttpEntity entity = response.getEntity();
                // 转换成字符串
                html = EntityUtils.toString(entity, charset);
            }
        } catch (Exception e) {
            // 可以进行一直访问网页，防止中断
            System.out.println("异常信息是：" + e);
            return getHtml(url, charset);
        }
        return html;
    }

}
