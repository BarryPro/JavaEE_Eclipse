package com.sitech.acctmgr.atom.impl.free;

import com.sitech.acctmgr.atom.domains.free.TransFreeEntity;
import com.sitech.acctmgr.atom.domains.query.FreeMinBill;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.free.STransFreeQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.STransFreeQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IFreeDisplayer;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.UnitUtils;
import com.sitech.acctmgr.inter.free.ITransFree;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.apache.commons.collections.MapUtils.getLongValue;
import static org.apache.commons.collections.MapUtils.safeAddToMap;

/**
 * Created by wangyla on 2016/7/26.
 */
@ParamTypes({@ParamType(m = "query", c = STransFreeQueryInDTO.class, oc = STransFreeQueryOutDTO.class)})
public class STransFree extends AcctMgrBaseService implements ITransFree {
    private IUser user;
    private IFreeDisplayer freeDisplayer;

    @Override
    public OutDTO query(InDTO inParam) {
        STransFreeQueryInDTO inDTO = (STransFreeQueryInDTO) inParam;
        log.debug("inDto=" + inDTO.getMbean());

        String phoneNo = inDTO.getPhoneNo();
        int queryYM = inDTO.getYearMonth();

        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
        long idNo = userInfo.getIdNo();

        List<FreeMinBill> transFreeList = freeDisplayer.getFreeDetailList(phoneNo, queryYM, "X"); /*可转赠流量明细*/
        Map<String, Object> transMap = this.getTransMap(transFreeList);
        List<TransFreeEntity> nationFreeList = (List<TransFreeEntity>) transMap.get("NATION_FREE_INFO");
        List<TransFreeEntity> provFreeList = (List<TransFreeEntity>) transMap.get("PROV_FREE_INFO");

        long nationGprsTotal = getLongValue(transMap, "NATION_GPRS_TOTAL");
        long nationGprsUsed = getLongValue(transMap, "NATION_GPRS_USED");
        long nationGprsRemain = getLongValue(transMap, "NATION_GPRS_REMAIN");
        long provGprsTotal = getLongValue(transMap, "PROV_GPRS_TOTAL");
        long provGprsUsed = getLongValue(transMap, "PROV_GPRS_USED");
        long provGprsRemain = getLongValue(transMap, "PROV_GPRS_REMAIN");

        List<FreeMinBill> gprsFreeList = freeDisplayer.getFreeDetailList(phoneNo, queryYM, "3"); /*gprs流量明细*/
        List<TransFreeEntity> freeList = this.getGprsListByPrcId(gprsFreeList, UnitUtils.GPRS_UNIT_MB);

        STransFreeQueryOutDTO outDTO = new STransFreeQueryOutDTO();
        outDTO.setNationGprsTotal(UnitUtils.trans(nationGprsTotal, UnitUtils.GPRS_UNIT_MB));
        outDTO.setNationGprsUsed(UnitUtils.trans(nationGprsUsed, UnitUtils.GPRS_UNIT_MB));
        outDTO.setNationGprsRemain(UnitUtils.trans(nationGprsRemain, UnitUtils.GPRS_UNIT_MB));
        outDTO.setProvGprsTotal(UnitUtils.trans(provGprsTotal, UnitUtils.GPRS_UNIT_MB));
        outDTO.setProvGprsUsed(UnitUtils.trans(provGprsUsed, UnitUtils.GPRS_UNIT_MB));
        outDTO.setProvGprsRemain(UnitUtils.trans(provGprsRemain, UnitUtils.GPRS_UNIT_MB));
        outDTO.setNationFreeList(nationFreeList);
        outDTO.setProvFreeList(provFreeList);
        outDTO.setFreeList(freeList);


        log.debug("outDto=" + outDTO.toJson());
        return outDTO;
    }

