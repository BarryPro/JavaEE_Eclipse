<%
  /*
   * ����: �û��������޸�2308
   * �汾: 1.0
   * ����: 2009/1/15
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
	 					//��������
	String phoneNo = request.getParameter("phoneNo").trim();					//�û�����
	//String opCode = request.getParameter("opCode");						//��������
	String opCode = "e384";	
	String orgCode = request.getParameter("orgCode");					//��������
	String regionCode = (String)session.getAttribute("regCode");		//���д���
	String iLoginAccept ="0";
	//String iChnSource  =request.getParameter("channelId");
	String iChnSource  ="01";
	String workno = (String)session.getAttribute("workNo");
	//String pwd = request.getParameter("pwd");
	String pwd ="";
	String nopass = (String)session.getAttribute("password");
	//System.out.println("1111111111111111111111iChnSource is "+iChnSource+" and pwd is "+pwd);
	//String sql_name = "select a.cust_name from dcustdoc a where a.cust_id =  ( select cust_id from dcustmsg b where b.phone_no ='?' )   ";
	//new ���� ��ѯwChargeCardMsg��add_pay_money ��Է�ת���� �� �����Ķ�Ҫд �������getUserMore����д
	String add_money="";
	//String sql_money="select to_char(add_pay_money) from wChargeCardMsg where phone_no1='?' and phone_no2='?' ";

	String ipAddr =  (String)session.getAttribute("ipAddr");
	
	String s_note="";
	s_note="�����ֻ�����"+phoneNo+"���в�ѯ";
	String detail_id = request.getParameter("detail_id");
	String[] strArray = detail_id.split(",");   
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaa detail_id is "+detail_id+" and strArray[0] is "+strArray[0]+" and strArray[1] is "+strArray[1]);
%>
 
	<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="40">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workno%>"/>
			<wtc:param value="<%=nopass%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=ipAddr%>"/>
			<wtc:param value="<%=s_note%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
</wtc:service>
<wtc:array id="resultName" scope="end"/>



<%
	String errCode2 = retCode2;
	String errMsg2 = retMsg2;
	String custName = "";
	if(resultName!=null)
	{
		custName=resultName[0][16];
		System.out.println("aaaaaaaaaaaaa~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~aaaaaaaaaa custName is "+custName);
	}
%>	
 
	<wtc:service name="sQryAwardCardBD" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=pwd%>"/>
		<wtc:param value="<%=strArray[0]%>"/>
		<wtc:param value="<%=strArray[1]%>"/>
	</wtc:service>
	<wtc:array id="mainInfo1"  scope="end"/>
 
<%
	String errCode = retCode;
	String errMsg = retMsg;
	
	/*���¿����ж�ֵ*/
	String oStoreNo="";/*��ֵ����ʼ����*/
	String oEndStoreNo="";/*��ֵ����������*/
	String oTranMianzhi=""; /*��ֵ����ֵ*/
	
	String oCustName="";
	String cardFlag = "";
	String scount="";
	int icount=0;//������
	String[][] out_money  = null ;
	String[][] result1  = null ;
	String[][] result2  = null ;
	String[][] result3  = null ;

	result1 = mainInfo1;
 
	if(errMsg.equals("")){
		errMsg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errCode));
		if( errMsg.equals("null")){
			errMsg ="δ֪������Ϣ";
		}
	} 
	
	%>//alert("retCode is "+"<%=retCode%>");<%
	if(retCode.equals("0")||retCode.equals("000000"))
	{
		scount = result1[0][3];
		System.out.println("QQQQQQQQQQQQQQQQQ scount is "+scount);
		icount = Integer.parseInt(scount);
		System.out.println("AAAAAAAAAAAAAAAAAAaQQQQQQQQQQQQQQQQQ icount is "+icount);
		%>
		var response = new AJAXPacket();
		<%
		 
		 
		 
		%>
			
			//alert("scount is "+"<%=scount%>"+" and result1.length is "+"<%=result1.length%>");
			response.data.add("flag1","0");//��ѯ�ɹ�

			
			<%
				
				for(int i = 0;i<result1.length;i++)
				{
					%>
						response.data.add("oStoreNo"+"<%=i%>","<%=result1[i][0]%>"); //��ʼ
						response.data.add("oEndStoreNo"+"<%=i%>","<%=result1[i][1]%>");//����
						response.data.add("oTranMianzhi"+"<%=i%>","<%=result1[i][2]%>");
						response.data.add("icardNum"+"<%=i%>","<%=result1[i][3]%>");//���Ŷ��ڵ�����
						
						//alert("oStoreNo is "+"<%=result1[i][0]%>");
					<%
					
				}
					
				
			%>
			 
	        response.data.add("iNumLen","<%=result1.length%>");//���м��� ��������   
			 
		 
			response.data.add("custName","<%=custName%>");
			core.ajax.receivePacket(response);
		<%
	}
	else
	{
		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAʧ���� errCode is "+errCode+" and errMsg is "+errMsg);
		%>
			var response = new AJAXPacket();
			
			response.data.add("flag1","1");
			
			response.data.add("errCode","<%=errCode%>");
			response.data.add("errMsg","<%=errMsg%>");
			core.ajax.receivePacket(response);
		<%
	}
	

%>
	
 