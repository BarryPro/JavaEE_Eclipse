package recursion.stack.reverse;

import java.util.Stack;
/**
 * ��ν��õݹ麯����ջ��������һ��ջ
 * @author Belong
 *
 */
public class Reverse {
	//�����˲���stack ջ�Ѿ��ǿյ���
	public int getAndRemoveLastElement(Stack<Integer> stack){//��ջstack��ջ��Ԫ�ط��ز��Ƴ�
		int result = stack.pop();//�ȷ���ջ��
		if(stack.empty()){//�ݹ�����ı�־
			return result; 
		} else{
			int last = getAndRemoveLastElement(stack);//����ջ��Ԫ��
			stack.push(result);//��ʱ��result��ջ�ĵ����ڶ���Ԫ�أ�������ջ��ֻ�ó�ջ��������ԭ���Żأ�
			return last;//����ջ�� ��������
		}		
	}
	
	public void reverse(Stack<Integer> stack){
		if(stack.empty()){//�ݹ��������
			return;
		} 
		int i = getAndRemoveLastElement(stack);
		reverse(stack);//ʵ�ֵ���ѹջû�ض���ջ��ѹ��ջ
		stack.push(i);
	}
}
