<%
  /*
   * 功能: 保存客户来电信息
　 * 版本: 1.0.0
　 * 日期: 2009/04/27
　 * 作者: 
　 * 版权: sitech
   * update: tancf 保存客户归属
　 */
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@page import="com.sitech.crmpd.kf.dto.dcallcall.Dcallcallyyyymm"%> 
<%@page import="com.sitech.crmpd.kf.cache.DCallCacheManager"%> 
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%> 
<%@page import="java.util.Calendar"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%> 
<%!
	/* inputStr为输入数组 lengthLimit为数组的长度限制  defaultStr为默认返回字符串
	*/
  public String formatStr(String inputStr,int lengthLimit,String defaultStr){
	      if(lengthLimit<=0||inputStr==null||"".equals(inputStr))
	      	return inputStr;
		  byte[] inputBytes = inputStr.getBytes();
		  if(inputBytes.length>lengthLimit){
			 if(defaultStr!=null&&!"".equals(defaultStr)){
				 return defaultStr;
			 }
			 byte[] returnBytes = new byte[lengthLimit];
			 System.arraycopy(inputBytes, 0, returnBytes, 0, lengthLimit);
			 return new String(returnBytes);
		  }
		  return inputStr;
		}
%>

<%

	String contactId = WtcUtil.repNull(request.getParameter("contactId"));
    Dcallcallyyyymm dcallcallyyyymm=new Dcallcallyyyymm();
    dcallcallyyyymm.setContact_id(contactId);	
    DCallCacheManager.getInstance().put(contactId,dcallcallyyyymm);		
  	dcallcallyyyymm.setContactMonth(contactId.substring(0,6));	
    String callid = WtcUtil.repNull(request.getParameter("callid"));
    System.out.print("yinzxyinzxyinzxyizxnyizxn=======>"+contactId.substring(0,6));
	String outFlag = WtcUtil.repNull(request.getParameter("outFlag"));
	String caller = formatStr(WtcUtil.repNull(request.getParameter("caller")),20,"9");
	String called = formatStr(WtcUtil.repNull(request.getParameter("called")),20,"9");	
	String login_no = formatStr(WtcUtil.repNull(request.getParameter("login_no")),10,"9");
	String workNo = formatStr(WtcUtil.repNull(request.getParameter("workNo")),10,"9");
	String ipAddress = formatStr(WtcUtil.repNull(request.getParameter("ipAddress")),15,"9");
	String orgCode = WtcUtil.repNull(request.getParameter("orgCode"));
	String opCode = formatStr(WtcUtil.repNull(request.getParameter("opCode")),4,"9");
	String accept_kf_no = formatStr(WtcUtil.repNull(request.getParameter("accept_kf_no")),10,"9");
	String agentSkill = formatStr(WtcUtil.repNull(request.getParameter("agentSkill")),128,"9");
	String userType = formatStr(WtcUtil.repNull(request.getParameter("userType")),10,"30");
	String servicecity = "";
	String class_id = formatStr(WtcUtil.repNull(request.getParameter("class_id")),100,"9");
	String org_id = formatStr(WtcUtil.repNull(request.getParameter("org_id")),5,"9");
	String duty = formatStr(WtcUtil.repNull(request.getParameter("duty")),5,"9");
	String lang_code = formatStr(WtcUtil.repNull(request.getParameter("lang_code")),5,"9");
	if(!lang_code.equals("1")&&!lang_code.equals("2")){
			lang_code = "1";
	}
	String kf_name = formatStr(WtcUtil.repNull((String)session.getAttribute("workName")),20,"9");	
	String accept_phone="";
	String acceptid="0";
	if(outFlag.equals("2")){
	  accept_phone=called;
	  acceptid="7";
	  acceptid=formatStr(acceptid,5,"9");
	 }	
	else{
		if(outFlag.equals("3")){
		   acceptid="9";
		 }
		 if(outFlag.equals("4")){
		   acceptid="15";
		 }
		accept_phone=caller;
		}
	accept_phone = formatStr(accept_phone,20,"9");
	String telNum;
	if(opCode.equals("K025"))	
	{
	telNum=called;
	}
	else
	{
	telNum=caller;
	}

	//modify by fangyuan 改变来电信息中主、被叫显示逻辑 20090501 开始
	if(opCode.equals("K025"))	
	{
		String temp = caller;
		caller = called;
		called = temp;
	}

	
	String cust_name       = "";
	String contact_phone   = "";
	String contact_address = "";
	String sm_code         = "";
	String grade_code	     = "";
	String region_code	   = "";
    String fav_brand= "";
    
    
        
        
