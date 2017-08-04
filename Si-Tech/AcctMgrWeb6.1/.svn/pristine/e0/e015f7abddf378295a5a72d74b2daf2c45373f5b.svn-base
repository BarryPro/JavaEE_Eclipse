package com.sitech.acctmgr.atom.impl.feeqry;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.query.EchgCardRdInfoEntity;
import com.sitech.acctmgr.atom.domains.query.EchgCardRecdEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.feeqry.SEchargeCardInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SEchargeCardOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.inter.feeqry.IEchargeCard;
import com.sitech.common.CrossEntity;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.service.client.ServiceUtil;
import org.apache.commons.collections.MapUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@ParamTypes({@ParamType(m = "query", c = SEchargeCardInDTO.class, oc = SEchargeCardOutDTO.class)
})
public class SEchargeCard extends AcctMgrBaseService implements IEchargeCard {

    private IUser user;
    private IGroup group;

    @Override
    public OutDTO query(InDTO dto) {

        String phoneNo = "";
        String belongName = "";
        List<EchgCardRdInfoEntity> outList = new ArrayList<EchgCardRdInfoEntity>();
        EchgCardRdInfoEntity cardRdInfoEntity = null;
        Map<String, Object> inMap = null;
        //S1: get the in params
        SEchargeCardInDTO inDto = (SEchargeCardInDTO) dto;
        log.info("入参：" + inDto.getMbean());

        phoneNo = inDto.getPhoneNo();

        //只允许查询一个月内的
        if (!checkQryDate(inDto.getBeginTime(), inDto.getEndTime())) {
            log.error("只允许查询一个月的记录!");
            throw new BusiException(AcctMgrError.getErrorCode("0000", "12001"), "只允许查询30天内的记录");
        }

        //查询用户地市
        UserInfoEntity uie = user.getUserInfo(phoneNo);
        String groupId = uie.getGroupId();

        ChngroupRelEntity cgre = group.getRegionDistinct(groupId, "2", inDto.getProvinceId());
        belongName = "黑龙江" + cgre.getRegionName();
        String regionCode = cgre.getRegionCode();

        //S3: get the charged records
        inMap = new HashMap<String, Object>();
        MapUtils.safeAddToMap(inMap, "PHONE_NO", phoneNo);
        MapUtils.safeAddToMap(inMap, "TRADE_BEGIN_TIME", inDto.getBeginTime()); //yyyy-mm-dd
        MapUtils.safeAddToMap(inMap, "TRADE_END_TIME", inDto.getEndTime());
        List<EchgCardRecdEntity> recdList = getChargeRecds(inMap);
        for (EchgCardRecdEntity echgCardRecdEntity : recdList) {
            // EchgCardInfoEntity
            cardRdInfoEntity = new EchgCardRdInfoEntity();

            cardRdInfoEntity.setCardNo(echgCardRecdEntity.getCardNo());
            cardRdInfoEntity.setCardState("已充值");
            cardRdInfoEntity.setChargeAmount(echgCardRecdEntity.getChargeAmount());
            cardRdInfoEntity.setPhoneNo(echgCardRecdEntity.getPhoneNo());
            cardRdInfoEntity.setTradeTime(echgCardRecdEntity.getTradeTime());
            //cardRdInfoEntity.setValidTime(cardInfoEntity.getCntStop());

            //调用资源接口，获取失效时间
            String interName = "com_sitech_res_inter_outinter_ISQryValueCardInfoSvc_queryCardInfo";
            // 入参报文
            MBean mbean = new MBean();
            mbean.setHeader(inDto.getHeader());
            mbean.setBody("BUSI_INFO.REGION_CODE", regionCode);
            mbean.setBody("BUSI_INFO.LOGIN_NO", inDto.getLoginNo());
            mbean.setBody("BUSI_INFO.RES_KIND", "Y001");
            mbean.setBody("BUSI_INFO.QUERY_TYPE", "0");
            mbean.setBody("BUSI_INFO.GROUP_ID", inDto.getGroupId());
            List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
            Map<String, Object> inMapTemp = new HashMap<String, Object>();
            inMapTemp.put("BEGIN_CARD_NO", echgCardRecdEntity.getCardNo());
            inMapTemp.put("END_CARD_NO", echgCardRecdEntity.getCardNo());
            mapList.add(inMapTemp);
            mbean.setBody("BUSI_INFO.CARD_INFOS", mapList);

            String outString = ServiceUtil.callService(interName, mbean);
            log.debug("有价卡信息出参 outString=" + outString);
            MBean outBean = new MBean(outString);
            List<Map<String, Object>> cardList = (List<Map<String, Object>>) outBean.getBodyList("OUT_DATA.CARD_INFOS");

            String validTime = "";
            if (cardList != null && cardList.size() > 0) {
                validTime = cardList.get(0).get("EXPIRE_TIME").toString();
            }
            cardRdInfoEntity.setValidTime(validTime); //yyyy-MM-dd HH:mm:ss

            outList.add(cardRdInfoEntity);
        }

        SEchargeCardOutDTO outDto = new SEchargeCardOutDTO();
        outDto.setOutList(outList);
        outDto.setPhoneNo(phoneNo);
        outDto.setBelongName(belongName);
        outDto.setPayChannel("09");
        outDto.setSumType("01");
        outDto.setRemark("无");

        log.info("出参:" + outDto.toJson());
        //S4: return the out params
        return outDto;
    }

