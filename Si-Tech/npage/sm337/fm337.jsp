<%
/********************
 version v2.0
������: si-tech
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
		$("#aaa333").hide();//���ڰ����С���޶���������Ʒ�ʷѵ���ʾ���� liangyl 20170324
		
		$("#bbb").hide();
		$("#bbb222").hide();
		
		$("#xiaoqudiv").show();
		$("#offeriddiv").show();
		$("#xiaoqudiv22").hide();
		$("#offeriddiv22").hide();
		$("#shenpirendiv").hide();//���ڰ����С���޶���������Ʒ�ʷѵ���ʾ���� liangyl 20170324
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
		$("#aaa333").hide();//���ڰ����С���޶���������Ʒ�ʷѵ���ʾ���� liangyl 20170324
		
		$("#bbb").show();
		$("#bbb222").show();
				
		$("#xiaoqudiv").hide();
		$("#offeriddiv").hide();	
		$("#xiaoqudiv22").show();
		$("#offeriddiv22").show();
		$("#shenpirendiv").hide();//���ڰ����С���޶���������Ʒ�ʷѵ���ʾ���� liangyl 20170324
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
	/*2016/4/21 21:01:15 gaopeng С���ͻ�������Ϣ��ѯ
		С���ͻ�������Ϣ��ѯ
		��ѯ������С������
		��ѯ���չʾ���������ơ�С�����롢С�����ơ�С���������ʴ��롢С��������������
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
	
	/*2016/10/21 liangyl ���ڿ�������������ر���������Դ���ý�������ĺ���BOSS�ࣩ
	С��������Ϣ
	��ѯ������С������
	��ѯ���չʾ���������ơ�С�����롢С�����ơ�С���������ʴ��롢С��������������
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
	
	/*2017/03/24 liangyl ���ڰ����С���޶���������Ʒ�ʷѵ���ʾ����
		��������һ����ť�������С�����ʷ�����
		����Ԫ��:��������(������������ɾ��)�������ļ����ֶ����ٰ������ʷѴ��롢С�����롣���ڽ����עһ�µ���ĸ�ʽ��Ҫ��
		Ҫ��1�����������뵥��������ҵ�����һ�¡�
     		2��һ�������Ե���500����
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
			
			 	var myPacket = new AJAXPacket("ajax_queryofferid.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
				myPacket.data.add("xiaoqudaima","");	
				myPacket.data.add("offeridss","");
				myPacket.data.add("oprtypes","");
				myPacket.data.add("statess","N");
				core.ajax.sendPacketHtml(myPacket,querinfo2,true);
				myPacket = null;
			
			}
}	

function queryofferidajax(xqdm) {
 	var myPacket = new AJAXPacket("ajax_queryofferid1.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
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
	/*С���ͻ������ѯ*/
	if (opType == "managerConfig") {
		/*�����߼�У��*/
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

			var myPacket = new AJAXPacket("fBroadManagerCfm.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
			myPacket.data.add("iFlag", manageFlag);
			myPacket.data.add("xqdm", manageXqdm);
			myPacket.data.add("propertyUnit", managePropertyUnit);
			myPacket.data.add("iManagerName", managerName);
			myPacket.data.add("iManagerPhone", managerPhone);
			core.ajax.sendPacket(myPacket, function(packet) {
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");

				if (retCode == "000000") {
					rdShowMessageDialog("�����ɹ���", 2);

				} else {
					rdShowMessageDialog("������룺" + retCode + ",������Ϣ��"
							+ retMsg, 1);

				}

			});

			myPacket = null;

		} else {
			rdShowMessageDialog("���ѯС���ͻ�������Ϣ��");
			return false;
		}
	} 
	else if (opType == "xiaoquQudao") {
		if (form1.uploadfile.value.length < 1) {
			rdShowMessageDialog("���ϴ��ļ�!");
			document.form1.uploadfile.focus();
			return false;
		}
		var fileVal = getFileExt($("#uploadfile").val());
		if ("txt" == fileVal) {
			//��չ����txt
		} else {
			rdShowMessageDialog("�ϴ��ļ�����չ������ȷ,ֻ���Ǻ�׺Ϊtxt�����ļ���", 0);
			return false;
		}
		document.all.quchoose.disabled = true;
		$("#form1").attr("encoding", "multipart/form-data");
		document.form1.action = "fm337_uploadQD.jsp";
		document.form1.submit();
	}
	else if (opType == "xiaoquZifei") {
		if (form1.uploadfile1.value.length < 1) {
			rdShowMessageDialog("���ϴ��ļ�!");
			document.form1.uploadfile1.focus();
			return false;
		}
		var fileVal = getFileExt($("#uploadfile1").val());
		if ("txt" == fileVal) {
			//��չ����txt
		} else {
			rdShowMessageDialog("�ϴ��ļ�����չ������ȷ,ֻ���Ǻ�׺Ϊtxt�����ļ���", 0);
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
												.trim() != "С������") {
											xiaoqustrsss = $(this).find(
													"td:eq(0)").html()
													.trim();
											xiaoqujsxgstr = $(this).find(
													"td:eq(2)").html()
													.trim();
										}
									});

					if (xiaoqustrsss == "") {
						rdShowMessageDialog("��ѡ��Ҫ���õ�С����");
						return false;
					}

					var offeridstrsss = "";
					var chuzhuangfeis = "";
					var shuliangbzaa = 0;
					$("#aaaa2 tr")
							.each(
									function(i) {
										if ($(this).find("td:eq(0)").html()
												.trim() != "�ʷѴ���") {
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
						rdShowMessageDialog("��ѡ��Ҫ���õ��ʷѣ�");
						return false;
					}

					var gonghaostrsss = "";
				//	$("#aaaa3 tr").each(function() {
				//		if ($(this).find("td:eq(0)").html().trim() != "С������") {
				//			gonghaostrsss = $(this).find("td:eq(0)").html().trim();
				//		}
				//	});

				//	if (gonghaostrsss == "") {
				//		rdShowMessageDialog("��ѡ�������ˣ�");
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
												.trim() != "С������") {
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
						rdShowMessageDialog("��ѡ��Ҫ���õ�С����");
						return false;
					}

					var offeridstrsss = "";
					$("#aaaa22 tr")
							.each(
									function() {
										if ($(this).find("td:eq(0)").html()
												.trim() != "�ʷѴ���") {
											offeridstrsss = $(this).find(
													"td:eq(0)").html()
													.trim();
										}
									});

					if (offeridstrsss == "") {
						rdShowMessageDialog("��ѡ��Ҫ���õ��ʷѣ�");
						return false;
					}

					var gonghaostrsss = "";
			//		$("#aaaa3 tr").each(function() {
			//			if ($(this).find("td:eq(0)").html().trim() != "С������") {
			//				gonghaostrsss = $(this).find("td:eq(0)").html().trim();
			//			}
			//		});

			//		if (gonghaostrsss == "") {
			//			rdShowMessageDialog("��ѡ�������ˣ�");
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
												.trim() != "С������") {
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
						rdShowMessageDialog("��ѡ��Ҫ���õ�С����");
						return false;
					}

					if ($("#yingxiaotext").val().trim() == ""
							&& $("#beizhutext").val().trim() == "") {
						rdShowMessageDialog("Ӫ�����ע��Ϣ�������һ��!");
						return false;
					}
					if ($("#yingxiaotext").val().trim().length > 500) {
						rdShowMessageDialog("Ӫ������ݲ��ܳ���500��!");
						return false;
					}
					if ($("#beizhutext").val().trim().length > 500) {
						rdShowMessageDialog("��ע��Ϣ���ݲ��ܳ���500��!");
						return false;
					}

					var gonghaostrsss = "";
					$("#ybshenpirenresult tr").each(function() {
						if ($(this).find("td:eq(0)").html().trim() != "С������") {
							gonghaostrsss = $(this).find("td:eq(0)").html().trim();
						}
					});

					if (gonghaostrsss == "") {
						rdShowMessageDialog("��ѡ�������ˣ�");
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
			rdShowMessageDialog("������С�����ƣ�");
			return false;
		}

		//���ù���js
		var pageTitle = "С����ѯ";
		var fieldName = "��������|С������|С������|С���������ʴ���|С��������������|";//����������ʾ���С�����

		var selType = "S"; //'S'��ѡ��'M'��ѡ
		var retQuence = "4|1|2|3|4";//�����ֶ�

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
			rdShowMessageDialog("��ѡ��С����Ϣ��");
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
				tr_str += "<td colspan='2'><input type='button' value='ɾ��' class='b_text' onClick='deletzhka(this)'></td>";
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
			if ($(this).find("td:eq(0)").html().trim() != "С������") {
				xiaoqustrsss = $(this).find("td:eq(0)").html().trim();
				xiaoqujsxgstr = $(this).find("td:eq(2)").html().trim();
			}
		});
		if (xiaoqustrsss == "") {
			rdShowMessageDialog("���Ȳ�ѯС����Ϣ��ѡ����ٲ�ѯ�ʷ���Ϣ��");
			return false;
		}
		var offeridaaa = $("#offeridaaa").val();
		var offernameaaa = $("#offernameaaa").val();
		if (offeridaaa.trim() == "" && offernameaaa.trim() == "") {
			rdShowMessageDialog("�������ʷѴ�����ʷ����ƽ��в�ѯ��");
			return false;
		}

		//���ù���js
		var pageTitle = "�ʷ���Ϣ";
		var fieldName = "�ʷѴ���|�ʷ�����|�ʷ�Ʒ��|Ʒ������|";//����������ʾ���С�����

		var selType = "M"; //'S'��ѡ��'M'��ѡ
		var retQuence = "4|0|1|2|3";//�����ֶ�

		if (MySimpSel222(pageTitle, fieldName, "", selType, retQuence, '50',
				offeridaaa, offernameaaa, xiaoqujsxgstr))
			;
	}

	function MySimpSel222(pageTitle, fieldName, sqlStr, selType, retQuence,
			dialogWidth, offeridaaa, offernameaaa, xiaoqujsxgstr) {

		var offeridstrsss = "";
		$("#aaaa2 tr").each(function() {
			if ($(this).find("td:eq(0)").html().trim() != "�ʷѴ���") {
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
			rdShowMessageDialog("��ѡ���ʷ���Ϣ��");
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
						tr_str += "<td colspan='2'><input type='button' value='ɾ��' class='b_text' onClick='deletzhka(this)'></td>";
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
					var getCzf = new AJAXPacket("fm337_ajax_qryczf.jsp","���ڻ�ó�װ��...");
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
  	//���ù���js
    var pageTitle = "��������Ϣ";
    var fieldName = "��������|��������|";//����������ʾ���С�����
   
   
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1";//�����ֶ�

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
      rdShowMessageDialog("��ѡ�������ˣ�");
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
			  tr_str+="<td><input type='button' value='ɾ��' class='b_text' onClick='deletzhka(this)'></td>";   
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
				  if($(this).find("td:eq(0)").html().trim()!="�ʷѴ���"){
				  offeridstrsss = $(this).find("td:eq(0)").html().trim();
				  offeridband  = $(this).find("td:eq(2)").html().trim();
				  }
				}
		 );								 

			if(offeridstrsss==""){
       rdShowMessageDialog("���Ȳ�ѯ�ʷ���Ϣ��ѡ����ٲ�ѯС����Ϣ��");
       return false;
		 }
							
		var xiaoqumingchengss = $("#xiaoqunamebbb").val();
		if(xiaoqumingchengss.trim()=="") {
				rdShowMessageDialog("������С�����ƣ�");
				return false;
		}
				
  	//���ù���js
    var pageTitle = "С����ѯ";
    var fieldName = "��������|С������|С������|С���������ʴ���|С��������������|";//����������ʾ���С�����
   
   
    var selType = "M";    //'S'��ѡ��'M'��ѡ
    var retQuence = "4|1|2|3|4";//�����ֶ�

    if(MySimpSelBBB(pageTitle,fieldName,"",selType,retQuence,'50',xiaoqumingchengss,offeridband));
}

function MySimpSelBBB(pageTitle,fieldName,sqlStr,selType,retQuence,dialogWidth,xiaoqumingchengss,offeridband)
{
			var xiaoqustrsss="";
		 $("#aaaa11 tr").each(
				function(){
				  if($(this).find("td:eq(0)").html().trim()!="С������"){
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
      rdShowMessageDialog("��ѡ��С����Ϣ��");
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
			  tr_str+="<td colspan='2'><input type='button' value='ɾ��' class='b_text' onClick='deletzhka(this)'></td>"; 
			  tr_str+="</tr>";
			  flags1s=0;
			 }
			 
			 
		       
		       }
       }
    }
    $("#aaaa11").append(tr_str);
    $("select[name='kzxchuzhuangfei']").each(function (i){
    	var getCzf = new AJAXPacket("fm337_ajax_qryczf.jsp","���ڻ�ó�װ��...");
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
						rdShowMessageDialog("�������ʷѴ�����ʷ����ƽ��в�ѯ��");
						return false;
				}		
				
  	//���ù���js
    var pageTitle = "�ʷ���Ϣ";
    var fieldName = "�ʷѴ���|�ʷ�����|�ʷ�Ʒ��|Ʒ������|";//����������ʾ���С�����
   
   
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "4|0|1|2|3";//�����ֶ�

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
      rdShowMessageDialog("��ѡ���ʷ���Ϣ��");
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
			  tr_str+="<td colspan='2'><input type='button' value='ɾ��' class='b_text' onClick='deletzhka(this)'></td>"; 
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
						rdShowMessageDialog("������С�����ƣ�");
						return false;
				}
				
				$("#showTab2").empty();
 	/*2016/4/21 21:07:52 gaopeng ��ȡ��ǰѡ��Ĳ�������*/
 	var opType = $.trim($("input[name='opType'][checked]").val());
 	var myPacket = new AJAXPacket("ajax_queryXQ.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
	myPacket.data.add("xiaoqunameccc",xiaoqunameccc.trim());
	myPacket.data.add("opType",opType);
	
	core.ajax.sendPacketHtml(myPacket,querinfo,true);
	myPacket = null;
	
 }
 
	function querinfo(data){
		//�ҵ���ӱ���div
		var markDiv=$("#showTab"); 
		markDiv.empty();
		markDiv.append(data);
				
	}
	
	function querinfo2(data){
		//�ҵ���ӱ���div
		var markDiv=$("#showTab2"); 
		markDiv.empty();
		markDiv.append(data);
				
	}	
	
	/*2016/4/21 21:22:11 gaopeng ��ѯ�ͻ�������Ϣ����*/
	function sBroadManagerQry(objId) {
				
				var managerObj = $("#"+objId);
				var regionName = managerObj.find("td").eq(0).html();
				
				var xqdm = managerObj.find("td").eq(1).html();
				var xqName = managerObj.find("td").eq(2).html();
				var propertyUnit = managerObj.find("td").eq(3).html();
				var propertyUnitName = managerObj.find("td").eq(4).html();
				
			 	var myPacket = new AJAXPacket("fBroadManagerQry.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
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
							rdShowMessageDialog("��ѡ��Ҫɾ�������ݣ�");
							return false;
					}
					if(jishu>0&&checklength==0&&checklength2==0) {
							rdShowMessageDialog("��ѡ������ɾ�����ͣ�");
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
						rdShowMessageDialog("�������ʷѴ�����ʷ����ƽ��в�ѯ��");
						return false;
				}
				$("#showTab2").empty();	
 
 	var myPacket = new AJAXPacket("ajax_queryofferidcc.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
	myPacket.data.add("offeridccc",offeridccc.trim());
	myPacket.data.add("offernameccc",offernameccc.trim());

	core.ajax.sendPacketHtml(myPacket,querinfo,true);
	myPacket = null;
	
 }
 
	function querinfo(data){
		//�ҵ���ӱ���div
		var markDiv=$("#showTab"); 
		markDiv.empty();
		markDiv.append(data);
				
	}
	

		function queryxiaoquccajax(offid) {
			 	var myPacket = new AJAXPacket("ajax_queryofferid1.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
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
						rdShowMessageDialog("������С�����ƣ�");
						return false;
				}
				
  	//���ù���js
    var pageTitle = "С����ѯ";
    var fieldName = "��������|С������|С������|С���������ʴ���|С��������������|";//����������ʾ���С�����
   
   
    var selType = "M";    //'S'��ѡ��'M'��ѡ
    var retQuence = "4|1|2|3|4";//�����ֶ�

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
      rdShowMessageDialog("��ѡ��С����Ϣ��");
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
			  tr_str+="<td colspan='2'><input type='button' value='ɾ��' class='b_text' onClick='deletzhka(this)'></td>"; 
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
  	//���ù���js
    var pageTitle = "��������Ϣ";
    var fieldName = "��������|��������|";//����������ʾ���С�����
     
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1";//�����ֶ�

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
      rdShowMessageDialog("��ѡ�������ˣ�");
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
			  tr_str+="<td><input type='button' value='ɾ��' class='b_text' onClick='deletzhka(this)'></td>";   
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
			rdShowMessageDialog("������С�����ƣ�");
			return false;
		}
		$("#showTab2").empty();
		/*2016/4/21 21:07:52 gaopeng ��ȡ��ǰѡ��Ĳ�������*/
		var myPacket = new AJAXPacket("ajax_queryQDXQ.jsp", "���ڲ�ѯ��Ϣ�����Ժ�......");
		myPacket.data.add("xiaoqunameccc", qudaoxiaoquName.trim());
		core.ajax.sendPacketHtml(myPacket, querinfo, true);
		myPacket = null;

	}
	
	function querygroupidajax(xqdm) {
		var myPacket = new AJAXPacket("ajax_querygroupid.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
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

			        		<td width=16% class="blue">��������</td>

			        		<td width=84% colspan="3">

			        			<input type="radio" name="opType"	value="aaa"   onclick="changeType(this.value);" checked/>���С�����ö���ʷ� &nbsp;&nbsp;

			        			<input type="radio" name="opType"	value="bbb"  onclick="changeType(this.value);"/>����ʷ����ö��С�� &nbsp;&nbsp;
			        			
			        			<!--<input type="radio" name="opType"	value="ddd"  onclick="changeType(this.value);"/>Ӫ���ͱ�ע��Ϣ &nbsp;&nbsp; -->
			        			
			        			<input type="radio" name="opType"	value="ccc"  onclick="changeType(this.value);"/>���������ѯ &nbsp;&nbsp;
			        			
			        			<input type="radio" name="opType"	value="managerConfig"  onclick="changeType(this.value);"/>С���ͻ�������Ϣ��ѯ &nbsp;&nbsp;
			        			
			        			<input type="radio" name="opType"	value="xiaoquQudao"  onclick="changeType(this.value);"/>С��������Ϣ&nbsp;&nbsp;
			        			
			        			<input type="radio" name="opType"	value="xiaoquZifei"  onclick="changeType(this.value);"/>���С�����ʷ�����&nbsp;&nbsp;

			        		</td>

        				</tr>
       </table>
 
 	<div class="title" id="xiaoqudiv">
		<div id="title_zi">С����Ϣ</div>
	</div>      

 	<div class="title" id="offeriddiv22">
		<div id="title_zi">�ʷ���Ϣ</div>
	</div>	
		
       <table id="aaa" style="display:block">
       	        <tr>
					        <td class='blue' width=16%>С������</td>
					        <td colspan="2">
								<input type="text" value="" name="xiaoqunameaaa" id="xiaoqunameaaa"    maxlength="50" />
								<input name="queryxiaoquaa" id="queryxiaoquaa" type="button" class="b_text"  style="cursor:hand" onClick="getXiaoquAAA()" value=��ѯ>
					        </td>
					        </tr>    				
        			
					
        				
              </table>
              
                       <table id="bbb222" style="display:none">
  				
        	        <tr>
					       <td class='blue' width=16%>�ʷѴ���</td>
					        <td>
								<input type="text" value="" name="offeridbbb" id="offeridbbb"    maxlength="6"  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"  />
					        </td>
					       <td class='blue' width=16%>�ʷ�����</td>
					        <td>
								<input type="text" value="" name="offernamebbb" id="offernamebbb"    maxlength="50" />
								<input name="" type="button" class="b_text"  style="cursor:hand" onClick="getOfferidBBB()" value=��ѯ>
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
		<div id="title_zi">�ʷ���Ϣ</div>
	</div>		

 	<div class="title" id="xiaoqudiv22">
		<div id="title_zi">С����Ϣ</div>
	</div> 	
		
       <table id="aaa222" style="display:block">
  				
        	        <tr>
					       <td class='blue' width=16%>�ʷѴ���</td>
					        <td>
								<input type="text" value="" name="offeridaaa" id="offeridaaa"    maxlength="6"  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
					        </td>
					       <td class='blue' width=16%>�ʷ�����</td>
					        <td>
								<input type="text" value="" name="offernameaaa" id="offernameaaa"    maxlength="50" />
								<input name="" type="button" class="b_text"  style="cursor:hand" onClick="getOfferidAAA()" value=��ѯ>
								<input name="" type="button" class="b_text"  style="cursor:hand" onClick="delOfferidAAA()" value=ɾ��ȫ��>
					        </td>
					        </tr>  				                					
        				       			
      					

        </table>
        

           		  <table id="bbb" style="display:none">
       	        <tr>
					        <td class='blue' width=16%>С������</td>
					        <td colspan="2">
								<input type="text" value="" name="xiaoqunamebbb" id="xiaoqunamebbb"    maxlength="50" />
								<input name="queryxiaoqua" type="button" class="b_text"  style="cursor:hand" onClick="getXiaoquBBB()" value=��ѯ>
								<input name="" type="button" class="b_text"  style="cursor:hand" onClick="delXiaoquBBB()" value=ɾ��ȫ��>
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
		<div id="title_zi">��������Ϣ</div>
	</div>
	        
       <table id="aaa333" style="display:block">
  				       <tr>
					        <td colspan='3'>
								<input name="" type="button" class="b_text"  style="cursor:hand" onClick="getworknoAAA()" value=��������Ϣ>
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
					              		<option class="button" value="0" selected>����ͨ��</option>
					              		<option class="button" value="1">������ͨ��</option>
					              	</select>
					        </td>
					        </tr>   -->			
					        
       	        <tr id="xiaoqudivcc">
					        <td class='blue' width=16%>С������</td>
					        <td colspan="3">
								<input type="text" value="" name="xiaoqunameccc" id="xiaoqunameccc"    maxlength="50" />
								<input name="queryxiaoqua" type="button" class="b_text"  style="cursor:hand" onClick="getXiaoquchaxun()" value=��ѯ>
					        </td>
					        </tr>
					        
					         <tr id="xiaoqudivcc22">
					       <td class='blue' width=16%>�ʷѴ���</td>
					        <td>
								<input type="text" value="" name="offeridccc" id="offeridccc"    maxlength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"  />
					        </td>
					       <td class='blue' width=16%>�ʷ�����</td>
					        <td>
								<input type="text" value="" name="offernameccc" id="offernameccc"    maxlength="50" />
								<input name="" type="button" class="b_text"  style="cursor:hand" onClick="getOfferidccc()" value=��ѯ>
					        </td>
					        </tr>                  					
        				       			
        </table>
		<table id="xiaoquQudao" style="display: none">
			<tr id="daoruTypeTr">
				<td class='blue'>��������</td>
				<td colspan='3'><select name="qudaodaoruType"
					id="qudaodaoruType" onChange="changequdaodaoruType()" width=50
					index="6">
						<option class="button" value="A" selected>����</option>
						<option class="button" value="D">ɾ��</option>
						<option class="button" value="Q">��ѯ</option>
				</select></td>
			</tr>
			<tr id="qudaoxiaoquTr">
				<td class='blue' width=16%>С������</td>
				<td colspan="3"><input type="text" value=""
					name="qudaoxiaoquName" id="qudaoxiaoquName" maxlength="50" /> <input
					name="qudaoqueryBtn" id="qudaoqueryBtn" type="button" class="b_text"
					style="cursor: hand" onClick="qudaoxiaoquQuery()" value=��ѯ>
				</td>
			</tr>
			<tr id="qudaowenjianTr">
				<td class='blue' width=16%>�����ļ�</td>
				<td>
					<input type="file" id="uploadfile" name="uploadfile"/>
				</td>
				<td colspan="2" style="color: red">
					�����ļ��ĸ�ʽ��group_id|���С������(�м���"|"���,ÿ��һ��),һ����ർ��100����¼<br/>
					��:<br/>
					10031|T_SPACE_STANDARD_ADDRESS-8aee349d3d204303013d634999a31638<br/>
					10031|T_SPACE_STANDARD_ADDRESS-8aee349d3d204303013d634a882f16a4<br/>
					
				</td>
			</tr>
		</table>
		<table id="xiaoquZifei" style="display: none">
			<tr id="daoruTypeTr">
				<td class='blue'>��������</td>
				<td colspan='3'>
					<select name="zifeidaoruType" id="zifeidaoruType" onChange="changezifeidaoruType()" width=50 index="6">
						<option class="button" value="A" selected>����</option>
						<option class="button" value="D">ɾ��</option>
					</select>
				</td>
			</tr>
			<!-- <tr id="zifeixiaoquTr">
				<td class='blue' width=16%>С������</td>
				<td colspan="3"><input type="text" value=""
					name="zifeixiaoquName" id="zifeixiaoquName" maxlength="50" /> <input
					name="zifeiqueryBtn" id="zifeiqueryBtn" type="button" class="b_text"
					style="cursor: hand" onClick="zifeixiaoquQuery()" value=��ѯ>
				</td>
			</tr> -->
			<tr id="zifeiwenjianTr">
				<td class='blue' width=16%>�����ļ�</td>
				<td>
					<input type="file" id="uploadfile1" name="uploadfile1"/>
				</td>
				<td colspan="2" style="color: red">
					�����ļ��ĸ�ʽ������ʱ,�����ļ��ֶ����ٰ������ʷѴ��롢С�����롢��װ�ѡ�С����������(�м���"|"���,ÿ��һ��),һ����ർ��500����¼<br/>
					��:<br/>
					43952|T_SPACE_STANDARD_ADDRESS-8aee349d3d204303013d634999a31638|100|1<br/>
					44018|T_SPACE_STANDARD_ADDRESS-8aee349d3d204303013d634a882f16a4|80|2<br/>
				</td>
			</tr>
		</table>
		<div id="showTab" ></div>
		<div id="showTab2" ></div>
        <div class="title" id="ybxiaoqudiv">
        	<div id="title_zi">С����Ϣ</div>
        </div>
        <table id="ybxiaoqutab" style="display:none">
	        <tr>
	        	<td class='blue' width=16%>С������</td>
	        	<td colspan="2">
	        		<input type="text" value="" name="ybxiaoquname" id="ybxiaoquname"    maxlength="50" />
	        		<input name="queryxiaoqua" type="button" class="b_text" style="cursor:hand" onClick="getXiaoquDDD()" value=��ѯ>
	        	</td> 
	        </tr>
        </table>
        <table>
        	<TBODY id="ybxiaoquresult"></TBODY>
        </table>
		<table>
			<TBODY id="beizhutab">
				<tr>
					<TD width="16%">Ӫ���</TD>
					<TD><textarea id="yingxiaotext" name="yingxiaotext" rows=6
							cols='' style="width: 80%"></textarea></TD>
				</tr>
				<tr>
					<TD>��ע��Ϣ</TD>
					<TD><textarea id="beizhutext" name="beizhutext" rows=6 cols=''
							style="width: 80%"></textarea></TD>
				</tr>
			</TBODY>
		</table>
		<div class="title" id="ybshenpirendiv">
			<div id="title_zi">��������Ϣ</div>
		</div>
		<table id="ybshenpirentab" style="display: block">
			<tr>
				<td colspan='3'><input name="" type="button" class="b_text"
					style="cursor: hand" onClick="getworknoDDD()" value=��������Ϣ>
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
							value="����" onclick="doCommit()"> <input name="querysss"
							id="querysss" class="b_foot" type=button value=ɾ��
							onclick="shanchu111()"> <input class="b_foot"
							type=button name=back value="���" onClick="resetPage()"> <input
							class="b_foot" type=button name=qryP value="�ر�"
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
    var workB = excelObj.Workbooks.Add(); ////����µĹ�����   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =12;//�����п� 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =9;//�����п� 
  sheet.Columns("C").ColumnWidth =21;//�����п� 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =14;//�����п� 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =16;//�����п�
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =35;//�����п� 
  sheet.Columns("G").ColumnWidth =10;//�����п� 

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
					alert('����excelʧ��!');
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
   var workB = excelObj.Workbooks.Add(); ////����µĹ�����   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =12;//�����п� 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =9;//�����п� 
  sheet.Columns("C").ColumnWidth =21;//�����п� 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =14;//�����п� 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =16;//�����п�
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =35;//�����п� 
  sheet.Columns("G").ColumnWidth =10;//�����п� 
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
				alert('����excelʧ��!');
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