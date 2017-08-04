package com.sitech.acctmgr.comp.impl.pay;


import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.dto.pay.SAuthoriseQryInDTO;
import com.sitech.acctmgr.atom.dto.pay.SAuthoriseQryOutDTO;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.InterProperties;
import com.sitech.acctmgr.inter.pay.IAuthorise;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.service.client.ServiceUtil;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by 2015/01/28
 * @author LIJXD
 * @modify   2015/01/28
 * 
 */

@ParamTypes({ 
	@ParamType(c = SAuthoriseQryInDTO.class, oc=SAuthoriseQryOutDTO.class, m = "query")
	})
public class SAuthoriseComp extends AcctMgrBaseService implements IAuthorise {
	 
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.inter.pay.IAuthorise#query(com.sitech.jcfx.dt.in.InDTO)
	 */
	public OutDTO query(InDTO inParam) {
		// TODO Auto-generated method stub
	 
		String provinceId="";
		String approvetype="";
		
		SAuthoriseQryInDTO   inParamDto = (SAuthoriseQryInDTO) inParam;
		log.info("------> inParamDto :"+inParamDto.getMbean());
		
		String opCode =inParamDto.getOpCode();
		String loginNo = inParamDto.getLoginNo().trim();
		String groupId=inParamDto.getGroupId();
		
		String isAuthen =inParamDto.getIsAuthen();
		String phoneNo = inParamDto.getPhoneNo();
		
		if(loginNo==null||"".equals(loginNo)){
 			throw new BusiException(AcctMgrError.getErrorCode("8011", "00001"),"工号失效,请重新登录!");
		}
		
		/*APP_8008_001 在网用户退预存款; APP_8054_001 退费受理; APP_8056_001 资金冲正;*/
		String appbusiCode = inParamDto.getAppbusiCode();

		//省份ID，session里面有，吉林默认为220000
		if( inParamDto.getProvinceId() ==null){
			 provinceId=InterProperties.getConfigByMap("PROVINCE_ID").toString();
		}else {
			provinceId=inParamDto.getProvinceId();
		}

	    //授权审批类型，用三位 “YYY” 第一位是模块级 第二位是业务级 第三位表示 是否强制认证（调用此接口基本是YY）
		if( inParamDto.getApproveType() ==null){
			 approvetype=InterProperties.getConfigByMap("APPROVE_TYPE").toString();
		}else {
			approvetype=inParamDto.getApproveType();
		}
	 
		//增加开关
		String interCtrl=InterProperties.getConfigByMap("AUTHER_PDOM").toString().trim(); //基础域接口开关： 0 关闭不调用；1打开调用
		
		//String checkType = isAuthen.substring(1,2);// 都是业务级别校验
		log.info("------> loginHead="+loginNo.substring(0,2)+ ",interCtrl="+interCtrl+ ",isAuthen="+isAuthen);
		
		//出参
		SAuthoriseQryOutDTO outParamDto =new SAuthoriseQryOutDTO();

	    if(interCtrl.equals("0")){ //loginNo.substring(0,2).equals("kf")	||checkType.equals("N") 
	    	log.info("------>  不需要授权审批["+loginNo+"]["+isAuthen+"]" );
	    	
	    	outParamDto.setAutherFlag("0"); //不需要审批接
			outParamDto.setApproveStatus("");
			outParamDto.setApproveFlag("");
			outParamDto.setApply_Id("");
			outParamDto.setFlowId("");
			outParamDto.setAppbusiCode("");
			outParamDto.setFunctionCode(opCode);
			outParamDto.setPhoneNo(phoneNo);
			outParamDto.setApplyLogin(loginNo);
			outParamDto.setGroupId(groupId);
			outParamDto.setApplyContent("");
	    }else {
	    	log.info("------>  需要调用授权审批接口["+loginNo+"]["+isAuthen+"]["+appbusiCode+"]" );
	    	
	    	Map<String, Object> header =new HashMap<String, Object>();
	    	header.put("ROUTE_KEY", "10");
	    	header.put("ROUTE_VALUE", phoneNo);
	    	
	    	MBean	inMbeanTmp = new MBean();
			inMbeanTmp.setRoute("10", phoneNo);
			//inMbeanTmp.setBody( "BUSI_INFO.IS_AUTHEN", isAuthen);
			approvetype=isAuthen;
			inMbeanTmp.setBody( "BUSI_INFO.PROVINCE_ID", provinceId);
			inMbeanTmp.setBody( "BUSI_INFO.APPROVE_TYPE" , approvetype ); //直接用基础域配置,不用自己传
			inMbeanTmp.setBody( "BUSI_INFO.FUNCTION_CODE" ,opCode );
			inMbeanTmp.setBody( "BUSI_INFO.APPBUSI_CODE" , appbusiCode );
			inMbeanTmp.setBody( "BUSI_INFO.PHONE_NO" , phoneNo);
			inMbeanTmp.setBody( "BUSI_INFO.APPLY_LOGIN" , loginNo);
			inMbeanTmp.setBody( "BUSI_INFO.GROUP_ID" ,  groupId);
			
			//接口名 
			String interfaceName ="com_sitech_basemng_atom_inter_apply_IApplyPdomSvc_pubAppQry";
			log.info( "------>lijxd 调用基础域接口开始:"+ inMbeanTmp.toString() );
			//调用方法 
			String outStringQry = ServiceUtil.callService(interfaceName, inMbeanTmp);
		
			log.info( "------>lijxd 调用基础域接口完成:"+outStringQry );
		
			MBean outBean=new MBean(outStringQry); 
			String retCode =  outBean.getBodyStr("RETURN_CODE").trim();
			String retMsg =  outBean.getBodyStr("RETURN_MSG").trim();
			log.info("------> retCode="+retCode);

			if("0".equals(retCode)){
				String approveFlag=outBean.getBodyStr("OUT_DATA.APPROVE_FLAG").trim();
				log.info("------> approveFlag="+approveFlag);
				if("N".equals(approveFlag)){
					log.info("------>不需要授权审,approveFlag="+approveFlag);
			    	outParamDto.setAutherFlag("0"); //不调用审批接口
					outParamDto.setApproveStatus("");
					outParamDto.setApproveFlag("");
					outParamDto.setApply_Id("");
					outParamDto.setFlowId("");
					outParamDto.setAppbusiCode("");
					outParamDto.setFunctionCode(opCode);
					outParamDto.setPhoneNo(phoneNo);
					outParamDto.setApplyLogin(loginNo);
					outParamDto.setGroupId(groupId);
					outParamDto.setApplyContent("");
					
				}if("Y".equals(approveFlag)){
					String appriveStatus=outBean.getBodyStr("OUT_DATA.APPROVE_STATUS").trim();
					if( appriveStatus.equals("3") ){
						log.info("------> 授权审批已经通过, APPROVE_STATUS="+appriveStatus);
						
						MBean mbInit = new MBean(outStringQry);
						String  jsonInit = JSON.toJSONString(mbInit.getBodyObject("OUT_DATA"));
						outParamDto =  JSON.parseObject(jsonInit, SAuthoriseQryOutDTO.class);
						outParamDto.setAutherFlag("1"); //调用审批接口
						
					}else if( appriveStatus.equals("0") ){
						log.error("------> 还没有填写申请单,请先到授权申请2936填写申请单 。APPROVE_FLAG="+appriveStatus);
			 			throw new BusiException(AcctMgrError.getErrorCode("0000", "00058")
								,"当前办理工号未填写授权申请单，请到2936授权申请填写申请单或者到2937授权查询模块根据此号码查询授权记录，并以申请的工号办理此业务。");
					}else if( appriveStatus.equals("2") ){
						log.error("------> 申请单正在审批中,请等待审批结束。 APPROVE_FLAG="+appriveStatus);
			 			throw new BusiException(AcctMgrError.getErrorCode("0000", "00059"),"申请单正在审批中,请等待审批结束!");
					}else if( appriveStatus.equals("5") ){
						log.error("------> 申请单被驳回。APPROVE_FLAG="+appriveStatus);
			 			throw new BusiException(AcctMgrError.getErrorCode("0000", "00060"),"申请单被驳回,请重新填写申请单!");
					}else if( appriveStatus.equals("4") ){
						log.error("------>业务办理结束。APPROVE_FLAG="+appriveStatus);
			 			throw new BusiException(AcctMgrError.getErrorCode("0000", "00062"),"业务办理结束,请重新填写申请单!");
					}else if( appriveStatus.equals("3") ){ //OK
						log.error("------> 授权申请审批通过!。APPROVE_FLAG="+appriveStatus);
					}else if( appriveStatus.equals("6") ){
						log.error("------> 授权申请审批取消。APPROVE_FLAG="+appriveStatus);
						throw new BusiException(AcctMgrError.getErrorCode("0000", "00067"),"授权申请审批取消,请重新填写申请单!");
					}else if( appriveStatus.equals("") ){
						log.error("------> 该业务在您归属地市需要审批，请联系管理员配置审批规则["+appbusiCode+"]");
						throw new BusiException(AcctMgrError.getErrorCode("0000", "00068"),"该业务在您归属地市需要审批，请联系管理员配置审批规则["+appbusiCode+"]");
					}
				}
					
			}else {
				log.info("------> 调用授权审批接口失败, retCode="+retCode+",retMsg="+retMsg);
				throw new BusiException(retCode,retMsg);
			}
		}
		 
		log.error("----> outParamDto ：" +outParamDto.toJson());
		return outParamDto;	
	}
	 
	
}
