<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: ��ʾ��ͨ����ϸ��Ϣ
�� * �汾: 1.0
�� * ����: 2008/10/20
�� * ����: hanjc
�� * ��Ȩ: sitech
   *
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.* ,java.text.SimpleDateFormat,java.util.*"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>


<%
    String opCode="k170";
    String opName="�ۺϲ�ѯ-������Ϣ-��ʾ��ͨ����ϸ��Ϣ";
	  String loginNo = (String)session.getAttribute("workNo");
	  String orgCode = (String)session.getAttribute("orgCode");
 		String regionCode = orgCode.substring(0,2);
    String beginTime="";
    String endTime="";
    String callerPhone="";
    String contact_id   = request.getParameter("contact_id");            //���͹���
    String myParams2 = "";
    String contactId_kf=contact_id.substring(0,6);
    String start_date   = request.getParameter("start_date");
    String[][] dataRows = new String[][]{};
    String[][] dataList = new String[][]{};
    String[][] msgList = new String[][]{};
    String[][] ivrdataRows = new String[][]{};
    String[][] innerHelpdataRows = new String[][]{};
    String tableName = request.getParameter("tableName");
    String action = request.getParameter("myaction");
    //System.out.println("==== lipf ==== k170_getCallDetail.jsp == start_date === "+start_date+"  ==contact_id== "+contact_id);
    String phone_no="";
    HashMap hashMap =new HashMap();
		if(start_date!=null){
			tableName=start_date.substring(0,6);
		}
     hashMap.put("tableName",tableName);
		 hashMap.put("contact_id",contact_id);
    if ("doLoad".equals(action) || contact_id!=null) {
        List iDataList1 =(List)KFEjbClient.queryForList("query_K170_detail_sqlStr",hashMap);
		    dataRows = getArrayFromListMap(iDataList1 ,0,26);
		    List iDataList2 =(List)KFEjbClient.queryForList("query_K170_toivr_strSql",hashMap);
		    ivrdataRows = getArrayFromListMap(iDataList2 ,0,4);
		    List iDataList3 =(List)KFEjbClient.queryForList("query_K170_transfer_strSql",hashMap);
		    innerHelpdataRows = getArrayFromListMap(iDataList3 ,0,4);
		}
		//System.out.println("==== lipf ==== k170_getCallDetail.jsp == dataRows === "+dataRows.length+"== ivrdataRows === "+ivrdataRows.length+"== innerHelpdataRows === "+innerHelpdataRows.length+" == hashMap== "+hashMap);
		//add by sunbya 20120326 ����и߶˱�ʶ begin--
		phone_no=dataRows[0][5];
		List lsMidHigh = (List)KFEjbClient.queryForList("selectPublic", "select count(t.phone_no)as total from dbcalladm.dcallmidhighcustphone t where t.phone_no = '"+phone_no+"'" );
	  Map mapMidHigh = (HashMap)lsMidHigh.get(0);  
	  String strMidHighFlag = new String();
	  strMidHighFlag = (String)mapMidHigh.get("TOTAL").toString();
	  if( strMidHighFlag.toString().equals("0") )
	  {
	      strMidHighFlag = "��";
	  }
	  else
	  {
	      strMidHighFlag = "��";
	  } 
	  //--end
%>

<%
	String kh_brand_sql="select sm_code from dcallcall"+contactId_kf+" t where t.contact_id=:contact_id";
	myParams2 = "contact_id=" + contact_id;
	
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

<title>��ʾ��ͨ����ϸ��Ϣ</title>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("Blue");
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

