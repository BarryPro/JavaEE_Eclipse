<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: ��ֵ˰��˰��������Ϣ��ѯ
�� * �汾: v1.0
�� * ����: 2013-11-29
�� * ����: wangjxc
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����:  	
   * �޸���:
   * �޸�Ŀ��:
 ��*/
%>


<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	String login_no = (String)session.getAttribute("workNo");
	String login_name = (String)session.getAttribute("workName");
	String regionCode=(String)session.getAttribute("regCode");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String hwAccept = "1";
	String showBody = "01";
	String cuDate =new SimpleDateFormat("yyyyMMdd").format(new java.util.Date()).toString();

%>
 
<html xmlns="http://www.w3.org/1999/xhtml">
	<script type="text/javascript" src="/npage/public/pubScript.js"></script>
	<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<head>
	
	<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
	<title>��˰��������Ϣ����</title>	
</head>
<body>
	<div id="operation">
		<form method="post" name="frmo001" action="" >
 			<%@ include file="/npage/include/header.jsp" %>
 			<div id="operation_table"> 	
 				<div class="title"><div class="text">��������</div></div>
			 	<div class="input">
					<table>
				 		<tr>
							<th>
								�������ͣ�
							</th>
							<td class="blue">
								<label class = "col-atttr-01"><input name="op" id="op" type="radio" value="query" onclick="choseType('query')"  checked="checked"/>��˰��������Ϣ��ѯ</label>
								<label class = "col-atttr-01"><input name="op" id="op" type="radio" value="add" onclick="choseType('add')" />��˰��������Ϣ����</label>
								<label class = "col-atttr-01"><input name="op" id="op" type="radio" value="upt" onclick="choseType('upt')" />��˰��������Ϣ�޸�</label>
								<label class = "col-atttr-01"><input name="op" id="op" type="radio" value="upto" onclick="choseType('upto')" />�����˹����޸�</label>
							</td>
				 		</tr>
					</table>
			 	</div>
			 	
				<div id="query_input">
	  			<div class="title"><div class="text">��˰��������Ϣ��ѯ</div></div>
	  			<div class="input">
					<table>
						<tr>
							<td class="blue">�ͻ�ѡ��</td>
							<td>
								<input type="text" name="custName" id="custName" readonly="true"/>
								<input type="hidden" name="cust_id" id="cust_id"/>
								<input type="button" id="button" name="sbutton" class="b_text" value="ѡ��" onClick="selectCust();"/>
							</td>	
							<td class="blue">��˰��ʶ��ţ�</td>
							<td>
								<input type="text" id="taxpayer_id" />
							</td>
						</tr>
					</table>
					</div>
					<div id="operation_button">
						<input class="b_foot"  type="button" value="��ѯ" onClick="taxpayListQry()">
						<input type="button" class="b_foot" value="����" onClick="resetMsg()" />
					</div>
					<div id="ct_taxpayer_list" style="display:none">
		        <div class="title">
		          <div class="text">��˰��������Ϣ�б�</div>
		        </div>
	          <div class="list" id="query_result"></div>
	        </div>
      	</div>
      	
      	<div id="add_input" name="add_input" style="display:none">
      		<div class="title"><div class="text">��˰��������Ϣ����</div></div>
      		<div class="input">	
		 			<table>
		 				<tr>
		 					<td class="blue">
								��˰��ʶ��ţ�
							</td>
							<td>
								<input type="text" id="TaxpayerId_add" name="TaxpayerId_add" v_must="15" v_type="string" v_minlength="15"  v_maxlength="30"/>
								<font class=red>*��������15λ</font> 
							</td>
		 					<td class="blue">�ͻ�ѡ��</td>
							<td>
								<input type="text" name="custName_add" id="custName_add" v_must="1" v_maxlength="100" readonly="true"/>
								<input type="hidden" name="custId_add" id="custId_add"/>
								<input type="button" id="button" name="sbutton" class="b_text" value="ѡ��"  onClick="selectCust();"/>
								<font class=red>*</font> 
							</td>
						</tr>
						<tr>
							<td class="blue">�������ͣ�</td>
							<td>
								<select v_must="1" id="taxpayerType_add" onChange="doSetBillType(this);">
									<option value="1">��ֵ˰һ����˰��</option>
									<option value="2">��ֵ˰С��ģ��˰��</option>
									<option value="3">����ֵ˰��˰��</option>
								</select>
								<font class=red>*</font> 
							</td>
							<td class="blue">��Ʊ���ͣ�</td>
							<td>
								<select v_must="1" id="billType_add">
									<option value="1">Ԥ�淢Ʊ</option>
									<option value="2">�½ᷢƱ</option>
								</select>
								<font class=red>*</font> 
							</td>
						</tr>
						<tr>
							<td class="blue">��ϵ�绰��</td>
							<td>
								<input type="text" id="phoneNo_add" name="phoneNo_add" v_must="1" v_type="phone" class="required isLengthOf andCellphone" v_maxlength="30" maxlength="30"/>
							<font class=red>*</font>
							</td>
							<td class="blue">�������ͣ�</td>
							<td>
								<select id="auditState" name="auditState" disabled >
									<option value="1">��ҵ</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="blue">
								���������У�
							</td>
							<td>
								<input type="text" id="bankName_add" name="bankName_add" v_must="1"  class="required isLengthOf" v_maxlength="20"/>
							<font class=red>*</font>
							</td>
							<td class="blue">�������ʺţ�</td>
							<td>
								<input type="text" id="bankAccount_add" v_must="1" name="bankAccount_add" class="required" v_maxlength="30" maxlength="30"/>							
							<font class=red>*</font>
							<input type="button" id="button" name="sbutton" class="b_text" value="չ��"  onClick="AddBank();"/>
							<input type="button" id="button" name="sbutton" class="b_text" value="����"  onClick="DelBank();"/>
							</td>
						</tr>
						<tr id="bank_name" name="bank_name" style="display:none">
							<td class="blue">�������У�</td>
			<td colspan="3">
	  			<textarea rows="3"   id="bank_name_list"  style="width:80%" ></textarea>
	  			<font class=red>����֮����Ӣ��,����,��ʽ:����,����</font>
	  		</td>
	  	</tr>
	  	<tr id="bank_num" name="bank_num" style="display:none">
	  		<td class="blue">�����ʺţ�</td>
			<td colspan="3">
	  			<textarea rows="3"   id="bank_num_list"  style="width:80%" ></textarea>
	  			<font class=red>�ʺ�֮����Ӣ��,����,��ʽ:123,234</font>
	  		</td>
		</tr>
						<tr>
							<td class="blue">Ӫҵִ����Чʱ�䣺</td>
							<td>
								<input type="text" name="valid_date_add" id="valid_date_add" v_must="1" class="Wdate"  v_type="date" value=""
                      			onfocus="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){validateElement(this)},minDate:'',maxDate:'cuDate'})"/>
								<font class=red>*</font>
								</td>
							<td class="blue">Ӫҵִ��ʧЧʱ�䣺</td>
							<td>
								<input type="text" name="expire_date_add" id="expire_date_add"  v_must="1" class="Wdate"  v_type="date" value=""
                      			onfocus="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){validateElement(this)},minDate:'cuDate'})"/>
							<font class=red>*</font>
							</td>
						</tr>
						<tr>
							<wtc:service name="sApproveQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="18">
	  						<wtc:param value="o005"/>
	  						<wtc:param value="<%=login_no%>"/>
							</wtc:service>
							<wtc:array id="retList"  scope="end"/>
							<wtc:service name="sApproveQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="18">
	  						<wtc:param value="o004"/>
	  						<wtc:param value="<%=login_no%>"/>
							</wtc:service>
							<wtc:array id="retListone"  scope="end"/>
							<td class="blue">�ϼ�����������Ա��</td>
							<td>
								<select v_must="1" id="approve_staff" >
									
									 <%
								           if(retListone.length>0){
								           for(int i=0;i<retListone.length;i++){
									              
							           %>
							               <option value="<%=retListone[i][0]%>"><%=retListone[i][0]%>---><%=retListone[i][1]%></option>
							           <%	
									          }
								         %>	
									
							           <% }%>
								</select>
								<font class=red>*</font> 
							</td>
							<td class="blue">����������Ա��</td>
							<td>
								<select v_must="1" id="approve_add" >
									
									 <%
								           if(retList.length>0){
								           for(int i=0;i<retList.length;i++){
									              
							           %>
							               <option value="<%=retList[i][0]%>"><%=retList[i][0]%>---><%=retList[i][1]%></option>
							           <%	
									          }
								         %>	
									
							           <% }%>
								</select>
								<font class=red>*</font> 
							</td>
						</tr>
						<tr>
							<td class="blue">
								��λ���ƣ�
							</td>
							<td colspan="3">
								<input type="text" id="unitName_add" v_must="1" name="unitName_add" size="80" class="required isLengthOf" v_maxlength="120"/>
							<font class=red>*</font>
							</td>
						</tr>
						<tr>
							<td class="blue">
								��λ��ַ��
							</td>
							<td  colspan="3">
								<input type="text" id="address_add" name="address_add" v_must="1" size="80" class="required isLengthOf" v_maxlength="255" maxlength="255"/>
							<font class=red>*</font>
							</td>
						</tr>
						<tr>
							<td class="blue">��ע:</td>
							<td colspan="3">
								<input type=text name="remark_add" id="remark_add" v_must="1" size="80" value="��˰����������" class="isLengthOf" v_maxlength="128"/>
							<font class=red>*</font>
							</td>
						</tr>
					</table>
					</div>	
