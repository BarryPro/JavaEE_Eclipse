<%
  /*
   * ����: ���Źܿػָ� d345
   * �汾: 1.0
   * ����: 2011/3/25
   * ����: huangrong 
   * ��Ȩ: si-tech
   * update:
  */
%>
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>

<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String phoneNo = request.getParameter("phoneNo");
  	 
	String regCode = (String)session.getAttribute("regCode");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String password =  (String)session.getAttribute("password");//��ȡ�������� 
	String []  inputParam = new String[16];
%>

<%      
/*--------------------------------��֯s1246Cfm�Ĵ������-------------------------------*/
	String ilogin_accept = request.getParameter("stream");             //ϵͳ��ˮ
	String iop_Code ="d345";                                          //��������					 
	String iwork_no = workNo;                                         //��������                  
	String iwork_pwd =password;                                       //��������						 
	String iorg_code = orgCode;                                       //org_code 
	String icust_id = request.getParameter("oid_no");                 //�ͻ�ID
	String icmd_code1 = request.getParameter("icmd_code");  
	String icmd_code = "";											//60,61
	if(icmd_code1.trim().equals("ǿ��"))
	{
		icmd_code="60";
	}else{
		icmd_code="61";
	}
	String inew_runcode = request.getParameter("onew_run");            //������״̬L,K.
	String ishould_fee = request.getParameter("ishould_fee");          //Ӧ��������
	String ireal_fee = request.getParameter("ohand_cash");            //ʵ��������	 
	String ido_note = request.getParameter("donote");                 //������ע
	String expDays = request.getParameter("expDays");                 //���ڱ�ע
	String ithe_ip = ipAddr;                                          //��½IP		
	String ret_code = "";
	String ret_msg = "";

	if(ireal_fee.equals(""))
	ireal_fee = "0";
	if(ishould_fee.equals(""))
	ishould_fee = "0";
	float  handcash = Float.parseFloat(ireal_fee);                    //�����ѵ�����
	System.out.println("sd344Cfm:"+icmd_code);
	/*--------------------------------��ʼ����s1246Cfm--------------------------------*/			                      
	inputParam[0] = ilogin_accept;
	inputParam[1] = "01";	
	inputParam[2] = iop_Code;
	inputParam[3] = iwork_no;
	inputParam[4] = iwork_pwd;
	inputParam[5] = phoneNo;	
	inputParam[6] = "";	
	inputParam[7] = orgCode;	
	inputParam[8] = icmd_code;
	inputParam[9] = inew_runcode;	
	inputParam[10] = ishould_fee;
	inputParam[11] = ireal_fee;	
	inputParam[12] = expDays;
	inputParam[13] = ido_note;
	inputParam[14] = ithe_ip;	
	String stream = "";
try{                                   
%>
	<wtc:service name="sd344Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<wtc:param value="<%=inputParam[0]%>"/>	
	<wtc:param value="<%=inputParam[1]%>"/>	
	<wtc:param value="<%=inputParam[2]%>"/>	
	<wtc:param value="<%=inputParam[3]%>"/>	
	<wtc:param value="<%=inputParam[4]%>"/>	
	<wtc:param value="<%=inputParam[5]%>"/>	
	<wtc:param value="<%=inputParam[6]%>"/>	
	<wtc:param value="<%=inputParam[7]%>"/>	
	<wtc:param value="<%=inputParam[8]%>"/>	
	<wtc:param value="<%=inputParam[9]%>"/>	
	<wtc:param value="<%=inputParam[10]%>"/>	
	<wtc:param value="<%=inputParam[11]%>"/>	
	<wtc:param value="<%=inputParam[12]%>"/>
	<wtc:param value="<%=inputParam[13]%>"/>	
	<wtc:param value="<%=inputParam[14]%>"/>	
	<wtc:param value="<%=inputParam[15]%>"/>	
	</wtc:service>	
	<wtc:array id="result"  scope="end"/>
<%

	stream = result[0][0];
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+stream+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; 
	System.out.println("%%%%%%%%%%%%%%%%%%%%%%%"+url);
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	ret_code = retCode1;
	ret_msg = retMsg1;
	System.out.println("test ret_code="+ret_code); 
  System.out.println("test ret_msg="+ret_msg);                             
}
catch(Exception e){
  e.printStackTrace() ;
}


/*------------------------------���ݵ��÷��񷵻ؽ������ҳ����ת------------------------------*/
%>
<%
/*************************************��ô�ӡ��Ʊ�Ĳ���****************************************/
String cardno = request.getParameter("idIccid");               //���֤����
String themob = request.getParameter("phoneNo");			             //�ƶ�����  
String name =  request.getParameter("custName");               //�û�����  
String address = request.getParameter("custAddr");		     //�û���ַ  
String realcash = ireal_fee;   				                     //������    
/***********************************************************************************************/
%>
<script language="jscript">
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
	 var dirpage="<%=request.getContextPath()%>/npage/sd344/fd345_1.jsp?activePhone=<%=themob%>&opCode=d345&opName=���Źܿػָ�"
	 location="<%=request.getContextPath()%>/npage/change/chkPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirpage);                    
}
</script>


<%if(ret_code.equals("000000")&&handcash>0.0){%>
	<script language="jscript">
		rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......',2);
		printBill();
	</script>
<%}%>

<%if(ret_code.equals("000000")){%>
	<script language='jscript'>
		rdShowMessageDialog('�����ɹ���',2);
		removeCurrentTab();
	</script>
<%}%>



<%if(!ret_code.equals("000000")){%>
	<script language='jscript'>
		var ret_code = "<%=ret_code%>";
		var ret_msg = "<%=ret_msg%>";
		rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code%>'��<br>������Ϣ��'<%=ret_msg%>'��",0);
		document.location.replace("fd345_1.jsp?activePhone=<%=themob%>&opName=���Źܿػָ�&opCode=d345");
	</script>
<%}%>




