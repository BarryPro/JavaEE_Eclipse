package com.sitech.acctmgr.atom.domains.pay;

import java.io.Serializable;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.common.constant.PayBusiConst;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 核心预存款对象
 * @version 1.0
 */
public class OriginEntity implements Serializable{

		private static final long serialVersionUID = -7969032439603652630L;

		@JSONField(name = "BUSI_CODE")
		@ParamDesc(path="BUSI_CODE",cons=ConsType.CT001,type="String",len="20",desc="",memo="略")
		private String busiCode;
		
		@JSONField(name = "ORIGIN_ORDER_LINE_ID")
		@ParamDesc(path="ORIGIN_ORDER_LINE_ID",cons=ConsType.CT001,type="String",len="40",desc="原始订单行号",memo="略")
		private String originOrderLineid;
		
		@JSONField(name = "ORIGIN_TIME")
		@ParamDesc(path="ORIGIN_TIME",cons=ConsType.CT001,type="String",len="14",desc="原始操作间",memo="格式：YYYYMMDDHH24MISS")
		private String originTime;
		
		@JSONField(name = "PHONE_NO")
		@ParamDesc(path="PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
		private String phoneNo;
		
		@JSONField(name = "CONTRACT_NO")
		@ParamDesc(path="CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="账号",memo="略")
		private long contractNo;

		@JSONField(name = "PAY_TYPE")
		@ParamDesc(path="PAY_TYPE",cons=ConsType.CT001,type="String",len="5",desc="账本类型",memo="略")
		private String payType;
		
		@JSONField(name = "RETURN_MONTH")
		@ParamDesc(path="RETURN_MONTH",cons=ConsType.CT001,type="String",len="10",desc="返还月数",memo="")
		private String returnMonth;
		
		@JSONField(name = "BEGIN_TIME")
		@ParamDesc(path="BEGIN_TIME",cons=ConsType.CT001,type="String",len="14",desc="第一笔生效时间",memo="")
		private String beginTime;
		
		@JSONField(name = "REMARK")
		@ParamDesc(path="REMARK",cons=ConsType.QUES,type="String",len="200",desc="备注",memo=" ")
		private String remark;

		/* (non-Javadoc)
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString() {
			return "OriginEntity [busiCode=" + busiCode + ", originOrderLineid=" + originOrderLineid + ", originTime=" + originTime
					+ ", phoneNo=" + phoneNo + ", contractNo=" + contractNo + ", payType=" + payType + ", returnMonth=" + returnMonth
					+ ", beginTime=" + beginTime + ", remark=" + remark + "]";
		}

		public String getBusiCode() {
			return busiCode;
		}

		public void setBusiCode(String busiCode) {
			this.busiCode = busiCode;
		}

		public String getOriginOrderLineid() {
			return originOrderLineid;
		}

		public void setOriginOrderLineid(String originOrderLineid) {
			this.originOrderLineid = originOrderLineid;
		}

		public String getOriginTime() {
			return originTime;
		}

		public void setOriginTime(String originTime) {
			this.originTime = originTime;
		}

		public String getPhoneNo() {
			return phoneNo;
		}

		public void setPhoneNo(String phoneNo) {
			this.phoneNo = phoneNo;
		}

		public long getContractNo() {
			return contractNo;
		}

		public void setContractNo(long contractNo) {
			this.contractNo = contractNo;
		}

		public String getPayType() {
			return payType;
		}

		public void setPayType(String payType) {
			this.payType = payType;
		}

		public String getReturnMonth() {
			return returnMonth;
		}

		public void setReturnMonth(String returnMonth) {
			this.returnMonth = returnMonth;
		}

		public String getBeginTime() {
			return beginTime;
		}

		public void setBeginTime(String beginTime) {
			this.beginTime = beginTime;
		}

		public String getRemark() {
			return remark;
		}

		public void setRemark(String remark) {
			this.remark = remark;
		}
	
}
