<%
/********************
* ����: ���ʷѳ��� 127b
* version v3.0
* ������: si-tech
* update by qidp @ 2008-12-01
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode = "127b";
    String opName = "���ʷѳ���";
/*
 * ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
 *		���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
 */
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>���ʷѳ���</TITLE>
</HEAD>
<!----------------------------------ҳͷ��ʾ����----------------------------------------->
<body>
<FORM action="" method=post name="form1">
<%
    //�ڴ˴���ȡsession��Ϣ
    
    String[][] favInfo = (String[][])session.getAttribute("favInfo");//��ȡ�Ż��ʷѴ���
    
    /*******************************����ȫ�ֱ���*******************************/
    String hdword_no = (String)session.getAttribute("workNo");//����
    String hdpowerright = (String)session.getAttribute("powerRight");//��ɫȨ��
    
    
    /**************************************************************************/
%>
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
   <div id="title_zi">�û���¼</div>
</div>
    <TABLE border=0>
        <TR>
            
            <TD class="blue" width="15%">�������</TD>
            <TD>
                <input name="i1" size="20" value="<%=activePhone%>" maxlength=11  v_must=1 v_minlength=1 v_maxlength=16 v_type="mobphone" class="InputGrey" readOnly>
            </TD>
        
        </TR>
        
        
        <tr>
            <td nowrap colspan="4" id="footer">
                <div align="center"> 
                
                    <input class="b_foot" name=sure  type=button value=ȷ�� onclick="if(check(form1))  pageSubmit();" >
                    <input class="b_foot" name=kkkk  onClick="removeCurrentTab()" type=button value=�ر�>
                </div>
            </td>
        </tr>
        
    </TABLE>

<!-------------------------�ı������������form1��----------------------------->
<input type="hidden" name="pw_favor">
<input type="hidden" name="iOpCode" value="127b">
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="iAddStr" value=""> 
<%@ include file="/npage/include/footer_simple.jsp" %>
<%@ include file="../../npage/common/pwd_comm.jsp" %>
</FORM>
</BODY>
</HTML>
<%/*-----------------------------javascript��-------------------------------------*/%>
<script language="javascript">
/*-----------------------------------loadҳ��ʱ��ȡ----------------------------------*/

function pageSubmit(){

form1.action="f127a_2.jsp";
form1.submit();
}
</script>
