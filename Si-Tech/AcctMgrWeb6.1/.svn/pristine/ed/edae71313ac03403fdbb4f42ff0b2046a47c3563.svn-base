package com.sitech.acctmgr.atom.dto.pay;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

 
/**
* @Description: 一点支付缴费：确认  出参DTO 
* @Date :2015年2月4日
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class S8020CfmOutDTO extends CommonOutDTO{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4484709076460754428L;
	
	@JSONField(name="PAY_ACCEPT")
	@ParamDesc(path="PAY_ACCEPT",cons=ConsType.CT001,type="long",len="18",desc="流水",memo="略")
	long  payAccept ;

	@JSONField(name="TOTAL_DATE")
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="String",len="8",desc="缴费日期",memo="略")
	protected String totalDate;//缴费日期
	
	public S8020CfmOutDTO() {
	}

	public S8020CfmOutDTO(String sJson) {
		MBean mBean = new MBean(sJson);
		this.payAccept = mBean.getLong(getPathByProperName("payAccept"));
		//this.payAccept = mBean.getBodyLong("OUT_DATA.PAY_ACCEPT");
	}
	
	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("payAccept"), payAccept);
		result.setRoot(getPathByProperName("totalDate"), totalDate);
		return result;
	}

	public String getTotalDate() {
		return totalDate;
	}

	public void setTotalDate(String totalDate) {
		this.totalDate = totalDate;
	}

	/**
	 * @return the payAccept
	 */
	public long getPayAccept() {
		return payAccept;
	}

	/**
	 * @param payAccept the payAccept to set
	 */
	public void setPayAccept(long payAccept) {
		this.payAccept = payAccept;
	}

	 
}
