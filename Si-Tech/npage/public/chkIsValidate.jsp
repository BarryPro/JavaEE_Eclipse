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

  System.out.println("====gaopengSeeLog21==== verifyVal = " + verifyVal);
  
	Map tmap = (Map)session.getAttribute("contactTimeMap");
	if(!"".equals(phoneNo)) {	//二级tab
		if (verifyVal.indexOf("1") != -1) {	//数据显示需要验证密码
			Map map = (Map)session.getAttribute("contactInfoMap");
			if(null==map){
				retCode = "000001";	//session中没有该用户信息
			}else{
				ContactInfo contactInfo = (ContactInfo) map.get(phoneNo);
		  //System.out.println("====wanghfa==== contactInfo.getPasswd_status() = " + contactInfo.getPasswd_status());
			//System.out.println("phoneNo===="+phoneNo);
	    //System.out.println("contactInfo====="+contactInfo);
				if(null==contactInfo) {
					retCode = "000001";	//session中没有该用户信息
				} else {
					String dateStr=new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
					java.text.SimpleDateFormat myFormatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
					
					String date1tmp = (String)tmap.get(phoneNo + "|x");
					System.out.println("====gaopengSeeLog21==== date1tmp1111 = " + date1tmp);
				
					if (null == date1tmp) {
						retCode = "000003";	//第一次打开此2级Tab
					} else {
						java.util.Date date1 = myFormatter.parse(date1tmp); 
						java.util.Date mydate= myFormatter.parse(dateStr);
						long day1=(mydate.getTime()-date1.getTime())/(60*1000);
						Long day2=new Long(day1);
	
					//	if(day1>30){	//超过30分钟
							retCode = "000002";
					//	} else {
					//		retCode = "000000";
					//		tmap.put(phoneNo + "|x", dateStr);
					//		tmap.put("x|" + opCode, "pwdValidate");
					//	}
					}
				}
			}
		} else {	//数据显示不需要验证密码
			retCode = "000000";
			tmap.put("x|" + opCode, "pwdValidate");
		}
	} else {	//一级tab
		System.out.println("====wanghfa==== verifyVal 2= " + verifyVal);
		if(null==tmap){
		retCode = "000001";	//session中没有该用户信息
	 }else{
			if (verifyVal.indexOf("1") != -1) {
				
				System.out.println("====gaopengSeeLogverifyVal====  " + verifyVal);
				tmap.put("x|" + opCode, "pwdUnValidate");
			} else {
					
					tmap.put("x|" + opCode, "pwdValidate");
				
			}
		}
	}
	
	
	
	/*1220 免密权限可以直接进入 否则每次都需要密码或随机密码验证*/
	
	if("1220".equals(opCode) || "m280".equals(opCode)){
		/*免密权限*/
		if("0".equals(verifyVal)){
			retCode = "000000";
			tmap.put("x|" + opCode, "pwdValidate");
		}else{
			retCode = "000001";
			tmap.put("x|" + opCode, "pwdUnValidate");
		}
	}
	
	//retCode = "000000";
	//tmap.put("x|" + opCode, "pwdValidate");
		//retCode = "000001";
	//tmap.put("x|" + opCode, "pwdUnValidate");
	
	//System.out.println("====wanghfa==== retCode = " + retCode);
%>
	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	core.ajax.receivePacket(response);
