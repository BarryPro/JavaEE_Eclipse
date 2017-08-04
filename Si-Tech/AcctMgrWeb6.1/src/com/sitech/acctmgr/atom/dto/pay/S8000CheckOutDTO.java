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
public class S8000CheckOutDTO extends CommonOutDTO {

	@ParamDesc(path="PAY_FLAG",cons=ConsType.CT001,type="String",len="1",desc="入账成功标识",memo="0：未入账  1：已入账")
	private String payFlag;
	
	@ParamDesc(path="TOTAL_DATE",cons=ConsType.CT001,type="String",len="8",desc="入账日期",memo="略")
	protected String totalDate;
	
	@ParamDesc(path="FOREIGN_SN",cons=ConsType.CT001,type="String",len="40",desc="外部流水",memo="略")
	private String foreignSn;
	
	@ParamDesc(path="PAYSN_LIST",cons=ConsType.STAR,type="complex",len="1",desc="入账缴费流水列表",memo="略")
	private	List<PayOutEntity> paySnList = new ArrayList<PayOutEntity>();

	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.out.OutDTO#encode()
	 */
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("payFlag"), payFlag);
		result.setRoot(getPathByProperName("totalDate"), totalDate);
		result.setRoot(getPathByProperName("foreignSn"), foreignSn);
		result.setRoot(getPathByProperName("paySnList"), paySnList);
		
		return result;
	}


	public String getPayFlag() {
		return payFlag;
	}


	public void setPayFlag(String payFlag) {
		this.payFlag = payFlag;
	}


	public String getTotalDate() {
		return totalDate;
	}


	public void setTotalDate(String totalDate) {
		this.totalDate = totalDate;
	}


	public String getForeignSn() {
		return foreignSn;
	}


	public void setForeignSn(String foreignSn) {
		this.foreignSn = foreignSn;
	}


	public List<PayOutEntity> getPaySnList() {
		return paySnList;
	}


	public void setPaySnList(List<PayOutEntity> paySnList) {
		this.paySnList = paySnList;
	}
	

}
