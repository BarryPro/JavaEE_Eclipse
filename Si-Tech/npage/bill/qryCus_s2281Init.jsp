<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
    /*ArrayList arrSession2 = (ArrayList)session.getAttribute("allArr");
	  String[][] baseInfoSession2 = (String[][])arrSession2.get(0);
    String loginNo = baseInfoSession2[0][2];*/
    String loginNo = (String)session.getAttribute("workNo");
  
  	/* liujian 安全加固修改 2012-4-6 16:18:13 begin */
		String op_strong_pwd = (String) session.getAttribute("password");
	  /* liujian 安全加固修改 2012-4-6 16:18:13 end */
	  
  /*ArrayList retList = new ArrayList();
  String[][] tempArr= new String[][]{};*/

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


	/*SPubCallSvrImpl co = new SPubCallSvrImpl();*/
	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = iLoginNo;
	inputParsm[2] = iOrgCode;
	inputParsm[3] = iOpCode;
	System.out.println("phoneNO === "+ iPhoneNo);


  /*retList = co.callFXService("s126bInit", inputParsm, "29","phone",iPhoneNo);
  int errCode = co.getErrCode();
  String errMsg = co.getErrMsg();

	co.printRetValue();*/
%>

<wtc:service name="s126bInit" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="errCode" retmsg="errMsg" outnum="29" >
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
			//retList[0][] = (String[][])retList.get(3);
			if(!(retList[0][3]==null)){
			  bp_name = retList[0][3];           //机主姓名
			}
			
			//retList[0][] = (String[][])retList.get(4);
			if(!(retList[0][4]==null)){
			  bp_add = retList[0][4];            //客户地址
			}
			
			//retList[0][] = (String[][])retList.get(2);
			if(!(retList[0][2]==null)){
			  passwordFromSer = retList[0][2];  //密码
			}
			
			// retList[0][] = (String[][])retList.get(11);
			if(!(retList[0][11]==null)){
			  sm_code = retList[0][11];         //业务类别
			}
			
			//retList[0][] = (String[][])retList.get(12);
			if(!(retList[0][12]==null)){
			  sm_name = retList[0][12];        //业务类别名称
			}
			
			//retList[0][] = (String[][])retList.get(13);
			if(!(retList[0][13]==null)){
			  hand_fee = retList[0][13];      //手续费
			}
			System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
			System.out.println(hand_fee);
			
			//retList[0][] = (String[][])retList.get(14);
			if(!(retList[0][14]==null)){
			  favorcode = retList[0][14];     //优惠代码
			}
			
			//retList[0][] = (String[][])retList.get(5);
			if(!(retList[0][5]==null)){
			  rate_code = retList[0][5];     //资费代码
			}
			
			//retList[0][] = (String[][])retList.get(6);
			if(!(retList[0][6]==null)){
			  rate_name = retList[0][6];    //资费名称
			}
			
			// retList[0][] = (String[][])retList.get(7);
			if(!(retList[0][7]==null)){
			  next_rate_code = retList[0][7];//下月资费代码
			}
			
			//retList[0][] = (String[][])retList.get(8);
			if(!(retList[0][8]==null)){
			  next_rate_name = retList[0][8];//下月资费名称
			}
			
			//retList[0][] = (String[][])retList.get(9);
			if(!(retList[0][9]==null)){
			  bigCust_flag = retList[0][9];//大客户标志
			}
			
			// retList[0][] = (String[][])retList.get(10);
			if(!(retList[0][10]==null)){
			  bigCust_name = retList[0][10];//大客户名称
			}
			
			//retList[0][] = (String[][])retList.get(15);
			if(!(retList[0][15]==null)){
			  lack_fee = retList[0][15];//总欠费
			}
			
			//retList[0][] = (String[][])retList.get(16);
			if(!(retList[0][16]==null)){
			  prepay_fee = retList[0][16];//总预交
			}
			
			//retList[0][] = (String[][])retList.get(17);
			if(!(retList[0][17]==null)){
			  cardId_type = retList[0][17];//证件类型
			}
			
			//retList[0][] = (String[][])retList.get(18);
			if(!(retList[0][18]==null)){
			  cardId_no = retList[0][18];//证件号码
			}
			
			//retList[0][] = (String[][])retList.get(19);
			if(!(retList[0][19]==null)){
			  cust_id = retList[0][19];//客户id
			}
			
			//retList[0][] = (String[][])retList.get(20);
			if(!(retList[0][20]==null)){
			  cust_belong_code = retList[0][20];//客户归属id
			}
			
			//retList[0][] = (String[][])retList.get(21);
			if(!(retList[0][21]==null)){
			  group_type_code = retList[0][21];//集团客户类型
			}
			
			//retList[0][] = (String[][])retList.get(22);
			if(!(retList[0][22]==null)){
			  group_type_name = retList[0][22];//集团客户类型名称
			}
			
			//retList[0][] = (String[][])retList.get(23);
			if(!(retList[0][23]==null)){
			  imain_stream = retList[0][23];//当前资费开通流水
			}
			
			//retList[0][] = (String[][])retList.get(24);
			if(!(retList[0][24]==null)){
			  next_main_stream = retList[0][24];//预约资费开通流水
			}
			
			//retList[0][] = (String[][])retList.get(25);
			if(!(retList[0][25]==null)){
			  print_note = retList[0][25];//工单广告
			}
			
			//retList[0][] = (String[][])retList.get(27);
			if(!(retList[0][27]==null)){
			  contract_flag = retList[0][27];//是否托收账户
			}
			
			//retList[0][] = (String[][])retList.get(28);
			if(!(retList[0][28]==null)){
			  high_flag = retList[0][28];//是否中高端用户
			}
		}
	}
	String rpcPage = "qryCus_s2281Init";
	
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

var response = new AJAX	Packet();
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

core.ajax.receivePacket(response);
