package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.pay.FieldEntity;
import com.sitech.acctmgr.atom.domains.pay.PayInfoEntity;
import com.sitech.acctmgr.atom.domains.pay.PosPayEntity;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

/**
 *
 * <p>Title: 缴费确认入参DTO  </p>
 * <p>Description: 缴费确认入参DTO  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8000CfmInDTO extends CommonInDTO {
	
	private static final long serialVersionUID = 5083778749611770159L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="账号",memo="略")
	private long contractNo;

	@ParamDesc(path="BUSI_INFO.PAY_LIST",cons=ConsType.PLUS,type="complex",len="1",desc="缴费账本+金额",memo="略")
	private	List<PayInfoEntity>	payList = new ArrayList<PayInfoEntity>();
	
	@ParamDesc(path="BUSI_INFO.PAY_PATH",cons=ConsType.CT001,type="String",len="5",desc="缴费渠道",
			memo="02:网上营业厅,06:IVR,04:短信营业厅,11:营业前台,05:自助终端,18:一级BOSS,19:银行,21:智能终端CRM,28:三卡合一")
	private String payPath;
	
	@ParamDesc(path="BUSI_INFO.PAY_METHOD",cons=ConsType.CT001,type="String",len="5",desc="缴费方式",
			memo="0:现金,W:POS机,8:赠费,c:充值卡")
	private String payMethod;
	
	@ParamDesc(path="BUSI_INFO.DELAY_RATE",cons=ConsType.QUES,type="String",len="5",desc="滞纳金优惠率",memo="略")
	private double delayRate;
	
	@ParamDesc(path="BUSI_INFO.PAY_NOTE",cons=ConsType.QUES,type="String",len="100",desc="缴费备注",memo="略")
	private String payNote;
	
	@ParamDesc(path="BUSI_INFO.FOREIGN_SN",cons=ConsType.QUES,type="String",len="40",desc="外部流水",memo="略")
	private String foreignSn;
	
	@ParamDesc(path="BUSI_INFO.FOREIGN_TIME",cons=ConsType.QUES,type="String",len="14",desc="外部时间",memo="外部缴费时间，可空，格式为YYYYMMDDHHMISS")
	private String foreignTime;//外部缴费时间，可空，格式为YYYYMMDDHHMISS
	
	@ParamDesc(path="BUSI_INFO.BANK_CODE",cons=ConsType.QUES,type="String",len="12",desc="银行编码",memo="略")
	private String bankCode;
	
	@ParamDesc(path="BUSI_INFO.CHECK_NO",cons=ConsType.QUES,type="String",len="20",desc="支票号码",memo="略")
	private String checkNo;

	@ParamDesc(path="BUSI_INFO.AGENT_PHONE",cons=ConsType.QUES,type="String",len="40",desc="联动优势代理商手机号码",memo="联动优势空中充值时传入")
	private String agentPhone;
	
	/**
	控制标志，第1位：发送短信标志  0发送短信，1不发送
		        第2位：是否做开机  0 即不做开机， 1 要做开机
	*/
	@ParamDesc(path="BUSI_INFO.CTRL_FLAG",cons=ConsType.QUES,type="String",len="10",desc="控制标志",memo="控制标志， 发送短信标志  0发送短信，1不发送,默认0")
	private String ctrlFlag;
	
	@ParamDesc(path="BUSI_INFO.POSPAY_INFO",cons=ConsType.QUES,type="complex",len="1",desc="Pose机缴费传入字段",memo="略")
	private	PosPayEntity	posPayInfo = new PosPayEntity();
	
	@ParamDesc(path="BUSI_INFO.IS_DOWEINV",cons=ConsType.QUES,type="String",len="1",desc="集团预开发票回收标识",memo="预开发票回收： R")
	private String isDoweInv;

	@ParamDesc(path="BUSI_INFO.PRE_LOGIN_ACCEPT",cons=ConsType.QUES,type="String",len="20",desc="集团预开发票，开票流水",memo="略")
	private long preloginAccept;
	
	@ParamDesc(path="BUSI_INFO.FIELD_LIST",cons=ConsType.PLUS,type="complex",len="1",desc="属性列表",
			memo="针对例如手机支付传入集团定义的字段，便于统计, 其中手机支付传入["
			+ "5.15 全网手机支付缴话费传入 FIELD_CODE: TRANS_CODE, FIELD_VALUE: T1001006"
			+ "FIELD_CODE: CNL_TYPE ,FIELD_VALUE: 规范中的渠道标识 "
			+ "5.24企业营销代缴话费  FIELD_CODE: TRANS_CODE FIELD_VALUE: T1001008 "
			+ "5.26赠送营销缴话费 FIELD_CODE: TRANS_CODE FIELD_VALUE: T1001009 "
			+ "5.28政企客户统一充值  FIELD_CODE: TRANS_CODE FIELD_VALUE: T1001010]")
	private	List<FieldEntity> fieldList = new ArrayList<FieldEntity>();

	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		if(arg0.getObject(getPathByProperName("contractNo")) != null && !arg0.getObject(getPathByProperName("contractNo")).equals("")){
			setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
		}
		if (StringUtils.isEmptyOrNull(phoneNo) && contractNo == 0){
			throw new BusiException(getErrorCode(opCode, "01002"), "PHONE_NO不能为空和CONTRACT_NO不能同时为空");
		}
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "8000";//设置默认值
		}
		setPayPath(arg0.getStr(getPathByProperName("payPath")));
		setPayMethod(arg0.getStr(getPathByProperName("payMethod")));
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("delayRate")))){
			setDelayRate(Double.parseDouble(arg0.getStr(getPathByProperName("delayRate"))));
		}
		
		setBankCode(arg0.getStr(getPathByProperName("bankCode")));
		setCheckNo(arg0.getStr(getPathByProperName("checkNo")));
		setPayNote(arg0.getStr(getPathByProperName("payNote")));
		if (StringUtils.isEmptyOrNull(payNote)){
			payNote = "";//设置缴费默认备注，待完善
		}
		setForeignSn(arg0.getStr(getPathByProperName("foreignSn")));
		setForeignTime(arg0.getStr(getPathByProperName("foreignTime")));
		
		agentPhone = arg0.getStr(getPathByProperName("agentPhone"));
		
		setCtrlFlag(arg0.getStr(getPathByProperName("ctrlFlag")));
		if (StringUtils.isEmptyOrNull(ctrlFlag)){
			ctrlFlag = "01";
		}
		
		//payList = (List<Map<String, Object>>)arg0.getBodyList("BUSI_INFO.PAY_LIST");
		List<Map<String, Object>> payListTmp = (List<Map<String, Object>>)arg0.getList(getPathByProperName("payList"));
		for(Map<String, Object> payTmp : payListTmp){
    		String jsonStr = JSON.toJSONString(payTmp);
    		this.payList.add(JSON.parseObject(jsonStr, PayInfoEntity.class));
    		
    		if(Long.parseLong(payTmp.get("PAY_MONEY").toString()) < 0){
    			
    			throw new BusiException(getErrorCode(opCode, "01030"), "缴费金额不能为负");
    		}
		}
		
		//如果是POSE机缴费则获取POS缴费字段
		if (this.payMethod.equals(PayBusiConst.POS_TYPE)) {
			if (arg0.getObject(getPathByProperName("posPayInfo")) != null
					&& !arg0.getObject(getPathByProperName("posPayInfo")).equals("")) {
				posPayInfo = arg0.getObject(getPathByProperName("posPayInfo"),PosPayEntity.class);
			} else {

			}

		}
		
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("isDoweInv")))){
			isDoweInv = arg0.getStr(getPathByProperName("isDoweInv"));
			
		}
		
		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("preloginAccept")))){
			preloginAccept = Long.parseLong(arg0.getStr(getPathByProperName("preloginAccept")));
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getObject(getPathByProperName("fieldList")))){
			
			List<Map<String, Object>> signFieldList = (List<Map<String, Object>>)arg0.getList(getPathByProperName("fieldList"));
			for(Map<String, Object> payTmp : signFieldList){
	    		String jsonStr = JSON.toJSONString(payTmp);
	    		this.fieldList.add(JSON.parseObject(jsonStr, FieldEntity.class));
			}
		}
		//一级BOSS手机支付增加对属性传入的校验
		if( this.payPath.equals("18") && (this.payMethod.equals("11")||this.payMethod.equals("12") ||
										  this.payMethod.equals("8")) ){
			if(this.fieldList.size() == 0){
				throw new BusiException(getErrorCode(opCode, "01031"), "集团定义属性必传!");
			}
		}
	}


	public List<FieldEntity> getFieldList() {
		return fieldList;
	}

	public void setFieldList(List<FieldEntity> fieldList) {
		this.fieldList = fieldList;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	public List<PayInfoEntity> getPayList() {
		return payList;
	}

	public void setPayList(List<PayInfoEntity> payList) {
		this.payList = payList;
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

	public double getDelayRate() {
		return delayRate;
	}

	public void setDelayRate(double delayRate) {
		this.delayRate = delayRate;
	}

	public String getPayNote() {
		return payNote;
	}

	public void setPayNote(String payNote) {
		this.payNote = payNote;
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

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	public String getCheckNo() {
		return checkNo;
	}

	public void setCheckNo(String checkNo) {
		this.checkNo = checkNo;
	}

	public String getAgentPhone() {
		return agentPhone;
	}

	public void setAgentPhone(String agentPhone) {
		this.agentPhone = agentPhone;
	}

	public String getCtrlFlag() {
		return ctrlFlag;
	}

	public void setCtrlFlag(String ctrlFlag) {
		this.ctrlFlag = ctrlFlag;
	}

	public PosPayEntity getPosPayInfo() {
		return posPayInfo;
	}

	public void setPosPayInfo(PosPayEntity posPayInfo) {
		this.posPayInfo = posPayInfo;
	}

	public String getIsDoweInv() {
		return isDoweInv;
	}

	public void setIsDoweInv(String isDoweInv) {
		this.isDoweInv = isDoweInv;
	}

	public long getPreloginAccept() {
		return preloginAccept;
	}

	public void setPreloginAccept(long preloginAccept) {
		this.preloginAccept = preloginAccept;
	}

}
