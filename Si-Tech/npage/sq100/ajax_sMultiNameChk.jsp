<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) -2017/4/7 ������ 16:05:20------------------
 
3���޸Ŀͻ�����-1100���ͻ����ϱ��-1210��ʵ���Ǽ�-m058��GSM����-1238���������-e972��
У԰ӭ������-m275���������-4977����վ����(b893)�����ſͻ�����(1993)��
��������(i067)��������ͨ����(m349)����λ����ʵ���Ǽ�(m389)�����Ų�Ʒ�û���Ϣ��ȫ(m296)��
���䳬�޿ͻ���������Ϣ��ȫ(m417)��ʵ��ʹ������Ϣ�޸�(m245)���ܣ�
��֤��������ͬʱ����ͻ�������������������ʵ��ʹ����������
������������4���е��κ�һ�������뾭���ṩ������(���۸��2��)����һ֤������
����ʾ����֤���������һ֤��������������롮m366-���֤��ѯ������Ϣ����ѯ��ϸ����
Ҫ��1�����ĸ����ƶ�Ҫ����һ֤��������ʾ��
      2�����������ļ�ʱ����һ֤��������������ƣ����������
      
 -------------------------��̨��Ա��xiahk--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	
	String iIdIccid       = WtcUtil.repNull(request.getParameter("Chk_iIdType"));
	String iIdType        = WtcUtil.repNull(request.getParameter("Chk_iIdIccid"));
	String iCustName      = WtcUtil.repNull(request.getParameter("Chk_iCustName"));			
 
 
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	//7����׼�����
	String paraAray[] = new String[10];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = "";                                  //�û�����
	paraAray[6] = "";                                       //�û�����
	paraAray[7] = iIdIccid;
	paraAray[8] = iIdType;
	paraAray[9] = iCustName;

	String serverName = "sMultiNameChk";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}

	System.out.println("--hejwa--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--hejwa--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
