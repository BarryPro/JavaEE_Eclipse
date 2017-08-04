package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

 
/**
* @Title:   []
* @Description: 一点支付缴费根据证件获取账户 入参DTO 
* @Date :2015年2月4日
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class S8020AccountInDTO extends CommonInDTO{
	
	@ParamDesc(path="BUSI_INFO.ID_ICCID",cons=ConsType.CT001,type="String",len="50",desc="证件号码",memo="略")
	protected String idICCID;
	 
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setIdICCID(arg0.getStr(getPathByProperName("idICCID")).trim());
	}
	

	/**
	 * @return the idICCID
	 */
	public String getIdICCID() {
		return idICCID;
	}

	/**
	 * @param idICCID the idICCID to set
	 */
	public void setIdICCID(String idICCID) {
		this.idICCID = idICCID;
	}

}

