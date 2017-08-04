<%
/********************
* 功能: 可选套餐包年 3250
* version v3.0
* 开发商: si-tech
* update by qidp @ 2008-11-25
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  request.setCharacterEncoding("GBK");
%>

<%
    String opCode=(String)request.getParameter("opCode");
    String opName=(String)request.getParameter("opName");
    String[][]  favInfo = (String[][])session.getAttribute("favInfo");
    String userPhone = (String)request.getParameter("activePhone");
%>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD>
<TITLE>可选套餐包年</TITLE>
<script language=javascript>
    onload = function()
    {
        self.status="";
        <%if (opCode.equals("3250")){%>
            document.all.opFlag[0].checked=true;
        <%}else if (opCode.equals("3264")){%>
            document.all.opFlag[1].checked=true;
            document.all.backaccept_id.style.display = "";
        <%}else if (opCode.equals("3275")){%>
            document.all.opFlag[2].checked=true;
        <%}%>
    } 
</script>
</HEAD>
<!----------------------------------页头显示区域----------------------------------------->
<body>
<FORM action="" method=post name="frm">
    <%@ include file="/npage/include/header.jsp" %>
    <div class="title">
       <div id="title_zi">功能选择</div>
    </div>
    <input type="hidden" name="opcode" >

       <TABLE border=0>
			<TR> 
	          <TD class="blue">操作类型</TD>
              <TD class="blue" colspan="3">
				<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >申请
				<input type="radio" name="opFlag" value="two" onclick="opchange()" >冲正
				<input type="radio" name="opFlag" value="three" onclick="opchange()" >取消
	          </TD>
			</TR>    
            <TR>
			
              <TD class="blue">手机号码</TD>
			  <TD class="blue" colspan=3>
			  <input class="button" name="srv_no" size="15" value="<%=userPhone%>" maxlength=11  v_must=1 v_minlength=1 v_maxlength=16 v_type="mobphone" readOnly>
			  </TD>
			  
			<TR style="display:none" id="backaccept_id"> 
				<TD class="blue">业务流水</TD>
				<TD class="blue" colspan="3">
				<input class="button" type="text" name="backaccept" v_must=1 >
				<font class="orange">*</font>
				</TD>
			</TR>    
          <tr>
                <td nowrap colspan="4" id="footer">
                    <div align="center"> 
                    <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
                  	<input class="b_foot" type=button name=back value="清除" onClick="doReset()">
    		      	<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
                </div>
                </td>
            </tr>
        </TABLE>

		<!-------------------------文本隐藏域必须在frm中----------------------------->

		<input type="hidden" name="opcode" >
		<input type="hidden" name="iAddStr" value="">
		<%@ include file="/npage/include/footer_simple.jsp" %>
 	<%@ include file="../../npage/common/pwd_comm.jsp" %>
 </FORM>
</BODY>
</HTML>
<%/*-----------------------------javascript区-------------------------------------*/%>
<script language="javascript">
/*-----------------------------------load页面时读取----------------------------------*/
document.all.srv_no.focus();                      //页面初始化时将焦点指向服务号码


function doReset(){
    location.reload();
    document.all.opFlag[0].checked=true;
}

function opchange(){
	 if(document.all.opFlag[0].checked==true)
	 {
	  	document.all.backaccept_id.style.display = "none";
	 }else if(document.all.opFlag[1].checked==true){
	  	document.all.backaccept_id.style.display = "";
	 }else if(document.all.opFlag[2].checked==true){
	  	document.all.backaccept_id.style.display = "none";
	 }
}
function doCfm(subButton)
{
  var radio1 = document.getElementsByName("opFlag");

  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	    	frm.action="f3250_1.jsp";
	    	document.all.opcode.value="3250";
	  }
	  else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowMessageDialog("请输入业务流水！");
	    	return;
	    }
	    frm.action="f3264_1.jsp";
	    document.all.opcode.value="3264";
	  }
	  else if(opFlag=="three")
	  {
	    	frm.action="f3275_1.jsp";
	    	document.all.opcode.value="3275";
	  }
	}
  }
  frm.submit();	
  return true;
}

</script>
