<%
	/*
	* 吉林BOSS-套餐实现－可选资费变更  2003-10
	* @author  ghostlin
	* @version 1.0
	* @since   JDK 1.4
	* Copyright (c) 2002-2003 si-tech All rights reserved.
  *
  *update:zhanghonga@2008-08-26 页面改造,修改样式
  *
	*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
			String opCode = "1272";
			String opName = "可选资费变更";
			String[][] favInfo = (String[][])session.getAttribute("favInfo");
			String kf_workno = (String)session.getAttribute("workNo");//获得客服工号
			String kf_PhoneNo = (String)session.getAttribute("userPhoneNo");//获得客服手机号码
%>
<HTML>
<HEAD>
<TITLE>可选资费变更</TITLE>
</HEAD>
<body>
<FORM action="" method=post name="form1">
<%@ include file="/npage/include/header.jsp" %>
   <table cellSpacing="0">
     <tr>
			<%//判断客服工号
						String temp_work = "";
						if(!kf_workno.equals(""))
						{
							temp_work = kf_workno;//用于判断是否客服工号
						}
		
					String favorcode = "a272";
					int m =0;
			   for(int p = 0;p< favInfo.length;p++){//优惠代码
						for(int q = 0;q< favInfo[p].length;q++){
							 if(favInfo[p][q].trim().equals(favorcode)){
								   ++m;
							 }
						}
		     }
			%>
			<%if(m == 0 && !temp_work.equals("186100")){//无密码免输权限并不是客服工号%>
	        <td class="blue">服务号码</td>
				  <td>
				  	<input name="i1" size="20" value="<%=activePhone%>" readonly class="InputGrey" maxlength=11 v_must=1 v_type=int v_name=服务号码 onkeydown="if(event.keyCode==13) if(check(form1));">
				  </td>
			<%}else if(m > 0 && !temp_work.equals("186100")){//有密码免输权限并不是客服工号%>
          <td class="blue">服务号码</td>
				  <td>
				  	<input name="i1" size="20" value="<%=activePhone%>" maxlength=11 class="InputGrey" readonly v_must=1 v_type=int v_name=服务号码 onkeydown="if(event.keyCode==13) if(check(form1)) pageSubmit('1');">
				  </td>
			<%}else if(m ==0 && temp_work.equals("186100")){//无密码免输权限并且是客服工号%>
				  <td class="blue">服务号码</td>
				  <td>
				 	  <input name="i1" size="20" value="<%=kf_PhoneNo%>" maxlength=11 v_must=1 v_type=int v_name=服务号码 onkeydown="if(event.keyCode==13) if(check(form1));"  readonly >
				  </td>
			<%}else if(m>0 && temp_work.equals("186100")){//有密码免输权限并且是客服工号%>
	        <td class="blue">服务号码</td>
				  <td>
				  	<input name="i1" size="20" value="<%=kf_PhoneNo%>"maxlength=11 v_must=1 v_type=int v_name=服务号码 onkeydown="if(event.keyCode==13) if(check(form1)) pageSubmit('1');"  readonly >
				  </td>
			<%}%>			  

          </tr>
	   </TABLE>
      
        <table cellSpacing="0">
          <TBODY>
            <TR>
              <TD id="footer">
						  <%if(m==0){%>
						  		<input name=sure class="b_foot" type=button value=确认 onclick="if(check(form1))  pageSubmit('0');" >
						  <%}else{%>
              		<input name=sure class="b_foot" type=button value=确认 onclick="if(check(form1))  pageSubmit('1');" >
              <%}%>
								  <input name=reset class="b_foot" onClick="" type=reset value=清除>
								  <input name=kkkk class="b_foot" onClick="removeCurrentTab()" type=button value=关闭>
              </td>
            </tr>
          </TBODY>
        </TABLE>
        <%@ include file="/npage/include/footer_simple.jsp" %> 
		<input type="hidden" name="pw_favor">
 		 <%--<%@ include file="../../npage/common/pwd_comm.jsp" %>--%>
 </FORM>
 <script language="javascript">

	function pageSubmit(p){
		document.all.pw_favor.value=p;//对密码优惠赋值
		form1.action="f1272_2.jsp";
		form1.submit();
	}
</script>
</BODY>
</HTML>



