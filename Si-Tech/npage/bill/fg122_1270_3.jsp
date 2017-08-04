<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.text.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%String Readpaths = request.getRealPath("npage/properties")+"/getRDMessage.properties";%>
<%
	String printAccept = request.getParameter("printAccept");
	String bdbz = request.getParameter("bdbz");
	String bdts = request.getParameter("bdts");
	String note = request.getParameter("note");
	String note1 = request.getParameter("note1");
	String smzvalue = request.getParameter("smzvalue");
	String goodbz = request.getParameter("goodbz");
	String oSmCode = request.getParameter("oSmCode")==null?"":request.getParameter("oSmCode");
	String m_smCode = request.getParameter("m_smCode")==null?"":request.getParameter("m_smCode");
%>
<script language="JavaScript">
function printInfoG122()
{
	  //得到该业务工单需要的参数
	var tempStr = document.form1.iAddStr.value;
		/**** ningtn add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",4);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}
		/**** ningtn add for pos end *****/
	var sale_code     = oneTokSelf(tempStr,"|",1);	//方案代码
	var agent_code    = oneTokSelf(tempStr,"|",2);	//固话品牌
	var phone_type    = oneTokSelf(tempStr,"|",3);	//固话型号
	var sale_price    = oneTokSelf(tempStr,"|",4);	//应收金额
	var base_fee      = oneTokSelf(tempStr,"|",5);	//话费
	var consume_term  = oneTokSelf(tempStr,"|",6);	//话费消费期限
	var free_fee      = oneTokSelf(tempStr,"|",7);	//网费
	var active_term   = oneTokSelf(tempStr,"|",8);	//网费消费期限
	var all_gift_price= oneTokSelf(tempStr,"|",9);	//购固话费用
	var market_price  = oneTokSelf(tempStr,"|",10); //市场价
	var imeino        = oneTokSelf(tempStr,"|",11); //IEMI号码
	var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //预存费用

	var begin_time='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>';

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

	var retInfo = "";
	/********基本信息类**********/
	cust_info+="手机号码："+document.all.phone.value+"|";
	cust_info+="客户姓名："+document.all.i4.value+"|";

	/********受理类**********/
	opr_info+="业务类型: 购TD商务固话赠通信费申请"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}%>
	opr_info+="TD商务固话品牌："+agent_code+"，型号："+phone_type+"，IMEI号："+imeino+"|";
	opr_info+="赠送话费"+base_fee+"元|";

	opr_info+="业务执行时间："+begin_time+"|";

	/*******备注类**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********描述类*********/
	note_info2+="资费说明："+"|";
	note_info2+=" "+codeChg("<%=note.trim()%>")+"|";
	note_info2+="拆包后自动变更的资费说明："+"|";
	note_info2+=" "+codeChg("<%=note1.trim()%>")+"|";
	note_info2+="您的话机如拆包使用，则自动变更为以上的资费，您可以到营业厅办理回原资费。|";
	/***************判断是否显示字符变更******************/
	   var old_SmCode = "<%=oSmCode%>";
       var new_SmCode = "<%=m_smCode%>";
	  if(old_SmCode == "zn")
  		{
  			//薛英哲 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@关于积分清零条件调整的需求 zn->gn 积分不清零
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn 积分清零 */
		  		
	  		}

  		}
  		
  			  	  			/* wanghyd 去掉积分清零提示同时增加提示 */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("g122","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
	note_info3+=" "+"|";
	note_info4+="备注： "+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//购TD商务固话赠通信费冲正  sunaj－20090828
function printInfoG123()
{
	//得到该业务工单需要的参数
	var tempStr = document.form1.iAddStr.value;
	/**** ningtn add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",5);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="01";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="04";
	}
	/**** ningtn add for pos end *****/	
	var login_accept  = oneTokSelf(tempStr,"|",1);  //业务流水
	var sale_code     = oneTokSelf(tempStr,"|",2);	//方案代码
	var agent_code    = oneTokSelf(tempStr,"|",3);	//手机品牌
	var phone_type    = oneTokSelf(tempStr,"|",4);	//手机型号
	var sale_price    = oneTokSelf(tempStr,"|",5);	//应收金额
	var base_fee      = oneTokSelf(tempStr,"|",6);	//底线预存
	var consume_term  = oneTokSelf(tempStr,"|",7);	//底线消费期限
	var free_fee      = oneTokSelf(tempStr,"|",8);	//活动预存
	var active_term   = oneTokSelf(tempStr,"|",9);	//活动消费期限
	var all_gift_price= oneTokSelf(tempStr,"|",10);	//购卡费用
	var market_price  = oneTokSelf(tempStr,"|",11); //市场价
	var imeino        = oneTokSelf(tempStr,"|",12); //IEMI号码
	var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //预存费用

	var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

	var retInfo = "";
	/********基本信息类**********/
	cust_info+="客户姓名：" +document.all.i4.value+"|";
	cust_info+="手机号码："+document.all.phone.value+"|";

	/********受理类**********/
	opr_info+="业务类型: 购TD商务固话赠通信费冲正"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}%>
	/*******备注类**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********描述类*********/
	note_info3+=" "+"|";
    note_info4+="备注："+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

function printInfoG124()
{
	  //得到该业务工单需要的参数
	var tempStr = document.form1.iAddStr.value;
		/**** ningtn add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",4);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}
		/**** ningtn add for pos end *****/
	var sale_code     = oneTokSelf(tempStr,"|",1);	//方案代码
	var agent_code    = oneTokSelf(tempStr,"|",2);	//固话品牌
	var phone_type    = oneTokSelf(tempStr,"|",3);	//固话型号
	var sale_price    = oneTokSelf(tempStr,"|",4);	//应收金额
	var base_fee      = oneTokSelf(tempStr,"|",5);	//话费
	var consume_term  = oneTokSelf(tempStr,"|",6);	//话费消费期限
	var free_fee      = oneTokSelf(tempStr,"|",7);	//网费
	var active_term   = oneTokSelf(tempStr,"|",8);	//网费消费期限
	var all_gift_price= oneTokSelf(tempStr,"|",9);	//购固话费用
	var market_price  = oneTokSelf(tempStr,"|",10); //市场价
	var imeino        = oneTokSelf(tempStr,"|",11); //IEMI号码
	var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //预存费用

	var begin_time='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>';

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

	var retInfo = "";
	/********基本信息类**********/
	cust_info+="手机号码："+document.all.phone.value+"|";
	cust_info+="客户姓名："+document.all.i4.value+"|";

	/********受理类**********/
	opr_info+="业务类型: 购TD商务固话赠通信费(铁通)申请"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}%>
	opr_info+="购机信息：品牌"+agent_code+"，型号"+phone_type+"，捆绑IMEI"+imeino+"|";
	opr_info+="赠送话费："+base_fee+"元|";

	opr_info+="业务执行时间："+begin_time+"|";

	/*******备注类**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********描述类*********/
	note_info2+="资费说明："+"|";
	note_info2+=" "+codeChg("<%=note.trim()%>")+"|";
	note_info2+="拆包后自动变更的资费说明："+"|";
	note_info2+=" "+codeChg("<%=note1.trim()%>")+"|";
	note_info2+="您的话机如拆包使用，则自动变更为以上的资费，您可以到营业厅办理回原资费。|";

	note_info3+=" "+"|";
	note_info4+="备注： "+"|";
	/***************判断是否显示字符变更******************/
	  var old_SmCode = "oSmCode%>";
	  var new_SmCode = "m_smCode%>";
	  if(old_SmCode == "zn")
  		{
  			//薛英哲 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@关于积分清零条件调整的需求 zn->gn 积分不清零
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn 积分清零 */
		  		
	  		}

  		}
  		
  			  	  			/* wanghyd 去掉积分清零提示同时增加提示 */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("7688","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//购TD商务固话赠通信费(铁通)冲正  wangyua－20100511
function printInfoG125()
{
	//得到该业务工单需要的参数
	var tempStr = document.form1.iAddStr.value;
	/**** ningtn add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",5);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="01";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="04";
	}
	/**** ningtn add for pos end *****/	
	var login_accept  = oneTokSelf(tempStr,"|",1);  //业务流水
	var sale_code     = oneTokSelf(tempStr,"|",2);	//方案代码
	var agent_code    = oneTokSelf(tempStr,"|",3);	//手机品牌
	var phone_type    = oneTokSelf(tempStr,"|",4);	//手机型号
	var sale_price    = oneTokSelf(tempStr,"|",5);	//应收金额
	var base_fee      = oneTokSelf(tempStr,"|",6);	//底线预存
	var consume_term  = oneTokSelf(tempStr,"|",7);	//底线消费期限
	var free_fee      = oneTokSelf(tempStr,"|",8);	//活动预存
	var active_term   = oneTokSelf(tempStr,"|",9);	//活动消费期限
	var all_gift_price= oneTokSelf(tempStr,"|",10);	//购卡费用
	var market_price  = oneTokSelf(tempStr,"|",11); //市场价
	var imeino        = oneTokSelf(tempStr,"|",12); //IEMI号码
	var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //预存费用

	var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

	var retInfo = "";
	/********基本信息类**********/
	cust_info+="客户姓名：" +document.all.i4.value+"|";
	cust_info+="手机号码："+document.all.phone.value+"|";

	/********受理类**********/
	opr_info+="业务类型: 购TD商务固话赠通信费(铁通)冲正"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}%>
	/*******备注类**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********描述类*********/
	note_info3+=" "+"|";
    note_info4+="备注："+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

</script>