<%
/********************
version v2.0
开发商: si-tech
模块：充值有礼
日期：2008.12.1
作者：leimd
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>

<%@ include file="/npage/include/public_title_name.jsp" %>


<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>充值有礼</title>
<%
        String opCode = (String)request.getParameter("opCode");
        String opName = (String)request.getParameter("opName");
        String ReqPageName = WtcUtil.repNull(request.getParameter("ReqPageName"));
        activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
        //String phone_no = (String)request.getParameter("activePhone");
        System.out.println("##########################s1219Login.jsp->activePhone->"+activePhone);
    %>
<%
  /**
    String workNoFromSession=(String)session.getAttribute("workNo");
		String userPhoneNo=(String)session.getAttribute("userPhoneNo");
		boolean workNoFlag=false;
		if(workNoFromSession.substring(0,1).equals("k"))
	  	workNoFlag=true;

    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String org_Code = baseInfoSession[0][16];
**/
	String[][] temfavStr= (String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    if(WtcUtil.haveStr(favStr,"a272"))
	    pwrf=true;
	/**
  comImpl co=new comImpl();	  
  String sqlAwardType  = "";  
  sqlAwardType  = "select distinct awardtype_code,awardtype_name from sawardtype order by awardtype_code" ;
  System.out.println("sqlAwardType==" + sqlAwardType);
  ArrayList awardTypeArr  = co.spubqry32("2",sqlAwardType );
  String[][] awardTypeStr  = (String[][])awardTypeArr.get(0);
 **/
%>

  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  onload=function()
  {
    <%if (opCode.equals("7163")){%>
        document.frm.flag[1].checked=true;
    <%}%>
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  //controlButt(subButton);//延时控制按钮的可用性
  if(!check(frm)) 
  return false;
  

  if(document.frm.flag[0].checked==true)
  {
  	frm.action="f7162_2.jsp";
	}
	else 
	{
		frm.action="f7162_3.jsp";
	}
  frm.submit();	
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    <div id="title_zi">充值有礼</div>
	</div>
	<table cellspacing="0">
		<tr> 
    	<td nowrap colspan="4" class="blue">
         <input type="radio" name="flag" value="Y" checked >充值有礼	
         <input type="radio" name="flag" value="N">充值有礼冲正	
      </td>
    </tr>
		<tr> 
        <td nowrap class="blue"> 
          手机号码
        </td>
        <td colspan="3"> 
           <input type="text" name="srv_no" id="srv_no" value="<%=activePhone%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  index="0" Class="InputGrey" readOnly>
             <font color="orange">*</font>
        </td>
       
    <tr align="center" > 
    	<td colspan="4">
          	<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
		    <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">         
		  </td>
    </tr>
  </table>
    <%@ include file="/npage/include/footer_simple.jsp" %>
    <%@ include file="../../page/common/pwd_comm.jsp" %>
  </form>
</div>
</body>
</html>
