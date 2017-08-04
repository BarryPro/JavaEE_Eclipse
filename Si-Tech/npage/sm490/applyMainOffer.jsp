<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
		//----------------申请订购新的基本销售品-----------------------
		String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
		String servId = WtcUtil.repNull(request.getParameter("servId"));
		String offerId = WtcUtil.repNull(request.getParameter("offerId"));
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String workNo = (String)session.getAttribute("workNo");
		/* liujian add workNo and password 2012-4-5 15:59:15 begin */
		String password = (String) session.getAttribute("password");
		/* liujian add workNo and password 2012-4-5 15:59:15 end */
		String opCode = request.getParameter("opCode");
		String groupId = (String)session.getAttribute("groupId");
		String offerattrtype="";
		String SqlStr = "select offer_attr_type  from product_offer where offer_id ='"+offerId+"'";
		/*20120917 gaopeng 新增查询157是否属于TD */
		String sqlstrTD = "select no_type from dcustres where phone_no='"+phoneNo+"'";
		String flagTD="false";
		System.out.println("------diling--------offerId----------------"+offerId);
		/*2015/04/20 10:04:49 gaopeng 关于在CRM增加手机积分兑换宽带产品功能的需求 增加一个入参*/
		String intePrice = request.getParameter("intePrice");
		if(intePrice == null || "".equals(intePrice)){
			intePrice = "NULL";
		}
		
%>
<wtc:utype name="sApplyMainOffer" id="retVal" scope="end">
  <wtc:uparam value="<%=loginAccept%>" type="long"/>
  <wtc:uparam value="<%=servId%>" type="long"/>
  <wtc:uparam value="<%=offerId%>" type="long"/>	
  <wtc:uparam value="<%=workNo%>" type="string"/>
  <wtc:uparam value="<%=opCode%>" type="string"/>
  <wtc:uparam value="<%=phoneNo%>" type="string"/>	
  <wtc:uparam value="<%=groupId%>" type="string"/>	
  <wtc:uparam value="<%=password%>" type="string"/>
  <wtc:uparam value="<%=intePrice%>" type="string"/>						
</wtc:utype>
<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=SqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray1" scope="end"/>	
<wtc:pubselect name="sPubSelect" retcode="retc21" retmsg="retm21" outnum="1">
			<wtc:sql><%=sqlstrTD%></wtc:sql>
</wtc:pubselect>
<wtc:array id="resultTD" scope="end" />
	
<%
System.out.println("offerattrtype==diling============="+offerattrtype);
	if(resultTD.length > 0)
	{
		String no_type = resultTD[0][0];
		if("0000h".equals(no_type)){
				flagTD = "true";
		}
		else
		{
				flagTD = "false";
		}
		
	}
	else
		{
			flagTD = "false";
		}


%>	

<% 
String strArray = CreatePlanerArray.createArray("retArray1",retArray1.length);

	if(retArray1!=null && retArray1.length > 0)
	{
		offerattrtype = retArray1[0][0];
	}
System.out.println("offerattrtype==============="+offerattrtype);
	String retCode1="";
	String retMsg1="";
	String phoneHead=phoneNo.substring(0,3);
	if(opCode.equals("1255")){
		System.out.println("gaopengSeeLog1255======phoneHead====="+phoneHead);
		System.out.println("gaopengSeeLog1255======flagTD====="+flagTD);
		System.out.println("gaopengSeeLog1255======offerattrtype====="+offerattrtype);
		if(((phoneHead.equals("157") && flagTD=="true") || (phoneHead.equals("184") && flagTD=="true")) && !(offerattrtype.equals("YnPT"))){
			retCode1="111111";
			retMsg1="157、184号段TD公话号码的用户只能办理TD固话包年类销售品！";
		}
		else if((!(phoneHead.equals("157") && flagTD=="true") && !(phoneHead.equals("184") && flagTD=="true")) && offerattrtype.equals("YnPT")){
			retCode1="111111";
			retMsg1="只有157、184号段TD公话号码的用户能办理TD固话包年类销售品！";
		}
	  else{
	  	retCode1 = retVal.getValue(0);
			retMsg1  = retVal.getValue(1).replaceAll("\\n"," ");
	  }
	}
	else{
		retCode1 = retVal.getValue(0);
		retMsg1  = retVal.getValue(1).replaceAll("\\n"," ");
	}
	
	System.out.println("-----------sApplyMainOffer----retCode:["+retCode1+"]");
	System.out.println("-----------sApplyMainOffer----retMsg1:["+retMsg1+"]");
	System.out.println("----------------end=--------------");
%>

var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode1%>");
response.data.add("errorMsg","<%=retMsg1%>");
response.data.add("offerId","<%=offerId%>");
core.ajax.receivePacket(response);
