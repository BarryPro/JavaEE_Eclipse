package com.belong.list;

/*
 * ˫������ķ�ת
 */
public class ReverseDoubleList {
	public class Node{
		public int data;//����
		public Node last;//ǰ��
		public Node next;//���
		
		//Ĭ�Ϲ�����
		public Node(){
			
		}
		
		//��ʼ��ȫ�����ԵĹ�����
		public Node(int data,Node pre,Node next){
			this.data = data;
			this.last = pre;
			this.next = next;
		}
	}
	public Node reverseDList(Node head){
		Node pre = null;
		Node next = null;
		while(head!=null){//ÿ���ƶ�һ���ڵ㣨��ͷ��ʼ��
			next = head.next;//����һ���ڵ��next
			head.next = pre;//���Ӻ���
			head.last = next;//����ǰ������Ϊ��ͷ����˵һǰ��Ҫָ��ԭ����ڵ����һ����
			pre = head;
			head = next;
		}
		return pre;
	}
	public Node getHeader(){
		return header;
	}
	
	private Node header;//˫�������ͷ�ڵ�
	private Node tail;//˫�������β�ڵ�
	private int size;//˫������Ĵ�С
	
	
	//��������ĳ���
	public int length(){
		return size;
	}
	//����β��������½ڵ�
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
