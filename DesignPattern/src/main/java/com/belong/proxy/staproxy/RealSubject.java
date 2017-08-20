package com.belong.proxy.staproxy;

public class RealSubject implements Subject{      
    
    public void print(){      
        System.out.println("RealSubject HelloWorld");
    }
}  
