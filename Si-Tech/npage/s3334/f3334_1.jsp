<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/********************
 version v3.0
������: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "3334";
 		String opName = "����Ʒ����ѯ";
 		
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		
%>

	<head>
		<title><%=opName%></title>
	</head>
<body onload="select_qx();">	
	<form action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp" %>
		
		<div class="title">
			<div id="title_zi">��ѯ����</div>
		</div>	
			<table cellspacing="0">
				<tr>
					<td  class="blue" nowrap>�ֻ�����</td>
					<td><input type="text" name="phone_no" id="phone_no" v_type="mobphone"  size="18" value=""></td>
					<td class="blue" nowrap>��������</td>
					<td>
						<select name="dq_code" onchange="select_qx();">
							<wtc:qoption name="sPubSelect" outnum="2">
							          <wtc:sql>select region_code,region_name from sRegionCode where unit_type = '0'  Order By region_code</wtc:sql>
							</wtc:qoption>
						</select>
					</td>
					<td class="blue" nowrap>���ش���</td>
					<td>
						<select name="qx_code">
						</select>
					</td>					
				</tr>	
				<tr>
					<td  class="blue" nowrap>��ѯ����</td>
					<td >
						<select name="query_type" onchange="add_con();">
							<option value="01">����Ʒ����ģ����ѯ</option>
							<option value="02">Ӫҵ������ģ����ѯ</option>
							<option value="03">����Ʒ���뾫ȷ��ѯ</option>
							<option value="04">Ӫҵ�����뾫ȷ��ѯ</option>
						</select>
					</td>
					<td  class="blue" nowrap>��ѯ����</td>
					<td>
						<input type="text" name="query_code" id="phone_no"  size="18" value="">
					</td>
					<td class="blue" nowrap>��ѯ����</td>
					<td>
						<input type="text" name="query_name" id="phone_no"  size="18" value="">
					</td>					
				</tr>				
			</table>
			<table cellSpacing="0">
		      <tr> 
		        <td id="footer"> 
		           <input type="button" name="resetButton"  class="b_foot" value="����" style="cursor:hand;" onclick="document.frm.reset()">&nbsp;
		           <input type="button" name="queryButton"  class="b_foot" value="��ѯ" style="cursor:hand;" onclick="doQuery()">&nbsp;
		           <input type="button" name="closeButton" class="b_foot" value="�ر�" style="cursor:hand;" onClick="doClose()">&nbsp;
		        </td>
		      </tr>
		    </table>	
		    
     		<table cellspacing="0">
				<tr>
					<td style="height:0;">
						<iframe frameBorder="0" id="qryInfoFrame" align="center" name="qryInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto;overflow-x:hidden; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryInfoFrame').style.height=qryInfoFrame.document.body.scrollHeight+20+'px'"></iframe>
					</td>
				</tr>
				<tr>
			</table>		    
		<%@ include file="/npage/include/footer.jsp" %> 
</form>
	<script language="javascript">	
		/**�ر�ҳ��**/
		function doClose(){
			parent.removeTab("<%=opCode%>");
		}			
		function add_con(){
			var query_type = document.all.query_type.value;
			if(query_type=="03"){
				document.all.query_code.v_must="1";
			}else{
				document.all.query_code.v_must="0";
			}
		}
		function select_qx(){
			var group_id = document.all.dq_code.value;
			var sqlStr = "select district_code,district_name from sDisCode where region_code = '"+group_id+"' and  unit_type = '0' Order By district_code,district_name";
			var myPacket = new AJAXPacket("../common/select_mulit_rpc.jsp","����У��IMEI��Ϣ�����Ժ�......");
			myPacket.data.add("retType","getqx");
			myPacket.data.add("sqlStr",sqlStr);
			myPacket.data.add("outNum","2");
			core.ajax.sendPacket(myPacket);
			myPacket=null;			
		}
		function doProcess(packet){
	 		errorCode = packet.data.findValueByName("retCode");
			errorMsg =  packet.data.findValueByName("retMessage");
			retType = packet.data.findValueByName("retType");
			retResult= packet.data.findValueByName("mulit_list");	
			var ret_code =  parseInt(errorCode);	
			var tmpObj = "qx_code";
			if(retType=="getqx"){
				if( ret_code == "000000"){
					  document.all(tmpObj).options.length=0;
					  document.all(tmpObj).options.length=retResult.length;
			        for(i=0;i<retResult.length;i++)
					{
					  document.all(tmpObj).options[i].text=retResult[i][1];
					  document.all(tmpObj).options[i].value=retResult[i][0];
					}
				}
				else{
					document.all(tmpObj).options.length=0;					
					rdShowMessageDialog("ȡ��Ϣ����:"+errorMsg+"!");
					return;
				}
			}			
		}
		function doQuery()
		{
			if(!check(document.frm)) return false;
			document.getElementById("qryInfoFrame").style.display="block"; 
			document.qryInfoFrame.location = "f3334_2.jsp?phone_no="+document.all.phone_no.value+"&dq_code="+document.all.dq_code.value+"&qx_code="+document.all.dq_code.value+"&query_type="+document.all.query_type.value+"&query_code="+document.all.query_code.value+"&query_name="+document.all.query_name.value;			
		}
	</script>	
</body>
</html>		    		