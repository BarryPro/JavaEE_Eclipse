<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)[2017/3/6 星期一 13:37:11]------------------
 
 
 -------------------------后台人员：[]--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");

%> 
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>

<SCRIPT language=JavaScript>

//重置刷新页面
function reSetThis(){
	  location = location;	
}


//
function go_Query(){
	if($("#in_unitid").val().trim()==""&&$("#in_ecid").val().trim()==""&&$("#in_productofferId").val().trim()==""){
		rdShowMessageDialog("集团编码、EC集团编码、订购关系id最少输入一个项目");
		return;
	}
	
	if($("#in_starttime").val().trim()==""){
		rdShowMessageDialog("归档日期开始必须输入");
		return;
	}
	
	if($("#in_endtime").val().trim()==""){
		rdShowMessageDialog("归档日期结束必须输入");
		return;
	}
 	var pactket = new AJAXPacket("fm461_Qry.jsp","正在进行查询，请稍候......");
 			
 			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("in_unitid",$("#in_unitid").val().trim());
			pactket.data.add("in_ecid",$("#in_ecid").val().trim());
			pactket.data.add("in_productofferId",$("#in_productofferId").val().trim());
			pactket.data.add("in_starttime",$("#in_starttime").val().trim());
			pactket.data.add("in_endtime",$("#in_endtime").val().trim());
			pactket.data.add("sel_opType",$("#sel_opType").val().trim());
			
			core.ajax.sendPacket(pactket,do_Query);
			pactket=null;
}

// 回调
function do_Query(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
		
			var opType = $("#sel_opType").val();
			$("#sel_opType").attr("disabled","disabled");
			if("del"==opType){
				$("#td_htd5").hide();
			}
			
			var retArray = packet.data.findValueByName("retArray");
			//获取数组成功，动态拼接列表
			var trObjdStr = "";
			//第二次以后查询会有多余行数据，所以删除除了title以外行的数据
			$("#upgMainTab tr:gt(0)").remove();
			
			var btn_objStr = "";
			var td5_style  = "";
			
			for(var i=0;i<retArray.length;i++){
					if("add"==opType){
							btn_objStr = "<input type=\"button\" value=\"出库\" class=\"b_text\" onclick=\"go_Cfm(this,'add')\">";
					}
					
					if("del"==opType){
							td5_style  = "style='display:none'";
							btn_objStr = "<input type=\"button\" value=\"回库\" class=\"b_text\" onclick=\"go_Cfm(this,'del')\">";
					}
					
					
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ //
														 "<td>"+retArray[i][1]+"</td>"+ //
														 "<td>"+retArray[i][2]+"</td>"+ //
														 "<td>"+retArray[i][3]+"</td>"+//
														 "<td "+td5_style+"><input type='text' style='width:50px;' value='50' maxlength='3' ></td>"+//
														 "<td>"+btn_objStr+"</td>"+//
												 "</tr>";
			}
			
			//将拼接的行动态添加到table中
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}



function go_Cfm(bt,optype){
	
		var trObj = $(bt).parent().parent();

		var iImeiNo  = trObj.find("td:eq(1)").text().trim();//获取imei号码
		var iMember_No  = trObj.find("td:eq(0)").text().trim();//获取成员终端序列号
		var fee = trObj.find("input").val().trim();//押金
	
		
		
		if("add"==optype){//进行出库操作
				var td0_text = trObj.find("input").val().trim();
				

				if(td0_text==""){
						rdShowMessageDialog("请输入押金金额");
						return;
				}
				
				var reg = /^\d{1,3}$/;
				if(!reg.test(td0_text)){
						rdShowMessageDialog("押金金额只能输入0-200之间的数字1");
						return;
				}
				
				if(Number(td0_text)<0||Number(td0_text)>200){
						rdShowMessageDialog("押金金额只能输入0-200之间的数字");
						return;
				}

		if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
		var pactket = new AJAXPacket("fm461_Cfm.jsp","正在出库，请稍候......");
 			
 			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("iImeiNo",iImeiNo);
			pactket.data.add("optype",optype);
			pactket.data.add("iMember_No",iMember_No);
			pactket.data.add("fee",fee);
			core.ajax.sendPacket(pactket,do_Cfm);
			pactket=null;
		
		
		}


		if("del"==optype){//进行回库操作

			if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
		var pactket = new AJAXPacket("fm461_Cfm.jsp","正在回库，请稍候......");
 			
 			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("iImeiNo",iImeiNo);
			pactket.data.add("optype",optype);
			pactket.data.add("iMember_No",iMember_No);
		
			core.ajax.sendPacket(pactket,do_Cfm);
			pactket=null;
		}
		
}

