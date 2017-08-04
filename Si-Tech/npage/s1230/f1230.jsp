<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 客户密码重置1231/修改1230
   * 版本: 1.0
   * 日期: 2009/1/14
   * 作者: zhanghonga
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("GBK");
	
	HashMap hm=new HashMap();
	hm.put("1","没有客户ID！");
	hm.put("2","未取到数据！");
	hm.put("3","客户密码错误！");
	hm.put("4","手续费不确定，您不能进行任何操作！");
	hm.put("5","不明错误1！");
	hm.put("6","不明错误2！");  
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>客户密码修改</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<%
	String opCode=request.getParameter("opCode")!=null?request.getParameter("opCode"):"1231";
	String opName=request.getParameter("opName")!=null?request.getParameter("opName"):"客户密码重置"; 
	String activePhone1=(String)request.getParameter("activePhone1")==null?"":(String)request.getParameter("activePhone1");
	
	if(opCode.equals("1231")){
		opName="客户密码重置";
	}else{
		opName="客户密码修改";
	}
	String regionCode=(String)session.getAttribute("regCode"); 
	String inputType="0";
	String changType="0";
	String operationType=request.getParameter("oprationType");
	System.out.println("=================="+request.getParameter("opCode"));
	if (operationType!=null&&operationType.equals("change")){
		changType=request.getParameter("changType");
		if (changType.equals("1")){
			inputType="1";
		}
		else 
		inputType="0";
	}
	
  String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
  if(ReqPageName.equals("main"))
  {
     String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));
 %>
     <script>
	  	rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");
	 </script>
<%
  }

   %>


<script language=javascript>

  onload=function()
  {

  	<%if((request.getParameter("status")==null)&&opCode.equals("1231")){%>
  		document.all.opType[1].checked=true;
    <%}%>

 	self.status="";
 	document.all.qry_cond[0].checked=true;
	document.all.identity.style.display="none";
	document.all.cus_id.focus();
  }

  //-------1--------查询系列函数----------------
  //-------3--------查询系列函数----------------
  function getAllId_No(){
   if((document.all.id_no.value).trim().length<1)
   {
     rdShowMessageDialog("证件号码不能为空！");
 	 return;
   }
   var h=400;
   var w=500;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
   var ret=window.showModalDialog("AllId_No.jsp?id_no="+document.all.id_no.value,"&id_type=" +document.all.id_type.value,"",prop);

   if(typeof(ret)!="undefined")
   {
	 document.all.cus_id.value=ret;
	 document.all.cus_pass.value="";
   }
   else
   {
     rdShowMessageDialog("您必须选择一个客户ID！");
	 document.all.id_no.value="";
     document.all.id_no.focus();
   }
 }

function changeType(ichange)
{	
		if (ichange=='1')
		{
			s3216.action="f1230.jsp?changType=1&oprationType=change";
			s3216.submit();
		}
		else {
			s3216.action="f1230.jsp?changType=0";
			s3216.submit();
		}
}

  function chkId()
  {
    if(document.all.qry_cond[0].checked)
	{
		document.all.identity.style.display="none";
		document.all.cus_id.value="";
 		document.all.cus_id.focus();
	}
	if(document.all.qry_cond[1].checked)
	{
		document.all.identity.style.display="";
 	}
  }

//-------2---------验证及提交函数-----------------
function doCfm()
{
    if(check(s3216))
	{
 	  if(document.all.identity.style.display!="none")
	  {
	    
	    if(document.all.id_type.value=="0")	    
		{
           if(document.all.id_no.value.length==0)
		  {
            rdShowMessageDialog("身份证号码有误！长度不对！");
			document.all.id_no.focus();
			return;
		  }

          if(forIdCard(document.all.id_no)==false)
          {
			document.all.id_no.value="";
			document.all.id_no.focus();
            return;
		  }
	    }
	  }
	  if((document.all.cus_pass.value).trim().length==0){
	  		rdShowMessageDialog("客户密码不能为空！");
		 	document.all.cus_pass.focus();
		 	return false;
	}
      s3216.action="main.jsp";
	  s3216.submit();
	}
}

function clearID()
{
  document.all.id_no.value="";
  document.all.id_no.focus();
}
 
</script>
</head>
<body>

<form name="s3216" method="POST" onKeyUp="chgFocus(s3216)">
  <input type="hidden" name="ReqPageName" id="ReqPageName" value="f1230">
  <input type="hidden" name="opCode" value="<%=opCode%>">
  <input type="hidden" name="status" value="true">
  <input type="hidden" name="opName" value="<%=opName%>">
  <input type="hidden" name="activePhone1" value="<%=activePhone1%>">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue">操作类型</td>
		<td>
			<input type="radio" name="opType" index="0" value="0" <%=changType.equals("0")?"checked":""%> onclick="changeType('0');" >修改密码
			<input type="radio" name="opType" index="1" value="1" <%=changType.equals("1")?"checked":""%> onclick="changeType('1');" >重置密码
		</td>
		<td class="blue">查询条件</td>
		<td>
			<input type="radio" name="qry_cond" id="qry_cond" value="0" onclick="chkId()">
			客户ID
			<input type="radio" name="qry_cond" id="qry_cond" value="1" onclick="chkId()">
			客户证件
		</td>
	</tr>
	<tr id="identity">
		<td class="blue">证件类型</td>
		<td>
			<select name="id_type" id="id_type" onchange="clearID()">
				<wtc:qoption name="sPubSelect" outnum="2">
					<wtc:sql>select id_type,id_name from sIdType order by id_type</wtc:sql>
				</wtc:qoption>
			</select>
		</td>
		<td class="blue">证件号码</td>
		<td>
			<input type="text" size="17" name="id_no" id="id_no">
			<input class="b_text" type="button" name="qryId_No" value="查询" onClick="getAllId_No()">
		</td>
	</tr>
	<tr>
		<td class="blue">客户ID</td>
		<td class=Input>
			<input type="text" size="17" name="cus_id" index="0" id="cus_id" v_minlength=1 v_maxlength=20 v_type=int>
		</td>
		<td class="blue">客户密码</td>
		<td>
			<jsp:include page="/npage/common/pwd_new_custid.jsp">
				<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="cus_pass"  />
				<jsp:param name="pwd" value="12345"  />
			</jsp:include>
			&nbsp;
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name=qryPage value="确认" onClick="doCfm()" index="2" onKeyUp="if(event.keyCode==13){doCfm()}">
			<input class="b_foot" type=button name=back value="清除" onClick="s3216.reset()">
			<input class="b_foot" type=button name=qryPage value="关闭" onClick="removeCurrentTab()">
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
	<%@ include file="/npage/common/pwd_comm.jsp" %>
</form>
</body>
</html>
