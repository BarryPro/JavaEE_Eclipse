package org.crazyit.ioc.xml;

import java.util.Collection;

import IoC.main.org.crazyit.ioc.xml.ElementLoader;
import IoC.main.org.crazyit.ioc.xml.ElementLoaderImpl;
import IoC.main.org.crazyit.ioc.xml.XmlDocumentHolder;
import junit.framework.TestCase;

public class ElementLoaderTest extends TestCase {

	XmlDocumentHolder holder;
	
	ElementLoader elementLoader;
	
	protected void setUp() throws Exception {
		holder = new XmlDocumentHolder();
		elementLoader = new ElementLoaderImpl();
	}

	protected void tearDown() throws Exception {
		holder = null;
		elementLoader = null;
	}

	public void testGetElements() {
		String filePath = "test/resources/ElementLoader.xml";
		Document doc = holder.getDocument(filePath);
		elementLoader.addElements(doc);
		Element e = elementLoader.getElement("test1");
		assertNotNull(e);
		System.out.println(e);
		
		Collection<Element> es = elementLoader.getElements();
		System.out.println(es.size());
	}
	
}
