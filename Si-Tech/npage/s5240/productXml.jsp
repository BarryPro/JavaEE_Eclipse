<%
  /*
   * ����: ��ƷĿ¼��
   * �汾: 1.0.0
   * ����: 2006/11/27
   * ����: xiening
   * ��Ȩ: si-tech
  */
%>
<%@ page language="java" contentType="text/xml;charset=gb2312" %>
<%@ page import ="org.dom4j.Document" %>
<%@ page import ="org.dom4j.io.XMLWriter" %>
<%@ page import ="org.dom4j.io.OutputFormat" %>
<%@ page import ="org.dom4j.*" %>
<%@ page import ="java.io.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import ="java.util.*" %>

<%
System.out.println("-----------------------------------------------");
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
String regionCode= orgCode.substring(0,2);
String regionName = otherInfoSession[0][5];
String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];

	SPubCallSvrImpl impl = new SPubCallSvrImpl();

	String startProductCode = request.getParameter("productCode");
	String productType = request.getParameter("productType");
	
	if(startProductCode==null||startProductCode.length()==0){
			startProductCode = productType;
	}

	String isRoot = request.getParameter("isRoot");
	
	if(isRoot==null||isRoot.length()==0){
		isRoot = "false";
	}
	
	String startProductName = request.getParameter("productName");
	
	if(startProductName==null||startProductName.length()==0){
		startProductName = (productType.equals("1")?"����":"����");
	}

	PrintWriter writer = response.getWriter();
	OutputFormat format = new OutputFormat();
	format.setIndent(true);
	format.setNewlines(true);
  format.setEncoding("gb2312");
	XMLWriter output = new XMLWriter(writer,format);

	
	int errCode=0;
  String errMsg="";

		ArrayList retList = new ArrayList();  
		String sql="select prod_direct,direct_name,parent_direct from sProductDirect where parent_direct ='"+startProductCode+"'";
		retList = impl.sPubSelect("2",sql,"region",regionCode);
		//impl.printRetValue();	
		String[][] retListString = (String[][])retList.get(0);
		errCode=impl.getErrCode();
  	errMsg=impl.getErrMsg();

	
	if(errCode==0){
		//����doc
		Document document = DocumentHelper.createDocument();
		Map map = new HashMap();
		Element tmpElm = null;
		
		if ("true".equals(isRoot)){
			tmpElm = document.addElement("TreeNode").addElement("TreeNode");
		}
		else {
			tmpElm = document.addElement("TreeNode");
		}
		
	  tmpElm.addAttribute("text","["+startProductCode.trim()+"]"+startProductName);
		tmpElm.addAttribute("id", startProductCode);
		map.put(startProductCode, tmpElm);
		System.out.println("----------------- startProductCode:"+startProductCode);
		System.out.println("�ӽڵ㳤��:"+retListString.length);
		
		String productCode="";
		String productName="";
		String parentProductCode="";


		System.out.println("��ʼѭ��ȡ�ڵ㣡");
		
		for (int i = 0; i < retListString.length; i++) {
			productCode=retListString[i][0];
			productName=retListString[i][1];
			parentProductCode=startProductCode;
			//System.out.println("productCode="+productCode.trim()+"parentProductCode="+parentProductCode);
		
			Element parentElm = (Element) map.get(parentProductCode);
			if (parentElm == null) {
				throw new Exception("��Ʒ���ϱ����ݴ��󣡲�Ʒ��ţ�" + productCode.trim());
			}

			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text","["+productCode.trim()+"]"+productName.trim());
			tmpElm.addAttribute("id", productCode.trim());
			map.put(productCode.trim(), tmpElm);
			String url = new StringBuffer("productXml.jsp?productCode=").append(productCode.trim()).append("&producrType="+productType+"&productName=").append(productName.trim()).toString();	
			tmpElm.addAttribute("href","javascript:returnCode(\""+productCode+"\",\""+productName+"\")");		  
			tmpElm.addAttribute("Xml", url);

		}
		
		//��û���ӽڵ�ʱ
		if(retListString.length==0){
			parentProductCode=startProductCode;
			
			Element parentElm = (Element) map.get(parentProductCode);
			if (parentElm == null) {
				throw new Exception("��Ʒ���ϱ����ݴ��󣡲�Ʒ��ţ�" + productCode.trim());
			}
			
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text","(��Ʒ��)");
			tmpElm.addAttribute("id","-1");
			map.put("-1", tmpElm);
		}
	
		output.write(document);
		output.close();
	}
	else{
		throw new Exception("���񱨴��������"+errCode+"��������Ϣ��"+errMsg);
	}
%>