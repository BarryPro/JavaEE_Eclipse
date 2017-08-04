
<%
	 /*
	 * 功能: 12580群组-新建编辑-select联系人
	 * 版本: 1.0.0
	 * 日期: 2009/01/12
	 * 作者: xingzhan
	 * 版权: sitech
	 * update:
	 */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<%
  String opCode = "K505";
  String opName = "群组维护";
  String dataRows[][] = new String[][]{};
  
  
  
  String PERSON_ID = request.getParameter("PERSON_ID")==null?"":request.getParameter("PERSON_ID");
  String SERIAL_NO = request.getParameter("SERIAL_NO")==null?"":request.getParameter("SERIAL_NO");
  String ACCEPT_NO = request.getParameter("ACCEPT_NO")==null?"":request.getParameter("ACCEPT_NO");
  String PERSON_NAME = request.getParameter("PERSON_NAME")==null?"":request.getParameter("PERSON_NAME");
  String PERSON_PHONE = request.getParameter("PERSON_PHONE")==null?"":request.getParameter("PERSON_PHONE");
  String PERSON_FAX = request.getParameter("PERSON_FAX")==null?"":request.getParameter("PERSON_FAX");
  String PERSON_EMAIL = request.getParameter("PERSON_EMAIL")==null?"":request.getParameter("PERSON_EMAIL");
  String PERSON_QQ = request.getParameter("PERSON_QQ")==null?"":request.getParameter("PERSON_QQ");
  String PERSON_UNIT = request.getParameter("PERSON_UNIT")==null?"":request.getParameter("PERSON_UNIT");
  String PERSON_DESCR = request.getParameter("PERSON_DESCR")==null?"":request.getParameter("PERSON_DESCR");
  String PERSON_SEX = request.getParameter("PERSON_SEX")==null?"":request.getParameter("PERSON_SEX");
  String PERSON_BIRTH = request.getParameter("PERSON_BIRTH")==null?"":request.getParameter("PERSON_BIRTH");
  
  String sqlStr = " select SERIAL_NO,PERSON_NAME,decode(PERSON_SEX,'F','女','M','男') "
						+" ,PERSON_PHONE,IS_MOBILE_NET,PERSON_FAX,PERSON_EMAIL,PERSON_QQ,PERSON_DESCR "
						+" ,PERSON_BIRTH,PERSON_UNIT,TO_CHAR(a.CREATE_TIME,'yyyy/mm/dd hh24:mi:ss'),a.ACCEPT_NO from DPHONLIST a "
						+" left join DMSGGRPPHONLIST b ON b.list_serial_no = a.serial_no "
						+" where b.grp_serial_no = '"+SERIAL_NO+"' and a.PERSON_TYPE = '1' and a.ACCEPT_NO = '"+ACCEPT_NO+"'";

  if(PERSON_NAME != ""){
				
		sqlStr = sqlStr+" AND PERSON_NAME = '"+PERSON_NAME+"'";
	}
	if(PERSON_PHONE != ""){
		
		sqlStr = sqlStr+" AND PERSON_PHONE = '"+PERSON_PHONE+"'";
	}
	if(PERSON_FAX != ""){
		
		sqlStr = sqlStr+" AND PERSON_FAX = '"+PERSON_FAX+"'";
	}
	if(PERSON_EMAIL != ""){
		
		sqlStr = sqlStr+" AND PERSON_EMAIL = '"+PERSON_EMAIL+"'";
	}
	if(PERSON_QQ != ""){
		
		sqlStr = sqlStr+" AND PERSON_QQ = '"+PERSON_QQ+"'";
	}
	if(PERSON_UNIT != ""){
		
		sqlStr = sqlStr+" AND PERSON_UNIT = '"+PERSON_UNIT+"'";
	}
	if(PERSON_DESCR != ""){
		
		sqlStr = sqlStr+" AND PERSON_DESCR = '"+PERSON_DESCR+"'";
	}
	if(PERSON_SEX != ""){
		
		sqlStr = sqlStr+" AND PERSON_SEX = '"+PERSON_SEX+"'";
	}
	
	sqlStr = sqlStr + " order by SERIAL_NO";	
			
%>
<wtc:service name="s151Select" outnum="24">
	<wtc:param value="<%=sqlStr%>" />
</wtc:service>
<wtc:array id="queryList" scope="end" />
<%
	dataRows = queryList;
	
%>

<%
    String org_code = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
%>

