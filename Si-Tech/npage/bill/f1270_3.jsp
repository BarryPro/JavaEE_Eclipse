 <%
	System.out.println("###################zhanghongzhanghong################System.currentTimeMillis()->"+System.currentTimeMillis());
%>
<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-20 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%String Readpaths = request.getRealPath("npage/properties")+"/getRDMessage.properties";%>
<html>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=GBK">
</HEAD>
<body>
<%
/** 注：变量的命名依据页面文本域的位置的先后顺序，如第一个文本域为i1，以此类推。
		部分变量的命名依据对此变量使用的意义，或用途。
*/%>
<%
		System.out.println("###################zhanghongzhanghong2################System.currentTimeMillis()->"+System.currentTimeMillis());
    String opCode = "1270";
		String opName = "主资费冲正";
		String opCode2 = (String)request.getParameter("opCode");
		String opName2 = (String)request.getParameter("opName");
		if (opCode2!= ""){
		    opCode = opCode2;
		    opName = opName2;
		}
		/* liujian 安全加固修改 2012-4-6 16:18:13 begin */
		String op_strong_pwd = (String) session.getAttribute("password");
	  /* liujian 安全加固修改 2012-4-6 16:18:13 end */
		String[][] favInfo = (String[][])session.getAttribute("favInfo");
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String subi20 = WtcUtil.repNull(request.getParameter("belong_code")).substring(0,2); //地区代码
		String groupId =(String)session.getAttribute("groupId");
		/**** tianyang add for pos start ****/
		String orgCode =(String)session.getAttribute("orgCode");
		String payType       = WtcUtil.repNull(request.getParameter("payType"));
		/*** ningtn 工商分期付款 分期付款期数**/
		String installmentNum = WtcUtil.repNull(request.getParameter("installmentList"));
		System.out.println("========= ningtn installmentNum["+installmentNum+"]");
		if(payType.equals("")){
			payType="0";
		}
		String Response_time = WtcUtil.repNull(request.getParameter("Response_time"));
		String TerminalId    = WtcUtil.repNull(request.getParameter("TerminalId"));
		String Rrn           = WtcUtil.repNull(request.getParameter("Rrn"));
		String Request_time  = WtcUtil.repNull(request.getParameter("Request_time"));
		String monitorValue  = WtcUtil.repNull(request.getParameter("monitorValue"));
		/**** tianyang add for pos end ****/
		//-----------wanghyd----start------------//增加判断参数为当非实名制的用户品牌转为神州行品牌时增加不给积分的提示。参数值为3时需要在免填单上打印提示
		String smzvalue  = WtcUtil.repNull(request.getParameter("smzvalue"));
	  //-----------wanghyd------end----------//
		String ret_code1 = "";
		String ret_msg1 = "";
		String ipower_right = ((String)session.getAttribute("powerRight")).trim();                         //登陆工号权限
		String icust_id = WtcUtil.repNull(request.getParameter("i2"));                            //客户ID
		String iold_m_code = WtcUtil.repNull(request.getParameter("i16"));         //现主套餐代码（老）
		if(iold_m_code.indexOf("-")!=-1){
			iold_m_code = iold_m_code.substring(0,iold_m_code.indexOf("-"));
		}
		System.out.println("=========ipower_right=========="+ipower_right);
		System.out.println("###################iold_m_codeiold_m_codeiold_m_codeiold_m_codeiold_m_code="+iold_m_code);
		String inew_m_code = WtcUtil.repNull(request.getParameter("ip"));             					  //申请主套餐代码(新)
		System.out.println("-----------------inew_m_code-------------------"+inew_m_code);
		String ibelong_code = WtcUtil.repNull(request.getParameter("belong_code"));   						//belong_code
		String print_note = WtcUtil.repNull(request.getParameter("print_note"));      						//工单广告词
		String iop_code = WtcUtil.repNull(request.getParameter("iOpCode"));                       //工号,非常重要
		System.out.println("12703-----------------iop_code-------------------"+iop_code);

		String next_mode = WtcUtil.repNull(request.getParameter("next_mode"));
		System.out.println("-----------------next_mode-------------------"+next_mode);
		String NextNew_m_code = WtcUtil.repNull(request.getParameter("Nmode_code"));
		System.out.println("-----------------NextNew_m_code-------------------"+NextNew_m_code);
		String nextName = "",new_smCode="";

		if(iop_code == "1200"){
			String next_begin = WtcUtil.repNull(request.getParameter("next_begin"));				//下档资费开始时间
		}
		String e505_sale_name = ""; //liujian 阶段活动名称
		String sale_name = ""; //liujian 阶段活动名称
		String new_Mode_Name = WtcUtil.repNull(request.getParameter("new_Mode_Name")); //新资费代码和名称
		System.out.println("-----------------new_Mode_Name-------------------"+new_Mode_Name);
		opCode=iop_code;
		String regionCode = ibelong_code.substring(0,2);
		String sqlStr2 = "";
		String erpi = "";
		String note="";
		String note1="";
		String daima = "";
		String erpi_flag=WtcUtil.repNull(request.getParameter("flag_code"));
		System.out.println("erpi_flag="+erpi_flag);
		System.out.println("###################zhanghongzhanghong3################System.currentTimeMillis()->"+System.currentTimeMillis());
		//增加参数区分网站预约和前台办理 ningtn
		String banlitype =request.getParameter("banlitype");
			erpi = erpi_flag;
			String[] inParas = new String[]{""};
			inParas = new String[3];
			inParas[0] = regionCode;
			inParas[1] = inew_m_code;
			inParas[2] = erpi;
			//value = viewBean.callService("0", null, "s1270ModeNote", "7", inParas);
			System.out.println("###################zhanghongzhanghong7################System.currentTimeMillis()->"+System.currentTimeMillis());
%>
		<wtc:service name="s1270NoteNew" routerKey="region" routerValue="<%=regionCode%>" outnum="7" >
			<wtc:param value=""/>
			<wtc:param value="01"/>
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

	System.out.println("###################zhanghongzhanghong8################System.currentTimeMillis()->"+System.currentTimeMillis());
			if(result3!=null){
				if(result3.length>0){
						String before_mode_note = result3[0][4];
						String after_mature_note = result3[0][6];
						daima = daima +" "+erpi;
						note= note+" "+before_mode_note;
						note1 = note1+" "+after_mature_note;
						System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						System.out.println("before_mode_note="+before_mode_note);
						System.out.println("note="+note);
				}
			}

		note = note.replaceAll("\"","");
		note = note.replaceAll("\'","");
		note = note.replaceAll("\r\n","");
		note1 = note1.replaceAll("\"","");
		note1 = note1.replaceAll("\'","");


		String tbselect = "";

		/**********设置表头**************/
		String titleStr="";
		String showFlag = "style=\"display:block\"";
		if(iop_code.equals("1198"))
		{
			titleStr = "哈尔滨畅听套餐续签冲正";
			showFlag = "style=\"display:none\"";
		}else if(iop_code.equals("1200"))
		{
		   titleStr = "哈尔滨畅听套餐续签";
           showFlag = "style=\"display:none\"";
		}else if(iop_code.equals("1205"))
		{
		   titleStr = "哈尔滨畅听套餐";
		}else if(iop_code.equals("1206"))
		{
		   titleStr = "哈尔滨畅听冲正";
           showFlag = "style=\"display:none\"";
		}else if(iop_code.equals("1207"))
		{
		   titleStr = "哈尔滨畅听取消";
		}else if(iop_code.equals("126b"))
		{
		   titleStr = "预存话费赠机";
		}
		else if(iop_code.equals("126c"))
		{
		   titleStr = "预存话费赠机冲正";
		   showFlag = "style=\"display:none\"";
		}else if(iop_code.equals("8034"))
		{
		   titleStr = "建设新农村、手机乐万家";
		}
		else if(iop_code.equals("8035"))
		{
		   titleStr = "建设新农村、手机乐万家冲正";
		    showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("8070"))
		{
		   titleStr = "致富信息机营销案";
		}
		else if(iop_code.equals("8071"))
		{
		   titleStr = "致富信息机营销案冲正";
		    showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("8042"))
		{
		   titleStr = "预存送手机、话费共分享";
		}
		else if(iop_code.equals("8043"))
		{
		   titleStr = "预存送手机、话费共分享冲正";
		    showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("7671"))
		{
		   titleStr = "预存赠固话、话费可分享";
		}
		else if(iop_code.equals("7672"))
		{
		   titleStr = "预存赠固话、话费可分享冲正";
		    showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("8044"))
		{
		   titleStr = "欢乐新农村神州行手机营销";
		}
		else if(iop_code.equals("8045"))
		{
		   titleStr = "欢乐新农村神州行手机营销冲正";
		    showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("126h"))
		{
		   titleStr = "签约赠机";
		}
		else if(iop_code.equals("126i"))
		{
		   titleStr = "签约赠机冲正";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("7960"))
		{
		   titleStr = "彩铃营销案申请";
		}
		else if(iop_code.equals("7964"))
		{
		   titleStr = "彩铃营销案冲正";
		}
		else if(iop_code.equals("7965"))
		{
		   titleStr = "彩铃营销案续签";
		}
		else if(iop_code.equals("7966"))
		{
		   titleStr = "彩铃营销案续签冲正";
		}
		else if(iop_code.equals("7967"))
		{
		   titleStr = "彩铃营销案取消";
		}
		else if(iop_code.equals("8023"))
		{
		   titleStr = "集团客户预存赠机申请";
		}
		else if(iop_code.equals("8024"))
		{
		   titleStr = "集团客户预存赠机冲正";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("8094"))
		{
		   titleStr = "特殊号码资费营销案申请";
		}
		else if(iop_code.equals("8091"))
		{
		   titleStr = "特殊号码资费营销案冲正";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("2264"))
		{
		   titleStr = "动感地带签约赠礼品";
		}

		else if(iop_code.equals("2265"))
		{
		   titleStr = "动感地带签约赠礼品冲正";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("2281"))
		{
		   titleStr = "签约赠礼品";
		}
		else if(iop_code.equals("2282"))
		{
		   titleStr = "签约赠礼品冲正";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("2283"))
		{
		   titleStr = "全球通签约送礼";
		}
		else if(iop_code.equals("2284"))
		{
		   titleStr = "全球通签约送礼冲正";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("7371"))
		{
		   titleStr = "预存优惠上网费用营销案";
		}
		else if(iop_code.equals("7374"))
		{
		   titleStr = "预存优惠上网费用营销案冲正";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("7981"))
		{
		   titleStr = "购TD固话赠通信费";
		}
		else if(iop_code.equals("7982"))
		{
		   titleStr = "购TD固话赠通信费冲正";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("8551"))
		{
		   titleStr = "购TD固话赠通信费(铁通)";
		}
		else if(iop_code.equals("8552"))
		{
		   titleStr = "购TD固话赠通信费(铁通)冲正";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("g068"))
		{
		   titleStr = "TD固话自备机入网";
		}
		else if(iop_code.equals("g069"))
		{
		   titleStr = "TD固话自备机入网冲正";
		   showFlag = "style=\"display:none\"";
		}		
		else if(iop_code.equals("7898"))
		{
		   titleStr = "预存话费赠TD商务固话";
		}
		else if(iop_code.equals("7899"))
		{
		   titleStr = "预存话费赠TD商务固话冲正";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("7688"))
		{
		   titleStr = "预存话费赠TD商务固话(铁通)";
		}
		else if(iop_code.equals("7689"))
		{
		   titleStr = "预存话费赠TD商务固话(铁通)冲正";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("8688"))
		{
		   titleStr = "TD固话主资费变更";
		}
		else if(iop_code.equals("8687"))
		{
		   titleStr = "TD商务固话主资费变更";
		}
		else if(iop_code.equals("7379"))
		{
		   titleStr = "预存优惠购卡营销案";
		}
		else if(iop_code.equals("7382"))
		{
		   titleStr = "预存优惠购卡营销案冲正";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("7975"))
		{
		   titleStr = "商务宝营销案";
		}
		else if(iop_code.equals("7976"))
		{
		   titleStr = "商务宝营销案冲正";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("7116"))
		{
		   titleStr = "数据卡包年";
		}
		else if(iop_code.equals("7118"))
		{
		   titleStr = "数据卡包年冲正";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("1208"))
		{
		   titleStr = "七台河GPRS包年";
		}else if(iop_code.equals("1253"))
		{
		   titleStr = "爱心卡申请";
		}else if(iop_code.equals("1254"))
		{
		   titleStr = "爱心卡取消";
		}else if(iop_code.equals("7977"))
		{
		   titleStr = "神州行助老爱心卡申请";
		}else if(iop_code.equals("7978"))
		{
		   titleStr = "神州行助老爱心卡取消";
		}else if(iop_code.equals("127a"))
		{
		   titleStr = "主资费预约取消";
		   showFlag = "style=\"display:none\"";
		}else if(iop_code.equals("127b"))
		{
		   titleStr = "主资费冲正";
		   showFlag = "style=\"display:none\"";
		}else if(iop_code.equals("125b"))
		{
		   titleStr = "动感月租包年";
		}else if(iop_code.equals("125c"))
		{
		   titleStr = "动感月租包年冲正";
		   showFlag = "style=\"display:none\"";
		}else if(iop_code.equals("7117"))
		{
		   titleStr = "数据业务包年取消";
		}else if(iop_code.equals("7119"))
		{
		   titleStr = "动感月租包年取消";
		}else if(iop_code.equals("8046"))
		{
		   titleStr = "营销案取消";
		}else if(iop_code.equals("8027"))
		{
		   titleStr = "买手机,送话费";
		}else if(iop_code.equals("8028"))
		{
		   titleStr = "买手机,送话费冲正";
		}else if(iop_code.equals("e505"))
		{
		   titleStr = "合约计划购机";
			 e505_sale_name = WtcUtil.repNull(request.getParameter("e505_sale_name"));
		   if(e505_sale_name == null) {
	    		e505_sale_name = "";
	  	 }
		}else if(iop_code.equals("e506"))
		{
		   titleStr = "合约计划购机冲正";
		   e505_sale_name = WtcUtil.repNull(request.getParameter("e505_sale_name"));
		   if(e505_sale_name == null) {
		   		e505_sale_name = "";
		  	}
		}else if(iop_code.equals("e528"))
		{
		   titleStr = "自备机合约计划";
			 sale_name = WtcUtil.repNull(request.getParameter("sale_name"));
		   if(sale_name == null) {
	    		sale_name = "";
	  	 }
		}else if(iop_code.equals("e529"))
		{
		   titleStr = "自备机合约计划冲正";
		   sale_name = WtcUtil.repNull(request.getParameter("sale_name"));
		   if(sale_name == null) {
		   		sale_name = "";
		  	}
		}
		else if(iop_code.equals("e720"))
		{
		   titleStr = "购机入网-让利计划";
			 sale_name = WtcUtil.repNull(request.getParameter("sale_name"));
		   if(sale_name == null) {
	    		sale_name = "";
	  	 }
	  	 }
	  	else if(iop_code.equals("e721"))
		{
		   titleStr = "购机入网-让利计划冲正";
			 sale_name = WtcUtil.repNull(request.getParameter("sale_name"));
		   if(sale_name == null) {
	    		sale_name = "";
	  	 }
	  	}else if(iop_code.equals("g122")){
		   titleStr = "购TD商务固话赠通信费";
	  	}else if(iop_code.equals("g123")){
		   titleStr = "购TD商务固话赠通信费冲正";
	  	}else if(iop_code.equals("g124")){
		   titleStr = "购TD商务固话赠通信费(铁通)";
	  	}else if(iop_code.equals("g125")){
		   titleStr = "购TD商务固话赠通信费(铁通)冲正";
	  	}
		else
		{
		   titleStr = "主资费变更SAAAA";
		}
		if(iop_code.equals("7960") || iop_code.equals("7965"))
		{
			/***********gonght add 2009-3-20 14:50:27 ***********/
		    //SPubCallSvrImpl co = new SPubCallSvrImpl();
			String  inputParsm [] = new String[1];
		    String sqlStr4 = "select offer_name from product_offer where  offer_id="+next_mode+"";
			inputParsm[0] = sqlStr4;
		%>
				<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
				<wtc:param value="<%=sqlStr4%>"/>
				</wtc:service>
				<wtc:array id="result0" scope="end" />
		<%
			nextName = WtcUtil.repNull(result0[0][0]);
			/***************gonght add end***************/
		if(iop_code.equals("7965"))
			inew_m_code = NextNew_m_code;
		String  inputParemeter [] = new String[1];
		String sqlString = "select sm_code from product_offer a,band b where a.band_id = b.band_id and a.offer_id="+inew_m_code+"";
		%>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
				<wtc:param value="<%=sqlString%>"/>
				</wtc:service>
				<wtc:array id="result1" scope="end" />
		<%
			new_smCode = WtcUtil.repNull(result1[0][0]);

		}
System.out.println("###################zhanghongzhanghong9################System.currentTimeMillis()->"+System.currentTimeMillis());
		/******************************准备调用s1270Must服务生成循环列表******************************/
		//getList_must = callView.s1270MustProcess(ipower_right,icust_id,iold_m_code, inew_m_code,ibelong_code,iop_code).getList();
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
		System.out.println("###################zhanghongzhanghong10################System.currentTimeMillis()->"+System.currentTimeMillis());
		String zzfmc=""; //主资费名称
		if(result_must!=null&&result_must.length>0){
				ret_code1 = result_must[0][0];
    		ret_msg1 = result_must[0][1];
    		zzfmc = result_must[0][2];
    		tbselect = result_must[0][3]; //生效时间,用于工单打印
				System.out.println("----tbselect------lj---------tbselect=" + tbselect);    		
		}

	    //对返回信息的控制
		if(ret_msg1.equals(""))
		{
			ret_msg1 = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code1));
			if( ret_msg1.equals("null"))
			{
				ret_msg1 ="未知错误信息";
			}
		}

		if(!ret_code1.equals("000000")){
%>
	<script language="JavaScript">
			var ret_code = "<%=ret_code1%>";
			var ret_msg = "<%=ret_msg1%>";
			rdShowMessageDialog("查询错误！<br>错误代码：'<%=ret_code1%>'。<br>错误信息：'<%=ret_msg1%>'。");
			<%
				if(iop_code.equals("e505") || iop_code.equals("e506")) {
					String phone = WtcUtil.repNull(request.getParameter("i1")); 
			%>
					location = "/npage/se505/se505_login.jsp?activePhone=<%=phone%>&opCode=<%=iop_code%>&opName=<%=opName%>";
			<%
				}else if(iop_code.equals("e528") || iop_code.equals("e529")) {
					String phone = WtcUtil.repNull(request.getParameter("i1")); 
			%>
					location = "/npage/se528/se528_login.jsp?activePhone=<%=phone%>&opCode=<%=iop_code%>&opName=<%=opName%>";
			<%
				}else if(iop_code.equals("e720") || iop_code.equals("e721")) {
					String phone = WtcUtil.repNull(request.getParameter("i1")); 
			%>
					location = "/npage/se720/fE720Login.jsp?activePhone=<%=phone%>&opCode=<%=iop_code%>&opName=<%=opName%>";
			<%
				}else {
			%>
					history.go(-1);
			<%		
				} 
			%>
  </script>
<%
		return;
		}

		//getList_must_1.add(0,getList_must.get(1));

    /*
		 ****得到生效方式
		 ****127a:主自费预约取消  127b：主自费冲正  1204:数据卡冲正  k206：哈尔滨畅听套餐冲正 126c:预存赠机冲正 126i:签约赠机冲正 a207:哈尔滨畅听套餐取消
		
		if(iop_code.equals("127a")||iop_code.equals("127b")||iop_code.equals("1204")||iop_code.equals("1206")||iop_code.equals("126c")||iop_code.equals("126i")||iop_code.equals("125c")||iop_code.equals("7118")||iop_code.equals("1207")||iop_code.equals("7117")||iop_code.equals("7119")||iop_code.equals("8046")||iop_code.equals("7977")||iop_code.equals("7978")||iop_code.equals("7981")||iop_code.equals("7898")||iop_code.equals("g068")||iop_code.equals("7982")||iop_code.equals("7899")||iop_code.equals("g069")||iop_code.equals("7671")||iop_code.equals("7672")||iop_code.equals("8551")||iop_code.equals("8552")||iop_code.equals("7688")||iop_code.equals("7689"))
		{
		     tbselect = "0 24小时之内生效";
		}
 **/
		/****得到打印流水****/
		String printAccept="";
		System.out.println("###################zhanghongzhanghong11################System.currentTimeMillis()->"+System.currentTimeMillis());
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
		System.out.println("###################zhanghongzhanghong12################System.currentTimeMillis()->"+System.currentTimeMillis());
		printAccept = sLoginAccept;
		/****得到生效时间,用于工单打印****/
		String exeDate="";
		String dateSqlStr="";
		String flag = "";
		System.out.println("-------------------------tbselect-----------------"+tbselect);
		flag = tbselect.substring(0,1);
	  if(flag.equals("0"))
	  {
		  if(iop_code.equals("1255") || iop_code.equals("1258"))
		  {
		    dateSqlStr = "select to_char(sysdate+1,'yyyymmdd')||' 0001' from dual";
		  }else{
		    dateSqlStr = "select to_char(sysdate,'yyyymmdd hh24mi') from dual";
		  }
	  }else if(flag.equals("2")){//预约生效
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
	  }else if(flag.equals("1")){//第二天生效
		    dateSqlStr = "select  to_char(sysdate+1,'yyyymm')||'01 0001' from dual";
	  }else{
	  		dateSqlStr = "select  to_char(sysdate+1,'yyyymm')||'01 0001' from dual";
	  }
	  System.out.println("dateSqlStr||||||||"+dateSqlStr);
	  System.out.println("###################zhanghongzhanghong13################System.currentTimeMillis()->"+System.currentTimeMillis());
%>
		<wtc:pubselect name="sPubSelect"  outnum="1">
		<wtc:sql><%=dateSqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="time_result_0" scope="end" />
<%
	System.out.println("###################zhanghongzhanghong15################System.currentTimeMillis()->"+System.currentTimeMillis());
	  if(time_result_0!=null&&time_result_0.length>0){
			exeDate  = time_result_0[0][0];
		}
		System.out.println("exeDate==============================+++++++"+exeDate);
%>
<%
	/******************new add*********************/
	String goodbz="";
	String phone_good=WtcUtil.repNull(request.getParameter("i1"));
	String modedxpay="";
	String sqlStrgood = "select mode_dxpay "+
  						 "from dgoodphoneres a, sGoodBillCfg b "+
 						 "where a.bill_code = b.mode_code "+
   						 " and b.region_code = '"+regionCode+"'"+
   						 " and a.phone_no = '"+phone_good+"' and b.valid_flag='Y' and a.bak_field='1' and end_time>sysdate and b.mode_dxpay>0";
  System.out.println("############################f1270_3->sqlStrgood->"+sqlStrgood);
	System.out.println("###################zhanghongzhanghong16################System.currentTimeMillis()->"+System.currentTimeMillis());
%>
		<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:sql><%=sqlStrgood%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultx" scope="end" />
