<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016/12/8 9:56:34-------------------
 ����imei��ѯmac
 -------------------------��̨��Ա��liyang--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String val_imei       = WtcUtil.repNull(request.getParameter("val_imei"));
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	String sql_str =  "select parm_value as MAC "+
										"  from dbchnterm.rs_term_imeiadd_info "+
										" where parm_name_en = 'MAC_ADDR' "+
										"   and imei_no = :val_imei "; // 

	String sql_param = "val_imei="+val_imei;									
	//7����׼�����
	String paraAray[] = new String[2];
	 
	paraAray[0] = sql_str;                                       // 
	paraAray[1] = sql_param;                                     // 

	String serverName = "TlsPubSelCrm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
			System.out.println("--hejwa--------code-----paraAray=["+i+"]---------"+paraAray[i]);
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
	System.out.println("--hejwa--------code-----serverName=["+serverName+"]---------"+code);
	System.out.println("--hejwa--------msg------serverName=["+serverName+"]---------"+msg);
	
	//ƴװ��������
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
		
		System.out.println("-------hejwa-------------serverResult["+i+"]["+j+"]------------>"+serverResult[i][j]);
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j].trim()%>";
<%		
		}
	}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
