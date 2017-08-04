<%
  /*
   * 功能: 服务类型属性树。
   * 版本: 1.0.0
   * 日期: 2006/12/29
   * 作者: chendx
   * 版权: si-tech
  */
%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%@ page language="java" contentType="text/xml;charset=GBK" %>
<%@ page import ="org.dom4j.Document" %>
<%@ page import ="org.dom4j.io.XMLWriter" %>
<%@ page import ="org.dom4j.io.OutputFormat" %>
<%@ page import ="org.dom4j.*" %>
<%@ page import ="java.io.*" %>
<%@ page import ="java.util.*" %>

<%@ page import ="com.sitech.crmpd.core.wtc.router.RouterClientTemplate" %>
<%@ page import ="com.sitech.crmpd.core.wtc.utype.UType" %>
<%@ page import ="com.sitech.crmpd.core.wtc.utype.UtypeUtil" %>
<%@ page import ="com.sitech.crmpd.core.wtc.utype.UtypeCall" %>
<%@ page import ="com.sitech.crmpd.core.wtc.utype.UElement" %>
<%
System.out.println("<---------------------进入树生成XML------------------------>");
//获取session信息
String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
String group_id  = WtcUtil.repNull((String)session.getAttribute("group_id"));
String flag="N";//是否省级工号
if(group_id.equals("10014"))
{
   flag="Y";
}

String catalog_item_id=WtcUtil.repNull(request.getParameter("catalog_item_id"));
String sm_code=WtcUtil.repNull(request.getParameter("sm_code"));
String motive_type=WtcUtil.repNull(request.getParameter("motive_type"));

String attr_type ="";				//属性类型
String attr_type_name="";	  //属性类型名称
String father_attr_type=""; //

String parentId = "9998";
String catalogDesc = catalog_item_id;    //参数描述
String catalogType = "";                 //参数类型

String isRoot = request.getParameter("isRoot");
if(isRoot==null||isRoot.length()==0){
	isRoot = "false";
}
System.out.println("### isRoot = "+isRoot);
	
//获取根节点
if ("true".equals(isRoot)){
				attr_type = "9998";
				father_attr_type= "9998";
				attr_type_name= "集团销售品目录";
	}else{
	    parentId = WtcUtil.repNull((String)request.getParameter("parent_id"));
	    catalogType = WtcUtil.repNull((String)request.getParameter("item_type"));
	    
	     System.out.println("liubo ### catalogType = "+catalogType);
	    /**************
	     * S:产品类型(catalog_item_id),T:品牌(sm_code),V:业务类型(motive_type)
		 **************/
	    if("S".equals(catalogType)){
	        catalogDesc = catalog_item_id;
	    }else if("T".equals(catalogType)){
	        catalogDesc = sm_code;
	    }else if("V".equals(catalogType)){
	        catalogDesc = motive_type;
	    }else if("W".equals(catalogType)){
	    	  catalogDesc = "";
	    	}
	    
	    System.out.println(" liubo ### catalogDesc = "+catalogDesc);
	    System.out.println("liubo  ### parentId = "+parentId);
	}
		
	//获取父节点
	String startAttrType = request.getParameter("attr_type");
	if(startAttrType==null||startAttrType.length()==0){
		startAttrType = attr_type;
	}
	
	//取父节点名称
	String startAttrTypeName = request.getParameter("attr_type_name");
	if(startAttrTypeName==null||startAttrTypeName.length()==0){
		startAttrTypeName = attr_type_name;
	}
	
	//取子节点类型
	String leaf_flag = request.getParameter("leaf_flag");
	if(leaf_flag==null||leaf_flag.length()==0){
		leaf_flag = "F";
	}
	
	
	PrintWriter writer = response.getWriter();
	OutputFormat format = new OutputFormat();
	format.setIndent(true);
	format.setNewlines(true);
  format.setEncoding("GBK");
	XMLWriter output = new XMLWriter(writer,format);
	List list = null;
	
	Document document = DocumentHelper.createDocument();
	Map map = new HashMap();
	Element tmpElm = null;
	
	if ("true".equals(isRoot)){
			tmpElm = document.addElement("TreeNode").addElement("TreeNode");
	}
	else {
			tmpElm = document.addElement("TreeNode");
	}
	tmpElm.addAttribute("text",startAttrTypeName+"["+startAttrType+"]");
	tmpElm.addAttribute("id", startAttrType);
	map.put(startAttrType, tmpElm);
	
