<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-10
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	String op_code = request.getParameter("op_code");          /*��������*/
	String loginAccept = request.getParameter("sysAccept");;  /*������ˮ*/
	System.out.println("()()()()()()()()()()()()()()()()"+loginAccept);
	String phoneno = request.getParameter("phoneno");
	String strOpType = request.getParameter("op_type");
	String strUnPayLevel = request.getParameter("UnPayLevel");
	String strUnPayFrom = request.getParameter("UnPayFrom");
	String strSpEnterCode = request.getParameter("spEnterCode");
	String strSpTranCode = request.getParameter("spTranCode");
	String strSpTranName = request.getParameter("spTranName");
	String strSpTranType = request.getParameter("spTranType");
	String strSpMark = request.getParameter("sp_mark");
	String strOpMark = request.getParameter("op_mark");
	String strFeeMoney = request.getParameter("feeMoney");//�˷ѽ��
	String strBackMoney = request.getParameter("backMoney");//���ս��
	//String strBackPreMoney = request.getParameter("backPreMoney"); //�˷��ֽ�
	String strBackPreMoney = "0"; //�˷��ֽ�
	String strCompMoney = request.getParameter("compMoney"); //�⳥���
	String strUseingTime = request.getParameter("useing_time"); //ʹ��ʱ��
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	
	String pass = (String)session.getAttribute("password");
	
	String paraAray[] = new String[19]; 
	
	System.out.println("strOpType="+strOpType);
	
	if (strOpType.equals("a")){ 
	  System.out.println("inser into \n");
		paraAray[0] = work_no;  		//��������
		paraAray[1] = pass;  				//��������
		paraAray[2] = loginAccept; 	//��ˮ
		paraAray[3] = op_code; 			//����������
		paraAray[4] = phoneno;			//�û�����
		paraAray[5] = strOpType;		//��������
		paraAray[6] = strUnPayLevel;   //�˷ѱ�ʾ
		paraAray[7] = strUnPayFrom; //�˷�����
		paraAray[8] = strSpEnterCode;  //Sp��ҵ����
		paraAray[9] = strSpTranCode; //ҵ�����
		paraAray[10] = strSpTranName;	//ҵ������
		paraAray[11] = strSpTranType;	//ҵ������
		paraAray[12] = strSpMark;	    //�˷�ԭ������
		paraAray[13] = strOpMark;	    //������ע 
		paraAray[14] = strFeeMoney;	  //�˷ѽ��
		paraAray[15] = strBackMoney;	//���ս�� 
		paraAray[16] = strBackPreMoney;	//�ֽ�Ԥ���� 
		paraAray[17] = strCompMoney;	//�⳥��� 
		paraAray[18] = strUseingTime;	//ʹ��ʱ�� 
	}else{
		System.out.println("delete into \n");
		paraAray[0] = work_no;  		//��������
		paraAray[1] = pass;  				//��������
		paraAray[2] = loginAccept; 	//��ˮ
		paraAray[3] = op_code; 			//����������
		paraAray[4] = phoneno;			//�û�����
		paraAray[5] = strOpType;		//��������
		paraAray[6] = "0";   //�˷ѱ�ʾ
		paraAray[7] = "0"; //�˷�����
		paraAray[8] = strSpEnterCode;  //Sp��ҵ����
		paraAray[9] = strSpTranCode; //ҵ�����
		paraAray[10] = "0";	//ҵ������
		paraAray[11] = "0";	//ҵ������
		paraAray[12] = "0";	    //�˷�ԭ������
		paraAray[13] = "0";	    //������ע
		paraAray[14] = "0";	  //�˷ѽ��
		paraAray[15] = "0";	//���ս�� 
		paraAray[16] = "0";	//�˷ѽ�� 	
		paraAray[17] = "0";	//�⳥��� 	
		paraAray[18] = "0";	//ʹ��ʱ�� 
	}
	

	//String[] ret = impl.callService("s1469Cfm",paraAray,"1","phone",phoneno);
	System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+paraAray[2]);
%>
<wtc:service name="s1469Cfm" routerKey="phone" routerValue="<%=phoneno%>" retcode="s1469CfmCode" retmsg="s1469CfmMsg" outnum="2" >
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
    <wtc:param value="<%=paraAray[13]%>"/>
    <wtc:param value="<%=paraAray[14]%>"/>
    
    <wtc:param value="<%=paraAray[15]%>"/>
    <wtc:param value="<%=paraAray[16]%>"/>
    <wtc:param value="<%=paraAray[17]%>"/>
    <wtc:param value="<%=paraAray[18]%>"/>
</wtc:service>
<wtc:array id="s1469CfmArr" scope="end"/>
<%
	String retCode= s1469CfmCode;
	String retMsg = s1469CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
	//int errCode = impl.getErrCode();
	
	 System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
    String url = "/npage/contact/upCnttInfo_boss.jsp?opCode="+"1469"+"&retCodeForCntt="+retCode+"&opName="+"ȫ��spҵ���˷�"+"&workNo="+work_no+"&loginAccept="+s1469CfmArr[0][0]+"&pageActivePhone="+phoneno+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");

	String errMsg = s1469CfmMsg;
	//String loginAccept = "";
	if (s1469CfmArr.length > 0 && s1469CfmCode.equals("000000"))
	{
	loginAccept = s1469CfmArr[0][0]; 
	System.out.println("success");
%>
<script language="JavaScript">
	rdShowMessageDialog("SPȫ���˷�ҵ����ɹ���",2);
	window.location="../s1300/s1300.jsp?opCode=1300&opName=�ɷ�";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("SPȫ���˷�ҵ��ʧ��: <%=retCode%>",0);
	window.location="s1469.jsp?opCode=1469&opName=ȫ��spҵ���˷�";
	</script>
<%}
%>

