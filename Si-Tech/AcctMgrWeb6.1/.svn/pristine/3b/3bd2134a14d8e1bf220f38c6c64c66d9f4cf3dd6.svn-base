package com.sitech.acctmgr.atom.domains.pay;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
*
* @Title:   []
* @Description: 地市限额实体类
* @Date : 2016年10月09日
* @Company: SI-TECH
* @author : SUZJ
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
*/
public class RegionLimitEntity {
	
	@JSONField(name="REGION_GROUP")
	@ParamDesc(path="REGION_GROUP",cons=ConsType.CT001,type="String",len="20",desc="地市group",memo="略")
	private String regionGroup;
	
	@JSONField(name="DISTRICT_GROUP_NAME")
	@ParamDesc(path="DISTRICT_GROUP_NAME",cons=ConsType.CT001,type="String",len="100",desc="地市名称",memo="略")
	private String districtGroupName;
	
	@JSONField(name="LIMIT_DAY_FEE")
	@ParamDesc(path="LIMIT_DAY_FEE",cons=ConsType.CT001,type="long",len="14",desc="日限额",memo="略")
	private long limitDayFee;
	
	@JSONField(name="LIMIT_MONTH_FEE")
	@ParamDesc(path="LIMIT_MONTH_FEE",cons=ConsType.CT001,type="long",len="14",desc="月限额",memo="略")
	private long limitMonthFee;
	
	@JSONField(name="BACKED_DAY_FEE")
	@ParamDesc(path="BACKED_DAY_FEE",cons=ConsType.CT001,type="long",len="14",desc="日已退费用",memo="略")
	private long backedDayFee;
	
	@JSONField(name="BACKED_MONTH_FEE")
	@ParamDesc(path="BACKED_MONTH_FEE",cons=ConsType.CT001,type="long",len="14",desc="月已退费用",memo="略")
	private long backedMonthFee;
	
	@JSONField(name="LIMIT_DAY_NUM")
	@ParamDesc(path="LIMIT_DAY_NUM",cons=ConsType.CT001,type="long",len="14",desc="日限次数",memo="略")
	private long limitDayNum;
	
	@JSONField(name="LIMIT_MONTH_NUM")
	@ParamDesc(path="LIMIT_MONTH_NUM",cons=ConsType.CT001,type="long",len="14",desc="月限次数",memo="略")
	private long limitMonthNum;
	
	@JSONField(name="BACKED_DAY_NUM")
	@ParamDesc(path="BACKED_DAY_NUM",cons=ConsType.CT001,type="long",len="14",desc="日已退次数",memo="略")
	private long backedDayNum;
	
	@JSONField(name="BACKED_MONTH_NUM")
	@ParamDesc(path="BACKED_MONTH_NUM",cons=ConsType.CT001,type="long",len="14",desc="月已退次数",memo="略")
	private long backedMonthNum;
	
	@JSONField(name="LIMIT_TYPE")
	@ParamDesc(path="LIMIT_TYPE",cons=ConsType.CT001,type="String",len="8",desc="限制类型",memo="zz:转账；tf:退预存")
	private String limitType;
	
	@JSONField(name="LIMIT_CYCLE")
	@ParamDesc(path="LIMIT_CYCLE",cons=ConsType.CT001,type="String",len="2",desc="限制周期",memo="0：日限额；1：月限额")
	private String limitCycle;
	
	@JSONField(name="OP_CODE")
	@ParamDesc(path="OP_CODE",cons=ConsType.CT001,type="String",len="4",desc="操作代码",memo="略")
	private String opCode;
	
	@JSONField(name="MSG_PHONE")
	@ParamDesc(path="MSG_PHONE",cons=ConsType.CT001,type="String",len="40",desc="发短信手机号",memo="略")
	private String msgPhone;
	
	@JSONField(name="MSG_DAY_FLAG")
	@ParamDesc(path="MSG_DAY_FLAG",cons=ConsType.CT001,type="String",len="1",desc="日限额短信发送标志",memo="0：未发；1：已发")
	private String msgDayFlag;
	
