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
		//�����������ֽڷ���list��ͷ�ڵ�
		if(head == null || head.next == head || m<1){
			return head;
		}
		Node last = head;
		//��lastָ�����һ���ڵ㣨��head��1��
		while(last.next != head){
			last = last.next;
		}
		int count = 0;//������
		//ֻ��ʣһ���ڵ��ʱ��head�ŵ���last
		while(head != last){
			if(++count == m){
				last.next = head.next;//ɾ��ͷ
				count = 0;//���¼���
			} else {
				last = last.next;//����ƶ�
			}
			head = last.next;//��һ���ڵ㵱ͷ
		}
		return head;
	}
}
