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
		System.out.println("000000000000000000000000000000000000000");
        //得到输入参数
        ArrayList retArray = new ArrayList();
        String return_message="";


        String[][] result = new String[][]{};
 		  //SPubCallSvrImpl impl = new SPubCallSvrImpl();
	    //--------------------------
	    String retType = request.getParameter("retType");
	    String saletype = request.getParameter("saletype");
	    String regionCode = request.getParameter("regionCode");
	    String salecode = request.getParameter("salecode");
	    String phonemoney="",prepay_gift="",cardvalue="";
	    String cardmoney="",cardshould="",cardy="",vspec_name="",vmode_code="",vused_date="",vspec_fee="",vcard_type="";


      int inputNumber = 3;
			String   outputNumber = "13";
			//String  inputParsm [] = new String[inputNumber];

			//inputParsm[0] = saletype;
			//inputParsm[1] = regionCode;
			//inputParsm[2] = salecode;
			//System.out.println(salecode);
  		//String [] initBack = impl.callService("sGetCard",inputParsm,outputNumber,"region",regionCode);
    	//int return_code = impl.getErrCode();
    	//System.out.println(return_code);
%>
			<wtc:service name="sGetCard" routerKey="region" routerValue="<%=regionCode%>"  retcode="return_code" retmsg="retMsg" outnum="<%=outputNumber%>">
				<wtc:param  value="<%=saletype%>"/>
				<wtc:param  value="<%=regionCode%>"/>
				<wtc:param  value="<%=salecode%>"/>
			</wtc:service>
			<wtc:array id="initBack" scope="end" />
<%
    	if(!return_code.equals("000000")&&!return_code.equals("0")){
    			return_code = "2";
          return_message = "取营销明细信息失败！";
        }else{
        	 System.out.println("调用服务sPubSelect in f1141_getcardrpc.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
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
        	System.out.println(phonemoney);System.out.println(prepay_gift);System.out.println(cardvalue);
        	System.out.println(cardy);
        }

     /*   try{
		String sqlStr4 = "select trim(function_name)||' '||to_char(function_fee,'9999.99') from sfunclist  "+
		"  where region_code = '"+regionCode+"' and function_code in ("+funcstr+") and function_name like '%来%' and sm_code='"+smcode+"'";

		retArray = impl.sPubSelect("1",sqlStr4);
		result = (String[][])retArray.get(0);
		int recordNum2 = result.length;
      		for(int k=0;k<recordNum2;k++){
      			re_funcstr=re_funcstr+result[k][0]+"元";

      			System.out.print(re_funcstr);
		}
	}catch(Exception e){
            ret_code = "000002";
            ret_message = "取来显说明失败！";

        }
        */
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

core.ajax.receivePacket(response);

