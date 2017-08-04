package com.belong.jsoup;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.StatusLine;
import org.apache.http.client.CookieStore;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.cookie.BasicClientCookie;
import org.apache.http.util.EntityUtils;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/5/12.
 */
public class PostRequest {
    public static void main(String[] args) {
        PostRequest convert = new PostRequest();
        String html = convert.getDecodeHtml();
        System.out.println(html);
    }

    public String getDecodeHtml() {
        String root = "http://www.toutiao.com/";
        return getHtml(root, "");
    }

    public String getHtml(String url, String url_input) {
        String html = null;
        try {
            // 获取客户端,使用客户端来进行网络请求
            //HttpClient httpClient = HttpClients.createDefault();
            HttpClient httpClient = HttpClients.custom()
                    .setDefaultRequestConfig(RequestConfig.custom()
                            .setCookieSpec(CookieSpecs.STANDARD).build())
                    .build();
            // 声明请求方法(相当于request的get请求方式)
            HttpPost httpPost = new HttpPost(url);
            // 解决中文乱码在外面包一层 StringEntity 继承了HttpEntity
            httpPost.setHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36");
            // 设置网页请求的参数，包括form-data的提交

            CookieStore cookieStore = new BasicCookieStore();
            Cookie cookie = new BasicClientCookie("","");
            cookieStore.addCookie(cookie);
            //List<BasicNameValuePair> form_params = new ArrayList<>();
            //form_params.add(new BasicNameValuePair("url-input", url_input));
            //UrlEncodedFormEntity urlEncodedFormEntity = new UrlEncodedFormEntity(form_params,"utf-8");
            //httpPost.setEntity(urlEncodedFormEntity);


            //httpPost
            // 返回请求的响应
            HttpResponse response = httpClient.execute(httpPost);
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
                html = EntityUtils.toString(entity, "utf-8");
            }
            //EntityUtils.consume(multipartEntity);
        } catch (Exception e) {
            // 可以进行一直访问网页，防止中断
            e.printStackTrace();
            //return getHtml(url,url_input);
        }
        return html;
    }
}
