package com.sitech.acctmgr.atom.impl.invoice;

import java.util.List;

import com.sitech.acctmgr.atom.domains.invoice.TtWcityinvoice;
import com.sitech.acctmgr.atom.domains.invoice.TtWdisinvoice;
import com.sitech.acctmgr.atom.domains.invoice.TtWgroupinvoice;
import com.sitech.acctmgr.atom.dto.invoice.S2313InDTO;
import com.sitech.acctmgr.atom.dto.invoice.S2313OutDTO;
import com.sitech.acctmgr.atom.entity.inter.IControl;
import com.sitech.acctmgr.atom.entity.inter.IGroup;
import com.sitech.acctmgr.atom.entity.inter.IInvoice;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.DateUtils;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.invoice.I2313;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(c = S2313InDTO.class, m = "regionEnter", oc = S2313OutDTO.class),
		@ParamType(c = S2313InDTO.class, m = "distinctEnter", oc = S2313OutDTO.class),
		@ParamType(c = S2313InDTO.class, m = "groupEnter", oc = S2313OutDTO.class) })
public class S2313 extends AcctMgrBaseService implements I2313 {
	private IGroup group;
	private IInvoice invoice;
	private IControl control;
	
	@Override
	public OutDTO regionEnter(InDTO inParam) {
		S2313InDTO inDto = (S2313InDTO) inParam;

		String invCode = inDto.getInvCode();
		int beginNo = inDto.getBeginNo();
		int endNo = inDto.getEndNo();


		String groupId = inDto.getRegionGroupId();
		// 查询发票代码下所有的发票号码，判断发票号码以前是否已经录入过
		List<TtWcityinvoice> cityInvoiceList = invoice.getCityInovice(invCode, "");
		boolean flag = isCityEnter(cityInvoiceList, beginNo, endNo);
		if(flag){
			throw new BusiException(AcctMgrError.getErrorCode("2313", "00002"), "该发票段已经录入过，请核查！");
		}

		// 入表
		TtWcityinvoice cityInvoice = new TtWcityinvoice();
		long loginAccept = control.getSequence("SEQ_SYSTEM_SN");
		cityInvoice.seteInvoiceNumber(endNo + "");
		cityInvoice.setFlag("N");
		cityInvoice.setInvoiceCode(invCode);
		cityInvoice.setInvoiceNumber("0");
		cityInvoice.setLoginAccept(loginAccept);
		cityInvoice.setLoginNo(inDto.getLoginNo());
		cityInvoice.setRegionCode(groupId);
		cityInvoice.setsInvoiceNumber(beginNo + "");
		cityInvoice.setYearMonth(DateUtils.getCurYm());
		invoice.insCityInvoice(cityInvoice);

		S2313OutDTO outDto = new S2313OutDTO();
		outDto.setLoginAccept(loginAccept);
		return outDto;
	}

	@Override
	public OutDTO distinctEnter(InDTO inParam) {
		S2313InDTO inDto = (S2313InDTO) inParam;
		String invCode = inDto.getInvCode();
		int beginNo = inDto.getBeginNo();
		int endNo = inDto.getEndNo();

		String regionGroupId = inDto.getRegionGroupId();
		String disGroupId = inDto.getDistinctGroupId();
		// 查询该地市下发票代码下有哪些发票号码
		boolean isEntered = isCityEnter(invCode, regionGroupId, beginNo, endNo);
		if (!isEntered) {
			throw new BusiException(AcctMgrError.getErrorCode("2313", "00003"), "此段发票号码段不属于该地市，请重新输入！");
		}
		// 判断这段发票有没有占用过
		boolean occupyFlag = isOccupyByOtherDis(invCode, regionGroupId, beginNo, endNo);
		if (occupyFlag) {
			throw new BusiException(AcctMgrError.getErrorCode("2313", "00004"), "此段发票号码已被其他区县录入，请重新输入");
		}
		// 入区县发票领取表
		TtWdisinvoice disInvoice = new TtWdisinvoice();
		long loginAccept = control.getSequence("SEQ_SYSTEM_SN");
		disInvoice.setEInvoiceNumber(endNo + "");
		disInvoice.setFlag("N");
		disInvoice.setInvoiceCode(invCode);
		disInvoice.setInvoiceNumber("0");
		disInvoice.setLoginAccept(loginAccept);
		disInvoice.setLoginNo(inDto.getLoginNo());
		disInvoice.setRegionCode(regionGroupId);
		disInvoice.setSInvoiceNumber(beginNo + "");
		disInvoice.setDistrictCode(disGroupId);
		disInvoice.setYearMonth(DateUtils.getCurYm());
		invoice.insDisInvoice(disInvoice);

		S2313OutDTO outDto = new S2313OutDTO();
		outDto.setLoginAccept(loginAccept);
		return outDto;
	}

