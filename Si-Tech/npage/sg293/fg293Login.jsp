<%
  /*
   * ����:УѶͨapn���ܿ�ͨ
   * �汾: 1.0
   * ����: 2012/09/25
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/common/serverip.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String sWorkNo = (String)session.getAttribute("workNo");
 		String dNopass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String custName=""; 
		//��ѯ�ͻ���Ϣsql
		String custSql = "select doc.cust_name from dcustdoc doc,dcustmsg msg where doc.cust_id = msg.cust_id and msg.phone_no=:phoneNo";
		String srv_params = "phoneNo=" + phoneNo;
 		String PrintAccept = getMaxAccept();
 		String serverIp=realip.trim();
 		
 		String ip = (String)session.getAttribute("ipAddr");
 		String ssss = "ͨ��phoneNo[" + phoneNo + "]��ѯ";
%>

<wtc:service name="sUserCustInfo" outnum="40" >
      <wtc:param value="<%=PrintAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=sWorkNo%>"/>
      <wtc:param value="<%=dNopass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value="<%=ip%>"/>
      <wtc:param value="<%=ssss%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
  
<wtc:array id="result11" scope="end" />

<wtc:service name="sG294Init" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=PrintAccept%>" />
		<wtc:param value="01" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=sWorkNo%>" />
		<wtc:param value="<%=dNopass%>" />
		<wtc:param value="<%=phoneNo%>" />
		<wtc:param value="" />
	</wtc:service>
	<wtc:array id="result22" scope="end" />

	<%
		if(result11.length <= 0)
		{
%>
<script language="JavaScript">
			rdShowMessageDialog("���û����������û���״̬��������");
			window.location = '/npage/sg147/fg147Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>';
</script>
<%
			return ;
		}
		else
		{
			custName=result11[0][5];
		}
%>

<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("���÷���sG294Init in fg293Login.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		
	</script>
<%
	}else{
		System.out.println("���÷���sG294Init in fg293Login.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		removeCurrentTab();
	</script>
<%
	}		

%>


<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
			$("#custName").val("<%=custName%>");
			$("#phoneNo").val("<%=phoneNo%>");
			$("#loginAccept").val("<%=PrintAccept%>");
			$("#workNo").val("<%=sWorkNo%>");
			$("#noPass").val("<%=dNopass%>");
			$("#iopCode").val("<%=opCode%>");
			$("#iopName").val("<%=opName%>");
		});
		function doCommit()
		{
			var opFlag = $("input[name='opFlag']:checked").val();
			if(check(f1))
			{
				
				if(opFlag=="g293")
				{
					
					f1.action="fg293Qry.jsp";
					f1.submit();
				}
				if(opFlag=="g294")
				{
						if($("#cyclDay").val().length==0)
					{
						rdShowConfirmDialog("��ѡ���������գ�",1);
						return false;
					}
					
					$("#iOpNote").val("��ɢ���ڱ��");
					f1.action="fg294Cfm.jsp";
					f1.submit();
				}
				
			}
			
		}
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table id="koManage">
		<tr>
			<td  class="blue">��������</td>
			<td  colspan="3">
				<input type="radio" name="opFlag" value="g293" data-bind="checked:offerId" />��ѯ&nbsp;&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="g294" data-bind="checked:offerId" />���
			</td>
		</tr>
		<tr>
			<td width="20%" class="blue">�������</td>
			<td width="30%">
				<%=phoneNo%>
			</td>
			<td width="20%" class="blue">�ͻ�����</td>
			<td width="30%">
				<%=custName%>
			</td>
		</tr>
		<%
		if(result22.length>0){
			for(int i=0;i<result22.length;i++){
		%>
		<tr data-bind="visible:offerId()=='g294'">
			<td width="20%" class="blue">ԭ������</td>
			<td width="30%">
				<%=result22[i][0]%>
			</td>
			<td width="20%" class="blue">��������</td>
			<td width="30%">
				<%=result22[i][1]%>
			</td>
		</tr>
		<%
				}
			}
		%>
		<tr data-bind="visible:offerId()=='g294'">
			<td  class="blue">��������</td>
			<td  colspan="3">
				<select name="cyclDay" id="cyclDay">
					<option value="">--��ѡ��--</option>
					<option value="1">1</option>
					<option value="5">5</option>
					<option value="10">10</option>
					<option value="15">15</option>
					<option value="20">20</option>
					<option value="25">25</option>
				</select>
			</td>
		</tr>
	</table>
	
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="ȷ��" onclick="doCommit()" id="Button1">&nbsp;&nbsp;
							<input  name="resetsd"  class="b_foot" type="button" value="���" onclick="javascript:window.location.href='/npage/sg293/fg293Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>'" id="Button3">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value=�ر� id="Button2" onclick="removeCurrentTab()">
						</td>
					</tr>
	</table>
	<!--�ֻ����� -->
	<input type="hidden" name="phoneNo" id="phoneNo" value=""/>
	<!--�ͻ����� -->
	<input type="hidden" name="custName" id="custName" value=""/>
	<!--��ˮ�� -->
	<input type="hidden" name="loginAccept" id="loginAccept" value=""/>
	<!--���� -->
	<input type="hidden" name="workNo" id="workNo" value=""/>
	<!--���� -->
	<input type="hidden" name="noPass" id="noPass" value=""/>
	<!--opcode -->
	<input type="hidden" name="iopCode" id="iopCode" value=""/>
	<!--opname -->
	<input type="hidden" name="iopName" id="iopName" value=""/>
	<!--iOpNote -->
	<input type="hidden" name="iOpNote" id="iOpNote" value=""/>
	<!--iIpAddr -->
	<input type="hidden" name="iIpAddr" id="iIpAddr" value="<%=serverIp%>"/>
	
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<!--ko���� script����-->
<script language="javascript">
var myViewModel = {
					offerId:ko.observable("<%=opCode%>")
		};
		ko.applyBindings(myViewModel,$("#koManage")[0]);
		
</script>

</html>
