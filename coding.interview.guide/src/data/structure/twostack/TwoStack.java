package data.structure.twostack;

import java.util.Stack;
/**
 * 用两个栈来实现队列的功能
 * @author belong
 *
 */
public class TwoStack {
	private Stack<Integer> stackPush;//负责压入的栈
	private Stack<Integer> stackPop;//负责弹出的栈
	
	public TwoStack(){
		this.stackPop = new Stack<Integer>();
		this.stackPush = new Stack<Integer>();
	}
	
	public void add(Integer pushInt){//入列
		this.stackPush.push(pushInt);
	}
	
	public Integer poll(){//出列（删除头）
		if(stackPop.isEmpty()&&stackPush.isEmpty()){
			throw new RuntimeException("Queue is empty!");
		} else if(stackPop.empty()){ //保证 弹出的栈是空的
			while(!stackPush.empty()){//压入的栈不是空的 就把压栈的元素次性的全部都压到弹出的栈中
				stackPop.push(stackPush.pop());
			}
		}
		return stackPop.pop();
	}
	
	public Integer peek(){//检查队头（不删除）
		if(stackPop.isEmpty()&&stackPush.isEmpty()){
			throw new RuntimeException("Queue is empty!");
		} else if(stackPop.empty()){
			while(!stackPush.empty()){
				stackPop.push(stackPush.pop());
			}
		}
		return stackPop.peek();
	}
}
