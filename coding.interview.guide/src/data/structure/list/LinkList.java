package data.structure.list;

/**
 * 单向链表
 * @author belong
 *
 * @param <T> 泛型 数据类型
 */
public class LinkList<T> {
	//定义内部类节点
	public class Node{
		private T data;//节点数据
		public Node next;//指向下一个节点
		
		//默认构造器
		public Node(){
			
		}
		
		//带输入的构造器
		public Node(T data,Node next){
			this.data = data;
			this.next = next;
		}
	}
	
	private Node header;//头节点
	private Node tail;//尾节点
	private int size;
	
	
	public Node getHeader() {
		return header;
	}

	public void setHeader(Node header) {
		this.header = header;
	}

	//链表默认构造器(空链表)
	public LinkList(){
		header = null;
		tail = null;
	}
	
	//带输入的链表
	public LinkList(T element){
		header = new Node(element,null);//只有一个头结点
		tail = header;
		size++;
	}
	
	//返回链表长度
	public int length(){
		return size;
	}
	
	//获取链表索引index出的数据
	public T get(int index){
		return getNodeByIndex(index).data;
	}

	//实现返回下标索引所指向的数据
	private Node getNodeByIndex(int index) {//体现封装行（除功能以外都要进行透明化（封装））
		// TODO Auto-generated method stub
		if(index < 0 || index > size - 1){
			throw new IndexOutOfBoundsException("线性表索引越界");
		}
		Node current = header;//从头开始进行索引
		//双向索引（下标，数据）
		for(int i = 0; i<size && current!=null;i++,current = current.next){
			if(i == index){
				return current;
			}
		}
		return null;
	}
	
	//通过指定数据进行(查找)返回索引
	public int locate(T element){
		Node current = header;//从头开始查
		for(int i = 0;i<size&& current!=null;i++,current = current.next){
			if(current.data.equals(element)){
				return i;
			}
		}
		return -1;
	}
	
	//在指定位置插入数据
	public void insert(T element,int index){
		if(index<0||index >size-1){
			throw new IndexOutOfBoundsException("线性表索引越界");
		}
		if(header == null){
			add(element);
		} else {
			//得到前驱节点
			Node pre = getNodeByIndex(index-1);
			pre.next = new Node(element,pre.next);
			size++;
		}
	}

	//采用尾插入法添加节点
	public void add(T element) {
		// TODO Auto-generated method stub
		if(header == null){
			header = new Node(element,null);
			tail = header;
		} else {
			Node newNode = new Node(element,null);
			tail.next = newNode;
			tail = newNode;
		}	
		size++;
	}
	
	//采用头插入为链表添加新节点
	public void addAtHeader(T element,int index){
		if(index < 0 || index > size-1){
			throw new IndexOutOfBoundsException("线性表下标越界");
		}
		header = new Node(element,header);
		if(tail == null){//空表时
			tail = header;
		}
		size++;
	}
	
	//删除链表中指定索引的数据
	public T delete(int index){
		if(index < 0 || index > size-1){
			throw new IndexOutOfBoundsException("线性表下标越界");
		}
		Node del = null;
		if(index == 0){//因为header节点没有前驱
			del = header;
			header = header.next;
		} else {
			Node pre = getNodeByIndex(index-1);
			del = pre.next;
			pre.next = del.next;
			del.next = null;
		}
		size--;
		return del.data;
	}
	
	//删除最后一个节点
	public T remove(){
		return delete(size-1);
	}
	
	//判断是否为空
	public boolean empty(){
		return size == 0;
	}
	
	//清空链表
	public void clear(){
		header = null;
		tail = null;
		size = 0;
	}
	
	//重写Object下的toString()方法
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		if(empty()){
			return "[]";
		} else {
			StringBuilder sb = new StringBuilder("[");
			for(Node current = header; current!=null; current = current.next){
				sb.append(current.data.toString()+ ",");
			}
			int len = sb.length();
			return sb.delete(len-1, len).append("]").toString();
		}		
	}
	
	//输出两个表的公共部分
	@SuppressWarnings("unchecked")
	public void printCommonPart(LinkList<Integer> list1,LinkList<Integer> list2){
		Node head1 = (Node) list1.header;
		Node head2 = (Node) list2.header;
		while(head1!=null && head2!=null){
			if((int)head1.data<(int)head2.data){
				head1 = head1.next;
			} else if((int)head1.data>(int)head2.data){
				head2 = head2.next;
			} else {
				System.out.println(head1.data);
				head1 = head1.next;
				head2 = head2.next;
			}
		}
	}
	
}
