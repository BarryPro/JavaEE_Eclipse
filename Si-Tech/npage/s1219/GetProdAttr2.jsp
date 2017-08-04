<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ taglib uri="/WEB-INF/xsl.tld" prefix="xsl" %>

<%
	System.out.println("<<------------查询产品属性------------>>");
	String verson_title = "<?xml version=\"1.0\" encoding=\"gb2312\"?>";
	String root_element = "<info>";
	String root_element1 = "</info>";
	StringBuffer sb = new StringBuffer(80);
	String servId =WtcUtil.repNull(request.getParameter("servId"));
System.out.println("***********servId====="+servId);	
	String flag =WtcUtil.repNull(request.getParameter("flag"));
	String ProdId =WtcUtil.repNull(request.getParameter("ProdId"));
System.out.println("*************ProdId-======="+ProdId);	
	//ProdId="10288937";
	String[] attrId =null;
	String[] attrVal=null;
	String isNew=request.getParameter("isNew");
System.out.println("====isNew=="+isNew);	
	if(!isNew.equals("1"))//不是新购
	{
%>
<wtc:utype name="sQProdIntAtr" id="retVal1" scope="end" >
	<wtc:uparam value="<%=flag%>" type="int" />
	<wtc:uparam value="<%=servId%>" type="long" />	
</wtc:utype>
<%
System.out.println("111111111111111111");
  	StringBuffer logBuffer = new StringBuffer(80);
		System.out.println(logBuffer.toString());  
		WtcUtil.recursivePrint(retVal1,1,"2",logBuffer);
		String retCode1 = retVal1.getValue(0);
		if(retCode1.equals("0"))
		{
System.out.println("====属性组的数量==="+retVal1.getUtype(2).getSize());	
  	attrVal=new String[retVal1.getUtype(2).getSize()];
  	attrId =new String[retVal1.getUtype(2).getSize()];
  	for(int i=0;i<retVal1.getUtype(2).getSize();i++)
  	{
  		attrVal[i]=retVal1.getValue("2."+i+".4");
  		attrId[i]=retVal1.getValue("2."+i+".3");
System.out.println("产品实例属性值==="+attrVal[i]);  		
  	}
  	}	
  }
%>	
<wtc:utype name="sGetAttrPage" id="retVal" scope="end">
	<wtc:uparam value="1" type="STRING"/>   
	<wtc:uparam value="<%=ProdId %>" type="LONG"/>   
</wtc:utype>

<%
	StringBuffer logBuffer = new StringBuffer(80);
	System.out.println(logBuffer.toString());  
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
  String retCode = retVal.getValue(0);
  sb.append(verson_title).append(root_element);
	if((retCode.equals("0"))){	
System.out.println("=====getSize()====="+retVal.getUtype("2").getSize());	
	if(retVal.getUtype("2").getSize()>0)
	{
		for(int i=0;i<+retVal.getUtype("2").getSize();i++)
		{
			String ss=retVal.getUtype("2."+i).getValue(8).trim();
			String ss2=retVal.getUtype("2."+i).getValue(13).trim();
			if(ss2!=null&&!ss2.equals("")){
			if(ss!=null&&ss.indexOf(ss2+"~")>=0)
			{
				if(ss.substring(ss.indexOf(ss2+"~")).indexOf(",")<0)
				{
					ss2=ss.substring(ss.indexOf(ss2+"~"));
				}else
				{
					ss2=ss.substring(ss.indexOf(ss2+"~"),ss.indexOf(ss2+"~")+ss.substring(ss.indexOf(ss2+"~")).indexOf(","));
				}
				if(ss.indexOf(ss2)+ss2.length()+1<=ss.length())
				{
					ss=ss.substring(0,ss.indexOf(ss2))+ss.substring(ss.indexOf(ss2)+ss2.length()+1);
				}else
				{
					ss=ss.substring(0,ss.indexOf(ss2))+ss.substring(ss.indexOf(ss2)+ss2.length());
				}
			}				
		}		
			sb.append("<field "+"order='"+i+"'"+"  dataType='"+retVal.getUtype("2."+i).getValue(2)+"'>");
			sb.append("<info_code>"+retVal.getUtype("2."+i).getValue(0)+"</info_code>");
			sb.append("<info_name>"+retVal.getUtype("2."+i).getValue(1).trim()+"</info_name>");
			sb.append("<read_only>"+retVal.getUtype("2."+i).getValue(3)+"</read_only>");
			sb.append("<data_length>"+retVal.getUtype("2."+i).getValue(4)+"</data_length>");
			sb.append("<data_preci>"+retVal.getUtype("2."+i).getValue(5)+"</data_preci>");
			sb.append("<data_remark>"+retVal.getUtype("2."+i).getValue(6).trim()+"</data_remark>");
			sb.append("<use_line>"+retVal.getUtype("2."+i).getValue(7)+"</use_line>");
			sb.append("<info_obj>"+ss+"</info_obj>");
			sb.append("<option_flag>"+retVal.getUtype("2."+i).getValue(10).trim()+"</option_flag>");
			sb.append("<doc_flag>"+retVal.getUtype("2."+i).getValue(11).trim()+"</doc_flag>");
			sb.append("<show_length>"+retVal.getUtype("2."+i).getValue(12).trim()+"</show_length>");
			
			if(!isNew.equals("1")&&attrVal!=null)//如果该产品不是新购且有属性值返回
			{
				System.out.println("=========================================================");			
				for(int iAttr=0;iAttr<attrId.length;iAttr++)
				{
				  System.out.println("================================================attrId["+attrId[iAttr]+"]retVal=["+retVal.getUtype("2."+i).getValue(0));					
				  if(attrId[iAttr].equals(retVal.getUtype("2."+i).getValue(0)))
				  {
				  	System.out.println("--------------------------------["+iAttr+"]["+attrVal[iAttr]);
						sb.append("<default_value>"+attrVal[iAttr]+"</default_value>");	
						break;
					}
				}
			}else{
				sb.append("<default_value>"+retVal.getUtype("2."+i).getValue(13).trim()+"</default_value>");	
				}
			sb.append("</field>");
		}
	 }
	}
	sb.append(root_element1);		
	System.out.println("mylog() =="+sb.toString());	 
%>
	<xsl:apply xmlstr="<%=sb.toString()%>" xsl="/npage/public/transTemplate.xsl"/>
