package com.belong.collection;

import java.util.Map;
import java.util.TreeMap;

/**
 * @Description: <p></p>
 * @Author : belong
 * @Date : 2017年8月12日
 */
public class TreeMapTest {
	public static void main(String[] args) {
        Map<String, String> maps = new TreeMap<String, String>();
        maps.put("aa", "aa");
        maps.put("cc", "cc");
        maps.put("bb", "bb");
        
        for (Map.Entry<String, String> entry : maps.entrySet()) {
            System.out.println(entry.getKey() + " : " + entry.getValue());
        }
    }
}
