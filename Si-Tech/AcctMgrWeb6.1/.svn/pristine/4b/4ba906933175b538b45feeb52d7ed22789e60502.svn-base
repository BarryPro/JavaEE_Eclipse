package com.sitech.acctmgr.atom.impl.query;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.sitech.ac.rdc.re.api.common.util.MBean;
import com.sitech.acctmgr.atom.domains.balance.BookTypeEntity;
import com.sitech.acctmgr.atom.domains.bill.BillItemEntity;
import com.sitech.acctmgr.atom.domains.bill.ItemEntity;
import com.sitech.acctmgr.atom.domains.bill.ItemRelEntity;
import com.sitech.acctmgr.atom.domains.bill.WriteOffItemEntity;
import com.sitech.acctmgr.atom.dto.query.S8414QryItemByFirstCodeInDTO;
import com.sitech.acctmgr.atom.dto.query.S8414QryItemByFirstCodeOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8414QryItemInfoInDTO;
import com.sitech.acctmgr.atom.dto.query.S8414QryItemInfoOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8414QryPayTypeInDTO;
import com.sitech.acctmgr.atom.dto.query.S8414QryPayTypeInfoInDTO;
import com.sitech.acctmgr.atom.dto.query.S8414QryPayTypeInfoOutDTO;
import com.sitech.acctmgr.atom.dto.query.S8414QryPayTypeOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.atom.entity.inter.IBill;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.query.I8414;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({ @ParamType(c = S8414QryItemInfoInDTO.class, oc = S8414QryItemInfoOutDTO.class, m = "queryItemInfo"),
		@ParamType(c = S8414QryPayTypeInfoInDTO.class, oc = S8414QryPayTypeInfoOutDTO.class, m = "queryPayTypeInfo"),
		@ParamType(c = S8414QryPayTypeInfoInDTO.class, oc = S8414QryPayTypeInfoOutDTO.class, m = "queryDownItem"),
		@ParamType(c = S8414QryPayTypeInfoInDTO.class, oc = S8414QryPayTypeInfoOutDTO.class, m = "queryWriteItem"),
		@ParamType(c = S8414QryPayTypeInDTO.class, oc = S8414QryPayTypeOutDTO.class, m = "queryPayTypeList"),
		@ParamType(c = S8414QryItemByFirstCodeInDTO.class, oc = S8414QryItemByFirstCodeOutDTO.class, m = "querySecondItemInfoByFirstItem"),
		@ParamType(c = S8414QryItemByFirstCodeInDTO.class, oc = S8414QryItemByFirstCodeOutDTO.class, m = "queryThirdItemInfoByFirstItem"),
		@ParamType(c = S8414QryItemByFirstCodeInDTO.class, oc = S8414QryItemByFirstCodeOutDTO.class, m = "queryFirstItemInfo"), })
public class S8414 extends AcctMgrBaseService implements I8414 {

	private IBalance balance;
	private IBill bill;

	@Override
	public OutDTO queryPayTypeList(InDTO inParam) {

		S8414QryPayTypeInDTO inDto = (S8414QryPayTypeInDTO) inParam;
		Map<String, Object> inMap = new HashMap<String, Object>();

		// 查询专款列表
		List<BookTypeEntity> bookTypeList = balance.getSpPayType(inMap);

		S8414QryPayTypeOutDTO outDto = new S8414QryPayTypeOutDTO();
		outDto.setPayTypeList(bookTypeList);

		String jsonStringTmp = outDto.toJson();

		MBean mb = new MBean(jsonStringTmp);
		String jsonString = JSON.toJSONString(mb.getBodyObject("OUT_DATA"));
		log.debug("JSONSTRING:" + jsonString);
		outDto.setJsonString(jsonString);
		return outDto;
	}

