package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * @Title:   []
 * @Description: 
 * @Date : 2015年2月28日下午2:46:22
 * @Company: SI-TECH
 * @author : LIJXD
 * @version : 1.0
 * @modify history
 *  <p>修改日期    修改人   修改目的<p> 	
 */
public class SGrpUnifyPayCfmOutDTO extends CommonOutDTO {

 
	/**
	 * 
	 */
	private static final long serialVersionUID = 7896522214415101844L;
	
	@JSONField(name="ID_TYPE")
	@ParamDesc(path="ID_TYPE",cons=ConsType.CT001,type="String",len="2",desc="用户类型",memo="略")
	protected String idType;
	@JSONField(name="ID_VALUE")
	@ParamDesc(path="ID_VALUE",cons=ConsType.CT001,type="String",len="18",desc="用户号码",memo="略")
	protected String 	idValue ; 
	@JSONField(name="TRANSACTION_ID")
	@ParamDesc(path="TRANSACTION_ID",cons=ConsType.CT001,type="String",len="32",desc="统一流水",memo="略")
	protected String 	transactionId ;  
	@JSONField(name="ACTION_DATE")
	@ParamDesc(path="ACTION_DATE",cons=ConsType.CT001,type="String",len="8",desc="请求日期",memo="略")
	protected String 	actionDate ; 
	@JSONField(name="USER_CAT")
	@ParamDesc(path="USER_CAT",cons=ConsType.CT001,type="String",len="1",desc="标识",memo="略")
	protected String 	userCat ; 
	@JSONField(name="RSP_CODE")
	@ParamDesc(path="RSP_CODE",cons=ConsType.CT001,type="String",len="4",desc="二级返回码",memo="略")
	protected String 	rspCode ; 
	@JSONField(name="RSP_INFO")
	@ParamDesc(path="RSP_INFO",cons=ConsType.CT001,type="String",len="1024",desc="返回信息",memo="略")
	protected String 	rspInfo ; 
	
	/*public SGrpUnifyPayCfmOutDTO(){

	}
	
	public SGrpUnifyPayCfmOutDTO(String sJson){
		MBean mBean = new MBean(sJson);
		this.sIdType = mBean.getBodyStr("OUT_DATA.ID_TYPE");
		this.sIdValue = mBean.getBodyStr("OUT_DATA.ID_VALUE");
		this.sTransactionId = mBean.getBodyStr("OUT_DATA.TRANSACTION_ID");
		this.sActionDate = mBean.getBodyStr("OUT_DATA.ACTION_DATE");
		this.sUserCat = mBean.getBodyStr("OUT_DATA.USER_CAT");
		this.sRspCode = mBean.getBodyStr("OUT_DATA.RSP_CODE");
		this.sRspInfo = mBean.getBodyStr("OUT_DATA.RSP_INFO");
	}*/
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result = super.encode();
		result.setRoot(getPathByProperName("idType"), idType);
		result.setRoot(getPathByProperName("idValue"), idValue);
		result.setRoot(getPathByProperName("transactionId"), transactionId);
		result.setRoot(getPathByProperName("actionDate"), actionDate);
		result.setRoot(getPathByProperName("userCat"), userCat);
		result.setRoot(getPathByProperName("rspCode"), rspCode);
		result.setRoot(getPathByProperName("rspInfo"), rspInfo);
		return result;
	}

	/**
	 * @return the idType
	 */
	public String getIdType() {
		return idType;
	}

	/**
	 * @param idType the idType to set
	 */
	public void setIdType(String idType) {
		this.idType = idType;
	}

	/**
	 * @return the idValue
	 */
	public String getIdValue() {
		return idValue;
	}

	/**
	 * @param idValue the idValue to set
	 */
	public void setIdValue(String idValue) {
		this.idValue = idValue;
	}

	/**
	 * @return the transactionId
	 */
	public String getTransactionId() {
		return transactionId;
	}

	/**
	 * @param transactionId the transactionId to set
	 */
	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	/**
	 * @return the actionDate
	 */
	public String getActionDate() {
		return actionDate;
	}

	/**
	 * @param actionDate the actionDate to set
	 */
	public void setActionDate(String actionDate) {
		this.actionDate = actionDate;
	}

	/**
	 * @return the userCat
	 */
	public String getUserCat() {
		return userCat;
	}

	/**
	 * @param userCat the userCat to set
	 */
	public void setUserCat(String userCat) {
		this.userCat = userCat;
	}

	/**
	 * @return the rspCode
	 */
	public String getRspCode() {
		return rspCode;
	}

	/**
	 * @param rspCode the rspCode to set
	 */
	public void setRspCode(String rspCode) {
		this.rspCode = rspCode;
	}

	/**
	 * @return the rspInfo
	 */
	public String getRspInfo() {
		return rspInfo;
	}

	/**
	 * @param rspInfo the rspInfo to set
	 */
	public void setRspInfo(String rspInfo) {
		this.rspInfo = rspInfo;
	}

	 
	
	
	
}
