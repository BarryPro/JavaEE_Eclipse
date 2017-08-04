<%
/********************
version v1.0
开发商: si-tech
add by zhangleij
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%@ page import="java.text.*"%>

<%

    String getopCode=request.getParameter("opCode");
    String getopName=request.getParameter("opName");
    System.out.println("-----------getopCode="+getopCode);
    System.out.println("-----------getopName="+getopName);
    String opCode="zgb1";
    String opName="安保部详单查询记录查询";
  	String workNo =  (String)session.getAttribute("workNo");
  	String workname = (String)session.getAttribute("workName");
    String belongName = (String)session.getAttribute("orgCode");
    String regionCode = belongName.substring(0,2);
        
%>
<HEAD>
<TITLE>黑龙江BOSS-安保部详单查询记录查询</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<script language="JavaScript" src="/npage/s1300/common_1300.js"></script>

<script language="JavaScript">

function docheck() {  
  
  if (document.form.begin_ymd.value > document.form.end_ymd.value) {
        rdShowMessageDialog("开始时间年月日不能大于结束时间年月日! ");
      document.form.begin_ymd.value="";
      document.form.end_ymd.value="";
      document.form.begin_ymd.focus();
      return false;
  }

 	form.submit();
        
}

function returnpage(){

window.location = "zgb1_1.jsp";

}
</script>

</HEAD>
<BODY>
    <FORM action="zgb1_2.jsp" method=post name="form">
        <%@ include file="/npage/include/header.jsp"%>
        <div class="title">
            <div id="title_zi">安保部详单查询记录查询</div>
        </div>
        <table cellspacing="0">
            <tr>
                <td class="blue" width="10%" align="right">工号</td>
                <td width="16%"><input type="text" name="login_no" maxlength="6" class="button"></td>
                <td class="blue" width="10%" align="right">开始时间</td>
                <td width="27%"><input type="text" name="begin_ymd" value="" maxlength="8"
                  class="button" onKeyPress="return isKeyNumberdot(0)"><font class="orange"> * 格式20160601</font></td>
                <td class="blue" width="10%" align="right">结束时间</td>
                <td width="27%"><input type="text" name="end_ymd" value="" maxlength="8"
                    class="button" onKeyPress="return isKeyNumberdot(0)"><font class="orange"> * 格式20160601</font></td>
            </tr>
        </table>

        <table width="100%" border=0 align=center cellpadding="4" cellspacing=1>
            <tbody>
                <tr>
                    <td align=center width="100%" id="footer">
                    	<input class="b_foot" name=sure type="button" value="查询" onclick="docheck()"> &nbsp; 
                    	<input class="b_foot" name=reset type=reset value="关闭" onclick="removeCurrentTab()">
                    	<input type="button" name="doreset" class="b_foot" value="重置" onclick="returnpage()">
                    </td>
                </tr>
            </tbody>
        </table>
        <%@ include file="/npage/include/footer_simple.jsp"%>
    </FORM>
</BODY>
</HTML>
