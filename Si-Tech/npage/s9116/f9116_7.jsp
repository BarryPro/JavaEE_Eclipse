<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
    String opCode = "9117";
    String opName = "DSMP���������ļ���ִ";
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String regionCode=(String)session.getAttribute("regCode");
	String op_name =  "DSMP����ҵ�����ִ�ļ�����";
	
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
		rdShowMessageDialog("�ϴ����ļ�����Ϊ�գ�");
		document.all.sure.disabled=true;
		return false;
	}
		document.all.sure.disabled=false;
	}
	
function resetB(){
}

function formSubmit(){
    if(form.filename.value.trim().length<=0){
        rdShowMessageDialog("�������Ѿ��ϴ����ļ�������DSMP_AA_YYYYMMDDXXX.txt��AA-���д��룬YYYYMMDD-�����գ�XXX������ˮ��");
        return;
    }
	form.action="http://10.110.0.200:62000/page/batchorder/filedownloadcfm.jsp";
	form.method="post";
	form.submit();
	}
-->
</script>

</HEAD>
<BODY>
	<FORM action="" method="post" name="form">
	    	    <%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">DSMP����ҵ�����ִ�ļ�����</div>
</div>
		<input type="hidden" name="opCode"  value="9116">		
		<input type="hidden" name="loginNo"  value="<%=workNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">	
			<table cellspacing="0">
    			  <tr>
            	<td class="blue">���ϴ����ļ���</td>
            	<td colspan="3">
            		<input size=50 type="text" name="filename">
            	</td>
            </tr>
			</table> 
			<table cellspacing="0">
				<tr id="footer">
					<td colspan="4"> 
						<input class="b_foot" name=sure type=button value=���� onclick="formSubmit()">
						<input class="b_foot" name=clear type=reset value=��� onclick="resetB()">
						<input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
					</td>
				</tr>
          </table>
          <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
