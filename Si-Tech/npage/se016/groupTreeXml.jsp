<%
  /*
   * ����: ��֯�ṹ��
   * �汾: 1.0.0
   * ����: 2006/11/01
   * ����: xiening
   * ��Ȩ: si-tech
  */
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page language="java" contentType="text/xml;charset=gb2312" %>
<%@ page import ="org.dom4j.Document" %>
<%@ page import ="org.dom4j.io.XMLWriter" %>
<%@ page import ="org.dom4j.io.OutputFormat" %>
<%@ page import ="org.dom4j.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import ="java.util.*" %>

<%
System.out.println("groupTreeXml.jsp");
System.out.println("-----------------------������֯�ṹ������XML------------------------");
//��ȡsession��Ϣ
ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
String[][] baseInfoSession = (String[][])arrSession.get(0);
String[][] otherInfoSession = (String[][])arrSession.get(2);
String loginNo = baseInfoSession[0][2];
String loginName = baseInfoSession[0][3];
String powerCode= otherInfoSession[0][4];
String power_right= baseInfoSession[0][5];
String orgCode = baseInfoSession[0][16];
String ip_Addr = request.getRemoteAddr();
String regionCode = orgCode.substring(0,2);
String iregionCode=WtcUtil.repNull(request.getParameter("regionCode"));
String regionName = otherInfoSession[0][5];
String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
String[][] pass = (String[][])arrSession.get(4);   
String nopass  = pass[0][0]; 
String groupId="";
String groupName="";
SPubCallSvrImpl callView = new SPubCallSvrImpl();
ArrayList acceptList = new ArrayList();	

String groupIdSql = "select b.group_id,b.group_name from sregionCode a ,dchngroupmsg b where a.group_id=b.group_id and a.region_code='"+iregionCode+"'";
%>
<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
	<wtc:param value="<%=groupIdSql%>"/>
</wtc:service>
<wtc:array id="resultGroupIdSql" scope="end"/>

<%
 if("000000".equals(retCode)&& resultGroupIdSql.length!=0)
 {
   groupId=resultGroupIdSql[0][0];
   groupName=resultGroupIdSql[0][1];
 }

System.out.println("---------------------groupId--------------------------"+groupId);

String isRoot = request.getParameter("isRoot");
if(isRoot==null||isRoot.length()==0){
	isRoot = "false";
}
	//��ȡ���ڵ�
/*
	if ("true".equals(isRoot)){
		String paraArr[] = new String[3];
		paraArr[0] = loginNo;
		paraArr[1] = nopass;
		paraArr[2] = "8021";
					
		acceptList = callView.callFXService("s8021_Qry04",paraArr,"2");
		int errCode=callView.getErrCode();   
		String errMsg=callView.getErrMsg();
		if(errCode!=0){
			throw new Exception("s8021_Qry04�����������"+errCode+"��������Ϣ��"+errMsg);
		}
		else{
			String[][] rootDirectList=(String[][])acceptList.get(0);
			String[][] rootDirectListName=(String[][])acceptList.get(1);
			groupId=rootDirectList[0][0];
			groupName=rootDirectListName[0][0];
		}
	}
*/
	if ("true".equals(isRoot)){	
	  groupId = groupId;
		groupName = groupName;
	}
	
	System.out.println("Xml:groupId="+groupId);	
	System.out.println("Xml:groupName="+groupName);	
	//��ȡ���ڵ�
	String startGroupId = request.getParameter("groupId");
	if(startGroupId==null||startGroupId.length()==0){
		startGroupId = groupId;
	}
	
	String startGroupName = request.getParameter("groupName");
	if(startGroupName==null||startGroupName.length()==0){
		startGroupName = groupName;
	}
	
	System.out.println("startGroupId="+startGroupId);
	System.out.println("startGroupName="+startGroupName);
	
	PrintWriter writer = response.getWriter();
	OutputFormat format = new OutputFormat();
	format.setIndent(true);
	format.setNewlines(true);
	format.setEncoding("gb2312");
	XMLWriter output = new XMLWriter(writer,format);
	List list = null;
	
	String sqlFindChild = "SELECT c.group_id, c.group_name, c.class_code, '00', "
		+ "'0','0', a.PARENT_GROUP_ID , 'Y', '0',' ', "
		+ "'0',' ', decode(upper(c.HAS_CHILD),'Y','N','Y') "
		+ "  FROM dbresadm.dChnGroupInfo a, "
		+ "       dChnGroupMsg c , "
		+ "       dbchnadn.sChnClassMsg d "
		+ " WHERE a.group_id = c.group_id "
		+ "   AND a.denorm_level = 1 "
		+ "   AND c.class_code = d.class_code "
		+ "   AND a.parent_group_id = '" + startGroupId + "'";
