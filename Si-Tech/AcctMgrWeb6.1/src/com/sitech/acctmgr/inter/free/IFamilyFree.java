package com.sitech.acctmgr.inter.free;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/25.
 */
public interface IFamilyFree {
    /**
     * 功能：家庭优惠信息查询 <br>
     * 对应旧接口：sFamUserFav 家庭亲情的优惠信息查询 <br>
     * 调用渠道：网上营业厅、短信营业厅、手机客户端、飞信营业厅、外呼系统、IVR、自助缴费机、新业务微信平台、微信营业厅服务号
     * @param inParam
     * @return
     */
    OutDTO query(InDTO inParam);

    /**
     * 功能：家庭优惠趣味信息查询 <br>
     * 对应旧接口：sFamSelect 亲情网显性化查询 <br>
     * 调用渠道：网上营业厅、短信营业厅、手机客户端、飞信营业厅、外呼系统、IVR、自助缴费机、新业务微信平台、微信营业厅服务号
     * @param inParam
     * @return
     */
    OutDTO funnyQuery(InDTO inParam);

    /**
     * 功能：家庭共享优惠查询（语音+GPRS） <br>
     * 对应老接口：sGetFamFavAll
     * @param inParam
     * @return
     */
    OutDTO shareQuery(InDTO inParam);
}
