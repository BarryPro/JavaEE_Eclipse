package com.belong.ds.tree;

import java.util.ArrayList;
import java.util.List;
public class TestTreeChild {
	public static void main(String[] args){
		TreeChild<String> tp = new TreeChild<String>("root");
		TreeChild.Node root = tp.root();
		System.out.println("根节点：" + root);
		tp.addNode("节点1" , root);
		tp.addNode("节点2" , root);
		tp.addNode("节点3" , root);
		System.out.println("添加子节点后的根节点：" + root);
		System.out.println("此树的深度:" + tp.deep());
		System.out.println("------------");
		//获取根节点的所有子节点
		List<TreeChild.Node<String>> nodes = tp.getChildren(root);
		System.out.println("根节点的第一个子节点：" + nodes.get(0));
		//为根节点的第一个子节点新增一个子节点
		tp.addNode("节点4" , nodes.get(0));
		System.out.println("根节点的第一个子节点：" + nodes.get(0));
		System.out.println("此树的深度:" + tp.deep());
	}
}
//让父节点记住它的所有子节点，
//使用该种方法记录树时，需要为每个节点维护一个子节点链，通过该子节点链来记录该节点的所有子节点。
class TreeChild<E>{
	//子节点
	private static class SonNode{
		//记录当前节点的位置
		private int pos;
		//子节点的中记录的下一个子节点的对象
		private SonNode next;
		public SonNode(int pos , SonNode next){
			this.pos = pos;//当前节点位置
			this.next = next;//下一节点位置
		}
	}
	//子节点链
	public static class Node<T>{
		T data;
		//记录第一个子节点:用于保存对该子节点链的引用，通过这种关系 ，可以记录树中节点之间的父子关系。
		SonNode first;
		public Node(T data){
			this.data = data;
			this.first = null;
		}
		public String toString(){
			if (first != null){
				return "TreeChild$Node[data=" + data + ", first="
				+ first.pos + "]";
			}else{
				return "TreeChild$Node[data=" + data + ", first=-1]";
			}
		}
	}
	
	private int treeSize = 100;
	//使用一个Node[]数组来记录该树里的所有节点
	private Node<E>[] nodes;
	//记录节点数目
	private int nodeNums;
	//以指定根节点创建树
	public TreeChild(E data){		
		nodes = new Node[this.treeSize];
		nodes[0] = new Node<E>(data);
		nodeNums++;
	}
	//为指定节点添加子节点
	public void addNode(E data , Node<?> parent){
		for (int i = 0 ; i < treeSize ; i++){
			//找到数组中第一个为null的元素，该元素保存新节点
			if (nodes[i] == null){
				//创建新节点，并用指定数组元素来保存它
				nodes[i] = new Node<E>(data);
				if (parent.first == null){//该节点没有子节点，也就是第一个子节点为空，把新节点加入到第一个子节点中
					parent.first = new SonNode(i , null);
				}else{//找到最后的一个当前父亲的子节点。该子节点也为空，把新节点添加到该节点的下一个子节点中。
					SonNode next = parent.first;
					while (next.next != null){
						next = next.next;
					}
					next.next = new SonNode(i , null);//把新节点地址添加到该节点的next中
				}
				nodeNums++;
				return;
			}
		}
		throw new RuntimeException("该树已满，无法添加新节点");
	}
	
	//返回根节点
	public Node<E> root(){
		//返回根节点
		return nodes[0];
	}
	//返回指定节点（非叶子节点）的所有子节点。
	public List<Node<E>> getChildren(Node<?> parent){
		List<Node<E>> list = new ArrayList<Node<E>>();
		//获取parent节点的第一个子节点
		SonNode next = parent.first;
		//沿着孩子链不断搜索下一个孩子节点
		while (next != null){
			//添加孩子链中的节点
			list.add(nodes[next.pos]);
			next = next.next;
		}
		return list;
	}
	
	//返回该树的深度。
	public int deep(){
		//获取该树的深度
		return deep(root()); 
	}
	//返回该节点的深度，这是一个递归方法：每棵子树的深度为其所有子树的最大深度 + 1
	private int deep(Node<?> node){
		if (node.first == null){//没有第一个子节点，所以深度仅为自己本身
			return 1;
		}else{
			//记录其所有子树的最大深度
			int max = 0;
			SonNode next = node.first;
			//沿着孩子链不断搜索下一个孩子节点
			while (next != null){
				//获取以其子节点为根的子树的深度
				int tmp = deep(nodes[next.pos]);
				if (tmp > max){
					max = tmp;
				}
				next = next.next;
			}
			//最后返回其所有子树的最大深度 + 1
			return max + 1;
		}
	}
	//返回包含指定值的节点。
	public int pos(Node<?> node){
		for (int i = 0 ; i < treeSize ; i++){
			//找到指定节点
			if (nodes[i] == node){
				return i;
			}
		}
		return -1;
	}
}
