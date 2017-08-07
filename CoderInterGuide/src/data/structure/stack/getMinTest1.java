package data.structure.stack;

import java.util.Stack;

public class getMinTest1 {
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
 * ���һ����getMin���ܵ�ջ * 
 * @author belong 
 * ����һ
 * �ŵ㣺��ջʡʱ
 * ȱ�㣺��ջ��ʱ
 */
class MyStack1 {
	private Stack<Integer> stackData;
	private Stack<Integer> stackMin;

	public MyStack1() {
		this.stackData = new Stack<Integer>();
		this.stackMin = new Stack<Integer>();
	}

	/**
	 * ��ջ	 * 
	 * @param newNum Ҫ��ջ������
	 */
	public void push(Integer newNum) {
		if (stackMin.isEmpty()) {
			this.stackMin.push(newNum);
		} else if (newNum <= this.getMin()) {
			this.stackMin.push(newNum);
		}
		this.stackData.push(newNum);
	}

	/**
	 * ����stackData��ջ��	 * 
	 * @return
	 */
	public Integer pop() {
		if (this.stackData.empty()) {
			throw new RuntimeException("your stack is empty.");
		}
		int value = this.stackData.pop();
		if (value == this.getMin()) {
			this.stackMin.pop();
		}
		return value;
	}

	/**
	 * ����stackMin��ջ��ֻ�ǲ鿴��ɾ��	 * 
	 * @return
	 */
	public int getMin() {
		if (this.stackMin.isEmpty()) {
			throw new RuntimeException("your stack is empty.");
		}
		return this.stackMin.peek();
	}
}