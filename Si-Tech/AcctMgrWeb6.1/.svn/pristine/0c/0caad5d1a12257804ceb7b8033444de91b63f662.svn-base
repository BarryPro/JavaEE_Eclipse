package com.sitech.acctmgr.atom.impl.billAccount;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.prod.UserPdPrcDetailInfoEntity;
import com.sitech.acctmgr.atom.domains.query.PrcIdTransEntity;
import com.sitech.acctmgr.atom.domains.record.LoginOprEntity;
import com.sitech.acctmgr.atom.domains.user.GroupchgInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserDeadEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.dto.query.SMonthShareQryInDTO;
import com.sitech.acctmgr.atom.dto.query.SMonthShareQryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillAccount;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.billAccount.IMonthShareQry;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(m = "queryMonthShare", c = SMonthShareQryInDTO.class, oc = SMonthShareQryOutDTO.class) })
public class SMonthShareQry extends AcctMgrBaseService implements IMonthShareQry {

	private IBillAccount billAccount;
	private IUser user;
	private IProd prod;
	private IGroup group;
	private IRecord record;

	@Override
	public OutDTO queryMonthShare(InDTO inParam) {
		SMonthShareQryInDTO inDto = (SMonthShareQryInDTO) inParam;
		SMonthShareQryOutDTO outDto = new SMonthShareQryOutDTO();
		
		String phoneNo = "";
		long idNo = 0;
		String flag=inDto.getFlag();
		String effectFlag = inDto.getEffectFlag();
		
		if(StringUtils.isNotEmpty(inDto.getPhoneNo())){
			phoneNo=inDto.getPhoneNo();
		}
		
		if (inDto.getIdNo() >= 0) {
			idNo = inDto.getIdNo();
		}
		
		// 获取用户信息
		int userFlag = CommonConst.IN_NET;
		UserInfoEntity userInfo = user.getUserEntity(idNo, phoneNo, 0l, false);
		if (userInfo == null) {
			// 获取离网用户的信息
			List<UserDeadEntity> userDeadList = user.getUserdeadEntity(phoneNo, idNo, 0l);
			if (userDeadList.size() > 0) {
				userFlag = CommonConst.NO_NET;
				idNo = userDeadList.get(0).getIdNo();
			}
		} else {
			if (idNo == 0) {
				idNo = userInfo.getIdNo();
			}
		}
		List<UserPrcEntity> userMainPrcEntList = new ArrayList<UserPrcEntity>();
		// 查询用户的主资费(生效和未生效)
		if (userFlag == CommonConst.IN_NET) {
			userMainPrcEntList = prod.getPdPrcId(idNo, "0", null, "false", "true");
		} else {
			userMainPrcEntList = prod.getPdPrcId(idNo, "0", null, "false", "false");
		}
		outDto.setUserPrcList(userMainPrcEntList);
		
		if(flag.equals("Y")){
			// 查询用户的有效的附加资费
			List<UserPrcEntity> userSubPrcEntList = new ArrayList<UserPrcEntity>();
			userSubPrcEntList = prod.getPdPrcId(idNo, "1");

			// 获取用户所在地市
			// 查询用户的region_code
			GroupchgInfoEntity groupchgInfo = group.getChgGroup(phoneNo, idNo, 0l);
			String groupId = groupchgInfo.getGroupId();
			ChngroupRelEntity chnGroupRel = group.getRegionDistinct(groupId, "2", inDto.getProvinceId());
			String regionCode = chnGroupRel.getRegionCode();
			// 查询用户的月租日租属性
			String mainPrcId = "";
			for (UserPrcEntity userPrc : userMainPrcEntList) {
				if (userPrc.getExpFlag().equals("有效")) {
					mainPrcId = userPrc.getProdPrcid();
					break;
				}
			}
			int userStaticType = getUserAttr(mainPrcId, regionCode);
			List<UserPrcEntity> total = new ArrayList<UserPrcEntity>();
			for (UserPrcEntity userPrc : userMainPrcEntList) {
				if (userPrc.getExpFlag().equals("有效") && effectFlag.equals("0")) {
					total.add(userPrc);
				} else if (userPrc.getExpFlag().equals("归档") && effectFlag.equals("1")) {
					total.add(userPrc);
				}
			}
			total.addAll(userSubPrcEntList);
			List<UserPdPrcDetailInfoEntity> userPrcDetailList = getUserPrcDetailList(total, regionCode);
			log.debug("userPrcDetailList:" + userPrcDetailList);

			for(UserPdPrcDetailInfoEntity userPrcDetail:userPrcDetailList){
				if (userPrcDetail.getDetailType().equals("1") || userPrcDetail.getDetailType().equals("9")) {
					userPrcDetail.getProdPrcid();
					String detailCode = userPrcDetail.getDetailCode();
					int familyCode = billAccount.isFamilyMonthCode(detailCode);
					if (familyCode > 0) {
						userStaticType = 0;
					} else {
						// 日租用户
						if(userStaticType==0){
							if(userPrcDetail.getDetailType().equals("1")){
								userStaticType=0;
							} else {
								if (userPrcDetail.getMonthFlag().equals("1")) {
									userStaticType = 1;
								}
								if (ValueUtils.intValue(userPrcDetail.getMonthFlag()) > 1) {
									userStaticType = 0;
								}
							}
						} else {
							// 月租用户
							if (userPrcDetail.getDetailType().equals("1")) {
								userStaticType = 1;
							} else {
								if (userPrcDetail.getMonthFlag().equals("1")) {
									userStaticType = 1;
								}
								if (ValueUtils.intValue(userPrcDetail.getMonthFlag()) > 1) {
									userStaticType = 0;
								}
							}
						}
					}
					if (userStaticType == 0) {
						userPrcDetail.setShareFlag("否");
					}else{
						String specialFlag = specialFlag(userPrcDetail.getPrcClass(), userPrcDetail.getProdPrcid());
						if (specialFlag.equals("是")) {
							userPrcDetail.setShareFlag("否");
						} else {
							userPrcDetail.setShareFlag("是");
						}
					}
				} else {
					userPrcDetail.setShareFlag("NULL");
				}
			}

			outDto.setUserPrcDetailList(userPrcDetailList);
		}
		

		// 获取系统时间
		int totalDate = DateUtils.getCurDay();
		// 入营业员操作记录表
		LoginOprEntity in = new LoginOprEntity();
		in.setIdNo(idNo);
		in.setBrandId(userInfo.getBrandId());
		in.setPhoneNo(phoneNo);
		in.setLoginNo(inDto.getLoginNo());
		in.setLoginGroup(inDto.getGroupId());
		in.setOpCode(inDto.getOpCode());
		in.setTotalDate(totalDate);
		in.setRemark(inDto.getOpCode());
		record.saveLoginOpr(in);
		
		
		return outDto;
	}


