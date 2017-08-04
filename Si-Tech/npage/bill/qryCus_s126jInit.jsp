<%
/********************
 version v2.0
开发商 si-tech
update hejw@2009-1-8
********************/
%>


<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
    //ArrayList arrSession2 = (ArrayList)session.getAttribute("allArr");
	  //String[][] baseInfoSession2 = (String[][])arrSession2.get(0);
	  
    String loginNo = (String)session.getAttribute("workNo");
  	
  	/* liujian 安全加固修改 2012-4-6 16:18:13 begin */
		String op_strong_pwd = (String) session.getAttribute("password");
	  /* liujian 安全加固修改 2012-4-6 16:18:13 end */
	  
  //ArrayList retList = new ArrayList();
  //String[][] tempArr= new String[][]{};

  String retFlag="",retMsg="";  
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
  String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";

	
	String iPhoneNo = request.getParameter("iPhoneNo");
	String iLoginNo = request.getParameter("iLoginNo");
	String iOrgCode = request.getParameter("iOrgCode");
	String iOpCode = request.getParameter("iOpCode");
  String regionCode=(String)session.getAttribute("regCode");

  /*  ArrayList retArray = new ArrayList();
    String[][] result = new String[][]{};
    SPubCallSvrImpl callView = new SPubCallSvrImpl();
	
  	String retResult = "";
    String sqlStr = "";

    sqlStr = "select current_point from dmarkmsg a,dcustmsg b where a.id_no=b.id_no and b.phone_no='" + iPhoneNo + "'";
    retArray = callView.sPubSelect("1",sqlStr);
					
    result = (String[][])retArray.get(0);
    String curpoint = (result[0][0]).trim();
    
    */
    		String[] paramIn = new String[2]; 
    		paramIn[0] = " select current_point from dmarkmsg a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:iPhoneNo ";
    		paramIn[1] = "iPhoneNo="+iPhoneNo;		
%>
    
    <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramIn[0]%>" />
			<wtc:param value="<%=paramIn[1]%>" />
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
   String curpoint = (result[0][0]).trim();
	System.out.println("curpoint === "+ curpoint);
	
	//SPubCallSvrImpl co = new SPubCallSvrImpl();
	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = iLoginNo;
	inputParsm[2] = iOrgCode;
	inputParsm[3] = iOpCode;
	System.out.println("phoneNO === "+ iPhoneNo);


  //retList = co.callFXService("s126bInit", inputParsm, "29","phone",iPhoneNo);
  //int errCode = co.getErrCode();
  //String errMsg = co.getErrMsg();

	//co.printRetValue();
%>	

	<wtc:service name="s126bInit" retcode="errCode" retmsg="errMsg" routerKey="phone" routerValue="<%=iPhoneNo%>" outnum="29">
   	<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=op_strong_pwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=inputParsm[2]%>"/>
  </wtc:service>
	
	<wtc:array id="retList" scope="end"/>

<%
	
  
  if(retList == null)
  {
	   retFlag = "1";
	   retMsg = "s126bInit查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;  
  }
  else
  {
	  if (errCode.equals("0")||errCode.equals("000000")){
	    bp_name = retList[0][3];           //机主姓名	 

	    bp_add = retList[0][4];            //客户地址

	    passwordFromSer = retList[0][2];  //密码

	    sm_code = retList[0][11];         //业务类别

	    sm_name = retList[0][12];        //业务类别名称

	    hand_fee = retList[0][13];      //手续费

	    favorcode = retList[0][14];     //优惠代码

	    rate_code = retList[0][5];     //资费代码

	    rate_name = retList[0][6];    //资费名称

	    next_rate_code = retList[0][7];//下月资费代码

	    next_rate_name = retList[0][8];//下月资费名称

	    bigCust_flag = retList[0][9];//大客户标志

	    bigCust_name = retList[0][10];//大客户名称

	    lack_fee = retList[0][15];//总欠费

	    prepay_fee = retList[0][16];//总预交

	    cardId_type = retList[0][17];//证件类型

	    cardId_no = retList[0][18];//证件号码

	    cust_id = retList[0][19];//客户id

	    cust_belong_code = retList[0][20];//客户归属id

	    group_type_code = retList[0][21];//集团客户类型

	    group_type_name = retList[0][22];//集团客户类型名称

	    imain_stream = retList[0][23];//当前资费开通流水

	    next_main_stream = retList[0][24];//预约资费开通流水

	    print_note = retList[0][25];//工单广告

	    contract_flag = retList[0][27];//是否托收账户

	    high_flag = retList[0][28];//是否中高端用户
		 }
	 }
	
	String rpcPage = "qryCus_s126jInit";
	
%>

var rpcPage="<%=rpcPage%>";
var bp_name="<%=bp_name%>";
var sm_code="<%=sm_code%>";
var family_code="<%=family_code%>";
var rate_code="<%=rate_code%>";
var bigCust_flag="<%=bigCust_flag%>";
var sm_name="<%=sm_name%>";
var rate_name="<%=rate_name%>";
var bigCust_name="<%=bigCust_name%>";
var next_rate_code="<%=next_rate_code%>";
var next_rate_name="<%=next_rate_name%>";
var lack_fee="<%=lack_fee%>";
var prepay_fee="<%=prepay_fee%>";
var bp_add="<%=bp_add%>";
var cardId_type="<%=cardId_type%>";
var cardId_no="<%=cardId_no%>";
var cust_id="<%=cust_id%>";
var cust_belong_code="<%=cust_belong_code%>";
var group_type_code="<%=group_type_code%>";
var group_type_name="<%=group_type_name%>";
var imain_stream="<%=imain_stream%>";
var next_main_stream="<%=next_main_stream%>";
var hand_fee="<%=hand_fee%>";
var favorcode="<%=favorcode%>";
var card_no="<%=card_no%>";
var print_note="<%=print_note%>";
var contract_flag="<%=contract_flag%>";
var high_flag="<%=high_flag%>";
var curpoint="<%=curpoint%>";

var response = new AJAXPacket();
response.guid		= '<%= request.getParameter("guid") %>';

response.data.add("rpc_page",rpcPage); 
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>"); 

response.data.add("bp_name",                     bp_name             );
response.data.add("sm_code",                    sm_code              );
response.data.add("family_code",                family_code          );
response.data.add("rate_code",                  rate_code            );
response.data.add("bigCust_flag",               bigCust_flag         );
response.data.add("sm_name",                    sm_name              );
response.data.add("rate_name",                  rate_name            );
response.data.add("bigCust_name",               bigCust_name         );
response.data.add("next_rate_code",             next_rate_code       );
response.data.add("next_rate_name",             next_rate_name       );
response.data.add("lack_fee",                   lack_fee             );
response.data.add("prepay_fee",                 prepay_fee           );
response.data.add("bp_add",                     bp_add               );
response.data.add("cardId_type",                cardId_type          );
response.data.add("cardId_no",                  cardId_no            );
response.data.add("cust_id",                    cust_id              );
response.data.add("cust_belong_code",           cust_belong_code     );
response.data.add("group_type_code",            group_type_code      );
response.data.add("group_type_name",            group_type_name      );
response.data.add("imain_stream",               imain_stream         );
response.data.add("next_main_stream",           next_main_stream     );
response.data.add("hand_fee",                   hand_fee             );
response.data.add("favorcode",                  favorcode            );
response.data.add("card_no",                    card_no              );
response.data.add("print_note",                 print_note           );
response.data.add("contract_flag",              contract_flag        );
response.data.add("high_flag",                  high_flag            );
response.data.add("curpoint",                   curpoint            );
core.ajax.receivePacket(response);
