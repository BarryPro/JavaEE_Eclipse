package com.belong.observer;

/// <summary>
/// ����۲��ߣ�ʵ�ֳ���۲��߽�ɫ��Ҫ��ĸ��½ӿڣ����Ǳ���״̬������״̬��Э��
/// </summary>
public class ConcreteObserver extends Observer{
    private String observerState;
    private String name;
    private ConcreteSubject subject;

    /// <summary>
    /// ����۲�����һ������������ʵ��
    /// </summary>
    
    public ConcreteObserver(ConcreteSubject subject, String name){
        this.subject = subject;
        this.name = name;
    }

    public ConcreteSubject getSubject() {
		return subject;
	}

	public void setSubject(ConcreteSubject subject) {
		this.subject = subject;
	}

	/// <summary>
    /// ʵ�ֳ���۲����еĸ��²���
    /// </summary>
    @Override
    public  void Update(){
       observerState = subject.getSubjectState();
       System.out.println("The observer's state of "+name+" is "+ observerState);
    }
}
