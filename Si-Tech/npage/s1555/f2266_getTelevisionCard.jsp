<%
    /*************************************
    * ��  ��: �°����Ʒͳһ���� �������ߵ��ӿ�����
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: gaopeng @ 2012-10-22
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode=(String)request.getParameter("opCode");
    String filedLen=(String)request.getParameter("filedLen");
    String opName="���뿨��";
    

%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>���뿨��</title>
        <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
        <script language="javascript">
            function subInfo(submitBtn2)
            {
                /* ��ť�ӳ� */
    			controlButt(submitBtn2);
    			/* �º����� */
    			getAfterPrompt();
                if(!check(frm6842T))
                { 
                    return false;
                }
                var televisionCard=$.trim($("#televisionCard").val());
                
                if(televisionCard.length<<%=filedLen%>){
                    rdShowMessageDialog("����λ������������������");
                    return false;	
                }
                
                  window.returnValue = televisionCard;
                  window.close();
             }
             
             function closeOpenWin(){
                window.returnValue = "";
                window.close();
             }
        </script>
    </head>
    <body>
        <form name="frm6842T" method="post" >
         	<input type="hidden" id="opCode" name="opCode"  value="" />
         	<input type="hidden" id="opName" name="opName"  value="" />
        	<%@ include file="/npage/include/header.jsp" %>
        	<div class="title">
        		<div id="title_zi">���뿨������</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td class="blue">����</td>
                    <td colspan="3">
                        <input type="text" id="televisionCard" name="televisionCard" v_must="1" v_type="0_9" maxlength="<%=filedLen%>" size="<%=filedLen%>" value="" />
                        &nbsp;<font color="orange">(���Ÿ�ʽΪ<%=filedLen%>λ����)</font>
                    </td>
                </tr>			
                <tr>
                    <td colspan="4" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="ȷ��" onClick="subInfo(this)" />   
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="�ر�" onClick="closeOpenWin()" />
                    </td>
                </tr>
            </table>
          <div id="intablediv"></div>
          <%@ include file="/npage/include/footer.jsp" %>
        </form>
    </body>
</html>