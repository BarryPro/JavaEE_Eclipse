<%
/********************
 version v2.0
 ������ si-tech
 update anln@2009-2-19
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
	String roleCode = request.getParameter("roleCode");
	String roleName = request.getParameter("roleName");

	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	//ArrayList acceptList = new ArrayList();	

	String isRoot = request.getParameter("isRoot");
	System.out.println("IsRootx=" + isRoot);

	if(isRoot==null||isRoot.length()==0)
	{
		isRoot = "false";
	}
	
	//��ȡ���ڵ�
	if ("true".equals(isRoot))
	{
		String	strSql = "select popedom_code, '("+roleCode+"-"+roleName+")��ɫȨ����' from sPopeDomCode where par_domcode = 0 order by reflect_code";
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
			//String[][] rootList = (String[][])acceptList.get(0);
			String[][] rootList =result;
			popedomCode = rootList[0][0];
			popedomName= rootList[0][1];
		}
	}
	
	//��ȡ���ڵ�
	String startPopedomCode = request.getParameter("popedomCode");
	System.out.println("startPopedomCodexx=" + startPopedomCode);
	
	if(startPopedomCode==null||startPopedomCode.length()==0)
	{
		startPopedomCode = popedomCode;
	}
	
	System.out.println("startPopedomCodexx1=" + startPopedomCode);
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
	
	//��ȡ�ӽڵ�
	String strSql1 = "select popedom_code, popedom_name, leaf_flag,reflect_code from sPopedomCode  "+
					 "where par_domcode = '"+startPopedomCode+"'  and 	use_flag = 'Y' and popedom_code in  "+
					 "(select popedom_code from sRolePDomRelation where role_code = '"+roleCode+"') ";
	//ArrayList acceptList2 = new ArrayList();							 
	//acceptList2 = callView.sPubSelect("4",strSql1,"region",regionCode);	
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="4">
		<wtc:sql><%=strSql1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
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
		//tmpElm.addAttribute("href","javascript:saveTo(\""+startPopedomCode+"\",\""+startPopedomName+"\",\""+startRoleTypeCode+"\",\""+startPowerDes+"\",\""+startUseFlag+"\",\""+startOpNote+"\",\""+startCreatLogin+"\",\""+startCreatDate+"\",\""+startCreatName+"\",\""+startCreatGroup+"\")");
		map.put(startPopedomCode, tmpElm);
		
		//String[][] rootList2 = (String[][])acceptList2.get(0);		
		String[][] rootList2 = result2;
		
		System.out.println("���ε��ýڵ�����="+rootList2.length);
		for (int i = 0; i < rootList2.length; i++)
		{
			String popedomCode2=rootList2[i][0];
			String popedomName2=rootList2[i][1];
			String flag=rootList2[i][2];
			String funcCode = rootList2[i][3];

			Element parentElm = (Element) map.get(startPopedomCode);
			if (parentElm == null)
			{
				throw new Exception("��ɫȨ�����ݴ���Ȩ�ޱ�ţ�" + startPopedomCode.trim());
			}
			
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text",popedomName2.trim()+"["+funcCode.trim()+"]");
			tmpElm.addAttribute("id", popedomCode2.trim());
			//tmpElm.addAttribute("href","javascript:saveTo(\""+popedomCode2+"\",\""+popedomName2+"\",\""+roleTypeCode2+"\",\""+powerDes2+"\",\""+useFlag2+"\",\""+opNote2+"\",\""+creatLogin2+"\",\""+creatDate2+"\",\""+creatName2+"\",\""+creatGroup2+"\")");
			//�������Ҷ�ڵ㽫��ΪĿ¼
			if(flag.equals("N"))
			{
				String url = "popedomtreeXml.jsp?roleCode="+roleCode+"&popedomCode="+popedomCode2.trim()+"&popedomName="+popedomName2.trim();
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