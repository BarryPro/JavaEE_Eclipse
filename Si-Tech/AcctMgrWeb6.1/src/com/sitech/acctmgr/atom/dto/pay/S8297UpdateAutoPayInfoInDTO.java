package com.sitech.acctmgr.atom.dto.pay;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 第三方缴费签约关系设置签约入参DTO  </p>
 * <p>Description: 		  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8297UpdateAutoPayInfoInDTO extends CommonInDTO {
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.UPDATE_FLAG",cons=ConsType.CT001,type="String",len="1",desc="设置标识",memo="1：设置金额，2：设置阀值，3：设置开关，4：设置（金额+阀值），5：开通（金额+阀值+开关）")
	private String updateFlag;
	
	@ParamDesc(path="BUSI_INFO.PAY_MONEY",cons=ConsType.QUES,type="long",len="14",desc="自动缴费金额",memo="单位：分")
	private long payMoney;
	
	@ParamDesc(path="BUSI_INFO.THRESHOLD_VALUE",cons=ConsType.QUES,type="String",len="14",desc="阀值，缴费临界值",memo="单位：分")
	private long thresholdValue;
	
	@ParamDesc(path="BUSI_INFO.AUTO_FLAG",cons=ConsType.QUES,type="String",len="14",desc="自动缴费开关",memo="1:开  0：关")
	private String autoFlag;
	
	@ParamDesc(path="BUSI_INFO.OP_NOTE",cons=ConsType.QUES,type="String",len="100",desc="备注",memo="略")
	private String opNote;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setUpdateFlag(arg0.getStr(getPathByProperName("updateFlag")));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("payMoney")))){
			
			setPayMoney(Long.parseLong(arg0.getStr(getPathByProperName("payMoney"))));
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("thresholdValue")))){
			
			setThresholdValue(Long.parseLong(arg0.getStr(getPathByProperName("thresholdValue"))));
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("autoFlag")))){
			
			setAutoFlag(arg0.getStr(getPathByProperName("autoFlag")));
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("opNote")))){
			
			setOpNote(arg0.getStr(getPathByProperName("opNote")));
		}
		
/*		//自动缴费金额只能设置为20、30、50、100、150、200、250、300、350、400、450、500 元
		if(updateFlag.equals("1") || updateFlag.equals("4") || updateFlag.equals("5")){
			
			if(!(this.payMoney == 2000 || this.payMoney == 3000 || this.payMoney == 5000 
				|| this.payMoney == 10000 || this.payMoney == 15000|| this.payMoney == 20000
				|| this.payMoney == 25000|| this.payMoney == 30000|| this.payMoney == 35000
				|| this.payMoney == 40000|| this.payMoney == 45000|| this.payMoney == 50000)){
				
				throw new BusiException(getErrorCode(opCode, "01001"), "自动缴费金额设置不正确!");
			}
		}*/
	}

	
	public String getOpNote() {
		return opNote;
	}

	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getUpdateFlag() {
		return updateFlag;
	}

	public void setUpdateFlag(String updateFlag) {
		this.updateFlag = updateFlag;
	}

	public long getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}

	public long getThresholdValue() {
		return thresholdValue;
	}

	public void setThresholdValue(long thresholdValue) {
		this.thresholdValue = thresholdValue;
	}

	public String getAutoFlag() {
		return autoFlag;
	}

	public void setAutoFlag(String autoFlag) {
		this.autoFlag = autoFlag;
	}

}