<%
		System.out.println("###################zhanghongzhanghong17################System.currentTimeMillis()->"+System.currentTimeMillis());
		if(resultx!=null&&resultx.length>0){
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
		/***********************end*********************/
		String bdbz = "N";
		String bdts = "";
		/******************liucm add 资费捆来电提示********************/
		String back_bz="";
		String phoneno=WtcUtil.repNull(request.getParameter("i1"));
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
			//value1= viewBean1.callService("0", null, "sModeBindDet", "6", inParas1);
			System.out.println("###################zhanghongzhanghong18################System.currentTimeMillis()->"+System.currentTimeMillis());
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
		System.out.println("###################zhanghongzhanghong19################System.currentTimeMillis()->"+System.currentTimeMillis());
		if(result4!=null&&result4.length>0){
			String return_code1 = result4[0][0];
			String return_msg1 = result4[0][1];
			bdbz = result4[0][4];
			bdts = result4[0][5];
			System.out.println("lcmlcmlcmlcmlcmbdbz="+bdbz);
			System.out.println("lcmlcmlcmlcmlcmbdts="+bdts);
		}
		/**************liucm add end ************/

			String loginNote="";
			String sqlStr9 = "select back_char1 from snotecode where region_code='"+regionCode+"' and op_code='XXXX'";
			System.out.println("###################zhanghongzhanghong20################System.currentTimeMillis()->"+System.currentTimeMillis());
%>
			<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1">
			<wtc:sql><%=sqlStr9%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result9" scope="end" />
<%
	System.out.println("###################zhanghongzhanghong21################System.currentTimeMillis()->"+System.currentTimeMillis());
      for(int i=0;i<result9.length;i++){
				 loginNote = (result9[i][0]).trim();
			}
			loginNote = loginNote.replaceAll("\"","");
			loginNote = loginNote.replaceAll("\'","");
			loginNote = loginNote.replaceAll("\r\n","   ");
			loginNote = loginNote.replaceAll("\r","   ");
			loginNote = loginNote.replaceAll("\n","   ");
%>
<%@ include file="/npage/include/header.jsp" %>
<form action="" method=post name="form1">
	    <input type="hidden" name="monitorValue" value="<%=monitorValue%>"/>
	    <input type="hidden" id="iInstNum" name="iInstNum" value=""/>
			<input type="hidden" name="e505_sale_name" id="e505_sale_name">
			<input type="hidden" name="sale_name" id="sale_name">
			<input type="hidden" name="mon_prepay_limit" id="mon_prepay_limit">
      <input type="hidden" name="cust_info">
      <input type="hidden" name="opr_info">
      <input type="hidden" name="note_info1">
      <input type="hidden" name="haseval">
      <input type="hidden" name="evalcode">
      <input type="hidden" name="note_info2">
      <input type="hidden" name="note_info3">
      <input type="hidden" name="note_info4">
      <input type="hidden" name="printcount">
			<!-- tianyang add at 20100201 for POS缴费需求*****start*****-->			
			<input type="hidden" name="payType"  value="<%=payType%>" ><!-- 缴费类型 payType=BX 是建行 payType=BY 是工行 -->			
			<input type="hidden" name="MerchantNameChs"  value=""><!-- 从此开始以下为银行参数 -->
			<input type="hidden" name="MerchantId"  value="">
			<input type="hidden" name="TerminalId"  value="">
			<input type="hidden" name="IssCode"  value="">
			<input type="hidden" name="AcqCode"  value="">
			<input type="hidden" name="CardNo"  value="">
			<input type="hidden" name="BatchNo"  value="">
			<input type="hidden" name="Response_time"  value="">
			<input type="hidden" name="Rrn"  value="">
			<input type="hidden" name="AuthNo"  value="">
			<input type="hidden" name="TraceNo"  value="">
			<input type="hidden" name="Request_time"  value="">
			<input type="hidden" name="CardNoPingBi"  value="">
			<input type="hidden" name="ExpDate"  value="">
			<input type="hidden" name="Remak"  value="">
			<input type="hidden" name="TC"  value="">
			<input type="hidden" name="transType"  value=""><!-- 银行侧交易类型 -->
			<input type="hidden" name="bMoney"  value=""><!-- 交易金额 -->
			<input type="hidden" name="transTotal" id="transTotal"  value=""><!-- 交易总账 -->
			<!-- tianyang add at 20100201 for POS缴费需求*****end*******-->
			<input type="hidden" name="yhje_8046" id="yhje_8046"  value=""><!-- 客户需交纳的补已优惠金额 -->
		<div class="title">
			<div id="title_zi">用户信息</div>
		</div>
      			<table cellspacing="0">
      				 <tr>
      				 	<td class="blue" width="15%">服务号码</td>
      				 	<td width="35%">
      				 		<input name="phone" class="InputGrey" readonly value="<%=WtcUtil.repNull(request.getParameter("i1"))%>" size="20">
      				 	</td>
      				 	<td class="blue" width="15%">客户名称</td>
      				 	<td>
      				 		<input name="i4" size="20" maxlength=30 class="InputGrey" readonly value="<%=WtcUtil.repNull(request.getParameter("i4"))%>">
      				 	</td>
      				 	<!--设置为隐藏  客户ID，客户地址，证件类型名称，证件号码，belong_code,-->
				 				<input type="hidden" name="i2" size="20"  value="<%=WtcUtil.repNull(request.getParameter("i2"))%>" maxlength=30  readonly >
				 				<input type="hidden" name="i5" size="60" maxlength=60 value="<%=WtcUtil.repNull(request.getParameter("i5"))%>" readonly>
				 				<!--客户地址-->
				 				<input type="hidden" name="i6" size="20" maxlength=30 value="<%=WtcUtil.repNull(request.getParameter("i6"))%>" readonly>
				 				<!--证件类型-->
 								<input type="hidden" name="i7" size="20" maxlength=30 value="<%=WtcUtil.repNull(request.getParameter("i7"))%>" readonly>
 								<!--证件号码-->
 								<input type="hidden" name="belong_code" value="<%=WtcUtil.repNull(request.getParameter("belong_code"))%>">
 								<input type="hidden" name="maincash_no" value="<%=WtcUtil.repNull(request.getParameter("maincash_no"))%>">
 								<input type="hidden" name="kx_code_bunch">
 								<!--可选资费代码串-->
 								<input type="hidden" name="kx_habitus_bunch">
 								<!--可选资费状态串-->
 								<input type="hidden" name="kx_operation_bunch">
 								<!--可选套餐的生效方式串-->
 								<input type="hidden" name="kx_explan_bunch">
 								<!--可选套餐说明-->
 								<input type="hidden" name="kx_code_name_bunch">
 								<!--可选套餐名称-->
 								<input type="hidden" name="kx_erpi_bunch">
 								<!--可选套餐二批-->
					      <input type="hidden" name="toprintdata">
					      <input type="hidden" name="stream" value="<%=printAccept%>">
					      <input type="hidden" name="handcash" value="<%=WtcUtil.repNull(request.getParameter("i19"))%>">
					      <input type="hidden" name="kx_stream_bunch"><!--原可选套餐的开通流水串-->
					      <input type="hidden" name="main_cash_stream" value="<%=WtcUtil.repNull(request.getParameter("imain_stream"))%>">
					      <input type="hidden" name="next_main_cash" value="<%=WtcUtil.repNull(request.getParameter("i18"))%>">
					      <input type="hidden" name="next_main_stream" value="<%=WtcUtil.repNull(request.getParameter("next_main_stream"))%>">
					      <input type="hidden" name="kx_want"><!--打印－所有申请操作--->
					      <input type="hidden" name="kx_cancle"><!--打印－所有取消操作--->
					      <input type="hidden" name="kx_running"><!--打印－所有开通的套餐--->
					      <input type="hidden" name="i1" value="<%=WtcUtil.repNull(request.getParameter("i1"))%>"><!--获得前一页面传来的phone_no--->
					      <input type="hidden" name="ipassword" value="<%=WtcUtil.repNull(request.getParameter("ipassword"))%>">
					      <!--获得前一页面传来的password--->
					      <input type="hidden" name="iAddStr" value="<%=WtcUtil.repNull(request.getParameter("iAddStr"))%>">
					      <input type="hidden" name="iOpCode" value="<%=WtcUtil.repNull(request.getParameter("iOpCode"))%>">
					      <input type="hidden" name="opCode" value="<%=opCode%>">
		                  <input type="hidden" name="opName" value="<%=opName%>">
					      <input type="hidden" name="favorcode" value="<%=WtcUtil.repNull(request.getParameter("favorcode"))%>">
					      <!--获得前一页面传来的favorcode--->
					      <input type="hidden" name="iAddRateStr" value="<%=WtcUtil.repNull(request.getParameter("iAddRateStr"))%>">
					      <!--获得前一页面传来的iAddRateStr--->
					      <input type="hidden" name="beforeOpCode" value="<%=WtcUtil.repNull(request.getParameter("beforeOpCode"))%>">
					      <!--冲正时传送对应申请业务的opCode--->
						  <input type="hidden" name="modestr">
					  <input type ="hidden" name ="hljNotePrint" value="">
					  <input type="hidden" name="flag_code" value="<%=WtcUtil.repNull(request.getParameter("flag_code"))%>">
					  <input type="hidden" name="rateCode" value="<%=WtcUtil.repNull(request.getParameter("rate_code"))%>">
					  <input type="hidden" name="returnPage" value="<%=WtcUtil.repNull(request.getParameter("return_page"))%>">
					  <input type="hidden" name="next_begin" value="<%=WtcUtil.repNull(request.getParameter("next_begin"))%>">
					  <input type="hidden" name="ipAddr" value="<%=WtcUtil.repNull(request.getParameter("ipAddr"))%>">
					  <input type="hidden" name="banlitype" value="<%=banlitype%>">
                 </tr>

	      		 <tr>
					 <td class="blue" width="15%">集团客户类别</td>
					 <td width="35%">
					   <input name="group_type" size="20" value="<%=WtcUtil.repNull(request.getParameter("group_type"))%>" class="InputGrey" readonly>
					 </td>
					 <td class="blue" width="15%">大客户类别</td>
					 <td width="35%">
					   <font class="orange"><%=WtcUtil.repNull(request.getParameter("ibig_cust"))%></font>
					 </td>
			    </tr>
				  <tr>
					 <td class="blue">当前主套餐</td>
					 <td id="showHitz1">
					   <input name="i16" size="30" value="<%=WtcUtil.repNull(request.getParameter("i16"))%>" class="InputGrey" readonly>
					 </td>
					 <td class="blue">下月主套餐</td>
					 <td id="showHitz2">
					  <input name="i18" size="30" value="<%=WtcUtil.repNull(request.getParameter("i18"))%>" class="InputGrey" readonly>
					 </td>
				  </tr>

			  	<tr>
                 <td class="blue" width="15%">申请主套餐</td>
			     <td width="35%" id="showHitz">
                   <input type="text" name="ip" value="<%=WtcUtil.repNull(request.getParameter("ip"))%>" size="40" class="InputGrey" readonly >
			       <script>
			         document.all.ip.value=document.all.ip.value+' <%=zzfmc%>';
			       </script>
                 </td>
			     <td class="blue" width="15%">生效方式</td>
			     <td width="35%">
			       <input type="text" name="tbselect" value="<%=tbselect%>" size="20" class="InputGrey" readonly v_must =1 v_name=生效方式>
			     </td>
				</tr>
		      <%
			    String favorcode = WtcUtil.repNull(request.getParameter("favorcode"));
			    int m =0;
			    for(int p = 0;p< favInfo.length;p++){//优惠资费代码
						for(int q = 0;q< favInfo[p].length;q++){
							 if(favInfo[p][q].trim().equals(favorcode)){
								   ++m;
							 }
						}
		          }
	 		  %>
		      		<tr>
		      <%
		      	if(m != 0){
		      %>
 					 <td class="blue" width="15%">手续费</td>
					 <td colspan="3">
					   <input name="i19" size="20" maxlength=20 value="<%=WtcUtil.repNull(request.getParameter("i19"))%>" v_must=1 v_name=手续费 v_type=float >
					   <input type="hidden" name="i20" size="20"maxlength=20 value="<%=WtcUtil.repNull(request.getParameter("i20"))%>" readonly v_name=最高手续费>
					 </td>
					 <script language="jscript">
					   document.all.i19.focus();
					 </script>
		      <%
		      	}else{
		      %>
					 <td class="blue" width="15%">手续费</td>
					 <td colspan="3">
					   <input name="i19" size="20" maxlength=20 value="<%=WtcUtil.repNull(request.getParameter("i19"))%>" v_must=1 v_name=手续费 v_type=float class="InputGrey" readonly>
					   <input type="hidden" name="i20" size="20"maxlength=20 value="<%=WtcUtil.repNull(request.getParameter("i20"))%>" readonly v_name=最高手续费>
					 </td>
		      <%
		      	}
		      %>
		      		</tr>
		      		<tr <%=showFlag%>>
								 <td class="blue" width="15%">可选套餐类别</td>
								 <td colspan="3">
                          <%
								String sm_code = WtcUtil.repNull(request.getParameter("i8")).substring(0,2);//获得业务品牌
								System.out.println("------------------------sm_code---------------------"+sm_code);
								String sqlStr="";
						        //sqlStr ="SELECT a.offer_attr_type, c.name, a.min_num, a.max_num  FROM product_offer a, product_offer_detail b , offer_category c  WHERE a.offer_id = b.offer_id AND a.offer_type = '40' and a.offer_attr_type NOT IN ('YnD3', 'YnD4') and a.offer_attr_type = c.offer_attr_type and c.region_code='"+WtcUtil.repNull(request.getParameter("belong_code")).substring(0,2)+"' and a.offer_id="+WtcUtil.repNull(request.getParameter("ip")).trim()+" ";

										sqlStr =" SELECT a.offer_detail_role_cd,d.mem_role_name,c.role_down_num,c.role_up_num,b.offer_attr_type  "
										+" FROM product_offer_detail a,product_offer b,PROD_OFFER_DETAIL_ROLE c, group_mbr_role d "
										+" WHERE a.element_type = '10C' "
										+" AND a.offer_id = "+WtcUtil.repNull(request.getParameter("ip")).trim()+" "
										+" AND a.sel_flag = '2' "
										+" AND a.state = 'A'  "
										+" AND a.element_id = b.offer_id"
										+" AND SYSDATE BETWEEN b.eff_date AND b.exp_date              "
										+" AND b.state = 'A' "
										+" and a.offer_detail_role_cd = c.offer_detail_role_cd "
										+" and b.offer_attr_type not in ('YnD3','YnD4') "
										+" and c.mem_role_cd = d.mem_role_cd "
										+" and exists (select 1 from product_offer_scene where op_code = '"+iop_code+"' and b.offer_id = offer_id)";
										if(sm_code.equals("gn")||sm_code.equals("hn")||sm_code.equals("dn")||sm_code.equals("d0")||sm_code.equals("cb")||sm_code.equals("zn"))
										{
											sqlStr +=" and b.band_id in('21','23','24')";
										}
										if(sm_code.equals("ip"))
										{
											sqlStr +=" and b.band_id in('29')";
										}
						        sqlStr +=" group by a.offer_detail_role_cd,d.mem_role_name,c.role_down_num,c.role_up_num, b.offer_attr_type";
						        System.out.println("yanpxsqlStr==="+sqlStr);
						        System.out.println("###################zhanghongzhanghong22################System.currentTimeMillis()->"+System.currentTimeMillis());
							 %>
	 							<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="5">
								<wtc:sql><%=sqlStr%></wtc:sql>
								</wtc:pubselect>
								<wtc:array id="result_select" scope="end" />
							    <%
							 		System.out.println("###################zhanghongzhanghong23################System.currentTimeMillis()->"+System.currentTimeMillis());
							        int recordNum = result_select.length;
							        System.out.println("recordNum等于:"+sqlStr);
							        for(int i=0;i<recordNum;i++){
								        //System.out.println("wwwwwwwwwwwww");
										//System.out.println(result_select[i][0]);
										//System.out.println(result_select[i][1]);
									    out.println("<a Href='#' onClick='openwindow("+'"'+
									          +i+'"'+","+'"'+result_select[i][4]+'"'+","+'"'+result_select[i][1]+'"'+")'>"+result_select[i][0]+" "+result_select[i][1]+"</a>");
									    out.println("<input type=hidden name=oActualOpen value='0'>");    //实际开通的数
										out.println("<input type=hidden name=oDefaultFlag value='N'>");   //是否有默认申请的配置
										out.println("<input type=hidden name=oDefaultOpen value='N'>");   //是否默认申请是否存在一个申请
										out.println("<input type=hidden name=oTypeValue value="+result_select[i][0]+">");
										out.println("<input type=hidden name=oTypeName value="+result_select[i][1]+">");
										out.println("<input type=hidden name=oMinOpen value="+result_select[i][2].trim()+">");
										out.println("<input type=hidden name=oMaxOpen value="+result_select[i][3].trim()+">");
							        }
                                  %>

						     </td>
						  </tr>
		   	</table>
		   </div>
			<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">套餐信息</div>
			</div>
		   <table id=tr cellSpacing="0" style="display:block">
          <tr align="center">
	     		 <th <%=showFlag%> nowrap>选择</th>
					 <th nowrap>可选套餐名称</th>
					 <th nowrap>状态</th>
					 <th nowrap>开始时间</th>
					 <th nowrap>结束时间</th>
					 <th nowrap>套餐类别</th>
					 <th nowrap>生效方式</th>
           <th nowrap>可选方式</th>
			  </tr>
			  <tr id="tr0" style="display:none">
			     <td><div align="center"><input type="checkbox" name="checkId" id="checkId"></div></td>
			     <td><div align="center"><input type="text" name="R0" value=""></div></td>
           		 <td><div align="center"><input type="text" name="R1" value=""></div></td>
			     <td><div align="center"><input type="text" name="R2" value=""></div></td>
			     <td><div align="center"><input type="text" name="R3" value=""></div></td>
			     <td><div align="center"><input type="text" name="R4" value=""></div></td>
			     <td><div align="center"><input type="text" name="R5" value=""></div></td>
			     <td>
					<div align="center">
						<input type="text" name="R6" value="">
						<input type="text" name="R7" value="">
						<input type="text" name="R8" value="">
						<input type="text" name="R9" value="">
						<input type="text" name="R10" value="">
						<input type="text" name="R11" value="">
						<input type="text" name="R12" value="">
					</div>
			     </td>
			  </tr>

         <%
					  	String[][] data= new String[][]{};
						  data = result_must_2;
        String test[][] = result_must_2;

        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
        for(int outer=0 ; test != null && outer< test.length; outer++)
        {
                for(int inner=0 ; test[outer] != null && inner< test[outer].length; inner++)
                {
                        System.out.print(" | "+test[outer][inner]);
                }
                System.out.println(" | ");
        }
        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
						  for(int y=0;y<data.length;y++)
						  {
						    String addstr = data[y][0] +"#" +data[y][1]+"#"+y;
			   %>
					  <tr id="tr<%=y+1%>" align="center">
         <%
         		if(data[y][data[0].length-1].equals("0") || data[y][data[0].length-1].equals("1")||data[y][data[0].length-1].equals("4")){//默认申请
         %>
							<td <%=showFlag%>><input type="checkbox" name="checkId" checked></td>
				 <%
				 		}

				 		if(data[y][data[0].length-1].equals("2")){//绑定申请
				 %>
							<td <%=showFlag%>>
								<input type="checkbox" name="checkId" checked onclick="if(document.all.checkId[<%=y%>+1].checked==false){ document.all.checkId[<%=y%>+1].checked=true;} rdShowMessageDialog('绑定申请！');return false;">
							</td>
				 <%
				 		}

				 		if(data[y][data[0].length-1].equals("a")){//默认申请下因生效时间与历史时间冲突而不可申请
				 %>
							<td <%=showFlag%>>
								<input type="checkbox" name="checkId" onclick="if(document.all.checkId[<%=y%>+1].checked==true){document.all.checkId[<%=y%>+1].checked=false;} rdShowMessageDialog('默认申请下因生效时间与历史时间冲突而不可申请！');return false;">
							</td>
				 <%
				 		}

				 		if(data[y][data[0].length-1].equals("b")){//强制申请下因生效时间与历史时间冲突而不可申请
				 %>
							<td <%=showFlag%>>
								<input type="checkbox" name="checkId" onclick="if(document.all.checkId[<%=y%>+1].checked==true){document.all.checkId[<%=y%>+1].checked=false;} rdShowMessageDialog('强制申请下因生效时间与历史时间冲突而不可申请！');return false;">
							</td>
				 <%
				 		}

				 		if(data[y][data[0].length-1].equals("d")){//强制取消
				 %>
							<td <%=showFlag%>>
								<input type="checkbox" name="checkId"disabled onclick="if(document.all.checkId[<%=y%>+1].checked==true ){document.all.checkId[<%=y%>+1].checked=false;} rdShowMessageDialog('强制取消不能申请！');return false;">
							</td>
				 <%
				 		}

				 		if(data[y][data[0].length-1].equals("9")){//不可取消
				 %>
							<td <%=showFlag%>>
								<input type="checkbox" name="checkId" checked onclick="if(document.all.checkId[<%=y%>+1].checked==false){document.all.checkId[<%=y%>+1].checked=true;} rdShowMessageDialog('特殊可选资费，请到单独业务界面办理！');return false;">
							</td>
				 <%
				 		}

						for(int j=0;j<data[0].length+1;j++){
							 String tbstr="";
							 if(j==0)
								{
									tbstr = "<td><a Href='#' onClick='openhref("+'"'+data[y][7].trim()+'"'+")'>" +
									data[y][j].trim() + "</a><input type='hidden' " +
									" id='R" + j  + "' name='R" + j + "' class='button' value='" +
									(data[y][j]).trim() + "'readonly></td>";
								}
							 else if(j==1)
								{
									String habitus = "";
									if(data[y][j].trim().equals("Y"))habitus="已开通";
									if(data[y][j].trim().equals("N"))habitus="未开通";
									 tbstr = "<td>" + habitus + "<input type='hidden' " +
									" id='R" + j  + "' name='R" + j + "' class='button' value='" +
									(data[y][j]).trim() + "'readonly></td>";
								}
							 else if(j>6&&j<12)
								{
									 tbstr = "<input type='hidden' " +
									" id='R" + j  + "' name='R" + j + "' class='button' value='" +
									(data[y][j]).trim() + "'readonly>";
								}
							 else if(j==12)
							   {
									tbstr = "<input type='hidden' " +
									" id='R" + j  + "' name='R" + j + "' class='button' value=' '>";
							   }
							  else
								{
									 tbstr = "<td>" + data[y][j].trim() + "<input type='hidden' " +
									" id='R" + j  + "' name='R" + j + "' class='button' value='" +
									(data[y][j]).trim() + "'readonly></td>";
								}
									out.println(tbstr);
						   }
				 %>
					  </tr>
			   <%
						}
         %>
	       </table>
			</div>

			<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">备注信息</div>
			</div>
           <table cellSpacing="0">
						  <tr>
							 <td class="blue">系统备注</td>
							 <td colspan="3">
							   <input name="sysnote" size="100" class="InputGrey" readonly>
							 </td>
						  </tr>
						  <tr style="display:none">
						     <td class="blue">用户备注</td>
							 <td>
								<input name="tonote" id="tonote" size="100" maxlength="60" value="<%=WtcUtil.repNull(request.getParameter("do_note"))%>" >
							 </td>
						  </tr>
	       		</table>

<!-- ningtn 2011-7-12 13:13:21 扩大电子工单 -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
       <table cellSpacing="0">
           <tbody>
              <tr>
                 <td id="footer">
					         <input class="b_foot" name=sure  type=button value="确认&打印" onclick="if(checknum(i19,i20)) if(senddata()) if(checksel()) if(check(form1)) printCommit();"> &nbsp;&nbsp;
					         <input class="b_foot" name=kkkk  onClick="removeCurrentTab()" type=button value=关闭>&nbsp;&nbsp;
					         <input class="b_foot" name=kkkk  onClick="pageSubmit(1)" type=button value=返回>
                 </td>
              </tr>
           </tbody>
       </table>
       <%@ include file="/npage/include/footer_new.jsp" %>
  </form>
  <frameset rows="0,0,0,0" cols="0" frameborder="no" border="0" framespacing="0" >
  <frame src="../common/evalControlFrame.jsp"    name="evalControlFrame" id="evalControlFrame" />
</frameset>
<noframes></noframes>

<!-- **** tianyang add for pos ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** tianyang add for pos ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>

</body>
<%@ include file="/npage/public/hwObject.jsp" %>
</HTML>
<%/*------------------------javascript区----------------------------*/%>
<%

String tempStrV1 = WtcUtil.repNull(request.getParameter("ip"));
if(tempStrV1.indexOf(" ")!=-1){
tempStrV1 = tempStrV1.substring(0,tempStrV1.indexOf(" "));
}

String tempStrV2 = WtcUtil.repNull(request.getParameter("i16"));
if(tempStrV2.indexOf("-")!=-1){
tempStrV2 = tempStrV2.substring(0,tempStrV2.indexOf("-"));
}

String tempStrV3 = WtcUtil.repNull(request.getParameter("i18"));

if(tempStrV3.indexOf("-")!=-1){
tempStrV3 = tempStrV3.substring(0,tempStrV3.indexOf("-"));
}

%>
<script language="javascript">
	var offerIdV1 = "<%=tempStrV1%>";
	var offerIdV2 = "<%=tempStrV2%>";
	var offerIdV3 = "<%=tempStrV3%>";
	getMidPrompt("10442",offerIdV1,"showHitz");
	getMidPrompt("10442",offerIdV2,"showHitz1");
	getMidPrompt("10442",offerIdV3,"showHitz2");

  var oActualOpenObj = document.getElementsByName("oActualOpen"); //用于判断
  var oDefaultFlagObj = document.getElementsByName("oDefaultFlag"); //用于判断
  var oDefaultOpenObj = document.getElementsByName("oDefaultOpen"); //用于判断
  var oTypeValueObj = document.getElementsByName("oTypeValue"); //用于判断
  var oTypeNameObj = document.getElementsByName("oTypeName"); //用于判断
  var oMinOpenObj = document.getElementsByName("oMinOpen"); //用于判断
  var oMaxOpenObj = document.getElementsByName("oMaxOpen"); //用于判断
  
  /**** tianyang add for AJAX回调 start ****/
  function doProcess(packet)
 	{
			var verifyType = packet.data.findValueByName("verifyType");
			var sysDate = packet.data.findValueByName("sysDate");
			if(verifyType=="getSysDate"){
				document.all.Request_time.value = sysDate;
				return false;
			}
 	}
  /**** tianyang add for AJAX回调 end ****/
  
/*--------------------------打印流程函数---------------------------*/
/*function showPrtDlg()
{
	document.all.sure.disabled=true;
	document.all.sysnote.value=document.all.i16.value.substring(0,8)+document.all.tbselect.value.substring(2)+document.all.ip.value.substring(0,8);//产生页面显示的系统备注
   /*弹出模式对话筐，并对用户操作进行处理*/
/*    document.all.tonote.value = document.all.phone.value+ "主资费变更";
   var h=105;
   var w=260;
   var t=screen.availHeight-h-20;
   var l=screen.availWidth/2-w/2;
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no"
   var ret=rdShowConfirmDialog("是否打印电子免填单？");
    if(typeof(ret)!="undefined")
    {
        if(ret==1)                      //点击认可
        {
            conf();
        }
        else if(ret==0)                 //点击取消,问是否提交
        {
            crmsubmit();
        }
    }
}*/
/*-------------------------打印流程提交处理函数-------------------*/
function conf()
{
   var h=200;
   var w=300;
   var t=screen.availHeight-h-20;
   var l=screen.availWidth/2-w/2;

   /***********************打印所需的参数**********************************/
   var phone = document.all.i1.value;								//用户手机号码
   var date = '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>';	// 系统日期
   var name = document.all.i4.value;								//用户姓名
   var address = document.all.i5.value;								//用户地址
   var cardno = document.all.i7.value;								//证件号码
   var stream = document.all.stream.value;							//打印流水
   var kx_want = document.all.kx_want.value;				        //打印－所有申请操作-串
   var kx_cancle = document.all.kx_cancle.value;                    //打印－所有取消操作-串
   var kx_running = document.all.kx_running.value;                  //打印－所有开通的套餐-串
   var work_no = '<%=workNo%>';                                 //得到工号
   var sysnote = document.all.i16.value.substring(9)+document.all.tbselect.value.substring(2)+document.all.ip.value.substring(9);
   var tonote = document.all.tonote.value;                          //得到打印的操作
   /**********************打印所需的参数组织完毕****************************/

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no"
   var ret_value=window.showModalDialog("f1270_print.jsp?phone="+phone+"&date="+date+"&name="+name+"&address="+address+"&cardno="+cardno+"&stream="+stream+"&sysnote="+sysnote+"&work_no="+work_no+"&kx_want="+kx_want+"&kx_cancle="+kx_cancle+"&kx_running="+kx_running+"&tonote="+tonote,"",prop);                                //点击确认，调用打印页面
   ifretvalue = ret_value.substring(0,4);
   if(ifretvalue == "true")
	 {
	 document.all.stream.value = ret_value.substring(4);//设置所取到的流水，并赋值，此笔业务的流水将一直是这个
	 crmsubmit()                                        //调用提交确认服务
     }

 }
 function crmsubmit()
 {
 if(rdShowConfirmDialog("是否提交此次操作？")==1)
		 {
           form1.action="f1270_4.jsp";
           form1.submit();
	     }
 else
	 {
	 canc()
	 }

 }

 function canc()
 {
	 document.all.sure.disabled=false;
 }

 /****************************************add by Mengqk begin********************************************/
  function printCommit(){
  	getAfterPrompt();
	//document.all.sure.disabled=true;
	document.all.sysnote.value=document.all.i16.value.substring(0,8)+document.all.tbselect.value.substring(2)+document.all.ip.value.substring(0,8);//系统备注
	if(document.all.tonote.value.trim().len()==0){//如果用户备注是空的话,就赋默认值.如果超过长度60,则在f1270_4中给截断
		document.all.tonote.value = document.all.sysnote.value.trim();
	}
/********************e505 506阶段活动名称 begin****************************/
	if("<%=opCode%>"=="e505" || "<%=opCode%>"=="e506") { 
		var sale_name = '<%=e505_sale_name%>';
		/*
			var tempStr = document.form1.iAddStr.value; 
			var sale_name = oneTokSelf(tempStr,"|",12);//阶段活动名称
		*/
			$('#e505_sale_name').val(sale_name);
	}
/********************e505 506阶段活动名称 end****************************/
/********************liujian e528 529阶段活动名称 begin****************************/
	if("<%=opCode%>"=="e528" || "<%=opCode%>"=="e529") { 
		var sale_name = '<%=sale_name%>';
		$('#sale_name').val(sale_name);
	}
/********************liujian e528 529阶段活动名称 end****************************/
/********************zhangyan e720 e721  begin****************************/
	if("<%=opCode%>"=="e720" || "<%=opCode%>"=="e721") { 
		var sale_name = '<%=sale_name%>';
		$('#sale_name').val(sale_name);
	}
/********************liujian e720 e721   end****************************/


// 4264修改start----------------------------------------------------------------------------------
	if(("<%=opCode%>"=="4264")||("<%=opCode%>"=="4265")||("<%=opCode%>"=="4263"))
	{
		frmCfm();
		return;
	}
// 4264修改end------------------------------------------------------------------------------------
var ret=showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
var iReturn=0;
if(typeof(ret)!="undefined"){
	if((ret=="confirm")){
		iReturn=showEvalConfirmDialog("确认电子免填单吗?");
		if(iReturn==1||2==iReturn){
			if(2==iReturn){
				var vEvalValue = GetEvalReq(1);
				document.all.haseval.value="1";
				document.all.evalcode.value=vEvalValue;
			}else{
				document.all.haseval.value="0";
				document.all.evalcode.value="0";
			}
      document.all.printcount.value="1";
      frmCfm();
   	}
  }
	if(ret=="continueSub"){
		iReturn=showEvalConfirmDialog("确认要提交信息吗?");
		if(iReturn==1||2==iReturn){
			if(2==iReturn){
				var vEvalValue = GetEvalReq(1);
				document.all.haseval.value="1";
				document.all.evalcode.value = vEvalValue;
			}else{
				document.all.haseval.value="0";
				document.all.evalcode.value="0";
			}
   		document.all.printcount.value="0";
   		frmCfm();
     }
   }
	}else{
		iRetrun = showEvalConfirmDialog("确认要提交信息吗？");
		if(iRetrun==1||2==iReturn){
			if(2==iReturn){
				var vEvalValue = GetEvalReq(1);
				document.all.haseval.value="1";
				document.all.evalcode.value = vEvalValue;
			}else{
				document.all.haseval.value="0";
				document.all.evalcode.value="0";
			}
			document.all.printcount.value="0";
			frmCfm();
		}
	}
	document.all.sure.disabled=true;
	return true;
  }
  /****/
  function frmCfm(){
		document.form1.action="f1270_4.jsp";
		/**** tianyang add for pos start ****/
		if(document.all.payType.value=="BX")
  	{
    		/*set 输入参数*/
				var transerial    = "000000000000";  	                     //交易唯一号 ，将会取消
				var trantype      = document.all.transType.value;          //交易类型
				var bMoney        = document.all.bMoney.value; 					   //缴费金额
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
				var tranoper      = "<%=workNo%>";                         //交易操作员
				var orgid         = "<%=groupId%>";                        //营业员归属机构
				var trannum       = "<%=phoneno%>";                        //电话号码
				getSysDate();       /*取boss系统时间*/
				var respstamp     = document.all.Request_time.value;       //提交时间
				var transerialold = "<%=Rrn%>";			                       //原交易唯一号,在缴费时传入空
				var org_code      = "<%=orgCode%>";                        //营业员归属						
				CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
				if(ccbTran=="succ") posSubmitForm();
  	}
		else if(document.all.payType.value=="BY")
		{
				var transType     = document.all.transType.value;					/*交易类型 */         
				var bMoney        = document.all.bMoney.value;            /*交易金额 */
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";         
				var response_time = "<%=Response_time%>";                 /*原交易日期 */				
				response_time     = response_time.substr(0,8);	
				var rrn           = "<%=Rrn%>";                           /*原交易系统检索号 */ 
				var instNum       = "";                                   /*分期付款期数 */     
				var terminalId    = "<%=TerminalId%>";                    /*原交易终端号 */			
				getSysDate();       //取boss系统时间                                            
				var request_time  = document.all.Request_time.value;      /*交易提交日期 */     
				var workno        = "<%=workNo%>";                        /*交易操作员 */       
				var orgCode       = "<%=orgCode%>";                       /*营业员归属 */       
				var groupId       = "<%=groupId%>";                       /*营业员归属机构 */   
				var phoneNo       = "<%=phoneno%>";                       /*交易缴费号 */       
				var toBeUpdate    = "";						                        /*预留字段 */         
				var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
				//调用POS机办理业务返回值入库服务 20121011 gaopeng 银行卡业务单边帐处理需求
				if("<%=iop_code%>"=="e505")
				{
					if(icbcTran=="succ")
					{
						SsPosPayPre();
					}
				}
				
				//一会儿展开
				if(icbcTran=="succ") posSubmitForm();
		}else if(document.all.payType.value=="EI")
		{
				var transType     = document.all.transType.value;					/*交易类型 */         
				var bMoney        = document.all.bMoney.value;            /*交易金额 */
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";         
				var response_time = "<%=Response_time%>";                 /*原交易日期 */				
				response_time     = response_time.substr(0,8);				       
				var rrn           = "<%=Rrn%>";                           /*原交易系统检索号 */ 
				var instNum       = "<%=installmentNum%>";                /*分期付款期数 */     
				var terminalId    = "<%=TerminalId%>";                    /*原交易终端号 */			
				getSysDate();       //取boss系统时间                                            
				var request_time  = document.all.Request_time.value;      /*交易提交日期 */     
				var workno        = "<%=workNo%>";                        /*交易操作员 */       
				var orgCode       = "<%=orgCode%>";                       /*营业员归属 */       
				var groupId       = "<%=groupId%>";                       /*营业员归属机构 */   
				var phoneNo       = "<%=phoneno%>";                       /*交易缴费号 */       
				var toBeUpdate    = "";						                        /*预留字段 */         
				var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
				//调用POS机办理业务返回值入库服务 20121011 gaopeng 银行卡业务单边帐处理需求
				if("<%=iop_code%>"=="e505")
				{
					if(icbcTran=="succ")
					{
						SsPosPayPre();
					}
				}
				if(icbcTran=="succ") posSubmitForm();
		}else{
				posSubmitForm();
		}
		/**** tianyang add for pos end ****/
  }
  /**调用POS机办理业务返回值入库服务 20121011 gaopeng 银行卡业务单边帐处理需求 start**/
  function SsPosPayPre()
  {
  		var MydataPacket = new AJAXPacket("/npage/sg175/fg175_1.jsp","正在处理POS数据，请稍候......");
			//流水号
			MydataPacket.data.add("iLoginAccept","<%=printAccept%>");
			//渠道标识
			MydataPacket.data.add("iChnSource","01");
			//操作代码
			MydataPacket.data.add("iOpCode","<%=iop_code%>");
			//工号
			MydataPacket.data.add("iLoginNo","<%=workNo%>");
			//工号密码
			MydataPacket.data.add("iLoginPwd","<%=op_strong_pwd%>");
			//用户号码
			MydataPacket.data.add("iPhoneNo","<%=phoneno%>");
			//号码密码
			MydataPacket.data.add("iUserPwd","");
			//缴费类型
			MydataPacket.data.add("iPayType",document.all.payType.value);
			//缴费金额
			MydataPacket.data.add("iPayFee",document.all.bMoney.value);
			//卡序列号
			MydataPacket.data.add("iCatdNo",document.all.CardNo.value);
			//分期付款期数
			MydataPacket.data.add("iInstNum",$("#iInstNum").val());
			//原交易日期
			var response_time = "<%=Response_time%>";                		
			response_time = response_time.substr(0,8);				       
			MydataPacket.data.add("iResponseTime",response_time);
			//原交易终端号
			MydataPacket.data.add("iTerminalId",document.all.TerminalId.value);
			//原交易系统检索号
			MydataPacket.data.add("iRrn",document.all.Rrn.value);
			//提交日期
			MydataPacket.data.add("iRequestTime",document.all.Request_time.value);
			//预留字段
			MydataPacket.data.add("iOtherS","");
			
			core.ajax.sendPacket(MydataPacket,dsPosPayPre12);
			
			MydataPacket = null;
  	
  }
  function dsPosPayPre12(packet)
  {
		var ErrorCode = packet.data.findValueByName("retCode12");
		var ErrorMsg = packet.data.findValueByName("retMsg12");
		if(ErrorCode!="0" && ErrorCode!="000000")
		{
			rdShowMessageDialog(ErrorMsg,1);
		}
  	else
  		{
  			return true;
  		}
  }
	/**调用POS机办理业务返回值入库服务 20121011 gaopeng 银行卡业务单边帐处理需求 end**/
	/*tianyang add POS缴费 start*/
	function getSysDate()
	{
		var myPacket = new AJAXPacket("../public/pos_getSysDate.jsp","正在获得系统时间，请稍候......");
		myPacket.data.add("verifyType","getSysDate");
		core.ajax.sendPacket(myPacket);
		myPacket = null;
	
	}
	function padLeft(str, pad, count)
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	function getCardNoPingBi(cardno)
	{
			var cardnopingbi = cardno.substr(0,6);
			for(i=0;i<cardno.length-10;i++)
			{
				cardnopingbi=cardnopingbi+"*";
			}
			cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
			return cardnopingbi;
	}
	/* POS缴费中 页面提交  start*/
	function posSubmitForm(){
			var tmpStr = $("#transTotal").val();
			tmpStr = replaceStr(tmpStr);
			$("#transTotal").val(tmpStr);
			form1.submit();
			return true;
	}
	/*tianyang add POS缴费 end*/
	function replaceStr(str){
		str = str.replace(/\s+/g, " ");
		return str;
	}


  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	//var kx_code = document.all.kx_code_bunch.value; //可选资费
	//kx_code = kx_code.replace(new RegExp("#","gm"),"~");
	var kx=""; //可选套餐代码
		for (var i = 0; i < document.all.checkId.length; i++){
		if (document.all.checkId[i].checked == true&& document.all.R1[i].value=="N"){
			kx=kx+document.all.R7[i].value+"~";
		}
	}
	var printStr = printInfo();

	var old_code = "<%=iold_m_code%>"; //旧资费代码
	var new_code = "<%=inew_m_code%>"; //新资费代码
	var pType="subprint";              // 打印类型：print 打印 subprint 合并打印
	var billType="1";               //  票价类型：1电子免填单、2发票、3收据
	var sysAccept="<%=printAccept%>";               // 流水号
	var mode_code=codeChg(new_code)+"~"+codeChg(kx);               //资费代码
	var fav_code=null;                 //特服代码
	var area_code="<%=WtcUtil.repNull(request.getParameter("rate_code"))%>";             //小区代码
	var opCode="1270";

	var phoneNo=document.all.i1.value;                  //客户电话
	<%

	System.out.println("---------------opCode------------------"+opCode);
	%>
	/* ningtn */
	var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
	var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
	/* ningtn */
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	<%if(iop_code.equals("1270") || iop_code.equals("127a") || iop_code.equals("127b")|| iop_code.equals("125b")|| iop_code.equals("125c")|| iop_code.equals("7119")){%>
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
	  path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.form1.phone.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr.trim();
	<%}else{%>
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
	  path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.form1.phone.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr.trim();
	<%}%>

	 var ret=window.showModalDialog(path.trim(),printStr,prop);
     return ret;
  }

  function printInfo()
  {
    var retInfo = "";

	<%if(iop_code.equals("1205")){%>
		retInfo = printInfo1205();
	<%}else if(iop_code.equals("1200")){%>
		retInfo = printInfo1200();
	<%}else if(iop_code.equals("1198")){%>
		retInfo = printInfo1198();
	<%}else if(iop_code.equals("1206")){%>
		retInfo = printInfo1206();
	<%}else if(iop_code.equals("1207")){%>
		retInfo = printInfo1207();
	<%}else if(iop_code.equals("1270")){%>
		retInfo = printInfo1270();
	<%}else if(iop_code.equals("127b")){%>
		retInfo = printInfo127b();
	<%}else if(iop_code.equals("127a")){%>
		retInfo = printInfo127a();
	<%}else if(iop_code.equals("126b")){%>
		retInfo = printInfo126b();
	<%}else if(iop_code.equals("126c")){%>
		retInfo = printInfo126c();
	<%}else if(iop_code.equals("8034")){%>
		retInfo = printInfo8034();
	<%}else if(iop_code.equals("8035")){%>
		retInfo = printInfo8035();
	<%}else if(iop_code.equals("8070")){%>
		retInfo = printInfo8070();
	<%}else if(iop_code.equals("8071")){%>
		retInfo = printInfo8071();
	<%}else if(iop_code.equals("8042")){%>
		retInfo = printInfo8042();
	<%}else if(iop_code.equals("8043")){%>
		retInfo = printInfo8043();
	<%}else if(iop_code.equals("8044")){%>
		retInfo = printInfo8044();
	<%}else if(iop_code.equals("7671")){%>
		retInfo = printInfo7671();
	<%}else if(iop_code.equals("7672")){%>
		retInfo = printInfo7672();
	<%}else if(iop_code.equals("8045")){%>
		retInfo = printInfo8045();
	<%}else if(iop_code.equals("126h")){%>
		retInfo = printInfo126h();
	<%}else if(iop_code.equals("126i")){%>
		retInfo = printInfo126i();
	<%}else if(iop_code.equals("7960")){%>
		retInfo = printInfo7960();
	<%}else if(iop_code.equals("7964")){%>
		retInfo = printInfo7964();
	<%}else if(iop_code.equals("7965")){%>
		retInfo = printInfo7965();
	<%}else if(iop_code.equals("7966")){%>
		retInfo = printInfo7966();
	<%}else if(iop_code.equals("7967")){%>
		retInfo = printInfo7967();
	<%}else if(iop_code.equals("8023")){%>
		retInfo = printInfo8023();
	<%}else if(iop_code.equals("8024")){%>
		retInfo = printInfo8024();
	<%}else if(iop_code.equals("8094")){%>
		retInfo = printInfo8094();
	<%}else if(iop_code.equals("8091")){%>
		retInfo = printInfo8091();
	<%}else if(iop_code.equals("2264")){%>
		retInfo = printInfo2264();
	<%}else if(iop_code.equals("2265")){%>
		retInfo = printInfo2265();
	<%}else if(iop_code.equals("2281")){%>
		retInfo = printInfo2281();
	<%}else if(iop_code.equals("2282")){%>
		retInfo = printInfo2282();
	<%}else if(iop_code.equals("2283")){%>
		retInfo = printInfo2283();
	<%}else if(iop_code.equals("2284")){%>
		retInfo = printInfo2284();
	<%}else if(iop_code.equals("7371")){%>
		retInfo = printInfo7371();
	<%}else if(iop_code.equals("7374")){%>
		retInfo = printInfo7374();
	<%}else if(iop_code.equals("7379")){%>
		retInfo = printInfo7379();
	<%}else if(iop_code.equals("7382")){%>
		retInfo = printInfo7382();
	<%}else if(iop_code.equals("7981")){%>
		retInfo = printInfo7981();
	<%}else if(iop_code.equals("7982")){%>
		retInfo = printInfo7982();
	<%}else if(iop_code.equals("8551")){%>
		retInfo = printInfo8551();
	<%}else if(iop_code.equals("8552")){%>
		retInfo = printInfo8552();
	<%}else if(iop_code.equals("7898")){%>
		retInfo = printInfo7898();
	<%}else if(iop_code.equals("g068")){%>
		retInfo = printInfoG068();		
	<%}else if(iop_code.equals("7899")){%>
		retInfo = printInfo7899();
	<%}else if(iop_code.equals("g069")){%>
		retInfo = printInfoG069();
	<%}else if(iop_code.equals("8687")){%>
		retInfo = printInfo8687();
	<%}else if(iop_code.equals("8688")){%>
		retInfo = printInfo8688();
	<%}else if(iop_code.equals("7975")){%>
		retInfo = printInfo7975();
	<%}else if(iop_code.equals("7976")){%>
		retInfo = printInfo7976();
	<%}else if(iop_code.equals("7116")){%>
		retInfo = printInfo7116();
	<%}else if(iop_code.equals("7118")){%>
		retInfo = printInfo7118();
	<%}else if(iop_code.equals("1253")){%>
		retInfo = printInfo1253();
	<%}else if(iop_code.equals("1254")){%>
		retInfo = printInfo1254();
	<%}else if(iop_code.equals("7977")){%>
		retInfo = printInfo7977();
	<%}else if(iop_code.equals("7978")){%>
		retInfo = printInfo7978();
	<%}else if(iop_code.equals("1208")){%>
		retInfo = printInfo1208();
	<%}else if(iop_code.equals("125b")){%>
		retInfo = printInfo125b();
	<%}else if(iop_code.equals("125c")){%>
		retInfo = printInfo125c();
	<%}else if(iop_code.equals("7117")){%>
		retInfo = printInfo7117();
	<%}else if(iop_code.equals("7119")){%>
		retInfo = printInfo7119();
	<%}else if(iop_code.equals("8046")){%>
		retInfo = printInfo8046();
	<%}else if(iop_code.equals("8027")){%>
		retInfo = printInfo8027();
	<%}else if(iop_code.equals("8028")){%>
		retInfo = printInfo8028();
	<%}else if(iop_code.equals("7688")){%>
		retInfo = printInfo7688();
	<%}else if(iop_code.equals("7689")){%>
		retInfo = printInfo7689();
	<%}else if(iop_code.equals("e505")){%>
		retInfo = printInfoE505();
	<%}else if(iop_code.equals("e506")){%>
		retInfo = printInfoE506();
	<%}else if(iop_code.equals("e528")){%>
		retInfo = printInfoE528();
	<%}else if(iop_code.equals("e529")){%>
		retInfo = printInfoE529();
	<%}else if(iop_code.equals("e720")){%>
		retInfo = printInfoE720();
	<%}else if(iop_code.equals("e721")){%>
		retInfo = printInfoE721();
	<%}else if(iop_code.equals("g122")){%>
		retInfo = printInfoG122();
	<%}else if(iop_code.equals("g123")){%>
		retInfo = printInfoG123();
	<%}else if(iop_code.equals("g124")){%>
		retInfo = printInfoG124();
	<%}else if(iop_code.equals("g125")){%>
		retInfo = printInfoG125();
	<%}%>
    return retInfo;
  }

  /********组织打印信息的一组函数  begin***********/
