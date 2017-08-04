package com.sitech.acctmgr.atom.dto.query;

import java.util.ArrayList;
import java.util.List;

import com.sitech.acctmgr.atom.domains.query.WxPayEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SWxPayQryOutDTO extends CommonOutDTO{

		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
		@ParamDesc(path="REGION_NAME",cons= ConsType.CT001,type="string",len="20",desc="地市",memo="略")
		private String regionName;
		@ParamDesc(path="PAY_LIST",cons=ConsType.STAR,type="complex",len="1",desc="缴费列表",memo="略")
		private List<WxPayEntity> paymentList = new ArrayList<WxPayEntity>();

		@Override
		public MBean encode() {
			MBean result = new MBean();
			result.setRoot(getPathByProperName("paymentList"), paymentList);
			
			return result;
		}

		/**
		 * @return the paymentList
		 */
		public List<WxPayEntity> getPaymentList() {
			return paymentList;
		}

		/**
		 * @param paymentList the paymentList to set
		 */
		public void setPaymentList(List<WxPayEntity> paymentList) {
			this.paymentList = paymentList;
		}

	
}
