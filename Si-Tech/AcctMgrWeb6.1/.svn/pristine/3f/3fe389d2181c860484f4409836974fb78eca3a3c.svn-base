package com.sitech.acctmgr.atom.busi.collection;

import com.sitech.acctmgr.atom.domains.pub.PubCodeDictEntity;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.jcf.core.exception.BusiException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * Description:托收代码维护
 * <p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 *
 * @author wangyla
 * @version 1.0
 */
public class CollCode extends BaseBusi {
    private IControl control;

    private Map<String, Object> inMapTmp = null;

    /**
     * <p>Description：检验托收代码是否已经配置，TRUE为已配置， FALSE为未配置</p>
     *
     * @param sRegionId
     * @param sCodeId
     * @return
     */
    @SuppressWarnings("unchecked")
    public Boolean isExistCode(String sRegionId, String sCodeId) {
        int iCnt = 0;
        inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("CODE_CLASS", 1003);
        inMapTmp.put("GROUP_ID", sRegionId);
        inMapTmp.put("CODE_ID", sCodeId);
        System.out.println(inMapTmp);

        Map<String, Object> result = (Map<String, Object>) baseDao
                .queryForObject("pub_codedef_dict.qCntPubCodeDict", inMapTmp);

        iCnt = Integer.parseInt(result.get("CNT").toString());

        if (iCnt == 0) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * <p>Description：检验托收代码是否已经配置，TRUE为已配置， FALSE为未配置</p>
     *
     * @param CODE_ID    托收返回代码
     * @param GROUP_ID   机构代码
     * @param CODE_VALUE 返回信息
     * @param STATUS     重托标识 0 不重托 1 重托
     * @param LOGIN_NO   操作工号
     * @param BEGIN_TIME 开始时间
     * @return 空
     */
    public void saveCode(Map<String, Object> inParam) {
        // 未做配置时，不允许修改
        if (isExistCode((String) inParam.get("GROUP_ID"), (String) inParam.get("CODE_ID"))) {
            System.out.println("托收代码已经配置，不允许重复操作");
            throw new BusiException(AcctMgrError.getErrorCode("8225", "80001"),
                    "托收代码已经配置，不允许重复操作！");
        }

        inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("CODE_CLASS", 1003);
        inMapTmp.put("CODE_ID", inParam.get("CODE_ID"));
        inMapTmp.put("GROUP_ID", inParam.get("GROUP_ID"));
        inMapTmp.put("CODE_NAME", "COLL_RET_CODE");
        inMapTmp.put("CODE_VALUE", inParam.get("CODE_VALUE"));
        inMapTmp.put("CODE_DESC", inParam.get("CODE_VALUE"));
        inMapTmp.put("STATUS", inParam.get("STATUS"));
        inMapTmp.put("LOGIN_NO", inParam.get("LOGIN_NO"));
        inMapTmp.put("BEGIN_TIME", inParam.get("BEGIN_TIME"));
        inMapTmp.put("END_TIME", "20991231");
        System.out.println(inMapTmp);

        baseDao.insert("pub_codedef_dict.instPubCodeDict", inMapTmp);

    }

    /**
     * <p>Description：删除托收代码</p>
     *
     * @param sRegionId 归属地市
     * @param sCodeId   托收返回代码
     * @return 空
     */
    public void removeCode(String sRegionId, String sCodeId) {
        // 未做配置时，不允许删除
        if (!isExistCode(sRegionId, sCodeId)) {
            System.out.println("还未做配置，不允许删除");
            throw new BusiException(AcctMgrError.getErrorCode("8225", "80002"),
                    "托收代码还未配置，不能进行删除操作！");
        }

        inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("CODE_CLASS", 1003);
        inMapTmp.put("GROUP_ID", sRegionId);
        inMapTmp.put("CODE_ID", sCodeId);
        System.out.println(inMapTmp);

        baseDao.delete("pub_codedef_dict.delPubCodeDict", inMapTmp);
    }

    /**
     * <p>Description：修改托收代码</p>
     *
     * @param sRegionId   归属地市
     * @param sCodeId     托收返回代码
     * @param sCodeValue  新托收返回信息
     * @param sCollStatus 新重托标识 0：不重托，1：重托
     * @return 空
     */
    public void updateCode(String sRegionId, String sCodeId, String sCodeValue, String sCollStatus) {
        // 未做配置时，不允许修改
        if (!isExistCode(sRegionId, sCodeId)) {
            System.out.println("还未做配置，不允许修改");
            throw new BusiException(AcctMgrError.getErrorCode("8225", "80003"),
                    "托收代码还未配置，不能进行修改操作！");
        }

        inMapTmp = new HashMap<String, Object>();
        inMapTmp.put("CODE_CLASS", 1003);
        inMapTmp.put("GROUP_ID", sRegionId);
        inMapTmp.put("CODE_ID", sCodeId);
        inMapTmp.put("CODE_VALUE", sCodeValue);
        inMapTmp.put("CODE_DESC", sCodeValue);
        inMapTmp.put("STATUS", sCollStatus);
        System.out.println(inMapTmp);

        baseDao.update("pub_codedef_dict.updPubCodeDict", inMapTmp);
    }

    /**
     * <p>Description：获取归属地市的托收代码</p>
     *
     * @param sRegionId 归属地市
     * @return 返回托收代码列表LIST
     */
    @SuppressWarnings("unchecked")
    public List<PubCodeDictEntity> getCode(String sRegionId) {
        long codeClass = 1003;
        List<PubCodeDictEntity> publist = control.getPubCodeList(codeClass, null, sRegionId, null, null);
        return publist;
    }

    public IControl getControl() {
        return control;
    }

    public void setControl(IControl control) {
        this.control = control;
    }
}
