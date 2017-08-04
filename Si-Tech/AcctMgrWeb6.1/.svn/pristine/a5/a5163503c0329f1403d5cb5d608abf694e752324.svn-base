package com.sitech.acctmgr.atom.domains.volume;

import java.io.Serializable;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 * 流量帐本
 * PS_ID && SALE_NUMBER合并
 */
@SuppressWarnings("serial")
public class PsIdListEntity implements Serializable {
	
	@JSONField(name = "PS_ID")
	@ParamDesc(path = "PS_ID", cons = ConsType.CT001, type = "string", len = "20", desc = "库存批次ID  入库", memo = "")
	private String psId;

	@JSONField(name = "SALE_NUMBER")
	@ParamDesc(path = "SALE_NUMBER", cons = ConsType.CT001, type = "long", len = "18", desc = "售卖数量", memo = "")
	private long saleNumber;

	public String getPsId() {
		return psId;
	}

	public void setPsId(String psId) {
		this.psId = psId;
	}

	public long getSaleNumber() {
		return saleNumber;
	}

	public void setSaleNumber(long saleNumber) {
		this.saleNumber = saleNumber;
	}

	@Override
	public String toString() {
		return "VolumeBookDetail{" +
				"psId='" + psId + '\'' +
				", saleNumber='" + saleNumber + '\'' +
				'}';
	}
}
