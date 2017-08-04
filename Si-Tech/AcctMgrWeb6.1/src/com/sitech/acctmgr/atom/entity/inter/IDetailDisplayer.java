package com.sitech.acctmgr.atom.entity.inter;

import com.sitech.acctmgr.atom.domains.detail.ChannelDetail;
import com.sitech.acctmgr.atom.domains.detail.DetailLimitEntity;
import com.sitech.acctmgr.atom.domains.detail.GrpDetailEntity;
import com.sitech.acctmgr.atom.domains.detail.QueryTypeEntity;
import com.sitech.acctmgr.net.ServerInfo;

import java.util.List;
import java.util.Map;

/**
 * Created by wangyla on 2016/7/27.
 */
public interface IDetailDisplayer {
    List<QueryTypeEntity> getDetailTypeList(String queryClass);

    /**
     * 功能：获取详单类型列表
     * @param queryClass
     * @param detailType
     * @return
     */
    List<QueryTypeEntity> getDetailTypeList(String queryClass, String detailType);

    /**
     * 功能：用户跨区查询详单限制
     * @param idNo
     * @param limitDay
     * @return true : 允许查询； false: 不允许查询
     */
    boolean transRegionLimit(Long idNo, int limitDay);

    /**
     * 功能：用户跨区查询详单限制
     * @param phoneNo
     * @param limitDay
     * @return true : 允许查询； false: 不允许查询
     */
    boolean transRegionLimit(String phoneNo, int limitDay);

    List<String> queryDetail(String phoneNo, String detailCode, ServerInfo si,  String dealBeginTime, String dealEndTime,
                             String... options);

    ChannelDetail comboDetail(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                              String callBeginTime, String callEndTime);

    ChannelDetail voiceDetail(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                              String callBeginTime, String callEndTime, String serviceType);

    ChannelDetail videoDetail(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                              String callBeginTime, String callEndTime, String serviceType);

    ChannelDetail smsDetail(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                            String callBeginTime, String callEndTime, String serviceType);

    ChannelDetail netDetail(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                            String callBeginTime, String callEndTime);

    ChannelDetail addedDetail(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                              String callBeginTime, String callEndTime);

    ChannelDetail groupDetail(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                              String callBeginTime, String callEndTime);

    ChannelDetail agencyDetail(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                               String callBeginTime, String callEndTime);

    ChannelDetail otherDetail(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                              String callBeginTime, String callEndTime);

    ChannelDetail favourDetail(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                               String callBeginTime, String callEndTime);

    /**
     * 功能：未合并详单查询
     * @param phoneNo
     * @param queryType
     * @param dealBeginTime
     * @param dealEndTime
     * @param callBeginTime
     * @param callEndTime
     * @param chargingId
     * @param resv
     * @return
     */
    ChannelDetail netDetailDetail(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                                  String callBeginTime, String callEndTime, String chargingId, String resv);

    /**
     * 功能：原始详单查询
     * @param phoneNo
     * @param queryType
     * @param dealBeginTime
     * @param dealEndTime
     * @param callBeginTime
     * @param callEndTime
     * @return
     */
    List<String> rawDetail(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
			String callBeginTime, String callEndTime);

    /**
     * 功能：查询工号地市详单已查询次数
     * @param loginNo
     * @param opCode
     * @param powerType
     * @return
     */
    DetailLimitEntity getDetailLimitConf(String loginNo, String opCode, String powerType);

    void insertDetailLimitConf(String loginNo, String opCode, String powerType);

    void updateDetailLimitUsedSum(String loginNo, String opCode, String powerType, boolean isFirst);

    /**
     * 功能：安保详单查询
     * @param phoneNo
     * @param queryType
     * @param dealBeginTime
     * @param dealEndTime
     * @param callBeginTime
     * @param callEndTime
     * @return
     */
    List<String> securityDetail(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                                String callBeginTime, String callEndTime);

    /**
     * 功能：详单屏蔽功能判定
     * @param idNo
     * @return Y：用户开启详单屏蔽功能；N：用户未开启详单屏蔽功能
     */
    String getDetailBillQryFlag(Long idNo);

    /**
     * 功能：梦网及自有业务详单查询
     * @param phoneNo
     * @param queryType
     * @param dealBeginTime
     * @param dealEndTime
     * @param callBeginTime
     * @param callEndTime
     * @return
     */
    ChannelDetail spDetail(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                           String callBeginTime, String callEndTime);

    Map<String, Integer> smsStats(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                                  String callBeginTime, String callEndTime);

    GrpDetailEntity grpDetail01Sms(String phoneNo, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                                   String callBeginTime, String callEndTime, String svrCode);

    GrpDetailEntity grpDetail01Mms(String phoneNo, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                                   String callBeginTime, String callEndTime);

    GrpDetailEntity grpDetail02(String phoneNo, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                                String callBeginTime, String callEndTime, String callNum, String confId);

    GrpDetailEntity grpDetail03(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                                String callBeginTime, String callEndTime, String svrCode);

    GrpDetailEntity grpDetail04(String phoneNo, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                                String callBeginTime, String callEndTime);

    GrpDetailEntity grpDetail05ER(String phoneNo, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                                  String callBeginTime, String callEndTime);

    GrpDetailEntity grpDetail05Sj(String phoneNo, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                                  String callBeginTime, String callEndTime);

    GrpDetailEntity grpDetail06(String phoneNo, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                                String callBeginTime, String callEndTime);

    GrpDetailEntity grpDetail07(String phoneNo, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                                String callBeginTime, String callEndTime);

    GrpDetailEntity grpDetail08(String phoneNo, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                                String callBeginTime, String callEndTime);

    GrpDetailEntity grpDetail09(String phoneNo, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                                String callBeginTime, String callEndTime);

    List<String> cityOldDetail(String phoneNo, String queryType, ServerInfo serverInfo, String dealBeginTime, String dealEndTime,
                               String callBeginTime, String callEndTime, String serviceType, boolean highPower);
}
