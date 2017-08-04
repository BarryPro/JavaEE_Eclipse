package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8229CheckQueryInDTO extends CommonInDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5574957028471815587L;
	
	@ParamDesc(path="BUSI_INFO.BANK_CODE",cons=ConsType.CT001,type="String",len="13",desc="银行代码",memo="略")
	protected String bankCode;
	@ParamDesc(path="BUSI_INFO.CHECK_NO",cons=ConsType.CT001,type="String",len="40",desc="支票号码",memo="略")
	protected String checkNo;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setBankCode(arg0.getStr(getPathByProperName("bankCode")));
		setCheckNo(arg0.getStr(getPathByProperName("checkNo")));
		
		if(StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("opCode")))){
			opCode="8229";
		}
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
}
