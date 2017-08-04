package data.structure.twostack;

import java.util.Stack;
/**
 * ������ջ��ʵ�ֶ��еĹ���
 * @author belong
 *
 */
public class TwoStack {
	private Stack<Integer> stackPush;//����ѹ���ջ
	private Stack<Integer> stackPop;//���𵯳���ջ
	
	public TwoStack(){
		this.stackPop = new Stack<Integer>();
		this.stackPush = new Stack<Integer>();
	}
	
	public void add(Integer pushInt){//����
		this.stackPush.push(pushInt);
	}
	
	public Integer poll(){//���У�ɾ��ͷ��
		if(stackPop.isEmpty()&&stackPush.isEmpty()){
			throw new RuntimeException("Queue is empty!");
		} else if(stackPop.empty()){ //��֤ ������ջ�ǿյ�
			while(!stackPush.empty()){//ѹ���ջ���ǿյ� �Ͱ�ѹջ��Ԫ�ش��Ե�ȫ����ѹ��������ջ��
				stackPop.push(stackPush.pop());
			}
		}
		return stackPop.pop();
	}
	
	public Integer peek(){//����ͷ����ɾ����
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
