package com.sitech.acctmgr.app.busiorder.jsontrans;

import java.util.Map;

import com.sitech.jcfx.dt.MBean;

public class testJsonTrans {

	private static boolean addDestKey(Object obj, String desKey, Map<String, Object> dest_map) {
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

	private static Object removeSrcKey(String rep_key, Map<String, Object> src_map) {

		int pot_index = 0;
		Object obj = null;
		String[] key_array = rep_key.split("\\.");

		if (1 == key_array.length) {
			obj = src_map.get(rep_key);
			src_map.remove(rep_key);

		} else if (1 < key_array.length) {
			pot_index = rep_key.indexOf('.');
			obj = removeSrcKey(rep_key.substring(pot_index + 1),
					(Map<String, Object>) src_map.get(rep_key.substring(0, pot_index)));
		} else {
			return null;
		}

		return obj;
	}
	
	public static void main(String[] args) {
		String sBosstestString = "{\"ROOT\":{\"HEADER\":{\"ROUTING\":{\"ROUTE_KEY\":\"\",\"ROUTE_VALUE\":\"\"}},\"BODY\":{\"BUSI_INFO\":{\"BUSI_CODE\":\"YKHJHZZ\",\"CONTRACT_NO\":\"\",\"ID_NO\":\"220400113504354022\",\"IS_PRINT\":\"N\",\"PAY_FEE\":\"1000\",\"PAY_METHOD\":\"j\",\"PAY_PATH\":\"11\",\"PAY_TYPE\":\"x\",\"PHONE_NO\":\"13504354022\"},\"OPR_INFO\":{\"LOGIN_NO\":\"crm123456\",\"OP_CODE\":\"1250\",\"OP_TIME\":\"20150519141458\",\"ORDER_LINE_ID\":\"JF100103510\"}}}}";
		MBean mBusiOdr = new MBean(sBosstestString);
		Map<String, Object> header = mBusiOdr.getHeader();
		Map<String, Object> body = mBusiOdr.getBody();

		Object obj = removeSrcKey("OPR_INFO.ORDER_LINE_ID", body);
		if (true == addDestKey(obj, "BUSI_INFO.FOREIGN_SN", body))
			System.out.println("----true----");
		System.out.println("--out return obj="+obj.toString());
		System.out.println("--end--mBusiOdr="+mBusiOdr.toString());
	}

}
