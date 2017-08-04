package com.sitech.acctmgr.atom.domains.query;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

public class OnlyFareEntity {

	@JSONField(name="PRODUCT_NAME")
	@ParamDesc(path="PRODUCT_NAME",cons=ConsType.CT001,type="String",len="256",desc="赠送返还项目名称",memo="略")
	private String productName = "";
	
	@JSONField(name="FAV_USED_SUM")
	@ParamDesc(path="FAV_USED_SUM",cons=ConsType.CT001,type="long",len="20",desc="预存/赠送总金额",memo="单位：分")
	private String favUsedSum = "";
	
	@JSONField(name="EFF_DATE")
	@ParamDesc(path="EFF_DATE",cons=ConsType.CT001,type="String",len="16",desc="生效时间",memo="YYYYMMDD")
	private String effDate = "";
	
	@JSONField(name="EXP_DATE")
	@ParamDesc(path="EXP_DATE",cons=ConsType.CT001,type="String",len="16",desc="失效时间",memo="YYYYMMDD")
	private String expDate = "";
	
	@JSONField(name="SHARE_LIST")
	@ParamDesc(path="SHARE_LIST",cons=ConsType.STAR,type="compx",len="1",desc="赠送与返还明细",memo="略")
	List<OnlyShareFareEntity> shareList = new ArrayList<OnlyShareFareEntity>();

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getFavUsedSum() {
		return favUsedSum;
	}

	public void setFavUsedSum(String favUsedSum) {
		this.favUsedSum = favUsedSum;
	}

	public String getEffDate() {
		return effDate;
	}

	public void setEffDate(String effDate) {
		this.effDate = effDate;
	}

	public String getExpDate() {
		return expDate;
	}

	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}

	public List<OnlyShareFareEntity> getShareList() {
		return shareList;
	}

	public void setShareList(List<OnlyShareFareEntity> shareList) {
		this.shareList = shareList;
	}


	
	
}

