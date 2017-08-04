
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
       String opCode = "1239";//模块代码
       String opName = "亲情号码变更";//模块名称

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
			serviceName = "s1239CfmCheck";
		}else if(iOpType.equals("2")){
			iKinPhone = request.getParameter("newPhoneno");
 			mode_code = request.getParameter("rate_code_1");
			update_newPhoneNo = request.getParameter("update_newPhoneno");
      serviceName = "s1239UpdCheck";
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

		

	  String outParaNums= "4";

		
		
		String code = "";
		String msg = "";
		System.out.println("-----------------iOpType----------------"+iOpType);
				
				System.out.println("-------------------------iLoginAccept-----------------"+iLoginAccept); 
				System.out.println("-------------------------01          -----------------"+01          ); 
				System.out.println("-------------------------iOpCode     -----------------"+iOpCode     ); 
				System.out.println("-------------------------iLoginNo    -----------------"+iLoginNo    ); 
				System.out.println("------------------------------------------------------"           ); 
				System.out.println("-------------------------iPhoneNo    -----------------"+iPhoneNo    ); 
				System.out.println("------------------------------------------------------"					   ); 
				System.out.println("-------------------------iOpType     -----------------"+iOpType     ); 
				System.out.println("-------------------------send_flag   -----------------"+send_flag   ); 
				System.out.println("-------------------------iKinPhone   -----------------"+iKinPhone   ); 
				System.out.println("-------------------------iDetailCode -----------------"+iDetailCode ); 
				System.out.println("-------------------------iShouldPay  -----------------"+iShouldPay  ); 
				System.out.println("-------------------------iPayFee     -----------------"+iPayFee     ); 
				System.out.println("-------------------------iFavourCode	----------------"+iFavourCode );	
				System.out.println("-------------------------iSysNote    -----------------"+iSysNote    ); 
				System.out.println("-------------------------iOpNote     -----------------"+iOpNote     ); 
				System.out.println("-------------------------iOrgCode    -----------------"+iOrgCode    ); 
				System.out.println("-------------------------iIpAdd			 -----------------"+iIpAdd			 ); 
				System.out.println("-------------------------kin_count	 -----------------"+kin_count	 ); 
				
	  if(iOpType.equals("0")||iOpType.equals("1")){
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


%>
	var response = new AJAXPacket();

	response.data.add("retcode","<%=code%>");
	response.data.add("retmsg","<%= msg%>");
	core.ajax.receivePacket(response);


