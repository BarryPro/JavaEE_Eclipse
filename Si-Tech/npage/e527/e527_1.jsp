<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String[] inParas2 = new String[2];
		String opCode = "e527";
		String opName = "系统充值失败数据查询";
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
 
		String sql_region="select region_code,region_name from sregioncode ";
%>
<wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=sql_region%>"/>
 
</wtc:service>
<wtc:array id="ret_val" scope="end" />
<HTML>
<HEAD>
<script language="JavaScript">
<!--	

function doProcess(packet){
 
}

 

 

function docheck()
{
	
	/*
	if(document.frm.phoneNo.value=="")
    {
	    rdShowMessageDialog("请输入服务号码!");
		document.frm.phoneNo.focus();
		return false;
    }
    if((document.frm.beginYm.value==""&&document.frm.endYm.value!="") ||(document.frm.beginYm.value!=""&&document.frm.endYm.value=="") )
    {
	    rdShowMessageDialog("请输入开始和结束年月!");
		document.frm.beginYm.focus();
		return false;
    }
	var tt = document.all.cityId.options[document.all.cityId.selectedIndex].text;
 
	if(tt.value=="")
    {
	    rdShowMessageDialog("请输入服务号码!");
		document..all.cityId.focus();
		return false;
    }*/
    if(document.frm.phoneNo.value==""&&(document.frm.beginYm.value==""&&document.frm.endYm.value=="") &&document.frm.cityId.options[document.frm.cityId.selectedIndex].value=="0")
	{
		rdShowMessageDialog("手机号码、查询开始、结束年月和地市必选其一!");
		return false;
	}
	else if((document.frm.beginYm.value==""&&document.frm.endYm.value!="")||(document.frm.beginYm.value!=""&&document.frm.endYm.value==""))
	{
		rdShowMessageDialog("查询开始年月和结束年月不可为空!");
		return false;
	}
	else
	{
		//	alert("document.frm.phoneNo.value is "+document.frm.cityId.options[document.frm.cityId.selectedIndex].value); 
		document.frm.action="e527_2.jsp?phoneNo="+document.frm.phoneNo.value+"&beginYm="+document.frm.beginYm.value+"&endYm="+document.frm.endYm.value+"&cityId="+document.frm.cityId.options[document.frm.cityId.selectedIndex].value;
		document.frm.submit();
	}

} 

 

 function doclear() {
 		frm.reset();
 }

 
-->
	   
 </script> 
 
<title>黑龙江BOSS-查询</title>
</head>
<BODY> 
<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">查询条件</div>
		</div>

    <table cellspacing="0">
      <tbody> 
	  <!--可以用tr id作区别
	  <tr class="blue" style="display:none" id="sptime3">
	  -->
   
	   
    </tbody>
  </table>
  
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">手机号码</td>
      <td> 
        <input class="button"type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)">
      </td>
	  </tr>
	  
	  <tr>
	  <td class="blue">地市</td>
      <td> 
        <select name="cityId" style= "width:135px;">
			<option value="0" selected></option>
				<%for(int i=0; i<ret_val.length; i++)
					{%>
						<option value="<%=ret_val[i][0]%>"><%=ret_val[i][1]%></option>
				  <%}%>
		</select>
      </td>

    </tr>
	<tr>
      <td class="blue" colspan=2>开始年月&nbsp;&nbsp;&nbsp;<input type="text" name="beginYm" size="6"  maxlength="6"   > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <font class="blue">终止年月</font>&nbsp;&nbsp;&nbsp;<input type="text" name="endYm" size="6" maxlength="6"   >
      </td>
	</tr>
  </table>
           
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="查询" onclick="docheck()" >
          &nbsp;
          <input type="reset" name="return1" class="b_foot" value="清除"   >
          &nbsp;
         <!--
		  <input type="button" name="reprint"  class="b_foot" value="重打发票" onclick="doreprint()">
		  -->
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
       </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>