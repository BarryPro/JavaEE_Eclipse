<%
    /*************************************
    * 功  能: 页面合成
    * 版  本: version v1.0
    * 开发商: si-tech 
    * 创建者: diling @ 2012-04-28
    **************************************/
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
       
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title><%=opName%></title>
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
        	 window.onload = function(){
        	 			$('#activePhone').val('<%=activePhone%>');
                if("2266"=="<%=opCode%>"){
                	$("#radiobutton1").attr("checked",true);
               		$("#radiobutton2").attr("checked",false);
               	}else if("6842"=="<%=opCode%>"){
               		$("#radiobutton1").attr("checked",false);
               		$("#radiobutton2").attr("checked",true);
               	}
        		}
//ng35 单选框后面文字可点 hejwa 2012-12-11 
$(document).ready(function(){
	$("input[type='radio']:visible").each(function(){
			$(this).attr("style",'cursor:hand');
			var oldtext = $(this).parent().text();
			var oldhtml = $(this).parent().html();
			//alert(oldhtml.indexOf(oldtext));
			oldhtml = oldhtml.substring(0,oldhtml.indexOf(oldtext));
			//alert("oldtext|"+oldtext+"\noldhtml|"+oldhtml);
			var newhtml = oldhtml+"<a style='cursor:hand' onclick='cheThis(this)'>"+oldtext+"</a>";
			//var reg2=new RegExp(oldtext,"gmi");
			//var newhtml = oldhtml.replace(reg2,"<a style='cursor:hand' onclick='cheThis(this)'>"+oldtext+"</a>");
			$(this).parent().html(newhtml);
	});
});
function cheThis(bt){
	$(bt).prev().attr("checked",true);
}       		
            function doCfm(){
                var radios = document.getElementsByName("radiobutton");
                var radioButtonVal = "";
                for(var i=0;i<radios.length;i++){
                    if(radios[i].checked){
                        radioButtonVal = radios[i].value;
                    }
                }
                if(radioButtonVal=="2266"){
                	// 设置opCode和opName 
                	$('#opCode').val('2266');
                	$('#opName').val('促销品统一付奖');
                	frm.action="../s1555/f2266.jsp";    
                }else if(radioButtonVal=="6842"){
                	// 设置opCode和opName    
                	$('#opCode').val('6842');
                	$('#opName').val('新版促销品统一付奖');
	    		    		frm.action="../s6842/f6842.jsp";
                }
                frm.submit();
            }
        </script>
    </head>
    <body>
        <form name="frm" method="post" >
         	<input type="hidden" id="opCode" name="opCodeNew"  value="" />
         	<input type="hidden" id="opName" name="opNameNew"  value="" />
         	<input type="hidden" id="activePhone" name="activePhone"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">请选择操作类型</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td style=""><input type="radio" name="radiobutton" id="radiobutton1"  value="2266" />[2266]促销品统一付奖</td>
                    <td><input type="radio" name="radiobutton" id="radiobutton2"  value="6842" />[6842]新版促销品统一付奖</td>
                </tr>
                <tr>
                    <td colspan="3" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="确定" onClick="doCfm()" />   
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>