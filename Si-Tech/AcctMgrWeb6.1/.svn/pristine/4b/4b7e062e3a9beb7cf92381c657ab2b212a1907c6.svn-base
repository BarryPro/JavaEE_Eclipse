package com.sitech.acctmgr.atom.dto.query;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.query.packetFeeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SPacketFeeInitOutDTO extends CommonOutDTO{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1371647947904689680L;
	@ParamDesc(path="BUSI_INFO.MODE_NAME",cons=ConsType.QUES,type="String",len="200",desc="产品名称",memo="略")
	private String modeName;
	@ParamDesc(path="BUSI_INFO.MODE_BEGIN",cons=ConsType.QUES,type="String",len="8",desc="产品生效日期",memo="略")
	private String modeBegin;
	@ParamDesc(path="BUSI_INFO.MODE_END",cons=ConsType.QUES,type="String",len="8",desc="产品失效日期",memo="略")
	private String modeEnd;
	
	@ParamDesc(path="FAVOUR_YEAR_LIST",cons=ConsType.STAR,type="compx",len="1",desc="包年列表",memo="略")
	private List<packetFeeEntity> favourYearList = new ArrayList<packetFeeEntity>();
	
	@Override
	public MBean encode() {
		MBean result=super.encode();
		
		result.setRoot(getPathByProperName("modeName"), modeName);
		result.setRoot(getPathByProperName("modeBegin"), modeBegin);
		result.setRoot(getPathByProperName("modeEnd"), modeEnd);
		result.setRoot(getPathByProperName("favourYearList"), favourYearList);

		return result;
	}

	/**
	 * @return the modeName
	 */
	public String getModeName() {
		return modeName;
	}

	/**
	 * @param modeName the modeName to set
	 */
	public void setModeName(String modeName) {
		this.modeName = modeName;
	}

	/**
	 * @return the modeBegin
	 */
	public String getModeBegin() {
		return modeBegin;
	}

	/**
	 * @param modeBegin the modeBegin to set
	 */
	public void setModeBegin(String modeBegin) {
		this.modeBegin = modeBegin;
	}

	/**
	 * @return the modeEnd
	 */
	public String getModeEnd() {
		return modeEnd;
	}

	/**
	 * @param modeEnd the modeEnd to set
	 */
	public void setModeEnd(String modeEnd) {
		this.modeEnd = modeEnd;
	}

	/**
	 * @return the favourYearList
	 */
	public List<packetFeeEntity> getFavourYearList() {
		return favourYearList;
	}

	/**
	 * @param favourYearList the favourYearList to set
	 */
	public void setFavourYearList(List<packetFeeEntity> favourYearList) {
		this.favourYearList = favourYearList;
	}
}
