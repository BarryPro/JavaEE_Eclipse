package com.belong.net.xml.bean;

import java.io.InputStream;

/**
 * @Description: <p></p>
 * @Author : belong
 * @Date : 2017年8月21日
 */
public class ReadXmlFileStream {
	private static final String XML_FILE = "com/belong/net/xml/addresses.xml";  
	  
    public static InputStream getXmlFileStream() {  
        return Thread.currentThread().getContextClassLoader()  
                .getResourceAsStream(XML_FILE);  
    }  
}
