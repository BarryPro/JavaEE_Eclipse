<%
/********************
 version v2.0
 开发商: si-tech
 update by liutong @ 2008.09.03
 update by qidp @ 2009-08-18 for 兼容端到端流程
********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="import java.sql.*"%>
<%@ page import="java.text.*" %>

<%

     String total_date,login_accept="0";
 	/*--------------------------*/
	String custId = request.getParameter("custId"); 
	System.out.println("-----------custId----------------"+custId);
	String regionCode = request.getParameter("regionCode"); 
	String workno = (String)session.getAttribute("workNo");
	String belongCode = (String)session.getAttribute("orgCode");
	belongCode = belongCode.substring(0,7);

	String regionId = request.getParameter("regionCode") + request.getParameter("districtCode") + "999"; 
	
	String custName = request.getParameter("custName"); 
	System.out.println("-----------custName----------------"+custName);
	String custPwd = WtcUtil.repStr(request.getParameter("custPwd")," "); 
	System.out.println("-----------custPwd----------------"+custPwd);
	custPwd=Encrypt.encrypt(custPwd);
	String custStatus = request.getParameter("custStatus"); 
	System.out.println("-----------custStatus----------------"+custStatus);
	String custGrade = WtcUtil.repStr(request.getParameter("custGrade"),"00"); 
	System.out.println("-----------custGrade----------------"+custGrade);
	String ownerType = request.getParameter("ownerType"); 
	System.out.println("-----------ownerType----------------"+ownerType);
	String custAddr = WtcUtil.repNull(request.getParameter("custAddr")); 
	System.out.println("-----------custAddr----------------"+custAddr);
	String idType = request.getParameter("idType");
	System.out.println("-----------idType----------------"+idType);
	if(idType.indexOf("|")!=-1)
		idType = idType.substring(0,idType.indexOf("|"));    //证件类型：0-身份证
		
	System.out.println("-----------idType----------------"+idType);
	String idIccid = request.getParameter("idIccid"); 
	System.out.println("-----------idIccid----------------"+idIccid);
	String idAddr = request.getParameter("idAddr"); 
	System.out.println("-----------idAddr----------------"+idAddr);
	String idValidDate = WtcUtil.repStr(request.getParameter("idValidDate")," "); 
	System.out.println("-----------idValidDate----------------"+idValidDate);
	if(idValidDate.trim().compareTo("")==0)
	{	  
 
		Calendar cc = Calendar.getInstance();
            cc.setTime(new java.util.Date());
            cc.add(Calendar.YEAR, 10);
            java.util.Date _tempDate = cc.getTime();
            idValidDate = new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(_tempDate);
	}
	
	String contactPerson = request.getParameter("contactPerson"); 
	System.out.println("-----------contactPerson----------------"+contactPerson);
	String contactPhone = request.getParameter("contactPhone"); 
	System.out.println("-----------contactPhone----------------"+contactPhone);
	String contactAddr = request.getParameter("contactAddr"); 
	System.out.println("-----------contactAddr----------------"+contactAddr);
	String contactPost = request.getParameter("contactPost");
	System.out.println("-----------contactPost----------------"+contactPost);
	if(contactPost.compareTo("")==0)
	{	contactPost = " ";	}
	String contactMAddr = request.getParameter("contactMAddr"); 	
	System.out.println("-----------contactMAddr----------------"+contactMAddr);
	String contactFax = request.getParameter("contactFax"); 
	System.out.println("-----------contactFax----------------"+contactFax);
	if(contactFax.compareTo("")==0)
	{	contactFax = " ";	}	
	String contactMail = request.getParameter("contactMail"); 
	System.out.println("-----------contactMail----------------"+contactMail);
	if(contactMail.compareTo("")==0)
	{	contactMail = " ";	}
	String unitCode = request.getParameter("unitCode"); //机构代码
	System.out.println("-----------unitCode----------------"+unitCode);
	String parentId = request.getParameter("parentId"); 
	System.out.println("-----------parentId----------------"+parentId);
	if(parentId.compareTo("") == 0)
	{   parentId = custId;          	}
	String custSex = request.getParameter("custSex");  	//客户性别
	System.out.println("-----------custSex----------------"+custSex);
	String birthDay = WtcUtil.repStr(request.getParameter("birthDay")," "); //出生日期
	System.out.println("-----------birthDay----------------"+birthDay);
	if(birthDay.trim().compareTo("") == 0)
	{
 	  if(idIccid.trim().length()==15 && idType.equals("0")) 
		birthDay="19"+idIccid.substring(6,8)+idIccid.substring(8,12);
	  else if(idIccid.trim().length()==18 && idType.equals("0")) 
        birthDay=idIccid.substring(6,10)+idIccid.substring(10,14);
	  else
        birthDay="19491001";
	} 
	String professionId = request.getParameter("professionId"); 
	System.out.println("-----------professionId----------------"+professionId);
	String vudyXl = request.getParameter("vudyXl"); //学历
	System.out.println("-----------vudyXl----------------"+vudyXl);
	String custAh = request.getParameter("custAh"); //客户爱好 
	System.out.println("-----------custAh----------------"+custAh);
	if(custAh.length() == 0)
	{	custAh = "无";	}
	String custXg = request.getParameter("custXg"); //客户习惯
	System.out.println("-----------custXg----------------"+custXg);
	if(custXg.compareTo("") == 0)
	{	custXg = "无";	}
	String unitXz = request.getParameter("unitXz"); //集团规模等级
	System.out.println("-----------unitXz----------------"+unitXz);
	String yzlx = request.getParameter("yzlx"); //执照类型//后台未用到,所以利用其传送策反集团标志
	System.out.println("-----------yzlx----------------"+yzlx);
	String yzhm = request.getParameter("yzhm"); //执照号码
	System.out.println("-----------yzhm----------------"+yzhm);
	String yzrq = request.getParameter("yzrq"); //执照有效期
	System.out.println("-----------yzrq----------------"+yzrq);
	String frdm = request.getParameter("frdm"); //法人代码
	System.out.println("-----------frdm----------------"+frdm);
	String groupCharacter = WtcUtil.repStr(request.getParameter("groupCharacter"),"无");//群组信息
	System.out.println("-----------groupCharacter----------------"+groupCharacter);
	String opCode = "1100";
	workno = request.getParameter("workno");	
	System.out.println("-----------workno----------------"+workno);
	String sysNote = request.getParameter("sysNote"); 
	System.out.println("-----------sysNote----------------"+sysNote);
	String opNote = request.getParameter("opNote"); 
	System.out.println("-----------opNote----------------"+opNote);
	String ip_Addr = request.getParameter("ip_Addr"); 
	System.out.println("-----------ip_Addr----------------"+ip_Addr);
	String oriGrpNo=WtcUtil.repStr(request.getParameter("oriGrpNo"),"0");
	System.out.println("-----------oriGrpNo----------------"+oriGrpNo);
	
	/*luxc 20080326 add*/
	if("02".equals(ownerType)||"03".equals(ownerType)||"04".equals(ownerType))
	{
		String instigate_flag	= request.getParameter("instigate_flag");
		String getcontract_flag	= request.getParameter("getcontract_flag");
		if("null".equals(getcontract_flag))
		{
			getcontract_flag="N";
		}
		yzlx=instigate_flag+getcontract_flag;
		System.out.println("luxc:instigate_flag="+instigate_flag+"|getcontract_flag="+getcontract_flag);
		System.out.println("luxc:yzlx="+yzlx);
	}
	
	
	String work_flow_no = request.getParameter("WORK_FLOW_NO");//工单号，传入购物车到开户调用服务
	String transJf      = request.getParameter("transJf");//转移积分，传入购物车到开户调用服务
	String transXyd     = request.getParameter("transXyd");//转移信誉度，传入购物车到开户调用服务
	
			System.out.println("************************************************************************************************8");
			System.out.println("--------------------login_accept------------------------------"+login_accept);
			System.out.println("--------------------custId------------------------------------"+custId);
			System.out.println("--------------------belongCode----------------------------------"+belongCode);
			System.out.println("--------------------custName----------------------------------"+custName);
			System.out.println("--------------------custPwd-----------------------------------"+custPwd);
			System.out.println("--------------------custStatus--------------------------------"+custStatus);
			System.out.println("--------------------custGrade---------------------------------"+custGrade);
			System.out.println("--------------------ownerType---------------------------------"+ownerType);
			System.out.println("--------------------custAddr----------------------------------"+custAddr);
			System.out.println("--------------------idType------------------------------------"+idType);
			System.out.println("--------------------idIccid-----------------------------------"+idIccid);
			System.out.println("--------------------idAddr------------------------------------"+idAddr);
			System.out.println("--------------------idValidDate-------------------------------"+idValidDate);
			System.out.println("--------------------contactPerson-----------------------------"+contactPerson);
			System.out.println("--------------------contactPhone------------------------------"+contactPhone);
			System.out.println("--------------------contactAddr-------------------------------"+contactAddr);
			System.out.println("--------------------contactPost-------------------------------"+contactPost);
			System.out.println("--------------------contactMAddr------------------------------"+contactMAddr);
			System.out.println("--------------------contactFax--------------------------------"+contactFax);
			System.out.println("--------------------contactMail-------------------------------"+contactMail);
			System.out.println("--------------------unitCode----------------------------------"+unitCode);	
			System.out.println("--------------------parentId----------------------------------"+parentId);
			System.out.println("--------------------custSex-----------------------------------"+custSex);
			System.out.println("--------------------birthDay----------------------------------"+birthDay);
			System.out.println("--------------------professionId------------------------------"+professionId);
			System.out.println("--------------------vudyXl------------------------------------"+vudyXl);
			System.out.println("--------------------custAh------------------------------------"+custAh);	
			System.out.println("--------------------custXg------------------------------------"+custXg);
			System.out.println("--------------------unitXz------------------------------------"+unitXz);
			System.out.println("--------------------yzlx--------------------------------------"+yzlx);
			System.out.println("--------------------yzhm--------------------------------------"+yzhm);
			System.out.println("--------------------yzrq--------------------------------------"+yzrq);
			System.out.println("--------------------frdm--------------------------------------"+frdm);
			System.out.println("--------------------groupCharacter----------------------------"+groupCharacter);
			System.out.println("--------------------opCode------------------------------------"+opCode);
			System.out.println("--------------------workno------------------------------------"+workno);
			System.out.println("--------------------sysNote-----------------------------------"+sysNote);
			System.out.println("--------------------opNote------------------------------------"+opNote);
			System.out.println("--------------------ip_Addr-----------------------------------"+ip_Addr);
			System.out.println("--------------------oriGrpNo----------------------------------"+oriGrpNo);   
			System.out.println("************************************************************************************************8");
			
			if(idType.length()>1)
				idType = idType.substring(0,1);
				
			System.out.println("--------------------idType----------------------------------"+idType);   	
