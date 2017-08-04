package com.belong.list;

public class ReversalList {
	public class Node{
		public int value;
		public Node next;
		public Node(int value){
			this.value = value;
		}
		public Node(int value ,Node next){
			this.value = value;
			this.next = next;
		}
	}
	private Node head;
	private Node tail;
	public void add(int data){
		if(head == null){
			head = new Node(data,null);
			tail = head;
		} else {
			Node newNode = new Node(data,null);
			tail.next = newNode;
			tail = newNode;
		}
	}
	public Node getHead(){
		return head;
	}
	/*
	 * 单链表的反转
	 */
	public Node reversal(Node head){
		Node pre = null;//用于新建一个头插入的单向链表
		Node next = null;//用于指向下一个节点
		while(head!=null){
			next = head.next;
			head.next = pre;
			pre = head;
			head = next;
		}
		return pre;
	}
}
