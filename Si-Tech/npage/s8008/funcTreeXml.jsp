<%
  /*
   * ����: ���ܴ�������
   * �汾: 1.0.0
   * ����: 2006/11/01
   * ����: wuln
   * ��Ȩ: si-tech
  */
%>
<%@ page language="java" contentType="text/xml;charset=GBK" %>
<%@ page import ="org.dom4j.Document" %>
<%@ page import ="org.dom4j.io.XMLWriter" %>
<%@ page import ="org.dom4j.io.OutputFormat" %>
<%@ page import ="org.dom4j.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import ="java.util.*" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
System.out.println("-----------------------���빦�ܴ���������XML------------------------");
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
String regionName = otherInfoSession[0][5];
String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
String[][] pass = (String[][])arrSession.get(4);   
String nopass  = pass[0][0]; 
String popeDomCode="";//�¼�Ȩ�޴���
String popeDomName="";//�¼�Ȩ������
String roleCode = request.getParameter("roleCode");	//��ɫ����

SPubCallSvrImpl callView = new SPubCallSvrImpl();
ArrayList acceptList = new ArrayList();	

String isRoot = request.getParameter("isRoot");
if(isRoot==null||isRoot.length()==0)
{
	isRoot = "false";
}
	
	//��ȡ���ڵ�
	if ("true".equals(isRoot))
	{
		String paraArr[] = new String[5];
		paraArr[0] = loginNo;
		paraArr[1] = "8008";
		paraArr[2] = "0";//popeDomCode ��Ȩ�޴���
		paraArr[3] = roleCode;
		paraArr[4] = ""; 
%>
		<wtc:service name="sQryPDOMList" outnum="4" retmsg="retMsg" retcode="retCode" 
			 routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraArr[0]%>" />
			<wtc:param value="<%=paraArr[1]%>" />	
			<wtc:param value="<%=paraArr[2]%>" />	
			<wtc:param value="<%=paraArr[3]%>" />	
			<wtc:param value="<%=paraArr[4]%>" />	
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />
<%
		String errMsg=retMsg;
		
		
		if(!"000000".equals(retCode))
		{
			throw new Exception("sQryPDOMList�����������"+retCode+"��������Ϣ��"+errMsg);
		}
		else
		{
			popeDomCode=result_t[0][0];
			popeDomName=result_t[0][1];
		}
		System.out.println("***sQryPDOMList***"+popeDomCode+"**"+popeDomName+"..**");
	}
	
	//��ȡ���ڵ�
	String startPopeDomCode = request.getParameter("popeDomCode");
	if(startPopeDomCode==null||startPopeDomCode.length()==0)
	{
		startPopeDomCode = popeDomCode;
	}
	
	String startPopeDomName = request.getParameter("popeDomName");
	if(startPopeDomName==null||startPopeDomName.length()==0)
	{
		startPopeDomName = popeDomName;
	}
	
	PrintWriter writer = response.getWriter();
	OutputFormat format = new OutputFormat();
	format.setIndent(true);
	format.setNewlines(true);
	format.setEncoding("gb2312");
	XMLWriter output = new XMLWriter(writer,format);
	List list = null;
	System.out.println("------------------������sQryPDOMList��ȡ�ӽڵ�-------------------");
	//�������ȡ�ӽڵ�
	String paraArr[] = new String[5];
	paraArr[0] = loginNo;
	paraArr[1] = "8008";
	paraArr[2] = startPopeDomCode; 
	paraArr[3] = roleCode; 
	paraArr[4] = ""; 
%>
			<wtc:service name="sQryPDOMList" outnum="4" retmsg="retMsg2" retcode="retCode2" 
			 routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraArr[0]%>" />
			<wtc:param value="<%=paraArr[1]%>" />	
			<wtc:param value="<%=paraArr[2]%>" />	
			<wtc:param value="<%=paraArr[3]%>" />	
			<wtc:param value="<%=paraArr[4]%>" />	
		</wtc:service>
		<wtc:array id="result_t2" scope="end"  />
<%
	
	if(!"000000".equals(retCode2))
	{
		throw new Exception("sQryPDOMList�����������"+retCode2+"��������Ϣ��"+retMsg2);
	}
	else
	{
		int len = result_t2.length;
		Document document = DocumentHelper.createDocument();
		Map map = new HashMap();
		Element tmpElm = null;
		
		if ("true".equals(isRoot))
		{
			tmpElm = document.addElement("TreeNode").addElement("TreeNode");
		}
		else
		{
			tmpElm = document.addElement("TreeNode");
		}
		tmpElm.addAttribute("text",startPopeDomName);
		tmpElm.addAttribute("id", startPopeDomCode);
		tmpElm.addAttribute("href","javascript:saveTo(\""+startPopeDomCode+"\",\""+startPopeDomName+"\")");
		map.put(startPopeDomCode, tmpElm);
		
		/*
		String[][] popeDomCodeArr=(String[][])acceptList2.get(0);		//�¼�Ȩ�޴���
		String[][] popeDomNameArr=(String[][])acceptList2.get(1);		//�¼�Ȩ������
		String[][] hasChildArr=(String[][])acceptList2.get(2);			//Ҷ�ڵ��־ Y/N(Y���ӽڵ�)
		String[][] sFuncCode=(String[][])acceptList2.get(3);
		*/
		System.out.println("���ε��ýڵ�����="+len);
		
		for (int i = 0; i < len; i++)
		{
			String popeDomCode2=result_t2[i][0];
			String popeDomName2=result_t2[i][1];
			String flag=result_t2[i][2];
			String funcCode=result_t2[i][3];
			
			System.out.println(">>>>>>>>>>>>"+popeDomCode2+"|"+popeDomName2+">>>>>>");
			
			Element parentElm = (Element) map.get(startPopeDomCode);
			if (parentElm == null)
			{
				throw new Exception("Ȩ�ޱ����ݴ���Ȩ�ޱ�ţ�" + startPopeDomCode.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			
			tmpElm.addAttribute("text",popeDomName2.trim()+"["+funcCode.trim()+"]");
			tmpElm.addAttribute("id", popeDomCode2.trim());
			tmpElm.addAttribute("href","javascript:saveTo(\""+popeDomCode2+"\",\""+popeDomName2+"\")");
			//�����Ҷ�ڵ㽫��ΪĿ¼
			if(flag.equals("Y"))
			{
				String	url = "funcTreeXml.jsp?roleCode="+roleCode+"&popeDomCode="+popeDomCode2.trim()+"&popeDomName="+popeDomName2.trim();			  
				tmpElm.addAttribute("Xml", url);
			}
			map.put(popeDomCode2.trim(), tmpElm);
		}
		if(len==0)
		{
			Element parentElm = (Element) map.get(startPopeDomCode);
			if (parentElm == null) 
			{
				throw new Exception("Ȩ�ޱ����ݴ���Ȩ�ޱ�ţ�" + startPopeDomCode.trim());
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