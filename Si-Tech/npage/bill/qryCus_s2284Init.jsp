<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%
    ArrayList arrSession2 = (ArrayList)session.getAttribute("allArr");
	  String[][] baseInfoSession2 = (String[][])arrSession2.get(0);
    String loginNo = baseInfoSession2[0][2];
  
  ArrayList retList = new ArrayList();
  String[][] tempArr= new String[][]{};

  String  retFlag="",retMsg="";  
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
  String  total_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="";
  String  gift_code="",gift_grade="",gift_name="";
  String  deposit_fee="",base_fee="",free_fee="";
  String  mark_subtract="",consume_term="",mon_base_fee="",prepay_fee="";

	
	String iPhoneNo = request.getParameter("iPhoneNo");
	String iLoginNo = request.getParameter("iLoginNo");
	String iOrgCode = request.getParameter("iOrgCode");
	String iOpCode = request.getParameter("iOpCode");


	SPubCallSvrImpl co = new SPubCallSvrImpl();
	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = iLoginNo;
	inputParsm[2] = iOrgCode;
	inputParsm[3] = iOpCode;
	System.out.println("phoneNO === "+ iPhoneNo);


  retList = co.callFXService("s2282Init", inputParsm, "39","phone",iPhoneNo);
  int errCode = co.getErrCode();
  String errMsg = co.getErrMsg();

	co.printRetValue();
  
  if(retList == null)
  {
	   retFlag = "1";
	   retMsg = "s2282Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;  
  }
  else
  {
	  if (errCode == 0 ){
	  tempArr = (String[][])retList.get(3);
	  if(!(tempArr==null)){
	    bp_name = tempArr[0][0];           //机主姓名
	  }

	  tempArr = (String[][])retList.get(4);
	  if(!(tempArr==null)){
	    bp_add = tempArr[0][0];            //客户地址
	  }

	  tempArr = (String[][])retList.get(11);
	  if(!(tempArr==null)){
	    sm_code = tempArr[0][0];         //业务类别
	  }

	  tempArr = (String[][])retList.get(12);
	  if(!(tempArr==null)){
	    sm_name = tempArr[0][0];        //业务类别名称
	  }

	  tempArr = (String[][])retList.get(13);
	  if(!(tempArr==null)){
	    hand_fee = tempArr[0][0];      //手续费
	  }

	  tempArr = (String[][])retList.get(14);
	  if(!(tempArr==null)){
	    favorcode = tempArr[0][0];     //优惠代码
	  }

	  tempArr = (String[][])retList.get(5);
	  if(!(tempArr==null)){
	    rate_code = tempArr[0][0];     //资费代码
	  }

	  tempArr = (String[][])retList.get(6);
	  if(!(tempArr==null)){
	    rate_name = tempArr[0][0];    //资费名称
	  }

	  tempArr = (String[][])retList.get(35);
	  if(!(tempArr==null)){
	    next_rate_code = tempArr[0][0];//下月资费代码
	  }

	  tempArr = (String[][])retList.get(8);
	  if(!(tempArr==null)){
	    next_rate_name = tempArr[0][0];//下月资费名称
	  }

	  tempArr = (String[][])retList.get(9);
	  if(!(tempArr==null)){
	    bigCust_flag = tempArr[0][0];//大客户标志
	  }

	  tempArr = (String[][])retList.get(10);
	  if(!(tempArr==null)){
	    bigCust_name = tempArr[0][0];//大客户名称
	  }

	  tempArr = (String[][])retList.get(15);
	  if(!(tempArr==null)){
	    lack_fee = tempArr[0][0];//总欠费
	  }

	  tempArr = (String[][])retList.get(16);
	  if(!(tempArr==null)){
	    total_prepay = tempArr[0][0];//总预交
	  }

	  tempArr = (String[][])retList.get(17);
	  if(!(tempArr==null)){
	    cardId_type = tempArr[0][0];//证件类型
	  }

	  tempArr = (String[][])retList.get(18);
	  if(!(tempArr==null)){
	    cardId_no = tempArr[0][0];//证件号码
	  }

	  tempArr = (String[][])retList.get(19);
	  if(!(tempArr==null)){
	    cust_id = tempArr[0][0];//客户id
	  }

	  tempArr = (String[][])retList.get(20);
	  if(!(tempArr==null)){
	    cust_belong_code = tempArr[0][0];//客户归属id
	  }

	  tempArr = (String[][])retList.get(21);
	  if(!(tempArr==null)){
	    group_type_code = tempArr[0][0];//集团客户类型
	  }

	  tempArr = (String[][])retList.get(22);
	  if(!(tempArr==null)){
	    group_type_name = tempArr[0][0];//集团客户类型名称
	  }

	  tempArr = (String[][])retList.get(23);
	  if(!(tempArr==null)){
	    imain_stream = tempArr[0][0];//当前资费开通流水
	  }

	  tempArr = (String[][])retList.get(24);
	  if(!(tempArr==null)){
	    next_main_stream = tempArr[0][0];//预约资费开通流水
	  }

	  tempArr = (String[][])retList.get(25);
	  if(!(tempArr==null)){
	    gift_grade = tempArr[0][0];//礼品等级
	  }

	  tempArr = (String[][])retList.get(26);
	  if(!(tempArr==null)){
	    gift_code = tempArr[0][0];//礼品代码
	  }
	  
	  tempArr = (String[][])retList.get(27);
	  if(!(tempArr==null)){
	    gift_name = tempArr[0][0];//礼品名称
	  }

	  tempArr = (String[][])retList.get(28);
	  if(!(tempArr==null)){
	    deposit_fee = tempArr[0][0];//抵押预存
	  }

	  tempArr = (String[][])retList.get(29);
	  if(!(tempArr==null)){
	    base_fee = tempArr[0][0];//底线预存
	  }

	  tempArr = (String[][])retList.get(30);
	  if(!(tempArr==null)){
	    free_fee = tempArr[0][0];//活动预存
	  }	  	  

	  tempArr = (String[][])retList.get(31);
	  if(!(tempArr==null)){
	    mark_subtract = tempArr[0][0];//扣减积分
	  }

	  tempArr = (String[][])retList.get(32);
	  if(!(tempArr==null)){
	    consume_term = tempArr[0][0];//消费期限
	  }

	  tempArr = (String[][])retList.get(33);
	  if(!(tempArr==null)){
	    mon_base_fee = tempArr[0][0];//月底线
	  }	  	 	  	  

	  tempArr = (String[][])retList.get(34);
	  if(!(tempArr==null)){
	    prepay_fee = tempArr[0][0];//预存总金额
	  }	  	  

	  tempArr = (String[][])retList.get(37);
	  if(!(tempArr==null)){
	    print_note = tempArr[0][0];//广告词
	  }		  
	 }
	  else{%>
	 <script language="JavaScript">
<!--
  	alert("错误代码：<%=errCode%>错误信息：<%=errMsg%>");
  	 history.go(-1);
  	//-->
  </script>
<%	 }
	}
	String rpcPage = "qryCus_s2284Init";
	
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
var total_prepay="<%=total_prepay%>";
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
var gift_grade="<%=gift_grade%>";
var gift_code="<%=gift_code%>";
var gift_name="<%=gift_name%>";
var deposit_fee="<%=deposit_fee%>";
var base_fee="<%=base_fee%>";
var free_fee="<%=free_fee%>";
var mark_subtract="<%=mark_subtract%>";
var consume_term="<%=consume_term%>";
var mon_base_fee="<%=mon_base_fee%>";
var prepay_fee="<%=prepay_fee%>";


var response = new RPCPacket();
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
response.data.add("total_prepay",               total_prepay         );
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

response.data.add("gift_grade",                 gift_grade           );
response.data.add("gift_code",                  gift_code            );
response.data.add("gift_name",                  gift_name            );
response.data.add("deposit_fee",                deposit_fee          );
response.data.add("base_fee",                   base_fee             );
response.data.add("free_fee",                   free_fee             );
response.data.add("mark_subtract",              mark_subtract        );
response.data.add("consume_term",               consume_term         );
response.data.add("mon_base_fee",               mon_base_fee         );
response.data.add("prepay_fee",                 prepay_fee           );


core.rpc.receivePacket(response);