%>


<wtc:service name="s1100Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code" retmsg="retMessage"  outnum="4" >
					    <wtc:param value="<%=login_accept%>"/>
			        <wtc:param value="<%=custId%>"/>
			        <wtc:param value="<%=belongCode%>"/>
			        <wtc:param value="<%=custName%>"/>
			        <wtc:param value="<%=custPwd%>"/>
			        <wtc:param value="<%=custStatus%>"/>
			        <wtc:param value="<%=custGrade%>"/>
			        <wtc:param value="<%=ownerType%>"/>         
			        <wtc:param value="<%=custAddr%>"/>
			        <wtc:param value="<%=idType%>"/>
			        <wtc:param value="<%=idIccid%>"/>
			        <wtc:param value="<%=idAddr%>"/>
			        <wtc:param value="<%=idValidDate%>"/>
			        <wtc:param value="<%=contactPerson%>"/>
			        <wtc:param value="<%=contactPhone%>"/>
			        <wtc:param value="<%=contactAddr%>"/>
			        <wtc:param value="<%=contactPost%>"/>
			        <wtc:param value="<%=contactMAddr%>"/>
			        <wtc:param value="<%=contactFax%>"/>
			        <wtc:param value="<%=contactMail%>"/>
			        <wtc:param value="<%=unitCode%>"/>	
			        <wtc:param value="<%=parentId%>"/>
			        <wtc:param value="<%=custSex%>"/>
			        <wtc:param value="<%=birthDay%>"/>
			        <wtc:param value="<%=professionId%>"/>
			        <wtc:param value="<%=vudyXl%>"/>
			        <wtc:param value="<%=custAh%>"/>	
			        <wtc:param value="<%=custXg%>"/>
			        <wtc:param value="<%=unitXz%>"/>
			        <wtc:param value="<%=yzlx%>"/>
			        <wtc:param value="<%=yzhm%>"/>
			        <wtc:param value="<%=yzrq%>"/>
			        <wtc:param value="<%=frdm%>"/>
			        <wtc:param value="<%=groupCharacter%>"/>
			        <wtc:param value="<%=opCode%>"/>
			        <wtc:param value="<%=workno%>"/>
			        <wtc:param value="<%=sysNote%>"/>
			        <wtc:param value="<%=opNote%>"/>
			        <wtc:param value="<%=ip_Addr%>"/>
			        <wtc:param value="<%=oriGrpNo%>"/>
			</wtc:service>
			<wtc:array id="result" scope="end" />

