<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%

	System.out.println("------------------ajax_getGoodNo_New.jsp------------------------");
  String workNo = (String)session.getAttribute("workNo");
  //wangzc  add begin
  String flag = "N";//是否省级工号
  String offerCode = WtcUtil.repNull(request.getParameter("offerCode"));//销售品编码
  String offerName = WtcUtil.repNull(request.getParameter("offerName"));//销售品名称
  String offerType = WtcUtil.repNull(request.getParameter("offerType"));
  String offerAttrSeq = WtcUtil.repNull(request.getParameter("offerAttrSeq"));//销售品属性标识
  String custGroupId = WtcUtil.repNull(request.getParameter("custGroupId"));//客户群标识
  String channelSegment = WtcUtil.repNull(request.getParameter("channelSegment"));//渠道类型标识
  String group_id =WtcUtil.repNull(request.getParameter("group_id"));//区域标识
  String band_id =WtcUtil.repNull(request.getParameter("band_id"));//品牌标识
  String offer_att_type =WtcUtil.repNull(request.getParameter("offer_att_type"));//销售品分类标识
  System.out.println("------------------offerCode-----------------"+offerCode);
  System.out.println("------------------offerName-----------------"+offerName);
  System.out.println("------------------offerType-----------------"+offerType);
  System.out.println("------------------offerAttrSeq-----------------"+offerAttrSeq);
  System.out.println("------------------custGroupId-----------------"+custGroupId);
  System.out.println("------------------channelSegment-----------------"+channelSegment);
  System.out.println("------------------group_id-----------------"+group_id);
  System.out.println("------------------band_id-----------------"+band_id);
  System.out.println("------------------offer_att_type-----------------"+offer_att_type);
   //wangzc  add end
  System.out.println("------------------workNo-----------------"+workNo);
  String goodNotype = WtcUtil.repNull(request.getParameter("goodNotype")); 
  System.out.println("------------------goodNotype-----------------"+goodNotype);
  
  String result8 = WtcUtil.repNull(request.getParameter("result8")); 
  System.out.println("------------------result8-----------------"+result8);
  
  String regionCode = (String)session.getAttribute("regCode");
  
  
  
  String sqlInfo="";
  String strArray="var retResult; ";  //must
  String goodTyp=null;
  String regCode=null;
%>
		//wangzc add 将原有188特殊号码资费查询调用的服务改成188普通号码资费查询的服务
		<wtc:utype name="sQGoodNoOffer" id="retVal" scope="end">
	<wtc:uparams name="TOfferMsg" iMaxOccurs="1">
			<wtc:uparam value="<%=workNo%>" type="STRING"/>
			<wtc:uparam value="<%=flag%>" type="STRING"/>
			<wtc:uparam value="<%=offerCode%>" type="STRING"/>
			<wtc:uparam value="<%=offerName%>" type="STRING"/>
			<wtc:uparam value="<%=offerType%>" type="LONG"/>
			<wtc:uparam value="<%=offerAttrSeq%>" type="LONG"/>
			<wtc:uparam value="<%=custGroupId%>" type="LONG"/>
			<wtc:uparam value="<%=channelSegment%>" type="STRING"/>
			<wtc:uparam value="<%=group_id%>" type="LONG"/>
			<wtc:uparam value="<%=band_id%>" type="LONG"/>
			<wtc:uparam value="<%=offer_att_type%>" type="STRING"/>
			<wtc:uparam value="" type="STRING"/>
			<wtc:uparam value="1104" type="STRING"/>
			<wtc:uparam value="<%=goodNotype%>" type="STRING"/>
	</wtc:uparams>
</wtc:utype>
		/*<wtc:utype name="sHLJQOfrByGType" id="retVal" scope="end" >
					<wtc:uparam value="<%=workNo%>" type="STRING"/>
					<wtc:uparam value="<%=goodNotype%>" type="STRING"/>      
					<wtc:uparam value="<%=result8%>" type="LONG"/>    
		</wtc:utype>		*/	
			
<%
	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1).replaceAll("\\n"," "); 
	 
	 String location = "";
	 if(retCode.equals("0"))
	{
  	int retValNum = retVal.getUtype("2").getSize();
		strArray = WtcUtil.createArray("retResult",retValNum);	
		%>
		<%=strArray%>
		<%
		 for(int i=0;i<retValNum;i++)
		 {
			location = "2."+i;
			int n =0;
			for(int j=0;j<32;j++){
			if(j==0||j==2||j==3||j==16||j==17||j==20||j==31){
			    String temp = retVal.getUtype(location).getValue(j);
						if(temp == null || temp.trim().equals(""))
					{
						temp = "";
					}
					
					System.out.println("----------------------------"+i+"|"+j+"------------------------"+temp);
					%>
					retResult[<%=i%>][<%=n%>] = "<%=temp.trim()%>";
					<%
					n++;
					}
			}
	%>			
	<%		
		}	
	}else{
		%>
		retResult=null;
		<%
		retMsg="操作错误，请联系管理员";
		}
%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("retResult",retResult);
core.ajax.receivePacket(response);