	private List<UserPdPrcDetailInfoEntity> getUserPrcDetailList(List<UserPrcEntity> userPrcList, String regionCode) {
		List<UserPdPrcDetailInfoEntity> userPdPrcDetailList = new ArrayList<UserPdPrcDetailInfoEntity>();
		for (UserPrcEntity userPrc : userPrcList) {
			// 老系统为60001对应新系统23M003
			Map<String, Object> inMap = new HashMap<String, Object>();
			inMap.put("ATTR_ID", "23M003");
			inMap.put("ID_NO", userPrc.getIdNo());
			inMap.put("PRC_ID", userPrc.getProdPrcid());
			inMap.put("REGION_CODE", regionCode.substring(2, 4));
			Map<String, Object> flagMap = billAccount.getFlag(inMap);
			log.debug("小区：" + flagMap);
			// 查询优惠代码和优惠名称及优惠类型
			List<PrcIdTransEntity> billInfoList = billAccount.getRateInfo(userPrc.getProdPrcid(), "", regionCode);
			log.debug("查询优惠信息" + billInfoList);
			for (PrcIdTransEntity billInfo : billInfoList) {
				UserPdPrcDetailInfoEntity userPdPrcDetail=new UserPdPrcDetailInfoEntity();
				userPdPrcDetail.setProdPrcid(userPrc.getProdPrcid());
				userPdPrcDetail.setPrcName(userPrc.getProdPrcName());
				userPdPrcDetail.setLoginNo(userPrc.getLoginNo());
				userPdPrcDetail.setLoginAccept(userPrc.getLoginAccept());
				userPdPrcDetail.setBeginTime(userPrc.getEffDate());
				userPdPrcDetail.setEndTime(userPrc.getExpDate());
				userPdPrcDetail.setPrcClass(userPrc.getPrcClass());
				userPdPrcDetail.setDetailCode(billInfo.getDetailCode());
				userPdPrcDetail.setDetailNote(billInfo.getDetailNote());
				userPdPrcDetail.setDetailType(billInfo.getDetailType());
				userPdPrcDetail.setDetailTypeName(billInfo.getDetailTypeName());

				// 查询月租
				Map<String, Object> monthCodeMap = billAccount.getMonthCodeInfo(regionCode, billInfo.getDetailCode());

				if (billInfo.getDetailType().equals("1") || billInfo.getDetailType().equals("9")) {
					userPdPrcDetail.setMonthFlag(monthCodeMap.get("MONTH_FLAG").toString());
					userPdPrcDetail.setMonFee(monthCodeMap.get("MONTH_FEE").toString());
				} else {
					userPdPrcDetail.setMonFee("0.00");
				}

				if (flagMap != null && StringUtils.isNotEmptyOrNull(flagMap.get("ATTR_VAL"))) {
					userPdPrcDetail.setFlagCode(flagMap.get("ATTR_VAL").toString());
					userPdPrcDetail.setFlagName(flagMap.get("FLAG_CODE_NAME").toString());
				} else {
					userPdPrcDetail.setFlagCode("无");
					userPdPrcDetail.setFlagName("无");
				}

				userPdPrcDetailList.add(userPdPrcDetail);
			}

		}

		return userPdPrcDetailList;
	}

