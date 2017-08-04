package com.sitech.acctmgr.atom.busi.pay;

import java.util.HashMap;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.inter.ILimitFee;
import com.sitech.acctmgr.atom.domains.pay.DistrictLimitEntity;
import com.sitech.acctmgr.atom.domains.pay.RegionLimitEntity;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgrint.atom.busi.intface.IShortMessage;
import com.sitech.jcf.core.exception.BaseException;
import com.sitech.jcfx.dt.MBean;

public class LimitFee extends BaseBusi implements ILimitFee{
	
	private IGroup group;
	private IShortMessage shortMessage;
	
	/*获取地市限额信息*/
	public RegionLimitEntity getRegionLimitConf(String regionGroup,String limitType){
		Map<String,Object> inParam;
		inParam = new HashMap<String,Object>();
		inParam.put("REGION_GROUP",regionGroup);
		inParam.put("LIMIT_TYPE", limitType);
		RegionLimitEntity regionLimitEnt = (RegionLimitEntity)baseDao.queryForObject("bal_paybacklimit_conf.qRegionLimitConf",inParam);
		return regionLimitEnt;
	}
	
	/*获取区县限额信息*/
	public DistrictLimitEntity getDistrictLimitConf(String regionGroup,String districtGroup,String limitType){
		Map<String,Object> inParam;
		inParam = new HashMap<String,Object>();
		inParam.put("REGION_GROUP",regionGroup);
		inParam.put("DISTRICT_GROUP", districtGroup);
		inParam.put("LIMIT_TYPE", limitType);
		DistrictLimitEntity districtLimitEnt = (DistrictLimitEntity)baseDao.queryForObject("bal_paybacklimit_dist_conf.qDistrictLimitConf",inParam);
		return districtLimitEnt;
	}
	
	/*更新地市月限额*/
	public void updateMonthRegionLimit(long backedMonthFee,String regionGroup,String limitType){
		Map<String,Object> inParam;
		inParam = new HashMap<String,Object>();
		inParam.put("REGION_GROUP",regionGroup);
		inParam.put("LIMIT_TYPE", limitType);
		inParam.put("BACKED_MONTH_FEE", backedMonthFee);
		baseDao.update("bal_paybacklimit_conf.upRMonthFee",inParam);
	}
	
	/*更新地市日限额*/
	public void updateDayRegionLimit(long backedDayFee,String regionGroup,String limitType){
		Map<String,Object> inParam;
		inParam = new HashMap<String,Object>();
		inParam.put("REGION_GROUP",regionGroup);
		inParam.put("LIMIT_TYPE", limitType);
		inParam.put("BACKED_DAY_FEE", backedDayFee);
		baseDao.update("bal_paybacklimit_conf.upRDayFee",inParam);
		
	}
	
	/*更新区县月限额*/
	public void  updateMonthDistrictLimit(long backedMonthFee,String regionGroup,String limitType,String districtGroup){
		Map<String,Object> inParam;
		inParam = new HashMap<String,Object>();
		inParam.put("REGION_GROUP",regionGroup);
		inParam.put("LIMIT_TYPE", limitType);
		inParam.put("BACKED_MONTH_FEE", backedMonthFee);
		inParam.put("DISTRICT_GROUP",districtGroup);
		baseDao.update("bal_paybacklimit_dist_conf.upCMonthFee",inParam);
	}
	
	/*更新区县日限额*/
	public void updateDayDistrictLimit(long backedDayFee,String regionGroup,String limitType,String districtGroup){
		Map<String,Object> inParam;
		inParam = new HashMap<String,Object>();
		inParam.put("REGION_GROUP",regionGroup);
		inParam.put("LIMIT_TYPE", limitType);
		inParam.put("BACKED_DAY_FEE", backedDayFee);
		inParam.put("DISTRICT_GROUP",districtGroup);
		baseDao.update("bal_paybacklimit_dist_conf.upCDayFee",inParam);
	}
	
