package org.crazyit.ioc.xml.property;

import IoC.main.org.crazyit.ioc.xml.construct.DataElement;

/**
 * property�ڵ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class PropertyElement {

	//propertyԪ�ص�name����ֵ
	private String name;
	
	//propertyԪ���µ�ref����value���Զ���
	private DataElement dataElement;

	public PropertyElement(String name, DataElement dataElement) {
		this.name = name;
		this.dataElement = dataElement;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public DataElement getDataElement() {
		return dataElement;
	}

	public void setDataElement(DataElement dataElement) {
		this.dataElement = dataElement;
	}

}
