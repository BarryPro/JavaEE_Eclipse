<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)[2017/3/6 ����һ 13:37:11]------------------
 
 
 -------------------------��̨��Ա��[]--------------------------------------------
 
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

//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}


//
function go_Query(){
	if($("#in_unitid").val().trim()==""&&$("#in_ecid").val().trim()==""&&$("#in_productofferId").val().trim()==""){
		rdShowMessageDialog("���ű��롢EC���ű��롢������ϵid��������һ����Ŀ");
		return;
	}
	
	if($("#in_starttime").val().trim()==""){
		rdShowMessageDialog("�鵵���ڿ�ʼ��������");
		return;
	}
	
	if($("#in_endtime").val().trim()==""){
		rdShowMessageDialog("�鵵���ڽ�����������");
		return;
	}
 	var pactket = new AJAXPacket("fm461_Qry.jsp","���ڽ��в�ѯ�����Ժ�......");
 			
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

// �ص�
function do_Query(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
		
			var opType = $("#sel_opType").val();
			$("#sel_opType").attr("disabled","disabled");
			if("del"==opType){
				$("#td_htd5").hide();
			}
			
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			$("#upgMainTab tr:gt(0)").remove();
			
			var btn_objStr = "";
			var td5_style  = "";
			
			for(var i=0;i<retArray.length;i++){
					if("add"==opType){
							btn_objStr = "<input type=\"button\" value=\"����\" class=\"b_text\" onclick=\"go_Cfm(this,'add')\">";
					}
					
					if("del"==opType){
							td5_style  = "style='display:none'";
							btn_objStr = "<input type=\"button\" value=\"�ؿ�\" class=\"b_text\" onclick=\"go_Cfm(this,'del')\">";
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
			
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}



function go_Cfm(bt,optype){
	
		var trObj = $(bt).parent().parent();

		var iImeiNo  = trObj.find("td:eq(1)").text().trim();//��ȡimei����
		var iMember_No  = trObj.find("td:eq(0)").text().trim();//��ȡ��Ա�ն����к�
		var fee = trObj.find("input").val().trim();//Ѻ��
	
		
		
		if("add"==optype){//���г������
				var td0_text = trObj.find("input").val().trim();
				

				if(td0_text==""){
						rdShowMessageDialog("������Ѻ����");
						return;
				}
				
				var reg = /^\d{1,3}$/;
				if(!reg.test(td0_text)){
						rdShowMessageDialog("Ѻ����ֻ������0-200֮�������1");
						return;
				}
				
				if(Number(td0_text)<0||Number(td0_text)>200){
						rdShowMessageDialog("Ѻ����ֻ������0-200֮�������");
						return;
				}

		if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
		var pactket = new AJAXPacket("fm461_Cfm.jsp","���ڳ��⣬���Ժ�......");
 			
 			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("iImeiNo",iImeiNo);
			pactket.data.add("optype",optype);
			pactket.data.add("iMember_No",iMember_No);
			pactket.data.add("fee",fee);
			core.ajax.sendPacket(pactket,do_Cfm);
			pactket=null;
		
		
		}


		if("del"==optype){//���лؿ����

			if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
		var pactket = new AJAXPacket("fm461_Cfm.jsp","���ڻؿ⣬���Ժ�......");
 			
 			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("iImeiNo",iImeiNo);
			pactket.data.add("optype",optype);
			pactket.data.add("iMember_No",iMember_No);
		
			core.ajax.sendPacket(pactket,do_Cfm);
			pactket=null;
		}
		
}

//�ص�
function do_Cfm(pactket){
	var code = pactket.data.findValueByName("code");
	var msg  = pactket.data.findValueByName("msg"); 
	var retArray  = pactket.data.findValueByName("retArray"); 
	var optype = 	pactket.data.findValueByName("optype");
	if (optype=="add") {
		var fee = 	pactket.data.findValueByName("iSale_Price");
	}else{
		var fee = 	retArray[0][6]; //Ѻ��
	}
	


	//alert(fee);
	//alert(retArray[0][0]);//a �ն�id
	//alert(retArray[0][1]);//b imei����
	//alert(retArray[0][2]);//c Ʒ�����ƣ���ҵ����������
	//alert(retArray[0][3]);//d ֤�����ͣ���ҵ����
	//alert(retArray[0][4]);//e ֤�����룺
	//alert(retArray[0][5]);//f �ͻ�����
	if(code=="000000"){	
		go_Query();
		show_bill_Prt(optype,fee,retArray[0][0],retArray[0][1],retArray[0][2],retArray[0][3],retArray[0][4],retArray[0][5]);//��ӡ��Ʊ
	}else{
		rdShowMessageDialog("ʧ�ܣ�"+code+"��"+msg,0);
	}
}

//��ӡ�վ�
function show_bill_Prt(optype,fee,a,b,c,d,e,f){
	 
	  	var  billArgsObj = new Object();

			$(billArgsObj).attr("10001","<%=workNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005",f);   //�ͻ�����
			$(billArgsObj).attr("10007",""); //�ͻ�Ʒ��
			$(billArgsObj).attr("10008","");    //�û�����
			$(billArgsObj).attr("10015",fee);   //���η�Ʊ���
			$(billArgsObj).attr("10016",fee);   //��д���ϼ�
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
			$(billArgsObj).attr("10030","<%=loginAccept%>");   //��ˮ�ţ�--ҵ����ˮ
			$(billArgsObj).attr("10036","<%=opCode%>");   //��������
	    $(billArgsObj).attr("10071","6");	//ģ��
 			$(billArgsObj).attr("10078", ""); //���Ʒ��	
 			$(billArgsObj).attr("10087", b); //imei����
 			$(billArgsObj).attr("10083", d); //֤������
 			$(billArgsObj).attr("10084", e); //֤������
 			$(billArgsObj).attr("10055",a);	//ģ��
 			
 			$(billArgsObj).attr("10072","0"); //�Ʒ�xuxzҪ��д��
 			
	 	  $(billArgsObj).attr("10086", "�𾴵Ŀͻ�����������ҵ���˶���ȡ������ֹҵ��ʹ�õĲ���ʱ����Я�����վݡ���Ч���֤��������ҵ��ʱ����ħ�ٺ��ն˵��ƶ�ָ������Ӫҵ������Ѻ���˻�������"); //��ע
			
			if(optype=="add"){
 					$(billArgsObj).attr("10006","��ҵ���������ӳ���");   //��������
 				}else{
 					$(billArgsObj).attr("10006","��ҵ���������ӻؿ�");   //��������
 				}
 		
 			
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			
			$(billArgsObj).attr("11213","REC");  //�°淢Ʊ����Ʊ�ݱ�־λ��Ĭ�Ͽ�λ��Ʊ REC = �վ�
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";
			
			
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
	    <td class="blue">��������</td>
		  <td colspan="3">
		  	<select id="sel_opType" name="sel_opType" >
				    <option value="add">����</option>
				    <option value="del">�ؿ�</option>
				</select>
		  </td>
		  
	</tr>
	
	<tr>
	    <td class="blue">���ű���</td>
		  <td>
			    <input type="text" name="in_unitid" id="in_unitid" value=""   /> 
		  </td>
		  <td class="blue" >EC���ű���</td>
		  <td>
		  	 <input type="text" name="in_ecid" id="in_ecid" value=""   /> 
		  </td>
	</tr>
	
	<tr>
	    <td class="blue">������ϵID</td>
		  <td>
			    <input type="text" name="in_productofferId" id="in_productofferId" value=""   /> 
		  </td>
		  <td class="blue" >�鵵���ڿ�ʼ</td>
		  <td>
			    <input type="text" name="in_starttime" id="in_starttime" value="20170101"  onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />  
		  </td>
	</tr>
	
	<tr>
		  <td class="blue" >�鵵���ڽ���</td>
		  <td>
			    <input type="text" name="in_endtime" id="in_endtime" value="20170201"  onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />  
		  </td>
	</tr>
	
</table>


<div class="title"><div id="title_zi">��ҵ���������ӳɹ��鵵�ĳ�Ա��Ϣ�б�</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="20%">��Ա�ն����к�</th>
        <th width="20%">IMEI��</th>
        <th width="20%">�鵵ʱ��</th>
        <th width="20%">�ն˹�������</th>	
        <th id="td_htd5">Ѻ����</th>	
        <th width="10%" >����</th>	
    </tr>
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="��ѯ" onclick="go_Query()"          />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>