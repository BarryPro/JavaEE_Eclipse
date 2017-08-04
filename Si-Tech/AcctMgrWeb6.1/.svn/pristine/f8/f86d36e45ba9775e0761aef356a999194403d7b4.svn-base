package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.bill.RealTimeBillDetailEntity;
import com.sitech.acctmgr.atom.domains.pay.GroupRelConInfo;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8428QueryOutDTO extends CommonOutDTO{
	
	@JSONField(name="REAL_TIME_OWEFEE_LIST")
	@ParamDesc(path="REAL_TIME_OWEFEE_LIST",cons=ConsType.CT001,type="compx",len="1",desc="实时欠费信息",memo="略")
	private List<RealTimeBillDetailEntity> realTimeOwefeeList;
	
	@JSONField(name="TOTAL_NUM")
	@ParamDesc(path = "TOTAL_NUM", cons = ConsType.QUES, type = "string", len = "10", desc = "总条数，用于分页", memo = "略")
	private int totalNum;
	
	@ParamDesc(path = "QUERY_SN", cons = ConsType.CT001, type = "Long", len = "14", desc = "查詢流水", memo = "")
	private String querySn;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setBody(getPathByProperName("realTimeOwefeeList"), realTimeOwefeeList);
		result.setRoot(getPathByProperName("totalNum"), totalNum);
		result.setRoot(getPathByProperName("querySn"), querySn);
		log.info(result.toString());
		return result;
	}

	
	/**
	 * @return the querySn
	 */
	public String getQuerySn() {
		return querySn;
	}


	/**
	 * @param querySn the querySn to set
	 */
	public void setQuerySn(String querySn) {
		this.querySn = querySn;
	}


	/**
	 * @return the realTimeOwefeeList
	 */
	public List<RealTimeBillDetailEntity> getRealTimeOwefeeList() {
		return realTimeOwefeeList;
	}

	/**
	 * @param realTimeOwefeeList the realTimeOwefeeList to set
	 */
	public void setRealTimeOwefeeList(
			List<RealTimeBillDetailEntity> realTimeOwefeeList) {
		this.realTimeOwefeeList = realTimeOwefeeList;
	}

	/**
	 * @return the totalNum
	 */
	public int getTotalNum() {
		return totalNum;
	}

	/**
	 * @param totalNum the totalNum to set
	 */
	public void setTotalNum(int totalNum) {
		this.totalNum = totalNum;
	}
	
	
	
}
