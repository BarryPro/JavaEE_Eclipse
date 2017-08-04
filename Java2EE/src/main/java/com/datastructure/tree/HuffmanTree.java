package com.datastructure.tree;


//然后：实现哈夫曼树的主题类，其中包括两个静态的泛型方法，为创建哈夫曼树和广度优先遍历哈夫曼树


import java.util.ArrayDeque;  
import java.util.ArrayList;  
import java.util.Collections;  
import java.util.List;  
import java.util.Queue;  

public class HuffmanTree<T> {  
	public static <T> Node<T> createTree(List<Node<T>> nodes){
		//只要nodes数组中还有两个以上的节点
		while(nodes.size() > 1){  
			Collections.sort(nodes);//1先排序数据  
			// 获取权值最小的两个节点
			Node<T> left = nodes.get(nodes.size()-1);  //倒数第一个
			Node<T> right = nodes.get(nodes.size()-2);//倒数第二个  
			//生成新节点，新节点的权值为两个子节点的权值之和
			Node<T> parent = new Node<T>(null, left.getWeight()+right.getWeight()); 
			//让新节点作为权值最小的两个节点的父节点
			parent.setLeft(left);  
			parent.setRight(right);  
			//删除权值最小的两个节点
			nodes.remove(left);  
			nodes.remove(right);
			//将新生成的节点添加到集合中
			nodes.add(parent);  
		}  
		return nodes.get(0);  
	}  
	/*7 5 4 2
	 * 
	 *       18
	 *    11   7
	 *   6  5
	 *  2 4
	 * 			
	 * 
	 */

	public static void main(String[] args) {  
		// TODO Auto-generated method stub  
		List<Node<String>> list = new ArrayList<Node<String>>();  
		list.add(new Node<String>("a",7));  
		list.add(new Node<String>("b",5));  
		list.add(new Node<String>("c",4));  
		list.add(new Node<String>("d",2));  

		Node<String> root = HuffmanTree.createTree(list);  
		System.out.println(HuffmanTree.breadth(root));  
		//    	      System.out.println(list);  
	}  

	//广度优先遍历
	public static <T> List<Node<T>> breadth(Node<T> root){  
		List<Node<T>> list = new ArrayList<Node<T>>();  
		Queue<Node<T>> queue = new ArrayDeque<Node<T>>();  

		if(root != null){  
			//将跟元素入"队列"
			queue.offer(root);  
		}  

		while(!queue.isEmpty()){  
			//将该队列的"队尾"的元素添加到list中
			list.add(queue.peek());  
			Node<T> node = queue.poll();  
			//如果左节点不为null，将它们加入队列
			if(node.getLeft() != null){  
				queue.offer(node.getLeft());  
			}  
			//如果有节点不为null，将它们加入队列。
			if(node.getRight() != null){  
				queue.offer(node.getRight());  
			}  
		}  
		return list;  
	}  
}
class Node<T> implements Comparable<Node<T>> {  
	private T data;  
	private double weight;  //权重
	private Node<T> left;  
	private Node<T> right;  

	public Node(T data, double weight){  
		this.data = data;  
		this.weight = weight;  
	}  

	public T getData() {  
		return data;  
	}  

	public void setData(T data) {  
		this.data = data;  
	}  

	public double getWeight() {  
		return weight;  
	}  

	public void setWeight(double weight) {  
		this.weight = weight;  
	}  

	public Node<T> getLeft() {  
		return left;  
	}  

	public void setLeft(Node<T> left) {  
		this.left = left;  
	}  

	public Node<T> getRight() {  
		return right;  
	}  

	public void setRight(Node<T> right) {  
		this.right = right;  
	}  

	@Override  
	public String toString(){  
		return "data:"+this.data+";weight:"+this.weight;  
	}  

	@Override  
	public int compareTo(Node<T> other) {  
		if(other.getWeight() > this.getWeight()){  
			return 1;  
		}  
		if(other.getWeight() < this.getWeight()){  
			return -1;  
		}  

		return 0;  
	}  
}  
