package com.sitech.acctmgr.atom.impl.free;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.query.FreeMinBill;
import com.sitech.acctmgr.atom.dto.free.SSchoolFreeQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.SSchoolFreeQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IFreeDisplayer;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.inter.free.ISchoolFree;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/25.
 */
@ParamTypes({ @ParamType(c = SSchoolFreeQueryInDTO.class, m = "query", oc = SSchoolFreeQueryOutDTO.class) })
public class SSchoolFree extends AcctMgrBaseService implements ISchoolFree {

	private IUser user;
	private IFreeDisplayer freeDisplayer;

	@Override
	public OutDTO query(InDTO inParam) {
		SSchoolFreeQueryInDTO inDTO = (SSchoolFreeQueryInDTO) inParam;
		log.debug("inDto=" + inDTO.getMbean());

		String broadNo = inDTO.getPhoneNo();// 宽带账号
		int queryYm = inDTO.getYearMonth();

		String mobilePhoneNo = user.getPhoneNoByAsn(broadNo, CommonConst.NBR_TYPE_KD);

		List<FreeMinBill> detailList = freeDisplayer.getFreeDetailList(mobilePhoneNo, queryYm, "P");

		Map<String, Long> freeTotalMap = this.getFreeTotalMap(detailList);
		long netTimeTotal = freeTotalMap.get("NET_TIME_TOTAL");
		long netTimeUsed = freeTotalMap.get("NET_TIME_USED");
		long netTimeRemain = freeTotalMap.get("NET_TIME_REMAIN");

		SSchoolFreeQueryOutDTO outDTO = new SSchoolFreeQueryOutDTO();
		outDTO.setNetTimeTotal(String.format("%d", netTimeTotal));
		outDTO.setNetTimeUsed(String.format("%d", netTimeUsed));
		outDTO.setNetTimeRemain(String.format("%d", netTimeRemain));

		log.debug("outDto=" + outDTO.toJson());
		return outDTO;
	}

	/**
	 * 以优惠信息进行汇总
	 * 
	 * @param freeList
	 * @return
	 */
	private Map<String, Long> getFreeTotalMap(List<FreeMinBill> freeList) {
		Map<String, Long> totalMap = new HashMap<>();

		long netTimeTotal = 0;
		long netTimeUsed = 0;
		long netTimeRemain = 0;
		for (FreeMinBill freeEnt : freeList) {
			String busiCode = freeEnt.getBusiCode();

			if (busiCode.equals("P")) {
				netTimeTotal += freeEnt.getLongTotal();
				netTimeUsed += freeEnt.getLongUsed();
				netTimeRemain += freeEnt.getLongRemain();
			}
		}

		safeAddToMap(totalMap, "NET_TIME_TOTAL", netTimeTotal);
		safeAddToMap(totalMap, "NET_TIME_USED", netTimeUsed);
		safeAddToMap(totalMap, "NET_TIME_REMAIN", netTimeRemain);

		return totalMap;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IFreeDisplayer getFreeDisplayer() {
		return freeDisplayer;
	}

	public void setFreeDisplayer(IFreeDisplayer freeDisplayer) {
		this.freeDisplayer = freeDisplayer;
	}
}
