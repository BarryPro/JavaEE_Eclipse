package com.sitech.acctmgr.atom.dto.query;

import com.sitech.acctmgr.atom.domains.query.ProductOfferUpEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SProductOfferUpQueryOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path = "PRODUCT_OFFER_UP_INFO", desc = "产品资费升级信息", cons = ConsType.CT001, type = "compx", len = "", memo = "")
	private ProductOfferUpEntity prodOfferEnt;
	
	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("prodOfferEnt"), prodOfferEnt);
		return result;
	}

	public ProductOfferUpEntity getProdOfferEnt() {
		return prodOfferEnt;
	}

	public void setProdOfferEnt(ProductOfferUpEntity prodOfferEnt) {
		this.prodOfferEnt = prodOfferEnt;
	}

}