//来电畅听申请
function printInfo1205()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr格式 方案代码| 包年预存| 月底线| 消费期限
      var year_fee = oneTokSelf(tempStr,"|",2);//包年预存
      var mon_base_fee = oneTokSelf(tempStr,"|",3);//月底线
	  var consume_term = oneTokSelf(tempStr,"|",4);//消费期限

	  var exeDate = "<%=exeDate%>";//得到执行时间
	  var time=exeDate.substring(0,8);
	  //rdShowMessageDialog("time="+time);
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
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";
      /********受理类**********/
      if ("<%=regionCode%>"=="03")
      	opr_info+="用户品牌: "+"全球通" + "  *"+ "办理业务:牡丹江数据业务包年申请"+"|";
      else
      	opr_info+="用户品牌: "+"全球通" + "  *"+ "办理业务:哈尔滨畅听套餐申请"+"|";
      <%if(goodbz.equals("Y")){%>
    		opr_info+="操作流水: "+"<%=printAccept%>" +"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";;
  		<%}else{%>
  			opr_info+="操作流水: "+"<%=printAccept%>" +"|";
  		<%}%>
      opr_info+="资费类型："+codeChg(document.all.ip.value)+"|";
      opr_info+="资费生效时间："+time+"|" ;
      /*******备注类**********/
		note_info1="备注："+"|"
      if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	    }
	  	/**********描述类*********/
      note_info1+="资费描述："+"<%=note%>"+"|";
      if ("<%=regionCode%>"=="03")
      {
      	note_info1+="包年到期后资费为：月租费12元，小区范围内本地通话费主叫0.25元/分钟，"+"|";
      	note_info1+="被叫免费；小区范围外本地通话费0.25元/分钟"+"|";
      }
      else
      {
				note_info1+=" "+"|";
				note_info1+=" "+"|";
      }
      if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>

		//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
}
//来电畅听续签
function printInfo1200()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr格式 方案代码| 包年预存| 月底线| 消费期限
      var year_fee = oneTokSelf(tempStr,"|",2);//包年预存
      var mon_base_fee = oneTokSelf(tempStr,"|",3);//月底线
	  var consume_term = oneTokSelf(tempStr,"|",4);//消费期限

	  var exeDate = "<%=exeDate%>";//得到执行时间
	  var time=exeDate.substring(0,8);
	  var real_begin=document.all.next_begin.value;
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
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";

      /********受理类**********/
      if ("<%=regionCode%>"=="03")
      	opr_info+="用户品牌: "+"全球通" + "  *"+ "办理业务:牡丹江数据业务包年续签申请"+"|";
      else
      	opr_info+="用户品牌: "+"全球通" + "  *"+ "办理业务:哈尔滨畅听套餐续签申请"+"|";
      <%if(goodbz.equals("Y")){%>
    		opr_info+="操作流水: "+"<%=printAccept%>" +"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";;
  		<%}else{%>
  			opr_info+="操作流水: "+"<%=printAccept%>" +"|";
  		<%}%>
      opr_info+="资费类型："+codeChg(document.all.ip.value)+"|";
      opr_info+="资费生效时间："+real_begin.substr(0,4)+"年"+real_begin.substr(4,2)+"月"+real_begin.substr(6,2)+"日"+"|" ;
	  	/*******备注类**********/
	  	note_info1="备注："+"|";
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  	/**********描述类*********/
      note_info1+="资费描述："+"<%=note%>"+"|";
      if ("<%=regionCode%>"=="03")
      {
      	note_info1+="包年到期后资费为：月租费12元，小区范围内本地通话费主叫0.25元/分钟，"+"|";
      	note_info1+="被叫免费；小区范围外本地通话费0.25元/分钟"+"|";
      }
      else
      {
				note_info1+=" "+"|";
				note_info1+=" "+"|";
      }
      if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
		//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//来电畅听冲正

<%
System.out.println("-----------------1111111111111-------------------");

%>
function printInfo1206()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr格式 方案代码| 包年预存| 月底线| 消费期限
      var year_fee = oneTokSelf(tempStr,"|",2);//包年预存
      var mon_base_fee = oneTokSelf(tempStr,"|",3);//月底线
	  var consume_term = oneTokSelf(tempStr,"|",4);//消费期限
	  <%
System.out.println("-----------------2222222222222222222-------------------"+exeDate);
%>
	  var exeDate = "<%=exeDate.substring(0,8)%>";//得到执行时间

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
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";

     if ("<%=regionCode%>"=="03")
      	opr_info+="用户品牌: "+"全球通" + "  *"+ "办理业务:牡丹江数据业务包年冲正"+"|";
      else
      	opr_info+="用户品牌: "+"全球通" + "  *"+ "办理业务:哈尔滨畅听套餐冲正"+"|";
      <%if(goodbz.equals("Y")){%>
    		opr_info+="操作流水: "+"<%=printAccept%>" +"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";;
  		<%}else{%>
  			opr_info+="操作流水: "+"<%=printAccept%>" +"|";
  		<%}%>
      opr_info+=" "+"|";
      opr_info+="月底线:  "+mon_base_fee+"元      预存话费:  "+year_fee+"元|";
      opr_info+="业务执行时间:  "+exeDate+"      底线预存期限:  "+consume_term+"个月|";
      /*******备注类**********/
      note_info1="备注："+"|"
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  	/**********描述类*********/

      if ("<%=regionCode%>"=="03")
      {
      	note_info1+="包年到期后资费为：月租费12元，小区范围内本地通话费主叫0.25元/分钟，"+"|";
      	note_info1+="被叫免费；小区范围外本地通话费0.25元/分钟"+"|";
      }
      else
      {
        note_info1+="<%=print_note%>"+"|";
      }
       if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
		//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
}
//来电畅听续签冲正

function printInfo1198()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr格式 方案代码| 包年预存| 月底线| 消费期限
      var year_fee = oneTokSelf(tempStr,"|",2);//包年预存
      var mon_base_fee = oneTokSelf(tempStr,"|",3);//月底线
	  var consume_term = oneTokSelf(tempStr,"|",4);//消费期限

	  var exeDate = "<%=exeDate.substring(0,8)%>";//得到执行时间
     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	  var retInfo = "";
	   /********基本信息类**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      cust_info+="客户姓名：" +document.all.i4.value+"|";
      cust_info+="手机号码："+document.all.phone.value+"|";
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";

      /********受理类**********/

      if ("<%=regionCode%>"=="03")
      	opr_info+="用户品牌: "+"全球通" + "  *"+ "办理业务:牡丹江数据业务包年续签冲正"+"|";
      else
      	opr_info+="用户品牌: "+"全球通" + "  *"+ "办理业务:哈尔滨畅听套餐续签冲正"+"|";
      <%if(goodbz.equals("Y")){%>
    		opr_info+="操作流水: "+"<%=printAccept%>" +"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";;
  		<%}else{%>
  			opr_info+="操作流水: "+"<%=printAccept%>" +"|";
  		<%}%>
      opr_info+=" "+"|";
      opr_info+="月底线:  "+mon_base_fee+"元      预存话费:  "+year_fee+"元|";
      opr_info+="业务执行时间:  "+exeDate+"      底线预存期限:  "+consume_term+"个月|";
      /*******备注类**********/
      note_info1="备注："+"|";
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  	/**********描述类*********/

      if ("<%=regionCode%>"=="03")
      {
      	note_info1+="包年到期后资费为：月租费12元，小区范围内本地通话费主叫0.25元/分钟，"+"|";
      	note_info1+="被叫免费；小区范围外本地通话费0.25元/分钟"+"|";
      }
      else
      {
        note_info1+="<%=print_note%>"+"|";
      }
      if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
		//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//来电畅听取消
