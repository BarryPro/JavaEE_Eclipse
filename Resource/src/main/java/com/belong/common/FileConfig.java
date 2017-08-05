package com.belong.common;

import com.belong.controller.URLCrawler;
import org.apache.log4j.Logger;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.Properties;

/**
 * @Description: <p>用于处理文件的读取和写出操作</p>
 * @Author: belong.
 * @Date: 2017/5/17.
 */
public class FileConfig {
    //日志工厂
    private static Logger logger = Logger.getLogger(FileConfig.class);

    public static void main(String[] args) {
        FileConfig.setConfig("position", "1890");
        System.out.println(FileConfig.getConfig("charset"));
    }

    /**
     * <p>用于得到想要的key所对应的值</p>
     *
     * @param key
     * @return
     */
    public static String getConfig(String key) {
        String path = FileConfig.class.getClassLoader().getResource(Config.CONFIG).getPath();
        InputStream is = null;
        Properties pro = new Properties();
        String value = null;
        try {
            is = new FileInputStream(path);
            pro.load(is);
            // 在存在key的时候在进行读取以防空指针异常
            if (pro.containsKey(key)) {
                value = pro.get(key).toString();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return value;
    }

    /**
     * <p>设置要写入的配置键值对</p>
     *
     * @param key
     * @param value
     */
    public static void setConfig(String key, String value) {
        String path = FileConfig.class.getClassLoader().getResource(Config.CONFIG).getPath();
        OutputStream os = null;
        Properties pro = new Properties();
        try {
            // 先把以前有的从新写入，要不会进行覆盖
            pro.load(new FileInputStream(path));
            for (Enumeration e = pro.propertyNames(); e.hasMoreElements(); ) {
                // 遍历所有元素
                String s = (String) e.nextElement();
                if (s.equals(key)) {
                    /**如果key已经存在则覆盖*/
                    pro.setProperty(key, value);
                } else {
                    /**把其他的Key-Value写入*/
                    pro.setProperty(s,pro.getProperty(s));
                }
            }
            // 在key原本就不在配置文件中要新插入config
            if(!pro.containsKey(key)){
                pro.setProperty(key,value);
            }
            os = new FileOutputStream(path);
            pro.store(os, "config_file");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * <p>用于得到文件中的网址Key-Value，来访问网址</p>
     * @param keyName
     * @return
     */
    public static String getUrls(String keyName) {
        InputStream is;
        Properties pro = new Properties();
        // 用于返回的url地址
        String url = null;
        try {
            is = URLCrawler.class.getClassLoader().getResourceAsStream(Config.PATH);
            pro.load(is);
            url = (String) pro.get(keyName);
        } catch (Exception e) {
            logger.error("异常信息是：" + e);
        }
        return url;
    }

}
