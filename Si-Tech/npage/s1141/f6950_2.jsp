<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����ͳһԤ���������6950
   * �汾: 1.0
   * ����: 2009/8/19
   * ����: sunaj
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>

<%	
//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String opCode="6950";
	String opName="����ͳһԤ���������";
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String cust_name = request.getParameter("cust_name"); 
	String sum_money = request.getParameter("sum_money");
	String regionCode = (String)session.getAttribute("regCode");			//����
	String chinaFee = "";													//��д���
	String phoneNo = (String)request.getParameter("phone_no");				//�ֻ�����
	
	String paraAray[] = new String[7];
	paraAray[0] = request.getParameter("login_accept");						//��ˮ
	paraAray[1] = request.getParameter("phone_no");							//�ֻ�����
	paraAray[2] = request.getParameter("opcode");
    paraAray[3] = work_no;
    paraAray[4] = request.getParameter("backaccept");
	paraAray[5] = request.getParameter("opNote");
	paraAray[6] = request.getParameter("preFlag");

%>
	<wtc:service name="s6950Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") )
	{
%>
	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" retcode="sToChinaFeeCode" retmsg="sToChinaFeeMsg" outnum="3">
		<wtc:param value="<%=WtcUtil.formatNumber(sum_money,2)%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
    if(result.length>0 && sToChinaFeeCode.equals("0")){
        chinaFee = result[0][2];
    }
    
	System.out.print(chinaFee);
%>
<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
	System.out.println("url===="+url);
%>
	<jsp:include page="<%=url%>" flush="true" />	
		<script language="JavaScript">
		   rdShowMessageDialog("ȷ�ϳɹ�!",2);
		   var infoStr="";
		   //infoStr+="<%=work_no%>  <%=work_name%>"+"       ����ͳһԤ���������"+"|";//����  
		   //infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   //infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   //infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   //infoStr+='<%=cust_name%>'+"|";
		   //infoStr+=" "+"|";
		   //infoStr+='<%=paraAray[1]%>'+"|";
		   //infoStr+=" "+"|";//Э�����                                                          
		   //infoStr+=" "+"|";
		   //infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
		   //infoStr+="<%=WtcUtil.formatNumber(sum_money,2)%>"+"|";//Сд 
		   //infoStr+="��Ԥ��  <%=sum_money%>Ԫ"+"|";
				
			//infoStr+="<%=work_name%>"+"|";//��Ʊ��
			//infoStr+=" "+"|";//�տ���
			//dirtPate = "/npage/s1141/f6949_login.jsp;
			window.location="f6949_login.jsp?activePhone=<%=phoneNo%>&opCode=6950&opName=����ͳһԤ���������";
		   //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
		</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("����ͳһԤ���������ʧ��!(<%=errMsg%>",0);
	window.location="f6949_login.jsp?activePhone=<%=phoneNo%>&opCode=6950&opName=����ͳһԤ���������";
</script>
<%}%>