function printInfo1207()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr格式 方案代码| 包年预存| 月底线| 消费期限
      var year_fee = oneTokSelf(tempStr,"|",2);//包年预存
      var mon_base_fee = oneTokSelf(tempStr,"|",3);//月底线
	  var consume_term = oneTokSelf(tempStr,"|",4);//消费期限
      var exeDate='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';
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
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";

      if ("<%=regionCode%>"=="03")
      	opr_info+="用户品牌: "+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>" + "  *"+ "办理业务:牡丹江数据业务包年取消"+"|";
      else
      	opr_info+="用户品牌："+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"  *"+"办理业务:"+"哈尔滨畅听套餐取消"+"|";
      <%if(goodbz.equals("Y")){%>
    		opr_info+="操作流水: "+"<%=printAccept%>" +"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";;
  		<%}else{%>
  			opr_info+="操作流水: "+"<%=printAccept%>" +"|";
  	  <%}%>
      opr_info+="取消的包年资费："+ "<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
      opr_info+="取消后执行资费："+document.all.ip.value+"  *"+"生效时间："+exeDate+"|";
      opr_info+="取消后执行资费对应品牌："+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"|";
      opr_info+=" "+"|";
      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  	/**********描述类*********/

	  note_info1+="取消后执行资费描述："+"<%=note%>"+"|";
      if(document.all.kx_explan_bunch.value.trim().len()==0)
      {
		note_info1+=" "+"|";
	  }
	  else
	  {
		note_info1+="可选资费描述："+document.all.kx_explan_bunch.value+"|";
	  }
      if ("<%=regionCode%>"=="03")
      {
      	note_info1+="包年到期后资费为：月租费12元，小区范围内本地通话费主叫0.25元/分钟，"+"|";
      	note_info1+="被叫免费；小区范围外本地通话费0.25元/分钟"+"|";
      }
      else
      {
		note_info1+="备注：由于包年资费未到期，取消包年资费属于违约行为，在本月出帐后，我公司将按剩余"+"|";
		note_info1+="包年预存的30％收取违约金，之后剩余的预存款将自动转到您的现金账户中。"+"|";
      }
          if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
		//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
}
//主资费变更
function printInfo1270()
{
  //得到该业务工单需要的参数
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";

  var exeDate = "<%=exeDate.substring(0,8)%>";//得到执行时间
  var smCode = "<%=WtcUtil.repNull(request.getParameter("s_city"))%>";
  var region_code = "<%=WtcUtil.repNull(request.getParameter("belong_code")).substring(0,2)%>"; //地区代码
  var old_smCode = "<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>";
  var smName = "";
	if(smCode=="zn")
		smName="神州行";
	else if(smCode=="gn")
		smName="全球通";
	else if(smCode=="dn")
		smName="动感地带";

  //王良 2006年11月13日 修改 增加电子免签单资费明细说明,只限哈尔滨

	var retInfo = "";

	/********基本信息类**********/
    cust_info+="客户姓名：" +document.all.i4.value+"|";
    cust_info+="手机号码："+document.all.phone.value+"|";
    cust_info+="客户地址："+document.all.i5.value+"|";
    cust_info+="证件号码："+document.all.i7.value+"|";

    /********受理类**********/
    opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌: "+'<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>'+ "|";
    <%if(goodbz.equals("Y")){%>
    opr_info+="办理业务:主资费变更"+"  "+"操作流水: "+"<%=printAccept%>" +"    底线消费金额："+"<%=modedxpay%>"+"元"+"|";
  <%}else{%>
  	opr_info+="办理业务:主资费变更"+"  "+"操作流水: "+"<%=printAccept%>" +"|";
  	<%}%>
    opr_info+="当前主资费："+"<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
    opr_info+="新申请主资费："+codeChg(document.form1.ip.value.trim())+"      "+"新资费生效时间："+checkdate(exeDate)+"|";
    opr_info+="新申请主资费二次批价："+ codeChg("<%=daima.trim()%>")+"*"+"新资费对应品牌："+ smName+"|" ;
    if( document.all.kx_want.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_want.value) + "|";
    }
    if( document.all.kx_cancle.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_cancle.value) + "|";
    }

	  /*******备注类**********/
	//note_info1+="备注："+"|";
	  if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }
	  /**********描述类*********/
	if(old_smCode !=smName && !(old_smCode=="神州行" && smName=="全球通"))
	note_info1+="本资费生效后，您的品牌将由"+ old_smCode+"变更为"+ smName+"；现有积分（或M值）将于资费生效的次月初清零，请您及时兑换积分"+"|";
	note_info1+="."+"|";
    note_info1+="新申请主资费描述:"+"|";
    note_info1+=codeChg("<%=note.trim()%>")+"|";
    if(document.all.kx_explan_bunch.value.trim().len()==0){

	  }else{
	    note_info3+="."+"| ";
	  	note_info3+="可选资费描述："+"|";
	  	note_info3+=document.all.kx_explan_bunch.value+"|";
	  	//alert(document.all.kx_explan_bunch.value);
  	}
  	if(document.all.modestr.value.length>0){
  	  note_info4+=" ."+"|";
      note_info4+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{

      }
	<%if(goodbz.equals("Y")){%>
	        note_info4+=" ."+"|";
			note_info4+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
	<%}%>
	note_info4+=" ."+"|";
	note_info4+="备注:"+codeChg(document.all.tonote.value)+"|";
  //retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}
//主资费冲正
function printInfo127b()
{
	  //得到该业务工单需要的参数

	  var exeDate = "<%=exeDate.substring(0,8)%>";//得到执行时间

	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  /********基本信息类**********/
     /* retInfo+='<%=workName%>'+"|"; */
     /* retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";  */
      cust_info+="客户姓名："+document.all.i4.value+"|";
      cust_info+="手机号码："+document.all.phone.value+"|";
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";
      //cust_info+="预交款: "+"|";
      //cust_info+="受理费: "+"|";

      /********受理类**********/


      opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌: "+"<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>"+"|";

      <%if(goodbz.equals("Y")){%>
      opr_info+="业务类型: 资费套餐冲正"+"  "+"流水: "+"<%=printAccept%>"+"  底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务类型: 资费套餐冲正"+"  "+"流水: "+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="新套餐类型:       "+codeChg(document.form1.ip.value)+"|";
      opr_info+="二次批价类型:     "+""+"|";
      opr_info+="套餐说明:         "+""+"|";
      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }
	  /**********描述类*********/
	  /*rdShowMessageDialog("note_info1="+"<%=print_note%>");  */
      note_info1+="<%=print_note%>"+"|";
      if(document.all.modestr.value.length>0){
      note_info2+=" "+"|";
      note_info2+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }
      	<%if(goodbz.equals("Y")){%>
      	    note_info3+=" "+"|";
			note_info3+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	note_info4+=" "+"|";
	note_info4+="备注:"+document.all.tonote.value+"|";
	  document.all.cust_info.value=cust_info+"#";
	  document.all.opr_info.value=opr_info+"#";
	  document.all.note_info1.value=note_info1+"#";
	  document.all.note_info2.value=note_info2+"#";
	  document.all.note_info3.value=note_info3+"#";
	  document.all.note_info4.value=note_info4+"#";
	/*retInfo=document.all.cust_info.value+" "+"|"+"---------------------------------------------"+"|"+" "+"|"+document.all.opr_info.value+" "+"|"+" "+"|"+document.all.note_info1.value+document.all.note_info2.value+document.all.note_info3.value+document.all.note_info4.value+" "+"|"+" "+"|"+" "+"|"+" "+"|"+"<%=loginNote.trim()%>"+"#";*/

	//return retInfo;
	//retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
//主资费预约取消
function printInfo127a()
{
	  /*得到该业务工单需要的参数

	  var exeDate = "<%=exeDate.substring(0,8)%>";//得到执行时间

	  var retInfo = "";
	  /基本信息类/
      retInfo+='<%=workNo%>  <%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="客户名称：" +document.all.i4.value+"|";
      retInfo+="手机号码："+document.all.phone.value+"|";
      retInfo+="客户地址："+document.all.i5.value+"|";
      retInfo+="证件号码："+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /受理类/
      retInfo+="用户品牌: "+"<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>" + "  *"+ "办理业务:主资费预约取消"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="操作流水: "+"<%=printAccept%>" +"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
       <%}else{%>
       retInfo+="操作流水: "+"<%=printAccept%>" +"|";
       <%}%>
      retInfo+="当前主资费："+"<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
      retInfo+="预约主资费："+codeChg(document.form1.i18.value)+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+="说明：用户办理主资费预约取消后，预约的主资费将不会生效，当前主资费继续执行。"+"|";
      retInfo+=" "+"|";
       /备注类/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  }
	  /描述类/
      if(document.all.modestr.value.length>0){
      retInfo+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			retInfo+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
		<%}%>


	  return retInfo; */


	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
    var retInfo = "";

    cust_info+="手机号码："+document.all.phone.value+"|";
	cust_info+="客户姓名："+document.all.i4.value+"|";
	cust_info+="客户地址："+document.all.i5.value+"|";
	cust_info+="证件号码："+document.all.i7.value+"|";

	opr_info+="用户品牌: "+"<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>" + "  *"+ "办理业务:主资费预约取消"+"|";
	<%if(goodbz.equals("Y")){%>
       opr_info+="操作流水: "+"<%=printAccept%>" +"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
    <%}else{%>
       opr_info+="操作流水: "+"<%=printAccept%>" +"|";
    <%}%>
    opr_info+="当前主资费："+"<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
    opr_info+="预约主资费："+codeChg(document.form1.i18.value)+"|";

	if("<%=bdbz%>"=="Y"){
        note_info2+="<%=bdts%>"+"|";
    }else{
	    note_info2+=" "+"|";
	}
	if(document.all.modestr.value.length>0){
      note_info3+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
    }else{
      note_info3+=" "+"|";
    }
    <%if(goodbz.equals("Y")){%>
	  note_info4+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
	<%}%>
    //retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//预存话费赠机申请
function printInfo126b()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr格式 flag,machine_type,order_code,prepay_fee,base_fee,free_fee,consume_term,mon_base_fee,machine_fee
      var machine_type = oneTokSelf(tempStr,"|",2);//机器类型
      var order_code = oneTokSelf(tempStr,"|",3);//方案代码
	  var prepay_fee = oneTokSelf(tempStr,"|",4);//预存款
	  var base_fee = oneTokSelf(tempStr,"|",5);//底线预存
	  var free_fee = oneTokSelf(tempStr,"|",6);//活动预存
	  var consume_term = oneTokSelf(tempStr,"|",7);//消费期限
	  var mon_base_fee = oneTokSelf(tempStr,"|",8);//月底线

	  var exeDate = "<%=exeDate.substring(0,8)%>";//得到执行时间

	  var retInfo = "";
	   /********基本信息类**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="客户名称：" +document.all.i4.value+"|";
      retInfo+="手机号码："+document.all.phone.value+"|";
      retInfo+="客户地址："+document.all.i5.value+"|";
      retInfo+="证件号码："+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********受理类**********/
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+="业务类型:         预存赠机按月扣费"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="流水: "+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      retInfo+="流水:             "+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+=" "+"|";
      retInfo+="业务类型: 预存话费赠手机"+"    手机型号: " + machine_type+"|";
      retInfo+="月底线: "+mon_base_fee+"元    预存话费: "+prepay_fee+"元    "+"其中:  底线预存: "+base_fee+"元  活动预存: "+free_fee+"元|";
      retInfo+="业务执行时间:  "+exeDate+"      底线预存期限:  "+consume_term+"个月|";
		 /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********描述类*********/
      retInfo+="<%=print_note%>"+"|";
      if(document.all.modestr.value.length>0){
      retInfo+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			retInfo+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>


	  return retInfo;
}
//预存话费赠机冲正
function printInfo126c()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr格式 flag,machine_type,order_code,prepay_fee,base_fee,free_fee,consume_term,mon_base_fee,machine_fee
      var machine_type = oneTokSelf(tempStr,"|",2);//机器类型
      var order_code = oneTokSelf(tempStr,"|",3);//方案代码
	  var prepay_fee = oneTokSelf(tempStr,"|",4);//预存款
	  var base_fee = oneTokSelf(tempStr,"|",5);//底线预存
	  var free_fee = oneTokSelf(tempStr,"|",6);//活动预存
	  var consume_term = oneTokSelf(tempStr,"|",7);//消费期限
	  var mon_base_fee = oneTokSelf(tempStr,"|",8);//月底线

	  var exeDate = "<%=exeDate.substring(0,8)%>";//得到执行时间

	  var retInfo = "";
	  /********基本信息类**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="客户名称：" +document.all.i4.value+"|";
      retInfo+="手机号码："+document.all.phone.value+"|";
      retInfo+="客户地址："+document.all.i5.value+"|";
      retInfo+="证件号码："+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********受理类**********/
      retInfo+=" "+"|";
      retInfo+=" "+"|";
       retInfo+="业务类型:         预存赠机按月扣费冲正"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="流水:"+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      retInfo+="流水:             "+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+=" "+"|";
      retInfo+="业务类型: 预存话费赠手机冲正"+"    手机型号: " + machine_type+"|";
      retInfo+="月底线: "+mon_base_fee+"元    预存话费: "+prepay_fee+"元    "+"其中:  底线预存: "+base_fee+"元  活动预存: "+free_fee+"元|";
      retInfo+="业务执行时间:  "+exeDate+"      底线预存期限:  "+consume_term+"个月|";
			 /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********描述类*********/
      retInfo+="<%=print_note%>"+"|";
      if(document.all.modestr.value.length>0){
      retInfo+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			retInfo+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>


	  return retInfo;
}
//预存换手机、话费共分享申请
function printInfo8042()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	 // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr格式 营销代码|品牌名称|应收金额|主卡预存|副卡预存|机型名称|预扣积分|消费月份|副卡月底线|IMEI码|副卡号码|副卡名称|

		/**** ningtn add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}
		/**** ningtn add for pos end *****/

    var sale_code = oneTokSelf(tempStr,"|",1);     //营销代码
    var brand_code = oneTokSelf(tempStr,"|",2);      //手机品牌
	  var prepay_fee = oneTokSelf(tempStr,"|",3);     //预存话费
	  var main_fee = oneTokSelf(tempStr,"|",4);       //主卡预存
	  var second_fee = oneTokSelf(tempStr,"|",5);       //副卡预存
	  var phone_type = oneTokSelf(tempStr,"|",6);    //手机型号
	  var mark_subtract = oneTokSelf(tempStr,"|",7);  //预扣积分
	  var consume_term = oneTokSelf(tempStr,"|",8);   //消费月份
	  var monbase_fee = oneTokSelf(tempStr,"|",9);    //月底线
	  var IMEINo = oneTokSelf(tempStr,"|",10);//IMEI码
	  var second_phone= oneTokSelf(tempStr,"|",11);//副卡号码
	  var second_name= oneTokSelf(tempStr,"|",12);//副卡名称
	  var award_flag = oneTokSelf(tempStr,"|",14);//award_flag

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	    /********基本信息类**********/
      cust_info+="客户姓名：" +document.all.i4.value+"|";
      cust_info+="手机号码："+document.all.phone.value+"|";
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";
      cust_info+="副卡名称："+second_name+"|";
      cust_info+="副卡号码："+second_phone+"|";

      /********受理类**********/

      opr_info+="业务类型：预存送手机、话费共分享"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="主卡申请资费："+document.all.ip.value+"|";
      //孙振兴修改     START                    retInfo+="手机型号："+gift_code+deposit_fee+"|";
      opr_info+="手机型号："+brand_code+phone_type+"      IMEI码："+IMEINo+"|";
      //孙振兴修改     END
      opr_info+="缴款合计："+prepay_fee+"元、含主卡预存话费："+main_fee+"元，副卡预存话费"+second_fee+"元。"+"|";

     /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
     if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      note_info1+="欢迎您参加的“预存送手机，话费共分享”活动，主卡及副卡：在12个月内均不能变更资费套餐、主卡预存话费限在12月内消费完毕、副卡话费按12个月返还，当月返还金额，限在当月消费完毕。预存话费不能进行转帐及退款操作。"+"|";
			<%if(goodbz.equals("Y")){%>
			note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	  note_info1+="手机终端会自动对字数较多的短信进行拆分，不同型号手机终端拆分原则不同，我公司将按手机自动拆分的条数收费。"+"|";
	  /***************判断是否显示字符变更******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//薛英哲 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@关于积分清零条件调整的需求 zn->gn 积分不清零
  			/* ningtn 积分清零*/
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
		  		note_info1+="<%=readValue("8042","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
  		
	  if(award_flag == "1")
	  {
	  		note_info1 += "已参与赠送礼品活动"+"|";
	  }
	  else
	  {
	      note_info1 += "  "+"|";
	  }
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	    return retInfo;
}
/*欢乐新农村神州行手机营销*/
function printInfo8044()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	 // rdShowMessageDialog("tempStr = " + tempStr);
 //iAddStr格式 营销代码|品牌名称|应收金额|赠送话费|彩铃预存|机型名称|消费月份|SIM卡号|月底线|IMEI码|购机款|手机原价|
             //营销代码|品牌名称|应收金额|赠送话费|彩铃预存|机型名称|消费月份|SIM卡号|月底线|IMEI码|购机款|
		/**** ningtn add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}
		/**** ningtn add for pos end *****/
    var sale_code = oneTokSelf(tempStr,"|",1);     //营销代码
    var brand_code = oneTokSelf(tempStr,"|",2);      //品牌名称
	  var prepay_fee = oneTokSelf(tempStr,"|",3);     //应收金额
	  var main_fee = oneTokSelf(tempStr,"|",4);       //赠送话费
	  var second_fee = oneTokSelf(tempStr,"|",5);       //彩铃预存
	  var phone_type = oneTokSelf(tempStr,"|",6);    //机型名称
	  var mark_subtract = oneTokSelf(tempStr,"|",7);  //消费月份
	  var consume_term = oneTokSelf(tempStr,"|",8);   //SIM卡号
	  var monbase_fee = oneTokSelf(tempStr,"|",9);    //月底线
	  var IMEINo = oneTokSelf(tempStr,"|",10);//IMEI码


	  var cost_price = oneTokSelf(tempStr,"|",12);//IMEI码
	  var award_flag = oneTokSelf(tempStr,"|",14);//award_flag


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
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";

      /********受理类**********/
      opr_info+="业务类型：欢乐新农村神州行手机营销"+"|";
       <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="手机型号："+brand_code+phone_type+"      IMEI码："+IMEINo+"|";
      opr_info+="手机原价："+cost_price+"元"+"|";
      //王良 2007年9月28日 修改增加 0 != second_fee 不捆绑彩铃业务
      if (0 != second_fee){
      	opr_info+="缴款合计："+prepay_fee+"元 (其中：预存话费 "+main_fee+"元，彩铃专款 "+second_fee+"元)"+"|";
      }else{
      	opr_info+="缴款合计："+prepay_fee+"元 (其中：预存话费 "+main_fee+"元)"+"|";
      }
      opr_info+="捆绑资费："+(document.all.ip.value).trim()+"|";
      opr_info+="业务执行时间："+begin_time+"|";

       /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
     if(document.all.modestr.value.length>0){
      note_info2+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info2+=" "+"|";
      }
      note_info3+="捆绑资费说明：您办理本业务所交的费用包含预存话费、购机款和彩铃专款。彩铃专款仅用于按月冲减彩铃费用，从入网当月起您可以使用3个月的彩铃业务，到期请您自行取消，不取消将收取彩铃月使用费。预存话费每月最多允许使用总额的六分之一，超额发生的话费请您另行交纳。您本次活动办理的手机号码和手机必须在一起使用，否则将不允许使用预存话费。本次所交预存话费必须在一年内消费完毕，剩余款额将全部被清零。"+"|";
      note_info3+="本活动业务期限为一年，期限内不变更资费，不得退款，业务到期后可自行办理其他业务。业务到期前若申请取消，按违约规定您以优惠价购买的手机将按手机原价补交差额，并按剩余预存款的30%交纳违约金。"+"|";
      note_info3+="未涉及的资费，按现行的移动电话资费标准执行。本次活动手机适用中国移动业务。在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。"+"|"
      /***************判断是否显示字符变更******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
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
		  		note_info1+="<%=readValue("8044","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
			<%if(goodbz.equals("Y")){%>
			note_info4+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	 note_info4+="手机终端会自动对字数较多的短信进行拆分，不同型号手机终端拆分原则不同，我公司将按手机自动拆分的条数收费。"+"|";
			/*ningtn IMEI重新绑定需求*/
			note_info4 += "如您因手机丢失或人为损坏等个人原因无法使用而造成机卡分离，请到营业厅重新购机，否则将不能继续使用剩余话费。" + "|";
			if(award_flag == "1")
			{
					note_info4 += "已参与赠送礼品活动"+"|";
			}
			else
			{
			    note_info4 += "  "+"|";
			}



    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}
//预存换手机、话费共分享冲正
function printInfo8043()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	 // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr格式 原流水|营销代码|应收金额|主卡预存|副卡预存|预扣积分|消费月份|副卡月底线|机型名称|副卡号码|副卡名称|冲正资费|

	/**** ningtn add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="01";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="04";
	}
	/**** ningtn add for pos end *****/	

    var sale_code = oneTokSelf(tempStr,"|",2);     //营销代码
	  var prepay_fee = oneTokSelf(tempStr,"|",3);     //预存话费
	  var main_fee = oneTokSelf(tempStr,"|",4);       //主卡预存
	  var second_fee = oneTokSelf(tempStr,"|",5);       //副卡预存
	  var mark_subtract = oneTokSelf(tempStr,"|",6);  //预扣积分
	  var consume_term = oneTokSelf(tempStr,"|",7);   //消费月份
	  var monbase_fee = oneTokSelf(tempStr,"|",8);    //月底线
	  var brand_code = oneTokSelf(tempStr,"|",9);      //手机品牌
	  var second_phone= oneTokSelf(tempStr,"|",10);//副卡号码
	  var second_name= oneTokSelf(tempStr,"|",11);//副卡名称
	  var mode_name= oneTokSelf(tempStr,"|",12);//冲正资费名

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	    /********基本信息类**********/
     cust_info+="客户姓名：" +document.all.i4.value+"|";
     cust_info+="手机号码："+document.all.phone.value+"|";
     cust_info+="客户地址："+document.all.i5.value+"|";
     cust_info+="证件号码："+document.all.i7.value+"|";
     cust_info+="副卡名称："+second_name+"|";
     cust_info+="副卡号码："+second_phone+"|";
      /********受理类**********/
      opr_info+="业务类型：预存送手机、话费共分享冲正"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="主卡申请资费："+mode_name+"|";
      opr_info+="手机型号："+brand_code+"|";
      opr_info+="退款合计："+prepay_fee+"元、含主卡预存话费："+main_fee+"元，副卡预存话费"+second_fee+"元。"+"|";
      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}
//预存赠固话、话费可分享申请
function printInfo7671()
{
	//得到该业务工单需要的参数
	var tempStr = document.form1.iAddStr.value;
		/**** ningtn add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}
		/**** ningtn add for pos end *****/
	// rdShowMessageDialog("tempStr = " + tempStr);
	//iAddStr格式 营销代码|品牌名称|应收金额|底线预存|活动预存|机型名称|固话卡款|固话卡消费月份|手机卡款消费期限|IMEI码|手机卡号码|手机卡款|中奖标志|

    var sale_code = oneTokSelf(tempStr,"|",1);       //营销代码
    var brand_code = oneTokSelf(tempStr,"|",2);      //手机品牌
	var prepay_fee = oneTokSelf(tempStr,"|",3);      //应收金额
	var base_fee = oneTokSelf(tempStr,"|",4);        //底线预存
	var free_fee = oneTokSelf(tempStr,"|",5);        //活动预存
	var phone_type = oneTokSelf(tempStr,"|",6);      //手机型号
	var mach_fee  = oneTokSelf(tempStr,"|",7);       //固话卡款
	var consume_term = oneTokSelf(tempStr,"|",8);    //固话卡消费时间
	var active_term = oneTokSelf(tempStr,"|",9);     //手机卡款消费期限
	var IMEINo = oneTokSelf(tempStr,"|",10);         //IMEI码
	var second_phone = oneTokSelf(tempStr,"|",11);   //手机卡号码
	var phone_fee = oneTokSelf(tempStr,"|",12);      //手机卡款
	var award_flag = oneTokSelf(tempStr,"|",13);     //award_flag
	var  total_fee=parseFloat(base_fee)+parseFloat(free_fee);
	var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	/********基本信息类**********/
	cust_info+="客户姓名：" +document.all.i4.value+"|";
	cust_info+="手机号码："+document.all.phone.value+"|";
	cust_info+="客户地址："+document.all.i5.value+"|";
	cust_info+="证件号码："+document.all.i7.value+"|";
	cust_info+="手机号码："+second_phone+"|";

	/********受理类**********/

	opr_info+="业务类型：预存赠固话、话费可分享"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="业务流水："+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="业务流水："+"<%=printAccept%>"+"|";
	<%}%>
	//opr_info+="固话卡申请资费："+document.all.ip.value+"|";
	//opr_info+="固话卡型号："+brand_code+phone_type+"      IMEI码："+IMEINo+"|";

	opr_info+="固话卡月赠送费用"+total_fee/consume_term+"元，底限预存"+base_fee+"元，活动预存"+free_fee+"元，"+consume_term+"个月消费完毕|";
	opr_info+="捆绑手机号码："+second_phone+"，手机卡月赠送费用"+parseFloat(phone_fee/active_term).toFixed(2)+"元，分"+active_term+"个月赠送，"+active_term+"个月消费完毕|";

	/*******备注类**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********描述类*********/
	note_info2+="固话资费说明："+"|";
	note_info2+=" "+codeChg("<%=note.trim()%>")+"|";
	note_info2+="拆包后自动变更的资费说明："+"|";
	note_info2+=" "+codeChg("<%=note1.trim()%>")+"|";
	note_info2+="您的话机如拆包使用，则自动变更为以上资费，您可以到营业厅办理回原资费，当月办理次月生效。|";

	note_info3+="  "+"|";
	note_info4+="备注："+"|";
	/***************判断是否显示字符变更******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
	  var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
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
		  		note_info1+="<%=readValue("7671","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		 		
	if(award_flag == "1")
	{
		note_info1 += "已参与赠送礼品活动"+"|";
	}
	else
	{
		note_info1 += "  "+"|";
	}
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}
//预存赠固话、话费可分享冲正
function printInfo7672()
{
	//得到该业务工单需要的参数
	var tempStr = document.form1.iAddStr.value;
	/**** ningtn add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="01";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="04";
	}
	/**** ningtn add for pos end *****/	
	//iAddStr格式 原流水|营销代码|应收金额|底线预存|活动预存|固话款|消费月份|赠手机话费|机型名称|手机卡号码|手机卡话费期限|冲正资费|

	var sale_code = oneTokSelf(tempStr,"|",2);       //营销代码
	var prepay_fee = oneTokSelf(tempStr,"|",3);      //预存话费
	var base_fee = oneTokSelf(tempStr,"|",4);        //底线预存
	var free_fee = oneTokSelf(tempStr,"|",5);        //活动预存
	var fixed_fee = oneTokSelf(tempStr,"|",6);       //固话款
	var consume_term = oneTokSelf(tempStr,"|",7);    //消费月份
	var phone_fee = oneTokSelf(tempStr,"|",8);       //赠手机话费
	var brand_code = oneTokSelf(tempStr,"|",9);      //手机品牌
	var second_phone= oneTokSelf(tempStr,"|",10);    //手机卡号码
	var active_term= oneTokSelf(tempStr,"|",11);     //手机卡消费期限
	var mode_name= oneTokSelf(tempStr,"|",12);       //冲正资费名
      
	var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';
      
     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	    /********基本信息类**********/
     cust_info+="客户姓名：" +document.all.i4.value+"|";
     cust_info+="手机号码："+document.all.phone.value+"|";
     cust_info+="客户地址："+document.all.i5.value+"|";
     cust_info+="证件号码："+document.all.i7.value+"|";

     
	  /********受理类**********/
      opr_info+="业务类型：预存赠固话、话费可分享冲正"+"|";
      <%if(goodbz.equals("Y")){%>
      		opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}else{%>
      		opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      //opr_info+="主卡申请资费："+mode_name+"|";
      opr_info+="固话品牌型号："+brand_code+"|";
      opr_info+="退款合计："+prepay_fee+"元，底限预存"+base_fee+"元，活动预存"+free_fee+"元,"+"|";
      opr_info+="捆绑手机卡号码："+second_phone+"，手机卡赠送费用"+phone_fee+"元|";
      
      /*******备注类**********/
	  if("<%=bdbz%>"=="Y")
	  {
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
function printInfo8045()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	 // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr格式 旧流水|营销代码|应收|赠送预存|彩铃专款|消费期限|月底线|机型|购机款|手机原价|IMEI|冲正套餐代码 冲正套餐名称|
	  
	/**** ningtn add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="01";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="04";
	}
	/**** ningtn add for pos end *****/	
	  
    	  var sale_code = oneTokSelf(tempStr,"|",2);     //营销代码
    	  var brand_code = oneTokSelf(tempStr,"|",8);      //品牌名称
	  var prepay_fee = oneTokSelf(tempStr,"|",3);     //应收金额
	  var main_fee = oneTokSelf(tempStr,"|",4);       //赠送话费
	  var second_fee = oneTokSelf(tempStr,"|",5);       //彩铃预存
	  var mark_subtract = oneTokSelf(tempStr,"|",6);  //消费月份
	  var monbase_fee = oneTokSelf(tempStr,"|",7);    //月底线
	  var cost_price = oneTokSelf(tempStr,"|",10);//手机原价
	  var IMEINo=oneTokSelf(tempStr,"|",11);//IMEI码
	  var mode_name= oneTokSelf(tempStr,"|",12);//冲正资费名



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
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";

      /********受理类**********/
      opr_info+="业务类型：欢乐新农村神州行手机营销冲正"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="手机型号："+brand_code+"      IMEI码："+IMEINo+"|";
      opr_info+="手机原价："+cost_price+"元"+"|";

      if (0 != second_fee){
      	opr_info+="退款合计："+prepay_fee+"元（其中：预存话费 "+main_fee+"元，彩铃专款 "+second_fee+"元)"+"|";
      }else{
      	opr_info+="退款合计："+prepay_fee+"元（其中：预存话费 "+main_fee+"元)"+"|";
      }
      opr_info+="捆绑资费："+mode_name+"|";
      opr_info+="业务执行时间："+begin_time+"|";

      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      note_info2+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info2+=" "+"|";
      }

     <%if(goodbz.equals("Y")){%>
			note_info3+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
      //retInfo+="您必须所交的费用包含预存话费、购机款和彩铃专款。彩铃专款仅用于按月冲减彩铃费用，从入网当月起您可以使用3个月的彩铃业务，到期请您自行取消，不取消将收取彩铃月使用费。预存话费每月最多允许使用总额的六分之一，超额发生的话费请您另行交纳。您本次活动办理的手机号码和手机必须在一起使用，否则将不允许使用预存话费。因以上情况而引起欠费拆机等相关问题，移动公司有权将剩余预存款及号码收回。本次所交预存话费必须在一年内消费完毕，剩余款额将全部被清零。"+"|";
      //retInfo+="本活动期限为一年，期限内不得变更资费，不得退款，业务到期后可以按规定办理其他优惠。业务到期前若申请取消，您以优惠价购买的手机将按手机原价补交差额，并按剩余预存款的30%交纳违约金。"+"|";
     // retInfo+="未涉及的资费，按现行的移动电话资费标准执行。本次活动手机适用中国移动业务。在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。"+"|";

    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");

	  return retInfo;
}
//签约赠机申请
function printInfo126h()
{	
	
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	 // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr格式 礼品等级|礼品代码|预存话费|底线预存|活动预存|抵押预存|预扣积分|消费月份|月底线|礼品名称|

		/**** tianyang add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}
		/**** tianyang add for pos end *****/

    var gift_grade = oneTokSelf(tempStr,"|",1);     //营销代码
    var gift_code = oneTokSelf(tempStr,"|",2);      //手机品牌
	  var prepay_fee = oneTokSelf(tempStr,"|",3);     //预存话费
	  var base_fee = oneTokSelf(tempStr,"|",4);       //底线预存
	  var free_fee = oneTokSelf(tempStr,"|",5);       //活动预存
	  var deposit_fee = oneTokSelf(tempStr,"|",6);    //手机型号
	  var mark_subtract = oneTokSelf(tempStr,"|",7);  //预扣积分
	  var consume_term = oneTokSelf(tempStr,"|",8);   //消费月份
	  var monbase_fee = oneTokSelf(tempStr,"|",9);    //月底线
	  var IMEINo = oneTokSelf(tempStr,"|",10);

	  var award_flag = oneTokSelf(tempStr,"|",12);//award_flag
	  var sale_kind=oneTokSelf(tempStr,"|",13);

	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
	  var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";

	    var retInfo = "";
	    /********基本信息类**********/
	  var cust_info=""; //客户信息
	  var opr_info=""; //操作信息
	  var note_info1=""; //备注1
	  var note_info2=""; //备注2
	  var note_info3=""; //备注3
	  var note_info4=""; //备注4

	  cust_info+="手机号码："+document.all.phone.value+"|";
	  cust_info+="客户姓名："+document.all.i4.value+"|";
	  cust_info+="客户地址："+document.all.i5.value+"|";
	  cust_info+="证件号码："+document.all.i7.value+"|";

      /********受理类**********/

      opr_info+="业务类型：签约赠机"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      //孙振兴修改     START                    opr_info+="手机型号："+gift_code+deposit_fee+"|";
      opr_info+="手机型号："+gift_code+deposit_fee+"      IMEI码："+IMEINo+"|";
      //孙振兴修改     END
      opr_info+="缴款合计："+prepay_fee+"元、其中话费预存款："+prepay_fee+"元。"+"|";

      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/

      note_info2+="备注：欢迎您参加“签约赠机”活动，你的话费预存款在未消费完毕前不能退、转款，签约期间不能变更资费套餐。"+"|";
      note_info2+="参与手机销售活动所获赠的话费未消费完，客户不能办理消户业务。"+"|";
      note_info2+="您参加本次活动的预存话费，要求一年内（含办理当月）消费完毕，且每月有底限消费，底限消费金额请参见购机时的业务说明。您参加本次活动所签约的资费12个月内（含办理当月）不允许变更，到期后变更资费时，新资费的生效时间，根据您选择的新资费决定是当月生效，还是次月生效。"+"|";
			if(document.all.modestr.value.length>0){
      note_info2+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info2+=" "+"|";
      }
      note_info2+="手机终端会自动对字数较多的短信进行拆分，不同型号手机终端拆分原则不同，我公司将按手机自动拆分的条数收费。"+"|";
	  /*****sunaj  20091221 提醒用户积分清零*****/
	  if(old_SmCode=="zn")
	  {
	  		 note_info2+=" ";
	  }else
	  {
	  		if(old_SmCode != new_SmCode)
	  		{
	  			/* ningtn 积分清零 */

	  		}
	  }
	  	  			/* wanghyd 去掉积分清零提示同时增加提示 */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("126h","ps","jf",Readpaths)%>"+"|";
		  		<%}%>

			<%if(goodbz.equals("Y")){%>
			note_info3+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
		if(sale_kind=="1" || sale_kind=="2")
		{
			note_info3 += "主、副卡客户进行绑定关联，不能再与其它手机绑定，只有副卡客户取消后，主卡客户业务才能取消。"+"|";
		}

		if(award_flag == "1")
		{
				note_info3 += "已参与赠送礼品活动"+"|";
		}
		else
		{
		    note_info3 += "  "+"|";
		}

		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//彩铃营销案申请
function printInfo7960()
{
   //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr=营销案代码|彩铃资费代码|专款预存|彩铃开始时间|操作备注|冲正流水|到期资费
    var sale_code = oneTokSelf(tempStr,"|",1);
      var color_mode = oneTokSelf(tempStr,"|",2);
	  var prepay_fee = oneTokSelf(tempStr,"|",3);
	  var mode_begintime = oneTokSelf(tempStr,"|",4);
	  var op_note = oneTokSelf(tempStr,"|",5);
	  var oldaccept = oneTokSelf(tempStr,"|",6);
	  var next_mode = oneTokSelf(tempStr,"|",7);
    var exeDate = "<%=exeDate.substring(0,8)%>";//生效日期
    var smName = "";
	var smCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
	var old_smCode = "<%=WtcUtil.repNull(request.getParameter("oSmName"))%>";
	if("<%=new_smCode%>" == "zn")
		smName="神州行";
	else if("<%=new_smCode%>" == "gn")
		smName="全球通";
	else if("<%=new_smCode%>" == "dn")
		smName="动感地带";

    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    /********基本信息类**********/
    cust_info += "客户姓名：" + document.all.i4.value + "|";
    cust_info += "手机号码：" + document.all.phone.value + "|";
    //cust_info += "客户地址：" + document.all.i5.value + "|";
    //cust_info += "证件号码：" + document.all.i7.value + "|";

    /********受理类**********/
    opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "   用户品牌："+ old_smCode + "|";
<%if(goodbz.equals("Y")){%>
    opr_info += "业务类型:" + "彩铃营销案申请" + "  " + "操作流水: " + "<%=printAccept%>" + "|";

<%}else{%>
    opr_info += "业务类型:" + "彩铃营销案申请" + "  " + "操作流水: " + "<%=printAccept%>" + "|";
<%}%>
    opr_info+="新申请主资费："+codeChg(document.form1.ip.value.trim())+"   "+"生效时间："+checkdate(exeDate)+"|";
    opr_info += "新主资费品牌：" + smName+ "|";
    opr_info += "到期后执行资费：" + "<%=WtcUtil.repNull(request.getParameter("next_mode"))%>" +"  "+" <%=nextName%>" +"|";
	opr_info+=""+"|" ;
	if( document.all.kx_want.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_want.value) + "|";
    }
    if( document.all.kx_cancle.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_cancle.value) + "|";
    }
    /*******备注类**********/
    if ("<%=bdbz%>" == "Y") {
        note_info1 += "<%=bdts%>" + "|";
    } else {

    }
    /**********描述类*********/
	note_info1+="."+"|";
    note_info1+="新申请主资费描述:"+"|";
    note_info1+=" "+codeChg("<%=note.trim()%>")+"|";
    if(document.all.kx_explan_bunch.value.trim().len()==0){

	  }else{
	    note_info3+="."+"| ";
	  	note_info3+="可选资费描述："+"|";
	  	note_info3+=document.all.kx_explan_bunch.value+"|";
	  	//alert(document.all.kx_explan_bunch.value);
  	}
  	if(document.all.modestr.value.length>0){
  	  note_info4+=" ."+"|";
      note_info4+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{

      }

    note_info2+="到期后资费描述:"+"|";
    note_info2+= " " +"|";
    note_info2+=codeChg("<%=note1.trim()%>")+"|";

<%if(goodbz.equals("Y")){%>
    note_info4 += " " + "|";
    note_info4 += "备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。" + "|";
<%}%>
    note_info4 += " " + "|";
    note_info4 += "备注：" + "|";
    document.all.cust_info.value = cust_info + "#";
    document.all.opr_info.value = opr_info + "#";
    document.all.note_info1.value = note_info1 + "#";
    document.all.note_info2.value = note_info2 + "#";
    document.all.note_info3.value = note_info3 + "#";
    document.all.note_info4.value = note_info4 + "#";
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	/***************判断是否显示字符变更******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
	  var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
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
		  		note_info1+="<%=readValue("7960","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
//彩铃营销案冲正
function printInfo7964()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr=营销案代码|彩铃资费代码|专款预存|彩铃开始时间|操作备注|冲正流水|

      var sale_code = oneTokSelf(tempStr,"|",1);
      var color_mode = oneTokSelf(tempStr,"|",2);
	  var prepay_fee = oneTokSelf(tempStr,"|",3);
	  var mode_begintime = oneTokSelf(tempStr,"|",4);
	  var op_note = oneTokSelf(tempStr,"|",5);
	  var oldaccept = oneTokSelf(tempStr,"|",6);
	    var retInfo = "";
	    /********基本信息类**********/
	  var cust_info=""; //客户信息
	  var opr_info=""; //操作信息
	  var note_info1=""; //备注1
	  var note_info2=""; //备注2
	  var note_info3=""; //备注3
	  var note_info4=""; //备注4

	  cust_info+="手机号码："+document.all.phone.value+"|";
	  cust_info+="客户姓名："+document.all.i4.value+"|";
	  //cust_info+="客户地址："+document.all.i5.value+"|";
	  //cust_info+="证件号码："+document.all.i7.value+"|";

      /********受理类**********/

      opr_info+="业务类型：彩铃营销案冲正"+"|";
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      opr_info+=""+"|";
      /*******备注类**********/
	  opr_info+=""+"|";
	  /**********描述类*********/
	<%if(goodbz.equals("Y")){%>
    note_info4 += " " + "|";
    note_info4 += "备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。" + "|";
	<%}%>
    note_info4 += " " + "|";
    note_info4 += "备注："+"|";
      	opr_info+=""+"|";
      	opr_info+=""+"|";
      	opr_info+=""+"|";
	  	opr_info+=""+"|";
      	opr_info+=""+"|";
		opr_info+=""+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  	return retInfo;
}
//彩铃营销案续签
function printInfo7965()
{
	 //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr=营销案代码|彩铃资费代码|专款预存|彩铃开始时间|操作备注|冲正流水|到期资费
    var sale_code = oneTokSelf(tempStr,"|",1);
      var color_mode = oneTokSelf(tempStr,"|",2);
	  var prepay_fee = oneTokSelf(tempStr,"|",3);
	  var mode_begintime = oneTokSelf(tempStr,"|",4);
	  var op_note = oneTokSelf(tempStr,"|",5);
	  var oldaccept = oneTokSelf(tempStr,"|",6);
	  var next_mode = oneTokSelf(tempStr,"|",7);
    var exeDate = "<%=exeDate.substring(0,8)%>";//生效日期

    <%

    String tempSqlStr = "select b.band_name from product_offer a,band b where a.offer_id='"+NextNew_m_code+"' and a.band_id=b.band_id";
    System.out.println("--------------------tempSqlStr-----------------"+tempSqlStr);
    %>

 		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=tempSqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_th3" scope="end"/>

	   <%
	   String tempSmNameStr = "";
	   	if(result_th3.length>0&&result_th3[0][0]!=null)
	   	tempSmNameStr = result_th3[0][0];
	   %>
    var smName = "";

	var smCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
	var old_smCode = "<%=WtcUtil.repNull(request.getParameter("oSmName"))%>";
	if("<%=NextNew_m_code%>" == "zn")
		smName="神州行";
	else if("<%=NextNew_m_code%>" == "gn")
		smName="全球通";
	else if("<%=NextNew_m_code%>" == "dn")
		smName="动感地带";

    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    /********基本信息类**********/
    cust_info += "客户姓名：" + document.all.i4.value + "|";
    cust_info += "手机号码：" + document.all.phone.value + "|";
    //cust_info += "客户地址：" + document.all.i5.value + "|";
    //cust_info += "证件号码：" + document.all.i7.value + "|";

    /********受理类**********/
    opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "  用户品牌："+old_smCode + "|";
<%if(goodbz.equals("Y")){%>
    opr_info += "业务类型:" + "彩铃营销案续签" + "  " + "操作流水: " + "<%=printAccept%>" + "|";
    ;
<%}else{%>
    opr_info += "业务类型:" + "彩铃营销案续签" + "  " + "操作流水: " + "<%=printAccept%>" + "|";
<%}%>
	  opr_info += ""+"|";
    opr_info += "新申请的主资费："+" " + "<%=WtcUtil.repNull(request.getParameter("Nmode_code"))%>"+"  "+"<%=WtcUtil.repNull(request.getParameter("Nmode_name"))%>"+"  "+"生效时间："+exeDate + "|";
    opr_info += "新主资费品牌： <%=tempSmNameStr%>"+ "|";
    opr_info += "到期后执行资费："+" " + "<%=WtcUtil.repNull(request.getParameter("next_mode"))%>"+"  " + "资费名称 : "+" "+" <%=nextName%>"+"|";

    /*******备注类**********/
    if ("<%=bdbz%>" == "Y") {
        note_info1 += "<%=bdts%>" + "|";
    } else {

    }
    /**********描述类*********/
	note_info1+=""+"|";
    note_info1+="新申请主资费描述:"+"|";
    note_info1+=" "+codeChg("<%=note.trim()%>")+"|";
	if(document.all.kx_explan_bunch.value.trim().len()==0){

	  }else{
	    note_info3+="."+"| ";
	  	note_info3+="可选资费描述："+"|";
	  	note_info3+=document.all.kx_explan_bunch.value+"|";
	  	//alert(document.all.kx_explan_bunch.value);
  	}
  	if(document.all.modestr.value.length>0){
  	  note_info4+=" ."+"|";
      note_info4+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{

      }

    note_info2 += "到期后执行资费描述：" + "|";
    note_info2+=" "+codeChg("<%=note1.trim()%>")+"|";
<%if(goodbz.equals("Y")){%>
    note_info4 += " " + "|";
    note_info4 += "备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。" + "|";
<%}%>
    note_info4 += " " + "|";
    note_info4 += "备注：" + "|";
    document.all.cust_info.value = cust_info + "#";
    document.all.opr_info.value = opr_info + "#";
    document.all.note_info1.value = note_info1 + "#";
    document.all.note_info2.value = note_info2 + "#";
    document.all.note_info3.value = note_info3 + "#";
    document.all.note_info4.value = note_info4 + "#";
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
//彩铃营销案续签冲正
function printInfo7966()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr=营销案代码|彩铃资费代码|专款预存|彩铃开始时间|操作备注|冲正流水|

      var sale_code = oneTokSelf(tempStr,"|",1);
      var color_mode = oneTokSelf(tempStr,"|",2);
	  var prepay_fee = oneTokSelf(tempStr,"|",3);
	  var mode_begintime = oneTokSelf(tempStr,"|",4);
	  var op_note = oneTokSelf(tempStr,"|",5);
	  var oldaccept = oneTokSelf(tempStr,"|",6);
	    var retInfo = "";
	    /********基本信息类**********/
	  var cust_info=""; //客户信息
	  var opr_info=""; //操作信息
	  var note_info1=""; //备注1
	  var note_info2=""; //备注2
	  var note_info3=""; //备注3
	  var note_info4=""; //备注4

	  cust_info+="手机号码："+document.all.phone.value+"|";
	  cust_info+="客户姓名："+document.all.i4.value+"|";
	  //cust_info+="客户地址："+document.all.i5.value+"|";
	  //cust_info+="证件号码："+document.all.i7.value+"|";

      /********受理类**********/

      opr_info+="业务类型：彩铃营销案续签冲正"+"|";
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      opr_info+=""+"|";

      /*******备注类**********/
	  opr_info+=""+"|";
	  /**********描述类*********/
	<%if(goodbz.equals("Y")){%>
    note_info4 += " " + "|";
    note_info4 += "备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。" + "|";
	<%}%>
    note_info4 += " " + "|";
    note_info4 += "备注："+"|";
      	opr_info+=""+"|";
      	opr_info+=""+"|";
      	opr_info+=""+"|";
	  	opr_info+=""+"|";
      	opr_info+=""+"|";
		opr_info+=""+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  	return retInfo;
}
//彩铃营销案取消
function printInfo7967()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr=营销案代码|彩铃资费代码|专款预存|彩铃开始时间|操作备注|冲正流水|

      var sale_code = oneTokSelf(tempStr,"|",1);
      var color_mode = oneTokSelf(tempStr,"|",2);
	  var prepay_fee = oneTokSelf(tempStr,"|",3);
	  var mode_begintime = oneTokSelf(tempStr,"|",4);
	  var op_note = oneTokSelf(tempStr,"|",5);
	  var oldaccept = oneTokSelf(tempStr,"|",6);
	    var retInfo = "";
	    /********基本信息类**********/
	  var cust_info=""; //客户信息
	  var opr_info=""; //操作信息
	  var note_info1=""; //备注1
	  var note_info2=""; //备注2
	  var note_info3=""; //备注3
	  var note_info4=""; //备注4

	  cust_info+="手机号码："+document.all.phone.value+"|";
	  cust_info+="客户姓名："+document.all.i4.value+"|";
	  //cust_info+="客户地址："+document.all.i5.value+"|";
	  //cust_info+="证件号码："+document.all.i7.value+"|";

      /********受理类**********/

      opr_info+="业务类型：彩铃营销案取消"+"|";
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      opr_info+=""+"|";

      /*******备注类**********/
	  opr_info+=""+"|";
	  /**********描述类*********/
	note_info4 += "备注："+"|";
	<%if(goodbz.equals("Y")){%>
    note_info4 += " " + "|";
    note_info4 += "备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。" + "|";
	<%}%>
    note_info4 += " " + "|";

      	opr_info+=""+"|";
      	opr_info+=""+"|";
      	opr_info+=""+"|";
	  	opr_info+=""+"|";
      	opr_info+=""+"|";
		opr_info+=""+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  	return retInfo;
}
//签约赠机冲正
function printInfo126i()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr格式 礼品等级|礼品代码|预存话费|底线预存|活动预存|抵押预存|预扣积分|消费月份|月底线|礼品名称|

		/**** tianyang add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="01";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="04";
		}
		/**** tianyang add for pos end *****/

    var gift_grade = oneTokSelf(tempStr,"|",1);     //冲正流水
    var gift_code = oneTokSelf(tempStr,"|",2);      //营销代码
	  var prepay_fee = oneTokSelf(tempStr,"|",3);     //预存话费
	  var base_fee = oneTokSelf(tempStr,"|",4);       //底线预存
	  var free_fee = oneTokSelf(tempStr,"|",5);       //活动预存
	  var deposit_fee = oneTokSelf(tempStr,"|",6);    //抵押预存
	  var mark_subtract = oneTokSelf(tempStr,"|",7);  //预扣积分
	  var consume_term = oneTokSelf(tempStr,"|",8);   //消费月份
	  var monbase_fee = oneTokSelf(tempStr,"|",9);    //月底线
	  var type_name = oneTokSelf(tempStr,"|",10);  //机型

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	    var retInfo = "";
	    /********基本信息类**********/
	  var cust_info=""; //客户信息
	  var opr_info=""; //操作信息
	  var note_info1=""; //备注1
	  var note_info2=""; //备注2
	  var note_info3=""; //备注3
	  var note_info4=""; //备注4

	  cust_info+="手机号码："+document.all.phone.value+"|";
	  cust_info+="客户姓名："+document.all.i4.value+"|";
	  cust_info+="客户地址："+document.all.i5.value+"|";
	  cust_info+="证件号码："+document.all.i7.value+"|";

     /********受理类**********/
      opr_info+="业务类型：签约赠机冲正"+"|";

      <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="手机型号："+type_name+"|";
      opr_info+="退款合计："+prepay_fee+"元、其中话费预存款："+prepay_fee+"元。"+"|";

       /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
     if(document.all.modestr.value.length>0){
      note_info2+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info2+=" "+"|";
      }
			<%if(goodbz.equals("Y")){%>
			note_info2+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}

//集团客户预存赠机申请
function printInfo8023()
{
	//得到该业务工单需要的参数
	var tempStr = document.form1.iAddStr.value;
	// rdShowMessageDialog("tempStr = " + tempStr);
	//iAddStr格式 礼品等级|礼品代码|预存话费|底线预存|活动预存|抵押预存|预扣积分|消费月份|月底线|礼品名称|
		
	/**** tianyang add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="00";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="05";
	}
	/**** tianyang add for pos end *****/
		
	var gift_grade = oneTokSelf(tempStr,"|",1);     //营销代码
  var gift_code = oneTokSelf(tempStr,"|",2);      //手机品牌
	var prepay_fee = oneTokSelf(tempStr,"|",3);     //预存话费
	var base_fee = oneTokSelf(tempStr,"|",4);       //底线预存
	var free_fee = oneTokSelf(tempStr,"|",5);       //活动预存
	var deposit_fee = oneTokSelf(tempStr,"|",6);    //手机型号
	var mark_subtract = oneTokSelf(tempStr,"|",7);  //预扣积分
	var consume_term = oneTokSelf(tempStr,"|",8);   //消费月份
	var monbase_fee = oneTokSelf(tempStr,"|",9);    //月底线
	var IMEINo = oneTokSelf(tempStr,"|",10);

	var award_flag = oneTokSelf(tempStr,"|",12);//award_flag
	
	var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
  var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";

	var retInfo = "";	
	
	/********基本信息类**********/	
	var cust_info=""; //客户信息
  var opr_info=""; //操作信息
  var note_info1=""; //备注1
  var note_info2=""; //备注2
  var note_info3=""; //备注3
  var note_info4=""; //备注4

  cust_info+="手机号码："+document.all.phone.value+"|";
  cust_info+="客户姓名："+document.all.i4.value+"|";
  cust_info+="客户地址："+document.all.i5.value+"|";
  cust_info+="证件号码："+document.all.i7.value+"|";
	
		/********受理类**********/	
	opr_info+="业务类型：集团客户预存赠机申请"+"|";
  <%if(goodbz.equals("Y")){%>
  opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
  <%}else{%>
  opr_info+="业务流水："+"<%=printAccept%>"+"|";
  <%}%>
  //孙振兴修改     START                    opr_info+="手机型号："+gift_code+deposit_fee+"|";
  opr_info+="手机型号："+gift_code+deposit_fee+"      IMEI码："+IMEINo+"|";
  //孙振兴修改     END
  opr_info+="缴款合计："+prepay_fee+"元、其中话费预存款："+prepay_fee+"元。"+"|";

  /*******备注类**********/
	if("<%=bdbz%>"=="Y"){
  	note_info1+="<%=bdts%>"+"|";
  }else{
		note_info1+=" "+"|";
	}
	/**********描述类*********/
	note_info2+="您参与集团客户预存话费赠手机活动后，预存话费不退不转，签约期为1年，底线预存按月返还。签约期内不能办理资费变更。如果要求取消限制，，所得礼品需由您按原价买回。资费取消后，剩余的包年费按30%收作违约金。"+"|";
	if(document.all.modestr.value.length>0){
  note_info2+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
  }else{
  note_info2+=" "+"|";
  }
  <%if(goodbz.equals("Y")){%>
		note_info2+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
	<%}%>
  note_info2+="手机终端会自动对字数较多的短信进行拆分，不同型号手机终端拆分原则不同，我公司将按手机自动拆分的条数收费。"+"|";
  /***************判断是否显示字符变更******************/
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
		  		note_info1+="<%=readValue("8023","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
		  		
  if(award_flag == "1")
	{
			note_info2 += "已参与赠送礼品活动"+"|";
	}
	else
	{
	    note_info2 += "  "+"|";
	}
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}
//集团客户预存赠机冲正
function printInfo8024()
{
	//得到该业务工单需要的参数
	var tempStr = document.form1.iAddStr.value;
	//rdShowMessageDialog("tempStr = " + tempStr);
	//iAddStr格式 礼品等级|礼品代码|预存话费|底线预存|活动预存|抵押预存|预扣积分|消费月份|月底线|礼品名称|
	
	/**** tianyang add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="01";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="04";
	}
	/**** tianyang add for pos end *****/	


  var gift_grade = oneTokSelf(tempStr,"|",1);     //冲正流水
  var gift_code = oneTokSelf(tempStr,"|",2);      //营销代码
	var prepay_fee = oneTokSelf(tempStr,"|",3);     //预存话费
	var base_fee = oneTokSelf(tempStr,"|",4);       //底线预存
	var free_fee = oneTokSelf(tempStr,"|",5);       //活动预存
	var deposit_fee = oneTokSelf(tempStr,"|",6);    //抵押预存
	var mark_subtract = oneTokSelf(tempStr,"|",7);  //预扣积分
	var consume_term = oneTokSelf(tempStr,"|",8);   //消费月份
	var monbase_fee = oneTokSelf(tempStr,"|",9);    //月底线
	var type_name = oneTokSelf(tempStr,"|",10);  //机型
	
	var retInfo = "";
	/********基本信息类**********/	
	var cust_info=""; //客户信息
  var opr_info=""; //操作信息
  var note_info1=""; //备注1
  var note_info2=""; //备注2
  var note_info3=""; //备注3
  var note_info4=""; //备注4

  cust_info+="手机号码："+document.all.phone.value+"|";
  cust_info+="客户姓名："+document.all.i4.value+"|";
  cust_info+="客户地址："+document.all.i5.value+"|";
  cust_info+="证件号码："+document.all.i7.value+"|";
	/********受理类**********/
	opr_info+="业务类型：集团客户预存赠机冲正"+"|";

  <%if(goodbz.equals("Y")){%>
  opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
  <%}else{%>
  opr_info+="业务流水："+"<%=printAccept%>"+"|";
  <%}%>
  opr_info+="手机型号："+type_name+"|";
  opr_info+="退款合计："+prepay_fee+"元、其中话费预存款："+prepay_fee+"元。"+"|";

  /*******备注类**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********描述类*********/
	if(document.all.modestr.value.length>0){
  	note_info2+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
  }else{
  	note_info2+=" "+"|";
  }
	<%if(goodbz.equals("Y")){%>
	note_info2+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
	<%}%>
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}



//特殊号码资费营销案申请
function printInfo8094()
{
	  //得到该业务工单需要的参数
	   var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	  var retInfo = "";

	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//礼品代码
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//预存话费
		var base_fee      = oneTokSelf(tempStr,"|",3);	//底线预存
		var free_fee      = oneTokSelf(tempStr,"|",4);	//活动预存
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//预扣积分
		var consume_term  = oneTokSelf(tempStr,"|",6);	//消费月份
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//月底线
		var gift_name     = oneTokSelf(tempStr,"|",8);	//礼品名称

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>';

	  /********基本信息类**********/

      cust_info+="手机号码："+document.all.phone.value+"|";
      cust_info+="客户姓名：" +document.all.i4.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";
      cust_info+="客户地址："+document.all.i5.value+"|";


      /********受理类**********/
      opr_info+="用户品牌："+'<%=WtcUtil.repNull(request.getParameter("oSmName"))%>'+"                   办理业务：特殊号码资费营销案申请"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="操作流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="操作流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="月租费: "+monbase_fee+"元     业务操作时间: "+begin_time+"|";
      opr_info+="包年费: "+prepay_fee+"元|";
      opr_info+="包年期限："+consume_term+"个月"+"         业务生效时间："+"<%=exeDate.substring(0,8)%>"+"|";
      opr_info+="指定资费： "+ document.all.ip.value+"|";
      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
      note_info1+="指定资费描述："+"<%=note%>"+"|";

      note_info1+="包年有效期为12个月，一年内不可以资费变更。包年资费到期后自动转为神州行30普通赠来电。新业务包年费用一次收取，不退不转。"+"|";
	  /***************判断是否显示字符变更******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
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
		  		note_info1+="<%=readValue("8094","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
		  		
	  <%if(goodbz.equals("Y")){%>
			note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;

}
//特殊号码资费营销案冲正
function printInfo8091()
{

	 var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	 var retInfo = "";


	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//礼品代码
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//预存话费
		var base_fee      = oneTokSelf(tempStr,"|",3);	//底线预存
		var free_fee      = oneTokSelf(tempStr,"|",4);	//活动预存
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//预扣积分
		var consume_term  = oneTokSelf(tempStr,"|",6);	//消费月份
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//月底线
		var gift_name     = oneTokSelf(tempStr,"|",9);	//礼品名称

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********基本信息类**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      cust_info+="手机号码："+document.all.phone.value+"|";
      cust_info+="客户姓名：" +document.all.i4.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";
      cust_info+="客户地址："+document.all.i5.value+"|";

      /********受理类**********/
      opr_info+="业务类型：特殊号码资费营销案冲正"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="月租费: "+monbase_fee+"元     业务操作时间: "+begin_time+"|";
      opr_info+="包年费: "+prepay_fee+"元|";
      opr_info+="包年期限:  "+consume_term+"个月|";
      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;

}
//农村低端营销案
function formatFloat(src, pos)
{
    return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos);
}

function printInfo8034()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr格式 营销代码|手机品牌|预存话费|农情包费用|机型|收费|SP代码|礼品代码|礼品名称|IMEI码|

    var gift_grade = oneTokSelf(tempStr,"|",1);     //营销代码
    var phone_code = oneTokSelf(tempStr,"|",2);      //手机品牌

	  var prepay_fee = oneTokSelf(tempStr,"|",3);     //预存话费

	  var phone_type = oneTokSelf(tempStr,"|",5);    //手机型号
	  var sp_fee = oneTokSelf(tempStr,"|",4);  //农情包费用
	  var gift_name = oneTokSelf(tempStr,"|",9);   //礼品名称
	  var gift_code=oneTokSelf(tempStr,"|",8);//礼品代码
	  var pay_money= oneTokSelf(tempStr,"|",6); //收费
	  var IMEINo = oneTokSelf(tempStr,"|",10);  //IMEI码



	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	    var retInfo = "";
	     /********基本信息类**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="客户名称：" +document.all.i4.value+"|";
      retInfo+="手机号码："+document.all.phone.value+"|";
      retInfo+="客户地址："+document.all.i5.value+"|";
      retInfo+="证件号码："+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
     /********受理类**********/
      retInfo+="业务类型：建设新农村、手机乐万家"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      retInfo+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
     //孙振兴修改     START                    retInfo+="手机型号："+phone_code+phone_type+"|";
      retInfo+="手机型号："+phone_code+phone_type+"      IMEI码："+IMEINo+"|";
      //孙振兴修改     END
      if(gift_code==""){
      retInfo+="缴款合计："+pay_money+"元、含预存话费："+prepay_fee+"元，农信通业务包年费用:"+sp_fee+"元；"+"|";
      }else{
      retInfo+="缴款合计："+pay_money+"元、含预存话费："+prepay_fee+"元，农信通业务包年费用:"+sp_fee+"元；赠送礼品："+gift_name+"。"+"|";
      }
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
			/*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********描述类*********/
      retInfo+="备注：欢迎您参加“建设新农村、手机乐万家”活动。1、您的话费预存款分六个月返还，月返还金额为"+formatFloat(prepay_fee/6, 2)+"元，在十二个月以内不能变更资费套餐；2、农信通业务费分12个月返还，月返还金额3元，此期间农信通业务不能变更、取消。"+"|";
      if(document.all.modestr.value.length>0){
      retInfo+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			retInfo+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>


	  return retInfo;
}
function printInfo8035()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	 // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr格式 原流水|营销代码|机型名称|预存话费|农情包费用|收费|SP代码|礼品名称|

    var gift_grade = oneTokSelf(tempStr,"|",1);     //营销代码
    var phone_type = oneTokSelf(tempStr,"|",3);      //手机品牌

	  var prepay_fee = oneTokSelf(tempStr,"|",4);     //预存话费


	  var sp_fee = oneTokSelf(tempStr,"|",5);  //农情包费用
	  var gift_name = oneTokSelf(tempStr,"|",8);   //礼品名称

	  var pay_money= oneTokSelf(tempStr,"|",6); //收费



	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	    var retInfo = "";
	    /********基本信息类**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="客户名称：" +document.all.i4.value+"|";
      retInfo+="手机号码："+document.all.phone.value+"|";
      retInfo+="客户地址："+document.all.i5.value+"|";
      retInfo+="证件号码："+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
     /********受理类**********/
      retInfo+="业务类型：建设新农村、手机乐万家冲正"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      retInfo+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="手机型号："+phone_type+"|";

      if(gift_name==""){
      retInfo+="退款合计："+pay_money+"元、含预存话费："+prepay_fee+"元，农信通业务包年费用:"+sp_fee+"元；"+"|";
      }else{
      retInfo+="退款合计："+pay_money+"元、含预存话费："+prepay_fee+"元，农信通业务包年费用:"+sp_fee+"元；赠送礼品："+gift_name+"。"+"|";
      }
     retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      retInfo+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			retInfo+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
      //retInfo+="备注：欢迎您参加“建设新农村、手机乐成家”活动，您的话费预存款按月返还，月返还金额为"+formatFloat(prepay_fee/6, 2)+"元，在六个月以内不能变更资费套餐。"+"|";
      //retInfo+="参与手机销售活动所获赠的话费未消费完，客户不能办理消户业务。"+"|";


	  return retInfo;
}
//致富信息机营销案
function printInfo8070()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr格式 营销代码|预存话费|农情包费用|收费|SP代码|IMEI码|集团ID|集团名称|购机款|

    var gift_grade = oneTokSelf(tempStr,"|",1);     //营销代码
    var prepay_fee = oneTokSelf(tempStr,"|",2);      //预存话费
	  var sp_fee = oneTokSelf(tempStr,"|",3);     //农情包费用
	  var pay_money = oneTokSelf(tempStr,"|",4);    //收费
	  var IMEINo = oneTokSelf(tempStr,"|",6);  //IMEI码
	  var grp_id = oneTokSelf(tempStr,"|",7);   //集团ID
	  var grp_name=oneTokSelf(tempStr,"|",8);//集团名称
	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	    var cust_info=""; //客户信息
		var opr_info=""; //操作信息
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4
	    var retInfo = "";  //打印内容
	    /********基本信息类**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      cust_info+="客户姓名：" +document.all.i4.value+"|";
      cust_info+="手机号码："+document.all.phone.value+"|";
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";
      retInfo+="集团ID: "+grp_id+"|";
      retInfo+="集团名称: "+grp_name+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
     /********受理类**********/
      opr_info+="业务类型：致富信息机营销案"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="IMEI码："+IMEINo+"|";
      opr_info+="业务套餐："+document.all.ip.value+"|";
      opr_info+="缴款合计："+pay_money+"元"+"|";
      opr_info+="含预存款："+prepay_fee+"元"+"|";
			opr_info+=" "+"|";
      opr_info+="预存款使用期限为一年，费用不退不转，到期后一次性收回。"+"|";
      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      note_info2+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info2+=" "+"|";
      }
			<%if(goodbz.equals("Y")){%>
			note_info3+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	  
	  /***************判断是否显示字符变更******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
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
		  		note_info1+="<%=readValue("8070","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");

	    return retInfo;
}
function printInfo8071()
{
	//alert("printInfo8071");
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr格式 原流水|预存话费|农情包费用|收费|SP代码|IMEI码|集团ID|集团名称|营销代码|购机款|

    	  var gift_grade = oneTokSelf(tempStr,"|",1);     //原流水
    	  var prepay_fee = oneTokSelf(tempStr,"|",2);      //预存话费
	  var sp_fee = oneTokSelf(tempStr,"|",3);     //农情包费用
	  var pay_money = oneTokSelf(tempStr,"|",4);    //收费
	  var IMEINo = oneTokSelf(tempStr,"|",6);  //IMEI码
	  var grp_id = oneTokSelf(tempStr,"|",7);   //集团ID
	  var grp_name=oneTokSelf(tempStr,"|",8);//集团名称


	   var cust_info=""; //客户信息
		var opr_info=""; //操作信息
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4
	    var retInfo = "";  //打印内容
	    /********基本信息类**********/

      cust_info+="手机号码："+document.all.phone.value+"|";
      cust_info+="客户姓名：" +document.all.i4.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";
      cust_info+="客户地址："+document.all.i5.value+"|";


      opr_info+="集团ID: "+grp_id+"|";
      opr_info+="集团名称: "+grp_name+"|";
     /********受理类**********/
      opr_info+="业务类型：致富信息机营销案冲正"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="IMEI码："+IMEINo+"|";
      opr_info+="业务套餐："+document.all.ip.value+"|";
      opr_info+="退款合计："+pay_money+"元"+"|";
      opr_info+="含预存款："+prepay_fee+"元"+"|";
     /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
	  if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
			<%if(goodbz.equals("Y")){%>
			note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");

	    return retInfo;
}
//动感地带用户签约赠礼品申请
function printInfo2264()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//礼品代码
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//预存话费
		var base_fee      = oneTokSelf(tempStr,"|",3);	//底线预存
		var free_fee      = oneTokSelf(tempStr,"|",4);	//活动预存
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//预扣积分
		var consume_term  = oneTokSelf(tempStr,"|",6);	//消费月份
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//月底线
		var gift_name     = oneTokSelf(tempStr,"|",8);	//礼品名称

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********基本信息类**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="客户名称：" +document.all.i4.value+"|";
      retInfo+="手机号码："+document.all.phone.value+"|";
      retInfo+="客户地址："+document.all.i5.value+"|";
      retInfo+="证件号码："+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********受理类**********/
      retInfo+="业务类型：动感地带签约赠礼品"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      retInfo+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="礼品名称: "+gift_name+"|";
	  retInfo+="预存话费: "+prepay_fee+"元 |";
      retInfo+="预存款期限:  "+consume_term+"个月|";
	  retInfo+="预扣积分: "+mark_subtract+"  业务执行时间: "+begin_time+"|";
      retInfo+="主资费:"+ codeChg(document.all.ip.value)+"|";
	  retInfo+="可选资费:"+ document.all.kx_code_name_bunch.value +"|";
      retInfo+=" "+"|";
      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      retInfo+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      retInfo+="主资费说明："+"|";
      retInfo+="您参与入网抽奖活动后，三个月（含入网当月）内不能进行资费变更。到期前若提前变更所得礼品需由您按原价买回。"+"|";
	  retInfo+=" "+"|";

	  return retInfo;

}
//动感地带用户签约赠礼品冲正
function printInfo2265()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//礼品代码
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//预存话费
		var base_fee      = oneTokSelf(tempStr,"|",3);	//底线预存
		var free_fee      = oneTokSelf(tempStr,"|",4);	//活动预存
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//预扣积分
		var consume_term  = oneTokSelf(tempStr,"|",6);	//消费月份
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//月底线
		var gift_name     = oneTokSelf(tempStr,"|",8);	//礼品名称

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********基本信息类**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="客户名称：" +document.all.i4.value+"|";
      retInfo+="手机号码："+document.all.phone.value+"|";
      retInfo+="客户地址："+document.all.i5.value+"|";
      retInfo+="证件号码："+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********受理类**********/
      retInfo+="业务类型：动感地带签约赠礼品冲正"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      retInfo+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="礼品名称: "+gift_name+"|";
	  retInfo+="预存话费: "+prepay_fee+"元 |";
      retInfo+="预存款期限:  "+consume_term+"个月|";
	  retInfo+="预扣积分: "+mark_subtract+"  业务执行时间: "+begin_time+"|";
      retInfo+="主资费:"+ codeChg(document.all.ip.value)+"|";
	  retInfo+="可选资费:"+ document.all.kx_code_name_bunch.value +"|";
      retInfo+=" "+"|";
      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      retInfo+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      retInfo+="主资费说明："+"|";
      retInfo+="您参与入网抽奖活动后，三个月（含入网当月）内不能进行资费变更。到期前若提前变更所得礼品需由您按原价买回。"+"|";
	  retInfo+=" "+"|";

	  return retInfo;

}
//签约赠礼品申请
function printInfo2281()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//礼品代码
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//预存话费
		var base_fee      = oneTokSelf(tempStr,"|",3);	//底线预存
		var free_fee      = oneTokSelf(tempStr,"|",4);	//活动预存
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//预扣积分
		var consume_term  = oneTokSelf(tempStr,"|",6);	//消费月份
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//月底线
		var gift_name     = oneTokSelf(tempStr,"|",8);	//礼品名称

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********基本信息类**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="客户名称：" +document.all.i4.value+"|";
      retInfo+="手机号码："+document.all.phone.value+"|";
      retInfo+="客户地址："+document.all.i5.value+"|";
      retInfo+="证件号码："+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********受理类**********/
      retInfo+="业务类型：签约赠礼品"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      retInfo+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="礼品名称: "+gift_name+"|";
      retInfo+="月底线: "+monbase_fee+"元     预扣积分: "+mark_subtract+"  业务执行时间: "+begin_time+"|";
      retInfo+="预存话费: "+prepay_fee+"元     其中:  底线预存: "+base_fee+"元  活动预存: "+free_fee+"元|";
      retInfo+="预存款期限:  "+consume_term+"个月|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      retInfo+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      retInfo+="备注：客户办理赠礼业务，资费变更为30新业务包资费，即0月租，5元来电显示（必选），"+"|";
      retInfo+="30元新业务包（含10元彩信/月，10元IVR/月，5元12580/月，5元WAP/月），本地通话0.25元/分钟，漫游费0.60元/分钟。"+"|";
      retInfo+="资费一年之内不得变更，预存话费需在一年之内消费完，到期剩余预存款系统将自动扣除，同时不再对用户的资费和预存话费进行限制。"+"|";
	  /***************判断是否显示字符变更******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
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
		  		note_info1+="<%=readValue("2281","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
	    <%if(goodbz.equals("Y")){%>
			retInfo+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	  return retInfo;

}
//签约赠礼品冲正
function printInfo2282()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//礼品代码
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//预存话费
		var base_fee      = oneTokSelf(tempStr,"|",3);	//底线预存
		var free_fee      = oneTokSelf(tempStr,"|",4);	//活动预存
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//预扣积分
		var consume_term  = oneTokSelf(tempStr,"|",6);	//消费月份
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//月底线
		var gift_name     = oneTokSelf(tempStr,"|",9);	//礼品名称

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********基本信息类**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="客户名称：" +document.all.i4.value+"|";
      retInfo+="手机号码："+document.all.phone.value+"|";
      retInfo+="客户地址："+document.all.i5.value+"|";
      retInfo+="证件号码："+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********受理类**********/
      retInfo+="业务类型：签约赠礼品冲正"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      retInfo+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="礼品名称: "+gift_name+"|";
      retInfo+="月底线: "+monbase_fee+"元     预扣积分: "+mark_subtract+"  业务执行时间: "+begin_time+"|";
      retInfo+="预存话费: "+prepay_fee+"元     其中:  底线预存: "+base_fee+"元  活动预存: "+free_fee+"元|";
      retInfo+="预存款期限:  "+consume_term+"个月|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
       /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      retInfo+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }

      retInfo+="备注：客户办理赠礼业务，资费变更为30新业务包资费，即0月租，5元来电显示（必选），"+"|";
      retInfo+="30元新业务包（含10元彩信/月，10元IVR/月，5元12580/月，5元WAP/月），本地通话0.25元/分钟，漫游费0.60元/分钟。"+"|";
      retInfo+="资费一年之内不得变更，预存话费需在一年之内消费完，到期剩余预存款系统将自动扣除，同时不再对用户的资费和预存话费进行限制。"+"|";
	    <%if(goodbz.equals("Y")){%>
			retInfo+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	  return retInfo;
}
//全球通签约送礼申请－202需求 ：修改全球通签约送礼电子免填单  baixf－20070612
function printInfo2283()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//礼品代码
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//预存话费
		var base_fee      = oneTokSelf(tempStr,"|",3);	//底线预存
		var free_fee      = oneTokSelf(tempStr,"|",4);	//活动预存
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//预扣积分
		var consume_term  = oneTokSelf(tempStr,"|",6);	//消费月份
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//月底线
		var gift_name     = oneTokSelf(tempStr,"|",8);	//礼品名称

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
      cust_info+="客户姓名：" +document.all.i4.value+"|";
      //cust_info+="证件号码："+document.all.i7.value+"|";
      //cust_info+="客户地址："+document.all.i5.value+"|";

      /********受理类**********/
      opr_info+="用户品牌："+'<%=WtcUtil.repNull(request.getParameter("oSmName")).trim()%>'+" 办理业务：全球通签约送礼"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="操作流水："+"<%=printAccept%>"+" 底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="操作流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="礼品名称: "+gift_name+" 月底线: "+monbase_fee+"元     预扣积分: "+mark_subtract+"  业务操作时间: "+begin_time+"|";
      opr_info+="预存话费: "+prepay_fee+"元        其中:  底线预存: "+base_fee+"元  活动预存: "+free_fee+"元|";
      opr_info+="活动预存款消费期限:  "+consume_term+"个月        签约期限："+consume_term+"个月"+"          业务生效时间："+"<%=exeDate.substring(0,8)%>"+"|";
      opr_info+="指定资费： "+ (document.all.ip.value).trim()+"|";

      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
     /* if(document.all.modestr.value.length>0){
      note_info2+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info2+=" "+"|";
      }
     */
      note_info2+="指定资费描述："+"<%=note%>"+"|";
	  
	  /***************判断是否显示字符变更******************/
	   var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
       var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
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
		  		note_info1+="<%=readValue("2283","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
  		
	  /***
      if ("<%=regionCode%>"=="11")
	  {
		  note_info3+="注意事项：您办理此业务后，即成为我公司全球通签约客户，签约期为资费生效之日起8个月（生效当月按整月计算），签约期内使用指定资费，不允许变更，签约期后可进行资费变更，如不变更，继续执行指定资费不变。";
	      note_info3+="到期后变更资费时，新资费的生效时间，根据您选择的新资费决定是当月生效，还是次月生效。活动预存消费期限为"+consume_term+"个月（办理业务当月按整月计算），在此期间须消费完毕，消费不完的，移动公司在期限结束后的月初收回。"+"|";
	  }
      else
	  {
	      if(consume_term=="60"){
	      note_info3+="注意事项：您办理此业务后，即成为我公司全球通签约客户，签约期为资费生效之日起12个月（生效当月按整月计算），签约期内使用指定资费，不允许变更，签约期后可进行资费变更。如不变更，继续执行指定资费不变。到期后变更资费时，新资费的生效时间，根据您选择的新资费决定是当月生效，还是次月生效。";
		  }else{
		  note_info3+="注意事项：您办理此业务后，即成为我公司全球通签约客户，签约期为资费生效之日起"+consume_term+"个月（生效当月按整月计算），签约期内使用指定资费，不允许变更，签约期后可进行资费变更。如不变更，继续执行指定资费不变。到期后变更资费时，新资费的生效时间，根据您选择的新资费决定是当月生效，还是次月生效。活动预存消费期限为"+consume_term+"个月（办理业务当月按整月计算），在此期间须消费完毕，消费不完的，移动公司在期限结束后的月初收回。";
	      }
	      note_info3+="您交纳的预存话费不退不转，底线预存按照签约时间每月返还，当月消费完毕。如果您要求取消签约，所得礼品需由您按原价买回。剩余预存款要扣除30％的违约金。在协议有效期内若遇国家资费标准调整,按国家新的资费政策执行。"+"|";
	  }
	  ****/
	  <%if(goodbz.equals("Y")){%>
			note_info4+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
	  <%}%>
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//全球通签约送礼冲正
function printInfo2284()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//礼品代码
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//预存话费
		var base_fee      = oneTokSelf(tempStr,"|",3);	//底线预存
		var free_fee      = oneTokSelf(tempStr,"|",4);	//活动预存
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//预扣积分
		var consume_term  = oneTokSelf(tempStr,"|",6);	//消费月份
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//月底线
		var gift_name     = oneTokSelf(tempStr,"|",9);	//礼品名称

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
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";

      /********受理类**********/
      opr_info+="业务类型：全球通签约送礼冲正"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="礼品名称: "+gift_name+"|";
      opr_info+="月底线: "+monbase_fee+"元     预扣积分: "+mark_subtract+"  业务操作时间: "+begin_time+"|";
      opr_info+="预存话费: "+prepay_fee+"元     其中:  底线预存: "+base_fee+"元  活动预存: "+free_fee+"元|";
      opr_info+="预存款期限:  "+consume_term+"个月|";

      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      note_info2+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info2+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info3+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>

    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//预存优惠上网费用营销案申请－202需求 ：修改预存优惠上网费用营销案电子免填单  sunaj－20090410
