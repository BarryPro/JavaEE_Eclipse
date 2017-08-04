package data.structure.list;

public class DuLinkList<T> {
	private class Node{
		private T data;//����
		private Node pre;//ǰ��
		private Node next;//���
		
		//Ĭ�Ϲ�����
		@SuppressWarnings("unused")
		public Node(){
			
		}
		
		//��ʼ��ȫ�����ԵĹ�����
		public Node(T data,Node pre,Node next){
			this.data = data;
			this.pre = pre;
			this.next = next;
		}
	}
	
	private Node header;//˫�������ͷ�ڵ�
	private Node tail;//˫�������β�ڵ�
	private int size;//˫������Ĵ�С
	
	//��ʼ��������
	public DuLinkList(){
		header = null;
		tail = null;
	}
	
	//��ָ��Ԫ�ؽ�����������ֻ��һ��Ԫ��
	public DuLinkList(Node element){
		this.header = element;
		tail = header;
		size++;		
	}
	
	//��������ĳ���
	public int length(){
		return size;
	}
	
	//ͨ�������õ�index��������
	public T get(int index){
		return getNodeByIndex(index).data;
	}
	
	//˽��ͨ�������õ��ڵ㣨���Ƕ��ⷢ���Ĺ��ܣ�
	private Node getNodeByIndex(int index) {
		// TODO Auto-generated method stub
		if(index<0||index>size-1){
			throw new IndexOutOfBoundsException("���Ա�����Խ��");
		}
		Node current = null;//���ڴ�ŵ�ǰ�ڵ�
		if(index <= size/2){
			current = header;
			/*
			 * ��i���ڵ��ͷ�ڵ㿪ʼ��ţ�ʹ������������һ���ò�Ѯ��
			 * ʵ�ʵı�����ͨ��current = current.next ��������
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
	
	//������element����ƥ��������±�
	public int locate(T element){
		Node current = header;
		for(int i = 0; i<size-1 && current != null; i++,current = current.next){
			if(current.equals(element)){
				return i;
			}
		}
		return -1;
	}
	
	//����ָ��λ�ý��в���
	public void insert(T element,int index){
		if(index<0||index>size-1){
			throw new IndexOutOfBoundsException("���Ա�����Խ��");
		}
		if(header == null){
			add(element);
		} else {
			if(index == 0){//ͷ����
				addAtHeader(element);
			} else {
				Node pre = getNodeByIndex(index-1);
				Node next = getNodeByIndex(index+1);
				Node newNode = new Node(element,pre,next);
				pre.next = newNode;//��hander���
				next.pre = newNode;//��hander���
			}
		}
		size++;
	}
	//����β��������½ڵ�
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
	
	//����ͷ����ķ�ʽ����½ڵ�
	public void addAtHeader(T element){
		header = new Node(element,null,header);
		if(tail == null){
			tail = header;
		}
		size++;
	}
	
	//ɾ��������ָ������
	public T delete(int index){
		if(index < 0 || index > size-1){
			throw new IndexOutOfBoundsException("���Ա�����Խ��");
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
			del.next = null;//�ж�hander
		}
		size--;
		return del.data;
	}
	
	//ɾ�������е����һ��Ԫ��
	public T remove(){
		return delete(size-1);
	}
	
	//�ж������Ƿ�Ϊ��
	public boolean empty(){
		return size == 0;
	}
	
	//�������
	public void clear(){
		header = null;
		tail = null;
		size = 0;				
	}
	
	//��дObject�µ�toString()����  ��header ���
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
	
	//��tail���
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
