package com.belong.face;

/**
 * 
 * @description <p>门面类，把所有模块集成一个按钮</p>
 *
 * @author belong
 */
public class Facade {  
    public void test(){  
        ModuleA a = new ModuleA();  
        a.testA();  
        ModuleB b = new ModuleB();  
        b.testB();  
        ModuleC c = new ModuleC();  
        c.testC();  
    }  
}  
