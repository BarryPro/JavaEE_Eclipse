package com.sitech.acctmgr.atom.impl.volume;


import com.sitech.acctmgr.atom.domains.volume.TransferOtherEntity;
import com.sitech.acctmgr.atom.domains.volume.VolumeBookDetail;
import com.sitech.acctmgr.atom.domains.volume.VolumeBookInOutDetail;
import com.sitech.acctmgr.atom.dto.volume.*;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.volume.IVolumeBook;
import com.sitech.acctmgr.net.ResponseData;
import com.sitech.acctmgr.net.ServerInfo;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import org.apache.commons.lang.StringUtils;

import java.util.ArrayList;
import java.util.List;

@ParamTypes({
        @ParamType(m = "pay", c = VolumeBookPayInDTO.class, oc = VolumeBookPayOutDTO.class, srvName = "com_sitech_acctmgr_inter_volume_IVolumeBookSvc_pay", srvCnName = "流量充入"),
        @ParamType(m = "rollback", c = VolumeBookRollbackInDTO.class, oc = VolumeBookRollbackOutDTO.class, srvName = "com_sitech_acctmgr_inter_volume_IVolumeBookSvc_rollback", srvCnName = "流量冲正"),
        @ParamType(m = "deduct", c = VolumeBookDeductInDTO.class, oc = VolumeBookDeductOutDTO.class, srvName = "com_sitech_acctmgr_inter_volume_IVolumeBookSvc_deduct", srvCnName = "流量扣减"),
        @ParamType(m = "preholding", c = VolumeBookPreHoldingInDTO.class, oc = VolumeBookPreHoldingOutDTO.class, srvName = "com_sitech_acctmgr_inter_volume_IVolumeBookSvc_preholding", srvCnName = "流量预占"),
        @ParamType(m = "preholdingDeduct", c = VolumeBookPreholdingDeductInDTO.class, oc = VolumeBookPreholdingDeductOutDTO.class, srvName = "com_sitech_acctmgr_inter_volume_IVolumeBookSvc_preholdingDeduct", srvCnName = "流量预占扣减"),
        @ParamType(m = "preholdingRelease", c = VolumeBookPreholdingReleaseInDTO.class, oc = VolumeBookPreholdingReleaseOutDTO.class, srvName = "com_sitech_acctmgr_inter_volume_IVolumeBookSvc_preholdingRelease", srvCnName = "流量预占释放"),
        @ParamType(m = "transfer", c = VolumeBookTransferInDTO.class, oc = VolumeBookTransferOutDTO.class, srvName = "com_sitech_acctmgr_inter_volume_IVolumeBookSvc_transfer", srvCnName = "流量转移"),
        @ParamType(m = "shareCreate", c = VolumeBookShareCreateInDTO.class, oc = VolumeBookShareCreateOutDTO.class, srvName = "com_sitech_acctmgr_inter_volume_IVolumeBookSvc_shareCreate", srvCnName = "流量共享创建"),
        @ParamType(m = "shareChange", c = VolumeBookShareChangeInDTO.class, oc = VolumeBookShareChangeOutDTO.class, srvName = "com_sitech_acctmgr_inter_volume_IVolumeBookSvc_shareChange", srvCnName = "流量共享变更"),
        @ParamType(m = "delay", c = VolumeBookDelayInDTO.class, oc = VolumeBookDelayOutDTO.class, srvName = "com_sitech_acctmgr_inter_volume_IVolumeBookSvc_delay", srvCnName = "流量延时"),
        @ParamType(m = "query", c = VolumeBookQueryInDTO.class, oc = VolumeBookQueryOutDTO.class, srvName = "com_sitech_acctmgr_inter_volume_IVolumeBookSvc_query", srvCnName = "流量查询"),
        @ParamType(m = "inAndOutQuery", c = VolumeBookInAndOutQueryInDTO.class, oc = VolumeBookInAndOutQueryOutDTO.class, srvName = "com_sitech_acctmgr_inter_volume_IVolumeBookSvc_inAndOutQuery", srvCnName = "流量收支查询")
})
public class SVolumeBook extends AcctMgrBaseService implements IVolumeBook {
    private IControl control;

