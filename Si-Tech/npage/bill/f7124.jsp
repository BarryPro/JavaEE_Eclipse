<%
/********************
 version v2.0
 开发商: si-tech
 模块: 家庭服务计划配置
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
  response.setHeader("Pragma","No-Cache");
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
%>
<head>
<title>家庭服务计划配置</title>
<%

	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String phoneNo = request.getParameter("activePhone");
   	String[][] temfavStr=(String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    if(WtcUtil.haveStr(favStr,"a272"))
	  pwrf=true; 
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  onload=function()
  {
   /************************************************************
  	*如果是7127,7128就是亲情号码申请或者变更,跳转一下页面
  	*7127是家庭服务计划亲情号码申请
  	*7128是家庭服务计划亲情号码变更
  	***********************************************************/
  	if("<%=opCode%>"=="7127"||"<%=opCode%>"=="7128"||"<%=opCode%>"=="g581"){
  		doJump();	
  	}
  	
    document.all.chief_srv_no.focus();
	document.all.opFlag.value= "one";

  }

 function chg_opType(){
	  var frm1=document.frm;
	  document.all.family_id.style.display="";
	  document.all.member_id.style.display="";
	  var radio1 = document.getElementsByName("opFlag");
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
  if(!check(frm)) return false;
  if(!checkElement(frm.cus_pass))	return false;
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	    frm.action="f7124_2.jsp";
	  }else if(opFlag=="two")
	  {
	    frm.action="f7124_3.jsp";
	  }
	}
  }
  frm.submit();
  return true;
}
  function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  } 
  
  
  
  /************************************************************
  	*如果是7127,7128就是亲情号码申请或者变更,跳转一下页面
  	*7127是家庭服务计划亲情号码申请
  	*7128是家庭服务计划亲情号码变更
  	***********************************************************/
  function doJump(){
  	if("<%=opCode%>"=="7127"||"<%=opCode%>"=="7128"||"<%=opCode%>"=="g581"){
  		window.location.href='f7124_3.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
	}else{
		window.location.href='f7124_3.jsp?opCode=7127&opName=家庭服务计划-亲情号码申请';
	}	
  }
</script>
</head>
<body>

<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

      <table cellspacing="0">
	      <TR>
	          <TD class="blue">操作类型</TD>
              <TD colspan="3">
			       <input type="radio" name="opFlag" value="one" checked>付费计划变更&nbsp;&nbsp;
				   <input type="radio" name="opFlag" value="two" onClick="doJump()">亲情号码变更&nbsp;&nbsp;
	          </TD>
         </TR>
         <tr id="family_id">
            <td class="blue">
              <div align="left">家长号码</div>
            </td>
			<td>
                <input type="text"  name="chief_srv_no" id="chief_srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 index="0">
                <font color="orange">*</font>
            </td>
			<td nowrap class="blue">
              <div align="left" >密码</div>
            </td>
            <%-- <%if(pwrf) {%>
              <TD>
			     1<input type="password" class="button" name="cus_pass" size="20" maxlength="8" disabled>
		      </TD>
			 <% } else { %> --%>
				  <td >
					<div align="left">
						  <jsp:include page="/npage/common/pwd_11.jsp">
							  <jsp:param name="width1" value="16%"  />
							  <jsp:param name="width2" value="34%"  />
							  <jsp:param name="pname" value="cus_pass"  />
							  <jsp:param name="pwd" value="12345"  />
						 </jsp:include>
					</div>
				  </td>
			<%--  <%}%>      --%>       
         </tr>
		  <tr id="member_id" style='none'>
            <td class="blue">
              <div align="left">成员号码</div>
            </td>
			<td>
                <input type="text" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16  v_must=1 v_type="mobphone" index="0">
                <font color="orange">*</font>
            </td>
              <td class="blue">
				<div align="left">操作类型</div>
            </td>
			<TD class="blue">
			<SELECT NAME="open_type"  id="open_type" onChange="chg_opType()">
                <option value="0">付费关系建立</option>
				<option value="1">修改底限</option>
				<option value="2">付费关系解除</option>
			</SELECT>
			</TD>
         </tr>
         <tr>
            <td colspan="5" id="footer">
              <div align="center">
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">
              <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
              </div>
           </td>
        </tr>
      </table>
     
   <input type="hidden" name="op_code" value="7124">
   <input type="hidden" name="opCode" value="<%=opCode%>">
   <input type="hidden" name="opName" value="<%=opName%>">
    <%@ include file="/npage/include/footer_simple.jsp" %> 
    <%@ include file="/npage/common/pwd_comm.jsp" %> 
   </form>
</body>
</html>
