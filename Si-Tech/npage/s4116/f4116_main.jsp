<%
    /*************************************
    * 功  能: 一卡多号绑定合并登陆页面
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
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title><%=opName%></title>
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
        	  window.onload = function(){
                if("4116"=="<%=opCode%>"){
                	$("#radiobutton1").attr("checked","checked");
               		$("#radiobutton2").attr("checked","");
               		$("#radiobutton3").attr("checked","");
               	}else if("4117"=="<%=opCode%>"){
               		$("#radiobutton1").attr("checked","");
               		$("#radiobutton2").attr("checked","checked");
               		$("#radiobutton3").attr("checked","");
               	}else if("4514"=="<%=opCode%>"){
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
                if(radioButtonVal=="4116"){
	    		    document.all.opCode.value="4116";
	    		    document.all.opName.value="一卡多号绑定";
	    		    frm.action="f4116_1.jsp";
                }else if(radioButtonVal=="4117"){
	    		    document.all.opCode.value="4117";
	    		    document.all.opName.value="一卡多号解除绑定";
	    		    frm.action="f4117_1.jsp";
                }else if(radioButtonVal=="4514"){
	    		    document.all.opCode.value="4514";
	    		    document.all.opName.value="一卡多号绑定信息查询";
	    		    frm.action="f4514_1.jsp";
                }
                frm.submit();
            }
        </script>
    </head>
    <body>
        <form name="frm" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">请选择操作类型</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton1"  value="4116" checked="checked" />[4116]一卡多号绑定&nbsp;
                    </td>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton2"  value="4117" />[4117]一卡多号解除绑定&nbsp;
                    </td>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton3"  value="4514" />[4514]一卡多号绑定信息查询&nbsp;
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