//add by lipf 20120702 �����°�֪ʶ����ʷ��� begin
function clicklink(knowledgeId) {
	var pathhead = "http://10.110.45.10/csp/kbs/showKng.action?kngId=";
	var pathend="&kngTblFlag=0&relativeKngFlag=true&buttonFlag=true&articleFlag=true&showType=1&clickingLogFlag=1&channelId=0";						
	var features = "titlebar=no,resizable=yes";
	//�������
	window.open(pathhead+knowledgeId+pathend,"_blank",features);
}
//add by lipf 20120702 �����°�֪ʶ����ʷ��� end
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body >
<iframe src="/npage/login/ssouse.jsp" style="display:none" width="100" height="100"></iframe>
<form id=sitechform name=sitechform>
<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<!--updated by tangsong 20100830 ����ʽ������
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	-->
	<td valign="top">
	<div id="Operation_Title" ><B>ͨ����ϸ��Ϣ</B></div>
    <div id="Operation_Table" >
		<div class="title" id="footer" style="width: 100%;padding-left:0px;">
 		<span style="color:#31318C">��ˮ��&nbsp;</span><input name="contact_id" type="text"  id="contact_id" value="<%=contact_id%>" >
   <input name="search" type="button"  id="search" value="��ѯ" onClick="submitInput('k170_getCallDetail.jsp?myaction=doLoad')"> &nbsp;&nbsp;
   <input name="clear" type="button"  id="clear" value="�ر�" onClick="closeWin()">
   <input name="tableName" type="hidden" value="<%=tableName%>">
</div>

<br>
	<div id="Operation_Table">
		<div class="title" style="color:#31318C">������Ϣ</div>
		<table cellspacing="0">
    <!-- THE FIRST LINE OF THE CONTENT -->
      <tr >
	     <td > ��ˮ�� </td>
	     <td ><%=(dataRows.length!=0)? dataRows[0][0]:"&nbsp;"%>&nbsp;</td>
	     <td > ����ʱ�� </td>
	     <td ><%=(dataRows.length!=0)? dataRows[0][1]:"&nbsp; "%>&nbsp;</td>
	     <td > ���к��� </td>
	     <td ><%=(dataRows.length!=0)? dataRows[0][2]:" &nbsp;"%>&nbsp;</td>
	     <%
	     beginTime=dataRows[0][1];
	    	SimpleDateFormat time=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	     try {
			Date date=time.parse(beginTime);
			date.setHours(date.getHours()-2);
			beginTime=time.format(date);
		       } catch (Exception e) {
			e.printStackTrace();
		      }
	     endTime=dataRows[0][1];
	     callerPhone=dataRows[0][2];
	     
	     %>
	     <td > ����ʽ </td>
	     <td ><%=(dataRows.length!=0)? dataRows[0][3]:" &nbsp;"%>&nbsp;</td>
	   </tr>
	   <!-- THE SECOND LINE OF THE CONTENT -->
	   <tr >
	     <td > �ͻ����� </td>
	     <td ><%=(dataRows.length!=0)? dataRows[0][4]:" &nbsp;"%>&nbsp;</td>
	     <td > ������� </td>
	     <td ><%=(dataRows.length!=0)? dataRows[0][5]:" &nbsp;"%>&nbsp;</td>
	     <td > ������ </td>
	     <td ><%=(dataRows.length!=0)? dataRows[0][9]:" &nbsp;"%>&nbsp;</td>
	     <td > �û����� </td>
	     <td ><%=(dataRows.length!=0)? dataRows[0][11]:" &nbsp;"%>&nbsp;</td>
	    </tr>

	  <!-- THE THIRD LINE OF THE CONTENT -->
	   <tr >
	     <!--<td > �ͻ����� </td>
	     <td ><%=(dataRows.length!=0)? dataRows[0][8]:" &nbsp;"%>&nbsp;</td>-->
	     
	     <!--<td>ҵ����� </td>
	     <td ><%=(dataRows.length!=0)? dataRows[0][10]:" &nbsp;"%>&nbsp;</td>-->
	     
	    </tr>

	   <!-- THE FOURTH LINE OF THE CONTENT -->
	   <!--add by sunbya 20120326 ����и߶˱�ʶ begin-->
	   <tr >
	   	 <td class="blue" style="color:#F00"   nowrap>�и߶˱�ʶ</td>
	     <td class="redcolor" style="color:#F00"   nowrap><%=strMidHighFlag%>&nbsp;</td>
	   <!--end-->
	     <td > ͨ��ʱ�� </td>
	     <td ><%=(dataRows.length!=0)? dataRows[0][12]:" &nbsp;"%>&nbsp;</td>
	     <td > ���к��� </td>
	     <td ><%=(dataRows.length!=0)? dataRows[0][15]:" &nbsp;"%>&nbsp;
	     </td>
	     <td>�һ���</td>
	     <td><%=(dataRows.length!=0 )?dataRows[0][24]:" &nbsp;"%>&nbsp;</td>
	     </td>
	    </tr>
	    <tr>
	    	<td>�ͻ�Ʒ��</td>
	    	<td><%=brand_name==null?" &nbsp; ":brand_name%></td>
	    	<td colspan="6">&nbsp; </td>
	    </tr>
		</table>

