package data.structure.list;

public class DuLinkList<T> {
	private class Node{
		private T data;//数据
		private Node pre;//前驱
		private Node next;//后继
		
		//默认构造器
		@SuppressWarnings("unused")
		public Node(){
			
		}
		
		//初始化全部属性的构造器
		public Node(T data,Node pre,Node next){
			this.data = data;
			this.pre = pre;
			this.next = next;
		}
	}
	
	private Node header;//双向链表的头节点
	private Node tail;//双向链表的尾节点
	private int size;//双向链表的大小
	
	//初始化空链表
	public DuLinkList(){
		header = null;
		tail = null;
	}
	
	//以指定元素建立链表，链表只有一个元素
	public DuLinkList(Node element){
		this.header = element;
		tail = header;
		size++;		
	}
	
	//返回链表的长度
	public int length(){
		return size;
	}
	
	//通过索引得到index出的数据
	public T get(int index){
		return getNodeByIndex(index).data;
	}
	
	//私有通过索引得到节点（不是对外发布的功能）
	private Node getNodeByIndex(int index) {
		// TODO Auto-generated method stub
		if(index<0||index>size-1){
			throw new IndexOutOfBoundsException("线性表索引越界");
		}
		Node current = null;//用于存放当前节点
		if(index <= size/2){
			current = header;
			/*
			 * 用i给节点从头节点开始标号（使链表像数据组一样好查旬）
			 * 实际的遍历是通过current = current.next 来遍历的
			 */
			for(int i = 0; i <= size/2 && current!=null;i++,current = current.next){
				if(index == i){
					return current;
				}
			}
		} else {
			current = tail;
			for(int i = size-1;i>size/2 &&current!=null; i--,current = current.pre){
				if(index == i){
					return current;
				}
			}
		}		
		return null;
	}
	
	//返回与element数据匹配的索引下标
	public int locate(T element){
		Node current = header;
		for(int i = 0; i<size-1 && current != null; i++,current = current.next){
			if(current.equals(element)){
				return i;
			}
		}
		return -1;
	}
	
	//根据指定位置进行插入
	public void insert(T element,int index){
		if(index<0||index>size-1){
			throw new IndexOutOfBoundsException("线性表索引越界");
		}
		if(header == null){
			add(element);
		} else {
			if(index == 0){//头插入
				addAtHeader(element);
			} else {
				Node pre = getNodeByIndex(index-1);
				Node next = getNodeByIndex(index+1);
				Node newNode = new Node(element,pre,next);
				pre.next = newNode;//接hander句柄
				next.pre = newNode;//接hander句柄
			}
		}
		size++;
	}
	//采用尾插入添加新节点
	public void add(T element){
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
	
	//采用头插入的方式添加新节点
	public void addAtHeader(T element){
		header = new Node(element,null,header);
		if(tail == null){
			tail = header;
		}
		size++;
	}
	
	//删除链表所指的索引
	public T delete(int index){
		if(index < 0 || index > size-1){
			throw new IndexOutOfBoundsException("线性表索引越界");
		}
		Node del = null;
		if(index == 0){
			del = header;
			header = header.next;
			header.pre = null;
		} else {
			Node pre = getNodeByIndex(index-1);
			del = pre.next;
			pre.next = del.next;
			if(del.next != null){
				del.next.pre = pre;
			}
			del.pre = null;
			del.next = null;//切断hander
		}
		size--;
		return del.data;
	}
	
	//删除链表中的最后一个元素
	public T remove(){
		return delete(size-1);
	}
	
	//判断链表是否为空
	public boolean empty(){
		return size == 0;
	}
	
	//清空链表
	public void clear(){
		header = null;
		tail = null;
		size = 0;				
	}
	
	//重写Object下的toString()方法  从header 输出
	public String toString(){
		if(empty()){
			return "[]";
		} else {
			StringBuilder sb = new StringBuilder("[");
			for(Node current = header; current != null; current = current.next){
				sb.append(current.data+",");
			}
			int len = sb.length();
			return sb.delete(len-1, len).append("]").toString();
		}
	}
	
	//从tail输出
	public String reverseToString(){
		if(empty()){
			return "[]";
		} else {
			StringBuilder sb = new StringBuilder("[");
			for(Node current = tail; current != null; current = current.pre){
				sb.append(current.data+",");
			}
			int len = sb.length();
			return sb.delete(len-1, len).append("]").toString();
		}
	}
}
