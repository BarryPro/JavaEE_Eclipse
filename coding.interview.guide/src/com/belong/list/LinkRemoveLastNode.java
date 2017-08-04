package com.belong.list;
public class LinkRemoveLastNode {
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
	public Node removeLastNode(Node head,int lastKth){
		Node temp = null;
		if(head==null||lastKth<1){
			return head;
		}
		Node cur = head;//用cur 进行移位
		while(cur!=null){
			lastKth--;
			cur = cur.next;
		}
		if(lastKth == 0){//要删除的正好是头节点
			head = head.next;
			//head.last = null;//前驱指向null
		}
		if(lastKth < 0){
			cur = head;//重新指回头
			while(++lastKth != 0){//找到要删出的节点的前一个节点
				cur = cur.next;
			}
			temp = cur.next;
			cur.next = cur.next.next;//删除该节点
			
			
			/*
			 * doubleNode newNext = cur.next.next;
			 * cur.next = newNext;
			 * if(newNext!=null){
			 * 
			 * newNext.last = cur;
			 */
		}
		return temp;
	}
}
