package com.sitech.acctmgr.comp.impl.jl.pay;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.dto.pay.S8000CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8000CfmOutDTO;
import com.sitech.acctmgr.common.domains.LoginPdomEntity;
import com.sitech.acctmgr.comp.dto.pay.S8000CompInitInDTO;
import com.sitech.acctmgr.comp.dto.pay.S8000CompInitOutDTO;
import com.sitech.acctmgr.comp.impl.pay.S8000Comp;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */

@ParamTypes({
	@ParamType(m = "init", c = S8000CompInitInDTO.class, oc = S8000CompInitOutDTO.class, routeKey = "10", 
		 routeValue = "phone_no", busiComId = "构件id", srvCat = "缴费", srvCnName = "缴费校验服务", 
		 srvVer = "V10.8.126.0", srvDesc = "缴费校验服务",srcAttr = "核心", srvLocal = "否", srvGroup = "否")
})
public class S8000CompJL extends S8000Comp{

	/**
	* 名称：
	* @param  无
	* @return 返回缴费查询需要校验的小权限列表
	*/
	protected List<Map<String, Object>> getPdomList() {
		
		List<Map<String, Object>> pdomList = new ArrayList<Map<String, Object>>();
		Map<String, Object> inMap1 = new HashMap<String, Object>();
		inMap1.put("BUSI_CODE", "a030"); // 跨地市缴费小权限
		pdomList.add(inMap1);

		Map<String, Object> inMap2 = new HashMap<String, Object>();
		inMap2.put("BUSI_CODE", "a034"); // 跨区县缴费小权限
		pdomList.add(inMap2);

		Map<String, Object> inMap3 = new HashMap<String, Object>();
		inMap3.put("BUSI_CODE", "a040"); // 违约金费优惠小权限
		pdomList.add(inMap3);		
		
		return pdomList;
	} 
	
	
	/**
	* 名称：获取是否有滞纳金优惠权限
	* 功能：作为出参返回，供前台使用
	* @param  List<LoginPdomEntity>, 调用基础域接口获取的所有工号小权限列表
	* @return Y-有权限，N-没有权限
	*/
	protected String isDelayPdom(List<LoginPdomEntity> inParam){
		
		String a040PdomFlag = "Y"; // 跨地市缴费权限标识
		for (LoginPdomEntity loginPdom : inParam) {

			if (loginPdom.getBusiCode().equals("a040")) { 		// 违约金费优惠小权限

				a040PdomFlag = loginPdom.getCheckFlag();
			}
		}
		
		return a040PdomFlag;
	}
}
