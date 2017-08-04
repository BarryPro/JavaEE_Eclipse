package com.sitech.acctmgr.atom.impl.free;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.sitech.acctmgr.atom.domains.bill.BillEntity;
import com.sitech.acctmgr.atom.domains.bill.UnbillEntity;
import com.sitech.acctmgr.atom.domains.free.FreeUseInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.free.SIntlRoamFreeQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.SIntlRoamFreeQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.atom.entity.inter.IFreeDisplayer;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.free.IIntlRoamFree;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/26.
 */
@ParamTypes({ @ParamType(c = SIntlRoamFreeQueryInDTO.class, m = "query", oc = SIntlRoamFreeQueryOutDTO.class) })
public class SIntlRoamFree extends AcctMgrBaseService implements IIntlRoamFree {

	private IFreeDisplayer freeDisplayer;
	private IUser user;
	private IBill bill;

	@Override
	public OutDTO query(InDTO inParam) {
		SIntlRoamFreeQueryInDTO inDTO = (SIntlRoamFreeQueryInDTO) inParam;

		String busiCode = "6";
		String phoneNo = inDTO.getPhoneNo();
		int queryYm = DateUtils.getCurYm();
		Map<String, FreeUseInfoEntity> freeUserMap = freeDisplayer.getFreeTotalInfo(phoneNo, queryYm, busiCode);
		log.debug("freeUserMap:" + freeUserMap);
		// 获取国际漫游当前已使用流量
		long used = 0;

		Set<String> keys = freeUserMap.keySet();

		for (String key : keys) {
			String busiCodeTmp = key.split("\\^")[0];

			if (busiCodeTmp.equals(busiCode)) {
				used += freeUserMap.get(key).getLongUsed();
			}
		}

		// 获取当前已使用国际漫游流量产生的费用
		long usedFee = 0;
		// List<com.sitech.acctmgr.net.Bill> unBillOweList = null;
		// 获取用户信息
		UserInfoEntity userInfoEntity = user.getUserEntity(null, phoneNo, null, true);

		// 查询用户的未出帐话费明细

		// UnBillData unBillData =
		// billDisplayer.findUnbillFee(userInfoEntity.getIdNo(),
		// userInfoEntity.getContractNo(), "02", "");

		UnbillEntity unbill = bill.getUnbillFee(userInfoEntity.getContractNo(), userInfoEntity.getIdNo(), CommonConst.UNBILL_TYPE_BILL_DET);
		List<BillEntity> billList = unbill.getUnBillList();
		// unBillOweList = unBillData.getBillList();
		for (BillEntity billEntity : billList) {
			if (billEntity.getAcctItemCode().substring(0, 2).equals("0w")) {
				usedFee += billEntity.getShouldPay() - billEntity.getFavourFee();
			}
		}

		SIntlRoamFreeQueryOutDTO outDTO = new SIntlRoamFreeQueryOutDTO();
		outDTO.setIntlRoamUsed(String.format("%.2f", used * 1.0 / 1024));
		outDTO.setIntlRoamFee(usedFee);
		return outDTO;
	}

	public IFreeDisplayer getFreeDisplayer() {
		return freeDisplayer;
	}

	public void setFreeDisplayer(IFreeDisplayer freeDisplayer) {
		this.freeDisplayer = freeDisplayer;
	}

	public IBill getBill() {
		return bill;
	}

	public void setBill(IBill bill) {
		this.bill = bill;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}
}
