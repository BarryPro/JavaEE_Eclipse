package com.belong.ip;

import org.apache.http.HttpEntity;
import org.apache.http.StatusLine;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * @Author: belong.
 * @Description:
 * @Date: 2017/4/15.
 */
public class UrlConnect {
    public static void main(String[] args) {
        URL url = null;
        // 用于http的协议连接
        HttpURLConnection urlConnection = null;
        try {
            url = new URL("http://www.5jhp.com/frim/index/180.html");
            CloseableHttpClient httpClient = HttpClients.createDefault();
            HttpGet request = new HttpGet(url.toString());
            String encode = "gb2312";
            request.setHeader("Content-Type", "text/html; charset="+encode);
            request.setHeader("User-Agent","Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36");
            CloseableHttpResponse response = httpClient.execute(request);
            // 得到http的相应码，用来验证请求是否是有效的
            // 200表示的是请求成功
            StatusLine statusLine = response.getStatusLine();
            if(statusLine.getStatusCode() == HttpURLConnection.HTTP_OK){
                // 用于保存整个网页
                StringBuffer html = new StringBuffer();
                HttpEntity httpEntity = response.getEntity();
                InputStream inputStream = httpEntity.getContent();
                BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream,encode));
                String buffer = null;
                while((buffer = reader.readLine()) != null){
                    System.out.println(buffer);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
