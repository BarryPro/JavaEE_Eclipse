<%
  /*
   * ����: ȫ��ͨ��������1121
   * �汾: 1.0
   * ����: 2008/12/22
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%!
 //splitString()���ڽ�ȡ�ַ�������jdk�ϰ汾û��String.split()����
  public Vector splitString(String sign, String sourceString){
        Vector splitArrays = new Vector();
        int i = 0;
        int j = 0;
        if (sourceString.length()==0) {return splitArrays;}
        while (i <= sourceString.length()) {
               j = sourceString.indexOf(sign, i);
               if (j < 0) {j = sourceString.length();}
               splitArrays.addElement(sourceString.substring(i, j));
               i = j + 1;
        }
        return splitArrays;
  }
%>

<%
	String opCode="1252";
	String opName="��ܰ��ͥȡ��";
	String work_no =(String)session.getAttribute("workNo");    		         //����
	String regionCode = (String)session.getAttribute("regCode");
	String org_code =(String)session.getAttribute("orgCode");				 //�������루�������룩
%>

<%	
	String paraAray[] = new String[11];
	String card_type="",new_rate_code="",phoneNo="",tempStr="";
    Vector vec = new Vector();

	tempStr = request.getParameter("phoneNo");								 //�ֻ�����
	vec = splitString("~",tempStr);
    if(vec.size()==3){
		phoneNo = (String)vec.get(0);
		card_type = (String)vec.get(1);
		new_rate_code = (String)vec.get(2);
	}

    paraAray[0] = card_type ;												//������
	paraAray[1] = request.getParameter("family_code");						//��ͥ����
    paraAray[2] = phoneNo.trim();											//�������
	paraAray[3] = request.getParameter("main_card");						//��������
	paraAray[4] = new_rate_code ;											//�ʷѴ���
	paraAray[5] = work_no;													//����
	paraAray[6] = org_code;													//��������
    paraAray[7] = "1252";													//��������  
	paraAray[8] = request.getParameter("new_rate_code2");					//��һ�������ײ�
 	paraAray[9] = request.getParameter("opNote");							//������ע
	paraAray[10] = request.getParameter("printAccept");						//��ӡ��ˮ
	System.out.println("paraAray[10]paraAray[10]paraAray[10]paraAray[10]="+paraAray[10]);

%>
	<wtc:service name="s1252Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
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
	</wtc:service>
	<wtc:array id="result" scope="end"/>

<%
	String errCode = result[0][0];
	String errMsg = result[0][1];
	System.out.println("errCodeerrCodeerrCodeerrCode="+result[0][1]);
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName
			  +"&workNo="+work_no+"&loginAccept="+paraAray[10]+"&pageActivePhone="+paraAray[3]+"&retMsgForCntt="+retMsg
			  +"&opBeginTime="+opBeginTime; 
	if (errCode.equals("000000")||errCode.equals("0"))
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("��ܰ��ͥȡ���ɹ�!",2);
	location="f1252_login.jsp?activePhone=<%=paraAray[3]%>";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("��ܰ��ͥȡ��ʧ��!<br>errCode:<%=errCode%><br>errMsg:<%=errMsg%>",0);
	history.go(-1);
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true" />