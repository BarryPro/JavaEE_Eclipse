<%
/********************
 version v2.0
开发商: si-tech
update:yanpx@2008-9-18
********************/
%>
<title>亲情号码变更</title>
<%@ page contentType= "text/html;charset=GBK" %>
<%
       String opCode = "1239";//模块代码
       String opName = "亲情号码变更";//模块名称

%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/include/header.jsp" %>
<%
    //得到输入参数
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    
		String iOpType = request.getParameter("opeTypeFlag");		    //操作类型
 		String send_flag = request.getParameter("send_flag");		    //生效标志
 		System.out.println("-----------------send_flag-----------------"+send_flag);
 		String iPhoneNo = request.getParameter("mphone_no");		    //手机号码
 		String iKinPhone = "";	    								                //亲情号码
		String update_newPhoneNo="";                                //修改时，新亲情号码
		String serviceName = "" ;                                   //服务名称
		String mode_code = "";       								                //套餐信息mode_code(mode_name)
		/* liujian 安全加固修改 2012-4-6 16:18:13 begin */
		String op_strong_pwd = (String) session.getAttribute("password");
	  /* liujian 安全加固修改 2012-4-6 16:18:13 end */
		if(iOpType.equals("0"))
		{
			iKinPhone = request.getParameter("new_phoneno");
			mode_code = request.getParameter("rate_code_1");
			serviceName = "s12_39Cfm";
		}else if(iOpType.equals("1")){
			iKinPhone = request.getParameter("newPhoneno");
			mode_code = request.getParameter("rate_code_1");
			serviceName = "s1239Del";
		}else if(iOpType.equals("2")){
			iKinPhone = request.getParameter("newPhoneno");
 			mode_code = request.getParameter("rate_code_1");
			update_newPhoneNo = request.getParameter("update_newPhoneno");
      		serviceName = "s1239Upd";
		}
		System.out.println("------------------rateCode"+mode_code);
		
		System.out.println("------------mode_code-----------"+mode_code);
		String iDetailCode = "";
		iDetailCode = mode_code;
 			
 			
 		String iShouldPay = request.getParameter("hand_fee");		//应收手续费
 		String iPayFee = request.getParameter("hand_fee");			//实收手续费
 		String iFavourCode = request.getParameter("vFavourCode");	//手续费优惠代码
 		String iSysNote = "亲情号码变更";							//系统备注
 		String iOpNote = request.getParameter("note");				//用户备注
 		String iLoginNo = request.getParameter("workno");			//操作工号  
		String iLoginName = request.getParameter("workName");		//操作号姓名 
 		String iOrgCode = request.getParameter("unitCode");			//机构编码
 		String iOpCode = request.getParameter("opCode");			//操作代码
 		String iIpAdd = request.getParameter("ipAddr");				//营业员登陆IP
 		String iLoginAccept = request.getParameter("printAccept");; //操作流水
		String kin_count = request.getParameter("kin_count");		//已申请亲情号码个数
		
		/**************/
		String updatecount= request.getParameter("updatecount");
		String oldstr=request.getParameter("oldstr");
		String newstr=request.getParameter("newstr");
		
		/*************/
		String stream=iLoginAccept;
		String thework_no=iLoginNo;
		String themob=iPhoneNo;
		String theop_code=iOpCode;
 %>
 <%   
		String cust_name = request.getParameter("cust_name");//客户姓名
    float iPayFeeFloat = Float.parseFloat(iPayFee);
		
		String ipf = WtcUtil.formatNumber(iPayFee,2);
	  String outParaNums= "4";
  %>
  	<wtc:service  name="sToChinaFee" routerKey="<%=regionCode%>" routerValue="<%=iPhoneNo%>" outnum="3"  retcode="retCode2" retmsg="retMessage2">
			<wtc:param  value="<%=ipf%>"/>
	  </wtc:service>
	  <wtc:array id="chinaFee1"  start="2"  length="1" scope="end"/>
