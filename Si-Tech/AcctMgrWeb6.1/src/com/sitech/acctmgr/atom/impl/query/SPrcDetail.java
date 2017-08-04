package com.sitech.acctmgr.atom.impl.query;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.query.PrcDetailEntity;
import com.sitech.acctmgr.atom.domains.query.PrcIdTransEntity;
import com.sitech.acctmgr.atom.domains.query.PriceCodeEntity;
import com.sitech.acctmgr.atom.dto.query.SPrcDetailQueryInDTO;
import com.sitech.acctmgr.atom.dto.query.SPrcDetailQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.query.IPrcDetail;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.ArrayList;
import java.util.List;

@ParamTypes({ 
	@ParamType(c = SPrcDetailQueryInDTO.class, oc=SPrcDetailQueryOutDTO.class, m = "query")
	})
public class SPrcDetail extends AcctMgrBaseService implements IPrcDetail {

	private IBillAccount billAccount;
	private IGroup group;
	
	@Override
	public OutDTO query(InDTO inParam) {
		SPrcDetailQueryInDTO inDto = (SPrcDetailQueryInDTO) inParam;
		
		log.debug("inDto=" +inDto.getMbean());
		
		String prcId = inDto.getPrcId();
		String prcGroupId = inDto.getPrcGroupId();

		ChngroupRelEntity groupInfo = group.getRegionDistinct(prcGroupId, "2", inDto.getProvinceId());
		String regionCode = groupInfo.getRegionCode();

		List<PrcIdTransEntity> detailList = billAccount.getPrcDetailList(prcId, "1", regionCode); //bargainpara_flag = '1'


		String favourFlag = null;
		
		List<PrcDetailEntity> outList = new ArrayList<>();
		
		for (PrcIdTransEntity prcIdEnt : detailList) {
			
			String priceCode = prcIdEnt.getDetailCode();
			String serviceType = prcIdEnt.getDetailType();
			String serviceCode = prcIdEnt.getDetailCode();
			
			PriceCodeEntity priceInfo = billAccount.getPriceInfo(priceCode, serviceType,serviceCode, "1,2");
			if (priceInfo == null) {
				continue;
			}
			
			favourFlag = "0";
			if (prcId.equals("M045053")) {
				int countFlag = billAccount.getCountFlag(prcId, priceCode,"2", regionCode); //detail_type = '2'
				if(countFlag > 0){
					favourFlag = "1";
				}
			}
			
			PrcDetailEntity prcDetailEnt = new PrcDetailEntity();
			
			prcDetailEnt.setPriceCode(priceCode);
			prcDetailEnt.setChargeFlag(priceInfo.getChargeFlag());
			prcDetailEnt.setFavourFlag(favourFlag);
			prcDetailEnt.setChargeType(priceInfo.getChargeType());
			prcDetailEnt.setChargeFlagName(priceInfo.getChargeFlagName());
			prcDetailEnt.setDetailCode(prcIdEnt.getDetailCode());
			prcDetailEnt.setDetailNote(prcIdEnt.getDetailNote());
			prcDetailEnt.setDetailType(serviceType);
			prcDetailEnt.setPrcId(prcId);
			prcDetailEnt.setPriceFee(priceInfo.getPriceFee());
			prcDetailEnt.setPriceName(priceInfo.getPriceName());
			
			outList.add(prcDetailEnt);
		}
		
		SPrcDetailQueryOutDTO outDto = new SPrcDetailQueryOutDTO();
		outDto.setDetailList(outList);
		
		log.debug("outDto=" + outDto.toJson());
		
		return outDto;
	}

	public IBillAccount getBillAccount() {
		return billAccount;
	}

	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}
}
