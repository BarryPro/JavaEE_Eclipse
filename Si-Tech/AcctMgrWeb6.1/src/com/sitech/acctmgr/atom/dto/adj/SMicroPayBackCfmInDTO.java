package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;


/**
* @Description: 手机钱包冲正入参DTO
* @Date :2016年11月07日
* @Company: SI-TECH
* @author : liuyc_billing
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class SMicroPayBackCfmInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4006963585921469284L;
	
	
	@ParamDesc(path="BUSI_INFO.LOGIN_PASSWORD",cons=ConsType.CT001,type="String",len="20",desc="工号密码",memo="略")
	private String vPassWord;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="20",desc="手机号码",memo="略")
	private String inPhoneNo;
	@ParamDesc(path="BUSI_INFO.TRADE_CODE",cons=ConsType.CT001,type="String",len="40",desc="交易代码",memo="略")
	private String vTradCode;
	@ParamDesc(path="BUSI_INFO.IN_TRANS_ID",cons=ConsType.CT001,type="String",len="40",desc="交易流水",memo="略")
	private String inTransId;
	@ParamDesc(path="BUSI_INFO.IN_BACKTRANS_ID",cons=ConsType.CT001,type="String",len="40",desc="冲正交易流水",memo="略")
	private String inBackTransId;
	@ParamDesc(path="BUSI_INFO.IN_TRANS_DATE",cons=ConsType.CT001,type="String",len="40",desc="交易日期",memo="略")
	private String inTransDate;



	@Override
	public void decode(MBean arg0){
		super.decode(arg0);
		setvPassWord(arg0.getStr(getPathByProperName("vPassWord")));
		setInPhoneNo(arg0.getStr(getPathByProperName("inPhoneNo")));
		setvTradCode(arg0.getStr(getPathByProperName("vTradCode")));
		setInTransId(arg0.getStr(getPathByProperName("inTransId")));
		setInBackTransId(arg0.getStr(getPathByProperName("inBackTransId")));
		setInTransDate(arg0.getStr(getPathByProperName("inTransDate")));
	
		/*设置默认opcode*/
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "C240";
		}
	}
	
	
	

	public String getvPassWord() {
		return vPassWord;
	}

	public void setvPassWord(String vPassWord) {
		this.vPassWord = vPassWord;
	}

	public String getInPhoneNo() {
		return inPhoneNo;
	}

	public void setInPhoneNo(String inPhoneNo) {
		this.inPhoneNo = inPhoneNo;
	}

	public String getvTradCode() {
		return vTradCode;
	}

	public void setvTradCode(String vTradCode) {
		this.vTradCode = vTradCode;
	}

	public String getInTransId() {
		return inTransId;
	}

	public void setInTransId(String inTransId) {
		this.inTransId = inTransId;
	}

	public String getInTransDate() {
		return inTransDate;
	}

	public void setInTransDate(String inTransDate) {
		this.inTransDate = inTransDate;
	}
	
	public String getInBackTransId() {
		return inBackTransId;
	}

	public void setInBackTransId(String inBackTransId) {
		this.inBackTransId = inBackTransId;
	}


}
