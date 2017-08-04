package com.sitech.acctmgr.atom.entity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.query.RemindOpenEntity;
import com.sitech.acctmgr.atom.entity.inter.IRemind;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.common.utils.ValueUtils;

public class Remind extends BaseBusi implements IRemind {

	@Override
	public int queryShortRemindAuth(String phoneNo) {

		// TODO:老系统查询的表为dbbillprg.WARMSSUNIQUECTR
		int count = (int) baseDao.queryForObject("warmssuniquectr.qCnt", phoneNo);

		return count;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<RemindOpenEntity> queryRemindOpenOrOff(String phoneNo) {

		List<RemindOpenEntity> remindOpenListTmp = new ArrayList<RemindOpenEntity>();
		List<RemindOpenEntity> remindOpenList = new ArrayList<RemindOpenEntity>();

		// TODO:老系统用到的表为：dbbillprg.remind_warn_rule_table
		remindOpenListTmp = baseDao.queryForList("remind_warn_rule_table.getOpenRule");

		for (RemindOpenEntity remindEntity : remindOpenListTmp) {

			String ruleId = remindEntity.getRuleId();

			Map<String, Object> inMap = new HashMap<String, Object>();
			List<String> ruleIdList = new ArrayList<String>();
			ruleIdList.add(ruleId);
			inMap.put("RULE_ID", ruleIdList);
			inMap.put("PHONE_NO", phoneNo);
			// TODO:老系统用到的表为：dbbillprg.remind_warn_user_info
			int count = Integer.parseInt((String) baseDao.queryForObject("remind_warn_user_info.qCnt", inMap));

			String isRemind = remindEntity.getIsRemind();
			if (isRemind.equals("0") && count == 0 || isRemind.equals("1") && count == 1) {
				remindEntity.setFlag("0");// 已开通，可以关闭
			} else {
				remindEntity.setFlag("1");// 已关闭，可以开通
			}

			remindOpenList.add(remindEntity);
		}

		return remindOpenList;
	}

	@Override
	public long qryAwokeFee(long idNo, int awokeDay, String validFlag) {
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("ID_NO", idNo);
		inMap.put("REAWOKE_DAY", 0);
		inMap.put("VALID_FLAG", "0");
		Map<String, Object> outMap = (Map<String, Object>) baseDao.queryForObject("cs_feeawokeadd_info.qAwokeFee", inMap);
		long awokeFee = 0;
		if(outMap!=null){
			awokeFee = ValueUtils.longValue(outMap.get("AWOKE_FEE"));
		}
		return awokeFee;
	}
}
