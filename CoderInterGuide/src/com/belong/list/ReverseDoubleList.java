package com.belong.list;

/*
 * 双向链表的反转
 */
public class ReverseDoubleList {
	public class Node{
		public int data;//数据
		public Node last;//前驱
		public Node next;//后继
		
		//默认构造器
		public Node(){
			
		}
		
		//初始化全部属性的构造器
		public Node(int data,Node pre,Node next){
			this.data = data;
			this.last = pre;
			this.next = next;
		}
	}
	public Node reverseDList(Node head){
		Node pre = null;
		Node next = null;
		while(head!=null){//每次移动一个节点（从头开始）
			next = head.next;//把下一个节点给next
			head.next = pre;//链接后驱
			head.last = next;//链接前驱（因为是头插入说一前驱要指向原链表节点的下一个）
			pre = head;
			head = next;
		}
		return pre;
	}
	public Node getHeader(){
		return header;
	}
	
	private Node header;//双向链表的头节点
	private Node tail;//双向链表的尾节点
	private int size;//双向链表的大小
	
	
	//返回链表的长度
	public int length(){
		return size;
	}
	//采用尾插入添加新节点
		public void add(int element){
			if(header == null){
				header = new Node(element,null,null);
				tail = header;
			} else {
				Node newNode = new Node(element,tail,null);
				tail.next = newNode;
				tail = newNode;
			}
			size++;
		}
}
