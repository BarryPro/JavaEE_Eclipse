package com.sitech.acctmgr.app.common;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.configuration.reloading.FileChangedReloadingStrategy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 *
 * <p>Title: 读取app配置文件  </p>
 * <p>Description: 读取可刷新的配置文件  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class AppProperties {
	
	private static final Logger log = LoggerFactory.getLogger(AppProperties.class);
	private static PropertiesConfiguration config;
	
	static {
		config = null;
		try {
			config = new PropertiesConfiguration("app.properties");
			config.setReloadingStrategy(new FileChangedReloadingStrategy());
		} catch (ConfigurationException e) {
			e.printStackTrace();
		}

	}


	public static String getConfigByMap(String key) {

		String value = config.getString(key);
		if (value != null)
			return value.trim();

		return value;
	}
	
	/**
	 * 名称：
	 * @param 
	 * @return 
	 * @throws InterruptedException
	 */
	public static void main(String[] args) throws InterruptedException {
		// TODO Auto-generated method stub
		//TopicProperties topicConfig = new TopicProperties();
		while(true)
		{
			log.info(AppProperties.getConfigByMap("APP_NAME"));
			
			Thread.currentThread().sleep(5000);
		}
	}

}
