<%
   /*
    * ����: �������۱����ѯ
�� * �汾: 1.0
�� * ����: 2008/11/10
�� * ����: hanjc
�� * ��Ȩ: sitech
    *  upd :
    *          mixh  2009/03/27
    *          1�����Ȩ��У��
    *
 ��*/
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>

<%
	String opCode="K216";
	String opName="�ʼ��ѯ-���˷������۱����ѯ";
%>

<%!
	/**
	   *����˵��: ����һ��������sql.Ȼ��ҳ�����ģʽ��  [�����_=_�ֶ���] ��  [�����_like_�ֶ���]
	   *����columnΪ��ѯ�ֶ�.��һλ�������.����Ų����ظ�.�ظ����������һ��ֵ.�ұ���������.��С������1,11,123.
	 */
    public String returnSql(HttpServletRequest request){
    		StringBuffer buffer = new StringBuffer();

		//�������.
		Map map = request.getParameterMap();
		Object[] objNames = map.keySet().toArray();
		Map temp = new HashMap();
		String name="";
		String[] names= new String[0];
		String value="";
		//���������������.key������.�����ֽ�������.value�������object�����ֵ.
		for (int i = 0; i < objNames.length; i++) {
			name = objNames[i] == null ? "" : objNames[i]
			.toString();
			//String name
			names = name.split("_");
			//��name����'_'�ֳ�3������.
			if (names.length >= 3) {
			//������ܷ�˵�����ֲ��Ϸ�.̫�����ֲ���.
		    value = request.getParameter(name);
		//�������ֵõ�value
		if (value.trim().equals("")) {
			//���value��""����.
			continue;
		}
		Object[] objs = new Object[3];
		objs[0] = names[1];
		//���� ��һ���ַ���.��like ���� =
		name = name.substring(name.indexOf("_") + 1);
		name = name.substring(name.indexOf("_") + 1);
		//��ط������ݿ���ֶδ���.������'_'�Ժ�Ķ������ݿ��ֶ���.
		objs[1] = name;
		//�ڶ����ַ���.��ѯ����.
		objs[2] = value;
		//������.��ѯ��ֵ.
		try {
			temp.put(Integer.valueOf(names[0]), objs);
			//����ط��ǽ��ַ���ת��������.Ȼ���������.����19Ҫ��2֮��.
		} catch (Exception e) {

		}
		//������������key����,ojbs����ŵ�value����.
			}
		}
		Object[] objNos = temp.keySet().toArray();
		//�õ�һ�����������.
		Arrays.sort(objNos);
		//�����ֽ�������.
		for (int i = 0; i < objNos.length; i++) {
			Object[] objs = null;
			objs = (Object[]) temp.get(objNos[i]);
			//�����like �� = �ֱ���.
			if (objs[0].toString().toLowerCase().equalsIgnoreCase(
			"like")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " '%%"
				+ objs[2].toString().trim() + "%%' ");
			}
			if (objs[0].toString().equalsIgnoreCase("=")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " '"
				+ objs[2].toString().trim() + "' ");
			}
		}

        return buffer.toString();
}

	public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}

%>

<%

	String loginNo = (String)session.getAttribute("kfWorkNo");
	String orgCode = (String)session.getAttribute("orgCode");

	String start_date     =  request.getParameter("start_date");
	String end_date       =  request.getParameter("end_date");
	String staffno          =  request.getParameter("staffno");
	String isCheckLogin  = "N";								//�Ƿ���Ȩ�޲鿴����ҵ�����ķ������۱���("Y"�У�"N"��)
	String bossLoginNo  = "";

	/*ȡ��ǰ��½���ŵĽ�ɫID��Ϊ���ŷָ���ַ��� mixh add 20090327*/
	String  powerCode = (String)session.getAttribute("powerCodekf");
	String[]  powerCodeArr = powerCode.split(",");

	
	/*
	 *�Ƿ����ʼ�Ա ���Ի�����[0100020I] ����������[01120O0E]��   ����ʱ��һ��
	 *�Ƿ��Ǹ���Ա ���Ի�����[0100020K] ����������[01120O0B]��   ����ʱ��һ��
	 *�Ƿ����ʼ��鳤 ���Ի�����[0100020J] ����������[01120O0C]������ʱ��һ��
	 *
	 */
			for(int i = 0; i < powerCodeArr.length; i++){
				for(int j=0; j<ZHIJIANYUAN_ID.length; j++) {
					if(ZHIJIANYUAN_ID[j].equals(powerCodeArr[i]) ||FUHEYUAN_ID.equals(powerCodeArr[i])){
							isCheckLogin="Y";	
					}
				}
				for(int k=0; k<ZHIJIANZUZHANG_ID.length; k++){
					if(ZHIJIANZUZHANG_ID[k].equals(powerCodeArr[i])) {
						isCheckLogin="Y";
					}
				}
			}
