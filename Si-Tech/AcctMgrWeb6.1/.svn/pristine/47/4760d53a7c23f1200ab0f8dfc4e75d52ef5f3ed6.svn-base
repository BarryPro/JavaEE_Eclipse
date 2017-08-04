package com.sitech.acctmgr.atom.entity.inter;

import com.sitech.acctmgr.atom.domains.prod.UserPdPrcDetailInfoEntity;

import java.util.List;
import java.util.Map;

/**
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 *
 * @author
 * @version 1.0
 */
public interface IGoods {

    /**
     * 名称：用户是否订购该产品，定价级
     *
     * @param prcId 定价ID
     * @param idNo
     */
    boolean isOrderGoods(long idNo, String prcId);

    /**
     * 名称：用户是否订购该产品，定价级
     *
     * @param idNo
     */
    UserPdPrcDetailInfoEntity getPacketPrcInfo(long idNo);

    /**
     * 名称：查询月租费
     *
     * @param idNo
     * @param attrId
     * @param prcClass
     * @return
     * @author liuhl_bj
     */
    List<Map<String, Object>> getMonthFee(long idNo, String[] attrId, String[] prcClass);

}
