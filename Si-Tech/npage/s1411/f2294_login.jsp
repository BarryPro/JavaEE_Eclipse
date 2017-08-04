   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-24
********************/
%>
              
<%
  String opCode = "2294";
  String opName = "集团客户预存送礼";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 


<%@ page contentType="text/html;charset=GB2312"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>集团客户预存送礼</title>
<%
    String workNoFromSession=(String)session.getAttribute("workNo");
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;

    String work_no = (String)session.getAttribute("workNo");
		String regionCode = (String)session.getAttribute("regCode");
	
	

	
	
	String[][] temfavStr= (String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    if(WtcUtil.haveStr(favStr,"a272"))
	  pwrf=true;
%>
<%
 
  String sql = " select  unique sale_type,sale_type||'-->'||trim(sal_name) from sSaleType ";
  System.out.println("sql====="+sql);
  //ArrayList agentCodeArr = co.spubqry32("2",sql);
  %>
  
		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>  
  
  <%
  String[][] agentCodeStr = result_t1;

/***************需要判断工号是否是集团工号*****************/

 
  String sql1 = " select count(*) from shighlogin where login_no='" +work_no+"' and op_code='2294'";
  System.out.println("sql1====="+sql1);
  //ArrayList agentCodeArr1 = co1.spubqry32("1",sql1);
  %>
  
		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>  
  
  <%
  String[][] agentCodeStr1 = result_t2;
  String dept=agentCodeStr1[0][0];
  System.out.println("dddddddddddddddddddddd"+agentCodeStr1[0][0]);
  if(agentCodeStr1[0][0].equals("0")){
	System.out.println("dddddddddddddddddddddd");
%>

<script language="JavaScript">
<!--
  	rdShowMessageDialog("此工号不允许操作",0);
  	removeCurrentTab();
  	//-->
</script>
<%}%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
 

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
 var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	  	
	    	frm.action="f2294_1.jsp";
	    	document.all.opcode.value="2294";
			document.all.dept.value='<%=dept%>';
	    	
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowMessageDialog("请输入业务流水！",0);
	    	return;
	    }
	   
	    	frm.action="f2295_1.jsp";
	    	document.all.opcode.value="2295";
	    	
	  }
	}
  }
  frm.submit();	
  return true;
}
function opchange(){
	

	 if(document.all.opFlag[0].checked==true) 
	{
	  	
	  	document.all.backaccept_id.style.display = "none";
	  }else {
	  	document.all.backaccept_id.style.display = "";
	  	
	  }

}
</script>
</head>
<body >
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">集团客户预存送礼</div>
	</div>
 <input type="hidden" name="opcode" >
 <input type="hidden" name ="dept" >
 
      <table   cellspacing="0" >
 
	  <TR> 
	          <TD width="16%" class="blue">操作类型</TD>
              <TD width="34%">
		<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >申请&nbsp;&nbsp;
		<input type="radio" name="opFlag" value="two" onclick="opchange()" >冲正
	          </TD>
 
             
         </TR>    
         <tr> 
            <td width="16%" nowrap class="blue"> 
              <div align="left">手机号码</div>
            </td>
            <td nowrap width="34%"> 
            <div align="left"> 
            	<%
            	String ph_no = request.getParameter("ph_no");
            	%>
                <input   type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11" index="0" value =<%=activePhone!=null?activePhone:ph_no%>  Class="InputGrey" readOnly >
                <font class="orange">*</font></div>
            </td>
           
         </tr>
         <TR style="display:none" id="backaccept_id"> 
	          <TD width="16%" class="blue">业务流水</TD>
              <TD width="34%">
			<input  type="text" name="backaccept" v_must=1 >
			<font class="orange">*</font>
	          </TD>
 
 
         <tr > 
            <td colspan="5" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
 
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
   </form>
</body>
</html>