<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	System.out.println("yanpx");
	String ipower_right = ((String)session.getAttribute("powerRight")).trim(); 
	String workNo = (String)session.getAttribute("workNo");
	String groupId      = (String)session.getAttribute("groupId");
	String regionCode   = (String)session.getAttribute("regCode");
	/* liujian 安全加固修改 2012-4-6 16:18:13 begin */
	String op_strong_pwd = (String) session.getAttribute("password");
  /* liujian 安全加固修改 2012-4-6 16:18:13 end */
	String iop_code     = request.getParameter("iop_code");	
	String icust_id     = WtcUtil.repNull(request.getParameter("i2")); 
	String iold_m_code  = WtcUtil.repNull(request.getParameter("iold_m_code"));         //现主套餐代码（老）
	String inew_m_code  = WtcUtil.repNull(request.getParameter("inew_m_code")); 		   //申请套餐代码
	String ibelong_code = WtcUtil.repNull(request.getParameter("belong_code"));   	   //belong_code
	String phoneno      = WtcUtil.repNull(request.getParameter("phone_no"));                  //电话号码
	String kexuancode   = WtcUtil.repNull(request.getParameter("kexuancode"));                  //可选套餐代码
	String cancalcode   = WtcUtil.repNull(request.getParameter("cancalcode"));                  //取消主套餐
	String ret_code     = "" ;                                                            //返回代码 
	String ret_msg      = "" ;                                                            //返回值
	String tbselect     = ""; 
	String[] inParas    = new String[]{""};
	String note         = "";
	String note1        = "";
	String offerAttrType = "";
	String expDateOffset = "";
	String matureCode    = "";															//到期后资费
	String mature_Name = "";
	System.out.println("-------------------------------icust_id---------------------"+icust_id);
	System.out.println("-------------------------------iold_m_code------------------------"+iold_m_code);
	System.out.println("-------------------------------inew_m_code--------------------------"+inew_m_code);
	System.out.println("-------------------------------ibelong_code--------------------------"+ibelong_code);
	System.out.println("-------------------------------phoneno-----------------------"+phoneno);
	System.out.println("-------------------------------iop_code--------------------------"+iop_code);
	inParas = new String[3];
	inParas[0] = regionCode;
	if(iop_code.equals("4205")){
		inParas[1] = kexuancode;
	}else{
		inParas[1] = inew_m_code;
	}
	inParas[2] = "";
%>
		<wtc:service name="s1270NoteNew" routerKey="region" routerValue="<%=regionCode%>" outnum="7" >
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=iop_code%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=op_strong_pwd%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>
			<wtc:param value="<%=inParas[2]%>"/>
			<wtc:param value="<%=groupId%>"/>
		</wtc:service>
		<wtc:array id="result3" scope="end"/>
<%
		
		if(result3!=null){
			if(result3.length>0){
				String before_mode_note = result3[0][4];
				String after_mature_note = result3[0][6];
				note= note+" "+before_mode_note;
				note1 = note1+" "+after_mature_note;
				matureCode = result3[0][5];
			}
		}
		
		note = note.replaceAll("\"","");
		note = note.replaceAll("\'","");
		note = note.replaceAll("\r\n","");
		note1 = note1.replaceAll("\"","");
		note1 = note1.replaceAll("\'","");	
		
		String sqlStr4 = "";
		sqlStr4 = "select offer_name from product_offer where offer_id ="+ matureCode ;
		System.out.println("testestetsetsetsetestsetesetsetsetestestesetest======"+sqlStr4);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
		<wtc:sql><%=sqlStr4%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result4" scope="end" />
<%
    mature_Name=result4.length>0?result4[0][0]:"";		
