package com.sitech.acctmgr.atom.dto.adj;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   投诉退费批量查询入参DTO</p>
 * <p>Description:   对入参进行解析成MBean，并检验入参的正确性</p>
 * <p>Copyright: Copyright (c) 2016</p>
 * <p>Company: SI-TECH </p>
 * @author guowy
 * @version 1.0
 */
public class S8041QryBatchInDTO extends CommonInDTO{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8413805725214942375L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	@ParamDesc(path="BUSI_INFO.REGION_CODE",cons=ConsType.QUES,type="String",len="8",desc="地市代码",memo="略")
	protected String regionCode;
	@ParamDesc(path="BUSI_INFO.BEGIN_TIME",cons=ConsType.CT001,type="String",len="18",desc="开始时间",memo="略")
	protected String beginTime;
	@ParamDesc(path="BUSI_INFO.END_TIME",cons=ConsType.CT001,type="String",len="18",desc="开始时间",memo="略")
	protected String endTime;
	@ParamDesc(path="BUSI_INFO.QRY_FLAG",cons=ConsType.CT001,type="String",len="18",desc="查询标志",memo="1：查询退费记录  2：查询退费冲正记录")
	protected String qryFlag;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setRegionCode(arg0.getStr(getPathByProperName("regionCode")));
		setBeginTime(arg0.getStr(getPathByProperName("beginTime")));
		setEndTime(arg0.getStr(getPathByProperName("endTime")));
		setQryFlag(arg0.getStr(getPathByProperName("qryFlag")));
		
		if(StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("opCode")))){
			opCode="8041";
		}
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
	 * @return the beginTime
	 */
	public String getBeginTime() {
		return beginTime;
	}

	/**
	 * @param beginTime the beginTime to set
	 */
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}

	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	/**
	 * @return the regionCode
	 */
	public String getRegionCode() {
		return regionCode;
	}

	/**
	 * @param regionCode the regionCode to set
	 */
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	/**
	 * @return the qryFlag
	 */
	public String getQryFlag() {
		return qryFlag;
	}

	/**
	 * @param qryFlag the qryFlag to set
	 */
	public void setQryFlag(String qryFlag) {
		this.qryFlag = qryFlag;
	}

}
