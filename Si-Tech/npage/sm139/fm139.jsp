<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
    
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName"); 
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	String stypesql = "select t.region_code,t.region_name from sregioncode t where t.use_flag = 'Y' order by t.group_id";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_type" retmsg="retMsg_type" outnum="2"> 
	<wtc:param value="<%=stypesql%>"/>
</wtc:service>  
<wtc:array id="result1"  scope="end"/>
	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
// 列表
function query(){
	var region_code = $("#region_code").val();
	if(region_code==""){
		rdShowMessageDialog("请选择地市名称！");
		return false;
  }
	var myPacket = new AJAXPacket("fm139_qry.jsp","正在查询信息，请稍候......");
  myPacket.data.add("region_code",region_code);
  myPacket.data.add("opCode","<%=opCode%>");
  core.ajax.sendPacketHtml(myPacket,doQuery);
  getdataPacket = null;
}

function doQuery(data){
	$("#simNo").val("");
	$("#hlrCode").val("");
	$("#simNoTr").css("display","none");
  //找到添加表格的div
	var markDiv=$("#intablediv"); 
	markDiv.empty();
	markDiv.append(data);
	/* 结果隔行渐变样式 */
	$("table[vColorTr='set']").each(function(){
		$(this).find("tr").each(function(i,n){
			$(this).bind("mouseover",function(){
				$(this).addClass("even_hig");
			});
			
			$(this).bind("mouseout",function(){
				$(this).removeClass("even_hig");
			});
			
			if(i%2==0){
				$(this).addClass("even");
			}
		});
	});
	
  var retCode = $("#retCode").val();
  var retMsg = $("#retMsg").val();
  if(retCode!="000000"){
		rdShowMessageDialog("查询失败！错误代码："+retCode+"<br>错误信息："+retMsg,0);
		window.location.href="fm139.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
  }
}

function schangeCard(phone){
	$("#simNo").val("");
	$("#hlrCode").val("");
	$("#sphones").val(phone);
	$("#simNoTr").css("display","block");
}

function sclickopr(phone,custname,offerid,dizhi,lianxiren,lianxiphone,youbian,dishi,iccid){
   $("#sphoneskh").val(phone);
   $("#custnamekh").val(custname);
   $("#offeridkh").val(offerid);
   $("#dizhikh").val(dizhi);
   $("#lianxirenkh").val(lianxiren);
   $("#lianxiphonekh").val(lianxiphone);
   $("#youbiankh").val(youbian);
   $("#dishikh").val(dishi);
   $("#iccidkh").val(iccid);
   
   
		 document.frm139.action="fm142.jsp";
		 document.frm139.submit();
}

function subInfo(){
	var simNo = $("#simNo").val();
	if(simNo==""){
		rdShowMessageDialog("请输入sim卡号！");
		return false;
  }
  
  var v_phoneNo = $("#sphones").val(); 

	var myPacket = new AJAXPacket("fm139SimJH.jsp","正在查询信息，请稍候......");
  myPacket.data.add("simNo",simNo);
  myPacket.data.add("phoneNo",v_phoneNo);
  core.ajax.sendPacket(myPacket,doSubInfo);
  getdataPacket = null;
}