	@Override
	public OutDTO queryPayTypeInfo(InDTO inParam) {

		S8414QryPayTypeInfoInDTO inDto = (S8414QryPayTypeInfoInDTO) inParam;
		Map<String, Object> inMap = new HashMap<String, Object>();

		String payType = inDto.getPayType();

		// 1.根据pay_type查询账本信息（账本类型，账本名称，是否可转等信息）
		inMap.put("PAY_TYPE", payType);
		// inMap.put("SP_FLAG", 0);
		List<BookTypeEntity> bookTypeList = balance.getSpPayType(inMap);
		if (bookTypeList.size() == 0) {
			throw new BusiException(AcctMgrError.getErrorCode("8414", "00001"), "没有查询出专款信息");
		}
		BookTypeEntity bookTypeEntity = bookTypeList.get(0);

		String payAttr = bookTypeEntity.getPayAttr();

		if (payAttr.substring(1, 2).equals("0")) {
			bookTypeEntity.setIsRefund("可退");
		} else {
			bookTypeEntity.setIsRefund("不可退");
		}

		if (payAttr.substring(2, 3).equals("0")) {
			bookTypeEntity.setIsShow("可见");
		} else {
			bookTypeEntity.setIsShow("不可见");
		}

		if (payAttr.substring(3, 4).equals("0")) {
			bookTypeEntity.setIsTrans("可转");
		} else {
			bookTypeEntity.setIsTrans("不可转");
		}

		// 2.根据pay_type从冲销计划表中查询可以冲销的账目项,根据冲销的账目项查询一级账目项，二级账目项代码和名称
		// List<WriteOffItemEntity> writeOffItemList = bill.getWriteOff(payType);
		// bookTypeEntity.setWriteOffItemList(writeOffItemList);

		// // 3.查询回收专款落地的账目项
		// List<WriteOffItemEntity> downItemList = bill.getDownItem(payType);
		//
		// bookTypeEntity.setRecycleItemConf(downItemList);

		S8414QryPayTypeInfoOutDTO outDto = new S8414QryPayTypeInfoOutDTO();
		outDto.setBookType(bookTypeEntity);
		return outDto;
	}

	@Override
	public OutDTO queryWriteItem(InDTO inParam) {
		S8414QryPayTypeInfoInDTO inDto = (S8414QryPayTypeInfoInDTO) inParam;
		// 1.根据pay_type从冲销计划表中查询可以冲销的账目项,根据冲销的账目项查询一级账目项，二级账目项代码和名称
		BookTypeEntity bookTypeEntity = new BookTypeEntity();
		Map<String, Object> outMap = bill.getWriteOff(inDto.getPayType(), inDto.getPageNum());
		List<WriteOffItemEntity> writeOffItemList = (List<WriteOffItemEntity>) outMap.get("WRITEOFF_LIST");

		bookTypeEntity.setWriteOffItemList(writeOffItemList);
		bookTypeEntity.setSum(ValueUtils.intValue(outMap.get("SUM")));
		S8414QryPayTypeInfoOutDTO outDto = new S8414QryPayTypeInfoOutDTO();
		outDto.setBookType(bookTypeEntity);
		return outDto;
	}

	@Override
	public OutDTO queryDownItem(InDTO inParam) {
		S8414QryPayTypeInfoInDTO inDto = (S8414QryPayTypeInfoInDTO) inParam;
		BookTypeEntity bookTypeEntity = new BookTypeEntity();
		// 查询回收专款落地的账目项
		List<WriteOffItemEntity> downItemList = bill.getDownItem(inDto.getPayType());

		bookTypeEntity.setRecycleItemConf(downItemList);
		S8414QryPayTypeInfoOutDTO outDto = new S8414QryPayTypeInfoOutDTO();
		outDto.setBookType(bookTypeEntity);
		return outDto;
	}

	@Override
	public OutDTO queryItemInfo(InDTO inParam) {

		S8414QryItemInfoInDTO inDto = (S8414QryItemInfoInDTO) inParam;

		String qryType = inDto.getQryType();
		// String itemCode = inDto.getItemCode();

		Map<String, Object> inMap = new HashMap<String, Object>();

		/* if (itemCode != null && !itemCode.equals("")) { inMap.put("ITEM_CODE", itemCode); } */
		if (qryType.equals("1")) {
			// 1.一级账目项查询，如果传入的一级账目项代码不为空，查询对应的二级账目项和三级账目项
			inMap.put("ITEM_LEVEL", "1");

		} else if (qryType.equals("2")) {
			// 2.二级账目项查询，如果传入的二级账目项代码不为空，查询对应的一级账目项和三级账目项
			inMap.put("ITEM_LEVEL", "3");

		} else if (qryType.equals("3")) {
			inMap.put("ITEM_LEVEL", "4");
		}
		ItemRelEntity writeOff = bill.getItemList(inMap);

		S8414QryItemInfoOutDTO outDto = new S8414QryItemInfoOutDTO();
		outDto.setAcctItemList(writeOff);
		String jsonStringTmp = outDto.toJson();

		MBean mb = new MBean(jsonStringTmp);
		String jsonString = "";
		jsonString = JSON.toJSONString(mb.getBodyObject("OUT_DATA.ACCT_ITEM_LIST"));
		log.debug("JSONSTRING:" + jsonString);

		outDto.setJsonString(jsonString);
		return outDto;
	}

