package org.crazyit.ioc.beans.factory;

import IoC.main.org.crazyit.ioc.context.AbstractApplicationContext;

/**
 * Bean��������, �����ʼ��ʱ�������κεĶ���
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class XmlBeanFactory extends AbstractApplicationContext {

	public XmlBeanFactory(String[] xmlPaths) {
		//ֻ��ʼ���ĵ�, �������κ�bean
		super.setUpElements(xmlPaths);
	}
}
