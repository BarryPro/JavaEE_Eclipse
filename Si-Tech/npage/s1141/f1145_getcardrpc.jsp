<%
/********************
 version v2.0
开发商: si-tech
update:yanpx@2008-10-08
********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("0--f1145_getcardrpc.jsp-----000000000000000000000000000");
        //得到输入参数
        ArrayList retArray = new ArrayList();
        String return_message="";
        String[][] result = new String[][]{};
	    String retType = request.getParameter("retType");
	    String saletype = request.getParameter("saletype");
	    String regionCode = request.getParameter("regionCode");
	    String salecode = request.getParameter("salecode");
	    String bindType = request.getParameter("bindType");
	    System.out.println("---liyan bindType="+bindType);
	    String phonemoney="",prepay_gift="",cardvalue="";
	    String cardmoney="",cardshould="",cardy="",vspec_name="",vmode_code="",vused_date="",vspec_fee="",vcard_type="",vnet_fee="",vphone_fee="",vsale_price="",vprepay_gift="";
		String outputNumber = "17";
      	int inputNumber = 4;
      	System.out.println(" ---regionCode=-"+regionCode );
%>
			<wtc:service name="sGetCard_1145" routerKey="region" routerValue="<%=regionCode%>"  retcode="return_code" retmsg="retMsg" outnum="<%=outputNumber%>">
				<wtc:param  value="<%=saletype%>"/>
				<wtc:param  value="<%=regionCode%>"/>
				<wtc:param  value="<%=salecode%>"/>
				<wtc:param  value="<%=bindType%>"/>
			</wtc:service>
			<wtc:array id="initBack" scope="end" />
<%
    	if(!return_code.equals("000000")&&!return_code.equals("0")){
    			return_code = "2";
          return_message = "取营销明细信息失败！";
        }else{
        	 System.out.println("调用服务sPubSelect in f1145_getcardrpc.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
        	 phonemoney=initBack[0][2];
        	 prepay_gift=initBack[0][3];
        	 cardvalue=initBack[0][4];
        	 cardmoney=initBack[0][5];
        	 cardshould=initBack[0][6];
        	 cardy=initBack[0][7];
        	 vspec_name=initBack[0][8];
        	 vmode_code=initBack[0][9];
        	 vused_date=initBack[0][10];
        	 vspec_fee=initBack[0][11];
        	 vcard_type=initBack[0][12];
        	 vnet_fee=initBack[0][13];
        	 vphone_fee=initBack[0][14];
        	 vsale_price=initBack[0][15];
        	 vprepay_gift=initBack[0][16];
        	System.out.println(phonemoney);
        	System.out.println(prepay_gift);
        	System.out.println(cardvalue);
        	System.out.println(cardy);
        }
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var phonemoney = "";
var prepay_gift="";
var cardvalue=""
var cardmoney="";
var cardshould="";
var cardy="";
var vspec_name="";
var vmode_code="";
var vused_date="";
var vspec_fee="";
var vcard_type="";
var vnet_fee="";
var vphone_fee="";
var vsale_price="";
var vprepay_gift="";

retType = "<%=retType%>";
retCode = "<%=return_code%>";
retMessage = "<%=return_message%>";
phonemoney = "<%=phonemoney%>";
prepay_gift="<%=prepay_gift%>";
cardvalue="<%=cardvalue%>";
cardmoney="<%=cardmoney%>";
cardshould="<%=cardshould%>";
cardy="<%=cardy%>";
vspec_name="<%=vspec_name%>";
vmode_code="<%=vmode_code%>";
vused_date="<%=vused_date%>";
vspec_fee="<%=vspec_fee%>";
vcard_type="<%=vcard_type%>";
vnet_fee="<%=vnet_fee%>";
vphone_fee="<%=vphone_fee%>";
vprepay_gift="<%=vprepay_gift%>";
vsale_price="<%=vsale_price%>";

response.guid = '<%=request.getParameter("guid") %>';
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("phonemoney",phonemoney);
response.data.add("prepay_gift",prepay_gift);
response.data.add("cardvalue",cardvalue);
response.data.add("cardmoney",cardmoney);
response.data.add("cardshould",cardshould);
response.data.add("cardy",cardy);
response.data.add("vspec_name",vspec_name);
response.data.add("vmode_code",vmode_code);
response.data.add("vused_date",vused_date);
response.data.add("vspec_fee",vspec_fee);
response.data.add("vcard_type",vcard_type);
response.data.add("vnet_fee",vnet_fee);
response.data.add("vphone_fee",vphone_fee);
response.data.add("vprepay_gift",vprepay_gift);
response.data.add("vsale_price",vsale_price);


core.ajax.receivePacket(response);

