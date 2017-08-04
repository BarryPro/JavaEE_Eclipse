   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-13
********************/
%>
              
<%
  String opCode = "1584";
  String opName = "申请延长有效期";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GbK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<HEAD>
<TITLE>黑龙江BOSS-申请延长有效期</TITLE>
</HEAD>
<!----------------------------------页头显示区域----------------------------------------->

<BODY>

<FORM action="" method=post name="form1">
<%@ include file="/npage/include/header.jsp" %>                         

	<div class="title">
		<div id="title_zi">申请延长有效期</div>
	</div>

            <TABLE cellspacing="0">
 
			        <%
						      //out.println("m="+m);   m=0 无密码优惠权限  m!=0 有密码优惠权限
						      int m=0;   
						      boolean pwrf = false;
                  //2011/9/2  diling添加 对密码权限整改 start
                  	String pubOpCode = opCode;
                  %>
                  	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
                  <%
                  	System.out.println("==第二批======f1584_1.jsp==== pwrf = " + pwrf);
                  if(pwrf){
                  		m=1;
                  }else{
                      m=0;
                  }
                  //2011/9/2  diling添加 对密码权限整改 end
			      
			      %>

		      	<% 
		      	if(m == 0){
		      	String ph_no = (String)request.getParameter("ph_no");
		      	%>

		      	<TR>
              <TD class="blue">服务号码</TD>
			        <TD >
			          <input  name="i1" size="20"  maxlength=11  v_must=1 v_type=mobphone v_name=服务号码
			          onkeydown="if(event.keyCode==13 && check(form1))document.all.i2.focus();" value =<%=activePhone!=null?activePhone:ph_no%>  Class="InputGrey" readOnly >
			        </TD>
			        <TD class="blue">密码</TD>
			        <TD>
			          <input  type="password" name="i2" size="20" v_must=0 v_type=int  value=""
			          onkeydown="if(event.keyCode==13) if(check(document.all.form1)) pageSubmit('0');">
			          <input  name=sure22 type=button value="验证" onClick="if(check(document.all.form1)) pwValidate(0)">
			       </TD>
			     <%
		      	}else{
		      		String ph_no = (String)request.getParameter("ph_no");
         	%>
          <TR>
            <TD  class="blue">服务号码</TD>
			      <TD >
			      <input  name="i1" size="20"   maxlength=11 v_must=1 v_type=mobphone v_name=服务号码
			      onkeydown="if(event.keyCode==13) if(check(form1)) pageSubmit('1');"value =<%=activePhone!=null?activePhone:ph_no%>  Class="InputGrey" readOnly >
			      </TD>

			    <%}%>
          </TR>
       </table>

       <table   cellspacing="0" >
       <tbody> 
          <tr > 
			      <td align="center" id="footer">
			        <% if(m==0){%>
			        <input name=sure type="button"  value=确认 onClick="if(check(form1)) pageSubmit('0');" class="b_foot">&nbsp;
			        <%
			         }else{ %>
              <input name=sure type="button"  value=确认 onClick="if(check(form1)) pageSubmit('1');" class="b_foot">&nbsp;
              <%}%>
			        <input name=reset onClick="" type=reset value=清除 class="b_foot">&nbsp;
			        <input name=kkkk onClick="removeCurrentTab()" type="button" value=关闭 class="b_foot">&nbsp;
            </td>
          </tr>
        </tbody> 
        </table>

		<!-------------------------文本隐藏域必须在form1中----------------------------->
<input type="hidden" name="pw_favor" value="0">　<!--密码优惠标志 -->
<input type="hidden" name="pw_flag" value="1" >　<!--密码验证标志 -->
<%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY>
</HTML>

<%/*-----------------------------javascript区-------------------------------------*/%>
<script language="javascript">
/*-----------------------------------load页面时读取----------------------------------*/
document.all.i1.focus();  //页面初始化时将焦点指向服务号码

function pageSubmit(p){
  document.all.pw_favor.value=p; //对密码优惠赋值
  document.all.pw_flag.value=1;  //对是否验证密码赋值
  form1.action="f1584_2.jsp?Send_Op_Code=1584";
  form1.submit();
}

function pwValidate(p){
  document.all.pw_favor.value=p;
  document.all.pw_flag.value=p;
  form1.action="f1584_2.jsp?Send_Op_Code=1584";
  form1.submit();
}

</script>
