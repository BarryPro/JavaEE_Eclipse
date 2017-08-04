package com.sitech.acctmgr.atom.dto.pay;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.pay.FieldEntity;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

/**
 *
 * <p>Title: 缴费确认入参DTO  </p>
 * <p>Description: 缴费确认入参DTO  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author zhangjp
 * @version 1.0
 */
public class S8000CfmDiscountInDTO extends CommonInDTO {
	
	private static final long serialVersionUID = -7590756544701548980L;

	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="账号",memo="略")
	private long contractNo;

	@ParamDesc(path="BUSI_INFO.PAY_TYPE",cons=ConsType.CT001,type="String",len="5",desc="账本类型",memo="略")
	private String payType;
	
	@ParamDesc(path="BUSI_INFO.PAY_MONEY",cons=ConsType.CT001,type="String",len="14",desc="交费金额",memo="单位：分")
	private String payMoney;
	
	@ParamDesc(path="BUSI_INFO.DIS_COUNT",cons=ConsType.CT001,type="String",len="14",desc="折扣率",memo="折扣率以整数表示，此字段填写“98”，表明九八折,如果9.85折，此处填写98.5")
	private String disCount;
	
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
	
	/**
	控制标志，第1位：发送短信标志  0发送短信，1不发送
	*/
	@ParamDesc(path="BUSI_INFO.CTRL_FLAG",cons=ConsType.QUES,type="String",len="10",desc="控制标志",memo="控制标志， 发送短信标志  0发送短信，1不发送,默认0")
	private String ctrlFlag;
	
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
		
		phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		if(arg0.getObject(getPathByProperName("contractNo")) != null && !arg0.getObject(getPathByProperName("contractNo")).equals("")){
			contractNo = Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString());
		}
		if (StringUtils.isEmptyOrNull(phoneNo) && contractNo == 0){
			throw new BusiException(getErrorCode(opCode, "01002"), "PHONE_NO不能为空和CONTRACT_NO不能同时为空");
		}
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "8000";//设置默认值
		}
		
		payType = arg0.getStr(getPathByProperName("payType"));
		payMoney = arg0.getStr(getPathByProperName("payMoney"));
		disCount = arg0.getStr(getPathByProperName("disCount"));
		payPath = arg0.getStr(getPathByProperName("payPath"));
		payMethod = arg0.getStr(getPathByProperName("payMethod"));
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("delayRate")))){
			delayRate = Double.parseDouble(arg0.getStr(getPathByProperName("delayRate")));
		}
		
		if (!payPath.equals(PayBusiConst.OWNPATH)) {
			delayRate=1;
		}
		
		payNote = arg0.getStr(getPathByProperName("payNote"));
		if (StringUtils.isEmptyOrNull(payNote)){
			payNote = "";//设置缴费默认备注，待完善
		}
		foreignSn = arg0.getStr(getPathByProperName("foreignSn"));
		foreignTime = arg0.getStr(getPathByProperName("foreignTime"));
		ctrlFlag = arg0.getStr(getPathByProperName("ctrlFlag"));
		if (StringUtils.isEmptyOrNull(ctrlFlag)){
			ctrlFlag = "0";
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

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public String getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(String payMoney) {
		this.payMoney = payMoney;
	}

	public String getDisCount() {
		return disCount;
	}

	public void setDisCount(String disCount) {
		this.disCount = disCount;
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

	public String getCtrlFlag() {
		return ctrlFlag;
	}

	public void setCtrlFlag(String ctrlFlag) {
		this.ctrlFlag = ctrlFlag;
	}


}
