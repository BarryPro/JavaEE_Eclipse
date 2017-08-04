<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String opCode = "1519";
String opName = "陈账查询";
%>

	 <html>
	 
 	 <head>
 	 <title>陈帐查询</title>
 	 <%
  		 ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
        String[][] baseInfoSession = (String[][])arrSession.get(0);
        String work_no = (String)session.getAttribute("workNo");
        System.out.println("work_no="+work_no);
        String loginName = baseInfoSession[0][3];
        //System.out.println("loginName="+loginName);
        String org_code = (String)session.getAttribute("orgCode");
        System.out.println("org_code="+org_code);
        //String[][] temfavStr=(String[][])arrSession.get(3);
        String[][] temfavStr = (String[][])session.getAttribute("favInfo");
        String[] favStr=new String[temfavStr.length];
        for(int i=0;i<favStr.length;i++)
        favStr[i]=temfavStr[i][0].trim();
		 boolean hfrf=false;
		String op_code = "1519";
      
 		//System.out.println("begin to call server");
 		String phone = request.getParameter("phone_no");
 		String phone_no = request.getParameter("phone_no");
 		//System.out.println(phone);

 	 //------------------填充数据------------------------------------------
 		String cus_id=WtcUtil.repNull(request.getParameter("cus_id"));

		//S1210Impl im=new S1210Impl();
		//ArrayList custDoc=im.getCustDoc(cus_id,op_code,"region",org_code.substring(0,2));
		
		//System.out.println("========================custDoc==============="+custDoc);
    	//new begin
		ArrayList custDoc;
		String sql1 = "select a.CUST_ID,a.REGION_CODE,a.DISTRICT_CODE,a.TOWN_CODE,a.CUST_NAME,a.CUST_PASSWD,a.CUST_STATUS,a.OWNER_GRADE,a.OWNER_TYPE,a.CUST_ADDRESS,a.ID_TYPE,a.ID_ICCID,a.ID_ADDRESS,to_char(a.ID_VALIDDATE,'YYYYMMDD'),a.CONTACT_PERSON,a.CONTACT_PHONE,a.CONTACT_ADDRESS,a.CONTACT_POST,a.CONTACT_MAILADDRESS,a.CONTACT_FAX,a.CONTACT_EMAILL,c.region_name from dcustdoc a,sRegionCode c where a.region_code=c.region_code and a.cust_id='?'";
		%>
		<wtc:pubselect name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phone_no%>" outnum="22">
			<wtc:sql><%=sql1%></wtc:sql>
			<wtc:param value="<%=cus_id%>"/>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end"/>
		 
		<%
		if (result1.length == 0){
		    custDoc = null;
		}else{
			custDoc = new ArrayList();
			for (int i = 0; i < result1[0].length; i++)
				custDoc.add(result1[0][i]);
            String sql2 = "select hand_fee ,trim(favour_code) from snewFunctionFee where region_code='?' and function_code='?'";
            %>
            	<wtc:pubselect name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phone_no%>" outnum="2">
        <wtc:sql><%=sql2%></wtc:sql>
        <wtc:param value="<%=(String)custDoc.get(1)%>"/>
            <wtc:param value="<%=op_code%>"/>
	</wtc:pubselect>
	<wtc:array id="result2" scope="end"/>
            <%
			if (result2.length == 0)
			{
				custDoc.add("");
				custDoc.add("");
			} else
			{
				custDoc.add(result2[0][0]);
				custDoc.add(result2[0][1]);
			}
			
			String sql3 = "select CUST_SEX,to_char(BIRTHDAY,'YYYYMMDD'),trim(PROFESSION_ID),trim(EDU_LEVEL),trim(CUST_LOVE),trim(CUST_HABIT) from dcustdocinadd where cust_id='?'";
%>
<wtc:pubselect name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phone_no%>" outnum="6">
        <wtc:sql><%=sql3%></wtc:sql>
            <wtc:param value="<%=cus_id%>"/>
	</wtc:pubselect>
	<wtc:array id="result3" scope="end"/>
<%
			if (result3.length == 0)
			{
				for (int i = 0; i < 6; i++)
					custDoc.add("");

			} else
			{
				for (int i = 0; i < result3[0].length; i++)
					custDoc.add(result3[0][i]);

			}
    
    }
    System.out.println("AAAAAAAAAAAAAAAAAAAAA!!!!!!!!!!!!!!!!!!!!!!!!!!!! custDoc is "+custDoc);
    %>
	 
        <%
        if(custDoc==null)
        {
			response.sendRedirect("f1519_1.jsp");
        }
        String init_region_code=(String)custDoc.get(1);
        
                System.out.println("init_region_code="+init_region_code);
        
        //String[] twoFlag=im.s1210Index(cus_id,"region",init_region_code);
        
        %>
        
        <%
		String[] twoFlag = new String[2];
		twoFlag[0] = "0";
		twoFlag[1] = "SUCCESS!";
		String fStr[][] = new String[0][];
		String sq1 = "select trim(attr_code) from dcustMsg where cust_id='?' and substr(run_code,2,1)<'a' and rownum<2";
		String temFlag = "";
		%>

