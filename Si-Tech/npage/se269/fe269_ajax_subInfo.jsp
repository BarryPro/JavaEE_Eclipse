<%
/*************************************
* ��  ��: 4A�ܿ��� e269
* ��  ��: version v1.0
* ������: si-tech
* ������: diling @ 2011-9-16
**************************************/
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="java.util.Date" %>

<%@ page import ="java.text.DateFormat"%>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>
<%
	String opCode=request.getParameter("opcode");
	String opName=request.getParameter("opName");
    String loginNo = (String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String passWord = (String)session.getAttribute("password");
    String ip = (String)session.getAttribute("ipAddr");
    String buttonFlag = request.getParameter("buttonFlag"); //���ر�ʶ
    
    /*����ʱ��*/
	java.util.Date sysdate = new java.util.Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
	String createTime = sf.format(sysdate);
	String vNote=opCode + opName;
%>   
<wtc:service name="se269Cfm" routerKey="region" routerValue="<%=regionCode%>" 
	 retcode="Code" retmsg="Msg" outnum="2" >
        <wtc:param value="0"/>  <%//��ˮ%>
        <wtc:param value="01"/> 
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="<%=passWord%>"/>
        <wtc:param value=" "/>
        <wtc:param value=" "/>
        <wtc:param value="<%=ip%>"/>
        <wtc:param value="<%=buttonFlag%>"/>  
        <wtc:param value="<%=createTime%>"/>  
        <wtc:param value="<%=vNote%>"/>  
</wtc:service>
<wtc:array id="result"  scope="end"/>
<%
String retcode = Code;
String retmsg = Msg;
if(retcode.equals("000000"))
{
	String treasuryPath = request.getRealPath("npage/properties")
		+"/treasury.properties";
	List lSceneId=readKeyValues( "sceneId",treasuryPath  );
	List lScenceNm=readKeyValues( "sceneName",treasuryPath  );
	/*ֻҪ��⿪����־,��Ҫ����־:����opcode���ж�
		����������Ҫ������־ �����ļ���*/
	if ( opCode.equals("e768") )
	{
		String fnTm=createTime.substring(0,11);
		
		String fileName=request.getRealPath("/npage/client4A/4aLog")+"/AAAA02.AVL";
		
		/*�����ļ����� 1-����;0-�ر�*/
		String fileCont="";	
		/**/
		for ( int i=0;i<lSceneId.size();i++ )
		{
			if ( buttonFlag.equals("1") ) /*������־*/
			{
				fileCont+=loginNo+"|"+lSceneId.get(i)+"|"+lScenceNm.get(i)+"|�ֶ�||"+createTime+"|1|"+java.net.InetAddress.getLocalHost().getHostAddress() +"|"+ip+"|\n";
			}
			else /*�ر���־*/
			{
				fileCont+=loginNo+"|"+lSceneId.get(i)+"|"+lScenceNm.get(i)+"|�ֶ�|"+createTime+"||0|"+java.net.InetAddress.getLocalHost().getHostAddress() +"|"+ip+"|\n";
			}			
		}
		try
		{
			/*�����ļ�*/
			File file = new File(fileName);
			/*����ļ�������*/
			if (!file.exists()) 
			{
				/*�ļ����� >> �ļ��������ʧ��*/
				if (!file.createNewFile())
				{
					%>
						<script language='javascript'>
						rdShowMessageDialog("��⿪�ز����ɹ�,���������־ʧ��!",0);
						window.location = "fe269_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
						</script>
					<%
				} 
			} 				

			FileWriter writer = new FileWriter(fileName, true);
			/*д�ļ��ļ�*/
			writer.write(fileCont);
			writer.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			%>
				<script language='javascript'>
				rdShowMessageDialog("��⿪�ز����ɹ�,��¼�����־ʧ��!",0);
				window.location = "fe269_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				</script>
			<%			
		}
	}	

%>
	<script language='javascript'>
	rdShowMessageDialog("�����ɹ���",2);
	window.location = "fe269_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
}
else
{
%>
	<script language='javascript'>
	rdShowMessageDialog("������Ϣ��<%=retmsg%><br>������룺<%=retcode%>", 0);
	window.location = "fe269_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
}
%>



                                                         



   	

