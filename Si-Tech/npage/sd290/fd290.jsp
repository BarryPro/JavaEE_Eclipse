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
    
 		String opCode = "d290";
 		String opName = "���Ѷ��Ÿ��²�ѯ";
 		
 		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		/**�鿴���ŵļ���,�����Ӫҵ���ļ�����С,��������޸�ҳ��**/
		String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
		System.out.println("#######checkSql->"+checkSql);
%>
		<wtc:pubselect  name="sPubSelect"  routerKey="region" 
			 routerValue="<%=regionCode%>" outnum="1"> 
		<wtc:sql><%=checkSql%></wtc:sql>
		</wtc:pubselect> 
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%
		/**����loginRootDistance���жϹ���Ȩ������**/
		int loginRootDistance = 999999;
		if(retCode.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				loginRootDistance = sVerifyTypeArr[0][0].equals("")?loginRootDistance:Integer.parseInt(sVerifyTypeArr[0][0]);
			}
		}
		/**
			������ŵļ�������ظ�С,���ܽ����޸Ĳ���;1.�жϹ��ŵļ���,
			���root_distance==1,ʡ��,==2,����,==3,����,>3,Ӫҵ�����С�ļ���
		**/
		if(loginRootDistance>3){
%>
				<table cellspacing="0">
					<tr bgcolor='649ECC' height=25 align="center">
						<td>
							<font style="color:red">(�˹������޸�Ȩ��)</font>
						</td>
					</tr>
				</table>
				<script language="javascript">
					<!--
					rdShowMessageDialog("�˹������޸�Ȩ��");
					window.close();
					//-->
				</script>	
<%
				return;
		}
%>
<html>
<head>
	<title>������BOSS-���Ѷ��Ÿ��²�ѯ</title>
	<script language="javascript">
		function doReset(){
			window.location.href = "fd290.jsp"
		}
		function doQuery(){
			if(!check(document.form1)){
				return false;
			}
			var opFlagVal = $("#opFlag").val();
			if("none" == opFlagVal){
				rdShowMessageDialog("��ѡ���������");
				return false;
			}
			form1.submit();
		}
	</script>
</head>
<body>
<form action="fd290_2.jsp" method="post" name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">���Ѷ��Ÿ��²�ѯ</div>
	</div>
	<table cellSpacing="0">
		<tr>
			<td class="blue">����ģ�����</td>
			<td>
				<input type="text" name="msgCode" id="msgCode" />
			</td>
			<td class="blue">��������</td>
			<td>
				<select name="opFlag" id="opFlag">
					<option value="none">--��ѡ��--</option>
					<option value="A">����</option>
					<option value="D">ɾ��</option>
					<option value="U">�޸�</option>
				</select>
				<font class="orange"><span>*</span></font>
			</td>
		</tr>
		<tr>
			<td class="blue">��ʼʱ��</td>
			<td>
				<input type="text" name="startTime" id="startTime" v_must="1" 
				v_type="date" onblur="checkElement(this)" />
				<font class="orange"><span>*(��ʽ��yyyymmdd)</span></font>
			</td>
			<td class="blue">����ʱ��</td>
			<td>
				<input type="text" name="endTime" id="endTime" v_must="1" 
				v_type="date" onblur="checkElement(this)" />
				<font class="orange"><span>*(��ʽ��yyyymmdd)</span></font>
			</td>
		</tr>
	</table>
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

