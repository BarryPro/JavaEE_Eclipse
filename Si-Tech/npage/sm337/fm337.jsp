<%
/********************
 version v2.0
开发商: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
		String regionCode= (String)session.getAttribute("regCode");
		String loginNoPass = (String)session.getAttribute("password");
		String ipAddrss = (String)session.getAttribute("ipAddr");
%>
  
	
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script type="text/javascript">
  onload=function()
  {
		changeType("aaa");
		document.all.querysss.disabled=true;
	  document.all.quchoose.disabled=false;	
  
  }
 

  		function frmCfm(){
				document.form1.action = "fm337Cfm.jsp";
   			document.form1.submit();
        return true;
      }
    
 
    

		
		
	function changeType(opCode){

	$("#aaaa1").empty();
	$("#aaaa2").empty();
	$("#aaaa11").empty();
	$("#aaaa22").empty();	
	$("#aaaa3").empty();
	$("#showTab").empty();	
	$("#showTab2").empty();
	$("#ybxiaoquresult").empty();
	$("#ybshenpirenresult").empty();
	
	if(opCode == "aaa"){
	
		$("#aaa").show();
		$("#aaa222").show();
		$("#aaa333").hide();//关于按宽带小区限定办理宽带单品资费的请示需求 liangyl 20170324
		
		$("#bbb").hide();
		$("#bbb222").hide();
		
		$("#xiaoqudiv").show();
		$("#offeriddiv").show();
		$("#xiaoqudiv22").hide();
		$("#offeriddiv22").hide();
		$("#shenpirendiv").hide();//关于按宽带小区限定办理宽带单品资费的请示需求 liangyl 20170324
		$("#shenpistyle").hide();
		
		$("#ybxiaoqudiv").hide();
		$("#ybxiaoqutab").hide();
		$("#ybxiaoquresult").hide();
		$("#beizhutab").hide();
		$("#ybshenpirendiv").hide();
		$("#ybshenpirentab").hide();
		$("#xiaoquQudao").hide();
		$("#xiaoquZifei").hide();
		document.all.querysss.disabled=true;
	  document.all.quchoose.disabled=false;	
	}
	if(opCode == "bbb"){
 
	 	$("#aaa").hide();
		$("#aaa222").hide();
		$("#aaa333").hide();//关于按宽带小区限定办理宽带单品资费的请示需求 liangyl 20170324
		
		$("#bbb").show();
		$("#bbb222").show();
				
		$("#xiaoqudiv").hide();
		$("#offeriddiv").hide();	
		$("#xiaoqudiv22").show();
		$("#offeriddiv22").show();
		$("#shenpirendiv").hide();//关于按宽带小区限定办理宽带单品资费的请示需求 liangyl 20170324
		$("#shenpistyle").hide();
		
		$("#ybxiaoqudiv").hide();
		$("#ybxiaoqutab").hide();
		$("#ybxiaoquresult").hide();
		$("#beizhutab").hide();
		$("#ybshenpirendiv").hide();
		$("#ybshenpirentab").hide();
		$("#xiaoquQudao").hide();
		$("#xiaoquZifei").hide();
		
		document.all.querysss.disabled=true;
	  document.all.quchoose.disabled=false;	
	}	
	if(opCode == "ccc"){
 		$("#xiaoqucanshu").val("");
		$("#shuliangbz").val("");
		$("#xiaoqucanshu2").val("");
		$("#shuliangbz2").val("");
	 	$("#aaa").hide();
		$("#aaa222").hide();
		$("#aaa333").hide();
		
		$("#bbb").hide();
		$("#bbb222").hide();
		
		$("#xiaoqudiv").hide();
		$("#offeriddiv").hide();
		$("#xiaoqudiv22").hide();
		$("#offeriddiv22").hide();	
		$("#shenpirendiv").hide();
		$("#shenpistyle").show();
		$("#forSomeXQJL").show();
		$("#xiaoqudivcc22").show();
		
		$("#ybxiaoqudiv").hide();
		$("#ybxiaoqutab").hide();
		$("#ybxiaoquresult").hide();
		$("#beizhutab").hide();
		$("#ybshenpirendiv").hide();
		$("#ybshenpirentab").hide();
		$("#xiaoquQudao").hide();
		$("#xiaoquZifei").hide();
		document.all.querysss.disabled=false;
	  document.all.quchoose.disabled=true;	
 
	}
	if(opCode == "ddd"){
		
		
	 	$("#aaa").hide();
		$("#aaa222").hide();
		$("#aaa333").hide();
		
		$("#bbb").hide();
		$("#bbb222").hide();		
		
		$("#xiaoqudiv").hide();
		$("#offeriddiv").hide();
		$("#xiaoqudiv22").hide();
		$("#offeriddiv22").hide();	
		$("#shenpirendiv").hide();
		$("#shenpistyle").hide();
		
		
		$("#ybxiaoqudiv").show();
		$("#ybxiaoqutab").show();
		$("#ybxiaoquresult").show();
		$("#beizhutab").hide();
		$("#ybshenpirendiv").show();
		$("#ybshenpirentab").show();
		$("#xiaoquQudao").hide();
		$("#xiaoquZifei").hide();
		
		document.all.querysss.disabled=true;
	  document.all.quchoose.disabled=false;	
 
	}	
	/*2016/4/21 21:01:15 gaopeng 小区客户经理信息查询
		小区客户经理信息查询
		查询条件：小区名称
		查询结果展示：地市名称、小区代码、小区名称、小区建设性质代码、小区建设性质名称
	*/
	if(opCode == "managerConfig"){
			$("#xiaoqucanshu").val("");
			$("#shuliangbz").val("");
			$("#xiaoqucanshu2").val("");
			$("#shuliangbz2").val("");
		 	$("#aaa").hide();
			$("#aaa222").hide();
			$("#aaa333").hide();
			
			$("#bbb").hide();
			$("#bbb222").hide();
			
			$("#xiaoqudiv").hide();
			$("#offeriddiv").hide();
			$("#xiaoqudiv22").hide();
			$("#offeriddiv22").hide();	
			$("#shenpirendiv").hide();
			$("#shenpistyle").show();
			
			/**/
			$("#forSomeXQJL").hide();
			$("#xiaoqudivcc22").hide();
			
			$("#ybxiaoqudiv").hide();
			$("#ybxiaoqutab").hide();
			$("#ybxiaoquresult").hide();
			$("#beizhutab").hide();
			$("#ybshenpirendiv").hide();
			$("#ybshenpirentab").hide();
			$("#xiaoquQudao").hide();
			$("#xiaoquZifei").hide();
			document.all.querysss.disabled=true;
		  document.all.quchoose.disabled=false;		
		
	}
	
	/*2016/10/21 liangyl 关于开发宽带渠道承载报表及改造资源配置界面需求的函（BOSS侧）
	小区渠道信息
	查询条件：小区名称
	查询结果展示：地市名称、小区代码、小区名称、小区建设性质代码、小区建设性质名称
	*/
	if(opCode == "xiaoquQudao"){
			$("#xiaoqucanshu").val("");
			$("#shuliangbz").val("");
			$("#xiaoqucanshu2").val("");
			$("#shuliangbz2").val("");
			
		 	$("#aaa").hide();
			$("#aaa222").hide();
			$("#aaa333").hide();
			
			$("#bbb").hide();
			$("#bbb222").hide();
			
			$("#xiaoqudiv").hide();
			$("#offeriddiv").hide();
			$("#xiaoqudiv22").hide();
			$("#offeriddiv22").hide();	
			$("#shenpirendiv").hide();
			$("#shenpistyle").hide();
			$("#xiaoquQudao").show();
			$("#xiaoquZifei").hide();
			
			/**/
			$("#forSomeXQJL").hide();
			$("#xiaoqudivcc22").hide();
			
			$("#ybxiaoqudiv").hide();
			$("#ybxiaoqutab").hide();
			$("#ybxiaoquresult").hide();
			$("#beizhutab").hide();
			$("#ybshenpirendiv").hide();
			$("#ybshenpirentab").hide();
			$("#qudaoxiaoquName").val("");
			$("#qudaodaoruType").val(0);
			document.all.querysss.disabled=true;
		  document.all.quchoose.disabled=false;
		  changequdaodaoruType();
		
	}
	
	/*2017/03/24 liangyl 关于按宽带小区限定办理宽带单品资费的请示需求
		界面新增一个按钮，即宽带小区与资费批量
		界面元素:操作类型(下拉框，新增和删除)，导入文件，字段至少包含：资费代码、小区代码。请在界面标注一下导入的格式等要求。
		要求：1）批量操作与单个操作的业务规则一致。
     		2）一次最多可以导入500条。
	*/
	if(opCode == "xiaoquZifei"){
			$("#xiaoqucanshu").val("");
			$("#shuliangbz").val("");
			$("#xiaoqucanshu2").val("");
			$("#shuliangbz2").val("");
			
		 	$("#aaa").hide();
			$("#aaa222").hide();
			$("#aaa333").hide();
			
			$("#bbb").hide();
			$("#bbb222").hide();
			
			$("#xiaoqudiv").hide();
			$("#offeriddiv").hide();
			$("#xiaoqudiv22").hide();
			$("#offeriddiv22").hide();	
			$("#shenpirendiv").hide();
			$("#shenpistyle").hide();
			$("#xiaoquQudao").hide();
			$("#xiaoquZifei").show();
			
			/**/
			$("#forSomeXQJL").hide();
			$("#xiaoqudivcc22").hide();
			
			$("#ybxiaoqudiv").hide();
			$("#ybxiaoqutab").hide();
			$("#ybxiaoquresult").hide();
			$("#beizhutab").hide();
			$("#ybshenpirendiv").hide();
			$("#ybshenpirentab").hide();
			$("#qudaoxiaoquName").val("");
			$("#qudaodaoruType").val(0);
			document.all.querysss.disabled=true;
		  document.all.quchoose.disabled=false;
		  changezifeidaoruType();
		
	}
}


