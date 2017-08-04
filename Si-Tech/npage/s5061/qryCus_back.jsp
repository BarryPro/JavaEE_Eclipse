<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-16 页面改造,修改样式
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
    
    	String loginNo =  (String)session.getAttribute("workNo");
	String phoneNo = request.getParameter("phoneNo");
	String opCode = request.getParameter("opCode");
	String backAccept = request.getParameter("backAccept");

	String  inputParsm [] = new String[4];
	inputParsm[0] = loginNo;
	inputParsm[1] = phoneNo;
	inputParsm[2] = opCode;
	inputParsm[3] = backAccept;
	
	System.out.println("phoneNO === "+ phoneNo);
	//String [] cussidArr=co.callService("s1449Init",inputParsm,"29","phone",phoneNo);
%>	
	<wtc:service name="s1449Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="29" >
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>		
	</wtc:service>
	<wtc:array id="cussidArr" scope="end"/>
<%
	String retCode= retCode1;
	String retMsg = retMsg1;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);

	
	String idNo = "";
	String smCode = "";
	String smName = "";
	String custName = "";
	String userPassword = ""; 	
	String runCode = "";
	String runName = "";
	String ownerGrade = "";   	
	String gradeName = "";
	String ownerType = "";
	String ownerTypeName = ""; 	
	String custAddr = "";
	String idType = "";
	String idName = "";
	String idIccid = ""; 
	String card_name = "";   	
	String totalOwe = "";  
	String totalPrepay = "";  	
	String firstOweConNo = ""; 	
	String firstOweFee = "";  
	String loginAccept = ""; 
	String orderCode = ""; 
	String orderName = ""; 
	String baseFee = ""; 
	String freeFee = ""; 
	String mon_base_fee = ""; 
	String consume_term = ""; 
	String begin_time = ""; 
	String end_time = ""; 	

	String rpcPage = "qryCus_back";

	if(cussidArr!=null&&cussidArr.length>0)
	{
		idNo = cussidArr[0][0];
		smCode = cussidArr[0][1];
		smName = cussidArr[0][2];
		custName = cussidArr[0][3];
		userPassword = cussidArr[0][4];
		runCode = cussidArr[0][5];
		runName = cussidArr[0][6];
		ownerGrade = cussidArr[0][7];
		gradeName = cussidArr[0][8];
		ownerType = cussidArr[0][9];
		ownerTypeName = cussidArr[0][10];
		custAddr = cussidArr[0][11];
		idType = cussidArr[0][12];
		idName = cussidArr[0][13];
		idIccid = cussidArr[0][14];
		card_name = cussidArr[0][15];
		totalOwe = cussidArr[0][16];
		totalPrepay = cussidArr[0][17];
		System.out.println("1111111111111111"+ totalPrepay);
		firstOweConNo = cussidArr[0][18];
		firstOweFee = cussidArr[0][19];
		loginAccept = cussidArr[0][20];
		orderCode = cussidArr[0][21];
		orderName = cussidArr[0][22];
		baseFee = cussidArr[0][23];
		freeFee = cussidArr[0][24];
		mon_base_fee = cussidArr[0][25];
		consume_term = cussidArr[0][26];
		begin_time = cussidArr[0][27];
		end_time = cussidArr[0][28];
	}
	String cussidStr="";
%>
<%
	/******************new add*********************/
	String regionCode = (String)session.getAttribute("regCode");
	//ArrayList retArray = new ArrayList();
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String[][] resultx = new String[][]{};
	String goodbz="N";
	String modedxpay="";
	String sqlStr = "select mode_dxpay "+
  						 "from dgoodphoneres a, sGoodBillCfg b "+
 						 "where a.bill_code = b.mode_code "+
   						 "and b.region_code = '"+regionCode+"'"+
   						 "and a.phone_no = '"+phoneNo+"' and b.valid_flag='Y' and a.bak_field='1' and end_time>sysdate and b.mode_dxpay>0";
try
        {
        
      	    //retArray = impl.sPubSelect("1",sqlStr); 
      	    %>
      	    	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
			<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
      	    <%      	    	
            		resultx = result;    
			if(resultx!=null&&resultx.length>0)  {        		
				if(resultx[0][0].equals(""))
				{
					goodbz="N";
				}else{
					goodbz="Y";
					modedxpay = resultx[0][0];
					System.out.println("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
					System.out.println(modedxpay);
				}
			}
			
			}catch(Exception e){
			            retCode = "000004";
			            retMsg = "调用服务(spubqry32)失败！";
            
        }
			
	System.out.println("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy++++++++++++++++"+goodbz);
%>
var response = new AJAXPacket();

var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg%>";

var idNo = "<%=idNo%>";
var smCode = "<%=smCode%>";
var smName = "<%=smName%>";
var custName = "<%=custName%>";
var userPassword = "<%=userPassword%>";
var runCode = "<%=runCode%>";
var runName = "<%=runName%>";
var ownerGrade = "<%=ownerGrade%>";
var gradeName = "<%=gradeName%>";
var ownerType = "<%=ownerType%>";
var ownerTypeName = "<%=ownerTypeName%>";
var custAddr = "<%=custAddr%>";
var idType = "<%=idType%>";
var idName = "<%=idName%>";
var idIccid = "<%=idIccid%>";
var card_name = "<%=card_name%>";
var totalOwe = "<%=totalOwe%>";
var totalPrepay = "<%=totalPrepay%>";
var firstOweConNo = "<%=firstOweConNo%>";
var firstOweFee = "<%=firstOweFee%>";
var loginAccept = "<%=loginAccept%>";
var orderCode = "<%=orderCode%>";
var orderName = "<%=orderName%>";
var baseFee = "<%=baseFee%>";
var freeFee = "<%=freeFee%>";
var mon_base_fee = "<%=mon_base_fee%>";
var consume_term = "<%=consume_term%>";
var begin_time = "<%=begin_time%>";
var end_time = "<%=end_time%>";
var goodbz="<%=goodbz%>"
var modedxpay="<%=modedxpay%>"

var rpcPage = "<%=rpcPage%>";

response.data.add("rpc_page",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 
response.data.add("idNo",idNo);
response.data.add("smCode",smCode);
response.data.add("smName",smName);
response.data.add("custName",custName);
response.data.add("userPassword",userPassword);
response.data.add("runCode",runCode);
response.data.add("runName",runName);
response.data.add("ownerGrade",ownerGrade);
response.data.add("gradeName",gradeName);
response.data.add("ownerType",ownerType);
response.data.add("ownerTypeName",ownerTypeName);
response.data.add("custAddr",custAddr);
response.data.add("idType",idType);
response.data.add("idName",idName);
response.data.add("idIccid",idIccid);
response.data.add("card_name",card_name);
response.data.add("totalOwe",totalOwe);
response.data.add("totalPrepay",totalPrepay);
response.data.add("firstOweConNo",firstOweConNo);
response.data.add("firstOweFee",firstOweFee);
response.data.add("loginAccept",loginAccept);
response.data.add("orderCode",orderCode);
response.data.add("orderName",orderName);
response.data.add("baseFee",baseFee);
response.data.add("freeFee",freeFee);
response.data.add("mon_base_fee",mon_base_fee);
response.data.add("consume_term",consume_term);
response.data.add("begin_time",begin_time);
response.data.add("end_time",end_time);
response.data.add("goodbz",goodbz);
response.data.add("modedxpay",modedxpay);
 
core.ajax.receivePacket(response);