%>
<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="13">
	<wtc:param value="<%=sqlFindChild%>"/>
</wtc:service>
<wtc:array id="resultFindChild" scope="end"/>

<%
	System.out.println("====wanghfa====groupTreeXml_workNo.jsp====sqlFindChild : " + retCode1 + ", " + retMsg1);
	if ("000000".equals(retCode1)) {
		for (int i = 0; i < resultFindChild.length; i ++) {
			for (int j = 0; j < resultFindChild[i].length; j ++) {
				
			}
		}
/*
	}
	

	//�������ȡ�ӽڵ�
	String paraArr[] = new String[7];
	paraArr[0] = loginNo;
	paraArr[1] = nopass;
	paraArr[2] = "8021";
	paraArr[3] = "a"; 
	paraArr[4] = startGroupId; 
	paraArr[5] = "N"; 
	paraArr[6] = "0"; 
	ArrayList acceptList2 = new ArrayList();				
	acceptList2 = callView.callFXService("s8021_Qry05",paraArr,"13");
	int errCode =callView.getErrCode();   
	String errMsg=callView.getErrMsg();
	
	if(errCode!=0){
		throw new Exception("s8021_Qry05�����������"+errCode+"��������Ϣ��"+errMsg);
	}
	else{
*/		
		Document document = DocumentHelper.createDocument();
		Map map = new HashMap();
		Element tmpElm = null;
		
		if ("true".equals(isRoot)){
			tmpElm = document.addElement("TreeNode").addElement("TreeNode");
		}
		else {
			tmpElm = document.addElement("TreeNode");
		}
		tmpElm.addAttribute("text",startGroupName);
		tmpElm.addAttribute("id", startGroupId);
		//tmpElm.addAttribute("href","javascript:saveTo(\""+startGroupId+"\",\""+startGroupName+"\")");
		map.put(startGroupId, tmpElm);
		
/*
		String[][] groupIdArr=(String[][])acceptList2.get(0);		//��֯���
		String[][] groupNameArr=(String[][])acceptList2.get(1);	//��֯����
		String[][] flagArr=(String[][])acceptList2.get(12);			//Ҷ�ڵ��־ Y/N(Y���ӽڵ�)

		System.out.println("���ε��ýڵ�����="+groupIdArr.length);
*/
		for (int i = 0; i < resultFindChild.length; i++) {
			String groupId2=resultFindChild[i][0];
			String groupName2=resultFindChild[i][1];
			String flag=resultFindChild[i][12];
			System.out.println("flag:"+flag);
			Element parentElm = (Element) map.get(startGroupId);
			if (parentElm == null) {
				throw new Exception("��֯���ϱ����ݴ�����֯��ţ�" + startGroupId.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text",groupName2.trim());
			tmpElm.addAttribute("id", groupId2.trim());
			//tmpElm.addAttribute("href","javascript:saveTo(\""+groupId2+"\",\""+groupName2+"\")");
			//�������Ҷ�ڵ㽫��ΪĿ¼
			if(flag.equals("N")){
				String url = "groupTreeXml.jsp?groupId="+groupId2.trim()+"&groupName="+groupName2.trim();			  
				tmpElm.addAttribute("Xml", url);
			}
			
			map.put(groupId2.trim(), tmpElm);

		}
		if(resultFindChild.length==0){
			Element parentElm = (Element) map.get(startGroupId);
			if (parentElm == null) {
				throw new Exception("��֯���ϱ����ݴ�����֯��ţ�" + startGroupId.trim());
			}
			//tmpElm = parentElm.addElement("TreeNode");
			//tmpElm.addAttribute("text","û���ҵ����ݣ�");
			//tmpElm.addAttribute("id","-1");
			//map.put("-1", tmpElm);
		}
		output.write(document);
		output.close();
	}
%> 
