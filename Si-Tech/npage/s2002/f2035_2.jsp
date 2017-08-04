<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年10月25日
　 * 作者: leimd
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/public/pubSASql.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%
	String opCode = WtcUtil.repNull(request.getParameter("pageOpCode"));	
	String opName = WtcUtil.repNull(request.getParameter("pageOpName"));	
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	String workName = (String)session.getAttribute("workName");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String orgCode = (String)session.getAttribute("orgCode");
	String productId = request.getParameter("productID");
	String orderSource = request.getParameter("orderSource");
	String productSpecNum = WtcUtil.repNull(request.getParameter("productSpecNum"));
	System.out.println("orderSource="+orderSource);
	String operType = request.getParameter("operType");
	String id_no = request.getParameter("grpIdNo");
	System.out.println("operType="+operType);
	String regionCode = orgCode.substring(0,2);
	String sqlStr="";
	String tMemberProperty = "";
	String  currentYear= (String)session.getAttribute("currentYear");
	String bizStatus="";//成员类型
	String member_type="";//成员类型，sMemberType表中的member_type
	String biz_code="";
	String productCode="";

	String ret_message = "";
	String ret_code = "";		
	String sm_code="";
	/*zhangyan 2011-5-12 15:32:07 
	此SQL字段名和from之间缺少空格  */
	sqlStr="select a.bizstatus,nvl(b.field_value,''),d.product_code   "
		  +"from sbillspcode a,dgrpusermsgadd b,dproductorderdet c,dgrpusermsg d"
		  +" where b.id_no=c.id_no and b.field_code='YWDM0' and c.id_no=d.id_no"
		  +" and a.bizcodeadd=b.field_value and c.Product_Id='"+productId+"'";
		  
	System.out.println(sqlStr);
	String sqlStr2 = "select count(*) from sbbossmembercharacter where productspec_number = '"+productSpecNum+"' and substr(character_attr_code,1,1)='1'";
	System.out.println("22222222222="+currentYear);	
	/*zhangyan 2011-5-12 14:49:31
	根据配置表查产品规格SQL , 根据产品订单产品规格和,查商品订单编号.
	根据查出的
	*/
	String sql_cntSpec ="select  count(*)									"
		+"  FROM DPRODUCTORDERDET T, DPOORDERINFO T1, dbvipadm.SCOMMONCODE T3        "
		+" WHERE T.POORDER_ID = T1.POORDER_ID                              "
		+"   AND T.PRODUCTSPEC_NUMBER = T3.FIELD_CODE2                      "
		+"   AND T1.POSPEC_NUMBER = T3.FIELD_CODE1                          "
		+"   AND T3.FIELD_CODE3 = '1'   and t.Product_Id =   '"+productId+"'";
%>                                                                  

<wtc:pubselect name="sPubSelect" outnum="3">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>

<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sqlStr2%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result2" scope="end"/>
	
<!--zhangyan 2011-5-12 14:52:16 b
查产品配置SQL,为是否展示文件上传选择按钮做准备
-->
<%
String v_productId = "v_productId="+productId;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
	<wtc:param value="<%=sql_cntSpec%>"/>
	<wtc:param value="<%=v_productId%>"/> 
</wtc:service>
<wtc:array id="result_cntSpec" scope="end"/>
	
<%
System.out.println("result_cntSpec>"+result_cntSpec.length);
String str_cntSpec = result_cntSpec[0][0];
System.out.println("str_cntSpec>"+str_cntSpec);
%>	
<!--zhangyan 2011-5-12 14:52:16 e-->
<%
if(retCode.equals("000000")){
	if(result.length>0){
		/*zhangyan mod 2011-5-12 14:47:08
		数组取得有问题
		*/
		bizStatus=result[0][0];
		biz_code=result[0][1];
		productCode=result[0][2];
		bizStatus.trim();
	}
System.out.println("length="+result.length+",bizStatus="+bizStatus+",bizCode="+biz_code+",productCode="+productCode);
}
%>
<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql>SELECT b.member_type FROM dproductorderdet a,smembertype b WHERE a.productspec_number = b.productspec_number(+) AND  product_id ='<%=productId%>'</wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end"/>
<%
	member_type = result1[0][0];
	System.out.println("member_type=="+member_type);
