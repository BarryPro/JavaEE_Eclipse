package com.sitech.acctmgr.atom.impl.feeqry;

import com.sitech.acctmgr.atom.busi.query.inter.IRemainFee;
import com.sitech.acctmgr.atom.domains.fee.OutFeeData;
import com.sitech.acctmgr.atom.domains.user.ServAddNumEntity;
import com.sitech.acctmgr.atom.domains.user.UserInfoEntity;
import com.sitech.acctmgr.atom.dto.feeqry.SGMBalanceQueryInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SGMBalanceQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.constant.CommonConst;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.inter.feeqry.IGMBalance;
import com.sitech.acctmgrint.atom.busi.intface.IShortMessage;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.HashMap;
import java.util.Map;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

/**
 * Created by wangyla on 2017/5/10.
 */
@ParamTypes({
        @ParamType(c = SGMBalanceQueryInDTO.class, m = "query", oc = SGMBalanceQueryOutDTO.class, srvName = "com_sitech_acctmgr_inter_feeqry_IGMBalanceSvc_query")
})
public class SGMBalance extends AcctMgrBaseService implements IGMBalance {
    private IUser user;
    private IRemainFee remainFee;
    private IControl control;
    private IShortMessage shortMessage;

    @Override
    public OutDTO query(InDTO inParam) {

        SGMBalanceQueryInDTO inDto = (SGMBalanceQueryInDTO) inParam;
        log.debug("inDto=" + inDto.getMbean());

        String phoneNo = inDto.getPhoneNo();
        String smsSendFlag = inDto.getSendFlag();

        ServAddNumEntity addNumEnt = user.getPhoneNoByAsn(phoneNo, CommonConst.NBR_TYPE_WLW, false);
        phoneNo = (addNumEnt != null) ? addNumEnt.getPhoneNo() : phoneNo;

        UserInfoEntity userInfo = user.getUserEntityByPhoneNo(phoneNo, true);
        long contractNo = userInfo.getContractNo();

        OutFeeData outFee = remainFee.getConRemainFee(contractNo);

        String curDate = DateUtils.getCurDate(DateUtils.DATE_FORMAT_YYYYMMDDHHMISS);

        if (smsSendFlag != null && smsSendFlag.equals("Y")) {
            Map<String, Object> msgData = new HashMap<>();
            safeAddToMap(msgData, "cur_date", curDate);
            safeAddToMap(msgData, "cur_balance", String.format("%.2f", outFee.getRemainFee() / 100.0));

            MBean msgBean = new MBean();
            msgBean.addBody("PHONE_NO", phoneNo);
            msgBean.addBody("LOGIN_NO", inDto.getLoginNo());
            ;
            msgBean.addBody("OP_CODE", inDto.getOpCode());
            msgBean.addBody("CHECK_FLAG", true);
            msgBean.addBody("DATA", msgData);
            msgBean.addBody("TEMPLATE_ID", "311100000002"); /*国漫平台话费余额查询发送短信*/
            String sendFlag = control.getPubCodeValue(2011, "DXFS", null); // 0:直接发送 1:插入短信接口临时表 2：外系统有问题，直接不发送短信
            if (sendFlag.equals("0")) {
                msgBean.addBody("SEND_FLAG", 0);
            } else if (sendFlag.equals("1")) {
                msgBean.addBody("SEND_FLAG", 1);
            } else if (sendFlag.equals("2")) {

            }

            if (sendFlag.charAt(0) != '2') {
                shortMessage.sendSmsMsg(msgBean);
            }
        }

        SGMBalanceQueryOutDTO outDto = new SGMBalanceQueryOutDTO();
        outDto.setCurDate(curDate);
        outDto.setCurBalance(outFee.getRemainFee());
        outDto.setPrepayFee(outFee.getPrepayFee());
        outDto.setDelayFee(outFee.getDelayFee());

        log.debug("outDto=" + outDto.toJson());
        return outDto;
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

    public IRemainFee getRemainFee() {
        return remainFee;
    }

    public void setRemainFee(IRemainFee remainFee) {
        this.remainFee = remainFee;
    }

    public IControl getControl() {
        return control;
    }

    public void setControl(IControl control) {
        this.control = control;
    }

    public IShortMessage getShortMessage() {
        return shortMessage;
    }

    public void setShortMessage(IShortMessage shortMessage) {
        this.shortMessage = shortMessage;
    }
}
