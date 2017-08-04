package com.sitech.acctmgr.atom.impl.bill;

import com.sitech.acctmgr.atom.domains.bill.*;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.bill.SPhoneBillOpenQueryInDTO;
import com.sitech.acctmgr.atom.dto.bill.SPhoneBillOpenQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBillDisplayer;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.bill.IPhoneBillOpen;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wangyla on 2017/6/5.
 */
@ParamTypes({
        @ParamType(c = SPhoneBillOpenQueryInDTO.class, m = "query", oc = SPhoneBillOpenQueryOutDTO.class, srvName = "com_sitech_acctmgr_inter_bill_IPhoneBillOpenSvc_query")
})
public class SPhoneBillOpen extends AcctMgrBaseService implements IPhoneBillOpen {
    private IUser user;
    private IBillDisplayer billDisplayer;

    @Override
    public OutDTO query(InDTO inParam) {
        SPhoneBillOpenQueryInDTO inDto = (SPhoneBillOpenQueryInDTO) inParam;
        SPhoneBillOpenQueryOutDTO outDto = new SPhoneBillOpenQueryOutDTO();



        log.debug("inDto=" + inDto.getMbean());

        String phoneNo = inDto.getPhoneNo();
        int begYm = inDto.getBeginMonth();
        int endYm = inDto.getEndMonth();

        String retCode = "0000";
        String retMsg = "成功";
        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, false);
        if (userInfo == null) {
            retCode = "4005";
            retMsg = "使用用户手机号码非法（不存在）";

            outDto.setRetCode(retCode);
            outDto.setRetMsg(retMsg);

            return outDto;
        }

        long idNo = userInfo.getIdNo();
        long contractNo = userInfo.getContractNo();

        long totalShould = 0;
        long totalFavour = 0;
        long totalReal = 0;
        List<BillDisp13LevelEntity> sevenBillList = null; //原10大类一级帐目列表
        List<BillDisp13LevelEntity> newSevenBillList = null; //分类汇总成7类后的列表
        List<PhoneBillOpenEntity> billList = new ArrayList<>(); //用户月帐单列表
        List<BillOpenLv1Entity> bill1List = null; //一级帐目列表
        List<BillOpenLv3Entity> bill3List = null; //三级帐目列表

        for (int ym = begYm; ym <= endYm; ym = DateUtils.addMonth(ym, 1)) {
            PhoneBillOpenEntity billOpenEnt = new PhoneBillOpenEntity();
            billOpenEnt.setYearMonth(ym);
            billOpenEnt.setBillMonth(String.format("%02d", ym % 100));

            //获取用户指定账期的10大类费用信息
            sevenBillList = billDisplayer.getBill13sLevelList(idNo, contractNo, ym);

            newSevenBillList = this.getNewSevenBill(sevenBillList); /*newSevenBillList.size() 必须等于 7*/

            totalShould = 0;
            totalFavour = 0;
            totalReal = 0;
            bill1List = new ArrayList<>();
            BillOpenLv1Entity billOpen1Ent = null; /*月一级帐目费用信息*/
            for (BillDisp13LevelEntity bill7Ent : newSevenBillList) {
                String parentItemid = bill7Ent.getItemId();

                totalShould += bill7Ent.getShouldPay();
                totalFavour += bill7Ent.getFavourFee();
                totalReal += bill7Ent.getRealFee();

                billOpen1Ent = new BillOpenLv1Entity();
                billOpen1Ent.setLv1ItemId(parentItemid); //合并后的七大类对应的规范代码，两位 01~06，09
                billOpen1Ent.setLongRealFee(bill7Ent.getRealFee());
                billOpen1Ent.setRealFee(String.format("%.2f", bill7Ent.getRealFee() / 100.0));

                List<BillDisp3LevelEntity> bill73List = bill7Ent.getDetailList();
                if (bill73List != null && bill73List.size() > 0) {
                    bill3List = new ArrayList<>();
                    BillOpenLv3Entity billOpen3Ent = null;
                    for (BillDisp3LevelEntity bill73Ent : bill7Ent.getDetailList()) {

                        billOpen3Ent = new BillOpenLv3Entity();
                        billOpen3Ent.setLv3ItemId(bill73Ent.getShowCode());
                        billOpen3Ent.setLv3ItemName(bill73Ent.getShowName());
                        billOpen3Ent.setLongRealFee(bill73Ent.getRealFee());
                        billOpen3Ent.setRealFee(String.format("%.2f", bill73Ent.getRealFee() / 100.0));

                        bill3List.add(billOpen3Ent);

                    } //:: 原三级帐目项

                    billOpen1Ent.setBillList(bill3List);
                }

                bill1List.add(billOpen1Ent);
            } //:: 原一级帐目项大类

            billOpenEnt.setTotalShould(totalShould);
            billOpenEnt.setTotalFavour(totalFavour);
            billOpenEnt.setTotalReal(totalReal);
            billOpenEnt.setBillFee(String.format("%.2f", totalReal / 100.0));
            billOpenEnt.setBillList(bill1List);

            billOpenEnt.setBillBegin(ym * 100 + 1);
            billOpenEnt.setBillEnd(ym * 100 + DateUtils.getLastDayOfMonth(ym));

            billList.add(billOpenEnt);

        } //:: 用户月帐单


