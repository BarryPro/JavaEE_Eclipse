<%
/********************
 version v2.0
������: si-tech
update:yanpx@2008-9-18
********************/
%>
<title>���������</title>
<%@ page contentType= "text/html;charset=GBK" %>
<%
       String opCode = "1239";//ģ�����
       String opName = "���������";//ģ������

%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/include/header.jsp" %>
<%
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
	   else if(iOpType.equals("1"))//hejwa ���� ɾ�������ײ� 
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
                rdShowMessageDialog("���������ʧ�ܣ�"+"<%=msg%>" + "[" + "<%=code%>" + "]");
                history.go(-1);
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

	 var dirtPage="/npage/bill/f1239_1.jsp";

	 location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPage;
}
</script>
<script language="jscript">
	<%if(iOpType.equals("2") && iPayFeeFloat>0.01){%>	              
	rdShowMessageDialog("����������ɹ�!");
	//printBill();
	location = "f1239_1.jsp?activePhone=<%=iPhoneNo%>";
	<%}else{%>
	rdShowMessageDialog("����������ɹ�!");
	location = "f1239_1.jsp?activePhone=<%=iPhoneNo%>";
	<%}%>
</script>
	<%            
	}
	%>
<jsp:include page="<%=url%>" flush="true" />
