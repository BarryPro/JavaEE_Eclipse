package com.sitech.acctmgr.comp.busi;

import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.InterProperties;
import com.sitech.acctmgr.common.domains.LoginPdomEntity;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.service.client.ServiceUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * <p>Title: 基础域相关组合服务实体类  </p>
 * <p>Description: 调用基础域权限校验等接口  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class LoginCheck extends BaseBusi {

	
	/**
	* 名称：调用基础域权限校验接口<br/>
	* @param	LOGIN_NO
	* @param	POPEDOM_TYPE	特权权限 ,可空,默认=06
	* @param	BUSI_CODE		小权限代码

	* @return	boolean		true ： 有权限 	false：无权限
	* @throws
	* @author qiaolin 
	 * */
	public boolean pchkFuncPower(Map<String, Object>Header, Map<String, Object> inParam) {
		
		String	popedom_type = "06";
		
		MBean	inMbeanTmp = new MBean();
		
		if ( inParam.get("POPEDOM_TYPE") !=null && !( (String)inParam.get("POPEDOM_TYPE") ).equals("") ) {
			popedom_type = (String)inParam.get("POPEDOM_TYPE");
		}
		
		inMbeanTmp.setHeader(Header);
		
		inMbeanTmp.setBody( "OPR_INFO.LOGIN_NO", (String)inParam.get("LOGIN_NO") );
		inMbeanTmp.setBody( "BUSI_INFO.POPEDOM_TYPE" , popedom_type );
		inMbeanTmp.setBody( "BUSI_INFO.BUSI_CODE" , (String)inParam.get("BUSI_CODE") );
		
		//接口名 
		String interfaceName ="com_sitech_basemng_atom_inter_login_ICheckLoginPdomSvc_checkLoginPdom";
		
		if(InterProperties.getConfigByMap("LOGIN_PDOM").toString().equals("1")){ //1开关关闭
			return true;
		}else{
			log.info( "qiaolin调用基础域接口开始:"+ inMbeanTmp.toString() );
			//调用方法 
			String outString = ServiceUtil.callService(interfaceName, inMbeanTmp);
		
			log.info( "qiaolin调用基础域接口完成:"+outString );
		
			MBean outBean=new MBean(outString); 
			String retCode =  outBean.getBodyStr("RETURN_CODE").trim();
			String retMsg =  outBean.getBodyStr("RETURN_MSG").trim();

			log.info("------> retCode="+retCode);

			if("0".equals(retCode)){		//基础域接口调用成功
				
				if( outBean.getBodyStr("OUT_DATA.CHECK_FLAG").equals("Y") ){
					return true;
				}else{
					return false;
				}
				
			}else {
				log.info("------> 调用授权审批接口失败, retCode="+retCode+",retMsg="+retMsg);
				
				throw new BusiException(retCode,"调用基础域小权限校验接口失败：" + retMsg);
			}
			
		}
		
	}
	
	
	
	/**
	* 名称：调用基础域权限校验接口，可以通过List一次校验多个小权限<br/>
	* @param	LOGIN_NO
	* @param	POPEDOM_TYPE	特权权限 ,可空,默认=06
	* @param	BUSIPRIVS_LIST		小权限代码 -- List中放多个BUSI_CODE

	* @return	List<LoginPdomEntity>
	* @author qiaolin 
	 * */
	public List<LoginPdomEntity> pchkFuncPowerList(Map<String, Object>Header, Map<String, Object> inParam) {

		log.debug("pchkFuncPowerList begin: " + inParam.toString());
		
		List<LoginPdomEntity> outList = new ArrayList<LoginPdomEntity>();
		
		String	popedom_type = "06";
		
		MBean	inMbeanTmp = new MBean();
		
		if ( inParam.get("POPEDOM_TYPE") !=null && !( (String)inParam.get("POPEDOM_TYPE") ).equals("") ) {
			popedom_type = (String)inParam.get("POPEDOM_TYPE");
		}
		
		inMbeanTmp.setHeader(Header);
		
		inMbeanTmp.setBody( "BUSI_INFO.LOGIN_NO", (String)inParam.get("LOGIN_NO") );
		inMbeanTmp.setBody( "BUSI_INFO.POPEDOM_TYPE" , popedom_type );
		
		List<Map<String, Object>> busiCodeList = (List<Map<String, Object>>)inParam.get("BUSIPRIVS_LIST");
		
		inMbeanTmp.setBody( "BUSI_INFO.BUSIPRIVS_LIST" , busiCodeList);
		
		//接口名 
		String interfaceName ="com_sitech_basemng_atom_inter_login_ICheckLoginPdomSvc_checkBusiPrivsList";
		
		if(InterProperties.getConfigByMap("LOGIN_PDOM").toString().equals("1")){ //1开关关闭
			
			for(Map<String, Object> mapTmp : busiCodeList){
				
				LoginPdomEntity outPdom = new LoginPdomEntity();
				outPdom.setBusiCode(mapTmp.get("BUSI_CODE").toString());
				outPdom.setCheckFlag("Y");
				
				outList.add(outPdom);
			}
			
			return outList;
			
		}else{
			log.info( "qiaolin调用基础域接口开始:"+ inMbeanTmp.toString() );
			//调用方法 
			String outString = ServiceUtil.callService(interfaceName, inMbeanTmp);
		
			log.info( "qiaolin调用基础域接口完成:"+outString );
		
			MBean outMBean=new MBean(outString); 
			String retCode =  outMBean.getBodyStr("RETURN_CODE").trim();
			String retMsg =  outMBean.getBodyStr("RETURN_MSG").trim();

			log.info("------> retCode="+retCode);

			if("0".equals(retCode)){		//基础域接口调用成功
				
				List<Map<String, Object>> pdmList = (List<Map<String, Object>>)outMBean.getBodyObject("OUT_DATA.LOGIN_PDOM_LIST");
				log.debug("权限列表： " + pdmList.toString());
				for(Map<String, Object> mapTmp : pdmList){
					
					LoginPdomEntity outPdom = new LoginPdomEntity();
					outPdom.setBusiCode(mapTmp.get("BUSI_CODE").toString());
					outPdom.setCheckFlag(mapTmp.get("CHECK_FLAG").toString());
					
					outList.add(outPdom);
				}
				
				return outList;
				
			}else {
				log.info("------> 调用小权限校验接口失败, retCode="+retCode+",retMsg="+retMsg);
				
				throw new BusiException(retCode,"调用小权限校验接口失败：" + retMsg);
			}
			
		}
	
	}
	
	public static void main(String[] args) {
		
		//{"ROOT":{"HEADER":{"ROUTING":{"ROUTE_KEY":"10","ROUTE_VALUE":"18246325286"},"DB_ID":"","KEEP_LIVE":"10.109.222.97","CHANNEL_ID":"11","PARENT_CALL_ID":"0AEABCBFEA5C99BE429CF24583BDE436","PROVINCE_GROUP":"HLJ","POOL_ID":"2"},"BODY":{"BUSI_INFO":{"BIP_CODE":"BIP1A163","TRANS_CODE":"T1000157","LOGIN_NO":"system","GROUP_ID":"341011","ID_TYPE":"01","ID_VALUE":"18246325286","TRANSACTION_ID":"10451201703181620251000000047","ACTION_DATE":20170318,"PAYED":"1000","CNL_TYPE":"00","SUB_ID":"","PAYED_TYPE":"01","DISCOUNT":"1","CHARGE_MONEY":"1000","ACTIVITY_NO":"","PRODUCT_NO":"","RESERVE1":"1","RESERVE2":"","RESERVE3":"","RESERVE4":"","RESERVE5":"","OP_NOTE":"银行总对总自动交费"}}}}
		
		MBean	inMbeanTmp = new MBean("{\"ROOT\":{\"HEADER\":{\"CHANNEL_ID\":\"19\",\"TRACE_ID\":\"11*20170207092934*00zx*ZHJKLD*116839\",\"ROUTING\":{\"ROUTE_KEY\":\"10\",\"ROUTE_VALUE\":\"13704685480\"}},\"BODY\":{\"OPR_INFO\":{\"LOGIN_NO\":\"aaaaxp\",\"GROUP_ID\":\"230000\",\"OP_CODE\":\"\",\"PROVINCE_ID\":\"230000\"},\"BUSI_INFO\":{\"BIP_CODE\":\"BIP1A163\",\"TRANS_CODE\":\"T1000157\",\"LOGIN_NO\":\"system\",\"GROUP_ID\":\"10477\",\"ID_TYPE\":\"01\",\"ID_VALUE\":\"13704685480\",\"TRANSACTION_ID\":\"01\",\"ACTION_DATE\":\"20170317\",\"PAYED\":\"01\",\"CNL_TYPE\":\"00\",\"SUB_ID\":\"0100045120141229158509\",\"PAYED_TYPE\":\"01\",\"DISCOUNT\":\"1\",\"CHARGE_MONEY\":\"01\",\"ACTIVITY_NO\":\"\",\"PRODUCT_NO\":\"01\",\"RESERVE1\":\"\",\"RESERVE2\":\"\",\"RESERVE3\":\"\",\"RESERVE4\":\"\",\"RESERVE5\":\"\",\"OP_NOTE\":\"银行总对总自动交费\"}}}}");
		
		String interfaceName = "com_sitech_oneboss_common_service_ISTSNPubSnd1_pubCall";
		String outString = ServiceUtil.callService(interfaceName, inMbeanTmp);
		
	}
	
}