</div>

<!--���ܶ��� -->
<br>
		<div id="Operation_Table">
		<div class="title" style="color:#31318C">���ܶ���</div>
		<table cellspacing="0">
			<tr>
	     <td style="text-indent:0;padding-left:5px;"><%=(dataRows.length!=0)? dataRows[0][25]:" &nbsp;"%>&nbsp;</td>
	      </tr>
	  </table>
	</div>

<br>
		<div id="Operation_Table">
		<div class="title" style="color:#31318C">����ԭ��</div>
		<table cellspacing="0">
			<tr>
	     <td style="text-indent:0;padding-left:5px;"><%=(dataRows.length!=0 )? dataRows[0][20]:" &nbsp;"%></td>
	     <td>�����ˮ��</td>
	     <td><%=(dataRows.length!=0 )? dataRows[0][21]:" &nbsp;"%></td>
	    </tr>
	  </table>
	</div><br>
	
	<!--�ֳ���� -->
		<div id="Operation_Table">
		<div class="title" style="color:#31318C">�ֳ����</div>
		<table cellspacing="0">
			<%
		                  
			  List dcasemsgList =(List)KFEjbClient.queryForList("query_wf_dcasemsg",hashMap);
		    msgList = getArrayFromListMap(dcasemsgList ,0,1);
	     	if(msgList.length>0){
			  for(int i=0;i<msgList.length;i++){
			%>
			  <tr>
	      <td style="text-indent:0;padding-left:5px;"><%=(msgList.length!=0)? msgList[i][0]:" &nbsp;"%>&nbsp;</td>
	      </tr>
	      <%
	      }
	      }
	      %>
	      </table>
	   </div>
	   <div id="Operation_Table">
		<div class="title" style="color:#31318C">������¼</div>
	    <table cellspacing="0">
	    <%
	      //SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		    //Calendar c = Calendar.getInstance();
		    //String thisMonth = sdf.format(c.getTime()); //����
	
		    String thisMonth = dataRows[0][1].substring(0,4)+dataRows[0][1].substring(5,7);
	      String tablename="dcallcall"+thisMonth;
	      HashMap CallMap = new HashMap();
        CallMap.put("tablename",tablename);
        CallMap.put("begin_date",dataRows[0][1]);
        CallMap.put("accept_phone",dataRows[0][5]);
	      List callList =(List)KFEjbClient.queryForList("query_call_phone", CallMap);
	      if(callList!= null){
	      %>
	      <tr > 
	      	    <td >������ˮ��</td>
	      	    <td >����</td>
	      	    <td >����ʱ��</td>
	      </tr>
	      <%
	      for(int i = 0; i < callList.size(); i++){
	       Map callmap = (Map)callList.get(i);   
	    %>
	      <tr>
	      <td style="text-indent:0;padding-left:5px;"><%=callmap.get("CONTACT_ID")%></td>
	      <td style="text-indent:0;padding-left:5px;"><%=callmap.get("LOGIN")%></td>
	      <td style="text-indent:0;padding-left:5px;"><%=callmap.get("TIME")%></td>
	      </tr>
	    <%}
	    }%>  
	    </table>
	  </div>
