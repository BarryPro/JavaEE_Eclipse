package data.structure.list;

import java.util.Arrays;
/**
 * ֻ�в�ɾ���ܵ����Ա�
 * @author Belong
 *
 * @param <T> ����
 */
public class SequenceList<T> {
	private int DEFAULT_SIZE = 16;//Ĭ�ϴ�С
	private int capacity;//���Ա�ĳ���
	private Object[] elementData;//�������Ա��Ԫ��
	private int size = 0;//��ǰ���Ա�Ĵ�С
	
	//���������Ա�
	public SequenceList(){
		this.capacity = DEFAULT_SIZE;
		elementData = new Object[capacity];
	}
	
	//��һ��Ԫ�س�ʼ�����Ա�
	public SequenceList(T element){
		this();//���ñ�����޲ι�����
		elementData[0] = element;
		this.size++;
	}
	
	//ָ�����ȴ������Ա�
	//��ʼ����һ��Ԫ��
	public SequenceList(T element,int initSize){
		capacity = 1;//��ʼֵ
		//��capacity��Ϊ����initSize����С��2��n�η�
		while(capacity<initSize){
			//�൱��capacity = capacity << 1;����λ��ֵ
			capacity <<=1;
		}
		elementData = new Object[capacity];
		elementData[0] = element;
		size++;
		
	}
	
	//���ص�ǰ����ĳ���
	public int length(){
		return this.size;
	}
	
	//������Ա������i��Ԫ��
	@SuppressWarnings("unchecked")
	public T get(int i){
		if(i<0 || i>size-1){
			throw new IndexOutOfBoundsException("���Ա�����Խ��");
		}
		return (T)elementData[i];
	}
	
	//�������Ա��ָ��Ԫ�ص�����
	public int locate(T element){
		for(int i = 0;i<size;i++){
			if(elementData[i].equals(element)){
				return i;
			}
		}
		return -1;//û����
	}
	
	//��ָ�����Ա��λ�ò���һ��Ԫ��
	public void insert(T element ,int index){
		if(index<0 || index>size){
			throw new IndexOutOfBoundsException("���Ա�����Խ��");
		}
		ensureCapacity(size+1);//ȷ���ײ�����鹻��
		/**
		 *  src - Դ���顣
			srcPos - Դ�����е���ʼλ�á�
			dest - Ŀ�����顣
			destPos - Ŀ�������е���ʼλ�á�
			length - Ҫ���Ƶ�����Ԫ�ص������� 

		 */
		System.arraycopy(elementData, index, elementData, index+1, size-index);//��index��λֵ�ճ���
		elementData[index] = element;
		size++;
	}
	
	//�ڱ�β��������
	public void add(T element){
		insert(element,size);
	}

	//�����Ա���չһλ
	private void ensureCapacity(int minCapacity) {
		// ��������ԭ�г���С��Ŀǰ����ĳ���
		if(minCapacity > capacity){
			//���ϵĽ�capacity*2��ֱ��capacity����minCapacity
			capacity <<= 1;
		}
		elementData = Arrays.copyOf(elementData, capacity);
	}
	
	//ɾ����������Ԫ��,��������������Ԫ��
	@SuppressWarnings("unchecked")
	public T delete(int index){//******************?
		if(index<0||index>size-1){
			throw new IndexOutOfBoundsException("���Ա�����Խ��");
		}
		T oldValue = (T)elementData[index];//��ԭ�ȵ�ֵ��������ɾ
		int numMoved = size-index-1;
		if(numMoved > 0){
			//�ø�����ɾ��index��Ԫ��
			System.arraycopy(elementData, index+1, elementData, index, numMoved);//������ǰ��һλ
		}
		//������һ��Ԫ��
		elementData[--size] = null;
		return oldValue;
	}
	
	//ɾ�����Ա�����һ��Ԫ��,��������
	public T remove(){
		return delete(size-1);
	}
	
	//�ж����Ա��Ƿ�Ϊ��
	public boolean empty(){
		return size == 0;
	}
	
	//������Ա�,ȫ���ƿ�
	public void clear(){
		Arrays.fill(elementData, null);
		size = 0;
	}
	
	//��д�����ʽ
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		if(size == 0){
			return "[]";
		} else {
			StringBuilder sb = new StringBuilder("[");
			for(int i = 0; i < size; i++){
				sb.append(elementData[i].toString()+",");
			}
			int len = sb.length();
			return sb.delete(len-1, len).append("]").toString();
		}
	}
}
