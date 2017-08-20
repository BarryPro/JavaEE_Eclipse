package com.belong.command;

/** 
 * 命令调用者
 * 负责调用命令
 * @author belong 
 *  
 */  
public class Invoker {  
    public void request(Command command) {  
        command.exceute();  
    }  
}  