    @Override
    public OutDTO pay(InDTO inDTO) {
        //000189~!~01~!~01~!~20160711~!~18249070556~!~18249070556~!~03~!~04~!~1~!~1~!~1~!~9900000000000084~!~65~!~~!~50008~!~30001~!~~!~1~!~10000~!~1~!~1~!~20170101000000~!~20170711000000~!~1~!~1~!~1
        VolumeBookPayInDTO in = (VolumeBookPayInDTO) inDTO;
        log.debug("inDto=" + in.getMbean());

        String serviceMsgType = StringUtils.isEmpty(in.getServiceMsgType()) ? "01" : in.getServiceMsgType();
        String changeReason = StringUtils.isEmpty(in.getChangeReason()) ? "01" : in.getChangeReason();
        String reqSeq = in.getReqSeq(); /*交易流水*/
        String msisdn = in.getMsisdn();
        String userId = in.getUserId();
        String regionId = in.getRegionId(); /*地市编码*/
        String partId = in.getPartId(); /*分区编码*/
        String operSource = in.getOperSource();
        String operChannel = in.getOperChannel();
        String operId = in.getOperId();
        String acctId = in.getAcctId();
        String acctType = in.getAcctType();
        String balanceId = in.getBalanceId();
        String balanceType = in.getBalanceType();
        String balanceAttr = in.getBalanceAttr();
        String addAttrCode = in.getAddAttrCode();
        String shareFlag = in.getShareFlag();
        String chargeValue = in.getChargeValue();
        String payValue = in.getPayValue();
        String payUntie = in.getPayUnite();
        String effDate = in.getEffDate();
        String expDate = in.getExpDate();
        String queryFlag = in.getQueryFlag();
        String productId = in.getProductId();
        String groupId = in.getGroupId1();

        ServerInfo svrInfo = control.getPhoneRouteConf(null, "VOLUMEQRY");

        String[] args = new String[]{
                serviceMsgType, changeReason, reqSeq, msisdn, userId, regionId,
                partId, operSource, operChannel, operId, /*以上为请求头*/
                acctId, acctType, balanceId, balanceType, balanceAttr, addAttrCode, shareFlag,
                chargeValue, payValue, payUntie, effDate, expDate, queryFlag,
                productId, groupId

        };

        String[] outArray = null;
        try {
            VolumeClient client = new VolumeClient();
            client.getServerProxy().setServerInfo(svrInfo);
            client.setRequestArgs(args);
            ResponseData response = client.getResponseData();
            String responseString = response.getResponseString();
            outArray = responseString.split(VolumeRequestData.SPLIT_CODE);

        } catch (RuntimeException e) {
            e.printStackTrace();
            throw new BusiException("连接超时，请联系管理员");
        }

        if (!outArray[1].equals("0000")) {
            //000032~!~2010~!~生成充值纪录重复
            throw new BusiException(outArray[1], outArray[2]);
        }

        VolumeBookPayOutDTO outDTO = new VolumeBookPayOutDTO();
        //成功返回报文：000038~!~0000~!~sucess~!~10000~!~40000
        outDTO.setChargeValue(outArray[3]);
        if (queryFlag.equals("1")) { //返回总量
            outDTO.setTypeAllValue(outArray[4]);
        }
        outDTO.setReturnCode(outArray[1]);
        outDTO.setReturnMsg(outArray[2]);

        log.debug("outDto=" + outDTO.toJson());
        return outDTO;
    }

    @Override
    public OutDTO rollback(InDTO inDTO) {
        VolumeBookRollbackInDTO in = (VolumeBookRollbackInDTO) inDTO;

        log.debug("inDto=" + in.getMbean());

        String serviceMsgType = StringUtils.isEmpty(in.getServiceMsgType()) ? "ff" : in.getServiceMsgType();
        String changeReason = StringUtils.isEmpty(in.getChangeReason()) ? "01" : in.getChangeReason();
        String reqSeq = in.getReqSeq(); /*交易流水*/
        String msisdn = in.getMsisdn();
        String userId = in.getUserId();
        String regionId = in.getRegionId(); /*地市编码*/
        String partId = in.getPartId(); /*分区编码*/
        String operSource = in.getOperSource();
        String operChannel = in.getOperChannel();
        String operId = in.getOperId();
        String operSession = in.getOperSession();

        String[] args = {
                serviceMsgType, changeReason, reqSeq, msisdn, userId, regionId, partId,
                operSource, operChannel, operId, operSession};

        ServerInfo svrInfo = control.getPhoneRouteConf(null, "VOLUMEQRY");

        String[] outArray = null;
        try {
            VolumeClient client = new VolumeClient();
            client.getServerProxy().setServerInfo(svrInfo);
            client.setRequestArgs(args);
            ResponseData response = client.getResponseData();
            String responseString = response.getResponseString();
            outArray = responseString.split(VolumeRequestData.SPLIT_CODE);
        } catch (RuntimeException e) {
            e.printStackTrace();
            throw new BusiException("连接超时，请联系管理员");
        }

        VolumeBookRollbackOutDTO outDTO = new VolumeBookRollbackOutDTO();
        if (!outArray[1].equals("0000")) {
            //000041~!~1007~!~账本已冲正，不能再进行冲正
            throw new BusiException(outArray[1], outArray[2]);
        }

        outDTO.setReturnCode(outArray[1]);
        outDTO.setReturnMsg(outArray[2]);

        log.debug("outDto=" + outDTO.toJson());
        return outDTO;
    }

