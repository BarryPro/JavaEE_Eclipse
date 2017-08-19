package org.crazyit.ioc.xml;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Ԫ�ؼ���ʵ����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class ElementLoaderImpl implements ElementLoader {

	private Map<String, Element> elements = new HashMap<String, Element>();

	public void addElements(Document doc) {
		List<Element> eles = doc.getRootElement().elements();
		for (Element e : eles) {
			String id = e.attributeValue("id");
			elements.put(id, e);
		}
	}

	public Element getElement(String id) {
		return elements.get(id);
	}
	
	public Collection<Element> getElements() {
		return this.elements.values();
	}
	
}
