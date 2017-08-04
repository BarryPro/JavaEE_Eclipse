package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8008BbdOutDTO extends CommonOutDTO{

	/**
	 *
	 * <p>Title: 宽带退预存款  </p>
	 * <p>Description:  将String入参解析成MBean格式 </p>
	 * <p>Copyright: Copyright (c) 2016</p>
	 * <p>Company: SI-TECH </p>
	 * @author SUZJ
	 * @version 1.0
	 */
	private static final long serialVersionUID = 1L;
	
	@JSONField(name="PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.STAR,type="String",len="40",desc="电话号",memo="略")
	protected	String PHONE_NO;
	@JSONField(name="CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.STAR,type="long",len="40",desc="账户号",memo="略")
	protected	Long CONTRACT_NO;
	@JSONField(name="AUTHORISE_FLAG")
	@ParamDesc(path="AUTHORISE_FLAG",cons=ConsType.STAR,type="String",len="1",desc="a272权限标志",memo="略")
	protected	String authoriseFlag;
	
	/**
	 * @return the CONTRACT_NO
	 */
	public Long getCONTRACT_NO() {
		return CONTRACT_NO;
	}
	
	/**
	 * @param CONTRACT_NO the CONTRACT_NO to set
	 */
	public void setCONTRACT_NO(Long cONTRACT_NO) {
		CONTRACT_NO = cONTRACT_NO;
		System.out.println(cONTRACT_NO);
	}
	/**
	 * @return the PHONE_NO
	 */
	public String getPHONE_NO() {
		return PHONE_NO;
	}
	/**
	 * @param PHONE_NO the PHONE_NO to set
	 */
	public void setPHONE_NO(String phoneNo) {
		PHONE_NO = phoneNo;
	}
	
	
	
	/**
	 * @return the authoriseFlag
	 */
	public String getAuthoriseFlag() {
		return authoriseFlag;
	}

	/**
	 * @param authoriseFlag the authoriseFlag to set
	 */
	public void setAuthoriseFlag(String authoriseFlag) {
		this.authoriseFlag = authoriseFlag;
	}

	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("PHONE_NO"), PHONE_NO);
		result.setRoot(getPathByProperName("CONTRACT_NO"),CONTRACT_NO);
		result.setRoot(getPathByProperName("authoriseFlag"),authoriseFlag);
		return result;
	}
}