    @Override
    public OutDTO deduct(InDTO inDTO) {
        VolumeBookDeductInDTO in = (VolumeBookDeductInDTO) inDTO;
        log.debug("inDto=" + in.getMbean());

        String serviceMsgType = StringUtils.isEmpty(in.getServiceMsgType()) ? "02" : in.getServiceMsgType();
        String changeReason = StringUtils.isEmpty(in.getChangeReason()) ? "07" : in.getChangeReason();
        String reqSeq = in.getReqSeq(); /*交易流水*/
        String msisdn = in.getMsisdn();
        String userId = in.getUserId();
        String regionId = in.getRegionId(); /*地市编码*/
        String partId = in.getPartId(); /*分区编码*/
        String operSource = in.getOperSource();
        String operChannel = in.getOperChannel();
        String operId = in.getOperId();

        String acctId = in.getAcctId();
        String acctType = in.getAcctType();
        String balanceId = in.getBalanceId();
        String balanceType = in.getBalanceType();
        String addAttrCode = in.getAddAttrCode();
        String chargeValue = in.getChargeValue();
        String payValue = in.getPayValue();
        String payUnite = in.getPayUnite();
        String queryFlag = in.getQueryFlag();
        String productId = in.getProductId();

        String[] args = {
                serviceMsgType, changeReason, reqSeq, msisdn, userId, regionId, partId,
                operSource, operChannel, operId,
                acctId, acctType, balanceId, balanceType, addAttrCode, chargeValue, payValue, payUnite, queryFlag, productId};

        ServerInfo svrInfo = control.getPhoneRouteConf(null, "VOLUMEQRY");

        String[] outArray = null;
        try {
            VolumeClient client = new VolumeClient();
            client.getServerProxy().setServerInfo(svrInfo);
            client.setRequestArgs(args);
            ResponseData response = client.getResponseData();
            String responseString = response.getResponseString();
            outArray = responseString.split(VolumeRequestData.SPLIT_CODE);
        } catch (RuntimeException e) {
            e.printStackTrace();
            throw new BusiException("连接超时，请联系管理员");
        }

        if (!outArray[1].equals("0000")) {
            throw new BusiException(outArray[1], outArray[2]);
        }

        VolumeBookDeductOutDTO outParam = new VolumeBookDeductOutDTO();
        outParam.setChargeValue(outArray[3]);
        outParam.setRealChargeValue(outArray[4]);
        if (queryFlag.charAt(0) == '1') { //1表示返回总流量；0表示不返回
            outParam.setTypeAllValue(outArray[5]);
        }
        outParam.setReturnCode(outArray[1]);
        outParam.setReturnMsg(outArray[2]);

        log.debug("outDto=" + outParam.toJson());
        return outParam;
    }

    @Override
    public OutDTO preholding(InDTO inDTO) {
        VolumeBookPreHoldingInDTO in = (VolumeBookPreHoldingInDTO) inDTO;
        log.debug("inDto=" + in.getMbean());

        String serviceMsgType = StringUtils.isEmpty(in.getServiceMsgType()) ? "20" : in.getServiceMsgType();
        String changeReason = in.getChangeReason();
        String reqSeq = in.getReqSeq(); /*交易流水*/
        String msisdn = in.getMsisdn();
        String userId = in.getUserId();
        String regionId = in.getRegionId(); /*地市编码*/
        String partId = in.getPartId(); /*分区编码*/
        String operSource = in.getOperSource();
        String operChannel = in.getOperChannel();
        String operId = in.getOperId();

        String acctId = in.getAcctId();
        String acctType = in.getAcctType();
        String balanceId = in.getBalanceId();
        String balanceType = in.getBalanceType();
        String addAttrCode = in.getAddAttrCode();
        String chargeValue = in.getChargeValue();
        String effDate = in.getEffDate();
        String expDate = in.getExpDate();
        String productId = in.getProductId();

        String[] args = {serviceMsgType,
                changeReason, reqSeq, msisdn, userId, regionId, partId,
                operSource, operChannel, operId, acctId, acctType, balanceId,
                balanceType, addAttrCode, chargeValue, effDate, expDate, productId};

        ServerInfo svrInfo = control.getPhoneRouteConf(null, "VOLUMEQRY");

        String[] outArray = null;
        try {
            VolumeClient client = new VolumeClient();
            client.getServerProxy().setServerInfo(svrInfo);
            client.setRequestArgs(args);
            ResponseData response = client.getResponseData();
            String responseString = response.getResponseString();
            outArray = responseString.split(VolumeRequestData.SPLIT_CODE);
        } catch (RuntimeException e) {
            e.printStackTrace();
            throw new BusiException("连接超时，请联系管理员");
        }

        if (!outArray[1].equals("0000")) {
            throw new BusiException(outArray[1], outArray[2]);
        }

        VolumeBookPreHoldingOutDTO outParam = new VolumeBookPreHoldingOutDTO();
        outParam.setChargeValue(outArray[3]);
        outParam.setRealChargeValue(outArray[4]);
        outParam.setReturnCode(outArray[1]);
        outParam.setReturnMsg(outArray[2]);

        log.debug("outDto=" + outParam.toJson());
        return outParam;
    }

