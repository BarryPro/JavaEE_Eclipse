package com.belong.list;

public class JosephusKill1 {
	public class Node{
		public int value;
		public Node next;
		public Node(int value,Node next){
			this.value  = value;
			this.next = next;
		}
	}
	private Node head;
	private Node tial;
	public Node getHead(){
		return head;
	}
	public void add(int data){
		if(head==null){
			head = new Node(data,null);
			tial = head;
		} else {
			Node newNode = new Node(data,null);
			tial.next = newNode;
			tial = newNode;
			tial.next = head;
		}
	}
	public Node josephusKill1(Node head,int m){
		//不满足条件字节返回list的头节点
		if(head == null || head.next == head || m<1){
			return head;
		}
		Node last = head;
		//让last指向最后一个节点（让head数1）
		while(last.next != head){
			last = last.next;
		}
		int count = 0;//报数器
		//只有剩一个节点的时候head才等于last
		while(head != last){
			if(++count == m){
				last.next = head.next;//删除头
				count = 0;//重新技术
			} else {
				last = last.next;//向后移动
			}
			head = last.next;//下一个节点当头
		}
		return head;
	}
}
