<%
  /*
   * ����: ��֯�ṹ��
   * �汾: 1.0.0
   * ����: 2006/11/01
   * ����: xiening
   * ��Ȩ: si-tech
  */
%>
<%@ page language="java" contentType="text/xml;charset=GBK" %>
<%@ page import ="org.dom4j.Document" %>
<%@ page import ="org.dom4j.io.XMLWriter" %>
<%@ page import ="org.dom4j.io.OutputFormat" %>
<%@ page import ="org.dom4j.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="java.util.*" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
System.out.println("groupTreeXmlTT.jsp");
System.out.println("-----------------------������֯�ṹ������XML------------------------");
//��ȡsession��Ϣ
String loginNo = (String)session.getAttribute("workNo");
String ip_Addr = request.getRemoteAddr();
String regionCode = (String)session.getAttribute("regCode");
String nopass  = (String)session.getAttribute("password"); 
String groupId="";
String groupName="";

String isRoot = request.getParameter("isRoot");
if(isRoot==null||isRoot.length()==0){
	isRoot = "false";
}
	//��ȡ���ڵ�
	if ("true".equals(isRoot)){
		String paraArr[] = new String[3];
		paraArr[0] = loginNo;
		paraArr[1] = nopass;
		paraArr[2] = "8021";
			
%>
		<wtc:service name="s8021_Qry04" outnum="2" 
			 routerKey="region" routerValue="<%=regionCode%>" 
			 retcode="errCode2" retmsg="errMsg2" >
			<wtc:param value="<%=paraArr[0]%>" />
			<wtc:param value="<%=paraArr[1]%>" />
			<wtc:param value="<%=paraArr[2]%>" />
		</wtc:service> 
		<wtc:array id="acceptList" scope="end"/>
<%
		if(!errCode2.equals("0") && !errCode2.equals("000000")){
			throw new Exception("s8021_Qry04�����������"+errCode2+"��������Ϣ��"+errMsg2);
		}
		else{
			groupId=acceptList[0][0];
			groupName=acceptList[0][1];
		}
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
	format.setEncoding("GBK");
	XMLWriter output = new XMLWriter(writer,format);
	List list = null;
	
	//�������ȡ�ӽڵ�
	String paraArr[] = new String[7];
	paraArr[0] = loginNo;
	paraArr[1] = nopass;
	paraArr[2] = "g642";
	paraArr[3] = "a"; 
	paraArr[4] = startGroupId; 
	paraArr[5] = "N"; 
	paraArr[6] = "0"; 
%>
	<wtc:service name="s8021_Qry05" outnum="13" 
		 routerKey="region" routerValue="<%=regionCode%>" 
		 retcode="errCode" retmsg="errMsg" >
		<wtc:param value="<%=paraArr[0]%>" />
		<wtc:param value="<%=paraArr[1]%>" />
		<wtc:param value="<%=paraArr[2]%>" />
		<wtc:param value="<%=paraArr[3]%>" />
		<wtc:param value="<%=paraArr[4]%>" />
		<wtc:param value="<%=paraArr[5]%>" />
		<wtc:param value="<%=paraArr[6]%>" />
		<wtc:param value="2148" />
	</wtc:service> 
	<wtc:array id="acceptList2" scope="end"/>
<%
	if(!errCode.equals("0") && !errCode.equals("000000")){
		throw new Exception("s8021_Qry05�����������"+errCode+"��������Ϣ��"+errMsg);
	}
	else{
		
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
		tmpElm.addAttribute("href","javascript:saveTo(\""+startGroupId+"\",\""+startGroupName+"\")");
		map.put(startGroupId, tmpElm);

		int len = acceptList2.length;
		//System.out.println("���ε��ýڵ�����="+groupIdArr.length);
		for (int i = 0; i < len; i++) {
			String groupId2=acceptList2[i][0];
			String groupName2=acceptList2[i][1];
			String flag=acceptList2[i][12];
			System.out.println("flag:"+flag);
			Element parentElm = (Element) map.get(startGroupId);
			if (parentElm == null) {
				throw new Exception("��֯���ϱ����ݴ�����֯��ţ�" + startGroupId.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text",groupName2.trim());
			tmpElm.addAttribute("id", groupId2.trim());
			tmpElm.addAttribute("href","javascript:saveTo(\""+groupId2+"\",\""+groupName2+"\")");
			//�������Ҷ�ڵ㽫��ΪĿ¼
			if(flag.equals("N")){
				String url = "groupTreeXmlTT.jsp?groupId="+groupId2.trim()+"&groupName="+groupName2.trim();			  
				tmpElm.addAttribute("Xml", url);
			}
			
			map.put(groupId2.trim(), tmpElm);

		}
		if(len==0){
			Element parentElm = (Element) map.get(startGroupId);
			if (parentElm == null) {
				throw new Exception("��֯���ϱ����ݴ�����֯��ţ�" + startGroupId.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text","û���ҵ����ݣ�");
			tmpElm.addAttribute("id","-1");
			map.put("-1", tmpElm);
		}
		output.write(document);
		output.close();
	}
%> 
