package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 退预存款  </p>
 * <p>Description:  将String入参解析成MBean格式 </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class SAuthoriseQryInDTO extends CommonInDTO{

 
	/**
	 * 
	 */
	private static final long serialVersionUID = 6530513105591434857L;
 
	@ParamDesc(path="BUSI_INFO.IS_AUTHEN",cons=ConsType.CT001,type="String",len="6",desc="审批标识",memo=" 三位 “YYY” 第一位是模块级 第二位是业务级 第三位表示 是否强制认证 : 账务的授权审批都是业务级别，程序会根据第二位是Y来判断是否调用基础域接口")
	protected String isAuthen;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="14",desc="请求号码",memo="")
	protected String phoneNo;
	@ParamDesc(path="BUSI_INFO.APPBUSI_CODE",cons=ConsType.CT001,type="String",len="12",desc="业务级别授权审批时传对应的业务编号",memo="NNY/NNN和YNY/YNN的情况传空即可。APP_8008_001：在网用户退预存款 ；APP_8054_001：退费受理；APP_8056_001：资金冲正")
	protected String appbusiCode;
	@ParamDesc(path="BUSI_INFO.APPROVE_TYPE",cons=ConsType.QUES,type="String",len="3",desc="授权审批类型",memo=" : 三位 “YYY” 第一位是模块级 第二位是业务级 第三位表示 是否强制认证（调用此接口基本是YYN）；不传入从配置文件读取")
	protected String approveType;
	@ParamDesc(path="BUSI_INFO.PROVINCE_ID",cons=ConsType.QUES,type="String",len="1024",desc="省份ID",memo="session里面有，吉林默认为220000，不传入从配置文件读取")
	protected String provinceId;
	
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		setIsAuthen(arg0.getStr(getPathByProperName("isAuthen")));
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setApproveType(arg0.getStr(getPathByProperName("approveType")));
		setAppbusiCode(arg0.getStr(getPathByProperName("appbusiCode")));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("provinceId")))){
			setProvinceId(arg0.getStr(getPathByProperName("provinceId")));
		}
	}

	/**
	 * @return the isAuthen
	 */
	public String getIsAuthen() {
		return isAuthen;
	}

	/**
	 * @param isAuthen the isAuthen to set
	 */
	public void setIsAuthen(String isAuthen) {
		this.isAuthen = isAuthen;
	}

	/**
	 * @return the approveType
	 */
	public String getApproveType() {
		return approveType;
	}

	/**
	 * @param approveType the approveType to set
	 */
	public void setApproveType(String approveType) {
		this.approveType = approveType;
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
	 * @return the provinceId
	 */
	public String getProvinceId() {
		return provinceId;
	}

	/**
	 * @param provinceId the provinceId to set
	 */
	public void setProvinceId(String provinceId) {
		this.provinceId = provinceId;
	}

	/**
	 * @return the appbusiCode
	 */
	public String getAppbusiCode() {
		return appbusiCode;
	}

	/**
	 * @param appbusiCode the appbusiCode to set
	 */
	public void setAppbusiCode(String appbusiCode) {
		this.appbusiCode = appbusiCode;
	}

 
	
	
}
