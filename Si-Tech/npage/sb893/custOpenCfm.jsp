<%
  /*
   * ����: ��վ����
   * �汾: 2.0
   * ����: 2010/11/26
   * ����: weigp
   * ��Ȩ: si-tech
   * update:
   */
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="01"  id="seq"/>
<%
	String workno 		= (String)session.getAttribute("workNo");	//��������
	String loginPwd 	= (String)session.getAttribute("password");
	String orgCode 		= (String)session.getAttribute("orgCode");
	String ip_Addr 		= (String)session.getAttribute("ip_Addr");
	String groupId 		= (String)session.getAttribute("groupId");	
	String custId 		= ""; 
	String login_accept	= seq;
	String regionCode 	= orgCode.substring(0,2);
%>
	<wtc:service name="spubGetId" routerKey="region" routerValue="<%=regionCode%>" retCode="retCode1" retMsg="retMsg1" outnum="3" >
	<wtc:param value="<%=regionCode%>"/>
	<wtc:param value="0"/>
	<wtc:param value="0"/>
	</wtc:service>
	<wtc:array id="result11" scope="end"/>
<%
	if(result11!=null&&result11.length>0){
	   	custId = result11[0][2];			
	} 
	String districtCode = orgCode.substring(2,4);
	String regionId 	= regionCode + districtCode + "999"; 
	String custStatus 	= "01";//�ͻ�״̬Ĭ��������
	String custGrade 	= "00"; //�ͻ��ȼ�һ��ͻ�
	String ownerType 	= "01"; //�ͻ����Ϊ����
	String idType 		= "0";	 //֤�����ͣ�0-���֤ 
	String custName 	= request.getParameter("custName"); 
	String custPassword	= request.getParameter("custPwd");
	String custAddr 	= WtcUtil.repNull(request.getParameter("custAddr"));  
	String idIccid 		= request.getParameter("idIccid"); 
	String idAddr 		= request.getParameter("idAddr"); 
	String contactPerson = request.getParameter("contactPerson"); 
	String contactPhone = request.getParameter("contactPhone"); 
	String contactAddr 	= request.getParameter("contactAddr"); 
	String contactMAddr = request.getParameter("contactMAddr"); 
	String custSex 		= request.getParameter("custSex");  	//�ͻ��Ա�	
	String idValidDate 	= "20201129";//֤������Ч��
	String contactPost 	= " ";//��ϵ���ʱ�
	String contactFax 	= " ";//��ϵ�˴���
	String contactMail 	= " ";//��ϵ�˵����ʼ�
	String unitCode 	= orgCode; //��������
	String parentId 	= custId;//Ĭ��Ϊ��ǰ�ͻ�Id
	String birthDay 	= "";//��������
 	  if(idIccid.trim().length()==15 && idType.equals("0")) {
		birthDay="19"+idIccid.substring(6,8)+idIccid.substring(8,12);
	  }else if(idIccid.trim().length()==18 && idType.equals("0")) {
        birthDay=idIccid.substring(6,10)+idIccid.substring(10,14);
	  }else{
        birthDay="19491001"; 
      }
	String professionId = "9999"; //����
	String vudyXl 		= "05"; //ѧ��
	String custAh 		= "��"; //�ͻ����� 
	String custXg 		= "��"; //�ͻ�ϰ��
	String unitXz 		= "C1"; //���Ź�ģ�ȼ�
	String yzlx 		= ""; //ִ������//��̨δ�õ�,���������䴫�Ͳ߷����ű�־
	String yzhm 		= ""; //ִ�պ���
	String yzrq 		= ""; //ִ����Ч��
	String frdm 		= ""; //���˴���
	String groupCharacter = WtcUtil.repStr(request.getParameter("groupCharacter"),"��");//Ⱥ����Ϣ
	String opCode 		= "1100";	
	String sysNote 		= "�½���:�ͻ�ID[" + custId + "]";
	String opNote 		= ""; 
	String oriGrpNo		= "0";
	
	//Ԥռ
	String phoneNo 		= request.getParameter("phoneNo");
	String phoneStatus  = "2";
	
	/*����������*/
	String gestoresName = WtcUtil.repStr(request.getParameter("gestoresName"),"");
	/*��������ϵ��ַ*/
	String gestoresAddr = WtcUtil.repStr(request.getParameter("gestoresAddr"),"");
	/*������֤������*/
	String gestoresIdType = WtcUtil.repStr(request.getParameter("gestoresIdType"),"");
	gestoresIdType = gestoresIdType.substring(0,gestoresIdType.indexOf("|"));
	/*������֤������*/
	String gestoresIccId = WtcUtil.repStr(request.getParameter("gestoresIccId"),"");
	/*������״̬*/
	String xsjbrxx=WtcUtil.repStr(request.getParameter("xsjbrxx"),"0");
	
	String inputStr11="";
	if(xsjbrxx.equals("1")){
		inputStr11=gestoresName+"|"+gestoresIdType+"|"+gestoresIccId+"|"+gestoresAddr+"|||||||||||01|";
	}
	else{
		inputStr11="||||||||||||||01|";
	}
	
	
   
