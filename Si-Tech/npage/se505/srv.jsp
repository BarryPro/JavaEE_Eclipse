<%@ page contentType= "text/html;charset=gb2312" %>
 <%@ page import="java.math.BigDecimal"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String loginPwd  = (String)session.getAttribute("password");//登陆密码
		String groupId  = (String)session.getAttribute("groupId");//diling add @2012/8/24
		String opCode = request.getParameter("opCode");
		String sale_type = request.getParameter("sale_type");
		String method = request.getParameter("method");
		String brand_code = request.getParameter("brand_code");
		String type_code = request.getParameter("type_code");
		String sale_code = request.getParameter("sale_code");
		String mode_code = request.getParameter("mode_code");
%>
		<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
	//通过手机品牌获得手机型号
	if(method != null && method != "" && method.equals("apply_getPhoneBrand")) {
     //lj. 绑定参数
  	 String sql_select1 = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b  where a.region_code=:region_code and  a.type_code=b.res_code and a.brand_code=b.brand_code  and a.sale_type=:sale_type and a.valid_flag='Y' and b.brand_code=:brand_code";
	 	 String srv_params1 = "region_code=" + regionCode + ",sale_type=" + sale_type + ",brand_code=" + brand_code;
%>
		<wtc:service name="TlsPubSelCrm" outnum="3">
			<wtc:param value="<%=sql_select1%>"/>
			<wtc:param value="<%=srv_params1%>"/>
		</wtc:service>
		<wtc:array id="phone_type" scope="end" />
<% 	 
		System.out.println("---------lj---method=apply_getPhoneBrand---------" + phone_type[0].length);
%>
		var array = [];
<%
	  if(retCode.equals("000000")) {
			//封装js数组
			for(int i=0;i<phone_type.length;i++) 
			{
		%>
					var type = {};
					type.value = '<%=phone_type[i][0]%>';
				  type.name = '<%=phone_type[i][1]%>';
				  array.push(type);
		<%
			}
	 }	
%>
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCode %>");
		response.data.add("retmsg","<%= retMsg %>");
		response.data.add("result",array);
		core.ajax.receivePacket(response);
<%
  }
	//通过营销方案
  else if(method != null && method != "" && method.equals("apply_getSaleWays")) {
  	System.out.println("---------lj---method=apply_getSaleWays-- begin -------");
  	/*begin diling add for 如果是社会渠道的工号办理此营销案，那么只可以办理营销方案中“购机款”等于零的方案！@2012/8/24 */
    String[] sql_chnInParam = new String[2];
    sql_chnInParam[0] = "select count(1) from dchngroupmsg a, schnclasstypecode b where b.class_type = '1' and a.class_code = b.class_code and b.class_code not in ('201', '202', '203') and a.group_id =:groupid ";
    sql_chnInParam[1] = "groupid="+groupId;
%>
    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_chn" retmsg="retMsg_chn" outnum="1"> 
      <wtc:param value="<%=sql_chnInParam[0]%>"/>
      <wtc:param value="<%=sql_chnInParam[1]%>"/> 
    </wtc:service>  
    <wtc:array id="chnRet"  scope="end"/>
<%
    String sql_select3 = "";
    String srv_params3 = "";
    if("000000".equals(retCode_chn)){
      if(chnRet.length>0){
        if("1".equals(chnRet[0][0])){/*此为社会渠道的工号*/
         //lj. 绑定参数
      	 sql_select3 = "select unique trim(sale_code),trim(sale_name),to_char(to_number(sale_price)-to_number(prepay_gift)-to_number(prepay_limit)), to_char(consume_term) from dphoneSaleCode where region_code=:region_code and sale_type=:sale_type and valid_flag='Y' and brand_code=:brand_code and type_code=:type_code and base_fee=0";
    	 	 srv_params3 = "region_code=" + regionCode + ",sale_type=" + sale_type + ",brand_code=" + brand_code + ",type_code=" + type_code;
	 	      System.out.println("---社会渠道工号------diling---chnRet[0][0]=" + chnRet[0][0]);
        }else{
      	 //lj. 绑定参数
      	 sql_select3 = "select unique trim(sale_code),trim(sale_name),to_char(to_number(sale_price)-to_number(prepay_gift)-to_number(prepay_limit)), to_char(consume_term) from dphoneSaleCode where region_code=:region_code and sale_type=:sale_type and valid_flag='Y' and brand_code=:brand_code and type_code=:type_code";
    	 	 srv_params3 = "region_code=" + regionCode + ",sale_type=" + sale_type + ",brand_code=" + brand_code + ",type_code=" + type_code;
        }
      }
    }
    /*end diling add @2012/8/24 */
     
	 	 System.out.println("---------lj---sql_select3=" + sql_select3);
	 	 System.out.println("---------lj---srv_params3=" + srv_params3);
%>
		<wtc:service name="TlsPubSelCrm" outnum="2">
			<wtc:param value="<%=sql_select3%>"/>
			<wtc:param value="<%=srv_params3%>"/>
		</wtc:service>
		<wtc:array id="sale_ways" scope="end" />
<% 	 
		System.out.println("---------lj---method=apply_getSaleWays---------");
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
		var array = {};
		//var attr = ['cost_price','market_price','allowance_cost','prepay_limit',
		//						'prepay_gift','consume_term','mon_base_fee','sale_price','op_note'];
			var attr = ['base_fee','consume_term','prepay_gift','prepay_limit','sale_price','sale_name','active_term','mon_base_fee','mon_prepay_limit'];
<%
		System.out.println("---------------liujian---------retCode=" + retCode );
	  if(retCode.equals("000000")) {
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
%>
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCode %>");
		response.data.add("retmsg","<%= retMsg %>");
		response.data.add("result",array);
		core.ajax.receivePacket(response);
<%
  }
%>