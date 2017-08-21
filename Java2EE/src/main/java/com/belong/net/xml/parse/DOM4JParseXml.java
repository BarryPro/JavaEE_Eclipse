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
 * @Description: <p></p>
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
