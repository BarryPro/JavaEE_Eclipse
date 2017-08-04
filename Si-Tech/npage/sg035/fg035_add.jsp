<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
version v1.0
������: si-tech
ningtn 2012-8-21 18:42:36
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = request.getParameter("opCode");
 		String opName = request.getParameter("opName");
 		String workNo = (String)session.getAttribute("workNo");
  	String password = (String)session.getAttribute("password");
 		String regionCode= (String)session.getAttribute("regCode");
 		
 		StringBuffer  stypesql = new StringBuffer();
  	stypesql.append("select type_code, nvl(b.region_name,'ʡ��˾') ");
  	stypesql.append("  from sUseCenter a, sregioncode b  ");
  	stypesql.append(" where a.USE_FLAG = 'Y'  ");
  	stypesql.append(" and  a.type_code=b.region_code(+) ");
  	stypesql.append(" group by type_code,nvl(b.region_name,'ʡ��˾') ");
  	stypesql.append(" order by type_code desc ");
%>
<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
<wtc:sql><%=stypesql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end" />

<html>
<head>
	<title>�������ÿ����ڸ�������</title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		var bankList = new Array(["ICBC","��������","EI"]);
		var installmentList = new Array(["3","3����"],["6","6����"],["12","12����"],["18","18����"],["24","24����"]);
		
		$(document).ready(function (){
			pageInit();
		});
		function pageInit(){
			$("#bankName").empty();
			$.each(bankList,function(i,n){
				var insertStr = "<option value='"+n[0]+"' payType='"+n[2]+"'>"+n[1]+"</option>";
				$("#bankName").append(insertStr);
			});
			$("#installmentSpan").empty();
			$.each(installmentList,function(i,n){
				var insertStr = "<input type='checkbox' name='installment' id='installment_"+i+"' value='"+n[0]+"' onclick='addItem(this)' />"+n[1]+"&nbsp;";
				$("#installmentSpan").append(insertStr);
			});
			$("#price").val("");
			$("#beginMoney").val("");
			$("#endMoney").val("");
			$("#opNote").val("");
			viewModel.rates.removeAll();
			$("[name='stypeCodeCheck']").removeAttr("checked");//ȡ��ȫѡ
			for(j=0;j<<%=result1.length%>;j++){
  			document.getElementById("stypeCode"+j).checked=false;
  			document.getElementById("stypeCode"+j).disabled=false;
    	}
		}
		function addItem(obj){
			var checkboxVal = obj.value;
			/*��ȡcheckboxѡ��״̬*/
			var checkedFlag = $(obj).attr("checked");
			if(typeof(checkedFlag) != "undefined" && checkedFlag == true){
				viewModel.rates.push({ installmentName: checkboxVal, rate: "" ,delBtnShowName: "delBtn"+checkboxVal, rateName: "rateText"+checkboxVal});
			}else{
				$.each($("input[name^='rateText']"),function(i,n){
					hiddenTip(n);
				});
				$("input[@name='delBtn"+checkboxVal+"']").click();
			}
			
		}
		function nextStep(submitBtn2){
			 /* ��ť�ӳ� */
			controlButt(submitBtn2);
			/* �º����� */
			getAfterPrompt();
			if(!check(document.form1)){
				return false;
			}
			/****begin ����Ӫ������ʡ�б�־���ж�@2013/3/12  ****/
			var marketingCaseId = $("#marketingCaseId").val();
			var checkedLength = $("input[type='checkbox'][name='stypeCodeCheck'][checked]").length; 
			if(checkedLength==0||checkedLength==""){
			  rdShowMessageDialog("������ѡ��һ�����У�",1);
				return false;
		  }
		  
			/****end ����Ӫ������ʡ�б�־���ж�@2013/3/12  ****/
			/*��������ѡ��һ��*/
			if($("input[name='installment'][@checked]").length == 0){
				rdShowMessageDialog("������ѡ��һ�����ڣ�",0);
				return false;
			}
			/*���ӿ�ʼ���С�ڽ�����������*/
			var beginMoneyVal = $("#beginMoney").val();
			var endMoneyVal = $("#endMoney").val();
			if((Number(endMoneyVal) - Number(beginMoneyVal)) < 0){
				rdShowMessageDialog("��ʼ���ܴ��ڽ�����",0);
				return false;
			}
			/*��Ϣ���� (0=<X<=100 ������С��)*/
			var rateFlag = true;
			var rateVal = "";
			var rateTextVal = "";
			$.each($("input[name^='rateText']"),function(i,n){
				if(Number($(n).val()) > 100){
					rateFlag = false;
					showTip(n,"��Ϣ����������0~100֮���ֵ��");
				}
				rateVal += $(n).attr("name").substr(8,$(n).attr("name").length) + "|";
				rateTextVal += $(n).val() + "|";
			});
			if(!rateFlag){
				//rdShowMessageDialog("��Ϣ����������0~100֮���ֵ��",0);
				return false;
			}
			var bankCode = $("#bankName").val();
			var bankName = $("#bankName option[@selected]").text();
			var payType = $("#bankName option[@selected]").attr("payType");
			var machFee = $("#price").val();
			var beginFeeVal = $("#beginMoney").val();
			var endFeeVal = $("#endMoney").val();
			var opNoteVal = $("#opNote").val();
			/*
			alert(rateVal);
			alert(rateTextVal);
			*/
			/* begin ��ȡӪ������ʡ�б�־@2013/3/12 */
      var checks = "";
      $("input[name='stypeCodeCheck']").each(function(){
        if($(this).attr("checked") == true){
          checks += $(this).val() + "|";            //��̬ƴȡѡ�е�checkbox��ֵ���á�|�����ŷָ�
        }
      });
      if(checks!=""){
        checks = checks.substring(0,checks.length-1);
      }
			/* end ��ȡӪ������ʡ�б�־@2013/3/12 */
			var getdataPacket = new AJAXPacket("/npage/public/pubCallServ.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("serviceName","sg035Cfm");
			getdataPacket.data.add("outnum","2");
			getdataPacket.data.add("inputParamsLength","20");
			getdataPacket.data.add("inParams0",$("#loginAccept").val());
			getdataPacket.data.add("inParams1","01");
			getdataPacket.data.add("inParams2","<%=opCode%>");
			getdataPacket.data.add("inParams3","<%=workNo%>");
			getdataPacket.data.add("inParams4","<%=password%>");
			getdataPacket.data.add("inParams5","");
			getdataPacket.data.add("inParams6","");
			getdataPacket.data.add("inParams7",bankCode);
			getdataPacket.data.add("inParams8",bankName);
			getdataPacket.data.add("inParams9",payType);
			getdataPacket.data.add("inParams10",machFee);
			getdataPacket.data.add("inParams11",beginFeeVal);
			getdataPacket.data.add("inParams12",endFeeVal);
			getdataPacket.data.add("inParams13",rateVal);
			getdataPacket.data.add("inParams14",rateTextVal);
			getdataPacket.data.add("inParams15","0");
			getdataPacket.data.add("inParams16","");
			getdataPacket.data.add("inParams17",opNoteVal);
			getdataPacket.data.add("inParams18",checks); //ʡ�б�־
			getdataPacket.data.add("inParams19",marketingCaseId); //Ӫ����
			core.ajax.sendPacket(getdataPacket,doAddBack);
			getdataPacket = null;
		}
		function doAddBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			if(retCode == "000000"){
				rdShowMessageDialog("�����ɹ�",2);
				//pageInit();
				window.location.href="fg035_add.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			}else{
				rdShowMessageDialog(retCode + ":" + retMsg,0);
				//pageInit();
				window.location.href="fg035_add.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			}
		}
		
		var num = 0;
		function seleStypeCode(obj){
		  if(obj.value=="99"){//ѡ��ʡ��˾�����������ûң����ܽ���ѡ��
        var j;
      	for(j=0;j<<%=result1.length%>;j++){
      		if(obj.checked){
      			document.getElementById("stypeCode"+j).checked=false;
      			document.getElementById("stypeCode"+j).disabled=true;
      			obj.disabled = false;
      			obj.checked = true;
      		}else if(obj.checked==false){
      			document.getElementById("stypeCode"+j).checked=false;
      			document.getElementById("stypeCode"+j).disabled=false;
      		}
      	}
		  }else{//ѡ���������У�ʡ��˾�û�
		    <%for(int j=0;j<result1.length;j++){%>
		        if(obj.checked){
		    <%    if("99".equals(result1[j][0])){%>
		            document.getElementById("stypeCode<%=j%>").checked=false;
      	        document.getElementById("stypeCode<%=j%>").disabled=true;
		    <%    }%>
		        }else if(obj.checked==false){
		          var checkedLength = $("input[type='checkbox'][name='stypeCodeCheck'][checked]").length;  
		          //alert(checkedLength); 
		          if(checkedLength==0){
		    <%      if("99".equals(result1[j][0])){%>
		            document.getElementById("stypeCode<%=j%>").checked=false;
      	        document.getElementById("stypeCode<%=j%>").disabled=false;
		    <%      }%>
		          }
		        }
		    <%}%>
      }
    }
    
    function goBack(){
      window.location.href="fg035_add.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
    }
	</script>
</head>
<body>
<form action="" method="post" name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�������ÿ����ڸ�������</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue" width="15%">��������</td>
			<td>
				<select name="bankName" id="bankName">
				</select>
			</td>
			<td class="blue" width="15%">������</td>
			<td>
				<input type="text" name="price" id="price" v_type="money" 
				v_must="1" onblur = "checkElement(this)" maxlength="10"/>
			</td>
		</tr>
		<tr>
			<td class="blue" width="15%">��ʼ���</td>
			<td>
				<input type="text" name="beginMoney" id="beginMoney" 
				 v_type="money" v_must="1" onblur = "checkElement(this)"/>
			</td>
			<td class="blue" width="15%">�������</td>
			<td>
				<input type="text" name="endMoney" id="endMoney" 
				 v_type="money" v_must="1" onblur = "checkElement(this)"/>
			</td>
		</tr>
		<tr>
			<td class="blue" width="15%">Ӫ��������</td>
			<td colspan="3">
				<select name="marketingCase" id="marketingCaseId" style="width:190px">
				  <%
				    if("aaa8wz".equals(workNo)){
				  %>
				      <option value="8030" >�����û�Ԥ�滰������(8030)</option>
				  <%
				    }else{
				  %>
				      <option value="e505" >��Լ�ƻ�����(e505)</option>
				  <%
				    }
				  %>
				</select>
			</td>
		</tr>
		<tr>
    	<td class="blue" width="15%" >ʡ�б�־</td>
    	<td colspan="3">
    		<%for (int i = 0; i < result1.length; i++) {%>
	      		<input type="checkbox" name="stypeCodeCheck" id="stypeCode<%=i%>" value="<%=result1[i][0]%>" onclick="seleStypeCode(this)"  /><%=result1[i][1]%>&nbsp;&nbsp;
	    	<%}%>
    	</td>
    </tr>
		<tr>
			<td class="blue" width="15%">����</td>
			<td colspan="3">
				<span id="installmentSpan">
				</span>
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<th>����</th>
			<th>��Ϣ����</th>
		</tr>
		<tbody data-bind='template: { name: "rateRowTemplate", foreach: rates }'>
    </tbody>
	</table>
	<table>
		<tr>
			<td class="blue" width="15%">������ע</td>
			<td>
				<input type="text" name="opNote" id="opNote" size="60" maxlength="30"/>
			</td>
		</tr>
		<tr > 
			<td id="footer" colspan="2"> <div align="center"> 
			<input name="confirm" type="button" class="b_foot" index="2" 
			 onClick="nextStep(this)" value="ȷ��"/>
			&nbsp; 
			<input name="reset" type="reset" class="b_foot" value="���" onclick="goBack()"/>
			&nbsp; 
			<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�" />
			&nbsp; </div>
			</td>
		</tr>
	</table>
	<!-- ���ر����֣�Ϊ��һҳ�洫���� -->
	<input type="hidden" name="opCode" id="opCode" />
	<input type="hidden" name="opName" id="opName" />
	<script type="text/html" id="rateRowTemplate">
		<tr>
			<td>
			<span data-bind="text:installmentName"></span>
			</td>
			<td>
			<input type="text" v_must="1" v_type="cfloat" onblur = "checkElement(this)"
			 data-bind="attr:{name:rateName}"/>
			<input type="button" data-bind="attr:{name:delBtnShowName},click: function() { viewModel.removeRate($data) }" style="display:none;"/>%
			</td>
		</tr>
	</script>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
	<script>
		var viewModel = {
		    rates: ko.observableArray([]),
		    removeRate: function (rate) {
		        this.rates.remove(rate);
		    }
		};
		ko.applyBindings(viewModel);
	</script>
</html>