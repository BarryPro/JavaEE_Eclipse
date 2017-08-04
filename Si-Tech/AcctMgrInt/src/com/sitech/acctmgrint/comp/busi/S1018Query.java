package com.sitech.acctmgrint.comp.busi;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sitech.acctmgrint.common.BaseBusi;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.service.client.ServiceUtil;

/**
 *
 * <p>Title: 商品受理服务调用类  </p>
 * <p>Description: 商品受理服务调用接口  </p>
 * <p>Copyright: Copyright (c) 2017</p>
 * <p>Company: SI-TECH </p>
 * @author zhangleij
 * @version 1.0
 */
public class S1018Query extends BaseBusi{

	/**
	 * 名称：		S1018接口<br/>
	 * @param	KEEP_LIVE|ROUTE_VALUE|PHONE_NO|PRC_CLASS|LOGIN_NO|REGION_ID|CONTACT_ID|OP_NOTE|OP_CODE
	 * @param	入参以“|”分割，举例：10.109.222.97|13766662921|13766662921|YnM040||aan70W||-1||1018

	 * @return	String			返回字符串，以“|”分割
	 * @throws
	 * @author zhangleij 
	 * */
	public String s1018Query(String inParam) {

		String inSplitFlag = "\\|";		// 入参解析分隔符,需要转义
		String outSplitFlag = "|";		// 出参拼装分隔符,不需要转义
		String retCode = "";
		String retMsg = "";

		String keepLive = "";
		String routeValue = "";

		String phoneNo = "";
		String prcClass = "";
		String loginNo = "";
		String regionId = "";
		String contactId = "";
		String opNote = "";
		String opCode = "";

		Map<String, Object> headMap = new HashMap<String, Object>();
		String retStr = "";

		// 处理入参
		log.info("------> inParam=["+inParam+"]");
		if (inParam != "" && inParam != null && inParam.length() > 0) {
			String[] splStr = inParam.split(inSplitFlag);
			if (splStr != null && splStr.length > 0) {
				keepLive = splStr[0];
				routeValue = splStr[1];
				phoneNo = splStr[2];
				prcClass = splStr[3];
				loginNo = splStr[4];
				regionId = splStr[5];
				contactId = splStr[6];
				opNote = splStr[7];
				opCode = splStr[8];
				log.info("------> keepLive=["+keepLive+"]");
				log.info("------> routeValue=["+routeValue+"]");
				log.info("------> phoneNo=["+phoneNo+"]");
				log.info("------> prcClass=["+prcClass+"]");
				log.info("------> loginNo=["+loginNo+"]");
				log.info("------> regionId=["+regionId+"]");
				log.info("------> contactId=["+contactId+"]");
				log.info("------> opNote=["+opNote+"]");
				log.info("------> opCode=["+opCode+"]");
			}
		}

		MBean inMbeanTmp = new MBean();

		// 设置HEADER参数
		headMap.put("CHANNEL_ID", "11");
		headMap.put("DB_ID", "");
		headMap.put("KEEP_LIVE", keepLive);
		headMap.put("PARENT_CALL_ID", "0AEABCBFEA5C99BE429CF24583BDE436");
		headMap.put("POOL_ID", "2");
		headMap.put("PROVINCE_GROUP", "HLJ");
		headMap.put("ROUTING.ROUTE_KEY", "10");
		headMap.put("ROUTING.ROUTE_VALUE", routeValue);
		inMbeanTmp.setHeader(headMap);

		// 获取并设置BODY参数
		inMbeanTmp.setBody( "BUSI_INFO.PHONE_NO" , phoneNo);
		inMbeanTmp.setBody( "BUSI_INFO.PRC_CLASS" , prcClass);
		inMbeanTmp.setBody( "OPR_INFO.LOGIN_NO", loginNo);
		inMbeanTmp.setBody( "OPR_INFO.REGION_ID", regionId);
		inMbeanTmp.setBody( "OPR_INFO.CONTACT_ID", contactId);
		inMbeanTmp.setBody( "OPR_INFO.OP_NOTE", opNote);
		inMbeanTmp.setBody( "OPR_INFO.OP_CODE", opCode);

		//接口名 
		String interfaceName ="com_sitech_ordersvc_person_comp_inter_s1018_IMainPrcAndPrcClassRelCoSvc_query";

		log.info( "zhangleij调用服务开始:"+ inMbeanTmp.toString() );

		//调用方法 
		String outString = ServiceUtil.callService(interfaceName, inMbeanTmp);

		log.info( "zhangleij调用服务完成:"+outString );

		MBean outBean=new MBean(outString); 
		if (outBean != null && outBean.size() > 0) {
			retCode = outBean.getBodyStr("RETURN_CODE").trim();
			retMsg = outBean.getBodyStr("RETURN_MSG").trim();
		}

		log.info("------> retCode="+retCode);

		if("0".equals(retCode)){	//调用成功
			String outFlag = outBean.getBodyStr("OUT_DATA.FLAG");
			String outMsg = outBean.getBodyStr("OUT_DATA.MSG");
			retStr = outFlag + outSplitFlag + outMsg;
			log.info("------> retStr=[" + retStr + "]");
			return retStr;
		}else {
			log.info("------> 调用服务失败, retCode="+retCode+",retMsg="+retMsg);
			throw new BusiException(retCode,"调用服务失败：" + retMsg);
		}
	}

	public static void main(String[] args) {

		String inParam = "10.109.222.97|13766662921|13766662921|YnM040|aan70W||-1||1018";

		S1018Query s1018Qry = new S1018Query();
		String outStr = s1018Qry.s1018Query(inParam);
//		System.out.println(s1018Qry.s1018Query_SCP(inParam));
		System.out.println(outStr);
	}

}
