<%
  /*
	* ����: �ʼ�����ϸ
	* �汾: 1.0
	* ����: 2008/10/20
	* ����: hanjc
	* ��Ȩ: sitech
	* update: tangsong 2011/06/14 ��̬���ҳ���Ű�
	*/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.* ,java.util.*,"%>

<%
	String opCode = "k211";
	String opName = "�ʼ��ѯ-�ʼ�����ϸ��Ϣ";
	String tName ="�ʼ�����ϸ��Ϣ";
	String loginNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String myParams = "";
	String myParams1 = "";
	String myParams2 = "";
	String contact_id = WtcUtil.repNull(request.getParameter("contact_id"));
	String contact_id_kf=request.getParameter("contact_id_kf");
	String contactId_kf=contact_id_kf.substring(0,6);
	System.out.println("sunbya----contactId---"+contactId_kf+"    "+contact_id_kf);
	String object_id = request.getParameter("object_id");
	String[][] detailRecList = new String[][]{};
	String[][] detailItemList = new String[][]{};
	String[][] detailItemSubListTemp = new String[][]{};
	ArrayList detailItemSubList = new ArrayList();
	String isPwdVer = request.getParameter("isPwdVer");
	if(null == isPwdVer||"".equals(isPwdVer)){
		isPwdVer = "��";
	}
	String sqlStr = "";
	String action = request.getParameter("myaction");
	if (contact_id!=null) {
		sqlStr = "select "
		        + "t1.recordernum,   " //������ˮ��
		        + "t1.staffno,       " //���칤��
		        + "t3.object_name,   " //�������
		        + "t4.name,          " //��������
		        + "decode(substr(to_char(trim(t1.score)),0,1),'.','0'||to_char(trim(t1.score)),to_char(t1.score))," //�ܵ÷�
		        + "t1.errorleveldesc," //�ȼ�
		        + "t1.evterno,       " //�ʼ칤��
		        + "decode(t1.kind,'0','�Զ�����','1','�˹�ָ��'),          " //������ʽ
		        + "decode(t1.checktype,'0','ʵʱ�ʼ�','1','�º��ʼ�'),     " //�������
		        + "to_char(t1.starttime,'yyyyMMdd hh24:mi:ss'),     " //�ʼ쿪ʼʱ��
		        + "to_char(t1.endtime,'yyyyMMdd hh24:mi:ss'),       " //�ʼ����ʱ��
		        + "to_char(t1.dealduration),  " //����ʱ��
		        + "to_char(t1.lisduration),   " //��������ʱ��
		        + "to_char(t1.arrduration),   " //����ʱ��
		        + "to_char(t1.evtduration),   " //�ʼ���ʱ��
		        + "decode(t1.flag,'0','��ʱ����','1','���ύ','2','���ύ���޸�','3','��ȷ��','4','����'),          " //�ʼ���
		        + "t1.signataryid,   " //ȷ����
		        + "to_char(t1.affirmtime,'yyyy-MM-dd hh24:mi:ss'),    " //ȷ������
		        + "t1.objectid," //�������id
		        + "t1.contentid " //��������id
		        + "from dqcinfo t1,dqcobject t3,dqccheckcontect t4 where t1.serialnum=:contact_id ";
		myParams = "contact_id="+contact_id;
		String strJoinSql = " and t1.objectid=t3.object_id(+) and t1.contentid=t4.contect_id(+) ";
		sqlStr += strJoinSql;
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="25">
			<wtc:param value="<%=sqlStr%>"/>
			<wtc:param value="<%=myParams%>"/>
		</wtc:service>
		<wtc:array id="queryList" scope="end"/>
<%
		detailRecList = queryList;
		if(detailRecList.length>0){
			sqlStr = "select t.item_name, t.formula, to_char(t.weight), t.item_id,t.is_scored  "
				    + "from dqccheckitem t "
				    + "where t.object_id = :object_id and t.contect_id = :contect_id and t.bak1='Y' ";
			myParams = "object_id="+detailRecList[0][18]+",contect_id="+detailRecList[0][19];
			String strParentSql=" and t.parent_item_id='0'  order by t.item_id";
			sqlStr += strParentSql;
%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
				<wtc:param value="<%=sqlStr%>"/>
				<wtc:param value="<%=myParams%>"/>
			</wtc:service>
			<wtc:array id="resultList" scope="end"/>
<%
			detailItemList = resultList;
			sqlStr = "select "
					+ "t1.item_name,"//������Ŀ
					+ "t1.formula,"  //��ʽ
					+ "to_char(t1.weight),"   //Ȩ��
					+ "decode(substr(to_char(trim(t2.score)),0,1),'.','0'||to_char(trim(t2.score)),to_char(t2.score)),"    //�÷�
					+ "t2.orgvalue, " //ԭʼֵ
					+ "t1.item_id, "   //������Ŀid
					+ "t2.itemcomment "   //����
					+ "from dqccheckitem t1, dqcinfodetail t2 where t1.object_id=:object_id and t1.contect_id=:contect_id and t1.bak1='Y' and t2.serialnum= :contact_id1 ";
			myParams = "object_id="+detailRecList[0][18]+",contect_id="+detailRecList[0][19]+",contact_id1="+contact_id;
			strJoinSql = " and t1.object_id(+)=t2.objectid and t1.contect_id(+)=t2.contentid and t1.item_id=t2.itemid ";
			sqlStr += strJoinSql;
			for(int i=0;i<detailItemList.length;i++){
				if("N".equals(detailItemList[i][4])){
					strParentSql=" and t1.parent_item_id=:parent_item_id  order by t1.item_id";
					myParams1 = myParams+",parent_item_id="+detailItemList[i][3];
				}else{
					strParentSql=" and t1.item_id=:item_id order by t1.item_id";
					myParams1 = myParams+",item_id="+detailItemList[i][3];
				}
%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="7">
				<wtc:param value="<%=sqlStr+strParentSql%>"/>
				<wtc:param value="<%=myParams1%>"/>
			</wtc:service>
			<wtc:array id="detailItemListTemp" scope="end"/>
<%
          detailItemSubListTemp=detailItemListTemp;
          detailItemSubList.add(detailItemSubListTemp);
			}
		}
	}
