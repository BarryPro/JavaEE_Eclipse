package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.atom.domains.collection.CollBillDetailEntity;
import com.sitech.acctmgr.atom.domains.collection.CollBillStatusGroupEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

public class S8225CalCollBillOutDTO extends CommonOutDTO {

    private static final long serialVersionUID = -1962465930402933600L;

    @ParamDesc(path = "DETAIL_LIST", cons = ConsType.CT001, type = "compx", len = "", desc = "托收单明细", memo = "略")
    private List<CollBillDetailEntity> detailList = new ArrayList<CollBillDetailEntity>();
    @ParamDesc(path = "GROUP_LIST", cons = ConsType.CT001, type = "compx", len = "", desc = "托收单分状态统计", memo = "略")
    private List<CollBillStatusGroupEntity> groupList = new ArrayList<CollBillStatusGroupEntity>();

    @ParamDesc(path = "SUM_PAY_NUM", cons = ConsType.CT001, type = "int", len = "", desc = "托收用户总数", memo = "略")
    private int sumPayNum = 0;
    @ParamDesc(path = "SUM_DETAIL_PAY_FEE", cons = ConsType.CT001, type = "long", len = "", desc = "托收费用总合", memo = "略")
    private long sumDetailPayFee = 0;
    @ParamDesc(path = "SUM_CON_NUM", cons = ConsType.CT001, type = "int", len = "", desc = "托收帐户总个数", memo = "略")
    private int sumConNum = 0;
    @ParamDesc(path = "SUM_GROUP_PAY_FEE", cons = ConsType.CT001, type = "long", len = "", desc = "托收费用总合", memo = "略")
    private long sumGroupPayFee = 0;

    @Override
    public MBean encode() {
        MBean result = new MBean();
        result.setRoot(getPathByProperName("detailList"), detailList);
        result.setRoot(getPathByProperName("groupList"), groupList);
        result.setRoot(getPathByProperName("sumPayNum"), sumPayNum);
        result.setRoot(getPathByProperName("sumDetailPayFee"), sumDetailPayFee);
        result.setRoot(getPathByProperName("sumConNum"), sumConNum);
        result.setRoot(getPathByProperName("sumGroupPayFee"), sumGroupPayFee);


        return result;
    }

    public List<CollBillDetailEntity> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<CollBillDetailEntity> detailList) {
        this.detailList = detailList;
    }

    public List<CollBillStatusGroupEntity> getGroupList() {
        return groupList;
    }

    public void setGroupList(List<CollBillStatusGroupEntity> groupList) {
        this.groupList = groupList;
    }

    public int getSumPayNum() {
        return sumPayNum;
    }

    public void setSumPayNum(int sumPayNum) {
        this.sumPayNum = sumPayNum;
    }

    public long getSumDetailPayFee() {
        return sumDetailPayFee;
    }

    public void setSumDetailPayFee(long sumDetailPayFee) {
        this.sumDetailPayFee = sumDetailPayFee;
    }

    public int getSumConNum() {
        return sumConNum;
    }

    public void setSumConNum(int sumConNum) {
        this.sumConNum = sumConNum;
    }

    public long getSumGroupPayFee() {
        return sumGroupPayFee;
    }

    public void setSumGroupPayFee(long sumGroupPayFee) {
        this.sumGroupPayFee = sumGroupPayFee;
    }
}
