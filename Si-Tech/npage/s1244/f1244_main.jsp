<%
    /*************************************
    * ��  ��: ��Ʊ������ز����ĺϲ���½ҳ��
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
                if("1244"=="<%=opCode%>"){
                	$("#radiobutton1").attr("checked","checked");
               		$("#radiobutton2").attr("checked","");
               		$("#radiobutton3").attr("checked","");
               		$("#radiobutton4").attr("checked","");
               		$("#radiobutton5").attr("checked","");
               	}else if("1138"=="<%=opCode%>"){
               		$("#radiobutton1").attr("checked","");
               		$("#radiobutton2").attr("checked","checked");
               		$("#radiobutton3").attr("checked","");
               		$("#radiobutton4").attr("checked","");
               		$("#radiobutton5").attr("checked","");
               	}else if("1370"=="<%=opCode%>"){
               		$("#radiobutton1").attr("checked","");
               		$("#radiobutton2").attr("checked","");
               		$("#radiobutton3").attr("checked","checked");
               		$("#radiobutton4").attr("checked","");
               		$("#radiobutton5").attr("checked","");
               	}else if("1781"=="<%=opCode%>"){
               		$("#radiobutton1").attr("checked","");
               		$("#radiobutton2").attr("checked","");
               		$("#radiobutton3").attr("checked","");
               		$("#radiobutton4").attr("checked","checked");
               		$("#radiobutton5").attr("checked","");
               	}else if("1321"=="<%=opCode%>"){
               		$("#radiobutton1").attr("checked","");
               		$("#radiobutton2").attr("checked","");
               		$("#radiobutton3").attr("checked","");
               		$("#radiobutton4").attr("checked","");
               		$("#radiobutton5").attr("checked","checked");
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
                if(radioButtonVal=="1244"){
    	    					document.all.opCode.value="1244";
                    document.all.opName.value="��Ʊ����";
                    frm.action="f1244.jsp";
                }else if(radioButtonVal=="1138"){
				    		    document.all.opCode.value="1138";
				    		    document.all.opName.value="������Ʊ����";
				    		    frm.action="../innet/f1138_1.jsp";
                }else if(radioButtonVal=="1370"){
                    document.all.opCode.value="1370";
			    	    		document.all.opName.value="�����û�����Ʊ";
			    	    		frm.action="../../page/s1300/s1370.jsp";
                }else if(radioButtonVal=="1781"){
                    document.all.opCode.value="1781";
			    	    		document.all.opName.value="�мۿ����۷�Ʊ����";
			    	    		frm.action="../s1300/s1330print.jsp";
                }else if(radioButtonVal=="1321"){
                    document.all.opCode.value="1321";
			    	    		document.all.opName.value="�һ���Ʊ";
			    	    		frm.action="../s1300/s1321_1.jsp";
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
                        <input type="radio" name="radiobutton" id="radiobutton1"  value="1244" checked="checked" />[1244]��Ʊ����&nbsp;
                    </td>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton2"  value="1138" />[1138]������Ʊ����&nbsp;
                    </td>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton3"  value="1370" />[1370]�����û�����Ʊ&nbsp;
                    </td>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton4"  value="1781" />[1781]�мۿ����۷�Ʊ����&nbsp;
                    </td>
                     <td>
                        <input type="radio" name="radiobutton" id="radiobutton5"  value="1321" />[1321]�һ���Ʊ&nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="5" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="ȷ��" onClick="doCfm()" />   
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="�ر�" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>