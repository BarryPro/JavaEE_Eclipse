package com.sitech.acctmgr.atom.dto.cct;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

public class S8157CfmInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 716975520827551140L;
	/*@ParamDesc(path = "BUSI_INFO.IS_CREDIT", cons = ConsType.CT001, type = "String", len = "2", desc = "是否为信用度用户", memo = "略")
	String isCredit = "";*/
	@ParamDesc(path = "BUSI_INFO.PHONE_NO", cons = ConsType.QUES, type = "String", len = "40", desc = "服务号码", memo = "phone_no、id_no不能同时为空")
	String phoneNo = "";
	@ParamDesc(path = "BUSI_INFO.CREDIT_CLASS", cons = ConsType.CT001, type = "String", len = "10", desc = "信用度等级", memo = "a:五星钻,b:五星金,c:五星普通,d:四星,e:三星,f:二星,g:一星,h:准星,A:未评级")
	String creditClass = "";
	@ParamDesc(path = "BUSI_INFO.OP_NOTE", cons = ConsType.CT001, type = "String", len = "100", desc = "操作备注", memo = "略")
	String opNote = "";

	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		if (StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo"))) && StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("idNo")))){
			throw new BusiException(getErrorCode("8157", "11001"), "PHONE_NO和ID_NO不能同时为空");
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))){
			setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		}
		setCreditClass(arg0.getStr(getPathByProperName("creditClass")));
		setOpNote(arg0.getStr(getPathByProperName("opNote")));
	}

	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}

	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	/**
	 * @return the creditClass
	 */
	public String getCreditClass() {
		return creditClass;
	}

	/**
	 * @param creditClass the creditClass to set
	 */
	public void setCreditClass(String creditClass) {
		this.creditClass = creditClass;
	}

	/**
	 * @return the opNote
	 */
	public String getOpNote() {
		return opNote;
	}

	/**
	 * @param opNote the opNote to set
	 */
	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}



	
}
