package com.belong.observer;

/// ����۲��߻����֪ͨ�ߣ����й�״̬�������۲��߶����ھ���������ڲ�״̬�ı�ʱ��
//�����еǼǹ��Ĺ۲��߷���֪ͨ�����������ɫͨ����һ����������ʵ�֡�
/// </summary>
public class ConcreteSubject extends Subject{
    private String subjectState;

	public String getSubjectState() {
		return subjectState;
	}

	public void setSubjectState(String subjectState) {
		this.subjectState = subjectState;
	}

}
