package com.sitech.acctmgr.comp.impl.pay;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.dto.pay.S8000CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8000CfmOutDTO;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.domains.LoginPdomEntity;
import com.sitech.acctmgr.comp.busi.LoginCheck;
import com.sitech.acctmgr.comp.dto.pay.S8000CompInitInDTO;
import com.sitech.acctmgr.comp.dto.pay.S8000CompInitOutDTO;
import com.sitech.acctmgr.inter.pay.I8000;
import com.sitech.acctmgr.inter.pay.I8000Co;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.service.client.ServiceUtil;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Title: 缴费组合服务层
 * Description:
 * Copyright: Copyright (c) 2014
 * Company: SI-TECH
 * 
 * @author qiaolin
 * @version 1.0
 */


public class S8000Comp extends AcctMgrBaseService implements I8000Co {

	protected LoginCheck logincheck;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sitech.acctmgr.inter.I8000#s8000Init(java.lang.String)
	 */
	@Override
	public final OutDTO init(final InDTO inParam) {
		
		S8000CompInitInDTO inDto = (S8000CompInitInDTO) inParam;

		//1、获取需要校验的小权限代码
		List<Map<String, Object>> inPdomList = getPdomList();

		//2、调用基础域接口获取小权限
		List<LoginPdomEntity> outPdomList = null;
		if(inPdomList != null){
			Map<String, Object> inPdom = new HashMap<String, Object>();
			inPdom.put("LOGIN_NO", inDto.getLoginNo());
			inPdom.put("BUSIPRIVS_LIST", inPdomList);
			outPdomList = logincheck.pchkFuncPowerList(inDto.getHeader(), inPdom);
		}
		log.info("调用获取小权限方法后结果：" + outPdomList.toString());
		
		//调用接口获取押金信息
		
		
		

		//4、调用缴费查询原子服务8000init
		MBean initIn = new MBean(inDto.getMbean().toString());
		initIn.addBody("BUSI_INFO.LOGIN_PDOM", outPdomList);
		log.info("调用缴费查询前：" + initIn);
		
		String interfaceName = "com_sitech_acctmgr_inter_pay_I8000Svc_init";
		String outString = ServiceUtil.callService(interfaceName, initIn.toString());
		
		log.info("调用缴费查询接口完成:" + outString);

		MBean mb = new MBean(outString);
		String jsonStr = JSON.toJSONString(mb.getBodyObject("OUT_DATA"));
		S8000CompInitOutDTO outDto = JSON.parseObject(jsonStr,S8000CompInitOutDTO.class);
		outDto.setA040Pdom(isDelayPdom(outPdomList));

		return outDto;
	}
	

	/**
	* 名称：获取需要校验的小权限列表
	* @param  无
	* @return 返回缴费查询需要校验的小权限列表
	*/
	protected List<Map<String, Object>> getPdomList() {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	* 名称：获取是否有滞纳金优惠权限
	* 功能：作为出参返回，供前台使用
	* @param  List<LoginPdomEntity>, 调用基础域接口获取的所有工号小权限列表
	* @return Y-有权限，N-没有权限
	*/
	protected String isDelayPdom(List<LoginPdomEntity> inParam){
		
		return "Y";
	}


	public LoginCheck getLogincheck() {
		return logincheck;
	}

	public void setLogincheck(LoginCheck logincheck) {
		this.logincheck = logincheck;
	}

}