    private Map<String, Object> getTransMap(List<FreeMinBill> inFreeList) {
        long nationGprsTotal = 0; /*国内可转赠总量*/
        long nationGprsUsed = 0; /**/
        long nationGprsRemain = 0;
        long provGprsTotal = 0;
        long provGprsUsed = 0;
        long provGprsRemain = 0;

        List<TransFreeEntity> nationFreeList = new ArrayList<>();
        List<TransFreeEntity> provFreeList = new ArrayList<>();

        for (FreeMinBill fmb : inFreeList) {
            String busiCode = fmb.getBusiCode();
            String favType = fmb.getFavType();
            String favCode = fmb.getFavCode();
            if (busiCode.charAt(0) != 'X' /*非可转流量不展示*/ || favType.equals("0002") /*套餐外流量不展示*/) {
                continue;
            }

            if (favCode.equals("0")) { /*省内*/
                provGprsTotal += fmb.getLongTotal() + fmb.getLongLastTotal();
                provGprsUsed += fmb.getLongUsed() + fmb.getLongLastUsed();
                provGprsRemain += fmb.getLongRemain() + fmb.getLongLastRemain();

            } else if (favCode.equals("1")) { /*国内*/
                nationGprsTotal += fmb.getLongTotal() + fmb.getLongLastTotal();
                nationGprsUsed += fmb.getLongUsed() + fmb.getLongLastUsed();
                nationGprsRemain += fmb.getLongRemain() + fmb.getLongLastRemain();
            }

            TransFreeEntity transFreeEnt = new TransFreeEntity();
            transFreeEnt.setGprsRegionType(fmb.getRegionType());
            transFreeEnt.setPrcId(fmb.getProdPrcId());
            transFreeEnt.setPrcName(fmb.getProdPrcName());
            transFreeEnt.setUnit(fmb.getUnitCode());
            transFreeEnt.setUnitName(UnitUtils.GPRS_UNIT_MB);

            transFreeEnt.setLongTotal(fmb.getLongTotal());
            transFreeEnt.setLongUsed(fmb.getLongUsed());
            transFreeEnt.setLongRemain(fmb.getLongRemain());

            transFreeEnt.setTotal(UnitUtils.trans(fmb.getLongTotal(), UnitUtils.GPRS_UNIT_MB));
            transFreeEnt.setUsed(UnitUtils.trans(fmb.getLongUsed(), UnitUtils.GPRS_UNIT_MB));
            transFreeEnt.setRemain(UnitUtils.trans(fmb.getLongRemain(), UnitUtils.GPRS_UNIT_MB));

            if (fmb.getLongLastTotal() > 0) {
                TransFreeEntity transLastFreeEnt = new TransFreeEntity();
                transLastFreeEnt.setGprsRegionType(fmb.getRegionType());
                transLastFreeEnt.setPrcId(fmb.getProdPrcId());
                transLastFreeEnt.setPrcName(fmb.getProdPrcName() + "上月结转流量");
                transLastFreeEnt.setUnit(fmb.getUnitCode());
                transLastFreeEnt.setUnitName(UnitUtils.GPRS_UNIT_MB);

                transLastFreeEnt.setLongTotal(fmb.getLongLastTotal());
                transLastFreeEnt.setLongUsed(fmb.getLongLastUsed());
                transLastFreeEnt.setLongRemain(fmb.getLongLastRemain());

                transLastFreeEnt.setTotal(UnitUtils.trans(fmb.getLongLastTotal(), UnitUtils.GPRS_UNIT_MB));
                transLastFreeEnt.setUsed(UnitUtils.trans(fmb.getLongLastUsed(), UnitUtils.GPRS_UNIT_MB));
                transLastFreeEnt.setRemain(UnitUtils.trans(fmb.getLongLastRemain(), UnitUtils.GPRS_UNIT_MB));

                if (favCode.equals("0")) {
                    provFreeList.add(transLastFreeEnt);
                } else if (favCode.equals("1")) {
                    nationFreeList.add(transLastFreeEnt);
                }
            }

            if (favCode.equals("0")) {
                provFreeList.add(transFreeEnt);
            } else if (favCode.equals("1")) {
                nationFreeList.add(transFreeEnt);
            }

        }

        Map<String, Object> outFreeMap = new HashMap<>();


        safeAddToMap(outFreeMap, "NATION_GPRS_TOTAL", nationGprsTotal);
        safeAddToMap(outFreeMap, "NATION_GPRS_USED", nationGprsUsed);
        safeAddToMap(outFreeMap, "NATION_GPRS_REMAIN", nationGprsRemain);

        safeAddToMap(outFreeMap, "PROV_GPRS_TOTAL", provGprsTotal);
        safeAddToMap(outFreeMap, "PROV_GPRS_USED", provGprsUsed);
        safeAddToMap(outFreeMap, "PROV_GPRS_REMAIN", provGprsRemain);

        safeAddToMap(outFreeMap, "NATION_FREE_INFO", nationFreeList);
        safeAddToMap(outFreeMap, "PROV_FREE_INFO", provFreeList);

        return outFreeMap;
    }

