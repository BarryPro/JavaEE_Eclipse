package com.sitech.acctmgr.atom.dto.feeqry;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.query.IvrBackPayEntity;
import com.sitech.acctmgr.atom.domains.query.SmsBackPayEntity;
import com.sitech.acctmgr.atom.domains.query.TotalSmsBackEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SSmsBackPayInitOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6310916980556511024L;
	
	@ParamDesc(path="RECORD_NUM",cons=ConsType.CT001,type="long",len="10",desc="已返还次数",memo="略")
	protected long recordNum;
	@ParamDesc(path="TOTAL_LIST",cons=ConsType.STAR,type="compx",len="1",desc="返费信息列表",memo="略")
	protected List<TotalSmsBackEntity> totalList ;
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();

		result.setRoot(getPathByProperName("totalList"), totalList);
		result.setRoot(getPathByProperName("recordNum"), recordNum);

		return result;
	}

	/**
	 * @return the totalList
	 */
	public List<TotalSmsBackEntity> getTotalList() {
		return totalList;
	}

	/**
	 * @param totalList the totalList to set
	 */
	public void setTotalList(List<TotalSmsBackEntity> totalList) {
		this.totalList = totalList;
	}

	/**
	 * @return the recordNum
	 */
	public long getRecordNum() {
		return recordNum;
	}

	/**
	 * @param recordNum the recordNum to set
	 */
	public void setRecordNum(long recordNum) {
		this.recordNum = recordNum;
	}


}
