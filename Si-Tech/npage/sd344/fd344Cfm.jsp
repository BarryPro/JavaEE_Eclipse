<%
  /*
   * ����: ���Źܿ� d344
   * �汾: 1.0
   * ����: 2011/3/25
   * ����: huangrong
   * ��Ȩ: si-tech
   * update:
  */
%>
 <% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode="d344";
	String opName="���Źܿ�";
	String iwork_no =(String)session.getAttribute("workNo");//����
	String hdorg_code = (String)session.getAttribute("orgCode");//org_code ����Ȩ�޹���
	String iwork_pwd =(String)session.getAttribute("password");//��������		
	String hdthe_ip =  (String)session.getAttribute("ipAddr");//��½IP	
	String regionCode = (String)session.getAttribute("regCode");
	String ilogin_accept = ReqUtil.get(request,"stream");
%>
	
<%			             
	String icmd_code1 = ReqUtil.get(request,"icmd_code");  //�������
	String icmd_code = "";											  //60,61
	if(icmd_code1.trim().equals("ǿ��"))
	{
		System.out.println("11111111111111111111111");
		icmd_code="60";
	}else{
		System.out.println("22222222222222222222222");
		icmd_code="61";
	}

	String inew_runcode = ReqUtil.get(request,"onew_run");             //������״̬L,K.
	String ishould_fee = ReqUtil.get(request,"ishould_fee");           //Ӧ��������
	String ireal_fee = ReqUtil.get(request,"ohand_cash");              //ʵ��������
				 
	String ido_note = ReqUtil.get(request,"opNote");                   //������ע
	String expDays = ReqUtil.get(request,"expDays");                   //���ڱ�ע	
	String ret_code = "";
	String ret_msg = "";
	String cardno = ReqUtil.get(request,"idIccid");                    //���֤����
	String themob = ReqUtil.get(request,"phoneNo");					           //�ƶ�����  
	String name =   ReqUtil.get(request,"custName");                   //�û�����  
	String address =  ReqUtil.get(request,"custAddr");			           //�û���ַ 	

	if(ireal_fee.equals(""))
	ireal_fee = "0";
	float  handcash = Float.parseFloat(ireal_fee);                     //�����ѵ�����
System.out.println("1246Cfm:"+ilogin_accept);
System.out.println("1246Cfm:"+opCode);
System.out.println("1246Cfm:"+iwork_no);
System.out.println("1246Cfm:"+iwork_pwd);
System.out.println("1246Cfm:"+themob);
System.out.println("1246Cfm:"+hdorg_code);
System.out.println("1246Cfm:"+icmd_code);
System.out.println("1246Cfm:"+inew_runcode);
System.out.println("1246Cfm:"+ishould_fee);
System.out.println("1246Cfm:"+ireal_fee);
System.out.println("1246Cfm:"+expDays);
System.out.println("1246Cfm:"+ido_note);
System.out.println("1246Cfm:"+hdthe_ip);
													
	/*--------------------------------��ʼ����s1246Cfm--------------------------------*/			                      
%>	
	<wtc:service name="sd344Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=ilogin_accept%>"/>
		<wtc:param value="01"/>						
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=iwork_no%>"/>
		<wtc:param value="<%=iwork_pwd%>"/>
		<wtc:param value="<%=themob%>"/>			
		<wtc:param value=" "/>					
		<wtc:param value="<%=hdorg_code%>"/>
		<wtc:param value="<%=icmd_code%>"/>						
		<wtc:param value="<%=inew_runcode%>"/>							
		<wtc:param value="<%=ishould_fee%>"/>						
		<wtc:param value="<%=ireal_fee%>"/>		
		<wtc:param value="<%=expDays%>"/>		
		<wtc:param value="<%=ido_note%>"/>		
		<wtc:param value="<%=hdthe_ip%>"/>		
	</wtc:service>
	<wtc:array id="result" scope="end"/>  
<%
	ret_code = retCode ;
	ret_msg = retMsg ;                                
%>
<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+iwork_no+"&loginAccept="+ilogin_accept+"&pageActivePhone="+themob+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
/*************************************��ô�ӡ��Ʊ�Ĳ���****************************************/
 
	String realcash = ireal_fee;   				                            //������    
	String stream = "";                                               //ϵͳ��ˮ 
	if(retCode.equals("000000")){
		if(result.length>0){
			stream = result[0][0];
		}		
	}
/***********************************************************************************************/
%>

<script language="javascript">
function printBill(){
	 var infoStr="";                                                                         
	 infoStr+='<%=cardno%>'+"|";//���֤����                                                  
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=themob%>'+"|";//�ƶ�����                                                   
	 infoStr+=""+"|";//��ͬ����                                                          
	 infoStr+='<%=name%>'+"|";//�û�����                                                
	 infoStr+='<%=address%>'+"|";//�û���ַ 
	 infoStr+="�ֽ�"+"|";
	 infoStr+='<%=handcash%>'+"|";
	 infoStr+="ǿ�ƿ��ػ���*�����ѣ�"+'<%=realcash%>'+"*��ˮ�ţ�"+'<%=stream%>'+"|";
	 location="<%=request.getContextPath()%>/npage/change/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=<%=request.getContextPath()%>/npage/sd344/fd344_1.jsp?activePhone=<%=themob%>";                    
}
</script>

<%if(ret_code.equals("000000")&&handcash>0.0){%>
<script language="javascript">
	rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......',2);
	printBill();
</script>
<%}%>

<%if(ret_code.equals("000000")){%>
<script language='javascript'>
	rdShowMessageDialog('�����ɹ���',2);
	document.location.replace("fd344_1.jsp?activePhone=<%=themob%>");
</script>
<%}%>



<%if(!ret_code.equals("000000")){%>
<script language='javascript'>
	var ret_code = "<%=ret_code%>";
	var ret_msg = "<%=ret_msg%>";
	rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code%>'��<br>������Ϣ��'<%=ret_msg%>'��",0);
	document.location.replace("fd344_1.jsp?activePhone=<%=themob%>");
</script>
<%}%>




