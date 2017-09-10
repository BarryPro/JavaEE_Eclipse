package com.belong.os.pageswap.LRU;

import java.util.Map;

/**
 * @Description: <p>基于LinkHashMap实现的LRU cache</p>
 * @Author : belong
 * @Date : 2017年9月2日
 */
public class LRUcache_LinkedHashMap {
	private int capacity;
	private Map<Integer, Integer> cache;

	public LRUcache_LinkedHashMap(int capacity) {
		this.capacity = capacity;
		this.cache = new java.util.LinkedHashMap<Integer, Integer>(capacity, 0.75f, true) {
			// 定义put后的移除规则，大于容量就删除eldest
			protected boolean removeEldestEntry(Map.Entry<Integer, Integer> eldest) {
				return size() > capacity;
			}
		};
	}

	public int get(int key) {
		if (cache.containsKey(key)) {
			return cache.get(key);
		} else
			return -1;
	}

	public void set(int key, int value) {
		cache.put(key, value);
	}
}
