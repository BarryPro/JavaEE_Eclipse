package com.belong.net.xml.parse;

import java.io.InputStream;
import java.util.Stack;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import com.belong.net.xml.bean.Address;
import com.belong.net.xml.bean.ReadXmlFileStream; 
/**
 * @Description: <p></p>
 * @Author : belong
 * @Date : 2017年8月21日
 */
public class SAXParseXml extends DefaultHandler {
	private static Address address = new Address();
	private Stack tags = new Stack();

	public SAXParseXml() {}

	@Override
	public void characters(char[] ch, int start, int length) throws SAXException {
		String tag = (String) tags.peek();
		if (tag.equals("no")) {
			address.setNo(new String(ch, start, length));
			System.out.println(address.getNo());
		}
		if (tag.equals("addr")) {
			address.setAddr(new String(ch, start, length));
			System.out.println(address.getAddr());
		}
	}

	@Override
	public void startElement(String uri, String localName, String qName, Attributes attrs) throws SAXException {
		tags.push(qName);
	}

	public static void main(String[] args) {
		long lasting = System.currentTimeMillis();
		try {
			SAXParserFactory factory = SAXParserFactory.newInstance();
			SAXParser sp = factory.newSAXParser();
			SAXParseXml reader = new SAXParseXml();
			InputStream in = ReadXmlFileStream.getXmlFileStream();
			sp.parse(new InputSource(in), reader);
			System.out.println("运行时间：" + (System.currentTimeMillis() - lasting) + " 毫秒");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