<div class="title">
	<div class="text">��˰���ʸ���֤����</div>
</div>
<table>
		<tr>
		<td class="blue">¼��֤����
			<select id="card_type11">
				<option value='1' >Ӫҵִ��</option>			
				<option value='2'>˰��Ǽ�֤</option>
				<option value='3'>һ����˰���ʸ�֤��</option>
				<option value='4'>���л���������֤��</option>
			</select>
		<input type="button" id="readByMultisss1" name="readByMultisss1" class="b_text"   value="ɨ��֤��" onClick="readByMultiss(1)" >
		</td>
	</tr>
</table>

					<table>
							<tr>
			      		<td id="add_file_td" name="add_file_td"> 
			      			<iframe frameborder="0" id="fileUpLoadIF" name="fileUpLoadIF" width="50%" style="overflow:hidden;border:0;height:33px" src="fo001_file.jsp"></iframe>
			      			<div id='showFileDiv'>
						  
					        </div>
			      			<input type="hidden"  v_must="1" name="VISIT_INFO_PATH" id="VISIT_INFO_PATH"/>
			        	</td>
							</tr>
							
						</table>
		 			<div id="operation_button">
		 				<input type="button" class="b_foot" value="����" id="btnSave" name="btnSave" onclick="checkAndSave()"  />
		 				<input type="button" class="b_foot" value="����" id="clears" name="clears" onclick="fj622_reset()" />
					</div>
      	</div>
			
			<div id="upt_input" name="upt_input" style="display:none">
	  			<div class="title"><div class="text">��˰��������Ϣ�޸�</div></div>
	  			<input type="hidden" id="manager_upt" />
	  			<div class="input">
					<table>
					<tr>
		<td class="blue">�ͻ�ѡ��</td>
							<td>
								<input type="text" name="custName_upt" id="custName_upt" readonly="true"/>
								<input type="hidden" name="custId_upt" id="custId_upt"/>
								<input type="button" id="button" name="sbutton" class="b_text" value="ѡ��" onClick="selectCust();"/>
							</td>	
							<td class="blue">��˰��ʶ��ţ�</td>
							<td>
								<input type="text" id="taxpayerId_upt" />
							</td>
	</tr>
	<tr>
				<td class="blue">����״̬��</td>
		<td><select id="auditState_upt" name="auditState_upt" >
			<option value="01">������</option>
			<option value="02">������</option>
			<option value="03">����������</option>
			<option value="04">δͨ��</option>
			<option value="05">����δͨ��</option>
			<option value="00">ȫ��</option>
		</select>
		</td>
		<td>
			<td>
			</td>
		</td>
	</tr>
