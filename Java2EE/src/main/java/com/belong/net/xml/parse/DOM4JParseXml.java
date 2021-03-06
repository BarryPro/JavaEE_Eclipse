package com.belong.net.xml.parse;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.util.Iterator;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.belong.net.xml.bean.Address;
import com.belong.net.xml.bean.ReadXmlFileStream;  
  
/**
 * @Description: <p>DOM4J(Document Object Model for Java)</p>
 * 
 * 简单易用，采用Java集合框架，并完全支持DOM、SAX和JAXP
 *	【优点】
 *		①大量使用了Java集合类，方便Java开发人员，同时提供一些提高性能的替代方法。
 *		②支持XPath。
 *		③有很好的性能。
 *	【缺点】
 *		①大量使用了接口，API较为复杂。
 * 
 * @Author : belong
 * @Date : 2017年8月21日
 */
public class DOM4JParseXml {
	private static Address address = new Address();

	public static void main(String[] args) {
		long starttime = System.currentTimeMillis();
		try {
			InputStream in = ReadXmlFileStream.getXmlFileStream();
			Reader reader = new InputStreamReader(in, "utf-8"); // 注意编码问题
			SAXReader SaxReader = new SAXReader();
			Document doc = SaxReader.read(reader);
			Element root = doc.getRootElement();
			Element childNode = null;
			// 枚举名称为value的节点
			for (Iterator it = root.elementIterator("value"); it.hasNext();) {
				childNode = (Element) it.next();
				address.setNo(childNode.elementText("no"));
				address.setAddr(childNode.elementText("addr"));
				System.out.println(address);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("运行时间：" + (System.currentTimeMillis() - starttime) + " 毫秒");
	}
}
