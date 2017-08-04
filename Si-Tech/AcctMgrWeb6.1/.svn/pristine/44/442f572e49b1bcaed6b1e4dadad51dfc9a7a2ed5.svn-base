package com.sitech.acctmgr.atom.dto.bill;


import com.sitech.acctmgr.atom.domains.bill.BillFeeEntity;
import com.sitech.acctmgr.atom.domains.bill.ContractDetail;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

@SuppressWarnings("serial")
public class QryBillHomeOutDTO extends CommonOutDTO {
	@ParamDesc(path = "PCAS_01.PCAS_01_01", cons = ConsType.CT001, len = "64", type = "string", desc = "客户名称", memo = "")
	private String custName;
	@ParamDesc(path = "PCAS_01.PCAS_01_02", cons = ConsType.CT001, len = "40", type = "string", desc = "服务号码", memo = "")
	private String phoneNo;
	@ParamDesc(path = "PCAS_01.PCAS_01_03", cons = ConsType.CT001, len = "10", type = "string", desc = "用户星级", memo = "")
	private String starLevel;
	@ParamDesc(path = "PCAS_01.PCAS_01_04", cons = ConsType.CT001, len = "40", type = "string", desc = "计费周期", memo = "")
	private String billCycle;

	@ParamDesc(path = "PCAS_02.PCAS_02_01", cons = ConsType.CT001, type = "long", len = "10", desc = "当前积分", memo = "")
	private long currentPoint;
	@ParamDesc(path = "PCAS_02.PCAS_02_02", desc ="客户交费余额", memo = "单位：分", len="14", cons = ConsType.CT001, type="long")
	private long custBalance;
	@ParamDesc(path = "PCAS_02.PCAS_02_03", desc ="移动赠送余额", memo = "单位：分", len="14", cons = ConsType.CT001, type="long")
	private long mobBalance;
	@ParamDesc(path = "PCAS_02.PCAS_02_04", desc ="本期末余额合计", memo = "单位：分", len="14", cons = ConsType.CT001, type="long")
	private long totalBalance;

	@ParamDesc(path = "PCAS_02.PCAS_02_05", cons = ConsType.CT001, len = "单位：分", type = "long", desc = "当月消费", memo = "")
	private long consume;
	@ParamDesc(path = "PCAS_02.PCAS_02_06", desc ="客户付费支付", memo = "单位：分", len="14", cons = ConsType.CT001, type="long")
	private long custConsumeFee;
	@ParamDesc(path = "PCAS_02.PCAS_02_07", desc ="移动付费支付", memo = "单位：分", len="14", cons = ConsType.CT001, type="long")
	private long mobConsumeFee;
	@ParamDesc(path = "PCAS_02.PCAS_02_08", desc ="本期末欠费", memo = "单位：分", len="14", cons = ConsType.CT001, type="long")
	private long totalOwe;

	@ParamDesc(path = "PCAS_03.PCAS_03_01", cons = ConsType.CT001, len = "", type = "compx", desc = "套餐及固定费", memo = "非List")
	private BillFeeEntity fixedFee;
	@ParamDesc(path = "PCAS_03.PCAS_03_02", cons = ConsType.CT001, len = "", type = "compx", desc = "语音通信费", memo = "非List")
	private BillFeeEntity voiceFee;
	@ParamDesc(path = "PCAS_03.PCAS_03_03", cons = ConsType.CT001, len = "", type = "compx", desc = "可视通话费", memo = "非List")
	private BillFeeEntity videoFee;
	@ParamDesc(path = "PCAS_03.PCAS_03_04", cons = ConsType.CT001, len = "", type = "compx", desc = "上网费", memo = "非List")
	private BillFeeEntity netFee;
	@ParamDesc(path = "PCAS_03.PCAS_03_05", cons = ConsType.CT001, len = "", type = "compx", desc = "短彩信费", memo = "非List")
	private BillFeeEntity messageFee;
	@ParamDesc(path = "PCAS_03.PCAS_03_06", cons = ConsType.CT001, len = "", type = "compx", desc = "增值业务费", memo = "非List")
	private BillFeeEntity spFee;
	@ParamDesc(path = "PCAS_03.PCAS_03_08", cons = ConsType.CT001, len = "", type = "compx", desc = "集团业务费", memo = "非List")
	private BillFeeEntity groupFee;
	@ParamDesc(path = "PCAS_03.PCAS_03_09", cons = ConsType.CT001, len = "", type = "compx", desc = "代收费业务费", memo = "非List")
	private BillFeeEntity proxyFee;
	@ParamDesc(path = "PCAS_03.PCAS_03_10", cons = ConsType.CT001, len = "", type = "compx", desc = "其他费", memo = "非List")
	private BillFeeEntity otherFee;
	@ParamDesc(path = "PCAS_03.PCAS_03_11", cons = ConsType.CT001, len = "", type = "compx", desc = "优惠费(减免)", memo = "非List")
	private BillFeeEntity favourFee;
	@ParamDesc(path = "PCAS_03.PCAS_03_12", cons = ConsType.CT001, len = "", type = "compx", desc = "总费用", memo = "非List")
	private BillFeeEntity totalFee;
	@ParamDesc(path = "PCAS_03.PCAS_03_13", cons = ConsType.CT001, len = "", type = "compx", desc = "他人代付", memo = "非List")
	private BillFeeEntity otherAgentFee;
	@ParamDesc(path = "PCAS_03.PCAS_03_14", cons = ConsType.CT001, len = "", type = "compx", desc = "集团代付", memo = "非List")
	private BillFeeEntity groupAgentFee;

