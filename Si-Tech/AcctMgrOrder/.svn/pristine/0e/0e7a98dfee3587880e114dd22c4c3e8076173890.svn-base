package com.sitech.acctmgr.app.common;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.ResourceBundle.Control;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * <p>Title: 公共配置测试类  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class ConfigUtils {

	private static final Logger log = LoggerFactory
			.getLogger(ConfigUtils.class);
	private static final String DEFAULT_CONFIG_FILE = "log4j";
	private static Map prop;

	public static HashMap getMap(String resourceFileName) {
		ResourceBundle bundle = ResourceBundle.getBundle(resourceFileName);
		Enumeration keys = bundle.getKeys();
		HashMap map = new HashMap();
		while (keys.hasMoreElements()) {
			String key = (String) keys.nextElement();
			String value = bundle.getString(key);
			value = (value == null) ? "" : value.trim();
			log.info(value);

			map.put(key, value);
		}
		return map;
	}

	public static String getConfig(String sourceFile, String key) {
		ResourceBundle bundle = ResourceBundle.getBundle(sourceFile);
		String value = bundle.getString(key);
		if (log.isInfoEnabled()) {
			log.info("Read config in " + sourceFile + " '" + key + "' = "
					+ value);
		}

		return value;
	}

	public static String getConfigByMap(String key) {
		String value = (String) prop.get(key);
		if (value != null)
			return value.trim();

		return value;
	}

	public static String getConfigByFile(String key) {
		ResourceBundle bundle = ResourceBundle.getBundle(DEFAULT_CONFIG_FILE);
		String value = bundle.getString(key);
		if (log.isInfoEnabled())
			log.info("Read config '" + key + "' = " + value);

		if (value != null)
			return value.trim();

		return value;
	}

	static {
		prop = getMap(DEFAULT_CONFIG_FILE);

		if (log.isInfoEnabled()) {
			log.info("ConfigUtils: read DEFAULT_CONFIG_FILE = "
					+ DEFAULT_CONFIG_FILE + ".properties");

		}
	}

	/**
	 * 名称：
	 * 
	 * @param
	 * @return
	 * @throws
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("log4j.rootLogger="
				+ getConfigByMap("log4j.rootLogger"));
	}

}