%>
	<wtc:service name="s1270Must" routerKey="region" routerValue="<%=regionCode%>" outnum="18" >
		<wtc:param value=""/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=iop_code%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=op_strong_pwd%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=ipower_right%>"/>
		<wtc:param value="<%=icust_id%>"/>
		<wtc:param value="<%=iold_m_code%>"/>
		<wtc:param value="<%=inew_m_code%>"/>
		<wtc:param value="<%=ibelong_code%>"/>						
	</wtc:service>
	<wtc:array id="result_must" start="0" length="4" scope="end"/>
	<wtc:array id="result_must_2" start="4" length="12" scope="end"/>
<%
	String zzfmc=""; //主资费名称
	if(result_must!=null&&result_must.length>0){
		ret_code = result_must[0][0];
		ret_msg = result_must[0][1];
		zzfmc = result_must[0][2];
		tbselect = result_must[0][3]; 
	}




	 /*
	 ****得到生效方式
	 ****127a:主自费预约取消  127b：主自费冲正  1204:数据卡冲正  k206：哈尔滨畅听套餐冲正 126c:预存赠机冲正 126i:签约赠机冲正 a207:哈尔滨畅听套餐取消
	 **/
	if(iop_code.equals("127a")||iop_code.equals("127b")||iop_code.equals("1204")||iop_code.equals("k206")||iop_code.equals("126c")||iop_code.equals("126i")||iop_code.equals("125c")||iop_code.equals("7118")||iop_code.equals("a207")||iop_code.equals("7117")||iop_code.equals("7119")||iop_code.equals("8046"))
	{
		tbselect = "0 24小时之内生效";
	}
		tbselect = "0 24小时之内生效";
	String printAccept=" ";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
	printAccept = sLoginAccept;
	String exeDate="";
	String dateSqlStr="";
	String flag = "";
	System.out.println("testestetsetsetsetestsetesetsetsetestestesetest="+tbselect);
	flag = tbselect.substring(0,1);
	if(flag.equals("0"))
	{
		if(iop_code.equals("1255") || iop_code.equals("1258"))
		{
			dateSqlStr = "select to_char(sysdate+1,'yyyymmdd')||' 0001' from dual";
		}else{
			dateSqlStr = "select to_char(sysdate,'yyyymmdd hh24mi') from dual";
		}
	}else if(flag.equals("1")){//预约生效
		if(iop_code.equals("1258"))
		{
			dateSqlStr = "select to_char(sysdate+1,'yyyymmdd')||' 0001' from dual";
		}else if(iop_code.equals("3530")){
			dateSqlStr = "select  to_char(add_months(sysdate,12),'yyyymmdd') from dual";
		}else if(iop_code.equals("1141")){
			dateSqlStr = "select  to_char(add_months(sysdate,11),'yyyymm') from dual";
		}else{
			dateSqlStr = "select  to_char(add_months(sysdate,1),'yyyymm')||'01 0001' from dual";
		}
	}
%>
	<wtc:pubselect name="sPubSelect"  outnum="1">
	<wtc:sql><%=dateSqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="time_result_0" scope="end" />
<%
	if(time_result_0!=null&&time_result_0.length>0){
		exeDate  = time_result_0[0][0];
	}
%>
<%
	/******************new add*********************/
	String goodbz="N";
	String modedxpay="";
	String sqlStrgood = "select mode_dxpay "+
		"from dgoodphoneres a, sGoodBillCfg b "+
		"where a.bill_code = b.mode_code "+
		" and b.region_code = '"+regionCode+"'"+
		" and a.phone_no = '"+phoneno+"' and b.valid_flag='Y' and a.bak_field='1' and end_time>sysdate and b.mode_dxpay>0";
	System.out.println("sqlStrgoodsqlStrgood="+sqlStrgood);
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:sql><%=sqlStrgood%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultx" scope="end" />
<%
	if(resultx!=null&&resultx.length>0){
		if(resultx[0][0].equals(""))
		{
			goodbz="N";
		}else{
			goodbz="Y";
			modedxpay = resultx[0][0];
			System.out.println(modedxpay);
		}
	}
	/***********************end*********************/
	String bdbz = "N";
	String bdts = "";
	String back_bz="";
	if(iop_code.equals("127b")||iop_code.equals("127a")||iop_code.equals("k206")||iop_code.equals("a198")||iop_code.equals("126c")||iop_code.equals("126i")||iop_code.equals("8035")||iop_code.equals("125c")||iop_code.equals("2282")||iop_code.equals("2265")||iop_code.equals("2284")||iop_code.equals("7118")||iop_code.equals("8071")||iop_code.equals("8043")||iop_code.equals("8045"))
	{
		back_bz="N";
	}else{
		back_bz="Y";
	}
	
	String[] inParas1 = new String[]{""};
	inParas1 = new String[4];
	inParas1[0] = regionCode;
	inParas1[1] = inew_m_code;
	inParas1[2] = back_bz;
	inParas1[3] = phoneno;
