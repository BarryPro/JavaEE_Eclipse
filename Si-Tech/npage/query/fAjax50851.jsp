<%@ page contentType="text/html;charset=GBK"%>

<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/client4A/connect4A.jsp" %>
<%@ include file="/npage/client4A/XMLHelper1.jsp" %>
<%@ include file="/npage/client4A/BASE64Crypt.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>
<%!
private static HashMap cfgMap = new HashMap(200);//���滰����ʽ
    private static String DETAIL_PATH = "";
    static {
        //�ӹ��������ļ��ж�ȡ������Ϣ������Ϣ����sever����
        /*���Ի�����*/
        /*DETAIL_PATH = "/iwebd2/applications/QtWebApp/npage/client4A/4aLog";*/
        /*����������*/
        DETAIL_PATH = "/webapp/applications/QtWebApp/npage/client4A/4aLog";
        //�������"/"��ʽ����,����"/"
        if (!DETAIL_PATH.endsWith("/")) {
            DETAIL_PATH = DETAIL_PATH+"/";
        }
    }
    
%>
<%
	/* ȡֵ */
		
	String loginNo = WtcUtil.repNull(request.getParameter("loginNo"));
	String sceneId = WtcUtil.repNull(request.getParameter("sceneId"));
	String sceneName = WtcUtil.repNull(request.getParameter("sceneName"));
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String currTime = WtcUtil.repNull(request.getParameter("currTime"));
	String appId = WtcUtil.repNull(request.getParameter("appId"));
	String appName = WtcUtil.repNull(request.getParameter("appName"));
	String flag4A = WtcUtil.repNull(request.getParameter("flag4A"));
	String appSessionIdFlag = WtcUtil.repNull(request.getParameter("appSessionId"));
	String ipAddrClient = WtcUtil.repNull(request.getParameter("ipAddr"));
	String ipAddr = (String)request.getServerName();
	if(flag4A.equals("1")){
	 flag4A = "����";
	}else{
		flag4A = "�ر�";
		}
	String result = "";
	String resultDesc = "";
	/* �ӿ�ID��5085��������־ΪAAAA03 */
	String transId = "AAAA01";
	/* ��־���·�� */
	String filePath = DETAIL_PATH;
	/* ��־���� */
	String fileName = filePath + transId+".AVL";
	String paramterString = loginNo + "|"  + sceneId + "|" + sceneName + "|" + phoneNo + "|"  + currTime + "|" + appId + "|" + appName + "|"+flag4A+"|" + appSessionIdFlag + "|" + ipAddr + "|" +ipAddrClient +"|";
   java.io.File f = new java.io.File(fileName);
   if(!f.exists())
   {
	 f.createNewFile();
   } 
   try {
	FileWriter writer = new FileWriter(fileName, true);
	writer.write(paramterString);
	writer.write("\n");
	writer.close();
	result = "1";
	resultDesc = "�ļ������ɣ�";
   } catch (IOException e) {
	e.printStackTrace();
	result = "0";
	resultDesc = "д�ļ�ʧ�ܣ�";
   }

	
	
%>
	var response = new AJAXPacket();

	response.data.add("result","<%=result%>");
	response.data.add("resultDesc","<%=resultDesc%>");