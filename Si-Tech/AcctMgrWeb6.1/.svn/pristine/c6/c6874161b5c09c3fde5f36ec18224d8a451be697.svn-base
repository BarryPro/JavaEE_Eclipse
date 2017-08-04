package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
* @Description: 飞豆充值验证 出参DTO 
* @Date :2015年5月21日
* @Company: SI-TECH
* @author : chenyha
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
*/
public class SFeiDouPayCfmOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4164659318145859662L;

	@JSONField(name="PAY_ACCEPT")
	@ParamDesc(path="PAY_ACCEPT",cons=ConsType.CT001,type="long",len="20",desc="交费流水",memo="略")
	long payAccept;

	@JSONField(name="SYSPLAT_ID")
	@ParamDesc(path="SYSPLAT_ID",cons=ConsType.CT001,type="long",len="4",desc="平台标识号",memo="平台标识号 1-飞信 2-139邮箱 3-MM")
	String sysplatId;

	@JSONField(name="SERV_ID")
	@ParamDesc(path="SERV_ID",cons=ConsType.CT001,type="long",len="20",desc="用户标识",memo="略")
	long servId;
	
	@JSONField(name="PAY_ACCID")
	@ParamDesc(path="PAY_ACCID",cons=ConsType.CT001,type="long",len="20",desc="支付帐户标识",memo="略")
	long payAccid;

	public MBean encode() {
		MBean result=super.encode();
		result.setRoot(getPathByProperName("payAccept"), payAccept);
		result.setRoot(getPathByProperName("sysplatId"), sysplatId);
		result.setRoot(getPathByProperName("servId"), servId);
		result.setRoot(getPathByProperName("payAccid"), payAccid);
		return result;
	}

	public String getSysplatId() {
		return sysplatId;
	}

	public void setSysplatId(String sysplatId) {
		this.sysplatId = sysplatId;
	}

	public long getPayAccept() {
		return payAccept;
	}

	public void setPayAccept(long payAccept) {
		this.payAccept = payAccept;
	}

	public long getServId() {
		return servId;
	}

	public void setServId(long servId) {
		this.servId = servId;
	}

	public long getPayAccid() {
		return payAccid;
	}

	public void setPayAccid(long payAccid) {
		this.payAccid = payAccid;
	}
	
	
}