    @Override
    public OutDTO preholdingDeduct(InDTO inDTO) {
        VolumeBookPreholdingDeductInDTO in = (VolumeBookPreholdingDeductInDTO) inDTO;
        log.debug("inDto=" + in.getMbean());

        String serviceMsgType = StringUtils.isEmpty(in.getServiceMsgType()) ? "21" : in.getServiceMsgType();
        String changeReason = in.getChangeReason();
        String reqSeq = in.getReqSeq(); /*交易流水*/
        String msisdn = in.getMsisdn();
        String userId = in.getUserId();
        String regionId = in.getRegionId(); /*地市编码*/
        String partId = in.getPartId(); /*分区编码*/
        String operSource = in.getOperSource();
        String operChannel = in.getOperChannel();
        String operId = in.getOperId();

        String reserveSession = in.getReserveSession();
        String chargeValue = in.getChargeValue();
        String chargeFlag = in.getChargeFlag();
        String chargeMsisdn = in.getChargeMsisdn();
        String chargeUserId = in.getChargeUserId();
        String productId = in.getProductId();
        String groupId1 = in.getGroupId1();

        String[] args = {serviceMsgType,
                changeReason, reqSeq, msisdn, userId, regionId, partId,
                operSource, operChannel, operId, reserveSession, chargeValue,
                chargeFlag, chargeMsisdn, chargeUserId, productId, groupId1};

        ServerInfo svrInfo = control.getPhoneRouteConf(null, "VOLUMEQRY");

        String[] outArray = null;
        try {
            VolumeClient client = new VolumeClient();
            client.getServerProxy().setServerInfo(svrInfo);
            client.setRequestArgs(args);
            ResponseData response = client.getResponseData();
            String responseString = response.getResponseString();
            outArray = responseString.split(VolumeRequestData.SPLIT_CODE);
        } catch (RuntimeException e) {
            e.printStackTrace();
            throw new BusiException("连接超时，请联系管理员");
        }

        if (!outArray[1].equals("0000")) {
            throw new BusiException(outArray[1], outArray[2]);
        }
        VolumeBookPreholdingDeductOutDTO outParam = new VolumeBookPreholdingDeductOutDTO();
        outParam.setChargeValue(outArray[3]);
        outParam.setReturnCode(outArray[1]);
        outParam.setReturnMsg(outArray[2]);

        log.debug("outDto=" + outParam.toJson());
        return outParam;
    }

    @Override
    public OutDTO preholdingRelease(InDTO inDTO) {
        VolumeBookPreholdingReleaseInDTO in = (VolumeBookPreholdingReleaseInDTO) inDTO;

        log.debug("inDto=" + in.getMbean());

        String serviceMsgType = StringUtils.isEmpty(in.getServiceMsgType()) ? "22" : in.getServiceMsgType();
        String changeReason = in.getChangeReason();
        String reqSeq = in.getReqSeq(); /*交易流水*/
        String msisdn = in.getMsisdn();
        String userId = in.getUserId();
        String regionId = in.getRegionId(); /*地市编码*/
        String partId = in.getPartId(); /*分区编码*/
        String operSource = in.getOperSource();
        String operChannel = in.getOperChannel();
        String operId = in.getOperId();

        String reserveSession = in.getReserveSession();
        String[] args = {serviceMsgType,
                changeReason, reqSeq, msisdn, userId, regionId, partId,
                operSource, operChannel, operId, reserveSession};

        ServerInfo svrInfo = control.getPhoneRouteConf(null, "VOLUMEQRY");

        String[] outArray = null;
        try {
            VolumeClient client = new VolumeClient();
            client.getServerProxy().setServerInfo(svrInfo);
            client.setRequestArgs(args);
            ResponseData response = client.getResponseData();
            String responseString = response.getResponseString();
            outArray = responseString.split(VolumeRequestData.SPLIT_CODE);
        } catch (RuntimeException e) {
            e.printStackTrace();
            throw new BusiException("连接超时，请联系管理员");
        }

        if (!outArray[1].equals("0000")) {
            throw new BusiException(outArray[1], outArray[2]);
        }

        VolumeBookPreholdingReleaseOutDTO outParam = new VolumeBookPreholdingReleaseOutDTO();
        outParam.setChargeValue(outArray[3]);
        outParam.setReturnCode(outArray[1]);
        outParam.setReturnMsg(outArray[2]);

        log.debug("outDto=" + outParam.toJson());
        return outParam;
    }

