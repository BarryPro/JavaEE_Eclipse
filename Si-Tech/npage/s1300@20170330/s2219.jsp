   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-9
********************/
%>
              
<%
  String opCode = "2219";
  String opName = "批量局拆特殊用户延期";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	

<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="com.jspsmart.upload.*"%>

<%
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
  	String orgcode = (String)session.getAttribute("orgCode");
	
	String op_code = "2219"  ;
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	Calendar cal = Calendar.getInstance(Locale.getDefault());
    cal.set(Integer.parseInt(dateStr.substring(0,4)),(Integer.parseInt(dateStr.substring(4,6))-1),Integer.parseInt(dateStr.substring(6,8)));
    String mon = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
%>

<HTML><HEAD><TITLE>黑龙江BOSS-批量局拆特殊用户延期</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
<!--
function form_load()
{
//form.sure.disabled=true;
}
function dosubmit() {
 getAfterPrompt();
 if(form.feefile.value.length<1)
{rdShowMessageDialog("数据文件错误，请重新选择数据文件！",0);
	document.form.feefile.focus();
	return false;
	}
else {
document.form.action="s2219_2.jsp?remark="+document.form.remark.value;
document.form.submit();
document.form.sure.disabled=true;
document.form.reset.disabled=true;
return true;
	}
}

function isKeyNumberdot(ifdot) 
{       
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0)
		if(s_keycode>=48 && s_keycode<=57)
			return true;
		else 
			return false;
    else
    {
		if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
		{
		      return true;
		}
		else if(s_keycode==45)
		{
		    rdShowMessageDialog('不允许输入负值,请重新输入!',0);
		    return false;
		}
		else
			  return false;
    }       
}
//-->
</script>
</HEAD>
<BODY>
<FORM action="s2219_2.jsp" method=post name=form ENCTYPE="multipart/form-data">
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">批量局拆特殊用户延期</div>
	</div>

            <table cellspacing="0">
              <tbody> 
              <tr> 
                <td width="13%" class="blue">操作类型</td>
                <td width="39%">
                  <select name = "SOprType" size = "1" >
                    <option value = "1" selected> 批量局拆特殊用户延期</option>
                  </select>
                </td>
                <td width="13%" class="blue">部门</td>
                <td width="35%"><%=orgcode%></td>
              </tr>
              </tbody> 
            </table>
          <table cellspacing="0">
              <tr> 
                <td width="13%" align="left" class="blue">数据文件</td>
                <td width="87%" colspan="3"> 
                  <input type="file" name="feefile" >
                </td>
              </tr>
            </table>
			<table cellspacing="0">
              <tbody> 
              <tr> 
                <td width=13% class="blue">操作备注</td>
                <td width="87%"> 
                  <input  name=remark size=60 maxlength="60"  Class="InputGrey" readOnly >
                </td>
              </tr>
              <tr> 
                <td colspan="2" class="blue">说明<br>
                  &nbsp;&nbsp;&nbsp;1、数据文件的文件格式为<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;服务号码 空格 延长时间 <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;如 <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13512345679 20051225<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13612345679 20051230<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13712345679 20060125
                </td>
              </tr>
              </tbody> 
            </table>
            <table cellspacing="0">
              <tbody> 
              <tr> 
                <td align=center width="100%" id="footer"> 
                  <input class="b_foot" name=sure type=button value=确认 onClick="dosubmit()" >
                  &nbsp;
                  <input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab">
                  &nbsp; </td>
              </tr>
              </tbody> 
            </table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