%>

<%
    float totalScore = 0;//�ܷ�
    float temp = 0;//�м����
    float fullScore = 0;// ����
    float integratedScore = 0;//�ۺϵ÷֣�Ĭ��Ϊ����
    
    if(staffno==null || "".equals(staffno)){
      	staffno =  request.getParameter("1_=_t1.staffno");
    }
    String objectid      =  request.getParameter("objectid");
    
    if(objectid==null || "".equals(objectid)){
      	objectid =  request.getParameter("0_str_t1.object_id");
    }
    String objectTypeName =  request.getParameter("objectTypeName");

	 	String sqlStr = "select "
                +"t1.recordernum,   " //������ˮ��
                +"decode(t1.checktype,'0','ʵʱ����','1','�º���'),   " //�������
                +"decode(substr(to_char(trim(t1.score)),0,1),'.','0'||trim(t1.score),t1.score),       " //�÷�
                +"t1.objectid,t1.contentid,t1.serialnum "
                +"from dqcinfo t1 ";
    String strJoinSql=" and t1.is_del != 'Y' and t1.objectid='"+objectid+"' and  t1.flag<>'0' and t1.flag<>'4' ";
    
    if(staffno!=null || !"".equals(staffno)&&!"Y".equals(isCheckLogin)){
      	strJoinSql+="and t1.staffno='"+staffno+"' ";
    }
		String strDateSql="";
    String sqlLogin="";
    //�ǻ���Ա���Բ鿴���еķ������۱���Ϣ
    if("Y".equals(isCheckLogin)){

    }else if("N".equals(isCheckLogin)){
    		sqlLogin=" and t1.staffno='"+loginNo+"' ";
  	}

    String[][] dataRows = new String[][]{};
    String action = request.getParameter("myaction");
	  String sqlFilter = request.getParameter("sqlFilter");

	 //��ѯ����
   if(sqlFilter==null || sqlFilter.trim().length()==0){
			if(start_date!=null&&!start_date.trim().equals("")&&end_date!=null&&!end_date.trim().equals("")){
					strDateSql=" where 1=1 and  to_char(t1.starttime,'yyyymmdd hh24:mi:ss')>='"+start_date.trim()+"' and to_char(t1.starttime,'yyyymmdd hh24:mi:ss')<='"+end_date.trim()+"' ";
			}
			sqlFilter=strDateSql+returnSql(request)+strJoinSql+sqlLogin+"and t1.group_flag='0' order by t1.starttime desc ";	//guozw20090907
   }
   String thSqlStr = "select t1.name,t1.object_id,t1.contect_id  from dqccheckcontect t1,dqcobject t2 where t1.object_id='"+objectid+"' and t1.object_id=t2.object_id  and t1.bak1='Y' and t2.bak1='Y' order by t1.object_id";
   %>
   <wtc:service name="s151Select" outnum="3">
			<wtc:param value="<%=thSqlStr%>"/>
	 </wtc:service>
	<wtc:array id="contentName"  scope="end"/>

<%
    sqlStr+=sqlFilter;
%>
    <wtc:service name="s151Select" outnum="6">
				<wtc:param value="<%=sqlStr%>"/>
		</wtc:service>
		<wtc:array id="queryList" scope="end"/>
<%
		dataRows = queryList;
%>
<%
String content_id = "";
if(dataRows!=null&&!("".equals(dataRows))&&dataRows.length>0){
	 content_id = dataRows[0][4];
	 String getHighScoreSql = "select sum(high_score) from dqccheckitem " +
                          	"where object_id='" + objectid +
                          	"' and contect_id='" + content_id +
                          	"' and is_leaf='Y' and is_scored='Y' and bak1='Y' ";
%>
<wtc:service name="s151Select" outnum="3">
		<wtc:param value="<%=getHighScoreSql%>"/>
</wtc:service>
<wtc:array id="sumHighScore" scope="end"/>
<%
	if(sumHighScore!=null&&!("".equals(sumHighScore))){
			fullScore = Integer.parseInt(sumHighScore[0][0]);
			integratedScore = fullScore;
	}
}
%>
<html>
<head>
<title>�������۱����ѯ</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
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

