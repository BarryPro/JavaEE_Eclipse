package com.sitech.acctmgr.atom.dto.pay;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

import java.util.Map;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class SFeeOrderPayMoneyForMrInDTO extends CommonInDTO{

	private static final long serialVersionUID = -3682083701969326333L;

	@ParamDesc(path="OPR_INFO.ORDER_LINE_ID",cons=ConsType.QUES,type="String",len="40",desc="外部流水",memo="略")
	private String foreignSn;
	
	@ParamDesc(path="OPR_INFO.OP_TIME",cons=ConsType.QUES,type="String",len="14",desc="外部时间",memo="外部缴费时间，可空，格式为YYYYMMDDHHMISS")
	private String foreignTime;//外部缴费时间，可空，格式为YYYYMMDDHHMISS
	
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.ID_NO",cons=ConsType.QUES,type="String",len="40",desc="用户ID",memo="略")
	private long idNo;
	
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="账号",memo="略")
	private long contractNo;
	
	@ParamDesc(path="BUSI_INFO.IS_PRINT",cons=ConsType.CT001,type="String",len="5",desc="CRM打印发票标识",memo="Y ：CRM已打印发票  N ：CRM未打印发票")
	private String isPrint;

	@ParamDesc(path="BUSI_INFO.PAY_PATH",cons=ConsType.CT001,type="String",len="5",desc="缴费渠道",memo="略")
	private String payPath;
	
	@ParamDesc(path="BUSI_INFO.PAY_METHOD",cons=ConsType.CT001,type="String",len="5",desc="缴费方式",memo="略")
	private String payMethod;
	
	@ParamDesc(path="BUSI_INFO.ACT_ID",cons=ConsType.CT001,type="String",len="20",desc="活动ID",memo="略")
	private String actId;
	
	@ParamDesc(path="BUSI_INFO.MEANS_ID",cons=ConsType.CT001,type="String",len="20",desc="档次ID",memo="略")
	private String meansId;
	
	/***
	 *	0  -- 所有都是有条件返费（第一笔 + 后面所有笔）
	 *	1  --第一笔无条件返费，后面几笔有条件返费
	 *	2 --所有都是无条件返费 
	 */
	@ParamDesc(path="BUSI_INFO.ACT_TYPE",cons=ConsType.CT001,type="String",len="20",desc="档次ID",memo="略")
	private String actType;
	
	@ParamDesc(path="BUSI_INFO.PAY_TYPE",cons=ConsType.CT001,type="String",len="5",desc="账本类型",memo="略")
	private String payType;
	
	@ParamDesc(path="BUSI_INFO.MKT_TYPE",cons=ConsType.CT001,type="String",len="5",desc="业务类型",memo="A：终端  B：存送")
	private String mktType;
	
	@ParamDesc(path="BUSI_INFO.RETURN_FEE",cons=ConsType.CT001,type="String",len="200",desc="返还金额",memo="单位：分。每个月都传，用“+”拼接")
	private String returnFee;
	
	@ParamDesc(path="BUSI_INFO.RULE_ID",cons=ConsType.CT001,type="String",len="10",desc="规则ID",memo="")
	private String ruleId;
	
	@ParamDesc(path="BUSI_INFO.FIRST_EFF",cons=ConsType.CT001,type="String",len="14",desc="第一笔生效时间",memo="")
	private String firstEff;
	
	@ParamDesc(path="BUSI_INFO.RETURN_MONTH",cons=ConsType.CT001,type="String",len="10",desc="返还月数",memo="")
	private String returnMonth;
	
	@ParamDesc(path="BUSI_INFO.INTERVAL_MONTH",cons=ConsType.CT001,type="String",len="10",desc="间隔月数",memo="")
	private String intervalMonth;
	
	@ParamDesc(path="BUSI_INFO.EXP_FLAG",cons=ConsType.CT001,type="String",len="10",desc="失效时间类型",memo="0：指定日期，1：有效月数，2：年底失效  ")
	private String expFlag;
	
	@ParamDesc(path="BUSI_INFO.EXP_DATE",cons=ConsType.QUES,type="String",len="10",desc="失效时间",memo="0：EXP_FLAG为0时，使用该字段，其他情况下可为空")
	private String expDate;

	@ParamDesc(path="BUSI_INFO.VALID_MONTH",cons=ConsType.QUES,type="String",len="10",desc="失效月数",memo="EXP_FLAG为1时，使用该字段，其他情况下可为空 ")
	private String validMonth;
	
	@ParamDesc(path="BUSI_INFO.IS_SENDFLAG",cons=ConsType.QUES,type="String",len="5",desc="是否发送短信",memo=" ")
	private String isSendFlag;
	
	@ParamDesc(path="BUSI_INFO.REMARK",cons=ConsType.QUES,type="String",len="200",desc="备注",memo=" ")
	private String remark;
	
	@ParamDesc(path="BUSI_INFO.SBILLTOTCODE_USER",cons=ConsType.QUES,type="complex",len="200",desc="底线消费处理则传入该节点",memo=" ")
	private Map<String, Object> billtotcodeUser;
	
	public void decode(MBean arg0){
		
		super.decode(arg0);
		
		foreignSn = arg0.getStr(getPathByProperName("foreignSn"));
		foreignTime = arg0.getStr(getPathByProperName("foreignTime"));
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		
		if(arg0.getObject(getPathByProperName("idNo")) != null && !arg0.getObject(getPathByProperName("idNo")).equals("")){
			idNo = Long.parseLong(arg0.getStr(getPathByProperName("idNo")));
		}
		if (arg0.getObject(getPathByProperName("contractNo")) != null
				&& !arg0.getObject(getPathByProperName("contractNo"))
						.equals("")) {
			contractNo = Long.parseLong(arg0
					.getStr(getPathByProperName("contractNo")));
		}
		
		String tmp = arg0.getStr(getPathByProperName("isPrint"));
		if(tmp.equals("Y")){
			this.isPrint = "2";
		}else{
			this.isPrint = "0";
		}
		
		payPath = arg0.getStr(getPathByProperName("payPath"));
		payMethod = arg0.getStr(getPathByProperName("payMethod"));
		
		actId = arg0.getStr(getPathByProperName("actId"));
		meansId = arg0.getStr(getPathByProperName("meansId"));
		actType = arg0.getStr(getPathByProperName("actType"));
		payType = arg0.getStr(getPathByProperName("payType"));
		mktType = arg0.getStr(getPathByProperName("mktType"));
		returnFee = arg0.getStr(getPathByProperName("returnFee"));
		ruleId = arg0.getStr(getPathByProperName("ruleId"));
		firstEff = arg0.getStr(getPathByProperName("firstEff"));
		returnMonth = arg0.getStr(getPathByProperName("returnMonth"));
		intervalMonth = arg0.getStr(getPathByProperName("intervalMonth"));
		expFlag = arg0.getStr(getPathByProperName("expFlag"));
		isSendFlag = arg0.getStr(getPathByProperName("isSendFlag"));
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("expDate")))){
			
			expDate = arg0.getStr(getPathByProperName("expDate"));
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("validMonth")))){
			
			validMonth = arg0.getStr(getPathByProperName("validMonth"));
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("remark")))){
			remark = arg0.getStr(arg0.getStr(getPathByProperName("remark")));
		}else{
			remark = "营销返费";
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("billtotcodeUser")))){
			
			billtotcodeUser = (Map<String, Object>)arg0.getObject(getPathByProperName("billtotcodeUser"));
		}
		
		//逻辑：目前只有专款类型为FB情况才会有底限消费限制。后续如果有其它情况，则修改此校验
		if(!payType.equals("FB") && billtotcodeUser != null){
			
			throw new BusiException(getErrorCode("0000", "01001"), "非FB专款不应该存在底线消费");
		}
		
	}


	public Map<String, Object> getBilltotcodeUser() {
		return billtotcodeUser;
	}


	public void setBilltotcodeUser(Map<String, Object> billtotcodeUser) {
		this.billtotcodeUser = billtotcodeUser;
	}


	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}


	public String getForeignSn() {
		return foreignSn;
	}


	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
	}


	public String getForeignTime() {
		return foreignTime;
	}


	public void setForeignTime(String foreignTime) {
		this.foreignTime = foreignTime;
	}


	public String getPhoneNo() {
		return phoneNo;
	}


	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}


	public long getIdNo() {
		return idNo;
	}


	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}


	public long getContractNo() {
		return contractNo;
	}


	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}


	public String getIsPrint() {
		return isPrint;
	}


	public void setIsPrint(String isPrint) {
		this.isPrint = isPrint;
	}


	public String getPayPath() {
		return payPath;
	}


	public void setPayPath(String payPath) {
		this.payPath = payPath;
	}


	public String getPayMethod() {
		return payMethod;
	}


	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}


	public String getActId() {
		return actId;
	}


	public void setActId(String actId) {
		this.actId = actId;
	}


	public String getMeansId() {
		return meansId;
	}


	public void setMeansId(String meansId) {
		this.meansId = meansId;
	}


	public String getActType() {
		return actType;
	}


	public void setActType(String actType) {
		this.actType = actType;
	}


	public String getPayType() {
		return payType;
	}


	public void setPayType(String payType) {
		this.payType = payType;
	}


	public String getMktType() {
		return mktType;
	}


	public void setMktType(String mktType) {
		this.mktType = mktType;
	}


	public String getReturnFee() {
		return returnFee;
	}


	public void setReturnFee(String returnFee) {
		this.returnFee = returnFee;
	}


	public String getRuleId() {
		return ruleId;
	}


	public void setRuleId(String ruleId) {
		this.ruleId = ruleId;
	}


	public String getFirstEff() {
		return firstEff;
	}


	public void setFirstEff(String firstEff) {
		this.firstEff = firstEff;
	}


	public String getReturnMonth() {
		return returnMonth;
	}


	public void setReturnMonth(String returnMonth) {
		this.returnMonth = returnMonth;
	}


	public String getIntervalMonth() {
		return intervalMonth;
	}


	public void setIntervalMonth(String intervalMonth) {
		this.intervalMonth = intervalMonth;
	}


	public String getExpFlag() {
		return expFlag;
	}


	public void setExpFlag(String expFlag) {
		this.expFlag = expFlag;
	}


	public String getExpDate() {
		return expDate;
	}


	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}


	public String getValidMonth() {
		return validMonth;
	}


	public void setValidMonth(String validMonth) {
		this.validMonth = validMonth;
	}


	public String getIsSendFlag() {
		return isSendFlag;
	}


	public void setIsSendFlag(String isSendFlag) {
		this.isSendFlag = isSendFlag;
	}

}
