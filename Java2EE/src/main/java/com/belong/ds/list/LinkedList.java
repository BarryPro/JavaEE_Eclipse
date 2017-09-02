package com.belong.ds.list;

/**
 * @Description: <p></p>
 * @Author : belong
 * @Date : 2017年9月2日
 */
public class LinkedList {
	static class Node {
		int value;
		Node next;

		public Node(int value) {
			this.value = value;
			this.next = null;
		}
	}

	static Node head;
	static Node tail;

	public static void insert(int value) {
		Node node = new Node(value);
		if (head == null) {
			head = node;
			tail = head;
		} else {
			tail.next = node;
			tail = node;
		}
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
