<%
  /*
   * ����: ����������������
   * �汾: 1.0.0
   * ����: 2006/12/29
   * ����: liubo
   * ��Ȩ: si-tech
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
System.out.println("<---------------------����������XML------------------------>");
//��ȡsession��Ϣ
String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
String group_id  = WtcUtil.repNull((String)session.getAttribute("group_id"));
String flag="N";//�Ƿ�ʡ������
if(group_id.equals("10014"))
{
   flag="Y";
}

String ProdType=WtcUtil.repNull(request.getParameter("ProdType"));
String sm_code=WtcUtil.repNull(request.getParameter("sm_code"));
String prod_direct=WtcUtil.repNull(request.getParameter("prod_direct"));
String biz_code=WtcUtil.repNull(request.getParameter("biz_code"));

String attr_type ="";				//��������
String attr_type_name="";	  //������������
String father_attr_type=""; //

String parentId = "9998";
String catalogDesc = ProdType;    //��������
String catalogType = "";    //��������

String isRoot = request.getParameter("isRoot");
if(isRoot==null||isRoot.length()==0){
	isRoot = "false";
}
System.out.println("### isRoot = "+isRoot);
	
//��ȡ���ڵ�
if ("true".equals(isRoot)){
				attr_type = "9998";
				father_attr_type= "9998";
				attr_type_name= "����ƷĿ¼";
	}else{
	    parentId = WtcUtil.repNull((String)request.getParameter("parent_id"));
	    catalogType = WtcUtil.repNull((String)request.getParameter("item_type"));
	    /**************
		 * S:��Ʒ����(ProdType),T:Ʒ��(sm_code),V:ҵ������(prod_direct),W:ҵ�����(biz_code).
		 **************/
		 System.out.println("##################3  catalogType == "+catalogType);
		 System.out.println("#################    prod_direct == "+prod_direct);
	    if("S".equals(catalogType)){
	        catalogDesc = ProdType;
	    }else if("T".equals(catalogType)){
	        catalogDesc = sm_code;
	    }else if("V".equals(catalogType)){
	        catalogDesc = prod_direct;
	    }else if("W".equals(catalogType)){
	        catalogDesc = biz_code;
	    }
	    System.out.println("### catalogDesc = "+catalogDesc);
	    System.out.println("### parentId = "+parentId);
	}
		
	//��ȡ���ڵ�
	String startAttrType = request.getParameter("attr_type");
	if(startAttrType==null||startAttrType.length()==0){
		startAttrType = attr_type;
	}
	
	//ȡ���ڵ�����
	String startAttrTypeName = request.getParameter("attr_type_name");
	if(startAttrTypeName==null||startAttrTypeName.length()==0){
		startAttrTypeName = attr_type_name;
	}
	
	//ȡ�ӽڵ�����
	String leaf_flag = request.getParameter("leaf_flag");
	if(leaf_flag==null||leaf_flag.length()==0){
		leaf_flag = "F";
	}
	
	System.out.println("ProdType=="+ ProdType);
	System.out.println("sm_code=="+ sm_code);
	System.out.println("prod_direct=="+ prod_direct);
	System.out.println("biz_code=="+ biz_code);
	System.out.println("parentId=="+ parentId);
	System.out.println("startAttrType=="+ startAttrType);
	
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
	System.out.println("##########    catalogDesc = "+catalogDesc);
	System.out.println("##########    parentId = "+parentId);