%>
<%
	/* ningtn 查询是否需要展示销售代理商，大于0为需要展示*/
	String showSql="select count(*) "
				+" from suserfieldcode a,susertypefieldrela b,dproductorderdet d,dproductspecinfo c "
				+" where a.field_code=b.field_code "
				+" and b.user_type=to_char(c.external_code) "
				+" and d.product_id='" + productId + "'"
				+" and b.field_order=to_number(d.productspec_number) "
				+" and d.productspec_number=c.productspec_number  "
				+" and a.field_code='81009'";
%>
<wtc:pubselect name="sPubSelect" outnum="1" retcode="showCode" retmsg="showMsg" >
	<wtc:sql><%=showSql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="showResult" scope="end"/>
<%
	String showResultVal = "0";
	if("000000".equals(showCode)){
		if(showResult != null && showResult.length > 0){
			showResultVal = showResult[0][0];
		}
	}
	System.out.println("=========showResultVal: " + showResultVal);
	/* ningtn 关于优化集团客户SA酬金结算系统的函*/
	String saListSql = pubSASqlStr;
%>
	<wtc:pubselect name="sPubSelect" outnum="2" retcode="saListCode" retmsg="saListMsg" >
		<wtc:sql><%=saListSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="saListResult" scope="end"/>

	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link href="s2002.css" rel="stylesheet" type="text/css">
<script>
	var showResultVal = "<%=showResultVal%>";
