<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *add:liangyl@2016-04-29 页面创建
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    System.out.println("---------合并：opCode="+opCode);
    System.out.println("---------合并：opName="+opName);
    String srv_no=activePhone;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title><%=opName%></title>
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
            function doCfm(){
                var radios = document.getElementsByName("radiobutton");
                var radioButtonVal = "";
                var opCode ="<%=opCode%>";
                for(var i=0;i<radios.length;i++){
                    if(radios[i].checked){
                        radioButtonVal = radios[i].value;
                    }
                }
                if(radioButtonVal=="shenqing"){
   					$("#opCode").val("m373");
   					$("#opName").val("申请休眠期");
                    frm.action="fm373Apply.jsp";
                }else if(radioButtonVal=="quxiao"){
               		$("#opCode").val("m373");
   					$("#opName").val("取消休眠期");
   					frm.action="fm373Cancel.jsp";
                }
                frm.submit();
            }
        </script>
    </head>
    <body>
        <form name="frm" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
         	<input type="hidden" id="crmActiveOpCode" name="crmActiveOpCode"  value="<%=request.getParameter("crmActiveOpCode")%>" />
         	<input type="hidden" id="activePhone" name="activePhone"  value="<%=request.getParameter("activePhone")%>" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">业务类型</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton1"  value="shenqing" checked="checked" />申请休眠期&nbsp;
                    </td>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton2"  value="quxiao" />取消休眠期&nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="确定" onClick="doCfm()" />   
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>