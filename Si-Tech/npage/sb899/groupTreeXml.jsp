<%
  /*
   * ����: ��֯�ṹ��
   * �汾: 1.0.0
   * ����: 2008/06/01
   * ����: sunwt
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
	System.out.println("------groupTreeXml.jsp----������֯�ṹ������XML--------");
	/*��ȡsession��Ϣ*/
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String serverName = "s8021_Qry04";    

	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgCode =  (String)session.getAttribute("orgCode");
	String ip_Addr = request.getRemoteAddr();
	String regionCode =  (String)session.getAttribute("regCode");
	String nopass  = (String)session.getAttribute("password");
	String groupId = "";
	String groupName = "";
	String accType = request.getParameter("accType");
	String selType = request.getParameter("selType");
    String ii = request.getParameter("ii") == null?"1":request.getParameter("ii");
	String isRoot = request.getParameter("isRoot");
	if(isRoot==null||isRoot.length()==0)
	{
		isRoot = "false";
	}
	/*��ȡ���ڵ�*/
	if ("true".equals(isRoot))
	{
%>
 	<wtc:service name="s8021_Qry04" routerKey="region" routerValue="<%=regionCode%>" retcode="Code" retmsg="Msg" outnum="2" >
	<wtc:param value="<%=loginNo%>" />
	<wtc:param value="<%=nopass%>" />
	<wtc:param value="8021" />
	</wtc:service> 
	<wtc:array id="result" scope="end"/>
<%		
        if("0".equals(Code) || "000000".equals(Code)){
           String[][] rootGroupMsg = result;
		   groupId = rootGroupMsg[0][0];
		   groupName = rootGroupMsg[0][1];
		   System.out.println(">>>>>>>>>>."+groupId+ ">>>>"+groupName);
        }else{
          throw new Exception("s8021_Qry04�����������"+Code+"��������Ϣ��"+Msg);	
        }
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
	/*�������ȡ�ӽڵ�*/
%>
	<wtc:service name="sb901GrpTreeQry" routerKey="region" routerValue="<%=regionCode%>" retcode="Code1" retmsg="Msg1" outnum="13" >
	<wtc:param value="<%=loginNo%>" />
	<wtc:param value="<%=nopass%>" />
	<wtc:param value="b901" />
	<wtc:param value="<%=startGroupId%>" />
	</wtc:service> 
	<wtc:array id="result_t" scope="end"/>
<%
	int len = result_t.length;
	if(!Code1.equals("000000") && !Code1.equals("0"))
	{
		throw new Exception(serverName + "�����������" + Code1 + "��������Ϣ��" + Msg1);
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
			String groupId2=result_t[i][0];
			String groupName2=result_t[i][1];
			String flag=result_t[i][12];
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

			int jj = Integer.parseInt(ii);
			if(flag.equals("N") && jj<3){
			    
			    jj++;
			    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  JJ    "+jj);
				String url = "groupTreeXml.jsp?groupId="+groupId2.trim()+"&groupName="+groupName2.trim()+"&ii="+jj;			  
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
