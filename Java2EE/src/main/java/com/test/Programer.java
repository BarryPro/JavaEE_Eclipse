package com.test;

public class Programer extends Person {   
    private Computer computer;  
    static final int a = 1;
  
    public Programer() {  
        this.computer = new Computer();  
    }  

    public static void main(String[] args) {
        try{

        }catch(Exception e){

        }
    }
    
    @Deprecated
    public void working(){  
        int tmp = 0;
        computer.working();  

    }  
}  