    /**
     * 按资费（区分结转）展示用户流量信息
     *
     * @param inFreeList
     * @param gprsUnit
     * @return
     */
    private List<TransFreeEntity> getGprsListByPrcId(List<FreeMinBill> inFreeList, String gprsUnit) {
        List<TransFreeEntity> outList = new ArrayList<>();
        List<FreeMinBill> gprsAddedList = new ArrayList<>(); // 流量叠加包资费明细列表
        List<FreeMinBill> gprsMealList = new ArrayList<>(); // 套餐内流量明细列表
        for (FreeMinBill fmb : inFreeList) {
            String busiCode = fmb.getBusiCode();
            String favType = fmb.getFavType();
            String favCode = fmb.getFavCode();

            if (favType.equals("0002") || !busiCode.equals("3")) {
                continue;
            }

            if (favCode.equals("e") || favCode.equals("f") || favCode.equals("1")) {
                continue;
            }

            if (!freeDisplayer.isAddedGprs(fmb.getProdPrcId())) {
                // 套餐内流量，非叠加包
                gprsMealList.add(fmb);
            } else {
                // 套餐外流量叠加包，明细展示时按资费合并
                gprsAddedList.add(fmb);
            }
        }

        outList.addAll(this.getMealFreeList(gprsMealList, gprsUnit));
        outList.addAll(this.getAddedFreeList(gprsAddedList, gprsUnit));

        return outList;
    }

    /**
     * 非流量加油包按资费展示明细
     *
     * @param inFreeList
     * @param gprsUnit
     * @return
     */
    private List<TransFreeEntity> getMealFreeList(List<FreeMinBill> inFreeList, String gprsUnit) {
        List<TransFreeEntity> outList = new ArrayList<>();

        for (FreeMinBill freeEnt : inFreeList) {
            TransFreeEntity freeDetailEnt = new TransFreeEntity();
            freeDetailEnt.setPrcId(freeEnt.getProdPrcId());
            freeDetailEnt.setPrcName(freeEnt.getProdPrcName());
            freeDetailEnt.setLongTotal(freeEnt.getLongTotal());
            freeDetailEnt.setLongUsed(freeEnt.getLongUsed());
            freeDetailEnt.setLongRemain(freeEnt.getLongRemain());
            freeDetailEnt.setUnit(freeEnt.getUnitCode());
            freeDetailEnt.setUnitName(freeEnt.getUnitName());
            outList.add(freeDetailEnt);

            if (freeEnt.getLongLastTotal() > 0) {
                TransFreeEntity lastFreeDetailEnt = new TransFreeEntity();
                lastFreeDetailEnt.setPrcId(freeEnt.getProdPrcId());
                lastFreeDetailEnt.setPrcName(freeEnt.getProdPrcName() + "上月结转流量");
                lastFreeDetailEnt.setLongTotal(freeEnt.getLongTotal());
                lastFreeDetailEnt.setLongUsed(freeEnt.getLongUsed());
                lastFreeDetailEnt.setLongRemain(freeEnt.getLongRemain());
                lastFreeDetailEnt.setUnit(freeEnt.getUnitCode());
                lastFreeDetailEnt.setUnitName(freeEnt.getUnitName());

                outList.add(lastFreeDetailEnt);
            }
        }

        for (TransFreeEntity freeEnt : outList) {
            freeEnt.setUnitName(gprsUnit);
            freeEnt.setTotal(UnitUtils.trans(freeEnt.getLongTotal(), gprsUnit));
            freeEnt.setUsed(UnitUtils.trans(freeEnt.getLongUsed(), gprsUnit));
            freeEnt.setRemain(UnitUtils.trans(freeEnt.getLongRemain(), gprsUnit));

        }

        return outList;
    }

