<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2008��10��25��
�� * ����: leimd
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = WtcUtil.repNull(request.getParameter("pageOpCode"));	
	String opName = WtcUtil.repNull(request.getParameter("pageOpName"));	
	String operType = WtcUtil.repNull(request.getParameter("operType")); //��������
	String productID = WtcUtil.repNull(request.getParameter("productID"));//��Ʒ�������
	String orderSource = WtcUtil.repNull(request.getParameter("orderSource"));//������Դ���
	String orderSourceName = WtcUtil.repNull(request.getParameter("orderSourceName"));//������Դ����
	String productSpecNum = WtcUtil.repNull(request.getParameter("productSpecNum"));
	String id_no = request.getParameter("grpIdNo");
	String workName = (String)session.getAttribute("workName");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	/*zhangyan 2011-5-12 18:55:22
	sql_cntSpec ���ݲ�Ʒ������Ų����ñ�,����ܷ����ļ��ϴ�
	*/

	String sqlStr2 = "select count(*) from sbbossmembercharacter where productspec_number = '"+productSpecNum+"' and substr(character_attr_code,1,1)='1'";
	
	//���ݲ�������ȡ��������
	String operTypeName = "";
	switch(Integer.parseInt(operType)){
	  	case 0 : 
	  					operTypeName = "ɾ��";
	  					break;
	  	case 2 :
	  					operTypeName = "�����Ա����";
	  					break;
	  	case 3 :
	  					operTypeName = "��ͣ��Ա";
	  					break;
	  	case 4 :
	  					operTypeName = "�ָ���Ա";
	  					break;
	  	default:
	  					operTypeName = "";
	  					break;
	 }
%>



<!--zhangyan 2011-5-12 14:52:16 b
���Ʒ����SQL,Ϊ�Ƿ�չʾ�ļ��ϴ�ѡ��ť��׼��
-->


<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sqlStr2%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result2" scope="end"/>
	
<!--zhangyan 2011-5-12 14:52:16 e-->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>��ԱǩԼ��ϵ����</title>
</head>
<script type="text/javascript">
function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");			
	if(retType=="getbizcode")
    {
    	if(retCode="000000")
    	{	
			var flag_1001 = packet.data.findValueByName("flag_1001");
			var flag_1002 = packet.data.findValueByName("flag_1002");
			var biz_code = packet.data.findValueByName("biz_code");
			document.all.flag_1001.value = flag_1001;
			document.all.flag_1002.value = flag_1002;
			document.all.biz_code.value = biz_code;	
    	}
    	else
    	{		    	
    		rdShowMessageDialog(retMessage);
    	}
    }
}		 
   
function getbizcode()
{
    var getbizcode_Packet = new AJAXPacket("f2035_ajax.jsp","���ڻ�ȡҵ����룬���Ժ�......");
	getbizcode_Packet.data.add("retType","getbizcode");
    getbizcode_Packet.data.add("id_no","<%=id_no%>");
    getbizcode_Packet.data.add("region_code","<%=regionCode%>");
	core.ajax.sendPacket(getbizcode_Packet);
	getbizcode_Packet=null;
	//delete(getbizcode_Packet);
	var proSpecNum="<%=productSpecNum%>";
	var operTYpe = document.frm.operType.value;
	if (operTYpe=="0")
	{
		$("#input_type").css("display","block");
		
		if (proSpecNum=="33101" || proSpecNum == "411506")
		{
				$("#input_type_file").css("display","block");
		}
	}
		
}	

/*zhangyan 2011-5-12 19:02:56
����������ʱ
*/
function chkMeb()
{
	$("#memberNo_file").css("display","none");
	$("#memberNo_text").css("display","block");
	$("#mebNo_info").css("display","none");
	document.getElementById("fileflag").value="0";
}

/*zhangyan 2011-5-12 19:02:56
����ļ�¼��ʱ
*/
function chkMebFile()
{
	$("#memberNo_file").css("display","block");
    $("#memberNo_text").css("display","none");
    $("#mebNo_info").css("display","block");
    document.getElementById("fileflag").value="1";
}
	
/*zhangyan 2011-5-12 19:04:25
�ļ��ύ
*/
function doFileCfm()
{
	document.frm.target="_self";
	document.frm.encoding="application/x-www-form-urlencoded";
	document.frm.action="f2035_cfm2.jsp";
	frm.method="post";
	frm.submit();
	loading();
}
	
function doCfm()
{
	var areaVal = document.all.phoneNo.value;
	var file_flag = document.frm.fileflag.value;
	if(areaVal=="" && file_flag !=1)
	{
		 rdShowMessageDialog("�ֻ����벻��Ϊ��!");
		 return ;
	}
	if(areaVal.charAt(areaVal.length-1)!="|" && file_flag !=1)
	{
		rdShowMessageDialog("�ֻ�������д����!");	
		return;
	}
    else
    {
    	var confirmFlag=0;
		confirmFlag = rdShowConfirmDialog("�Ƿ��ύ���β�����");
		if (confirmFlag==1 && file_flag!="1") 
		{
			document.frm.action="f2035_cfm2.jsp";
			document.getElementById("doSubmit").disabled=true;
			document.frm.submit();
		}
		else if (confirmFlag==1 )
		{
			/*zhangyan add 2011-5-12 8:52:00
			�ļ��ϴ�ʱҪ���Ա������
			*/
			if (  <%=result2[0][0]%>!="0" )
			{
				rdShowMessageDialog("Ҫ�����ļ����,��Ա���Ա���Ϊ��!");
				return false;
			}
			document.frm.target="hidden_frame";
			document.frm.encoding="multipart/form-data";
			document.frm.action="f2035_upload.jsp";
			document.frm.method="post";
			document.getElementById("doSubmit").disabled=true;
			document.frm.submit();
			loading();	
			/*zhangyan add 2011-5-12 8:52:00 e*/
		}
	}
}

