package org.crazyit.ioc.xml;

import java.util.Collection;

/**
 * Ԫ�ؼ��ؽӿ�
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public interface ElementLoader {
	
	/**
	 * ����һ��doc������Element
	 * @param doc
	 */
	void addElements(Document doc);
	
	/**
	 * ����Ԫ��id���Element����
	 * @param id
	 * @return
	 */
	Element getElement(String id);
	
	/**
	 * ����ȫ����Element
	 * @return
	 */
	Collection<Element> getElements();
}