	@ParamDesc(path = "PCAS_07", desc = "账户明细列表", memo = "List", len = "", cons = ConsType.PLUS, type = "complex")
	private List<ContractDetail> conDetailList;


	@ParamDesc(path = "PCAS_08.PCAS_08_02", cons = ConsType.CT001, type = "long", len = "10", desc = "上期积分余额", memo = "")
	private long lastPoint;
	@ParamDesc(path = "PCAS_08.PCAS_08_03", cons = ConsType.CT001, type = "long", len = "10", desc = "新增积分", memo = "黑龙江奖励积分累加到新增积分")
	private long newPoint;
	@ParamDesc(path = "PCAS_08.PCAS_08_06", cons = ConsType.CT001, type = "long", len = "10", desc = "已使用积分", memo = "")
	private long usedPoint;
	@ParamDesc(path = "PCAS_08.PCAS_08_04", cons = ConsType.CT001, type = "long", len = "10", desc = "奖励积分", memo = "黑龙江不使用此字段，返回值为0")
	private long bonusPoint;
	@ParamDesc(path = "PCAS_08.PCAS_08_05", cons = ConsType.CT001, type = "long", len = "10", desc = "转增积分", memo = "")
	private long presentPoint;
	@ParamDesc(path = "PCAS_08.PCAS_08_01", cons = ConsType.CT001, type = "long", len = "10", desc = "可用积分余额", memo = "")
	private long remainPoint;
	@Override
	public MBean encode() {

		MBean mbean = super.encode();

		/*基础头展示信息*/
		mbean.setRoot(getPathByProperName("custName"), custName);
		mbean.setRoot(getPathByProperName("phoneNo"), phoneNo);
		mbean.setRoot(getPathByProperName("starLevel"), starLevel);
		mbean.setRoot(getPathByProperName("billCycle"), billCycle);
		mbean.setRoot(getPathByProperName("totalOwe"), totalOwe);
		mbean.setRoot(getPathByProperName("currentPoint"), currentPoint);
		mbean.setRoot(getPathByProperName("custConsumeFee"), custConsumeFee);
		mbean.setRoot(getPathByProperName("mobConsumeFee"), mobConsumeFee);
		mbean.setRoot(getPathByProperName("consume"), consume);
		mbean.setRoot(getPathByProperName("custBalance"), custBalance);
		mbean.setRoot(getPathByProperName("mobBalance"), mobBalance);
		mbean.setRoot(getPathByProperName("totalBalance"), totalBalance);

		/*十大类费用部分*/
		mbean.setRoot(getPathByProperName("fixedFee"), fixedFee);
		mbean.setRoot(getPathByProperName("voiceFee"), voiceFee);
		mbean.setRoot(getPathByProperName("videoFee"), videoFee);
		mbean.setRoot(getPathByProperName("netFee"), netFee);
		mbean.setRoot(getPathByProperName("messageFee"), messageFee);
		mbean.setRoot(getPathByProperName("spFee"), spFee);
		mbean.setRoot(getPathByProperName("proxyFee"), proxyFee);
		mbean.setRoot(getPathByProperName("groupFee"), groupFee);
		mbean.setRoot(getPathByProperName("otherFee"), otherFee);
		mbean.setRoot(getPathByProperName("favourFee"), favourFee);
		mbean.setRoot(getPathByProperName("totalFee"), totalFee);
		mbean.setRoot(getPathByProperName("otherAgentFee"), otherAgentFee);
		mbean.setRoot(getPathByProperName("groupAgentFee"), groupAgentFee);

		/*帐户余额明细部分*/
		mbean.setRoot(getPathByProperName("conDetailList"), conDetailList);

		/*积分展示部分*/
		mbean.setRoot(getPathByProperName("lastPoint"), lastPoint);
		mbean.setRoot(getPathByProperName("newPoint"), newPoint);
		mbean.setRoot(getPathByProperName("usedPoint"), usedPoint);
		mbean.setRoot(getPathByProperName("bonusPoint"), bonusPoint);
		mbean.setRoot(getPathByProperName("presentPoint"), presentPoint);
		mbean.setRoot(getPathByProperName("remainPoint"), remainPoint);
		
		return mbean;
	}

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(String billCycle) {
		this.billCycle = billCycle;
	}

