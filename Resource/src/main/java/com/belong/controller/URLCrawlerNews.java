package com.belong.controller;

import com.belong.common.Config;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

/**
 * @Description: <p>爬取UC新闻</p>
 * @Author: belong.
 * @Date: 2017/5/16.
 */
@Controller
@RequestMapping("/News")
public class URLCrawlerNews {
    private static Logger logger = LoggerFactory.getLogger(URLCrawlerNews.class);
    // 网站的解析字符集
    private static String charset;
    // 网站的html
    private static String html;
    private static String root;

    // 用于初始化网站的解析字符集
    static {
        Map<String,String> map = Config.init("uc");
        charset = map.get(Config.CHARSET);
        root = map.get(Config.ROOT);
        html = map.get(Config.HTML);
        logger.info("提示信息："+map.get(Config.MESSAGE));
    }

    @RequestMapping("/classify")
    public String home() {
        return Config.HOME;
    }
}
