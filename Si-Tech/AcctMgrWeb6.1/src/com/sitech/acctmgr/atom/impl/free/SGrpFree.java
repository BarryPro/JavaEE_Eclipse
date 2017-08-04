package com.sitech.acctmgr.atom.impl.free;

import com.sitech.acctmgr.atom.domains.account.ContractInfoEntity;
import com.sitech.acctmgr.atom.domains.cust.CustInfoEntity;
import com.sitech.acctmgr.atom.domains.query.FreeMinBill;
import com.sitech.acctmgr.atom.domains.record.ActQueryOprEntity;
import com.sitech.acctmgr.atom.domains.user.UserGroupMbrEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.domains.user.UserPrcEntity;
import com.sitech.acctmgr.atom.domains.user.UsersvcAttrEntity;
import com.sitech.acctmgr.atom.dto.free.SGrpFreeIndivQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.SGrpFreeIndivQueryOutDTO;
import com.sitech.acctmgr.atom.dto.free.SGrpFreeShareQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.SGrpFreeShareQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.*;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.free.IGrpFree;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.service.client.ServiceUtil;

import java.util.List;

/**
 * Created by wangyla on 2016/12/15.
 */
@ParamTypes({
        @ParamType(c = SGrpFreeShareQueryInDTO.class, m = "shareQuery", oc = SGrpFreeShareQueryOutDTO.class),
        @ParamType(c = SGrpFreeIndivQueryInDTO.class, m = "indivQuery", oc = SGrpFreeIndivQueryOutDTO.class)
})
public class SGrpFree extends AcctMgrBaseService implements IGrpFree {

    private IFreeDisplayer freeDisplayer;
    private IUser user;
    private IAccount account;
    private ICust cust;
    private IProd prod;
    private IRecord record;

    @Override
    public OutDTO shareQuery(InDTO inParam) {
        SGrpFreeShareQueryInDTO inDto = (SGrpFreeShareQueryInDTO) inParam;
        log.debug("inDto=" + inDto.getMbean());

        int queryYm = inDto.getYearMonth();
        String phoneNo = inDto.getPhoneNo();
        int curYm = DateUtils.getCurYm();
        int lastYm = DateUtils.addMonth(curYm, -2);

        /*限制只可查询近三个月数据（含当月）*/
        if (queryYm < lastYm || queryYm > curYm) {
            throw new BusiException(AcctMgrError.getErrorCode("8114", "20001"), "仅能查本月和前两月信息!");
        }


        UserInfoEntity grpUserInfo = user.getUserEntityByPhoneNo(phoneNo, true);
        long grpCon = grpUserInfo.getContractNo();
        long grpId = grpUserInfo.getIdNo();
        long grpCustId = grpUserInfo.getCustId();

        CustInfoEntity grpCustInfo = cust.getCustInfo(grpCustId, null);
        String custName = grpCustInfo.getCustName();

        ContractInfoEntity grpConInfo = account.getConInfo(grpCon, "1"); //集团帐户信息
        String conName = grpConInfo.getContractName(); //集团产品名称

        List<FreeMinBill> shareList = freeDisplayer.getFreeDetailList(phoneNo, queryYm, "Z", "0");

        long outTotal = 0;
        long gprsTotal = 0;
        long gprsUsed = 0;
        for (FreeMinBill fmb : shareList) {
            String busiCode = fmb.getBusiCode();
            String favType = fmb.getFavType();
            if (busiCode.equals("Z")) {
                if (favType.equals("0001")) { //套餐外流量
                    outTotal += fmb.getLongUsed();
                } else {
                    if (curYm == queryYm) {
                        gprsTotal += fmb.getLongTotal();
                        gprsUsed += fmb.getLongUsed();
                    } else {
                        gprsTotal += fmb.getLongUsed();
                    }

                }

            }
        }

        ActQueryOprEntity oprEntity = new ActQueryOprEntity();
        oprEntity.setQueryType("jt");
        oprEntity.setOpCode(inDto.getOpCode());
        oprEntity.setContactId(String.format("%d", grpCon));
        oprEntity.setIdNo(grpId);
        oprEntity.setPhoneNo(phoneNo);
        oprEntity.setBrandId("");
        oprEntity.setLoginNo(inDto.getLoginNo());
        oprEntity.setLoginGroup(inDto.getGroupId());
        oprEntity.setProvinceId(inDto.getProvinceId());
        oprEntity.setRemark("集团共享流量查询（集团）");
        record.saveQueryOpr(oprEntity, false);

        SGrpFreeShareQueryOutDTO outDto = new SGrpFreeShareQueryOutDTO();
        outDto.setContractName(conName);
        outDto.setGrpPhoneNo(phoneNo);
        outDto.setCustName(custName);
        outDto.setOutTotal(String.format("%d", outTotal));
        outDto.setGprsTotal(String.format("%d", gprsTotal));
        outDto.setGprsUsed(String.format("%d", gprsUsed));
        outDto.setUnitName("KB");

        log.debug("outDto=" + outDto.toJson());
        return outDto;
    }

