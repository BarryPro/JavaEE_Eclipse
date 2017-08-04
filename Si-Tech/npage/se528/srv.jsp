<%@ page contentType= "text/html;charset=gb2312" %>
 <%@ page import="java.math.BigDecimal"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String loginPwd  = (String)session.getAttribute("password");//登陆密码
		String opCode = request.getParameter("opCode");
		String sale_type = request.getParameter("sale_type");
		String method = request.getParameter("method");
		String brand_code = request.getParameter("brand_code");
		String type_code = request.getParameter("type_code");
		String sale_code = request.getParameter("sale_code");
		String mode_code = request.getParameter("mode_code");
		String imei_no = request.getParameter("imei_no");
		System.out.println("----liujian---iiiiiiiiiiiiiiiii------imei_no=" + imei_no);
		System.out.println("----liujian---------type_code=" + type_code);
%>
		<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
		
<% 
	//通过营销方案
 if(method != null && method != "" && method.equals("apply_getSaleWays")) {
  	System.out.println("---------lj---method=apply_getSaleWays-- begin -------");
     //lj. 绑定参数
  	 String sql_select3 = "select unique trim(sale_code),trim(sale_name),to_char(to_number(sale_price)-to_number(prepay_gift)-to_number(prepay_limit)), to_char(consume_term) from dphoneSaleCode where region_code=:region_code and sale_type=:sale_type and valid_flag='Y' and brand_code=:brand_code and type_code=:type_code";
	 	 String srv_params3 = "region_code=" + regionCode + ",sale_type=" + sale_type + ",brand_code=" + brand_code + ",type_code=" + type_code;
	 	 System.out.println("---------lj---sql_select3=" + sql_select3);
	 	 System.out.println("---------lj---srv_params3=" + srv_params3);
%>
		<wtc:service name="TlsPubSelCrm" outnum="2">
			<wtc:param value="<%=sql_select3%>"/>
			<wtc:param value="<%=srv_params3%>"/>
		</wtc:service>
		<wtc:array id="sale_ways" scope="end" />
<% 	 
		System.out.println("---------lj---method=apply_getSaleWays---------" + sale_ways[0].length);
%>
		var array = [];
<%
	   if(retCode.equals("000000")) {
				//封装js数组
				for(int i=0;i<sale_ways.length;i++) 
				{
			%>
						var ways = {};
						ways.code = '<%=sale_ways[i][0]%>';
					  ways.name = '<%=sale_ways[i][1]%>';
					  array.push(ways);
			<%}
			}
%>
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCode %>");
		response.data.add("retmsg","<%= retMsg %>");
		response.data.add("result",array);
		core.ajax.receivePacket(response);
<%
  }
  //获得新主资费
  else if(method != null && method != "" && method.equals("apply_getModeSale")) {
  	System.out.println("---------lj---method=apply_getModeSale-- begin -------");
     //lj. 绑定参数
  	 String sql_select4 = "SELECT a.mode_code, a.mode_code || '--' || c.offer_name FROM dchnressaleplanmoderel a, dphonesalecode b, product_offer c WHERE a.sale_code = b.sale_code AND TRIM (a.mode_code) = TO_CHAR (c.offer_id) AND b.valid_flag = 'Y' AND b.region_code =:region_code  AND a.sale_code = :sale_code AND b.sale_type = :sale_type";
	 	 String srv_params4 = "region_code=" + regionCode + ",sale_type=" + sale_type + ",sale_code=" + sale_code ;
	 	 System.out.println("---------lj---sql_select4=" + sql_select4);
	 	 System.out.println("---------lj---srv_params4=" + srv_params4);
%>
		<wtc:service name="TlsPubSelCrm" outnum="2">
			<wtc:param value="<%=sql_select4%>"/>
			<wtc:param value="<%=srv_params4%>"/>
		</wtc:service>
		<wtc:array id="mode" scope="end" />
		var array = [];
<%
	  if(retCode.equals("000000")) {
			//封装js数组
			for(int i=0;i<mode.length;i++) 
			{
		%>
					var mode = {};
					mode.code = '<%=mode[i][0]%>';
				  mode.name = '<%=mode[i][1]%>';
				  array.push(mode);
		<%}
		}
%>
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCode %>");
		response.data.add("retmsg","<%= retMsg %>");
		response.data.add("result",array);
		core.ajax.receivePacket(response);
<%
  }
	//获得手机付款信息
  else if(method != null && method != "" && method.equals("apply_getPayInfo")) {
  	System.out.println("---------lj---method=apply_getPayInfo-- begin -------");
     //lj. 绑定参数
  	 String sql_select5 = "select base_fee,consume_term,prepay_gift,prepay_limit,sale_price,sale_name,active_term,mon_base_fee from dphonesalecode where sale_type = :plan_code and mode_code = :mode_code and sale_code = :sale_code";
	 	 String srv_params5 = "plan_code=" + sale_type + ",sale_code=" + sale_code + ",mode_code=" + mode_code;
	 	 System.out.println("---------lj---sql_select5=" + sql_select5);
	 	 System.out.println("---------lj---srv_params5=" + srv_params5);
%>
		<wtc:service name="TlsPubSelCrm" outnum="8">
			<wtc:param value="<%=sql_select5%>"/>
			<wtc:param value="<%=srv_params5%>"/>
		</wtc:service>
		<wtc:array id="payInfo" scope="end" />
			
		<%
			 //System.out.println("---------lj-------payInfo=" + payInfo[0].length);
		%>
		var array = {};
		var attr = ['base_fee','consume_term','prepay_gift','prepay_limit','sale_price','sale_name','active_term','mon_base_fee','mon_prepay_limit'];
<%
	  if(retCode.equals("000000") || payInfo.length > 0) {
			//封装js数组
			for(int i=0;i<payInfo[0].length;i++) 
			{
				System.out.println("--------------lj---------payInfo----");
				//设置底线预存等于底线预存*预存消费期限
				if( i == 3 && null != payInfo[0][1] && null != payInfo[0][3]) {
						String ct = payInfo[0][1];
						String pl = payInfo[0][3];
						//通过BigDecimal获得准确精度
		      	if(ct !=null && ct.indexOf(".") != -1) {
							ct = ct.substring(0,ct.indexOf("."));
						}%>
							array[attr[<%=8%>]] = '<%=pl%>';
						<%
						System.out.println("--------------lj---------ct----" + ct);
						System.out.println("--------------lj---------pl----" + pl);
						BigDecimal b1 = new BigDecimal(ct);
						BigDecimal b2 = new BigDecimal(pl); 
						payInfo[0][3] = b1.multiply(b2).toString();
						System.out.println("--------------lj---------payInfo[0][3]----" + payInfo[0][3]);
				}
		%>
				array[attr[<%=i%>]] = '<%=payInfo[0][i]%>';
		<%}		
		}
		
		/* 关于优化e528自备机合约计划小区资费捆绑的需求 @ningtn*/
		
%>
		<wtc:service name="sOfferAttrCheck" retcode="offerAttrRetCode" retmsg="offerAttrRetMsg" outnum="3">
			<wtc:param value=""/>
			<wtc:param value="01"/>
			<wtc:param value="e528"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=loginPwd%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=mode_code%>"/>
		</wtc:service>
		<wtc:array id="offerAttrResult1" scope="end" start="0" length="1" />
		<wtc:array id="offerAttrResult2" scope="end" start="1" length="2" />
<%
		String offerAttrFlag = "N";
		String strArray = "var arrMsg; ";
		if("000000".equals(offerAttrRetCode)){
			if(offerAttrResult1.length > 0){
				offerAttrFlag = offerAttrResult1[0][0];
			}
			if("Y".equals(offerAttrFlag)){
				strArray = WtcUtil.createArray("arrMsg",offerAttrResult2.length);
%>
				<%=strArray%>
<%
				for(int i = 0; i < offerAttrResult2.length; i++){
					System.out.println("-------- ningtn flagcode:"+offerAttrResult2[i][0]+"|"+offerAttrResult2[i][1]);
%>
				arrMsg[<%=i%>][0] = "<%=offerAttrResult2[i][0]%>";
				arrMsg[<%=i%>][1] = "<%=offerAttrResult2[i][1]%>";
<%
				}
			}else{
%>
				<%=strArray%>
<%
			}
		}
%>
			
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCode %>");
		response.data.add("retmsg","<%= retMsg %>");
		response.data.add("result",array);
		response.data.add("offerAttrFlag","<%=offerAttrFlag%>");
		response.data.add("offerAttrResult",arrMsg);
		core.ajax.receivePacket(response);
<%
  } 
	else if(method != null && method != "" && method.equals("apply_checkIMEI")) {
  //lj. 绑定参数
  String sql_select6="select count(*) from dbchnterm.sChnResCodeTAC a where a.tac_code  = :imei_no and a.res_code=:style_code";
	String srv_params6 = "imei_no=" + imei_no.substring(0,8) + ",style_code=" + type_code;
	System.out.println("sql_select6=" + sql_select6);
	System.out.println("srv_params6=" + srv_params6);
	String sql_select7 = "select count(*) from wmachsndopr where sysdate between bx_begin and bx_end and trim(imei_no) = :imei_no and back_flag = '0' and op_code = 'e528'";
	String srv_params7 = "imei_no=" + imei_no;
%>
	<wtc:service name="TlsPubSelCrm" retcode="retResult" retmsg="retMsg" outnum="1">
		<wtc:param value="<%=sql_select6%>"/>
		<wtc:param value="<%=srv_params6%>"/>
	</wtc:service>
	<wtc:array id="imeiCount" scope="end" />
<%
		if(retResult.equals("0")||retResult.equals("000000")){
		    System.out.println("调用服务TlsPubSelCrm in srv.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
		    String num1 = (imeiCount[0][0]).trim();
				System.out.println("num1="+num1);
				System.out.println("-----liujian-----retResult=" + retResult);
				System.out.println("-----liujian-----num1=" + num1);
				if(num1.equals("0")){
						retResult="000003";
				}else{
						retResult="000000";
		%>
					<wtc:service name="TlsPubSelCrm" retcode="retIMEICode" retmsg="retIMEIMsg" outnum="1">
						<wtc:param value="<%=sql_select7%>"/>
						<wtc:param value="<%=srv_params7%>"/>
					</wtc:service>
					<wtc:array id="imeiCount2" scope="end" />
		<%
					System.out.println("-----liujian-----retIMEICode=" + retIMEICode);
					if(retIMEICode.equals("0")||retIMEICode.equals("000000")){
							String imeiNum = (imeiCount2[0][0]).trim();
							System.out.println("-----liujian-----imeiNum=" + imeiNum);
							System.out.println("imeiNum="+imeiNum);
							if(imeiNum.equals("0")){
									retResult="000000";
							}else{
									retResult="000004";
							}
					}else {
						retResult = retIMEICode;
						System.out.println("TlsPubSelCrm sql_select7  in srv.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
					}
				}	
    }else{
			System.out.println("TlsPubSelCrm sql_select6 in srv.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
		}
%>
		var response = new AJAXPacket();
		response.data.add("retcode","<%=retResult%>");
		response.data.add("retmsg","<%=retMsg%>");
		core.ajax.receivePacket(response);
<%
}
%>