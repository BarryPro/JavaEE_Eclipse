<%
  /*
   * ����:�������
�� * �汾:  v1.0
�� * ����: 2009-01-15 10:00
�� * ����: wanglj
�� * ��Ȩ: sitech
��*/
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode = (String)request.getParameter("opCode");
    String opName = (String)request.getParameter("opName");
	//String PSiteId_Cur   = (String)session.getAttribute("siteId");
	String PSiteId_Cur   = (String)session.getAttribute("groupId");
    String PSiteName_Cur = (String)session.getAttribute("siteName");
    String workNo = (String)session.getAttribute("workNo");
    String gCustId =  request.getParameter("gCustId");
    String custOrderId =  request.getParameter("custOrderId");
    String loginNo = (String) session.getAttribute("workNo");	//��������
    System.out.println("PSiteId_Cur======"+PSiteId_Cur);
    System.out.println("gCustId======"+gCustId);
    System.out.println("custOrderId======"+custOrderId);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��������</title>
</head>
<script type="text/javascript" src="/njs/si/validate_class.js"></script>
<script type="text/javascript">
		var arrayOrderStr = "";
		var filed_name = "��������ID|�ͻ�����ID|ҵ�����|��������|��������|״̬|����ʱ��|�����|���ȼ�|��ע"; //����Ϣ
		var page_size = "10";//ÿҳ��¼��
		var sel_type = "M"; //ѡ������,M��ѡ��,S��ѡ��,""û��ѡ��,��ΪM��Sʱ,���ѡ���,�����selectRow()����,��ret_quenceָ����ֵ���ظ�ѡ���
		var ret_quence= "0";//ָ���ɼ�������,��ʽ:"0|3|5"
		var servJsp = "fq025_ajax.jsp?type=1&order_val=<%=workNo%>";//�������ajaxҳ��,�����񷵻ؽ������ɶ�ά�ַ�������,���ظ���ҳ��,��ҳ����ûص���������
		
		var closeFlag = false; //�ж��������ύҳ��,���ǷǷ��ر�ҳ��
		window.onload = function init(){ initPage025();};
		 
function selectRow(){}

function chg_dep()
{
	var sel_dep = document.getElementById("select_dep");
	sel_dep.value = "1"; //���ݿͻ�Ҫ��,ֻ�����Ա�����Լ�����ĵ���
	if(sel_dep.value=="0")
	{
		document.getElementById("thName").innerHTML="";
		document.getElementById("order_val").value="";
		document.getElementById("order_val").className="";
		document.getElementById("order_val").readOnly=true;
	}else if(sel_dep.value=="1")
	{
		document.getElementById("thName").innerHTML="Ա����:";
		document.getElementById("order_val").value="";
		document.getElementById("order_val").className="required";
		document.getElementById("order_val").readOnly=true;
	}else if(sel_dep.value=="2")
	{
		document.getElementById("thName").innerHTML="������:";
		document.getElementById("order_val").value="";
		document.getElementById("order_val").className="required";
		document.getElementById("order_val").readOnly=false;
	}else if(sel_dep.value=="3")
	{
		document.getElementById("thName").innerHTML="��������:";
		document.getElementById("order_val").value="";
		document.getElementById("order_val").className="required";
		document.getElementById("order_val").readOnly=false;
	}
}
 
function gotoPage025(pageNum)
				{
					if(Number(pageNum) <= 0 ||Number(pageNum) > Number(g("totalpage").value)){
						return false;		 
					}
				  var mypacket = new AJAXPacket(servJsp,"���Ժ�");
				  mypacket.data.add("ret_type","showPageList025");
				  mypacket.data.add("filed_name",filed_name);													
				  mypacket.data.add("pageSize",page_size);
				  mypacket.data.add("currentPage",pageNum);
				  core.ajax.sendPacket(mypacket,publicListPageq025);
				  mypacket = null;
				}
function initPage025()
				{
				  var mypacket = new AJAXPacket(servJsp,"���Ժ�");
				  mypacket.data.add("ret_type","showPageList025");
				  mypacket.data.add("filed_name",filed_name);													
				  mypacket.data.add("pageSize",page_size);
				  mypacket.data.add("currentPage",1);
				  core.ajax.sendPacket(mypacket,publicListPageq025);
				  mypacket = null;
				}	

 
