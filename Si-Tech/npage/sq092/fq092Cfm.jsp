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
	
	String opCodeCfm = request.getParameter("opCodeCfm");
  String loginAcceptc = request.getParameter("loginAccept");


	System.out.println("retType======="+retType);
	System.out.println("workNo ======="+workNo);
	System.out.println("opCode======="+opCode);
	System.out.println("srvno ======="+srvno);
	System.out.println("password======="+password);
	System.out.println("ipAddr ======="+ipAddr);
	System.out.println("siteId======="+siteId);
	System.out.println("objectId ======="+objectId);
		System.out.println("opCodeCfm===add===="+opCodeCfm);
	System.out.println("loginAccept ===add===="+loginAcceptc);
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
 </wtc:utype>
<%
	String retCode=retVal.getValue(0);
	String retMsg=retVal.getValue(1);
	System.out.println("retCode1============sOrderBack============="+retCode);
	System.out.println("retMsg============sOrderBack============="+retMsg);
	
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