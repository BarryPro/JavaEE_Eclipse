<%
    /*************************************
    * ��  ��: ӪҵԱ�Ͻ���¼�롢��ѯ�ϲ���½ҳ��
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
                if("4927"=="<%=opCode%>"){
                	$("#radiobutton1").attr("checked","checked");
               		$("#radiobutton2").attr("checked","");
               	}else if("4928"=="<%=opCode%>"){
               		$("#radiobutton1").attr("checked","");
               		$("#radiobutton2").attr("checked","checked");
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
                if(radioButtonVal=="4927"){
	    		    document.all.opCode.value="4927";
	    		    document.all.opName.value="ӪҵԱ�Ͻ���¼��";
	    		    frm.action="f4927.jsp";
                }else if(radioButtonVal=="4928"){
	    		    document.all.opCode.value="4928";
	    		    document.all.opName.value="ӪҵԱ�Ͻ����ѯ";
	    		    frm.action="f4928.jsp";
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
        		<div id="title_zi">��ѡ���������</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton1"  value="4927" checked="checked" />[4927]ӪҵԱ�Ͻ���¼��&nbsp;
                    </td>
                    <td>
                        <input type="radio" name="radiobutton" id="radiobutton2"  value="4928" />[4928]ӪҵԱ�Ͻ����ѯ&nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="ȷ��" onClick="doCfm()" />   
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="�ر�" onClick="removeCurrentTab();" />
                    </td>
                </tr>
            </table>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>