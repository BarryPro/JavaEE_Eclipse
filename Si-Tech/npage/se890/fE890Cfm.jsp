<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
	//String objectId = (String)session.getAttribute("objectId");
	//String siteId =   (String)session.getAttribute("siteId");
	
	String objectId = (String)session.getAttribute("groupId");
	String siteId =   (String)session.getAttribute("groupId");
	
	String workNo =   (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	
	String result = request.getParameter("result");
	String retType = request.getParameter("retType");
	String opNameCfm = request.getParameter("opNameCfm");
	
	String srvno = request.getParameter("srvno") == null ? "" : request.getParameter("srvno");
	//srvno = "13003027016";
	String ipAddr = request.getRemoteAddr();
	String opCode = request.getParameter("opCode");
	System.out.println("e890~~~~~opCode="+opCode);
	
	String opCodeCfm = request.getParameter("opCode");
	System.out.println("e890~~~~~opCodeCfm="+opCodeCfm);
  String loginAcceptc = request.getParameter("loginAccept");
  String loginAcceptHv = request.getParameter("e890loginAccept");
  System.out.println("e890~~~~loginAcceptHv="+loginAcceptHv);
  
  
  
  /********tianyang add at 20090928 for POS�ɷ�����****start*****/
  String payType				 = request.getParameter("payType");/**�ɷ����� payType=BX �ǽ��� payType=BY �ǹ���**/
	String MerchantNameChs = request.getParameter("MerchantNameChs");/**�Ӵ˿�ʼ����Ϊ���в���**/
	String MerchantId      = request.getParameter("MerchantId");
	String TerminalId      = request.getParameter("TerminalId");
	String IssCode         = request.getParameter("IssCode");
	String AcqCode         = request.getParameter("AcqCode");
	String CardNo          = request.getParameter("CardNo");
	String BatchNo         = request.getParameter("BatchNo");
	String Response_time   = request.getParameter("Response_time");
	String Rrn             = request.getParameter("Rrn");
	String AuthNo          = request.getParameter("AuthNo");
	String TraceNo         = request.getParameter("TraceNo");
	String Request_time    = request.getParameter("Request_time");
	String CardNoPingBi    = request.getParameter("CardNoPingBi");
	String ExpDate         = request.getParameter("ExpDate");
	String Remak           = request.getParameter("Remak");
	String TC              = request.getParameter("TC");
	/********tianyang add at 20090928 for POS�ɷ�����****end*******/
  
  


	System.out.println("retType===e890===="+retType);
	System.out.println("workNo ===e890===="+workNo);
	System.out.println("opCode====e890==="+opCode);
	System.out.println("srvno ====e890==="+srvno);
	System.out.println("password===e890===="+password);
	System.out.println("ipAddr ====e890==="+ipAddr);
	System.out.println("siteId=====e890=="+siteId);
	System.out.println("objectId ===e890===="+objectId);
		System.out.println("opCodeCfm==e890=add===="+opCodeCfm);
	System.out.println("loginAccept ===e890add===="+loginAcceptc);
	/**
		-utype #������Ϣ
		--string ba0001 #����
		--string q070 #��������
		--string 13003027016 #�ֻ�����
		--string 0 #��������
		--string 3018 #serv_busi_id
		--string 1234 #l��������
		--string 168.0.0.1 #ip_addr
		--string 10031 #�����
		--string 1001 #objcect_id
		--int 1 #deallev����ȼ�
		
		#-utype #�ͻ����������б�
		#--utype #�ͻ���������1
		#---string A0109061500000033 #�ͻ�����ID
		#---utype #���񶨵��б�
		#----utype #���񶨵�1
		#-----string S0109060400000007 #���񶨵�ID
		#----utype #���񶨵�2
		#-----string S0109060400000005 #���񶨵�ID
		#--utype #�ͻ���������2
		#---string A02 #�ͻ�����ID
		#---utype #���񶨵��б�
		#----utype #���񶨵�2
		#-----string S0109060100000019 #���񶨵�ID 
	*/
	
	
	
  UType sendInfo1  = new UType(); //TOprInfo ����������Ϣ
  sendInfo1.setUe("STRING", workNo);//
  sendInfo1.setUe("STRING", opCodeCfm);//
  sendInfo1.setUe("STRING", srvno);//
  sendInfo1.setUe("STRING", "0");//sLoginPwd
  sendInfo1.setUe("STRING", "3018");//
  sendInfo1.setUe("STRING", password);//
  sendInfo1.setUe("STRING", ipAddr);//
  sendInfo1.setUe("STRING", siteId);//
  sendInfo1.setUe("STRING", objectId);//
  sendInfo1.setUe("INT", "1");//
  sendInfo1.setUe("LONG", loginAcceptc);//
  
  
  /****tianyang add for pos start *****/
  sendInfo1.setUe("STRING", payType);
  sendInfo1.setUe("STRING", MerchantNameChs);
  sendInfo1.setUe("STRING", MerchantId);
  sendInfo1.setUe("STRING", TerminalId);
  sendInfo1.setUe("STRING", IssCode);
  sendInfo1.setUe("STRING", AcqCode);
  sendInfo1.setUe("STRING", CardNo);
  sendInfo1.setUe("STRING", BatchNo);
  sendInfo1.setUe("STRING", Response_time);
  sendInfo1.setUe("STRING", Rrn);
  sendInfo1.setUe("STRING", AuthNo);
  sendInfo1.setUe("STRING", TraceNo);
  sendInfo1.setUe("STRING", Request_time);
  sendInfo1.setUe("STRING", CardNoPingBi);
  sendInfo1.setUe("STRING", ExpDate);
  sendInfo1.setUe("STRING", Remak);
  sendInfo1.setUe("STRING", TC);
  /****tianyang add for pos end *****/
  
  String[] array1 = result.split("\\|");
  System.out.println("result===================="+result);
  System.out.println("array1.length===================="+array1.length);
  /**
  A0109061500000032@S0109061500000040|A0109061500000031@S0109061500000039|
  */
  UType custOrderInfoList  = new UType(); //�ͻ����������б�
  for(int i=0;i<array1.length;i++){
  System.out.println("array1["+i+"]===================="+array1[i]);
  		UType custOrderInfo  = new UType(); //�����ͻ������ڵ�
  		String[] array2 = array1[i].split("@");
  		System.out.println("array2.length===================="+array2.length);
  		System.out.println("�ͻ�����[0]===================="+array2[0]);
  		System.out.println("���񶩵���Ϣ[1]===================="+array2[1]);
  		custOrderInfo.setUe("STRING", array2[0].trim());//����ͻ�������
  		String[] array3 = array2[1].split("~");//��ȡ���񶩵���
  		UType servOrderInfoList  = new UType(); //���������б�ڵ�
  		for(int j=array3.length-1;j>=0;j--){
  		System.out.println("���񶩵�["+j+"]===================="+array3[j]);
  			UType servOrderInfo  = new UType(); //�������񶩵��ڵ�
  			servOrderInfo.setUe("STRING", array3[j].trim());//������񶩵���
  			
  			servOrderInfoList.setUe(servOrderInfo);//�ѷ��񶩵��ڵ���������ͻ������ڵ���
  		}
  		custOrderInfo.setUe(servOrderInfoList);//�ѷ��񶩵��ڵ������񶩵��б���
  		custOrderInfoList.setUe(custOrderInfo);//�ѷ��񶩵��б�ڵ����ͻ����������б���
 	}
 	/*
 	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
	System.out.println(logBuffer.toString());
	*/
%>
<wtc:utype name="sOrderBack" id="retVal" scope="end" >
<wtc:uparam value="<%= sendInfo1 %>" type="UTYPE"/>      
<wtc:uparam value="<%= custOrderInfoList %>" type="UTYPE"/>           
<wtc:uparam value="<%= loginAcceptHv %>" type="LONG"/>           
</wtc:utype>
<%
	String retCode=retVal.getValue(0);
	String retMsg=retVal.getValue(1);
	System.out.println("retCode1========================="+retCode);
	System.out.println("retMsg========================="+retMsg);
	
	    String statisLoginAccept =  request.getParameter("loginAccept"); /*��ˮ*/
		String statisOpCode=opCode;
		String statisPhoneNo= request.getParameter("srvno");	
		String statisIdNo="";	
		String statisCustId="";
		String statisUrl = "/npage/public/pubCustSatisIn.jsp"
			+"?statisLoginAccept="+statisLoginAccept
			+"&statisOpCode="+statisOpCode
			+"&statisPhoneNo="+statisPhoneNo
			+"&statisIdNo="+statisIdNo	
			+"&statisCustId="+statisCustId;	
    	System.out.println("@zhangyan~~~~statisLoginAccept="+statisLoginAccept);
    	System.out.println("@zhangyan~~~~statisOpCode="+statisOpCode);
    	System.out.println("@zhangyan~~~~statisPhoneNo="+statisPhoneNo);
    	System.out.println("@zhangyan~~~~statisIdNo="+statisIdNo);
    	System.out.println("@zhangyan~~~~statisCustId="+statisCustId);
    	System.out.println("@zhangyan~~~~statisUrl="+statisUrl);
    	
   		if (statisOpCode.equals("127a"))
		{
		%>
		<jsp:include page="<%=statisUrl%>" flush="true" />	
		
		<%	
		}		
	
	
  System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
	
	String loginAccept = "";//����δ������ˮ,�����ÿ�
	String cnttActivePhone = srvno;
	String opName="����������ѯ";
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCodeCfm+"&retCodeForCntt="+retCode+"&opName="+opNameCfm+"&workNo="+workNo+"&loginAccept="+loginAcceptc+"&pageActivePhone="+cnttActivePhone+"&opBeginTime="+opBeginTime+"&contactId="+cnttActivePhone+"&contactType=user";
	System.out.println("url||||"+url);
%>
	<jsp:include page="<%=url%>" flush="true" />
	
	
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");

core.ajax.receivePacket(response);