	/*转账地市月限额校验*/
	@SuppressWarnings("unchecked")
	public void regionMonthLimit(Map<String,Object> inParam){
		/*地市转账退费月限额配置信息查询*/
		long transFee = (long)inParam.get("TRANS_FEE");
		String regionGroup = (String)inParam.get("REGION_GROUP");
		String limitType = (String)inParam.get("LIMIT_TYPE");
		RegionLimitEntity regionLimitEnt = this.getRegionLimitConf(regionGroup, limitType);
		
		long limitMonthFee = regionLimitEnt.getLimitMonthFee();
		long backedMonthFee = regionLimitEnt.getBackedMonthFee();
		long transMonthFee = transFee + backedMonthFee;
		
		String limitMFStr = String.format("%.2f", (double) limitMonthFee / 100);
		String backedMFStr = String.format("%.2f", (double) backedMonthFee / 100);
		String transStr = String.format("%.2f", (double) transFee / 100);
		
		/*地市月限额校验*/
		if(transMonthFee >= limitMonthFee){
			throw new BaseException(AcctMgrError.getErrorCode("8008","00012"),"超出地市月限额，目前月限额："+ limitMFStr +"元，目前月总额："+ backedMFStr +
					"元，本次受理："+ transStr + "元");
		}
		
		//有发短信的业务逻辑，但是帐管短信模板没有，暂定不发
	}
	
	/*地市日限额*/
	@SuppressWarnings("unchecked")
	public void regionDayLimit(Map<String,Object> inParam){
		/*地市转账退费日限额配置信息查询*/

		long transFee = (long)inParam.get("TRANS_FEE");
		String regionGroup = (String)inParam.get("REGION_GROUP");
		String limitType = (String)inParam.get("LIMIT_TYPE");
		RegionLimitEntity regionLimitEnt = this.getRegionLimitConf(regionGroup, limitType);
		
		long limitMonthFee = regionLimitEnt.getLimitMonthFee();
		long backedMonthFee = regionLimitEnt.getBackedMonthFee();
		long transMonthFee = transFee + backedMonthFee;
		long limitDayFee = regionLimitEnt.getLimitDayFee();
		long backedDayFee = regionLimitEnt.getBackedDayFee();
		long transDayFee = transFee + backedDayFee;
		
		String limitMFStr = String.format("%.2f", (double) limitMonthFee / 100);
		String backedMFStr = String.format("%.2f", (double) backedMonthFee / 100);
		String transStr = String.format("%.2f", (double) transFee / 100);
		String limitDFStr = String.format("%.2f", (double) limitDayFee / 100);
		String backedDFStr = String.format("%.2f", (double) backedDayFee / 100);

		if(transMonthFee > limitMonthFee){
			throw new BaseException(AcctMgrError.getErrorCode("8008","00012"),"超出地市月限额，目前月限额："+ limitMFStr +"元，目前月总额："+ backedMFStr +
					"元，本次受理："+ transStr + "元");
		}
		if(transDayFee > limitDayFee){
			throw new BaseException(AcctMgrError.getErrorCode("8008","00013"),"超出地市日限额，目前日限额："+ limitDFStr +"元，目前日总额："+ backedDFStr +
					"元，本次受理："+ transStr + "元");
		}
		
		//地市日限额和月限额超限额80%发送短信，无短信内容暂不发送
		if(transMonthFee > limitMonthFee * 0.8){
			Map<String,Object> msgMap = new HashMap<String,Object>();
			Map<String,Object> flagMap = new HashMap<String,Object>();
			flagMap.put("REGION_GROUP", regionGroup);
			flagMap.put("LIMIT_TYPE", limitType);
			msgMap.put("FLAG_MAP", flagMap);
			//this.sendMRegionMsgWarning(msgMap);
		}
		if(transDayFee > limitDayFee * 0.8){
			Map<String,Object> msgMap = new HashMap<String,Object>();
			Map<String,Object> flagMap = new HashMap<String,Object>();
			flagMap.put("REGION_GROUP", regionGroup);
			flagMap.put("LIMIT_TYPE", limitType);
			msgMap.put("FLAG_MAP", flagMap);
			//this.sendDRegionMsgWarning(msgMap);
		}
	}
	
