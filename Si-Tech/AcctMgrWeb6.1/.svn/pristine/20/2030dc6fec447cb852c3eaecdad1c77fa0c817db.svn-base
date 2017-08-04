package com.sitech.acctmgr.atom.impl.billAccount;

import com.sitech.acctmgr.atom.domains.base.ChngroupRelEntity;
import com.sitech.acctmgr.atom.domains.prod.UserPdPrcDetailInfoEntity;
import com.sitech.acctmgr.atom.domains.query.PrcIdTransEntity;
import com.sitech.acctmgr.atom.domains.query.packetFeeEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.query.SPacketFeeInitInDTO;
import com.sitech.acctmgr.atom.dto.query.SPacketFeeInitOutDTO;
import com.sitech.acctmgr.atom.entity.inter.*;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.billAccount.IPacketFeeQry;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@ParamTypes({
        @ParamType(m = "query", c = SPacketFeeInitInDTO.class, oc = SPacketFeeInitOutDTO.class)
})
public class SPacketFeeQry extends AcctMgrBaseService implements IPacketFeeQry {

    private IUser user;
    private IGoods goods;
    private IBillAccount billAccount;
    private IGroup group;
    private IBill bill;

    @Override
    public OutDTO query(InDTO inParam) {

        List<packetFeeEntity> resultList = new ArrayList<packetFeeEntity>();
        SPacketFeeInitInDTO inDto = (SPacketFeeInitInDTO) inParam;
        String phoneNo = inDto.getPhoneNo();

        int curYm = DateUtils.getCurYm();

        UserInfoEntity uie = user.getUserInfo(phoneNo);
        String groupId = uie.getGroupId();
        long idNo = uie.getIdNo();

        //取用户地市
        ChngroupRelEntity cgre = group.getRegionDistinct(groupId, "2", inDto.getProvinceId());
        String regionCode = cgre.getRegionCode();

        UserPdPrcDetailInfoEntity upe = goods.getPacketPrcInfo(idNo);
        String prcId = upe.getProdPrcid();
        String prcName = upe.getPrcName();
        String effDate = upe.getBeginTime();
        String expDate = upe.getEndTime();

        long sumFavoured = 0;
        int i = 0;
        List<PrcIdTransEntity> detailList = billAccount.getDetailCodeList(prcId, regionCode, "b");
        for (PrcIdTransEntity detailTemp : detailList) {
            String detailCode = detailTemp.getDetailCode();
            Map<String, Object> outMap = billAccount.getYearFavourFee(regionCode, detailCode);
            String codeName = outMap.get("CODE_NAME").toString().trim();
            long totalFav = Long.parseLong(outMap.get("FAVOUR1").toString());

            int beginYm = Integer.parseInt(effDate) / 100;
            int endYm = Integer.parseInt(expDate) / 100;
            while (beginYm <= endYm) {
                if (beginYm > curYm) {
                    break;
                }
                Map<String, Long> unPayMap = bill.getSumUnpayInfo(null, idNo, beginYm);
                long favourFee = Long.parseLong(unPayMap.get("SHOULD_PAY").toString());
                sumFavoured = sumFavoured + favourFee;
                beginYm = DateUtils.addMonth(beginYm, 1);
                i++;
            }

            if (sumFavoured - totalFav * 100 > -0.5) {
                sumFavoured = totalFav * 100;
            }

            packetFeeEntity pfe = new packetFeeEntity();
            pfe.setOrderCodeDesc("新包年");
            pfe.setCodeName(codeName);
            pfe.setTotalFav(totalFav * 100);
            pfe.setSumFavoured(sumFavoured);
            pfe.setRemainFavor(totalFav * 100 - sumFavoured);
            pfe.setUseMonths(i);
            pfe.setFavourBegin(effDate);
            pfe.setFavourEnd(expDate);
            resultList.add(pfe);
        }

        SPacketFeeInitOutDTO outDto = new SPacketFeeInitOutDTO();
        outDto.setModeName(prcName);
        outDto.setModeBegin(effDate);
        outDto.setModeEnd(expDate);
        outDto.setFavourYearList(resultList);
        return outDto;
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
     * @return the goods
     */
    public IGoods getGoods() {
        return goods;
    }

    /**
     * @param goods the goods to set
     */
    public void setGoods(IGoods goods) {
        this.goods = goods;
    }

    /**
     * @return the billAccount
     */
    public IBillAccount getBillAccount() {
        return billAccount;
    }

    /**
     * @param billAccount the billAccount to set
     */
    public void setBillAccount(IBillAccount billAccount) {
        this.billAccount = billAccount;
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
     * @return the bill
     */
    public IBill getBill() {
        return bill;
    }

    /**
     * @param bill the bill to set
     */
    public void setBill(IBill bill) {
        this.bill = bill;
    }

}
