<%
   /*
   * ����: ��ѯ���õ�����Ϣ
�� * �汾: v3.0
�� * ����: 2011-7-12
�� * ����: huangrong
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
		<%@ page import="java.util.ArrayList" %>
<%
 		String opCode = "e016";
 		String opName = "ѫ�¶һ���Ʒ��������";

		String groupId = (String)session.getAttribute("groupId");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = (String)session.getAttribute("regCode");
		String regionCodeSql="";
		String [] paraIn = new String[2];
	  
	  
		String getAuditLoginSql = "";
		if(groupId.equals("10014"))
    {
			regionCodeSql = "select region_code,region_name,group_id from sregionCode where use_flag=:use_flag order by region_code";
			paraIn[1]="use_flag=Y";
		}else
		{
		 	regionCodeSql = "select region_code,region_name,group_id from sregionCode  where region_code=:regionCode";
		 	paraIn[1]="regionCode="+regionCode;
		}	
		paraIn[0] = regionCodeSql;
		%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="3">
			<wtc:param value="<%=paraIn[0]%>"/>
			<wtc:param value="<%=paraIn[1]%>"/>
			</wtc:service>
			<wtc:array id="regionCodeStr" scope="end" />
<%		
		int totalNum = regionCodeStr.length;
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
			function select_groupId(regionCode,row)
			{
				var path = "groupTree.jsp?regionCode="+regionCode+"&row="+row;
			  window.open(path,'_blank','height=600,width=300,scrollbars=yes');
			}	
			//�鿴��ѡӪҵ��
			function query_groupId(row)
			{
				var groupIds=document.getElementById("groupId"+row).value;
				var groupNames=document.getElementById("groupName"+row).value;
				if(groupIds=="" || groupIds==null)
				{
					rdShowMessageDialog("����ѡ����ȡӪҵ����Ȼ��鿴��Ϣ!");
					return false;					
				}
				var group_ids=groupIds.split(",");
				if(group_ids.length>50)
				{
					rdShowMessageDialog("�һ�Ӫҵ���ĸ���̫�೬��50���������Բ鿴��������У�鲢����ִ�жһ�������");
					return false;				
				}
				var path = "fe016_queryInfo.jsp?groupIds="+groupIds+"&groupNames="+groupNames;
				window.open(path,'_blank','height=550,width=550,scrollbars=yes');
			
			}	
			
			function check_groupId(row)
			{
				var groupIds=document.getElementById("groupId"+row).value;
				if(groupIds=="" || groupIds==null)
				{
					rdShowMessageDialog("����ѡ����ȡӪҵ����Ȼ��У��ѡ����Ƿ���Ӫҵ������");
					return false;					
				}
        isSaleHall(groupIds,row);
			}	
			
			
	 	 function isSaleHall(groupId,row)
	 	 {
				var myPacket = new AJAXPacket("fe016_isSaleHall.jsp","�����ύ�����Ժ�......");
				myPacket.data.add("groupId",groupId);
				myPacket.data.add("row",row);
				core.ajax.sendPacket(myPacket,doIsSaleHall);
				myPacket=null; 	 	
	 	 } 
	
	
	 	 function doIsSaleHall(packet){
					var isSaleHall = packet.data.findValueByName("isSaleHall");
					var row = packet.data.findValueByName("row");
			 		if(isSaleHall=="1")
			 		{
						//document.getElementById("auditRegionCode"+row).disabled=true;
					  rdShowMessageDialog("��֤ͨ����ѡ��ľ�ΪӪҵ������",2);						
						document.getElementById("addButton"+row).disabled=true;
						document.getElementById("queryButton"+row).disabled=true;
						document.getElementById("checkButton"+row).disabled=true;
						var groupIds=document.getElementById("groupId"+row).value;
						
						
						
      			var checkButtons = document.getElementsByName("checkButton");	
						var impCodeStr = "";
						var regionLength = 0;
						for(var i=0;i<checkButtons.length;i++){
							if(checkButtons[i].disabled){
								/*
								var tr=document.getElementById("groupId"+i).parentNode.parentNode;
								var tds=tr.childNodes;
								var region_code=tds[0].innerHTML;
								var impValue =document.getElementById("groupId"+i).value;//�������еĵ��к�Ӫҵ��������У�鰴ť��ң����ȡ��ǰ��group_id
						    if(impCodeStr=="")
							  {
							  	impCodeStr=region_code+"~"+impValue;
							  }else
							  {
							  	impCodeStr=impCodeStr+"/"+region_code+"~"+impValue;
							  }
							  */
							  var impValue =document.getElementById("groupId"+i).value;//�������еĵ��к�Ӫҵ��������У�鰴ť��ң����ȡ��ǰ��group_id
							  var region_code =document.getElementById("group_id"+i).value;//��ȡ���ж�Ӧ��groupId
						    if(impCodeStr=="")
							  {
							  	impCodeStr=region_code+"~"+impValue;
							  }else
							  {
							  	impCodeStr=impCodeStr+"/"+region_code+"~"+impValue;
							  }							  
							}
						}
						//��ҳ�洫ֵ
						parent.document.all.reginonCodes.value ="";//�����һҳ����д����ֵ
						parent.document.all.reginonCodes.value = impCodeStr;
						
			 			
			 		}else
			 		{
						rdShowMessageDialog("��ȡӪҵ������ѡ��Ӫҵ������������ѡ��!");
						return false;		 			
			 		}		
	 	}									
		//-->
	</script>
