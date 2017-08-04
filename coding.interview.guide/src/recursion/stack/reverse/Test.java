package recursion.stack.reverse;

import java.util.Stack;

public class Test {
	public static void main(String[] args) {
		Stack<Integer> stack = new Stack<Integer>();
		stack.push(1);
		stack.push(2);
		stack.push(3);
//		for(int i = 0;i<3;i++){
//			System.out.println(stack.pop());
//		}
		new Reverse().reverse(stack);//ÊµÏÖµ¹Ðò
		for(int i = 0;i<3;i++){
			System.out.println(stack.pop());
		}
	}
}