function printInfo7371()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;

		var sale_code     = oneTokSelf(tempStr,"|",1);	//方案代码
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//预存话费
		var base_fee      = oneTokSelf(tempStr,"|",3);	//底线预存
		var free_fee      = oneTokSelf(tempStr,"|",4);	//活动预存
		var base_term     = oneTokSelf(tempStr,"|",5);	//底线消费期限
		var free_term     = oneTokSelf(tempStr,"|",6);	//活动消费期限
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//月底线
		var sale_name     = oneTokSelf(tempStr,"|",8);	//方案名称

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
      //cust_info+="客户地址："+document.all.i5.value+"|";
      //cust_info+="证件号码："+document.all.i7.value+"|";


      /********受理类**********/
      opr_info+="业务类型:  随e行省内套餐  预存费用优惠上网费申请"+"|";
       <%if(goodbz.equals("Y")){%>
      opr_info+="操作流水： "+"<%=printAccept%>"+"|";
      <%}else{%>
      opr_info+="操作流水： "+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="新申请主套餐："+ document.all.ip.value.trim()+"    优惠时限:  10个月|";
      opr_info+="预存话费: "+prepay_fee+"元专款          业务执行时间："+begin_time+"|";



      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
        note_info2+="资费描述："+"<%=note%>"+"|";

	  note_info3+="注意事项："+"|";
	  /***************判断是否显示字符变更******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
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
		  		note_info1+="<%=readValue("7371","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
		  		
      note_info3+=" "+"|";
	  <%if(goodbz.equals("Y")){%>
			note_info4+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//预存优惠上网费用营销案冲正
function printInfo7374()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;

		var sale_code     = oneTokSelf(tempStr,"|",1);	//方案代码
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//预存话费
		var base_fee      = oneTokSelf(tempStr,"|",3);	//底线预存
		var free_fee      = oneTokSelf(tempStr,"|",4);	//活动预存
		var base_term     = oneTokSelf(tempStr,"|",5);	//底线消费期限
		var free_term     = oneTokSelf(tempStr,"|",6);	//活动消费期限
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//月底线
		var sale_name     = oneTokSelf(tempStr,"|",9);	//方案名称

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
      //cust_info+="客户地址："+document.all.i5.value+"|";
      //cust_info+="证件号码："+document.all.i7.value+"|";

      /********受理类**********/
      opr_info+="业务类型:  随e行省内套餐  预存费用优惠上网费冲正"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水： "+"<%=printAccept%>"+"|";
      <%}else{%>
      opr_info+="业务流水： "+"<%=printAccept%>"+"|";
      <%}%>
     /* opr_info+="新申请主套餐： "+ document.all.ip.value.trim()+"   优惠时限:  "+free_term+"个月|";
      opr_info+="预存话费: "+prepay_fee+"元专款       业务执行时间："+begin_time+"|";
      */

      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
      <%if(goodbz.equals("Y")){%>
			note_info3+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	note_info4+="备注："+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//预存优惠购卡营销案申请－202需求 ：修改预存优惠购卡营销案电子免填单  sunaj－20090414
function printInfo7379()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;

		var sale_code     = oneTokSelf(tempStr,"|",1);	//方案代码
		var agent_code    = oneTokSelf(tempStr,"|",2);	//手机品牌
		var phone_type    = oneTokSelf(tempStr,"|",3);	//手机型号
		var sale_price    = oneTokSelf(tempStr,"|",4);	//应收金额
		var base_fee      = oneTokSelf(tempStr,"|",5);	//底线预存
		var consume_term  = oneTokSelf(tempStr,"|",6);	//底线消费期限
	    var free_fee      = oneTokSelf(tempStr,"|",7);	//活动预存
		var active_term   = oneTokSelf(tempStr,"|",8);	//活动消费期限
		var monbase_fee   = oneTokSelf(tempStr,"|",9);	//月底线
		var all_gift_price= oneTokSelf(tempStr,"|",10);	//购卡费用
		var market_price  = oneTokSelf(tempStr,"|",11); //市场价
		var imeino        = oneTokSelf(tempStr,"|",12); //IEMI号码
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
      //cust_info+="客户地址："+document.all.i5.value+"|";
      //cust_info+="证件号码："+document.all.i7.value+"|";


      /********受理类**********/
      opr_info+="业务类型: 随e行省内套餐   预存费用赠送上网卡申请"+"|";
       <%if(goodbz.equals("Y")){%>
      opr_info+="操作流水："+"<%=printAccept%>"+"|";
      <%}else{%>
      opr_info+="操作流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="新申请主套餐："+ document.all.ip.value.trim()+"|";
      opr_info+="上网卡型号："+ phone_type +"   市场价："+market_price+"   优惠金额： "+"<%=WtcUtil.repNull(request.getParameter("Favour_Cost"))%>"+"元|";
      opr_info+="交款额: "+sale_price+"元(其中，预存话费："+all_fee+"元, 购卡费用："+all_gift_price+"元)|";
      opr_info+="业务执行时间："+begin_time+"|";

      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
        note_info2+="资费描述："+"<%=note%>"+"|";

	note_info3+="注意事项："+"|";
	/*note_info3+="您交纳的预存话费不退不转。如果您要求取消签约,剩余预存款要扣除30％的违约金。在协议有效期内若遇国家资费标准调整,按国家新的资费政策执行。"+"|";
    */
    /***************判断是否显示字符变更******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
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
		  		note_info1+="<%=readValue("7379","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
      note_info3+=" "+"|";
	  <%if(goodbz.equals("Y")){%>
			note_info4+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//预存优惠购卡营销案冲正
function printInfo7382()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;


        var login_accept  = oneTokSelf(tempStr,"|",1);  //业务流水
		var sale_code     = oneTokSelf(tempStr,"|",2);	//方案代码
		var agent_code    = oneTokSelf(tempStr,"|",3);	//手机品牌
		var phone_type    = oneTokSelf(tempStr,"|",4);	//手机型号
		var sale_price    = oneTokSelf(tempStr,"|",5);	//应收金额
		var base_fee      = oneTokSelf(tempStr,"|",6);	//底线预存
		var consume_term  = oneTokSelf(tempStr,"|",7);	//底线消费期限
	    var free_fee      = oneTokSelf(tempStr,"|",8);	//活动预存
		var active_term   = oneTokSelf(tempStr,"|",9);	//活动消费期限
		var monbase_fee   = oneTokSelf(tempStr,"|",10);	//月底线
		var all_gift_price= oneTokSelf(tempStr,"|",11);	//购卡费用
		var market_price  = oneTokSelf(tempStr,"|",12); //市场价
		var imeino        = oneTokSelf(tempStr,"|",13); //IEMI号码
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
      //cust_info+="客户地址："+document.all.i5.value+"|";
      //cust_info+="证件号码："+document.all.i7.value+"|";

      /********受理类**********/
      opr_info+="业务类型: 随e行省内套餐   预存费用赠送上网卡冲正"+"|";
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
      <%if(goodbz.equals("Y")){%>
			note_info3+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
    note_info4+="备注："+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//商务宝营销案申请需求 ：商务宝营销案电子免填单  sunaj－20090516
function printInfo7975()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;

		var sale_code     = oneTokSelf(tempStr,"|",1);	//方案代码
		var agent_code    = oneTokSelf(tempStr,"|",2);	//手机品牌
		var phone_type    = oneTokSelf(tempStr,"|",3);	//手机型号
		var sale_price    = oneTokSelf(tempStr,"|",4);	//应收金额
		var base_fee      = oneTokSelf(tempStr,"|",5);	//底线预存
		var consume_term  = oneTokSelf(tempStr,"|",6);	//底线消费期限
	    var free_fee      = oneTokSelf(tempStr,"|",7);	//活动预存
		var active_term   = oneTokSelf(tempStr,"|",8);	//活动消费期限
		//var monbase_fee   = oneTokSelf(tempStr,"|",9);	//月底线
		var all_gift_price= oneTokSelf(tempStr,"|",9);	//购卡费用
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
      //cust_info+="客户地址："+document.all.i5.value+"|";
      //cust_info+="证件号码："+document.all.i7.value+"|";


      /********受理类**********/
      opr_info+="业务类型: 商务宝套餐  预存费用赠送商务宝申请"+"|";
       <%if(goodbz.equals("Y")){%>
      opr_info+="操作流水："+"<%=printAccept%>"+"|";
      <%}else{%>
      opr_info+="操作流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="月套餐费用："+"<%=WtcUtil.repNull(request.getParameter("Favour_Cost"))%>"+"元|";
      opr_info+="商务宝型号："+ phone_type +"   市场价："+market_price+"|";
      opr_info+="交款额: "+sale_price+"元(其中，预存话费："+all_fee+"元)|";
      opr_info+="业务执行时间："+begin_time+"|";

      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
        note_info2+="资费描述："+"<%=note%>"+"|";

	note_info3+="注意事项："+"|";
	/*note_info3+="您交纳的预存话费不退不转。如果您要求取消签约,剩余预存款要扣除30％的违约金。在协议有效期内若遇国家资费标准调整,按国家新的资费政策执行。"+"|";
    */
      note_info3+=" "+"|";
	  <%if(goodbz.equals("Y")){%>
			note_info4+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//商务宝营销案冲正需求 ：商务宝营销案电子免填单  sunaj－20090516
function printInfo7976()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;

        var login_accept  = oneTokSelf(tempStr,"|",1);  //业务流水
		var sale_code     = oneTokSelf(tempStr,"|",2);	//方案代码
		var agent_code    = oneTokSelf(tempStr,"|",3);	//手机品牌
		var phone_type    = oneTokSelf(tempStr,"|",4);	//手机型号
		var sale_price    = oneTokSelf(tempStr,"|",5);	//应收金额
		var base_fee      = oneTokSelf(tempStr,"|",6);	//底线预存
		var consume_term  = oneTokSelf(tempStr,"|",7);	//底线消费期限
	    var free_fee      = oneTokSelf(tempStr,"|",8);	//活动预存
		var active_term   = oneTokSelf(tempStr,"|",9);	//活动消费期限
		//var monbase_fee   = oneTokSelf(tempStr,"|",10);	//月底线
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
      //cust_info+="客户地址："+document.all.i5.value+"|";
      //cust_info+="证件号码："+document.all.i7.value+"|";

      /********受理类**********/
      opr_info+="业务类型: 商务宝套餐  预存费用赠送商务宝冲正"+"|";
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
      <%if(goodbz.equals("Y")){%>
			note_info3+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
    note_info4+="备注："+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//数据业务包年申请
function printInfo7116()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;

	  var prepay_fee    = oneTokSelf(tempStr,"|",1);	//预存话费
	  var consume_term  = oneTokSelf(tempStr,"|",2);	//消费月数
	  var exeDate = "<%=exeDate%>";//得到执行时间
	  var time=exeDate.substring(0,8);

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********基本信息类**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="客户名称：" +document.all.i4.value+"|";
      retInfo+="手机号码："+document.all.phone.value+"|";
      retInfo+="客户地址："+document.all.i5.value+"|";
      retInfo+="证件号码："+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********受理类**********/
      retInfo+="业务类型：数据业务包年申请"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      retInfo+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="业务操作时间: "+begin_time+"     业务执行时间:  "+time+"|";
      retInfo+="预存话费: "+prepay_fee+"元      预存款期限:  "+consume_term+"个月|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      retInfo+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			retInfo+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	  return retInfo;

}
//数据业务包年冲正
function printInfo7118()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;

		var prepay_fee    = oneTokSelf(tempStr,"|",1);	//预存话费
		var consume_term  = oneTokSelf(tempStr,"|",2);	//消费月数

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********基本信息类**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="客户名称：" +document.all.i4.value+"|";
      retInfo+="手机号码："+document.all.phone.value+"|";
      retInfo+="客户地址："+document.all.i5.value+"|";
      retInfo+="证件号码："+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********受理类**********/
      retInfo+="业务类型：数据业务包年冲正"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      retInfo+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="业务操作时间: "+begin_time+"|";
      retInfo+="预存话费: "+prepay_fee+"元      预存款期限:  "+consume_term+"个月|";
       retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********描述类*********/
     if(document.all.modestr.value.length>0){
      retInfo+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			retInfo+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	  return retInfo;
}
//爱心卡申请
function printInfo1253()
{
	  //得到该业务工单需要的参数

	  var exeDate = "<%=exeDate%>";//得到执行时间
	  var time=exeDate.substring(0,8);
		var cust_info="";  //客户信息
		var opr_info="";   //操作信息
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4
		var retInfo = "";  //打印内容
	  /********基本信息类**********/
      retInfo+='<%=workNo%>  <%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      cust_info+="客户姓名：" +document.all.i4.value+"|";
      cust_info+="手机号码："+document.all.phone.value+"|";
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";
      /********受理类**********/
      retInfo+=" "+"|";
      opr_info+="用户品牌："+'<%=WtcUtil.repNull(request.getParameter("i8"))%>'+"|";
      opr_info+="业务类型：爱心卡申请"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="资费（代码、名称）："+document.all.ip.value+"|";
      opr_info+="生效时间："+time+"|";
      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	opr_info+="<%=bdts%>"+"|";
      }else{
	  	opr_info+=" "+"|";
	  	}
	  /**********描述类*********/
	  note_info1+="<%=note%>"+"|";
      if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      note_info1+="<%=print_note%>"+"|";
      <%if(goodbz.equals("Y")){%>
			note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//爱心卡取消
function printInfo1254()
{
	  //得到该业务工单需要的参数

	  var exeDate = "<%=exeDate%>";//得到执行时间
	  var time=exeDate.substring(0,8);

		var cust_info="";  //客户信息
		var opr_info="";   //操作信息
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4
		var retInfo = "";  //打印内容
	  /********基本信息类**********/
      retInfo+='<%=workNo%>  <%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      cust_info+="客户姓名：" +document.all.i4.value+"|";
      cust_info+="手机号码："+document.all.phone.value+"|";
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";
       /********受理类**********/
      opr_info+="用户品牌："+'<%=WtcUtil.repNull(request.getParameter("i8"))%>'+"|";
      opr_info+="业务类型：爱心卡取消"+"|";
       <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
	    opr_info+="资费（代码、名称）："+document.all.ip.value+"|";
      opr_info+="生效时间："+time+"|";
	     /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	opr_info+="<%=bdts%>"+"|";
      }else{
	  	opr_info+=" "+"|";
	  	}
	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      note_info1+="<%=print_note%>"+"|";
      <%if(goodbz.equals("Y")){%>
			note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//七台河GPRS申请
function printInfo1208()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr格式 year_fee|pay_type
      var year_fee = oneTokSelf(tempStr,"|",1);//包年预存

	  var retInfo = "";
	  /********基本信息类**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="客户名称：" +document.all.i4.value+"|";
      retInfo+="手机号码："+document.all.phone.value+"|";
      retInfo+="客户地址："+document.all.i5.value+"|";
      retInfo+="证件号码："+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********受理类**********/
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+="业务类型:         七台河GPRS包年"+"|";
	    retInfo+="包年金额: "+year_fee+"元|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      retInfo+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
       /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      retInfo+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      retInfo+="<%=print_note%>"+"|";
      <%if(goodbz.equals("Y")){%>
			retInfo+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>

	  return retInfo;
}
//动感地带月租包年
function printInfo125b()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr格式  包年预存 | 消费期限
      var year_fee = oneTokSelf(tempStr,"|",1);//包年预存
	  var consume_term = oneTokSelf(tempStr,"|",2);//消费期限

	  var exeDate = "<%=exeDate.substring(0,8)%>";//得到执行时间

	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  /********基本信息类**********/
      /*retInfo+='<%=workNo%>  <%=workName%>'+"|"; */
      /*retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";  */
      cust_info+="客户姓名：" +document.all.i4.value+"|";
      cust_info+="手机号码："+document.all.phone.value+"|";
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";

	    /********受理类**********/
	  opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌：动感地带"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="办理业务：动感地带月租包年－申请 "+"  操作流水："+"<%=printAccept%>"+"  底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="办理业务：动感地带月租包年－申请 "+"  操作流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="动感地带主资费："+codeChg(document.all.ip.value)+"  主资费生效时间："+checkdate(exeDate)+"|";
      opr_info+="动感地带主资费二次批价："+"<%=daima%>"+"|";
      opr_info+="动感地带可选资费："+document.all.kx_code_name_bunch.value+"  可选资费生效时间：次月"+"|";
	  opr_info+="动感地带可选资费二次批价："+document.all.kx_erpi_bunch.value+"|";

      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }
	  /**********描述类*********/
	  note_info1=" "+"|";
	  if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }
      note_info2=" "+"|";
	  note_info2+="动感地带月租包年资费描述："+"<%=note%>"+"|";
	  note_info3=" "+"|";
      if(document.all.kx_explan_bunch.value.trim().len()==0){

	  }else{
		//rdShowMessageDialog("fffffff"+document.all.kx_explan_bunch.value);
	  note_info3+="动感地带可选资费描述:"+document.all.kx_explan_bunch.value+"|";

	  }
	  note_info4=" "+"|";
      <%if(goodbz.equals("Y")){%>
			note_info4+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	 note_info4+=" "+"|";
	 note_info4+="备注:"+document.all.tonote.value+"|";
	 document.all.cust_info.value=cust_info+"#";
	document.all.opr_info.value=opr_info+"#";
	document.all.note_info1.value=note_info1+"#";
	document.all.note_info2.value=note_info2+"#";
	document.all.note_info3.value=note_info3+"#";
	document.all.note_info4.value=note_info4+"#";

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	 return retInfo;
}
//动感地带月租包年冲正
function printInfo125c()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr格式  包年预存 | 消费期限
      var year_fee = oneTokSelf(tempStr,"|",1);//包年预存
	  var consume_term = oneTokSelf(tempStr,"|",2);//消费期限

	  var exeDate = "<%=exeDate.substring(0,8)%>";//得到执行时间

	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  /********基本信息类**********/
      /*retInfo+='<%=workName%>'+"|"; */
      /*retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|"; */
      cust_info+="客户姓名：" +document.all.i4.value+"|";
      cust_info+="手机号码："+document.all.phone.value+"|";
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";

       /********受理类**********/
      opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌：动感地带"+"|";


      <%if(goodbz.equals("Y")){%>
      opr_info+="业务类型:  动感地带月租包年冲正"+"  业务流水："+"<%=printAccept%>"+"  底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务类型:  动感地带月租包年冲正"+"  业务流水："+"<%=printAccept%>"+"|";
      <%}%>

      opr_info+="预存话费:  "+year_fee+"|";
      opr_info+="业务执行时间:  "+exeDate+"      消费期限:  "+consume_term+"个月|";
     /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }
	  /**********描述类*********/
	  note_info1+=" "+"|";
      if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }
      note_info2+=" "+"|";
      note_info2+="<%=print_note%>"+"|";
      note_info3+=" "+"|";
      <%if(goodbz.equals("Y")){%>
			note_info3+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	document.all.cust_info.value=cust_info+"#";
	document.all.opr_info.value=opr_info+"#";
	document.all.note_info1.value=note_info1+"#";
	document.all.note_info2.value=note_info2+"#";
	document.all.note_info3.value=note_info3+"#";
	document.all.note_info4.value=note_info4+"#";

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	 return retInfo;
}
function printInfo7117()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr格式 方案代码| 包年预存| 月底线| 消费期限
      var year_fee = oneTokSelf(tempStr,"|",2);//包年预存
	  var consume_term = oneTokSelf(tempStr,"|",4);//消费期限

      var exeDate='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********基本信息类**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="客户名称：" +document.all.i4.value+"|";
      retInfo+="手机号码："+document.all.phone.value+"|";
      retInfo+="客户地址："+document.all.i5.value+"|";
      retInfo+="证件号码："+document.all.i7.value+"|";
      retInfo+=" "+"|";
	    retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
       /********受理类**********/
      retInfo+=" "+"|";
      retInfo+=" "+"|";
	  retInfo+="用户品牌："+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"  *"+"办理业务:"+"数据业务包年取消"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      retInfo+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="取消的包年资费："+ "<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
      retInfo+="取消后执行资费："+document.all.ip.value+"  *"+"生效时间："+exeDate+"|";
      retInfo+="取消后执行资费对应品牌："+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"|";
      retInfo+=" "+"|";
      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      retInfo+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
	    retInfo+="取消后执行资费描述："+"<%=note%>"+"|";
      if(document.all.kx_explan_bunch.value.trim().len()==0)
      {
				retInfo+=" "+"|";
	  	}
	  	else
	  	{
				retInfo+="可选资费描述："+document.all.kx_explan_bunch.value+"|";
	  	}
	 		 retInfo+="备注：由于包年资费未到期，取消包年资费属于违约行为，在本月出帐后，我公司将按剩余"+"|";
	  		retInfo+="包年预存的30％收取违约金，之后剩余的预存款将自动转到您的现金账户中。"+"|";
      <%if(goodbz.equals("Y")){%>
			retInfo+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>

	  return retInfo;
}
function printInfo7119()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr格式 方案代码| 包年预存| 月底线| 消费期限
      var year_fee = oneTokSelf(tempStr,"|",2);//包年预存
	  var consume_term = oneTokSelf(tempStr,"|",4);//消费期限

      var exeDate='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  /********基本信息类**********/
      /*retInfo+='<%=workName%>'+"|"; */
      /*retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|"; */
      cust_info+="客户名称：" +document.all.i4.value+"|";
      cust_info+="手机号码："+document.all.phone.value+"|";
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";

      /********受理类**********/
      opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌："+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="办理业务:"+"动感地带月租包年取消"+"  业务流水："+"<%=printAccept%>"+"  底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="办理业务:"+"动感地带月租包年取消"+"  业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="取消的包年资费："+ "<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
      opr_info+="取消后执行资费："+document.all.ip.value+"  *"+"生效时间："+exeDate+"|";
      opr_info+="取消后执行资费对应品牌："+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"|";

      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }
	  /**********描述类*********/
	  note_info1+=" "+"|";
      if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }
      note_info2+=" "+"|";
	  note_info2+="取消后执行资费描述："+"<%=note%>"+"|";
	  note_info3+=" "+"|";
      if(document.all.kx_explan_bunch.value.trim().len()==0)
      {

	  	}
	  	else
	  	{
				note_info3+="可选资费描述："+document.all.kx_explan_bunch.value+"|";
	  	}
	  	note_info4+=" "+"|";
	  	note_info4+="备注：由于包年资费未到期，取消包年资费属于违约行为，在本月出帐后，我公司将按剩余"+"|";
	  	note_info4+="包年预存的30％收取违约金，之后剩余的预存款将自动转到您的现金账户中。"+"|";
     <%if(goodbz.equals("Y")){%>
     		note_info4+=" "+"|";
			note_info4+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
	document.all.cust_info.value=cust_info+"#";
	document.all.opr_info.value=opr_info+"#";
	document.all.note_info1.value=note_info1+"#";
	document.all.note_info2.value=note_info2+"#";
	document.all.note_info3.value=note_info3+"#";
	document.all.note_info4.value=note_info4+"#";
	retInfo=document.all.cust_info.value+" "+"|"+"---------------------------------------------"+"|"+" "+"|"+document.all.opr_info.value+" "+"|"+" "+"|"+document.all.note_info1.value+document.all.note_info2.value+document.all.note_info3.value+document.all.note_info4.value+" "+"|"+" "+"|"+" "+"|"+" "+"|"+"<%=loginNote.trim()%>"+"#";

	  return retInfo;
}

function printInfo8046()
{
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr格式 营销案类型代码|补手机款|补促销品款|流水|

    var saleType = oneTokSelf(tempStr,"|",1);//营销案类型代码
	  var pay_phone_fee = oneTokSelf(tempStr,"|",2);//补手机款
	  var pay_product_fee = oneTokSelf(tempStr,"|",3);//补促销品款
	  var pay_fee = (parseFloat(pay_phone_fee) + parseFloat(pay_product_fee)) + "";

      var exeDate='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";

	  /********基本信息类**********/
      cust_info+="手机号码："+document.all.phone.value+"|";
      cust_info+="客户姓名：" +document.all.i4.value+"|";
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";

      /********受理类**********/
      
      if(saleType=="38"){
        var myPacket = new AJAXPacket("f8046_ajax_getYhjeInfo.jsp","正在获取信息，请稍候......");
      	myPacket.data.add("phoneNo",document.all.phone.value);
      	core.ajax.sendPacket(myPacket,doGetYhjeInfo);
      	myPacket=null; 
      }
	  opr_info+="用户品牌："+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"     *"+"办理业务:"+"营销案取消"+"|";
      if(saleType=="38"){
        opr_info+="操作流水："+"<%=printAccept%>"+"|";
        alert(document.all.yhje_8046.value);
        opr_info+="客户需交纳的补已优惠金额："+document.all.yhje_8046.value+"|";		
      }else{
        opr_info+="操作流水："+"<%=printAccept%>     *客户需交纳的礼品或手机款："+pay_fee+"|";
        opr_info+="取消的营销案资费："+ "<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
        opr_info+="取消后执行资费："+document.all.ip.value+"  *"+"生效时间："+exeDate+"|";
        opr_info+="取消后执行资费对应品牌："+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"|";
        opr_info+=" "+"|";
      }
      

      /*******备注类**********/
		if(saleType=="38")
		{
			note_info1+="在本业务到期前申请取消或办理销户，您需要退还营销案期间全部已经享受到的通信费用优惠，做为取消业务的违约金。"+"|";
    }
		else
		{
	  		if("<%=bdbz%>"=="Y"){
      		note_info1+="<%=bdts%>"+"|";
      		}else{
          	note_info1+=" "+"|";
	  		}
		}

	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      	note_info2+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      	note_info2+=" "+"|";
      }
	  	note_info2+="取消后执行资费描述："+"<%=note%>"+"|";
      if(document.all.kx_explan_bunch.value.trim().len()==0)
		note_info2+=" "+"|";
	  else
		note_info2+="可选资费描述："+document.all.kx_explan_bunch.value+"|";
	  note_info3+="注意事项：由于营销活动资费未到期，取消资费属于违约行为，您参与活动时所赠送的礼品"+"|";
	  note_info3+="或手机需由您按原价购买；您以优惠价格购买的手机，需按原价交纳差价款。您参与活动时"+"|";
	  note_info3+="交纳的专款预存款扣除手机或礼品款后，我公司将按剩余预存款的30％收取违约金，剩余的"+"|";
	  note_info3+="预存款将自动转到您的现金账户中。请您根据礼品（或手机）原价或差价及违约金额度交纳"+"|";
	  note_info3+="足额的预存话费，以免收取以上费用后产生欠费停机。"+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

function doGetYhjeInfo(packet){
  var v_yhje = packet.data.findValueByName("v_yhje");
  $("#yhje_8046").val(v_yhje);
}

/*************************************add by MengQK  end*************************************************************/

function printInfo8027()
{
	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  //得到该业务工单需要的参数
	  var tempStr = document.form1.iAddStr.value;
	  // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr格式 营销代码|手机品牌|预存话费|机型|收费|IMEI码|

    var gift_grade = oneTokSelf(tempStr,"|",1);     //营销代码
    var phone_code = oneTokSelf(tempStr,"|",2);      //手机品牌
	var prepay_fee = oneTokSelf(tempStr,"|",3);     //预存话费
	var phone_type = oneTokSelf(tempStr,"|",4);    //手机型号
	var pay_money= oneTokSelf(tempStr,"|",5); //收费
	var IMEINo = oneTokSelf(tempStr,"|",6);  //IMEI码



	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	     /********基本信息类**********/
      cust_info+="客户姓名：" +document.all.i4.value+"|";
      cust_info+="手机号码："+document.all.phone.value+"|";
      cust_info+="客户地址："+document.all.i5.value+"|";
      cust_info+="证件号码："+document.all.i7.value+"|";
     /********受理类**********/
      opr_info+="业务类型：买手机、送话费"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="手机型号："+phone_code+phone_type+"      IMEI码："+IMEINo+"|";
	  opr_info+="缴款合计："+pay_money+"元、另赠送："+prepay_fee+"元话费"+"|";
			/*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
      note_info1+="欢迎您参加'买手机、送话费活动'：1.活动赠送的预存话费每月最多允许使用总额的十分之一，超额发生的话费请您另行交纳，您本次活动办理的手机号码和手机必须在一起使用，否则将不允许使用赠送的预存话费。赠送的预存话费必须在10个月内消费完毕，剩余款额将全部被清零;2.在赠送的预存款未消费完毕前不得退款、转款，12个月内不得办理资费变更，业务到期后可自行办理其他业务。若提前申请取消，按违约规定补交赠送话费，并按剩余预存款的30%交纳违约金;3.未涉及的资费，按现行的移动电话资费标准执行。本次活动手机适用中国移动业务。在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。"+"|";
      if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      note_info1+="手机终端会自动对字数较多的短信进行拆分，不同型号手机终端拆分原则不同，我公司将按手机自动拆分的条数收费。"+"|";
			/* ningtn IMEI 重新绑定需求*/
			note_info4 += "如您因手机丢失或人为损坏等个人原因无法使用而造成机卡分离，请到营业厅重新购机，否则将不能继续使用剩余话费。" + "|";
	  /***************判断是否显示字符变更******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
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
		  		note_info1+="<%=readValue("8027","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
      <%if(goodbz.equals("Y")){%>
			note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
function printInfo8028()
{
	  //得到该业务工单需要的参数
	var tempStr = document.form1.iAddStr.value;
	  //iAddStr格式 原流水|营销代码|机型名称|赠送话费|购机款|
	var backaccept = oneTokSelf(tempStr,"|",1);     //原流水
    var SaleCode = oneTokSelf(tempStr,"|",2);      //营销代码
	var PhoneName = oneTokSelf(tempStr,"|",3);     //机型名称
	var preparefee= oneTokSelf(tempStr,"|",4); //赠送话费
	var PayMoney= oneTokSelf(tempStr,"|",5); //购机款



	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	    /********基本信息类**********/
       cust_info+="客户姓名：" +document.all.i4.value+"|";
       cust_info+="手机号码："+document.all.phone.value+"|";
       cust_info+="客户地址："+document.all.i5.value+"|";
       cust_info+="证件号码："+document.all.i7.value+"|";

     /********受理类**********/
      opr_info+="业务类型：买手机，送话费冲正"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="业务流水："+"<%=printAccept%>"+"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";
      <%}else{%>
      opr_info+="业务流水："+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="手机型号："+PhoneName+"|";
      opr_info+="退款合计："+PayMoney+"元、赠送话费："+preparefee+"元"+"|";
      /*******备注类**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********描述类*********/
      if(document.all.modestr.value.length>0){
      note_info1+="新资费生效时将被取消的可选资费:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
			<%}%>
      //retInfo+="备注：欢迎您参加“建设新农村、手机乐成家”活动，您的话费预存款按月返还，月返还金额为"+formatFloat(prepay_fee/6, 2)+"元，在六个月以内不能变更资费套餐。"+"|";
      //retInfo+="参与手机销售活动所获赠的话费未消费完，客户不能办理消户业务。"+"|";

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//购TD固话赠通信费申请   sunaj－20090828
function printInfo7981()
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
	var price         = oneTokSelf(tempStr,"|",9);	//购固话费用
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
	opr_info+="业务类型: 购TD固话赠话费申请"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}%>
	opr_info+="购机信息：品牌"+agent_code+"，型号"+phone_type+"，捆绑IMEI"+imeino+"|";
	opr_info+="赠送话费"+base_fee+"元|";
	if(free_fee>0)
	{
		opr_info+="赠送上网费: "+free_fee+"元，|";
	}
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
	note_info2+="您的话机如拆包使用，则自动变更为以上资费，您可以到营业厅办理回原资费。|";
	/***************判断是否显示字符变更******************/
	   var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
       var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
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
		  		note_info1+="<%=readValue("7981","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
	note_info3+="  "+"|";
	note_info4+="备注："+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//购TD固话赠通信费冲正  sunaj－20090828
function printInfo7982()
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
	var base_fee      = oneTokSelf(tempStr,"|",6);	//话费
	var consume_term  = oneTokSelf(tempStr,"|",7);	//话费消费期限
	var free_fee      = oneTokSelf(tempStr,"|",8);	//上网费
	var active_term   = oneTokSelf(tempStr,"|",9);	//上网费消费期限
	var price         = oneTokSelf(tempStr,"|",10);	//购TD费用
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
	opr_info+="业务类型: 购TD固话赠话费冲正"+"|";
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
//购TD固话赠通信费申请   sunaj－20100427
function printInfo8551()
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
	var price         = oneTokSelf(tempStr,"|",9);	//购固话费用
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
	opr_info+="业务类型: 购TD固话赠话费(铁通)申请"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}%>
	opr_info+="购机信息：品牌"+agent_code+"，型号"+phone_type+"，捆绑IMEI"+imeino+"|";
	opr_info+="赠送话费"+base_fee+"元|";
	if(free_fee>0)
	{
		opr_info+="赠送上网费: "+free_fee+"元，|";
	}
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
	note_info2+="您的话机如拆包使用，则自动变更为以上资费，您可以到营业厅办理回原资费。|";

	note_info3+="  "+"|";
	note_info4+="备注："+"|";
	/***************判断是否显示字符变更******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
	  var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
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
		  		note_info1+="<%=readValue("8551","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//购TD固话赠通信费冲正  sunaj－20100427
function printInfo8552()
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
	var base_fee      = oneTokSelf(tempStr,"|",6);	//话费
	var consume_term  = oneTokSelf(tempStr,"|",7);	//话费消费期限
	var free_fee      = oneTokSelf(tempStr,"|",8);	//上网费
	var active_term   = oneTokSelf(tempStr,"|",9);	//上网费消费期限
	var price         = oneTokSelf(tempStr,"|",10);	//购TD费用
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
	opr_info+="业务类型: 购TD固话赠话费(铁通)冲正"+"|";
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
//TD商务固话主资费变更
function printInfo8687()
{
  //得到该业务工单需要的参数
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";

  var exeDate = "<%=exeDate.substring(0,8)%>";//得到执行时间
  var region_code = "<%=WtcUtil.repNull(request.getParameter("belong_code")).substring(0,2)%>"; //地区代码
  var old_smCode = "<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>";

  var retInfo = "";

	/********基本信息类**********/
    cust_info+="客户姓名：" +document.all.i4.value+"|";
    cust_info+="手机号码："+document.all.phone.value+"|";
    cust_info+="客户地址："+document.all.i5.value+"|";
    cust_info+="证件号码："+document.all.i7.value+"|";

    /********受理类**********/
    opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    <%if(goodbz.equals("Y")){%>
    opr_info+="办理业务:主资费变更"+"  "+"操作流水: "+"<%=printAccept%>" +"|";
  <%}else{%>
  	opr_info+="办理业务:主资费变更"+"  "+"操作流水: "+"<%=printAccept%>" +"|";
  	<%}%>
    opr_info+="当前主资费："+"<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
    opr_info+="新申请主资费："+codeChg(document.form1.ip.value.trim())+"      "+"新资费生效时间："+checkdate(exeDate)+"|";
    opr_info+="新申请主资费二次批价："+ codeChg("<%=daima.trim()%>")+"*|" ;
    if( document.all.kx_want.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_want.value) + "|";
    }
    if( document.all.kx_cancle.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_cancle.value) + "|";
    }

	  /*******备注类**********/
	//note_info1+="备注："+"|";
	  if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }
	  /**********描述类*********/
	note_info1+="  "+"|";
	note_info1+="  "+"|";
    note_info1+="新申请主资费描述: "+"|";
    note_info1+=codeChg("<%=note.trim()%>")+"|";
    note_info2+="  "+"|";
    note_info3+="  "+"|";

	<%if(goodbz.equals("Y")){%>
	        note_info4+=" "+"|";
			note_info4+="备注："+"|";
	<%}%>
	note_info4+=" "+"|";
	note_info4+="备注:"+codeChg(document.all.tonote.value)+"|";
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}
//TD固话主资费变更
function printInfo8688()
{
  //得到该业务工单需要的参数
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";

  var exeDate = "<%=exeDate.substring(0,8)%>";//得到执行时间
  var region_code = "<%=WtcUtil.repNull(request.getParameter("belong_code")).substring(0,2)%>"; //地区代码
  var old_smCode = "<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>";

  var retInfo = "";

	/********基本信息类**********/
    cust_info+="客户姓名：" +document.all.i4.value+"|";
    cust_info+="手机号码："+document.all.phone.value+"|";
    cust_info+="客户地址："+document.all.i5.value+"|";
    cust_info+="证件号码："+document.all.i7.value+"|";

    /********受理类**********/
    opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    <%if(goodbz.equals("Y")){%>
    opr_info+="办理业务:主资费变更"+"  "+"操作流水: "+"<%=printAccept%>" +"|";
  <%}else{%>
  	opr_info+="办理业务:主资费变更"+"  "+"操作流水: "+"<%=printAccept%>" +"|";
  	<%}%>
    opr_info+="当前主资费："+"<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
    opr_info+="新申请主资费："+codeChg(document.form1.ip.value.trim())+"      "+"新资费生效时间："+checkdate(exeDate)+"|";
    opr_info+="新申请主资费二次批价："+ codeChg("<%=daima.trim()%>")+"*|" ;
    if( document.all.kx_want.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_want.value) + "|";
    }
    if( document.all.kx_cancle.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_cancle.value) + "|";
    }

	  /*******备注类**********/
	//note_info1+="备注："+"|";
	  if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }
	  /**********描述类*********/
	note_info1+="  "+"|";
	note_info1+="  "+"|";
    note_info1+="新申请主资费描述:"+"|";
    note_info1+=codeChg("<%=note.trim()%>")+"|";
    note_info2+="  "+"|";
    note_info3+="  "+"|";

	<%if(goodbz.equals("Y")){%>
	        note_info4+=" "+"|";
			note_info4+="备注："+"|";
	<%}%>
	note_info4+=" "+"|";
	note_info4+="备注:"+codeChg(document.all.tonote.value)+"|";
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}

