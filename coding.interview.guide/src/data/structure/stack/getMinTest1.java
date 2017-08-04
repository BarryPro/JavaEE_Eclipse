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
 * 设计一个有getMin功能的栈 * 
 * @author belong 
 * 方法一
 * 优点：入栈省时
 * 缺点：出栈费时
 */
class MyStack1 {
	private Stack<Integer> stackData;
	private Stack<Integer> stackMin;

	public MyStack1() {
		this.stackData = new Stack<Integer>();
		this.stackMin = new Stack<Integer>();
	}

	/**
	 * 入栈	 * 
	 * @param newNum 要入栈的新数
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
	 * 返回stackData的栈顶	 * 
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
	 * 返回stackMin的栈顶只是查看不删除	 * 
	 * @return
	 */
	public int getMin() {
		if (this.stackMin.isEmpty()) {
			throw new RuntimeException("your stack is empty.");
		}
		return this.stackMin.peek();
	}
}