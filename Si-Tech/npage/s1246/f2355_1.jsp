<%
/********************
 version v2.0
 开发商: si-tech
 模块:强制开关机恢复
 update zhaohaitao at 2009.1.6
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>


<%/*
* 注：变量的命名依据页面文本域的位置的先后顺序，如第一个文本域为i1，以此类推。
		部分变量的命名依据对此变量使用的意义，或用途。
*/%>
<%
	 String opCode = request.getParameter("opCode");
  	 String opName = request.getParameter("opName");
  	 String phoneNo = request.getParameter("activePhone");
%>
<HEAD>
<TITLE>黑龙江BOSS-开关机管理－强制开关机恢复</TITLE>

</HEAD>
<!----------------------------------页头显示区域----------------------------------------->
<body>
<FORM action="" method=post name="form1">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
       <TABLE cellSpacing="0">
        <TR>
          <TD class="blue">服务号码</TD>
		  <TD>
		 	<input class="InputGrey" name="i1" value="<%=phoneNo%>" v_must=1 v_type=mobphone onkeydown="if(event.keyCode==13)if(check(form1))  pageSubmit('1');" readOnly>
		  </TD>
        </TR>
	   </TABLE>
      
        <TABLE cellSpacing="0">
          <TBODY>
            <TR>
              <TD id="footer" align=center>
			  <input class="b_foot" name=sure  type=button value=确认 onclick="if(check(form1))  pageSubmit();" >
			  <input class="b_foot" name=kkkk  onClick="removeCurrentTab()" type=button value=关闭>
              </TD>
            </TR>
          </TBODY>
        </TABLE>
        <input type="hidden" name="opCode" value="<%=opCode%>" >
        <input type="hidden" name="opName" value="<%=opName%>" >
         <%@ include file="/npage/include/footer_simple.jsp" %>   
 </FORM>
</BODY>
</HTML>
<%/*-----------------------------javascript区-------------------------------------*/%>
<script language="javascript">
/*-----------------------------------load页面时读取----------------------------------*/
//document.all.i1.focus();                      //页面初始化时将焦点指向服务号码


function pageSubmit(){
form1.action="f2355_2.jsp";
form1.submit();
}
</script>