%>
	<wtc:service name="sModeBindDet" routerKey="region" routerValue="<%=regionCode%>" outnum="6" >
		<wtc:param value=""/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=iop_code%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=inParas1[3]%>"/>
		<wtc:param value=""/>				
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/>
		<wtc:param value="<%=inParas1[2]%>"/>
	</wtc:service>
	<wtc:array id="result4" scope="end"/>
<%
	if(result4!=null&&result4.length>0){
		String return_code1 = result4[0][0];
		String return_msg1 = result4[0][1];
		bdbz = result4[0][4];
		bdts = result4[0][5];
	}
	if(iop_code.equals("3250")||iop_code.equals("4205")||iop_code.equals("4208")){
			String sql11 = "";
			if(iop_code.equals("3250")){
				sql11 = "select offer_attr_type , exp_date_offset from product_offer	where offer_id ="+kexuancode;
			}else if(iop_code.equals("4205")){
				sql11 = "select offer_attr_type , exp_date_offset from product_offer	where offer_id ="+inew_m_code;	
			}else if(iop_code.equals("4208")){
				sql11 = "select offer_attr_type , exp_date_offset from product_offer	where offer_id ="+cancalcode;	
			}
			System.out.println("-------------------------------sql11---------------------"+sql11);
		%>
			<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				<wtc:sql><%=sql11%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result1" scope="end" />
		<%
			if(result1!=null&&result1.length>0){
				offerAttrType = result1[0][0] ;
				expDateOffset = result1[0][1] ;	
			}
	}
	System.out.println("-------------------------------modedxpay---------------------"+modedxpay);
	System.out.println("-------------------------------goodbz------------------------"+goodbz);
	System.out.println("-------------------------------bdbz--------------------------"+bdbz);
	System.out.println("-------------------------------bdts--------------------------"+bdts);
	System.out.println("-------------------------------exeDate-----------------------"+exeDate);
	System.out.println("-------------------------------note--------------------------"+note);
	System.out.println("-------------------------------note1-------------------------"+note1);	
	System.out.println("-------------------------------offerAttrType--------------------------"+offerAttrType);
	System.out.println("-------------------------------expDateOffset-------------------------"+expDateOffset);		
	System.out.println("-------------------------------matureCode--------------------------"+matureCode);
	System.out.println("-------------------------------mature_Name-------------------------"+mature_Name);			
%>
var response = new AJAXPacket();
response.data.add("errCode","<%=ret_code%>");
response.data.add("errMsg","<%=ret_msg%>");
response.data.add("modedxpay","<%=modedxpay%>");
response.data.add("goodbz","<%=goodbz%>");
response.data.add("bdbz","<%=bdbz%>");
response.data.add("bdts","<%=bdts%>");
response.data.add("exeDate","<%=exeDate%>");
response.data.add("note","<%=note%>");
response.data.add("note1","<%=note1%>");
response.data.add("offerAttrType","<%=offerAttrType%>");
response.data.add("expDateOffset","<%=expDateOffset%>");
response.data.add("matureCode","<%=matureCode%>");
response.data.add("mature_Name","<%=mature_Name%>");
core.ajax.receivePacket(response);
