package com.belong.list;

public class ReversePartList {
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
		}
	}
	public Node reversePart(Node head,int from,int to){
		int len = 0;//用于查找到fpre 和 tpos 节点用
		Node node1 = head;//用于存放头节点(因为要先向后一移一遍找节点所以要（用复制品）替换)
		Node fpre = null;
		Node tpos = null;
		while(node1!=null){
			len++;
			fpre = len == from - 1 ? node1 : fpre; 
			tpos = len == to + 1 ? node1 : tpos;
			node1 = node1.next;
		}
		if(from>to||from<1||to>len){
			return head;//不交换
		}
		node1 = fpre == null ? head : fpre.next;//先把要反转的头与原链表的尾相连(头的前一个节点)
		Node node2 = node1.next;//得到要反转的头结点的下一个节点(相当于pre)
		node1.next = tpos;//指向尾节点
		Node next = null;//(相当于next)
		while(node2 != null){//因为tpos是null
			next = node2.next;
			node2.next = node1;//
			node1 = node2;//（相当于）把node2给fpre
			node2 = next;
		}
		//把反转之后的连到前节点上
		if(fpre!=null){
			fpre.next = node1;//当node2为空时node1正好当前的相对尾节点
			return head;
		}
		return node1;
	}
}