%>
<%
// 增加本地region_code的查询
	String called_region_code = "";//客户归属区号
	//获取被叫(如:100860351)的后4位,保存客户归属 by libin 2009/04/27
	if(called !=null && called.length() >= 9){
		called_region_code = called.substring(5,9);
	}
	called_region_code = formatStr(called_region_code,5,"9");
	
%>

<wtc:service name="sKFComering" outnum="7">
	<wtc:param value="<%=telNum%>"/>
</wtc:service>
<wtc:array id="rows" scope="end"/>
<%
  if(retCode.equals("000000"))
  {
		cust_name      = formatStr(rows[0][0],80,"9");
		contact_phone  = formatStr(rows[0][1],80,"9");
		contact_address= formatStr(rows[0][2],200,"9");
		sm_code        = rows[0][3];
		grade_code	   = formatStr(rows[0][4],5,"9");
		region_code	   = formatStr(rows[0][5],5,"9");
                fav_brand      = rows[0][6];
  }
  	//没有品牌时变为他网用户tancf
		if(sm_code==null||sm_code.equals(""))
		{
		sm_code="tw";
		}
		sm_code = formatStr(sm_code,5,"9");
		//jiangbing 20091116 增加记录客户级别
		if("".equals(userType)){
			if(sm_code.equals("zn")||sm_code.equals("z0"))
			{//神州行
		  		userType="30";
			}
			else if(sm_code.equals("dn"))
			{//动感地带
		  		userType="40";
			}
			else if(sm_code.equals("gn"))
			{//全球通
		  		userType="50";
			}
			else if(sm_code.equals("hl")||sm_code.equals("np")||sm_code.equals("j1"))
			{//集团
		  		userType="55";
			}
			else
			{
				userType="30";
			}
			/*
				if(sm_code.equals("dn")){
		  		userType="70";
				}else if(sm_code.equals("z0")){
		  		userType="50";
				}else if(sm_code.equals("gn")){
		 			userType="80";
				}else if(sm_code.equals("cb")){
		 			userType="40";
				}else if(sm_code.equals("hn")){
		 			userType="60";
				}else {
					userType="30";
  			}	
  			*/
		}
		//jiangbing 20090721 外呼设置城市代码
		String[][] city_to_code ={
			{"01","0451"},
			{"02","0467"},
			{"03","0464"},
			{"04","0469"},
			{"05","0468"},
			{"06","0454"},
			{"07","0453"},
			{"08","0452"},
			{"09","0457"},
			{"10","0455"},
			{"11","0456"},
			{"12","0458"},
			{"13","0459"},
			{"15","888"},
			{"","00"}
			};
		if("".equals(called_region_code)){
				for(int i=0;i<city_to_code.length;i++){
						if(city_to_code[i][0].equals(region_code)){
								called_region_code = city_to_code[i][1];
								break;
						}
				}
		}


  
    String timemer =(String)KFEjbClient.queryForObject("getSysdate");
		dcallcallyyyymm.setCallee_phone(called);
		dcallcallyyyymm.setCaller_phone(caller);
		dcallcallyyyymm.setCust_name(cust_name);
		dcallcallyyyymm.setSm_code(sm_code);
		dcallcallyyyymm.setGrade_code(grade_code);
		dcallcallyyyymm.setRegion_code(region_code);
		dcallcallyyyymm.setContact_phone(contact_phone);
		dcallcallyyyymm.setContact_address(contact_address);
		dcallcallyyyymm.setAccept_phone(accept_phone);
		dcallcallyyyymm.setAccept_login_no(login_no);
		dcallcallyyyymm.setLang_code(lang_code);
		dcallcallyyyymm.setAcceptid(acceptid);
		dcallcallyyyymm.setOp_code(opCode);	
		dcallcallyyyymm.setAccept_kf_login_no(workNo);
		dcallcallyyyymm.setSkill_quence(agentSkill);
		if("".equals(region_code))
		{
		dcallcallyyyymm.setStaffcity("01");
		}
		else
		{
		dcallcallyyyymm.setStaffcity(region_code);
		}
		if("00".equals(called_region_code))
		{
		dcallcallyyyymm.setServicecity("0451");	
		}
		else
		{
		dcallcallyyyymm.setServicecity(called_region_code);	
		}
    	dcallcallyyyymm.setBegin_date(timemer);	
    	dcallcallyyyymm.setEnd_date(timemer);
    	dcallcallyyyymm.setCheckpsnum("0");		
    	dcallcallyyyymm.setUsertype(userType);	
    	KFEjbClient.insert("insertDcallcall",dcallcallyyyymm);
		
	out.print("000000|"+grade_code+"|"+fav_brand);

%>