    @Override
    public OutDTO transfer(InDTO inDTO) {
        VolumeBookTransferInDTO in = (VolumeBookTransferInDTO) inDTO;
        log.debug("inDto=" + in.getMbean());

        String serviceMsgType = StringUtils.isEmpty(in.getServiceMsgType()) ? "10" : in.getServiceMsgType();
        String changeReason = StringUtils.isEmpty(in.getChangeReason()) ? "05" : in.getChangeReason();
        String reqSeq = in.getReqSeq(); /*交易流水*/
        String msisdn = in.getMsisdn();
        String userId = in.getUserId();
        String regionId = in.getRegionId(); /*地市编码*/
        String partId = in.getPartId(); /*分区编码*/
        String operSource = in.getOperSource();
        String operChannel = in.getOperChannel();
        String operId = in.getOperId();

        String acctId = in.getAcctId();
        String acctType = in.getAcctType();
        String balanceId = in.getBalanceId();
        String balanceType = in.getBalanceType();
        String addAttrCode = in.getAddAttrCode();
        String chargeValue = in.getChargeValue();
        String count = in.getCount();
        List<TransferOtherEntity> otherList = in.getOthers();
        String effDate = in.getEffDate();
        String expDate = in.getExpDate();
        String queryFlag = in.getQueryFlag();
        String productId = in.getProductId();


        StringBuilder sb = new StringBuilder();
        int i = 0;
        for (TransferOtherEntity other : otherList) {
            if (i > 0) {
                sb.append(VolumeRequestData.SPLIT_CODE);
            }
            sb.append(other.getOtherParty()).append("#")
                    .append(other.getOtherValue()).append("#")
                    .append(other.getUserId());
            i++;
        }

        String otherString = sb.toString();

        String[] args = {
                serviceMsgType, changeReason, reqSeq, msisdn, userId, regionId, partId,
                operSource, operChannel, operId,
                acctId, acctType, balanceId,
                balanceType, addAttrCode, chargeValue, count, otherString,
                effDate, expDate, queryFlag, productId};


        ServerInfo svrInfo = control.getPhoneRouteConf(null, "VOLUMEQRY");
        String[] outArray = null;
        try {
            VolumeClient client = new VolumeClient();
            client.getServerProxy().setServerInfo(svrInfo);
            client.setRequestArgs(args);
            ResponseData response = client.getResponseData();
            String responseString = response.getResponseString();
            outArray = responseString.split(VolumeRequestData.SPLIT_CODE);
        } catch (RuntimeException e) {
            e.printStackTrace();
            throw new BusiException("连接超时，请联系管理员");
        }

        if (!outArray[1].equals("0000")) {
            throw new BusiException(outArray[1], outArray[2]);
        }

        VolumeBookTransferOutDTO outParam = new VolumeBookTransferOutDTO();
        outParam.setChargeValue(outArray[3]);
        if (queryFlag.charAt(0) == '1') {
            outParam.setTypeAllValue(outArray[4]);
        }
        outParam.setReturnCode(outArray[1]);
        outParam.setReturnMsg(outArray[2]);
        log.debug("outDto=" + outParam.toJson());
        return outParam;
    }

