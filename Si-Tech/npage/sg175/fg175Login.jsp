<%
  /*
   * ����:
   * �汾: 1.0
   * ����: 
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
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		
		String workNo = (String)session.getAttribute("workNo");

    boolean pwrf = false;
    String pubOpCode = opCode;
%>
        
    <%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		function doSubmit()
		{
			if(check(f1))
			{
			  <%
			  if (!pwrf){
			  %>
    			  if ($('input[name="fatherPwd4"]').val() == ''){
    			    rdShowMessageDialog('�������ֻ����룡', '0');
    			    return;
    			  }
    			  checkUserPwd($('input[name="phoneNo"]').val(),
    			   $('input[name="fatherPwd4"]').val());
			  <%
			} else {
			  %>
              f1.action="/npage/sg175/fg175Main.jsp";
		f1.submit();
			  
			  <%
			  }
			  %>
			}
		}
	
function checkUserPwd(phoneId, pwdId) {
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
		checkPwd_Packet.data.add("custType", "01");						//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
		checkPwd_Packet.data.add("phoneNo", phoneId);		//�ƶ�����,�ͻ�id,�ʻ�id
		checkPwd_Packet.data.add("custPaswd", pwdId);//�û�/�ͻ�/�ʻ�����
		checkPwd_Packet.data.add("idType", "");							//en ����Ϊ���ģ�������� ����Ϊ����
		checkPwd_Packet.data.add("idNum", "");							//����
		checkPwd_Packet.data.add("loginNo", "<%=workNo%>");				//����
		core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
		checkPwd_Packet=null;
	}

function doCheckPwd(packet){
    var retResult = packet.data.findValueByName("retResult");
    var msg = packet.data.findValueByName("msg");
    if (retResult != '000000'){
        rdShowMessageDialog(msg, '0');
        return;
    }
    
    f1.action="/npage/sg175/fg175Main.jsp";
		f1.submit();
}
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table>
		<tr>
			<td class="bule">
				�ֻ�����
			</td>
			<td>
				<input type="text" name="phoneNo"  value="" v_must="1" v_type="mobphone" onblur="checkElement(this)"/><span style="color:red">*</span>
			</td>

<%
        System.out.println("==zhouby======fg175Login.jsp==== pwrf = " + pwrf);
        
				if (pwrf) {
%>
					<td width="50%" class="orange">
						�ù��ž��С������롱Ȩ�ޣ�����Ҫ�����û�����
					</td>
<%				
				} else {
%>
					<td class="blue" width="20%">
						�û�����
					</td>
					<td width="30%">
							<jsp:include page="/npage/common/pwd_1.jsp">
								<jsp:param name="width1" value="16%"/>
								<jsp:param name="width2" value="34%"/>
								<jsp:param name="pname" value="fatherPwd4"/>
								<jsp:param name="pwd" value=""/>
							</jsp:include>
					</td>
<%
				}
%>
		</tr>
	</table>
	<table cellSpacing="0">
		<tr align="center">
			<td align="center" id="footer">
			<input type="button" class="b_foot" value="ȷ��" onclick="doSubmit()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="reset" class="b_foot" value="���" />
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab();"/>
			</td>
		</tr>
	</table>
	<input type="hidden" name="opCode" value="<%=opCode%>"/>
	<input type="hidden" name="opName" value="<%=opName%>"/>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>


</html>