<wtc:pubselect name="spubqry32" retcode="err_code" retmsg="err_message" routerKey="region" routerValue="<%=init_region_code%>" outnum="2">
        <wtc:sql><%=sq1%></wtc:sql>
            <wtc:param value="<%=cus_id%>"/>
	</wtc:pubselect>
    <wtc:array id="sPubQry32Arr" scope="end"/>
<%
			twoFlag[0] = err_code;
			twoFlag[1] = err_message;
			if (Integer.parseInt(err_code) == 0)
				fStr = sPubQry32Arr;
			if (fStr[0][1] == null)
				temFlag = "00000";
			else
				temFlag = fStr[0][1];
			if (!temFlag.equals(""))
			{
				String bigFlag = temFlag.substring(2, 4);
				String grpFlag = temFlag.substring(4, 5);
				System.out.println("bigFlag="+bigFlag);
				String sq2 = "select trim(card_name) from sBigCardCode where card_type='?'";
				String sq3 = "select trim(grp_name) from sGrpBigFlag where grp_flag='?'";
				System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
				System.out.println("bigFlag="+bigFlag);
				System.out.println("grpFlag="+grpFlag);
			
%>
<wtc:pubselect name="sPubMultiSel" retcode="err_code2" retmsg="err_message2" routerKey="region" routerValue="<%=init_region_code%>" outnum="2">
        <wtc:sql><%=sq2%></wtc:sql>
        <wtc:param value="<%=bigFlag%>"/>
</wtc:pubselect>
<wtc:array id="sPubMultiSelArr1" scope="end"/>
<%
System.out.println("*********************************err_message2="+err_message2);
                twoFlag[0] = err_code2;
				if (Integer.parseInt(err_code2) == 0)
				{
					twoFlag[0] = sPubMultiSelArr1[0][0];
				}
%>
<wtc:pubselect name="sPubMultiSel" retcode="err_code3" retmsg="err_message3" routerKey="region" routerValue="<%=init_region_code%>" outnum="2">
        <wtc:sql><%=sq3%></wtc:sql>
        <wtc:param value="<%=grpFlag%>"/>
</wtc:pubselect>
<wtc:array id="sPubMultiSelArr2" scope="end"/>
<%
     System.out.println("*********************************err_message3="+err_message3);
				twoFlag[1] = err_message3;
				if (Integer.parseInt(err_code3) == 0)
				{
					twoFlag[1] = sPubMultiSelArr2[0][0];
				}
			}
   
		//new end
		//String init_region_code=(String)custDoc.get(1);
		//String[] twoFlag=im.s1210Index(cus_id,"region",init_region_code);


		if(((String)custDoc.get(22)).trim().equals("") || ((String)custDoc.get(22)).trim().equals("0"))
		{
 			hfrf=true; 
		}
		else
		{
          if(!WtcUtil.haveStr(favStr,((String)custDoc.get(23)).trim()))
		  {
 			hfrf=true;
		  }
		}

	 //------------------处理下拉框----------------------------------------

		//取得第一级下拉框数据(6)
		StringBuffer sqlsBUF=new StringBuffer("");
		sqlsBUF.append("select status_name||'#'||status_code from sCustStatusCode order by  status_code;");
		sqlsBUF.append("select type_name||'#'||owner_code from sCustGradeCode where region_code='");
		sqlsBUF.append(init_region_code);
		sqlsBUF.append("' order by trim(owner_code);");
		sqlsBUF.append("select Type_name||'#'||type_code from sCustTypeCode order by type_code;");
		sqlsBUF.append("select id_name||'#'||id_type from sIdType order by id_type;");
		sqlsBUF.append("select sex_name||'#'||sex_code from sSexCode order by sex_code;");
		sqlsBUF.append("select profession_name||'#'||profession_id from sProfessionId order by profession_id;");
		String sqls=sqlsBUF.toString();
	//String[][] metaData=co.fillSelect(sqls);
  	%>
    <wtc:mutilselect name="sPubMultiSel"  id="metaData" type="array">

    <wtc:sql><%=sqls%></wtc:sql>

    </wtc:mutilselect>
   <%

     

		//取得第二级下拉框数据(2)
		StringBuffer subSqlBUF=new StringBuffer("select district_name||'#'||district_code from sDisCode where region_code='");
		subSqlBUF.append(init_region_code);
		subSqlBUF.append("' order by district_code;");
		subSqlBUF.append("select type_name||'#'||work_code from sWorkCode where region_code='");
		subSqlBUF.append(init_region_code);
		subSqlBUF.append("' order by work_code;");
		String subSql=subSqlBUF.toString();
	//	String[][] sub_metaData=co.fillSelect(subSql,"region",init_region_code);
	%>
		<wtc:mutilselect name="sPubMultiSel"  id="sub_metaData" type="array">

    <wtc:sql><%=subSql%></wtc:sql>

    </wtc:mutilselect>
	<%	
		String init_city_code=WtcUtil.getOneTok(sub_metaData[0][0],"#",2);
		for(int i=0;i<sub_metaData[0].length;i++)
		{
		  if((WtcUtil.getOneTok(sub_metaData[0][i],"#",2)).equals(((String)custDoc.get(2)).trim()))
		 {
			 init_city_code=(WtcUtil.getOneTok(sub_metaData[0][i],"#",2));
			break;
		 }
	   }

		//取得第三级下拉框数据(1)
		StringBuffer triBUF=new StringBuffer("select rtrim(town_name)||'#'||town_code from sTownCode where region_code='");
		triBUF.append(init_region_code);
		triBUF.append("' and district_code='");
		triBUF.append(init_city_code);
		triBUF.append("' order by town_code;");
		String triSql=triBUF.toString();
		//System.out.println("3     \r\n"+triSql);
		//String[][] tri_metaData=co.fillSelect(triSql,"region",init_region_code);
		%>
		<wtc:mutilselect name="sPubMultiSel"  id="tri_metaData" type="array">

    <wtc:sql><%=triSql%></wtc:sql>

    </wtc:mutilselect>
		<%
		
		//输入参数 手机号码、用户ID、开始时间、结束时间、操作工号、操作员
	//	String phone_no=request.getParameter("phone_no");
		String id_no=request.getParameter("id_no");
		String begin_ym=request.getParameter("begin_ym");
		String end_ym=request.getParameter("end_ym");
		String work_name=request.getParameter("work_name");
	
		ArrayList arlist = new ArrayList();
	/*	try{
			s1520view viewBean = new s1520view();//实例化viewBean
			arlist = viewBean.s1519Qry(phone_no,id_no,begin_ym,end_ym,work_no); 
		}
		catch(Exception e)
		{
			//System.out.println("调用EJB发生失败！");
		}*/
		%>  
	<wtc:service name="s1519Qry"  outnum="20" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=phone_no%>"/>
	  <wtc:param value="<%=id_no%>"/>
	  <wtc:param value="<%=begin_ym%>"/>
	  <wtc:param value="<%=end_ym%>"/>
	  <wtc:param value="<%=work_no%>"/>	
	</wtc:service>

	<wtc:array id="result"   scope="end"/>
  <% 
	//	String [][] result = new String[][]{};
	//	result = (String[][])arlist.get(0);
		String return_code =result[0][0];
		String return_message =result[0][1];
	%>
	<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
	<%
		if (!return_code.equals("000000"))
		{
	%>
	<script language="JavaScript">
		rdShowMessageDialog("<%=return_message%><br>错误代码 '<%=return_code%>'。");
		history.go(-1);
	</script>
	<%	}
	%>

	 <META content=no-cache http-equiv=Pragma>
	 <META content=no-cache http-equiv=Cache-Control>
	 <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
 
	 <script language=javascript>
	   core.loadUnit("debug");
	   core.loadUnit("rpccore");

	   onload=function()
	   {
		 fillSelect();
		 self.status="";
		//core.rpc.onreceive = doProcess;
	   }

	   //---------1------RPC处理函数------------------
	   function doProcess(packet)
	   {
		  var rpc_page=packet.data.findValueByName("rpc_page");
		  if(rpc_page=="chg_city")
		  {
			var triListData = packet.data.findValueByName("tri_list");
			var triList=new Array(triListData.length);
			triList[0]="s_spot";
 		    for(i=0;i<triListData.length;i++)
    		{
			  document.all(triList[i]).options.length=0;
			  document.all(triList[i]).options.length=triListData[i].length;
			  for(j=0;j<triListData[i].length;j++)
			  {
				document.all(triList[i]).options[j].text=oneTok(triListData[i][j],"#",1);
				document.all(triList[i]).options[j].value=oneTok(triListData[i][j],"#",2);
			  }
			}
		  }
		}

	   //-------2------下拉框点击函数----------------
		function chg_city()
		{
			var region_code = document.all.region_code.value;
			var city_code = document.all.s_city[document.all.s_city.selectedIndex].value;
			var myPacket = new RPCPacket("chg_city.jsp","正在获得归属网点信息，请稍候......");
			myPacket.data.add("region_code",region_code);
			myPacket.data.add("city_code",city_code);
			core.rpc.sendPacket(myPacket);
			delete(myPacket);
		}

	  //--------4---------显示打印对话框----------------
	 function printCommit()
	 {
		// in here form check
		showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	 }

	 function showPrtDlg(printType,DlgMessage,submitCfm)
	 {
		if(check(frm))
		{
		  document.all.t_sys_remark.value="客户"+jtrim(document.all.cust_name.value)+"资料查询。";

		 //显示打印对话框
		  var h=200;
		  var w=350;
		  var t=screen.availHeight/2-h/2;
		  var l=screen.availWidth/2-w/2;
		  var printStr = printInfo(printType);
		  var prop="dialogHeight "+h+"px; dialogWidth "+w+"px; dialogLeft "+l+"px; dialogTop "+t+"px;toolbar no; menubar no;	scrollbars yes; resizable no;location no;status no;help no"

		  var path = "<%=request.getContextPath()%>/page/s1501/spubPrint.jsp?DlgMsg=" + DlgMessage;
    	  var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
    	  var ret=window.showModalDialog(path,"",prop);

		  if(typeof(ret)!="undefined")
		  {
			if((ret=="confirm")&&(submitCfm == "Yes"))
			{
			  if(rdShowConfirmDialog('确认电子免填单吗？')==1)
			  {
			   conf();
			  }
		    }
		    if(ret=="continueSub")
		    {
			  if(rdShowConfirmDialog('确认要提交陈帐查询信息吗？')==1)
			  {
			   conf();
			  }
    		}
		  }
		  else
		  {
			  if(rdShowConfirmDialog('确认要提交陈帐查询信息吗？')==1)
			  {
			   conf();
			  }
		  }
		}
	 }

	 function printInfo(printType)
	 {
 		  var retInfo = "";
		  retInfo+=document.all.cus_id.value+"|";
		  retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";

	      retInfo+=document.all.cust_name.value+"|";
		  retInfo+=document.all.t_comm_phone.value+"|";
		  retInfo+=document.all.t_comm_address.value+"|";
		  retInfo+=document.all.t_idno.value+"|";
		  retInfo+=document.all.t_id_address.value+"|";
		  retInfo+="陈帐查询。*手续费 "+document.all.t_handFee.value+"|";
		  retInfo+=document.all.t_sys_remark.value+"|";
		  retInfo+=document.all.t_op_remark.value+"|";
		 return retInfo;
	 }

	 //--------5----------提交处理函数-------------------
	 function conf()
	 {
		document.all.b_print.Disabledd=true;
		document.all.b_clear.Disabledd=true;
		document.all.b_back.Disabledd=true;

		 frm.action="s1501_conf.jsp";
		 frm.submit();
	 }

	 function canc()
	 {
		frm.submit();
	 }

    //-------6--------实收栏专用函数----------------
     function ChkHandFee()
	 {
       if(jtrim(document.all.oriHandFee.value).length>=1 && jtrim(document.all.t_handFee.value).length>=1)
	   {
         if(parseFloat(document.all.oriHandFee.value)<parseFloat(document.all.t_handFee.value))
	     {
          rdShowMessageDialog("实收手续费不能大于原始手续费！");
		  document.all.t_handFee.value="0";
		  document.all.t_handFee.select();
		  document.all.t_handFee.focus();
		  return;
	     }
	   }
	  
	   if(jtrim(document.all.oriHandFee.value).length>=1 && jtrim(document.all.t_handFee.value).length==0)
	   {
         document.all.t_handFee.value="0";
	   }
	 }

	 function getFew()
	 {
	   if(window.event.keyCode==13)
	   {
		 var fee=document.all.t_handFee;
		 var fact=document.all.t_factFee;
		 var few=document.all.t_fewFee;
		 if(jtrim(fact.value).length==0)
		 {
		  rdShowMessageDialog("实收金额不能为空！");
		  fact.value="";
		  fact.focus();
		  return;
		 }
		 if(parseFloat(fact.value)<parseFloat(fee.value))
		 {
		  rdShowMessageDialog("实收金额不足！");
		  fact.value="";
		  fact.focus();
		  return;
		 }

		var tem1=((parseFloat(fact.value)-parseFloat(fee.value))*100+0.5).toString();
		var tem2=tem1;
		if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
	    few.value=(tem2/100).toString();
		few.focus();
	   }
	 }
	 </script>
	 </head>
	 <body >
 	 <form name="frm" method="POST">
	 <%@ include file="/npage/include/header.jsp" %>
 	 <input type="hidden" name="cus_id" id="cus_id" value="<%=cus_id%>">
 	 <input type="hidden" name="region_code" id="region_code" value="<%=((String)custDoc.get(1)).trim()%>">
 	 <input type="hidden" name="cust_name" id="cust_name" value="<%=(String)custDoc.get(4)%>">

 	 <input type="hidden" name="oriHandFee" id="oriHandFee" value="<%=((String)custDoc.get(22)).trim()%>">
     <input type="hidden" name="oldPass" id="oldPass" value="<%=((String)custDoc.get(5)).trim()%>">
 	 <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
 	 <tr>
 	  <td  >
 	  
 		    
 		  
 		   
 	   <table width="100%" align="center">
 		 <tr>
 		   <td>
  				   <table   >
 					 <tr  >
 					   <td nowrap width="10%">
 						 <div align="right">大客户标志 </div>
 					   </td>
 					   <td nowrap width="23%">
 						 <div align="left"><%=twoFlag[0]%></div>
 					   </td>
  					   <td nowrap width="10%">
 						 <div align="right">集团标志 </div>
 					   </td>
 					   <td nowrap colspan="3" bgcolor="eeeeee">
 						 <div align="left"><%=twoFlag[1]%></div>
 					   </td>
 					 </tr>
 					 <tr  >
 					   <td nowrap width="10%">
 						 <div align="right">客户归属地区 </div>
 					   </td>
 					   <td nowrap width="23%">
 						 <div align="left">
 						   <input type="text" class="button" name="t_region" id="t_region" size="16"
	value="<%=(String)custDoc.get(21)%>" readonly>
 						 </div>
 					   </td>
 					   <td nowrap width="10%">
 						 <div align="right">归属市县 </div>
 					   </td>
 
					   <td nowrap width="24%">
 					 <div align="left">
 			   <select name="s_city" id="s_city" onchange="chg_city()" Disabled>

 			   </select>
 		   <font color="#FF0000"></font></div>
					   </td>
					   <td nowrap width="10%">
						 <div align="right">归属网点 </div>
					   </td>
					   <td nowrap width="23%">
						 <div align="left">
						   <select name="s_spot" id="s_spot" Disabled>
						   </select>
						    </div>
					   </td>
					 </tr>
					 <tr  >
					   <td nowrap width="10%">
						 <div align="right">客户名称 </div>
					   </td>
					   <td nowrap width="23%">
						 <div align="left">
						   <input type="text" class="button" name="t_cus_name" id="t_cus_name" size="16"
	value="<%=(String)custDoc.get(4)%>" v_minlength=1 v_maxlength=60 v_type=string  v_name="客户名称" readonly>
	   </div>
					   </td>
					   <td nowrap width="10%">
						 <div align="right"> </div>
					   </td>
					   <td nowrap width="24%">
						 <div align="left">
						 </div>
 					   </td>
 					   <td nowrap width="10%">
 					   </td>
 					   <td nowrap width="23%">
 						 <div align="left">
 						 </div>
 					   </td>
 					 </tr>
 					 <tr  >
 					   <td nowrap width="10%">
 						 <div align="right">客户状态 </div>
 					   </td>
 					   <td nowrap width="23%">
 						 <div align="left">
 						   <select name="s_cus_status" Disabled>
 						   </select>
 						    </div>
 					   </td>
 					   <td nowrap width="10%">
 						 <div align="right">客户级别 </div>
 					   </td>
 					   <td nowrap width="24%">
 						 <div align="left">
  						   <select name="s_cus_level" Disabled>
 						   </select>
 						    </div>
 					   </td>
 					   <td nowrap width="10%">
 						 <div align="right">客户类别 </div>
 					   </td>
 					   <td nowrap width="23%">
 						 <div align="left">
 						   <select name="s_cus_type" Disabled>
 						   </select>
 						    </div>
 					   </td>
 					 </tr>
 					 <tr  >
 					   <td nowrap width="10%">
 						 <div align="right">客户地址 </div>
 					   </td>
  					   <td nowrap width="23%">
  						 <div align="left">
 						   <input type="text" class="button" name="t_cus_address" id="t_cus_address" size="16"
	value="<%=(String)custDoc.get(9)%>" v_minlength=1 v_maxlength=60 v_type=string  v_name="客户地址" readonly>
 						    </div>
 					   </td>
 					   <td nowrap width="10%">
 						 <div align="right">证件类型 </div>
 					   </td>
 					   <td nowrap width="24%">
 						 <div align="left">
 						   <select name="s_idtype" Disabled>
 						   </select>
 						 </div>
 					   </td>
  					   <td nowrap width="10%">
 						 <div align="right">证件号码 </div>
 					   </td>
 					   <td nowrap width="23%">
 						 <div align="left">
  						   <input type="text" class="button" name="t_idno" id="t_idno" size="16"
	value="<%=(String)custDoc.get(11)%>" v_minlength=1 v_maxlength=20 v_type=int v_name="证件号码" readonly>
 						     </div>
 					   </td>
 					 </tr>
 					 <tr bgcolor="eeeeee">
 					   <td nowrap width="10%">
 						 <div align="right">证件地址 </div>
 					   </td>
 					   <td nowrap width="23%">
 						 <div align="left">
 						   <input type="text" class="button" name="t_id_address" id="t_id_address" size="16"
	value="<%=(String)custDoc.get(12)%>" v_minlength=1 v_maxlength=60 v_type=string  v_name="证件地址" readonly>
 						    </div>
 					   </td>
 					   <td nowrap width="10%">
 						 <div align="right">证件有效期 </div>
 					   </td>
 					   <td nowrap width="24%">
 						 <div align="left">
  						   <input type="text" class="button" name="t_id_valid" id="t_id_valid" size="16"
	value="<%=(String)custDoc.get(13)%>" v_minlength=1 v_maxlength=8 v_type=date  v_name="证件有效期" readonly>
 						 </div>
 					   </td>
 					   <td nowrap width="10%">
 						 <div align="right">联系人姓名 </div>
 					   </td>
 					   <td nowrap width="23%">
 						 <div align="left">
  						   <input type="text" class="button" name="t_comm_name" id="t_comm_name" size="16"
	value="<%=(String)custDoc.get(14)%>" v_minlength=1 v_maxlength=20 v_type=string  v_name="联系人姓名" readonly>
 						    </div>
 					   </td>
 					 </tr>
  					 <tr bgcolor="eeeeee">
 					   <td nowrap width="10%">
 						 <div align="right">联系人电话 </div>
 					   </td>
 					   <td nowrap width="23%">
 						 <div align="left">
 						   <input type="text" class="button" name="t_comm_phone" id="t_comm_phone" size="16"
	value="<%=(String)custDoc.get(15)%>" v_minlength=1 v_maxlength=20 v_type=phone  v_name="联系人电话" readonly>
 						     </div>
 					   </td>
 					   <td nowrap width="10%">
 						 <div align="right">联系人地址 </div>
 					   </td>
 					   <td nowrap width="24%">
  						 <div align="left">
 						   <input type="text" class="button" name="t_comm_address" id="t_comm_address" size="16"
	value="<%=(String)custDoc.get(16)%>" v_minlength=1 v_maxlength=20 v_type=string  v_name="联系人地址" readonly>
 						    </div>
 					   </td>
 					   <td nowrap width="10%">
 						 <div align="right">联系人邮编 </div>
 					   </td>
 					   <td nowrap width="23%">
 						 <div align="left">
  						   <input type="text" class="button" name="t_comm_postcode" id="t_comm_postcode" size="16"
	value="<%=(String)custDoc.get(17)%>" v_minlength=1 v_maxlength=6 v_type=zip  v_name="联系人邮编" readonly>
  						     </div>
 					   </td>
 					 </tr>
 					 <tr bgcolor="eeeeee">
 					   <td nowrap width="10%">
 						 <div align="right">联系人通讯地址 </div>
  					   </td>
 					   <td nowrap width="23%">
 						 <div align="left">
  						   <input type="text" class="button" name="t_comm_comm" id="t_comm_comm" size="16"
	value="<%=(String)custDoc.get(18)%>" v_minlength=1 v_maxlength=60 v_type=string  v_name="联系人通讯地址" readonly>
 						   </div>
 					   </td>
 					   <td nowrap width="10%">
 						 <div align="right">联系人传真 </div>
 					   </td>
 					   <td nowrap width="24%">
 						 <div align="left">
 						   <input type="text" class="button" name="t_comm_fax" id="t_comm_fax" size="16"
	value="<%=(String)custDoc.get(19)%>" v_minlength=1 v_maxlength=30 v_type=phone  v_name="联系人传真" readonly>
 						    </div>
 					   </td>
 					   <td nowrap width="10%">
 						 <div align="right">联系人EMAIL </div>
 					   </td>
 					   <td nowrap width="23%">
 						 <div align="left">
 						   <input type="text" readonly class="button" name="t_comm_email" id="t_comm_email" size="16"
	value="<%=(String)custDoc.get(20)%>"  v_type=email  v_name="联系人EMAIL" readonly>
 						     </div>
 					   </td>
 					 </tr>
 					 <tr >
 					   <td nowrap width="10%">
 						 <div align="right">客户性别 </div>
 					   </td>
 					   <td nowrap width="23%">
 						 <div align="left">
 						   <select name="s_cus_sex" Disabled>
 						   </select>
 						   </div>
 					   </td>
 					   <td nowrap width="10%">
 						 <div align="right">出生日期 </div>
 					   </td>
 					   <td nowrap width="24%">
 						 <div align="left">
 						   <input type="text" readonly class="button" name="t_birth" id="t_birth" size="16"
	value="<%=(String)custDoc.get(25)%>" v_minlength=1 v_maxlength=8 v_type=date  v_name="出生日期" readonly>
 						   <font color="#FF0000"> </font></div>
 					   </td>
 					   <td nowrap width="10%">
 						 <div align="right">职业类型 </div>
 					   </td>
 					   <td nowrap width="23%">
 						 <div align="left">
 						   <select name="s_busi_type" Disabled>
 						   </select>
 						   <font color="#FF0000"> </font></div>
 					   </td>
 					 </tr>
 					 <tr bgcolor="eeeeee">
 					   <td nowrap width="10%">
 						 <div readonly align="right">学历 </div>
 					   </td>
 					   <td nowrap width="23%">
 						 <div align="left">
  						   <select name="s_edu" Disabled>
 						   </select>
 						   <font color="#FF0000"> </font></div>
 					   </td>
 					   <td nowrap width="10%">
 						 <div align="right">手机号码 </div>
 					   </td>
					   <td nowrap width="24%">
							
                    <div align="left"> 
                      <input type="text" name="phone_no" class="button" value="<%=phone%>" size=20>
                      <font color="#FF0000"> </font></div>
					   </td>
					   <td nowrap width="10%">
						 <div align="right">客户习惯 </div>
					   </td>
					   <td nowrap width="23%">
						 <div align="left">
						   <input type="text" readonly class="button" name="t_cus_habit" id="t_cus_habit" size="16"
	value="<%=(String)custDoc.get(29)%>" v_minlength=1 v_maxlength=20 v_type=string v_name="客户习惯" readonly>
						   <font color="#FF0000"> </font></div>
					   </td>
					 </tr>
					 <tr bgcolor="eeeeee">
					   <td nowrap colspan="6">
						 <div align="center">
						   <hr noshade>
						 </div>
					   </td>
					 </tr>
					 <tr bgcolor="eeeeee">
					   <td nowrap width="10%">
						 <div align="right">手续费 </div>
					   </td>
					   <td nowrap width="23%">
						 <div align="left">
						   <input type="text" readonly class="button" name="t_handFee" id="t_handFee" size="16" readonly 
	value="<%=((String)custDoc.get(22)).trim()%>" v_type=float v_name="手续费" <%if(hfrf){%>readonly<%}%> onblur="ChkHandFee()">
						 </div>
					   </td>
					   <td nowrap width="10%">
						 <div align="right">系统备注 </div>
					   </td>
					   <td nowrap colspan="5">
						 <div align="left">
						   <input type="text" class="button" name="t_sys_remark" id="t_sys_remark" size="45" readonly>
						 </div>
					   </td>
					 </tr>
					 
				   </table>
				    	         <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr>
          <td>
            <TABLE width=100% height=25 border=0 align="center" cellSpacing=1 cellpadding="4">
              <TBODY>
                <TR bgcolor="649ECC" >
                  <TD width=6%>年月</TD>
                  <TD width=7%>帐单状态</TD>
                  <TD width=7%>应收款</TD>
                  <TD width=7%>优惠</TD>
                  <TD width=7%>月租</TD>
                  <TD width=7%>特服</TD>
                  <TD width=7%>市话费</TD>
                  <TD width=7%>漫游费</TD>
                  <TD width=7%>长途费</TD>
                  <TD width=7%>IP费</TD>
                  <TD width=7%>VPMN</TD>
                  <TD width=6%>GPRS</TD>
                  <TD width=6%>信息费</TD>
                  <TD width=6%>其他费</TD>
                </TR>
