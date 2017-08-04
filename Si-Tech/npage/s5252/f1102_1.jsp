 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-04 页面改造,修改样式
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>

<%  
	String opCode = "5252";	
	String opName = "帐户开户";	//header.jsp需要的参数   
	
		//ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
 	//S1100View callView = new S1100View();   
 	String printAccept = ""; 
%>
<%
	String workNo = (String)session.getAttribute("workNo");    //工号 
	String loginPwd    = (String)session.getAttribute("password"); //工号密码
	String workName =(String)session.getAttribute("workName");//工号名称  	   
	String regionCode = (String)session.getAttribute("regCode");  
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String Department = (String)session.getAttribute("orgCode");
	String belongCode = Department.substring(0,7);
	
        String rowNum = "1000";        
	String agentPaper = "";	
	if(request.getParameter("agentPaper")!=null){
		System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
		agentPaper = request.getParameter("agentPaper");
	}
	
	
%>

    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>

	<HEAD>
		<TITLE>帐户开户 </TITLE>			
		<script type="text/javascript">

		onload=function()
		{
		   
		    document.all.idIccid.focus();		
			if(typeof(frm1102.accountId)!="undefined") 
			{	if(frm1102.accountId.value != "")            ////恢复到提交前的获得帐户ID按钮显示状态
				{	frm1102.accountIdQuery.disabled = true; }
			}		
			//core.rpc.onreceive = doProcess;	
		}
		//---------1------RPC处理函数------------------
		function doProcess(packet)
		{	
		    //RPC处理函数findValueByName
		    var retType = packet.data.findValueByName("retType");
		    var retCode = packet.data.findValueByName("retCode"); 
		    var retMessage = packet.data.findValueByName("retMessage");	
		    self.status="";
		    
		    var msg = packet.data.findValueByName("msg");
			   if(retType == "AccountId")
				 {
			        var retnewId = packet.data.findValueByName("retnewId");
			    	if(retCode=="000000")
			    	{
			       		//document.all.accountName.focus();			 		
			    	    document.frm1102.accountId.value = retnewId;
				        document.frm1102.accountIdQuery.disabled = true; 		    	 
			    	}
			    	else
			    	{
			    	    retMessage = retMessage + "[errorCode1:" + retCode + "]";
			    		rdShowMessageDialog(retMessage,0);
						return false;
			    	}	
				 }
		    //-----------------------------------------
		    if(retType == undefined)
		    {
		        //进行密码校验
		      var retResult = packet.data.findValueByName("retResult");
		      if(retResult!="000000"){
		      	frm1102.checkPwd_Flag.value = false;
		      }else{
		      	frm1102.checkPwd_Flag.value = true;
		      } 
			    //frm1102.checkPwd_Flag.value = retResult; 
			    if(frm1102.checkPwd_Flag.value == "false")
			    {
			    	rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
			    	frm1102.custPwd.value = "";
			    	frm1102.custPwd.focus();
			    	frm1102.checkPwd_Flag.value = "false";	    	
			    	return false;	        	
			    }		
				else
					{
			 		   rdShowMessageDialog("客户密码校验成功！",2);
			 		   frm1102.newPwd.value=frm1102.custPwd.value;
			   		 frm1102.cfmPwd.value=frm1102.custPwd.value;
					   document.all.accountIdQuery.disabled=false;	      
					}
		
		    }
			//------------------------------------
			if(retType == "getInfo_withID")
			{
			    clear_CustInfo();
			    if(retCode == "000000") {
			        var retInfo = packet.data.findValueByName("retInfo");
			        
			        if(retInfo != "") {
			            for(var i = 0; i < 7; i ++){
                            document.all('in' + i).value = retInfo[0][i];
			            }
			        }
			    }else {
			        retMessage = retMessage + "[errorCode2:" + retCode + "]";
		    		rdShowMessageDialog(retMessage,0);
					return false;
			    }
			}
			if(retType=="chkX")
			{
		        var retObj = packet.data.findValueByName("retObj");
		
				if(retCode == "000000")
		        {
		         // document.all.print.disabled=false;
				}
		        else
		        {
		             retMessage = "错误" + retCode + "："+retMessage;			 
		             rdShowMessageDialog(retMessage,0);
					 document.all.print.disabled=true;
					 document.all(retObj).focus();
					 return false;
		        }
			}
		   
		   /*
		   //-----------------------------------
		   if(retType == "AccountId")
			{
		       var retnewId = packet.data.findValueByName("retnewId");
		    	if(retCode=="000000")
		    	{
		       		//document.all.accountName.focus();			 		
		    	    document.frm1102.accountId.value = retnewId;
			        document.frm1102.accountIdQuery.disabled = true; 		    	 
		    	}
		    	else
		    	{
		    	    retMessage = retMessage + "[errorCode1:" + retCode + "]";
		    		rdShowMessageDialog(retMessage,0);
					return false;
		    	}	
			}
		  //-----------------------------------
		  if(retType == "getInfo_withID")
			{
			    clear_CustInfo();
			    if(retCode == "000000") {
			        var retInfo = packet.data.findValueByName("retInfo");
			        
			        if(retInfo != "") {
			            for(var i = 0; i < 7; i ++){
                            document.all('in' + i).value = retInfo[0][i];
			            }
			        }
			    }else {
			        retMessage = retMessage + "[errorCode2:" + retCode + "]";
		    		rdShowMessageDialog(retMessage,0);
					return false;
			    }
			}
			//-----------------------------------
			if(retType=="chkX")
			{
		        var retObj = packet.data.findValueByName("retObj");
		
				if(retCode == "000000")
		        {
		         // document.all.print.disabled=false;
				}
		        else
		        {
		             retMessage = "错误" + retCode + "："+retMessage;			 
		             rdShowMessageDialog(retMessage,0);
					 document.all.print.disabled=true;
					 document.all(retObj).focus();
					 return false;
		        }
			} 
			
			//----------------------------
				if(retType == undefined)
		    {
		    	alert("校验密码");
		        //进行密码校验
		      var retResult = packet.data.findValueByName("retResult");
		      alert(retResult);
			   	frm1102.checkPwd_Flag.value = retResult; 
			    if(frm1102.checkPwd_Flag.value == "false")
			    {
			    	rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
			    	frm1102.custPwd.value = "";
			    	frm1102.custPwd.focus();
			    	frm1102.checkPwd_Flag.value = "false";	    	
			    	return false;	        	
			    }else{
		 		   rdShowMessageDialog("客户密码校验成功！",2);
		 		   frm1102.newPwd.value=frm1102.custPwd.value;
		   		 frm1102.cfmPwd.value=frm1102.custPwd.value;
				   document.all.accountIdQuery.disabled=false;	      
				 }
			}
			*/
		   
		   /*
			if(retCode=="")
			{
		       rdShowMessageDialog("调用"+retType+"服务时失败！",0);
		       return false;
			}
			if(msg!="" || msg !="undefined" || msg !=null || msg !=" "){
					rdShowMessageDialog(msg,0);
					return false;	
			}
			*/
		}
		
		//--------------------------------------------
		//清空上级客户信息
		function clear_CustInfo()
		{
		        for(i=0;i<6;i++)
		        {          
		                var obj = "in" + i;
		                document.all(obj).value = "";
		        }
		}
		//-----------------------------------------------------		
		function choiceSelWay()
		{	//选择客户信息的查询方式			
			if(frm1102.custId.value != "")
			{	//按客户ID进行查询
				getInfo_withId();	
				return true;
			}
			 document.all.accountIdQuery2.disabled=false;
			if(frm1102.idIccid.value != "")
			{	
				getInfo_IccId();
				return true;
			}
			if(frm1102.custName.value != "")
			{	
				getInfo_withName();
				return true;
			}
			
			rdShowMessageDialog("客户信息可以以ID、证件号码或名称进行查询，请输入其中任意项作为查询条件！",0);
			 
		}
				//-----------------------------------------------------
		function getInfo_withId()
		{
			
		    //根据客户ID得到相关信息
		    
		    if(document.frm1102.custId.value == "")
		    {
		        rdShowMessageDialog("请输入客户ID！",0);
		        return false;
		    }
		    if(forNonNegInt(frm1102.custId) == false)
		    {	
		    	frm1102.custId.value = "";
		    	return false;	
		    }    
		    
		    var custId =  document.frm1102.custId.value;
		    
		    var getIdPacket = new AJAXPacket("f5252_ajax_1.jsp", "正在获得客户信息，请稍候...");
			getIdPacket.data.add("retType","getInfo_withID");
			getIdPacket.data.add("serviceName","sCustTypeQry");
			getIdPacket.data.add("outnum","7");
			getIdPacket.data.add("inputParamsLength","8");
			
			getIdPacket.data.add("inParams0","<%=loginAccept%>");
			getIdPacket.data.add("inParams1","01");
			getIdPacket.data.add("inParams2","<%=opCode%>");
			getIdPacket.data.add("inParams3","<%=workNo%>");
			getIdPacket.data.add("inParams4","<%=loginPwd%>");
			getIdPacket.data.add("inParams5","");
			getIdPacket.data.add("inParams6","");
			getIdPacket.data.add("inParams7",custId);
			/**
			getIdPacket.data.add("sqlStr","select to_char(a.CUST_ID),a.CUST_PASSWD,a.ID_ICCID,b.ID_NAME,a.CUST_NAME," +
			            " a.CUST_ADDRESS,a.REGION_CODE||a.DISTRICT_CODE||a.TOWN_CODE" + 
			            " from DCUSTDOC a,SIDTYPE b where a.CUST_ID=" + custId
		                + " and b.ID_TYPE = a.ID_TYPE and rownum<500 ");
		    */
			core.ajax.sendPacket(getIdPacket);
			getIdPacket=null;
		} 
		
		//-----------------------------------------------------
		/*
		    参数1(pageTitle)：查询页面标题
		    参数2(fieldName)：列中文名称，以'|'分隔的串
		    参数3(sqlStr)：sql语句
		    参数4(selType)：类型1 rediobutton 2 checkbox
		    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
		    参数6(retToField))：返回值存放域的名称,以'|'分隔
		*/
	
		//-------------------------------------------------
		function getInfo_withName()
		{ 
		  
		  	if(document.frm1102.custName.value == "")
		    {
		        rdShowMessageDialog("请输入客户名称！",0);
		        return false;
		    }
		    /**
		    var pageTitle = "客户信息查询";
		    var fieldName = "客户ID|客户名称|开户时间|证件类型|证件号码|客户地址|归属代码|客户密码|";
		    var sqlStr = "select to_char(a.CUST_ID),a.CUST_NAME,to_char(a.CREATE_TIME,'YYYY-MM-DD HH24:MI:SS'),b.ID_NAME,a.ID_ICCID," +
			             " a.CUST_ADDRESS,a.REGION_CODE||a.DISTRICT_CODE||a.TOWN_CODE,a.CUST_PASSWD" + 
			             " from DCUSTDOC a,SIDTYPE b where " +
			             " a.CUST_NAME like '" + document.frm1102.custName.value + "%' and b.ID_TYPE = a.ID_TYPE  and rownum<500 order by a.cust_name asc,a.create_time desc ";
		    var selType = "S";              //'S'单选；'M'多选
		    var retQuence = "7| 0|  1|  3|  4|  5|  6|  7|";
		    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
		    */
		    var path = "selectCustMsg.jsp";
		    path = path + "?custName=" + document.frm1102.custName.value;
		    
		    custInfoQueryAdd(path);     	       	   
		}
		
		function custInfoQueryAdd(path){
		    retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");
		    
		    if(typeof(retInfo) == "undefined") {
		        return false;
		    }
		    
	        document.all('in0').value = retInfo.in0;
	        document.all('in4').value = retInfo.in1;
	        document.all('in3').value = retInfo.in3;
	        document.all('in2').value = retInfo.in4;
	        document.all('in5').value = retInfo.in5;
	        document.all('in6').value = retInfo.in6;
	        document.all('in1').value = retInfo.in7;
	        
			document.all.accountName.value = retInfo.in1;
			
			rpc_chkX("idType","idIccid","A");
		}
		
		//-----------------------------------------------------
		function custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
		{
		    /*
		    参数1(pageTitle)：查询页面标题
		    参数2(fieldName)：列中文名称，以'|'分隔的串
		    参数3(sqlStr)：sql语句
		    参数4(selType)：类型1 rediobutton 2 checkbox
		    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
		    参数6(retToField))：返回值存放域的名称,以'|'分隔
		    */
		    //var path = "/npage/public/fPubSimpSel.jsp";   //密码显示
		    var path = "/npage/innet/pubGetCustInfo.jsp";   //密码为*
		    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
		    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
		    path = path + "&selType=" + selType;  
		   
		    retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");
		    if(typeof(retInfo) == "undefined")     
		    {   return false;   }
		    var chPos_field = retToField.indexOf("|");
		    var chPos_retStr;
		    var valueStr;
		    var obj;
		    while(chPos_field > -1)
		    {
		        obj = retToField.substring(0,chPos_field);
		        chPos_retInfo = retInfo.indexOf("|");
		        valueStr = retInfo.substring(0,chPos_retInfo);
		        document.all(obj).value = valueStr;
				if(obj=="in4")
				  document.all.accountName.value=valueStr;
		        retToField = retToField.substring(chPos_field + 1);
		        retInfo = retInfo.substring(chPos_retInfo + 1);
		        chPos_field = retToField.indexOf("|");        
		    }
			rpc_chkX("idType","idIccid","A");
		}
		//-------------------------------------------------
		function getInfo_IccId()
		{ 
		  	//根据客户证件号码得到相关信息
		  	if((document.frm1102.idIccid.value.trim()).length == 0)
		    {
		        rdShowMessageDialog("请输入客户证件号码！",0);
		        return false;
		    }
			else if((document.frm1102.idIccid.value.trim()).length < 5)
			{
		        rdShowMessageDialog("证件号码长度有误（最少五位）！",0);
		        return false;
			}
			/**
		    var pageTitle = "客户信息查询";
		    var fieldName = "客户ID|客户名称|开户时间|证件类型|证件号码|客户地址|归属代码|客户密码|";
		    var sqlStr = "select to_char(a.CUST_ID),a.CUST_NAME,to_char(a.CREATE_TIME,'YYYY-MM-DD HH24:MI:SS'),b.ID_NAME,a.ID_ICCID," +
			             " a.CUST_ADDRESS,a.REGION_CODE||a.DISTRICT_CODE||a.TOWN_CODE,a.CUST_PASSWD" + 
			             " from DCUSTDOC a,SIDTYPE b where b.ID_TYPE = a.ID_TYPE " +
			             " and a.ID_ICCID = '" + document.frm1102.idIccid.value.trim() + "' and rownum<500 order by a.cust_name asc,a.create_time desc "; 
		    var selType = "S";    //'S'单选；'M'多选
		    var retQuence = "7|0|1|3|4|5|6|7|";
		    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
		    */
		     var path = "selectCustMsg.jsp";
		    path = path + "?iIdIccid=" + document.frm1102.idIccid.value.trim();
		    custInfoQueryAdd(path);    	       	   
		}
		
		//----------------------------------------------------------
		function printCommit()
		{   
			//if(encrypt(frm1102.custPwd.value) != frm1102.in1.value)
			/* if(frm1102.custPwd.value == "")
			{
				rdShowMessageDialog("请输入客户密码！",0);
				frm1102.custPwd.focus();
				return false;		
			} */
			if((frm1102.payCode.value).indexOf("托收") > 0)
			{
				if((frm1102.accountNo.value == "")||(frm1102.bankCode.value == "")||(frm1102.postCode.value == ""))
				{
					rdShowMessageDialog("托收相关的帐号、银行信息不能为空！",0);
					return false;
				}		
			}
			//
			if(check(frm1102))
			{
			    if((document.all.newPwd.value.trim()).length>0)
				{
				  if(document.all.newPwd.value.length!=6)
				  {
				    rdShowMessageDialog("帐户密码长度有误！",0);
				    document.all.custPwd.focus();
				    return false;
				  }
		          if(checkPwd(document.frm1102.newPwd,document.frm1102.cfmPwd)==false)
				  return false;
				}
		
		    	sysNote = "帐户开户:" + "客户ID[" + document.frm1102.custId.value + "]帐户ID[" +
		    	         document.frm1102.accountId.value + "]";
		    	         //":帐号[" + document.frm1102.accountNo.value + "]"; 
		    	document.frm1102.sysNote.value = sysNote;
				if((document.all.opNote.value.trim()).length==0)
					{
		              document.all.opNote.value="操作员[<%=workName%>]"+"对客户["+document.all.custName.value.trim()+"]进行帐户开户业务。"
					}
		    	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");    	    
		    }    
		}
		//---------------------------------------------------
		function getId()
		{
		    //得到帐户ID
		    var getAccountId_Packet = new AJAXPacket("/npage/innet/f1100_getId.jsp","正在获得帐户ID，请稍候......");
			getAccountId_Packet.data.add("region_code","<%=regionCode%>");
			getAccountId_Packet.data.add("retType","AccountId");
			getAccountId_Packet.data.add("idType","1");
			getAccountId_Packet.data.add("oldId","0");
			core.ajax.sendPacket(getAccountId_Packet);
			//delete(getAccountId_Packet);
			getAccountId_Packet=null;
			
			document.all.print.disabled=false;	
			
		}
		//----------------------------------
		function checkPwd(obj1,obj2)
		{
			//密码一致性校验
			var pwd1 = obj1.value;
			var pwd2 = obj2.value;
			if(pwd1 != pwd2)
			{
				var message = "'" + obj1.v_name + "'和'" + obj2.v_name + "'不一致，请重新输入！";
				rdShowMessageDialog(message,0);
				obj1.value = "";
				obj2.value = "";
				obj1.focus();
				return false;
			}
			return true;
		}
		//-----------------------------------
		function change_custPwd()
		{   //验证密码（密码）
		    check_HidPwd(frm1102.custPwd.value,"show",frm1102.in1.value.trim(),"hid");
		   	
		}
		//------------------------------------
		function check_HidPwd(Pwd1,Pwd1Type,Pwd2,Pwd2Type)
		{
			/*
		  		Pwd1,Pwd2:密码
		  		wd1Type:密码1的类型；Pwd2Type：密码2的类型      show:明码；hid：密码
		  	
			if((Pwd1.trim()).length==0)
			{
		        rdShowMessageDialog("客户密码不能为空！",0);
		        frm1102.custPwd.focus();
				return false;
			}
		    else 
			{
			   if((Pwd2.trim()).length==0)
			   {
		         rdShowMessageDialog("原始客户密码为空，请核对数据！",0);
		         frm1102.custPwd.focus();
				 return false;
			   }
			}*/
		
		  var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
		  
		  /*
		  checkPwd_Packet.data.add("retType","checkPwd");
			checkPwd_Packet.data.add("Pwd1",Pwd1);
			checkPwd_Packet.data.add("Pwd1Type",Pwd1Type);
			checkPwd_Packet.data.add("Pwd2",Pwd2);
			checkPwd_Packet.data.add("Pwd2Type",Pwd2Type);
			*/
			checkPwd_Packet.data.add("custType","02"); //01:用户密码校验 02 客户密码校验 03帐户密码校验
			checkPwd_Packet.data.add("phoneNo",frm1102.custId.value);  //移动号码,客户id,帐户id
			checkPwd_Packet.data.add("custPaswd",frm1102.custPwd.value);//用户/客户/帐户密码
			checkPwd_Packet.data.add("idType","cn");   //en 密码为密文，其它情况 密码为明文
			checkPwd_Packet.data.add("idNum","");       //传空
			checkPwd_Packet.data.add("loginNo","");			
		
			core.ajax.sendPacket(checkPwd_Packet);
			//delete(checkPwd_Packet);	
			checkPwd_Packet=null;	
		}
		//-------------------------------------
		function payWayChange()
		{
		    var payWay = document.frm1102.payCode.value;
		    var chPos = payWay.indexOf("托收");
		    var obj = "tbBank" + 0;
		    if(chPos > 0)
		    {
		        document.all(obj).style.display = "";
		    }
		    else
		    {
		        document.all(obj).style.display = "none";
		        frm1102.bankCode.value = "";
		        frm1102.postCode.value = "";
		    }
		}
		
		function getBankCode()
		{ 
		  	//调用公共js得到银行代码
		    var pageTitle = "银行代码查询";
		    var fieldName = "银行代码|银行名称";
		    var sqlStr = "select BANK_CODE,BANK_NAME from sBankCode " +
		                "where REGION_CODE = '" + document.frm1102.unitCode.value.substring(0,2) + "'" +
		                " and DISTRICT_CODE ='" + document.frm1102.unitCode.value.substring(2,4) + "'";
		    if(document.frm1102.bankName.value != "")
		    {
		        sqlStr = sqlStr + " and BANK_NAME like '%" + document.frm1102.bankName.value + "%'";
		    }
		    //sqlStr = sqlStr + " and rowNum <" + <%=rowNum%> ;  
		    var selType = "S";    //'S'单选；'M'多选
		    var retQuence = "0|1";
		    var retToField = "bankCode|bankName|";
		    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);        	       	   
		}
		
		function getPostCode()
		{ 
		  	//调用公共js得到银行代码
		    var pageTitle = "局方银行代码查询";
		    var fieldName = "银行代码|银行名称";
		    var sqlStr = "select POST_BANK_CODE,BANK_NAME from sPostCode " +
		                "where REGION_CODE = '" + document.frm1102.unitCode.value.substring(0,2) + "'";
		    if(document.frm1102.postName.value != "")
		    {
		        sqlStr = sqlStr + " and BANK_NAME like '%" + document.frm1102.postName.value + "%'";
		    }
		   // sqlStr = sqlStr + " and rowNum <" + <%=rowNum%> ;  
		    sqlStr = sqlStr + "  order by POST_BANK_CODE " ;
			var selType = "S";    //'S'单选；'M'多选
		    var retQuence = "0|1";
		    var retToField = "postCode|postName|";
		    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);   	       	   
		}
		 
		function jspReset()
		{
		        var obj = null;
		        var t = null;
		    	var i;   	
		        for (i=0;i<document.frm1102.length;i++)
		        {    
		    		obj = document.frm1102.elements[i];		 		 		 
		    		packUp(obj); 
		    	    obj.disabled = false;
		         }        
		        document.frm1102.commit.disabled = "none"; 
		}
		//打印信息---------------------------------------------------
		function printInfo(printType)
		{
		    var retInfo = "";
		    if(printType == "Detail")
		    {	
			<%
		        	//取得打印流水		        
			                String sqlStr ="select sMaxSysAccept.nextval as accept from dual";			              
		                %>
		                <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
					<wtc:sql><%=sqlStr%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result1" scope="end" />
		                <%
		                if(result1!=null&&result1.length>0){
					result = result1;					    		
				}		              
		                if(result!=null&&result.length>0){
		                	 printAccept = (result[0][0]).trim();
		                }else{%>
		                	<SCRIPT type=text/javascript>
						rdShowMessageDialog('取电子免填单打印流水失败！',0);
					</SCRIPT>
		                	
		                <%
		                }
		               
		                
		%>          
										
				//打印电子免填单	        	
			
				
				var cust_info=""; //客户信息
	      			var opr_info=""; //操作信息
	      			var retInfo = "";  //打印内容
	      			var note_info1=""; //备注1
	      			var note_info2=""; //备注2
	      			var note_info3=""; //备注3
	      			var note_info4=""; //备注4
	      						
				cust_info+="客户姓名：   "+frm1102.custName.value+"|";	      		         	
      		         	cust_info+="客户地址：   "+frm1102.custAddr.value+"|";
      		         	cust_info+="证件号码：   "+frm1102.idIccid.value+"|";
				cust_info+= "帐户ID：   "+frm1102.accountId.value+"|";
				cust_info+= "帐户名称：   "+frm1102.accountName.value+"|";
				cust_info+= "付款方式：   "+frm1102.payCode.value+"|";
				
				opr_info+= "打印流水：" + "<%=printAccept%>" + "|";				
				opr_info+= "帐户开户。*|";
				
				note_info1+="备注："+document.all.sysNote.value+"|";
				 retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	      			retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
    	      			return retInfo;	
		
			}  
		    if(printType == "Bill")
		    {	//打印发票
			}
			return retInfo;	
		}
		//-----------------------------------------------------
		function showPrtDlg(printType,DlgMessage,submitCfm)
		{  
			var pType="print";                     // 打印类型print 打印 subprint 合并打印
	     		var billType="1";                      //  票价类型1电子免填单、2发票、3收据
			var sysAccept ="<%=printAccept%>";                       // 流水号
			var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
			
			var mode_code=null;                        //资费代码
			var fav_code=null;                         //特服代码
			var area_code=null;                    //小区代码
			var opCode =   "<%=opCode%>";                         //操作代码
			var phoneNo = "";                           //客户电话	
		
			 //显示打印对话框 
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;	
			
			 var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
		   	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
			    //if(typeof(ret)!="undefined")
			   {
			       //if((ret=="confirm")&&(submitCfm == "Yes"))
			       {
				       if(rdShowConfirmDialog("确认要提交帐户开户信息吗？")==1)
				       {
					       frm1102.action="f1102_2.jsp";
					       frm1102.submit();
					   }
					}		        
		   }
		}
		
		function jspCommit()
		{
		 		document.frm1102.commit.disabled = "none";
				with(document.frm1102)
				{
						action="f1102_2.jsp"
						submit();
				}		
		}
		
		function rpc_chkX(x_type,x_no,chk_kind)
		{
		  var obj_type=document.all(x_type);
		  var obj_no=document.all(x_no);
		  var idname="";		  
		  if(obj_type.type=="text")
		  {		     
		    idname=obj_type.value.trim();
		  }
		  else if(obj_type.type=="select-one")
		  {		   
		    idname=obj_type.options[obj_type.selectedIndex].text.trim();  
		  }		  
		  if(obj_no.value.trim().length>0)
		  {
		    if(obj_no.value.trim().length<5)
			{
		      rdShowMessageDialog("证件号码长度有误（至少5位）！");
			  obj_no.focus();
		  	  return false;
			}
			else
			{
		      if(idname=="身份证")
			  {
		           //if(checkElement(x_no)==false) return false;
			  }
			}
		  }
		  else 
			return;
		
		  var myPacket = new AJAXPacket("/npage/innet/chkX.jsp","正在验证黑名单信息，请稍候......");
		  myPacket.data.add("retType","chkX");
		  myPacket.data.add("retObj",x_no);
		  myPacket.data.add("x_idType",getX_idno(idname));
		  myPacket.data.add("x_idNo",obj_no.value);
		  myPacket.data.add("x_chkKind",chk_kind);
		  core.ajax.sendPacket(myPacket);
		  myPacket=null;
		  //delete(myPacket);
		  
		}
		function getX_idno(xx)
		{
		  if(xx==null) return "0";		  
		  if(xx=="身份证") return "0";
		  else if(xx=="军官证") return "1";
		  else if(xx=="驾驶证") return "2";
		  else if(xx=="警官证") return "4";
		  else if(xx=="学生证") return "5";
		  else if(xx=="单位") return "6";
		  else if(xx=="校园") return "7";
		  else if(xx=="营业执照") return "8";
		  else return "0";
		}
		
		</script>		
	</HEAD>
 
