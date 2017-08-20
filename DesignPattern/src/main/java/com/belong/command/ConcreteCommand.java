package com.belong.command;

/** 
 * 具体命令实现命令接口
 * 
 * @author belong
 *  
 */  
public class ConcreteCommand implements Command {  

	private Receiver receiver;  

	public ConcreteCommand(Receiver receiver) {  
		this.receiver = receiver;  
	}  
	@Override
	public void exceute() {
		// TODO Auto-generated method stub
		receiver.sendMessage();  
	}  
}  
