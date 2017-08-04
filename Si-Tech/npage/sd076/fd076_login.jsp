<%
  /*
   * 功能: 亲情通（原邦尼老年人服务解决方案）业务
   * 版本: 2.0
   * 日期: 2011/1/5
   * 作者: weigp
   * 版权: si-tech
   * update:
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<head>
<title>亲情通(原邦尼老年人服务解决方案)业务</title>
<%
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  	String phoneNo = (String)request.getParameter("activePhone"); 
	
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
	
	
	$(document).ready(function(){
		//opCode对应展示
		if("<%=opCode%>" == "d076"){
			$("input[@name=opFlag][@value=one]").attr("checked",true);
		}
		if("<%=opCode%>" == "d077"){
			$("input[@name=opFlag][@value=two]").attr("checked",true);
		}
		if("<%=opCode%>" == "d078"){
			$("input[@name=opFlag][@value=three]").attr("checked",true);
			$("#backaccept_id").css("display","block");
		}
		/*
		$("input[@name=opFlag]").click(function(){
			if($(this).val() == "three"){
				$("#backaccept_id").css("display","block");
			}else{
				$("#backaccept_id").css("display","none");
			}
		});
		*/
	});


//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  document.frm.confirm.disabled=true;
  if(!check(frm))
  {
    document.frm.confirm.disabled=false;
	return false;
  }
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	  	$("#opCode").val("d076");
	  	$("#opName").val("亲情通业务申请");
	    frm.action="fd076Main.jsp";
	  }
	  else if(opFlag=="two")
	  {
	  	$("#opCode").val("d077");
	  	$("#opName").val("亲情通业务变更");
	    frm.action="fd076Main.jsp";
	  }
	  else if(opFlag=="three")
	  {
	  	/*if($("#backaccept_id").val() == ""){
	  		rdShowMessageDialog("请输入业务流水！",1)
			return;
	  	}*/
	  	$("#opCode").val("d078");
	  	$("#opName").val("亲情通业务取消");
	    frm.action="fd078Main.jsp";
	  }
	}
  }
  frm.submit();	
  return true;
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
              <TD>
			       <input type="radio" name="opFlag" value="one" checked>申请&nbsp;&nbsp;
				   <input type="radio" name="opFlag" value="two" >变更&nbsp;&nbsp;
				   <input type="radio" name="opFlag" value="three" >取消&nbsp;&nbsp;
	          </TD>
         </TR>
         <tr> 
            <td class="blue"> 
              <div align="left">手机号码</div>
            </td>
            <td> 
            <div align="left"> 
                <input class="InputGrey" readonly  type="text" size="12" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 index="0">
            </td>
        </tr>
       <%-- <tr style="display:none" id="backaccept_id"> 
			<td class="blue">业务流水</td>
			<td colspan="3">
				<input class="button" type="text" name="backaccept">
					<font color="orange">*</font>
			</td>
		</tr>   --%>
         <tr> 
            <td colspan="2" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
      <input type="hidden" name="opCode" id="opCode"/>
      <input type="hidden" name="opName" id="opName"/>
     <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>
