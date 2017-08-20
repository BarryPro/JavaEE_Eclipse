package com.belong.command;

/**
 * 客户类
 * 命令模式可以很好的将调用者个作出动作的接收者进行解耦
 * @author belong
 * 
 */
public class Client {
	public static void main(String[] args) {  
		Receiver receiver = new Receiver();  
		// 设定命令的接受者
		Command command = new ConcreteCommand(receiver); 
		// 使用调用器来进行调用命令
		Invoker invoker = new Invoker();  
		invoker.request(command); 
	}  
}