	@Override
	public OutDTO groupEnter(InDTO inParam) {
		S2313InDTO inDto = (S2313InDTO) inParam;
		String invCode = inDto.getInvCode();
		int beginNo = inDto.getBeginNo();
		int endNo = inDto.getEndNo();

		String regionGroupId = inDto.getRegionGroupId();
		String disGroupId = inDto.getDistinctGroupId();
		String groupId = inDto.getGroupId();

		// 获取地市发票代码下的所有发票号
		boolean enteredFlag = isEnterDis(invCode, regionGroupId, disGroupId, beginNo, endNo);
		if (!enteredFlag) {
			throw new BusiException(AcctMgrError.getErrorCode("2313", "00005"), "此段发票号码不属于该区县，请重新输入！");
		}
		// 判断该发票段是否被其他营业厅领取
		boolean occupyedFlag = isOccupyByOtherGroup(regionGroupId, disGroupId, invCode, beginNo, endNo);
		if (occupyedFlag) {
			throw new BusiException(AcctMgrError.getErrorCode("2313", "00006"), "此段发票号码已被其他营业厅录入，请重新输入！");
		}

		TtWgroupinvoice groupInvoice = new TtWgroupinvoice();
		long loginAccept = control.getSequence("SEQ_SYSTEM_SN");
		groupInvoice.setEInvoiceNumber(endNo + "");
		groupInvoice.setFlag("N");
		groupInvoice.setInvoiceCode(invCode);
		groupInvoice.setInvoiceNumber("0");
		groupInvoice.setLoginAccept(loginAccept);
		groupInvoice.setLoginNo(inDto.getLoginNo());
		groupInvoice.setRegionCode(regionGroupId);
		groupInvoice.setSInvoiceNumber(beginNo + "");
		groupInvoice.setDistrictCode(disGroupId);
		groupInvoice.setYearMonth(DateUtils.getCurYm());
		groupInvoice.setGroupId(groupId);
		invoice.insGroupInvoice(groupInvoice);

		S2313OutDTO outDto = new S2313OutDTO();
		outDto.setLoginAccept(loginAccept);
		return outDto;
	}

	
	/**
	 * 判断发票代码和发票号码有没有录入过
	 * 
	 * @param cityInvoiceList
	 * @param beginNo
	 * @param endNo
	 * @return
	 */
	private boolean isCityEnter(List<TtWcityinvoice> cityInvoiceList, int beginNo, int endNo) {
		int flag = 0;
		for (TtWcityinvoice cityInvoice : cityInvoiceList) {
			String sInvoiceNumber = cityInvoice.getsInvoiceNumber();
			String eInvoiceNumber = cityInvoice.geteInvoiceNumber();
			int enteredBegin = Integer.parseInt(sInvoiceNumber);
			int enteredEnd = Integer.parseInt(eInvoiceNumber);
			log.debug("beginNo >= enteredBegin:" + (beginNo >= enteredBegin && beginNo <= enteredEnd));
			log.debug("(endNo >= enteredBegin && endNo <= enteredEnd):" + (endNo >= enteredBegin && endNo <= enteredEnd));
			if (beginNo >= enteredBegin && beginNo <= enteredEnd || (endNo >= enteredBegin && endNo <= enteredEnd)) {
				flag = 1;
				break;
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * 判断这段发票在地市区间内有没有被录入
	 * 
	 * @param invCode
	 * @param groupId
	 * @param beginNo
	 * @param endNo
	 * @return
	 */
	private boolean isCityEnter(String invCode, String groupId, int beginNo, int endNo) {
		List<TtWcityinvoice> cityList = invoice.getCityInovice(invCode, groupId);
		boolean flag = false;
		for (TtWcityinvoice cityInovice : cityList) {
			String sInvoiceNum = cityInovice.getsInvoiceNumber();
			String eInvoiceNum = cityInovice.geteInvoiceNumber();

			int enteredBegin = ValueUtils.intValue(sInvoiceNum);
			int enteredEnd = ValueUtils.intValue(eInvoiceNum);
			log.debug("beginNo >= enteredBegin:" + (beginNo >= enteredBegin));
			log.debug("endNo <= enteredEnd" + (endNo <= enteredEnd));
			log.debug("beginNo >= enteredBegin && endNo <= enteredEnd" + (beginNo >= enteredBegin && endNo <= enteredEnd));
			if (beginNo >= enteredBegin && endNo <= enteredEnd) {
				flag = true;
				break;
			}
			if (beginNo >= enteredBegin && endNo >= enteredEnd) {
				beginNo = enteredEnd + 1;
				log.debug("开始号码在此区间内  剩下的开始号码为：" + beginNo);
			}
			if (beginNo <= enteredBegin && endNo >= enteredBegin) {
				endNo = beginNo - 1;
				log.debug("结束号码在此区间内  剩下的结束号码为：" + enteredEnd);
			}
		}
		return flag;
	}
	
	/**
	 * 判断该发票段有没有被其他省占用
	 * 
	 * @param invCode
	 * @param groupId
	 * @param beginNo
	 * @param endNo
	 * @return
	 */
	private boolean isOccupyByOtherDis(String invCode, String groupId, int beginNo, int endNo) {
		List<TtWdisinvoice> distinctInvoiceList = invoice.getDistinctInvoice(invCode, groupId, "");
		boolean flag = false;
		for (TtWdisinvoice distinctInvoice : distinctInvoiceList) {
			String beginNumber = distinctInvoice.getSInvoiceNumber();
			String endNumber = distinctInvoice.getEInvoiceNumber();

			int beginNum = ValueUtils.intValue(beginNumber);
			int endNum = ValueUtils.intValue(endNumber);
			if ((beginNo >= beginNum && beginNo <= endNo) || (endNo >= beginNum && endNo <= endNum)) {
				flag = true;
				break;
			}
		}
		return flag;
	}

	/**
	 * 该区县是否录入过发票
	 * 
	 * @param invCode
	 * @param regGroup
	 * @param disGroup
	 * @param beginNo
	 * @param endNo
	 * @return
	 */
	private boolean isEnterDis(String invCode, String regGroup, String disGroup, int beginNo, int endNo) {
		boolean flag = false;
		// 查询该区县录入的所有发票信息
		List<TtWdisinvoice> disInvList = invoice.getDistinctInvoice(invCode, regGroup, disGroup);
		for (TtWdisinvoice disInv : disInvList) {
			String sInvoiceNum = disInv.getSInvoiceNumber();
			String eInvoiceNum = disInv.getEInvoiceNumber();

			int enteredBegin = ValueUtils.intValue(sInvoiceNum);
			int enteredEnd = ValueUtils.intValue(eInvoiceNum);

			if (beginNo >= enteredBegin && endNo <= enteredEnd) {
				flag = true;
				break;
			}
			if (beginNo >= enteredBegin && endNo >= enteredEnd) {
				beginNo = enteredEnd + 1;
			}
			if (beginNo <= enteredBegin && endNo >= enteredBegin) {
				endNo = beginNo - 1;
			}
		}
		return flag;
	}
	
	/**
	 * 是否被其他营业厅占用
	 * 
	 * @param regionGroup
	 * @param disGroup
	 * @param invCode
	 * @param beginNo
	 * @param endNo
	 * @return
	 */
	private boolean isOccupyByOtherGroup(String regionGroup, String disGroup, String invCode, int beginNo, int endNo) {
		boolean flag = false;
		List<TtWgroupinvoice> groupInvoiceList = invoice.getGroupInvoice(invCode, regionGroup, disGroup, "");
		for (TtWgroupinvoice groupInvoice : groupInvoiceList) {
			String beginNumber = groupInvoice.getSInvoiceNumber();
			String endNumber = groupInvoice.getEInvoiceNumber();

			int beginNum = ValueUtils.intValue(beginNumber);
			int endNum = ValueUtils.intValue(endNumber);
			if ((beginNo >= beginNum && beginNo <= endNo) || (endNo >= beginNum && endNo <= endNum)) {
				flag = true;
				break;
			}
		}
		return flag;
	}

	public IGroup getGroup() {
		return group;
	}

	public void setGroup(IGroup group) {
		this.group = group;
	}

	public IInvoice getInvoice() {
		return invoice;
	}

	public void setInvoice(IInvoice invoice) {
		this.invoice = invoice;
	}

	public IControl getControl() {
		return control;
	}

	public void setControl(IControl control) {
		this.control = control;
	}

}