	// 判断用户日收和月收属性 0:日收 1：月收
	private int getUserAttr(String mainPrcId, String regionCode) {
		int staticType = 0;
		log.debug("主资费是》》》》》" + mainPrcId);
		List<PrcIdTransEntity> prcIdTransList = billAccount.getRateInfo(mainPrcId, "1", regionCode);

		if (prcIdTransList.size() > 0) {
			PrcIdTransEntity prcIdTrans = prcIdTransList.get(0);
			// 获取月租代码
			Map<String, Object> monthMap = billAccount.getMonthCodeInfo(regionCode, prcIdTrans.getDetailCode());

			if (monthMap == null || StringUtils.isEmptyOrNull(monthMap.get("DAY_FLAG"))) {
				throw new BusiException(AcctMgrError.getErrorCode("0000", ""), "取用户的月租代码错误");
			}
			String dayFlag = monthMap.get("DAY_FLAG").toString();
			if (dayFlag.equals("0")) {
				staticType = 1;
			}else{
				// 查询月租配置
				int monthCfg = billAccount.monthCfg(mainPrcId, regionCode);
				if (monthCfg > 0) {
					staticType = 1;
				}
			}

		} else {
			staticType = 1;
		}
		return staticType;
	}

	// 是否为话费加油包或亲情流量分享
	private String specialFlag(String prcClass, String prcId) {
		// 用户资费、月收取属性

		String specailFlag = "否";
		// 话费加油包
		if (prcClass.equals("YnGA40")){
			specailFlag = "是";
		}
		// 亲情流量共享
		if (prcId.equals("M042363") || prcId.equals("M042362") || prcId.equals("M042364")) {
			specailFlag = "是";
		}
		return specailFlag;
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

	public IRecord getRecord() {
		return record;
	}

	public void setRecord(IRecord record) {
		this.record = record;
	}

}
