<%
/********************
 * version v2.0
 * ������: si-tech
 * update by wangjya @ 2009-04-16
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	

	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr");

	String themob=request.getParameter("phone_no");
	String theop_code=request.getParameter("opcode");
	//  ��ڲ�����ֵ : 0 ������ˮ 1�ֻ����� 2�������� 3�������� 4�û���ǰ���� 5�û��¸�����  6������ע  7IP��ַ
	String paraAray[] = new String[8];
    paraAray[0] = request.getParameter("login_accept");
    paraAray[1] = themob;
    paraAray[2] = work_no;
    paraAray[3] = theop_code;
    paraAray[4] = request.getParameter("cur_level");
    paraAray[5] = request.getParameter("next_level");
    paraAray[6] = request.getParameter("opNote");
    paraAray[7] = request.getParameter("ip_Addr");
	for (int i=0;i<paraAray.length;i++)
	{
	    System.out.println("paraAray["+i+"]=  "+paraAray[i]);
	}
%>

<wtc:service name="s6909Cfm" routerKey="phone" routerValue="<%=themob%>" retcode="errCode" retmsg="errMsg" outnum="2">
	<wtc:param value="<%=paraAray[0]%>"/> 
	<wtc:param value="<%=paraAray[1]%>"/> 
    <wtc:param value="<%=paraAray[2]%>"/> 
    <wtc:param value="<%=paraAray[3]%>"/>
    <wtc:param value="<%=paraAray[4]%>"/>
    <wtc:param value="<%=paraAray[5]%>"/>
    <wtc:param value="<%=paraAray[6]%>"/>
    <wtc:param value="<%=paraAray[7]%>"/>
</wtc:service>
<wtc:array id="s6909CfmArr" scope="end" />

<%
	System.out.println("in f6909_2.jsp - s6909Cfm :  "+errCode+" : "+errMsg);
    System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+"6909"+"&retCodeForCntt="+errCode+"&opName="+"�Ų��ܼҰ�������"+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+themob+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
%>
    <jsp:include page="<%=url%>" flush="true" />
<%

    System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");
    
	if (errCode.equals("000000"))
	{
	   String chinaFee = "";
%>
    <wtc:service name="sToChinaFee" routerKey="phone" routerValue="<%=themob%>" retcode="sToChinaFeeCode" retmsg="sToChinaFeeMsg" outnum="3">
        <wtc:param value="0"/>
    </wtc:service>
    <wtc:array id="result" scope="end"/>
<%
        if(result.length>0 && sToChinaFeeCode.equals("0")){
            chinaFee = result[0][2];
        }
        System.out.print("chinaFee   ===   "+chinaFee);
%>
<script language="JavaScript">
   rdShowMessageDialog("�ύ�ɹ�",2);
   window.location="f6909_login.jsp?activePhone=<%=themob%>&opCode=6909&opName=�Ų��ܼҰ�������";
 
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("�Ų��ܼҰ�������ʧ��!(<%=errMsg%>",0);
	window.location="f6909_login.jsp?activePhone=<%=themob%>&opCode=6909&opName=�Ų��ܼҰ�������";
</script>
<%}%>
