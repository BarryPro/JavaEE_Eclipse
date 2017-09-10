package com.belong.ds.list;

/**
 * @Description: <p></p>
 * @Author : belong
 * @Date : 2017年9月2日
 */
public class LinkedList{
	static class Node {
		Object value;
		Node next;

		public Node(Object value) {
			this.value = value;
			this.next = null;
		}
	}

	static Node head;
	static Node tail;

	public static void set(Object value) {
		Node node = new Node(value);
		if (head == null) {
			head = node;
			tail = head;
		} else {
			tail.next = node;
			tail = node;
		}
	}
	
	public static Object get(int index) {
		Node cur = head;
		for(int i = 0;i<index;i++) {
			cur = cur.next;
		}
		return cur.value;		
	}
	
	
	public static String show() {
		Node cur = head;
		StringBuffer str = new StringBuffer();
		while (cur != null) {
			str.append(cur.value + " ");
			cur = cur.next;
		}
		return str.toString();
	}
}
