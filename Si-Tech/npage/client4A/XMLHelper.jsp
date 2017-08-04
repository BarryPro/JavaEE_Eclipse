<%
/********************
 version v1.0
 ������ si-tech
 ningtn 2012-3-15 09:30:18
********************/
%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>

<%@ page import="org.dom4j.Attribute"%>
<%@ page import="org.dom4j.Document"%>
<%@ page import="org.dom4j.DocumentException"%>
<%@ page import="org.dom4j.DocumentHelper"%>
<%@ page import="org.dom4j.Element"%>
<%@ page import="org.dom4j.io.SAXReader"%>
<%!
	public Document CreateXMLDocument(String inputXml, String createType) {
		/**
		 * createType:file ����xmlģ��·�������ļ��� createType:str ����xml���Ĵ����ļ���
		 * */
		Document document = null;
		SAXReader saxReader = new SAXReader();
		try {
			if ("file".equals(createType)) {
				document = saxReader.read(inputXml);
			} else if ("str".equals(createType)) {
				document = DocumentHelper.parseText(inputXml);
			}
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return document;
	}

	public String doc2String(Document document) {
		String s = "";
		try {
			// ByteArrayOutputStream out = new ByteArrayOutputStream();
			// OutputFormat format = new OutputFormat(" ", true, "UTF-8");
			// XMLWriter writer = new XMLWriter(out, format);
			// writer.write(document);
			// s = out.toString("UTF-8");
			s = document.asXML();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public Document updateElementAttribute(Document document,
			String elementName, String attributeName, String newAttrValue) {
		/**
		 * �޸�xml���Ľڵ������ �ѽڵ���ΪelementName��������ΪattributeName��ֵ��ȫ���滻��newAttrValue
		 * elementName �ڵ��� attributeName Ҫ�޸ĵĽڵ�������� newAttrValue Ҫ���ڵ�����׼���޸ĵ�����
		 * */
		String fullName = "//" + elementName + "/@" + attributeName;
		List list = document.selectNodes(fullName);
		Iterator iter = list.iterator();
		while (iter.hasNext()) {
			Attribute attribute = (Attribute) iter.next();
			attribute.setValue(newAttrValue);
		}
		return document;
	}

	public Document updateElementAttribute(Document document,
			String elementName, String attributeName, String oldAttrValue,
			String newAttrValue) {
		/**
		 * �޸�xml���Ľڵ������ �ѽڵ���ΪelementName��������ΪattributeName��,ֵΪoldAttrValue������ֵ��
		 * ȫ���滻��newAttrValue elementName �ڵ��� attributeName Ҫ�޸ĵĽڵ��������
		 * oldAttrValue Ҫ�޸ĵĽڵ��ֵ newAttrValue Ҫ���ڵ�����׼���޸ĵ�����
		 * */
		String fullName = "//" + elementName + "/@" + attributeName;
		List list = document.selectNodes(fullName);
		Iterator iter = list.iterator();
		while (iter.hasNext()) {
			Attribute attribute = (Attribute) iter.next();
			if (attribute.getValue().equals(oldAttrValue)) {
				attribute.setValue(newAttrValue);
			}
		}
		return document;
	}

	public Document updateElementText(Document document, String elementName,
			String newTextValue) {
		/**
		 * �޸�xml���Ľڵ㣬��ȫ���ڵ���ΪelementName���ı�ֵ��ΪnewTextValue
		 * */
		String fullName = "//" + elementName;
		List list = document.selectNodes(fullName);
		Iterator iter = list.iterator();
		while (iter.hasNext()) {
			Element element = (Element) iter.next();
			element.setText(newTextValue);
		}
		return document;
	}

	public Document updateElementText(Document document, String elementName,
			String oldTextValue, String newTextValue) {
		/**
		 * �޸�xml���Ľڵ㣬�ѽڵ���ΪelementNameֵΪoldTextValue���ı�ֵ��ΪnewTextValue
		 * */
		String fullName = "//" + elementName;
		List list = document.selectNodes(fullName);
		Iterator iter = list.iterator();
		while (iter.hasNext()) {
			Element element = (Element) iter.next();
			if (element.getText().equals(oldTextValue)) {
				element.setText(newTextValue);
			}
		}
		return document;
	}

	public List getElementText(Document document, String elementName) {
		String fullName = "//" + elementName;
		List list = document.selectNodes(fullName);
		List returnList = new ArrayList();
		Iterator iter = list.iterator();
		while (iter.hasNext()) {
			Element element = (Element) iter.next();
			returnList.add(element.getText());
		}
		return returnList;
	}
%>