	@SuppressWarnings("unchecked")
	public void districtDayLimit(Map<String,Object> inParam){
		
		/*区县退费日限额配置信息查询*/
		long transFee = (long)inParam.get("TRANS_FEE");
		String regionGroup = (String)inParam.get("REGION_GROUP");
		String limitType = (String)inParam.get("LIMIT_TYPE");
		String districtGroup = (String)inParam.get("DISTRICT_GROUP");
		DistrictLimitEntity districtLimitEnt = this.getDistrictLimitConf(regionGroup,districtGroup, limitType);
		String msgPhone = districtLimitEnt.getMsgPhone();
		String msgDayFlag = districtLimitEnt.getMsgDayFlag();
		String msgMonthFlag = districtLimitEnt.getMsgMonthFlag();
		
		long limitMonthFee = districtLimitEnt.getLimitMonthFee();
		long backedMonthFee = districtLimitEnt.getBackedMonthFee();
		long transMonthFee = transFee + backedMonthFee;
		long limitDayFee = districtLimitEnt.getLimitDayFee();
		long backedDayFee = districtLimitEnt.getBackedDayFee();
		long transDayFee = transFee + backedDayFee;
		
		String limitMFStr = String.format("%.2f", (double) limitMonthFee / 100);
		String backedMFStr = String.format("%.2f", (double) backedMonthFee / 100);
		String transStr = String.format("%.2f", (double) transFee / 100);
		String limitDFStr = String.format("%.2f", (double) limitDayFee / 100);
		String backedDFStr = String.format("%.2f", (double) backedDayFee / 100);

		if(transMonthFee > limitMonthFee){
			throw new BaseException(AcctMgrError.getErrorCode("8008","00014"),"超出区县月限额，目前月限额："+ limitMFStr +"元，目前月总额："+ backedMFStr +
					"元，本次受理："+ transStr + "元");
		}else if(transDayFee > limitDayFee){
				throw new BaseException(AcctMgrError.getErrorCode("8008","00015"),"超出区县日限额，目前日限额："+ limitDFStr +"元，目前日总额："+ backedDFStr +
						"元，本次受理："+ transStr + "元");
		}
		if(transMonthFee > limitMonthFee * 0.8){
			Map<String,Object> msgMap = new HashMap<String,Object>();
			Map<String,Object> flagMap = new HashMap<String,Object>();
			flagMap.put("REGION_GROUP", regionGroup);
			flagMap.put("LIMIT_TYPE", limitType);
			flagMap.put("DISTRICT_GROUP", districtGroup);
			flagMap.put("MSG_PHONE", msgPhone);
			msgMap.put("FLAG_MAP", flagMap);
			if(msgMonthFlag.equals("0")){
				this.sendMDistrictMsgWarning(msgMap);
			}
		}
		if(transDayFee > limitDayFee * 0.8){
			Map<String,Object> msgMap = new HashMap<String,Object>();
			Map<String,Object> flagMap = new HashMap<String,Object>();
			flagMap.put("REGION_GROUP", regionGroup);
			flagMap.put("LIMIT_TYPE", limitType);
			flagMap.put("DISTRICT_GROUP", districtGroup);
			flagMap.put("MSG_PHONE", msgPhone);
			msgMap.put("FLAG_MAP", flagMap);
			if(msgDayFlag.equals("0")){
				this.sendDDistrictMsgWarning(msgMap);
			}
		}
	}
	
	/*更新地市限额配置信息*/
	public void updateRegionLimit(String regionMonthLimit,String regionDayLimit,String regionGroup,String limitType,String msgPhone){
		Map<String,Object> limitMap = new HashMap<String,Object>();
		limitMap.put("REGION_MONTH_LIMIT", regionMonthLimit);
		limitMap.put("REGION_DAY_LIMIT", regionDayLimit);
		limitMap.put("REGION_GROUP", regionGroup);
		limitMap.put("LIMIT_TYPE", limitType);
		limitMap.put("MSG_PHONE", msgPhone);
		
		baseDao.update("bal_paybacklimit_conf.upRegionLimit",limitMap);
	}
	
	/*更新区县限额配置信息*/
	public void updateDistrictLimit(String districtGroup,String districtMonthLimit,String districtDayLimit,String regionGroup,String limitType,String msgPhone){
		Map<String,Object> limitMap = new HashMap<String,Object>();
		limitMap.put("DISTRICT_MONTH_LIMIT", districtMonthLimit);
		limitMap.put("DISTRICT_DAY_LIMIT", districtDayLimit);
		limitMap.put("REGION_GROUP", regionGroup);
		limitMap.put("DISTRICT_GROUP", districtGroup);
		limitMap.put("LIMIT_TYPE", limitType);
		limitMap.put("MSG_PHONE", msgPhone);
		
		baseDao.update("bal_paybacklimit_dist_conf.upDistrictLimit",limitMap);
	}
	