onload=function()
{
	getbizcode();
	document.form1.selectAdditive.disabled=false;
	document.getElementById("nextoper").disabled=false;
	var operType="<%=operType%>";
	var bizS="<%=bizStatus%>";
	var proSpecNum="<%=productSpecNum%>";

 	if(operType=="1"){
 		memInfo.style.display="inline";	
 		//memInfoList.style.display="none"
 		if(document.getElementById("b_del"))
 		{
 			document.getElementById("b_del").style.display="inline";
 		}
 		//如果查找出bizStatus则按照此显示，如果没有则统一为签约关系
 		if(bizS=="0")
 		{
 			document.form1.memberType.value="1";
 		}
 		else if(bizS=="1")
 		{
 			document.form1.memberType.value="2";
 		}
 		else if(bizS=="2")
 		{
 			document.form1.memberType.value="0";
 		}
 		else
 		{
 			document.form1.memberType.value="1";
 		}
 		//400业务语音和短信产品只允许添加黑名单成员 wuxy alter 20090913 短信采用白名单管理
 		if(proSpecNum=="411501")
 		{
 			document.form1.memberType.value="0";
 		}
 		if(proSpecNum=="411506")
 		{
 			document.form1.memberType.value="2";
 		}
 		//更具配置表sMemberType判断成员类型
 		if('<%=member_type%>'!=""){	
 			document.form1.memberType.value = '<%=member_type%>';
 		}
 		$("#memberType").find("option:not(:selected)").remove();
 		/*zhangyan 2011-5-12 14:50:26 b
 		根据查询结果判断,是否展示文件上传选择按钮
 		产品
 		*/
 		var v_cntSpec = document.form1.hidden_cntSpec.value;
 		if ( v_cntSpec==0 )
 		{
 			$("#input_file").css("display","none");
 		}
 		/*zhangyan 2011-5-12 14:50:26 b*/
 
 	}
}
	function getbizcode()
	{
	    var getbizcode_Packet = new AJAXPacket("f2035_ajax.jsp","正在获取业务代码，请稍候......");
		getbizcode_Packet.data.add("retType","getbizcode");
	    getbizcode_Packet.data.add("id_no","<%=id_no%>");
	    getbizcode_Packet.data.add("region_code","<%=regionCode%>");
		core.ajax.sendPacket(getbizcode_Packet);
		getbizcode_Packet=null;
		//delete(getbizcode_Packet);
	}	

	function doProcess(packet)
	{
		var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		var retMessage = packet.data.findValueByName("retMessage");			
		if(retType=="getbizcode")
	    {
	    	if(retCode="000000")
	    	{ 
	    			var flag_1001 = packet.data.findValueByName("flag_1001");
	    			var flag_1002 = packet.data.findValueByName("flag_1002");
	    			var biz_code = packet.data.findValueByName("biz_code");
	    			document.all.flag_1001.value = flag_1001;
	    			document.all.flag_1002.value = flag_1002;
	    			document.all.biz_code.value = biz_code;
	    			//alert("--------"+flag_1001);
	    			//alert("sssssssssss="+flag_1002);
	    			
					if(flag_1001=="1")
					{
						document.all.addProduct_div.style.display="";
						document.all.addmodeflag.value="9"; //1001为1
						//alert("dddddddd="+document.all.addmodeflag.value);
					}
					//wuxy alter 20090819 增加支持只能集团付费模式
					if(flag_1002!="4")
					{
						var operType="<%=operType%>";
						
						if(operType=="1")
						{       
							if(flag_1001=="1")
							{
								document.all.addmodeflag.value="11"; //都为1 
								//alert( "jjjjjjjj="+document.all.addmodeflag.value);   					
							}
							else
							{  
							    document.all.addmodeflag.value="10"; //1002为1 
							}
							document.all.addProduct_div1.style.display="";  
							if(flag_1002=="2")
							{
								document.all.pay_flag.value="1";
								document.all.pay_flag.disabled=true;
							} 
							if(flag_1002=="0")
							{
								document.all.pay_flag.value="0";
								document.all.pay_flag.disabled=true;
							} 
							if(flag_1002=="1")
							{
								document.all.pay_flag.value="0";
							}  
							if(flag_1002=="3")
							{
								document.all.pay_flag.value="1";
							}  				
						}
					}
					if(flag_1001=="0"&&flag_1002=="4")
					{
						document.all.addmodeflag.value="0"; //全为0   
					}  			    				    			
	    	}
	    	else
	    	{		    	
	    		rdShowMessageDialog(retMessage);
	    	}
	    	//alert(document.all.addmodeflag.value);
	    }			
	}		
	function addColumn(a,b,c,d,e,f,g){
	  var tab = document.getElementById("productTab");	
	    
    var tmp_flag=false;
    
    tmp_flag = verifyUnique(a);
    
		if(tmp_flag == false)
		{
		  rdShowMessageDialog("已经有相同的号码，不能在重复添加!");
		  return false;
		}
    
    
		var t_row =tab.insertRow(-1);
		var t_cell1=t_row.insertCell(0);
		var t_cell2=t_row.insertCell(1);
		var t_cell3=t_row.insertCell(2);
		var t_cell4=t_row.insertCell(3);
		var t_cell5=t_row.insertCell(4);
		var t_cell6=t_row.insertCell(5);
		
		t_cell1.align="center";
		t_cell2.align="center";
		t_cell3.align="center";
		t_cell4.align="center";
		t_cell5.align="center";
		t_cell6.align="center";
		var saNo = "";
		if(showResultVal > 0){
			var t_cell7=t_row.insertCell(6);
			t_cell7.align="center";
			if(g.indexOf("->") == "-1"){
				/* 用户没选则销售代理商 */
				saNo = "";
				g = "";
			}else{
				saNo = g.substring(0,g.indexOf("->"));
			}
		}
		
		t_cell1.innerHTML="<input type=\"hidden\" name=\"tMemberProperty\" id=\"tMemberProperty\" value=\"\" ><input type=\"hidden\" id=\"tMemberNo\" name=\"tMemberNo\"  value=\""+a+"\" >"+a;
		
		t_cell1.childNodes("tMemberNo").value = a;
		t_cell1.childNodes("tMemberProperty").value = "";
		
		t_cell2.innerHTML="<input type=\"hidden\" name=\"tMemberType\" value=\""+b+"\" >"+f;
		t_cell3.innerHTML="<input type=\"hidden\" name=\"tMemberGroup\" value=\""+c+"\" >"+c+"&nbsp";
		t_cell4.innerHTML="<input type=\"hidden\" name=\"tBeginTime\" value=\""+d+"\" >"+d;	
		t_cell5.innerHTML="<input type=\"hidden\" name=\"tEndTime\" value=\""+e+"\" >"+e+"&nbsp";
		if(showResultVal > 0){
			t_cell6.innerHTML="<input type=\"hidden\" name=\"tSaHide\" value=\""+saNo+"\" >"+g+"&nbsp";
			t_cell7.innerHTML="<input type=\"button\" name=\"b_del\" value=\"删除\" class=\"b_text\" onclick=\"delColumn(this)\" >"+"&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"button\" name=\"b_getProperty2\" onclick=\"getPropertyMember2('"+a+"',this)\" class=\"b_text\" value=<%if(operType.equals("1")){%>添加成员属性<%}else{%>\"查看成员属性\"<%}%> >";
		}else{
			t_cell6.innerHTML="<input type=\"button\" name=\"b_del\" value=\"删除\" class=\"b_text\" onclick=\"delColumn(this)\" >"+"&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"button\" name=\"b_getProperty2\" onclick=\"getPropertyMember2('"+a+"',this)\" class=\"b_text\" value=<%if(operType.equals("1")){%>添加成员属性<%}else{%>\"查看成员属性\"<%}%> >";
		}


	}
	
	
	function verifyUnique(phone_no)
	{
		//alert(phone_no);
	    var tmp_phoneNo="";
	    //alert(document.all.productTab.rows.length);
	    for(var a = document.all.productTab.rows.length-1;a>0;a--)
	    {
	    	 //alert("ddss["+a+"]["+document.all.productTab.rows[a].childNodes[0].childNodes("tMemberNo")+"]");
	    	 //alert("ddss["+a+"]["+document.all.productTab.rows[a].childNodes[0].innerHTML+"]");
	    	 //alert("ddss["+a+"]["+document.all.productTab.rows[a].childNodes[0].childNodes[0].value+"]");
	    	 
	    	   //alert("Valid:"+document.all.productTab.rows[a].childNodes[0].childNodes[1].value);
		       tmp_phoneNo = document.all.productTab.rows[a].childNodes[0].childNodes[1].value;
		       //alert("Valid:"+tmp_phoneNo);
		       if( tmp_phoneNo && (tmp_phoneNo.trim() == phone_no.trim()))
		       {
		             return false;
		       }
		     
	    }
	
	       return true;
	}

	
	
	function addProductMem(){
		  var flag_1001=document.all.flag_1001.value;
		  var addProduct=document.all.addProduct.value;
		  if(flag_1001.trim()=="1"&&addProduct.trim()=="")
		  {
		  	rdShowMessageDialog("成员附加套餐不能为空!");
		  	return false;
		  }
	    if(check(form1)){
				var addColumnPacket = new AJAXPacket("f2035_ajaxAddColumn.jsp", "请稍候......");
				addColumnPacket.data.add("productId", "<%=productId%>");
				addColumnPacket.data.add("phoneNo", document.getElementById("memberNo").value);
				core.ajax.sendPacket(addColumnPacket, doAddColumn);
				getbizcode_Packet=null;
	    }
	   document.form1.beginTime.value=<%= currentYear%>;  
	}
	
	function doAddColumn (packet) {
		var ret = packet.data.findValueByName("ret");
		//alert(ret);
		if (ret == "0") {
			var memberNo = document.form1.memberNo.value;	
			var memberType = document.form1.memberType.value;	
			var memberGroup = document.form1.memberGroup.value;	
			var beginTime = document.form1.beginTime.value;	
			var endTime = document.form1.endTime.value;	
			var memberTypeInnerHtml = document.all.memberType.options[document.all.memberType.selectedIndex].innerText;
			var saVal = $("#SAType").find("option:selected").text();
			addColumn(memberNo,memberType,memberGroup,beginTime,endTime,memberTypeInnerHtml,saVal);
			initProductSelect();
		} else {
			rdShowMessageDialog("此成员已经存在！不允许重复添加", 1);
			return;
		}
	}
	
	function initProductSelect(){
		document.form1.memberNo.value="";	
	    //document.form1.memberType.value="0";	
	    document.form1.memberGroup.value="";	
	    document.form1.beginTime.value="";	
	    document.form1.endTime.value="";	
	    $("#pay_flag").find("option:not(:selected)").remove();
	}
	function delColumn(obj){
		var td = obj.parentNode;
		var tr = td.parentNode;
		tr.parentNode.removeChild(tr);
		var tabLen = document.all.productTab.rows.length;
		if(tabLen == 1){
		    $("#pay_flag").empty();
		    $("<option value='0' >集团付费</option> <option value='1' >个人付费</option>").appendTo("#pay_flag");
		    $("#selectAdditive").attr("disabled",false);
		    $("#addProduct").val("");
		    $("#addProduct_name").val("");
		}
	}
	function getPropertyMember(imemberNo,obj){
		var tr = obj.parentNode.parentNode;
		var tMemberProperty = tr.childNodes[0].childNodes[0];
		var winUrl = "f2035_3.jsp?memberNo="+imemberNo+"&productId=<%=productId%>"+"&operType=<%=operType%>&tMemberProperty="+tMemberProperty.value;
		var winResult=window.showModalDialog(winUrl,"","scroll:yes;dialogHeight:700px;dialogWidth:600px;dialogTop:458px;dialogLeft:166px");
		tMemberProperty.value =winResult;
		
	}
	//wangzn 091010
	function getPropertyMember2(imemberNo,obj){
		var tr = obj.parentNode.parentNode;
		var tMemberProperty = tr.childNodes[0].childNodes[0];
		var winUrl = "f2035_3_2.jsp?memberNo="+imemberNo+"&productId=<%=productId%>"+"&operType=<%=operType%>&tMemberProperty="+tMemberProperty.value+"&orgCode=<%=orgCode%>";
		var winResult=window.showModalDialog(winUrl,"","scroll:yes;dialogHeight:700px;dialogWidth:600px;dialogTop:458px;dialogLeft:166px");
		tMemberProperty.value =winResult;
		
	}
	
	function doCfm(){
		
		
		//wuxy add 20090812 本地车务通产品添加成员时，成员属性必须填写                                  
		var productSpecNum1=<%=productSpecNum.trim()%>;
		//if(productSpecNum1=="110903")
		//
		//{
		//	for(var a = 1;a<document.all.productTab.rows.length ; a++)
		//	{
		//		//alert(document.all.productTab.rows[a].childNodes[0].childNodes("tMemberProperty").value);
		//		if((document.all.productTab.rows[a].childNodes[0].childNodes("tMemberProperty").value=="")||(document.all.productTab.rows[a].childNodes[0].childNodes("tMemberProperty").value=="undefined"))
		//		{
		//			rdShowMessageDialog("本地车务通产品添加成员时，成员属性必须填写!");
		//		  return false;
		//		}
	 	//  }
    //}
   
		if(<%=result2[0][0]%>!='0'){
				for(var a = 1;a<document.all.productTab.rows.length ; a++)
				{
				  //alert((document.all.productTab.rows[a].childNodes[0].childNodes("tMemberProperty").value=="")||(document.all.productTab.rows[a].childNodes[0].childNodes("tMemberProperty").value=="undefined"));
					if((document.all.productTab.rows[a].childNodes[0].childNodes("tMemberProperty").value=="")||(document.all.productTab.rows[a].childNodes[0].childNodes("tMemberProperty").value=="undefined"))
					{
						rdShowMessageDialog("本产品添加成员时，成员属性必须填写!");
					  return false;
					}
		 	  }
		}
		var file_flag = document.getElementById("fileflag").value;
		/*zhangyan add 2011-5-12 8:52:00
		文件上传时要求成员无属性
		*/
		if ( file_flag==1 &&  <%=result2[0][0]%>!='0' )
		{
			rdShowMessageDialog("此产品规格成员拥有属性，不能以文件形式添加!");
			return false;
		}
		/*zhangyan add 2011-5-12 8:52:00 e*/

		document.all.pay_flag1.value=document.all.pay_flag.value;
		var confirmFlag=0;	
		confirmFlag = rdShowConfirmDialog("是否提交本次操作？");
		
		if (confirmFlag==1 && file_flag == "0") /*号码输入*/
		{
			document.form1.action="f2035_cfm.jsp";
			document.getElementById("nextoper").disabled=true;
			document.form1.submit();
		}else if ( confirmFlag==1 )/*文件录入*/
		{
		
			document.form1.target="hidden_frame";
			document.form1.encoding="multipart/form-data";
			document.form1.action="f2035_upload.jsp";
			document.form1.method="post";
			document.getElementById("nextoper").disabled=true;
			document.form1.submit();
			loading();
		}

		
	}
	
	function doFileCfm()
	{
		document.form1.target="_self";
		document.form1.encoding="application/x-www-form-urlencoded";
		document.form1.action="f2035_cfm.jsp";
		form1.method="post";
		form1.submit();
		loading();
	}
	
	function getAdditiveBill()
	{
	//var addMode = document.frm.addProduct.value;
	//alert(document.all.biz_code.value);
    var path = "pubAdditiveBill_3509.jsp";
    path = path + "?pageTitle=" + "可选资费选择";
    path = path + "&orgCode=" + "<%=orgCode%>";
	path = path + "&existModeCode=" ;
	path = path + "&biz_code=" + "<%=biz_code%>";
	path = path + "&product_code=" + "<%=productCode%>";
	path=  path +"&productId="+"<%=productId%>";
	path = path + "&userType=ADCA";
    var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:30;");
	if(typeof(retInfo) == "undefined")     
    {   
    	return false;   
    }
	var addiMode=retInfo.substring(0,retInfo.indexOf("|"));
	var addProduct_name=retInfo.substring(retInfo.indexOf("|")+2,retInfo.length-1);
    document.form1.addProduct.value      =  addiMode;
    document.form1.addProduct_name.value =  addiMode+"->"+addProduct_name;  
    document.form1.selectAdditive.disabled=true;
	}
	
	/*点击号码输入时*/
	function chkMeb()
	{
	
		$("#b_addProduct").css("display","block");
		$("#memberNoFile").css("display","none");
        $("#memberNo").css("display","block");
        $("#mebNo_info").css("display","none");
        $("#fileflag").val("0");
        $("#add_btn").css("display","block");
	}
	
	/*点击文件录入时*/
	function chkMebFile()
	{
		$("#b_addProduct").css("display","none");
		$("#memberNoFile").css("display","block");
        $("#memberNo").css("display","none");
        $("#mebNo_info").css("display","block");
        $("#fileflag").val("1")
		$("#add_btn").css("display","none");
	}
	
	$(document).ready(function(){
		if(showResultVal > 0){
			/*需要显示销售代理商*/
			$("#saContent1").show();
			$("#saContent2").show();
			$("#saTh").show();
		}else{
			/*不需要显示~~*/
			$("#saContent1").hide();
			$("#saContent2").hide();
			$("#saTh").hide();
		}
	});
