package com.belong.os.pageswap.LRU;

import java.util.HashMap;
import java.util.Map;

/**
 * @Description: <p>基于HashMap实现的LRU cache</p>
 * 1、用HashMap来模拟 LRU cache一次调入内存的页数
 * 2、用双向链表来记录最久未使用的内存页
 * @Author : belong
 * @Date : 2017年9月2日
 */
public class LRUcache_HashMap {
	// 双相列表和hash表的存储节点是一样的，采用这两种结构来实现cache
	class Node {
		Node pre;
		Node next;
		Integer key;
		Integer val;

		Node(Integer k, Integer v) {
			key = k;
			val = v;
		}
	}

	// 内存中的缓存O(1)的获取时间复杂度
	public Map<Integer, Node> cache = new HashMap<Integer, Node>();
	// 头和尾就是用来存取元素的实际上没有具体的值
	// 头部的都是最久未使用的.
	Node head;
	// 尾部都是最新加入和使用的内存页.
	Node tail;
	// 设置内存能存储的最大页数
	int cap;

	// 初始化内存的页数
	public LRUcache_HashMap(int capacity) {
		cap = capacity;
		head = new Node(null, null);
		tail = new Node(null, null);
		head.next = tail;
		tail.pre = head;
	}

	// 缓存获取获取获取内存页，如果在内存就更新为最新访问
	public int get(int key) {
		Node n = cache.get(key);
		if (n != null) {
			n.pre.next = n.next;
			n.next.pre = n.pre;
			appendTail(n);
			return n.val;
		}
		return -1;
	}

	// 添加内存页
	public void set(int key, int value) {
		Node newPage = cache.get(key);
		// 1.如果在内存中存在该页了，更新内存页中也有的页
		if (newPage != null) {
			newPage.val = value;
			cache.put(key, newPage);
			newPage.pre.next = newPage.next;
			newPage.next.pre = newPage.pre;
			appendTail(newPage);
			return;
		}
		// 2.如果内存中已经达到了页的最大值，触发缺页置换，把最久未使用的页调出内存
		if (cache.size() == cap) {
			Node tmp = head.next;
			head.next = head.next.next;
			head.next.pre = head;
			cache.remove(tmp.key);
		}
		// 3.把要调入的页面导入内存，并标记为最新使用
		newPage = new Node(key, value);
		appendTail(newPage);
		cache.put(key, newPage);
	}

	/**
	 * 把n节点插入双相链表的尾部
	 * @param n
	 */
	private void appendTail(Node n) {
		n.next = tail;
		n.pre = tail.pre;
		tail.pre.next = n;
		tail.pre = n;
	}
	
	public void showLinkedList() {
		Node cur = head.next;
		while(cur.next != null) {
			System.out.print(cur.val+" ");
			cur = cur.next;
		}
		System.out.println();
	}
}