</table>
</div>
<div id="operation_button">
	<input type="button" class="b_foot" value="��ѯ" onclick="doQueryApprove()" />
	<input type="button" class="b_foot" value="����" onClick="resetMsg()" />
</div>
<div id="approve_list" style="display:none">
                <div class="title">
                  <div class="text">��˰��������Ϣ�б�</div>
                </div>
              <div class="list" id="approve_result"></div>
</div> 
</div>
  				
<div id="upto_input" name="upto_input" style="display:none">
	  			<div class="title"><div class="text">�����˹����޸�</div></div>
	  			<input type="hidden" id="manager_upt" />
	  			<div class="input">
					<table>
					<tr>
		<td class="blue">�ͻ�ѡ��</td>
							<td>
								<input type="text" name="custName_upto" id="custName_upto" readonly="true"/>
								<input type="hidden" name="custId_upto" id="custId_upto"/>
								<input type="button" id="button" name="sbutton" class="b_text" value="ѡ��" onClick="selectCust();"/>
							</td>	
							<td class="blue">��˰��ʶ��ţ�</td>
							<td>
								<input type="text" id="taxpayerId_upto" />
							</td>
	</tr>
	<tr>
				<td class="blue">����״̬��</td>
		<td><select id="auditState_upto" name="auditState_upto" >
			<option value="01">������</option>
			<option value="03">����������</option>
			<option value="04">δͨ��</option>
			<option value="05">����δͨ��</option>
		</select>
		</td>
		<td>
			<td>
			</td>
		</td>
	</tr>
</table>
</div>
<div id="operation_button">
	<input type="button" class="b_foot" value="��ѯ" onclick="doQueryApproveO()" />
	<input type="button" class="b_foot" value="����" onClick="resetMsg()" />
</div>
<div id="approve_listO" style="display:none">
                <div class="title">
                  <div class="text">���������˹����б�</div>
                </div>
              <div class="list" id="approve_resultO"></div>
