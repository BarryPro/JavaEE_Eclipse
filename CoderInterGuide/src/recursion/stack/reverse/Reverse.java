package recursion.stack.reverse;

import java.util.Stack;
/**
 * 如何仅用递归函数和栈操作逆序一个栈
 * @author Belong
 *
 */
public class Reverse {
	//经过此操作stack 栈已经是空的了
	public int getAndRemoveLastElement(Stack<Integer> stack){//将栈stack的栈底元素返回并移除
		int result = stack.pop();//先返回栈顶
		if(stack.empty()){//递归结束的标志
			return result; 
		} else{
			int last = getAndRemoveLastElement(stack);//返回栈底元素
			stack.push(result);//此时的result是栈的倒数第二个元素，把它入栈（只拿出栈底其他的原样放回）
			return last;//返回栈底 结束函数
		}		
	}
	
	public void reverse(Stack<Integer> stack){
		if(stack.empty()){//递归结束条件
			return;
		} 
		int i = getAndRemoveLastElement(stack);
		reverse(stack);//实现倒序压栈没回都把栈底压入栈
		stack.push(i);
	}
}
