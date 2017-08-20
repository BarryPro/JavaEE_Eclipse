package com.belong.adapter;

public class Adapter implements Target{
    private Adaptee adapteet=new Adaptee();

	@Override
	public void request() {
		// TODO Auto-generated method stub
		 adapteet.SpecificRequest();
	}
     
   

	
}
