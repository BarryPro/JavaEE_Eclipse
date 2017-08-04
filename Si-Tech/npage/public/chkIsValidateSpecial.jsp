<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.Map"%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String workNo = (String) session.getAttribute("workNo");
	//String[][] favInfo =(String[][])session.getAttribute("favInfo");//优惠代码列表36
	String verifyVal = WtcUtil.repNull(request.getParameter("verifyVal"));
	
	String retCode = "000000";
	
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
%>
	<wtc:service  name="sGetBroadPhone"  routerKey="region" routerValue="<%=regionCode%>" 
		 outnum="2"  retcode="errCodeGetPhone" retmsg="errMsgGetPhone">
			<wtc:param  value="0"/>
			<wtc:param  value="01"/>
			<wtc:param  value=""/>
			<wtc:param  value="<%=workNo%>"/>
			<wtc:param  value=""/>
			<wtc:param  value=""/>
			<wtc:param  value=""/>
			<wtc:param  value="<%=phoneNo%>"/>
	  </wtc:service>
  	<wtc:array id="list" scope="end"/>
<%
	if("000000".equals(errCodeGetPhone) && list.length >0){
		String cmfLogin = list[0][1];
		if(!"".equals(cmfLogin)){
			/*说明输入的是宽带对应的手机号码*/
			phoneNo = phoneNo;
		}else{
			phoneNo = list[0][0];
		}
	}
  System.out.println("====gaopengSeeLogchkisChkIsValidate==== verifyVal 1= " + verifyVal);
  
	Map tmap = (Map)session.getAttribute("contactTimeMap");
	tmap.put("p|" + opCode, verifyVal);
	if(!"".equals(phoneNo)) {	//二级tab
		if (verifyVal.indexOf("1") != -1) {	//数据显示需要验证密码
			Map map = (Map)session.getAttribute("contactInfoMap");
			ContactInfo contactInfo = new ContactInfo();
			map.put(phoneNo,contactInfo);
			ContactInfo contactInfo2 = (ContactInfo) map.get(phoneNo);
			/*放一个值，这样 contactInfo 就不是空了 */
		 	contactInfo2.setPasswd_status(verifyVal);  //
				System.out.println("====gaopengSeeLogchkis==== retCode 2= 272727");
				String dateStr=new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
				java.text.SimpleDateFormat myFormatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
				
				String date1tmp = (String)tmap.get(phoneNo + "|x");
				
			System.out.println("====gaopengSeeLogchkis==== date1tmp 2= date1tmp==="+date1tmp);
				if (date1tmp == null) {
				System.out.println("====gaopengSeeLogchkis==== retCode 2= 353535");
				/*2015/7/13 9:59:31 gaopeng R_CMI_HLJ_guanjg_2015_2303829@关于优化实名标识系列功能的需求示 
					放进去一个新的时间
				*/
				//tmap.put(phoneNo + "|x", dateStr);
					retCode = "000003";	//第一次打开此2级Tab
				} else {
					System.out.println("====gaopengSeeLogchkis==== retCode 2= 28");
					java.util.Date date1 = myFormatter.parse(date1tmp); 
					java.util.Date mydate= myFormatter.parse(dateStr);
					long day1=(mydate.getTime()-date1.getTime())/(60*1000);
					Long day2=new Long(day1);
					
					if(day1>30){	//超过30分钟
						retCode = "000002";
					} else {
						retCode = "000000";
						tmap.put(phoneNo + "|x", dateStr);
						tmap.put("x|" + opCode, "pwdValidate");
					}
				}
			
		} else {	//数据显示不需要验证密码
			retCode = "000000";
			tmap.put("x|" + opCode, "pwdValidate");
		}
	} else {	//一级tab
		System.out.println("====wanghfa==== verifyVal 2= " + verifyVal);
		if (verifyVal.indexOf("1") != -1) {
			tmap.put("x|" + opCode, "pwdUnValidate");
		} else {
			
				tmap.put("x|" + opCode, "pwdValidate");
			
		}
	}
	/*2015/05/21 15:48:50 暂时直接都不用密码验证*/
		
			//retCode = "000000";
			//tmap.put("x|" + opCode, "pwdValidate");
		
	
	
	System.out.println("gaopengSeeLogchkis===chkIsVali====wanghfa==== retCode = " + retCode);
%>
	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	core.ajax.receivePacket(response);
