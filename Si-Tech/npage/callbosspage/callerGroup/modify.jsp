<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
String id=request.getParameter("id");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String params = "id="+id;
String sqltotal="SELECT c.caller_call_out_id,c.Caller_Call_Out_Phone,c.classid,s.class_name,c.Region_Code,c.Region_Code||'-->'||r.Region_Name,c.Note,c.outflag FROM Dcallercalloutphone c ,scallclass s ,scallregioncode r WHERE s.Class_Id = c.Classid AND c.Region_Code = r.Region_Code  AND c.Caller_Call_Out_Id = :id" ;


%>

<wtc:service name="TlsPubSelCrm" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sqltotal%>"/>
		<wtc:param value="<%=params%>"/>
</wtc:service>
<wtc:array id="totalPlan" start="0" length="8" scope="end"/>	
<html>
<head>
<title>��������Ӧ��ϵ</title>
<style>
.content_02
{
	font-size:12px;
}
#tabtit
{
	height:23px;
	padding:0px 0 0 12px;
} 
#tabtit ul
{
	height:23px;
	position:absolute;
} 
#tabtit ul li
{
	float:left;
	margin-right:2px;
	display:inline;
	text-align:center;
	padding-top:7px;
	cursor:pointer;
	height:22px;
	width:100px;
}
#tabtit .normaltab
{
	color:#3161b1;
	background:url(../../../../nresources/default/images/callimage/tab_bj_02.gif) no-repeat left top;
	height:23px;
}
#tabtit .hovertab 
{ 
	color:#3161b1;
	background:url(../../../../nresources/default/images/callimage/tab_bj_01.gif) no-repeat left top;
	height:24px;
}
.dis
{
	display:block;
	border-top:1px solid #6c90ca;
	background:#fff url(../../../../nresources/default/images/callimage/tab_cont.gif) repeat-x 0px 0px;
	padding:8px 12px;
}
.undis
{
	display:none;
}
.content_02 .dis li
{
	line-height:1.8em;
	padding-left:12px;
}
</style>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<%! 
		/** 
		 ����˵��: ����һ��������sql.Ȼ��ҳ�����ģʽ��  [�����_=_�ֶ���] ��  [�����_like_�ֶ���]
		 ����columnΪ��ѯ�ֶ�.��һλ�������.����Ų����ظ�.�ظ����������һ��ֵ.�ұ���������.��С������1,11,123.
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
	//	System.out.println("~~~~~~~~~~~~~" + objs[0]);
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
   String start_date=totalPlan[0][1];
    String end_date=totalPlan[0][2];
%>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script>

function doProcessAddQcContent(packet)
{
	   var retType = packet.data.findValueByName("retType");
	   var retCode = packet.data.findValueByName("retCode");
	   var retMsg = packet.data.findValueByName("retMsg");
   		if(retCode=="000000"){
    			rdShowMessageDialog("�޸ĳɹ�",'2');
    			window.sitechform.action="list.jsp";
          window.sitechform.method='post';
          document.sitechform.submit();
	   	}else{
	   		rdShowMessageDialog("�޸�ʧ��");
	   		return false;
	   	}   

}
 
  function submitInputCheck(){
   if( document.sitechform.phone.value == ""){
    	   showTip(document.sitechform.phone,"�������벻��Ϊ��"); 
    	   sitechform.phone.focus(); 	
    	 return false;
    }
    if(isNaN(document.sitechform.phone.value)){
    		showTip(document.sitechform.phone,"��������ֻ��������"); 
    	   sitechform.phone.focus(); 	
    	   return false;
    	}
     if(document.sitechform.class_id.value == ""){
		     showTip(document.sitechform.class_id,"��ѡ�����"); 
    	   sitechform.class_id.focus(); 	
    	   return false;
    }
    submitQcContent();
    	
}
  
function submitQcContent()
{
	

	
  var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/callerGroup/update.jsp","���Ժ�...");

   
       //��ҳ����

 var id = document.getElementById("id").value;
 var phone = document.getElementById("phone").value;
 var class_id = document.getElementById("class_id").value;
 var Region_Code = document.getElementById("Region_Code").value;
 var note = document.getElementById("note").value;
 var outflag = document.getElementById("outflag").value;
 
 chkPacket.data.add("id", id);
 chkPacket.data.add("phone", phone);
 chkPacket.data.add("class_id", class_id);
 chkPacket.data.add("Region_Code", Region_Code);
 chkPacket.data.add("note", note);
 chkPacket.data.add("outflag", outflag);

    core.ajax.sendPacket(chkPacket,doProcessAddQcContent,true);
	  chkPacket =null;
}
	
	
	
	function g(o)
{
	return document.getElementById(o);
}

function HoverLi(n){
	for(var i=1;i<=2;i++)
	{
		g('tb_'+i).className='normaltab';
		g('tbc_0'+i).className='undis';
	}
	g('tbc_0'+n).className='dis';
	g('tb_'+n).className='hovertab';
}
</script>

</head>
<body>

<form  name="sitechform" id="sitechform">




<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B>��������Ӧ��ϵ</B></div>
    <div id="Operation_Table">
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    	
    	<input type="hidden" name="id" value="<%=totalPlan[0][0]%>">
      <tr>
      	<td width="15%" class="blue">��������</td>
        <td width="15%">
        <input name ="phone" value="<%=totalPlan[0][1]%>" type="text" id="phone" size='22' maxlength='20'>
        	</select> 
        </td>
        <td width=15% class="blue">����</td>
        <td width="20%">  
       	
        	<select id="class_id" name="class_id" >
         	 <option value="">--��ѡ��--</option>
         	 
         	 		<option value="<%=totalPlan[0][2]%>" selected >
      	 				<%=totalPlan[0][2]%>--><%=totalPlan[0][3]%>
      	 			</option>
         	 
          <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>SELECT class_id,class_id||'-->'||class_name FROM scallclass ORDER BY class_id</wtc:sql>
				  </wtc:qoption>
        	</select>
        </td>
        
         <td width=15% class="blue">����</td>
        <td width="20%">  
			 <select id="Region_Code" name="Region_Code" size="1" >
      	<option value="" >--���е���--</option>
      	
      	 	 		<option value="<%=totalPlan[0][4]%>" selected >
      	 				<%=totalPlan[0][5]%>
      	 			</option>
      	
				    <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
				    <wtc:sql>select Region_Code , region_code|| '-->' ||region_name from scallregioncode where valid_flag = 'Y'order by region_code</wtc:sql>
				  </wtc:qoption>
        </select>    
        </td>
      </tr>
       
             <tr>
      	<td width="16%" class="blue">��ע</td>
        <td width="34%" colspan='5'>
        <input name="note"  id="note" type="text" size='52' maxlength='50' value="<%=totalPlan[0][6]%>" >  
        </td>

     </tr>
     
      		  <tr>
        <td class="blue" >��������</td>
        <td colspan = '5'> 
			 <select id="outflag" name="outflag" size="1" >
      	 	 		<option value="<%=totalPlan[0][7]%>" selected >
      	 				<%=(totalPlan[0][7].equals("Y"))?"��������":"�������"%>
      	 			</option>
      	 			
      	 			
      	 			        <option value="N" >-- ������� --</option>			 	
      	<option value="Y" >-- �������� --</option>
        </select>
        </td>  
      </tr>
      </table>


  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    	<tr>
         <td width="100%">  
        &nbsp;
         </td>
 			</tr>   	
   </table>
   

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_foot" name="submita" type="button" value="ȷ��" onclick="submitInputCheck()">
        	<input class="b_foot" name="reset1" type="button"  onclick="window.close()" value="�˳�">
        </td>
       </tr>  
     </table>
    </div>
    <br/>          
    </td>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
  </tr>
        
  <tr>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
    <td valign="bottom">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
      <tr>
        <td height="1"></td>
      </tr>
    </table>
    </td>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
  </tr>
</table>

</div>

</form>
</body>
</html>
 