</head>
<body>
	<FORM method=post name="form1">
		<div id="Operation_Table">
     <table cellspacing="0" id="tab">
			<tr align="center">
			<!--	<th width="10%" nowrap>ѡ��<input type="checkbox" name="checkAll" onclick="checkAll(this)"></td>-->
				<th width="20%" nowrap>���д���</td>
				<th width="20%" nowrap>��������</td> 
				<th width="50%" nowrap>��ȡӪҵ������</td> 
			</tr> 
	<%
			if(totalNum==0){
				out.println("<tr height='25' align='center'><td colspan='3'>");
				out.println("û���κμ�¼��");
				out.println("</td></tr>");
			}else if(totalNum>0){
				String tbclass = "";
				for(int i=0;i<totalNum;i++){
					tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>"><%=regionCodeStr[i][0]%></td>
							<td class="<%=tbclass%>"><%=regionCodeStr[i][1]%></td>
							<input type="hidden" id="group_id<%=i%>" value="<%=regionCodeStr[i][2]%>">
							
							<input type="hidden" id="groupName<%=i%>" v_must="1"  v_type="string" maxlength="60" class="button" readonly>
							<input type="hidden" id="groupId<%=i%>">
							<td class="<%=tbclass%>">
								<input name="addButton" id="addButton<%=i%>" class="b_text" type="button" value="ѡ��" onClick="select_groupId('<%=regionCodeStr[i][0]%>','<%=i%>')" >
                <input name="queryButton" id="queryButton<%=i%>" class="b_text" type="button" value="�鿴��ѡӪҵ��" onClick="query_groupId('<%=i%>')" >			
                 <input name="checkButton" id="checkButton<%=i%>" class="b_text" type="button" value="У���Ƿ���Ӫҵ��" onClick="check_groupId('<%=i%>')" >																	
							</td>
						</tr>
	<%				
				}
			}
	%>
  </table>
 <table  cellspacing="0">
 	<tbody> 
    <tr height="20"> 
    	<td colspan="3">����˵����<font color="red">ֻ��ѡ��ĵ�����Ӫҵ����ǰ��¼��ң��ò�����Ч</font><br>
			  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">1�����ѡ��ť��ѡ����ж�Ӧ��Ӫҵ��</font><br>
			  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">2������鿴��ѡӪҵ����ť���鿴���ж�Ӧѡ���Ӫҵ����ϸ&nbsp	</font><br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">3�����У���Ƿ���Ӫҵ����ť��У����ж�Ӧѡ��Ӫҵ������ѡ����Ƿ���Ӫҵ������</font><br>
      </td>
    </tr>
  </tbody> 
</table>  
</div>
</FORM>
</body>
</html>    

