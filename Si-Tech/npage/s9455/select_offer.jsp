<% 
  /*
   * ����: ��ѯ�û���ѡ��BlackBerry�����ʷ�
�� * �汾: v1.00
�� * ����: 2010/04/07
�� * ����: daixy
�� * ��Ȩ: sitech
   * ���������ݴ����ҵ�����Ͳ�ѯ�û���ѡ��BlackBerry�����ʷ� 
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   *  
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% request.setCharacterEncoding("GBK");%> 
<%
	String iBusiType = request.getParameter("iBusiType");
	String orgCode = (String)session.getAttribute("orgCode");
   	String regionCode = orgCode.substring(0,2);
	String levelsql = "select level_id,offer_name from sBlackBerrylevel where busi_type="+iBusiType;
%>
 		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=levelsql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />
<%
		if(retCode1.equals("0")||retCode1.equals("000000"))
		{
			System.out.println("result1.length="+result1.length);
		}else{
 			System.out.println("���÷���sPubSelect in select_offer.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			System.out.println("retCode1="+retCode1+"retMsg1"+retMsg1);
%>
		<script language=javascript>
		rdShowMessageDialog("��ѯ�û���ѡ��BlackBerry�����ʷѳ���������룺"+retCode1+"������Ϣ��"+retMsg1);
		</script>
<%
 		}
%>
		
var response = new AJAXPacket();
var myArrayId=new Array();
var myArrayName=new Array();
<%
		for(int i=0;i<result1.length;i++)
		{
%>	
	myArrayId.push("<%=result1[i][0]%>");
	myArrayName.push("<%=result1[i][1]%>");
<%
		}
%>

response.data.add("retType","0");
response.data.add("length","<%=result1.length%>");
response.data.add("myArrayId",myArrayId);
response.data.add("myArrayName",myArrayName);
core.ajax.receivePacket(response);