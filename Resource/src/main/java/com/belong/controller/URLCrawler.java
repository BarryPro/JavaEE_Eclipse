package com.belong.controller;

import com.belong.common.Config;
import com.belong.common.Net;
import com.belong.service.IVideoRec;
import com.belong.service.IVideoTypeConfig;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 网络爬虫
 * 爬取网上的资源
 * Created by belong on 2017/4/11.
 */
@Controller
@RequestMapping(value = "/urlCrawler")
public class URLCrawler {
    //日志工厂
    private static Logger logger = LoggerFactory.getLogger(URLCrawler.class);

    private static String root;
    private static String charset;

//    static {
//        Map<String,String> map = Config.init("99vv1");
//        root = map.get("root");
//        charset = map.get("charset");
//    }

    @Autowired
    private IVideoTypeConfig config_service;

    @Autowired
    private IVideoRec rec_service;

    @RequestMapping(value = "/home")
    public String home() {
        return Config.HOME;
    }

    @RequestMapping(value = "/error")
    public String error() {
        return Config.ERROR;
    }

    /**
     * 用于得到远程客户端的ip地址
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/addr")
    public String getAddr(HttpServletRequest request) {
        String Remote_addr = request.getRemoteAddr();
        String Local_addr = request.getLocalAddr();
        // 获取远程客户端的ip
        String ip = Net.getIpAddress(request);
        logger.info("Remote_addr:" + Remote_addr);
        logger.info("Local_addr:" + Local_addr);
        logger.info("ip:" + ip);
        return Config.HOME;
    }

    /**
     * <p>用于给video_type_config插入url数据</p>
     *
     * @return
     */
    @RequestMapping(value = "/type")
    public String getSubUrls() {
        URLCrawler crawler = new URLCrawler();
        String html = crawler.getDecodeHtml(root);
        logger.info("type=service:" + config_service);
        crawler.getHrefAndType(html, config_service);
        return Config.HOME;
    }

    /**
     * <p>用于查询所有的可访问的超链然后进行访问</p>
     *
     * @return
     */
    @RequestMapping(value = "/subUrls")
    public String cyclicConnUrls(Map<String, String> map) {
        // 用于装入可访问的链表
        List<String> list = config_service.getVideoCate();
        logger.info("可访问的网址是：[" + list.size() + "]" + list);
        // 进行访问查询出来的地址
        String context;
        Document document;
        //定义计数器
        int count = 0;
        for (String url : list) {
            logger.info("当前访问的url是：[第" + (++count) + "个url]" + url);
            context = getDecodeHtml(url);
            //得到dom
            document = Jsoup.parse(context);
            Elements lis = document.getElementsByClass("pagination");
            // 得到最后一个是最后的那个页
            Element last_a = lis.get(lis.size() - 1);
            String regex = "<a href=.*-(.*)\\.html\">尾页</a>";
            Pattern pattern = Pattern.compile(regex);
            Matcher matcher = pattern.matcher(last_a.html());
            // 循环子页的次数
            int n = 0;
            if (matcher.find()) {
                String num = matcher.group(1);
                n = Integer.parseInt(num);
            }
            //
            String video_no;
            String video_type;
            logger.info("子链的个数是：" + n);
            for (int i = 2; i <= n; i++) {
                video_no = url.substring(0, url.length() - 5) + "-" + i + url.substring(url.length() - 5, url.length());
                video_type = i + " ";
                map.put("videoNo", video_no);
                map.put("videoType", video_type);
                logger.info("要插入的map：" + map);
                try {
                    int code = config_service.addTypeConfig(map);
                    if (code > 0) {
                        logger.info("成功插入：" + map);
                    } else {
                        logger.info("插入失败！");
                    }
                } catch (Exception e) {
                    logger.error("异常信息是：" + e);
                    continue;
                }
            }
        }

        return Config.HOME;
    }

    @RequestMapping(value = "/rec")
    public String getRec(Map map) {
        // 用于装入可访问的链表
        List<String> list = config_service.getVideoCate();
        logger.info("可访问的网址是：[" + list.size() + "]" + list);
        // 进行访问查询出来的地址
        String html = Net.getRequest(root, Config.DEFAULT_CHARSET);
        String charset = Net.getCharset(html);
        String context;
        Document document;
        //定义计数器
        int count = 0;
        for (String url : list) {
            logger.info("当前访问的url是：[第" + (++count) + "个url]" + url);
            context = getDecodeHtml(url);
            //得到dom
            document = Jsoup.parse(context);
            Elements uls = document.getElementsByTag("ul");
            String class_type;
            for (Element ul : uls) {
                class_type = ul.attr("class");
                // 可以确定是具体的url(而不是分类的url)
                if ("".equals(class_type)) {
                    Elements as = ul.getElementsByTag("a");
                    Elements imgs = ul.getElementsByTag("img");
                    Elements h3s = ul.getElementsByTag("h3");
                    if (imgs.size() > 0) {
                        logger.info("as:" + as.size() + "  imgs:" + imgs.size() + "  h3s:" + h3s.size());
                        // 进行循环取想要的资源
                        String a, img, h3;
                        for (int i = 0; i < imgs.size(); i++) {
                            a = as.get(i).attr("href");
                            img = imgs.get(i).attr("src");
                            h3 = h3s.get(i).text();
                            logger.info("a=" + a + " img=" + img + " h3=" + h3);
                            a = root + a;
                            map.put("videoSrc", a);
                            map.put("videoName", h3);
                            map.put("videoPic", img);
                            map.put("videoType", url);
                            logger.info("要插入的信息是：" + map);
                            int code = 0;
                            try {
                                code = rec_service.addRec(map);
                            } catch (Exception e) {
                                continue;
                            }
                            if (code > 0) {
                                logger.info("成功插入：" + map);
                            } else {
                                logger.info("插入失败！");
                            }
                        }
                    } else {
                        // ul有多了，只有有资源的才是有图片的
                        continue;
                    }
                }
            }
        }
        return Config.HOME;
    }

    /**
     * <p>返回解码后的网页信息</p>
     *
     * @return
     */
    public String getDecodeHtml(String url) {
        return Net.getRequest(url, charset);
    }

    /**
     * 得到html页中的超链和超链所指向的内容
     *
     * @param html    html的全部内容
     * @param service 用于调用服务的句柄
     */
    private void getHrefAndType(String html, IVideoTypeConfig service) {
        logger.info("开始解析html内容");
        Document document = Jsoup.parse(html);
        // 得到多有的超链信息
        Elements a = document.getElementsByTag("a");
        // 用于过滤有效的超链
        String regex = "^/{1}.+/{1}.+\\.html$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher;
        logger.info("开始插入数据");
        logger.info("service:" + service);
        for (Element element : a) {
            // 得到超链的text内容
            String video_type = element.text();
            matcher = pattern.matcher(element.attr("href"));
            String video_no = null;
            // 得到超链的地址
            if (matcher.find()) {
                video_no = matcher.group(0);
                Map map = new HashMap<>();
                // 拼接全名插入
                video_no = root + video_no;
                map.put("videoNo", video_no);
                map.put("videoType", video_type);
                logger.info("插入的信息是：" + map);
                // service 是作为参数传进来的（否则在没有RequestMapping的方法先service不会被实例化）
                int code = service.addTypeConfig(map);
                if (code > 0) {
                    logger.info("成功插入" + map);
                } else {
                    logger.info("插入失败！");
                }
            }
        }
        logger.info("插入数据结束");
    }

}