function doSubInfo(packet){
	var retCode = packet.data.findValueByName("retCode2");
	var retMsg =  packet.data.findValueByName("retMsg2");
	if(retCode != "000000"){
		rdShowMessageDialog("换卡失败！错误代码："+retCode+"<br>错误信息："+retMsg,0);
		//window.location.href="fm139.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}else{
		rdShowMessageDialog("换卡成功！",2);
		window.location.href="fm139.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
}

function querySimInfos() {

	var simNo = $("#simNo").val();
	if(simNo==""){

  }else {
	var myPacket = new AJAXPacket("getHlrCode.jsp","正在提交，请稍候......");	
	myPacket.data.add("simNo",simNo);
	core.ajax.sendPacket(myPacket,doGetHlrCode);
	myPacket=null;
	}
}
function doGetHlrCode(packet)
{
	document.all.hlrCode.value = packet.data.findValueByName("result");
}

function getPhoto(zheng,fan,three)
{
//alert(zheng);
//alert(fan);
	window.open("fgetIccIdPhoto.jsp?photozheng="+zheng+"&photofan="+fan+"&three="+three,"","width="+(screen.availWidth*1-900)+",height="+(screen.availHeight*1-150) +",left=450,top=240,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
}

function changeSel(obj){
	
	var line = $(obj).attr("line");

	var str = '<span name="noSpan">'
						+'<br/>'
						+'<input type="radio" name="noPass_'+line+'" value="1" />身份证不清晰<br/>'
						+'<input type="radio" name="noPass_'+line+'" value="2" />图片不合格<br/>'
						+'<input type="radio" name="noPass_'+line+'" value="3" />身份证信息与填报信息不一致<br/>'
						+'<input type="radio" name="noPass_'+line+'" value="4" />身份证不在有效期<br/>'
						+'<input type="radio" name="noPass_'+line+'" value="5"/>其他内容<textarea rows="2" cols="18" onkeyup="this.value = this.value.slice(0, 100)"></textarea>'
						+'</span>';
	if($(obj).val() == "1"){
		$(obj).after(str);
	}else if($(obj).val() == "0"){
		$(obj).parent().find("span").remove();
	}
}

	function shenhe(phone,num,state) {
				var shenhestate = $("#selections"+num).val();
				var resn = "0";
				var otherResn = "";
				if(shenhestate == "1"){
					//审核不通过，要添加不通过原因
					resn = $(":radio[name='noPass_"+num+"']:checked").val();
					if(resn == undefined || resn == "undefined"){
						rdShowMessageDialog("请选择审核不通过原因",1);
						return false;
					}
					
					if(resn == "5"){
						otherResn = $("#row_"+num).find("textarea").text();
						if(otherResn == ""){
							rdShowMessageDialog("请输入其他内容",1);
							return false;
						}
					}else{
						if(resn == "1"){
							  otherResn = "身份证不清晰";
						}else if(resn == "2"){
							  otherResn = "图片不合格";
						}else if(resn == "3"){
							  otherResn = "身份证信息与填报信息不一致";
						}else if(resn == "4"){
							  otherResn = "身份证不在有效期";
						}
					}
				}
				
        var packet = new AJAXPacket("fm139SH.jsp","正在获得数据，请稍候......");
      	packet.data.add("phoneNo",phone);
      	packet.data.add("shenhestate",shenhestate);
      	packet.data.add("num",num);
      	packet.data.add("state",state);
      	packet.data.add("otherResn",otherResn);
      	core.ajax.sendPacket(packet,dogetOfferInfo);
      	packet = null;
      
			
	}
function dogetOfferInfo(packet){
      var retcode = packet.data.findValueByName("retCode2");
      var retmsg = packet.data.findValueByName("retMsg2");
      var num = packet.data.findValueByName("num");
      var state = packet.data.findValueByName("state");
      var dingdanliushui = packet.data.findValueByName("dingdanliushui");
      var shenhestate = packet.data.findValueByName("shenhestate");
      if(retcode != "000000"){
        rdShowMessageDialog("审核失败！错误代码：" + retcode + "，错误信息：" + retmsg,0);
     
      }else{
     		rdShowMessageDialog("审核成功！",2);
     		if(shenhestate=="1") {
     		window.location.href="fm139.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
     		}else {
 			  document.all("selections"+num).disabled=true;
 			  document.all("shenheinput"+num).disabled=true;
 			  
 			  $("#dingdanliushui").val(dingdanliushui);
 			  
 			  if(state=="0") {
 			   document.all("huanka"+num).disabled=false;
 			  }else if(state=="1") {
 			   document.all("kaihu"+num).disabled=false;			  
 			  }
 			  
 			  }
      }
    }
    
    

</script> 
 
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form  method="post" name="frm139"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	
	<input type="hidden" id="sphones" name="sphones">
	
	<input type="hidden" id="sphoneskh" name="sphoneskh">
	<input type="hidden" id="custnamekh" name="custnamekh">
	<input type="hidden" id="offeridkh" name="offeridkh">
	<input type="hidden" id="dizhikh" name="dizhikh">
	<input type="hidden" id="lianxirenkh" name="lianxirenkh">
	<input type="hidden" id="lianxiphonekh" name="lianxiphonekh">
	<input type="hidden" id="youbiankh" name="youbiankh">
	<input type="hidden" id="dishikh" name="dishikh">
	<input type="hidden" id="iccidkh" name="iccidkh">
	
	<input type="hidden" id="dingdanliushui" name="dingdanliushui" value="">
	
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">           
    <tr>
    	<td class="blue" width="8%" nowrap>地市名称</td>
    	<td>
	    	<select name="region_code" id="region_code" class="button"  >
	    		<option value="">--请选择--</option>
	    		<option value="ALL">全省</option>
	    		<%
	    			if("000000".equals(retCode_type)){
	    				if(result1.length>0){
	    					for (int i = 0; i < result1.length; i++){
	    		%>
		      		<option value="<%=result1[i][0]%>"><%=result1[i][1]%></option>
		      <%
	    					}
	    				}
		    		}else{
		    	%>
		    			<script language="JavaScript">
		    				rdShowMessageDialog("查询地市名称失败！<br>错误代码：<%=retCode_type%><br>错误信息：<%=retMsg_type%>",0);
		    				removeCurrentTab();
		    			</script>
		    	<%
		    		}
		    	%>
	    	</select>
    	</td>
	  </tr>
		<tr> 
			<td align="center" id="footer" colspan="4"> 
				<input type="button" name="qryBtn"  class="b_foot" value="查询" onclick="query()">
				&nbsp;
				<input type="button" name="closeBtn1" class="b_foot" value="关闭" onclick="removeCurrentTab()">
			</td>
		</tr>
	</table>
	<div id="intablediv"></div>
	<table cellspacing="0" id="simNoTr" style="display:none">     
		<tr >
    	<td class="blue" width="8%" nowrap>SIM卡号</td>
    	<td>
	    	<input type="text" id="simNo" name="simNo" v_type="0_9" value="" onBlur="querySimInfos()"/>
    	</td>
    	<td class="blue" width="8%" nowrap>SIM归属HLR</td>
    	<td>
	    	<input type="text" id="hlrCode" name="hlrCode"  value="" readonly/>
    	</td>
	  </tr>
	  <tr> 
			<td align="center" id="footer" colspan="4"> 
				<input type="button" name="subBtn"  class="b_foot" value="确定" onclick="subInfo()">
				&nbsp;
				<input type="button" name="closeBtn2" class="b_foot" value="关闭" onclick="removeCurrentTab()">
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>