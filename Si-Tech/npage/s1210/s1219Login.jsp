<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-08-28 ҳ�����,�޸���ʽ
     *ɾ���˸���������Ȩ��У�������У�鹦��.
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.ErrorMsg" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    request.setCharacterEncoding("GBK");
    HashMap hm = new HashMap();
    hm.put("1", "���û���Ӧ�Ŀͻ��ͻ�ID�����ڣ�");
    hm.put("3", "�û�����������������룡");
    hm.put("4", "�����Ѳ�ȷ���������ܽ����κβ�����");

    hm.put("2", "�û���Ϣ��ȫ����ֹ����������ϵϵͳ����Ա��");
    hm.put("8", "�����ڼ䣬��ֹ�����ҵ��");
    hm.put("10", "�û��ط���Ϣ������!");
    hm.put("11", "�û����ϲ�����->11!");
    hm.put("12", "���÷��񷵻ز���ʧ��->12!");
    hm.put("13", "�õ��������ط�������Ϣ->13!");
    hm.put("14", "�û����ϲ�����->14!");
%>
<html>
<head>
    <title>�ط����</title>
    <%
        String opCode = "1219";
        String opName = "�ط����";
        String ReqPageName = WtcUtil.repNull(request.getParameter("ReqPageName"));
        activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
        System.out.println("##########################s1219Login.jsp->activePhone->"+activePhone);
    %>

    <META content=no-cache http-equiv=Pragma>
    <META content=no-cache http-equiv=Cache-Control>
    <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
    <script language=javascript>
        onload = function()
        {
            self.status = "";

        <%
            if(ReqPageName.equals("s1219Main")){
                String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));
                if(!retMsg.equals("100") && !retMsg.equals("101")){
        %>
            			rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");
        <%
              	}else if(retMsg.equals("100")){
        %>
            		  rdShowMessageDialog('�ʻ�<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>��Ƿ��<%=WtcUtil.repNull(request.getParameter("oweFee"))%>Ԫ�����ܰ���ҵ��');
        <%
                }else if(retMsg.equals("101")){
        %>
            		  rdShowMessageDialog('����<%=WtcUtil.repNull(request.getParameter("errCode"))%>��<%=WtcUtil.repStr(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>');
        <%
                }
        %>
        				parent.removeTab("<%=opCode%>");
        <%      
              } /*else{*/
        %>
	        			/*doCfm(); */
        <%    	
             /*}*/
        %>
        }


        //----------------��֤���ύ����-----------------
        function doCfm()
        {
        		if(document.all.srv_no.value.trim().len()==0){
        			parent.removeTab("<%=opCode%>");
        			return false;
        		}
            frm.action = "s1219Main.jsp";
            frm.submit();
        }
        
        //alert(parent.g_activateTab);
    </script>
</head>
<body>

<form name="frm" method="POST">
    <%@ include file="/npage/include/header.jsp" %>
    <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1219Login">
    <input type="hidden" name="activePhone" value="<%=activePhone%>">
<!--
    <div class="title">
        <div id="title_zi">��ҳ��δ�Զ���ת,���ֶ����"ȷ��"��ť</div>
    </div>  -->

    <table cellspacing="0">
        <tr>
            <td width="16%" class="blue">�������</td>
            <td>
                <input class="InputGrey" value="<%=activePhone%>" name="srv_no" id="srv_no" readonly>
            </td>
        </tr>

        <tr>
            <td id="footer" colspan="2">
                <input class="b_foot" type=button name=qryPage value="ȷ��" onClick="doCfm()" index="2">
                <input class="b_foot" type=button name=qryP value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
            </td>
        </tr>
    </table>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
