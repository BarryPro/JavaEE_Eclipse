package com.sitech.acctmgr.atom.impl.query;


import com.sitech.acctmgr.atom.domains.query.PriceCodeEntity;
import com.sitech.acctmgr.atom.dto.query.SPriceCodeQueryInDTO;
import com.sitech.acctmgr.atom.dto.query.SPriceCodeQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.query.IPriceCode;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ 
	@ParamType(c = SPriceCodeQueryInDTO.class,oc=SPriceCodeQueryOutDTO.class, m = "query")
	})
public class SPriceCode extends AcctMgrBaseService implements IPriceCode {

	private IBillAccount billAccount;
	
	@Override
	public OutDTO query(InDTO inParam) {
		SPriceCodeQueryInDTO inDto = (SPriceCodeQueryInDTO) inParam;
		log.debug("inDto=" +inDto.getMbean());
		
		String priceCode = inDto.getPriceCode();

		PriceCodeEntity priceInfo = billAccount.getPriceInfo(priceCode);

		String priceName = "";
		long priceFee = 0;
		if (priceInfo != null) {
			priceName = priceInfo.getPriceName();
			priceFee = priceInfo.getPriceFee();
		}

		SPriceCodeQueryOutDTO outDto = new SPriceCodeQueryOutDTO();
		outDto.setPriceName(priceName);
		outDto.setPriceFee(priceFee);

		log.debug("outDto=" + outDto.toJson());
		return outDto;
	}

	public IBillAccount getBillAccount() {
		return billAccount;
	}

	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
	}
	
	

}
