package org.crazyit.ioc.context;

import java.util.List;

/**
 * Bean�����ӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface BeanCreator {

	/**
	 * ʹ���޲εĹ���������beanʵ��, �������κ�����
	 * @param className
	 * @return
	 */
	Object createBeanUseDefaultConstruct(String className);
	
	/**
	 * ʹ���в����Ĺ���������beanʵ��, �������κ�����
	 * @param className 
	 * @param args ��������
	 * @return
	 */
	Object createBeanUseDefineConstruce(String className, List<Object> args);

}