    public List<EchgCardRecdEntity> getChargeRecds(Map<String, Object> inParam) {
        // EAI_EchgCard_Recd
        List<EchgCardRecdEntity> outList = new ArrayList<EchgCardRecdEntity>();
        EchgCardRecdEntity cardRecdEntity = null;

        log.debug("getChargeRecds inparams=" + inParam.toString());
        //wangylatest 3221 vNewaddress:ADDRESS=//10.163.106.18:29999//10.163.106.18:29999,vAppid:700004,vPriority:10,vTranscode:1
        //vInMsg=3221|18844079878|2015-05-01|2015-05-01
        MBean inBean = new MBean();
        inBean.setBody("MSISDN", inParam.get("PHONE_NO").toString()); //18844079878
        inBean.setBody("TRADETIMEBEGIN", inParam.get("TRADE_BEGIN_TIME").toString());
        inBean.setBody("TRADETIMEEND", inParam.get("TRADE_END_TIME").toString());

        log.debug("获取充值记录入参：inBean=" + inBean.toString());

        Map<String, String> result = CrossEntity.callService("EAI_EchgCard_Recd", inBean);
        //现返回结果（不准）：{FAULTTIMES=10, RETN=0, CHARGETIME=5, DESC="操作成功", FAILLIST=, ACCOUNTSTATE=0, CARDTOTAL=20, SUCCESSNUM=20, FAILNUM=0}
        /*[RETN=0,DESC="查询成功",TOTAL=1,ATTR=SEQUENCE&ACCOUNTPIN&CHRGMSISDN&COUNTTOTAL&TRADETIME&TRADETYPE,RESULT=15631221301568292|188440798
78|18844079878|5000|"2015-05-01 00:00:41"|9|; ]*/
        log.debug("EAI_EchgCard_Recd 平台返回：" + result.toString());

        int retCode = Integer.parseInt(result.get("RETN"));
        String desc = result.get("DESC");
        log.debug("retCode=[" + retCode + "]desc = [" + desc + "]");

        //接口返回失败!
        if (retCode != 0) {
            throw new BusiException(AcctMgrError.getErrorCode("0000", "12004"), "接口返回失败!");
        }

        String attrStr = result.get("ATTR");
//        String resultStr = result.get("RESULT").replace("\"", "").replace(";", "\r\n");
        String resultStr = result.get("RESULT").replace("\"", "");

		/* 属性的列数 */
        String[] attrArray = attrStr.split("&");
        int attrCount = attrArray.length;

        /* 解析每一条充值记录 */
        String[] resultArray = resultStr.split("\\;");

        for (int i = 0; i < resultArray.length; i++) {
            String line = resultArray[i];
            String[] recdArray = line.split("\\|");
            int recdColNo = recdArray.length;

            if (log.isDebugEnabled()) {
                log.debug("resultArray[" + i + "]=[" + line + "]");
                log.debug("attrCount=[" + attrCount + "] recdColNo=[" + recdColNo + "]");
            }
                /* 属性列需要和每条记录的列数相同 */
            if (attrCount != recdColNo) {
                log.error("接口返回内容不正确。属性名和属性值数量不匹配");
                continue;
            }

			    /* 解析每一列 */

            cardRecdEntity = new EchgCardRecdEntity();
            for (int j = 0; j < recdArray.length; j++) {
                String recdColStr = recdArray[j];
                String attrColStr = attrArray[j];
                if (attrColStr.equals("SEQUENCE")) {
                    cardRecdEntity.setCardNo(recdColStr);
                } else if (attrColStr.equals("ACCOUNTPIN")) {
                    cardRecdEntity.setAccountPin(recdColStr);
                } else if (attrColStr.equals("CHRGMSISDN")) {
                    cardRecdEntity.setPhoneNo(recdColStr);
                } else if (attrColStr.equals("COUNTTOTAL")) {
                    cardRecdEntity.setChargeAmount(Long.parseLong(recdColStr));
                } else if (attrColStr.equals("TRADETIME")) {
                    cardRecdEntity.setTradeTime(recdColStr);
                } else if (attrColStr.equals("TRADETYPE")) {
                    cardRecdEntity.setTradeType(recdColStr);
                    cardRecdEntity.setTradeTypeName(getTradeTypeName(recdColStr));
                } else {

                }
            }

            outList.add(cardRecdEntity);
        }

        return outList;
    }

