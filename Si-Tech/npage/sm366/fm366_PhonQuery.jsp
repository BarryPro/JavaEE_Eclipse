<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) -------------------
 
 -------------------------��̨��Ա��--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.csp.bsf.pwm.util.*"%>
	var retArray = new Array();//���巵������
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String id_typess      = WtcUtil.repNull(request.getParameter("id_typess"));
	String idIccid        = WtcUtil.repNull(request.getParameter("idIccid"));	
	
	
	System.out.println("-------hejwa-------MD5ǰ-----------idIccid-------->"+idIccid);
	
	MD5 md5 = new MD5();
	String idIccid_md5str  = md5.encode(idIccid); /*���� loginPass Ϊ����ǰ�����룬����������*/
		                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	String phoneQryNum    = "";


	//ͨ��sql��ѯ������������ˮ���½�����SEQ_PHONEQUERY_ID
	/*B��ʡBOSS�ı������3λʡ����+14λ���ʱ��YYYYMMDDHH24MMSS+6λ��ˮ�ţ�����������Ŵ�000001��ʼ����������Ϊ1��*/
	String seq_sql = "select to_char(trim('451'||to_char(sysdate,'yyyyMMddHH24miss'))||trim(to_char(DBCUSTADM.SEQ_PHONEQUERY_SEQ.NEXTVAL,'000000'))) as seq from dual";
	String seq_str = "";
	
%>

      	 
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=seq_sql%>" />
	</wtc:service>
	<wtc:array id="result_Seq" scope="end"   />

<%
	if(result_Seq.length>0){
			seq_str = result_Seq[0][0];
	}
	
	/*�������Ϊ��ȫ����ʶ���루1λ��+������루8λ��+������ʽ���루1λ��+���кţ�5λ����*/
	/*������루8λ���������Ϊ��ʡ���루3λ��+���б��루3λ��+�������루2λ��*/
	

	String channelId_sql =  "	select to_char('2' || '451' || "+
												  "    (select trim(to_char(a.toll_no)) as toll_no "+
												  "       from sregioncode a "+
												  "      where a.region_code = :loginRegion) || '00' || '1' || "+
												  "  trim(to_char(DBCUSTADM.SEQ_PHONEQUERY_SEQ.NEXTVAL, '00000'))) as ChannelId "+
												  "	 from dual";
	String channelId_sql_parm = "loginRegion="+regionCode;											  
	String channelId_str = "";

%>

  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=channelId_sql%>" />
		<wtc:param value="<%=channelId_sql_parm%>" />
	</wtc:service>
	<wtc:array id="result_channelId" scope="end"   />
		
<%
	if(result_channelId.length>0){
		channelId_str = result_channelId[0][0];
	}
	
	//7����׼�����
	String paraAray[] = new String[8];                                                                                                                                                    
	                                                                                                                                                                                      
	paraAray[0] = "P0000013";                                                 // 0	"ҵ����루bipCode��"	�ַ���	8	P0000012	                                                                
	paraAray[1] = "S0000013";                                                 // 1	���״��루transCode��	�ַ���	8	S0000012	                                                                
	paraAray[2] = (String)session.getAttribute("workNo");   //����            // 2	���ţ�loginNo ��	�ַ���	V60		                                                                          
	paraAray[3] = (String)session.getAttribute("orgCode");                    // 3	����OrgCode(orgCode )	�ַ���			                                                                        
	paraAray[4] = seq_str;                                                    // 4	������ˮ�ţ�Seq��		V32		��д��ʽ��7.5 ������ˮ��                                                        
	paraAray[5] = id_typess;                                                  // 6	֤������(IDCardType)	�ַ���	F2		�μ��ͻ�֤�����ͱ���                                                  
	paraAray[6] = idIccid_md5str;                                             // 7	֤������(IDCardNum)	�ַ���	V32		���ֶ���ҪMD5���ܣ�ʡ��˾ͨ��MD5����֮���ϴ���ƽ̨�յ������            
	paraAray[7] = channelId_str;                                              // 8	�������(ChannelId)	�ַ���	V32		��ʡ��������ʶ������ȫ������ͳһ������������¼7.6��                 
	                                                                                                                                                                                      
	String serverName = "sTSNPubSnd";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="8" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="result_t"     scope="end" start="0"  length="1"  />
		<wtc:array id="serverResult" scope="end" start="1"  length="7" />
<%
	retCode = code;
	retMsg = msg;
	
	if(result_t.length>0){
		phoneQryNum = result_t[0][0];
	}
	
	//ƴװ��������
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
				System.out.println("--hejwa--------------------------------------------����------serverName=["+serverName+"]--------serverResult["+i+"]["+j+"]------->"+serverResult[i][j]);
		
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j]%>";
<%		
		}
	}
	
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
response.data.add("phoneQryNum","<%=phoneQryNum%>");

response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