function printInfoG068() 
{
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	
	var exeDate = "<%=exeDate.substring(0,8)%>";//得到执行时间
	var region_code = "<%=WtcUtil.repNull(request.getParameter("belong_code")).substring(0,2)%>"; //地区代码
	var old_smCode = "<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>";

	var tempStr = document.form1.iAddStr.value;	
	var phone_type    = oneTokSelf(tempStr,"|",3);	//固话型号
	var imeino        = oneTokSelf(tempStr,"|",11); //IEMI号码
	var agent_code    = oneTokSelf(tempStr,"|",2);	//手机品牌
	
	cust_info+="手机号码："+document.all.phone.value+"|";
	cust_info+="客户姓名：" +document.all.i4.value+"|";
	opr_info+="用户品牌："+"<%=WtcUtil.repNull(request.getParameter("oSmName")).trim()%>"+"    办理业务:TD固话自备机入网"+"|";
	opr_info+="操作流水：<%=printAccept%>"+"|";
	opr_info+="TD固话型号："+agent_code+"-"+phone_type+"      IMEI码："+imeino+"|";
	note_info1+="欢迎您办理“TD固话自备机入网”业务"
		+"您本次活动办理的TD固话号码和您自备的TD固话必须在一起使用，"
		+"否则系统将不执行您办理的TD固话资费，自动变更为30普通资费。"
		+"如您的TD固话因丢失、质量问题或其他个人原因造成不能继续使用，"
		+"可到营业厅办理销户业务，"
		+"或购买新的TD固话并到营业厅办理重新绑定业务，才可以继续使用。"+"|";
	note_info2+="  "+"|";
    	note_info3+="  "+"|";
    	note_info4+="  "+"|";
	var retInfo = "";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}


