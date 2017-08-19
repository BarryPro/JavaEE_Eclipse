package org.crazyit.ioc.xml;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import org.dom4j.io.SAXReader;

import IoC.main.org.crazyit.ioc.xml.exception.DocumentException;

/**
 * xml�ĵ�������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class XmlDocumentHolder implements DocumentHolder {

	private Map<String, Document> docs = new HashMap<String, Document>();
	
	public Document getDocument(String filePath) {
		Document doc = this.docs.get(filePath);
		if (doc == null) {
			//ʹ��SAXReader����ȡxml�ļ�
			this.docs.put(filePath, readDocument(filePath));
		}
		return this.docs.get(filePath);
	}
	
	/**
	 * �����ļ�·����ȡDocument
	 * @param filePath
	 * @return
	 */
	private Document readDocument(String filePath) {
		try {
			SAXReader reader = new SAXReader(true);
			reader.setEntityResolver(new IoCEntityResolver());
			File xmlFile = new File(filePath);
			Document doc = reader.read(xmlFile);
			return doc;
		} catch (Exception e) {
			e.printStackTrace();
			throw new DocumentException(e.getMessage());
		}
	}

}
