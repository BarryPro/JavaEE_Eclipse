package com.sitech.acctmgr.atom.impl.query;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.query.PrcIdTransEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.dto.query.SIpShopQueryInDTO;
import com.sitech.acctmgr.atom.dto.query.SIpShopQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.query.IIpShop;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.List;

@ParamTypes({ 
	@ParamType(c = SIpShopQueryInDTO.class,oc=SIpShopQueryOutDTO.class, m = "query")
	})
public class SIpShop extends AcctMgrBaseService implements IIpShop {

	private IBillAccount billAccount;
	private IUser user;
	private IProd prod;
	private IGroup group;
	
	@Override
	public OutDTO query(InDTO inParam) {
		SIpShopQueryInDTO inDto = (SIpShopQueryInDTO) inParam;
		log.debug("inDto=" +inDto.getMbean());
		
		String phoneNo = inDto.getPhoneNo();
		UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
		long idNo = userInfo.getIdNo();

		String userGroupId = userInfo.getGroupId();

		ChngroupRelEntity regionInfo = group.getRegionDistinct(userGroupId, "2", inDto.getProvinceId());
		String regionCode = regionInfo.getRegionCode();

		UserPrcEntity userPrcEnt = prod.getUserPrcidInfo(idNo, true);
		String prcId = userPrcEnt.getProdPrcid();

		List<PrcIdTransEntity> list = billAccount.getDetailCodeList(prcId, regionCode, "0");
		
		boolean flag = this.hasIpShop(list);
		
		SIpShopQueryOutDTO outDto = new SIpShopQueryOutDTO();
		outDto.setFlag(flag ? "Y" : "N");
		
		log.debug("outDto=" + outDto.toJson());
		return outDto;
	}

	private boolean hasIpShop(List<PrcIdTransEntity> list ){
		boolean flag = false;		
		for (PrcIdTransEntity prcIdTransEntity : list) {
			String detailCode = prcIdTransEntity.getDetailCode();
			if ("zu02".equals(detailCode) || "zu05".equals(detailCode) || "zu07".equals(detailCode)) {
				flag = true;
				break;
			} else {
				flag = false;
			}
		}
		return flag;
	}
	
	public IBillAccount getBillAccount() {
		return billAccount;
	}

	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IProd getProd() {
		return prod;
	}

	public void setProd(IProd prod) {
		this.prod = prod;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}
}