<br>
	<div id="Operation_Table">
		<div class="title" style="color:#31318C">ת�Զ�����</div>
		<table cellspacing="0">
		<tr>
			<td style="width:20%">ת��ʱ��</td>
			<td style="width:10%">ת����</td>
			<td style="width:10%">ת�ӵ���</td>
			<td>ת�ӽڵ�</td>
		</tr>
		<%
			if(ivrdataRows.length>0){
			for(int i=0;i<ivrdataRows.length;i++){
			   //updated by tangsong 20110401 ���ͻ�Ҫ��IVRת�ӽڵ㻻����ʾ
				String ivrStr = "";
				if (ivrdataRows[i][2].length()!=0) {
					ivrStr = ivrdataRows[i][2].replaceAll("~", "<br />");
				}
		%>
		<tr>
	     <td ><%=(ivrdataRows[i][0].length()!=0)? ivrdataRows[i][0]:" &nbsp;"%>&nbsp;</td>
		 <td ><%=(ivrdataRows[i][1].length()!=0)? ivrdataRows[i][1]:" &nbsp;"%>&nbsp;</td>
		 	<td ><%=(ivrdataRows[i][3].length()!=0)? ivrdataRows[i][3]:" &nbsp;"%>&nbsp;</td>
		 	<td style="text-indent:0;padding-left:5px;"><%=ivrStr%></td>
	    </tr>

	    <%
	    }}
	    %>
	  </table>
	</div><br>

	<div id="Operation_Table">
		<table cellspacing="0">
				<div class="title" style="color:#31318C">���֪ʶ�б�</div>
    <tr >
<td width="40%" align="center">
֪ʶ����
</td>
</tr>
<%

String[] tablenames= new String[1];
HashMap knowledgehashMap = new HashMap();
//String start_time=start_date.substring(0,4)+start_date.substring(4,6);
//update by lipf 20120703 ֪ʶ�����¼��Ϊ�ӻ�Ϊ���޸� begin
String start_time=start_date.substring(2,6);
//tablenames[0]="1207";
//knowledgehashMap.put("contentId","2012070314570109069zD");
tablenames[0]=start_time;
knowledgehashMap.put("contentId",contact_id);
knowledgehashMap.put("tablenames",tablenames);
 //List knowledgeList =(List)KFEjbClient.queryForList("query_Info_clickknowledge",knowledgehashMap);
try{
	List knowledgeList =(List)KFEjbClient.queryForList("query_Info_clickknowledge_hw",knowledgehashMap);
//update by lipf 20120703 ֪ʶ�����¼��Ϊ�ӻ�Ϊ���޸� end
	if (knowledgeList != null) {                    
		for(int i = 0; i < knowledgeList.size(); i++){   
			Map knowledgemap = (Map)knowledgeList.get(i);    
%>    
<tr>			      
<td width="40%" align="center"><a href="#" onclick="clicklink('<%=knowledgemap.get("KNGID")%>');return false;"><%=knowledgemap.get("SRNAME")%></a></td>
</tr>       
 <%
  		}
	}
}catch(Exception e){
	
}
 %>
		</table>
	</div><br>



<div id="Operation_Table">
  	<div class="title" style="color:#31318C">�ڲ�������Ϣ</div>
			  <table  cellspacing="0">
		<%if(innerHelpdataRows.length>0){
		%>
			<tr><td>��������</td><td>����������</td><td>����ʱ��</td></tr>
		<%
			for(int i=0;i<innerHelpdataRows.length;i++){

		%>
		<tr>
	     <td ><%=(innerHelpdataRows[i][0].length()!=0)? innerHelpdataRows[i][0]:" &nbsp;"%>&nbsp;</td>
		 <td ><%=(innerHelpdataRows[i][1].length()!=0)? innerHelpdataRows[i][1]:" &nbsp;"%>&nbsp;</td>
		 <td ><%=(innerHelpdataRows[i][2].length()!=0)? innerHelpdataRows[i][2]:" &nbsp;"%>&nbsp;</td>
	    </tr>

	    <%
	    }
		}else{%>
    <tr >
			<td bgcolor="white">
				����ˮ��û�ж�Ӧ���ڲ�������Ϣ
			</td>
    </tr>
    <%}%>
  </table>
