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
	String opTypeCode     = WtcUtil.repNull(request.getParameter("opTypeCode"));
	String prodId         = WtcUtil.repNull(request.getParameter("prodId"));
		
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	String current_time   = new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
	
	//7����׼�����
	String paraAray[] = new String[15];
	
	paraAray[0] = "BIP3A305";                               //1	ҵ�����	�ַ���	F8	BIP3A305	�̶�Ϊȱʡֵ
	paraAray[1] = "T3000308";                               //2	���״���	�ַ���	F8	T3000308	�̶�Ϊȱʡֵ
	paraAray[2] = (String)session.getAttribute("workNo");   //3	��������	�ַ���	F6		                    
	paraAray[3] = (String)session.getAttribute("orgCode");  //4	���Ź���	�ַ���	F9		ORGCODE             
	paraAray[4] = "";                                       //5	���𷽵Ĳ�����ˮ��	�ַ���	V32		��Ϊ��    
	paraAray[5] = phoneNo;                                  //6	�ֻ�����	�ַ���	V32		                    
	paraAray[6] = "451";                                    //7	ʡ����	�ַ���	F3	451	�̶�Ϊȱʡֵ        
	paraAray[7] = current_time;                             //8	����ʱ��	�ַ���	F14		YYYYMMDDHH24MISS    
	paraAray[8] = prodId;                                       //9	��ƷID����	�ַ���	F14		                  
	paraAray[9] = opTypeCode;                               //10	��������	�ַ���	V32		01:����  02:ȡ��  03:�����˶�        
	paraAray[10] = "0";                                      //11	��������	�ַ���	F9		          
	paraAray[11] = "";                                      //12	��������	�ַ�������	V10		      
	paraAray[12] = "";                                      //13	����ֵ	�ַ�������	V256		      
	paraAray[13] = "";                                      //14	������ע	�ַ���	V256		        
	paraAray[14] = "��ע��"+phoneNo+"����"+opCode+"����Ϊ"+opTypeCode;                 //15                                  
	                                                                  
	                                                                  



	String serverName = "sTSNPubSnd";
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
