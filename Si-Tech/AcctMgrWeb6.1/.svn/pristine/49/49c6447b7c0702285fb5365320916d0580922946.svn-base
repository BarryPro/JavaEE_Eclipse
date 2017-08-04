package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.PayOutEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * <p>Title: 缴费确认出参DTO  </p>
 * <p>Description: 缴费确认出参DTO，封装出参结果  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author zhangjp
 * @version 1.0
 */
public class S8000CfmOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3955468863171228032L;
	
	@JSONField(name="TOTAL_DATE")
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="String",len="8",desc="缴费日期",memo="略")
	protected String totalDate;//缴费日期
	
	@JSONField(name="PAYSN_LIST")
	@ParamDesc(path="PAYSN_LIST",cons=ConsType.STAR,type="compx",len="1",desc="缴费流水列表",memo="略")
	private	List<PayOutEntity> paySnList = new ArrayList<PayOutEntity>();
	
	@JSONField(name="USER_NAME")
	@ParamDesc(path="USER_NAME",cons=ConsType.CT001,type="String",len="100",desc="用户名称",memo="用户名称，目前银行缴费才有值")
	private String conName;
	
	@JSONField(name="REMAIN_FEE")
	@ParamDesc(path="REMAIN_FEE",cons=ConsType.CT001,type="long",len="18",desc="当前余额",memo="缴费后余额，，目前银行缴费缴费才有值")
	private long remainFee;
	
	public S8000CfmOutDTO(){

	}
	
	public S8000CfmOutDTO(String sJson){
		MBean mBean = new MBean(sJson);
		this.totalDate = mBean.getBodyStr("OUT_DATA.TOTAL_DATE");
		//this.paySnList = (List<Map<String, Object>>)mBean.getBodyList("OUT_DATA.PAYSN_LIST");
		List<Map<String, Object>> payListTmp = (List<Map<String, Object>>)mBean.getList(getPathByProperName("paySnList"));
		for(Map<String, Object> payTmp : payListTmp){
    		String jsonStr = JSON.toJSONString(payTmp);
    		this.paySnList.add(JSON.parseObject(jsonStr, PayOutEntity.class));
		}
		
		this.conName = mBean.getBodyStr("OUT_DATA.USER_NAME");
		this.remainFee = mBean.getBodyLong("OUT_DATA.REMAIN_FEE");
	}
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("totalDate"), totalDate);
		result.setRoot(getPathByProperName("paySnList"), paySnList);
		result.setRoot(getPathByProperName("conName"), conName);
		result.setRoot(getPathByProperName("remainFee"), remainFee);
		
		return result;
	}
	


	/**
	 * @return the conName
	 */
	public String getConName() {
		return conName;
	}

	/**
	 * @param conName the conName to set
	 */
	public void setConName(String conName) {
		this.conName = conName;
	}

	/**
	 * @return the remainFee
	 */
	public long getRemainFee() {
		return remainFee;
	}

	/**
	 * @param remainFee the remainFee to set
	 */
	public void setRemainFee(long remainFee) {
		this.remainFee = remainFee;
	}

	/**
	 * @return the totalDate
	 */
	public String getTotalDate() {
		return totalDate;
	}

	/**
	 * @param totalDate the totalDate to set
	 */
	public void setTotalDate(String totalDate) {
		this.totalDate = totalDate;
	}

	/**
	 * @return the paySnList
	 */
	public List<PayOutEntity> getPaySnList() {
		return paySnList;
	}

	/**
	 * @param paySnList the paySnList to set
	 */
	public void setPaySnList(List<PayOutEntity> paySnList) {
		this.paySnList = paySnList;
	}

}