</div><br>
<!--��Сʱ�ڽӴ���־ -->
		<div id="Operation_Table">
		<div class="title" style="color:#31318C">��Сʱ�ڽӴ���־</div>
		<table cellspacing="0">
			<tr>
	     <td style="text-indent:0;padding-left:5px;">��ˮ��</td>
	     <td style="text-indent:0;padding-left:5px;">����</td>
	     <td style="text-indent:0;padding-left:5px;">ת��·��</td>
	     <td style="text-indent:0;padding-left:5px;">����ԭ��</td>
	    </tr>
	    <%
	      HashMap map =new HashMap();
	      map.put("tableName",tableName);
	      map.put("beginTime",beginTime);
	      map.put("endTime",endTime);
	      map.put("callerPhone",callerPhone);
	      List contentIdList =(List)KFEjbClient.queryForList("query_userDetailInfo_2call",map);
		    dataList = getArrayFromListMap(contentIdList ,0,4);
	     	if(dataList.length>0){
			for(int i=0;i<dataList.length;i++){
		%>
		<tr>
	     <td ><%=(dataList[i][0].length()!=0)? dataList[i][0]:" &nbsp;"%>&nbsp;</td>
		   <td ><%=(dataList[i][1].length()!=0)? dataList[i][1]:" &nbsp;"%>&nbsp;</td>
		   <td ><%=(dataList[i][2].length()!=0)? dataList[i][2]:" &nbsp;"%>&nbsp;</td>
	     <td ><%=(dataList[i][3].length()!=0)? dataList[i][3]:" &nbsp;"%>&nbsp;</td>   
	  </tr>
	    <%
	    }}
	    %>
	  </table>
	</div>
	<br>
<div id="Operation_Table">
	<div class="title" style="color:#31318C">������֤��Ϣ</div>
	<table>
	  <tr>
	  	<td style="width:20%">�Ƿ�������֤</td>
	  	<td style="width:20%">�Ƿ�������֤</td>
	  	<td>&nbsp;</td>
		</tr>
	  <tr>
	  	<td><%=dataRows[0][22]%></td>
	  	<td><%=dataRows[0][23]%></td>
	  	<td>&nbsp;</td>
		</tr>
	</table>
</div>
<br/>
<div id="Operation_Table" >
		<div class="title" style="color:#31318C">�Ӽ���ϯ��ʶ</div>
		<table cellspacing="0">
	    <%
	      List homeflagList =(List)KFEjbClient.queryForList("querycallhomeflag",contact_id);
	      if(homeflagList!=null){
		     	 String[][] commnendArray = getArrayFromListMap(homeflagList ,0,6);
		     	 String isJuJia = Integer.parseInt(commnendArray[0][0])==1?"��":"��";
		     	 out.println("<tr><td>"+isJuJia+"</td></tr>");
  
		    }
	    %>
	  </table>
</div>
<br>
	<div id="Operation_Table">
		<div class="title" style="color:red">�����������Ƽ�</div>
		<table cellspacing="0">
			<tr>
	     <td style="text-indent:0;padding-left:5px;">��ˮ��</td>
	     <td style="text-indent:0;padding-left:5px;">�绰����</td>
	     <td style="text-indent:0;padding-left:5px;">����ԭ��</td>
	     <td style="text-indent:0;padding-left:5px;">����</td>
	     <td style="text-indent:0;padding-left:5px;">����ʱ��</td>
	    </tr>
	    <%
	      List commnendList =(List)KFEjbClient.queryForList("query_inf_commendinfo",contact_id);
	      if(commnendList!=null){
		     	 String[][] commnendArray = getArrayFromListMap(commnendList ,0,6);
		     	 if(commnendArray!=null)
		     	 {
			     	 if(commnendArray.length>0)
			     	 {
								for(int i=0;i<commnendArray.length;i++)
								{
										%>
										<tr>
									     <td ><%=(commnendArray[i][0].length()!=0)? commnendArray[i][0]:" &nbsp;"%>&nbsp;</td>
										   <td ><%=(commnendArray[i][1].length()!=0)? commnendArray[i][1]:" &nbsp;"%>&nbsp;</td>
										   <td ><%=(commnendArray[i][2].length()!=0)? commnendArray[i][2]:" &nbsp;"%>&nbsp;</td>
									     <td ><%=(commnendArray[i][3].length()!=0)? commnendArray[i][3]:" &nbsp;"%>&nbsp;</td>
									     <td ><%=(commnendArray[i][4].length()!=0)? commnendArray[i][4]:" &nbsp;"%>&nbsp;</td> 
									  </tr>
									    <%
						    }
						 }
					 }
		    }
	    %>
	  </table>
	</div>
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