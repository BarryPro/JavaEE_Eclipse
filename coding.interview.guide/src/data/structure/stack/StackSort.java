package data.structure.stack;

import java.util.Stack;
/**
 * ��һ��ջʵ����һ��ջ������
 * ����ջhelp
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
		int n = stack.size();//stack�ڱ�
		for(int i=0;i<n;i++){
			System.out.println(stack.pop());
		}
	}
	//*�ð�����Ԫ�طŵ�help��ջ��
	public void fun(Stack<Integer> stack){
		Stack<Integer> help = new Stack<Integer>();//����ջ����ջ����ջ����С����
		while(!stack.isEmpty()){
			int cur = stack.pop();//���ڴ����ʱֵ
			while(!help.isEmpty()&&help.peek()<cur){
				stack.push(help.pop());//��stack��ֵ������help���ֵ�ǰ�help���ֵ�ŵ�stackջ��
			}
			help.push(cur);//��stack��ֵС��help���ֵʱ���Ѵ�����ݴ���helpջ����֤�ð�����Ԫ�طŵ�help��ջ�ף�
		}
		while(!help.isEmpty()){
			stack.push(help.pop());//����ջ����ջ���ɴ�С��
		}
		
	}
}