//如果不是叶节点将作为目录
if(leaf_flag.equals("F")){		  
	  //获取子节点	
	  %>
      <wtc:service name="sQGroupCatalog" routerKey="region" routerValue="<%=regionCode%>" outnum="9">
  		<wtc:param   value="<%=catalogDesc%>" />
  		<wtc:param   value="<%=parentId%>"/>
      </wtc:service>
      <wtc:array id="rows1" start="0" length="2" scope="end"/>
      <wtc:array id="rows" start="2" length="7" scope="end"/>
    <%
	    int errCode = Integer.parseInt(retCode);
	    String errMsg = retMsg;
			System.out.println("liubo ###"+errCode);
			System.out.println("liubo ###"+errMsg);
	if(errCode!=0){
		throw new Exception("查询服务属性出错！错误代码"+errCode+"！错误信息："+errMsg);
	}else{	
		String[][] rootList2 = new String[][]{};
		rootList2 = rows;
		System.out.println(" rootList2 本次调用节点数量="+rootList2.length);
		for (int i = 0; i < rootList2.length; i++) {	

          if(i>150)break; 
			    //System.out.println("liubo rootList2["+i+"][5]=="+rows[i][5]);
								
			
			String attr_type2       =rootList2[i][0];        
			String father_attr_type2=rootList2[i][5];                  
			String attr_type_name2  =rootList2[i][2];                   
   
			String	catalog_item_id2		  = rootList2[i][0];   //节点
			String	catalog_item_type2	      = rootList2[i][1];   //节点类型
			String	catalog_item_name2		  = rootList2[i][2];   //节点名称
			String	catalog_item_desc2		  = rootList2[i][3];   //节点描述
			String	band_id2				  = rootList2[i][4];   //品牌id
			String	parent_catalog_item_id2	  = rootList2[i][5];   //父节点id
			String	leaf_flag2	              = rootList2[i][6];   //叶节点标志 F/T(F是目录节点;T是叶子节点)
    	    
			Element parentElm = (Element) map.get(startAttrType);
			if (parentElm == null) {
				throw new Exception("liubo 权限表数据错误！权限编号：" + startAttrType.trim());
			}
			
			System.out.println("liubo leaf_flag2===="+leaf_flag2);
			
			tmpElm = parentElm.addElement("TreeNode");
			tmpElm.addAttribute("text",attr_type_name2.trim()+"["+attr_type2.trim()+"]");
			tmpElm.addAttribute("id", attr_type2.trim());
		
      String itemType = "";
  	  %>
        <wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
    		<wtc:param value="216" />
    		<wtc:param value="<%=catalog_item_id2%>"/>
        </wtc:service>
        <wtc:array id="typeArr" scope="end"/>
      <%
            if("000000".equals(retCode1)){
                itemType = typeArr[0][0];
            }
            //System.out.println("liubo ### itemType = "+itemType);
            
						String	url = "priceModeXml.jsp?item_type="+itemType+"&parent_id="+catalog_item_id2+"&attr_type="+catalog_item_type2.trim()+"&attr_type_name="+catalog_item_name2.trim()+"&leaf_flag="+leaf_flag2.trim()+"&catalog_item_id="+catalog_item_id+"&sm_code="+sm_code+"&motive_type="+motive_type;		  
						tmpElm.addAttribute("Xml", url);	
      }
   		if(rootList2.length==0){
						Element parentElm = (Element) map.get(startAttrType);
						if (parentElm == null) {
							throw new Exception("权限表数据错误！权限编号：" + startAttrType.trim());
						}
						tmpElm = parentElm.addElement("TreeNode");
						tmpElm.addAttribute("text","没有找到数据！");
						tmpElm.addAttribute("id","-1");
						map.put("-1", tmpElm);
		  }
 }
}else{
	      //如果是叶结点从另一个表中查询具体服务
			  map.put(startAttrType, tmpElm);
				UType inUType  = new UType();
				UType TOptrMsg = new  UType();
				TOptrMsg.setUe("STRING", loginNo);
				TOptrMsg.setUe("STRING", flag);
				TOptrMsg.setUe("LONG", parentId);
				TOptrMsg.setUe("STRING", "");
				 
				UElement ue = new UElement();
				ue.setUtype(TOptrMsg);
				ue.setType((char) UtypeUtil.STRUCT);
				inUType.setUe(ue);

				UType retVal = new UType();
				String serverId = RouterClientTemplate.getRouterId("region", regionCode);
	      int inputLen = UtypeUtil.packLen(inUType);
				byte [] inputBytes = new byte[inputLen];
				UtypeUtil.pack(inUType , inputBytes,  -1   );
			   
			  UtypeCall wtcCall = new UtypeCall(); 
	 		  byte[] bytes = wtcCall.callService("sGOfferByCat", serverId ,  inputBytes , inputLen);
		 	  UtypeUtil.parse(retVal , bytes, bytes.length , 0   );		

				String errCode1 = retVal.getValue(0);
				String errMsg1 = retVal.getValue(1).replaceAll("\\n"," "); 
				System.out.println("liubo return from sGOfferByCat -> "+errCode1+ " | " +errMsg1);
				String location = "";
				int retValNum = retVal.getUtype("2").getSize();
				System.out.println("liubo 本次调用节点数量="+retValNum);

  if(retValNum>0){
       for(int k=0;k<retValNum;k++){   
        if(k>150)break;
        
        location = "2."+k;
        String sItemId = retVal.getUtype(location).getValue(0);
        String sItemName = retVal.getUtype(location).getValue(2);     
        String effDate = retVal.getUtype(location).getValue(9); 
        String expDate = retVal.getUtype(location).getValue(10);  
        
       for(int j=0;j<31;j++){ 
            System.out.println(" ###  retVal["+j+"] = "+retVal.getUtype(location).getValue(j));
        }
        System.out.println(" ###  sItemName = "+sItemName);
        
        Element parentElm1 = (Element) map.get(startAttrType);
        if (parentElm1 == null) {
            throw new Exception("权限表数据错误！权限编号：" + sItemName.trim());
        }
        tmpElm = parentElm1.addElement("TreeNode");
        tmpElm.addAttribute("text",sItemName.trim()+"["+sItemId.trim()+"]");
        tmpElm.addAttribute("id", sItemId.trim());
        tmpElm.addAttribute("href","javascript:saveTo(\""+sItemId+"\",\""+sItemName+"\",\""+effDate+"\",\""+expDate+"\")");  
        map.put(sItemId.trim(), tmpElm);
       }
  }else{
			Element parentElm2 = (Element) map.get(startAttrType);
			tmpElm = parentElm2.addElement("TreeNode");
			tmpElm.addAttribute("text","没有找到数据！");
			tmpElm.addAttribute("id","-1");
			map.put("-1", tmpElm);
     }	 	
	}
		output.write(document);
		output.close();

%>