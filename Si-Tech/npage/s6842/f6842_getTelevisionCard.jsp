<%
    /*************************************
    * ��  ��: �°����Ʒͳһ���� �������ߵ��ӿ�����
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2011-10-16
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
     String opCode="6842";
    String opName="�������ߵ��ӿ�����";

%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>�������ߵ��ӿ�����</title>
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
                
                if(televisionCard.length<16){
                    rdShowMessageDialog("���ӿ�����λ������������������");
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
        		<div id="title_zi">�������ߵ��ӿ�������</div>
        	</div>
            <table cellspacing="0">
                <tr>
                    <td class="blue">���ߵ��ӿ�����</td>
                    <td colspan="3">
                        <input type="text" id="televisionCard" name="televisionCard" v_must="1" v_type="0_9" maxlength="16" size="16" value="" />
                        &nbsp;<font color="orange">(���Ÿ�ʽΪ16λ����)</font>
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