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
 * 设计一个有getMin功能的栈
 * @author belong
 * 方法二
 * 优点：出栈省时
 * 缺点：入栈费时
 */
class MyStack2{
	private Stack<Integer> stackData;
	private Stack<Integer> stackMin;//存小栈 从栈底到栈顶是从小到大排列
	public MyStack2(){
		this.stackData = new Stack<Integer>();
		this.stackMin = new Stack<Integer>();
	}
	/**
	 * 要入栈的新元素
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
	 * 返回数据栈的栈顶元素
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
	 * 返回stackMin的栈顶也就是最小元素
	 * @return
	 */
	public int getMin(){
		if(this.stackMin.isEmpty()){
			throw new RuntimeException("your stack is empty.");
		}
		return this.stackMin.peek();
	}
}