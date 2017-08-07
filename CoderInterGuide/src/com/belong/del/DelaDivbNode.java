package com.belong.del;

/*
 * ������ɾ����Ӧ�ڵ������
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
		while(cur!=null){//����һ���ж��ٸ��ڵ�
			n++;
			cur = cur.next;
		}
		n = (int) Math.ceil((double)(a*n)/(double)b);//��ɾ�������Ǹ�λ��
		if(n == 1){//ɾ��ͷ�ڵ�
			head = head.next;
		}
		if(n>1){
			cur = head;//��ͷ��ʼ
			while(--n != 1){//�ҵ�ǰһ���ڵ�
				cur = cur.next;
			}
			temp = cur.next;
			cur.next = cur.next.next;
		}
		return temp;
	}
}
