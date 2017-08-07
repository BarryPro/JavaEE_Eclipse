package com.belong.tree;

import java.util.ArrayList;
import java.util.List;

public class TreeParent<E> {
	public static class Node<T>{
		T data;
		//��¼���ڵ��λ��
		int parent;
		public Node(){
			
		}
		public Node(T data){
			this.data = data;
		}
		public Node(T data ,int parent){
			this.data = data;
			this.parent = parent;
		}
		public String toString(){
			return "TreeParent$Node[data=" + data + ",parent=" + parent + "]";
		}
	}
	private final int DEFAULT_TREE_SIZE = 100;
	private int treeSize = 0;
	//���ڴ�����нڵ�
	private Node<E> [] nodes;
	//��¼�ڵ���
	private int nodeNums;
	//��ָ�����ڵ㴴����
	public TreeParent(E data){
		treeSize = DEFAULT_TREE_SIZE;
		nodes = new Node[treeSize];
		//��ʼ�����ڵ�
		nodes[0] = new Node<E>(data,-1);
		nodeNums++;
	}
	//ָ������С����
	public TreeParent(E data,int treeSize){
		this.treeSize = treeSize;
		nodes = new Node[treeSize];
		nodes[0] = new Node<E>(data,-1);
		nodeNums++;
	}
	//��ӽڵ�
	public void addNode(E data,Node parent){
		for(int i = 0; i< treeSize; i++){
			//�ҵ���һ��Ϊ�յĽڵ������½ڵ�
			if(nodes[i] == null){
				nodes[i] = new Node(data,pos(parent));
				nodeNums++;
				return ;
			}
		}
	}
	private int pos(Node node) {
		// TODO Auto-generated method stub
		for(int i = 0; i< treeSize; i++){
			//�ҵ�ָ���ڵ�
			if(nodes[i] == node){
				return i;
			}
		}
		return -1;
	}
	public boolean empty(){
		//�ø��ڵ����ж�
		return nodes[0] == null;
	}
	//���ظ��ڵ�
	public Node<E> root(){
		return nodes[0];
	}
	//���س��˸��ڵ�ĸ��ڵ�
	public Node<E> parent(Node node){
		return nodes[node.parent];
	}
	//����ָ���ڵ�(��Ҷ�ӵ�)�����ӽڵ�
	public List<Node<E>> children(Node parent){
		List<Node<E>> list = new ArrayList<Node<E>>();
		for(int i = 0; i<treeSize;i++){
			//�ǿյ�ͬһ�����׽ڵ���ӽڵ�
			if(nodes[i] != null && nodes[i].parent == pos(parent)){
				list.add(nodes[i]);
			}
		}
		return list;
	}
	public int deep(){
		int max = 0;
		for(int i = 0 ; i < treeSize && nodes[i] !=null;i++){
			//��ʼ�����ڵ�����
			int def = 1;
			//m��¼��ǰ�ڵ�ĸ��ڵ��λ��
			int m = nodes[i].parent;
			//����丸������
			while(m != -1 && nodes[m] !=null){
				//���ϼ����������ڵ�
				m = nodes[m].parent;
				def++;
			}
			if(max < def){
				max = def;
			}
		}
		//����������
		return max;
	}
}
