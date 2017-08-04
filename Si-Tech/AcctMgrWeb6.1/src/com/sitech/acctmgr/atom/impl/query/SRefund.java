package com.sitech.acctmgr.atom.impl.query;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.query.RefundEntity;
import com.sitech.acctmgr.atom.domains.record.ActQueryOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.query.SRefundInDTO;
import com.sitech.acctmgr.atom.dto.query.SRefundOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAdj;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.query.IRefund;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(m = "queryRefundInfo", c = SRefundInDTO.class, oc = SRefundOutDTO.class),
		@ParamType(m = "queryRefundInfoFor10086", c = SRefundInDTO.class, oc = SRefundOutDTO.class) })
public class SRefund extends AcctMgrBaseService implements IRefund {

	private IUser user;
	private IAdj adj;
	private IGroup group;
	private IBillAccount billAccount;
	private IRecord record;

	@Override
	public OutDTO queryRefundInfo(InDTO inParam) {
		SRefundInDTO inDto = (SRefundInDTO) inParam;

		String phoneNo = inDto.getPhoneNo();
		String beginTime = inDto.getBeginTime();
		String endTime = inDto.getEndTime();
		String queryType = inDto.getQueryType();
		// 根据服务号码查询用户信息
		UserInfoEntity userInfo = user.getUserEntity(0l, phoneNo, 0l, true);
		long idNo = userInfo.getIdNo();
		long contractNo = userInfo.getContractNo();

		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("PHONE_NO", phoneNo);
		inMap.put("BEGIN_TIME", beginTime);
		inMap.put("END_TIME", endTime);
		inMap.put("GROUP_ID", inDto.getGroupId());
		inMap.put("QUERY_TYPE", queryType);
		inMap.put("ID_NO", idNo);
		inMap.put("CONTRACT_NO", contractNo);

		List<RefundEntity> refundList = new ArrayList<RefundEntity>();

		// queryType=0 查询全部退费 1:gprs退费 2：梦网/及自有业务退费
		if (queryType.equals("0")) {
			// 从表act_adjowe_info和ACT_OBBIZBACK_INFO表中取值
			for (int yearMonth = Integer.parseInt(endTime.substring(0, 6)); yearMonth >= Integer.parseInt(beginTime.substring(0, 6)); yearMonth = DateUtils
					.addMonth(yearMonth, -1)) {
				inMap.put("YEAR_MONTH", yearMonth);
				List<RefundEntity> refundListTmp = adj.getRefundList(inMap);
				log.debug("refundListTmp:" + refundListTmp);

				if (refundListTmp != null) {
					refundListTmp = dealRefund(refundListTmp, inDto.getProvinceId(), "0");
				}

				refundList.addAll(refundListTmp);

			}
			log.debug(refundList + ">>>>>>>");
			if (refundList == null || refundList.size() == 0) {
				throw new BusiException(getErrorCode("8126", "11001"), "该用户在这段时间内没有退费");
			}

		} else if (queryType.equals("1")) {
			inMap.put("REASON", "1|%");
			for (int yearMonth = Integer.parseInt(endTime.substring(0, 6)); yearMonth >= Integer.parseInt(beginTime.substring(0, 6)); yearMonth = DateUtils
					.addMonth(yearMonth, -1)) {
				inMap.put("YEAR_MONTH", yearMonth);
				List<RefundEntity> refundListTmp = adj.getGprsOrMonternetRefund(inMap);
				log.debug("refundListTmp:" + refundListTmp);
				if (refundListTmp != null) {
					refundListTmp = dealRefund(refundListTmp, inDto.getProvinceId(), "0");
				}

				refundList.addAll(refundListTmp);

			}
			if (refundList == null || refundList.size() == 0) {
				throw new BusiException(getErrorCode("8126", "11001"), "该用户在这段时间内没有GPRS退费");
			}
		} else if (queryType.equals("2")) {
			inMap.put("REASON", "0|%");
			for (int yearMonth = Integer.parseInt(endTime.substring(0, 6)); yearMonth >= Integer.parseInt(beginTime.substring(0, 6)); yearMonth = DateUtils
					.addMonth(yearMonth, -1)) {
				inMap.put("YEAR_MONTH", yearMonth);
				List<RefundEntity> refundListTmp = adj.getGprsOrMonternetRefund(inMap);
				log.debug("refundListTmp:" + refundListTmp);
				if (refundListTmp != null) {
					refundListTmp = dealRefund(refundListTmp, inDto.getProvinceId(), "0");
				}

				refundList.addAll(refundListTmp);

			}
			if (refundList == null || refundList.size() == 0) {
				throw new BusiException(getErrorCode("8126", "11002"), "该用户在这段时间内没有梦网/及自有业务退费");
			}
		}

		SRefundOutDTO outDto = new SRefundOutDTO();
		outDto.setRefundList(refundList);
		return outDto;
	}