    /**
     * 流量加油包按资费展示明细，相同资费展示个数
     *
     * @param inFreeList
     * @return
     */
    private List<TransFreeEntity> getAddedFreeList(List<FreeMinBill> inFreeList, String gprsUnit) {
        List<TransFreeEntity> outList = new ArrayList<>();

        Map<String, TransFreeEntity> indexMap = new HashMap<>();
        Map<String, Integer> numMap = new HashMap<>(); // //流量叠加包个数
        for (FreeMinBill freeEnt : inFreeList) {
            String prcId = freeEnt.getProdPrcId();
            if (indexMap.containsKey(prcId)) {
                TransFreeEntity oldEnt = indexMap.get(prcId);
                long oldTotal = oldEnt.getLongTotal();
                long oldUsed = oldEnt.getLongUsed();
                long oldRemain = oldEnt.getLongRemain();

                long newTotal = oldTotal + freeEnt.getLongTotal();
                long newUsed = oldUsed + freeEnt.getLongUsed();
                long newRemain = oldRemain + freeEnt.getLongRemain();
                oldEnt.setLongTotal(newTotal);
                oldEnt.setLongUsed(newUsed);
                oldEnt.setLongRemain(newRemain);

                oldEnt.setUnitName(gprsUnit);
                oldEnt.setTotal(UnitUtils.trans(freeEnt.getLongTotal(), gprsUnit));
                oldEnt.setUsed(UnitUtils.trans(freeEnt.getLongUsed(), gprsUnit));
                oldEnt.setRemain(UnitUtils.trans(freeEnt.getLongRemain(), gprsUnit));

                Integer numNew = numMap.get(prcId) + 1;
                if (freeEnt.getLongLastTotal() > 0) {
                    numNew++;
                }
                numMap.put(prcId, numNew);
            } else {
                TransFreeEntity freeDetailEnt = new TransFreeEntity();
                freeDetailEnt.setGprsRegionType(freeEnt.getRegionType());
                freeDetailEnt.setLongTotal(freeEnt.getLongTotal());
                freeDetailEnt.setLongUsed(freeEnt.getLongUsed());
                freeDetailEnt.setLongRemain(freeEnt.getLongRemain());
                freeDetailEnt.setPrcName(freeEnt.getProdPrcName());
                freeDetailEnt.setPrcId(freeEnt.getProdPrcId());
                freeDetailEnt.setUnit(freeEnt.getUnitCode());
                freeDetailEnt.setUnitName(gprsUnit);

                freeDetailEnt.setTotal(UnitUtils.trans(freeEnt.getLongTotal(), gprsUnit));
                freeDetailEnt.setUsed(UnitUtils.trans(freeEnt.getLongUsed(), gprsUnit));
                freeDetailEnt.setRemain(UnitUtils.trans(freeEnt.getLongRemain(), gprsUnit));

                indexMap.put(prcId, freeDetailEnt);
                numMap.put(prcId, 1);
            }
        }

        StringBuilder sb = null;
        for (String key : indexMap.keySet()) {

            TransFreeEntity detailEnt = indexMap.get(key);
            if (numMap.containsKey(key)) {
                String oldPrcName = detailEnt.getPrcName();
                sb = new StringBuilder();
                sb.append(oldPrcName).append("(").append(numMap.get(key)).append("个)");
                detailEnt.setPrcName(sb.toString());
            }

            outList.add(detailEnt);
        }

        return outList;
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
