<%
  /*
   * ����: ҵ��Ŀ¼��
   * �汾: 1.0.0
   * ����: 2008/04/15
   * ����: xuls
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
String regionCode = orgCode.substring(0,2);
String regionName = otherInfoSession[0][5];
String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];

	SPubCallSvrImpl impl = new SPubCallSvrImpl();

	String startProductCode = request.getParameter("productCode");
	String region = request.getParameter("region");
	String regionName2=request.getParameter("regionName2"); 

	System.out.println("regionName2:"+regionName2);


	if(startProductCode==null||startProductCode.length()==0){
		startProductCode = "";
	}

	String isRoot = request.getParameter("isRoot");

	if(isRoot==null||isRoot.length()==0){
		isRoot = "false";
	}

	String startProductName = request.getParameter("productName");
	System.out.println("startProductName:"+startProductName);

	if(startProductName==null||startProductName.length()==0){
		startProductName = "����ҵ��";
	}


	String treeType = request.getParameter("treeType");
	System.out.println("treeType:"+treeType);

	if (treeType==null || "".equals(treeType)){
		treeType="R";
	}

	PrintWriter writer = response.getWriter();
	OutputFormat format = new OutputFormat();
	format.setIndent(true);
	format.setNewlines(true);
  format.setEncoding("gb2312");
	XMLWriter output = new XMLWriter(writer,format);
	List list = null;

	int errCode=0;
  String errMsg="";

	if ("R".equals(treeType))///���ڵ�
	{
			String paraAray[] = new String[3];
			paraAray[0] = loginNo ;
			paraAray[1] = "2951" ; 
			paraAray[2] = "1" ;
			//paraAray[3] = "1";
			//paraAray[4] = region;
			//list = impl.callFXService("sProdDirSel",paraAray,"8");
			list = impl.callFXService("sSiDirSel",paraAray,"6");
			//impl.printRetValue();
			errCode=impl.getErrCode();
  		errMsg=impl.getErrMsg();
	}
	else {////չʾ�м����
		String paraAray2[] = new String[3];
		paraAray2[0] = loginNo ;
		paraAray2[1] = "2951" ;
		paraAray2[2] = startProductCode ;
		//paraAray2[3] = startProductCode ;
		//paraAray2[4] = region ;
		//list = impl.callFXService("sProdDirSel",paraAray2,"8");
		list = impl.callFXService("sSiDirSel",paraAray2,"6");
		//impl.printRetValue();
		errCode=impl.getErrCode();
  	errMsg=impl.getErrMsg();
	}

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
	  tmpElm.addAttribute("href", "javascript:clickProd0(\""+"0"+"\",\""+startProductCode.trim()+"\",\""+region.trim()+"\")");
		tmpElm.addAttribute("id", startProductCode);
		map.put(startProductCode, tmpElm);
		System.out.println("----------------------------- startProductCode:"+startProductCode);
		System.out.println("�ӽڵ㳤��:"+((String[][])list.get(3)).length);
		String[][] arrProductCode = (String[][]) list.get(3);	//�ӽڵ�ҵ�����
		String[][] arrProductName = (String[][]) list.get(4);	//�ӽڵ�ҵ������
		String[][] arrRD = (String[][]) list.get(2);					//ҵ������
		//String[][] strFlag = (String[][]) list.get(5);				//releaseFlag|stopFlag  1/0(1Ϊ����) | 1/0(0Ϊ����)*/
		String productCode="";
		String productName="";
		String parentProductCode="";
		String rd = "";
		String rf = "1";
		String sf = "1";
		int num1=0;
		int num2=0;
		System.out.println("��ʼѭ��ȡ�ڵ㣡");
		for (int i = 0; i < arrProductCode.length; i++) {
			productCode=arrProductCode[i][0];
			productName=arrProductName[i][0];
			rd = arrRD[i][0];


			if("D".equals(treeType)){
				parentProductCode=startProductCode;
			}
			if("R".equals(treeType)){
				parentProductCode="1";
			}

			//System.out.println("################productCode="+productCode.trim()+"parentProductCode="+parentProductCode);
		
			Element parentElm = (Element) map.get(parentProductCode);
			if (parentElm == null) {
				throw new Exception("ҵ�����ϱ����ݴ���ҵ���ţ�" + productCode.trim());
			}



			if (!"P".equals(rd)) {
					tmpElm = parentElm.addElement("TreeNode");
					tmpElm.addAttribute("text","["+productCode.trim()+"]"+productName.trim());
					tmpElm.addAttribute("id", productCode.trim());
					map.put(productCode.trim(), tmpElm);
					String url = new StringBuffer("f5110_productXml.jsp?productCode=").append(productCode.trim()).append("&treeType=D&productName=").append(productName.trim()).append("&region="+region).toString();
					tmpElm.addAttribute("Xml", url);
					tmpElm.addAttribute("href", "javascript:clickProd1(\""+parentProductCode.trim()+"\",\""+productCode.trim()+"\",\""+region.trim()+"\",\""+productName.trim()+"\")");
			}
			else{
				/*rf = strFlag[i][0].substring(0,1);//δ����==0
				sf = strFlag[i][0].substring(2,3);//����==0*/
				if ("1".equals(sf)) {
					tmpElm = parentElm.addElement("TreeNode");
					if("1".equals(rf)){
						tmpElm.addAttribute("text","["+productCode.trim()+"]"+productName.trim());
					}
					if("0".equals(rf)){//
						num2++;
						tmpElm.addAttribute("text","["+productCode.trim()+"]"+productName.trim()+"(δ����)");
					}
					
					tmpElm.addAttribute("id", productCode.trim());
					map.put(productCode.trim(), tmpElm);
					tmpElm.addAttribute("href", "javascript:clickProd3(\""+parentProductCode.trim()+"\",\""+productCode.trim()+"\",\""+region.trim()+"\",\""+productName.trim()+"\")");
				}
				if ("0".equals(sf)) {
					num1++;
					tmpElm = parentElm.addElement("TreeNode");
					tmpElm.addAttribute("text","["+productCode.trim()+"]"+productName.trim()+"(�ѹ���)");
					tmpElm.addAttribute("id", productCode.trim());
					map.put(productCode.trim(), tmpElm);
					tmpElm.addAttribute("href", "javascript:clickProd3(\""+parentProductCode.trim()+"\",\""+productCode.trim()+"\",\""+region.trim()+"\",\""+productName.trim()+"\")");
				}
			}
		}

		System.out.println("δ�����ڵ�������"+num1);
		System.out.println("�ѹ��ڽڵ�������"+num2);
		if(arrProductCode.length==0){
			if("D".equals(treeType)){
				parentProductCode=startProductCode;
			}
			if("R".equals(treeType)){
				parentProductCode="1";
			}
			Element parentElm = (Element) map.get(parentProductCode);
			if (parentElm == null) {
				throw new Exception("ҵ�����ϱ����ݴ���ҵ���ţ�" + productCode.trim());
			}

			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text","û���ҵ����ݣ�");
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