%>


<wtc:service name="s1100Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code" retmsg="retMessage"  outnum="4" >
					<wtc:param value="<%=login_accept%>"/>
			        <wtc:param value="<%=custId%>"/>
			        <wtc:param value="<%=regionId%>"/>
			        <wtc:param value="<%=custName%>"/>
			        <wtc:param value="<%=custPassword%>"/>
			        <wtc:param value="<%=custStatus%>"/>
			        <wtc:param value="<%=custGrade%>"/>
			        <wtc:param value="<%=ownerType%>"/>         
			        <wtc:param value="<%=custAddr%>"/>
			        <wtc:param value="<%=idType%>"/>
			        <wtc:param value="<%=idIccid%>"/>
			        <wtc:param value="<%=idAddr%>"/>
			        <wtc:param value="<%=idValidDate%>"/>
			        <wtc:param value="<%=contactPerson%>"/>
			        <wtc:param value="<%=contactPhone%>"/>
			        <wtc:param value="<%=contactAddr%>"/>
			        <wtc:param value="<%=contactPost%>"/>
			        <wtc:param value="<%=contactMAddr%>"/>
			        <wtc:param value="<%=contactFax%>"/>
			        <wtc:param value="<%=contactMail%>"/>
			        <wtc:param value="<%=unitCode%>"/>	
			        <wtc:param value="<%=parentId%>"/>
			        <wtc:param value="<%=custSex%>"/>
			        <wtc:param value="<%=birthDay%>"/>
			        <wtc:param value="<%=professionId%>"/>
			        <wtc:param value="<%=vudyXl%>"/>
			        <wtc:param value="<%=custAh%>"/>	
			        <wtc:param value="<%=custXg%>"/>
			        <wtc:param value="<%=unitXz%>"/>
			        <wtc:param value="<%=yzlx%>"/>
			        <wtc:param value="<%=yzhm%>"/>
			        <wtc:param value="<%=yzrq%>"/>
			        <wtc:param value="<%=frdm%>"/>
			        <wtc:param value="<%=groupCharacter%>"/>
			        <wtc:param value="<%=opCode%>"/>
			        <wtc:param value="<%=workno%>"/>
			        <wtc:param value="<%=sysNote%>"/>
			        <wtc:param value="<%=opNote%>"/>
			        <wtc:param value="<%=ip_Addr%>"/>
			        <wtc:param value="<%=oriGrpNo%>"/>
			        <wtc:param value=""/>
			        <wtc:param value=""/>
			        <wtc:param value=""/>
			        <wtc:param value=""/>
			        <wtc:param value=""/>
			        <wtc:param value=""/>
			        <wtc:param value="<%=inputStr11%>"/>
			        
			</wtc:service>
			<wtc:array id="result" scope="end" />
			<wtc:service name="sb893Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retCode="retCode12" retMsg="retMsg12" outnum="2" >
				<wtc:param value="b893"/>
				<wtc:param value="<%=workno%>"/>
				<wtc:param value="<%=loginPwd%>"/>
				<wtc:param value="<%=groupId%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value="<%=phoneStatus%>"/>
				<wtc:param value="<%=custId%>"/>
			</wtc:service>
			<wtc:array id="result111" scope="end"/>	

<%
	System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
	String retCodeForCntt = ret_code ;
    String retMsgForCntt =retMessage;
	String loginAccept =login_accept; 
	String opName = "�ͻ�����";
	if(ret_code.equals("0")||ret_code.equals("000000")){
		if(result.length>0){
			System.out.println("s1100Cfmִ�гɹ���");
			loginAccept=result[0][2];
		}
	}else{
		System.out.println("s1100Cfmִ��ʧ�ܣ�");	
	}
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCodeForCntt+"&retMsgForCntt="+retMsgForCntt+"&opName="+opName+"&workNo="+workno+"&loginAccept="+loginAccept+"&pageActivePhone=&opBeginTime="+opBeginTime+"&contactId="+custId+"&contactType=cust";
	System.out.println("url="+url);
	System.out.println("retCodeForCntt>>"+retCodeForCntt+"  retMsgForCntt>>"+retMsgForCntt+" custId>>"+custId);
%>
<jsp:include page="<%=url%>" flush="true" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCodeForCntt%>");
response.data.add("retMsg","<%=retMsgForCntt%>");
response.data.add("cust","<%=custId%>");
core.ajax.receivePacket(response);