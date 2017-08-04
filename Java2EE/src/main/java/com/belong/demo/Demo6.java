package com.belong.demo;

import org.apache.commons.lang3.StringUtils;

import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.Semaphore;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/5/9.
 */
public class Demo6 {
    public static void main(String[] args) {
        int n = 10;
        // java可以进行连续赋值
        int m;
        int h;
        h=m=n;
        System.out.println(n+=n-=n-n);
        System.out.println(h+"----"+m+"----"+n);
        Set<String> set = new HashSet<>();
        Semaphore semaphore;
        AtomicInteger atomicInteger;
        String s1 = "hello";
        if(s1 == "hello"){
            System.out.println("ok");
        }
        System.out.println(StringUtils.repeat("belong.",2));
    }
}