function publicListPageq025(packet){
       error_code = packet.data.findValueByName("errorCode");
       error_msg =  packet.data.findValueByName("errorMsg");
       retType = packet.data.findValueByName("retType"); 
       g("curpage").value= packet.data.findValueByName("currentPage");
       g("totalpage").value= packet.data.findValueByName("totalPage");
       g("totalrec").value= packet.data.findValueByName("totalRec");
       var obj=g("list_page");
	   	  var cols = filed_name.split("|");
	   	  var tmpstr = "";
	   	  for(var i = 0 ; i < cols.length;i++){
	   	  		tmpstr = tmpstr +"<th>" + cols[i]+"</th>";
	   	  }
	   		if(!(sel_type == "")){
	   			obj.innerHTML="<table id='listtbl' name='listtbl'><tr>" + tmpstr + "<th>ѡ��</th></tr></table>";
	   		}else{
	   			obj.innerHTML="<table id='listtbl' name='listtbl'><tr>" + tmpstr + "</tr></table>";
	   		}
       if(error_code != "0"){
       		rdShowMessageDialog("û�д���˶���!");
       		return false;
       }
       if(retType == "showPageList025"){
      		var result = packet.data.findValueByName("arrMsg");
      		if (result == null) return false;
      		var obj = document.getElementById("listtbl");
      		var tabRowNum;
      		for(var i = 0 ; i < result.length; i ++){
      			var resultCol = result[i];
      			if(sel_type=="M"){
      				var rowvalue = "";
							var retval = ret_quence.split("|");
							for(var j = 0 ; j< retval.length; j++){
									rowvalue= rowvalue + resultCol[retval[j]]+"|";
							}
							if(resultCol.length != 0){
      					resultCol.push("<input type='checkbox' name='checkList' value='" + rowvalue + "' onclick='selectRow(this.value)'>");              					
      				}
      			}else if(sel_type=="S"){
      				var rowvalue = "";
							var retval = ret_quence.split("|");
							for(var j = 0 ; j< retval.length; j++){
									rowvalue= rowvalue + resultCol[retval[j]]+"|";
							}
							if(resultCol.length != 0){
      					resultCol.push("<input type='radio' name='singleList' value='" + rowvalue + "' onclick='selectRow(this.value)'>");              					
      				}
      			}
      			 tabRowNum = g("listtbl").rows.length;
      			 dynAddTr("listtbl",tabRowNum,resultCol);
      	  }
      }
 }
 
 /*
*��̬�����wangljadd20090219
*/ 					
function dynAddTr(tableID,trIndex,arrTdCont)
{
	var tableId=g(tableID);
	var insertTr=tableId.insertRow(trIndex);
	var arrTd=new Array();
	for(var i=0;i<arrTdCont.length;i++)
	{
		arrTd[i]=insertTr.insertCell(i);
	}
	for(var i=0;i<arrTdCont.length;i++)
	{
		arrTd[i].innerHTML=arrTdCont[i];
	}
} 

	$(document).ready(function(){
		var checkType="";
		if(sel_type=="M"){
				checkType="checkList";
		}else if(sel_type=="S"){
				checkType="singleList";
		} 
		$("#selAll").toggle(
			function() {
					var obj = g("frm");
					for(var i = 0 ; i< obj.elements.length;i++){
							if(obj[i].name == checkType && obj[i].checked==false){
								obj[i].checked = true;
							}
					}	
			}, 
			function() {
				var obj = g("frm");
					for(var i = 0 ; i< obj.elements.length;i++){
							if(obj[i].name == checkType && obj[i].checked==true){
								obj[i].checked = false;
							}
					}		
			}
		);
	});

function ask_dep()
{
	servJsp = "fq025_ajax.jsp?type="+g("select_dep").value+"&order_val="+g("order_val").value;
	gotoPage025(1);
}
function doSubmit(){
	var checkType="";
	if(sel_type=="M"){
			checkType="checkList";
	}else if(sel_type=="S"){
			checkType="singleList";
	}
	var check = false;
	var obj = g("frm");
	for(var i = 0 ; i< obj.elements.length;i++){
			if(obj[i].name == checkType && obj[i].checked==true){
					check = true;
			}
	}
	if(check == false){
			rdShowMessageDialog("��ѡ��Ҫ��˵Ķ�����!",0);	
			return false;
	}
	closeFlag = true;
	document.all.frm.action='fq025_cfm.jsp?array_order='+checkType;
	document.all.frm.submit();
}

