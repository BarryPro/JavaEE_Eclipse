<%
/********************
 version v2.0
 ������ si-tech
 update anln@2009-2-25
********************/
%>
<%@ page language="java" contentType="text/xml;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import ="org.dom4j.Document" %>
<%@ page import ="org.dom4j.io.XMLWriter" %>
<%@ page import ="org.dom4j.io.OutputFormat" %>
<%@ page import ="org.dom4j.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="java.util.*" %>

<%
System.out.println("-----------------------�����ɫȨ�޽ṹ������XML------------------------");
//��ȡsession��Ϣ
	String loginNo =(String)session.getAttribute("workNo");	
	String regionCode = (String)session.getAttribute("regCode");

	String popedomCode="";
	String popedomName="";
	String loginNo1 = request.getParameter("loginNo1");
	System.out.println("loginNo1="+loginNo1);
	
	String isRoot = request.getParameter("isRoot");
	if(isRoot==null||isRoot.length()==0)
	{
		isRoot = "false";
	}
	
	//��ȡ���ڵ�
	if ("true".equals(isRoot))
	{
		String	strSql = "select popedom_code, '("+loginNo1+")����Ȩ����' from sPopeDomCode where par_domcode = 0";
		//acceptList = callView.sPubSelect("2",strSql,"region",regionCode);
	%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=strSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
	<%		
		String errCode=retCode1;
		String errMsg=retMsg1;
		
		if(!errCode.equals("000000"))
		{
			throw new Exception("��ѯ��ɫȨ���������������"+errCode+"��������Ϣ��"+errMsg);
		}
		else
		{
			String[][] rootList = result;
			popedomCode = rootList[0][0];
			popedomName= rootList[0][1];
		}
	}
	
	//��ȡ���ڵ�
	String startPopedomCode = request.getParameter("popedomCode");
	if(startPopedomCode==null||startPopedomCode.length()==0)
	{
		startPopedomCode = popedomCode;
	}
	
	String startPopedomName = request.getParameter("popedomName");
	if(startPopedomName==null||startPopedomName.length()==0)
	{
		startPopedomName = popedomName;
	}
	
	PrintWriter writer = response.getWriter();
	OutputFormat format = new OutputFormat();
	format.setIndent(true);
	format.setNewlines(true);
	format.setEncoding("gb2312");
	XMLWriter output = new XMLWriter(writer,format);
	List list = null;
	
	//�������ȡ�ӽڵ�
	String paraArr[] = new String[4];
	paraArr[0] = loginNo;
	paraArr[1] = "8002";
	paraArr[2] = loginNo1; 
	paraArr[3] = startPopedomCode; 
	ArrayList acceptList2 = new ArrayList();
	//acceptList2 = callView.callFXService("sQryWorkPDOM",paraArr,"4");
%>
	<wtc:service name="sQryWorkPDOM" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="4" >
		<wtc:param value="<%=paraArr[0]%>"/>
		<wtc:param value="<%=paraArr[1]%>"/>
		<wtc:param value="<%=paraArr[2]%>"/>
		<wtc:param value="<%=paraArr[3]%>"/>		
	</wtc:service>
	<wtc:array id="rootList2" start="0" length="1" scope="end"/>
	<wtc:array id="popedomNameList2" start="1" length="1" scope="end"/>
	<wtc:array id="flagList2" start="3" length="1" scope="end"/>	
<%	
	String errCode =retCode2;
	String errMsg=retMsg2;
	
	if(!errCode.equals("000000"))
	{
		throw new Exception("��ѯ��ɫȨ���������������"+errCode+"��������Ϣ��"+errMsg);
	}
	else
	{
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
		tmpElm.addAttribute("text",startPopedomName);
		tmpElm.addAttribute("id", startPopedomCode);
		map.put(startPopedomCode, tmpElm);
		
		//String[][] rootList2 = result1;
		//String[][] popedomNameList2 = (String[][])acceptList2.get(1);
		//String[][] flagList2 = (String[][])acceptList2.get(3);
		System.out.println("���ε��ýڵ�����="+rootList2.length);
		for (int i = 0; i < rootList2.length; i++)
		{
			String popedomCode2=rootList2[i][0];
			String popedomName2=popedomNameList2[i][0];
			String flag=flagList2[i][0];
			Element parentElm = (Element) map.get(startPopedomCode);
			if (parentElm == null)
			{
				throw new Exception("��ɫȨ�����ݴ���Ȩ�ޱ�ţ�" + startPopedomCode.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text",popedomName2.trim());//+"["+popedomCode2.trim()+"]"
			tmpElm.addAttribute("id", popedomCode2.trim());
			
			//�������Ҷ�ڵ㽫��ΪĿ¼
			if(flag.equals("N"))
			{
				String url = "popedomtreeXml.jsp?loginNo1="+loginNo1+"&popedomCode="+popedomCode2.trim()+"&popedomName="+popedomName2.trim();
				tmpElm.addAttribute("Xml", url);
			}
			
			map.put(popedomCode2.trim(), tmpElm);
		}
		if(rootList2.length==0)
		{
			Element parentElm = (Element) map.get(startPopedomCode);
			if (parentElm == null)
			{
				throw new Exception("��ɫȨ�ޱ����ݴ���Ȩ�ޱ�ţ�" + startPopedomCode.trim());
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