</div> 
</div>
  				
  				
  			<div id="rel_input" name="rel_input" style="display:none">
	  			<div class="title"><div class="text">�ͻ���ϵ����</div></div>
	  			<div class="input">
					<table>
						<tr>
							<td class="blue">�ϼ��ͻ�ѡ��</td>
							<td>
								<input type="text" name="par_custName" id="par_custName" readonly="true"/>
								<input type="hidden" name="par_cust_id" id="par_cust_id"/>
								<input type="button" id="button" name="sbutton" class="b_text" value="ѡ��" onClick="selectCust();"/>
							</td>	
							<td class="blue">�¼��ͻ�ѡ��</td>
							<td>
								<input type="text" name="low_custName" id="low_custName" readonly="true"/>
								<input type="hidden" name="low_cust_id" id="low_cust_id"/>
								<input type="button" id="button" name="sbutton" class="b_text" value="ѡ��" onClick="selectLowCust();"/>
							</td>	
						</tr>
					</table>
					</div>
					<div id="operation_button">
						<input class="b_foot"  type="button" value="��ѯ" onClick="taxpayrelQry()">
						<input class="b_foot"  type="button" value="����" onClick="taxpayrelAdd()">
						<input type="button" class="b_foot" value="����" onClick="resetMsg()" />
					</div>
					<div id="ct_taxpayer_rel" style="display:none">
		        <div class="title">
		          <div class="text">�ͻ���ϵ��Ϣ�б�</div>
		        </div>
	          <div class="list" id="query_rel_result"></div>
	        </div>
      	</div>
  				
			</div>
 			<%@ include file="/npage/include/footer.jsp" %>
			
		</form>
