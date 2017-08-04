<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-06
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>

<%
String opCode = "9130";
String opName = "信息服务开关";
String Msg = request.getParameter("errMsg");
if(!"".equals(Msg) && Msg!=null)
{
%>
<script language="javascript">
rdShowMessageDialog("<%=Msg%>",0);
</script>
<%}
%>


<!----------------------正文--------------------->
<%  //----head 标题及opcode
    String pageName="信息服务开关";
	String message="";
%>
<!--@ include file="../../public/head.jsp" -->
<%

    System.out.println("f9130 Start....");

    String phone_no = request.getParameter("phone_no");

	boolean needPassword = true;


	
	
%>

<script>

//界面检查，跳转到查询结果页
function docheck(){		
	
		//if(!checkElement(document.form1.phone_no)) return false;
        if (!forMobil(document.form1.phone_no)){
		document.form1.phone_no.focus();
		return false;
	}
		document.form1.action="f9130_info.jsp";
		document.form1.submit();
	
}
function GetResult()
		{
		   var str=document.form1.phone_no.value;

			var oBao = new ActiveXObject("Microsoft.XMLHTTP");
			oBao.open("POST","f9130_panduan.jsp?phone_no="+str,false);
			oBao.send();
			var arrstr = new Array();
			arrstr = unescape(oBao.responseText).split("#");
			document.all.panduan.value=arrstr[1];

		}
 </script>



 <!-----------正文-------->
<form action="" method="post" name="form1">
    <%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">信息服务开关</div>
</div>
 	
<table cellspacing="0">
	<tbody>
		<tr>
			<td class=blue>
				用户号码
			</td>
			<td>

				<input type="text" name="phone_no" v_must=1 v_type="phone_no" maxlength="11" size="20" onKeyPress="return isKeyNumberdot(0)" value="<%
						if(phone_no!=null) out.println(phone_no);%>"/><font class="orange">*</font>
			</td>
			<td class=blue>
				用户密码
			</td>

			<%if (!needPassword) {%>
			<TD>
				<input type="password" name="user_passwd" size="20" maxlength="8" disabled>
			</TD>
			<%} else {

%>
			<td nowrap>
				<div align="left">
					<jsp:include page="/npage/common/pwd_1.jsp">
						<jsp:param name="width1" value="16%" />
						<jsp:param name="width2" value="34%" />
						<jsp:param name="pname" value="user_passwd" />
						<jsp:param name="pwd" value="12345" />
					</jsp:include>
				</div>
			</td>
			<%}%>

		</tr>
<input type="hidden" name = "panduan" value = "">
		
</table>
	<%@ include file="../../../npage/common/pwd_comm.jsp" %>
<table cellspacing="0">
		<TR>
			<TD noWrap id="footer" align="center">
				<input type="button" name="query" class="b_foot" value="查询" onclick="docheck()" index="9">
				&nbsp;
				<input type="button" name="return1" class="b_foot" value="清除" onclick="window.location='f9130.jsp'" index="10">
				&nbsp;
				<input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" index="13">
			</TD>
		</TR>
	</TABLE>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
<!------------------------------------->
