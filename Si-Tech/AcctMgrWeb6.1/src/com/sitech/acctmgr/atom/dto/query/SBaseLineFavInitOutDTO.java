package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SBaseLineFavInitOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ParamDesc(path="BUSI_INFO.TOTAL_FAV_TIME",cons=ConsType.QUES,type="long",len="20",desc="总优惠时间",memo="略")
	private long totalFavTime;
	@ParamDesc(path="BUSI_INFO.FAVOURED_TIME",cons=ConsType.QUES,type="long",len="20",desc="已优惠时间",memo="略")
	private long favouredTime;
	@ParamDesc(path="BUSI_INFO.FAV_LEFT_TIME",cons=ConsType.QUES,type="long",len="20",desc="优惠剩余时间",memo="略")
	private long favLeftTime;
	@ParamDesc(path="BUSI_INFO.TOTAL_FAV_MSG",cons=ConsType.QUES,type="long",len="20",desc="总优惠短信数",memo="略")
	private long totalFavMsg;
	@ParamDesc(path="BUSI_INFO.FAVOURED_MSG",cons=ConsType.QUES,type="long",len="20",desc="已优惠短信数",memo="略")
	private long favouredMsg;
	@ParamDesc(path="BUSI_INFO.FAV_LEFT_MSG",cons=ConsType.QUES,type="long",len="20",desc="剩余短信数",memo="略")
	private long favLeftMsg;
	@ParamDesc(path="BUSI_INFO.UNBILL_SHOULD",cons=ConsType.QUES,type="long",len="20",desc="应收",memo="略")
	private long unbillShould;
	

	@Override
	public MBean encode() {
		MBean result=super.encode();
		
		result.setRoot(getPathByProperName("totalFavTime"), totalFavTime);
		result.setRoot(getPathByProperName("totalFavTime"), totalFavTime);
		result.setRoot(getPathByProperName("favLeftTime"), favLeftTime);
		result.setRoot(getPathByProperName("totalFavMsg"), totalFavMsg);
		result.setRoot(getPathByProperName("favouredMsg"), favouredMsg);
		result.setRoot(getPathByProperName("favLeftMsg"), favLeftMsg);
		result.setRoot(getPathByProperName("unbillShould"), unbillShould);

		return result;
	}


	/**
	 * @return the totalFavTime
	 */
	public long getTotalFavTime() {
		return totalFavTime;
	}


	/**
	 * @param totalFavTime the totalFavTime to set
	 */
	public void setTotalFavTime(long totalFavTime) {
		this.totalFavTime = totalFavTime;
	}


	/**
	 * @return the favouredTime
	 */
	public long getFavouredTime() {
		return favouredTime;
	}


	/**
	 * @param favouredTime the favouredTime to set
	 */
	public void setFavouredTime(long favouredTime) {
		this.favouredTime = favouredTime;
	}


	/**
	 * @return the favLeftTime
	 */
	public long getFavLeftTime() {
		return favLeftTime;
	}


	/**
	 * @param favLeftTime the favLeftTime to set
	 */
	public void setFavLeftTime(long favLeftTime) {
		this.favLeftTime = favLeftTime;
	}


	/**
	 * @return the totalFavMsg
	 */
	public long getTotalFavMsg() {
		return totalFavMsg;
	}


	/**
	 * @param totalFavMsg the totalFavMsg to set
	 */
	public void setTotalFavMsg(long totalFavMsg) {
		this.totalFavMsg = totalFavMsg;
	}


	/**
	 * @return the favouredMsg
	 */
	public long getFavouredMsg() {
		return favouredMsg;
	}


	/**
	 * @param favouredMsg the favouredMsg to set
	 */
	public void setFavouredMsg(long favouredMsg) {
		this.favouredMsg = favouredMsg;
	}


	/**
	 * @return the favLeftMsg
	 */
	public long getFavLeftMsg() {
		return favLeftMsg;
	}


	/**
	 * @param favLeftMsg the favLeftMsg to set
	 */
	public void setFavLeftMsg(long favLeftMsg) {
		this.favLeftMsg = favLeftMsg;
	}


	/**
	 * @return the unbillShould
	 */
	public long getUnbillShould() {
		return unbillShould;
	}


	/**
	 * @param unbillShould the unbillShould to set
	 */
	public void setUnbillShould(long unbillShould) {
		this.unbillShould = unbillShould;
	}
}
