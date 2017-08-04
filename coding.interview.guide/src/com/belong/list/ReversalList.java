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
	 * ������ķ�ת
	 */
	public Node reversal(Node head){
		Node pre = null;//�����½�һ��ͷ����ĵ�������
		Node next = null;//����ָ����һ���ڵ�
		while(head!=null){
			next = head.next;
			head.next = pre;
			pre = head;
			head = next;
		}
		return pre;
	}
}