//回调
function do_Cfm(pactket){
	var code = pactket.data.findValueByName("code");
	var msg  = pactket.data.findValueByName("msg"); 
	var retArray  = pactket.data.findValueByName("retArray"); 
	var optype = 	pactket.data.findValueByName("optype");
	if (optype=="add") {
		var fee = 	pactket.data.findValueByName("iSale_Price");
	}else{
		var fee = 	retArray[0][6]; //押金
	}
	


	//alert(fee);
	//alert(retArray[0][0]);//a 终端id
	//alert(retArray[0][1]);//b imei号码
	//alert(retArray[0][2]);//c 品牌名称：企业互联网电视
	//alert(retArray[0][3]);//d 证件类型：企业代码
	//alert(retArray[0][4]);//e 证件号码：
	//alert(retArray[0][5]);//f 客户名称
	if(code=="000000"){	
		go_Query();
		show_bill_Prt(optype,fee,retArray[0][0],retArray[0][1],retArray[0][2],retArray[0][3],retArray[0][4],retArray[0][5]);//打印发票
	}else{
		rdShowMessageDialog("失败，"+code+"："+msg,0);
	}
}

//打印收据
function show_bill_Prt(optype,fee,a,b,c,d,e,f){
	 
	  	var  billArgsObj = new Object();

			$(billArgsObj).attr("10001","<%=workNo%>");     //工号
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005",f);   //客户名称
			$(billArgsObj).attr("10007",""); //客户品牌
			$(billArgsObj).attr("10008","");    //用户号码
			$(billArgsObj).attr("10015",fee);   //本次发票金额
			$(billArgsObj).attr("10016",fee);   //大写金额合计
			$(billArgsObj).attr("10017","*");        //本次缴费：现金
			$(billArgsObj).attr("10030","<%=loginAccept%>");   //流水号：--业务流水
			$(billArgsObj).attr("10036","<%=opCode%>");   //操作代码
	    $(billArgsObj).attr("10071","6");	//模板
 			$(billArgsObj).attr("10078", ""); //宽带品牌	
 			$(billArgsObj).attr("10087", b); //imei号码
 			$(billArgsObj).attr("10083", d); //证件类型
 			$(billArgsObj).attr("10084", e); //证件号码
 			$(billArgsObj).attr("10055",a);	//模板
 			
 			$(billArgsObj).attr("10072","0"); //计费xuxz要求写死
 			
	 	  $(billArgsObj).attr("10086", "尊敬的客户，如您办理业务退订、取消等中止业务使用的操作时，请携带本收据、有效身份证件、办理业务时所得魔百和终端到移动指定自有营业厅办理押金退还手续。"); //备注
			
			if(optype=="add"){
 					$(billArgsObj).attr("10006","企业互联网电视出库");   //操作类型
 				}else{
 					$(billArgsObj).attr("10006","企业互联网电视回库");   //操作类型
 				}
 		
 			
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			
			$(billArgsObj).attr("11213","REC");  //新版发票新增票据标志位，默认空位发票 REC = 收据
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "确实要进行发票打印吗？";
			
			
			var path = path +"&loginAccept=<%=loginAccept%>&opCode=<%=opCode%>&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
			
}


</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue">操作类型</td>
		  <td colspan="3">
		  	<select id="sel_opType" name="sel_opType" >
				    <option value="add">出库</option>
				    <option value="del">回库</option>
				</select>
		  </td>
		  
	</tr>
	
	<tr>
	    <td class="blue">集团编码</td>
		  <td>
			    <input type="text" name="in_unitid" id="in_unitid" value=""   /> 
		  </td>
		  <td class="blue" >EC集团编码</td>
		  <td>
		  	 <input type="text" name="in_ecid" id="in_ecid" value=""   /> 
		  </td>
	</tr>
	
	<tr>
	    <td class="blue">订购关系ID</td>
		  <td>
			    <input type="text" name="in_productofferId" id="in_productofferId" value=""   /> 
		  </td>
		  <td class="blue" >归档日期开始</td>
		  <td>
			    <input type="text" name="in_starttime" id="in_starttime" value="20170101"  onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />  
		  </td>
	</tr>
	
	<tr>
		  <td class="blue" >归档日期结束</td>
		  <td>
			    <input type="text" name="in_endtime" id="in_endtime" value="20170201"  onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />  
		  </td>
	</tr>
	
</table>


<div class="title"><div id="title_zi">企业互联网电视成功归档的成员信息列表</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="20%">成员终端序列号</th>
        <th width="20%">IMEI码</th>
        <th width="20%">归档时间</th>
        <th width="20%">终端归属机构</th>	
        <th id="td_htd5">押金金额</th>	
        <th width="10%" >操作</th>	
    </tr>
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="查询" onclick="go_Query()"          />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>