%>
<%
	String kh_brand_sql="select sm_code from dcallcall"+contactId_kf+" t where t.contact_id=:contact_id";
	myParams2 = "contact_id=" + contact_id_kf;
	
	String brand_no="";
	String brand_name="";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:param value="<%=kh_brand_sql%>" />
		<wtc:param value="<%=myParams2%>" />
	</wtc:service>
	<wtc:array id="kh_brand" scope="end" />
<%
if (kh_brand != null || kh_brand.length != 0) {
	for(int i=0;i<kh_brand.length;i++){
		brand_no=kh_brand[i][0];
		//System.out.println(kh_brand[i][0]+"-"+brand_no+"sunbya"+"50".equals(brand_no));
	}
		if(brand_no.equals("zn")){
			brand_name="������";
		}else if(brand_no.equals("gn")){
			brand_name="ȫ��ͨ";
		}else if(brand_no.equals("dn")){
			brand_name="���еش�";
	  }else{
	  	brand_name="δ֪";	
	  }
}
%>
<html>
<head>
<title>�ʼ�����ϸ��Ϣ</title>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);

			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

function checkElement2() {
		checkElement(this);
}

function submitInput(url){
   if( document.sitechform.contact_id.value == ""){
    	  showTip(document.sitechform.contact_id,"��ˮ�Ų���Ϊ�գ�������ѡ�������");
        sitechform.contact_id.focus();
    }
    else {

    hiddenTip(document.sitechform.contact_id);
    doSubmit(url);
    }
}

function doSubmit(url){
    window.sitechform.action=url;
    window.sitechform.method='post';
    window.sitechform.submit();
}

//�رմ���
function closeWin(){
  window.close();
}

</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body >
<form id=sitechform name=sitechform>
<!--%@ include file="/npage/include/header.jsp"%-->
<%@ include file="/npage/callbosspage/checkWork/K203/check_header.jsp"%>
<div class="title" id="footer">
	<div id="title_zi">��ˮ��&nbsp;</div>
	<input name="contact_id" type="text" id="contact_id" readonly value="<%=contact_id%>" disabled="disabled" />
</div>