    @Override
    public OutDTO shareCreate(InDTO inDTO) {
    	VolumeBookShareCreateInDTO in = (VolumeBookShareCreateInDTO)inDTO;
    	log.debug("inDto=" + in.getMbean());

        String serviceMsgType = StringUtils.isEmpty(in.getServiceMsgType()) ? "11" : in.getServiceMsgType();
        String changeReason = in.getChangeReason();
        String reqSeq = in.getReqSeq(); /*交易流水*/
        String msisdn = in.getMsisdn();
        String userId = in.getUserId();
        String regionId = in.getRegionId(); /*地市编码*/
        String partId = in.getPartId(); /*分区编码*/
        String operSource = in.getOperSource();
        String operChannel = in.getOperChannel();
        String operId = in.getOperId();
        
        String shareId = in.getShareId();
        String effDate = in.getEffDate();
        String expDate = in.getExpDate();
        String limitValue = in.getLimitValue();
        String limitType = in.getLimitType();
        String limitCycle = in.getLimitCycle();

        String[] args = {serviceMsgType,
                changeReason, reqSeq, msisdn, userId, regionId, partId,
                operSource, operChannel, operId, 
                shareId, limitType, limitValue ,limitCycle, effDate, expDate};

        ServerInfo svrInfo = control.getPhoneRouteConf(null, "VOLUMEQRY");

        String[] outArray = null;
        try {
            VolumeClient client = new VolumeClient();
            client.getServerProxy().setServerInfo(svrInfo);
            client.setRequestArgs(args);
            ResponseData response = client.getResponseData();
            String responseString = response.getResponseString();
            outArray = responseString.split(VolumeRequestData.SPLIT_CODE);
        } catch (RuntimeException e) {
            e.printStackTrace();
            throw new BusiException("连接超时，请联系管理员");
        }

        if (!outArray[1].equals("0000")) {
            throw new BusiException(outArray[1], outArray[2]);
        }

        VolumeBookShareCreateOutDTO outParam = new VolumeBookShareCreateOutDTO();
        outParam.setReturnCode(outArray[1]);
        outParam.setReturnMsg(outArray[2]);

        log.debug("outDto=" + outParam.toJson());
    	
        return outParam;
    }
    
    @Override
	public OutDTO shareChange(InDTO inDTO) {
    	VolumeBookShareChangeInDTO in = (VolumeBookShareChangeInDTO)inDTO;
    	log.debug("inDto=" + in.getMbean());

        String serviceMsgType = StringUtils.isEmpty(in.getServiceMsgType()) ? "12" : in.getServiceMsgType();
        String changeReason = in.getChangeReason();
        String reqSeq = in.getReqSeq(); /*交易流水*/
        String msisdn = in.getMsisdn();
        String userId = in.getUserId();
        String regionId = in.getRegionId(); /*地市编码*/
        String partId = in.getPartId(); /*分区编码*/
        String operSource = in.getOperSource();
        String operChannel = in.getOperChannel();
        String operId = in.getOperId();
        
        String shareId = in.getShareId();
        String memberPhone = in.getMemberPhone();
        String memberId = in.getMemberId();
        String limitType = in.getLimitType();
        String limitValue = in.getLimitValue();
        String limitCycle = in.getLimitCycle();
        String effDate = in.getEffDate();
        String expDate = in.getExpDate();
        String changeFlag = in.getChangeFlag();
        

        String[] args = {serviceMsgType,
                changeReason, reqSeq, msisdn, userId, regionId, partId,
                operSource, operChannel, operId, 
                shareId, memberPhone, memberId, limitType, 
                limitValue, limitCycle, effDate, expDate, changeFlag};

        ServerInfo svrInfo = control.getPhoneRouteConf(null, "VOLUMEQRY");

        String[] outArray = null;
        try {
            VolumeClient client = new VolumeClient();
            client.getServerProxy().setServerInfo(svrInfo);
            client.setRequestArgs(args);
            ResponseData response = client.getResponseData();
            String responseString = response.getResponseString();
            outArray = responseString.split(VolumeRequestData.SPLIT_CODE);
        } catch (RuntimeException e) {
            e.printStackTrace();
            throw new BusiException("连接超时，请联系管理员");
        }

        if (!outArray[1].equals("0000")) {
            throw new BusiException(outArray[1], outArray[2]);
        }

        VolumeBookShareChangeOutDTO outParam = new VolumeBookShareChangeOutDTO();
        outParam.setReturnCode(outArray[1]);
        outParam.setReturnMsg(outArray[2]);

        log.debug("outDto=" + outParam.toJson());
    	
        return outParam;
	}

