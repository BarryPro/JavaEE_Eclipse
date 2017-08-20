package com.reflect;



import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;

public class G {
	
	public static void main(String[] args) throws Exception{
		
		User u=new User();
		u.setName( "Winter Wei" );         

		// 如果不想把父类的属性也列出来的话，
		// 那 getBeanInfo 的第二个参数填写父类的信息
		BeanInfo bi = Introspector.getBeanInfo(u.getClass(), Object. class );
		PropertyDescriptor[] props = bi.getPropertyDescriptors();
		for ( int i=0;i<props.length;i++){	
			if(props[i].getName().equals("name")){
				props[i].getWriteMethod().invoke(u, "weiku" );
				System.out.println(props[i].getName()+ "=" +
						props[i].getReadMethod().invoke(u, null ));
			}
		} 
	}  
}