</script>


<body onload="getbizcode();">
	<form method="post" name="frm" >
		<input type="hidden" name="pageOpCode" value="<%=opCode%>">
		<input type="hidden" name="pageOpName" value="<%=opName%>">
		<input type="hidden" name="addmodeflag"  value="0"> 
		<input type="hidden" name="flag_1001" value="">
		<input type="hidden" name="flag_1002" value="">
		<input type="hidden" name="biz_code" value="">	
		<input type="hidden" name="fileflag" value="">
		<input type="hidden" name="memberType" value="">
		<input type="hidden" id = "inputFile" name="inputFile" value="">
		<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>	
	<%@ include file="/npage/include/header.jsp" %>
		<table cellspacing="0">
			<tr id= "input_type" name = "input_type" style = "display:none">
				<td class="blue">����¼�뷽ʽ</td>
				<td colspan="3">
					<input type='radio' id='memberNo_type' name='memberNo_type' 
						onClick='chkMeb()' value='memberNo_type' checked/>�������� &nbsp;&nbsp;
	           	 	<div id="input_type_file" style="display:none">
	           	 	<input type='radio' id='memberNo_type' name='memberNo_type' 
	           	 		onClick='chkMebFile()' value='memberNo_type' />�ļ�¼��
	           	 	</div>
           	 	</td>
			</tr>
			<tr>
				<td class="blue">��������</td>
				<td colspan="3"><input name="operTypeName" value="<%=operTypeName%>" class="InputGrey" readonly></td>
				                <input name="operType" value="<%=operType%>" type="hidden"> 
			</tr>
			<tr>
				<td class="blue">��Ʒ�������</td>
				<td><input name="productIDName"    value="<%=productID%>" class="InputGrey" readonly></td>
				    <input name="productID"   value="<%=productID%>" type="hidden">
				<td class="blue">������Դ</td>
				<td>
					<input name="orderSourceName" value="<%=orderSourceName%>" class="InputGrey" readonly>
					<input name="orderSource" value="<%=orderSource%>" type="hidden"> 	
				</td>
			</tr>
			<%if(Integer.parseInt(operType) == 2){%>
                <tr>
                    <td class="blue">��Ա����</td>
                    <td colspan="3">
                     	<select name="memberType">
	              			<option value="1" >ǩԼ��Ա</option>	
	              			<option value="2" >������</option>
	              			<option value="0" >������</option>
          				</select>
          			</td>
                </tr>
            <%}%>
            
			<tr id = "memberNo_text" name  =  "memberNo_text" >
				<td class="blue">�ֻ�����</td>
				<td>
					<textarea cols=30 rows=8 name="phoneNo" style="overflow:auto" v_must=1 v_minlength="11" v_maxlength="15" v_type="string" index="8"></textarea>
				<td colspan="2">ע�����������ֻ�����ʱ,����"|"��Ϊ�ָ�<br>
								&nbsp;&nbsp;&nbsp;&nbsp;��,�������һ������Ҳ����"|"��Ϊ����.<br>
								&nbsp;&nbsp;&nbsp;&nbsp;���磺13900000000|<br>
								&nbsp;&nbsp;&nbsp;&nbsp;13900000001|<br>
				</td>
			</tr>
			<tr id = "memberNo_file" name = "memberNo_file" style = "display:none">
				<td colspan =4 >

	 				<input type="file" id="memberNoFile"  name="memberNoFile" class="button" 
	 					style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;display:block'/>			
	 				<font class='orange' id = 'mebNo_info' name = 'mebNo_info' style = 'display:block'>
	 					�ļ�˵��:�ϴ��ļ���ʽ����Ϊ�ı��ļ�,һ������һ��,ÿ�����50���롣
	 				</font>
	 			</td>		
			</tr>			
			<tr>
				<td class="blue">��ע</td>
				<td colspan="3">
					<input name="opNote" size="60" value="����Ա<%=workName%>����<%=operTypeName%>����" readonly Class="InputGrey">
				</td>
			</tr>
			<tr>
				<td align="center" id="footer" colspan="4">
					<input class="b_foot" name="doSubmit"  type=button value="ȷ��" onclick="doCfm()">
					<input class="b_foot" name="reset1"  onClick="" type=reset value="���">
					<input class="b_foot" name=next id=nextoper1 type=button value="����" onclick="history.go(-1)" >
					<input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="�ر�">
				</td>
			</tr>
		</table>
	<%@ include file="/npage/include/footer.jsp" %>
	</form>
</body>
</html>