function submitInputCheck(){
   if( document.sitechform.start_date.value == ""){
    	   showTip(document.sitechform.start_date,"��ʼʱ�䲻��Ϊ��");
    	   sitechform.start_date.focus();

    }else if(document.sitechform.end_date.value == ""){
		     showTip(document.sitechform.end_date,"����ʱ�䲻��Ϊ��");
    	   sitechform.end_date.focus();

    }else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
		     showTip(document.sitechform.end_date,"����ʱ�������ڿ�ʼʱ��");
    	   sitechform.end_date.focus();

    }else if(document.sitechform.objectTypeName.value==""){
		     showTip(document.sitechform.objectTypeName,"���������Ϊ�գ�");
    	   sitechform.objectTypeName.focus();

    }else if(document.sitechform.staffno.value==""){
		     showTip(document.sitechform.staffno,"���칤�Ų���Ϊ�գ�");
    	   sitechform.staffno.focus();

    }else{
    hiddenTip(document.sitechform.start_date);
    hiddenTip(document.sitechform.end_date);
    hiddenTip(document.sitechform.objectTypeName);
    hiddenTip(document.sitechform.staffno);
    window.sitechform.sqlFilter.value="";//����ѱ����sqlFilter��ֵ
    submitMe();
    	}
}

function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K216_repDetailQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
}

//�������¼
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
  if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
  	if(e[i].id=="start_date"){
	  	e[i].value='<%=getCurrDateStr("00:00:00")%>';
	  }else if(e[i].id=="end_date"){
	  	e[i].value='<%=getCurrDateStr("23:59:59")%>';
	  }else{
	  	e[i].value="";
	  }
  }else if(e[i].type=="checkbox"){
  	e[i].checked=false;
  }
 }
 document.getElementById("groupflag").value = "0";	//����Ϊ0
}

function keepValue(){
	  window.sitechform.sqlFilter.value="<%=sqlFilter%>";
    window.sitechform.start_date.value="<%=start_date%>";
    window.sitechform.end_date.value="<%=end_date%>";
    window.sitechform.objectTypeName.value="<%=objectTypeName%>";
    window.sitechform.objectid.value="<%=objectid%>";
    window.sitechform.staffno.value="<%=staffno%>";
}

//�������
function showObjectCheckTree(){
   var path= 'K204_objectIdTree.jsp';
   var param  = 'dialogWidth=300px;dialogHeight=250px';
   var returnValue = window.showModalDialog(path,'ѡ���ʼ�Ⱥ��',param);

	if(typeof(returnValue) != "undefined"){
		 var objectid = document.getElementById("objectid");
		 var objectTypeName   = document.getElementById("objectTypeName");
		 var temp = returnValue.split('_');
		 objectid.value = trim(temp[0]);
		 objectTypeName.value = trim(temp[1]);
	 }
}

//��ʾ�ʼ�����ϸ��Ϣ
function getQcDetail(contact_id){
		var path="../K211/K211_getResultDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
 	  window.showModalDialog(path,'�ʼ�������',param);
		return true;
}