<br>
<div id="Operation_Table" style="width:100%;">
	<div class="title"><div id="title_zi">������Ϣ</div></div>
	<table cellspacing="0">
		<tr >
			<td > ������ˮ�� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][0].length()!=0)? detailRecList[0][0]:"&nbsp;"%></td>
			<td > ���칤�� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][1].length()!=0)? detailRecList[0][1]:"&nbsp; "%></td>
			<td > ������� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][2].length()!=0)? detailRecList[0][2]:" &nbsp;"%></td>
			<td > �������� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][3].length()!=0)? detailRecList[0][3]:" &nbsp;"%></td>
		</tr>
		<tr >
			<td > �÷� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][4].length()!=0)? detailRecList[0][4]:" &nbsp;"%></td>
			<td > �ȼ� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][5].length()!=0)? detailRecList[0][5]:" &nbsp;"%></td>
			<td > �ʼ칤�� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][6].length()!=0)? detailRecList[0][6]:" &nbsp;"%></td>
			<td > ������ʽ </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][7].length()!=0)? detailRecList[0][7]:" &nbsp;"%></td>
		</tr>
		<tr >
			<td > ������� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][8].length()!=0)? detailRecList[0][8]:" &nbsp;"%></td>
			<td > �ʼ쿪ʼʱ�� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][9].length()!=0)? detailRecList[0][9]:" &nbsp;"%></td>
			<td>�ʼ����ʱ�� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][10].length()!=0)? detailRecList[0][10]:" &nbsp;"%></td>
			<td > �ʼ�ʱ�� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][11].length()!=0)? detailRecList[0][11]:" &nbsp;"%></td>
		</tr>
		<tr >
			<td > ��������ʱ�� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][12].length()!=0)? detailRecList[0][12]:" &nbsp;"%></td>
			<td > ����ʱ�� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][13].length()!=0)? detailRecList[0][13]:" &nbsp;"%></td>
			<td >���ʼ�ʱ�� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][14].length()!=0)? detailRecList[0][14]:" &nbsp;"%></td>
			<td > �ʼ��� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][15].length()!=0)? detailRecList[0][15]:" &nbsp;"%></td>
		</tr>
		<tr >
			<td > ȷ���� </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][16].length()!=0)?detailRecList[0][16]:" &nbsp;"%></td>
			<td > ȷ������ </td>
			<td ><%=(detailRecList.length!=0 && detailRecList[0][17].length()!=0)? detailRecList[0][17]:" &nbsp;"%></td>
			<td > �ͻ�Ʒ�� </td>
			<td><%=brand_name==null?" &nbsp; ":brand_name%></td>
			<td colspan="2">&nbsp; </td>
		</tr>
	</table>
</div>

<%
	/***************add by tangsong 20110614 ��ö�̬�������� start******************/
	String dqcCommentsSql = "select * from dqcinfocomments t where t.serialnum = :serialnum";
	myParams = "serialnum=" + contact_id;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="22">
		<wtc:param value="<%=dqcCommentsSql%>" />
		<wtc:param value="<%=myParams%>" />
	</wtc:service>
	<wtc:array id="dqcComments" scope="end" />
<%
	//�����ѯ������ʱ����
	if (dqcComments == null || dqcComments.length == 0) {
		dqcComments = new String[1][22];
	}
	/***************add by tangsong 20110614 ��ö�̬�������� end******************/

	/***************add by tangsong 20110614 ���ѡ���������� start******************/
	String chooseCommentItemsSql = "select t.comment_name from dqcchoosecomment t"
											+ " where t.object_id=:object_id and t.parent_comment_id='0' and t.valid_flag='Y'"
											+ " order by t.comment_id";
	myParams = "object_id=" + object_id;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:param value="<%=chooseCommentItemsSql%>" />
		<wtc:param value="<%=myParams%>" />
	</wtc:service>
	<wtc:array id="chooseCommentItems" scope="end" />
<%
	/***************add by tangsong 20110614 ���ѡ���������� end******************/

	/***************add by tangsong 201106014 ����ֹ������������� start******************/
	String inputCommentItemsSql = "select t.comment_name from dqcinputcomment t"
											+ " where t.object_id=:object_id and t.valid_flag='Y'"
											+ " order by t.comment_id";
	myParams = "object_id=" + object_id;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:param value="<%=inputCommentItemsSql%>" />
		<wtc:param value="<%=myParams%>" />
	</wtc:service>
	<wtc:array id="inputCommentItems" scope="end" />
<%
	/***************add by tangsong 201106014 ����ֹ������������� start******************/
%>

