<%
    /*************************************
    * ��  ��: Ӧ���ʽ����ϵͳ@ӪҵԱ�Ͻ���¼��(�ύҳ)
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2011-12-9
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	String group_id = (String)session.getAttribute("workGroupId");
	String work_no=(String)session.getAttribute("workNo");
	String org_code=(String)session.getAttribute("orgCode");
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
    System.out.println("------regionCode="+regionCode);
	String paraAray[] = new String[13];
	paraAray[0] = request.getParameter("pay_type"); //��������
	paraAray[1] = request.getParameter("check_no"); //֧Ʊ��
    paraAray[2] = request.getParameter("money_type"); //Ӫҵ������
	paraAray[3] = request.getParameter("pay_money"); //�Ͻ����
	paraAray[4] = "4927";
	paraAray[5] = work_no;
	paraAray[6] = org_code;
	paraAray[7] = group_id;
	paraAray[8] = request.getParameter("bank_cust"); //֧Ʊ��λ
	paraAray[9] = request.getParameter("account_id"); //�ʺ�
	paraAray[10] = request.getParameter("is_user"); //�Ƿ�ͨҵ��
	paraAray[11] = request.getParameter("total_date"); //Ӫҵ���������
	paraAray[12] = request.getParameter("begin_account"); //�������д���
	for (int i =0;i<paraAray.length;i++)
	{
		System.out.println("paraAray[]"+i+"="+paraAray[i]);
	}

%>
    <wtc:service name="s4927Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" 
		retcode="errCode" retmsg="errMsg" outnum="2">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
		<wtc:param value="<%=paraAray[11]%>"/>
		<wtc:param value="<%=paraAray[12]%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
	System.out.println("f4927---errCode="+errCode);
	System.out.println("f4927---errMsg="+errMsg);
	if("000000".equals(errCode))
	{
%>
        <script language="javascript">
           rdShowMessageDialog("�����ɹ���",2);
           window.location.href="f4927.jsp?opCode=4927&opName=ӪҵԱ�Ͻ���";
        </script>
<%
	}else{
%>
        <script language="javascript">
        	rdShowMessageDialog("������룺<%=errMsg%><br>������Ϣ��<%=errCode%>", 0);
            window.location.href = "f4927.jsp?opCode=4927&opName=ӪҵԱ�Ͻ���";
        </script>
<%}%>
