<%
/********************
 version v2.0
 ������: si-tech
 ģ��:ǿ�ƿ��ػ��ָ�
 update zhaohaitao at 2009.1.6
********************/
%>
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>

<%/*
* ������BOSS-���ػ�����ǿ�ƿ��ػ�  2003-12-13
* @author  ghostlin
* @version 1.0
* @since   JDK 1.4
* Copyright (c) 2002-2003 si-tech All rights reserved.
*/%>
<%/*
* ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
		���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
*/%>
<%
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  	String phoneNo = request.getParameter("i1");
  	 
	String regCode = (String)session.getAttribute("regCode");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
	String ipAddr = (String)session.getAttribute("ipAddr");
	//�ڴ˴���ȡsession��Ϣ
	String password =  (String)session.getAttribute("password");//��ȡ�������� 
	String outList[][] = new String [][]{{"0","1"}};
	String []  inputParam = new String[13];

%>
<!---------------------------------����JS--����ҳ������ʽ��----------------------------->
<%      
	ArrayList retArray = new ArrayList();
	ArrayList getList = new ArrayList();
/*--------------------------------��֯s1246Cfm�Ĵ������-------------------------------*/
	String ilogin_accept = request.getParameter("stream");             //ϵͳ��ˮ
	String iop_Code ="2355";                                          //��������					 
	String iwork_no = workNo;                                         //��������                  
	String iwork_pwd =password;                                       //��������						 
	String iorg_code = orgCode;                                       //org_code 
	String icust_id = request.getParameter("oid_no");                 //�ͻ�ID
	String icmd_code1 = request.getParameter("icmd_code");  
	System.out.println("33333"+icmd_code1+"4444444");
	String icmd_code = "";											//60,61
	if(icmd_code1.trim().equals("ǿ��"))
	{
		icmd_code="60";
	}else{
		icmd_code="61";
	}
	//String icmd_code = request.getParameter("icmd_code");            //�����
	String inew_runcode = request.getParameter("onew_run");            //������״̬L,K.
	String ishould_fee = request.getParameter("ishould_fee");          //Ӧ��������
	String ireal_fee = request.getParameter("ohand_cash");            //ʵ��������
	//String isys_note = request.getParameter("sysnote");               //ϵͳ��ע					 
	String ido_note = request.getParameter("donote");                 //������ע
	String expDays = request.getParameter("expDays");                 //���ڱ�ע
	String ithe_ip = ipAddr;                                          //��½IP		
	String ret_code = "";
	String ret_msg = "";
	/*String themob = ReqUtil.get(request,"i1");                        //�ֻ�����					 
	String do_string=ReqUtil.get(request,"do_string_add");            //�������  1:���� 2:ȡ��
	String addcash_string=ReqUtil.get(request,"addcash_string");      //��ѡ�ʷѴ��봮
	String favour = "a017";                                           //�Żݴ���					 
	String realcash = ReqUtil.get(request,"i19");                     //ʵ��������				 
	String fircash = ReqUtil.get(request,"i20");                      //�̶�������				 
	*/
	if(ireal_fee.equals(""))
	ireal_fee = "0";
	if(ishould_fee.equals(""))
	ishould_fee = "0";
	float  handcash = Float.parseFloat(ireal_fee);                    //�����ѵ�����
	System.out.println("s1246Cfm:"+icmd_code);
	/*--------------------------------��ʼ����s1246Cfm--------------------------------*/			                      
	inputParam[0] = ilogin_accept;
	inputParam[1] = iop_Code;
	inputParam[2] = iwork_no;
	inputParam[3] = iwork_pwd;
	inputParam[4] = iorg_code;
	inputParam[5] = icust_id;
	inputParam[6] = icmd_code;
	inputParam[7] = inew_runcode;
	inputParam[8] = ishould_fee;
	inputParam[9] = ireal_fee;
	inputParam[10] = expDays;
	inputParam[11] = ido_note;
	inputParam[12] = ithe_ip;
	
	String stream = "";
	String osm_code=request.getParameter( "osm_code" );
	String svcNm = "s1246Cfm";
	System.out.println("osm_code~~~"+osm_code);
	/**
	if ( osm_code.equals("PB") || osm_code.equals("PA") )
	{
		svcNm = "sWLWInterFace";
	}*/
	

try{                                  
    //result = callWrapper.callService("s1246Cfm",inputParam,"1");   
%>
	<wtc:service name="<%=svcNm%>" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
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
String cardno = request.getParameter("oid_iccid");               //���֤����
String themob = request.getParameter("i1");			             //�ƶ�����  
String name =  request.getParameter("ocust_name");               //�û�����  
String address = request.getParameter("ocust_addr");		     //�û���ַ  
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
	 var dirpage="<%=request.getContextPath()%>/npage/s1246/f1246_1.jsp?activePhone=<%=themob%>&opCode=1246&opName=ǿ�ƿ��ػ�"
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
history.go(-1);
</script>
<%}%>



