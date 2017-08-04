<%
/********************
 version v2.0
 开发商: si-tech
 模块: 家庭服务计划变更
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<head>
<title>家庭服务计划变更</title>
<%

	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String phoneNo = request.getParameter("activePhone");
	String phoneNo1 = request.getParameter("activePhone");
	String  inputParsm [] = new String[1];    
	//String sqlStr = "select count(*) from dfamilymsg where phone_no='" + phoneNo + "' and family_order='1'";
	String sqlStr = "select count(*) from group_instance_member a,dcustmsg b  where a.serv_id = b.id_no and b.phone_no = '" + phoneNo + "'  and member_role_id = 11009 and add_months(sysdate,1) < exp_date";
	inputParsm[0] = sqlStr;
%>
	<wtc:service name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  outnum="1">
	<wtc:param value="<%=sqlStr%>"/>
	</wtc:service>
	<wtc:array id="result0" scope="end" />
<%
	String higflag="";
	if(result0!=null&&result0.length>0){
		higflag = result0[0][0];
	}
%>			
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  onload=function()
  {
		document.all.parentPhoneNo.focus();
		document.all.opFlag.value= "one";
		document.all.member_id.style.display="none";
		document.all.member_id2.style.display="none";
  }

 function chg_opType(){
	  var frm1=document.frm;
	  if(eval('frm1.openType').value == "0"){
			document.all.family_id.style.display="";
			document.all.member_id.style.display="none";
			document.all.member_id2.style.display="none";
			document.all.parentPhoneNo.focus();
	  }else if(eval('frm1.openType').value == "1"){
			document.all.family_id.style.display="";	
			document.all.member_id.style.display="";	
			document.all.member_id2.style.display="none";					
			document.all.password.style.display="";		  	  
		  document.all.memberPhoneNo.style.display="";
		  document.all.cus_id.style.display ="";		  
		  document.all.srv_no1.style.display="none";
		  document.frm.memberPhoneNo.value="";	  
		  document.frm.srv_no1.value="";
	  }else if(eval('frm1.openType').value == "2"){
	  	if(<%=higflag%> ==0)
	  	{
				document.all.family_id.style.display="none";
				document.all.member_id.style.display="";
				document.all.member_id2.style.display="none";
				document.all.cus_id.style.display ="none";			
				document.all.password.style.display="none";					  		  
				document.all.memberPhoneNo.style.display="none";		  
				document.all.srv_no1.style.display="";
				document.frm.srv_no1.value="<%=phoneNo1%>";
		 }
		 else
		 {
				document.all.family_id.style.display="";
				document.all.member_id.style.display="";
				document.all.member_id2.style.display="none";
				document.all.cus_id.style.display ="none";	
				document.all.password.style.display="none";
				document.all.srv_no1.style.display="none";		  
				document.all.memberPhoneNo.style.display="";
		 }	 	
	  }else if(eval('frm1.openType').value == "3"){
			 document.all.member_id.style.display="none";
			 document.all.member_id2.style.display="none";
			 document.all.family_id.style.display="";
	  }else{
	  	//begin huangrong add 当申请类型选择短信模式成员加入时，页面展示的样式 2011-5-12 
	  	document.all.family_id.style.display="";	
			document.all.member_id.style.display="none";			
			document.all.password.disabled=true;	
			document.all.member_id2.style.display="";
			
		  document.frm.memberPhoneNo.value="";	  
		  document.frm.srv_no1.value="";
		  //begin huangrong add 当申请类型选择短信模式成员加入时，页面展示的样式 2011-5-12 
	  }
  }
  function onClick1(){
  	  document.all.opr_type.style.display="";
  	  document.all.openType.options[0].selected=true;
  	}
  
  function onClick3(){
	  document.all.opr_type.style.display="none";
	  document.all.family_id.style.display="";
	  document.all.member_id.style.display="none";
  }
 function controlButt(subButton){
		subButt2 = subButton;
		subButt2.disabled = true;
		setTimeout("subButt2.disabled = false",3000);
  }
//----------------验证及提交函数-----------------
function doCfm(subButton)
{
	//alert(document.all.parentPhoneNo.value);
  controlButt(subButton);//延时控制按钮的可用性
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
		{
		  var opFlag = radio1[i].value;
		  
		  if(opFlag=="one")
		  {
				if(eval('frm.openType').value == "1")
				{
	  			if(!check(frm)) return false;
	  			if(!forMobil(frm.memberPhoneNo)){
						return false;
					}
			  }else if(document.frm.parentPhoneNo.value==document.frm.memberPhoneNo.value)
			  {
					rdShowMessageDialog("家长号码和成员号码不能相同！");
				}else if((eval('frm.openType').value == "0") || (eval('frm.openType').value == "3"))
		  	{
		  		if(!checkElement(frm.parentPhoneNo))	return false;
		  	}else if(eval('frm.openType').value == "2")
		  	{
		  		if((!checkElement(frm.srv_no1))&&(!checkElement(frm.memberPhoneNo)))	return false;
		  	}else if(eval('frm.openType').value == "4")
				{
					if(document.frm.memberPhoneNo2.value=="")
					{
						rdShowMessageDialog("成员号码不能为空，请输入！",1);
						return false;
					}
					if(isNaN(document.frm.memberPhoneNo2.value))
					{
						rdShowMessageDialog("成员号码必须是数字，请输入！",1);
						return false;
					}	
					if(document.frm.memberPhoneNo2.value.length!=11)
					{
						rdShowMessageDialog("成员号码格式不对，请输入！",1);
						return false;
					}						
					document.frm.memberPhoneNo.value=document.frm.memberPhoneNo2.value;
				}
			  frm.action="f7328_2.jsp";
		  }else if(opFlag=="two")
		  {
		    frm.action="f7328_3.jsp";
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
          	<TD colspan=3>
				    	<input type="radio" name="opFlag" value="one" checked onClick="onClick1()">业务办理&nbsp;&nbsp;
					    <input type="radio" name="opFlag" value="two" onClick="onClick3()">家庭信息查询&nbsp;&nbsp;
            </TD> 
        </TR>
         <tr id="family_id"> 
            <td class="blue" nowrap> 
              <div align="left">家长号码</div>
            </td>
			      <td colspan=3> 
                <input class="InputGrey"  type="text" name="parentPhoneNo" id="parentPhoneNo" v_minlength=1 v_maxlength=16  v_type="string" v_must=1 index="0" value="<%=phoneNo%>" readonly>
            </td>
         </tr>
				 <tr id="member_id" style='none'> 
	          <td class="blue"> 
	            	<div align="left">成员号码</div> 
	          </td>
						<td> 
              	<!--
                <input class="button"  type="text" name="srv_no" id="srv_no" 
                 v_minlength=1 v_maxlength=12 size="11" maxlength=11 
                  v_type="string" v_must=1 index="0" >
                -->
                <jsp:include page="/npage/common/text_1.jsp">
					      <jsp:param name="width1" value=""  />
					      <jsp:param name="width2" value="34%"  />
					      <jsp:param name="pname" value="memberPhoneNo"  />
					      <jsp:param name="btnName" value="输入"  />
				        </jsp:include>
             		<input class="InputGrey"  type="text" name="srv_no1" id="srv_no1" v_minlength=1 v_maxlength=120 size="11" v_type="string" v_must=1 index="0" readOnly>
		        </td>
						<td nowrap class="blue" id="cus_id" style='none'> 
		            <div align="left">密码：</div>
		        </td>
		         
            <TD>
			     			<input type="password" class="button" name="password" size="20" maxlength="8" style='none' > 		    
		        </TD>
		     </tr>
				 <tr id="member_id2" style='none'> 
	          <td class="blue"> 
	            	<div align="left">成员号码</div> 
	          </td>
						<td colspan=3> 
              	<input class="button"  type="text" name="memberPhoneNo2" id="memberPhoneNo2" maxlength=11>
		        </td>
		     </tr>		     
				 <tr id="opr_type"> 
						<td class="blue" > 
								<div align="left">申请类型</div>
			      </td>
						<TD class="blue" colspan=3>
								<SELECT NAME="openType" id="openType" onChange="chg_opType()">
		                <option value="0" selected>新建家庭</option>
		                <option value="1">加入家庭</option>
										<option value="2">退出家庭</option>
										<option value="3">取消家庭</option>
										<option value="4">短信模式成员加入</option>
								</SELECT>
						</TD>
		     </tr>
         <tr> 
            <td colspan="5" id="footer"> 
              <div align="center"> 
	              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
	              <input class="b_foot" type=hidden name=clear value="清除" onClick="frm.reset()">
			     		  <input class="b_foot" type=button name=colse value="关闭" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
     
   <input type="hidden" name="op_code" value="7328">
   <input type="hidden" name="opCode" value="<%=opCode%>">
   <input type="hidden" name="opName" value="<%=opName%>">
     <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>
