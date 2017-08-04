<%@page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
/*
* 功能: 宽带小区资源信息查询
* 版本: 1.0
* 日期: 2010-11-2
* 作者: lijy
* 版权: sitech
*/
%>
<%
	String addrCode = request.getParameter("addrCode")==null?"":request.getParameter("addrCode");
	String productTYPE = request.getParameter("productType")==null?"":request.getParameter("productType");
	String enterType = request.getParameter("enterType")==null?"":request.getParameter("enterType");
	String bandWidth = request.getParameter("bandWidth")==null?"":request.getParameter("bandWidth");
	//String flag= request.getParameter("flag")==null?"":request.getParameter("flag");
	String opName="小区资源查询";
	String areaResourceFlag="0";//是否查询到资源的标志，0表示未查询到，1表示查询成功
	System.out.println("=========资源查询服务的调用========");
	System.out.println("入参如下");
	System.out.println("addrCode========"+addrCode);
	System.out.println("productTYPE========"+productTYPE);
	System.out.println("enterType========"+enterType);
	System.out.println("bandWidth========"+bandWidth);
  String iMsg="FIELDCHNAME=小区地址|产品类型|接入类型|用户带宽,FIELDENNAME=distAddress|productType|inType|userBandwidth,FIELDCONTENT="+addrCode+"|"+productTYPE+"|"+enterType+"|"+bandWidth;
%>
<wtc:service name="sGAreaResource" routerKey="region"   retcode="retcode" retmsg="retmsg"  outnum="2" >
		<wtc:param value="<%=iMsg%>"/>   	 	
</wtc:service>	
<wtc:array id="result"  scope="end"/>
<%
System.out.println("retcode======="+retcode);
System.out.println("retmsg======="+retmsg);
if(retcode.equals("000000")){
	System.out.println("ajax_getIdleResource.jsp  result======="+result[0][0]);
}
 //retcode="000000";
//retmsg="成功";
//result[0][0]="fieldChName=设备类型%设备编码%型号%厂家%IP地址%设备安装地址%端口编号%端口类型%电信局编码#设备类型%设备编码%型号%厂家%IP地址%设备安装地址%端口编号%端口类型#%电信局编码设备类型%设备编码%型号%厂家%IP地址%设备安装地址%端口编号%端口类型%电信局编码#设备类型%设备编码%型号%厂家%IP地址%设备安装地址%端口编号%端口类型#设备类型%设备编码%型号%厂家%IP地址%设备安装地址%端口编号%端口类型%电信局编码,fieldEnName=deviceType%deviceCode%model%factory%ipAddress%deviceInAddress%portCode%portType%icctCode#deviceType%deviceCode%model%factory%ipAddress%deviceInAddress%portCode%portType%icctCode#deviceType%deviceCode%model%factory%ipAddress%deviceInAddress%portCode%portType%icctCode#deviceType%deviceCode%model%factory%ipAddress%deviceInAddress%portCode%portType%icctCode#deviceType%deviceCode%model%factory%ipAddress%deviceInAddress%portCode%portType%icctCode,fieldContent=ONU%NN608A-GPON01-ONU004-HW-HG850%HG850%华为%%黑龙江七台河勃利县勃利区园湖南路七台河移动公司%NN608A-GPON01-ONU007-HW-HG850-04%电口%001#ONU%NN608A-GPON01-ONU004-HW-HG850%HG850%华为%%黑龙江七台河勃利县勃利区园湖南路七台河移动公司%NN608A-GPON01-ONU008-HW-HG850-01%电口%002#ONU%NN608A-GPON01-ONU004-HW-HG850%HG850%华为%%黑龙江七台河勃利县勃利区园湖南路七台河移动公司%NN608A-GPON01-ONU008-HW-HG850-02%电口%003#ONU%NN608A-GPON01-ONU004-HW-HG850%HG850%华为%%黑龙江七台河勃利县勃利区园湖南路七台河移动公司%NN608A-GPON01-ONU008-HW-HG850-03%电口%004#ONU%NN608A-GPON01-ONU004-HW-HG850%HG850%华为%%黑龙江七台河勃利县勃利区园湖南路七台河移动公司%NN608A-GPON01-ONU008-HW-HG850-04%电口%005";
 
if(retcode.equals("000000")){
%>

var response = new AJAXPacket();
var returnCode= "<%=retcode%>";
var returnMsg="<%=retmsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
response.data.add("result","<%=result[0][0]%>");
core.ajax.receivePacket(response);
<%
}else{
%>
var response = new AJAXPacket();
var returnCode= "<%=retcode%>";
var returnMsg="<%=retmsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
core.ajax.receivePacket(response);
<%}%>



