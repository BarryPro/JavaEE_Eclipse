
<%
	/*
	 * ���ܣ� ȫ������ҵ����Ϣҳ��
	 * �汾�� v1.0
	 * 20121128 sunzj
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	String xml = request.getParameter("gResInfo");
	String meansId = request.getParameter("meansId");
	System.out.println("gAddFeeInfo=xml===AAAAAAAAAAAAAAAAAAAAAA====" + xml);
	MapBean mb = new MapBean();
 %>	
 <%@ include file="getMapBean.jsp"%>
 <%	
	List fundsList = null;
	Iterator it =null;
	if(null != mb){
		fundsList = mb.getList("OUT_DATA.H39.GRES_LIST.GRES_INFO");
		if(null!=fundsList)
			it =fundsList.iterator();
	}
	String ALL_RES_UNDEADLINE = "";
	if(fundsList != null&&fundsList.size()>0){
		Map stMap = mb.isMap(fundsList.get(0));
		ALL_RES_UNDEADLINE = (String)stMap.get("ALL_RES_UNDEADLINE");
	}
 %>
<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation">
		<form method="post" name="frm4938" action="">
				
				<div id="operation_table">
					 <div class="title">
						<div class="text">
							�ն���ϸ��Ϣ
						</div>
					</div>
					<div class="input">
					<table>
						<tr>
							<th>IMEI��</th>
							<td>	
								<input type="text" name="imei_code" id="imei_code" value="" onkeyup="this.value=this.value.replace(/[^\d]/g,'');"/>
								<input type="button" class="b_text" name="verify" id="verify" onclick="chkrBrand()" value="��֤"/>
								<font style="color:red"><b>*</b></font>
								<div id="td1" align="left">
							</td>
							<th>����ʱ��</th>
							<td>
								<input type="text" name="cmit_date" id="cmit_date"  class="required Wdate"  value=""
									readonly
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',onpicked:function(){validateElement(this)}})" />
								<font color="red"><b>*</b></font>
							</td>
						</tr>									
						<tr>
							<th>����ʱ��</th>
							<td><input type="text" name="quality_limit" id="quality_limit" value=""/></td>
							<th>�������</th>
							<td>
								<%=ALL_RES_UNDEADLINE %>
							</td>
						</tr>					
					</table>
					<table>
						<tr>
							<th>ѡ��</th>
							<th>�ն�Ʒ��</th>
							<th>�ն��ͺ�</th>
							<th>�ն˳ɱ�</th>
							<th>������</th>
						</tr>
					<%if(fundsList != null && fundsList.size()>1 ){
						for(int i=1; i<fundsList.size(); i++){
							Map stMap = mb.isMap(fundsList.get(i));
							if(null==stMap)continue;
							String All_RES_BRAND = (String)stMap.get("All_RES_BRAND") == null ? "":(String)stMap.get("All_RES_BRAND");
							String All_RES_MODEL = (String)stMap.get("All_RES_MODEL") == null ? "":(String)stMap.get("All_RES_MODEL");
							String All_RES_COST_PRICE = (String)stMap.get("All_RES_COST_PRICE") == null ? "":(String)stMap.get("All_RES_COST_PRICE");
							String All_RES_FEE = (String)stMap.get("All_RES_FEE") == null ? "":(String)stMap.get("All_RES_FEE");
							String ALL_RES_CODE = (String)stMap.get("All_RES_CODE") == null ? "":(String)stMap.get("All_RES_CODE");
							String All_RES_BRAND_CODE = (String)stMap.get("All_RES_BRAND_CODE") == null ? "":(String)stMap.get("All_RES_BRAND_CODE");
					 %>
							<tr>
								<td>
									<input type="radio" name="fee" id="<%=ALL_RES_CODE %>"  size="1"/>
									<input type="hidden" name="brand_code" id="<%=ALL_RES_CODE %>_11" value="<%=All_RES_BRAND_CODE %>" />
								</td>														
								<td id="<%=ALL_RES_CODE %>_1">
									<%=All_RES_BRAND%>					
								</td>
								<td id="<%=ALL_RES_CODE %>_2">
									<%=All_RES_MODEL%>
								</td>
								<td id="<%=ALL_RES_CODE %>_3">
									<%=All_RES_COST_PRICE%>
								</td>	
								<td id="<%=ALL_RES_CODE %>_4">
									<%=All_RES_FEE%>
								</td>																		
							</tr>
						
						<%}}%>
						</table>
						</div>
					<div id="operation_button">
						<input type="button" class="b_foot"  disabled="disabled" value="ѡ��" id="btnSubmit"
							name="btnSubmit" onclick="subAll()" />					
						<input type="button" class="b_foot" value="�ر�" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">
	function subAll(){
		var cmit_date = $("#cmit_date").val();
		if(cmit_date==null||cmit_date=="null"||cmit_date==""){
			showDialog("��ѡ��ɽ���ʱ��!",0);
		 	return false;		
		}
		var quality_limit=$("#quality_limit").val();
		var checkEle = $("input:checked");
		
		var res_code = $(checkEle[0]).attr("id");
		var brand =  $.trim($("#"+res_code+"_1").text());
		var model =  $.trim($("#"+res_code+"_2").text());
		var price =  $.trim($("#"+res_code+"_3").text());
		var fee =  $.trim($("#"+res_code+"_4").text());
		var imei =  $.trim($("#imei_code").val());
		var brand_code =  $.trim($("#"+res_code+"_11").val());
		var des = "�ն�Ʒ�ƣ�"+brand+"���ն��ͺţ�"+model+"��������"+fee+"Ԫ"+"������ʱ��"+quality_limit+"���£��������"+<%=ALL_RES_UNDEADLINE%>+"����";
		//�洢����
		parent.saveGRes("<%=meansId%>", res_code, brand, model, price, fee, imei, cmit_date, quality_limit, brand_code, des, <%=ALL_RES_UNDEADLINE%>);
		closeWin();
	}
	
	function closeWin(){
		closeDivWin();
	}
	
	function chkrBrand(){
		var checkEle = $("input:checked");
		if(checkEle.length == 0){
			showDialog("��ѡ���ն�!",0);
			return;
		}
		var tid = $(checkEle[0]).attr("id");
		var imei_code = $("#imei_code").val();//IMEI
		var packet = null;
		packet = new AJAXPacket("checkResource.jsp","���Ժ�...");
		packet.data.add("imei_code",imei_code);
		packet.data.add("RESOURCE_RES_CODE",tid);
		core.ajax.sendPacketHtml(packet,doResourceCat,true);
		packet =null;
	}
	function doResourceCat(data){
		
		var idAndName =data.split(",");
		if(trim(idAndName[0])=="000000")
		{
			var td1 = document.getElementById("td1");
	 		td1.innerHTML=trim(idAndName[1]);
	 		$("#btnSubmit").attr("disabled",false);
	 		$("#imei_code").attr("readonly",true);
	 		$("input:radio").attr("disabled",true);
						
		}else if(trim(idAndName[0])!="000000")
		{
			var td1 = document.getElementById("td1");
	 		td1.innerHTML=trim(idAndName[1]);
			$("#btnSubmit").attr("disabled",true);
		}
	}
	
	</script>
</html>