    protected String getTradeTypeName(String tradeType) {

        String tradeTypeName = "";
        if (tradeType.equals("1")) {
            tradeTypeName = "智能网预付费用户本机充值";
        } else if (tradeType.equals("2")) {
            tradeTypeName = "智能网预付费用户他机充值";
        } else if (tradeType.equals("3")) {
            tradeTypeName = "智能预付费用户CRM渠道充值";
        } else if (tradeType.equals("4")) {
            tradeTypeName = "固定电话充值";
        } else if (tradeType.equals("5")) {
            tradeTypeName = "预留";
        } else if (tradeType.equals("6")) {
            tradeTypeName = "预充值";
        } else if (tradeType.equals("7")) {
            tradeTypeName = "BOSS用户CRM渠道充值";
        } else if (tradeType.equals("8")) {
            tradeTypeName = "银行卡充值";
        } else if (tradeType.equals("9")) {
            tradeTypeName = "BOSS用户语音充值";
        } else if (tradeType.equals("A")) {
            tradeTypeName = "PPIP电话充值";
        } else if (tradeType.equals("B")) {
            tradeTypeName = "PPIPCRM渠道充值";
        } else if (tradeType.equals("C")) {
            tradeTypeName = "IUSER品牌有价卡充值";
        } else if (tradeType.equals("E")) {
            tradeTypeName = "17951电话充值";
        } else if (tradeType.equals("F")) {
            tradeTypeName = "17951CRM渠道充值";
        } else if (tradeType.equals("S")) {
            tradeTypeName = "短信充值";
        } else if (tradeType.equals("d")) {
            tradeTypeName = "BOSS发MML命令直接置位有价卡";
        } else if (tradeType.equals("s")) {
            tradeTypeName = "BOSS网营充值";
        } else {
            tradeTypeName = "未知";
        }

        return tradeTypeName;
    }

    private Boolean checkQryDate(String bTime, String eTime) {
        Date dateBeg = null;
        Date dateEnd = null;
        try {
            dateBeg = new SimpleDateFormat("yyyy-MM-dd").parse(bTime);
            dateEnd = new SimpleDateFormat("yyyy-MM-dd").parse(eTime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        Calendar cldBeg = Calendar.getInstance();
        Calendar cldEnd = Calendar.getInstance();
        cldBeg.setTime(dateBeg);
        cldEnd.setTime(dateEnd);
        //int days = cldEnd.get(Calendar.DAY_OF_YEAR) - cldBeg.get(Calendar.DAY_OF_YEAR);
        int days = (int) ((cldEnd.getTimeInMillis() - cldBeg.getTimeInMillis()) / (1000 * 60 * 60 * 24));
        log.debug("begTime=[" + bTime + "] eTime=[" + eTime + "] days=[" + days + "]");

        if (days > 30) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * @return the user
     */
    public IUser getUser() {
        return user;
    }

    /**
     * @param user the user to set
     */
    public void setUser(IUser user) {
        this.user = user;
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
}
