<%
  /* 
   * ����:�������������ܺ������ۺ�������������Ĺ���
   * �汾: 1.0
   * ����: 2011/06/1
   * ����: huangrong
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/common/serverip.jsp" %>

<%
String opCode = "6945";
String opName = "�������������ܺ������ۺ�����";
String workno = (String)session.getAttribute("workNo");
String chnSource="01";
String groupId =(String)session.getAttribute("groupId");//��������
String loginPass =(String)session.getAttribute("password");
String regionCode = (String)session.getAttribute("regCode");
String sSaveName = request.getParameter("sSaveName");
String remark = request.getParameter("remark"); //��ע��Ϣ
String delayType = request.getParameter("delayType"); //huangrong add ��ȡ���ڱ�־ 2011-6-29
System.out.println("========================="+delayType);
String seled = request.getParameter("seled"); 
//System.out.println("seed====="+seled);
String filename = request.getParameter("filename"); 
String serverIp=realip.trim();
System.out.println("serverIp:"+serverIp);
String total_no = "";//�����ɹ�����
int flag = 0;
%>
	<wtc:service name="s6947Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="1" >
		<wtc:param value="0"/>
		<wtc:param value="<%=chnSource%>"/>		
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=loginPass%>"/>			
		<wtc:param value=" "/>
		<wtc:param value=" "/>						
		<wtc:param value="<%=sSaveName%>"/>
		<wtc:param value="<%=serverIp%>"/>			
		<wtc:param value="<%=remark%>"/>		
		<wtc:param value="<%=delayType%>"/>			<!--huangrong add ���ڱ�־��� 2011-6-29-->	
			<wtc:param value="<%=seled%>"/>						
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%  
	if(!sReturnCode.equals("000000")){
		flag = -1;
		System.out.println(" ������Ϣ : " + sErrorMessage);
	}
	if (flag == 0)
	{	
		total_no = result[0][0];
	}
	else
	{
		System.out.println("failed, ���� !");
	}
String groupNameSql = "select group_name from dchngroupmsg where group_id='"+groupId+"'";
String groupName="";
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1" retcode="retCode" retmsg="retMsg">
   <wtc:sql><%=groupNameSql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="groupNameStr" scope="end"/>
<%
  if(retCode.equals("000000"))
  {
  	groupName=groupNameStr[0][0];
  }	
	else
	{
		System.out.println("failed, ���� !");
	}
%>  	
<HEAD><TITLE>������BOSS-��������������������ܺ������ۺ�������</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
<!--
function gohome()
{
	document.location.replace("f6945_3.jsp");
}

function seeInformation()
{
	var path = "<%=request.getContextPath()%>/npage/s1210/s6945Error.jsp?fileName=<%=filename%>";
	window.open(path,"","height=500, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
}
-->
</script>
</HEAD>
<BODY>
<FORM action="f6945_3.jsp" method=post name=form>
   <%@ include file="/npage/include/header.jsp" %>
		<table cellspacing="0">
		  <tbody> 
		  <tr> 
		    <td class="blue" width="10%">��������</td>
		    <td width="40%">�����������������ܺ������ۺ�������</td>
		    <td class="blue" width="10%">����</td>
		    <td width="40%"><%=groupName%></td>		    
		  </tr>
		  </tbody> 
		</table>
		<table cellspacing="0">
		   <tbody> 
		    <tr > 
		      <td colspan="2">
		        <div align="center">��������������������ܺ������ۺ������ܡ�			
					  	<br> 					
<% 
						  	if (flag == 0){
%>
						  	�ɹ�������<%=total_no%>��
<% 
			           }else 
			           { 
%>
			           	������룺'<%=sReturnCode%>'��<br>������Ϣ��'<%=sErrorMessage%>'��");
<%
			           } 
%>					   
					     <br><input class="b_foot_long" name="seeInfo" type="button" value="ʧ����Ϣ�鿴" onClick="seeInformation()">
					 </div>
		      </td>
		    </tr>
		    </tbody> 
		</table>
		<table cellspacing="0">
		  <tbody> 
		  <tr id="footer"> 
		    <td align=center bgcolor="F5F5F5" width="100%"> 
		      <input class="b_foot" name="confirm" disabled type="submit" value="ȷ��">
		      &nbsp; 		      
		      <input class="b_foot" name="goBack" type="reset" value="����" onClick="gohome()">
		      &nbsp; 
		    </td>
		  </tr>
		  </tbody> 
		</table>
		<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>




