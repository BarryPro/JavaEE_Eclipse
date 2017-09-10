package com.belong.os.pageswap.LRU;

/**
 * @Title : LRU置换算法
 * @Description : 
 * <p>测试置换算法</p>
 * @Author : belong
 * @Date : 2017年9月3日
 */
public class LRUTest {
	public static void main(String[] args) {
		LRUcache_HashMap cache_HashMap = new LRUcache_HashMap(3);
		cache_HashMap.set(5,5);
		cache_HashMap.set(2,2);
		cache_HashMap.set(4,4);
		cache_HashMap.set(1,1);
		cache_HashMap.set(3,3);
		System.out.println(cache_HashMap.cache.keySet());
		cache_HashMap.showLinkedList();
		System.out.println(cache_HashMap.get(5));
		System.out.println(cache_HashMap.cache.keySet());
		cache_HashMap.showLinkedList();
		System.out.println(cache_HashMap.get(1));
		System.out.println(cache_HashMap.cache.keySet());
		cache_HashMap.showLinkedList();
	}
}
