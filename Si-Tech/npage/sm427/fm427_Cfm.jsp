<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) -------------------
 
 -------------------------��̨��Ա��--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
	
	

<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String loginAccept    = WtcUtil.repNull(request.getParameter("loginAccept"));                     
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	String op_flag = "";
	
	if("m427".equals(opCode)){
		op_flag = "06";
	}else{
		op_flag = "07";
	}
	
%>

  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="select to_char( sysdate+3 ,'yyyyMMddHH24miss')  as datef72 from dual" />
	</wtc:service>
	<wtc:array id="result_datef72" scope="end" />	
		
<%

String eff_date = "";
if(result_datef72.length>0){
	eff_date = result_datef72[0][0];
}
  String currentDate = "";
	
	//7����׼�����
	String paraAray[] = new String[15];
	
	paraAray[0] = loginAccept;                              /*ҵ����ˮ*/                
	paraAray[1] = "01";                                     /*��������*/                
	paraAray[2] = opCode;                                   /*��������*/                
	paraAray[3] = (String)session.getAttribute("workNo");   /*��������*/                
	paraAray[4] = (String)session.getAttribute("password"); /*��������*/                
	paraAray[5] = phoneNo;                                  /*�ֻ�����*/                
	paraAray[6] = "";                                       /*�ֻ����� */               
	                                                          
	paraAray[7] = "ZY";                            /*ҵ������ ZY */                         
	paraAray[8] = "045112";                            /*��ҵ���� 045112 */                     
	paraAray[9] = "ZY1201";                            /*ҵ����� ZY1201 */                     
	paraAray[10] = op_flag;                            /*�������� 06��ŷ07�˶� */               
	paraAray[11] = currentDate;                            /*��Чʱ�� 14λ */                       
	paraAray[12] = eff_date;                            /*ʧЧʱ�� 20501230000000 */             
	paraAray[13] = currentDate;                            /*����ʱ�� 14λ */                       
	paraAray[14] = "��ע��"+opCode;                            /*������ע*/                
	

	String serverName = "sProWorkFlowCfm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-------------paraAray["+i+"]-------------------->"+paraAray[i]);
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
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j]%>";
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