//购TD商务固话赠通信费申请   sunaj－20090828
function printInfo7898()
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
	opr_info+="业务类型: 预存话费赠TD商务固话申请"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}%>
	opr_info+="购机信息：品牌"+agent_code+"，型号"+phone_type+"，捆绑IMEI"+imeino+"|";
	opr_info+="赠送话费"+base_fee+"元，分"+consume_term+"个月赠送，"+consume_term+"个月消费完毕，|";
	if(free_fee>0)
	{
		opr_info+="赠送上网费: "+free_fee+"元，|";
	}
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
	   var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
       var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
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
		  		note_info1+="<%=readValue("7898","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
	note_info3+=" "+"|";
	note_info4+="备注： "+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//购TD商务固话赠通信费冲正  sunaj－20090828
function printInfo7899()
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
	opr_info+="业务类型: 预存话费赠TD商务固话冲正"+"|";
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

//TD固话自备机入网冲正  
function printInfoG069()
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
	var smName="";
	if("<%=WtcUtil.repNull(request.getParameter("i8"))%>" == "zn")
		smName="神州行";
	else if("<%=WtcUtil.repNull(request.getParameter("i8"))%>" == "gn")
		smName="全球通";
	else if("<%=WtcUtil.repNull(request.getParameter("i8"))%>" == "dn")
		smName="动感地带";	
	opr_info+="用户品牌："+smName+"|";
	opr_info+="办理业务： TD固话自备机入网冲正"+"|";

	<%if(goodbz.equals("Y")){%>
	opr_info+="业务流水："+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}%>
	opr_info+="TD固话型号："+agent_code+"-"+phone_type+"      IMEI码："+imeino+"|";
	/*******备注类**********/

	/**********描述类*********/
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}


//购TD商务固话,赠通信费(铁通)申请   wangyua－20100511
function printInfo7688()
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
	opr_info+="业务类型: 预存话费赠TD商务固话(铁通)申请"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="操作流水："+"<%=printAccept%>"+"|";
	<%}%>
	opr_info+="购机信息：品牌"+agent_code+"，型号"+phone_type+"，捆绑IMEI"+imeino+"|";
	opr_info+="赠送话费："+base_fee+"元，分"+consume_term+"个月赠送，"+consume_term+"个月消费完毕，|";
	if(free_fee>0)
	{
		opr_info+="赠送上网费："+free_fee+"元，|";
	}
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
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
	  var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
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
function printInfo7689()
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
	opr_info+="业务类型: 预存话费赠TD商务固话(铁通)冲正"+"|";
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

//合约计划购机
function printInfoE505() {
		//得到该业务工单需要的参数
		var tempStr = document.form1.iAddStr.value;
		/**** pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",10);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}else if(document.all.payType.value=="EI"){
				document.all.transType.value="12";
		}
		/**** pos end *****/
		var login_accept   = '<%=printAccept%>';        //业务流水
		var old_code			 = '<%=iold_m_code%>';        //老资费代码
		var sale_code 		 = '<%=inew_m_code%>';        //新主资费代码
		var phone_brand    = oneTokSelf(tempStr,"|",1); //手机品牌
		var phone_type     = oneTokSelf(tempStr,"|",2);	//手机型号
		var sale_ways      = oneTokSelf(tempStr,"|",3);	//营销方案
		var mode_sale   	 = oneTokSelf(tempStr,"|",4);	//新主资费
		var prepay_limit   = oneTokSelf(tempStr,"|",5);	//底线预存
		var prepay_gift    = oneTokSelf(tempStr,"|",6);	//活动预存
		var consume_term   = oneTokSelf(tempStr,"|",7);	//预存消费期限
		var mon_base_fee   = oneTokSelf(tempStr,"|",8);	//月底线消费
		var base_fee   		 = oneTokSelf(tempStr,"|",9);	//购机款
		var sale_price     = oneTokSelf(tempStr,"|",10);//用户缴费合计
		var active_term    = oneTokSelf(tempStr,"|",11);//拆包期限
		var sale_name  		 = oneTokSelf(tempStr,"|",12);//阶段活动名称
		var imeino         = oneTokSelf(tempStr,"|",13);//IMEI码
		var mon_prepay_limit  = oneTokSelf(tempStr,"|",14);//月底线预存
		var feeMark         = oneTokSelf(tempStr,"|",15);//IMEI码
		var pointMoney  = oneTokSelf(tempStr,"|",16);//月底线预存
		var instalNum = oneTokSelf(tempStr,"|",17);//分期数
		var instalIncome = oneTokSelf(tempStr,"|",18);//分期比例
		var yuCunKuan = parseFloat(prepay_limit) + parseFloat(prepay_gift);
		//设置iAddStr的值
		/**营销代码|品牌名称|品牌型号｜用户缴费合计｜底线预存｜消费期限｜活动预存｜拆包期限｜购机款｜传0｜imei码|拆包期限**/
		base_fee = parseFloat(base_fee-pointMoney).toFixed(2);//liujian 2012-7-30 16:11:53 添加消费积分
		var txt = sale_ways     + "|" + 
				phone_brand   + "|" +
				phone_type    + "|" + 
				sale_price    + "|" + 
				prepay_limit  + "|" + 
				consume_term  + "|" + 
				prepay_gift   + "|" + 
				active_term  + "|" + 
				base_fee      + "|" + 
				"0"           + "|" + 
				imeino        + "|" +
				feeMark       + "|" +
				parseFloat(pointMoney).toFixed(2)    + "|";//liujian 2012-7-30 16:11:53 添加消费积分
				txt += instalNum + "|";
				txt += instalIncome + "|";
		$("input[name='iAddStr']").val(txt);
		
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
	cust_info+="证件号码：" +document.all.i7.value+"|";
	cust_info+="客户地址："+document.all.i5.value+"|";
	
	/********受理类**********/
//	var saleName = sale_name ? (sale_name+"--") : "";
  opr_info+="用户品牌: "+ "<%=WtcUtil.repNull(request.getParameter("i8"))%>" + "       办理业务:" + "<%=e505_sale_name%>" + "<%=opName%>"+"|";
  <%if(goodbz.equals("Y")){%>
		opr_info+="操作流水: "+"<%=printAccept%>" +"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";;
	<%}else{%>
		opr_info+="操作流水: "+"<%=printAccept%>" +"|";
	<%}%>
  opr_info+="手机型号：" + phone_type + "          IMEI码:" + imeino + "|";
  opr_info+="缴费合计：" + sale_price  +"元  含：购机款" + base_fee + "元（已使用"+feeMark+"积分抵消"+parseFloat(pointMoney).toFixed(2)+"元购机款），预存款" + yuCunKuan + "元，每月返还金额" + mon_prepay_limit +"元，一次性返还" + prepay_gift + "元，业务有效期" + consume_term + "个月" + "|" ;
	/*******备注类**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	note_info2+=" "+"|";
	/**********描述类*********/
	note_info3+="签约资费: " + "<%=new_Mode_Name%>" + "，" + "<%=note%>" + "|";
  note_info4+="备注：" + document.all.tonote.value + "|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	
	
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}
//合约计划购机冲正
function printInfoE506() {
		//得到该业务工单需要的参数
		var tempStr = document.form1.iAddStr.value;
		/**** pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",5);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="01";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="04";
		}else if(document.all.payType.value=="EI"){
				document.all.transType.value="04";
		}
		/**** pos end *****/
		
		/*
			冲正流水｜营销代码|品牌名称|品牌型号｜用户缴费合计｜底线预存｜消费期限｜活动预存｜活动期限｜购机款｜传0｜imei码｜
			loginAccept1
			saleCode 2
			brandName 3
			resName 4
			cashPay 5
			baseFee 6
			consumeTerm 7
			prepay_Gift 8
			consumeTerm 9 
			machPrice 10
			0
			imeiNo 12
		*/
		var login_accept   = '<%=printAccept%>';        //业务流水
		var old_code			 = '<%=iold_m_code%>';        //老资费代码
		var sale_code 		 = '<%=inew_m_code%>';        //新主资费代码
		
		var phone_brand    = oneTokSelf(tempStr,"|",1); //冲正流水
		var saleCode     = oneTokSelf(tempStr,"|",2);	//营销代码
		var brandName      = oneTokSelf(tempStr,"|",3);	//品牌名称
		var resName   	 = oneTokSelf(tempStr,"|",4);	//品牌型号
		var cashPay   = oneTokSelf(tempStr,"|",5);	//用户缴费合计
		var baseFee    = oneTokSelf(tempStr,"|",6);	//底线预存
		var consumeTerm   = oneTokSelf(tempStr,"|",7);	//消费期限
		var prepay_Gift   = oneTokSelf(tempStr,"|",8);	//活动预存
		var consumeTerm   		 = oneTokSelf(tempStr,"|",9);	//活动期限
		var machPrice     = oneTokSelf(tempStr,"|",10);//购机款
		var imeiNo    		 = oneTokSelf(tempStr,"|",12);//imei码
		
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
		cust_info+="证件号码：" +document.all.i7.value+"|";
		cust_info+="客户地址："+document.all.i5.value+"|";
		
		/********受理类**********/
	  opr_info+="用户品牌: "+ "<%=WtcUtil.repNull(request.getParameter("i8"))%>" + "       办理业务:" + "<%=e505_sale_name%>" +"<%=opName%>"+"|";
		opr_info+="操作流水: "+"<%=printAccept%>" +"|";
	  opr_info+="退款：" + cashPay  +"元|" ;
		/*******备注类**********/
		if("<%=bdbz%>"=="Y"){
			note_info1+="<%=bdts%>"+"|";
		}else{
			note_info1+=" "+"|";
		}
		note_info2+=" "+"|";
		/**********描述类*********/
	  note_info4+="备注：" + document.all.tonote.value + "|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		
		
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
}
//自备机合约计划
function printInfoE721() {
		//得到该业务工单需要的参数
		var tempStr = document.form1.iAddStr.value;
		/**** pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",4);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="01";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="04";
		}

		var login_accept   = '<%=printAccept%>';        //业务流水
		var old_code			 = '<%=iold_m_code%>';        //老资费代码
		var sale_code 		 = '<%=inew_m_code%>';        //新主资费代码
		var oldAccept      = oneTokSelf(tempStr,"|",1);	//冲正流水
		var saleCode    = oneTokSelf(tempStr,"|",2); //
		var brandName     = oneTokSelf(tempStr,"|",3);	//品牌
		var resName   = oneTokSelf(tempStr,"|",4);	//
		var cashPay     = oneTokSelf(tempStr,"|",5);	//
		var consume_term   = oneTokSelf(tempStr,"|",6);	//
		var free_fee		=oneTokSelf(tempStr,"|",7);//优惠总金额
		var active_term		=oneTokSelf(tempStr,"|",8);//拆包期限
		var base_fee		=oneTokSelf(tempStr,"|",9);//优惠比例
		var phoneOther 	= oneTokSelf(tempStr,"|",10);//
		var imeino         = oneTokSelf(tempStr,"|",11);//IMEI码
		//设置iAddStr的值
		/**营销代码|品牌名称|品牌型号｜用户缴费合计｜底线预存｜消费期限｜活动预存｜拆包期限｜月赠送预存款｜传0｜imei码|**/
		var temp = tempStr.substring(0,tempStr.lastIndexOf("|"));
	
		var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";
	
	var retInfo = "";
	/********基本信息类**********/
	cust_info+="手机号码："+document.all.phone.value+"|";
	cust_info+="客户姓名：" +document.all.i4.value+"|";
	cust_info+="客户地址："+document.all.i5.value+"|";	
	cust_info+="证件号码：" +document.all.i7.value+"|";
	/********受理类**********/
	 var exeDate = "<%=exeDate.substring(0,6)%>"

//	var saleName = sale_name ? (sale_name+"--") : "";
  	opr_info+="用户品牌: "	+'<%=WtcUtil.repNull(request.getParameter("i8"))%>'+ "       办理业务:" + "<%=sale_name%>"+"--" + "<%=opName%>"+"|";
	opr_info+="	业务流水："+login_accept+"|";
	opr_info+="	手机型号："+resName  +"|";
	opr_info+="	退预存款:"+cashPay+"元"+"|";

	/*******备注类**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	note_info2+=" "+"|";
	/**********描述类*********/

  note_info4+="备注:|" ;
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}