	public long getCustConsumeFee() {
		return custConsumeFee;
	}

	public void setCustConsumeFee(long custConsumeFee) {
		this.custConsumeFee = custConsumeFee;
	}

	public long getMobConsumeFee() {
		return mobConsumeFee;
	}

	public void setMobConsumeFee(long mobConsumeFee) {
		this.mobConsumeFee = mobConsumeFee;
	}

	public long getTotalOwe() {
		return totalOwe;
	}

	public void setTotalOwe(long totalOwe) {
		this.totalOwe = totalOwe;
	}

	public long getConsume() {
		return consume;
	}

	public void setConsume(long consume) {
		this.consume = consume;
	}

	public BillFeeEntity getFixedFee() {
		return fixedFee;
	}

	public void setFixedFee(BillFeeEntity fixedFee) {
		this.fixedFee = fixedFee;
	}

	public BillFeeEntity getVoiceFee() {
		return voiceFee;
	}

	public void setVoiceFee(BillFeeEntity voiceFee) {
		this.voiceFee = voiceFee;
	}

	public void setVideoFee(BillFeeEntity videoFee) {
		this.videoFee = videoFee;
	}

	public BillFeeEntity getNetFee() {
		return netFee;
	}

	public void setNetFee(BillFeeEntity netFee) {
		this.netFee = netFee;
	}

	public BillFeeEntity getMessageFee() {
		return messageFee;
	}

	public void setMessageFee(BillFeeEntity messageFee) {
		this.messageFee = messageFee;
	}

	public BillFeeEntity getSpFee() {
		return spFee;
	}

	public void setSpFee(BillFeeEntity spFee) {
		this.spFee = spFee;
	}

	public void setGroupFee(BillFeeEntity groupFee) {
		this.groupFee = groupFee;
	}

	public BillFeeEntity getProxyFee() {
		return proxyFee;
	}

	public void setProxyFee(BillFeeEntity proxyFee) {
		this.proxyFee = proxyFee;
	}

	public BillFeeEntity getOtherFee() {
		return otherFee;
	}

	public void setOtherFee(BillFeeEntity otherFee) {
		this.otherFee = otherFee;
	}

	public BillFeeEntity getFavourFee() {
		return favourFee;
	}

	public void setFavourFee(BillFeeEntity favourFee) {
		this.favourFee = favourFee;
	}

	public BillFeeEntity getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(BillFeeEntity totalFee) {
		this.totalFee = totalFee;
	}

	public BillFeeEntity getOtherAgentFee() {
		return otherAgentFee;
	}

	public void setOtherAgentFee(BillFeeEntity otherAgentFee) {
		this.otherAgentFee = otherAgentFee;
	}

	public BillFeeEntity getGroupAgentFee() {
		return groupAgentFee;
	}

	public void setGroupAgentFee(BillFeeEntity groupAgentFee) {
		this.groupAgentFee = groupAgentFee;
	}

	public String getStarLevel() {
		return starLevel;
	}

	public void setStarLevel(String starLevel) {
		this.starLevel = starLevel;
	}

	public long getLastPoint() {
		return lastPoint;
	}

	public void setLastPoint(long lastPoint) {
		this.lastPoint = lastPoint;
	}

	public long getNewPoint() {
		return newPoint;
	}

	public void setNewPoint(long newPoint) {
		this.newPoint = newPoint;
	}

	public long getUsedPoint() {
		return usedPoint;
	}

	public void setUsedPoint(long usedPoint) {
		this.usedPoint = usedPoint;
	}

	public long getBonusPoint() {
		return bonusPoint;
	}

	public void setBonusPoint(long bonusPoint) {
		this.bonusPoint = bonusPoint;
	}

	public long getPresentPoint() {
		return presentPoint;
	}

	public void setPresentPoint(long presentPoint) {
		this.presentPoint = presentPoint;
	}

	public long getRemainPoint() {
		return remainPoint;
	}

	public void setRemainPoint(long remainPoint) {
		this.remainPoint = remainPoint;
	}

	public long getCurrentPoint() {
		return currentPoint;
	}

	public void setCurrentPoint(long currentPoint) {
		this.currentPoint = currentPoint;
	}

	public BillFeeEntity getVideoFee() {
		return videoFee;
	}

	public BillFeeEntity getGroupFee() {
		return groupFee;
	}

	public List<ContractDetail> getConDetailList() {
		return conDetailList;
	}

	public void setConDetailList(List<ContractDetail> conDetailList) {
		this.conDetailList = conDetailList;
	}

	public long getCustBalance() {
		return custBalance;
	}

	public void setCustBalance(long custBalance) {
		this.custBalance = custBalance;
	}

	public long getMobBalance() {
		return mobBalance;
	}

	public void setMobBalance(long mobBalance) {
		this.mobBalance = mobBalance;
	}

	public long getTotalBalance() {
		return totalBalance;
	}

	public void setTotalBalance(long totalBalance) {
		this.totalBalance = totalBalance;
	}
}
