<%
    /*************************************
    * 功  能: 租机相关业务合并登陆页面
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
        	 window.onload = function(){
                if("1222"=="<%=opCode%>"){
                	$("#radiobutton1").attr("checked","checked");
               		$("#radiobutton2").attr("checked","");
               		$("#radiobutton3").attr("checked","");
               		$("#radiobutton4").attr("checked","");
               	}else if("1223"=="<%=opCode%>"){
               		$("#radiobutton1").attr("checked","");
               		$("#radiobutton2").attr("checked","checked");
               		$("#radiobutton3").attr("checked","");
               		$("#radiobutton4").attr("checked","");
               	}else if("1225"=="<%=opCode%>"){
               		$("#radiobutton1").attr("checked","");
               		$("#radiobutton2").attr("checked","");
               		$("#radiobutton3").attr("checked","checked");
               		$("#radiobutton4").attr("checked","");
               	}else if("1226"=="<%=opCode%>"){
               		$("#radiobutton1").attr("checked","");
               		$("#radiobutton2").attr("checked","");
               		$("#radiobutton3").attr("checked","");
               		$("#radiobutton4").attr("checked","checked");
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
                if(radioButtonVal=="1222"){
	    		    document.all.opCode.value="1222";
	    		    document.all.opName.value="异制租机申请";
	    		    document.all.activePhone1.value="<%=activePhone%>";
	    		    frm.action="f1222.jsp";
                }else if(radioButtonVal=="1223"){
	    		    document.all.opCode.value="1223";
	    		    document.all.opName.value="异制租机续租";
	    		    document.all.activePhone1.value="<%=activePhone%>";
	    		    frm.action="../s1223/f1223.jsp";
                }else if(radioButtonVal=="1225"){
	    		    document.all.opCode.value="1225";
	    		    document.all.opName.value="异制租机退租";
	    		    document.all.activePhone1.value="<%=activePhone%>";
	    		    frm.action="../s1225/f1225.jsp";
                }else if(radioButtonVal=="1226"){
	    		    document.all.opCode.value="1226";
	    		    document.all.opName.value="租机查询";
	    		    document.all.activePhone1.value="<%=activePhone%>";
	    		    frm.action="../s1226/f1223.jsp";
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
                        <input type="radio" name="radiobutton" id="radiobutton1"  value="1222" checked="checked" />[1222]异制租机申请&nbsp;
                    </td>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton2"  value="1223" />[1223]异制租机续租&nbsp;
                    </td>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton3"  value="1225" />[1225]异制租机退租&nbsp;
                    </td>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton4"  value="1226" />[1226]租机查询&nbsp;
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