<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%
  
//  ArrayList retList = new ArrayList();
//  String[][] tempArr= new String[][]{};

	String regionCode = (String)session.getAttribute("regCode");	//地市 
	String retFlag="",retMsg="";  
	String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
	String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
	String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
	String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
	String  favorcode="",card_no="",print_note="",contract_flag="",high_flag="",passwordFromSer="";
	
	String iPhoneNo = request.getParameter("secondphone");
	String iLoginNo = request.getParameter("loginno");
	String iOrgCode = request.getParameter("orgcode");
	String iSaleCode = request.getParameter("salecode");
	String iOpCode = request.getParameter("iOpCode");
	String iMainFlag="N";
	
	String  inputParsm [] = new String[6];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = iLoginNo;
	inputParsm[2] = iOrgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = iSaleCode;
	inputParsm[5] = iMainFlag;
	System.out.println("iOpCode === "+ iOpCode);

%>
	<wtc:service name="s8672Init" routerKey="region" routerValue="<%=regionCode%>" outnum="29" retcode="retCode1" retmsg="retMsg1">
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
		<wtc:param value="<%=inputParsm[5]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%
	String errCode = retCode1;
	String errMsg = retMsg1;

  if(tempArr == null)
  {
	   retFlag = "1";
	   retMsg = "s8672Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;  
  }
  else
  {
	  if (errCode.equals("000000")&tempArr.length>0 ){
		    bp_name = tempArr[0][3];           //机主姓名
		    bp_add = tempArr[0][4];            //客户地址
		    passwordFromSer = tempArr[0][2];  //密码
		    sm_code = tempArr[0][11];         //业务类别
		    sm_name = tempArr[0][12];        //业务类别名称
		    hand_fee = tempArr[0][13];      //手续费
		    favorcode = tempArr[0][14];     //优惠代码
		    rate_code = tempArr[0][5];     //资费代码
		    rate_name = tempArr[0][6];    //资费名称
		    next_rate_code = tempArr[0][7];//下月资费代码
		    next_rate_name = tempArr[0][8];//下月资费名称
		    bigCust_flag = tempArr[0][9];//大客户标志
		    bigCust_name = tempArr[0][10];//大客户名称
		    lack_fee = tempArr[0][15];//总欠费
		    prepay_fee = tempArr[0][16];//总预交
		    cardId_type = tempArr[0][17];//证件类型
		    cardId_no = tempArr[0][18];//证件号码
		    cust_id = tempArr[0][19];//客户id
		    cust_belong_code = tempArr[0][20];//客户归属id
		    group_type_code = tempArr[0][21];//集团客户类型
		    group_type_name = tempArr[0][22];//集团客户类型名称
		    imain_stream = tempArr[0][23];//当前资费开通流水
		    next_main_stream = tempArr[0][24];//预约资费开通流水
	    	print_note = tempArr[0][25];//工单广告
	    	contract_flag = tempArr[0][27];//是否托收账户
	    	high_flag = tempArr[0][28];//是否中高端用户
	  }
	 }
	String rpcPage = "qrysecondpn";
	
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
	
	var response = new AJAXPacket();
	
	response.data.add("rpc_page",rpcPage); 
	response.data.add("retCode","<%=errCode%>");
	response.data.add("retMsg","<%=errMsg%>"); 
	
	response.data.add("bp_name",                    bp_name              );
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
	
	core.ajax.receivePacket(response);
