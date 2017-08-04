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
		Node cur = head;//��cur ������λ
		while(cur!=null){
			lastKth--;
			cur = cur.next;
		}
		if(lastKth == 0){//Ҫɾ����������ͷ�ڵ�
			head = head.next;
			//head.last = null;//ǰ��ָ��null
		}
		if(lastKth < 0){
			cur = head;//����ָ��ͷ
			while(++lastKth != 0){//�ҵ�Ҫɾ���Ľڵ��ǰһ���ڵ�
				cur = cur.next;
			}
			temp = cur.next;
			cur.next = cur.next.next;//ɾ���ýڵ�
			
			
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
