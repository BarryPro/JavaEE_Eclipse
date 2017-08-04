package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 空中充值确认入参DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8016CfmInDTO extends CommonInDTO{

	@ParamDesc(path="BUSI_INFO.AGENT_PHONE",cons=ConsType.CT001,type="String",len="40",desc="代理商手机号码",memo="略")
	private String	agentPhone = "";
	
	@ParamDesc(path="BUSI_INFO.AGENT_PASSWORD",cons=ConsType.CT001,type="String",len="40",desc="代理商账号密码",memo="略")
	private String	agentPassword = "";
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="充值号码",memo="略")
	private String	phoneNo = "";
	
	@ParamDesc(path="BUSI_INFO.PAY_MONEY",cons=ConsType.CT001,type="String",len="14",desc="缴费金额",memo="单位：分")
	private long	payMoney = 0;
	
	@ParamDesc(path="BUSI_INFO.PAY_PATH",cons=ConsType.CT001,type="String",len="5",desc="缴费渠道",
			memo="02:网上营业厅,06:IVR,04:短信营业厅")
	private String	payPath = "";
	
	@ParamDesc(path="BUSI_INFO.PAY_METHOD",cons=ConsType.CT001,type="String",len="5",desc="缴费方式",
			memo="B:空中充值")
	private String	payMethod = "";
	
	@ParamDesc(path="BUSI_INFO.PAY_NOTE",cons=ConsType.QUES,type="String",len="100",desc="缴费备注",memo="略")
	private	String	payNote = "";
	
	@ParamDesc(path="BUSI_INFO.FOREIGN_SN",cons=ConsType.CT001,type="String",len="60",desc="外部缴费流水",memo="略")
	private String	foreignSn = "";
	
	@ParamDesc(path="BUSI_INFO.FOREIGN_TIME",cons=ConsType.QUES,type="String",len="14",desc="外部时间",memo="外部缴费时间，可空，格式为YYYYMMDDHHMISS")
	private String	foreignTime = "";
	
	
	public void decode(MBean arg0){
		super.decode(arg0);
		
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "8016";//设置默认值
		}
		agentPhone = arg0.getBodyStr("BUSI_INFO.AGENT_PHONE");
		agentPassword = arg0.getBodyStr("BUSI_INFO.AGENT_PASSWORD");
		phoneNo = arg0.getBodyStr("BUSI_INFO.PHONE_NO");
		payMoney = Long.parseLong(arg0.getBodyStr("BUSI_INFO.PAY_MONEY"));
		payPath = arg0.getBodyStr("BUSI_INFO.PAY_PATH");
		payMethod = arg0.getBodyStr("BUSI_INFO.PAY_METHOD");
		
		payNote = arg0.getBodyStr("BUSI_INFO.PAY_NOTE");
		if (StringUtils.isEmptyOrNull(payNote)){
			payNote = "空中充值" + this.getLoginNo();//设置缴费默认备注
		}
		foreignSn = arg0.getBodyStr("BUSI_INFO.FOREIGN_SN");
		if (StringUtils.isEmptyOrNull(foreignSn)){
			foreignSn = "";
		}
		foreignTime = arg0.getBodyStr("BUSI_INFO.FOREIGN_TIME");

	}


	public String getAgentPhone() {
		return agentPhone;
	}

	public void setAgentPhone(String agentPhone) {
		this.agentPhone = agentPhone;
	}

	public String getAgentPassword() {
		return agentPassword;
	}

	public void setAgentPassword(String agentPassword) {
		this.agentPassword = agentPassword;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public long getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
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
	
}
