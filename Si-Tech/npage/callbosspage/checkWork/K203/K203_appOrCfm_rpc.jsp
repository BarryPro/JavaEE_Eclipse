<%
  /*
   * ����: �ʼ���ȷ������
�� * �汾: 1.0
�� * ����: 2008/11/11
�� * ����: hanjc
�� * ��Ȩ: sitech
   * update:  mixh 2009/02/19 ȷ��֮���֪ͨ��֪ͨ���⡢֪ͨ����Ϊֻ����
   *
 ��*/
 %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String belongno   = WtcUtil.repNull(request.getParameter("belongno"));   //������ˮ��                            
	String submitno   = WtcUtil.repNull(request.getParameter("submitno"));   //�ύ�˹���
	String type       = WtcUtil.repNull(request.getParameter("type"));       //���0:�ʼ���֪ͨ��1���ߡ�2�𸴡�3ȷ��                               
	String serialnum  = WtcUtil.repNull(request.getParameter("serialnum"));  //�ʼ쵥��ˮ                                 
	String staffno    = WtcUtil.repNull(request.getParameter("staffno"));    //���칤��                                   
	String evterno    = WtcUtil.repNull(request.getParameter("evterno"));    //�ʼ칤��                       
	String title      = WtcUtil.repNull(request.getParameter("apptitle"));   //����                                       
	String content    = WtcUtil.repNull(request.getParameter("content"));    //���� 
	//String signataryid = WtcUtil.repNull((String)session.getAttribute("kfWorkNo"));//ȷ���˹���
	String signataryid = WtcUtil.repNull((String)session.getAttribute("workNo"));//ȷ���˹���
	
	//�м䴫ֵ���ʼ��Ƿ������ѱ�־
	String flag          = WtcUtil.repNull(request.getParameter("flag"));    //���� 
	String contact_id    = WtcUtil.repNull(request.getParameter("recordeserialnum"));    //ͨ����ˮ 
	String[] sqlStrs     = new String[3];
	String tableName     = "dcallcall";
	if(contact_id.length()>0){
		String nowYYYYMM = contact_id.substring(0, 6);
		tableName = "dcallcall" + nowYYYYMM;
	}
	  
	if("3".equals(type)){
		String sqlUpdateQcinfo = "update dqcinfo set flag='3',signataryid=:v1,affirmtime=sysdate where serialnum=:v2&&"+signataryid+"^"+serialnum;
		String sqlUpdateQcmodInfo = "update dqcmodinfo set flag='3',signataryid=:v1,affirmtime=sysdate where serialnum=:v2 and modflag='1'&&"+signataryid+"^"+serialnum;
		String sqlUpdateDacllcall = "update "+tableName+" set qc_flag='Y',qc_login_no=:v1 where contact_id=:v2&&"+evterno+"^"+contact_id;
		
		sqlStrs[0] = sqlUpdateQcinfo;
		sqlStrs[1] = sqlUpdateQcmodInfo;
		sqlStrs[2] = sqlUpdateDacllcall;    
		//jiangbing 20091118 ���������滻
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm=""; 
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlStrs%>"/>
</wtc:service>
<%
	}
%>
	<wtc:service name="sK203Insert" outnum="3">
	<wtc:param value="<%=belongno%>"/>
	<wtc:param value="<%=submitno%>"/>
	<wtc:param value="<%=type%>"/>
	<wtc:param value="<%=serialnum%>"/>
	<wtc:param value="<%=staffno%>"/>
	<wtc:param value="<%=evterno%>"/>
	<wtc:param value="<%=title%>"/>
	<wtc:param value="<%=content%>"/>
	</wtc:service> 
                          
	var response = new AJAXPacket();
	response.data.add("retCode",<%=retCode%>);
	response.data.add("type","<%=type%>");
	response.data.add("flag","<%=flag%>");
	core.ajax.receivePacket(response);
                      