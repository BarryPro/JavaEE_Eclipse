<%
  /*
   * ����:�ƶ���ͥ�ͻ����ҵ����Ӫ֧��ϵͳ���� ������ϲ�ѯ
   * �汾: 1.0
   * ����: 2014/04/18 15:17:18
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
		String phoneNo = (String)request.getParameter("activePhone");
		
 		String loginAccept = getMaxAccept();
	
%>

<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		function doQry(){
			if($.trim($("#cfm_login").val()).length == 0){
				rdShowMessageDialog("���������˺ţ�");
				return false;
			}
			
			var msgPacket = new AJAXPacket("fm093Qry.jsp","���ڻ�ȡ���ݣ����Ժ�......");
			msgPacket.data.add("iLoginAccept","<%=loginAccept%>");
			msgPacket.data.add("iChnSource","01");
			msgPacket.data.add("iOpCode","<%=opCode%>");
			msgPacket.data.add("iLoginNo","<%=loginNo%>");
			msgPacket.data.add("iLoginPwd","<%=noPass%>");
			msgPacket.data.add("iPhoneNo","");
			msgPacket.data.add("iUserPwd","");
			msgPacket.data.add("iCfmLogin",$.trim($("#cfm_login").val()));
			core.ajax.sendPacket(msgPacket, doFm093QryBack);
				
			
		}
		function doFm093QryBack(packet){
			
				var retCode = packet.data.findValueByName("retcode");
				var retMsg = packet.data.findValueByName("retmsg");
				var vRetAccept = packet.data.findValueByName("vRetAccept");
				//alert(vRetAccept);
				
				$("#appendSome").empty();
				var msgArr = new Array();
				if(retCode == "000000"){
					msgArr = vRetAccept.split("#");
					for(var i=0;i<msgArr.length;i++){
						var inArr = new Array();
						inArr = msgArr[i].split(" ");
						var appendTd = "";
						appendTd += "<tr>";
						appendTd += "<td>"+inArr[0]+"</td>";
						appendTd += "<td>"+inArr[1]+"</td>";
						appendTd += "<td>"+inArr[2]+"</td>";
						appendTd += "</tr>";
						$("#appendSome").append(appendTd);
						
					}
					
					
					$("#showAndHide").show();
					$("#showAndHide1").show();
					
				}else{
					/*
					$("#vRetAccept").find("td").eq(1).html("vRetAccept");
					$("#vRetCodede").find("td").eq(1).html("vRetCodede");
					$("#vRetMsg").find("td").eq(1).html("vRetMsg");
					$("#vRetLogMsg").find("td").eq(1).html("vRetLogMsg");
					
					$("#showAndHide").show();
					$("#showAndHide1").show();
					*/
					
					$("#showAndHide").hide();
					$("#showAndHide1").hide();
					rdShowMessageDialog("������룺" + retCode+",������Ϣ��" + retMsg);
				}
				
			
		}
		
		
	</script>
	</head>
<body>
	<form action="" method="post" name="form_i146" id="form_i146">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
	<table >
	
		<tr>
			<td class="blue" width="30%">����˺�</td>	
			<td><input type="text" id="cfm_login" name="cfm_login" value=""/>&nbsp;<font color="red">*</font></td>
		</tr>
	</table>
	<div class="title" style="display:none" id="showAndHide1">
			<div id="title_zi">��ѯ���</div>
	</div>
	
		<table style="display:none" id="showAndHide">
			<tr>
				<th>ʱ��</th>
				<th>���ϴ���</th>
				<th>������Ϣ</th>
			</tr>
			<tbody id="appendSome">
			</tbody>
		<table>
	
	
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="��ѯ" onclick="doQry()" id="submitr" >&nbsp;&nbsp;
							<input  name="resetsd"  class="b_foot" type="button" value="����" onclick="window.location.href = '/npage/sm093/fm093Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';" id="Button3">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value=�ر� id="Button2" onclick="removeCurrentTab()">
						</td>
					</tr>
	</table>
</div>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>