<body>
<FORM method=post name="frm1102" action="f1102_2.jsp" onKeyUp="chgFocus(frm1102)">
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">帐户开户</div>
	</div>
     <table  cellspacing="0">
          <TBODY> 
                <TR> 
                  	<TD width="16%" class="blue"> 
                   		客户证件号码
                  	</TD>
                  	<TD width="34%"> 
                  		<input id="in2" name=idIccid readonly  Class="InputGrey" v_must=1 v_type="string"  onKeyup="if(event.keyCode==13)getInfo_IccId();" maxlength="20"  index="2">
                    		<font class="orange">*</font>		
                    		<input type="button" name=custIdQuery class="b_text"  onClick="choiceSelWay();"  style="cursor:hand" id="custIdQuery" value="客户查询">
                  	</TD>
                  	<TD width=16% class="blue"> 
                   		客户密码
                  	</TD>
                  	<TD width="34%"> 
				<jsp:include page="/npage/common/pwd_1.jsp">
			                <jsp:param name="width1" value="16%"  />
			                <jsp:param name="width2" value="34%"  />
			                <jsp:param name="pname" value="custPwd"  />
			                <jsp:param name="pwd" value="12345"  />
		 	        </jsp:include>				
	                    	<input name=accountIdQuery2 class="b_text" type=button onClick="change_custPwd();"  value="校验" disabled >
                  	</TD>
                </TR>
                <TR> 
                  	<TD class="blue"> 
                   		客户名称
                  	</TD>
                  	<TD> 
                  		<input id='in4'  name=custName onKeyup="if(event.keyCode==13)getInfo_withName();" maxlength="60" size=33>
                   		<font class="orange">*</font>
                   	</TD>
                       <td class="blue"> 
                   		客户证件类型
                  	</TD>
                  	<TD> 
                    		<input id='in3'  name=idType readonly Class="InputGrey">
                  	</TD>
                </TR>
                <TR> 
                  	<TD class="blue"> 
                   		客户ID
                  	</TD>
                  	<TD> 
                    		<input id='in0'  name=custId v_type=int v_must=1 onKeyup="if(event.keyCode==13)getInfo_withId();" maxlength="22">
                    		<font class="orange">*</font>
                    	</TD>
                 	<TD class="blue"> 
                   		客户地址
                  	</TD>
                  	<TD> 
                    		<input id='in5'  size=35 name=custAddr   readonly Class="InputGrey">
                  	</TD>
                </TR>
                <TR> 
                  	<TD class="blue"> 
                   		帐户ID
                  	</TD>
                  	<TD> 
                    		<input  name=accountId v_must=1 v_type="0_9"  maxlength="22" readonly Class="InputGrey">
                    		<font class="orange">*</font>	
                    		<input name=accountIdQuery type=button class="b_text" onmouseup="getId()" onkeyup="if(event.keyCode==13)getId()"  value=获得 index="4" disabled >
                       </TD>
                  	<TD class="blue"> 
                   		帐户名称
                  	</TD>
                  	<TD> 
                    		<input name=accountName  v_must=1 v_maxlength=60 v_type="string"  maxlength="60" size=33 index="5">
                    		<font class="orange">*</font>	 
                    	</TD>
                </TR>
		<TR>      
			<jsp:include page="/npage/common/pwd_2.jsp">
			 	<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="newPwd"  />
				<jsp:param name="pcname" value="cfmPwd"  />
			 </jsp:include>
		</TR>	
                <TR> 
                  	<TD class="blue"> 
                   		帐户类型
                  	</TD>
                  	<TD> 
                    		<select align="left" name=accountType width=50  index="8">
		                      <%
					    //得到输入参数帐户类型
					 	 sqlStr ="select trim(ACCOUNT_TYPE), TYPE_NAME from sAccountType order by ACCOUNT_TYPE"; 
						//retArray = callView.view_spubqry32("2",sqlStr);
					    	//result = (String[][])retArray.get(0);
					    	%>
					    	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
							<wtc:sql><%=sqlStr%></wtc:sql>
						</wtc:pubselect>
						<wtc:array id="result2" scope="end" />
					    	<%
					    		int recordNum=0;
						    	if(result2!=null&&result2.length>0){
						    		result = result2;
						    		recordNum=result.length;
						    	}
						      	
					      	for(int i=0;i<recordNum;i++){
					        	out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
					      	}
					     	 
					%>
                    		</select>
                  </TD>
                  <TD class="blue"> 
                   	付款方式
                  </TD>
                  <TD> 
                    	<select align="left" name=payCode onchange="payWayChange()" width=50 index="9">
                      		<%
				    //得到输入参数帐户类型
				 
				      		 sqlStr ="select trim(PAY_CODE)||'-'||trim(PAY_NAME),trim(PAY_NAME) from sPayCode where REGION_CODE= '" + regionCode.substring(0,2) +"' order by PAY_CODE";
				      		//retArray = callView.view_spubqry32("2",sqlStr);
				      		%>
				      		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="2">
							<wtc:sql><%=sqlStr%></wtc:sql>
						</wtc:pubselect>
						<wtc:array id="result3" scope="end" />
				      		<%
					      		if(result3!=null&&result3.length>0){
						    		result = result3;					    		
						    	}
				       		//result = (String[][])retArray.get(0);
				      		recordNum = 1;
				      		for(int i=0;i<recordNum;i++){
				        		out.println("<option class='button' value='" + result[0][0] + "'>" + result[0][1] + "</option>");
				      	       }
				%>
                    </select>
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>  
                   
            
              <TABLE id=tbBank0 cellSpacing="0" style="display:none">
                <TBODY> 
	                <TR > 
		                  <TD class="blue"> 
		                   	帐号
		                  </TD>
		                  <TD colspan="3"> 
		                    	<input name=accountNo   maxlength="30" index="10">
		                  </TD>
	                </TR>
                	<TR> 
		                  <TD width=16% class="blue"> 
		                   	银行代码
		                  </TD>
		                  <TD width=34%> 
		                    	<input name=bankCode size=12  maxlength="12" readonly  Class="InputGrey">
		                    	<input name=bankName size=13  onkeyup="if(event.keyCode==13)getBankCode();" readonly index="11" Class="InputGrey">
		                    	<input name=bankCodeQuery type=button  id="bankCodeQuery" style="cursor:hand" onClick="getBankCode()" value=查询 index="12">
		                  </TD>
		                  <TD width=16% class="blue"> 
		                   	局方银行代码
		                  </TD>
		                  <TD width=34%> 
			                    <input name=postCode size=12  maxlength="12" readonly Class="InputGrey">
			                    <input name=postName size=13  onkeyup="if(event.keyCode==13)getPostCode();" index="13">
			                    <input name=postCodeQuery type=button  id="postCodeQuery" style="cursor:hand" onClick="getPostCode()" value=查询 index="14">
		                  </TD>
                	</TR>
                </TBODY> 
              </TABLE>  	
              <TABLE  cellSpacing="0">
	                <TBODY> 
		                <TR> 
		                 	 <TD width=16% class="blue"> 
		                   		开始日期
		                  	</TD>
		                  	<TD> 
		                     		<input  name=beginDate v_type="date"  v_must=1 value="<%=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new Date())%>" maxlength="20" readonly Class="InputGrey">
		                                <input  name=endDate date  v_must=1 maxlength="20" value="20501231" readonly style="display:none" Class="InputGrey">
		                  	</TD>
		               </TR>	
		                <tr> 
		                	<td class="blue">
		                      		系统备注
		                  	</td>
			                <td> 
			                    	<input  name=sysNote size=60 readonly maxlength="60"  Class="InputGrey">
			                </td>
	                	</tr> 
	                	<input name=opNote  type="hidden" size=60 maxlength="60"  index="15" v_must=0 v_maxlength=60 v_type="string" >     	              
	                </TBODY> 
              </TABLE>                             
                      
        	<TABLE  cellSpacing="0">
	          <TBODY>
		            <TR> 
			              <TD id="footer" >
			                    <input class="b_foot_long" name=print  onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" type=button value=确认&打印 index="16" disabled>
					    <input class="b_foot" name=reset1   type=button onClick="frm1102.reset();" value=清除 index="17">
					     <input class="b_foot" name=back   onclick="window.close()" type=button value=关闭 index="18">
					</TD>
		            </TR>
	          </TBODY>
        	</TABLE> 
		  <input type="hidden" id=in1 name="hidPwd" >
		  <input type="hidden" name="hidCustPwd">  <!--客户加密后的密码-->
		  <input type="hidden" name="workno" value=<%=workNo%>>
		  <input type="hidden" name="regionCode" value=<%=regionCode%>> 
		  <input type="hidden" id=in6 name="belongCode" value=<%=belongCode%>>
		  <input type="hidden" name="unitCode" value=<%=Department%>>
		  <input type="hidden" name="ip_Addr" value=<%=ip_Addr%>>
		  <input type="hidden" name="inParaStr" >
		  <input type="hidden" name="checkPwd_Flag" value="false">		<!--密码校验标志-->
		  <input type="hidden" name="workName" value=<%=workName%> >
 		  <jsp:include page="/npage/common/pwd_comm.jsp"/>
 		  <%@ include file="/npage/include/footer_pop.jsp" %> 
		</form>
	</body>
	<SCRIPT type=text/javascript>
		document.frm1102.idIccid.value = '<%=agentPaper%>';
	
		for(i = 0;i < document.frm1102.accountType.length;i++){
				document.frm1102.accountType.options[i].text = "";
				document.frm1102.accountType.options[i].value = "";
			}
		document.frm1102.accountType.length = 1;
		document.frm1102.accountType.options[0] = new Option("空中充值帐户","a");
	</SCRIPT> 
</html>
                                                                                                                                                                          