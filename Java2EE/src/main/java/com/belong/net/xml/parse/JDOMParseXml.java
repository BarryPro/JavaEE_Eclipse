package com.belong.net.xml.parse;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import com.belong.net.xml.bean.Address;
import com.belong.net.xml.bean.ReadXmlFileStream;
/**
 * @Description: <p></p>
 * @Author : belong
 * @Date : 2017年8月21日
 */
public class JDOMParseXml {
	private static Address address = new Address();

	public static void main(String[] args) {
		long lasting = System.currentTimeMillis();
		try {
			SAXBuilder builder = new SAXBuilder();
			InputStream in = ReadXmlFileStream.getXmlFileStream();
			Document doc = builder.build(in);
			Element root = doc.getRootElement();
			List allChildren = root.getChildren();
			for (int i = 0; i < allChildren.size(); i++) {
				address.setNo(((Element) allChildren.get(i)).getChild("no").getTextTrim());
				address.setAddr(((Element) allChildren.get(i)).getChild("addr").getTextTrim());
				System.out.println(address);
			}
		} catch (JDOMException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("运行时间：" + (System.currentTimeMillis() - lasting) + " 毫秒");
	}
}