<div id="Operation_Table" style="width:100%;">
	<div class="title"><div id="title_zi">��Ч����</div></div>
	<table  cellspacing="0">
		<tr>
	<%
		for (int i = 0; i < chooseCommentItems.length; i++) {
	%>
			<th style="font-weight:bold"><%=chooseCommentItems[i][0]%></th>
	<%
		}
	%>
		</tr>
		<tr>
	<%
		for (int i = 0; i < chooseCommentItems.length; i++) {
	%>
			<td><%=dqcComments[0][i+1]==null?"":dqcComments[0][i+1]%></td>
	<%
		}
	%>
		</tr>
	</table>
</div>

<%
	for (int i = 0; i < inputCommentItems.length; i++) {
%>
<div id="Operation_Table" style="width:100%;">
	<div class="title"><div id="title_zi"><%=inputCommentItems[i][0]%></div></div>
	<table  cellspacing="0">
	<tr >
		<td><%=dqcComments[0][i+11]==null?"":dqcComments[0][i+11]%></td>
	</tr>
	</table>
</div>
<%
	}
%>

<div id="Operation_Table" style="width:100%;">
	<div class="title"><div id="title_zi">��Ŀ������Ϣ</div></div>
		<input type="hidden" name="page" value="">
		<input type="hidden" name="myaction" value="">
		<input type="hidden" name="sqlFilter" value="">
		<table  cellSpacing="0" >
			<tr >
				<th align="center" class="blue" width="25%" > ������Ŀ </th>
				<th align="center" class="blue" width="10%" > ��ʽ </th>
				<th align="center" class="blue" width="10%" > Ȩ�� </th>
				<th align="center" class="blue" width="15%" > �÷� </th>
				<th align="center" class="blue"> ���� </th>
			</tr>

<%
	for ( int i = 0; i < detailItemList.length; i++ ) {
		String[][] tempList = (String[][])detailItemSubList.get(i);
		String tmpIsScore = (detailItemList[i][4].length()!=0)?detailItemList[i][4]:"N";
		String tmpItemScore = "0";
		if("Y".equals(tmpIsScore)){
			if(tempList!=null && tempList.length>0){
				tmpItemScore = (tempList[0][3].length()!=0)?tempList[0][3]:"0";
			}
		}
		String tdClass="";
		if((i+1)%2==1){
			tdClass="grey";
		}
%>
			<tr>
				<td align="left" class="<%=tdClass%>"  ><%=(detailItemList[i][0].length()!=0)?detailItemList[i][0]:"&nbsp;"%></td>
				<td align="center" class="<%=tdClass%>"  ><%=(detailItemList[i][1].length()!=0)?detailItemList[i][1]:"&nbsp;"%></td>
				<td align="center" class="<%=tdClass%>"  >&nbsp;</td>
				<td align="center" class="<%=tdClass%>"  >&nbsp;</td>
				<td align="center" class="<%=tdClass%>"  ></td>
			</tr>
<%
		if("N".equals(tmpIsScore)){
			for(int j=0;j<tempList.length;j++){
%>
			<tr>
				<td align="left" class="<%=tdClass%>"  >&nbsp;&nbsp;<%=(tempList[j][0].length()!=0)?tempList[j][0]:"&nbsp;"%></td>
				<td align="center" class="<%=tdClass%>"  ><%=(tempList[j][1].length()!=0)?tempList[j][1]:"&nbsp;"%></td>
				<td align="center" class="<%=tdClass%>"  ><%=(tempList[j][2].length()!=0)?tempList[j][2]:"&nbsp;"%></td>
				<td align="center" class="<%=tdClass%>"  ><%=(tempList[j][3].length()!=0)?tempList[j][3]:"&nbsp;"%></td>
				<td align="center" class="<%=tdClass%>"  ><%=(tempList[j][6].length()!=0)?tempList[j][6]:"&nbsp;"%></td>
			</tr>
<%
			}
		}
	}
%>
  </table>
</div>

<div id="Operation_Table" style="width:100%;">
	<div class="title"><div id="title_zi">������֤��Ϣ</div></div>
	<table  cellspacing="0">
		<tr >
			<td><%=isPwdVer.equals("��")? "������֤" : "��֤"%></td>
		</tr>
  </table>
</div>
<br>
<div id="Operation_Table" style="width:100%;">
	<input name="search" type="button"  id="search" value="����" onClick="javascript:window.close()"> &nbsp;&nbsp;
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>