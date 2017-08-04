package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class StringToMapTest {
	public static void main(String[] args) {
		String result = "{status:\"3|6\",charge:\"30|50\"}";
		// String aa = result.replace("=", ":");
		JSONObject jsonStr = JSON.parseObject(result);
		Map<String, Object> inMap = jsonStr;
		System.err.println(inMap);
	}
}
