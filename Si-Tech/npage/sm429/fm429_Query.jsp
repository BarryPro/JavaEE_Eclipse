<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2016/11/17 16:43:25-------------------
 
 -------------------------��̨��Ա��--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String sel_q_accept   = WtcUtil.repNull(request.getParameter("sel_q_accept"));
		                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	String current_time   = new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
	
	//7����׼�����
	String paraAray[] = new String[12];
	
	paraAray[0] = "BIP3A309";                               //ҵ�����	�ַ���	F8	BIP3A309	�̶�Ϊȱʡֵ
	paraAray[1] = "T3000312";                               //���״���	�ַ���	F8	T3000312	�̶�Ϊȱʡֵ
	paraAray[2] = (String)session.getAttribute("workNo");   //��������	�ַ���	F6		                    
	paraAray[3] = (String)session.getAttribute("orgCode");  //���Ź���	�ַ���	F9		ORGCODE             
	paraAray[4] = sel_q_accept;                                       //���𷽵Ĳ�����ˮ��	�ַ���	V32		��Ϊ��    
	paraAray[5] = phoneNo;                                  //�ֻ�����	�ַ���	V32		                    
	paraAray[6] = "451";                                    //ʡ����	�ַ���	F3	451	�̶�Ϊȱʡֵ        
	paraAray[7] = current_time;                             //����ʱ��	�ַ���	F14		YYYYMMDDHH24MISS    
	paraAray[8] = "0";                                       //��������	�ַ���	F9		                    
	paraAray[9] = "";                                       //��������	�ַ�������	V10		                
	paraAray[10] = "";                                      //����ֵ	�ַ�������	V256		                
	paraAray[11] = "��ע��"+phoneNo+"���������ײ�Ԥ�����ѯ"+opCode;                 //������ע	�ַ���	V256		                  
	
	

	String serverName = "sTSNPubSnd";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="24" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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
				System.out.println("--hejwa--------����------serverName=["+serverName+"]--------serverResult["+i+"]["+j+"]------->"+serverResult[i][j]);
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
