<%
    /*************************************
    * 功  能: 密码等相关操作合并登陆页面
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-12-9
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
    System.out.println("---------合并：opName="+opName);
    String broadPhone = request.getParameter("broadPhone");
    String oprationType=request.getParameter("oprationType");
    String changType=request.getParameter("changType");
    String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
    String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));
    String status= request.getParameter("status");
       
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title><%=opName%></title>
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
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
        	 window.onload = function(){
                if(("1234"=="<%=opCode%>")||("1235"=="<%=opCode%>")){
                	$("#radiobutton1").attr("checked","checked");
               		$("#radiobutton2").attr("checked","");
               		$("#radiobutton3").attr("checked","");
               	}else if("1230"=="<%=opCode%>"){
               		$("#radiobutton1").attr("checked","");
               		$("#radiobutton2").attr("checked","checked");
               		$("#radiobutton3").attr("checked","");
               	}else if("1236"=="<%=opCode%>"){
               		$("#radiobutton1").attr("checked","");
               		$("#radiobutton2").attr("checked","");
               		$("#radiobutton3").attr("checked","checked");
               	}
        		}
            function doCfm(){
                var radios = document.getElementsByName("radiobutton");
                var radioButtonVal = "";
                for(var i=0;i<radios.length;i++){
                    if(radios[i].checked){
                        radioButtonVal = radios[i].value;
                    }
                }
                if(radioButtonVal=="1234"){
	    		    document.all.opCode.value="1234";
	    		    document.all.opName.value="用户密码修改";
	    		    document.all.broadPhone.value="<%=broadPhone%>";
	    		    document.all.oprationType.value="<%=oprationType%>";
	    		    document.all.changType.value="<%=changType%>";
	    		    document.all.ReqPageName.value="<%=ReqPageName%>";
	    		    document.all.retMsg.value="<%=retMsg%>";
	    		    document.all.activePhone1.value="<%=activePhone%>";
	    		    frm.action="f1234.jsp";
                }else if(radioButtonVal=="1230"){
	    		    document.all.opCode.value="1230";
	    		    document.all.opName.value="客户密码修改";
	    		    document.all.oprationType.value="<%=oprationType%>";
	    		    document.all.changType.value="<%=changType%>";
	    		    document.all.ReqPageName.value="<%=ReqPageName%>";
	    		    document.all.retMsg.value="<%=retMsg%>";
	    		    document.all.status.value="<%=status%>";
	    		    document.all.activePhone1.value="<%=activePhone%>";
	    		    frm.action="../s1230/f1230.jsp";
                }else if(radioButtonVal=="1236"){
	    		    document.all.opCode.value="1236";
	    		    document.all.opName.value="详单密码设置";
	    		    document.all.activePhone1.value="<%=activePhone%>";
	    		    frm.action="../s1236/f1236.jsp";
                }
                frm.submit();
            }
        </script>
    </head>
    <body>
        <form name="frm" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
         	<input type="hidden" id="broadPhone" name="broadPhone"  value="" />
         	<input type="hidden" id="oprationType" name="oprationType"  value="" />
         	<input type="hidden" id="changType" name="changType"  value="" />
         	<input type="hidden" id="ReqPageName" name="ReqPageName"  value="" />
         	<input type="hidden" id="retMsg" name="retMsg"  value="" />
         	<input type="hidden" id="status" name="status"  value="" />
         	<input type="hidden" id="activePhone1" name="activePhone1"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">请选择操作类型</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton2"  value="1230" />[1230]客户密码修改
                    </td>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton1"  value="1234" checked="checked" />[1234-1235]用户密码修改及重置
                    </td>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton3"  value="1236" />[1236]详单密码设置
                    </td>
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