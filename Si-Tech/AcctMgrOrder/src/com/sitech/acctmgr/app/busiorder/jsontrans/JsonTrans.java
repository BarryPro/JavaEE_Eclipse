package com.sitech.acctmgr.app.busiorder.jsontrans;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.app.busiorder.cachecfg.BusiKeyCache;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.jcfx.dt.MBean;

public class JsonTrans extends BaseBusi {

	//BusiKeyCache keyCache;
	
	/**
	 * @description 转换Json报文中Key为Boss系统可识别Key
	 * @param inBusiCode
	 * @param jsonBean
	 * @return jsonBean
	 */
	public MBean transJsonInter(String inBusiCode, MBean jsonBean) {
		
		if (jsonBean == null || jsonBean.isEmpty())
			return jsonBean;
		
		//查询对应转换配置
		List<Map<String, Object>> keyCfgList = getKeyConfig(inBusiCode);
		if (keyCfgList == null || keyCfgList.isEmpty()) {
			log.debug("业务工单标识["+inBusiCode+"],无转换KEY配置，不转换。");
			return jsonBean;
		}
		
		Map<String, Object> header = jsonBean.getHeader();
		Map<String, Object> body = jsonBean.getBody();
		
		//输出转换的报文
		String rootKey = "";
		String valType = "";
		String srcKey = "";
		String desKey = "";
		Object obj = null;
		for (Map<String, Object> keysMap:keyCfgList) {

			srcKey = keysMap.get("SRC_KEY").toString();
			desKey = keysMap.get("DEST_KEY").toString();
			//valType = keysMap.get("VALUE_TYPE").toString();
			
			rootKey = keysMap.get("ROOT_KEY").toString();
			if (rootKey.equals("H")) {
				obj = removeSrcKey(srcKey, header);
				if (obj != null) {
					if (false == addDestKey(obj, desKey, header)) {
						return jsonBean;
					}
				} else {
					continue; 
				}
			} else if (rootKey.equals("B")) {
				//回调函数处理
				obj = removeSrcKey(srcKey, body);
				if (obj != null) {
					if (false == addDestKey(obj, desKey, body)) {
						return jsonBean;
					}
				} else {
					continue; 
				}
			}
		}
		jsonBean.setBody(body);
		jsonBean.setHeader(header);
		log.debug("-转换后的报文-jsonMbean:["+jsonBean.toString()+"]");
		
		return jsonBean;
	}

	
	private List<Map<String, Object>> getKeyConfig(String inBusiCode) {

		List<Map<String, Object>> keyList = BusiKeyCache.getKeys(inBusiCode);
		/*if (keyList == null || keyList.isEmpty()) {
			Map<String, Object> inMap = new HashMap<String, Object>();
			inMap.put("BUSI_CODE", inBusiCode);
			keyList = baseDao.queryForList("in_busikey_dict.qkeysBybusicode", inMap);
		}*/
		
		return keyList;
	}
	
	private boolean addDestKey(Object obj, String desKey, Map<String, Object> dest_map) {
		int pot_index = 0;
		String[] key_array = desKey.split("\\.");
		if (1 == key_array.length) {
			dest_map.put(desKey, obj);
		} else if (1 < key_array.length) {
			pot_index = desKey.indexOf('.');
			addDestKey(obj, desKey.substring(pot_index + 1),
					(Map<String, Object>) dest_map.get(desKey.substring(0, pot_index)));
		} else {
			return false;
		}
		return true;
	}

	private Object removeSrcKey(String rep_key, Map<String, Object> src_map) {
		int pot_index = 0;
		Object obj = null;
		String[] key_array = rep_key.split("\\.");
		if (1 == key_array.length) {
			obj = src_map.get(rep_key);
			//src_map.remove(rep_key);
		} else if (1 < key_array.length) {
			pot_index = rep_key.indexOf('.');
			obj = removeSrcKey(rep_key.substring(pot_index + 1),
					(Map<String, Object>) src_map.get(rep_key.substring(0, pot_index)));
		}
		return obj;
	}
	
}
