<%
    /*************************************
    * ��  ��: ��ͥ����ƻ����
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2011-12-9
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
    System.out.println("---------�ϲ���opCode="+opCode);
    System.out.println("---------�ϲ���opName="+opName);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title><%=opName%></title>
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
        	 window.onload = function(){
                if(("7123"=="<%=opCode%>")||("7124"=="<%=opCode%>")||("7125"=="<%=opCode%>")||("7126"=="<%=opCode%>")){
                	$("#radiobutton1").attr("checked","checked");
               		$("#radiobutton2").attr("checked","");
               		$("#radiobutton3").attr("checked","");
               	}else if(("7127"=="<%=opCode%>")||("7128"=="<%=opCode%>")|("g581"=="<%=opCode%>")){
               		$("#radiobutton1").attr("checked","");
               		$("#radiobutton2").attr("checked","checked");
               		$("#radiobutton3").attr("checked","");
               	}else if("7129"=="<%=opCode%>"){
               		$("#radiobutton1").attr("checked","");
               		$("#radiobutton2").attr("checked","");
               		$("#radiobutton3").attr("checked","checked");
               	}
        		}
            function doCfm(){
                var radios = document.getElementsByName("radiobutton");
                var radioButtonVal = "";
                var opCode ="<%=opCode%>";
                for(var i=0;i<radios.length;i++){
                    if(radios[i].checked){
                        radioButtonVal = radios[i].value;
                    }
                }
                if(radioButtonVal=="familyServChange"){
    	    		document.all.opCode.value="7123";
                    document.all.opName.value="��ͥ����ƻ�-������ͥ";
                    frm.action="f7123.jsp";
                }else if(radioButtonVal=="PhoneNoOperation"){
                	/*alert("<%=opCode%>"+"<%=opName%>");
			    		    document.all.opCode.value="7127";
			    		    document.all.opName.value="��ͥ����ƻ�-�����������";*/
			    		    document.all.opCode.value="<%=opCode%>";
			    		    document.all.opName.value="<%=opName%>";
	    		    frm.action="f7124.jsp";
                }else if(radioButtonVal=="PayPlanToApply"){
                    document.all.opCode.value="7129";
    	    		document.all.opName.value="��ͥ����ƻ�-���Ѽƻ�����";
    	    		frm.action="f7124.jsp";
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
        		<div id="title_zi">��ѡ���������</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton1"  value="familyServChange" checked="checked" />[7123-7126]��ͥ����ƻ�-��ͥ��ز���&nbsp;
                    </td>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton2"  value="PhoneNoOperation" />[7127-7128-g581]��ͥ����ƻ�-����������롢�����ȡ��&nbsp;
                    </td>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton3"  value="PayPlanToApply" />[7129]��ͥ����ƻ�-���Ѽƻ�����&nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="ȷ��" onClick="doCfm()" />   
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="�ر�" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>