<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------duming -------------------
 
 -------------------------��̨��Ա��--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String phone_type     = WtcUtil.repNull(request.getParameter("phone_type"));
	
	String retCode        = "";
	String retMsg         = "";
	
	String regionCode     = (String)session.getAttribute("regCode");
	String serverName = "sm463Cfm";
	
	String workNo = (String)session.getAttribute("workNo");
	System.out.println("--hejwa--------phone_type-------------"+phone_type);
			

if("2".equals(phone_type)){
	//�ȵ���sGetBroadPhone����ת���ֻ�����
%>
			<wtc:service  name="sGetBroadPhone"  routerKey="region" routerValue="<%=regionCode%>"  outnum="2"  retcode="errCodeGetPhone" retmsg="errMsgGetPhone">
          <wtc:param  value="0"/>
          <wtc:param  value="01"/>
          <wtc:param  value=""/>
          <wtc:param  value="<%=workNo%>"/>
          <wtc:param  value=""/>
          <wtc:param  value=""/>
          <wtc:param  value=""/>
          <wtc:param  value="<%=phoneNo%>"/>
      </wtc:service>
      <wtc:array id="sGetBroadPhone_result" scope="end"/>
	
<%

	for(int iii=0;iii<sGetBroadPhone_result.length;iii++){
		for(int jjj=0;jjj<sGetBroadPhone_result[iii].length;jjj++){
			System.out.println("--------hejwa-------------sGetBroadPhone_result["+iii+"]["+jjj+"]=-----------------"+sGetBroadPhone_result[iii][jjj]);
		}
	}
			if("000000".equals(errCodeGetPhone) && sGetBroadPhone_result.length >0){
          phoneNo = sGetBroadPhone_result[0][0];
      }else{
      		retCode = "m463y1";
					retMsg  = "δ��ѯ����������Ӧ���ֻ���";
      }
      
      if("".equals(phoneNo)){
      		retCode = "m463y1";
					retMsg  = "δ��ѯ����������Ӧ���ֻ���";
      }
        	
}
	System.out.println("--hejwa--------phoneNo-------------"+phoneNo);

		System.out.println("--hejwa--------retCode--------------"+retCode);
		System.out.println("--hejwa--------retMsg---------------"+retMsg);
		
if(!"m463y1".equals(retCode)){
	
	//7����׼�����
	String paraAray[] = new String[8];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = phoneNo;                                  //�û�����
	paraAray[6] = "";                                       //�û�����
	paraAray[7] = phoneNo;



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
		System.out.println("--hejwa--------retCode-----serverName=["+serverName+"]---------"+retCode);
		System.out.println("--hejwa--------retMsg------serverName=["+serverName+"]---------"+retMsg);
}
 

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);
