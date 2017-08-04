package com.sitech.acctmgr.atom.domains.query;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class packetFeeEntity {
	
    @JSONField(name = "ORDER_CODE_DESC")
    @ParamDesc(path = "ORDER_CODE_DESC", cons = ConsType.CT001, len = "200", type = "string", desc = "包年名称", memo = "")
    private String orderCodeDesc; 
    @JSONField(name = "CODE_NAME")
    @ParamDesc(path = "CODE_NAME", cons = ConsType.CT001, len = "200", type = "string", desc = "优惠类型", memo = "")
    private String codeName;  
    @JSONField(name = "TOTAL_FAV")
    @ParamDesc(path = "TOTAL_FAV", cons = ConsType.CT001, len = "20", type = "long", desc = "总优惠金额", memo = "")
    private long totalFav;
    @JSONField(name = "SUM_FAVOURED")
    @ParamDesc(path = "SUM_FAVOURED", cons = ConsType.CT001, len = "20", type = "long", desc = "已使用优惠金额", memo = "")
    private long sumFavoured;
    @JSONField(name = "REMAIN_FAVOR")
    @ParamDesc(path = "REMAIN_FAVOR", cons = ConsType.CT001, len = "20", type = "long", desc = "未使用优惠金额", memo = "")
    private long remainFavor;
    @JSONField(name = "USE_MONTHS")
    @ParamDesc(path = "USE_MONTHS", cons = ConsType.CT001, len = "10", type = "int", desc = "使用年月数", memo = "")
    private int useMonths;
    @JSONField(name = "FAVOUR_BEGIN")
    @ParamDesc(path = "FAVOUR_BEGIN", cons = ConsType.CT001, len = "8", type = "string", desc = "生效日期", memo = "")
    private String favourBegin; 
    @JSONField(name = "FAVOUR_END")
    @ParamDesc(path = "FAVOUR_END", cons = ConsType.CT001, len = "8", type = "string", desc = "失效日期", memo = "")
    private String favourEnd;
	/**
	 * @return the orderCodeDesc
	 */
	public String getOrderCodeDesc() {
		return orderCodeDesc;
	}
	/**
	 * @param orderCodeDesc the orderCodeDesc to set
	 */
	public void setOrderCodeDesc(String orderCodeDesc) {
		this.orderCodeDesc = orderCodeDesc;
	}
	/**
	 * @return the codeName
	 */
	public String getCodeName() {
		return codeName;
	}
	/**
	 * @param codeName the codeName to set
	 */
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	/**
	 * @return the totalFav
	 */
	public long getTotalFav() {
		return totalFav;
	}
	/**
	 * @param totalFav the totalFav to set
	 */
	public void setTotalFav(long totalFav) {
		this.totalFav = totalFav;
	}
	/**
	 * @return the sumFavoured
	 */
	public long getSumFavoured() {
		return sumFavoured;
	}
	/**
	 * @param sumFavoured the sumFavoured to set
	 */
	public void setSumFavoured(long sumFavoured) {
		this.sumFavoured = sumFavoured;
	}
	/**
	 * @return the remainFavor
	 */
	public long getRemainFavor() {
		return remainFavor;
	}
	/**
	 * @param remainFavor the remainFavor to set
	 */
	public void setRemainFavor(long remainFavor) {
		this.remainFavor = remainFavor;
	}
	/**
	 * @return the useMonths
	 */
	public int getUseMonths() {
		return useMonths;
	}
	/**
	 * @param useMonths the useMonths to set
	 */
	public void setUseMonths(int useMonths) {
		this.useMonths = useMonths;
	}
	/**
	 * @return the favourBegin
	 */
	public String getFavourBegin() {
		return favourBegin;
	}
	/**
	 * @param favourBegin the favourBegin to set
	 */
	public void setFavourBegin(String favourBegin) {
		this.favourBegin = favourBegin;
	}
	/**
	 * @return the favourEnd
	 */
	public String getFavourEnd() {
		return favourEnd;
	}
	/**
	 * @param favourEnd the favourEnd to set
	 */
	public void setFavourEnd(String favourEnd) {
		this.favourEnd = favourEnd;
	} 
}
