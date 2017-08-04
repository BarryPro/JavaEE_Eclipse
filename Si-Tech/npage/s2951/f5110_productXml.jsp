<%
  /*
   * 功能: 业务目录树
   * 版本: 1.0.0
   * 日期: 2008/04/15
   * 作者: xuls
   * 版权: si-tech
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
//获取session信息
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
		startProductName = "集团业务";
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

	if ("R".equals(treeType))///根节点
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
	else {////展示中间各级
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
		//创建doc
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
		System.out.println("子节点长度:"+((String[][])list.get(3)).length);
		String[][] arrProductCode = (String[][]) list.get(3);	//子节点业务代码
		String[][] arrProductName = (String[][]) list.get(4);	//子节点业务名称
		String[][] arrRD = (String[][]) list.get(2);					//业务属性
		//String[][] strFlag = (String[][]) list.get(5);				//releaseFlag|stopFlag  1/0(1为发布) | 1/0(0为过期)*/
		String productCode="";
		String productName="";
		String parentProductCode="";
		String rd = "";
		String rf = "1";
		String sf = "1";
		int num1=0;
		int num2=0;
		System.out.println("开始循环取节点！");
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
				throw new Exception("业务资料表数据错误！业务编号：" + productCode.trim());
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
				/*rf = strFlag[i][0].substring(0,1);//未发布==0
				sf = strFlag[i][0].substring(2,3);//过期==0*/
				if ("1".equals(sf)) {
					tmpElm = parentElm.addElement("TreeNode");
					if("1".equals(rf)){
						tmpElm.addAttribute("text","["+productCode.trim()+"]"+productName.trim());
					}
					if("0".equals(rf)){//
						num2++;
						tmpElm.addAttribute("text","["+productCode.trim()+"]"+productName.trim()+"(未发布)");
					}
					
					tmpElm.addAttribute("id", productCode.trim());
					map.put(productCode.trim(), tmpElm);
					tmpElm.addAttribute("href", "javascript:clickProd3(\""+parentProductCode.trim()+"\",\""+productCode.trim()+"\",\""+region.trim()+"\",\""+productName.trim()+"\")");
				}
				if ("0".equals(sf)) {
					num1++;
					tmpElm = parentElm.addElement("TreeNode");
					tmpElm.addAttribute("text","["+productCode.trim()+"]"+productName.trim()+"(已过期)");
					tmpElm.addAttribute("id", productCode.trim());
					map.put(productCode.trim(), tmpElm);
					tmpElm.addAttribute("href", "javascript:clickProd3(\""+parentProductCode.trim()+"\",\""+productCode.trim()+"\",\""+region.trim()+"\",\""+productName.trim()+"\")");
				}
			}
		}

		System.out.println("未发布节点数量："+num1);
		System.out.println("已过期节点数量："+num2);
		if(arrProductCode.length==0){
			if("D".equals(treeType)){
				parentProductCode=startProductCode;
			}
			if("R".equals(treeType)){
				parentProductCode="1";
			}
			Element parentElm = (Element) map.get(parentProductCode);
			if (parentElm == null) {
				throw new Exception("业务资料表数据错误！业务编号：" + productCode.trim());
			}

			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text","没有找到数据！");
			tmpElm.addAttribute("id","-1");
			map.put("-1", tmpElm);
		}

		output.write(document);
		output.close();
	}
	else{
		throw new Exception("服务报错！错误代码"+errCode+"！错误信息："+errMsg);
	}
%>