</script>
</head>
<body>
<form name="form1" method="post">
	<input type="hidden" name="pageOpCode" value="<%=opCode%>">
	<input type="hidden" name="pageOpName" value="<%=opName%>">

	<input type="hidden" name="addmodeflag" value="3">
	<input type="hidden" name="flag_1001" value="">
	<input type="hidden" name="flag_1002" value="">
	<input type="hidden" name="biz_code" value="">
	<input type="hidden" name="pay_flag1" value="">
	<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
	<input type="hidden" name="hidden_cntSpec" value="<%=str_cntSpec%>">
	<input type="hidden" name="inputFile" value="">	
	<input type="hidden" id = "fileflag" name="fileflag" value="0" maxlength="8">
<%@ include file="/npage/include/header.jsp" %>
<div id="memInfo" style="display:none">
	<div class="title">
		<div id="title_zi">成员信息 </div>
	</div>
	<input type="hidden" name="productId" value="<%=productId%>" >
	<input type="hidden" name="operType" value="<%=operType%>" >
	<input type="hidden" name="orderSource" value="<%=orderSource%>" >
	<input type="hidden" name="endTime" value=""  v_type="date" maxlength="8">

	<table cellspacing="0">
		<tr >
			<td class="blue">成员号码</td>   
			<td>
				<div id = "input_file">
				<input type='radio' id='memberNo_type' name='memberNo_type' 
					onClick='chkMeb()' value='memberNo_type' checked/>号码输入 &nbsp;&nbsp;
           	 	
           	 	<input type='radio' id='memberNo_type' name='memberNo_type' 
           	 		onClick='chkMebFile()' value='memberNo_type' />文件录入
           		</div> 
           	</td>
			<td colspan =2>
				<input type="text" id="memberNo" name="memberNo"  v_type="0_9" value="" v_must="1" 
					v_type="string"　 maxlength="18">
 				<input type="file" id="memberNoFile"  name="memberNoFile" class="button" 
 					style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;display:none'/>			
 				<font class='orange' id = 'mebNo_info' name = 'mebNo_info' style = 'display:none'>
 					文件说明:上传文件格式必须为文本文件,一个号码一行,每次最多50号码。
 				</font>
 			</td>
 			
		</tr>
		
		<tr>
			<td class="blue">开始时间</td>   
			<td >
				<input type="text" name="beginTime" value="<%=currentYear%>" v_must="1" v_type="date" maxlength="8" readOnly>
			</td>   
			<!--<td class="blue">结束时间</td>  
			<td >
				
			</td>    -->
			<td class="blue">成员群组号</td>   
			<td>
				<input type="text" name="memberGroup" value=""  v_type="string"  maxlength="32" >
			</td>
		</tr> 
		<tr id="addProduct_div"  style="display:none">
			<td class="blue">成员附加套餐</td>
			<td colspan="3">
			<input name="addProduct" id="addProduct" class="button" type="hidden" v_must=1 v_maxlength=8 v_type="string" v_name="成员附加套餐" index="10" value="" >
		   	<input name="addProduct_name" id="addProduct_name" class="button" type="text" v_must=1 v_maxlength=20  v_name="成员附加套餐" index="20" value="" readOnly >
		   	<input class="b_text" id="selectAdditive" name="selectAdditive" onMouseUp="if(event.keyCode==13)getAdditiveBill()" onClick="getAdditiveBill()" style="cursor:hand" type=button value=选择  index="20" >
		   	<font color="#FF0000">*</font>
		   	</td>
		</tr>
		<tr  style="">
			<td class="blue">成员类型</td>   
			<td >
				<select name="memberType" id="memberType">
					<option value="1" >签约成员</option>	
					<option value="2" >白名单</option>
					<option value="0" >黑名单</option>
				</select>
			</td>
			<td id="saContent1" class="blue">销售代理商</td>   
			<td id="saContent2">
				<select name="SAType" id="SAType">
					<option value="" >--请选择--</option>
					<%
						if(saListResult != null && saListResult.length > 0){
							for(int saList_i = 0; saList_i < saListResult.length; saList_i++){
					%>
						<option value="<%=saListResult[saList_i][0]%>" ><%=saListResult[saList_i][0]%>-><%=saListResult[saList_i][1]%></option>
					<%
							}
						}
					%>
				</select>
			</td>
			   
		</tr>
		
		<tr id="addProduct_div1"  style="display:none">
			<td class="blue">付费方式</td>
			<td colspan="3">
				<select name="pay_flag" id="pay_flag">
					<option value="0" >集团付费</option>	
					<option value="1" >个人付费</option>
				</select>
			</td>
		</tr>		
		
			<tr>
			<td align="center" colspan="4" >
				<input  type="button" class="b_text" id = "b_addProduct" name="b_addProduct" value="增加" onclick="addProductMem()" >
			</td>  
		</tr>
	</table>
