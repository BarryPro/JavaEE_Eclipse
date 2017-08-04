package com.belong.tree;

import java.util.ArrayList;
import java.util.List;

public class TreeParent<E> {
	public static class Node<T>{
		T data;
		//记录父节点的位置
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
	//用于存放所有节点
	private Node<E> [] nodes;
	//记录节点数
	private int nodeNums;
	//以指定根节点创建树
	public TreeParent(E data){
		treeSize = DEFAULT_TREE_SIZE;
		nodes = new Node[treeSize];
		//初始化根节点
		nodes[0] = new Node<E>(data,-1);
		nodeNums++;
	}
	//指定树大小建树
	public TreeParent(E data,int treeSize){
		this.treeSize = treeSize;
		nodes = new Node[treeSize];
		nodes[0] = new Node<E>(data,-1);
		nodeNums++;
	}
	//添加节点
	public void addNode(E data,Node parent){
		for(int i = 0; i< treeSize; i++){
			//找到第一个为空的节点来存新节点
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
			//找到指定节点
			if(nodes[i] == node){
				return i;
			}
		}
		return -1;
	}
	public boolean empty(){
		//用根节点来判断
		return nodes[0] == null;
	}
	//返回根节点
	public Node<E> root(){
		return nodes[0];
	}
	//返回除了根节点的父节点
	public Node<E> parent(Node node){
		return nodes[node.parent];
	}
	//返回指定节点(非叶子的)所有子节点
	public List<Node<E>> children(Node parent){
		List<Node<E>> list = new ArrayList<Node<E>>();
		for(int i = 0; i<treeSize;i++){
			//非空的同一个父亲节点的子节点
			if(nodes[i] != null && nodes[i].parent == pos(parent)){
				list.add(nodes[i]);
			}
		}
		return list;
	}
	public int deep(){
		int max = 0;
		for(int i = 0 ; i < treeSize && nodes[i] !=null;i++){
			//初始化本节点的深度
			int def = 1;
			//m几录当前节点的父节点的位置
			int m = nodes[i].parent;
			//如果其父结点存在
			while(m != -1 && nodes[m] !=null){
				//向上继续搜索父节点
				m = nodes[m].parent;
				def++;
			}
			if(max < def){
				max = def;
			}
		}
		//返回最大深度
		return max;
	}
}
