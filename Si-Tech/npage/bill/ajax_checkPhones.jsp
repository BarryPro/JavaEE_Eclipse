
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
       String opCode = "1239";//ģ�����
       String opName = "���������";//ģ������

    //�õ��������
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    
		String iOpType = request.getParameter("opeTypeFlag");		    //��������
 		String send_flag = request.getParameter("send_flag");		    //��Ч��־
 		System.out.println("-----------------send_flag-----------------"+send_flag);
 		String iPhoneNo = request.getParameter("mphone_no");		    //�ֻ�����
 		String iKinPhone = "";	    								                //�������
		String update_newPhoneNo="";                                //�޸�ʱ�����������
		String serviceName = "" ;                                   //��������
		String mode_code = "";       								                //�ײ���Ϣmode_code(mode_name)
		/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
		String op_strong_pwd = (String) session.getAttribute("password");
	  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
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
 			
 			
 		String iShouldPay = request.getParameter("hand_fee");		//Ӧ��������
 		String iPayFee = request.getParameter("hand_fee");			//ʵ��������
 		String iFavourCode = request.getParameter("vFavourCode");	//�������Żݴ���
 		String iSysNote = "���������";							//ϵͳ��ע
 		String iOpNote = request.getParameter("note");				//�û���ע
 		String iLoginNo = request.getParameter("workno");			//��������  
		String iLoginName = request.getParameter("workName");		//���������� 
 		String iOrgCode = request.getParameter("unitCode");			//��������
 		String iOpCode = request.getParameter("opCode");			//��������
 		String iIpAdd = request.getParameter("ipAddr");				//ӪҵԱ��½IP
 		String iLoginAccept = request.getParameter("printAccept");; //������ˮ
		String kin_count = request.getParameter("kin_count");		//����������������
		
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
		String cust_name = request.getParameter("cust_name");//�ͻ�����

		

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


