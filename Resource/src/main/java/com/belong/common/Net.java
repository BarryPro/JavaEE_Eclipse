package com.belong.common;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.StatusLine;
import org.apache.http.client.CookieStore;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ConnectionPoolTimeoutException;
import org.apache.http.cookie.Cookie;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.cookie.BasicClientCookie;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @Description: <p>处理与网络有关的方法</p>
 * @Author: belong.
 * @Date: 2017/5/17.
 */
public class Net {

    // 日志工厂
    private static Logger logger = Logger.getLogger(Net.class);

    /**
     * 不需要登录使用GET请求来获取网站数据
     *
     * @param url
     * @param charset
     * @return
     */
    public static String getRequest(String url, String charset) {
        String html = null;
        try {
            // 获取客户端,使用客户端来进行网络请求
            HttpClient httpClient = HttpClients.custom().
                    setDefaultRequestConfig(RequestConfig.custom().setCookieSpec(CookieSpecs.STANDARD).build())
                    .build();
            // 声明请求方法(相当于request的get请求方式)
            HttpGet httpGet = new HttpGet(url);
            // 返回请求的响应
            HttpResponse response = httpClient.execute(httpGet);
            // 得到响应状态
            StatusLine statusLine = response.getStatusLine();
            // 得到请求响应码
            int code = statusLine.getStatusCode();
            logger.info("请求返回的状态码是：" + code);
            //判断响应状态码
            if (code == HttpStatus.SC_OK) {
                // 得到网页的实体
                HttpEntity entity = response.getEntity();
                // 转换成字符串
                html = EntityUtils.toString(entity, charset);
            }
        } catch (ConnectionPoolTimeoutException e) {
            // 可以进行一直访问网页，防止中断
            logger.error("异常信息是：" + e);
            return getRequest(url, charset);
        } catch (UnknownHostException he) {
            url = Config.URL_HEAD + url;
            return getRequest(url, charset);
        } catch (IOException ioe) {
            logger.error("异常信息是：" + ioe);
            return getRequest(url, charset);
        } catch (Exception ee) {
            logger.error("异常信息是：" + ee);
        }
        return html;
    }

    /**
     * 使用POST的请求方式进行访问网站
     *
     * @param url
     * @param map 用于请求的form参数表
     * @return
     */
    public static String postRequest(String url, Map<String, String> map) {
        String html = null;
        try {
            // 获取客户端,使用客户端来进行网络请求
            //HttpClient httpClient = HttpClients.createDefault();
            HttpClient httpClient = HttpClients.custom()
                    .setDefaultRequestConfig(RequestConfig.custom().setCookieSpec(CookieSpecs.STANDARD).build())
                    .build();
            // 声明请求方法(相当于request的get请求方式)
            HttpPost httpPost = new HttpPost(url);
            // 解决中文乱码在外面包一层 StringEntity 继承了HttpEntity
            httpPost.setHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36");
            // 设置网页请求的参数，包括form-data的提交

            CookieStore cookieStore = new BasicCookieStore();
            Cookie cookie = new BasicClientCookie("", "");
            cookieStore.addCookie(cookie);
            // 用于设置post方式的form表单的内容
            List<BasicNameValuePair> form_params = new ArrayList<>();
            Set<String> set = map.keySet();
            // 把传进来的表单参数都放入列表中
            for (String param : set) {
                form_params.add(new BasicNameValuePair(param, map.get(param)));
            }
            UrlEncodedFormEntity urlEncodedFormEntity = new UrlEncodedFormEntity(form_params, Config.DEFAULT_CHARSET);
            httpPost.setEntity(urlEncodedFormEntity);

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
                html = EntityUtils.toString(entity, Config.DEFAULT_CHARSET);
            }
            //EntityUtils.consume(multipartEntity);
        } catch (ConnectionPoolTimeoutException e) {
            // 可以进行一直访问网页，防止中断
            logger.error("异常信息是：" + e);
            return postRequest(url, map);
        } catch (UnknownHostException he) {
            url = Config.URL_HEAD + url;
            return postRequest(url, map);
        } catch (IOException ioe) {
            logger.error("异常信息是：" + ioe);
            return postRequest(url, map);
        } catch (Exception ee) {
            logger.error("异常信息是：" + ee);
        }
        return html;
    }

    /**
     * <p>得到网页的翻译的字符集</p>
     *
     * @return 返回字符集
     */
    public static String getCharset(String html) {
        // 解析成dom
        String charset = null;
        if (html != null) {
            Document document = Jsoup.parse(html);
            Elements metas = document.getElementsByTag("meta");
            for (Element meta : metas) {
                String tmp_attr = meta.attr("content");
                // 网页存在content属性
                if (tmp_attr != null) {
                    String[] attrs = tmp_attr.split("=");
                    for (int i = 0; i < attrs.length; i++) {
                        if (attrs[i].equals("charset")) {
                            charset = attrs[i + 1];
                            break;
                        }
                    }
                    // 如果没有content属性，就直接查charset属性来获取字符集
                }
                // 检查content中的charset
                if (charset != null) {
                    break;
                }
                charset = meta.attr("charset");
                // 检查charset的值
                if (charset != null) {
                    break;
                }
            }
        }
        return charset;
    }

    /**
     * <p>用于解析客户端请求的ip地址</p>
     *
     * @param request
     * @return
     */
    public static String getIpAddress(HttpServletRequest request) {
        // 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址

        String ip = request.getHeader("X-Forwarded-For");
        if (logger.isInfoEnabled()) {
            logger.info("getIpAddress(HttpServletRequest) - X-Forwarded-For - String ip=" + ip);
        }

        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("Proxy-Client-IP");
                if (logger.isInfoEnabled()) {
                    logger.info("getIpAddress(HttpServletRequest) - Proxy-Client-IP - String ip=" + ip);
                }
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("WL-Proxy-Client-IP");
                if (logger.isInfoEnabled()) {
                    logger.info("getIpAddress(HttpServletRequest) - WL-Proxy-Client-IP - String ip=" + ip);
                }
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("HTTP_CLIENT_IP");
                if (logger.isInfoEnabled()) {
                    logger.info("getIpAddress(HttpServletRequest) - HTTP_CLIENT_IP - String ip=" + ip);
                }
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("HTTP_X_FORWARDED_FOR");
                if (logger.isInfoEnabled()) {
                    logger.info("getIpAddress(HttpServletRequest) - HTTP_X_FORWARDED_FOR - String ip=" + ip);
                }
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getRemoteAddr();
                if (logger.isInfoEnabled()) {
                    logger.info("getIpAddress(HttpServletRequest) - getRemoteAddr - String ip=" + ip);
                }
            }
        } else if (ip.length() > 15) {
            String[] ips = ip.split(",");
            for (int index = 0; index < ips.length; index++) {
                String strIp = ips[index];
                if (!("unknown".equalsIgnoreCase(strIp))) {
                    ip = strIp;
                    break;
                }
            }
        }
        return ip;
    }
}
