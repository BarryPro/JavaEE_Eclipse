<%
/********************
 version v1.0
 开发商 si-tech
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
		 * createType:file 根据xml模板路径创建文件。 createType:str 根据xml报文创建文件。
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
		 * 修改xml报文节点的属性 把节点名为elementName的属性名为attributeName的值，全部替换成newAttrValue
		 * elementName 节点名 attributeName 要修改的节点的属性名 newAttrValue 要将节点属性准备修改的名字
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
		 * 修改xml报文节点的属性 把节点名为elementName的属性名为attributeName的,值为oldAttrValue的属性值，
		 * 全部替换成newAttrValue elementName 节点名 attributeName 要修改的节点的属性名
		 * oldAttrValue 要修改的节点的值 newAttrValue 要将节点属性准备修改的名字
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
		 * 修改xml报文节点，把全部节点名为elementName的文本值改为newTextValue
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
		 * 修改xml报文节点，把节点名为elementName值为oldTextValue的文本值改为newTextValue
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