<html>
	<head>
		<title>群组</title>
		<script language=javascript>  
		function setObjID(idvalue)
		{
            // alert(idvalue);		    
		    var myPacket = new AJAXPacket("k505_select_obj.jsp","正在提交，请稍候......");
		    myPacket.data.add("idvalue",idvalue); 
		    core.ajax.sendPacket(myPacket,doProcess,true);
			myPacket=null;
		}
		function doProcess(myPacket)
		{
		
		    var retType = myPacket.data.findValueByName("retType");
			var retCode = myPacket.data.findValueByName("retCode");
			var retMsg = myPacket.data.findValueByName("retMsg");
			
			var phone_name = myPacket.data.findValueByName("phone_name");
			var phone_mainnum = myPacket.data.findValueByName("phone_mainnum");
			var phone_fax = myPacket.data.findValueByName("phone_fax");
			var phone_qq = myPacket.data.findValueByName("phone_qq");
			var phone_email = myPacket.data.findValueByName("phone_email");
			var phone_sxe = myPacket.data.findValueByName("phone_sxe");
			var phone_unit = myPacket.data.findValueByName("phone_unit");
			var phone_note = myPacket.data.findValueByName("phone_note");
			var phone_yeas = myPacket.data.findValueByName("phone_yeas");
			var phone_month = myPacket.data.findValueByName("phone_month");
			var phone_date = myPacket.data.findValueByName("phone_date");
			var SERIAL_NO = myPacket.data.findValueByName("SERIAL_NO");
				if(retCode=="000000"){
				   //alert("插入成功");
				   // rdShowMessageDialog("成功",2);
				
				  parent.document.getElementById("PERSON_NAME").value = phone_name;
				  parent.document.getElementById("PERSON_PHONE").value = phone_mainnum;
				  parent.document.getElementById("PERSON_FAX").value = phone_fax;
				  parent.document.getElementById("PERSON_EMAIL").value = phone_email;
				  parent.document.getElementById("PERSON_QQ").value = phone_qq;
				  parent.document.getElementById("phone_yeas").value = phone_yeas;
				  parent.document.getElementById("phone_month").value = phone_month;
				  parent.document.getElementById("phone_date").value = phone_date;
				  parent.document.getElementById("PERSON_UNIT").value = phone_unit;
				  parent.document.getElementById("PERSON_DESCR").value = phone_note;
				  parent.document.getElementById("PERSON_ID").value = SERIAL_NO;
				  if(phone_sxe=='M'){
				  
				  	 parent.document.getElementById("PERSON_SEXM").checked="checked"
				  }else{
				  	 parent.document.getElementById("PERSON_SEXF").checked="checked" 
				  }
				            
				  
				}else if(retCode=="11111"){
					
					rdShowMessageDialog("失败,此受理号不存在电话本中",0);
					return false;
				}else{
					//alert("插入失败!");
					rdShowMessageDialog("失败",0);
					return false;
				}
		}
		</script>
	</head>
	<body >
		
		  <form name="sitechform" id="sitechform">
		  <div id="Operation_Table">
		  	<table cellSpacing="0">
					
					<tr>

                        <th align="center" class="blue" width="8%">&nbsp;</th> 
						<th align="center" class="blue" width="8%">序号</th>
						<th align="center" class="blue" width="8%">姓名</th>
						<th align="center" class="blue" width="8%">性别</th>
						<th align="center" class="blue" width="8%">主号码</th>
						<th align="center" class="blue" width="8%">受理号</th>
						<th align="center" class="blue" width="8%">是否本网</th>
						<th align="center" class="blue" width="8%">传真</th>
						<th align="center" class="blue" width="8%">电邮</th>
						<th align="center" class="blue" width="8%">QQ/BP</th>
						<th align="center" class="blue" width="8%">备注</th>
						<th align="center" class="blue" width="8%">生日</th>
						<th align="center" class="blue" width="8%">单位</th>
						<th align="center" class="blue" width="8%">创建时间</th>

					</tr>
		  	
		  			<div id ="checknull" style="display: none;">
					<input type="radio" name="obj_id" id="obj_id"  value="0" checked="checked"/>
					<input type="hidden" name="checkid" id ="checkid" value="0">
					</div>
					<%
							for (int i = 0; i < dataRows.length; i++) {
							String tdClass = "";
					%>

					<%
								if ((i + 1) % 2 == 1) {
								tdClass = "grey";
							}
					%>
					<tr>
					    
					    <td align="center" class="<%=tdClass%>" nowrap="nowrap"><input type="radio" name="obj_id" id="obj_id" value="<%= dataRows[i][0]%>" onclick="setObjID(this.value);" <%if(dataRows[i][0].equalsIgnoreCase(PERSON_ID)){%>checked="checked"<%}%>></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][0].length() != 0) ? dataRows[i][0]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][1].length() != 0) ? dataRows[i][1]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][2].length() != 0) ? dataRows[i][2]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][3].length() != 0) ? dataRows[i][3]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][12].length() != 0) ? dataRows[i][12]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][4].length() != 0) ? dataRows[i][4]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][5].length() != 0) ? dataRows[i][5]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][6].length() != 0) ? dataRows[i][6]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][7].length() != 0) ? dataRows[i][7]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][8].length() != 0) ? dataRows[i][8]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" nowrap="nowrap"><%=(dataRows[i][9].length() != 0) ? dataRows[i][9]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" ><%=(dataRows[i][10].length() != 0) ? dataRows[i][10]: "&nbsp;"%></td>
						<td align="center" class="<%=tdClass%>" nowrap="nowrap"><%=(dataRows[i][11].length() != 0) ? dataRows[i][11]: "&nbsp;"%></td>

					</tr>
					<%
					}
					%>
		  	</table>
		  	</div>
		  </form>
	   
	</body>
</html>	
