<%
  /*
   * ����:���Ӫ��������Ϣ��ѯ(g832)
   * �汾: 1.0
   * ����: 2013/07/15 10:10:01
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		//String phoneNo = (String)request.getParameter("activePhone");
		//��ˮ��
 		String loginAccept = getMaxAccept();
%>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		function doQryIt1()
		{
			if(!check(form_g832))
			{
				return false;
			}
			//�ֻ�����
			var iPhoneNo = $("input[name='iPhoneNo']").val().trim();
			//�������
			var iCfmLogin = $("input[name='iCfmLogin']").val().trim(); 
			if(iPhoneNo.length==0 && iCfmLogin.length==0)
			{
				rdShowMessageDialog("�ֻ�����������������ѡ��һ�����룡",1);
				return false;
			}
				var getdataPacket = new AJAXPacket("fg832Qry.jsp","���ڻ�����ݣ����Ժ�......");
  			getdataPacket.data.add("iLoginAccept","<%=loginAccept%>");
  			getdataPacket.data.add("iChnSource","01");
  			getdataPacket.data.add("iOpCode","<%=opCode%>");
  			getdataPacket.data.add("iOpName","<%=opName%>");
  			getdataPacket.data.add("iLoginNo","<%=loginNo%>");
  			getdataPacket.data.add("iLoginPwd","");
  			getdataPacket.data.add("iPhoneNo",iPhoneNo);
  			getdataPacket.data.add("iUserPwd","<%=noPass%>");
  			getdataPacket.data.add("iOpNote","���Ӫ��������Ϣ��ѯ");
  			getdataPacket.data.add("iCfmLogin",iCfmLogin);
  			core.ajax.sendPacketHtml(getdataPacket,myRetFunc);
  			getdataPacket = null;
		}
		function myRetFunc(data)
		{
				//�ҵ���ӱ���div
				var markDiv=$("#intablediv"); 
				//���ԭ�б��
				markDiv.empty();
				//ѹ������
				markDiv.append(data);
			
		}
	</script>
	</head>
<body>
	<form action="" method="post" name="form_g832">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div id="koManage">
	<table>
		<tr>
			<td width="15%" class="blue">�ֻ�����</td>
			<td width="35%">
				<input type="text"  name="iPhoneNo" value="" v_type="mobphone" onblur="checkElement(this)"/>
			</td>
			<td width="15%" class="blue">�������</td>
			<td width="35%">
				<input type="text" name="iCfmLogin" value=""/>
			</td>
		</tr>
	</table>
	<div id="intablediv">
	</div>
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="��ѯ" onclick="doQryIt1()" id="doQryIt">&nbsp;&nbsp;
							<input  name="resetsd"  class="b_foot" type="button" value="���" onclick="javascript:window.location.href='/npage/sg832/fg832Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>'" id="Button3">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value="�ر�" id="Button2" onclick="removeCurrentTab()">
						</td>
					</tr>
	</table>
	
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<!--ko���� script����-->
<script language="javascript">
	var myViewModel = {
					/*offerId:ko.observable("<%=opCode%>")*/
		};
		ko.applyBindings(myViewModel,$("#koManage")[0]);
</script>

</html>
