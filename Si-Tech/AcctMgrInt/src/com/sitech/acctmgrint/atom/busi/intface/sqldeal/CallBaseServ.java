package com.sitech.acctmgrint.atom.busi.intface.sqldeal;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgrint.common.BaseBusi;
import com.sitech.acctmgrint.common.InterProperties;
import com.sitech.common.CrossEntity;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.service.client.ServiceUtil;

public class CallBaseServ extends BaseBusi {
	
	
	//服务列表，根据IN_BSDATASOURCE_DICT配置新增。#新增需配置
	final static private String[] service_name_arr = 
		{"com_sitech_res_inter_outinter_IQryNoDetInfoSvc_sQryNoDetInfo",
		""};
	
	/**
	* 名称：调用基础域客户平台信息查询接口<br/>
	* 
	* 使用注意事项:1.根据服务编号调用service_name_arr中对应服务，新增需新增service_name_arr；
	* 		   2.在getUserInfo中实现服务出参处理逻辑
	*
	* @param    SERV_PARAM:A,B,C,D
	* @return	OUT_VALUE
	* @throws
	* @author  KONGLJ
	 */
	public String callArrService(Map<String, Object> header, Map<String, Object> inParam) {
		
		MBean paramBean = new MBean();
		paramBean.setHeader(header);
		//Body入参
		List<String> list_param = (List<String>) inParam.get("SERV_PARAM");
		for (String param:list_param) 
			paramBean.setBody(param, inParam.get(param)); 
		
		//接口名 
		int serv_num = Integer.valueOf(inParam.get("SERV_NUM").toString());
		String interfaceName = service_name_arr[serv_num];
		
		log.debug( "调用基础域接口开始:"+ paramBean.toString());
		//调用方法 
		Map out_servMap = CrossEntity.callService(interfaceName, paramBean); 
		if (out_servMap != null && out_servMap.size() > 0) {
		
			/*按照服务编号新增服务出参处理逻辑！！！！！！！！！！*/
			return getUserInfo(serv_num, out_servMap, inParam);
		
		} else {
			log.error("------> 调用基础域客户信息查询接口失败, retmap="+out_servMap);
			throw new BusiException("700000001","调用基础域客户信息查询接口失败, retmap="+out_servMap);
		}

	}
	
	/**
	 * 根据服务编号实现个性化处理#新增需配置
	 * @param serv_num
	 * @param servMap
	 * @param inParam
	 * @return
	 */
	private String getUserInfo(int serv_num, Map servMap, Map<String, Object> inParam) {
		
		/*按照服务编号新增服务出参处理逻辑！！！！！！！！！！*/
		if (0 == serv_num) {
			//0 服务对应功能： 查询用户交换机类型信息
			String speed = inParam.get("SPEED").toString();
			String hlrBrand = servMap.get("SYS_NAME").toString();
			if (!"NOK".equals(hlrBrand)) {
				Long temp = Long.parseLong(speed) * 1024;
				return temp.toString();
			} else {
				return speed;
			}
		} else if (1 == serv_num) {
			//1 服务对应功能： xxxxx新增补充xxxxxx#新增需配置
			return "";
		}
		
		return "";
	}
	
	/********************************src_type=5类型，个性化方法，查询用户KI_NO服务。新增服务使用上述方法(src_type=6)******************************/

	/**
	* 名称：调用基础域客户信息查询接口<br/>
	* 描述：根据IMSI_NO查询KI_NO接口
	* @param    OLD_RUN  只有预拆恢复时，才调用基础域接口查询KI_NO
	* @param	IMSI     传：IMSI_NO,非空
	* @param	OP_TYPE  操作标识： 写死2：SIM_NO当作IMSI来用，查询KI专用,非必传
	* @return	OUT_DATA OUT_DATA.KI_NO
	* @throws
	* @author  KONGLJ
	* */
	public Map<String, Object> qryUserKIInfo(Map<String, Object>Header, Map<String, Object> inParam) {
		
		//只有预拆恢复时，才调用
		if (null != inParam.get("CUR_RUN_CODE"))
			if (!inParam.get("CUR_RUN_CODE").toString().equals("J")) {
				log.info("只有预拆恢复时，才调用基础域接口，CUR_RUN_CODE！=J");
				return null;
			}
		
		String	op_type = InterProperties.getConfigByMap("FWKT_CALLSERV_OPTYPE");//操作标识： 2：SIM_NO当作IMSI来用，查询KI专用
		/*if ( inParam.get("OP_TYPE") !=null && !( (String)inParam.get("OP_TYPE") ).equals("") ) {
			op_type = (String)inParam.get("OP_TYPE");
		}*/
		
		MBean inMbeanTmp = new MBean();
		inMbeanTmp.setHeader(Header);
		inMbeanTmp.setBody( "BUSI_INFO.OP_TYPE", op_type);
		inMbeanTmp.setBody( "BUSI_INFO.SIM_NO", inParam.get("IMSI").toString());
		inMbeanTmp.setBody( "BUSI_INFO.LOGIN_NO", inParam.get("LOGIN_NO").toString());
		
		//接口名 
		String interfaceName ="com_sitech_res_inter_outinter_IQrySimDetInfoSvc_sQrySimDetInfo";
		//1开关关闭
		if(!"1".equals(InterProperties.getConfigByMap("FWKT_JTOA_CALLSERVER").toString())){
			log.info("inter.properties中配置关闭调用基础域接口,FWKT_JTOA_CALLSERVER.");
			return null;
		} else {
			log.debug( "调用基础域接口开始:"+ inMbeanTmp.toString());
			//调用方法 
			String outString = ServiceUtil.callService(interfaceName, inMbeanTmp);
		
			log.debug( "调用基础域接口完成:"+outString );
		
			MBean outBean=new MBean(outString); 
			String retCode =  outBean.getBodyStr("RETURN_CODE").trim();
			String retMsg =  outBean.getBodyStr("RETURN_MSG").trim();

			log.debug("------> retCode="+retCode);
			if("0".equals(retCode)) {//基础域接口调用成功
				return (Map<String, Object>) outBean.getBodyObject("OUT_DATA");
			} else {
				log.error("------> 调用基础域客户信息查询接口失败, retCode="+retCode+",retMsg="+retMsg);
				throw new BusiException(retCode,"调用基础域小权限校验接口失败：" + retMsg);
			}
			
		}
		
	}
	
}
