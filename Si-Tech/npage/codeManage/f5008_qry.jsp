<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
  String regionCode= (String)session.getAttribute("regCode");
  String disCode = request.getParameter("disCode");
  String choPhoneType = request.getParameter("choPhoneType");
  String sqls ="select to_char(INTEREST_RATE),to_char(INSURANCE_FEE), to_char(TEST_FEE),to_char(CONTRACT_HAND),to_char( LOCK_MONTH),ownpsw,to_char(ID_NUM),to_char(ASSURE_NUM),to_char(DEAD_DELAY_RATE),dead_delay_begin,check_flag, to_char(NOUSER_DAY),to_char(NOUSER_MONEY),to_char(PREDEL_MONTH),to_char(PREDEL_DEPOSIT),to_char(INNET_PREDEL_MONTHS),GOOD_TYPE from sBaseCodegood where region_code='"+ regionCode +"' and district_code='"+disCode+"' and good_type='"+choPhoneType+"' ";
  String INTEREST_RATE="";
  String INSURANCE_FEE="";
  String TEST_FEE="";
  String CONTRACT_HAND="";
  String LOCK_MONTH="";
  String ownpsw="";
  String ID_NUM="";
  String ASSURE_NUM="";
  String DEAD_DELAY_RATE="";
  String dead_delay_begin="";
  String check_flag="";
  String NOUSER_DAY="";
  String NOUSER_MONEY="";
  String PREDEL_MONTH="";
  String PREDEL_DEPOSIT="";
  String INNET_PREDEL_MONTHS="";
%> 
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode" retmsg="RetMsg" outnum="16">
	<wtc:sql><%=sqls%></wtc:sql>
</wtc:pubselect>
<wtc:array id="baseCodeDetailData" scope="end" />
	<%if("000000".equals(RetCode) && baseCodeDetailData.length>0) {
			INTEREST_RATE=baseCodeDetailData[0][0];
			INSURANCE_FEE=baseCodeDetailData[0][1];
			TEST_FEE=baseCodeDetailData[0][2];
			CONTRACT_HAND=baseCodeDetailData[0][3];
			LOCK_MONTH=baseCodeDetailData[0][4];
			ownpsw=baseCodeDetailData[0][5];
			ID_NUM=baseCodeDetailData[0][6];
			ASSURE_NUM=baseCodeDetailData[0][7];
			DEAD_DELAY_RATE=baseCodeDetailData[0][8];
			dead_delay_begin=baseCodeDetailData[0][9];
			check_flag=baseCodeDetailData[0][10];
			NOUSER_DAY=baseCodeDetailData[0][11];
			NOUSER_MONEY=baseCodeDetailData[0][12];
			PREDEL_MONTH=baseCodeDetailData[0][13];
			PREDEL_DEPOSIT=baseCodeDetailData[0][14];
			INNET_PREDEL_MONTHS=baseCodeDetailData[0][15];
	}
	%>
		var response = new AJAXPacket();

	response.data.add("retcode","<%= RetCode %>");
	response.data.add("retmsg","<%= RetMsg %>");
	response.data.add("INTEREST_RATE","<%=INTEREST_RATE%>");
	response.data.add("INSURANCE_FEE","<%=INSURANCE_FEE%>");
	response.data.add("TEST_FEE","<%=TEST_FEE%>");
	response.data.add("CONTRACT_HAND","<%=CONTRACT_HAND%>");
	response.data.add("LOCK_MONTH","<%=LOCK_MONTH%>");
	response.data.add("ownpsw","<%=ownpsw%>");
	response.data.add("ID_NUM","<%=ID_NUM%>");
	response.data.add("ASSURE_NUM","<%=ASSURE_NUM%>");
	response.data.add("DEAD_DELAY_RATE","<%=DEAD_DELAY_RATE%>");
	response.data.add("dead_delay_begin","<%=dead_delay_begin%>");
	response.data.add("check_flag","<%=check_flag%>");
	response.data.add("NOUSER_DAY","<%=NOUSER_DAY%>");
	response.data.add("NOUSER_MONEY","<%=NOUSER_MONEY%>");
	response.data.add("PREDEL_MONTH","<%=PREDEL_MONTH%>");
	response.data.add("PREDEL_DEPOSIT","<%=PREDEL_DEPOSIT%>");
	response.data.add("INNET_PREDEL_MONTHS","<%=INNET_PREDEL_MONTHS%>");

	
	core.ajax.receivePacket(response);