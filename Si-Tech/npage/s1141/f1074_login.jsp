<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.04
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>


<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>铁通固话入网IMEI绑定</title>
<%
  		String workNoFromSession=(String)session.getAttribute("workNo");
		String userPhoneNo=(String)session.getAttribute("userPhoneNo");
        String opCode = request.getParameter("opCode");
		String opName = "铁通固话入网IMEI绑定";
  	    String work_no =(String)session.getAttribute("workNo");
        String loginName =(String)session.getAttribute("workName");
        String powerRight =(String)session.getAttribute("powerRight");
        String orgCode =(String)session.getAttribute("orgCode");
        String regionCode = orgCode.substring(0,2);
%>
<script language=javascript>

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
 
 	if(document.frm.srv_no.value.substring(0, 3)!='451' && document.frm.srv_no.value.substring(0, 3)!= '045' && document.frm.srv_no.value.substring(0, 3)!= '046')
	{
		rdShowMessageDialog("只有铁通用户（451、045、046号段）才能办理该业务！");
  		return false;
  	}
 
 
 var radio1 = document.getElementsByName("opFlag");
 var xiaosfs=document.all.banlitype.value
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	  	 if(xiaosfs==0) {
	    	frm.action="f1074_1.jsp";
	    	document.all.opCode.value="1074"; //测试
	    	}else {
	    	frm.action="f1074_3.jsp";
	    	document.all.opCode.value="1074"; //测试
	    	}
	    	
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
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">铁通固话入网IMEI绑定</div>
		</div>
	
      <table cellspacing="0">
		<TR> 
		  <TD width="16%" class="blue">操作类型</TD>
		  <TD width="84%" colspan="3">
			<input type="radio" name="opFlag" value="one"  checked >申请&nbsp;&nbsp;
		  </TD>
		</TR>    
		<tr> 
			<td width="16%" nowrap class="blue"> 
			  <div align="left">手机号码</div>
			</td>
			<td nowrap  width="34%" colspan="3"> 
				<div align="left"> 
					<input   type="text" size="12" name="srv_no" id="srv_no" 
					v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   
					maxlength="11" index="0"  Class="InputGrey" readOnly  value ="<%=activePhone%>">
				</div>
			</td>
		</tr>
			         </TR>    
           	  <TR id="bltys"  > 

	          <TD width="16%" class="blue">销售方式</TD>
              <TD >
							<select id="banlitype" name="banlitype" >
						<option value="0">正常销售</option>
						<option value="1">铁通自采终端</option>
							</select>
	          </TD>

         </TR> 

		 </TR>    
           <td class=Lable  nowrap colspan="4">&nbsp;</td>
         </tr>
         <tr> 
            <td colspan="5" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
    <input type="hidden" name="opCode" value="<%=opCode%>">
	<%@ include file="/npage/include/footer.jsp"%>
   </form>
</body>
</html>