</div>
<script type="text/javascript">
	var op_type;
	var index=0; 
	var save_name=new Array();
	$().ready(function(){choseType('query')});
	
	//ѡ���ѯ������
	function choseType(in_type){
		op_type=in_type;
		if(op_type=="query"){
			query_input.style.display="";
			add_input.style.display="none";
			upt_input.style.display="none";
			upto_input.style.display="none";
			bank_name.style.display="none";
		    bank_num.style.display="none";
		    rel_input.style.display="none";
		}else if(op_type=="add"){
			query_input.style.display="none";
			add_input.style.display="";
			upt_input.style.display="none";
			upto_input.style.display="none";
			bank_name.style.display="none";
		    bank_num.style.display="none";
		    rel_input.style.display="none";
		}
		else if(op_type=="upt"){
			query_input.style.display="none";
			add_input.style.display="none";
			upt_input.style.display="";
			upto_input.style.display="none";
			bank_name.style.display="none";
		    bank_num.style.display="none";
		    rel_input.style.display="none";
		}
		else if(op_type=="upto"){
			query_input.style.display="none";
			add_input.style.display="none";
			upt_input.style.display="none";
			upto_input.style.display="";
			bank_name.style.display="none";
		    bank_num.style.display="none";
		    rel_input.style.display="none";
		}
		else
		{
			query_input.style.display="none";
			add_input.style.display="none";
			upt_input.style.display="none";
			upto_input.style.display="none";
			bank_name.style.display="none";
		    bank_num.style.display="none";
		    rel_input.style.display="";
		}
			
		
	}
	
	function taxPayerExtUpload(cardFilePath){
	//������Ȩ������Ϣ
 	$("#busiFileUpLoadIF").contents().find("#cardFilePath").val(cardFilePath);
 	$("#busiFileUpLoadIF").contents().find("#busiFilePathButton").click();
}

	
	//��ѯ��ֵ˰��˰��������Ϣ
	function taxpayListQry()
	{
		var CustId       = $("#cust_id").val();
		var TaxpayerId   = $("#taxpayer_id").val();
		var packet = new AJAXPacket("fo001_ajax_ResultList.jsp");
		packet.data.add("CustId",CustId);
		packet.data.add("TaxpayerId",TaxpayerId);
		packet.data.add("PAGE_NUM","1");   
		core.ajax.sendPacketHtml(packet,doQueryTaxpayer);
    	packet = null;
	}
	
	//��ѯ�ص�����
  function doQueryTaxpayer(data)
  {
  	$("#query_result").empty().append(data);
    var retCode=$("#retCode").val();
    var retMsg=$("#retMsg").val();
    if(retCode !=="000000")
    {
      rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    }
      else
    {
      $("#ct_taxpayer_list").css("display","");
  }
  }   
		
	 //��ҳ��ѯ��˰��������Ϣ��¼
  function doQueryTaxpayList(page_index)
  {
		var CustId       = $("#cust_id").val();
		var TaxpayerId   = $("#taxpayer_id").val();
		var packet = new AJAXPacket("fo001_ajax_ResultList.jsp");
		packet.data.add("CustId",CustId);
		packet.data.add("TaxpayerId",TaxpayerId);
		packet.data.add("PAGE_NUM",page_index);
		core.ajax.sendPacketHtml(packet,getQueryTaxListResult);
		packet = null;
	}
      
 function getQueryTaxListResult(data)
  {
  	$("#query_result").empty().append(data);
    var retCode=$("#retCode").val();
    var retMsg=$("#retMsg").val();
    if(retCode !=="000000")
    {
      rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    }
      else
    {
      $("#ct_taxpayer_list").css("display","");
  }
  }   
		
	var picpath_n2new = "";
	var picpath_bei2new = "";
	
	function readByMultiss(str)
	{
		//ɨ��������֤
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
		tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
		var cre_dir = filep1+":\\custID";//����Ŀ¼
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
	
	var ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1000);
	
	if(ret_open!=0){
		ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1001);
	}	
	if(ret_open==0){
		var cardType = document.getElementById("card_type11").value ;	


			//�๦���豸OCR��ȡ
			var ret_getImageMsg=CardReader_CMCC.MutiIdCardGetImageMsg(cardType,"c:\\custID\\cert_<%=hwAccept%>"+str+".jpg");
			
				if(str==1){
					picpath_n2new="";
					picpath_n2new = "c:\\custID\\cert_<%=hwAccept%>1.jpg";
				}else if(str==2){
					picpath_n2new="";
					picpath_n2new = "c:\\custID\\cert_<%=hwAccept%>2.jpg";
				}
								
					rdShowMessageDialog("ɨ��ɹ���",2);
					if(str==1){
						$("#firstId").val(picpath_n2new+"|"+picpath_bei2new+"|");
					}else if(str==2){
						$("#secondId").val(picpath_n2new+"|"+picpath_bei2new+"|");
					}else if(str==11) {
						$("#firstId").val(picpath_n2new+"|"+picpath_bei2new+"|");
					}else if(str==22) {
						$("#secondId").val(picpath_n2new+"|"+picpath_bei2new+"|");
					}	


	}else{
					rdShowMessageDialog("���豸ʧ��");
					return ;
	}
	//�ر��豸
	var ret_close=CardReader_CMCC.MutiIdCardCloseDevice();
	if(ret_close!=0){
							rdShowMessageDialog("�ر��豸ʧ��");
					return ;
	}
	
}
	
	//�����ϴ��ļ�
	function getFilePath(filePath,file_name,source_name,info){
	  var retInfo = info.split("|");
	  var flag = retInfo[0];//0:�ϴ��ɹ���-1��ʧ��
	  if(flag == "0"){
			frmo001.VISIT_INFO_PATH.value = filePath;
			source_name=unescape(source_name);
			save_name[index]=source_name+"*"+file_name;
			index++;
			rdShowMessageDialog("�ϴ��ɹ���",2);
			showFile();
	  }else if(flag == "-1"){
	  	rdShowMessageDialog("�ϴ�ʧ�ܣ�",0);
	  }
	}	
	
	//չʾ����
	function showFile(){
		var list_name = save_name[0];
		for(var i=1;i<save_name.length;i++){
			list_name = list_name+"|"+save_name[i];
		}
		if(list_name==undefined){
			$("#showFileDiv").html("");
			return;
		}
		var packet = new AJAXPacket("fo001_ajax_showBusiFile.jsp");
		packet.data.add("list_name",list_name);
		core.ajax.sendPacketHtml(packet,doShowFile);
		packet=null;
	}
	
	//չʾ�����ص�
	function doShowFile(packet){
		$("#showFileDiv").html(packet);
	}
	
	//ѡ��ͻ���ť
	function selectCust()
	{
		window.open("fo001_custQuery.jsp", "�ͻ���Ϣ", "height=350, width=600,top=100,left=300,scrollbars=yes, resizable=no,location=no, status=yes");
	}
	
	function setCustId(AddCustId,AddCustName,AddCustLogin)
	{
		$("#manager_upt").val(AddCustLogin);
		if(op_type=="query")
		{
			$("#cust_id").val(AddCustId);
			$("#custName").val(AddCustName);
		}
		else if(op_type=="add")
		{
			$("#custId_add").val(AddCustId);
			$("#custName_add").val(AddCustName);
			//���������ǿͻ������ţ�������ť����
			if(AddCustLogin=="<%=login_no%>")
			{
				$("#btnSave").attr("disabled",false);
			}else
			{
				$("#btnSave").attr("disabled",false);
			}
		}
		else if(op_type=="upt")
		{
			$("#custId_upt").val(AddCustId);
			$("#custName_upt").val(AddCustName);
		}
		else
		{
			$("#par_cust_id").val(AddCustId);
			$("#par_custName").val(AddCustName);
		}	
	}
	
		//ѡ��ͻ���ť
	function selectLowCust()
	{
		window.open("fo001_lowcustQuery.jsp", "�ͻ���Ϣ", "height=350, width=600,top=100,left=300,scrollbars=yes, resizable=no,location=no, status=yes");
	}
	
	function setLowCustId(AddCustId,AddCustName,AddCustLogin)
	{
		$("#low_cust_id").val(AddCustId);
		$("#low_custName").val(AddCustName);
	}

	
	//����
	function checkAndSave(){
	if(!check(frmo001))return false;
	if(document.frmo001.VISIT_INFO_PATH.value==""){
    		rdShowMessageDialog("��ѡ��Ҫ�ϴ��ĸ���",0);
    		return;
    		}
	
	
	//ȡҳ������ 
	var custId = $("#custId_add").val();
	var taxpayerId = $("#TaxpayerId_add").val();
	if(taxpayerId=="")
	{
		taxpayerId = "9999A";
	}
	var taxpayerType = $("#taxpayerType_add").val();		
	var billType = $("#billType_add").val();
	var unitName = $("#unitName_add").val();
	var address = $("#address_add").val();
	var phoneNo = $("#phoneNo_add").val();
	var typeCode = "1";//	1��ҵ2���ˣ�Ŀǰֻ��Ҫ֧����ҵ
	var bankName = $("#bankName_add").val();
	var bankAccount = $("#bankAccount_add").val();
	var approveLogin = $("#approve_staff").val();
	var approveLoginOne = $("#approve_add").val();
	var valid_date = $("#valid_date_add").val();
	var expire_date = $("#expire_date_add").val();
	var reg = new RegExp("[- :]","gi"); 
	valid_date = valid_date.replace(reg,"")+"000000";
	expire_date = expire_date.replace(reg,"")+"235959";
	var remark = $("#remark_add").val();
	var bankNameList = $("#bank_name_list").val();
	var bankNumList = $("#bank_num_list").val();
	var bankNameMsg;
	var bankNumMsg;
	if(bankNameList == "" && bankNumList != "")
	{
		rdShowConfirmDialog("�����ʺŹ�ϵҪ�ɶԳ���");
		return false;
	}
	if(bankNameList != "" && bankNumList == "")
	{
		rdShowConfirmDialog("�����ʺŹ�ϵҪ�ɶԳ���");
		return false;
	}
	if(bankNameList != "")
	{
		bankNameMsg = bankName+","+bankNameList+",";
		bankNumMsg = bankAccount+","+bankNumList+",";
	}
	else
	{
		bankNameMsg = bankName+",";
		bankNumMsg = bankAccount+",";
	}
	
	 //����
	 	//֤�����ϸ�������ɨ���
		var list_name; 
		if(save_name.length>0){
			list_name = save_name[0];
		  for(var i=1;i<save_name.length;i++){
		  	list_name = list_name+"|"+save_name[i];
			}
		}
		var packet = new AJAXPacket("fo001_ajax_doSubmit.jsp","���Ժ�...");
		packet.data.add("custId",custId);
		packet.data.add("taxpayerId",taxpayerId);
		packet.data.add("taxpayerType",taxpayerType);
		packet.data.add("billType",billType);
		packet.data.add("taxpayerFlag","N");
		packet.data.add("unitName",unitName);
		packet.data.add("address",address);
		packet.data.add("phoneNo",phoneNo);
		packet.data.add("typeCode",typeCode);
		packet.data.add("bankName",bankName);
		packet.data.add("bankAccount",bankAccount);
		packet.data.add("approveLogin",approveLogin);
		packet.data.add("approveLoginOne",approveLoginOne);
		packet.data.add("valid_date",valid_date);
		packet.data.add("expire_date",expire_date);
		packet.data.add("remark",remark);
		packet.data.add("bankNameList",bankNameList);
		packet.data.add("bankNumList",bankNumList);
		packet.data.add("list_name",list_name);
		packet.data.add("bankNameMsg",bankNameMsg);
		packet.data.add("bankNumMsg",bankNumMsg);
		core.ajax.sendPacket(packet,doSuccess,true);
	  	packet = null;
	} 
	
 	function doSuccess(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if(retCode == "000000"){
			rdShowMessageDialog("������˰��������Ϣ�ɹ���",2);
			window.location.reload();
		} else{
			rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
		}
	}
	
		//��ѯ�����켣
	function doQueryApprove()
	{
		var CustId = $("#custId_upt").val();
		var auditState = $("#auditState_upt").val();
		var TaxpayerId = $("#taxpayerId_upt").val();
		var manager_login = $("#manager_upt").val();
		var packet = new AJAXPacket("fo001_ajax_approveQry.jsp");
		packet.data.add("model","4");
		packet.data.add("auditState",auditState);
		packet.data.add("CustId",CustId);
		packet.data.add("TaxpayerId",TaxpayerId);
		packet.data.add("LoginNo",manager_login);
		
		packet.data.add("PAGE_NUM","1");   
		core.ajax.sendPacketHtml(packet,doGetHtml);
		packet =null;
	}
	
	//��ҳ��ѯ��Ȩ�˺��еĹ���Ȩ��
   	function doQueryApproveList(page_index,total_num)
   	{
		var CustId = $("#custId_upt").val();
		var auditState = $("#auditState_upt").val();
		var TaxpayerId = $("#taxpayerId_upt").val();
		var manager_login = $("#manager_upt").val();
		var packet = new AJAXPacket("fo001_ajax_approveQry.jsp");

		packet.data.add("model","4");
		packet.data.add("auditState",auditState);
		packet.data.add("CustId",CustId);
		packet.data.add("TaxpayerId",TaxpayerId);
		packet.data.add("LoginNo",manager_login);
   		packet.data.add("PAGE_NUM",page_index);
		core.ajax.sendPacketHtml(packet,doGetHtml);
		packet =null;
   	}

	function doGetHtml(data)
	{
		$("#approve_result").empty().append(data);
        var retCode=$("#retCode").val();
        var retMsg=$("#retMsg").val();
       if(retCode !=="000000")
    {
      rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    }
      else
    {
      $("#approve_list").css("display","");
    }
	}
	//��ѯ�����켣
	function doQueryApproveO()
	{
		var CustId = $("#custId_upto").val();
		var auditState = $("#auditState_upto").val();
		var TaxpayerId = $("#taxpayerId_upto").val();
		var manager_login = $("#manager_upto").val();
		var packet = new AJAXPacket("fo001_ajax_approveQryO.jsp");
		packet.data.add("model","4");
		packet.data.add("auditState",auditState);
		packet.data.add("CustId",CustId);
		packet.data.add("TaxpayerId",TaxpayerId);
		packet.data.add("LoginNo",manager_login);
		packet.data.add("PAGE_NUM","1");   
		core.ajax.sendPacketHtml(packet,doGetHtmlO);
		packet =null;
	}

	//��ҳ��ѯ��Ȩ�˺��еĹ���Ȩ��
   	function doQueryApproveListO(page_index,total_num)
   	{
		var CustId = $("#custId_upto").val();
		var auditState = $("#auditState_upto").val();
		var TaxpayerId = $("#taxpayerId_upto").val();
		var manager_login = $("#manager_upto").val();
		var packet = new AJAXPacket("fo001_ajax_approveQryO.jsp");

		packet.data.add("model","4");
		packet.data.add("auditState",auditState);
		packet.data.add("CustId",CustId);
		packet.data.add("TaxpayerId",TaxpayerId);
		packet.data.add("LoginNo",manager_login);
   		packet.data.add("PAGE_NUM",page_index);
		core.ajax.sendPacketHtml(packet,doGetHtmlO);
		packet =null;
   	}
   	
	function doGetHtmlO(data)
	{
		$("#approve_resultO").empty().append(data);
        var retCode=$("#retCode").val();
        var retMsg=$("#retMsg").val();
       if(retCode !=="000000")
    {
      rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    }
      else
    {
      $("#approve_listO").css("display","");
    }
	}
		

	
	function viewTaxPayerInfo(UpCustId,queryflag)
	{
		window.open("/npage/so003/fo003_TaxpayerView.jsp?UpCustId="+UpCustId+"&queryflag="+queryflag, "չʾ��Ϣ", "height=500, width=1000,top=200,left=450,scrollbars=yes, resizable=no,location=no, status=yes");
	}

	function viewTaxPayerInfoO(UpCustId,queryStatus,oAppIdeaOne,oAppIdeaTwo)
	{
		window.open("/npage/so003/fo003_TaxpayerUptO.jsp?UpCustId="+UpCustId+"&queryStatus="+queryStatus+"&oAppIdeaOne="+oAppIdeaOne+"&oAppIdeaTwo="+oAppIdeaTwo, "չʾ��Ϣ", "height=500, width=1000,top=200,left=450,scrollbars=yes, resizable=no,location=no, status=yes");
	}

	function resetMsg()
	{
		$("#taxpayer_id").val("");
		$("#cust_id").val("");
		$("#custName").val("");
		$("#custName_upt").val("");
		$("#custId_upt").val("");
		$("#taxpayerId_upt").val("");
		$("#par_custName").val("");
		$("#par_cust_id").val("");
		$("#low_custName").val("");
		$("#low_cust_id").val("");
	}
	
	function fj622_reset()
	{
		$("#TaxpayerId_add").val("");
		$("#custName_add").val("");
		$("#custId_add").val("");
		$("#phoneNo_add").val("");
		$("#bankName_add").val("");
		$("#bankAccount_add").val("");
		$("#valid_date_add").val("");
		$("#expire_date_add").val("");
		$("#unitName_add").val("");
		$("#address_add").val("");
		$("#remark_add").val("��˰����������");
	}

	function uptTaxPayerInfo(UpCustId,queryflag)
	{
		window.open("/npage/so003/fo003_TaxpayerUpt.jsp?UpCustId="+UpCustId+"&queryflag="+queryflag, "�޸���Ϣ", "height=500, width=1000,top=200,left=450,scrollbars=yes, resizable=no,location=no, status=yes");
	}
	
	function AddBank()
	{
		bank_name.style.display="";
		bank_num.style.display="";
		//window.open("fo001_AddBankMsg.jsp", "���������Ϣ", "height=500, width=1000,top=200,left=450,scrollbars=yes, resizable=no,location=no, status=yes");
	}
	
	function DelBank()
	{
		bank_name.style.display="none";
		bank_num.style.display="none";
	}
	
	function delTaxPayerInfo(DelCustId)
	{
		if(rdShowConfirmDialog('ȷ��Ҫɾ������˰��������Ϣô��')==1)
        {
        	var packet = new AJAXPacket("/npage/so003/fo003_ajax_doTaxpayerDel.jsp","���Ժ�...");
			packet.data.add("DelCustId",DelCustId);
			core.ajax.sendPacket(packet,doDelTaxpayer,true);
	  		packet = null;
        }
	}
	
	function doDelTaxpayer(packet)
	{
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if(retCode == "000000")
		{
			rdShowMessageDialog("ɾ��������ɣ�",2);
			doQueryApprove();
		} 
		else
		{
			rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
		}
	}
	
	//�ͻ���ϵ��ѯ
	function taxpayrelQry()
	{
		if(document.frmo001.par_custName.value=="" && document.frmo001.low_custName.value=="")
		{
			rdShowConfirmDialog("���¼��ͻ�������дһ��");
			return false;
		}
		var par_cust_id   = $("#par_cust_id").val();
		var low_cust_id   = $("#low_cust_id").val();
		var packet = new AJAXPacket("fo001_ajax_RelResultList.jsp");
		packet.data.add("par_cust_id",par_cust_id);
		packet.data.add("low_cust_id",low_cust_id);
		core.ajax.sendPacketHtml(packet,doQueryTaxpayerRel);
    	packet = null;
	}
	
	function doQueryTaxpayerRel(data)
  {
  	$("#query_rel_result").empty().append(data);
    var retCode=$("#retCode").val();
    var retMsg=$("#retMsg").val();
    if(retCode !=="000000")
    {
      rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
    }
      else
    {
      $("#ct_taxpayer_rel").css("display","");
  }
  }
	
	
	//�ͻ���ϵ����
	function taxpayrelAdd()
	{
		if(document.frmo001.par_custName.value=="" || document.frmo001.low_custName.value=="")
		{
			rdShowConfirmDialog("���¼��ͻ�������д");
			return false;
		}
		
		var ParCustId = $("#par_cust_id").val();
		var LowCustId = $("#low_cust_id").val();
		var packet = new AJAXPacket("fo001_ajax_doRelSubmit.jsp","���Ժ�...");
		packet.data.add("ParCustId",ParCustId);
		packet.data.add("LowCustId",LowCustId);
		core.ajax.sendPacket(packet,dorelSuccess,true);
	  	packet = null;
	}
	
	function dorelSuccess(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if(retCode == "000000"){
			rdShowMessageDialog("�����ͻ���ϵ�ɹ���",2);
			window.location.reload();
		} else{
			rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
		}
	}
	
	function delTaxPayerRel(DelCustId)
	{
		if(rdShowConfirmDialog('ȷ��Ҫɾ���ͻ���ϵô��')==1)
        {
        	var packet = new AJAXPacket("fo001_ajax_doTaxpayerRelDel.jsp","���Ժ�...");
			packet.data.add("DelCustId",DelCustId);
			core.ajax.sendPacket(packet,doDelTaxpayerRel,true);
	  		packet = null;
        }
	}
	
	function doDelTaxpayerRel(packet)
	{
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if(retCode == "000000")
		{
			rdShowMessageDialog("ɾ��������ɣ�",2);
			window.location.reload();
		} 
		else
		{
			rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
		}
	}
	

</script>

<script language=javascript>
	//�ж��豸����
	var fso = new ActiveXObject("Scripting.FileSystemObject");
	if(!fso.FileExists("C:/WINDOWS/system32/MutiIdCard.dll")){ 
		//document.getElementById('readByMultisss1').disabled = false;
		document.getElementById('readByMultisss1').disabled = true;	
	}
</script>	
</body>
</html>