    @Override
    public OutDTO indivQuery(InDTO inParam) {
        SGrpFreeIndivQueryInDTO inDto = (SGrpFreeIndivQueryInDTO) inParam;
        log.debug("inDto=" + inDto.getMbean());

        int queryYm = inDto.getYearMonth();
        String phoneNo = inDto.getPhoneNo();
        int curYm = DateUtils.getCurYm();
        int lastYm = DateUtils.addMonth(curYm, -2);

        /*限制只可查询近三个月数据（含当月）*/
        if (queryYm < lastYm || queryYm > curYm) {
            throw new BusiException(AcctMgrError.getErrorCode("8114", "20001"), "仅能查本月和前两月信息!");
        }

        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
        long idNo = userInfo.getIdNo();

        List<UserGroupMbrEntity> userGroupList = user.getUserGroupList(idNo);
        if (userGroupList == null || userGroupList.isEmpty()) {
            throw new BusiException(AcctMgrError.getErrorCode("8114", "20002"), "用户未办理集团共享业务，请到8123进行个人流量查询！");
        }

        String grpPhoneNo = ""; /*集团虚拟服务号码*/
        String grpCustName = ""; /*集团客户名称*/
        String grpPrcName = ""; /*集团主订价资费名称*/
        String grpConName = ""; /*集团产品名称*/
        boolean hasShareFlag = false; //用户拥有集团共享
        for (UserGroupMbrEntity userGroupEnt : userGroupList) {
            long grpUserId = userGroupEnt.getGroupIdNo(); //集团的归属ID

            //判定此集团为用户共享的集团，CRMPD确认集团共享的属性attr_id为'23B362','23B422','23B347','23B285'
            /**
             * 23B285 个性化行业应用(104)
             * 23B347 M2M(105)
             * 23B362 执法通(203)、车辆定位(205)、视频监控(204)
             * 23B422 虚拟呼叫中心(214)
             */
            String attrIds = "23B362,23B422,23B347,23B285";
            UsersvcAttrEntity svcAttrInfo = user.getUsersvcAttr(grpUserId, attrIds);
            if (svcAttrInfo != null) {
                UserInfoEntity grpUserInfo = user.getUserEntityByIdNo(grpUserId, false);
                if (grpUserInfo == null) {
                    continue;
                }

                grpPhoneNo = grpUserInfo.getPhoneNo();
                long grpIdNo = grpUserInfo.getIdNo();
                long grpConNo = grpUserInfo.getContractNo();
                long grpCustId = grpUserInfo.getCustId();
                grpCustName = cust.getCustInfo(grpCustId, null).getCustName();

                UserPrcEntity grpPrcInfo = prod.getUserPrcidInfo(grpIdNo);
                grpPrcName = grpPrcInfo.getProdPrcName();

                ContractInfoEntity grpConInfo = account.getConInfo(grpConNo, "1"); //集团帐户信息
                grpConName = grpConInfo.getContractName(); //集团产品名称

                hasShareFlag = true;

                /*黑龙江业务：用户不可在多个集团下共享流量*/
                break;
            }

        }

        if (!hasShareFlag) {
            throw new BusiException(AcctMgrError.getErrorCode("8114", "20002"), "用户未办理集团共享业务，请到8123进行个人流量查询！");
        }

        /*调用普通用户GPRS流量查询*/
        MBean mbean = inDto.getMbean();
        log.debug("mbean=" + mbean);
        long t1 = System.currentTimeMillis();
        String markJson = ServiceUtil.callService("com_sitech_acctmgr_inter_free_IFreeSvc_gprsQuery", mbean);
        long t2 = System.currentTimeMillis();
        log.debug("调用流量查询服务时长：" + (t2 - t1) + " ms , markJson=" + markJson);

        MBean resultBean = new MBean(markJson);
        String returnCode = resultBean.getBodyStr("RETURN_CODE");
        String returnMsg = resultBean.getBodyStr("RETURN_MSG");
        if (!returnCode.equals("0")) {
            throw new BusiException(AcctMgrError.getErrorCode("8114", "20003"), returnMsg);
        }
        String gprsTotal = resultBean.getBodyStr("OUT_DATA.GRP_SHARED_GPRS_TOTAL"); //集团共享总量
        String gprsUsed = resultBean.getBodyStr("OUT_DATA.GRP_SHARED_GPRS_USED"); //集团共享总使用量
        String unityUsed = resultBean.getBodyStr("OUT_DATA.GRP_SHARED_UNITY_USED"); //集团共享个人总使用量
        String unitName = resultBean.getBodyStr("OUT_DATA.UNIT_NAME"); //流量计量单位

        ActQueryOprEntity oprEntity = new ActQueryOprEntity();
        oprEntity.setQueryType("jt");
        oprEntity.setOpCode(inDto.getOpCode());
        oprEntity.setContactId(String.format("%d", userInfo.getContractNo()));
        oprEntity.setIdNo(idNo);
        oprEntity.setPhoneNo(phoneNo);
        oprEntity.setBrandId("");
        oprEntity.setLoginNo(inDto.getLoginNo());
        oprEntity.setLoginGroup(inDto.getGroupId());
        oprEntity.setProvinceId(inDto.getProvinceId());
        oprEntity.setRemark("集团共享流量查询（个人）");
        record.saveQueryOpr(oprEntity, false);

        SGrpFreeIndivQueryOutDTO outDto = new SGrpFreeIndivQueryOutDTO();
        outDto.setContractName(grpConName);
        outDto.setGrpPhoneNo(grpPhoneNo);
        outDto.setCustName(grpCustName);
        outDto.setPrcName(grpPrcName);
        outDto.setGprsUsed(gprsUsed);
        outDto.setGprsTotal(gprsTotal);
        outDto.setUnityGprsUsed(unityUsed);
        outDto.setUnitName(unitName);

        return outDto;
    }

    public IFreeDisplayer getFreeDisplayer() {
        return freeDisplayer;
    }

    public void setFreeDisplayer(IFreeDisplayer freeDisplayer) {
        this.freeDisplayer = freeDisplayer;
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

    public IAccount getAccount() {
        return account;
    }

    public void setAccount(IAccount account) {
        this.account = account;
    }

    public ICust getCust() {
        return cust;
    }

    public void setCust(ICust cust) {
        this.cust = cust;
    }

    public IProd getProd() {
        return prod;
    }

    public void setProd(IProd prod) {
        this.prod = prod;
    }

    public IRecord getRecord() {
        return record;
    }

    public void setRecord(IRecord record) {
        this.record = record;
    }
}
