package com.belong.ds.tree;

import java.util.ArrayList;
import java.util.List;

/*
 * 父节点表示法
 */
public class TestTreeParent {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//根目录
		TreeParent<String> tp = new TreeParent<String>("root");//第一个节点
		TreeParent.Node root = tp.root();
		System.out.println(root);
		tp.addNode("节点1" , root);
		System.out.println("此树的深度:" + tp.deep());
		System.out.println("----------------");
		
		tp.addNode("节点2" , root);
		//获取根节点的所有子节点
		List<TreeParent.Node<String>> nodes = tp.getChildren(root);
		System.out.println("根节点的第一个子节点：" + nodes.get(0));
		
		System.out.println("根节点的第二个子节点：" + nodes.get(1));
		//为根节点的第一个子节点新增一个子节点
		tp.addNode("节点3" , nodes.get(0));
		
		List<TreeParent.Node<String>> nodes1 = tp.getChildren(nodes.get(0));
		System.out.println("根节点的第三个子节点：" + nodes1.get(0));
		System.out.println("此树的深度:" + tp.deep());
	}
}
class TreeParent<E> {
	public static class Node<T>{
		//节点数据
		T data;
		//记录其父节点的位置
		int parent;
		
		public Node(T data , int parent){
			this.data = data;
			this.parent = parent;
		}
		public String toString(){
			return "父节点表示法[data=" + data + ", parent="+ parent + "]";
		}
	}
	//树节点的数量
	private int treeSize =100;
	//使用一个Node[]数组来记录该树里的所有节点
	private Node<E>[] nodes;
	//记录节点数
	private int nodeNums;
	public TreeParent(E data){
		
		nodes=new Node[this.treeSize];
		nodes[0] = new Node<E>(data , -1);//创建根节点。
		nodeNums++;		
	}
	
	//返回包含指定值的节点的索引。
	public int pos(Node node){
		for (int i = 0 ; i < treeSize ; i++){
			//找到指定节点
			if (nodes[i] == node){//地址一样
				return i;
			}
		}
		return -1;
	}
	//为指定父节点添加子节点
	public void addNode(E data , Node parent){
		for (int i = 0 ; i < treeSize ; i++){
			//找到数组中第一个为null的元素，该元素保存新节点
			if (nodes[i] == null){
				//创建新节点，并用指定的数组元素保存它
				nodes[i] = new Node(data , pos(parent));
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
	public List<Node<E>> getChildren(Node parent){
		List<Node<E>> list = new ArrayList<Node<E>>();
		for (int i = 0 ; i < treeSize  ; i++){
			//如果当前节点的父节点的位置等于parent节点的位置
			if (nodes[i] != null &&nodes[i].parent == pos(parent)){
				list.add(nodes[i]);
			}
		}
		return list;
	}
	//返回该树的深度:树中节点的最大层次值
	public int deep(){
		//用于记录节点的最大深度
		int max = 0;
		for(int i = 0 ; i < treeSize && nodes[i] != null; i++){
			//初始化本节点的深度
			int def = 1;
			//m记录当前节点的父节点的位置
			int m = nodes[i].parent;//父节点的索引
			//如果其父节点存在
			while(m != -1 && nodes[m] != null){
				//向上继续搜索父节点
				m = nodes[m].parent;
				def++;
			}	
			if(def>max){
				max = def;
			}
						
		}
		//返回最大深度
		return max; 
	}
}