<%            for(int y=0;y<result.length;y++)
              {
%>
	        <tr bgcolor="#EEEEEE">
<%    	        for(int j=2;j<16;j++)
	        {
%>
	          <td height="25"><%= result[y][j]%> </td>
<%	        }
%>
                </tr>
<%	      }
%>
              </TBODY>
	    </TABLE>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
        <tr>
          <td>
            <TABLE width=100% height=25 border=0 align="center" cellSpacing=1 cellpadding="4">
              <TBODY>
                <TR bgcolor="#EEEEEE" >
                  <TD>已 交 费 <input class="button" value="<%=result[0][19]%>" maxlength="25" size=25 readonly></TD>
                  <TD>欠费月数 <input class="button" value="<%=result[0][16]%>" maxlength="25" size=25 readonly></TD>
                  <TD>欠费总额 <input class="button" value="<%=result[0][17]%>" maxlength="25" size=25 readonly></TD>
                </TR>
              </TBODY>
	    </TABLE>
          </td>
        </tr>
      </table>
      <table width="100%" border=0 align=center cellpadding="4" cellspacing=0>
        <tbody> 
          <tr > 
      	    <td align=center>
    	      &nbsp; <input class="b_foot" name=back onClick="window.location='f1519_1.jsp'" type=button value=返回>
    	      &nbsp; <input class="b_foot" name=back onClick="window.close()" type=button value=关闭>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
      
		   </td>
		 </tr>
		 <tr>
		  <td>&nbsp; </td>
 		 </tr>
 	   </table>
 	   </td>
 	   </tr>
 	   </table>

 	 </form>
 	 </body>
 		<script language="JavaScript">
 		function fillSelect()
 		{
  	 <%
 		  //最终修改区-------------------
  		  int selObj_num=6;
  		  String[] selObj={"s_cus_status","s_cus_level","s_cus_type","s_idtype","s_cus_sex","s_busi_type"};
 		  //int[] firListLoc={6,7,8,10,8,10,24,26};  modify by zhaorh
 		  int[] firListLoc={6,7,8,10,24,26};
 			 for(int p=0;p<selObj_num;p++)
 			 {
 	 %>
 				   document.all("<%=selObj[p]%>").options.length=<%=metaData[p].length%>;
 	 <%
 			   for(int i=0;i<metaData[p].length;i++)
			   {
	 %>
				 document.all("<%=selObj[p]%>").options[<%=i%>].text='<%=WtcUtil.getOneTok(metaData[p][i],"#",1)%>';
				 document.all("<%=selObj[p]%>").options[<%=i%>].value='<%=WtcUtil.getOneTok(metaData[p][i],"#",2)%>';

	             if(document.all("<%=selObj[p]%>").options[<%=i%>].value=="<%=WtcUtil.repNull(((String)custDoc.get(firListLoc[p])).trim())%>")
				 {
					 document.all("<%=selObj[p]%>").options[<%=i%>].selected=true;
				 }
	 <%
			   }
			 }

			 int sub_num=2;
			 String[] subObj={"s_city","s_edu"};
			 int[] subListLoc={2,27};
			 for(int q=0;q<sub_num;q++)
			 {
	 %>
			   document.all("<%=subObj[q]%>").options.length=<%=sub_metaData[q].length%>;
	 <%
       		   for(int j=0;j<sub_metaData[q].length;j++)
			   {
	 %>
 				 document.all("<%=subObj[q]%>").options[<%=j%>].text='<%=WtcUtil.getOneTok(sub_metaData[q][j],"#",1)%>';
				  document.all("<%=subObj[q]%>").options[<%=j%>].value='<%=WtcUtil.getOneTok(sub_metaData[q][j],"#",2)%>';
                 if(document.all("<%=subObj[q]%>").options[<%=j%>].value=="<%=WtcUtil.repNull(((String)custDoc.get(subListLoc[q])).trim())%>")
				 {
					 document.all("<%=subObj[q]%>").options[<%=j%>].selected=true;
				 }
	 <%
				}
			 }
			 int tri_num=1;
			 String[] triObj={"s_spot"};
			 int[] triListLoc={3};
			 for(int r=0;r<tri_num;r++)
			 {
	 %>
			   document.all("<%=triObj[r]%>").length=<%=tri_metaData[r].length%>;
			  
	 <%
			   for(int k=0;k<tri_metaData[r].length;k++)
			   {
	 %>
				 document.all("<%=triObj[r]%>").options[<%=k%>].text='<%=WtcUtil.getOneTok(tri_metaData[r][k],"#",1)%>';
				  document.all("<%=triObj[r]%>").options[<%=k%>].value='<%=WtcUtil.getOneTok(tri_metaData[r][k],"#",2)%>';
              	if(document.all("<%=triObj[r]%>").options[<%=k%>].value=="<%=WtcUtil.repNull(((String)custDoc.get(triListLoc[r])).trim())%>")
				 {
					 document.all("<%=triObj[r]%>").options[<%=k%>].selected=true;
				 }
	 <%
				}
			}
	 %>
		}
		</script>