    @Override
    public OutDTO delay(InDTO inDTO) {
        VolumeBookDelayInDTO in = (VolumeBookDelayInDTO) inDTO;
        log.debug("inDto=" + in.getMbean());

        String serviceMsgType = StringUtils.isEmpty(in.getServiceMsgType()) ? "31" : in.getServiceMsgType();
        String changeReason = in.getChangeReason();
        String reqSeq = in.getReqSeq(); /*交易流水*/
        String msisdn = in.getMsisdn();
        String userId = in.getUserId();
        String regionId = in.getRegionId(); /*地市编码*/
        String partId = in.getPartId(); /*分区编码*/
        String operSource = in.getOperSource();
        String operChannel = in.getOperChannel();
        String operId = in.getOperId();

        String acctId = in.getAcctId();
        String acctType = in.getAcctType();
        String balanceId = in.getBalanceId();
        String changeValue = in.getChangeValue();
        String expDate = in.getExpDate();
        String productId = in.getProductId();

        String[] args = {
                serviceMsgType, changeReason, reqSeq, msisdn, userId, regionId, partId,
                operSource, operChannel, operId, acctId, acctType, balanceId,
                changeValue, expDate, productId};

        ServerInfo svrInfo = control.getPhoneRouteConf(null, "VOLUMEQRY");

        String[] outArray = null;
        try {
            VolumeClient client = new VolumeClient();
            client.getServerProxy().setServerInfo(svrInfo);
            client.setRequestArgs(args);
            ResponseData response = client.getResponseData();
            String responseString = response.getResponseString();
            outArray = responseString.split(VolumeRequestData.SPLIT_CODE);
        } catch (RuntimeException e) {
            e.printStackTrace();
            throw new BusiException("连接超时，请联系管理员");
        }

        if (!outArray[1].equals("0000")) {
            throw new BusiException(outArray[1], outArray[2]);
        }

        VolumeBookDelayOutDTO outParam = new VolumeBookDelayOutDTO();
        outParam.setReturnCode(outArray[1]);
        outParam.setReturnMsg(outArray[2]);
        outParam.setInBalanceId(outArray[3]);
        outParam.setBalanceId(outArray[4]);
        log.debug("outDto=" + outParam.toJson());
        return outParam;
    }

    @Override
    public OutDTO query(InDTO inDTO) {
        VolumeBookQueryInDTO in = (VolumeBookQueryInDTO) inDTO;
        log.debug("inDto=" + in.getMbean());

        String serviceMsgType = StringUtils.isEmpty(in.getServiceMsgType()) ? "40" : in.getServiceMsgType();
        String changeReason = StringUtils.isEmpty(in.getChangeReason()) ? "00" : in.getChangeReason();
        String reqSeq = in.getReqSeq(); /*交易流水*/
        String msisdn = in.getMsisdn();
        String userId = in.getUserId();
        String regionId = in.getRegionId(); /*地市编码*/
        String partId = in.getPartId(); /*分区编码*/
        String operSource = in.getOperSource();
        String operChannel = in.getOperChannel();
        String operId = in.getOperId();

        String acctType = in.getAcctType();
        String balanceType = in.getBalanceType();
        String balanceAttr = in.getBalanceAttr();
        String balanceState = in.getBalanceState();
        String queryTime = in.getQueryTime();
        String timeType = in.getTimeType();
        String queryType = in.getQueryType();
        String productId = in.getProductId();
        String queryShare = in.getQueryShare();

        String[] args = {
                serviceMsgType, changeReason, reqSeq, msisdn, userId, regionId, partId,
                operSource, operChannel, operId,
                acctType, balanceType, balanceAttr, balanceState, queryTime, timeType,
                queryType, productId, queryShare};

        ServerInfo svrInfo = control.getPhoneRouteConf(null, "VOLUMEQRY");

        String[] outArray = null;
        try {
            VolumeClient client = new VolumeClient();
            client.getServerProxy().setServerInfo(svrInfo);
            client.setRequestArgs(args);
            ResponseData response = client.getResponseData();
            String responseString = response.getResponseString();
            outArray = responseString.split(VolumeRequestData.SPLIT_CODE);
        } catch (RuntimeException e) {
            e.printStackTrace();
            throw new BusiException("连接超时，请联系管理员");
        }

        if (!outArray[1].equals("0000")) {
            throw new BusiException(outArray[1], outArray[2]);
        }

        VolumeBookQueryOutDTO outParam = new VolumeBookQueryOutDTO();

        outParam.setReturnCode(outArray[1]);
        outParam.setReturnMsg(outArray[2]);
        outParam.setQueryAllValue(outArray[3]);
        outParam.setQueryCount(outArray[4]); /*帐本返回条数*/
        int retNums = Integer.parseInt(outArray[4]);
        if (queryType.equals("1") && retNums > 0) { //查询明细，并且有返回帐本列表
            List<VolumeBookDetail> bookDetails = new ArrayList<>();
            for (int index = 5/*帐本列表开始的第一个位置*/; index < outArray.length; index++) {
                String bookInfo = outArray[index];
                String[] bookFields = StringUtils.splitByWholeSeparatorPreserveAllTokens(bookInfo, "#");

                VolumeBookDetail bookDetail = new VolumeBookDetail();
                bookDetail.setAcctType(bookFields[0]);
                bookDetail.setBalanceId(bookFields[1]);
                bookDetail.setBalanceType(bookFields[2]);
                bookDetail.setBalanceAttr(bookFields[3]);
                bookDetail.setAcctId(bookFields[4]);
                bookDetail.setValueTotal(bookFields[5]);
                bookDetail.setInitValue(bookFields[6]);
                bookDetail.setValue(bookFields[7]);
                bookDetail.setResv(bookFields[8]);
                bookDetail.setRemindFlag(bookFields[9]);
                bookDetail.setOrder(bookFields[10]);
                bookDetail.setAttrCode(bookFields[11]);
                bookDetail.setEffDate(bookFields[12]);
                bookDetail.setExpDate(bookFields[13]);
                bookDetail.setCreateDate(bookFields[14]);
                bookDetail.setState(bookFields[15]);
                bookDetail.setProductId(bookFields[16]);
                bookDetail.setSourceGroup(bookFields[17]);
                bookDetail.setShareFlag(bookFields[18]);
                bookDetail.setDelayFlag(bookFields[19]);

                bookDetails.add(bookDetail);
            }

            outParam.setBookDetails(bookDetails);

        }

        log.debug("outDto=" + outParam.toJson());
        return outParam;
    }

