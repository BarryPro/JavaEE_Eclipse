<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
	
<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%
  request.setCharacterEncoding("GBK");
 %>
<html>
<head>
<title>集团客户统一付费赠机营销案</title>
<%
String opCode = "8609";
String opName = "集团客户统一付费赠机营销案";
if(activePhone==null){
	activePhone= request.getParameter("phone_no");
}
    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	  String[][] baseInfoSession = (String[][])arrSession.get(0);

	  String[][] temfavStr=(String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    if(Pub_lxd.haveStr(favStr,"a272"))
	  pwrf=true;
%>
 

  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
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
	    	frm.action="f8609_1.jsp";
	    	document.all.opcode.value="8609";
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	alert("请输入业务流水！");
	    	return;
	    }
	    	frm.action="f8612_1.jsp";
	    	document.all.opcode.value="8612";
	  }
	}
  }
  frm.submit();	
  return true;
}
function opchange(){
	document.all.cus_pass.value="";
	
	 if(document.all.opFlag[0].checked==true) 
	{
	  	document.all.backaccept_id.style.display = "none";
	  	document.all.vUnitContract_id.style.display = "";
	  	document.all.vUnitCotract.value="";
	  }else {
	  	document.all.backaccept_id.style.display = "";
	  	document.all.vUnitContract_id.style.display = "none";
	  	document.all.backaccept.value="";
	  	
	  }

}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>  
	<div class="title">
		<div id="title_zi">集团客户统一付费赠机营销案</div>
	</div>
	<table>                       
 <input type="hidden" name="opcode" >
	  <TR> 
	          <TD class=blue width="16%">操作类型</TD>
              <TD width="34%">
		<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >申请&nbsp;&nbsp;
		<input type="radio" name="opFlag" value="two" onclick="opchange()" >冲正
	          </TD>
	          <TD width="16%">	&nbsp;</TD>
	          <TD width="16%">	&nbsp;</TD>
         </TR>    
         <tr> 
            <td width="16%" nowrap class=blue > 
              <div align="left">手机号码</div>
            </td>
            <td nowrap width="34%"> 
            <div align="left"> 
                <input   readOnly  value ="<%=activePhone%>" class="InputGrey" type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  v_name="服务号码" maxlength="11" index="0">
                <font class="orange">*</font></div>
            </td>
            <td nowrap width="16%" class=blue > 
              <div align="left">用户密码</div>
            </td>
            <%if(pwrf) {%>
              <TD width=34%>
			     <input type="password"  name="cus_pass" size="20" maxlength="8" disabled> 		    
		      </TD>
			 <% } else { %>
				  <td nowrap width="34%"> 
					<div align="left">
						  <jsp:include page="/npage/common/pwd_1.jsp">
							  <jsp:param name="width1" value="16%"  />
							  <jsp:param name="width2" value="34%"  />
							  <jsp:param name="pname" value="cus_pass"  />
							  <jsp:param name="pwd" value="12345"  />
						 </jsp:include>
					</div>
				  </td>
			 <%}%>
         </tr>
         <TR  style="display:''" id="vUnitContract_id"> 
	          <TD width="16%" class=blue >付费帐号</TD>
              <TD width="34%">
			<input  type="text" name="vUnitCotract" id=="vUnitCotract" v_must=1 >
			<font class="orange">*</font>
	          </TD>
	          <TD width="16%"></TD>
		      <TD width="34%">
		      </TD>
         </TR>    
         <TR style="display:none" id="backaccept_id"> 
	          <TD width="16%" class=blue >业务流水</TD>
              <TD width="34%">
			<input  type="text" name="backaccept" v_must=1 >
			<font class="orange">*</font>
	          </TD>
	          <TD width="16%"></TD>
		      <TD width="34%">
		      </TD>
         </TR>    
          
         <tr> 
            <td colspan="5" > 
              <div align="center"> 
              <input  type=button name="confirm" class="b_foot" value="确认" onClick="doCfm(this)" index="2">    
              <input  type=button name=back  class="b_foot" value="清除" onClick="frm.reset()">
		          <input  type=button name=qryP  class="b_foot" value="关闭" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
 <%@ include file="/npage/include/footer.jsp" %>
   </form>
</body>
</html>