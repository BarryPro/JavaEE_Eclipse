<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.10
 模块：过期卡激活
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=gbk"%>

<%	
	
	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code= (String)session.getAttribute("orgCode");
	String regCode= (String)session.getAttribute("regCode");
	String loginNoPass = (String)session.getAttribute("password");
	
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String passwd = request.getParameter("passwd");
	String cardno = request.getParameter("cardno");  
	String op_code = request.getParameter("op_code");  

	int inputNumber = 1;
	String  outputNumber = "4";
	String  inputParsm [] = new String[inputNumber];	
	inputParsm[0] = cardno;
	
  	//String [] initBack = impl.callService("s3073Init",inputParsm,outputNumber);
%>
	<wtc:service name="s3073Init" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4">			
	<wtc:param value="<%=cardno%>"/>	
	</wtc:service>	
	<wtc:array id="initBack"  scope="end"/>
<%

  	String retCode = retCode1;
	String retMsg = retMsg1;
	
	//String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>"  id="seq"/>
<%
	String loginAccept=seq;
	
	Calendar cal= Calendar.getInstance();
    cal.add(Calendar.DATE,+95);
    Date d= cal.getTime();
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(d);
   
%>
<%
if (!retCode.equals("000000")) {
%><script language="JavaScript">
	rdShowMessageDialog("查询错误！<br>错误代码：'<%=retCode%>'。<br>错误信息：'<%=retMsg%>'。",0);
	history.go(-1);
</script>
<%
	return;
}
	String ctotal = initBack[0][2];	
	String stop_date =initBack[0][3];	
%>
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>过期卡激活充值</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires"> 
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<script language="JavaScript">
<!--
  
  function conf()
  {
     frm.action="s1373_conf.jsp";
     frm.submit();
  }
  
  function isNumberString (InString,RefString)
  {
	if(InString.length==0) return (false);
	for (Count=0; Count < InString.length; Count++)  {
		TempChar= InString.substring (Count, Count+1);
		if (RefString.indexOf (TempChar, 0)==-1)  
		return (false);
	}
	return (true);
  }
  
  function doCommit()
  {
    getAfterPrompt();
    conf();
    
	return true;
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
		    rdShowMessageDialog('不允许输入负值,请重新输入!');
		    return false;
		}
		else
			  return false;
    }       
}
  
//-->
</script>
</head>
<body>
<form name="frm" method="post" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
                <tr> 
                  <td class="blue">过期卡号</td>
                  <td> 
                    <input type="text" name="cardno" readonly maxlength="11" class="InputGrey" value="<%=cardno%>">
                  </td>
                  <td class="blue">面值</td>
                  <td> 
                    <input type="text" class="InputGrey" maxlength="20" readonly name="money" value="<%=ctotal%>" >
                  </td>
                </tr>              
                    
        </table>
       <table cellspacing="0">        
          <tr style="display:none"> 
            <td class="blue">操作备注</td>
            <td colspan="3">
            <input name="t_op_remark" type="text" class="InputGrey" readonly id="t_op_remark" size="60" maxlength="60" value=""> 
            </td>
          </tr>
          <tr> 
            <td colspan="4" id="footer">
            	<div align="center"> 
	            <input name="confirm" type="button" class="b_foot" index="2" value="确认" onClick="doCommit()">
	            <input name="reset" type="reset" class="b_foot" value="清除" >
	            <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
            	</div>
            </td>
          </tr>
		 </table>
 
  <input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
  <input type=hidden name=loginAccept value="<%=loginAccept%>">  
  <input type=hidden name=loginNoPass value="<%=loginNoPass%>">
  <input type="hidden" name="login_no"  value="<%=loginNo%>">
  <input type="hidden" name="ctotal"  value="<%=ctotal%>">
  <input type="hidden" name="org_code"  value="<%=org_code%>">
  <input type="hidden" name="stop_date"  value="<%=stop_date%>">
 <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
