package com.belong.test;

import com.belong.test.HashMapTest.Entry;

/**
 * @Title : 测试HashMap
 * @Description :
 *              <p>
 *              </p>
 * @Author : belong
 * @Date : 2017年9月12日
 */
public class HashMapTest<K, V> {
	// 1.定义bucket的容量（bucket里存的是链表）,默认大小是16
	private static int INIT_CAPACITY = 16;
	private Entry<K, V>[] bucket;
	// 2.定义默认的加载因子，用于计算扩容的阈值，默认是0.75
	private static float LOAD_FACTOR = 0.75f;
	// 3.定义扩容的阈值max，如果超过这个值就要进行扩容
	private int max;
	// 4.记录HashMap的大小
	private int size;

	public HashMapTest(int capacity, float loader) {
		this.INIT_CAPACITY = capacity;
		this.LOAD_FACTOR = loader;
		bucket = new Entry[capacity];
		max = (int) (bucket.length * loader);
	}

	public HashMapTest() {
		this(INIT_CAPACITY, LOAD_FACTOR);
	}

	/**
	 * 1、插入数据
	 * 
	 * @param key
	 * @param value
	 */
	public void put(K key, V value) {
		// 1.得到哈希码，以后用这个码来进行得到该存在哪个bucket中
		int hash = key.hashCode();		
		Entry newNode = new Entry(key, value, hash);
		addEntry(newNode,bucket);
	}

	private void addEntry(Entry newNode,Entry[] bucket) {
		int index = fromHashToIndex(bucket.length, newNode.hash);
		Entry curNode = bucket[index];
		// 判断元素是否已经存在，考虑三点，第一点hash值，key值，value值
		if(curNode != null) {
			if ((newNode.hash == curNode.hash) 
					&& (newNode.key == curNode.key || newNode.key.equals(curNode.key))
					&& (newNode.value == curNode.value || newNode.value.equals(curNode.value))) {
				return ;
			}
			// 如果不存在直接添加，找到尾节点
			// 2.说明bucket中的节点不为空，这时就得找到链表中的最后一个
			while (curNode != null) {
				// 当节点的next为空的话就是最后一个节点的
				if (curNode.next == null) {
					break;
				}
				curNode = curNode.next;
			}
			addEntryLast(curNode, newNode);
		}		
		// 3.如果bucket中的节点为空，说明还没有在筐中装入元素，需要在bucket中装入元素
		addBucketNode(newNode, index);
		if(size > max) {
			reSize(bucket);
		}
	}

	private void addBucketNode(Entry newNode, int index) {
		bucket[index] = newNode;
		size++;
	}

	private void addEntryLast(Entry curNode, Entry newNode) {
		curNode.next = newNode;
		newNode.next = null;
		size++;
	}
	
	public int getSize() {
		return size;
	}

	/**
	 * 2、通过键值得到值
	 * 
	 * @param key
	 * @return
	 */
	public V get(K key) {
		int hash = key.hashCode();
		int index = fromHashToIndex(bucket.length, hash);
		Entry curNode = bucket[index];
		if (curNode != null) {
			while (curNode != null) {
				// 当节点的next为空的话就是最后一个节点的
				if (curNode.next == null) {
					break;
				}
				curNode = curNode.next;
			}
		} else {
			return null;
		}
		return (V) curNode.value;
	}

	/**
	 * 3、返回键值对
	 * 
	 * @param len
	 * @param index
	 * @return
	 */
	public int fromHashToIndex(int len, int index) {
		return (len - 1) & index;
	}

	public void reSize(Entry[] bucket_old) {
		// 1.进行原有大小扩大2倍
		Entry[] newBucket = new Entry[bucket.length << 1];
		// 2.把原数组的内容放到新数组中
		for (int i = 0; i < bucket_old.length; i++) {
			Entry curNode = bucket_old[i];
			newBucket[i] = curNode;
			while(curNode!=null) {
				addEntry(curNode,bucket);
				curNode = curNode.next;
			}
		}
		this.bucket = newBucket;
	}
	
	@Override
	public String toString() {
		return super.toString();
	}

	class Entry<K, V> {
		K key;
		V value;
		int hash;
		Entry next;

		public Entry(K key, V value, int hash) {
			this.key = key;
			this.value = value;
			this.hash = hash;
			this.next = null;
		}
	}
}
