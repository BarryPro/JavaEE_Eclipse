package com.sitech.acctmgr.test.junit;

import com.alibaba.fastjson.JSON;

import java.util.HashMap;
import java.util.Map;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

public class ArgumentBuilder {
	
	private Map<String, Object> root = new HashMap<String, Object>();
	
	private Map<String, Object> body = new HashMap<String, Object>();
	private Map<String, Object> header = new HashMap<String, Object>();
	private Map<String, Object> busi = new HashMap<String, Object>();
	private Map<String, Object> route = new HashMap<String, Object>();
	private Map<String, Object> busiargs = new HashMap<String, Object>();
	private Map<String, Object> operargs = new HashMap<String, Object>();

	public ArgumentBuilder() {
	}
	
	public void setBusiargs(Map<String, Object> busiargs) {
		this.busiargs = busiargs;
	}
	
	public void setOperargs(Map<String, Object> operargs) {
		this.operargs = operargs;
	}
	
	private void build(){
		
		safeAddToMap(root, "ROOT", body);
		safeAddToMap(body, "BODY", busi);
		safeAddToMap(body, "HEADER", header);
		safeAddToMap(busi, "OPR_INFO", operargs);
		safeAddToMap(busi, "BUSI_INFO", busiargs);
		safeAddToMap(header, "DB_ID", "");
		safeAddToMap(header, "ENV_ID", "");
		safeAddToMap(header, "POOL_ID", "11");
		safeAddToMap(route, "ROUTE_VALUE", "");
		safeAddToMap(route, "ROUTE_KEY", "");
		safeAddToMap(header, "ROUTING", route);
		safeAddToMap(header, "PROVINCE_GROUP", "HLJ");

	}
	
	public String toString() {
		this.build();
		return JSON.toJSONString(root);
	}
}