	@Override
	public OutDTO queryRefundInfoFor10086(InDTO inParam) {
		SRefundInDTO inDto = (SRefundInDTO) inParam;
		String proviceId = inDto.getProvinceId();
		Map<String, Object> inMap = null;

		String phoneNo = "";
		long contractNo = 0;
		String flag = "0";
		if (StringUtils.isNotEmpty(inDto.getPhoneNo())) {
			phoneNo = inDto.getPhoneNo();
			flag = "1";
		}

		String beginTime = inDto.getBeginTime();
		String endTime = inDto.getEndTime();
		List<RefundEntity> refundList = new ArrayList<RefundEntity>();
		inMap = new HashMap<String, Object>();
		inMap.put("PHONE_NO", phoneNo);
		inMap.put("BEGIN_TIME", beginTime);
		inMap.put("END_TIME", endTime);
		inMap.put("GROUP_ID", inDto.getGroupId());

		for (int yearMonth = Integer.parseInt(endTime.substring(0, 6)); yearMonth >= Integer.parseInt(beginTime.substring(0, 6)); yearMonth = DateUtils
				.addMonth(yearMonth, -1)) {
			inMap.put("YEAR_MONTH", yearMonth);
			List<RefundEntity> refundList1 = adj.getGprsOrMonternetRefund(inMap);

			inMap.put("CONTRACT_NO", contractNo);
			refundList.addAll(refundList1);
		}

		refundList = dealRefund(refundList, proviceId, flag);
		// 插营业操作记录表
		ActQueryOprEntity oprEntity = new ActQueryOprEntity();
		oprEntity.setQueryType("0");
		oprEntity.setOpCode("8416");
		oprEntity.setContactId("");
		oprEntity.setIdNo(0l);
		if (StringUtils.isNotEmpty(inDto.getPhoneNo())) {
			oprEntity.setPhoneNo(phoneNo);
		} else {
			oprEntity.setPhoneNo("999999999999");
		}
		oprEntity.setBrandId("");
		oprEntity.setLoginNo(inDto.getLoginNo());
		oprEntity.setLoginGroup(inDto.getGroupId());
		oprEntity.setRemark("10086人工退费查询");
		oprEntity.setProvinceId(inDto.getProvinceId());
		record.saveQueryOpr(oprEntity, false);
		SRefundOutDTO outDto = new SRefundOutDTO();
		outDto.setRefundList(refundList);

		log.debug("outDto = " + outDto.toJson());
		return outDto;
	}

	// flag:表示是否传入了phoneNo，flag=0：表示phoneNo不为空，只需要查询每个的phoneNo的归属 flag=1：
	// 表示phoneNo为空，需要查询所有phoneNo的归属
	private List<RefundEntity> dealRefund(List<RefundEntity> refundList, String proviceId, String flag) {
		log.debug("待处理的退费列表：" + refundList);
		List<RefundEntity> refundEntList = new ArrayList<RefundEntity>();
		String regionName = "";
		for (RefundEntity refund : refundList) {
			// 根据服务号码查询归属地市
			String phoneNo = refund.getPhoneNo();
			// 如果服务号码为空，根据contract_no查询用户号码
			if (StringUtils.isEmpty(phoneNo)) {
				UserInfoEntity userInfo = user.getUserEntityByIdNo(refund.getIdNo(), false);
				if (userInfo == null) {
					continue;
				} else {
					phoneNo = userInfo.getPhoneNo();
				}
			}

			if (flag.equals("1") || StringUtils.isEmpty(regionName)) {
				UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, false);
				if (userInfo == null) {
					continue;
				}
				String groupId = userInfo.getGroupId();
				ChngroupRelEntity groupRelInfo = group.getRegionDistinct(groupId, "", proviceId);
				regionName = groupRelInfo.getRegionName();
			}

			refund.setRegionName(regionName);
			// 查询三级退费原因名称
			String reasonCode = refund.getReasonCode();
			if (StringUtils.isNotEmpty(reasonCode)) {
				String[] reason = reasonCode.split("\\|");
				if (reason.length >= 3) {
					String thirdReason = reason[2];
					log.debug("三级原因:" + thirdReason);
					// 从pub_codedef_dict表中获取名称 code_class='2412'
					String thirdReasonName = adj.reasonName("2412", thirdReason, "4");
					if (StringUtils.isEmpty(thirdReasonName)) {
						continue;
					}
					refund.setReasonName(thirdReasonName);
				} else {
					refund.setReasonName("无");
				}

			}

			// 查询sp名称，企业名称,计费名称
			if (StringUtils.isNotEmpty(refund.getSpCode()) && StringUtils.isNotEmpty(refund.getSpName())) {
				String spName = billAccount.getSpName(refund.getSpCode());
				if (StringUtils.isNotEmpty(spName)) {
					refund.setSpName(spName);
				}
			}
			if (StringUtils.isNotEmpty(refund.getOperCode()) && StringUtils.isNotEmpty(refund.getOperName())) {
				if (StringUtils.isNotEmpty(billAccount.getOperName(refund.getSpCode(), refund.getOperCode()))) {
					refund.setOperName(billAccount.getOperName(refund.getSpCode(), refund.getOperCode()));
				}
			}
			if (StringUtils.isNotEmpty(refund.getBillType())) {
				if (StringUtils.isNotEmpty(billAccount.getbillTypeName(refund.getBillType()))) {
					refund.setBillName(billAccount.getbillTypeName(refund.getBillType()));
				}
			}
			refundEntList.add(refund);
		}


		return refundEntList;
	}

	public IUser getUser() {
		return user;
	}

	public void setUser(IUser user) {
		this.user = user;
	}

	public IAdj getAdj() {
		return adj;
	}

	public void setAdj(IAdj adj) {
		this.adj = adj;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}

	public IBillAccount getBillAccount() {
		return billAccount;
	}

	public void setBillAccount(IBillAccount billAccount) {
		this.billAccount = billAccount;
	}

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

}
