package com.sitech.acctmgrint.atom.busi.intface.cfgcache;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.configuration.reloading.FileChangedReloadingStrategy;

public final class DataBaseConst {
	
	private static PropertiesConfiguration config;
	static {
		try {
			config = new PropertiesConfiguration("ijdbc.properties");
			config.setReloadingStrategy(new FileChangedReloadingStrategy());
		} catch (ConfigurationException e) {
			e.printStackTrace();
		}
	}

	//消息中间件配置
	public static final int    load_data  = Integer.parseInt(config.getString("LOAD_DATA"));
	public static final int    maxperkey  = Integer.parseInt(config.getString("MAX_PER_KEY"));
	public static final int process_time  = Integer.parseInt(config.getString("PROCESS_TIME"));
	public static final int     time_out  = Integer.parseInt(config.getString("TIME_OUT")); 
	public static final boolean compress  = Boolean.parseBoolean(config.getString("COMPRESS"));
	public static final String pub_client = config.getString("PUB_CLIENT");
	public static final String data_topic = config.getString("DATA_TOPIC");
	public static final String addr       = config.getString("ADDR");
	public static final String dataSource = config.getString("DATASOURCE");
	
}
