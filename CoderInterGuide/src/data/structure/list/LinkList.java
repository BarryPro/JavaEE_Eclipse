package data.structure.list;

/**
 * ��������
 * @author belong
 *
 * @param <T> ���� ��������
 */
public class LinkList<T> {
	//�����ڲ���ڵ�
	public class Node{
		private T data;//�ڵ�����
		public Node next;//ָ����һ���ڵ�
		
		//Ĭ�Ϲ�����
		public Node(){
			
		}
		
		//������Ĺ�����
		public Node(T data,Node next){
			this.data = data;
			this.next = next;
		}
	}
	
	private Node header;//ͷ�ڵ�
	private Node tail;//β�ڵ�
	private int size;
	
	
	public Node getHeader() {
		return header;
	}

	public void setHeader(Node header) {
		this.header = header;
	}

	//����Ĭ�Ϲ�����(������)
	public LinkList(){
		header = null;
		tail = null;
	}
	
	//�����������
	public LinkList(T element){
		header = new Node(element,null);//ֻ��һ��ͷ���
		tail = header;
		size++;
	}
	
	//����������
	public int length(){
		return size;
	}
	
	//��ȡ��������index��������
	public T get(int index){
		return getNodeByIndex(index).data;
	}

	//ʵ�ַ����±�������ָ�������
	private Node getNodeByIndex(int index) {//���ַ�װ�У����������ⶼҪ����͸��������װ����
		// TODO Auto-generated method stub
		if(index < 0 || index > size - 1){
			throw new IndexOutOfBoundsException("���Ա�����Խ��");
		}
		Node current = header;//��ͷ��ʼ��������
		//˫���������±꣬���ݣ�
		for(int i = 0; i<size && current!=null;i++,current = current.next){
			if(i == index){
				return current;
			}
		}
		return null;
	}
	
	//ͨ��ָ�����ݽ���(����)��������
	public int locate(T element){
		Node current = header;//��ͷ��ʼ��
		for(int i = 0;i<size&& current!=null;i++,current = current.next){
			if(current.data.equals(element)){
				return i;
			}
		}
		return -1;
	}
	
	//��ָ��λ�ò�������
	public void insert(T element,int index){
		if(index<0||index >size-1){
			throw new IndexOutOfBoundsException("���Ա�����Խ��");
		}
		if(header == null){
			add(element);
		} else {
			//�õ�ǰ���ڵ�
			Node pre = getNodeByIndex(index-1);
			pre.next = new Node(element,pre.next);
			size++;
		}
	}

	//����β���뷨��ӽڵ�
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
	
	//����ͷ����Ϊ��������½ڵ�
	public void addAtHeader(T element,int index){
		if(index < 0 || index > size-1){
			throw new IndexOutOfBoundsException("���Ա��±�Խ��");
		}
		header = new Node(element,header);
		if(tail == null){//�ձ�ʱ
			tail = header;
		}
		size++;
	}
	
	//ɾ��������ָ������������
	public T delete(int index){
		if(index < 0 || index > size-1){
			throw new IndexOutOfBoundsException("���Ա��±�Խ��");
		}
		Node del = null;
		if(index == 0){//��Ϊheader�ڵ�û��ǰ��
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
	
	//ɾ�����һ���ڵ�
	public T remove(){
		return delete(size-1);
	}
	
	//�ж��Ƿ�Ϊ��
	public boolean empty(){
		return size == 0;
	}
	
	//�������
	public void clear(){
		header = null;
		tail = null;
		size = 0;
	}
	
	//��дObject�µ�toString()����
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
	
	//���������Ĺ�������
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