function changeTGflag() {
	var flagsss= $("#shenpiflag").val();
	
		$("#showTab").empty();	
	  $("#showTab2").empty();
	
		if(flagsss=="0") {
					
			$("#xiaoqudivcc").show();
			$("#xiaoqudivcc22").show();
			
		}else {
			
			$("#xiaoqudivcc").hide();
			$("#xiaoqudivcc22").hide();
			
			 	var myPacket = new AJAXPacket("ajax_queryofferid.jsp","正在查询信息，请稍候......");
				myPacket.data.add("xiaoqudaima","");	
				myPacket.data.add("offeridss","");
				myPacket.data.add("oprtypes","");
				myPacket.data.add("statess","N");
				core.ajax.sendPacketHtml(myPacket,querinfo2,true);
				myPacket = null;
			
			}
}	

function queryofferidajax(xqdm) {
 	var myPacket = new AJAXPacket("ajax_queryofferid1.jsp","正在查询信息，请稍候......");
	myPacket.data.add("xiaoqudaima",xqdm.split("|")[0]);	
	myPacket.data.add("offeridss","");	
	myPacket.data.add("oprtypes","1");
	myPacket.data.add("statess","Y");
	myPacket.data.add("propertyUnitVal",xqdm.split("|")[1]);
	
	core.ajax.sendPacketHtml(myPacket,querinfo2,true);
	myPacket = null;

}
 	function resetPage(){
 		window.location.href = "f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
	
	
		
function doCommit() {
	var opType = $.trim($("input[name='opType'][checked]").val());
	/*小区客户经理查询*/
	if (opType == "managerConfig") {
		/*进行逻辑校验*/
		var managerNameObj = $("#managerName");
		var managerPhoneObj = $("#managerPhone");

		if (typeof (document.all.managerName) != "undefined"
				&& typeof (document.all.managerPhone) != "undefined") {
			if (!checkElement(managerNameObj[0])) {
				return false;
			}
			if (!checkElement(managerPhoneObj[0])) {
				return false;
			}
			var managerName = $.trim(managerNameObj.val());
			var managerPhone = $.trim(managerPhoneObj.val());
			var manageFlag = $("#manageFlag").val();
			var manageXqdm = $.trim($("#manageXqdm").val());
			var managePropertyUnit = $.trim($("#managePropertyUnit").val());

			var myPacket = new AJAXPacket("fBroadManagerCfm.jsp","正在查询信息，请稍候......");
			myPacket.data.add("iFlag", manageFlag);
			myPacket.data.add("xqdm", manageXqdm);
			myPacket.data.add("propertyUnit", managePropertyUnit);
			myPacket.data.add("iManagerName", managerName);
			myPacket.data.add("iManagerPhone", managerPhone);
			core.ajax.sendPacket(myPacket, function(packet) {
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");

				if (retCode == "000000") {
					rdShowMessageDialog("操作成功！", 2);

				} else {
					rdShowMessageDialog("错误代码：" + retCode + ",错误信息："
							+ retMsg, 1);

				}

			});

			myPacket = null;

		} else {
			rdShowMessageDialog("请查询小区客户经理信息！");
			return false;
		}
	} 
	else if (opType == "xiaoquQudao") {
		if (form1.uploadfile.value.length < 1) {
			rdShowMessageDialog("请上传文件!");
			document.form1.uploadfile.focus();
			return false;
		}
		var fileVal = getFileExt($("#uploadfile").val());
		if ("txt" == fileVal) {
			//扩展名是txt
		} else {
			rdShowMessageDialog("上传文件的扩展名不正确,只能是后缀为txt类型文件！", 0);
			return false;
		}
		document.all.quchoose.disabled = true;
		$("#form1").attr("encoding", "multipart/form-data");
		document.form1.action = "fm337_uploadQD.jsp";
		document.form1.submit();
	}
	else if (opType == "xiaoquZifei") {
		if (form1.uploadfile1.value.length < 1) {
			rdShowMessageDialog("请上传文件!");
			document.form1.uploadfile1.focus();
			return false;
		}
		var fileVal = getFileExt($("#uploadfile1").val());
		if ("txt" == fileVal) {
			//扩展名是txt
		} else {
			rdShowMessageDialog("上传文件的扩展名不正确,只能是后缀为txt类型文件！", 0);
			return false;
		}
		document.all.quchoose.disabled = true;
		$("#form1").attr("encoding", "multipart/form-data");
		document.form1.action = "fm337_uploadZF.jsp";
		document.form1.submit();
	}
	
	else {
		var radio1 = document.getElementsByName("opType");
		for ( var i = 0; i < radio1.length; i++) {
			if (radio1[i].checked) {
				var opFlag = radio1[i].value;
				if (opFlag == "aaa") {
					var xiaoqustrsss = "";
					var xiaoqujsxgstr = "";
					$("#aaaa1 tr")
							.each(
									function() {
										if ($(this).find("td:eq(0)").html()
												.trim() != "小区名称") {
											xiaoqustrsss = $(this).find(
													"td:eq(0)").html()
													.trim();
											xiaoqujsxgstr = $(this).find(
													"td:eq(2)").html()
													.trim();
										}
									});

					if (xiaoqustrsss == "") {
						rdShowMessageDialog("请选择要配置的小区！");
						return false;
					}

					var offeridstrsss = "";
					var chuzhuangfeis = "";
					var shuliangbzaa = 0;
					$("#aaaa2 tr")
							.each(
									function(i) {
										if ($(this).find("td:eq(0)").html()
												.trim() != "资费代码") {
											offeridstrsss += $(this).find(
													"td:eq(0)").html()
													.trim()
													+ "|";
											shuliangbzaa++;
										}
										chuzhuangfeis += $(
												"select[name='kxzchuzhuangfei']")
												.eq(i).val()
												+ "|";
									});

					if (offeridstrsss == "") {
						rdShowMessageDialog("请选择要配置的资费！");
						return false;
					}

					var gonghaostrsss = "";
				//	$("#aaaa3 tr").each(function() {
				//		if ($(this).find("td:eq(0)").html().trim() != "小区名称") {
				//			gonghaostrsss = $(this).find("td:eq(0)").html().trim();
				//		}
				//	});

				//	if (gonghaostrsss == "") {
				//		rdShowMessageDialog("请选择审批人！");
				//		return false;
				//	}

					$("#xiaoqucanshu").val(xiaoqustrsss);
					$("#offeridcanshu").val(offeridstrsss);
					$("#chuzhuangfeicanshu").val(chuzhuangfeis);
					$("#shenpirencanshu").val(gonghaostrsss);
					$("#xiaoqujsxgstr").val(xiaoqujsxgstr);
					$("#optypess").val("1");
					$("#shuliangbz").val(shuliangbzaa);

					document.all.quchoose.disabled = true;
					frmCfm();

				} else if (opFlag == "bbb") {

					var xiaoqustrsss = "";
					var xiaoqujsxgstr = "";
					var chuzhuangfeis = "";
					var shuliangbzbb = 0;
					$("#aaaa11 tr")
							.each(
									function(i) {
										if ($(this).find("td:eq(0)").html()
												.trim() != "小区名称") {
											xiaoqustrsss += $(this).find(
													"td:eq(0)").html()
													.trim()
													+ "|";
											xiaoqujsxgstr += $(this).find(
													"td:eq(2)").html()
													.trim()
													+ "|";
											shuliangbzbb++;
										}
										//  alert($("select[name='kzxchuzhuangfei']").eq(i).val());
										chuzhuangfeis += $(
												"select[name='kzxchuzhuangfei']")
												.eq(i).val()
												+ "|";
									});

					if (xiaoqustrsss == "") {
						rdShowMessageDialog("请选择要配置的小区！");
						return false;
					}

					var offeridstrsss = "";
					$("#aaaa22 tr")
							.each(
									function() {
										if ($(this).find("td:eq(0)").html()
												.trim() != "资费代码") {
											offeridstrsss = $(this).find(
													"td:eq(0)").html()
													.trim();
										}
									});

					if (offeridstrsss == "") {
						rdShowMessageDialog("请选择要配置的资费！");
						return false;
					}

					var gonghaostrsss = "";
			//		$("#aaaa3 tr").each(function() {
			//			if ($(this).find("td:eq(0)").html().trim() != "小区名称") {
			//				gonghaostrsss = $(this).find("td:eq(0)").html().trim();
			//			}
			//		});

			//		if (gonghaostrsss == "") {
			//			rdShowMessageDialog("请选择审批人！");
			//			return false;
			//		}

					$("#xiaoqucanshu").val(xiaoqustrsss);
					$("#offeridcanshu").val(offeridstrsss);
					$("#chuzhuangfeicanshu").val(chuzhuangfeis);
					$("#shenpirencanshu").val(gonghaostrsss);
					$("#xiaoqujsxgstr").val(xiaoqujsxgstr);
					$("#optypess").val("2");
					$("#shuliangbz").val(shuliangbzbb);

					document.all.quchoose.disabled = true;
					frmCfm();

				}

				else if (opFlag == "ccc") {

				} else if (opFlag == "ddd") {

					var xiaoqustrsss = "";
					var xiaoqujsxgstr = "";
					var shuliangbzbb = 0;
					$("#ybxiaoquresult tr")
							.each(
									function(i) {
										if ($(this).find("td:eq(0)").html()
												.trim() != "小区名称") {
											xiaoqustrsss += $(this).find(
													"td:eq(0)").html()
													.trim()
													+ "|";
											xiaoqujsxgstr += $(this).find(
													"td:eq(2)").html()
													.trim()
													+ "|";
											shuliangbzbb++;
										}
									});
					if (xiaoqustrsss == "") {
						rdShowMessageDialog("请选择要配置的小区！");
						return false;
					}

					if ($("#yingxiaotext").val().trim() == ""
							&& $("#beizhutext").val().trim() == "") {
						rdShowMessageDialog("营销活动或备注信息至少添加一项!");
						return false;
					}
					if ($("#yingxiaotext").val().trim().length > 500) {
						rdShowMessageDialog("营销活动内容不能超过500字!");
						return false;
					}
					if ($("#beizhutext").val().trim().length > 500) {
						rdShowMessageDialog("备注信息内容不能超过500字!");
						return false;
					}

					var gonghaostrsss = "";
					$("#ybshenpirenresult tr").each(function() {
						if ($(this).find("td:eq(0)").html().trim() != "小区名称") {
							gonghaostrsss = $(this).find("td:eq(0)").html().trim();
						}
					});

					if (gonghaostrsss == "") {
						rdShowMessageDialog("请选择审批人！");
						return false;
					}

					$("#xiaoqucanshu2").val(xiaoqustrsss);
					$("#xiaoqujsxgstr2").val(xiaoqujsxgstr);
					$("#optypess").val("4");
					$("#shuliangbz2").val(shuliangbzbb);
					$("#yingxiaohuodongcanshu").val(
					$("#yingxiaotext").val().trim());
					$("#yingxiaobeizhucanshu").val(
					$("#beizhutext").val().trim());
					$("#shenpirencanshu").val(gonghaostrsss);
					document.all.quchoose.disabled = true;
					frmCfm();
				}
			}
		}
	}
}
	function getXiaoquAAA() {
		$("#aaaa2").empty();
		var xiaoqumingchengss = $("#xiaoqunameaaa").val();
		if (xiaoqumingchengss.trim() == "") {
			rdShowMessageDialog("请输入小区名称！");
			return false;
		}

		//调用公共js
		var pageTitle = "小区查询";
		var fieldName = "地市名称|小区代码|小区名称|小区建设性质代码|小区建设性质名称|";//弹出窗口显示的列、列名

		var selType = "S"; //'S'单选；'M'多选
		var retQuence = "4|1|2|3|4";//返回字段

		if (MySimpSel(pageTitle, fieldName, "", selType, retQuence, '50',
				xiaoqumingchengss))
			;
	}

	function MySimpSel(pageTitle, fieldName, sqlStr, selType, retQuence,
			dialogWidth, xiaoqumingchengss) {
		var path = "queryAreaInfoa.jsp";
		path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
		path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
		path = path + "&selType=" + selType + "&xiaoqumingchengss="
				+ xiaoqumingchengss;
		retInfo = window
				.showModalDialog(path, "", "dialogWidth:" + dialogWidth);
		if (retInfo == undefined) {
			return false;
		}
		if (retInfo == "") {
			rdShowMessageDialog("请选择小区信息！");
			return false;
		}
		//alert(retInfo);

		var array11 = new Array();
		array11 = retInfo.split("#$#");
		var tr_str = '';
		var flags1s = 0;
		for ( var flags = 0; flags < array11.length - 1; flags++) {
			flags1s++;
			if (flags1s == 1) {
				tr_str += "<tr>";
				tr_str += "<td style='display:none'>" + array11[flags]
						+ "</td>";
			}
			if (flags1s == 2) {
				tr_str += "<td>" + array11[flags] + "</td>";
			}
			if (flags1s == 3) {
				tr_str += "<td style='display:none'>" + array11[flags]
						+ "</td>";
			}
			if (flags1s == 4) {
				tr_str += "<td style='display:block'>" + array11[flags]
						+ "</td>";
				tr_str += "<td colspan='2'><input type='button' value='删除' class='b_text' onClick='deletzhka(this)'></td>";
				tr_str += "</tr>";
				flags1s = 0;
			}

		}
		$("#aaaa1").empty();
		$("#aaaa1").append(tr_str);

	}

	function getOfferidAAA() {
		var xiaoqustrsss = "";
		var xiaoqujsxgstr = "";
		$("#aaaa1 tr").each(function() {
			if ($(this).find("td:eq(0)").html().trim() != "小区名称") {
				xiaoqustrsss = $(this).find("td:eq(0)").html().trim();
				xiaoqujsxgstr = $(this).find("td:eq(2)").html().trim();
			}
		});
		if (xiaoqustrsss == "") {
			rdShowMessageDialog("请先查询小区信息并选择后再查询资费信息！");
			return false;
		}
		var offeridaaa = $("#offeridaaa").val();
		var offernameaaa = $("#offernameaaa").val();
		if (offeridaaa.trim() == "" && offernameaaa.trim() == "") {
			rdShowMessageDialog("请输入资费代码或资费名称进行查询！");
			return false;
		}

		//调用公共js
		var pageTitle = "资费信息";
		var fieldName = "资费代码|资费名称|资费品牌|品牌名称|";//弹出窗口显示的列、列名

		var selType = "M"; //'S'单选；'M'多选
		var retQuence = "4|0|1|2|3";//返回字段

		if (MySimpSel222(pageTitle, fieldName, "", selType, retQuence, '50',
				offeridaaa, offernameaaa, xiaoqujsxgstr))
			;
	}

	function MySimpSel222(pageTitle, fieldName, sqlStr, selType, retQuence,
			dialogWidth, offeridaaa, offernameaaa, xiaoqujsxgstr) {

		var offeridstrsss = "";
		$("#aaaa2 tr").each(function() {
			if ($(this).find("td:eq(0)").html().trim() != "资费代码") {
				offeridstrsss += $(this).find("td:eq(0)").html().trim() + "|";
			}
		});

		//alert(offeridstrsss);							
		var path = "queryOffermsg.jsp";
		path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
		path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
		path = path + "&selType=" + selType + "&xiaoqujsxgstr=" + xiaoqujsxgstr
				+ "&offeridaaa=" + offeridaaa + "&offernameaaa=" + offernameaaa;
		retInfo = window
				.showModalDialog(path, "", "dialogWidth:" + dialogWidth);
		if (retInfo == undefined) {
			return false;
		}
		if (retInfo == "") {
			rdShowMessageDialog("请选择资费信息！");
			return false;
		}

		//alert(retInfo);

		var array11 = new Array();
		array11 = retInfo.split("#$#");

		var tr_str = '';

		var flag1111 = "0";
		var flags1s = 0;

		for ( var flags = 0; flags < array11.length - 1; flags++) {
			if (offeridstrsss.indexOf(array11[flags]) != -1) {
				flag1111 = "1";
			} else {
				if (flag1111 == "1") {
					flag1111 = "2";
				} else if (flag1111 == "2") {
					flag1111 = "3";
				} else if (flag1111 == "3") {
					flag1111 = "0";
				} else {
					flags1s++;
					if (flags1s == 1) {
						tr_str += "<tr>";
						tr_str += "<td>" + array11[flags] + "</td>";
					}
					if (flags1s == 2) {
						tr_str += "<td>" + array11[flags] + "</td>";
					}
					if (flags1s == 3) {
						tr_str += "<td name='zifeidaima'>" + array11[flags]
								+ "</td>";
					}
					if (flags1s == 4) {
						tr_str += "<td style='display:block'>" + array11[flags]
								+ "</td>";
						tr_str += "<td><select name='kxzchuzhuangfei'></select></td>";
						tr_str += "<td colspan='2'><input type='button' value='删除' class='b_text' onClick='deletzhka(this)'></td>";
						tr_str += "</tr>";
						flags1s = 0;
					}
				}
			}
		}

		//	$("#aaaa2").empty();
		$("#aaaa2").append(tr_str);

		$("select[name='kxzchuzhuangfei']").each(
				function(i) {
					var getCzf = new AJAXPacket("fm337_ajax_qryczf.jsp","正在获得初装费...");
					getCzf.data.add("tdindex", i);
					getCzf.data.add("region_code", "<%=regionCode%>");
			getCzf.data.add("sm_code",$(this).parent().parent().find("td[name='zifeidaima']").text());
			core.ajax.sendPacket(getCzf,kxzdealResults);
			getCzf=null;
    });
}
function kxzdealResults(packet){
	var countLoginno = packet.data.findValueByName("results");
	$("select[name='kxzchuzhuangfei']").eq(packet.data.findValueByName("tdindex")).empty();
	$("select[name='kxzchuzhuangfei']").eq(packet.data.findValueByName("tdindex")).append(countLoginno);
}

function getworknoAAA()
{
  	//调用公共js
    var pageTitle = "审批人信息";
    var fieldName = "审批工号|工号名称|";//弹出窗口显示的列、列名
   
   
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1";//返回字段

    if(MySimpSel333(pageTitle,fieldName,"",selType,retQuence,'50'));
}	

function MySimpSel333(pageTitle,fieldName,sqlStr,selType,retQuence,dialogWidth)
{
    var path = "queryWorknos.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
    if(retInfo ==undefined)
    {   return false;   
    }
    if(retInfo=="") {
      rdShowMessageDialog("请选择审批人！");
       return false; 
    }

    //alert(retInfo);
    
    var array11  =	new Array(); 
    array11 = retInfo.split("#$#");
    
    var tr_str='';   
    for (var flags=0;flags<array11.length-1;flags++) {    	
       if(flags % 2 == 0) {
        tr_str+="<tr>";  
				tr_str+="<td>"+array11[flags]+"</td>";  
       }
       if(flags % 2 != 0) {			  
			  tr_str+="<td>"+array11[flags]+"</td>"; 
			  tr_str+="<td><input type='button' value='删除' class='b_text' onClick='deletzhka(this)'></td>";   
			  tr_str+="</tr>";
       }
    }
    $("#aaaa3").empty(); 
    $("#aaaa3").append(tr_str);  
    
    
    
}


function getXiaoquBBB()
{

		var offeridstrsss="";
		var offeridband="";
		 $("#aaaa22 tr").each(
				function(){
				  if($(this).find("td:eq(0)").html().trim()!="资费代码"){
				  offeridstrsss = $(this).find("td:eq(0)").html().trim();
				  offeridband  = $(this).find("td:eq(2)").html().trim();
				  }
				}
		 );								 

			if(offeridstrsss==""){
       rdShowMessageDialog("请先查询资费信息并选择后再查询小区信息！");
       return false;
		 }
							
		var xiaoqumingchengss = $("#xiaoqunamebbb").val();
		if(xiaoqumingchengss.trim()=="") {
				rdShowMessageDialog("请输入小区名称！");
				return false;
		}
				
  	//调用公共js
    var pageTitle = "小区查询";
    var fieldName = "地市名称|小区代码|小区名称|小区建设性质代码|小区建设性质名称|";//弹出窗口显示的列、列名
   
   
    var selType = "M";    //'S'单选；'M'多选
    var retQuence = "4|1|2|3|4";//返回字段

    if(MySimpSelBBB(pageTitle,fieldName,"",selType,retQuence,'50',xiaoqumingchengss,offeridband));
}

function MySimpSelBBB(pageTitle,fieldName,sqlStr,selType,retQuence,dialogWidth,xiaoqumingchengss,offeridband)
{
			var xiaoqustrsss="";
		 $("#aaaa11 tr").each(
				function(){
				  if($(this).find("td:eq(0)").html().trim()!="小区名称"){
				  xiaoqustrsss += $(this).find("td:eq(0)").html().trim()+"|";
				  }
				}
		 );
		 
    var path = "queryAreaInfoa.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType +"&offeridband="+offeridband+"&xiaoqumingchengss=" + xiaoqumingchengss;
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
    if(retInfo ==undefined)
    {   return false;   
    }
    if(retInfo=="") {
      rdShowMessageDialog("请选择小区信息！");
       return false; 
    }
    //alert(retInfo);
    
 var array11  =	new Array(); 
    array11 = retInfo.split("#$#");
    var tr_str='';   
    
    var flag1111="0";
    var flags1s=0;
    for (var flags=0;flags<array11.length-1;flags++) {
     	 
    	 if(xiaoqustrsss.indexOf(array11[flags])!=-1) {
    	 	flag1111="1";
    	 }else {
	    	  if(flag1111=="1") {
	    	  		flag1111="2";
	    	  }else if(flag1111=="2") {
	    	  		flag1111="3";
	    	  }else if(flag1111=="3") {
	    	  		flag1111="0";
	    	  }
	    	  else {

			 flags1s++;

       if(flags1s==1) {
        tr_str+="<tr>";  
				tr_str+="<td style='display:none'>"+array11[flags]+"</td>";  
       }
		   if(flags1s==2) {
			  tr_str+="<td>"+array11[flags]+"</td>"; 
			 }
		   if(flags1s==3) {
			  tr_str+="<td style='display:none'>"+array11[flags]+"</td>"; 
			 }			 
			 if(flags1s==4) {
			  tr_str+="<td style='display:block'>"+array11[flags]+"</td>"; 
			  tr_str+="<td><select name='kzxchuzhuangfei'></select></td>"; 
			  tr_str+="<td colspan='2'><input type='button' value='删除' class='b_text' onClick='deletzhka(this)'></td>"; 
			  tr_str+="</tr>";
			  flags1s=0;
			 }
			 
			 
		       
		       }
       }
    }
    $("#aaaa11").append(tr_str);
    $("select[name='kzxchuzhuangfei']").each(function (i){
    	var getCzf = new AJAXPacket("fm337_ajax_qryczf.jsp","正在获得初装费...");
    	getCzf.data.add("tdindex",i);
    	getCzf.data.add("region_code","<%=regionCode%>");
			getCzf.data.add("sm_code",$("#kzxofferserial").text());
			core.ajax.sendPacket(getCzf,kzxdealResults);
			getCzf=null;
    });
    
}
function kzxdealResults(packet){
	var countLoginno = packet.data.findValueByName("results");
	$("select[name='kzxchuzhuangfei']").eq(packet.data.findValueByName("tdindex")).empty();
	$("select[name='kzxchuzhuangfei']").eq(packet.data.findValueByName("tdindex")).append(countLoginno);
}


function getOfferidBBB()
{				
	$("#aaaa11").empty();
				var offeridbbb = $("#offeridbbb").val();
				var offernamebbb = $("#offernamebbb").val();
				if(offeridbbb.trim()=="" && offernamebbb.trim()=="") {
						rdShowMessageDialog("请输入资费代码或资费名称进行查询！");
						return false;
				}		
				
  	//调用公共js
    var pageTitle = "资费信息";
    var fieldName = "资费代码|资费名称|资费品牌|品牌名称|";//弹出窗口显示的列、列名
   
   
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "4|0|1|2|3";//返回字段

    if(MySimpSelBBB222(pageTitle,fieldName,"",selType,retQuence,'50',offeridbbb,offernamebbb));
}	

function MySimpSelBBB222(pageTitle,fieldName,sqlStr,selType,retQuence,dialogWidth,offeridbbb,offernamebbb)
{
		
		//alert(offeridstrsss);							
    var path = "queryOffermsg.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType + "&offeridaaa="+offeridbbb+"&offernameaaa="+offernamebbb;
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
    if(retInfo ==undefined)
    {   return false;   
    }
    if(retInfo=="") {
      rdShowMessageDialog("请选择资费信息！");
       return false; 
    }

    //alert(retInfo);
    
    var array11  =	new Array(); 
    array11 = retInfo.split("#$#");
    
    var tr_str='';
    var flags1s=0;   
    for (var flags=0;flags<array11.length-1;flags++) { 
    	 flags1s++; 	   	 
       if(flags1s==1) {
        tr_str+="<tr>";  
				tr_str+="<td>"+array11[flags]+"</td>";  
       }
		   if(flags1s==2) {
			  tr_str+="<td>"+array11[flags]+"</td>"; 
			 }
			 if(flags1s==3) {
				tr_str+="<td id='kzxofferserial'>"+array11[flags]+"</td>"; 
			 }	
			 	if(flags1s==4) {
			  tr_str+="<td style='display:block'>"+array11[flags]+"</td>";
			  tr_str+="<td colspan='2'><input type='button' value='删除' class='b_text' onClick='deletzhka(this)'></td>"; 
			  tr_str+="</tr>";
			  flags1s=0;
			 }		 
       
    }
    
    $("#aaaa22").empty();
    $("#aaaa22").append(tr_str);
    
    
    
}


 function deletzhka(k) {
 	  $(k).parent().parent().remove();  
 }
  function delOfferidAAA() {
 	  $("#aaaa2").empty();
 }
   function delXiaoquBBB() {
 	  $("#aaaa11").empty();
 }
 
 
 function getXiaoquchaxun() {
 
 				var xiaoqunameccc = $("#xiaoqunameccc").val();
				if(xiaoqunameccc.trim()=="") {
						rdShowMessageDialog("请输入小区名称！");
						return false;
				}
				
				$("#showTab2").empty();
 	/*2016/4/21 21:07:52 gaopeng 获取当前选择的操作类型*/
 	var opType = $.trim($("input[name='opType'][checked]").val());
 	var myPacket = new AJAXPacket("ajax_queryXQ.jsp","正在查询信息，请稍候......");
	myPacket.data.add("xiaoqunameccc",xiaoqunameccc.trim());
	myPacket.data.add("opType",opType);
	
	core.ajax.sendPacketHtml(myPacket,querinfo,true);
	myPacket = null;
	
 }
 
	function querinfo(data){
		//找到添加表格的div
		var markDiv=$("#showTab"); 
		markDiv.empty();
		markDiv.append(data);
				
	}
	
	function querinfo2(data){
		//找到添加表格的div
		var markDiv=$("#showTab2"); 
		markDiv.empty();
		markDiv.append(data);
				
	}	
	
	/*2016/4/21 21:22:11 gaopeng 查询客户经理信息方法*/
	function sBroadManagerQry(objId) {
				
				var managerObj = $("#"+objId);
				var regionName = managerObj.find("td").eq(0).html();
				
				var xqdm = managerObj.find("td").eq(1).html();
				var xqName = managerObj.find("td").eq(2).html();
				var propertyUnit = managerObj.find("td").eq(3).html();
				var propertyUnitName = managerObj.find("td").eq(4).html();
				
			 	var myPacket = new AJAXPacket("fBroadManagerQry.jsp","正在查询信息，请稍候......");
				myPacket.data.add("iFlag","s");	
				myPacket.data.add("xqdm",xqdm);	
				myPacket.data.add("propertyUnit",propertyUnit);
				myPacket.data.add("iManagerName","");
				myPacket.data.add("iManagerPhone","");
				myPacket.data.add("xqName",xqName);
				core.ajax.sendPacketHtml(myPacket,querinfo2,true);
				myPacket = null;
				
	
	}
	
					function checkAll() { 
				var el = document.getElementsByTagName('input');
				var len = el.length;
				
				for(var i=0; i<len; i++) {
				if((el[i].type=="checkbox") && (el[i].id=='ckbox')) {
				el[i].checked = true;
				}
				}
				}
				function clearAll() {
				var el = document.getElementsByTagName('input');
				var len = el.length;
				for(var i=0; i<len; i++) {
				if((el[i].type=="checkbox") && (el[i].id=='ckbox')) {
				el[i].checked = false;
				}
				}
				}
				
				function shanchu111() {
					
	  			var el = document.getElementsByTagName('input');
					var len = el.length;
					var jishu=0;
					var checklength=0;
					var offeridstr ="";
					var xiaoqudaimass="";
					
					var xiaoqudaimass2="";
					var checklength2=0;
					var sm= new Array();
					for(var i=0; i<len; i++) {
						
					if((el[i].type=="checkbox") && (el[i].id=='ckbox') && (el[i].checked == true) ) {
						jishu++;
						if($(el[i]).parent().parent().find("#delType").val().split("-")[0]=="Y"
						&&$(el[i]).parent().parent().find("#zfzt").val()!=""){
							checklength++;
							sm =el[i].value.split("#$#");
							xiaoqudaimass+=sm[0]+"|";
							offeridstr+=sm[1]+"|";
						}
						if($(el[i]).parent().parent().find("#delType").val().split("-")[1]=="Y"
						&&$(el[i]).parent().parent().find("#yxzt").val()!=""){
							checklength2++;
							sm =el[i].value.split("#$#");
							xiaoqudaimass2+=sm[0]+"|";
						}
					}
					}
					if(jishu==0) {
							rdShowMessageDialog("请选择要删除的数据！");
							return false;
					}
					if(jishu>0&&checklength==0&&checklength2==0) {
							rdShowMessageDialog("请选择其他删除类型！");
							return false;
					}
	 			 $("#xiaoqucanshu").val(xiaoqudaimass);
				 $("#offeridcanshu").val(offeridstr);
				 $("#optypess").val("3");  
				 $("#shuliangbz").val(checklength);
				 $("#xiaoqucanshu2").val(xiaoqudaimass2);
				 $("#shuliangbz2").val(checklength2);
				  
				 
				frmCfm(); 
								 	
				
				}	
				
				
 function getOfferidccc() {
 
 				var offeridccc = $("#offeridccc").val();
				var offernameccc = $("#offernameccc").val();
				if(offeridccc.trim()=="" && offernameccc.trim()=="") {
						rdShowMessageDialog("请输入资费代码或资费名称进行查询！");
						return false;
				}
				$("#showTab2").empty();	
 
 	var myPacket = new AJAXPacket("ajax_queryofferidcc.jsp","正在查询信息，请稍候......");
	myPacket.data.add("offeridccc",offeridccc.trim());
	myPacket.data.add("offernameccc",offernameccc.trim());

	core.ajax.sendPacketHtml(myPacket,querinfo,true);
	myPacket = null;
	
 }
 
	function querinfo(data){
		//找到添加表格的div
		var markDiv=$("#showTab"); 
		markDiv.empty();
		markDiv.append(data);
				
	}
	

		function queryxiaoquccajax(offid) {
			 	var myPacket = new AJAXPacket("ajax_queryofferid1.jsp","正在查询信息，请稍候......");
				myPacket.data.add("xiaoqudaima","");	
				myPacket.data.add("offeridss",offid);	
				myPacket.data.add("oprtypes","2");	
				myPacket.data.add("statess","Y");
				core.ajax.sendPacketHtml(myPacket,querinfo2,true);
				myPacket = null;
	
	}						





function getXiaoquDDD()
{

				var xiaoqumingchengss = $("#ybxiaoquname").val();
				if(xiaoqumingchengss.trim()=="") {
						rdShowMessageDialog("请输入小区名称！");
						return false;
				}
				
  	//调用公共js
    var pageTitle = "小区查询";
    var fieldName = "地市名称|小区代码|小区名称|小区建设性质代码|小区建设性质名称|";//弹出窗口显示的列、列名
   
   
    var selType = "M";    //'S'单选；'M'多选
    var retQuence = "4|1|2|3|4";//返回字段

    if(MySimpSelDDD(pageTitle,fieldName,"",selType,retQuence,'50',xiaoqumingchengss));
}

function MySimpSelDDD(pageTitle,fieldName,sqlStr,selType,retQuence,dialogWidth,xiaoqumingchengss)
{
    var path = "queryAreaInfoa.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType +"&xiaoqumingchengss=" + xiaoqumingchengss;
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
    if(retInfo ==undefined)
    {   return false;   
    }
    if(retInfo=="") {
      rdShowMessageDialog("请选择小区信息！");
       return false; 
    }
    //alert(retInfo);
    
    var array11  =	new Array(); 
    array11 = retInfo.split("#$#");
    
    var tr_str='';
    var flags1s=0;   
    for (var flags=0;flags<array11.length-1;flags++) { 
    	 flags1s++; 	   	 
       if(flags1s==1) {
        tr_str+="<tr>";  
				tr_str+="<td style='display:none'>"+array11[flags]+"</td>";  
       }
		   if(flags1s==2) {
			  tr_str+="<td>"+array11[flags]+"</td>"; 
			 }
			 if(flags1s==3) {
				tr_str+="<td style='display:none'>"+array11[flags]+"</td>"; 
			 }	
			 	if(flags1s==4) {
			  tr_str+="<td style='display:block'>"+array11[flags]+"</td>"; 
			  tr_str+="<td colspan='2'><input type='button' value='删除' class='b_text' onClick='deletzhka(this)'></td>"; 
			  tr_str+="</tr>";
			  flags1s=0;
			 }		 
       
    }
    $("#ybxiaoquresult").empty(); 
    $("#ybxiaoquresult").append(tr_str);
    if(tr_str!=""){
    	$("#beizhutab").show();
    }
}
function getworknoDDD()
{
  	//调用公共js
    var pageTitle = "审批人信息";
    var fieldName = "审批工号|工号名称|";//弹出窗口显示的列、列名
     
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1";//返回字段

    if(MySimpSelYBSPR(pageTitle,fieldName,"",selType,retQuence,'50'));
}	

function MySimpSelYBSPR(pageTitle,fieldName,sqlStr,selType,retQuence,dialogWidth)
{
    var path = "queryWorknos.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    retInfo = window.showModalDialog(path,"","dialogWidth:"+dialogWidth);
    if(retInfo ==undefined)
    {   return false;   
    }
    if(retInfo=="") {
      rdShowMessageDialog("请选择审批人！");
       return false; 
    }

    //alert(retInfo);
    
    var array11  =	new Array(); 
    array11 = retInfo.split("#$#");
    
    var tr_str='';   
    for (var flags=0;flags<array11.length-1;flags++) {    	
       if(flags % 2 == 0) {
        tr_str+="<tr>";  
				tr_str+="<td>"+array11[flags]+"</td>";  
       }
       if(flags % 2 != 0) {			  
			  tr_str+="<td>"+array11[flags]+"</td>"; 
			  tr_str+="<td><input type='button' value='删除' class='b_text' onClick='deletzhka(this)'></td>";   
			  tr_str+="</tr>";
       }
    }
    $("#ybshenpirenresult").empty(); 
    $("#ybshenpirenresult").append(tr_str);
}

	function changequdaodaoruType() {
		var qudaodaoruType = $("#qudaodaoruType").val();
		if (qudaodaoruType == "A") {
			document.all.querysss.disabled=true;
			document.all.quchoose.disabled=false;
			$("#showTab").empty();
			$("#showTab2").empty();
			$("#qudaoxiaoquTr").hide();
			$("#qudaowenjianTr").show();
		} else if (qudaodaoruType == "D") {
			document.all.querysss.disabled=true;
			document.all.quchoose.disabled=false;
			$("#showTab").empty();
			$("#showTab2").empty();
			$("#qudaoxiaoquTr").hide();
			$("#qudaowenjianTr").show();
		} else if (qudaodaoruType == "Q") {
			document.all.querysss.disabled=true;
			document.all.quchoose.disabled=true;
			$("#qudaoxiaoquName").val("");
			$("#showTab").empty();
			$("#showTab2").empty();
			$("#qudaoxiaoquTr").show();
			$("#qudaowenjianTr").hide();
		}
	}
	function changezifeidaoruType() {
		var zifeidaoruType = $("#zifeidaoruType").val();
		if (zifeidaoruType == "A") {
			document.all.querysss.disabled=true;
			document.all.quchoose.disabled=false;
			$("#showTab").empty();
			$("#showTab2").empty();
			$("#zifeiwenjianTr").show();
		}else if (zifeidaoruType == "D") {
			document.all.querysss.disabled=true;
			document.all.quchoose.disabled=false;
			$("#showTab").empty();
			$("#showTab2").empty();
			$("#zifeiwenjianTr").show();
		}
	}
	
	function qudaoxiaoquQuery() {
		var qudaoxiaoquName = $("#qudaoxiaoquName").val();
		if (qudaoxiaoquName.trim() == "") {
			rdShowMessageDialog("请输入小区名称！");
			return false;
		}
		$("#showTab2").empty();
		/*2016/4/21 21:07:52 gaopeng 获取当前选择的操作类型*/
		var myPacket = new AJAXPacket("ajax_queryQDXQ.jsp", "正在查询信息，请稍候......");
		myPacket.data.add("xiaoqunameccc", qudaoxiaoquName.trim());
		core.ajax.sendPacketHtml(myPacket, querinfo, true);
		myPacket = null;

	}
	
	function querygroupidajax(xqdm) {
		var myPacket = new AJAXPacket("ajax_querygroupid.jsp","正在查询信息，请稍候......");
		myPacket.data.add("xiaoqudaima", xqdm);
		core.ajax.sendPacketHtml(myPacket, querinfo2, true);
		myPacket = null;
	}
	function getFileExt(obj)
	{
	    var pos = obj.lastIndexOf(".");
	    return obj.substring(pos+1);
	}
</script>
</head>
<body>
<form name="form1" id="form1" method="post">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
              
   <table id=""  cellspacing="0" >  	
        	  <tr>

			        		<td width=16% class="blue">操作类型</td>

			        		<td width=84% colspan="3">

			        			<input type="radio" name="opType"	value="aaa"   onclick="changeType(this.value);" checked/>宽带小区配置多个资费 &nbsp;&nbsp;

			        			<input type="radio" name="opType"	value="bbb"  onclick="changeType(this.value);"/>宽带资费配置多个小区 &nbsp;&nbsp;
			        			
			        			<!--<input type="radio" name="opType"	value="ddd"  onclick="changeType(this.value);"/>营销和备注信息 &nbsp;&nbsp; -->
			        			
			        			<input type="radio" name="opType"	value="ccc"  onclick="changeType(this.value);"/>审批结果查询 &nbsp;&nbsp;
			        			
			        			<input type="radio" name="opType"	value="managerConfig"  onclick="changeType(this.value);"/>小区客户经理信息查询 &nbsp;&nbsp;
			        			
			        			<input type="radio" name="opType"	value="xiaoquQudao"  onclick="changeType(this.value);"/>小区渠道信息&nbsp;&nbsp;
			        			
			        			<input type="radio" name="opType"	value="xiaoquZifei"  onclick="changeType(this.value);"/>宽带小区与资费批量&nbsp;&nbsp;

			        		</td>

        				</tr>
       </table>
 
 	<div class="title" id="xiaoqudiv">
		<div id="title_zi">小区信息</div>
	</div>      

 	<div class="title" id="offeriddiv22">
		<div id="title_zi">资费信息</div>
	</div>	
		
       <table id="aaa" style="display:block">
       	        <tr>
					        <td class='blue' width=16%>小区名称</td>
					        <td colspan="2">
								<input type="text" value="" name="xiaoqunameaaa" id="xiaoqunameaaa"    maxlength="50" />
								<input name="queryxiaoquaa" id="queryxiaoquaa" type="button" class="b_text"  style="cursor:hand" onClick="getXiaoquAAA()" value=查询>
					        </td>
					        </tr>    				
        			
					
        				
              </table>
              
                       <table id="bbb222" style="display:none">
  				
        	        <tr>
					       <td class='blue' width=16%>资费代码</td>
					        <td>
								<input type="text" value="" name="offeridbbb" id="offeridbbb"    maxlength="6"  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"  />
					        </td>
					       <td class='blue' width=16%>资费名称</td>
					        <td>
								<input type="text" value="" name="offernamebbb" id="offernamebbb"    maxlength="50" />
								<input name="" type="button" class="b_text"  style="cursor:hand" onClick="getOfferidBBB()" value=查询>
					        </td>
					        </tr>  				                					     				           					

        </table>

              
              <table>
                <TBODY id="aaaa1">
        				</TBODY> 
        		   </table>
        		   
        		   <table>
        		     <TBODY id="aaaa22">
        				</TBODY> 
        		   </table>

 	<div class="title" id="offeriddiv">
		<div id="title_zi">资费信息</div>
	</div>		

 	<div class="title" id="xiaoqudiv22">
		<div id="title_zi">小区信息</div>
	</div> 	
		
       <table id="aaa222" style="display:block">
  				
        	        <tr>
					       <td class='blue' width=16%>资费代码</td>
					        <td>
								<input type="text" value="" name="offeridaaa" id="offeridaaa"    maxlength="6"  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
					        </td>
					       <td class='blue' width=16%>资费名称</td>
					        <td>
								<input type="text" value="" name="offernameaaa" id="offernameaaa"    maxlength="50" />
								<input name="" type="button" class="b_text"  style="cursor:hand" onClick="getOfferidAAA()" value=查询>
								<input name="" type="button" class="b_text"  style="cursor:hand" onClick="delOfferidAAA()" value=删除全部>
					        </td>
					        </tr>  				                					
        				       			
      					

        </table>
        

           		  <table id="bbb" style="display:none">
       	        <tr>
					        <td class='blue' width=16%>小区名称</td>
					        <td colspan="2">
								<input type="text" value="" name="xiaoqunamebbb" id="xiaoqunamebbb"    maxlength="50" />
								<input name="queryxiaoqua" type="button" class="b_text"  style="cursor:hand" onClick="getXiaoquBBB()" value=查询>
								<input name="" type="button" class="b_text"  style="cursor:hand" onClick="delXiaoquBBB()" value=删除全部>
					        </td>
					        </tr>    				
        			

        				
              </table>
                   
                <table>
                <TBODY id="aaaa2">
        				</TBODY> 
        		   </table>
        		   
                 <table>
                <TBODY id="aaaa11">
        				</TBODY> 
        		   </table>       		   

              
              

 	<div class="title" id="shenpirendiv">
		<div id="title_zi">审批人信息</div>
	</div>
	        
       <table id="aaa333" style="display:block">
  				       <tr>
					        <td colspan='3'>
								<input name="" type="button" class="b_text"  style="cursor:hand" onClick="getworknoAAA()" value=审批人信息>
					        </td>
					        </tr>  				                					
        				       			
        </table>        
        				  
                <table>
                <TBODY id="aaaa3">
        				</TBODY> 
        		   </table>
        		   
        		   
       <table id="shenpistyle" style="display:none">
  				       <!-- <tr id="forSomeXQJL">
					        <td colspan='4'>
					              	<select  name="shenpiflag" id="shenpiflag" onChange="changeTGflag()" width=50 index="6">
					              		<option class="button" value="0" selected>审批通过</option>
					              		<option class="button" value="1">审批不通过</option>
					              	</select>
					        </td>
					        </tr>   -->			
					        
       	        <tr id="xiaoqudivcc">
					        <td class='blue' width=16%>小区名称</td>
					        <td colspan="3">
								<input type="text" value="" name="xiaoqunameccc" id="xiaoqunameccc"    maxlength="50" />
								<input name="queryxiaoqua" type="button" class="b_text"  style="cursor:hand" onClick="getXiaoquchaxun()" value=查询>
					        </td>
					        </tr>
					        
					         <tr id="xiaoqudivcc22">
					       <td class='blue' width=16%>资费代码</td>
					        <td>
								<input type="text" value="" name="offeridccc" id="offeridccc"    maxlength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"  />
					        </td>
					       <td class='blue' width=16%>资费名称</td>
					        <td>
								<input type="text" value="" name="offernameccc" id="offernameccc"    maxlength="50" />
								<input name="" type="button" class="b_text"  style="cursor:hand" onClick="getOfferidccc()" value=查询>
					        </td>
					        </tr>                  					
        				       			
        </table>
		<table id="xiaoquQudao" style="display: none">
			<tr id="daoruTypeTr">
				<td class='blue'>导入类型</td>
				<td colspan='3'><select name="qudaodaoruType"
					id="qudaodaoruType" onChange="changequdaodaoruType()" width=50
					index="6">
						<option class="button" value="A" selected>新增</option>
						<option class="button" value="D">删除</option>
						<option class="button" value="Q">查询</option>
				</select></td>
			</tr>
			<tr id="qudaoxiaoquTr">
				<td class='blue' width=16%>小区名称</td>
				<td colspan="3"><input type="text" value=""
					name="qudaoxiaoquName" id="qudaoxiaoquName" maxlength="50" /> <input
					name="qudaoqueryBtn" id="qudaoqueryBtn" type="button" class="b_text"
					style="cursor: hand" onClick="qudaoxiaoquQuery()" value=查询>
				</td>
			</tr>
			<tr id="qudaowenjianTr">
				<td class='blue' width=16%>导入文件</td>
				<td>
					<input type="file" id="uploadfile" name="uploadfile"/>
				</td>
				<td colspan="2" style="color: red">
					导入文件的格式：group_id|宽带小区代码(中间用"|"间隔,每行一条),一次最多导入100条记录<br/>
					例:<br/>
					10031|T_SPACE_STANDARD_ADDRESS-8aee349d3d204303013d634999a31638<br/>
					10031|T_SPACE_STANDARD_ADDRESS-8aee349d3d204303013d634a882f16a4<br/>
					
				</td>
			</tr>
		</table>
		<table id="xiaoquZifei" style="display: none">
			<tr id="daoruTypeTr">
				<td class='blue'>导入类型</td>
				<td colspan='3'>
					<select name="zifeidaoruType" id="zifeidaoruType" onChange="changezifeidaoruType()" width=50 index="6">
						<option class="button" value="A" selected>新增</option>
						<option class="button" value="D">删除</option>
					</select>
				</td>
			</tr>
			<!-- <tr id="zifeixiaoquTr">
				<td class='blue' width=16%>小区名称</td>
				<td colspan="3"><input type="text" value=""
					name="zifeixiaoquName" id="zifeixiaoquName" maxlength="50" /> <input
					name="zifeiqueryBtn" id="zifeiqueryBtn" type="button" class="b_text"
					style="cursor: hand" onClick="zifeixiaoquQuery()" value=查询>
				</td>
			</tr> -->
			<tr id="zifeiwenjianTr">
				<td class='blue' width=16%>导入文件</td>
				<td>
					<input type="file" id="uploadfile1" name="uploadfile1"/>
				</td>
				<td colspan="2" style="color: red">
					导入文件的格式：新增时,导入文件字段至少包含：资费代码、小区代码、初装费、小区建设性质(中间用"|"间隔,每行一条),一次最多导入500条记录<br/>
					例:<br/>
					43952|T_SPACE_STANDARD_ADDRESS-8aee349d3d204303013d634999a31638|100|1<br/>
					44018|T_SPACE_STANDARD_ADDRESS-8aee349d3d204303013d634a882f16a4|80|2<br/>
				</td>
			</tr>
		</table>
		<div id="showTab" ></div>
		<div id="showTab2" ></div>
        <div class="title" id="ybxiaoqudiv">
        	<div id="title_zi">小区信息</div>
        </div>
        <table id="ybxiaoqutab" style="display:none">
	        <tr>
	        	<td class='blue' width=16%>小区名称</td>
	        	<td colspan="2">
	        		<input type="text" value="" name="ybxiaoquname" id="ybxiaoquname"    maxlength="50" />
	        		<input name="queryxiaoqua" type="button" class="b_text" style="cursor:hand" onClick="getXiaoquDDD()" value=查询>
	        	</td> 
	        </tr>
        </table>
        <table>
        	<TBODY id="ybxiaoquresult"></TBODY>
        </table>
		<table>
			<TBODY id="beizhutab">
				<tr>
					<TD width="16%">营销活动</TD>
					<TD><textarea id="yingxiaotext" name="yingxiaotext" rows=6
							cols='' style="width: 80%"></textarea></TD>
				</tr>
				<tr>
					<TD>备注信息</TD>
					<TD><textarea id="beizhutext" name="beizhutext" rows=6 cols=''
							style="width: 80%"></textarea></TD>
				</tr>
			</TBODY>
		</table>
		<div class="title" id="ybshenpirendiv">
			<div id="title_zi">审批人信息</div>
		</div>
		<table id="ybshenpirentab" style="display: block">
			<tr>
				<td colspan='3'><input name="" type="button" class="b_text"
					style="cursor: hand" onClick="getworknoDDD()" value=审批人信息>
				</td>
			</tr>
		</table>
		<table>
			<TBODY id="ybshenpirenresult">
			</TBODY>
		</table>
		<table cellspacing="0">
			<tr>
				<td noWrap id="footer">
					<div align="center">
						<input name="quchoose" id="quchoose" class="b_foot" type=button
							value="配置" onclick="doCommit()"> <input name="querysss"
							id="querysss" class="b_foot" type=button value=删除
							onclick="shanchu111()"> <input class="b_foot"
							type=button name=back value="清除" onClick="resetPage()"> <input
							class="b_foot" type=button name=qryP value="关闭"
							onClick="removeCurrentTab()">
					</div>
				</td>
			</tr>
		</table>
		<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" /> 
        <input type="hidden" name="opName" id="opName" value="<%=opName%>" /> 
        <input type="hidden" name="xiaoqucanshu" id="xiaoqucanshu"  /> 
        <input type="hidden" name="offeridcanshu" id="offeridcanshu"  /> 
        <input type="hidden" name="chuzhuangfeicanshu" id="chuzhuangfeicanshu"  /> 
        <input type="hidden" name="shenpirencanshu" id="shenpirencanshu"  /> 
        <input type="hidden" name="optypess" id="optypess"  /> 
        <input type="hidden" name="xiaoqujsxgstr" id="xiaoqujsxgstr"  /> 
        <input type="hidden" name="shuliangbz" id="shuliangbz"  /> 
        <input type="hidden" name="xiaoqucanshu2" id="xiaoqucanshu2"/> 
        <input type="hidden" name="xiaoqujsxgstr2" id="xiaoqujsxgstr2"/> 
        <input type="hidden" name="yingxiaohuodongcanshu" id="yingxiaohuodongcanshu"/> 
        <input type="hidden" name="yingxiaobeizhucanshu" id="yingxiaobeizhucanshu"/> 
        <input type="hidden" name="shuliangbz2" id="shuliangbz2"/>
      
    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>
<script ="javascript">
var excelObj;

function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.t1.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
    var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =12;//设置列宽 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =9;//设置列宽 
  sheet.Columns("C").ColumnWidth =21;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =14;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =16;//设置列宽
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =35;//设置列宽 
  sheet.Columns("G").ColumnWidth =10;//设置列宽 

		for(a=0;a<document.all.t1.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						var g=0;
						for(j=0;j<cells;j++)
						{
							if(obj[a].rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj[a].rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value='';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj[a].rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj[a].rows[i].cells[j].innerText;
							g++;
							}
						}
					}
				}
				catch(e)
				{
					alert('生成excel失败!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
	}
	else
	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
   var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =12;//设置列宽 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =9;//设置列宽 
  sheet.Columns("C").ColumnWidth =21;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =14;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =16;//设置列宽
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =35;//设置列宽 
  sheet.Columns("G").ColumnWidth =10;//设置列宽 
		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					var g=0;
					for(j=0;j<cells;j++)
					{
							if(obj.rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj.rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value = '';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj.rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj.rows[i].cells[j].innerText;
							g++;
							}
					}
				}
			}
			catch(e)
			{
				alert('生成excel失败!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
	excelObj.Range('A1:'+str.charAt(cells+colspan-2)
+total_row).Borders.LineStyle=1;
}

</script>