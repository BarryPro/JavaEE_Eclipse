<%
   /*
   * 功能: 公共验证页面	
　 * 版本: v3.0
　 * 日期: 2008/04/06
　 * 作者: ranlf
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%> 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
var retMsg = "";
<%
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String verifyType = WtcUtil.repNull(request.getParameter("verifyType"));//验证类型:0用户密码;1身份证号;2随机
   String verifyVal = WtcUtil.repNull(request.getParameter("verifyVal"));//密码值
   String validateVal = WtcUtil.repNull(request.getParameter("validateVal"));//密码验证状态
   String workNo = (String)session.getAttribute("workNo");
   String password = (String)session.getAttribute("password");
   String opCode =  WtcUtil.repNull(request.getParameter("opCode"));
   String phoneNo  = WtcUtil.repNull(request.getParameter("phoneNo"));
   String passFlag  = WtcUtil.repNull(request.getParameter("passFlag")); //用于判断伊春的密码是不是过于简单的标志
   Map tmap = (Map)session.getAttribute("contactTimeMap");
   
   /** add by zhanghonga@2008-09-16
     * 因为黑龙江这边的密码验证跟吉林那边的验证方式不一样.黑龙江密码是直接使用本地java方法加密的.
     * 所以直接从页面传入加密后的密码,直接进行比较
   	 * verifyType为->0：密码，1：身份证，2：随机密码
   	 ***/
   String returnFalg = "";
   if(verifyType.equals("0"))//用户密码
   {
   		verifyVal = Encrypt.encrypt(verifyVal);
   		String pwChckSqlStr = "select user_passwd from dcustmsg where phone_no = '"+phoneNo+"'";
%>
		  <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=pwChckSqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="pwChckArr" scope="end" />  		
<%   	

			if(pwChckArr!=null&&pwChckArr.length>0){
			// yuanqs add 100820 密码改造需求 begin
%>
    	<wtc:service name="sPubCustCheck" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="5">
				<wtc:param value="01"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value="<%=verifyVal%>"/>
				<wtc:param value="en"/>
				<wtc:param value=""/>
				<wtc:param value="<%=workNo%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end"/>
			var retCode = "<%=retCode%>";
			retMsg = "<%=retMsg%>";
			<%
					System.out.println("===========wanghfa============retCode=" + retCode);
					System.out.println("===========wanghfa============retMsg=" + retMsg);

					if ("000000".equals(retCode)) {
						 returnFalg = "1";
			  		 Map map = (Map)session.getAttribute("contactInfoMap");
					   ContactInfo contactInfo = (ContactInfo) map.get(phoneNo);
					   if(contactInfo!=null)
					   {
					   	contactInfo.setPasswdVal(verifyVal,(2-Integer.parseInt(verifyType)));//将用户密码存入MAP
					   	contactInfo.setPasswd_status(validateVal);  //
							String dateStr = new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
							System.out.println("====wanghfa==== " + phoneNo + "|" + opCode + ", " + dateStr);
							tmap.put(phoneNo + "|x", dateStr);
							tmap.put("x|" + opCode, "pwdValidate");
					   }
						for (int i = 0; i < result.length; i ++ ) {
							for (int j = 0; j < result[i].length; j ++) {
								System.out.println("=========wanghfa==========result[" + i + "][" + j + "]" + result[i][j]);
							}
						}
					} else {
						tmap.put("x|" + opCode, "pwdUnValidate");
					}
					
			
			%>
			if ("000000" != retCode) {
				//	rdShowMessageDialog("<%=retMsg%>");
			} 
<% 
			// yuanqs add 100820 密码改造需求 end
				/*if(Encrypt.checkpwd2(pwChckArr[0][0],verifyVal)!=0){//用户验证通过
					 returnFalg = "1";
		  		 Map map = (Map)session.getAttribute("contactInfoMap");
				   ContactInfo contactInfo = (ContactInfo) map.get(phoneNo);
				   if(contactInfo!=null)
				   {
				   	contactInfo.setPasswdVal(verifyVal,(2-Integer.parseInt(verifyType)));//将用户密码存入MAP
				   	contactInfo.setPasswd_status(validateVal);  //
				   }					
				}*/
			}
			
				//	   if(workNo.equals("jalj0h")) returnFalg = "1";//解决打印白屏问题hejwa 临时增加 完成后删除
		   //System.out.println("hjwlog---------------workNo---------------"+workNo);
		   
   } else if (verifyType.equals("2")){
       %>
       <wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>
       <wtc:service name="sPassCheck" retcode="passCheckCode" retmsg="passCheckMsg"  outnum="1">
    		<wtc:param value="<%=loginAccept%>"/>
    		<wtc:param value="01"/>
    		<wtc:param value="<%=opCode%>"/>
    		<wtc:param value="<%=workNo%>"/>
    		<wtc:param value="<%=password%>"/>
    		<wtc:param value="<%=phoneNo%>"/>
    		<wtc:param value=""/>
    		<wtc:param value="<%=verifyVal%>"/>
    		<wtc:param value="0"/>
	   </wtc:service>
       
       retMsg = "<%=passCheckMsg%>";
       <%
       if ("000000".equals(passCheckCode)){
       		 /*2014/12/24 10:31:41 gaopeng 关于优化凭随机验证码4G换卡业务受理单打印内容的需求 
       		 	 修改随机密码校验成功后,在session中存储opcode|phoneNo 为验证成功标志
       		 */
       		 String RandomPubFlag = (String)session.getAttribute("RandomPubFlag");
       		 if(RandomPubFlag != null && !"".equals(RandomPubFlag)){
       		 /*2014/12/24 10:41:21 删除session中的RandomPubFlag信息*/
       		 	session.removeAttribute("RandomPubFlag");
       		 }
       		 session.setAttribute("RandomPubFlag",phoneNo+"|true");
           returnFalg = "1";
           
           Map map = (Map)session.getAttribute("contactInfoMap");
		   ContactInfo contactInfo = (ContactInfo) map.get(phoneNo);
		   if(contactInfo!=null){
		   	   contactInfo.setPasswdVal(verifyVal,(2 - Integer.parseInt(verifyType)));//将用户密码存入MAP
		   	   contactInfo.setPasswd_status(validateVal);  //
			   String dateStr = new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
			   tmap.put(phoneNo + "|x", dateStr);
			   tmap.put("x|" + opCode, "pwdValidate");
		   } else {
			   tmap.put("x|" + opCode, "pwdUnValidate");
		   }
       } else {
           returnFalg = "";
       }
   }
   else//身份证号
   	{
   	/***add by zhanghonga end****/
%>
			<wtc:service name="sUserPWChck" outnum="1">
					<wtc:param value="<%=workNo%>"/>
					<wtc:param value="<%=opCode%>"/>
					<wtc:param value="0"/>
					<wtc:param value="<%=phoneNo%>"/>
					<wtc:param value="<%=verifyType%>"/>
					<wtc:param value="<%=verifyVal%>"/>
			</wtc:service>
		  <wtc:array id="rows" scope="end"/>
<%
		   returnFalg = rows.length>0?rows[0][0]:"";
		   

		   
		   if(returnFalg.equals("1"))//用户验证通过
		  	{
		  		 Map map = (Map)session.getAttribute("contactInfoMap");
				   ContactInfo contactInfo = (ContactInfo) map.get(phoneNo);
				   if(contactInfo!=null&&(!passFlag.equals("1")))
				   {
				   	contactInfo.setPasswdVal(verifyVal,(2-Integer.parseInt(verifyType)));//已经验证
				   	contactInfo.setPasswd_status(validateVal); 
						String dateStr = new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
						System.out.println("====wanghfa==== " + phoneNo + "|" + opCode + ", " + dateStr);
						tmap.put(phoneNo + "|x", dateStr);
						tmap.put("x|" + opCode, "pwdValidate");
				   }
		  	}	else {
					tmap.put("x|" + opCode, "pwdUnValidate");
				}
		}
%>

	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("flag","<%=returnFalg%>");
	response.data.add("retMsg",retMsg); //yuanqs add 100823 密码验证改造
	core.ajax.receivePacket(response);


	