window.onbeforeunload =function LeaveWin(){
	        if(!closeFlag){
	        	<%
	        		if(custOrderId != null && !"".equals(custOrderId)){
	        	%>
	        			closeLog();
	        	<%}%>
	        	rdShowMessageDialog("�ö�����δ���,���ڴ����״̬,�뵽�ͻ���ҳ��ѯ�ö������жϵ������������!");
	    	}
		}
		
		function closeLog(){
			var myPacket = new AJAXPacket("fq025_log_ajax.jsp","���ڻ����Ϣ�����Ժ�......");
			var opNote = "����Ա<%=loginNo%>�Ƿ��رն������ҳ��,<%=custOrderId%>�������ڴ����״̬";			
			myPacket.data.add("opNote",opNote);
			myPacket.data.add("custOrderId","<%=custOrderId%>");	
			myPacket.data.add("opCode",g("opCode").value);	
			myPacket.data.add("loginNo","<%=loginNo%>");
			core.ajax.sendPacket(myPacket,getCloseLog);	
			myPacket=null;	
		}
		function getCloseLog(packet){
			var err_code = packet.data.findValueByName("errorCode");
		}		
</script>

<body>
	<FORM method="post" name="frm" id="frm" >
 	<%@ include file="/npage/include/header.jsp" %>
 	<div class="title">
	<div id="title_zi">�ͻ�������ѯ</div>
</div>

			<table cellspacing=0>
				<tr>
					<td class='blue'>��ѯ����</td>
					<td>
						<select id="select_dep" onchange="chg_dep()" readonly="true">
							<!--<option value="0">0->����</option>-->
							<option value="1">1->Ա����</option>
							<!--<option value="2">2->������</option>-->
							<!--<option value="3">3->��������</option>-->
						</select>
					</td>
					<td class='blue' id="thName"><!--����:--> ����Ա��</td>
					<td>
						<input type="text" id="order_val" name="order_val" class="" value="<%=workNo%>"readonly/>
					</td>
					<td ><input type="button" name="quer" class="b_text" value="��ѯ"  onclick="ask_dep()"/></td>
				</tr>
			</table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">�ͻ���������</div>
</div>

     		<!--�����б�DIV-->
				<div class="list" id="list_page">
				</div>
				<div id="operation_pagination">
				    <table cellspacing=0>
				        <tr><td>
					��<input type="text" size="3" style="text-align:right" readOnly name="curpage" id="curpage" value="1">ҳ
					��<input type="text" size="3" style="text-align:right" readOnly name="totalpage" id="totalpage" value="1">ҳ
					<input type="text" size="5" style="text-align:right" name="totalrec" id="totalrec" value="1">����¼
					<a style="cursor:hand;" onclick=gotoPage025("1")>[��ҳ]</a></span>&nbsp;
					<a style="cursor:hand;" onclick=gotoPage025(Number(g("curpage").value)-1)>[��һҳ]</a>&nbsp;
					<a style="cursor:hand;" onclick=gotoPage025(Number(g("curpage").value)+1)>[��һҳ]</a>&nbsp;
					<a style="cursor:hand;" onclick=gotoPage025(Number(g("totalpage").value))>[βҳ]</a>&nbsp;
					ת��<input type="text" size="5" onchange="gotoPage025(Number(this.value))">ҳ
				</td></tr>
			</table>
				</div>
		<div id="footer">
			<input type="button" class="b_foot_long" name="selAll" id="selAll" value="ȫ��ѡ��" > 
			<input type="button" class="b_foot" value="���" onclick="doSubmit()"> 
		</div>
		<input type="hidden"  id="sum_ret" value="" />
		<input type="hidden"  id="ask_depval" value="0" />
		<input type="hidden" name="gCustId" id="gCustId" value="<%=gCustId%>">
		<input type="hidden" id="opCode" name="opCode" value="<%=opCode%>"/>
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</body>
</html>


