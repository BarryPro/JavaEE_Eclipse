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
	String loginAccept = request.getParameter("backaccept");;       //������ˮ
	System.out.println("()()()()()()()()()()()()()()()()"+loginAccept);
	String phoneno = request.getParameter("phoneno");              //Ͷ�ߵ绰����
	String acceptno = request.getParameter("acceptno");            //Ͷ�ߵ�����ˮ
	String FirstClass = request.getParameter("FirstClass");        //�˷�һ��ԭ��
	String SecondClass = request.getParameter("SecondClass");      //�˷Ѷ���ԭ��
	String ThirdClass = request.getParameter("ThirdClass");        //�˷�����ԭ��
	String strBackMoney = request.getParameter("backMoney");       //�˷ѽ��
	String strCompMoney = request.getParameter("compMoney");       //�⳥���
	String op_note = request.getParameter("op_note");              //��ע
	String UnPayKindcode = request.getParameter("UnPayKindcode");  //�˷�����code
	
	String work_no = (String)session.getAttribute("workNo");       
	String loginName = (String)session.getAttribute("workName");   
	String org_code = (String)session.getAttribute("orgCode");	
	String pass = (String)session.getAttribute("password");
	
	System.out.println("inser into \n");
	System.out.println("org_Code============"+org_Code);
	System.out.println("regionCode============"+regionCode);
	System.out.println("op_code============"+op_code);
	System.out.println("loginAccept============"+loginAccept);
	System.out.println("phoneno============"+phoneno);
	System.out.println("acceptno============"+acceptno);
	System.out.println("FirstClass============"+FirstClass);
	System.out.println("SecondClass============"+SecondClass);
	System.out.println("ThirdClass============"+ThirdClass);
	System.out.println("strBackMoney============"+strBackMoney);
	System.out.println("strCompMoney============"+strCompMoney);
	System.out.println("op_note============"+op_note);
	System.out.println("work_no============"+work_no);
	System.out.println("loginName============"+loginName);
	System.out.println("org_code============"+org_code);
	System.out.println("pass============"+pass);

	String paraAray[] = new String[12]; 
	paraAray[0] = loginAccept; 	        //������ˮ
	paraAray[1] = "01";  				//������ʶ
	paraAray[2] = op_code; 			    //��������
	paraAray[3] = work_no;  		    //��������
	paraAray[4] = pass;			    //��������
	paraAray[5] = phoneno;  		    //Ͷ�ߵ绰����
	paraAray[6] = "";			    //��������	
	paraAray[7] = acceptno;             //Ͷ�ߵ�����ˮ
	paraAray[8] = strCompMoney;	        //�⳥��� 
	paraAray[9] = op_note;              //��ע
	paraAray[10] = org_Code;    //��������
	paraAray[11] = UnPayKindcode;        //�˷�����code

%>
<wtc:service name="s4141_2Cfm" routerKey="phone" routerValue="<%=phoneno%>" retcode="s4141_2CfmCode" retmsg="s4141_2CfmMsg" outnum="2" >
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
</wtc:service>
<wtc:array id="s4141_2CfmArr" scope="end"/>
<%
	String retCode= s4141_2CfmCode;
	String retMsg = s4141_2CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
	System.out.println("%%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
    String url = "/npage/contact/upCnttInfo_boss.jsp?opCode="+"4141"+"&retCodeForCntt="+retCode+"&opName="+"Ͷ���˷�"+"&workNo="+work_no+"&loginAccept="+s4141_2CfmArr[0][0]+"&pageActivePhone="+phoneno+"&retMsgForCntt="+retMsg;
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("%%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");

	String errMsg = s4141_2CfmMsg;
	if (s4141_2CfmArr.length > 0 && s4141_2CfmCode.equals("000000"))
	{
	loginAccept = s4141_2CfmArr[0][0]; 
	System.out.println("success");
%>
<script language="JavaScript">
	rdShowMessageDialog("Ͷ���˷ѳ�������ɹ���",2);
	window.location="../s4140/f4141.jsp?opCode=4141&opName=Ͷ���˷�";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("Ͷ���˷ѳ�������ʧ��: <%=retMsg%>",0);
	window.location="f4141.jsp?opCode=4141&opName=Ͷ���˷�";
	</script>
<%}
%>

