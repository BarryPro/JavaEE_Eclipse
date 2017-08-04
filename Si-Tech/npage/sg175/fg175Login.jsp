<%
  /*
   * 功能:
   * 版本: 1.0
   * 日期: 
   * 作者: gaopeng
   * 版权: si-tech
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
    			    rdShowMessageDialog('请输入手机密码！', '0');
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
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
		checkPwd_Packet.data.add("custType", "01");						//01:手机号码 02 客户密码校验 03帐户密码校验
		checkPwd_Packet.data.add("phoneNo", phoneId);		//移动号码,客户id,帐户id
		checkPwd_Packet.data.add("custPaswd", pwdId);//用户/客户/帐户密码
		checkPwd_Packet.data.add("idType", "");							//en 密码为密文，其它情况 密码为明文
		checkPwd_Packet.data.add("idNum", "");							//传空
		checkPwd_Packet.data.add("loginNo", "<%=workNo%>");				//工号
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
				手机号码
			</td>
			<td>
				<input type="text" name="phoneNo"  value="" v_must="1" v_type="mobphone" onblur="checkElement(this)"/><span style="color:red">*</span>
			</td>

<%
        System.out.println("==zhouby======fg175Login.jsp==== pwrf = " + pwrf);
        
				if (pwrf) {
%>
					<td width="50%" class="orange">
						该工号具有“免密码”权限，不需要输入用户密码
					</td>
<%				
				} else {
%>
					<td class="blue" width="20%">
						用户密码
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
			<input type="button" class="b_foot" value="确认" onclick="doSubmit()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="reset" class="b_foot" value="清除" />
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab();"/>
			</td>
		</tr>
	</table>
	<input type="hidden" name="opCode" value="<%=opCode%>"/>
	<input type="hidden" name="opName" value="<%=opName%>"/>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>


</html>
