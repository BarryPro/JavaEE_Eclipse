<%
  /*
   * ����: ��֯�ṹ��
   * �汾: 1.0.0
   * ����: 2011/05/03
   * ����: ningtn
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
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import ="java.util.*" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
	System.out.println("------groupTreeXml.jsp----������֯�ṹ������XML--------");
	//��ȡsession��Ϣ
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String serverName = "s8021_Qry06";    //ֻ��ʾ��Ч��
	String serverType = request.getParameter("serverType");

	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String[][] otherInfoSession = (String[][])arrSession.get(2);
	String loginNo = baseInfoSession[0][2];
	String regionCode = (String)session.getAttribute("regCode");
	String[][] pass = (String[][])arrSession.get(4);
	String nopass  = pass[0][0];
	String groupId = "";
	String groupName = "";
	String accType = request.getParameter("accType");
	String selType = request.getParameter("selType");

	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	ArrayList acceptList = new ArrayList();

	if(serverType.equals("ALL"))
	{
		serverName = "s8021_Qry05";   //Ĭ��Ϊȫ����ʾ
	}
	/*
	if(accType != null && "2".equals(accType))
	{
		serverName = "s8021_Qry07";
	}
	*/
	System.out.println(">>>>" + serverType + ">>>>" + serverName + ">>>>>");

	String isRoot = request.getParameter("isRoot");
	String rootGroupId = request.getParameter("rootGroupId");
	if(isRoot==null||isRoot.length()==0)
	{
		isRoot = "false";
	}
	//��ȡ���ڵ�
	if ("true".equals(isRoot))
	{
		String strSql = "";
		/*�ͷ���֯�ṹ����ʾ�����*/

		if(accType != null && accType.equals("2"))
		{
			strSql = "select group_id, group_name from dChnGroupMsg "
				+ "where root_distance = 2 and class_code = '5'";
			System.out.println(strSql);
		}
		else /*BOSS��֯�����ڵ���ʾ�����*/
		{
			if(rootGroupId == null || rootGroupId.length()==0){
				strSql = "select b.group_id, a.group_name from dChnGroupMsg a, dLoginMsg b "
					+ "where b.login_no = '" + loginNo + "' and a.group_id = b.group_id";
			}else{
				strSql = "select a.group_id, a.group_name from dChnGroupMsg a "
					+ "where a.group_id = '" + rootGroupId + "'";
			}
		}

		System.out.println("++++"+strSql+"++++");
		comImpl comResult = new comImpl();
		acceptList = comResult.spubqry32("2",strSql);
		String[][] rootGroupMsg = (String[][])acceptList.get(0);

		groupId = rootGroupMsg[0][0];
		groupName = rootGroupMsg[0][1];

		System.out.println(">>>>>>>>>>."+groupId+ ">>>>"+groupName);
	}

	//��ȡ���ڵ�
	String startGroupId = request.getParameter("groupId");
	if(startGroupId==null||startGroupId.length()==0)
	{
		startGroupId = groupId;
	}

	String startGroupName = request.getParameter("groupName");
	if(startGroupName==null||startGroupName.length()==0)
	{
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
	String paraArr[] = new String[8];
	paraArr[0] = loginNo;
	paraArr[1] = nopass;
	paraArr[2] = "8021";
	paraArr[3] = "a";
	paraArr[4] = startGroupId;
	paraArr[5] = "N";
	paraArr[6] = "0";
	paraArr[7] = selType;

/*
	ArrayList acceptList2 = new ArrayList();
	acceptList2 = callView.callFXService(serverName,paraArr,"13");
	int errCode =callView.getErrCode();
	String errMsg=callView.getErrMsg();
*/	

%>
	<wtc:service name="<%=serverName%>" outnum="13" >
		<wtc:param value="<%=paraArr[0]%>" />
		<wtc:param value="<%=paraArr[1]%>" />
		<wtc:param value="<%=paraArr[2]%>" />
		<wtc:param value="<%=paraArr[3]%>" />
		<wtc:param value="<%=paraArr[4]%>" />
		<wtc:param value="<%=paraArr[5]%>" />
		<wtc:param value="<%=paraArr[6]%>" />
		<wtc:param value="<%=paraArr[7]%>" />
	</wtc:service> 
	<wtc:array id="result" scope="end"/>
<%
	int len = result.length;
	if(!retCode.equals("000000"))
	{
		throw new Exception(serverName + "�����������" + retCode + "��������Ϣ��" + retMsg);
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

		tmpElm.addAttribute("text",startGroupName);
		tmpElm.addAttribute("id", startGroupId);
		tmpElm.addAttribute("href","javascript:saveTo(\""+startGroupId+"\",\""+startGroupName+"\")");
		map.put(startGroupId, tmpElm);
/*
		String[][] groupIdArr=(String[][])result.get(0);   //��֯���
		String[][] groupNameArr=(String[][])result.get(1); //��֯����
		String[][] flagArr=(String[][])result.get(12);     //Ҷ�ڵ��־ Y/N(Y���ӽڵ�)
*/
		System.out.println("���ε��ýڵ�����="+len);
		for (int i = 0; i < len; i++)
		{
			String groupId2=result[i][0];
			String groupName2=result[i][1];
			String flag=result[i][12];
			System.out.println("flag:"+flag);
			Element parentElm = (Element) map.get(startGroupId);
			if (parentElm == null)
			{
				throw new Exception("��֯���ϱ����ݴ�����֯��ţ�" + startGroupId.trim());
			}
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text",groupName2.trim());
			tmpElm.addAttribute("id", groupId2.trim());
			tmpElm.addAttribute("href","javascript:saveTo(\""+groupId2+"\",\""+groupName2+"\")");

			//�������Ҷ�ڵ㽫��ΪĿ¼
			if(flag.equals("N"))
			{
				String url = "groupTreeXml.jsp?groupId="+groupId2.trim()
							+ "&groupName=" + groupName2.trim()+ "&serverType="+serverType
							+ "&accType=" + accType + "&selType="+selType;
				tmpElm.addAttribute("Xml", url);
			}

			map.put(groupId2.trim(), tmpElm);

		}
		if(len==0)
		{
			Element parentElm = (Element) map.get(startGroupId);
			if (parentElm == null)
			{
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
