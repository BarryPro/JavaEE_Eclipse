<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: ������ַά��ҳ��
�� * �汾: 1.0
�� * ����: 2013/03/05
�� * ����: liuhaoa
�� * ��Ȩ: sitech
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*,java.text.SimpleDateFormat,com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>
<%
	String tdClass = "blue";
	List dataList = new ArrayList();
	Map pMap = new HashMap();
	dataList = (List) KFEjbClient.queryForList("query_K850_select",pMap);
%>
<html>
<head>
<title>������ַά��</title>
</head>
<script language="javascript" type="text/javascript">
	//ѡ���и�����ʾ
	var hisObj="";//������һ����ɫ����
	var hisColor=""; //������һ������ԭʼ��ɫ
	function changeColor(color,obj){
		//�ָ�ԭ��һ�е���ʽ
		if(hisObj != ""){
			for(var i=0;i<hisObj.cells.length;i++){
				var tempTd=hisObj.cells.item(i);
				//tempTd.className=hisColor; ��ԭ�ֵ���ɫ
				tempTd.style.backgroundColor = '#F7F7F7';		//��ԭ�б�����ɫ
			}
		}
		hisObj   = obj;
		hisColor = color;
		//���õ�ǰ�е���ʽ
		for(var i=0;i<obj.cells.length;i++){
			var tempTd=obj.cells.item(i);
			//tempTd.className='green'; �ı��ֵ���ɫ
			tempTd.style.backgroundColor='#00BFFF';	//�ı��б�����ɫ
		}
	}
	function updateAddressUrl(id_no){
		var height = 320;
		var width = 550;
		var top = screen.availHeight/2 - height/2;
		var left = screen.availWidth/2 - width/2;
		var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left=" + left + ",toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,status=no";
		var url = "<%=request.getContextPath()%>/npage/callbosspage/K850/K850_chinaMobileHref_update.jsp?id_no="+id_no;
		window.open(url,"chinaMobileHref_update",winParam);
	}
	function submitInputCheck(){
		window.sitechform.action = "K850_chinaMobileHref.jsp";
		window.sitechform.method = "post";
		window.sitechform.submit();
	}	
</script>

<body>
	<form id="sitechform" name="sitechform" action="" >
	<div id="Operation_Table">
		<div class="title">
			<div id="title_zi">������ַ��ȫά��</div>
		</div>
		<table cellspacing="0">
			<tr>
				<th align="center" class="blue" width="8%" nowrap >ϵͳ����</th>
				<th align="center" class="blue" width="8%" nowrap >��ַ</th>
				<th align="center" class="blue" width="8%" nowrap >����ʱ��</th>
				<th align="center" class="blue" width="8%" nowrap >��������</th>
				<th align="center" class="blue" width="8%" nowrap >����</th>
			</tr>
<%
			for(int i = 0; i < dataList.size(); i++){
				Map dataMap = (HashMap)dataList.get(i);
%>
			<tr onClick="changeColor('<%=tdClass%>',this);">
				<td align="center" class="<%=tdClass%>" nowrap ><%=dataMap.get("SYSTEM_NAME")%></td>
				<td align="left" class="<%=tdClass%>" nowrap ><%=dataMap.get("ADRESS_URL")%></td>
				<td align="center" class="<%=tdClass%>" nowrap ><%=dataMap.get("OP_TIME")%></td>
				<td align="center" class="<%=tdClass%>" nowrap ><%=dataMap.get("OP_LOGIN_NO")%></td>
				<td align="center" class="<%=tdClass%>" nowrap >
					<img style="cursor:hand" id="updateManual" alt="�޸�" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/2.gif" 
					onClick="updateAddressUrl('<%=dataMap.get("ID_NO")%>')",width="16" height="16" align="absmiddle">
				</td>
			</tr>
<%				
			}
%>
		</table>
	</div>
</form>
</body>
</html>