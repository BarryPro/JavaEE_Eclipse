package data.structure.stack;

import java.util.Stack;

public class getMinTest2 {
	public static void main(String[] args) {
		MyStack1 stack = new MyStack1();
		stack.push(3);
		stack.push(4);
		stack.push(5);
		stack.push(1);
		stack.push(2);
		stack.push(1);
		System.out.println("MinNum is :"+stack.getMin());
		for(int i = 0;i<6;i++){
			System.out.println(stack.pop());			
		}	
	}
}
/**
 * ���һ����getMin���ܵ�ջ
 * @author belong
 * ������
 * �ŵ㣺��ջʡʱ
 * ȱ�㣺��ջ��ʱ
 */
class MyStack2{
	private Stack<Integer> stackData;
	private Stack<Integer> stackMin;//��Сջ ��ջ�׵�ջ���Ǵ�С��������
	public MyStack2(){
		this.stackData = new Stack<Integer>();
		this.stackMin = new Stack<Integer>();
	}
	/**
	 * Ҫ��ջ����Ԫ��
	 * @param newNum
	 */
	public void push(Integer newNum){
		if(this.stackMin.isEmpty()){
			this.stackMin.push(newNum);
		} else if(newNum < this.getMin()){
			this.stackMin.push(newNum);
		} else {
			this.stackMin.push(this.getMin());
		}
		this.stackData.push(newNum);
	}
	/**
	 * ��������ջ��ջ��Ԫ��
	 * @return
	 */
	public int pop(){
		if(this.stackData.isEmpty()){
			throw new RuntimeException("your stack is empty.");
		} 
		int value = this.stackData.pop();
		this.stackMin.pop();
		return value;
	}
	/**
	 * ����stackMin��ջ��Ҳ������СԪ��
	 * @return
	 */
	public int getMin(){
		if(this.stackMin.isEmpty()){
			throw new RuntimeException("your stack is empty.");
		}
		return this.stackMin.peek();
	}
}