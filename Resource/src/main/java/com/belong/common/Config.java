package com.belong.common;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by belong on 2017/4/12.
 */
public class Config {
    public static final String PATH = "txt/url.txt";
    public static final String DEFAULT_CHARSET = "utf-8";
    public static final String HOME ="custom/home.ftl";
    public static final String ERROR ="custom/error.ftl";
    public static final String CONFIG = "txt/config.txt";
    public static final String URL_HEAD = "http://";
    public static final String HTML = "html";
    public static final String CHARSET = "charset";
    public static final String ROOT = "root";
    public static final String MESSAGE = "message";
    public static final String OUT_IMG = "img/out_img.jpg";

    /**
     * 负责初始化网站
     * @param url_name
     */
    public static Map init(String url_name){
        Map<String,String> map = new HashMap<>();
        String root = FileConfig.getUrls(url_name);
        String html = Net.getRequest(root, DEFAULT_CHARSET);
        String charset = Net.getCharset(html);
        map.put("root",root);
        map.put("charset",charset);
        if (charset != null) {
            map.put("message","当前访问的网站的字符集是："+charset);
        } else {
            charset = DEFAULT_CHARSET;
            map.put("message","当前访问的网站的采用默认字符集："+charset);
        }
        return map;
    }
}
