package com.sitech.acctmgr.common.utils;

import org.eclipse.jetty.util.log.Log;

import com.thoughtworks.xstream.XStream;

public class BeanToXmlUtils {
	static Log log = new Log();
	public static String trans(Object bean) {

		XStream xstream = new XStream();
		xstream.processAnnotations(bean.getClass());
		xstream.autodetectAnnotations(true);// 自动检测注解
		String xml = xstream.toXML(bean);
		String xmlArray[] = xml.split("<");
		StringBuffer sb = new StringBuffer();
		
		for (String xmlStr : xmlArray) {
			sb.append("<");
			if (xmlStr.length() > 0) {
				log.debug("&&" + xmlStr.substring(xmlStr.length() - 2, xmlStr.length() - 1) + "***"
						+ xmlStr.substring(xmlStr.length() - 1, xmlStr.length()).getBytes().length + ">>>>.");
			}
			if (xmlStr.length() > 0 && xmlStr.substring(xmlStr.length() - 1, xmlStr.length()).getBytes().length >= 2) {

				sb.append(xmlStr + " ");
			} else {
				sb.append(xmlStr);
			}
		}
		xml = sb.toString().replaceAll("^<\\?.*", "").replaceAll("\n", "").replaceAll("__", "_");
		xml = xml.substring(1, xml.length());
		return xml.toString();
	}
}