<%
		
		String chinaFee =chinaFee1[0][0];
		String code = "";
		String msg = "";
		System.out.println("-----------------iOpType----------------"+iOpType);
				
				System.out.println("hjw-------------------------iLoginAccept-----------------"+iLoginAccept); 
				System.out.println("hjw-------------------------01          -----------------"+01          ); 
				System.out.println("hjw-------------------------iOpCode     -----------------"+iOpCode     ); 
				System.out.println("hjw-------------------------iLoginNo    -----------------"+iLoginNo    ); 
				System.out.println("hjw------------------------------------------------------"           ); 
				System.out.println("hjw-------------------------iPhoneNo    -----------------"+iPhoneNo    ); 
				System.out.println("hjw------------------------------------------------------"					   ); 
				System.out.println("hjw-------------------------iOpType     -----------------"+iOpType     ); 
				System.out.println("hjw-------------------------send_flag   -----------------"+send_flag   ); 
				System.out.println("hjw-------------------------iKinPhone   -----------------"+iKinPhone   ); 
				System.out.println("hjw-------------------------iDetailCode -----------------"+iDetailCode ); 
				System.out.println("hjw-------------------------iShouldPay  -----------------"+iShouldPay  ); 
				System.out.println("hjw-------------------------iPayFee     -----------------"+iPayFee     ); 
				System.out.println("hjw-------------------------iFavourCode	----------------"+iFavourCode );	
				System.out.println("hjw-------------------------iSysNote    -----------------"+iSysNote    ); 
				System.out.println("hjw-------------------------iOpNote     -----------------"+iOpNote     ); 
				System.out.println("hjw-------------------------iOrgCode    -----------------"+iOrgCode    ); 
				System.out.println("hjw-------------------------iIpAdd			 -----------------"+iIpAdd			 ); 
				System.out.println("hjw-------------------------kin_count	 -----------------"+kin_count	 ); 
				
	  if(iOpType.equals("0")){
%>
		<wtc:service  name="<%=serviceName%>" routerKey="phone" routerValue="<%=iPhoneNo%>" outnum="<%=outParaNums%>"  retcode="retCode1" retmsg="retMessage1" >
				<wtc:param  value="<%=iLoginAccept%>"/>
				<wtc:param  value="01"/>
				<wtc:param  value="<%=iOpCode%>"/>
				<wtc:param  value="<%=iLoginNo%>"/>
				<wtc:param  value="<%=op_strong_pwd%>"/>
				<wtc:param  value="<%=iPhoneNo%>"/>
				<wtc:param  value=""/>					
				<wtc:param  value="<%=iOpType%>"/>
				<wtc:param  value="<%=send_flag%>"/>
				<wtc:param  value="<%=iKinPhone%>"/>
				<wtc:param  value="<%=iDetailCode%>"/>
				<wtc:param  value="<%=iShouldPay%>"/>
				<wtc:param  value="<%=iPayFee%>"/>
				<wtc:param  value="<%=iFavourCode%>"/>			
				<wtc:param  value="<%=iSysNote%>"/>
				<wtc:param  value="<%=iOpNote%>"/>
				<wtc:param  value="<%=iOrgCode%>"/>
				<wtc:param  value="<%=iIpAdd%>"/>			
				<wtc:param  value="<%=kin_count%>"/>						
    </wtc:service>
<%	 
		 code = retCode1;
		 msg = retMessage1;
	   }else if(iOpType.equals("2"))
	   {	   	  
%>
		<wtc:service  name="<%=serviceName%>" routerKey="phone" routerValue="<%=iPhoneNo%>" outnum="<%=outParaNums%>"  retcode="retCode1" retmsg="retMessage1">
				<wtc:param  value="<%=iLoginAccept%>"/>
				<wtc:param  value="01"/>
				<wtc:param  value="<%=iOpCode%>"/>
				<wtc:param  value="<%=iLoginNo%>"/>
				<wtc:param  value="<%=op_strong_pwd%>"/>
				<wtc:param  value="<%=iPhoneNo%>"/>
				<wtc:param  value=""/>											
				<wtc:param  value="<%=oldstr%>"/>
				<wtc:param  value="<%=newstr%>"/>
				<wtc:param  value="<%=iDetailCode%>"/>
				<wtc:param  value="<%=iShouldPay%>"/>
				<wtc:param  value="<%=iPayFee%>"/>
				<wtc:param  value="<%=iFavourCode%>"/>
				<wtc:param  value="<%=iSysNote%>"/>			
				<wtc:param  value="<%=iOpNote%>"/>
				<wtc:param  value="<%=iOrgCode%>"/>
				<wtc:param  value="<%=iIpAdd%>"/>				
    </wtc:service>
<%	  
		 code = retCode1;
		 msg = retMessage1;
	   }
	   else if(iOpType.equals("1"))//hejwa 增加 删除亲情套餐 
	   {	   	  
	   String cenPhoneList = request.getParameter("cenPhoneList");
	   System.out.println("--------------cenPhoneList--------------"+cenPhoneList);
%>
		<wtc:service  name="<%=serviceName%>" routerKey="phone" routerValue="<%=iPhoneNo%>" outnum="<%=outParaNums%>"  retcode="retCode1" retmsg="retMessage1">
				<wtc:param  value="<%=iLoginAccept%>"/>
				<wtc:param  value="01"/>
				<wtc:param  value="<%=iOpCode%>"/>
				<wtc:param  value="<%=iLoginNo%>"/>
				<wtc:param  value="<%=op_strong_pwd%>"/>
				<wtc:param  value="<%=iPhoneNo%>"/>
				<wtc:param  value=""/>							
				<wtc:param  value="<%=cenPhoneList%>"/>	
				<wtc:param  value="<%=iDetailCode%>"/>										
				<wtc:param  value="<%=iOpNote%>"/>											
    </wtc:service>
<%	  
		 code = retCode1;
		 msg = retMessage1;
	   }
	   //String url = "/npage/contact/upCnttInfo.jsp?opCode="+iOpCode+"&retCodeForCntt="+code+"&opName="+opName+"&workNo="+iLoginNo+"&loginAccept="+loginAccept+"";	
	   String url = "/npage/contact/upCnttInfo.jsp?opCode="+iOpCode+"&retCodeForCntt="+code+"&opName="+opName+"&workNo="+iLoginNo+"&loginAccept="+stream+"&pageActivePhone="+iPhoneNo+"&retMsgForCntt="+msg+"&opBeginTime="+opBeginTime;
	   System.out.println(url);
	   if(!code.equals("000000")&&!code.equals("0"))
	   {
%>
            <script language='jscript'>
                rdShowMessageDialog("亲情号码变更失败！"+"<%=msg%>" + "[" + "<%=code%>" + "]");
                history.go(-1);
            </script>
<%		  }
        else
        {
%> 
<script language="jscript">
function printBill(){
	 var infoStr="";                                                                         
	 infoStr+="<%=iLoginNo%>  <%=iLoginAccept%>"+"  亲情号码修改"+"|";//工号                                          
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//年
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";//月
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日

   infoStr+="<%=cust_name%>"+"|";//用户名称 
   infoStr+=" "+"|";//卡号

	 infoStr+="<%=iPhoneNo%>"+"|";//移动号码                                                   
	 infoStr+=" "+"|";//协议号码                                                          
	 infoStr+=" "+"|";//支票号码  
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=WtcUtil.formatNumber(iPayFee,2)%>"+"|";//小写

	 infoStr+="手续费：  <%=WtcUtil.formatNumber(iPayFee,2)%>"+
	 "~~~亲情号码更改：<%=iKinPhone%>改为<%=update_newPhoneNo%>"+"|";//项目

	 infoStr+="<%=iLoginName%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人

	 var dirtPage="/npage/bill/f1239_1.jsp";

	 location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPage;
}
</script>
<script language="jscript">
	<%if(iOpType.equals("2") && iPayFeeFloat>0.01){%>	              
	rdShowMessageDialog("亲情号码变更成功!");
	//printBill();
	location = "f1239_1.jsp?activePhone=<%=iPhoneNo%>";
	<%}else{%>
	rdShowMessageDialog("亲情号码变更成功!");
	location = "f1239_1.jsp?activePhone=<%=iPhoneNo%>";
	<%}%>
</script>
	<%            
	}
	%>
<jsp:include page="<%=url%>" flush="true" />