	@Override
	public OutDTO querySecondItemInfoByFirstItem(InDTO inParam) {
		S8414QryItemByFirstCodeInDTO inDto = (S8414QryItemByFirstCodeInDTO) inParam;
		String pageNum = inDto.getPageNum();
		String itemCode = inDto.getItemCode();
		String queryType = inDto.getQueryType();
		log.debug("queryType:" + queryType);
		log.debug("pageNum:" + pageNum);

		Map<String, Object> outMap = new HashMap<>();
		List<ItemEntity> itemList = new ArrayList<ItemEntity>();
		int totalNum = 0;
		if (queryType.equals("1")) {
			outMap = bill.getItemRel("2", itemCode, Integer.parseInt(pageNum));
		} else if (queryType.equals("3")) {
			outMap = bill.getItemRelByChild(itemCode, "2");
		} else {
			S8414QryItemByFirstCodeOutDTO outDto = new S8414QryItemByFirstCodeOutDTO();
			outDto.setItemList(itemList);
			outDto.setTotalNum(totalNum);
			return outDto;
		}
		log.debug("outMap:>>>>>" + outMap);
		// Map<String, Object>
		List<Map<String, Object>> itemInfoList = (List<Map<String, Object>>) outMap.get("result");
		totalNum = (int) outMap.get("sum");

		log.debug("itemInfoList:" + itemInfoList);
		log.debug("totalNum:" + totalNum);

		for (Map<String, Object> itemMap : itemInfoList) {
			String itemId = itemMap.get("ITEM_ID").toString();
			// 查询账目项名称
			log.debug("itemId" + itemId);
			BillItemEntity billItemEntity = bill.getBillItemConf(itemId);
			ItemEntity item = new ItemEntity();
			item.setItemCode(itemId);
			item.setItemName(billItemEntity.getItemName());
			itemList.add(item);
		}
		S8414QryItemByFirstCodeOutDTO outDto = new S8414QryItemByFirstCodeOutDTO();
		outDto.setItemList(itemList);
		outDto.setTotalNum(totalNum);
		return outDto;
	}

	@Override
	public OutDTO queryThirdItemInfoByFirstItem(InDTO inParam) {
		S8414QryItemByFirstCodeInDTO inDto = (S8414QryItemByFirstCodeInDTO) inParam;
		String pageNum = inDto.getPageNum();
		String itemCode = inDto.getItemCode();
		log.debug("pageNum:" + pageNum);
		Map<String, Object> outMap = bill.getItemRel("3", itemCode, Integer.parseInt(pageNum));
		List<Map<String, Object>> itemInfoList = (List<Map<String, Object>>) outMap.get("result");
		int totalNum = (int) outMap.get("sum");

		log.debug("itemInfoList:" + itemInfoList);
		log.debug("totalNum:" + totalNum);
		List<ItemEntity> itemList = new ArrayList<ItemEntity>();
		for (Map<String, Object> itemMap : itemInfoList) {
			String itemId = itemMap.get("ITEM_ID").toString();
			// 查询账目项名称
			log.debug("itemId" + itemId);
			BillItemEntity billItemEntity = bill.getItemConf(itemId);
			ItemEntity item = new ItemEntity();
			item.setItemCode(itemId);
			item.setItemName(billItemEntity.getItemName());
			itemList.add(item);
		}

		S8414QryItemByFirstCodeOutDTO outDto = new S8414QryItemByFirstCodeOutDTO();
		outDto.setItemList(itemList);
		outDto.setTotalNum(totalNum);
		return outDto;
	}

	public OutDTO queryFirstItemInfo(InDTO inParam) {
		S8414QryItemByFirstCodeInDTO inDTO = (S8414QryItemByFirstCodeInDTO) inParam;
		String itemCode = inDTO.getItemCode();
		Map<String, Object> outMap = bill.getItemRelByChild(itemCode, "0");
		// Map<String, Object>
		List<Map<String, Object>> itemInfoList = (List<Map<String, Object>>) outMap.get("result");
		List<ItemEntity> itemList = new ArrayList<ItemEntity>();
		int totalNum = (int) outMap.get("sum");

		log.debug("itemInfoList:" + itemInfoList);
		log.debug("totalNum:" + totalNum);

		for (Map<String, Object> itemMap : itemInfoList) {
			String itemId = itemMap.get("ITEM_ID").toString();
			// 查询账目项名称
			log.debug("itemId" + itemId);
			BillItemEntity billItemEntity = bill.getBillItemConf(itemId);
			ItemEntity item = new ItemEntity();
			item.setItemCode(itemId);
			item.setItemName(billItemEntity.getItemName());
			itemList.add(item);
		}
		S8414QryItemByFirstCodeOutDTO outDto = new S8414QryItemByFirstCodeOutDTO();
		outDto.setItemList(itemList);
		outDto.setTotalNum(totalNum);
		return outDto;
	}

	public IBalance getBalance() {
		return balance;
	}

	public void setBalance(IBalance balance) {
		this.balance = balance;
	}

	public IBill getBill() {
		return bill;
	}

	public void setBill(IBill bill) {
		this.bill = bill;
	}

}
