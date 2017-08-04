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
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
	 	String opCode = "6236";
		String opName = "呼叫等待激活";
		String phoneNo = (String)request.getParameter("activePhone");

%>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		function doCommit(){
			var srv_no = $.trim($("input[name='srv_no']").val());
			var cust_pass = $.trim($("input[name='cust_pass']").val());
			if(srv_no.length == 0 ){
				rdShowMessageDialog("请输入服务号码！");
				return false;
			}
			if(cust_pass.length == 0 ){
				rdShowMessageDialog("用户密码不能为空！");
				return false;
			}
			
			frm.action="/npage/s1210/s6236Main.jsp";
    	frm.submit();
		}
		
	
	</script>
	</head>
<body>
	<form action="" method="post" name="frm" id="frm">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
		<table>
	    <tr>
	  		<td width="20%" class="blue">服务号码</td>
	  		<td width="30%">
	  			<input type="text" id="srv_no" name="srv_no" v_type="0_9" maxlength="11" value="" onblur="checkElement(this)"/>&nbsp;&nbsp;
	  			
	  		</td>
	  		<td width="20%" class="blue">用户密码</td>
	  		<td width="30%">
	  			<jsp:include page="/npage/common/pwd_9.jsp">
              <jsp:param name="width1" value="16%"  />
              <jsp:param name="width2" value="34%"  />
              <jsp:param name="pname" value="cust_pass"  />
              <jsp:param name="pwd" value="12345"  />
 	        </jsp:include>
	  		</td>
	    </tr>
	  </table>
	  <table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<input class="b_foot" id="configBtn" name="configBtn"  type="button" value="确认"  onclick="doCommit();">&nbsp;&nbsp;
				<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=关闭>
			</td>
		</tr>
		</table>
	 </div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>


</html>
