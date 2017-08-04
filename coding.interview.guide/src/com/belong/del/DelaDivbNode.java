package com.belong.del;

/*
 * 按比例删除对应节点的数据
 */
public class DelaDivbNode {
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
	public Node removeByRatio(Node head,int a,int b){
		Node temp = null;
		if(a<1||a>b){
			return head;
		}
		int n = 0;
		Node cur = head;
		while(cur!=null){//看看一共有多少个节点
			n++;
			cur = cur.next;
		}
		n = (int) Math.ceil((double)(a*n)/(double)b);//看删除的是那个位置
		if(n == 1){//删除头节点
			head = head.next;
		}
		if(n>1){
			cur = head;//从头开始
			while(--n != 1){//找到前一个节点
				cur = cur.next;
			}
			temp = cur.next;
			cur.next = cur.next.next;
		}
		return temp;
	}
}
