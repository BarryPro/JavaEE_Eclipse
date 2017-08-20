package com.belong.observer;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ConcreteSubject subject = new ConcreteSubject();

        subject.Attach(new ConcreteObserver(subject, "Observer A"));
        subject.Attach(new ConcreteObserver(subject, "Observer B"));
        subject.Attach(new ConcreteObserver(subject, "Observer C"));

        subject.setSubjectState("Ready");
        subject.Notify();
        
        subject.setSubjectState("Start");
        
        subject.Notify();
       
	}

}