<%
	System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
	
	System.out.println("------------ret_code----------------------"+ret_code);
	System.out.println("------------retMessage--------------------"+retMessage);
	String retCodeForCntt = ret_code ;
  String retMsgForCntt =retMessage;
	String loginAccept =login_accept; 
	String opName = "客户开户";
	String unit_id = "";
	
	if(ret_code.equals("0")||ret_code.equals("000000")){
		if(result.length>0){
			loginAccept=result[0][2];
			unit_id = result[0][3];
		}
	}
	System.out.println("# unit_id = "+unit_id);
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCodeForCntt+"&retMsgForCntt="+retMsgForCntt+"&opName="+opName+"&workNo="+workno+"&loginAccept="+loginAccept+"&pageActivePhone=&opBeginTime="+opBeginTime+"&contactId="+custId+"&contactType=cust";
	System.out.println("url="+url);
		
	%>
	<jsp:include page="<%=url%>" flush="true" />
		
	<script src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/redialog/redialog.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/autocomplete.js"  type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/common.js"  type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/framework2.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/framework_extend.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/tabScript_jsa.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js" type="text/javascript" ></script>
	<script src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/si/validate_pack.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/extend/mztree/MzTreeView12.js" type="text/javascript"></script>
	
	<%
		if((ret_code.trim()).compareTo("000000") == 0)
		{
  %>
            <script language="JavaScript">
                rdShowMessageDialog("客户开户操作成功！",2);
                var cusId = "<%=custId%>";
  							var custName = "<%=custName%>";
  							
  							var work_flow_no = "<%=work_flow_no%>";
								var	transJf      = "<%=transJf%>"; 
								var	transXyd     = "<%=transXyd%>";
								
								if(transJf=="") transJf = "0";
								if(transXyd=="") transXyd = "0";
								
  							openCustMain(cusId,custName,'',custName);
									  
									  function openCustMain(custId,custName,loginType,phone_no)
											{
											    iCustId = custId;
											    loginType = "open4603§"+work_flow_no+"§"+transJf+"§"+transXyd;
												if($("#contentArea iframe").size() < 11){
													parent.addTab(true,"custid"+custId,custName,'childTab2.jsp?gCustId='+custId+'&loginType='+loginType+'&phone_no='+phone_no+'&activePhone='+phone_no);
													parent.removeTab("4603");
													$("#phoneNo").val("请输入信息进行查询");
												}else{
													rdShowMessageDialog("只能打开10个一级tab");
												}
											}
										 
            </script>            
<%		
        }else
        {
%>
            <script language="JavaScript">
                rdShowMessageDialog("<%=retMessage%>" + "[" + "<%=ret_code%>" + "]");
                history.go(-1);
            </script>
<%
        }
%>
