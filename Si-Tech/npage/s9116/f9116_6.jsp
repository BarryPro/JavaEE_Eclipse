<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
    String opCode = "9116";
    String opName = "DSMP批量文件上传";
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String regionCode=(String)session.getAttribute("regCode");
	String op_name =  "DSMP批量业务处理文件上传";
	
	String sqlStr = "";
	int recordNum=0;
	int i=0;
	String  retNo = ""; 
	String loginPwd  = (String)session.getAttribute("password");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE><%=op_name%></TITLE>
<script language="JavaScript">
<!--
function checkfile(filePath){
	
	if(filePath==""){
		rdShowMessageDialog("上传的文件不能为空！");
		document.all.sure.disabled=true;
		return false;
	}
		document.all.sure.disabled=false;
	}
	
function resetB(){
	document.all.sure.disabled=true;
}

function formSubmit(){

	form.action="http://10.110.0.200:62000/page/batchorder/fileuploadcfm.jsp";
	form.method="post";
	form.submit();
	}
-->
</script>

</HEAD>
<BODY>
	<FORM action="" method="post" name="form" enctype="multipart/form-data">
	    <%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">DSMP批量业务处理文件上传</div>
</div>
		<input type="hidden" name="opCode"  value="9116">		
		<input type="hidden" name="loginNo"  value="<%=workNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">	
			<table cellspacing="0">
			  <tr>
        	<td class=blue>上传文件</td>
        	<td colspan="3">
        		<input size=50 type="file" name="updateFiles" onchange="checkfile(this.value)">
        	</td>
        </tr>
        <tr>
        	<td class=blue>说明</td>
        	<td colspan="3">
        		<div><Font class="orange">
							1.文件命名规范：DSMP_AA_YYYYMMDDXXX.txt，AA-地市代码，YYYYMMDD-年月日，XXX当日流水，从001开始，如果多次开通，序号递增<br/>
							2. 文件格式：一行一条记录{号码;【A：订购|D：取消|S：SP业务退订|Z：全业务退订】;SP企业代码;SP业务代码;操作备注}<br/>
							3.文件大小：小于10M<br/>
							</font>
        		</div>
        	</td>
        </tr>
			</table> 
			<table cellspacing="0">
				<tr id="footer">
					<td colspan="4"> 
						<input class="b_foot" name=sure type=button value=上传 onclick="formSubmit()" disabled>
						<input class="b_foot" name=clear type=reset value=清除 onclick="resetB()">
						<input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()">
					</td>
				</tr>
          </table>
      <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
