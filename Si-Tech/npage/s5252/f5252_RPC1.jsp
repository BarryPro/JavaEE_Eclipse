 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-04 ҳ�����,�޸���ʽ
	********************/
%>  
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
	//��ȡsession��Ϣ	
	 String regionCode = (String)session.getAttribute("regCode");   

	//������Ϣ���������
	String errCode = "0";
	String errMsg = "";
	String contract_passwd="";
	String pw_flag="1";   //�������
	String n_flag="0";    //δ�ҵ��ʻ�����


	String UserCode = request.getParameter("UserCode");
	String type = request.getParameter("type");
	
	account_pwd  = WtcUtil.repStr(request.getParameter("newPwd")," ");//�ʻ�����
	account_pwd = Encrypt.encrypt(account_pwd);  //�����û�����

	System.out.println("UserCode:"+UserCode);

	//SPubCallSvrImpl impl = new SPubCallSvrImpl();

	//------------------------------------��ѯ�ʻ���Ϣ---------------------------------------
	//ArrayList retList = new ArrayList();
	String sqlStr = "select a.bank_cust,a.contract_passwd from dconmsg a where a.contract_no = '" + UserCode + "' and a.account_type = 'a'";

	retList = impl.sPubSelect("2",sqlStr,"region",regionCode);
	%>
	
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
	
	<%
		
		errCode = retCode1; //�������
		System.out.println("errCode:"+errCode);
		errMsg = retMsg1; //������Ϣ
		System.out.println("errMsg:"+errMsg);
	
	String[][] retListString = null;
%>
	var bank_cust="";
<%

	if(errCode.equals("000000")){		
		//retListString = (String[][])retList.get(0);
		retListString=result1;			
	 	if(retListString!=null&&retListString.length!=0){
	    	  n_flag="0";        //�ҵ��ʻ�
		  contract_passwd=(String)retListString[0][1];
		  System.out.println("contract_passwd:"+contract_passwd);
		  System.out.println("account_pwd:"+account_pwd);
	
%>
    bank_cust = '<%=retListString[0][0]%>';
<%
    if(0==Encrypt.checkpwd2(contract_passwd,account_pwd)){
      pw_flag="1";     //�������
    }
    else{
  	  pw_flag="0";     //������ȷ
    }
  }
  else{
  	  n_flag="1";      //δ�ҵ��ʻ�
  }
}

	//ArrayList retList2 = new ArrayList();
	String sqlStr2 = "select count(*) from dagtbasemsg where contract_no='" + UserCode + "'";
	//retList2 = impl.sPubSelect("1",sqlStr2,"region",regionCode);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=sqlStr2%></wtc:sql>
		</wtc:pubselect>
<wtc:array id="result2" scope="end" />
<%
		
		errCode = retCode2; //�������
		System.out.println("errCode1:"+errCode);
		errMsg = retMsg2; //������Ϣ
		System.out.println("errMsg1:"+errMsg);
	
	
	String[][] retListString2 = null;
%>
	var phone_num="";

<%
if(errCode.equals("000000")){
	//retListString2 = (String[][])retList2.get(0);
	retListString2=result2;
	if(retListString!=null){
	for(int i = 0;i < retListString2.length;i++){
%>

		phone_num = '<%=retListString2[0][0]%>';

<%
	}
}
}
%>

var response = new AJAXPacket();
response.data.add("bank_cust",bank_cust);
response.data.add("type","<%=type%>");
response.data.add("phone_num",phone_num);
response.data.add("pw_flag","<%=pw_flag%>");
response.data.add("n_flag","<%=n_flag%>");
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
core.ajax.receivePacket(response);