	@SuppressWarnings("unchecked")
	public void sendMDistrictMsgWarning(Map<String,Object> inParam){
		/*发送区县月限额警告短信*/
		Map<String,Object> flagMap = new HashMap<String,Object>();
		flagMap = (Map<String,Object>)inParam.get("FLAG_MAP");
		String regionGroup = (String)flagMap.get("REGION_GROUP");
		String districtGroup  = (String)flagMap.get("DISTRICT_GROUP");
		String msgPhone = (String)flagMap.get("MSG_PHONE");
		
		/*获取地市区县名称*/
		String regionName = (String)group.getCurrentGroupInfo(regionGroup, "230000").get("GROUP_NAME");
		String districtName = (String)group.getCurrentGroupInfo(districtGroup, "230000").get("GROUP_NAME");
		
		/*您好：${region_name}地市，${group_name}区县当前的退费日限额已经使用80%，请立即关注，以免影响正常使用。【中国移动】${sms_release}*/
		Map<String, Object> outMapTmp = new HashMap<String, Object>();
		outMapTmp.put("region_name", regionName);
		outMapTmp.put("district_name",districtName);
		outMapTmp.put("sms_release", "");
		
		MBean outMessage = new MBean();
		outMessage.addBody("PHONE_NO", msgPhone);
		outMessage.addBody("OP_CODE", "8008");
		outMessage.addBody("CHECK_FLAG", true);
		outMessage.addBody("TEMPLATE_ID", "311200800801");
		outMessage.addBody("DATA", outMapTmp);
		log.info("发送短信内容：" + outMessage.toString());
		shortMessage.sendSmsMsg(outMessage);
		
		baseDao.update("bal_paybacklimit_dist_conf.upCMonthF",flagMap);
	}
	
	@SuppressWarnings("unchecked")
	public void sendDDistrictMsgWarning(Map<String,Object> inParam){
		/*发送区县日限额警告短信*/
		Map<String,Object> flagMap = new HashMap<String,Object>();
		flagMap = (Map<String,Object>)inParam.get("FLAG_MAP");
		String regionGroup = (String)flagMap.get("REGION_GROUP");
		String districtGroup  = (String)flagMap.get("DISTRICT_GROUP");
		String msgPhone = (String)flagMap.get("MSG_PHONE");
		
		/*获取地市区县名称*/
		String regionName = (String)group.getCurrentGroupInfo(regionGroup, "230000").get("GROUP_NAME");
		String districtName = (String)group.getCurrentGroupInfo(districtGroup, "230000").get("GROUP_NAME");
		
		/*您好：${region_name}地市，${group_name}区县当前的退费日限额已经使用80%，请立即关注，以免影响正常使用。【中国移动】${sms_release}*/
		Map<String, Object> outMapTmp = new HashMap<String, Object>();
		outMapTmp.put("region_name", regionName);
		outMapTmp.put("district_name",districtName);
		outMapTmp.put("sms_release", "");
		
		MBean outMessage = new MBean();
		outMessage.addBody("PHONE_NO", msgPhone);
		outMessage.addBody("OP_CODE", "8008");
		outMessage.addBody("CHECK_FLAG", true);
		outMessage.addBody("TEMPLATE_ID", "311200800802");
		outMessage.addBody("DATA", outMapTmp);
		log.info("发送短信内容：" + outMessage.toString());
		shortMessage.sendSmsMsg(outMessage);
		
		baseDao.update("bal_paybacklimit_dist_conf.upCDayF",flagMap);
		
	}

	/**
	 * @return the group
	 */
	public IGroup getGroup() {
		return group;
	}

	/**
	 * @param group the group to set
	 */
	public void setGroup(IGroup group) {
		this.group = group;
	}

	/**
	 * @return the shortMessage
	 */
	public IShortMessage getShortMessage() {
		return shortMessage;
	}

	/**
	 * @param shortMessage the shortMessage to set
	 */
	public void setShortMessage(IShortMessage shortMessage) {
		this.shortMessage = shortMessage;
	}
	
}
