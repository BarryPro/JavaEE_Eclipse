<%
/********************
 * version v2.0
 * ������: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	String op_code = request.getParameter("op_code");              //��������
	String loginAccept = request.getParameter("sysAccept");;       //������ˮ
	System.out.println("()()()()()()()()()()()()()()()()"+loginAccept);
	String phoneno = request.getParameter("phoneno1");              //Ͷ�ߵ绰����
	String acceptno = request.getParameter("acceptno");            //Ͷ�ߵ�����ˮ
	String FirstClass = request.getParameter("FirstClass");        //�˷�һ��ԭ��
	String SecondClass = request.getParameter("SecondClass");      //�˷Ѷ���ԭ��
	String ThirdClass = request.getParameter("ThirdClass");        //�˷�����ԭ��
	String strUnPayLevel = request.getParameter("UnPayLevel");     //�˷�����
	String strSpEnterCode = request.getParameter("spEnterCode");   //sp��ҵ����
	String strSpTranCode = request.getParameter("spTranCode");     //ҵ�����
	String useing_time = request.getParameter("useing_time");      //sp�״�ʹ��ʱ��
	String op_time = request.getParameter("op_time");              //����ʱ��
	String end_time = request.getParameter("end_time");            //����ʱ��
	String strBackMoney = request.getParameter("backMoney");      //�˷ѽ��
	String strCompMoney = request.getParameter("compMoney");       //�⳥���
	String op_note = request.getParameter("op_note");              //��ע
	String strUnPayKind = "1";//request.getParameter("UnPayKind");       //�˷�����
	
	String work_no = (String)session.getAttribute("workNo"); 
	
	//work_no="800195";

	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	//xl add for zhangshuo
	String dj = request.getParameter("dj");       //����
	String sl = request.getParameter("sl");       //����
	
	String paraAray[] = new String[27]; 
	
	System.out.println("inser into \n");
	System.out.println("SSSSSSSSSSSSSSSSSSSSS dj is ========"+dj+" and sl is "+sl);
	System.out.println("regionCode============"+regionCode);
	System.out.println("op_code============"+op_code);
	System.out.println("loginAccept============"+loginAccept);
	System.out.println("phoneno============"+phoneno);
	System.out.println("acceptno============"+acceptno);
	System.out.println("FirstClass============"+FirstClass);
	System.out.println("SecondClass============"+SecondClass);
	System.out.println("ThirdClass============"+ThirdClass);
	System.out.println("strUnPayLevel============"+strUnPayLevel);
	System.out.println("strSpEnterCode============"+strSpEnterCode);
	System.out.println("strSpTranCode============"+strSpTranCode);
	System.out.println("useing_time============"+useing_time);
	System.out.println("op_time============"+op_time);
	System.out.println("end_time============"+end_time);
	System.out.println("strBackMoney============"+strBackMoney);
	System.out.println("strCompMoney============"+strCompMoney);
	System.out.println("op_note============"+op_note);
	System.out.println("work_no============"+work_no);
	System.out.println("loginName============"+loginName);
	System.out.println("org_Code============"+org_Code);
	System.out.println("pass============"+pass);
	System.out.println("strUnPayKind============"+strUnPayKind);
	/*xl add new ���У� �˼����� �Ʒ����� ҵ��ʹ��ʱ�� �˼�ʱ�� */
	String hjlx = "";
	String jflx = "";
	String ywsysj = "";
	String hjsj = "";
	hjlx = request.getParameter("kjlx");
	jflx = request.getParameter("jflx");
	ywsysj = request.getParameter("ywsysj");
	hjsj = request.getParameter("hjsj");
	/*xl add for ivrFlag*/
	String ivrFlag="4";
    //ivrFlag = request.getParameter("ivrflag");
	
	//xl add for gongjian
	String spname = request.getParameter("spname");

	paraAray[0] = loginAccept;  		    //������ˮ
	paraAray[1] = "01";  				//������ʶ
	paraAray[2] = op_code; 	        //��������
	paraAray[3] = work_no; 			    //��������
	paraAray[4] = pass;			    //��������
	paraAray[5] = phoneno; 			    //Ͷ�ߵ绰����
	paraAray[6] = "";			    //��������	
	paraAray[7] = acceptno;             //Ͷ�ߵ�����ˮ
	paraAray[8] = strUnPayLevel;        //�˷����� refund_type
	paraAray[9] = "0";           //�˷�һ��ԭ��code ����or����ҵ���˷� һ��ԭ��=0
	paraAray[10] = "0000";//request.getParameter("UnPayKind");          //����zlc���,����ԭ���Ϊ0000 �˷Ѷ���ԭ��code �ø��ֶ�����������ҵ��=1��������ҵ��=2
	paraAray[11] = request.getParameter("tfyw");           //�˷�����ԭ��code tfyw
	paraAray[12] = strSpEnterCode;      //Sp��ҵ����
	paraAray[13] = strSpTranCode;       //ҵ�����		
	paraAray[14] = strBackMoney;	    //�˷ѽ�� 
	paraAray[15] = strCompMoney;	    //�⳥��� 
	paraAray[16] = op_note;             //��ע
	paraAray[17] = regionCode;  //���д���
	paraAray[18] = org_Code;   //��������
	paraAray[19] = strUnPayKind;      //�˷����� zg67ʱ ������ԭ��һ�� ����ҵ��=1��������ҵ��=2 
	/*new begin*/
	paraAray[20] = hjlx; 
	paraAray[21] = jflx; 
	paraAray[22] = ywsysj; 
	paraAray[23] = hjsj; 
	paraAray[24] =ivrFlag;
	//xl add for ���� ����
	paraAray[25] =dj;
	paraAray[26] =sl;

%>
<wtc:service name="s4141Cfm" routerKey="phone" routerValue="<%=phoneno%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
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
    <wtc:param value="<%=paraAray[19]%>"/>
	<wtc:param value="<%=paraAray[20]%>"/>
	<wtc:param value="<%=paraAray[21]%>"/>
	<wtc:param value="<%=paraAray[22]%>"/>
	<wtc:param value="<%=paraAray[23]%>"/>
	<wtc:param value="<%=paraAray[24]%>"/>
	<wtc:param value="<%=paraAray[25]%>"/>
	<wtc:param value="<%=paraAray[26]%>"/>
	<wtc:param value="<%=spname%>"/>
</wtc:service>
<wtc:array id="s4141CfmArr" scope="end"/>
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
	System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
    String url = "/npage/contact/upCnttInfo_boss.jsp?opCode="+"4141"+"&retCodeForCntt="+retCode+"&opName="+"Ͷ���˷�"+"&workNo="+work_no+"&loginAccept="+s4141CfmArr[0][0]+"&pageActivePhone="+phoneno+"&retMsgForCntt="+retMsg;
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");

	String errMsg = s4141CfmMsg;
	if (s4141CfmArr.length > 0 && s4141CfmCode.equals("000000"))
	{
	loginAccept = s4141CfmArr[0][0]; 
	System.out.println("success");
%>
<script language="JavaScript">
	rdShowMessageDialog("Ͷ���˷�ҵ����ɹ���",2);
	window.location="zg67_1.jsp?opCode=4141&opName=Ͷ���˷�";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("Ͷ���˷�ҵ����ʧ��: <%=retMsg%>",0);
	window.location="zg67_1.jsp?opCode=4141&opName=Ͷ���˷�";
	</script>
<%}
%>