//�������Ҷ�ڵ㽫��ΪĿ¼
if(leaf_flag.equals("F")){		  
	  //��ȡ�ӽڵ�	
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
		throw new Exception("��ѯ�������Գ����������"+errCode+"��������Ϣ��"+errMsg);
	}else{	
		String[][] rootList2 = new String[][]{};
		rootList2 = rows;
		System.out.println("liubo rootList2 ���ε��ýڵ�����="+rootList2.length);
		for (int i = 0; i < rootList2.length; i++) {	

          if(i>150)break;
          
			    //System.out.println("liubo rootList2["+i+"][5]=="+rows[i][5]);
								
			
			String attr_type2       =rootList2[i][0];        
			String father_attr_type2=rootList2[i][5];                  
			String attr_type_name2  =rootList2[i][2];                   
   
			String	catalog_item_id2		    = rootList2[i][0];   //�ڵ�
			String	catalog_item_type2	  	= rootList2[i][1];   //�ڵ�����
			System.out.println("############ catalog_item_type2 === "+catalog_item_type2);
			String	catalog_item_name2		  = rootList2[i][2];   //�ڵ�����
			String	catalog_item_desc2		  = rootList2[i][3];   //�ڵ�����
			String	band_id2				        = rootList2[i][4];   //Ʒ��id
			String	parent_catalog_item_id2	= rootList2[i][5];   //���ڵ�id
			String	leaf_flag2	            = rootList2[i][6];   //Ҷ�ڵ��־ F/T(F��Ŀ¼�ڵ�;T��Ҷ�ӽڵ�)
    	    
			Element parentElm = (Element) map.get(startAttrType);
			if (parentElm == null) {
				throw new Exception("liubo Ȩ�ޱ����ݴ���Ȩ�ޱ�ţ�" + startAttrType.trim());
			}
			
			//System.out.println("attr_type2===="+attr_type2);
			
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
						String	url = "bizModeXml.jsp?item_type="+itemType+"&parent_id="+catalog_item_id2+"&attr_type="+catalog_item_type2.trim()+"&attr_type_name="+catalog_item_name2.trim()+"&leaf_flag="+leaf_flag2.trim()+"&ProdType="+ProdType+"&sm_code="+sm_code+"&prod_direct="+prod_direct+"&biz_code="+biz_code;		  
						tmpElm.addAttribute("Xml", url);	
      }
   		if(rootList2.length==0){
						Element parentElm = (Element) map.get(startAttrType);
						if (parentElm == null) {
							throw new Exception("Ȩ�ޱ����ݴ���Ȩ�ޱ�ţ�" + startAttrType.trim());
						}
						tmpElm = parentElm.addElement("TreeNode");
						tmpElm.addAttribute("text","û���ҵ����ݣ�");
						tmpElm.addAttribute("id","-1");
						map.put("-1", tmpElm);
		  }
 }
}else{
	      //�����Ҷ������һ�����в�ѯ�������
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
				System.out.println("liubo # return from sGOfferByCat -> "+errCode1+ " | " +errMsg1);
				String location = "";
				int retValNum = retVal.getUtype("2").getSize();
				System.out.println("liubo ���ε��ýڵ�����="+retValNum);

  if(retValNum>0){
       for(int k=0;k<retValNum;k++){   
        if(k>150)break;
        
        location = "2."+k;
        String sItemId = retVal.getUtype(location).getValue(0);
        String sItemName = retVal.getUtype(location).getValue(2);        
        System.out.println("liubo ###  sItemId = "+sItemId);
        System.out.println("liubo ###  sItemName = "+sItemName);
        
        Element parentElm1 = (Element) map.get(startAttrType);
        if (parentElm1 == null) {
            throw new Exception("liubo Ȩ�ޱ����ݴ���Ȩ�ޱ�ţ�" + sItemName.trim());
        }
        tmpElm = parentElm1.addElement("TreeNode");
        tmpElm.addAttribute("text",sItemName.trim()+"["+sItemId.trim()+"]");
        tmpElm.addAttribute("id", sItemId.trim());
        tmpElm.addAttribute("href","javascript:saveTo(\""+sItemId+"\",\""+sItemName+"\",\""+parentId+"\")");  
        map.put(sItemId.trim(), tmpElm);
       }
  }else{
		    Element parentElm2 = (Element) map.get(startAttrType);
		    tmpElm = parentElm2.addElement("TreeNode");
		    tmpElm.addAttribute("text","û���ҵ����ݣ�");
			  tmpElm.addAttribute("id","-1");
			  map.put("-1", tmpElm);
     }	 	
	}
		output.write(document);
		output.close();

%>