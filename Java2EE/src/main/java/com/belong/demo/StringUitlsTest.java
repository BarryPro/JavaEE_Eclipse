package com.belong.demo;

import org.apache.commons.lang3.StringUtils;

/**
 * @Description: <p>c测试Apache.common.lang3包</p>
 * @Author: belong.
 * @Date: 2017/5/11.
 */
public class StringUitlsTest {
    public static void main(String[] args) {
        // 重复输出字符串
        System.out.println(StringUtils.repeat("belong.",2));
        // 查看字符出现的个数
        System.out.println(StringUtils.countMatches("belong.belong@outlook.com",'o'));
        System.out.println(StringUtils.countMatches("belong.belong@outlook.com","belong"));
    }
}