function openWinMid(url,name,iHeight,iWidth){
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

//ȥ��ո�;
function ltrim(s){
  	return s.replace( /^\s*/, "");
}
//ȥ�ҿո�;
function rtrim(s){
		return s.replace( /\s*$/, "");
}
//ȥ���ҿո�;
function trim(s){
		return rtrim(ltrim(s));
}

</script>
</head>
<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table" style="width:100%;"><!-- guozw20090828 -->
		<div class="title"><div id="title_zi">�������۱����ѯ</div></div>
		<table cellspacing="0" style="width:100%;">
    <!-- THE FIRST LINE OF THE CONTENT -->
     <tr >
      <td > ��ʼʱ�� </td>
      <td >
				<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > ����ʱ�� </td>
      <td >
			  <input id="end_date" name ="end_date" type="text"   value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
    </tr>
    <!-- THE SECOND LINE OF THE CONTENT -->
    <tr >
		  <td > ������� </td>
      <td >
			 	<input id="objectTypeName" name ="objectTypeName" size="20" type="text" onclick="showObjectCheckTree(0);" value="<%=(objectTypeName==null)?"":objectTypeName%>" >
  			<input id="objectid" name ="0_str_t1.object_id" size="20"  type="hidden" value="<%=(objectid==null)?"":objectid%>">
		    <img onclick="showObjectCheckTree(0)" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
		 <td > ���칤�� </td>
      <td >
			  <input name ="1_=_t1.staffno" type="text" id="staffno"  maxlength="10" value="<%=(staffno==null)?"":staffno%>">
			  <font color="orange">*</font>
			  <!-- ������0��������1 -->
			  <input name ="2_=_t1.group_flag" type="hidden" id="groupflag" value="0">
      </td>
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="4" align="left" id="footer" style="width:420px">
        <input name="delete_value" type="button"  id="add" value="����" onClick="clearValue();return false;">&nbsp;&nbsp;&nbsp;&nbsp;
        <input name="search" type="button"  id="search" value="��ʼ��ѯ" onClick="submitInputCheck();return false;">
      </td>
    </tr>
		</table>
	</div>
	<%
      if(dataRows==null||"".equals(dataRows)||dataRows.length<1){
  %>
  <div id="Operation_Table" style="width:100%;"><!-- guozw20090828 -->
     <table cellspacing="0" style="width:100%;">
     		<input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
     	 <tr><th align="center" class="blue" width="100%" colspan="2"> <%=(staffno==null)?"":staffno%>�������۱��� </th></tr>
     	<%
	    if("Y".equals(isCheckLogin)){
	    %>
	     <tr><td align="center">�����������ķ������۱���!</td></tr>
	    <%
	   	}else{
	   %>
	   	<tr><td align="center">��û��Ȩ�޲鿴�ù��ŷ������۱���!</td></tr>
	   <%
	   }
	   %>
   	</table>
  </div>
   <%
    }else{
   %>
  <div id="Operation_Table" style="width:100%;"><!-- guozw20090828 -->
      <table cellspacing="0">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <tr><th align="center" class="blue" width="100%" colspan="2"> <%=(staffno==null)?"":staffno%>�������۱��� </th></tr>
          <tr >
            <th align="center" class="blue" width="10%" > �������� </th>
            <th align="center" class="blue" width="10%" > ָ������� </th>
          </tr>

          <% for ( int i = 0; i < contentName.length; i++ ) {
                String tdClass="";
           %>
          <%if((i+1)%2==1){
          tdClass="grey";
          %>
          <tr>
		<%
			}else{
		%>
	   <tr  >
	<%}%>
      <td align="center" class="<%=tdClass%>"><%=(contentName[i][0].length()!=0)?contentName[i][0]:"&nbsp;"%></td>
      <td style="margin:0px;padding:0px">
        	<table style="width:100%;height:100%;" cellspacing="0" >
          <tr >
            <th align="left" class="blue" width="40%" > ������ˮ�� </th>
            <th align="left" class="blue" width="40%" > ������� </th>
            <th align="center" class="blue" width="12%" > �÷� </th>
          </tr>
           <% for(int j = 0; j < dataRows.length;j++ ) {
              if(dataRows[j][3].equals(contentName[i][1])&&dataRows[j][4].equals(contentName[i][2])){
                temp = Float.parseFloat((dataRows[j][2].length()!=0)?dataRows[j][2]:"0");
           	    totalScore+=temp;
           	    integratedScore = integratedScore-(fullScore-temp);
            %>
           <tr >
           <td align="left" onClick="getQcDetail('<%=dataRows[j][5]%>')" style="cursor:hand" class="<%=tdClass%>"  ><%=(dataRows[j][0].length()!=0)?dataRows[j][0]:"&nbsp;"%></td>
           <td align="left" class="<%=tdClass%>"  ><%=(dataRows[j][1].length()!=0)?dataRows[j][1]:"&nbsp;"%></td>
           <td align="right" class="<%=tdClass%>"  ><%=(dataRows[j][2].length()!=0)?dataRows[j][2]:"&nbsp;"%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          </tr>
        <%}}%>
       	</table>
      </td>
    </tr>
      <% } %>
   <tr >
     <td align="left" style="background:pink" width="30%" > �ۺϵ÷� </th>
     <%
     		//��floatֵΪ����ʱ������ȥ��С��������".0"  ��98.0���õ�Ϊ98
				String lastIntegratedScore = "";
				String tmpIntegratedScore =  Float.toString(integratedScore);
				//���������Ϊ��ֵ��ȥ��".0"
				if(tmpIntegratedScore.endsWith(".0")){
					lastIntegratedScore = tmpIntegratedScore.substring(0,tmpIntegratedScore.length()-2);

				}else{
					lastIntegratedScore = tmpIntegratedScore;
				}
     %>
   	 <td align="right" style="background:pink" width="70%" > <%=lastIntegratedScore%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
   </tr>
  </table>
</div>
<%}%>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>