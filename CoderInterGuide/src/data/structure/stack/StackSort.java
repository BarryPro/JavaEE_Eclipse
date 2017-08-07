package data.structure.stack;

import java.util.Stack;
/**
 * 用一个栈实现另一个栈的排序
 * 辅助栈help
 * @author Belong
 *
 */
public class StackSort {
	public static void main(String[] args) {
		Stack<Integer> stack = new Stack<Integer>();
		stack.push(3);
		stack.push(7);
		stack.push(8);
		stack.push(2);
		stack.push(1);
		new StackSort().fun(stack);
		int n = stack.size();//stack在变
		for(int i=0;i<n;i++){
			System.out.println(stack.pop());
		}
	}
	//*用把最大的元素放到help的栈底
	public void fun(Stack<Integer> stack){
		Stack<Integer> help = new Stack<Integer>();//辅助栈（从栈顶到栈底由小到大）
		while(!stack.isEmpty()){
			int cur = stack.pop();//用于存放临时值
			while(!help.isEmpty()&&help.peek()<cur){
				stack.push(help.pop());//当stack的值大于于help里的值是把help里的值放到stack栈里
			}
			help.push(cur);//当stack的值小于help里的值时，把打的数据打入help栈（保证用把最大的元素放到help的栈底）
		}
		while(!help.isEmpty()){
			stack.push(help.pop());//（从栈顶到栈底由大到小）
		}
		
	}
}
