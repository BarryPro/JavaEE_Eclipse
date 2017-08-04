<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
������: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "d291";
 		String opName = "���Ѷ��Ų�ѯ";
 		
 		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		String accountType = (String)session.getAttribute("accountType"); /*ȡ�������� 2Ϊ�ͷ�����*/
 		/**�鿴���ŵļ���,�����Ӫҵ���ļ�����С,�������ҳ��
 			�˴���ѯ���ǹ��Ÿ�һ���ڵ����֯������Ϣ��
 		**/
		String checkSql = "SELECT msg.root_distance,msg.group_id FROM dchngroupmsg msg, dchngroupinfo info " 
							+ " WHERE msg.GROUP_ID = info.parent_group_id AND info.GROUP_ID = '"
							+ groupId +"' AND info.denorm_level = 1";
		System.out.println("#######checkSql->"+checkSql);
%>
 		<wtc:pubselect  name="sPubSelect"  routerKey="region" 
 			 routerValue="<%=regionCode%>"  outnum="2"> 
			<wtc:sql><%=checkSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%
		/**����loginRootDistance���жϹ���Ȩ������**/
		int loginRootDistance = 999999;
		String parentGroupId = "";
		if(retCode.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				loginRootDistance = sVerifyTypeArr[0][0].equals("")?loginRootDistance:Integer.parseInt(sVerifyTypeArr[0][0]);
				parentGroupId = sVerifyTypeArr[0][1];
			}
		}
		StringBuffer  sql = new StringBuffer();

			sql.append("SELECT   msg.GROUP_ID, msg.GROUP_ID||'->'||msg.group_name ");
			sql.append("FROM dchngroupmsg msg, dchngroupinfo info ");
			sql.append("WHERE msg.GROUP_ID = info.GROUP_ID AND info.denorm_level = 1 ");
			if(loginRootDistance == 0){
				sql.append("AND info.parent_group_id = '10014' ");
			}else{
				sql.append("AND info.parent_group_id = '" + parentGroupId + "' ");
			}
			sql.append("ORDER BY info.GROUP_ID ");
			System.out.println("sql==========" + sql);

%>
		<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
			<wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
<html>
<head>
<title>������BOSS-���Ѷ��Ų�ѯ</title>
<script language="javascript">
	function doQuery(){
		var qryGroupIdVal = document.all.regionCodeSel.value;
		var denormLevel = "<%=loginRootDistance%>";
		if(qryGroupIdVal == ""){
			rdShowMessageDialog("��֯������ʶ����Ϊ�գ�");
			return false;
		}
		/* ����ѯ */
		
		var msgCodeVal = $("#msgCode").val();
		var msgNameVal = $("#msgName").val();
		var startTimeVal = $("#startTime").val();
		var endTimeVal = $("#endTime").val();
		var getdataPacket = new AJAXPacket("fd291Qry.jsp","���ڻ����Ϣ�����Ժ�......");
		getdataPacket.data.add("msgCode",msgCodeVal);
		getdataPacket.data.add("msgName",msgNameVal);
		getdataPacket.data.add("startTime",startTimeVal);
		getdataPacket.data.add("endTime",endTimeVal);
		getdataPacket.data.add("qryGroupId",qryGroupIdVal);
		getdataPacket.data.add("denormLevel",denormLevel);
		core.ajax.sendPacket(getdataPacket,doBack);
		getdataPacket = null;
	}
	function doBack(packet){
		retCode = packet.data.findValueByName("retcode");
		retMsg = packet.data.findValueByName("retmsg");
		result = packet.data.findValueByName("result");
		
		if("000000" == retCode){
			var qryTabObj = $("#queryTabDiv");
			var td ="";
			td = "<table cellspacing=\"0\" id=\"tabList\">";
			td = td + "<tr>";
			td = td + "<th>����ģ�����</th><th>����ģ������</th><th>���Ų�������</th><th>��������</th><th>��Чʱ��</th><th>ʧЧʱ��</th><th>���õ�λ</th><th>������</th><th>��������</th>";
			td = td + "</tr>";
			if("undefined" == typeof(result)){
				td = td + "<tr>";
				td = td + "<td colspan='9' align=\"center\"><font class='orange'>û���κμ�¼��</font></td>";
				td = td + "</tr>";
			}else{
				$.each( result, function(i, n){
					td = td + "<tr>";
					td = td + "<td>" + n[2] + "</td>";
					td = td + "<td>" + n[3] + "</td>";
					td = td + "<td>" + n[6] + "</td>";
					td = td + "<td>" + n[10] + "</td>";
					td = td + "<td>" + n[8] + "</td>";
					td = td + "<td>" + n[9] + "</td>";
					td = td + "<td>" + n[4] + "</td>";
					td = td + "<td>" + n[1] + "</td>";
					td = td + "<td>" + n[0] + "</td>";
					td = td + "</tr>";
				});
			}
			td = td + "<tr><td colspan='9' align=\"center\">";
			td = td + "<input type='button' value='����' class=\"b_foot\" onclick='printTable(tabList)' />";
			td = td + "</td></tr>";
			td = td + "</table>";
			qryTabObj.empty();
			qryTabObj.append(td);
			qryTabObj.show("fast");
		}else{
			rdShowMessageDialog("��ѯʧ��" + retCode + " : " + retMsg);
		}
	}
	function doReset(){
		window.location.href = "fd291.jsp"
	}