</div>
</div>
<wtc:pubselect name="sPubSelect" outnum="8">
    <wtc:sql></wtc:sql>
    <wtc:param value="<%=productId%>"/>
</wtc:pubselect>
<wtc:array id="rows"  scope="end" />
	

<div id="Operation_Table">
<div class="title">
	<div id="title_zi">成员信息列表 </div>
</div>

<table cellspacing="0" id="productTab" >
	<tr align="center">
		<th nowrap>成员号码</th>
		<th nowrap>成员类型 </th>
		<th nowrap>成员群组</th>   
		<th nowrap>开始时间</th>   
		<th nowrap>结束时间</th>  
		<th id="saTh" nowrap>销售代理商</th>
		<th nowrap>添加成员属性</th>
	</tr>
	<%
		for(int i=0;i<rows.length;i++){
		tMemberProperty = "";
	%>
	<tr align="center">
		<wtc:pubselect name="sPubSelect" outnum="5">
			<wtc:sql>select trim(character_id)||'*'||trim(character_name)||'*'||trim(character_value) from dproductSignOtherAdd where product_id = '?' and member_no = '?'</wtc:sql>
			<wtc:param value="<%=productId%>"/>
			<wtc:param value="<%=rows[i][0]%>"/>
		</wtc:pubselect>
		<wtc:array id="rows1"  scope="end" /> 
	<%
	
		for(int j=0;j<rows1.length;j++){
		tMemberProperty += rows1[j][0].trim()+"@";
		}
	
	%>	   	
		<td nowrap>
			<input type="hidden" name="tMemberProperty" id="tMemberProperty" value="<%=tMemberProperty%>" >
			<input type="hidden" name="tMemberNo" value="<%=rows[i][0]%>" ><%=rows[i][0]%>
		</td>
			<td nowrap><input type="hidden" name="tMemberType" value="<%=rows[i][1]%>" ><%=rows[i][1]%></td>
			<td nowrap><input type="hidden" name="tMemberGroup" value="<%=rows[i][2]%>" ><%=rows[i][2]%></td>   
			<td nowrap><input type="hidden" name="tBeginTime" value="<%=rows[i][3]%>" ><%=rows[i][3]%></td>   
			<td nowrap><input type="hidden" name="tEndTime" value="<%=rows[i][4]%>" ><%=rows[i][4]%></td>
			<td nowrap>
				<input type="button" name="b_del" value="删除" class="b_text" onclick="delColumn(this)" style="display:none">
				&nbsp;&nbsp;
				<input type="button" name="b_getProperty" onclick="getPropertyMember('<%=rows[i][0]%>',this)" class="b_text" value=<%if(operType.equals("1")){%>添加成员属性<%}else{%>查看成员属性<%}%>>
		</td>
	</tr>
	<%
	}
	%>
</table>

<table cellSpacing=0> 
	<tr>
		<td align="center" id="footer" colspan="4">
			<%
			if(!"0".equals(operType))
			{
			%>
				<input class="b_foot" name=next id=nextoper type=button value="提交" onclick="doCfm()" >
			<%
			}
			%>
			<input class="b_foot" name=next id=nextoper1 type=button value="返回" onclick="history.go(-1)" >
			<input class="b_foot" name=reset type=button value="关闭" onClick="removeCurrentTab()">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
<input type="hidden" name="operType" value="<%=operType%>">
</FORM>
</BODY>
</HTML>
