package com.datastructure.tree;


public class ArrayBinTreeTest {
	public static void main(String[] args){
		ArrayBinTree<String> binTree = 
			new ArrayBinTree<String>(4, "根");
		binTree.add(0 , "第二层右子节点" , false);
		binTree.add(2 , "第三层右子节点" , false);
		binTree.add(6 , "第四层右子节点" , false);
		System.out.println(binTree.left(6));//它的左面没有 因此都是null
		System.out.println(binTree.right(6));//第三层的右面就是第四层
		System.out.println(binTree);
		
	}
}
/**
 * Description:
 * <br/>网站: <a href="http://www.papaok.org"></a> 
 * <br/>Copyright (C), 2001-2012, 
 * <br/>This program is protected by copyright laws.
 * <br/>Program Name:
 * <br/>Date: 2012-1-31
 * @author belong
 * @version  1.0
 * 二叉树的顺序存储
 */
class ArrayBinTree<T>{
	//使用数组来记录该树的所有节点
	private Object[] datas;
	private int DEFAULT_DEEP = 8;
	//保存该树的深度
	private int deep;
	private int arraySize;
	//以默认的深度来创建二叉树
	public ArrayBinTree(){
		this.deep = DEFAULT_DEEP;
		this.arraySize = (int)Math.pow(2 , deep) - 1;//二叉树总节点的个数，是个公司
		datas = new Object[arraySize];
	}
	//以指定深度来创建二叉树
	public ArrayBinTree(int deep){
		this.deep = deep;
		this.arraySize = (int)Math.pow(2 , deep) - 1;
		datas = new Object[arraySize];
	}
	//以指定深度,指定根节点创建二叉树
	public ArrayBinTree(int deep , T data){
		this.deep = deep;
		this.arraySize = (int)Math.pow(2 , deep) - 1;
		datas = new Object[arraySize];
		datas[0] = data;
	}
	/**
	 * 为指定节点添加子节点。
	 * @param index 需要添加子节点的父节点的索引
	 * @param data 新子节点的数据
	 * @param left 是否为左节点
	 */
	public void add(int index , T data , boolean left){
		if (datas[index] == null){
			throw new RuntimeException(index + "处节点为空，无法添加子节点");
		}
		if (2 * index + 1 >= arraySize){
			throw new RuntimeException("树底层的数组已满，树越界异常");
		}
		//添加某个指定index的左子节点,奇数
		if (left){
			datas[2 * index + 1] = data;
		}else{//偶数		添加某个指定index的右子节点,奇数
			datas[2 * index + 2] = data;
		}
	}
	//判断二叉树是否为空。
	public boolean empty(){
		//根据根元素来判断二叉树是否为空
		return datas[0] == null;
	}
	//返回根节点。
	public T root(){
		return (T)datas[0] ;
	}
	//返回指定节点（非根节点）的父节点。
	public T parent(int index){
		return (T)datas[(index - 1) / 2] ;//整除，不会产生小数,生成节点的逆向
	}
	//返回指定节点（非叶子节点）的左子节点。当左子节点不存在时返回null
	public T left(int index){
		if (2 * index + 1 >= arraySize){
			throw new RuntimeException("该节点为叶子节点，无子节点");
		}
		return (T)datas[index * 2 + 1] ;
	}
	//返回指定节点（非叶子节点）的右子节点。当右子节点不存在时返回null
	public T right(int index){
		if (2 * index + 2 >= arraySize){
			throw new RuntimeException("该节点为叶子节点，无子节点");
		}
		return (T)datas[index * 2 + 2] ;
	}
	//返回该二叉树的深度。
	public int deep(int index){
		return deep;
	}
	//返回指定节点的位置。
	public int pos(T data){
		//该循环实际上就是按广度遍历来搜索每个节点
		for (int i = 0 ; i < arraySize ; i++){
			if (datas[i].equals(data)){
				return i;
			}
		}
		return -1;
	}
	public String toString(){
		return java.util.Arrays.toString(datas);
	}
}
