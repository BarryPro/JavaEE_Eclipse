<%
/********************
 * version v2.0
 * ������: si-tech
 * update by wangjya @ 2009-04-14
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
	//  ��ڲ�����ֵ : 1������ˮ 2�ֻ����� 3�������� 4�������� 5�û�����  6������ע  7IP��ַ
	String paraAray[] = new String[10];

//��׼����� hejwa add 2013��12��16��14:13:13
paraAray[0] = "0";                                   //��ˮ
paraAray[1] = "01";                                  //��������
paraAray[2] = request.getParameter("opcode");        //��������
paraAray[3] = work_no;                               //����
paraAray[4] = pass;                                  //��������
paraAray[5] = request.getParameter("phone_no");      //�û�����
paraAray[6] = "";                                    //�û�����
//ԭ���ȥ����׼���ظ��Ĳ���
paraAray[7] = request.getParameter("opNote");
paraAray[8] = request.getParameter("ip_Addr");
paraAray[9] = request.getParameter("favour_type");
	for (int i=0;i<10;i++)
	{
	    System.out.println("hejwa paraAray["+i+"]=  "+paraAray[i]);
	}
%>
<wtc:service name="s6907Cfm" routerKey="phone" routerValue="<%=themob%>" retcode="errCode" retmsg="errMsg" outnum="2">
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
</wtc:service>
<wtc:array id="s6907CfmArr" scope="end" />

<%
	System.out.println("in f6907_2.jsp - s6907Cfm :  "+errCode+" : "+errMsg);
    System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+"6907"+"&retCodeForCntt="+errCode+"&opName="+"�Ų��ܼҰ�������"+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+themob+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
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
   window.location="f6907_login.jsp?activePhone=<%=themob%>&opCode=6907&opName=�Ų��ܼҰ�������";
 
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("�Ų��ܼҰ�������ʧ��!(<%=errMsg%>",0);
	window.location="f6907_login.jsp?activePhone=<%=themob%>&opCode=6907&opName=�Ų��ܼҰ�������";
</script>
<%}%>
