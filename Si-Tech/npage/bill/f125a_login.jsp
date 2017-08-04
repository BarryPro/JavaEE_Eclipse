<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>

<head>
<title>包年续签冲正</title>
<%
	String opCode="125a";
	String opName="包年续签冲正";
    String workNoFromSession=(String)session.getAttribute("workNo");
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;

    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
 
    String[][] temfavStr=(String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    if(WtcUtil.haveStr(favStr,"a272"))
	  pwrf=true;
%>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>
  onload=function()
  {
 	self.status="";
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
  if(check(frm))
  {
    frm.action="f125aMain.jsp";
    frm.submit();	
  }
}
</script>
</head>
<body>
	
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">包年续签冲正</div>
	</div>
  <table cellspacing="0">
    <tr> 
        <td class="blue" width="15%"> 
          服务号码
        </td>
      <td > 
         <input class="InputGrey" value="<%=activePhone%>" type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone"  v_name="服务号码" maxlength="11" index="0">
      </td>
    </tr>
     <tr> 
       <td colspan="2" id="footer"> 
          <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
          <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
		  <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
      </td>
    </tr>
  </table>
 	<%@ include file="/npage/include/footer_simple.jsp" %> 
 	<%@ include file="../../page/common/pwd_comm.jsp" %>
   </form>
</body>
</html>