    @Override
    public OutDTO inAndOutQuery(InDTO inDTO) {
        VolumeBookInAndOutQueryInDTO in = (VolumeBookInAndOutQueryInDTO) inDTO;
        log.debug("inDto=" + in.getMbean());

        String serviceMsgType = StringUtils.isEmpty(in.getServiceMsgType()) ? "42" : in.getServiceMsgType();
        String changeReason = in.getChangeReason();
        String reqSeq = in.getReqSeq(); /*交易流水*/
        String msisdn = in.getMsisdn();
        String userId = in.getUserId();
        String regionId = in.getRegionId(); /*地市编码*/
        String partId = in.getPartId(); /*分区编码*/
        String operSource = in.getOperSource();
        String operChannel = in.getOperChannel();
        String operId = in.getOperId();

        String queryTime = in.getQueryTime();
        String productId = in.getProductId();

        String[] args = {
                serviceMsgType, changeReason, reqSeq, msisdn, userId, regionId, partId,
                operSource, operChannel, operId, queryTime, productId};

        ServerInfo svrInfo = control.getPhoneRouteConf(null, "VOLUMEQRY");

        String[] outArray = null;
        try {
            VolumeClient client = new VolumeClient();
            client.getServerProxy().setServerInfo(svrInfo);
            client.setRequestArgs(args);
            ResponseData response = client.getResponseData();
            String responseString = response.getResponseString();
            outArray = responseString.split(VolumeRequestData.SPLIT_CODE);
        } catch (RuntimeException e) {
            e.printStackTrace();
            throw new BusiException("连接超时，请联系管理员");
        }

        if (!outArray[1].equals("0000")) {
            throw new BusiException(outArray[1], outArray[2]);
        }

        VolumeBookInAndOutQueryOutDTO outParam = new VolumeBookInAndOutQueryOutDTO();

        outParam.setReturnCode(outArray[1]);
        outParam.setReturnMsg(outArray[2]);
        outParam.setQueryCount(outArray[3]); /*返回条数*/
        int retNums = Integer.parseInt(outArray[3]);
        List<VolumeBookInOutDetail> inOutDetails = new ArrayList<>();
        if (retNums > 0) {
            for (int index = 4/*列表开始的第一个位置*/; index < outArray.length; index++) {
                String bookInfo = outArray[index];
                String[] bookFields = StringUtils.splitByWholeSeparatorPreserveAllTokens(bookInfo, "#");

                VolumeBookInOutDetail detail = new VolumeBookInOutDetail();
                detail.setBalanceId(bookFields[0]);
                detail.setProductId(bookFields[1]);
                detail.setTradeSession(bookFields[2]);
                detail.setAcctType(bookFields[3]);
                detail.setValue(bookFields[4]);
                detail.setOperType(bookFields[5]);
                detail.setChangeReason(bookFields[6]);
                detail.setOperChannel(bookFields[7]);
                detail.setOperId(bookFields[8]);
                detail.setOperDate(bookFields[9]);
                detail.setNotes(bookFields[10]);

                inOutDetails.add(detail);
            }

            outParam.setDetails(inOutDetails);
        }

        log.debug("outDto=" + outParam.toJson());

        return outParam;
    }

    public IControl getControl() {
        return control;
    }

    public void setControl(IControl control) {
        this.control = control;
    }

	
}
