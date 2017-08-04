<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)[]------------------
 
 
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

	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%> 
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" />	
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>

//手机号码
var PHONE_NO      = "";
//初始化IMEI授权终端类型 N=手机  H=pad
var ARR_IMEI_TYPE = new Array("N","H");


/**
 * 比较2个日期相差的天数
 * 入参strDateStart 开始时间，必须小于结束时间
 * 入参strDateEnd   结束时间  必须大于开始时间
 * 时间格式均为 YYYYmmdd
 * 如 20161101 到 20161110 返回结果为9
 */
onload=function(){	  
  getIdCitys();
  getShopInfo();
}
function getIdCitys(){
	var pactket = new AJAXPacket("m494_ajax.jsp","正在进行13个地市查询，请稍候......");
 	
			pactket.data.add("opCode","<%=opCode%>");
			
			core.ajax.sendPacketHtml(pactket,do_Query);
			pactket=null;
}
function getShopInfo(){
	var shop = $('#shopInfo option:selected').val();
	var pactket = new AJAXPacket("m494_ajax1.jsp","正在进行信息查询，请稍候......");
 	//alert("shop:"+shop);
	pactket.data.add("opCode","<%=opCode%>");
	pactket.data.add("shop",shop);
	core.ajax.sendPacket(pactket,do_Query1);
	pactket=null;
}
function do_Query(data){
	//alert(data);
			//找到添加的select
				var markDiv=$("#tdappendSome"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(data);
}	
function do_Query1(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
		var retArray = packet.data.findValueByName("retArray");
		//alert(retArray);
		var markDiv=$("#tb_ifof2"); 
		//清空原有表格
		markDiv.empty();
		if ($("#tb_ifof2 th").length==0 )
		{
			$("#tb_ifof2").append("<tr>"
				+"<th align='center' width='20%'>地市名称</th>"
				+"<th align='center' width='20%' >手机号码</th>"
				+"<th align='center' width='20%' >开户总金额</th>"
				+"<th align='center' width='20%' >操作时间</th>"
				+"<th align='center' width='20%' >操作</th>"
			+"</tr>");
		}	
		for(var i=0;i<retArray.length;i++){
			$("#tb_ifof2").append("<tr>"
					+"<td align='center'>"
						+"<input type='text' name='o_addId'  ch_name='地市名称' value='"+retArray[i][0]+"' class='InputGrey' readOnly >"
						+"<input type='hidden' name='o_backFlag' id='o_backFlag"+i+"'  ch_name='' value='"+retArray[i][1]+"'>"
						+"<input type='hidden' name='o_regionCode' id='o_regionCode"+i+"'  ch_name='' value='"+retArray[i][4]+"'>"
					+"</td>"
					+"<td align='center'>"
						+"<input type='text' name='o_addName'  ch_name='手机号码' value='"+retArray[i][1]+"' class='InputGrey' readOnly >"
					+"</td>"	
					+"<td align='center'>"
						+"<input type='text' name='o_efftime'  ch_name='开户总金额' "
							+"  value='"+retArray[i][2]+"' class='InputGrey' readOnly >"
					+"</td>"				
					+"<td align='center'>"
						+"<input type='text' name='o_exptime'  ch_name='操作时间' "
							+" value='"+retArray[i][3]+"' class='InputGrey' readOnly >"
					+"</td>"		
														
					+"<td align='center'>"
						+"<input type ='button' value='撤单' class='b_text'  id='b_back"+i+"' "
							+"style='cursor:Pointer;' class='del_cls'  alt='' "  
									
							+" onclick='fn_back("+i+")'>"	
											
											
					+"</td>"		
				+"</tr>");	
				
		}
		
		
		
	}else{
		rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
	
}

function fn_back( i )
{
	$("#b_back"+i).attr("disabled" , true);
	var pactket = new AJAXPacket("m494_chk.jsp","正在进行信息查询，请稍候......");
	pactket.data.add("iLoginAccept" 		,'<%=loginAccept%>');
	pactket.data.add("iChnSource" 		,"01");
	pactket.data.add("iOpCode" 			,"<%=opCode%>");
	pactket.data.add("iLoginNo" 			,"<%=workNo%>");
	pactket.data.add("iLoginPwd" 		,"<%=password%>");
	pactket.data.add("iPhoneNo" 			,$('#o_backFlag'+i).val());
	pactket.data.add("iUserPwd" 			,"");
	pactket.data.add("iRegionCode"      ,$('#o_regionCode'+i).val());
	
	core.ajax.sendPacket(pactket,function(pactket){
		var code = pactket.data.findValueByName('code');
		var msg = pactket.data.findValueByName('msg');
		//alert(code+":"+msg);
		if ("000000" == code){
			if(!check(msgFORM)) return false;
			//show_bill_Prt();//打印发票
		  //var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
		 	
			var myPacket = new AJAXPacket("m494_orderDraw.jsp","服务正在提交，请稍候...");
			myPacket.data.add("accept",'<%=loginAccept%>' );
			myPacket.data.add("opCode", '<%=opCode%>');
			myPacket.data.add("phoneNo", $('#o_backFlag'+i).val());
			
			core.ajax.sendPacket(myPacket, function(packet){
					
					alert(errorCode+"aa:bb"+errorMsg);
					var errorCode = packet.data.findValueByName('errorCode');
					var errorMsg = packet.data.findValueByName('errorMsg');
					if(rdShowConfirmDialog("确认要提交信息吗？")!=1) return;
					if ("000000" == errorCode){
							rdShowMessageDialog("撤单成功！");
					} else {
							rdShowMessageDialog("撤单失败！" + errorCode + errorMsg, 1);
					}
			});
			
			myPacket = null;
		}else{
			rdShowMessageDialog("撤单失败！" + code + msg, 2);
		}
	});
	pactket=null;
	
			
			
	
}
function fn_chk(i)//二代证
{
	
}
function do_chk(){
	
}

function change_idType()//二代证
{
	var city = document.all.idType.value;
	if(document.all.idType.value=="00")
    { 
      /*ajax\*/
		//var packet = new AJAXPacket("fm494_ajax1.jsp","请稍后...");
		//packet.data.add("iLoginAccept" 		,"");
		//packet.data.add("iChnSource" 		,"01");
		//packet.data.add("iOpCode" 			,"");
		
	 
		//core.ajax.sendPacket(packet		,fn_doQryMPIfo,true);//异步	
   		
    	
    }
}	
<%--
function getDays(strDateStart,strDateEnd){
	
   var strDateS = new Date(
   													parseInt(strDateStart.substring(0,4)), 
   													parseInt(strDateStart.substring(4,6))-1, 
   													parseInt(strDateStart.substring(6,8))
   												);
   												
   var strDateE = new Date(  
   													parseInt(strDateEnd.substring(0,4)),   
   													parseInt(strDateEnd.substring(4,6))-1,   
   													parseInt(strDateEnd.substring(6,8))
   											  );
   
   var iDays = parseInt(Math.abs(strDateE - strDateS ) / 1000 / 60 / 60 /24)//把相差的毫秒数转换为天数
   
   return iDays ;
}

//重置刷新页面
function reSetThis(){
	  location = location;	
}


//查询客户基础信息
function getAjaxInfo(){
    var packet = new AJAXPacket("ajaxGetServRe.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("cust_name",$("#cust_name").val());//
    core.ajax.sendPacket(packet,doGetAjaxInfo);
    packet =null;
}
//查询客户基础信息回调
function doGetAjaxInfo(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//操作成功
	    rdShowMessageDialog("操作成功",2);
    	reSetThis();
    }
}

//
function go_Query(){
	if($("#phoneNo").val().trim()==""){
		rdShowMessageDialog("请输入手机号码");
		return;
	}
	//m239·物联网业务开通状态查询  打印免填单后调用服务更新状态
 	var pactket = new AJAXPacket("/npage/sm390/fm390UpDserv.jsp","正在进行电子工单状态修改，请稍候......");
			pactket.data.add("id_no","0");
			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("paySeq",$("#accepts").val().trim());
			core.ajax.sendPacket(pactket,do_Query);
			pactket=null;
}

--%>





<%--
//打印收据
function show_bill_Prt(){
 	     
	  	var  billArgsObj = new Object();

			$(billArgsObj).attr("10001","<%=workNo%>");     //工号
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005","<%=custName%>");   //客户名称
			$(billArgsObj).attr("10006","NFC城市通卡");    //业务类别
			$(billArgsObj).attr("10008","<%=activePhone%>");    //用户号码
			$(billArgsObj).attr("10015","20");   //本次发票金额
			$(billArgsObj).attr("10016","20");   //大写金额合计
			$(billArgsObj).attr("10017","*");        //本次缴费：现金
			$(billArgsObj).attr("10030","<%=loginAccept%>");   //流水号：--业务流水
			$(billArgsObj).attr("10036","<%=opCode%>");   //操作代码
	    $(billArgsObj).attr("10071","6");	//模板
 			$(billArgsObj).attr("10078", ""); //宽带品牌	
 			$(billArgsObj).attr("10083", ""); //证件类型
 			$(billArgsObj).attr("10084", ""); //证件号码
 			$(billArgsObj).attr("10085", "zsj"); //宽带费用收取方式 只弹出打印收据的框
 			$(billArgsObj).attr("10086", "尊敬的用户，如您需要开具公交卡20元代收费发票，请携带已开通移动城市通功能并实名制绑定的SIM卡片于开卡30日内至城市通指定网点领取发票，网点信息可关注城市通微信平台(hrbcst)查询，客服电话：95105188。"); //备注
 			
 			$(billArgsObj).attr("10072","0"); //计费xuxz要求写死
 			//$(billArgsObj).attr("10088","m404"); //收据模块
 			

 			
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			
			$(billArgsObj).attr("11213","REC");  //新版发票新增票据标志位，默认空位发票 REC = 收据
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "确实要进行发票打印吗？";
			
			
			var path = path +"&loginAccept=<%=loginAccept%>&opCode=<%=opCode%>&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);
			
}--%>

<%--
function frmCfm(){
	  frm.submit();
	  return true;
}

function showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	  var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	  var sysAccept =<%=loginAccept%>;             	//流水号
	    var printStr = printInfo(printType);
	  
		                      //调用printinfo()返回的打印内容
	  var mode_code=null;           							  //资费代码
	  var fav_code=null;                				 		//特服代码
	  var area_code=null;             				 		  //小区代码
	  var opCode="<%=opCode%>" ;                   			 	//操作代码
	  var phoneNo="<%=activePhone%>";                  //客户电话
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode=<%=opCode%>&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				
//打印模板id为：
function printInfo(printType){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="手机号码：   "+"<%=activePhone%>"+"|";
	  cust_info+="客户姓名：   "+"<%=custName%>"+"|";
	  opr_info +="业务类型：终端型号捆绑套餐办理    操作流水: "+"<%=loginAccept%>" +"|";
	  opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "   " + "用户品牌：" + $('#band_ids').text()+ "|";
	  opr_info += "本次申请可选套餐："+$('#offerIdSel').find('option:selected').text()+"|";
	  opr_info += "IMEI码:"+$("#imeino").val()+"|";
	  opr_info += "资费描述："+ $('#offercomments').text()+"|";
	  
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
$(document).ready(function(){
	//自动查询已经鉴权的IMEI列表
	ajaxGetAndroidCrmUpgList();
});
--%>
//展示移动商城超时能撤单信息
function fn_doQryMPIfo( packet )
{
	<%--var v_oRetCode=packet.data.findValueByName("code");
	var v_oRetMsg=packet.data.findValueByName("msg");
	
	if ( "000000"==v_oRetCode )
	{

		var v_jsn=packet.data.findValueByName("retArray") ;

		var v_jsn1 = JSON.parse(v_jsn,function(key,value){
			return value;
		});
		
		document.all.showText.value=v_jsn;
		if ($("#tb_ifof2 th").length==0 )
		{
			$("#tb_ifof2").append("<tr>"
				+"<th align='center' >地市名称</th>"
				+"<th align='center' >手机号码</th>"
				+"<th align='center' >开户总金额</th>"
				+"<th align='center' >操作时间</th>"
				
			+"</tr>");
		}		
		
		var i=0;

		while (v_jsn1.ProdInfo[i]!=null )
		{
			var j=0;
			var s_ServiceID="";
			var s_AttrKey="";
			var s_AttrValue="";
			
			if (v_jsn1.ProdInfo[i].ProdAttrInfo!=null)
			{
				while ( v_jsn1.ProdInfo[i].ProdAttrInfo[j]!=null  )
				{
					s_ServiceID=s_ServiceID+v_jsn1.ProdInfo[i].ProdAttrInfo[j].ServiceID+"@";
					s_AttrKey=s_AttrKey+v_jsn1.ProdInfo[i].ProdAttrInfo[j].AttrKey+"@";
					s_AttrValue=s_AttrValue+v_jsn1.ProdInfo[i].ProdAttrInfo[j].AttrValue+"@";
					j=j+1;
				}				
			}
			
			
			var ret_S = "";
			var is_disabled = "";
			
			if("A"==v_jsn1.ProdInfo[i].State){
				ret_S = "正常";
			}else if("F"==v_jsn1.ProdInfo[i].State){
				ret_S = "暂停";
			}else{
				ret_S = "已退订";
				is_disabled = "disabled";
			}
			
			
			var v_dis = v_jsn1.ProdInfo[i].State=="A" ? "disabled" :" ";
			
			$("#tb_ifof2").append("<tr>"
				+"<td align='center'>"
					+"<input type='text' name='o_addId'  ch_name='地市名称' value='"+v_jsn1.ProdInfo[i].OfferId+"' class='InputGrey' readOnly >"
					+"<input type='hidden' name='o_backFlag' id='o_backFlag"+i+"'  ch_name='' value='0'>"
					+"<input type='hidden' name='o_ServiceID' id='o_ServiceID"+i+"'  ch_name='' value='"+s_ServiceID+"'>"
					+"<input type='hidden' name='o_AttrKey' id='o_AttrKey"+i+"'  ch_name='' value='"+s_AttrKey+"'>"
					+"<input type='hidden' name='o_AttrValue' id='o_AttrValue"+i+"'  ch_name='' value='"+s_AttrValue+"'>"
				+"</td>"
				+"<td align='center'>"
					+"<input type='text' name='o_addName'  ch_name='手机号码' value='"+v_jsn1.ProdInfo[i].OfferName+"' class='InputGrey' readOnly >"
				+"</td>"	
				+"<td align='center'>"
					+"<input type='text' name='o_efftime'  ch_name='开户总金额' "
						+"  value='"+v_jsn1.ProdInfo[i].ProdInstEffTime+"' class='InputGrey' readOnly >"
				+"</td>"				
				+"<td align='center'>"
					+"<input type='text' name='o_exptime'  ch_name='操作时间' "
						+" value='"+v_jsn1.ProdInfo[i].ProdInstExpTime+"' class='InputGrey' readOnly >"
				+"</td>"		
				+"<td align='center' width='50px'>"
					+
					 ret_S
				+"</td>"										
				+"<td align='center'>"
					+"<input type ='button' value='退订' class='b_text'  id='b_back"+i+"' "
						+"style='cursor:Pointer;' class='del_cls'  alt='' "  
						
						+  
						is_disabled
						
						+" onclick='fn_back("+i+")'>"	
											
				+"</td>"		
			+"</tr>");	
			i=i+1;		
		}	
	}
	else
	{
		rdShowMessageDialog(v_oRetCode+":"+v_oRetMsg , 0);	
		return false;	
	}--%>	
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>
<table  id='tb_ifof1'>
	<tr>
		<td class="blue" width="16%">地市</td>
		<td class="blue" id="tdappendSome" >
				
		</td>
	</tr>
</table>
<div class="title" >
			<div id="title_zi">移动商城超时</div>
		</div>
		<table   id='tb_ifof2'>
			<tr>
				<th>地市名称</th>		
				<th>手机号码</th>		
				<th>开户总金额</th>		
				<th>操作时间</th>	
				<th>操作</th>						
			</tr>
		</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>




<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>