	@JSONField(name="MSG_MONTH_FLAG")
	@ParamDesc(path="MSG_MONTH_FLAG",cons=ConsType.CT001,type="String",len="4",desc="月限额短信发送标志",memo="0：未发；1：已发")
	private String msgMonthFlag;

	@Override
	public String toString() {
		return "RegionLimitEntity [regionGroup=" + regionGroup
				+ ", districtGroupName=" + districtGroupName + ", limitDayFee="
				+ limitDayFee + ", limitMonthFee=" + limitMonthFee
				+ ", backedDayFee=" + backedDayFee + ", backedMonthFee="
				+ backedMonthFee + ", limitDayNum=" + limitDayNum
				+ ", limitMonthNum=" + limitMonthNum + ", backedDayNum="
				+ backedDayNum + ", backedMonthNum=" + backedMonthNum
				+ ", limitType=" + limitType + ", limitCycle=" + limitCycle
				+ ", opCode=" + opCode + ", msgPhone=" + msgPhone
				+ ", msgDayFlag=" + msgDayFlag + ", msgMonthFlag="
				+ msgMonthFlag + "]";
	}

	public String getRegionGroup() {
		return regionGroup;
	}

	public void setRegionGroup(String regionGroup) {
		this.regionGroup = regionGroup;
	}

	public String getDistrictGroupName() {
		return districtGroupName;
	}

	public void setDistrictGroupName(String districtGroupName) {
		this.districtGroupName = districtGroupName;
	}

	public long getLimitDayFee() {
		return limitDayFee;
	}

	public void setLimitDayFee(long limitDayFee) {
		this.limitDayFee = limitDayFee;
	}

	public long getLimitMonthFee() {
		return limitMonthFee;
	}

	public void setLimitMonthFee(long limitMonthFee) {
		this.limitMonthFee = limitMonthFee;
	}

	public long getBackedDayFee() {
		return backedDayFee;
	}

	public void setBackedDayFee(long backedDayFee) {
		this.backedDayFee = backedDayFee;
	}

	public long getBackedMonthFee() {
		return backedMonthFee;
	}

	public void setBackedMonthFee(long backedMonthFee) {
		this.backedMonthFee = backedMonthFee;
	}

	public long getLimitDayNum() {
		return limitDayNum;
	}

	public void setLimitDayNum(long limitDayNum) {
		this.limitDayNum = limitDayNum;
	}

	public long getLimitMonthNum() {
		return limitMonthNum;
	}

	public void setLimitMonthNum(long limitMonthNum) {
		this.limitMonthNum = limitMonthNum;
	}

	public long getBackedDayNum() {
		return backedDayNum;
	}

	public void setBackedDayNum(long backedDayNum) {
		this.backedDayNum = backedDayNum;
	}

	public long getBackedMonthNum() {
		return backedMonthNum;
	}

	public void setBackedMonthNum(long backedMonthNum) {
		this.backedMonthNum = backedMonthNum;
	}

	public String getLimitType() {
		return limitType;
	}

	public void setLimitType(String limitType) {
		this.limitType = limitType;
	}

	public String getLimitCycle() {
		return limitCycle;
	}

	public void setLimitCycle(String limitCycle) {
		this.limitCycle = limitCycle;
	}

	public String getOpCode() {
		return opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public String getMsgPhone() {
		return msgPhone;
	}

	public void setMsgPhone(String msgPhone) {
		this.msgPhone = msgPhone;
	}

	public String getMsgDayFlag() {
		return msgDayFlag;
	}

	public void setMsgDayFlag(String msgDayFlag) {
		this.msgDayFlag = msgDayFlag;
	}

	public String getMsgMonthFlag() {
		return msgMonthFlag;
	}

	public void setMsgMonthFlag(String msgMonthFlag) {
		this.msgMonthFlag = msgMonthFlag;
	}
	
}