function printInfoE720() {
		//得到该业务工单需要的参数
		var tempStr = document.form1.iAddStr.value;
		/**** pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",4);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="01";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="04";
		}
		/**** iSaleCode|iBrandName|iTypeName|缴费金额|iBaseFee|优惠期限|优惠总金额|拆包期限
		|优惠比例|绑定人号码|iImeiNo|*****/
		var login_accept   = '<%=printAccept%>';        //业务流水
		var old_code			 = '<%=iold_m_code%>';        //老资费代码
		var sale_code 		 = '<%=inew_m_code%>';        //新主资费代码
		var sale_ways      = oneTokSelf(tempStr,"|",1);	//营销方案
		var phone_brand    = oneTokSelf(tempStr,"|",2); //手机品牌
		var phone_type     = oneTokSelf(tempStr,"|",3);	//手机型号
		var prepay_limit   = oneTokSelf(tempStr,"|",4);	//缴费金额
		var iBaseFee     = oneTokSelf(tempStr,"|",5);	//iBaseFee
		var consume_term   = oneTokSelf(tempStr,"|",6);	//合约期限
		var free_fee		=oneTokSelf(tempStr,"|",7);//优惠总金额
		var active_term		=oneTokSelf(tempStr,"|",8);//拆包期限
		var base_fee		=oneTokSelf(tempStr,"|",9);//优惠比例
		var phoneOther 	= oneTokSelf(tempStr,"|",10);//月底线预存
		var imeino         = oneTokSelf(tempStr,"|",11);//IMEI码
		var temp = tempStr.substring(0,tempStr.lastIndexOf("|"));
	

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";
	
	var retInfo = "";


	/********基本信息类**********/
	cust_info+="手机号码："+document.all.phone.value+"|";
	cust_info+="客户姓名：" +document.all.i4.value+"|";
	cust_info+="客户地址："+document.all.i5.value+"|";	
	cust_info+="证件号码：" +document.all.i7.value+"|";
	/********受理类**********/
		
	var	dt1 =new Date ();
	var ctBY=dt1.getFullYear();
	var ctBM= dt1.getMonth()+1;
		
	var ctEnd = new Date(dt1.getFullYear(), ( dt1.getMonth()+parseInt(consume_term , 10 ) ));
	var ctEndY=ctEnd.getFullYear();
	var ctEndM=ctEnd.getMonth()+1;
//	var saleName = sale_name ? (sale_name+"--") : "";
	var login_accept   = '<%=printAccept%>';        //业务流水
  opr_info+="用户品牌: "	+'<%=WtcUtil.repNull(request.getParameter("i8"))%>'+ "       办理业务:" + "<%=sale_name%>" + "<%=opName%>"+"|";
  opr_info+="资费套餐：" 	+document.all.ip.value    +"|";       
  opr_info+="资费描述："	+ "<%=note%>"			+"|";      
  opr_info+= "合约期："+ctBY+"年"+ctBM+"月至"+ctEndY+"年"+ctEndM+"月	"+"|";      
  opr_info+="业务流水："+login_accept+"|";   
  opr_info+="手机型号:"+phone_type+"    IMEI码："+imeino+"|";   
  opr_info+="缴费合计:"+prepay_limit+"含：预存话费"+prepay_limit+"元；"+"|"; 
  opr_info+="合约期内总通信费用优惠总额度为"+free_fee+"元；"+"|"; 
  opr_info+="通信费用优惠比例为客户移动电话号码月实际消费额度的"+base_fee+"%。"+"|"; 
	/*******备注类**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	note_info2+=" "+"|";
	/**********描述类*********/

  note_info4+="备注：|" ;

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

function printInfoE528() {
		//得到该业务工单需要的参数
		var tempStr = document.form1.iAddStr.value;
		/**** pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",4);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="01";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="04";
		}
		/**** pos end *****/
		var login_accept   = '<%=printAccept%>';        //业务流水
		var old_code			 = '<%=iold_m_code%>';        //老资费代码
		var sale_code 		 = '<%=inew_m_code%>';        //新主资费代码
		var sale_ways      = oneTokSelf(tempStr,"|",1);	//营销方案
		var phone_brand    = oneTokSelf(tempStr,"|",2); //手机品牌
		var phone_type     = oneTokSelf(tempStr,"|",3);	//手机型号
		var sale_price     = oneTokSelf(tempStr,"|",4);	//缴费合计
		var prepay_limit   = oneTokSelf(tempStr,"|",5);	//底线预存
		var consume_term   = oneTokSelf(tempStr,"|",6);	//消费期限
		var prepay_gift    = oneTokSelf(tempStr,"|",7);	//活动预存
		var mon_base_fee   = oneTokSelf(tempStr,"|",9);	//月赠送预存款
		var imeino         = oneTokSelf(tempStr,"|",11);//IMEI码
		var mon_prepay_limit = oneTokSelf(tempStr,"|",12);//月底线预存
		var sale_name			 = oneTokSelf(tempStr,"|",13);//阶段活动名称
		var yuCunKuan =  parseFloat(prepay_limit) + parseFloat(prepay_gift);
		//设置iAddStr的值
		/**营销代码|品牌名称|品牌型号｜用户缴费合计｜底线预存｜消费期限｜活动预存｜拆包期限｜月赠送预存款｜传0｜imei码|**/
		var temp = tempStr.substring(0,tempStr.lastIndexOf("|"));
		$("input[name='iAddStr']").val(temp.substring(0,temp.lastIndexOf("|")+1));
		$('#mon_prepay_limit').val(mon_prepay_limit);
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
	cust_info+="证件号码：" +document.all.i7.value+"|";
	cust_info+="客户地址："+document.all.i5.value+"|";
	
	/********受理类**********/
//	var saleName = sale_name ? (sale_name+"--") : "";
  opr_info+="用户品牌: "+ "<%=WtcUtil.repNull(request.getParameter("i8"))%>" 
  	+ "       办理业务:" + "<%=sale_name%>" + "<%=opName%>"+"|";
  <%if(goodbz.equals("Y")){%>
		opr_info+="操作流水: "+"<%=printAccept%>" +"       底线消费金额："+"<%=modedxpay%>"+"元"+"|";;
	<%}else{%>
		opr_info+="操作流水: "+"<%=printAccept%>" +"|";
	<%}%>
  opr_info+="手机型号：" + phone_type + "            IMEI码:" + imeino + "|";
  opr_info+="缴费合计：" + sale_price  +"元  含：预存话费" + yuCunKuan + "元，每月返还金额" + mon_prepay_limit + "元，一次性返还" + prepay_gift + "元，每月赠送费用" + mon_base_fee + "元,业务有效期" + parseInt(consume_term) + "个月。" + "|" ;
	/*******备注类**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	note_info2+=" "+"|";
	/**********描述类*********/
	note_info3+="签约资费: " + "<%=new_Mode_Name%>" + "，" + "<%=note%>" + "|";
  note_info4+="备注：" + document.all.tonote.value + "|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}
//自备机合约计划冲正
function printInfoE529() {
		//得到该业务工单需要的参数
		var tempStr = document.form1.iAddStr.value;
		/**** pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",5);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="01";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="04";
		}
		/**** pos end *****/
		
		/*
			冲正流水｜营销代码|品牌名称|品牌型号｜用户缴费合计｜底线预存｜消费期限｜活动预存｜活动期限｜月赠送预存款｜传0｜imei码｜
			loginAccept1
			saleCode 2
			brandName 3
			resName 4
			cashPay 5
			baseFee 6
			consumeTerm 7
			prepay_Gift 8
			consumeTerm 9 
			machPrice 10
			0
			imeiNo 12
		*/
		var login_accept   = '<%=printAccept%>';        //业务流水
		var old_code			 = '<%=iold_m_code%>';        //老资费代码
		var sale_code 		 = '<%=inew_m_code%>';        //新主资费代码
		
		var phone_brand    = oneTokSelf(tempStr,"|",1); //冲正流水
		var saleCode     = oneTokSelf(tempStr,"|",2);	//营销代码
		var brandName      = oneTokSelf(tempStr,"|",3);	//品牌名称
		var resName   	 = oneTokSelf(tempStr,"|",4);	//品牌型号
		var cashPay   = oneTokSelf(tempStr,"|",5);	//用户缴费合计
		var baseFee    = oneTokSelf(tempStr,"|",6);	//底线预存
		var consumeTerm   = oneTokSelf(tempStr,"|",7);	//消费期限
		var prepay_Gift   = oneTokSelf(tempStr,"|",8);	//活动预存
		var consumeTerm   		 = oneTokSelf(tempStr,"|",9);	//活动期限
		var machPrice     = oneTokSelf(tempStr,"|",10);//月赠送预存款
		var imeiNo    		 = oneTokSelf(tempStr,"|",12);//imei码
		var yuCunKuan = parseFloat(baseFee) + parseFloat(prepay_Gift) + "";
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
		cust_info+="证件号码：" +document.all.i7.value+"|";
		cust_info+="客户地址："+document.all.i5.value+"|";
		
		/********受理类**********/
	  opr_info+="用户品牌: "+ "<%=WtcUtil.repNull(request.getParameter("i8"))%>" + "       办理业务:" + "<%=sale_name%>" +"<%=opName%>"+"|";
		opr_info+="操作流水: "+"<%=printAccept%>" +"|";
		//  含：预存话费XX元；每月返还金额：XX元；一次性返还：XX元；每月赠送费用：XX元。
	  opr_info+="退款总计：" + cashPay  +"元   含：预存话费" + yuCunKuan + "元。|" ;
		/*******备注类**********/
		if("<%=bdbz%>"=="Y"){
			note_info1+="<%=bdts%>"+"|";
		}else{
			note_info1+=" "+"|";
		}
		note_info2+=" "+"|";
		/**********描述类*********/
	  note_info4+="备注：" + document.all.tonote.value + "|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		
		
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
}

/*--------------------------手续费校验函数--------------------------*/

function checknum(obj1,obj2)
{
    var num2 = parseFloat(obj2.value);
    var num1 = parseFloat(obj1.value);

    if(num2<num1)
    {
        var themsg = "'" + obj1.v_name + "'不得大于'" + obj2.value + "'请重新输入！";
        rdShowMessageDialog(themsg);
        obj1.focus();
        return false;
    }
    return true;
}
/*-------------------------页面提交跳转函数----------------------------*/
function pageSubmit(flag){
 	if(flag==1){
	/*document.form1.action="<%=request.getContextPath()%>/npage/bill/f1270_1.jsp"; */
  //form1.submit();
      history.go(-1);
	}
	if(flag==2)
	{
	    document.form1.action="<%=request.getContextPath()%>/npage/bill/f1270_3.jsp";
        form1.submit();
	}
	if(flag==3)
	{
	    document.form1.action="f1270_2.jsp";
        form1.submit();
	}
}

var dynTbIndex=0;
var token = "|";

/*------------------------- 删除对应业务逻辑表格---------------------------*/

function tohidden(s)// s 表示 套餐类型，从openwindow 传入
{
	var tmpTr = "";
	for(var a = document.all('tr').rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
	{
        if(document.all.R8[a].value==s && document.all.R1[a].value=="N")
        {   			if(document.all.R11[a].value.trim()=="0"||document.all.R11[a].value.trim()=="c")//choice_flag0或c删除
            {
                document.all.tr.deleteRow(a+1);
						}
        }
	}

    return true;
}

function openwindow(theNo,p,q)
{
	//定义窗口参数
    var h=600;
    var w=720;
    var t=screen.availHeight-h-20;
    var l=screen.availWidth/2-w/2;
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" ;
    var belong_code = document.all.belong_code.value;
    var maincash_no = document.all.maincash_no.value;
    var ip = document.all.ip.value.substring(0,8);
    var cust_id = document.all.i2.value;
    var sendflag = document.all.tbselect.value.substring(0,1);
	//-----------------linxd--1---------------------------
	var minopen="";
	var maxopen="";
    minopen = oMinOpenObj[theNo].value;
	maxopen = oMaxOpenObj[theNo].value;


    var ret_code = window.showModalDialog("f1270_6.jsp?mode_type="+p+"&belong_code="+belong_code+"&maincash_no="+codeChg(maincash_no)+"&ip="+codeChg(ip)+"&cust_id="+cust_id+"&sendflag="+sendflag+"&mode_name="+q+"&minopen="+minopen+"&maxopen="+maxopen,"",prop);
    var srcStr = ret_code;
    if(ret_code==null)
    {
        return false;
    }

    if(typeof(srcStr)!="undefined")
	  {
    	tohidden(p);
        getStr(srcStr,token);
    }
    return true;
}
function getStr(srcStr,token)
	{
		var field_num = 13;
		var i =0;
		var inString = srcStr;
		var retInfo="";
		var tmpPos=0;
	    var chPos;
	    var valueStr;
	    var retValue="";

	    var a0="";
	    var a1="";
	    var a2="";
	    var a3="";
	    var a4="";
		var a5="";
		var a6="";
		var a7="";
        var a8="";
		var a9="";
		var a10="";
		var a11="";
		var a12="";
		var a1Tmp="";
		retInfo = inString;
		chPos = retInfo.indexOf(token);
	    while(chPos > -1)
	    {
		  for( i=0; i<field_num; i++)
		  {
			valueStr = retInfo.substring(0,chPos);

			if(i == 0) a0 = valueStr;
			if(i == 1) a1 = valueStr;
			if(a1=="Y")a1Tmp="已开通";
			if(a1=="N")a1Tmp="未开通";
			if(i == 2) a2 = valueStr;
			if(i == 3) a3 = valueStr;
			if(i == 4) a4 = valueStr;
            if(i == 5) a5 = valueStr;
			if(i == 6) a6 = valueStr;
            if(i == 7) a7 = valueStr;
            if(i == 8) a8 = valueStr;
			if(i == 9) a9 = valueStr;
			if(i == 10) a10 = valueStr;
            if(i == 11) a11 = valueStr;
			if(i == 12) a12 = valueStr;
			//rdShowMessageDialog("a12="+a12);
			retInfo = retInfo.substring(chPos + 1);
			chPos = retInfo.indexOf(token);
            if( !(chPos > -1)) break;
	       }
			  insertTab(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a1Tmp);
	    }
	}
function insertTab(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a1Tmp)
{

    var tr1=tr.insertRow();
    tr1.id="tr"+dynTbIndex;
    var divid = "div"+dynTbIndex;
    //rdShowMessageDialog(tr1.id);
	//rdShowMessageDialog("a12="+a12);
	td1 = tr1.insertCell();
	td2 = tr1.insertCell();
	td3 = tr1.insertCell();
	td4 = tr1.insertCell();
	td5 = tr1.insertCell();
	td6 = tr1.insertCell();
	td7 = tr1.insertCell();
	td8 = tr1.insertCell();
	td2.id="div"+dynTbIndex;
	td1.innerHTML = '<div align="center"><input type="checkbox" name="checkId" checked></input></div>';
    td2.innerHTML = '<div align="center"><a Href="#"  onClick="openhref('+"'"+a7+"'"+')">'+a0+'</a><input id=R0 type=hidden value='+a0+'  size=10 readonly></input></div>';
    td3.innerHTML = '<div align="center">'+a1Tmp+'<input id=R1 type=hidden value='+a1+'  size=10 readonly></input></div>';
    td4.innerHTML = '<div align="center">'+a2+'<input id=R2 type=hidden value='+a2+'  size=18 readonly></input></div>';
    td5.innerHTML = '<div align="center">'+a3+'<input id=R3 type=hidden value='+a3+'  size=10 readonly></input></div>';
    td6.innerHTML = '<div align="center">'+a4+'<input id=R4 type=hidden value='+a4+'  size=10 readonly></input></div>';
    td7.innerHTML = '<div align="center">'+a5+'<input id=R5 type=hidden value='+a5+'  size=10 readonly></input></div>';
    td8.innerHTML = '<div align="center">'+a6+'<input id=R6 type=hidden value='+a6+'  size=10 readonly><input id=R7 type=hidden value='+a7+'  size=10 readonly><input id=R8 type=hidden value='+a8+'  size=10 readonly><input id=R9 type=hidden value='+a9+'  size=10 readonly><input id=R10 type=hidden value='+a10+'  size=10 readonly><input id=R11 type=hidden value='+a11+'  size=10 readonly><input name="R12" id="R12'+dynTbIndex+'" type=hidden  size=10 readonly></input></div>';
	$("#R12"+dynTbIndex).val(a12);   //为了解决返回描述信息中的回车造成数据显示不全
    getMidPrompt("10442",a7,divid);

    dynTbIndex++;


}
/*------------------------------组织参数到下一页接受---------------------------------------*/
function senddata()
{
 var kx_code_bunch = "";                                     //可选资费代码串
 var kx_code_name_bunch = "";                                 //可选资费名称串
 var kx_habitus_bunch ="";                                   //可选自费状态串
 var kx_erpi_bunch="";										//可选套餐二批
 var kx_operation_bunch="";                                  //可选套餐的生效方式串
 var kx_stream_bunch="";                                     //可选套餐原开通流水串
 var kx_explan_bunch="";									//可选套餐描述
 var tempnm="";												 //临时操作变量
 var kx_want="";											 //打印－申请操作
 var kx_cancle="";											 //打印－取消操作
 var kx_running="";											 //打印－所有开通操作
 var kx_want_chgrow="0";								     //打印－申请操作,换行标志
 var kx_cancle_chgrow= "0";									 //打印－取消操作,换行标志
 var kx_running_chgrow="0";									 //打印－所有开通操作,换行标志
	kx_want =  "本次申请可选套餐：";
	kx_cancle = "本次取消可选套餐：";

	//rdShowMessageDialog("["+document.all.i16.value.substring(0,8)+"*"+document.all.i18.value.substring(0,8)+"]");
	if(document.all.i16.value.substring(0,8)!=document.all.i18.value.substring(0,8))
			kx_cancle = kx_cancle + " " + document.all.i18.value.substring(8);
    var modestr="";
    var modestr_lj="";
    var modestr_yy="";
	  for(var i=0;i<document.all.checkId.length;i++)
		  {

		/********liucm可选资费取消提示*******************/
		 <% if(iop_code.equals("a198")||iop_code.equals("k200")||iop_code.equals("k206")||iop_code.equals("126c")
		 ||iop_code.equals("8035")||iop_code.equals("8071")||iop_code.equals("8043")||iop_code.equals("8045")
		 ||iop_code.equals("126i")||iop_code.equals("2282")||iop_code.equals("2265")||iop_code.equals("2284")||iop_code.equals("7118")
		 ||iop_code.equals("127a")||iop_code.equals("127b")||iop_code.equals("125c")) {%>

		<%}else{%>
		   if(document.all.checkId[i].checked==false && document.all.R1[i].value=="Y"){
		    	//modestr=modestr+document.all.R7[i].value+"("+document.all.R0[i].value+")，　";

		   		if(document.all.R9[i].value=="0"){
		   			modestr_lj=modestr_lj+document.all.R7[i].value+"("+document.all.R0[i].value+"),";
		   		}else{
		   			modestr_yy=modestr_yy+document.all.R7[i].value+"("+document.all.R0[i].value+"),";
		   		}　

		   }

		 <%}%>

		    if(document.all.checkId[i].checked==true && document.all.R1[i].value=="N" ||//申请
			   document.all.checkId[i].checked==false && document.all.R1[i].value=="Y" )//取消
				  {
						kx_code_bunch = kx_code_bunch + document.all.R7[i].value + "#"; //可选资费代码串
						kx_habitus_bunch = kx_habitus_bunch + document.all.R1[i].value + "#";       //可选资费状态串
						kx_operation_bunch = kx_operation_bunch + document.all.R9[i].value + "#";   //可选套餐的生效方式串
						kx_stream_bunch = kx_stream_bunch + document.all.R10[i].value + "#";//可选套餐原开通流水串



						if(document.all.R12[i].value=="无描述信息"){
							kx_explan_bunch = kx_explan_bunch ;
						}else{
							kx_explan_bunch = kx_explan_bunch +" "+ document.all.R12[i].value ;
						}
						if(document.all.checkId[i].checked==true && document.all.R1[i].value=="N") //所有开通情况
						  {
								kx_want = kx_want +  " (" + document.all.R7[i].value+"、"+ document.all.R0[i].value+"、"+document.all.R5[i].value +")" ;  //申请串
								kx_want_chgrow = 1*kx_want_chgrow+1;
						  }
						if(document.all.checkId[i].checked==false && document.all.R1[i].value=="Y")//取消情况
						  {
							kx_cancle = kx_cancle +  " (" + document.all.R7[i].value+"、"+ document.all.R0[i].value+"、"+document.all.R5[i].value +")" ;  //取消串
							kx_cancle_chgrow = 1*kx_cancle_chgrow+1;
						  }

				  }
			if(document.all.checkId[i].checked==true)
				  {
			           kx_running = kx_running  + " " + document.all.R0[i].value  ;     //所有开通串
					   kx_running_chgrow = 1*kx_running_chgrow+1;
					   kx_erpi_bunch=kx_erpi_bunch+ document.all.R8[i].value + " ";
					   kx_code_name_bunch = kx_code_name_bunch +document.all.R7[i].value+document.all.R0[i].value+" ";


					   if(kx_running_chgrow==3) kx_running+="|";
			      }
		  }
    	document.all.modestr.value="";
    	//需求未上线封
		if (modestr_lj.length>0){
		   	document.all.modestr.value=document.all.modestr.value+modestr_lj+"将被立即取消, "
		}
		if(modestr_yy.length>0){
		    document.all.modestr.value=document.all.modestr.value+modestr_yy+"将于下月1日被取消, "
		}
		if(document.all.modestr.value.length>0){

			rdShowMessageDialog("可选资费"+document.all.modestr.value+"请提示客户!");
		}
		  if(modestr.length>0){
		    document.all.modestr.value=modestr;
			rdShowMessageDialog("可选资费"+document.all.modestr.value+"在下一个资费生效时将被取消，请提示客户！");
			}


	if(kx_running=="")kx_running="无";
	kx_running = "开通可选套餐：" +  kx_running +"|";
	kx_want = kx_want + "|";
	kx_cancle = kx_cancle + "|";


		  if(kx_habitus_bunch==""){kx_habitus_bunch = " #";}
		  if(kx_operation_bunch==""){kx_operation_bunch=" #";}
		  if(kx_stream_bunch==""){kx_stream_bunch=" #";}

		  document.all.kx_code_bunch.value=kx_code_bunch;                        //可选资费代码串
		  document.all.kx_habitus_bunch.value=kx_habitus_bunch;                  //可选资费状态串
		  document.all.kx_operation_bunch.value = kx_operation_bunch;            //可选套餐的生效方式串
		  document.all.kx_stream_bunch.value = kx_stream_bunch;                  //可选套餐的开通流水串
		  document.all.kx_explan_bunch.value = kx_explan_bunch;						//可选套餐描述

		  document.all.kx_erpi_bunch.value = kx_erpi_bunch;
		  document.all.kx_code_name_bunch.value = kx_code_name_bunch;

		  document.all.kx_want.value = kx_want;                                  //打印－所有申请操作-串
		  document.all.kx_cancle.value = kx_cancle;                              //打印－所有取消操作-串
		  document.all.kx_running.value = kx_running;                            //打印－所有开通的套餐-串
		/*  rdShowMessageDialog(document.all.kx_code_bunch.value);
		  rdShowMessageDialog(document.all.kx_habitus_bunch.value);
		  rdShowMessageDialog(document.all.kx_operation_bunch.value);
		  rdShowMessageDialog(document.all.kx_stream_bunch.value);
		  rdShowMessageDialog(document.all.kx_want.value);
		  rdShowMessageDialog(document.all.kx_cancle.value);
		  rdShowMessageDialog(document.all.kx_running.value);*/
		  return true;
}
/*----------------------------------判断业务套餐是否可以操作-----------------------------------*/
function checksel()
{
    with(document.all)
    {
        for(j=0;j<oTypeNameObj.length;j++)
        {
            oDefaultFlagObj[j].value="N";
            oDefaultOpenObj[j].value="N";
            oActualOpenObj[j].value = "0" ;
        }
        for(var i=1;i<checkId.length;i++)
        {
            if(R11[i].value=="b")
            {
                rdShowMessageDialog("‘"+R0[i].value+"’因生效时间与历史时间冲突而不可申请导致此次操作失败！");
                return false;
            }
            for(var j=0;j<oTypeNameObj.length;j++)
            {
                if(oTypeValueObj[j].value==R8[i].value)
                {
                    if(checkId[i].checked==true)
                    {
                        oActualOpenObj[j].value = 1*oActualOpenObj[j].value+1;
                    }
                    if(R11[i].value=="1"||R11[i].value=="a")
                    {
                        oDefaultFlagObj[j].value="Y";
                        if(checkId[i].checked==true) oDefaultOpenObj[j].value="Y";
                    }
                    break;
                }
            }
        }
        for(j=0;j<oTypeNameObj.length;j++)
        {
            if(Math.round(oActualOpenObj[j].value)<Math.round(oMinOpenObj[j].value)||Math.round(oActualOpenObj[j].value)>Math.round(oMaxOpenObj[j].value))
            {
                rdShowMessageDialog("‘"+oTypeNameObj[j].value+"’类套餐实际开通"+oActualOpenObj[j].value+"，应在"+oMinOpenObj[j].value+"到"+oMaxOpenObj[j].value+"之间");
                return false;
            }
            if(oDefaultFlagObj[j].value=="Y"&&oDefaultOpenObj[j].value=="N")
            {
                rdShowMessageDialog("请确认‘"+oTypeNameObj[j].value+"’类可选方式为‘默认’的套餐至少开通一个");
                return false;
            }
        }
		var tempflag="0";
		var threeflag = "0";
		for(V=0;V<R11.length;V++)
			{
				if(R11[V].value == "4")
					{
						tempflag = 1*tempflag+1;
					}//先统计有没有等于3的数据，如果有再做一下判断
			}
		if(tempflag>0)
			{
				for(m=0;m<R11.length;m++)
					{
					if(R11[m].value == "4" && checkId[m].checked == true)
						{
							threeflag = 1*threeflag+1;
						}
					}
				if(threeflag < 1)
					{
						rdShowMessageDialog("所有'多组选一'套餐至少开通一个");
						return false;
					}
			}

    }
    return true;
}
/*-----------------------------------判断是否有生效时间与历史时间冲突而不可申请的错误数据-----------------------*/
//读取页面时
onload=function()
{
	if("<%=bdbz%>"=="Y"){
		rdShowMessageDialog("<%=bdts%>");
	}
	for(var i=1;i<document.all.checkId.length;i++)
	{
	if(document.all.R11[i].value=="b")
	  {
	 	rdShowMessageDialog("‘"+document.all.R0[i].value+"’因生效时间与历史时间冲突而不可申请导致此次操作失败！");
	  }
	}
}

function openhref(p)
	{
		var h=600;
		var w=550;
		var t=screen.availHeight-h-20;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" ;
		var region_code = '<%=ibelong_code.substring(0,2)%>';
		var ret_code = window.showModalDialog("f1270m_detail.jsp?mode_code="+p+"&region_code="+region_code,"",prop);
	}
function checkdate(s)
{
	var extdate=s;
	var	date_note;
	var year = s.substr(0,4);
	var month = s.substr(4,2);
	var date = s.substr(6,2);
	var sysyear = <%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>;
	var sysmonth = <%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>;
	var sysday = <%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>;
	var sysdate=<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>;
	if(year==sysyear)
	{	if(month==sysmonth){
			if(date==sysday){
				date_note="当日";
			}else if(date-sysday>1){
				date_note="当月";
			}else{
				date_note="次日";
			}
		}else{
			date_note="次月";
		}

	}else{
		date_note="次月";
	}
	return date_note;
}

/**************
	//将字符串按照tok分解取值
   function oneTok(str,tok,loc){
		   var temStr=str;
		   if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
		   if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);

			 var temLoc;
			 var temLen;
		    for(ii=0;ii<loc-1;ii++)
			{
		       temLen=temStr.length;
		       temLoc=temStr.indexOf(tok);
		       temStr=temStr.substring(temLoc+1,temLen);
		 	}
			if(temStr.indexOf(tok)==-1)
			  return temStr;
			else
		    return temStr.substring(0,temStr.indexOf(tok));
  }
**************/

	//分解字符串
	function oneTokSelf(str,tok,loc)
  {
    var temStr=str;
    //if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
    //if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);

	var temLoc;
	var temLen;
    for(ii=0;ii<loc-1;ii++)
	{
       temLen=temStr.length;
       temLoc=temStr.indexOf(tok);
       temStr=temStr.substring(temLoc+1,temLen);
 	}
	if(temStr.indexOf(tok)==-1)
	  return temStr;
	else
      return temStr.substring(0,temStr.indexOf(tok));
  }

  /***其他函数中要用到的过滤函数**/
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
</script>
<%
	System.out.println("###################zhanghongzhanghong24################System.currentTimeMillis()->"+System.currentTimeMillis());
%>

<jsp:include page="fg122_1270_3.jsp">
	<jsp:param name="printAccept" value="<%=printAccept%>"  />
	<jsp:param name="bdbz" value="<%=bdbz%>"  />
	<jsp:param name="bdts" value="<%=bdts%>"  />
	<jsp:param name="note" value="<%=note%>"  />
	<jsp:param name="note1" value="<%=note1%>"  />
	<jsp:param name="smzvalue" value="<%=smzvalue%>"  />
	<jsp:param name="goodbz" value="<%=goodbz%>"  />
</jsp:include>