package com.sitech.acctmgr.atom.impl.billAccount;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.acctmng.S8510InDTO;
import com.sitech.acctmgr.atom.dto.acctmng.S8510OutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGoods;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.billAccount.I8510;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.service.client.ServiceUtil;
import com.sitech.jcfx.util.DateUtil;

@ParamTypes({ 
	@ParamType(m = "cfm", c = S8510InDTO.class, oc = S8510OutDTO.class)
})
public class S8510 extends AcctMgrBaseService implements I8510{

	private IControl control;
	private IUser user;
	private IBillAccount billAccount;
	private IRecord record;
	private IGoods goods;
	
	@Override
	public OutDTO cfm(InDTO inParam) {
		
		S8510InDTO inDto = (S8510InDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		String opType = inDto.getOpType();
		String fdType = inDto.getFdType();
		String openResult = "";
		String openResult1 = "";
		
		//取系统时间和流水
		String sCurDate = DateUtil.format(new Date(), "yyyyMMdd");
		long loginAccept=control.getSequence("SEQ_SYSTEM_SN");
		
		UserInfoEntity uie = user.getUserInfo(phoneNo);
		String runCode = uie.getRunCode();
		long idNo = uie.getIdNo();
		if(!runCode.equals("A")){
			throw new BusiException(AcctMgrError.getErrorCode("8510", "00001"), "该号码不是正常状态手机号！");
		}
		
		/* s_op_type=1时为办理接口，s_op_type=0时为查询接口*/
		if(opType.equals("1")){
			/* s_fd_type=1时为办理取消封顶接口，s_fd_type=0时为办理不封顶接口*/
			openResult="不封顶";
			openResult1="0";
			if(fdType.equals("0")){
				//判断有无开通
				int count=0;
				count = billAccount.getCntGuMan(phoneNo);
				if(count>0){
					throw new BusiException(AcctMgrError.getErrorCode("8510", "00002"), "取消封顶功能无法重复办理！");
				}else {
					Map<String, Object> inMap = new HashMap<String, Object>();
					inMap.put("PHONE_NO", phoneNo);
					inMap.put("LOGIN_ACCEPT", loginAccept);
					inMap.put("ID_NO", phoneNo);
					inMap.put("WARN_RULE_ID", "100033");
					billAccount.saveDataGuMan(inMap);
				}
				
				//记录营业员操作记录表
				LoginOprEntity loe = new LoginOprEntity();
				loe.setIdNo(idNo);
				loe.setPhoneNo(phoneNo);
				loe.setLoginGroup(inDto.getGroupId());
				loe.setLoginNo(inDto.getLoginNo());
				loe.setLoginSn(loginAccept);
				loe.setOpCode(inDto.getOpCode());
				loe.setTotalDate(Long.parseLong(sCurDate));
				loe.setRemark("超出50M不封顶功能办理");
				record.saveLoginOpr(loe);
				
				//校验是否已订购
				boolean order = false;
				order = goods.isOrderGoods(idNo, "M001038");
				if(order){
					log.info("已经订购");
				}else {
					//调用CRM订购服务
					Map<String,Object> inMap = new HashMap<String,Object>();
					inMap.put("OPERATE_TYPE", "A");
					inMap.put("PRC_ID", "M001038");
					List<Map<String,Object>> goodsList = new ArrayList<Map<String,Object>>();
					goodsList.add(inMap);
			    	MBean	inMbeanTmp = new MBean();
			    	inMbeanTmp.setHeader(inDto.getHeader());
			    	inMbeanTmp.setBody("OPR_INFO.LOGIN_NO",inDto.getLoginNo());
			    	inMbeanTmp.setBody("OPR_INFO.OP_CODE",inDto.getOpCode());
			    	inMbeanTmp.setBody("OPR_INFO.CONTACT_ID","-1");
					inMbeanTmp.setBody( "BUSI_INFO.PHONE_NO", phoneNo);
					inMbeanTmp.setBody( "BUSI_INFO.CHN_FLAG" , "3" ); 
					inMbeanTmp.setBody( "BUSI_INFO.GOODS_LIST" , goodsList );
					
					//接口名 
					String interfaceName ="com_sitech_ordersvc_person_comp_inter_s1090_ISubmitGoodsCoSvc_goodsDataSubmit";
					log.info( "------>xiongjy 调用CRM订购服务开始:"+ inMbeanTmp.toString() );
					//调用方法 
					
					String outStringQry = ServiceUtil.callService(interfaceName, inMbeanTmp);
				
					log.info( "------>xiongjy 调用CRM订购完成:"+outStringQry );
				
					MBean outBean=new MBean(outStringQry); 
					String retCode =  outBean.getBodyStr("RETURN_CODE").trim();
					String retMsg =  outBean.getBodyStr("RETURN_MSG").trim();
					if(!"0".equals(retCode)){
						log.info("------> 调用订购接口失败, retCode="+retCode+",retMsg="+retMsg);
						throw new BusiException(retCode,retMsg);
					}
					
				}
				
				//TODO 发送短信
				
			}else {
				//办理封顶
				int count=0;
				count=billAccount.getCntGuMan(phoneNo);
				if(count>0){
					billAccount.delDataGuMan(Long.parseLong(phoneNo));
				}else {
					throw new BusiException(AcctMgrError.getErrorCode("8510", "00003"), "该号码未办理达到50M后不封顶功能，无法办理恢复封顶！");
				}
				//记录营业员操作记录表
				LoginOprEntity loe = new LoginOprEntity();
				loe.setIdNo(idNo);
				loe.setPhoneNo(phoneNo);
				loe.setLoginGroup(inDto.getGroupId());
				loe.setLoginNo(inDto.getLoginNo());
				loe.setLoginSn(loginAccept);
				loe.setOpCode(inDto.getOpCode());
				loe.setTotalDate(Long.parseLong(sCurDate));
				loe.setRemark("50M恢复封顶功能办理");
				record.saveLoginOpr(loe);
				
				//TODO 发送短信
				
			}
		}else {
			//50M封顶功能查询
			int count=0;
			count = billAccount.getCntGuMan(phoneNo);
			if(count>0){
				openResult="不封顶";
				openResult1="0";
			}else {
				openResult="封顶";
				openResult1="1";
			}
			//记录营业员操作记录表
			LoginOprEntity loe = new LoginOprEntity();
			loe.setIdNo(idNo);
			loe.setPhoneNo(phoneNo);
			loe.setLoginGroup(inDto.getGroupId());
			loe.setLoginNo(inDto.getLoginNo());
			loe.setLoginSn(loginAccept);
			loe.setOpCode(inDto.getOpCode());
			loe.setTotalDate(Long.parseLong(sCurDate));
			loe.setRemark("8510超出50M封顶功能查询");
			record.saveLoginOpr(loe);
		}
		
		S8510OutDTO outDto = new S8510OutDTO();
		outDto.setLoginAccept(String.valueOf(loginAccept));
		outDto.setOpenResult(openResult);
		outDto.setOpenResult1(openResult1);
		log.info("result------->"+outDto.toJson());
		return outDto;
	}

	/**
	 * @return the control
	 */
	public IControl getControl() {
		return control;
	}

	/**
	 * @param control the control to set
	 */
	public void setControl(IControl control) {
		this.control = control;
	}

	/**
	 * @return the user
	 */
	public IUser getUser() {
		return user;
	}

	/**
	 * @param user the user to set
	 */
	public void setUser(IUser user) {
		this.user = user;
	}

	/**
	 * @return the billAccount
	 */
	public IBillAccount getBillAccount() {
		return billAccount;
	}

	/**
	 * @param billAccount the billAccount to set
	 */
	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
	}

	/**
	 * @return the record
	 */
	public IRecord getRecord() {
		return record;
	}

	/**
	 * @param record the record to set
	 */
	public void setRecord(IRecord record) {
		this.record = record;
	}

	/**
	 * @return the goods
	 */
	public IGoods getGoods() {
		return goods;
	}

	/**
	 * @param goods the goods to set
	 */
	public void setGoods(IGoods goods) {
		this.goods = goods;
	}
	
}
