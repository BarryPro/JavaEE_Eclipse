<%
  /*
   * ���ڡ�˫ʮһ������Ӫ������֧�Ź��ܵĿ������󡪡�18Ԫ�׿�����
   * ���� 4  ���4 6 7��
   * ����: 2013/11/01 15:16:43
   * ����: gaopeng
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  
  String currentMonth = new java.text.SimpleDateFormat("MM", Locale.getDefault())
  												.format(new java.util.Date());
	String currentYear = new java.text.SimpleDateFormat("yyyy", Locale.getDefault())
  												.format(new java.util.Date());
  
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
  String phoneNo = (String)request.getParameter("phoneNo");
  String retCode1="";
  String retMsg1="";

 String opnote =workNo+"����"+opCode+"����";
/**
 *@        iLoginAccept              	��ˮ
 *@        iChnSource              	   	������ʶ
 *@        iOpCode                 		��������
 *@        iLoginNo              	   	����
 *@        iLoginPwd                   	��������
 *@        iPhoneNo              	   	�ֻ�����
 *@        iUserPwd              	   	��������
 *@        iOpNote              	   	��ע
 *@        iFlag              	   		0д��1��д��������2����¼��3���4���ʧ��5����ʧ�ܻ��û���������
 *@ ���ز�����
 *@        oRetCode						���ش���
 *@        oRetMsg						�������� 
 *@        vPhoneNo						�ֻ�����
 *@        vSimNo						SIM����
 *@        vSimType						SIM����
 *@        vMailPerson					�ջ�������
 *@        vMailPhone					�ջ��˵绰
 *@        vMailAddress					�ջ��˵�ַ
 *@        vStreamNo					��������
 *@        vCompanyName					������˾����
 *@        vGroupId					    Ӫҵ��

*/
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="accept"/>
	
<wtc:service name="sg530Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="27">
		<wtc:param value="<%=accept%>"/>
  	<wtc:param value="01"/>
  	<wtc:param value="<%=opCode%>"/>
  	<wtc:param value="<%=workNo%>"/>
  	<wtc:param value="<%=password%>"/>
    <wtc:param value="<%=phoneNo%>"/>
  	<wtc:param value=""/>
  	<wtc:param value="<%=opnote%>"/>
  	<wtc:param value="6"/>
</wtc:service>

<wtc:array id="result" scope="end" />

<body>
<form name="frm" method="post" action="">
  <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
  <input type="hidden" name="opName" id="opName" value="<%=opName%>">
  <input type="hidden" name="sysAccept" value="<%=accept%>">
  <div class="title">
    <div id="title_zi">������Ϣ</div>
  </div>
  
  <table cellspacing="0">
		<tr> 
			<th>�ֻ�����</th>
			<th>�ջ�������</th>
			<th>��ϵ�绰</th>
			<th>�ͻ���ַ</th>
			<th></th>
		</tr>
		<%	
	if (retCode.equals("000000") && result.length > 0){
	System.out.println(result.length+"====gaopengSee");
			for(int i = 0; i < result.length; i++){
		%>
			<tr>
					<td><%=result[i][0]%></td>
					<td><%=result[i][1]%></td>
					<td><%=result[i][2]%></td>
					<td><%=result[i][3]%></td>
				  <td><input type="button" class="b_text" name="btnq" value="����" onclick="removeBill(<%=phoneNo%>)"/></td>
			</tr>		
		<%
					}
			}
		else{
		%>
			<script language="JavaScript">
							rdShowMessageDialog("������룺"+"<%=retCode%>"+",������Ϣ��"+"<%=retMsg%>");
					</script>
		<%
			}
		%>
		
  </table>
</form>
</body>
</html>