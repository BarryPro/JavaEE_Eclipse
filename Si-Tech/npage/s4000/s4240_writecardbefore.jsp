<%
/*
* ����: 
* �汾: 1.0
* ����: liangyl 2017/05/03 liangyl ����ȫ��ָ�ʡ�ʿ������������֪ͨ
* ����: liangyl
* ��Ȩ: si-tech
*/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");

	String bipCode       = "BIP2B021";//ҵ�����
	String transCode     = "T2000021";//���״���
	String loginNo 		 = WtcUtil.repStr(request.getParameter("loginNo"),"");/* ��������   */ 
	String orgCode 		 = WtcUtil.repStr(request.getParameter("orgCode"),"");/* ��������   */
	String idValue 		 = WtcUtil.repStr(request.getParameter("idValue"),"");//����
	String seq 	 		 = WtcUtil.repStr(request.getParameter("seq"),"");//������ˮ��,�ɲ���
	String cardSN 	 	 = WtcUtil.repStr(request.getParameter("cardSN"),"");//�տ����к�
	String ICCID 		 = WtcUtil.repStr(request.getParameter("ICCID"),"");//ICCID
	
	String[] names = null;
	String name = WtcUtil.repStr(request.getParameter("name"),"");//��չ������  ����
	if(!"".equals(name)){
		names=name.split(",");
	}
	String[] values =null;	 
	String value = WtcUtil.repStr(request.getParameter("value"),"");//��չ����ֵ  ����
	if(!"".equals(value)){
		values=value.split(",");
	}
	String opNote        = "��ص���д������,"+loginNo+"�������дUSIM��";//��ע
	
	String  inputParsm [] = new String[9];
	inputParsm[0] = bipCode;
	inputParsm[1] = transCode;
	inputParsm[2] = loginNo;
	inputParsm[3] = orgCode;
	inputParsm[4] = idValue;
	inputParsm[5] = seq;
	inputParsm[6] = cardSN;
	inputParsm[7] = ICCID;
	inputParsm[8] = opNote;
	String retCode1="";
	String retMsg1="";
try{
%>
<wtc:service name="sTSNPubSnd" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="18">
	<wtc:param value="<%=inputParsm[0]%>"/>
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>
	<wtc:param value="<%=inputParsm[4]%>"/>
	<wtc:param value="<%=inputParsm[5]%>"/>
	<wtc:param value="<%=inputParsm[6]%>"/>
	<wtc:param value="<%=inputParsm[7]%>"/>
	<wtc:params value="<%=names%>"/>
	<wtc:params value="<%=values%>"/>
	<wtc:param value="<%=inputParsm[8]%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
var resultmsg = new Array();
<%
	retCode1=retCode;
	retMsg1=retMsg;
	if(result.length>0 && "000000".equals(retCode)){
		for(int i=0;i<result.length;i++){
		%>
			resultmsg[<%=i%>]=new Array();
		<%
			for(int j=0;j<result[i].length;j++){
			System.out.println("liangyl---------------------"+result[i][j]);
		%>
		
			resultmsg[<%=i%>][<%=j%>] = "<%=result[i][j]%>";
		<%		
			}	
		}
	}else{
		
	}
}catch(Exception e){
	System.out.println(e);
	System.out.println("cuocuowa111133");
	retCode1= "444444";
	retMsg1= "ϵͳ�쳣";
	System.out.println("retMsg="+retMsg1);
}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode1%>");
response.data.add("retMsg","<%=retMsg1%>");
response.data.add("resultmsg",resultmsg);
core.ajax.receivePacket(response);