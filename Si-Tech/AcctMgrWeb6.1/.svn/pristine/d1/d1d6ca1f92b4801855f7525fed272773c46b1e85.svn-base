package com.sitech.acctmgr.atom.domains.bill;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;
import java.util.Map;

@SuppressWarnings("serial")
public class BillFeeInfo implements Serializable {

	@JSONField(name = "FIXED_EXP")
	@ParamDesc(path="FIXED_EXP", cons= ConsType.CT001, type="long", len="", desc="套餐及固定费", memo="")
	private long fixedExp;

	@JSONField(name = "CALL")
	@ParamDesc(path="CALL", cons= ConsType.CT001, type="long", len="", desc="语音通信费", memo="")
	private long call;

	@JSONField(name = "MESSAGE")
	@ParamDesc(path="MESSAGE", cons= ConsType.CT001, type="long", len="", desc="短彩信费", memo="")
	private long message;

	@JSONField(name = "VIEDO_FEE")
	@ParamDesc(path="VIEDO_FEE", cons= ConsType.CT001, type="long", len="", desc="可视电话通信费", memo="")
	private long videoFee;

	@JSONField(name = "NET_PLAY")
	@ParamDesc(path="NET_PLAY", cons= ConsType.CT001, type="long", len="", desc="上网费", memo="")
	private long netPlay;

	@JSONField(name = "VALUE_ADDED")
	@ParamDesc(path="VALUE_ADDED", cons= ConsType.CT001, type="long", len="", desc="自有增值业务费", memo="")
	private long valueAdded;

	@JSONField(name = "GROUP_FEE")
	@ParamDesc(path="GROUP_FEE", cons= ConsType.CT001, type="long", len="", desc="集团业务费", memo="")
	private long groupFee;

	@JSONField(name = "GENERATION")
	@ParamDesc(path="GENERATION", cons= ConsType.CT001, type="long", len="", desc="代收费业务费", memo="")
	private long generation;

	@JSONField(name = "OTHER_EXP")
	@ParamDesc(path="OTHER_EXP", cons= ConsType.CT001, type="long", len="", desc="其他费", memo="")
	private long otherExp;

	@JSONField(name = "TOTAL_FEE")
	@ParamDesc(path="TOTAL_FEE", cons= ConsType.CT001, type="long", len="", desc="总费用", memo="")
	private long totalFee;

	@JSONField(name = "FAVOUR_FEE")
	@ParamDesc(path="FAVOUR_FEE", cons= ConsType.CT001, type="long", len="", desc="总优惠费用", memo="")
	private long favourFee;
	
	public BillFeeInfo(long[] fee) {
		this.setFixedExp(fee[0]);
		this.setCall(fee[1]);
		this.setVideoFee(fee[2]);
		this.setNetPlay(fee[3]);
		this.setMessage(fee[4]);
		this.setValueAdded(fee[5]);
		this.setGroupFee(fee[6]);
		this.setGeneration(fee[7]);
		this.setOtherExp(fee[8]);
	}
	
	public BillFeeInfo(Map<String, Long> feeMap){
		this.setFixedExp(feeMap.get(String.format("%010d", 1)));
		this.setCall(feeMap.get(String.format("%010d", 2)));
		this.setVideoFee(feeMap.get(String.format("%010d", 3)));
		this.setNetPlay(feeMap.get(String.format("%010d", 4)));
		this.setMessage(feeMap.get(String.format("%010d", 5)));
		this.setValueAdded(feeMap.get(String.format("%010d", 6)));
		this.setGroupFee(feeMap.get(String.format("%010d", 8)));
		this.setGeneration(feeMap.get(String.format("%010d", 9)));
		this.setOtherExp(feeMap.get(String.format("%010d", 10)));
	}
	
	public BillFeeInfo(){super();}

	public long getFixedExp() {
		return fixedExp;
	}

	public void setFixedExp(long fixedExp) {
		this.fixedExp = fixedExp;
	}

	public long getCall() {
		return call;
	}

	public void setCall(long call) {
		this.call = call;
	}

	public long getMessage() {
		return message;
	}

	public void setMessage(long message) {
		this.message = message;
	}

	public long getNetPlay() {
		return netPlay;
	}

	public void setNetPlay(long netPlay) {
		this.netPlay = netPlay;
	}

	public long getValueAdded() {
		return valueAdded;
	}

	public void setValueAdded(long valueAdded) {
		this.valueAdded = valueAdded;
	}

	public long getGeneration() {
		return generation;
	}

	public void setGeneration(long generation) {
		this.generation = generation;
	}

	public long getOtherExp() {
		return otherExp;
	}

	public void setOtherExp(long otherExp) {
		this.otherExp = otherExp;
	}

	public long getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(long totalFee) {
		this.totalFee = totalFee;
	}

	public long getFavourFee() {
		return favourFee;
	}

	public void setFavourFee(long favourFee) {
		this.favourFee = favourFee;
	}

	public long getVideoFee() {
		return videoFee;
	}

	public void setVideoFee(long videoFee) {
		this.videoFee = videoFee;
	}

	public long getGroupFee() {
		return groupFee;
	}

	public void setGroupFee(long groupFee) {
		this.groupFee = groupFee;
	}

	@Override
	public String toString() {
		return "BillFeeInfo{" +
				"fixedExp=" + fixedExp +
				", call=" + call +
				", message=" + message +
				", videoFee=" + videoFee +
				", netPlay=" + netPlay +
				", valueAdded=" + valueAdded +
				", groupFee=" + groupFee +
				", generation=" + generation +
				", otherExp=" + otherExp +
				", totalFee=" + totalFee +
				", favourFee=" + favourFee +
				'}';
	}


}
