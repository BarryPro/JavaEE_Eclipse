<%
/********************
 version v2.0
������: si-tech
update:zhaohaitao@2009-1-7
********************/
%>
<title>��ͥ�ƻ����������</title>
<%@ page contentType= "text/html;charset=gbk" %>
<%
       String opCode = request.getParameter("opCode");//ģ�����
       String opName = request.getParameter("opName");//ģ������

%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/include/header.jsp" %>
<%
    //�õ��������
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String opFlagName="";
		String iOpType = request.getParameter("opeTypeFlag");		    //��������
 		String send_flag = request.getParameter("send_flag");		    //��Ч��־
 		String iPhoneNo = request.getParameter("mphone_no");		    //�ֻ�����
 		String iKinPhone = "";	    								                //�������
		String update_newPhoneNo="";                                //�޸�ʱ�����������
		String serviceName = "" ;                                   //��������
		String mode_code = "";       								//�ײ���Ϣmode_code(mode_name)
		/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
		String op_strong_pwd = (String) session.getAttribute("password");
	  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
		if(iOpType.equals("0"))
		{
			iKinPhone = request.getParameter("new_phoneno");
			mode_code = request.getParameter("rate_code");
			serviceName = "s12_39Cfm";
		}else if(iOpType.equals("1")){
			iKinPhone = request.getParameter("newPhoneno");
			mode_code = request.getParameter("rate_code");
			serviceName = "s12_39Cfm";
		}else if(iOpType.equals("2")){
			iKinPhone = request.getParameter("newPhoneno");
 			mode_code = request.getParameter("rateCode");
			update_newPhoneNo = request.getParameter("update_newPhoneno");
      		serviceName = "s1239Upd";
		}
		else if(iOpType.equals("3")){
			iKinPhone = request.getParameter("newPhoneno");
 			mode_code = request.getParameter("rate_code");
      serviceName = "s1239Del";
		}
		
		if(mode_code.indexOf("(")!=-1){
			mode_code = mode_code.substring(0,mode_code.indexOf("("));
		} 
		System.out.println("mylog------------------rateCode----------"+mode_code);
 		String iDetailCode=mode_code;				//�ʷ�����
 		String iShouldPay = request.getParameter("hand_fee");		//Ӧ��������
 		String iPayFee = request.getParameter("hand_fee");			//ʵ��������
 		String iFavourCode = request.getParameter("vFavourCode");	//�������Żݴ���
 		String iSysNote = "��ͥ�ƻ����������";					//ϵͳ��ע
 		String iOpNote = request.getParameter("note");				//�û���ע
 		String iLoginNo = request.getParameter("workno");			//��������  
		String iLoginName = request.getParameter("workName");		//���������� 
 		String iOrgCode = request.getParameter("unitCode");			//��������
 		String iOpCode = request.getParameter("opCode");			//��������
 		String iIpAdd = request.getParameter("ipAddr");				//ӪҵԱ��½IP
 		String iLoginAccept = request.getParameter("printAccept"); //������ˮ
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
	  if(iOpType.equals("0")||iOpType.equals("1")){
	  
				System.out.println("mylog--------------iOpType       ----------------"+iOpType     );
				System.out.println("mylog--------------send_flag     ----------------"+send_flag   );
				System.out.println("mylog--------------iPhoneNo      ----------------"+iPhoneNo    );
				System.out.println("mylog--------------iKinPhone     ----------------"+iKinPhone   );
				System.out.println("mylog--------------iDetailCode   ----------------"+iDetailCode );
				System.out.println("mylog--------------iShouldPay    ----------------"+iShouldPay  );
				System.out.println("mylog--------------iPayFee       ----------------"+iPayFee     );
				System.out.println("mylog--------------iFavourCode		----------------"+iFavourCode	);	
				System.out.println("mylog--------------iSysNote      ----------------"+iSysNote    );
				System.out.println("mylog--------------iOpNote       ----------------"+iOpNote     );
				System.out.println("mylog--------------iLoginNo      ----------------"+iLoginNo    );
				System.out.println("mylog--------------iOrgCode      ----------------"+iOrgCode    );
				System.out.println("mylog--------------iOpCode       ----------------"+iOpCode     );
				System.out.println("mylog--------------iIpAdd        ----------------"+iIpAdd      );
				System.out.println("mylog--------------iLoginAccept	-----------------"+iLoginAccept );			
				System.out.println("mylog--------------kin_count			---------------"+kin_count		);		  
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
	   
	   		System.out.println("mylog--------------iPhoneNo      -----------------"+ iPhoneNo    ); 
				System.out.println("mylog--------------oldstr        -----------------"+ oldstr      );
				System.out.println("mylog--------------newstr        -----------------"+ newstr      );
				System.out.println("mylog--------------iDetailCode   -----------------"+ iDetailCode );
				System.out.println("mylog--------------iShouldPay    -----------------"+ iShouldPay  );
				System.out.println("mylog--------------iPayFee       -----------------"+ iPayFee     );
				System.out.println("mylog--------------iFavourCode   -----------------"+ iFavourCode );
				System.out.println("mylog--------------iSysNote			-----------------"+ iSysNote		);
				System.out.println("mylog--------------iOpNote       -----------------"+ iOpNote     );
				System.out.println("mylog--------------iLoginNo      -----------------"+ iLoginNo    );
				System.out.println("mylog--------------iOrgCode      -----------------"+ iOrgCode    );
				System.out.println("mylog--------------iOpCode       -----------------"+ iOpCode     );
				System.out.println("mylog--------------iIpAdd        -----------------"+ iIpAdd      );
				System.out.println("mylog--------------iLoginAccept	-----------------"+ iLoginAccept);
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
		 
		 
	   }else if(iOpType.equals("3"))
	   {	   	  
	   		System.out.println("mylog--------------gaopeng----------------->>>>>>>>>>"    ); 
	   		System.out.println("mylog--------------iPhoneNo      -----------------"+ iPhoneNo    ); 
				System.out.println("mylog--------------oldstr        -----------------"+ oldstr      );
				System.out.println("mylog--------------iDetailCode   -----------------"+ iDetailCode );
				System.out.println("mylog--------------iOpNote       -----------------"+ iOpNote     );
				System.out.println("mylog--------------iLoginNo      -----------------"+ iLoginNo    );
				System.out.println("mylog--------------iOrgCode      -----------------"+ iOrgCode    );
				System.out.println("mylog--------------iOpCode       -----------------"+ iOpCode     );
				System.out.println("mylog--------------iLoginAccept	-----------------"+ iLoginAccept);
%>
		<wtc:service  name="<%=serviceName%>" routerKey="phone" routerValue="<%=iPhoneNo%>" outnum="2"  retcode="retCode1" retmsg="retMessage1">
				<wtc:param  value="<%=iLoginAccept%>"/>
				<wtc:param  value="01"/>
				<wtc:param  value="<%=iOpCode%>"/>
				<wtc:param  value="<%=iLoginNo%>"/>
				<wtc:param  value="<%=op_strong_pwd%>"/>
				<wtc:param  value="<%=iPhoneNo%>"/>
				<wtc:param  value=""/>											
				<wtc:param  value="<%=oldstr%>"/>
				<wtc:param  value="<%=iDetailCode%>"/>
				<wtc:param  value="<%=iOpNote%>"/>
    </wtc:service>
<%
		 code = retCode1;
		 msg = retMessage1;
			}


	   String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+code+"&opName="+opName+"&workNo="+iLoginNo+"&loginAccept="+stream+"&pageActivePhone="+iPhoneNo+"&retMsgForCntt="+msg+"&opBeginTime="+opBeginTime+"&contactId="+iPhoneNo+"&contactType=user";
	   System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+url);
	   System.out.println("mylog-----------------code---------------"+code);
		 System.out.println("mylog-----------------msg---------------"+msg);
	   if(!code.equals("000000")&&!code.equals("0"))
	   {
%>
            <script language='jscript'>
                rdShowMessageDialog("��ͥ�ƻ����������ʧ�ܣ�"+"<%=msg%>" + "[" + "<%=code%>" + "]",0);
                window.location="f7124.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
            </script>
<%		  }
        else
        {
%> 
<script language="jscript">
function printBill(){
	 var infoStr="";                                                                         
	 infoStr+="<%=iLoginNo%>  <%=iLoginAccept%>"+"  ��������޸�"+"|";//����                                          
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//��
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";//��
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";//��

   infoStr+="<%=cust_name%>"+"|";//�û����� 
   infoStr+=" "+"|";//����

	 infoStr+="<%=iPhoneNo%>"+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//Э�����                                                          
	 infoStr+=" "+"|";//֧Ʊ����  
	 
	 infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
	 infoStr+="<%=WtcUtil.formatNumber(iPayFee,2)%>"+"|";//Сд

	 infoStr+="�����ѣ�  <%=WtcUtil.formatNumber(iPayFee,2)%>"+
	 "~~~���������ģ�<%=iKinPhone%>��Ϊ<%=update_newPhoneNo%>"+"|";//��Ŀ

	 infoStr+="<%=iLoginName%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���

	 var dirtPage="/npage/bill/f7124_1.jsp";

	 location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPage;
}
</script>
<script language="jscript">
	<%
	if(iOpType.equals("2") && iPayFeeFloat>0.01)
	{
	%>	              
	rdShowMessageDialog("��ͥ�ƻ�����������ɹ�!",2);
	//printBill();
	//location = "f1239_1.jsp?activePhone=<%=iPhoneNo%>";
	removeCurrentTab();
	<%
	}
else if (iOpType.equals("3"))
	{
	%>
	rdShowMessageDialog("��ͥ�ƻ��������ȡ���ɹ�!",2);
	window.location="f7124.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	<%
	}
	else{
	%>
	rdShowMessageDialog("��ͥ�ƻ�����������ɹ�!",2);
	//location = "f1239_1.jsp?activePhone=<%=iPhoneNo%>";
	removeCurrentTab();
	<%}%>
</script>
	<%            
	}
	%>
<jsp:include page="<%=url%>" flush="true" />
