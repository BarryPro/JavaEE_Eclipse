package com.belong.cadapter;
/**
 * 适配器包装类Wrapper
 * @author belong
 *
 */
public class Adapter extends Adaptee implements Target{
    public void request() {
        super.SpecificRequest();        
    } 
}