</script>
</head>
<body>
<form action="" method="post" name="frm">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">���Ѷ��Ų�ѯ</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue" nowrap>��֯������ʶ</td>
			<td>
				<select name="regionCodeSel" id="regionCodeSel">
					<option value="" selected>��ѡ��</option>
					<%for (int i = 0; i < result.length; i++) {%>
		      		<option value="<%=result[i][0]%>"><%=result[i][1]%>
		      		</option>
		    	<%}%>
				</select>
				<font class="orange"><span>*</span></font>
			</td>
			<td class="blue" nowrap width="15%">����ģ�����</td>
			<td width="30%">
				<input type="text" name="msgCode" id="msgCode" maxlength="5" />
			</td>
		</tr>
		<tr>
			<td class="blue" nowrap>����ģ������</td>
			<td>
				<input type="text" name="msgName" id="msgName" maxlength="10" />
			</td>
			<td class="blue" nowrap>����ʱ��</td>
			<td>
				<input type="text" name="startTime" id="startTime" size="8" 
				v_type="date" onblur="checkElement(this)" />
				-
				<input type="text" name="endTime" id="endTime" size="8" 
				v_type="date" onblur="checkElement(this)" />
				<font class="orange"><span>(��ʽ��yyyymmdd)</span></font>
			</td>
		</tr>
	</table>
	<div id="queryTabDiv" style="display:none;">
	</div>
	<table cellSpacing="0">
    <tr> 
      <td id="footer"> 
         <input type="button" name="resetButton"  class="b_foot" value="����" 
          style="cursor:hand;" onclick="doReset()">&nbsp;
         <input type="button" name="queryButton"  class="b_foot" value="��ѯ" 
          style="cursor:hand;" onclick="doQuery()">&nbsp;
         <input type="button" name="closeButton" class="b_foot" value="�ر�" 
          style="cursor:hand;" onClick="removeCurrentTab()">&nbsp;
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
<script>
var excelObj;
function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.tabList.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 excelObj.WorkBooks.Add; 
		for(a=0;a<document.all.tabList.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						for(j=0;j<cells;j++)
							excelObj.Cells(i+1+(total_row),j+1).Value=obj[a].rows[i].cells[j].innerText;
					}
				}
				catch(e)
				{
					//alert('����excelʧ��!');
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
 excelObj.WorkBooks.Add; 
		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					for(j=0;j<cells;j++)
						excelObj.Cells(i+1,j+1).Value=obj.rows[i].cells[j].innerText;
				}
			}
			catch(e)
			{
				//alert('����excelʧ��!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
}
</script>