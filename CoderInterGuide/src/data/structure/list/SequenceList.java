package data.structure.list;

import java.util.Arrays;
/**
 * 只有插删功能的线性表
 * @author Belong
 *
 * @param <T> 泛型
 */
public class SequenceList<T> {
	private int DEFAULT_SIZE = 16;//默认大小
	private int capacity;//线性表的长度
	private Object[] elementData;//保存线性表的元素
	private int size = 0;//当前线性表的大小
	
	//创建空线性表
	public SequenceList(){
		this.capacity = DEFAULT_SIZE;
		elementData = new Object[capacity];
	}
	
	//以一个元素初始化线性表
	public SequenceList(T element){
		this();//调用本身的无参构造器
		elementData[0] = element;
		this.size++;
	}
	
	//指定长度创建线性表
	//初始化第一个元素
	public SequenceList(T element,int initSize){
		capacity = 1;//初始值
		//把capacity设为大于initSize的最小的2的n次方
		while(capacity<initSize){
			//相当于capacity = capacity << 1;先移位后赋值
			capacity <<=1;
		}
		elementData = new Object[capacity];
		elementData[0] = element;
		size++;
		
	}
	
	//返回当前链表的长度
	public int length(){
		return this.size;
	}
	
	//获得线性表的索引i的元素
	@SuppressWarnings("unchecked")
	public T get(int i){
		if(i<0 || i>size-1){
			throw new IndexOutOfBoundsException("线性表索引越界");
		}
		return (T)elementData[i];
	}
	
	//查找线性表的指定元素的索引
	public int locate(T element){
		for(int i = 0;i<size;i++){
			if(elementData[i].equals(element)){
				return i;
			}
		}
		return -1;//没找着
	}
	
	//向指定线性表的位置插入一个元素
	public void insert(T element ,int index){
		if(index<0 || index>size){
			throw new IndexOutOfBoundsException("线性表索引越界");
		}
		ensureCapacity(size+1);//确保底层的数组够用
		/**
		 *  src - 源数组。
			srcPos - 源数组中的起始位置。
			dest - 目标数组。
			destPos - 目标数据中的起始位置。
			length - 要复制的数组元素的数量。 

		 */
		System.arraycopy(elementData, index, elementData, index+1, size-index);//把index的位值空出来
		elementData[index] = element;
		size++;
	}
	
	//在表尾插入数据
	public void add(T element){
		insert(element,size);
	}

	//把线性表扩展一位
	private void ensureCapacity(int minCapacity) {
		// 如果数组的原有长度小于目前所需的长度
		if(minCapacity > capacity){
			//不断的将capacity*2，直到capacity大于minCapacity
			capacity <<= 1;
		}
		elementData = Arrays.copyOf(elementData, capacity);
	}
	
	//删除索引出的元素,并返回索引处的元素
	@SuppressWarnings("unchecked")
	public T delete(int index){//******************?
		if(index<0||index>size-1){
			throw new IndexOutOfBoundsException("线性表索引越界");
		}
		T oldValue = (T)elementData[index];//把原先的值传出来再删
		int numMoved = size-index-1;
		if(numMoved > 0){
			//用覆盖来删除index的元素
			System.arraycopy(elementData, index+1, elementData, index, numMoved);//整体往前串一位
		}
		//清空最后一个元素
		elementData[--size] = null;
		return oldValue;
	}
	
	//删除线性表的最后一个元素,并返回它
	public T remove(){
		return delete(size-1);
	}
	
	//判断线性表是否为空
	public boolean empty(){
		return size == 0;
	}
	
	//清空线性表,全部制空
	public void clear(){
		Arrays.fill(elementData, null);
		size = 0;
	}
	
	//重写输出格式
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
