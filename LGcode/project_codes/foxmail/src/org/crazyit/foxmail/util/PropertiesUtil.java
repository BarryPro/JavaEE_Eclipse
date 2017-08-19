package org.crazyit.foxmail.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

import foxmail.src.org.crazyit.foxmail.exception.PropertiesException;
import foxmail.src.org.crazyit.foxmail.ui.MailContext;

/**
 * ���Թ�����
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class PropertiesUtil {

	
	/*
	 * �����ļ��õ���Ӧ��properties�ļ�
	 */
	private static Properties getProperties(File propertyFile) throws IOException {
		Properties prop = new Properties();
		FileInputStream fis = new FileInputStream(propertyFile);
		prop.load(fis);
		return prop;
	}

	/*
	 * ���������ļ��Ķ���������MailContext����
	 */
	public static MailContext createContext(File propertyFile) throws IOException {
		Properties props = getProperties(propertyFile);
		//���û������smtp�Ķ˿ڣ���ʹ��Ĭ�ϵ�25�˿�
		Integer smtpPort = getInteger(props.getProperty("smtpPort"), 25);
		//���û������pop3�Ķ˿ڣ���ʹ��Ĭ�ϵ�110�˿�
		Integer pop3Port = getInteger(props.getProperty("pop3Port"), 110);
		return new MailContext(null, 
				props.getProperty("account"), props.getProperty("password"), 
				props.getProperty("smtpHost"), smtpPort, 
				props.getProperty("pop3Host"), pop3Port);
	}
	
	//������sת����һ��Integer���󣬸��ַ���Ϊ���򷵻ز����е�Ĭ��ֵ
	private static Integer getInteger(String s, int defaultValue) {
		if (s == null || s.trim().equals("")) {
			return defaultValue;
		}
		return Integer.parseInt(s);
	}
	
	/*
	 * ����һ��MailContext���� ����������д���ļ���
	 */
	public static void store(MailContext ctx) {
		try {
			File propFile = new File(FileUtil.DATE_FOLDER + ctx.getUser() + 
					FileUtil.CONFIG_FILE);
			Properties prop = getProperties(propFile);
			prop.setProperty("account", ctx.getAccount());
			prop.setProperty("password", ctx.getPassword());
			prop.setProperty("smtpHost", ctx.getSmtpHost());
			prop.setProperty("smtpPort", String.valueOf(ctx.getSmtpPort()));
			prop.setProperty("pop3Host", ctx.getPop3Host());
			prop.setProperty("pop3Port", String.valueOf(ctx.getPop3Port()));
			FileOutputStream fos = new FileOutputStream(propFile);
			prop.store(fos, "These are mail configs.");
			fos.close();
		} catch (IOException e) {
			throw new PropertiesException("����ϵͳ�������ļ�, " + FileUtil.DATE_FOLDER + ctx.getUser() + 
					FileUtil.CONFIG_FILE);
		}
	}
}
