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
		var bankList = new Array(["ICBC","��������"]);
		
		$(document).ready(function (){
			pageInit();
			//getBankInstalList();
		});
		function pageInit(){
			$("#bankName").empty();
			$.each(bankList,function(i,n){
				var insertStr = "<option value='"+n[0]+"'>"+n[1]+"</option>";
				$("#bankName").append(insertStr);
			});
		}
		function getBankInstalList(submitBtn2){
		  /* ��ť�ӳ� */
			controlButt(submitBtn2);
			/* �º����� */
			getAfterPrompt();
			/* begin ��ȡӪ������ʡ�б�־@2013/3/12 */
			var marketingCaseId = $("#marketingCaseId").val();
      var stypeCodeIds = document.getElementById("stypeCodeId");
      var stypeCodeIdVal;
      for(i=0;i<stypeCodeIds.length;i++){            
        if(stypeCodeIds[i].selected==true){             
          stypeCodeIdVal = stypeCodeIds[i].value;               
        }   
      }
			/* end ��ȡӪ������ʡ�б�־@2013/3/12 */
			var bankCode = $("#bankName").val();
			var getdataPacket = new AJAXPacket("/npage/public/pubCallServ.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("serviceName","sg035Qry");
			getdataPacket.data.add("outnum","10");
			getdataPacket.data.add("inputParamsLength","10");
			getdataPacket.data.add("inParams0","");
			getdataPacket.data.add("inParams1","01");
			getdataPacket.data.add("inParams2","<%=opCode%>");
			getdataPacket.data.add("inParams3","<%=workNo%>");
			getdataPacket.data.add("inParams4","<%=password%>");
			getdataPacket.data.add("inParams5","");
			getdataPacket.data.add("inParams6","");
			getdataPacket.data.add("inParams7",bankCode);
			getdataPacket.data.add("inParams8",stypeCodeIdVal); //ʡ�б�־
			getdataPacket.data.add("inParams9",marketingCaseId);//Ӫ����
			core.ajax.sendPacket(getdataPacket,doGetListBack);
			getdataPacket = null;
		}
		function doGetListBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var result = packet.data.findValueByName("result");
			if(retCode == "000000"){
			  $("#listNamesTr").css("display","");
			  $("#opNoteTr").css("display","");
			  $("#subBtnTr").css("display","");
			  $("#bankInstalList").empty();
			  if(result.length>0){
			    $.each(result,function(i,n){
  					var insertStr = "<tr>";
  					insertStr += "<td><input type='radio' name='bankCodeRadio' value='"+result[i][0]+"' /></td>";
  					insertStr += "<td>"+result[i][4]+"</td>";
  					insertStr += "<td>"+result[i][1]+"</td>";
  					insertStr += "<td>"+result[i][2]+"</td>";
  					insertStr += "<td>"+result[i][3]+"</td>";
  					insertStr += "<td>"+result[i][8]+"</td>";
  					insertStr += "<td>"+result[i][9]+"</td>";
  					var tempStr = result[i][6].substr(0,result[i][6].length-1).replace(/\|/g,"<hr/>");
  					insertStr += "<td>"+tempStr+"</td>";
  					tempStr = result[i][7].substr(0,result[i][7].length-1).replace(/\|/g,"<hr/>");
  					insertStr += "<td>"+tempStr+"</td>";
  					insertStr += "</tr>";
  					$("#bankInstalList").append(insertStr);
				  });
			  }else{
			    var insertStr = "<tr>";
					insertStr += "<td colspan='9'>û�в�ѯ�����</td>";
					insertStr += "</tr>";
					$("#bankInstalList").append(insertStr);
					$("#opNoteTr").css("display","none");
			    $("#subBtnTr").css("display","none");
			  }
			}else{
				rdShowMessageDialog(retCode + ":" + retMsg,0);
				removeCurrentTab();
			}
		}
		function nextStep(){
			if(!check(document.form1)){
				return false;
			}
			/*��������ѡ��һ��*/
			if($("input[name='bankCodeRadio'][@checked]").length == 0){
				rdShowMessageDialog("������ѡ��һ���",0);
				return false;
			}
			var bankCodeVal = $("input[name='bankCodeRadio'][@checked]").val();
			var getdataPacket = new AJAXPacket("/npage/public/pubCallServ.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("serviceName","sg035Cfm");
			getdataPacket.data.add("outnum","2");
			getdataPacket.data.add("inputParamsLength","18");
			getdataPacket.data.add("inParams0",$("#loginAccept").val());
			getdataPacket.data.add("inParams1","01");
			getdataPacket.data.add("inParams2","<%=opCode%>");
			getdataPacket.data.add("inParams3","<%=workNo%>");
			getdataPacket.data.add("inParams4","<%=password%>");
			getdataPacket.data.add("inParams5","");
			getdataPacket.data.add("inParams6","");
			getdataPacket.data.add("inParams7","");
			getdataPacket.data.add("inParams8","");
			getdataPacket.data.add("inParams9","PT");
			getdataPacket.data.add("inParams10","");
			getdataPacket.data.add("inParams11","");
			getdataPacket.data.add("inParams12","");
			getdataPacket.data.add("inParams13","");
			getdataPacket.data.add("inParams14","");
			getdataPacket.data.add("inParams15","1");
			getdataPacket.data.add("inParams16",bankCodeVal);
			getdataPacket.data.add("inParams17","opNoteVal");
			core.ajax.sendPacket(getdataPacket,doAddBack);
			getdataPacket = null;
		}
		function doAddBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			if(retCode == "000000"){
				rdShowMessageDialog("�����ɹ�",2);
				resetPage();
			}else{
				rdShowMessageDialog(retCode + ":" + retMsg,0);
				resetPage();
			}
		}
		function resetPage(){
			window.location="/npage/sg035/fg035.jsp?opCode=g035&opName=�������ÿ����ڸ�������&crmActiveOpCode=g035";
		}
		
    function goBack(){
      window.location.href="fg035_del.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
			<td class="blue" width="15%">Ӫ��������</td>
			<td >
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
				<select name="stypeCodeCheck" id="stypeCodeId" style="width:190px">
				  <option value="" selected >*��ѡ��*</option>
          <%for (int i = 0; i < result1.length; i++) {%>
				    <option value="<%=result1[i][0]%>" ><%=result1[i][1]%></option>
				  <%}%>
				</select>
			</td>
		</tr>
		<tr>
      <td colspan="4" align="center" id="footer">
          <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="��ѯ" onClick="getBankInstalList(this)" />   
          <input type="button" id="reSetBtn"  name="reSetBtn"  class="b_foot" value="����" onClick="goBack()" /> 
          <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="�ر�" onClick="removeCurrentTab();" />
      </td>
    </tr>
	</table>
	<table>
		<tr id="listNamesTr" style="display:none">
			<th>ѡ��</th>
			<th>��������</th>
			<th>������</th>
			<th>��ʼ���</th>
			<th>�������</th>
			<th>����</th>
			<th>Ӫ��������</th>
			<th>����</th>
			<th>��Ϣ����</th>
		</tr>
		<tbody id="bankInstalList">
		</tbody>
	</table>
	<table>
		<tr id="opNoteTr" style="display:none">
			<td class="blue" width="15%">������ע</td>
			<td>
				<input type="text" name="opNote" id="opNote" size="60" maxlength="30"/>
			</td>
		</tr>
		<tr id="subBtnTr" style="display:none"> 
			<td id="footer" colspan="2"> <div align="center"> 
			<input name="confirm" type="button" class="b_foot" index="2" 
			 onClick="nextStep(this)" value="ȷ��"/>
			&nbsp; 
			<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�" />
			&nbsp; </div>
			</td>
		</tr>
	</table>
	<!-- ���ر����֣�Ϊ��һҳ�洫���� -->
	<input type="hidden" name="opCode" id="opCode" />
	<input type="hidden" name="opName" id="opName" />

	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>

</html>
