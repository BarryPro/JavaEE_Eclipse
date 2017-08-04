package com.sitech.acctmgr.atom.dto.detail;

import com.sitech.acctmgr.atom.domains.detail.ChannelDetail;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

public class SDetailSmsStatsOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = 8838165671510924111L;

	@ParamDesc(path = "SMS_COUNT", cons = ConsType.CT001, len = "8", type = "int", desc = "短信总条数", memo = "略")
	private int smsCount;

	@ParamDesc(path = "MMS_COUNT", cons = ConsType.CT001, len = "8", type = "int", desc = "彩信总条数", memo = "略")
	private int mmsCount;

	@ParamDesc(path = "SS_COUNT", cons = ConsType.CT001, len = "8", type = "int", desc = "普通短信条数", memo = "略")
	private int ssCount;

	@ParamDesc(path = "CD_COUNT", cons = ConsType.CT001, len = "8", type = "int", desc = "移动彩信条数", memo = "略")
	private int cdCount;

	@ParamDesc(path = "SI_COUNT", cons = ConsType.CT001, len = "8", type = "int", desc = "国际短信条数", memo = "略")
	private int siCount;

	@ParamDesc(path = "CI_COUNT", cons = ConsType.CT001, len = "8", type = "int", desc = "国际彩信条数", memo = "略")
	private int ciCount;

	@ParamDesc(path = "SG_COUNT", cons = ConsType.CT001, len = "8", type = "int", desc = "互联网短信条数", memo = "略")
	private int sgCount;

	@ParamDesc(path = "CG_COUNT", cons = ConsType.CT001, len = "8", type = "int", desc = "互联网彩信条数", memo = "略")
	private int cgCount;

	@ParamDesc(path = "SC_COUNT", cons = ConsType.CT001, len = "8", type = "int", desc = "短号短信条数", memo = "略")
	private int scCount;

	@ParamDesc(path = "MC_COUNT", cons = ConsType.CT001, len = "8", type = "int", desc = "行业网关短信条数", memo = "略")
	private int mcCount;

	@ParamDesc(path = "SMS_SEND_COUNT", cons = ConsType.CT001, len = "8", type = "int", desc = "短信总发送条数", memo = "略")
	private int smsSendCount;

	@ParamDesc(path = "SMS_RECV_COUNT", cons = ConsType.CT001, len = "8", type = "int", desc = "短信总接收条数", memo = "略")
	private int smsRecvCount;

	@ParamDesc(path = "MMS_SEND_COUNT", cons = ConsType.CT001, len = "8", type = "int", desc = "彩信总发送条数", memo = "略")
	private int mmsSendCount;

	@ParamDesc(path = "MMS_RECV_COUNT", cons = ConsType.CT001, len = "8", type = "int", desc = "彩信总接收条数", memo = "略")
	private int mmsRecvCount;



	@Override
	public MBean encode() {
		MBean result = super.encode();
		result.setRoot(getPathByProperName("smsCount"), smsCount);
		result.setRoot(getPathByProperName("mmsCount"), mmsCount);
		result.setRoot(getPathByProperName("ssCount"), ssCount);
		result.setRoot(getPathByProperName("cdCount"), cdCount);
		result.setRoot(getPathByProperName("siCount"), siCount);
		result.setRoot(getPathByProperName("ciCount"), ciCount);
		result.setRoot(getPathByProperName("sgCount"), sgCount);
		result.setRoot(getPathByProperName("cgCount"), cgCount);
		result.setRoot(getPathByProperName("scCount"), scCount);
		result.setRoot(getPathByProperName("mcCount"), mcCount);
		result.setRoot(getPathByProperName("smsSendCount"), smsSendCount);
		result.setRoot(getPathByProperName("smsRecvCount"), smsRecvCount);
		result.setRoot(getPathByProperName("mmsSendCount"), mmsSendCount);
		result.setRoot(getPathByProperName("mmsRecvCount"), mmsRecvCount);

		return result;
	}

	public int getSmsCount() {
		return smsCount;
	}

	public void setSmsCount(int smsCount) {
		this.smsCount = smsCount;
	}

	public int getMmsCount() {
		return mmsCount;
	}

	public void setMmsCount(int mmsCount) {
		this.mmsCount = mmsCount;
	}

	public int getSsCount() {
		return ssCount;
	}

	public void setSsCount(int ssCount) {
		this.ssCount = ssCount;
	}

	public int getCdCount() {
		return cdCount;
	}

	public void setCdCount(int cdCount) {
		this.cdCount = cdCount;
	}

	public int getSiCount() {
		return siCount;
	}

	public void setSiCount(int siCount) {
		this.siCount = siCount;
	}

	public int getCiCount() {
		return ciCount;
	}

	public void setCiCount(int ciCount) {
		this.ciCount = ciCount;
	}

	public int getSgCount() {
		return sgCount;
	}

	public void setSgCount(int sgCount) {
		this.sgCount = sgCount;
	}

	public int getCgCount() {
		return cgCount;
	}

	public void setCgCount(int cgCount) {
		this.cgCount = cgCount;
	}

	public int getScCount() {
		return scCount;
	}

	public void setScCount(int scCount) {
		this.scCount = scCount;
	}

	public int getMcCount() {
		return mcCount;
	}

	public void setMcCount(int mcCount) {
		this.mcCount = mcCount;
	}

	public int getSmsSendCount() {
		return smsSendCount;
	}

	public void setSmsSendCount(int smsSendCount) {
		this.smsSendCount = smsSendCount;
	}

	public int getSmsRecvCount() {
		return smsRecvCount;
	}

	public void setSmsRecvCount(int smsRecvCount) {
		this.smsRecvCount = smsRecvCount;
	}

	public int getMmsSendCount() {
		return mmsSendCount;
	}

	public void setMmsSendCount(int mmsSendCount) {
		this.mmsSendCount = mmsSendCount;
	}

	public int getMmsRecvCount() {
		return mmsRecvCount;
	}

	public void setMmsRecvCount(int mmsRecvCount) {
		this.mmsRecvCount = mmsRecvCount;
	}
}
