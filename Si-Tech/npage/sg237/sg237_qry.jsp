<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%
	/*------�鿴�ֻ��û��Ƿ���ʵ�����û�*/
	String workNo = (String)session.getAttribute("workNo");
	String regionCode= (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");
	String opCode = request.getParameter("opCode");
	String smzflag ="";

	String phoneNo = request.getParameter("phoneNo");
	String s_flag="";
	String s_datesource = "";
	String s_message_flag = "";
	String s_op_flag="";
	String s_login_no="";
	String s_op_time="";
	String s_note="";

	String[] inParamS = new String[2];
	inParamS[0] = "select a.datesource,a.OPR_CODE,a.MESSAGE_FLAG,a.LOGIN_NO,a.REASON_NOTE,a.OP_TIME "
								+" from "
								+" (select DECODE(datesource,'01','ȫ�����ƽ̨','02','ʡ�ڼ��','03','�ٱ�����','04','�û�Ͷ��') datesource, DECODE(OPR_CODE,'01','�ѼӺ�','02','�ѽ��','03','�ѼӺ�','04','�ѽ��','05','�ѼӺ�','06','�ѽ��') OPR_CODE,DECODE(MESSAGE_FLAG,'01','��������','02','ɧ�ŵ绰','03','��������') MESSAGE_FLAG, LOGIN_NO,REASON_NOTE, to_char(OP_TIME,'yyyymmdd hh24:mi:ss') OP_TIME "
								+" from WINFORMATIONSAFEMSG "
								+" where PHONE_NO =:phone_no "
								+" order by OP_TIME desc "
								+" ) a "
								+" WHERE ROWNUM = 1  ";
	inParamS[1] = "phone_no=" + phoneNo;
	
	System.out.println(" inParamS[0]  = "+inParamS[0]);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeS" retmsg="retMsgS" outnum="6">
		<wtc:param value="<%=inParamS[0]%>"/>
		<wtc:param value="<%=inParamS[1]%>"/>
	</wtc:service>
	<wtc:array id="resultS"  scope="end"/>
<%
	if("000000".equals(retCodeS)){
		if(resultS.length==0){
			s_flag="1";
		}else{
			s_flag="0";
			s_datesource = resultS[0][0]; //������Դ
			s_op_flag=resultS[0][1]; //������״̬
			s_message_flag=resultS[0][2]; //������Ϣ����
			s_login_no=resultS[0][3]; //�������Ĳ�������
			s_note=resultS[0][4]; //�������Ĳ�����ע
			s_op_time=resultS[0][5]; //����ʱ��
		}
	}
%>
var response = new AJAXPacket();
response.data.add("s_flag","<%=s_flag%>");
response.data.add("s_datesource","<%=s_datesource%>");
response.data.add("s_op_flag","<%=s_op_flag%>");
response.data.add("s_message_flag","<%=s_message_flag%>");
response.data.add("s_login_no","<%=s_login_no%>");
response.data.add("s_note","<%=s_note%>"); 
response.data.add("s_op_time","<%=s_op_time%>"); 
core.ajax .receivePacket(response);


 
 
