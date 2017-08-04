<%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
/*
* 功能: 装机信息查询
* 版本: 1.0
* 日期: 2015-05-23
* 作者: lijy
* 版权: sitech
*/
%>

<%
	System.out.println("==============进入小区查询=============== ");
	String kuandaiNum = request.getParameter("kuandaiNum")==null?"":request.getParameter("kuandaiNum");
//	String regionName=request.getParameter("regionName")==null?"":request.getParameter("regionName");
	String smCode=request.getParameter("smCode")==null?"":request.getParameter("smCode");
	String iBusiType = "02";
	String iObjectType = request.getParameter("iObjectType");
	
//	System.out.println("regionName=============== "+regionName);
	System.out.println("smCode=============== "+smCode);
	
	String opName="IMS资源查询";
	String iMsg="FIELDCHNAME=产品关键字|产品类型,FIELDENNAME=productCode|productType,FIELDCONTENT="+kuandaiNum+"|12";
  
 // System.out.println("gaopengSeeLog==== 111=============== "+regionName);
  String result1="";
%>
<wtc:service name="sGetJZAreaInfo" routerKey="region"   retcode="retcode" retmsg="retmsg"  outnum="17" >
	<wtc:param value="<%=iMsg%>"/>
	<wtc:param value="<%=kuandaiNum%>"/>
	<wtc:param value="<%=iBusiType%>"/>
	<wtc:param value="<%=iObjectType%>"/>
</wtc:service>	
<wtc:array id="result"  scope="end"/>
<%
	System.out.println("gaopengSeeLog==== retcode======"+retcode);
	System.out.println("retMsg======"+retmsg);
	
	//retcode="000000";
	//result[0][0]="fieldChName=小区名称%小区编码%所属市/县%带宽%接入类型#小区名称%小区编码%所属市/县%带宽%接入类型#小区名称%小区编码%所属市/县%带宽%接入类型#小区名称%小区编码%所属市/县%带宽%接入类型,fieldEnName=distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType,fieldContent=七台河移动公司%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16c9c029a%七台河/勃利县%100M%1#七台河宏伟小区%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16e8702a2%七台河/勃利县%100M%2#七台河勃利小区%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16d92029e%七台河/勃利县%100M%1#七台河卫星小区%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16f8702a6%七台河/勃利县%100M%0";
	//result[0][0]="fieldChName=小区名称%小区编码%接入类型%电信局编码%合作方编码#小区名称%小区编码%接入类型%电信局编码%合作方编码,fieldEnName=distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType#distName%distCode%belongArea%bandWidth%connectType,fieldContent=七台河/勃利县%T_SPACE_STANDARD_ADDRESS-8aee349d336479490133685be629140c%0%80045%paers#七台河/勃利县/七台河宏伟小区%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16e8702a2%2%00113%par02#七台河/勃利县/七台河勃利小区%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16d92029e%3%00114%par03#七台河/勃利县/七台河卫星小区%T_SPACE_STANDARD_ADDRESS-8aee349d2d1be04d012d1cd16f8702a6%0%00115%par04";
if(retcode.equals("000000")){
	
	for(int i=0;i<result.length;i++){
		for(int j=0;j<result[i].length;j++){
			System.out.println("liangyl======"+result[i][j]);
		}
	}
	
//	var retInfo1="4%"+area_name+"|"+area_code+"|"+areaAddr+"|"+bandWidth+"|"+enter_type+"|"+addrCode+"|"+addrContent;
//	var retInfo2="|"+deviceType+"|"+deviceCode+"|"+model+"|"+factory+"|"+ipAddress+"|"+deviceInAddress+"|"+portType+"|"+portCode+"|"+cctId+"|"+partnerCode+"|"+belongCategory+"|"+bearType+"|"+propertyUnit+"|"+distKdCode+"|"+nearInfo;
//	var retInfo=retInfo1+retInfo2;
/* String AccessType = result[0][1];
	String AccessTypeShow="";
	if(AccessType.equals("1")){
    	AccessTypeShow = "XDSL";
    }else if(AccessType.equals("2")){
    	AccessTypeShow = "FTTH";
    }else if(AccessType.equals("3")){
    	AccessTypeShow = "FTTB";
    }else if(AccessType.equals("4")){
    	AccessTypeShow = "CABLE";
    }else if(AccessType.equals("5")){
    	AccessTypeShow = "WBS";
    }else{
    	AccessTypeShow = "其他";
    } */
    /* String BelongCategory = result[0][12];
	String BelongCategoryShow="";
	if(BelongCategory.equals("0")){
		BelongCategoryShow = "城市";
    }else if(BelongCategory.equals("1")){
    	BelongCategoryShow = "农村";
    } */
    /* String BearType = result[0][13];
	String BearTypeShow="";
	if(BearType.equals("0")){
		BearTypeShow = "有线";
    }else if(BearType.equals("1")){
    	BearTypeShow = "无线";
    } */
    
    /*  String propertyUnit = result[0][16];
    String propertyUnitShowText = "";
  	if(propertyUnit.equals("1")){
  		propertyUnitShowText = "移动自建";
  	}else if(propertyUnit.equals("2")){
  		propertyUnitShowText = "移动合建";
  	}else if(propertyUnit.equals("3")){
  		propertyUnitShowText = "省广电";
  	}else if(propertyUnit.equals("4")){
  		propertyUnitShowText = "哈广电";
  	}else if(propertyUnit.equals("5")){
  		propertyUnitShowText = "铁通";
  	}else if(propertyUnit.equals("6")){
  		propertyUnitShowText = "三方";
  	} */
  	
  	/* String NearInfo = result[0][15];
	String NearInfoShow="";
	if(NearInfo.equals("0")){
		NearInfoShow = "垄断";
    }else if(NearInfo.equals("1")){
    	NearInfoShow = "竞争";
    } */
    System.out.println("liangyl+++++++++++++++++++++++++++++++++++++++"+result[0][0]);
	result1+="4%|";
	result1+=result[0][6]+"|";
	result1+=result[0][7]+"|";
	result1+=result[0][8]+"|";
	result1+=result[0][1]+"|";
	result1+="|";
	result1+=result[0][8]+"|";
	result1+="|";
	result1+="|";
	result1+="|";
	result1+="|";
	result1+="|";
	result1+="|";
	result1+="|";
	result1+="|";
	result1+=result[0][4]+"|";//电信局代码
	
	result1+=result[0][11]+"|";//合作方编码
	
	result1+=result[0][12]+"|";//归属类型
	
	result1+=result[0][13]+"|";//承载方式
	
	result1+=result[0][16]+"|";//小区建设性质
	
	result1+=result[0][14]+"|";//小区编码
	
	
	result1+=result[0][15]+"|";//小区接入情况
	
	result1+=kuandaiNum+"|";//宽带账号
	String return00 = result[0][0].split("fieldContent=")[1];
	System.out.println("liangyl+++++++++++++++++++++++++++++++++++++++"+return00.split("%")[5]);
	result1+=return00.split("%")[5]+"|";//区县
	
%>
var response = new AJAXPacket();
var returnCode= "<%=retcode%>";
var returnMsg="<%=retmsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMsg);
response.data.add("result","<%=result[0][0]%>");
response.data.add("result1","<%=result1%>");
core.ajax.receivePacket(response);
<%}else{%>
	var response = new AJAXPacket();
	var returnCode= "<%=retcode%>";
	var returnMsg="<%=retmsg%>";
	response.data.add("retCode",returnCode);
	response.data.add("retMessage",returnMsg);
	core.ajax.receivePacket(response);
<%}%>