        //拼接出参
        outDto.setRetCode(retCode);
        outDto.setRetMsg(retMsg);
        outDto.setQueryTime(DateUtils.getCurDate(DateUtils.DATE_FORMAT_YYYYMMDDHHMISS));
        outDto.setBillList(billList);

        log.debug("outDto=" + outDto.toJson());
        return outDto;
    }

    private List<BillDisp13LevelEntity> getNewSevenBill(List<BillDisp13LevelEntity> sevenBillList) {

        BillDisp13LevelEntity[] billArray = new BillDisp13LevelEntity[7];
        for (BillDisp13LevelEntity bill7Ent : sevenBillList) {
            String parentItemid = bill7Ent.getItemId();
            int pid = Integer.parseInt(parentItemid);

            /**
             * 总的账单，分7大类展示
             * 01 套餐及固定费 (1)
             * 02 语音通信费 (2)
             * 03 上网费 (4)
             * 04 短信/彩信费用 (5)
             * 05 增值业务费  (6 + 7)
             * 06 代收费 (9)
             * 09 其他 (3 + 8 + 10)
             */
            BillDisp13LevelEntity billInfo = new BillDisp13LevelEntity();
            switch (pid) {
                case 1:
                    billInfo.setItemId("01");
                    billInfo.setItemName("套餐及固定费用");
                    billInfo.setRealFee(bill7Ent.getRealFee());
                    billInfo.setShouldPay(bill7Ent.getShouldPay());
                    billInfo.setFavourFee(bill7Ent.getFavourFee());
                    billInfo.setDetailList(bill7Ent.getDetailList());
                    billArray[0] = billInfo;
                    break;
                case 2:
                    billInfo.setItemId("02");
                    billInfo.setItemName("语音通信费");
                    billInfo.setRealFee(bill7Ent.getRealFee());
                    billInfo.setShouldPay(bill7Ent.getShouldPay());
                    billInfo.setFavourFee(bill7Ent.getFavourFee());
                    billInfo.setDetailList(bill7Ent.getDetailList());
                    billArray[1] = billInfo;
                    break;
                case 4:
                    billInfo.setItemId("03");
                    billInfo.setItemName("上网费");
                    billInfo.setRealFee(bill7Ent.getRealFee());
                    billInfo.setShouldPay(bill7Ent.getShouldPay());
                    billInfo.setFavourFee(bill7Ent.getFavourFee());
                    billInfo.setDetailList(bill7Ent.getDetailList());
                    billArray[2] = billInfo;
                    break;
                case 5:
                    billInfo.setItemId("04");
                    billInfo.setItemName("短彩信");
                    billInfo.setRealFee(bill7Ent.getRealFee());
                    billInfo.setShouldPay(bill7Ent.getShouldPay());
                    billInfo.setFavourFee(bill7Ent.getFavourFee());
                    billInfo.setDetailList(bill7Ent.getDetailList());
                    billArray[3] = billInfo;
                    break;
                case 6: //6 + 7 合并到 05
                case 7:
                    if (billArray[4] == null) {
                        billInfo.setItemId("05");
                        billInfo.setItemName("增值业务费");
                        billInfo.setRealFee(bill7Ent.getRealFee());
                        billInfo.setShouldPay(bill7Ent.getShouldPay());
                        billInfo.setFavourFee(bill7Ent.getFavourFee());
                        billInfo.setDetailList(bill7Ent.getDetailList());
                        billArray[4] = billInfo;
                    } else {
                        billArray[4].setRealFee(bill7Ent.getRealFee() + billArray[4].getRealFee());
                        billArray[4].setShouldPay(bill7Ent.getShouldPay() + billArray[4].getShouldPay());
                        billArray[4].setFavourFee(bill7Ent.getFavourFee() + billArray[4].getFavourFee());
                        billArray[4].getDetailList().addAll(bill7Ent.getDetailList());
                    }
                    break;
                case 9:
                    billInfo.setItemId("06");
                    billInfo.setItemName("代收费");
                    billInfo.setRealFee(bill7Ent.getRealFee());
                    billInfo.setShouldPay(bill7Ent.getShouldPay());
                    billInfo.setFavourFee(bill7Ent.getFavourFee());
                    billInfo.setDetailList(bill7Ent.getDetailList());
                    billArray[5] = billInfo;
                    break;
                case 3: // 3 + 8+ 10 合并到其他 09
                case 8:
                case 10:
                    if (billArray[6] == null) {
                        billInfo.setItemId("09");
                        billInfo.setItemName("其他费用");
                        billInfo.setRealFee(bill7Ent.getRealFee());
                        billInfo.setShouldPay(bill7Ent.getShouldPay());
                        billInfo.setFavourFee(bill7Ent.getFavourFee());
                        billInfo.setDetailList(bill7Ent.getDetailList());
                        billArray[6] = billInfo;
                    } else {
                        billArray[6].setRealFee(bill7Ent.getRealFee() + billArray[6].getRealFee());
                        billArray[6].setShouldPay(bill7Ent.getShouldPay() + billArray[6].getShouldPay());
                        billArray[6].setFavourFee(bill7Ent.getFavourFee() + billArray[6].getFavourFee());
                        billArray[6].getDetailList().addAll(bill7Ent.getDetailList());
                    }
                    break;
                default:
                    break;
            }//::switch case end

        } //:: for end

        List<BillDisp13LevelEntity> billList = new ArrayList<>();

        //按七大类返回列表，并且处理费用为0的一级帐目项
        for (int i = 0; i < 7; i++) {
            BillDisp13LevelEntity billInfo = billArray[i];
            if (billInfo == null) {
                billInfo = new BillDisp13LevelEntity();
                if (i == 6) {
                    billInfo.setItemId("09");
                } else {
                    billInfo.setItemId(String.format("%02d", i + 1 ));
                }
                switch (i){
                    case 0:
                        billInfo.setItemName("套餐及固定费用");
                        break;
                    case 1:
                        billInfo.setItemName("语音通信费");
                        break;
                    case 2:
                        billInfo.setItemName("上网费");
                        break;
                    case 3:
                        billInfo.setItemName("短彩信");
                        break;
                    case 4:
                        billInfo.setItemName("增值业务费");
                        break;
                    case 5:
                        billInfo.setItemName("代收费");
                        break;
                    default:
                        break;
                }
                billInfo.setRealFee(0);
            }

            billList.add(billInfo);
        } //:: end

        return billList;
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

    public IBillDisplayer getBillDisplayer() {
        return billDisplayer;
    }

    public void setBillDisplayer(IBillDisplayer billDisplayer) {
        this.billDisplayer = billDisplayer;
    }
}
