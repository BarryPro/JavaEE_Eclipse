<%@ page language="java"  pageEncoding="gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/callTrans/k029_mixedtree_rpc_method.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<script type="text/javascript" language="javascript" src="../../../njs/si/base_kf.js"></script>
<script type="text/javascript" language="javascript" src="../../../njs/si/ajax_kf.js"></script>

<%
 String orgCode = (String)session.getAttribute("orgCode");
 String regionCode = orgCode.substring(0,2);
 String myParams="";
 String myParams1="";
 String CalledNo=request.getParameter("CalledNo");
 if(CalledNo!=null){
 		CalledNo = CalledNo.trim();
 }
 String UserClass=request.getParameter("UserClass");
 if(UserClass!=null){
 		UserClass = UserClass.trim();
 }
 String CityCode=request.getParameter("CityCode");
 if (CityCode == null || CityCode.trim().equals("")) {
 		CityCode= "0451";
 }
 if(CityCode!=null){
 		CityCode = CityCode.trim();
 }
 String ServiceNo=request.getParameter("ServiceNo");
 if(ServiceNo!=null){
 		ServiceNo = ServiceNo.trim();
 }
 String inFlag=(null == request.getParameter("flag") ? "0" : request.getParameter("flag"));
 String hasSelectNodes = request.getParameter("hasSelectNodes");
 if(hasSelectNodes!=null){
 		hasSelectNodes = hasSelectNodes.trim();
 }else{
 		hasSelectNodes = "";
 }

 String nodeId = "0";
 String isRoot = "1";
 String nodeLevel = "1";
 nodeLevel = new Integer(Integer.parseInt(nodeLevel)+1).toString();
 String lastChildRoute = request.getParameter("lastChildRoute");
 String hasSelectOption = "1";
 String sqlStr="";
 StringBuffer res = new StringBuffer();
 String selectTabBar = (null == request.getParameter("selectTabBar")?"0":request.getParameter("selectTabBar"));
 if (!"2".equals(selectTabBar)) {
 try{
 //�����ĸ��ڵ���
 if(isRoot.equals("")||isRoot.equals("0")){
 		if(nodeId!=null&&!nodeId.equals("")){
 			 //updated by tangsong 20101224 ��������ת��tab
       //if(inFlag.equals("0")){
       if(inFlag.equals("0") || inFlag.equals("3")){
        	sqlStr="select a.id,a.superid ,a.servicename,DECODE(decode((select count(*) from DSCETRANSFERTAB c where c.superid=a.id) ,'0','2002','2001'),'2001','0','1'),";
        	sqlStr=sqlStr+"decode((select count(*) from DSCETRANSFERTAB c where c.superid=a.id) ,'0','2002','2001'),a.ttansfercode,a.digitcode,a.userclass,a.usertype from DSCETRANSFERTAB a where 1=1 ";
        	sqlStr=sqlStr+"and a.typeid<>0 and a.superid=:nodeId  order by a.id " ;
        	myParams ="nodeId="+nodeId;
       }else{
         	sqlStr="select a.id,a.superid ,a.servicename,DECODE( decode((select count(*) from DZXSCETRANSFERTAB c where c.superid=a.id AND c.visiable = '1') ,'0','2004','2003'),'2003','0','1'),"
         	+"decode((select count(*) from DZXSCETRANSFERTAB c where c.superid=a.id AND c.visiable = '1') ,'0','2004','2003'),a.transfercode,a.digitcode,a.userclass,a.usertype from DZXSCETRANSFERTAB a where 1=1 ";
         	if(nodeId.indexOf("*")!=nodeId.length()-1){
         		sqlStr=sqlStr+"and a.superid=:nodeId  " ;
         		myParams ="nodeId="+nodeId;
         	}else{
         		String nodeLike = nodeId.substring(0,nodeId.length()-1);
         		sqlStr=sqlStr+"and ( a.id!=:nodeId  and  (a.superid='"+nodeLike+"' or substr(a.superid,0,length(a.superid)-1)=:vnodeLike)) " ;
         		myParams ="nodeId="+nodeId+",nodeLike="+nodeLike+",vnodeLike="+nodeLike;
         	}
         	sqlStr=sqlStr+" and a.visiable = '1' " ;
         	//yanghy ��Ϊ����Ƿ�ɼ����ֶ�. 1 �ǿɼ�.20090910
         	sqlStr=sqlStr+"order by a.id " ;
       }
    }
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="9">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="9" >

<%
	for(int i = 0; i < resultList.length; i++){
    String isLast = "0";
	  if(i==resultList.length-1){
	  	 isLast="1";
	   }
	  String lastChildRoute_ = (lastChildRoute.equals("")?lastChildRoute:(lastChildRoute+","))+isLast;
    getNodeHtml(res,resultList[i],nodeLevel,isLast,lastChildRoute_,hasSelectOption,"0",hasSelectNodes);
	}
%>
</wtc:array>
<%
}else{
      String isVisual = "0";
      if(isVisual==null){
           isVisual = "";
      }
      //��ʼ��ʵ�常�ڵ�
      if(isVisual.equals("")||isVisual.equals("0")){
           if(!CityCode.equals("")&&!CalledNo.equals("")&&!UserClass.equals("")){
                System.out.println("in Citycode");
                if(inFlag.equals("0")){
                     sqlStr="select a.id,a.superid ,a.servicename,DECODE(decode(a.typeid,'2002', decode((select count(*) from DSCETRANSFERTAB c where c.superid=a.id) ,'0','2002','2001'),a.typeid),'2001','0','1'), ";
                     sqlStr=sqlStr+"decode(a.typeid,'2002', decode((select count(*) from DSCETRANSFERTAB c where c.superid=a.id) ,'0','2002','2001'),a.typeid),a.ttansfercode,a.digitcode,a.userclass,a.usertype from DSCETRANSFERTAB a where 1=1 ";
                     sqlStr=sqlStr+"and a.accesscode=:CalledNo ";
                     sqlStr=sqlStr+"and userclass=:UserClass ";
                     sqlStr=sqlStr+"and citycode=:CityCode ";
                     sqlStr=sqlStr+"and a.typeid in('2001','2002','2003','2004') and not exists( select 1 from DSCETRANSFERTAB b where b.id=a.superid and b.typeid in ('2001','2002','2003','2004')) order by a.id " ;
                     myParams1 = "CalledNo="+CalledNo+",UserClass="+UserClass+",CityCode="+CityCode;
                }
                else if(inFlag.equals("1")){
                     System.out.println("in k029_2rpc_sql_2");
                     sqlStr="select a.id,a.superid ,a.servicename,DECODE(a.typeid,'2003','0','1'),a.typeid,a.transfercode,a.digitcode,a.userclass,a.usertype from DZXSCETRANSFERTAB a where 1=1 ";
                     sqlStr=sqlStr+"and a.accesscode=:CalledNo ";
                     sqlStr=sqlStr+"and userclass=:UserClass ";
                     sqlStr=sqlStr+"and citycode=:CityCode ";
                     sqlStr=sqlStr+" and a.visiable = '1' " ;
                     sqlStr=sqlStr+"and not exists( select 1 from DZXSCETRANSFERTAB b where b.id=a.superid) " ;
                     sqlStr=sqlStr+" order by a.id " ;
                     myParams1 = "CalledNo="+CalledNo+",UserClass="+UserClass+",CityCode="+CityCode;
                }
                //added by tangsong 20101224 ��������ת��tab
                else if(inFlag.equals("3")) {
		               sqlStr="select a.id,a.superid ,a.servicename,DECODE(decode(a.typeid,'2002', decode((select count(*) from DSCETRANSFERTAB c where c.superid=a.id) ,'0','2002','2001'),a.typeid),'2001','0','1'), ";
		               sqlStr=sqlStr+"decode(a.typeid,'2002', decode((select count(*) from DSCETRANSFERTAB c where c.superid=a.id) ,'0','2002','2001'),a.typeid),a.ttansfercode,a.digitcode,a.userclass,a.usertype from DSCETRANSFERTAB a where 1=1 ";
		               sqlStr=sqlStr+"and a.accesscode=:CalledNo ";
		               sqlStr=sqlStr+"and userclass=:UserClass ";
		               sqlStr=sqlStr+"and citycode=:CityCode ";
		               //sqlStr=sqlStr+"and a.typeid in('2001','2002','2003','2004') and not exists( select 1 from DSCETRANSFERTAB b where b.id=a.superid and b.typeid in ('2001','2002','2003','2004')) order by a.id " ;
		               sqlStr=sqlStr+"and a.servicename in ('Iphone���ҵ��','��ͨ�����ն����','������רϯ���','����רϯ���')";
		               //sqlStr=sqlStr+"and a.servicename like '%����%' ";
		               myParams1 = "CalledNo="+CalledNo+",UserClass="+UserClass+",CityCode="+CityCode;
                }
           }
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="9">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams1%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="9" >
<%
      for(int i = 0; i < resultList.length; i++)
      {
           String isLast = "0";
           if(i==resultList.length-1)
           {
                isLast="1";
           }
           getNodeHtml(res,resultList[i],"1",isLast,isLast,hasSelectOption,"0",hasSelectNodes);
      }
%>
</wtc:array>
<%
       }
      else
      {
           String[] param = {"0","-1","IVR","0","IVR"};
           getNodeHtml(res,param,"1","1","1",hasSelectOption,isRoot,hasSelectNodes);
      }
 	}
 }catch(Exception e){
 	e.printStackTrace();
 }
}
%>

<%
/**############################��Ӳ�ѯ��ʼ.############################*/
String flag = ( null == request.getParameter("flag") ? "0" : request.getParameter("flag") );
StringBuffer searchStr = new StringBuffer();
if("2".equals(selectTabBar)){
/**����ǲ�ѯ,�ж�selectTabBar��ѡ����3��ʱ���ٽ�������ʾ.*/
	String searchName = ( null == request.getParameter("searchName") ? "" : request.getParameter("searchName") );
	String calledNo = ( null == request.getParameter("calledNo") ? "" : request.getParameter("calledNo") );
	String userClass = ( null == request.getParameter("userClass") ? "" : request.getParameter("userClass") );
	String cityCode = ( null == request.getParameter("cityCode") ? "" : request.getParameter("cityCode") );
	myParams="";
	sqlStr = "";
	if(!"".equals(searchName)){
	if(flag.equals("0")){
		sqlStr = " select a.id,a.superid ,a.typeid,a.servicename,a.ttansfercode,a.digitcode,a.userclass,a.usertype from DSCETRANSFERTAB a where 1=1 ";
		if(!calledNo.equals(""))
		sqlStr += " and a.accesscode = :calledNo ";
		myParams = "calledNo="+calledNo;
		if(!userClass.equals(""))
		sqlStr +=" and a.userclass = :userClass ";
		myParams = myParams + ",userClass="+userClass;
		if(!cityCode.equals(""))
		sqlStr += " and a.citycode = :cityCode ";
		sqlStr += " and a.servicename like '%'||:searchName||'%'  ";
		sqlStr += " and a.typeid not in ('0','1','2','3') and not exists( select 1 from DSCETRANSFERTAB b where b.superid = a.id )   order by a.id" ;
		myParams = myParams + ",cityCode="+cityCode+",searchName="+searchName;
		searchStr.append("<div>");
		searchStr.append("<span style='font: bold ;font-size: smaller;cursor:hand'>");
		searchStr.append("תҵ��������������");
		searchStr.append("</span></div>");
	}
	else{
		sqlStr = " select a.id,a.superid ,'2004',a.servicename,a.transfercode,a.digitcode,a.userclass,a.usertype from DZXSCETRANSFERTAB a where 1=1 ";
		if(!calledNo.equals(""))
		sqlStr += " and a.accesscode = :calledNo ";
		myParams = "calledNo="+calledNo;
		if(!userClass.equals(""))
		sqlStr += " and a.userclass = :userclass ";
		myParams = myParams + ",userclass="+userClass;
		if(!cityCode.equals(""))
		sqlStr += " and a.citycode = :cityCode ";
		sqlStr += " and a.servicename like '%'||:searchName||'%' ";
		myParams = myParams+",cityCode="+cityCode+",searchName="+searchName;
		sqlStr += " and a.visiable = '1' " ;
		sqlStr += " and (a.typeid = '2004' or not exists( select 1 from DZXSCETRANSFERTAB b where b.superid = a.id and b.visiable='1')) order by a.id ";
		/**�޸�Ҷ�ӽڵ��ж�.2004��Ҷ�ӽڵ�.sqlStr += " and not exists( select 1 from DZXSCETRANSFERTAB b where b.superid = a.id ) order by a.id" ;*/
		searchStr.append("<div>");
		searchStr.append("<span style='font: bold ;font-size: smaller;cursor:hand'>");
		searchStr.append("ת��ѯ�������������");
		searchStr.append("</span></div>");
	}
	%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="queryList" scope="end"/>	
	<% 
	searchStr.append("\n<TABLE><TR><TD vAlign=top>\n");
	for (int i = 0; i < queryList.length; i++) {
		if(queryList[i][0] != null && queryList[i][0].indexOf("*") > 0){
			/**���⴦��������������*�Ľڵ�.�Ǹ�Ҳ�Ǹ��ڵ�.*/
			continue;
		}
	  if(queryList[i][2].equals("2001")||queryList[i][2].equals("2003")){
		  //searchStr.append(" open=\"0\" im0=\"folderClosed.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">");
	        //xml.append(" child=\"1\">");   
	    }else {    
	    	//searchStr.append(" im0=\"leaf.gif\" im1=\"folderOpen.gif\" im2=\"folderClosed.gif\">"); 
	        //xml.append(" child=\"0\">");     
	    }
		searchStr.append("\n<div class='child_show' style='padding: 0px;margin: 0px;'>\n");
		searchStr.append("<img style='cursor:hand' align=absMiddle border=0 src='/npage/callbosspage/k170/tree/images/T.gif'>");
		searchStr.append("<img style='cursor:hand' align=absMiddle border=0 src='/npage/callbosspage/k170/tree/images/icon-page.gif'>");
		searchStr.append("<input type='checkbox' onclick=\"checkBoxClick('");
		searchStr.append(queryList[i][0]);/**id*/
		searchStr.append("');\"  value='");
		searchStr.append(queryList[i][0]);/**id*/
		searchStr.append("' id ='chk");
		searchStr.append(queryList[i][0]);/**id*/
		searchStr.append("'>");
		/*update by sunbya add�������ܽ���������ɫ����ttansfercode�Ĳ�ͬ���ı� 20120308
		searchStr.append("<span class='item' style='cursor:hand' onclick=\"spanClick('");
		*/
		if(queryList[i][4].toString().equals("4403")){
			searchStr.append("<span class='item' style='cursor:hand;color:blue' onclick=\"spanClick('");
		}else if(queryList[i][4].toString().equals("4559")){
			searchStr.append("<span class='item' style='cursor:hand;color:red' onclick=\"spanClick('");
		}else if(queryList[i][4].toString().equals("4554")){
			searchStr.append("<span class='item' style='cursor:hand;color:#2AFF00' onclick=\"spanClick('");
		}else{
			searchStr.append("<span class='item' style='cursor:hand' onclick=\"spanClick('");
		}
		searchStr.append(queryList[i][0]);/**id*/
		searchStr.append("');return false;\" id='m");
		
		searchStr.append(queryList[i][0]);/**id*/
		searchStr.append("span' typeid='");
		searchStr.append(queryList[i][2]);/**typeid*/
		searchStr.append("' servicename='");
		searchStr.append(queryList[i][3]);/**servicename*/
		searchStr.append("' ttansfercode='");
		searchStr.append(queryList[i][4]);/**ttansfercode*/
		searchStr.append("' digitcode='");
		searchStr.append(queryList[i][5]);/**digitcode*/
		searchStr.append("' usertype='");
		searchStr.append(queryList[i][7]);/**usertype*/
		searchStr.append("' >");
		searchStr.append(queryList[i][3]);/**servicename*/
		searchStr.append("</span>\n</div>");
		
		/**searchStr.append("<userdata name='typeid'>"+queryList[i][2]+"</userdata>");  
		searchStr.append("<userdata name='super_id'>"+queryList[i][1]+"</userdata>");   
		searchStr.append("<userdata name='servicename'>"+queryList[i][3]+"</userdata>");
		searchStr.append("<userdata name='ttansfercode'>"+queryList[i][4]+"</userdata>"); 
		searchStr.append("<userdata name='digitcode'>"+queryList[i][5]+"</userdata>"); 
		searchStr.append("<userdata name='userclass'>"+queryList[i][6]+"</userdata>"); 
		searchStr.append("<userdata name='usertype'>"+queryList[i][7]+"</userdata>");*/
		}
	searchStr.append("\n</TD></TR></TABLE>\n");
	}
}

/**############################��Ӳ�ѯ����.############################*/
%>
<HTML>
<HEAD>
<!--
<SCRIPT src="<%=request.getContextPath()%>/njs/csp/mixedtree.js" type=text/javascript></SCRIPT>
-->
</HEAD>
<BODY>
<%if(!"2".equals(selectTabBar)){%>
<TABLE>
	<TR>
		<TD vAlign=top>
		<DIV id="baseTree"></DIV>
		</TD>
		<TD vAlign=top>
		<DIV id="childTree"></DIV>
		</TD>
	</TR>
</TABLE>
<%}else{ %>
<div style="height: 340px;width: 100%;margin: 0;border: 0;overflow: auto;background-color: white;">
					<%=searchStr.toString()%>
</div>
<%} %>
</BODY>
</html>
<SCRIPT type=text/javascript>
/*comment by hucw 20101124,��������,ͳһ��callTreeMain����ext2ֵ
var ext2 = parent.document.form1.ext2.value;
*/
var typeFlag;
var toAthouDigitcode;
var inFlag = '<%=flag%>';

// ȡ�����е�checkboxѡ��
function unCheckBoxBySelect() {

	var checkBoxItems = document.getElementsByTagName("input");
	for ( var i = 0; i < checkBoxItems.length; i++) {
		if (checkBoxItems[i].type == 'checkbox'
				&& checkBoxItems[i].checked == true) {
		
			checkBoxItems[i].checked = false;
			<!-- add by jiyk 2012-06-22 �����ı���������-->
			var sendSMS = window.parent.sendSMS;
			
		}
	}
}
//ȡ��
function deleteBoxList(node_id){
	/**ȡ��selectѡ��.*/
	var myselect = parent.document.form1.select_Name.options;
	for ( var i = 0; i < myselect.length; i++) {
		if (myselect[i].value == node_id) {
			myselect.remove(i);
			break;
		}
	}
	//add by hucw 20101124,ɾ����ѡ�ڵ�id,ɾ����������
	parent.removeFromNode_id(node_id);
	//parent.sendSMS.setContent("");
}

function sendData(ttansfercode, typeId, toAthouDigitcode, usertype) {
	//��֯���ݣ�תIVR,ȡ��ttansfercode
	parent.document.form1.ttansfercode.value = ttansfercode;
	parent.document.form1.typeId.value = typeId;
	parent.document.form1.DigitCode.value = toAthouDigitcode;
	parent.document.form1.userType.value = usertype;
	/*comment by hucw 20101124,��������,ͳһ��callTreeMain����ext2ֵ;
	parent.document.form1.ext2.value = ext2;
	*/
}
function img1Click(par_id) {
	changeColor(par_id);
	var pardiv = document.getElementById('m' + par_id + 'span');
	//��Է�Ҷ�ӽڵ㣬�򿪼�������
	if (pardiv.is_Leaf == '0') {
		if (pardiv.isOpen == '0') {
			if (pardiv.hasLoad == '0') {
				getChildren(par_id);
				pardiv.isOpen = '1';
				//pardiv.hasLoad='1';
				hideOrShow_(par_id);
			} else {
				pardiv.isOpen = '1';
				hideOrShow_(par_id);
			}
		} else {
			pardiv.isOpen = '0';
			hideOrShow_(par_id);
		}
	} else {
		var checkBoxItem = document.getElementById("chk" + par_id);
		if (checkBoxItem.checked == false) {
			checkBoxItem.checked = true;
		} else {
			checkBoxItem.checked = false;
		}
		checkBoxClick(par_id);
	}
}

function img2Click(par_id) {
	img1Click(par_id);
}

function spanClick(par_id) {
	var pardiv = document.getElementById('m' + par_id + 'span');
	//��Է�Ҷ�ӽڵ㣬�򿪼�������
	if (pardiv.is_Leaf == '0') {
		//�ڵ����������
		if (pardiv.isOpen == '0') {
			if (pardiv.hasLoad == '0') {
				getChildren(par_id);
				pardiv.isOpen = '1';
				//pardiv.hasLoad='1';
				hideOrShow_(par_id);
			} else {
				pardiv.isOpen = '1';
				hideOrShow_(par_id);
			}
		} else {
			pardiv.isOpen = '0';
			hideOrShow_(par_id);
		}
	} else {
		var checkBoxItem = document.getElementById("chk" + par_id);
		if (checkBoxItem.checked == false) {
			checkBoxItem.checked = true;
		} else {
			checkBoxItem.checked = false;
		}
		checkBoxClick(par_id);
	}
}

function spandblClick(par_id) {

}

function changeMMsContent(){
	 var checkBoxIds="";
	 var checkBoxItems = document.getElementsByTagName("input");
		for ( var i = 0; i < checkBoxItems.length; i++) {
			if (checkBoxItems[i].type == 'checkbox'
					&& checkBoxItems[i].checked == true) {
					
				  checkBoxIds=checkBoxIds+"'"+checkBoxItems[i].value+"',";
			}
		}
	$.ajax({
		url : '<%=request.getContextPath()%>/npage/callbosspage/callTrans/findMessegeById_rpc.jsp?type=1&checkBoxIds='+checkBoxIds,
		type : "POST",
		dataType : "html",
		success : function(data) {
				var temp_1 = eval('(' + data.trim() + ')');/**��json,���ͽ���ת��.*/	        
	        	//��ʾ��������
		     var sendSMS = window.parent.sendSMS; 
		     sendSMS.document.getElementById("ivrId").value=temp_1.msgId;
			   var msgContent = temp_1.msg_content;
			   var ivrBoxObjs=msgContent.split("��");
		     sendSMS.messageArray = new Array();
	       for (var i=0;i<ivrBoxObjs.length;i++) {
			       var msgContent =ivrBoxObjs[i];
			       if(msgContent != ''){
			       sendSMS.msg_content.readOnly='';
			       sendSMS.messageArray.push(msgContent);
			       
			       }
		      }
		     
		     //add by lipf 2012-03-06 begin ����ת�����Խڵ㷢�Ͷ���
		     /**
					var ivrMsgContents=temp_1.msg_content.split("��");
					sendSMS.ivrMsgArray=new Array();
					for(var i=0;i<ivrMsgContents.length;i++){
						sendSMS.ivrMsgArray.push(ivrMsgContents[i]);
					}
					*/
					//add by lipf 2012-03-06 end 
					
		      sendSMS.genHTMLByArray();
		      sendSMS.msg_content.readOnly='true';
		}
	});
	
	}
<!-- add by jiyk 2012-05-12 -->
function checkBoxClick(id) {

	var pardiv = document.getElementById('m' + id + 'span');
	var inReg;
	var arr;
	var isLeaf = pardiv.typeid;
	var digitcode = pardiv.digitcode;
	var ttansfercode = pardiv.ttansfercode;
	var typeId = pardiv.typeid;
	var usertype = pardiv.usertype;
	var sendSMS = window.parent.sendSMS;
	changeColor(id);
	var checkBoxItem = document.getElementById("chk" + id);
	/**ǰ��Ҫ���������У��.*/
	if (checkBoxItem.checked == false) {
		deleteBoxList(id);
		changeMMsContent();
		
	} else {
		//yanghy 20090917 �������������ƹ���.����������Ϊ5.BEGIN.
		if(parent.document.form1.select_Name.options.length > 4){
			rdShowMessageDialog("���ֻ��ѡ��5��!",1);
			document.getElementById("chk" + id).checked = false;
			return;
		}
		if (isLeaf == '2001' || isLeaf == '2002') {
			inReg = "00";
		}
		if (isLeaf == '2003' || isLeaf == '2004') {
			inReg = "01";
		}
		var checkBoxItems = document.getElementsByTagName("input");
		var arr = new Array();
		var m = 0;
		for ( var i = 0; i < checkBoxItems.length; i++) {
			if (checkBoxItems[i].type == 'checkbox'
					&& checkBoxItems[i].checked == true) {
				arr[m] = checkBoxItems[i].value;
				m++;
			}
		}
		if (m == 1) {
			typeFlag = document.getElementById('m' + arr[0] + 'span').typeid;
			if (typeFlag == '2001' || typeFlag == '2003') {
				toAthouDigitcode = digitcode;
			} else {
				toAthouDigitcode = digitcode.substr(0, 2);
			}
			showNodeIdList('', id, ttansfercode, typeId, toAthouDigitcode,usertype);
		}
      
		if (m > 1) {/**���Ƕ����ʱ��.*/	  
						if (arr[0] == checkBoxItem.value) {
							typeFlag = document.getElementById('m' + arr[1] + 'span').typeid;
						} else {
							typeFlag = document.getElementById('m' + arr[0] + 'span').typeid;
						}
						if (typeFlag == '2001' || typeFlag == '2003') {
							checkBoxItem.checked = false;
						}
						if (typeFlag == '2002' || typeFlag == '2004') {
							/**����ų���ѡ,�������������.*/
							/*outflag='0'��ʾ����״̬,outflag='1'����״̬*/
							var outflag = top.opener.outCallFlag;
										if (outflag != undefined && outflag == 1) {
											checkBoxItem.checked = false;
											rdShowMessageDialog("���ֻ��ѡ��һ���ڵ�!",1);
										} else if (isLeaf == '2001' || isLeaf == '2003') {
											checkBoxItem.checked = false;
										} else {
											//add by chenhr.20101123.Ϊ�˷�ֹdigitcodeδ��ֵ��
												if (typeFlag == '2001' || typeFlag == '2003') {
														toAthouDigitcode = digitcode;
													} else {
														toAthouDigitcode = digitcode.substr(0, 2);
													}
												//add end.	
												showNodeIdList('', id, ttansfercode, typeId,
							                toAthouDigitcode, usertype);
										}
						}
		}
	}

}

//����һ����̬��
function initBaseTree() {
	iniRootNodes();
}

//��������Ϣ��ʾ��ҳ���·�
function showNodeIdList(allCheckItem, id, ttansfercode, typeId,
		toAthouDigitcode, usertype) {
	sendData(ttansfercode, typeId, toAthouDigitcode, usertype);
	
	//var els=parent.document.getElementsByTagName("span");
	//�õ�ѡ�нڵ�����
	var type = "";
	if (typeId == '2001' || typeId == '2002') {
		type = "0";
	}
	if (typeId == '2003' || typeId == '2004') {
		type = "1";
	}
	
	 var checkBoxIds="";
	 var checkBoxItems = document.getElementsByTagName("input");
		for ( var i = 0; i < checkBoxItems.length; i++) {
			if (checkBoxItems[i].type == 'checkbox'
					&& checkBoxItems[i].checked == true) {
				  checkBoxIds=checkBoxIds+"'"+checkBoxItems[i].value+"',";
	
			}
		}
		
	
	$.ajax({
		url : '<%=request.getContextPath()%>/npage/callbosspage/callTrans/findMessegeById_rpc.jsp?id='+id+'&type='+type+'&checkBoxIds='+checkBoxIds,
		type : "POST",
		dataType : "html",
		success : function(data) {
				var temp_1 = eval('(' + data.trim() + ')');/**��json,���ͽ���ת��.*/
				/**###########################################�����Ǵ���ڵ���ʾ.BEGIN*/
				var pardiv = document.getElementById('m' + id + 'span');
				var onCheckItemName = "";
				var isLeaf = pardiv.typeid;
				/**��������ʾ*/
				var cityCode = '';
				var userClass = ''
				if(parent.selectTabBar == '2'){/**�ж��������������ֱ��ȥ2����.�������������..*/
					cityCode = parent.document.getElementById("CityCode").value;
					userClass = parent.document.getElementById("UserClass").value;
				}else{
					cityCode = parent.document.getElementById("CityCode").value;
					userClass = parent.document.getElementById("UserClass").value;
				}
				if (!isInShowName(id)) {
					onCheckItemName = temp_1.node_name;
					<!-- add by jiyk 2012-05-26 -->
					/**�����ݷŵ�option����.*/
					var mytext =id + '��' + onCheckItemName;
					var myvalue = id;
					var myOption = new Option(mytext, myvalue);
					/**yanghy add NodeId and NodeName. */
					myOption.node_id = id;
					myOption.node_name = mytext;
					myOption.city_code = cityCode;
					myOption.user_class = userClass;
					/**��ӽڵ�����.�ж���ת��ѯ���ǰ���.*/
					myOption.node_type = type;
					myOption.msg_content = temp_1.msg_content;
					myOption.digit_code = temp_1.digit_code;
					myOption.node_id = id;
					/**��option��ӵ�ѡ����б�����.*/
					//add by lipf 2012-03-06 begin ����ת�����Խڵ㷢�Ͷ���
					myOption.ivr_msg_content = temp_1.msg_content;
					//add by lipf 2012-03-06 end 
					parent.document.form1.select_Name.options.add(myOption);
					//add by hucw,20101124,������ѡ�ڵ�idֵ��node_idԪ��
					//add by hucw 20101124��ʾ��������
					
					//parent.sendSMS.setContent(myOption.msg_content);
					//��ʾ��������
		     var sendSMS = window.parent.sendSMS;
			   var msgContent = myOption.msg_content;
		     sendSMS.document.getElementById("ivrId").value=temp_1.msgId;
			   var ivrBoxObjs=msgContent.split("��");
		     sendSMS.messageArray = new Array();
		     
	       for (var i=0;i<ivrBoxObjs.length;i++) {
			       var msgContent =ivrBoxObjs[i];
			       if(msgContent != ''){
			<!-- add by jiyk 2012-06-23 ���Ž���-->       	
			       sendSMS.msg_content.readOnly='';
			       sendSMS.messageArray.push(msgContent);
			   
			       }
		      }
		      
		      //add by lipf 2012-03-06 begin ����ת�����Խڵ㷢�Ͷ���
		      /**
					var ivrMsgContents=myOption.ivr_msg_content.split("��");
					sendSMS.ivrMsgArray=new Array();
					for(var i=0;i<ivrMsgContents.length;i++){
						sendSMS.ivrMsgArray.push(ivrMsgContents[i]);
					}
					*/
					//add by lipf 2012-03-06 end 
		      
		      sendSMS.genHTMLByArray();
		 <!-- add by jiyk 2012-06-22 �����ı�����Ҫ�������������޸Ĳ��� -->
				  sendSMS.msg_content.readOnly='true';
				  
					var hasSelectNodes = parent.document.getElementById("node_id");
					var node_ids = hasSelectNodes.value;
					hasSelectNodes.value = (node_ids == "") ? myOption.node_id : node_ids + "," + myOption.node_id;
					//end by hucw,20101124
					tempNodeId = null;mytext = null;myvalue = null;myOption = null;
				}
				pardiv = null;onCheckItemName = null;isLeaf = null;
				temp_1 = null;
				///###########################################�����Ǵ���ڵ���ʾ.END
		}
	});
}


/*
 *�жϽڵ�ID�Ƿ���ѡ�еļ�����
 */
function isInShowName(node_id) {
	var els = parent.document.form1.select_Name.options;
	if (els.length < 0)
		return false;
	for ( var i = 0; i < els.length; i++) {
		if (els[i].value == node_id) {
			return true;
		}
	}
	return false;
}

//�Ƿ���ڸ�ѡ��
var hasSelectOption = "1";
//��ǰ������span
var operateDiv = null;

with (document) {
	write("<STYLE TYPE='text/css'>");
	write(".parent { font: 12px/14px;  margin:0px; Times; text-decoration: none; color: black;}");
	write(".child { font:12px/14px  margin:0px; Times; display:none;color:black;}");
	write(".child_show { font:12px/14px  margin:0px; Times; display:block;color:black;}");
	write(".item { color: black; border:0px; margin:0px; text-decoration:none; cursor: hand;display: inline  }");
	write(".highlight { color: blue; text-decoration:none }");
	write(".icon { margin-right: 5 }")		
	write("</STYLE>");
}




/**
* ��ȡ�ӽڵ�
*/

function getChildren(par_id){ 
  var pardiv=document.getElementById('m'+par_id+'span'); 
  /* 
  var packet = new AJAXPacket("/npage/callbosspage/callTrans/k029_mixedtree_rpc.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
  packet.data.add("nodeId",par_id);
  packet.data.add("nodeLevel",pardiv.nodeLevel);
  packet.data.add("inFlag",inFlag);
  packet.data.add("hasSelectNodes",parent.document.getElementById("node_id").value);
  packet.data.add("lastChildRoute",pardiv.lastChildRoute);
  packet.data.add("hasSelectOption",hasSelectOption);
  core.ajax.sendPacket(packet,getChildCallBack,true);
	packet=null;
	*/
	var no_id_i=parent.document.getElementById("node_id").value;
	var urlStrl="/npage/callbosspage/callTrans/k029_mixedtree_rpc.jsp?";
	var strbill="nodeId="+par_id+"&nodeLevel="+pardiv.nodeLevel+"&inFlag="+inFlag+"&hasSelectOption="+hasSelectOption+"&hasSelectNodes="+no_id_i+"&lastChildRoute="+pardiv.lastChildRoute;
	asyncGetText(urlStrl+strbill,getChildCallBack);
}

function getChildCallBack(packet){
   /*
  var nodesHtml = packet.data.findValueByName("worknos");
  var nodeId= packet.data.findValueByName("nodeId");
  */   
  
  packet=packet.trim();
  var sp_return=packet.split('A~A');
  var nodesHtml=sp_return[0];
  var nodeId=sp_return[1];
  var curPardiv=document.getElementById("m"+nodeId+"Child"); 
  //curPardiv.innerHTML = nodesHtml;
  $(curPardiv).append(nodesHtml);
  var pardiv=document.getElementById('m'+nodeId+'span');
  pardiv.hasLoad='1';
  if(par_ids && par_ids.length >0 ){
  	for(var i=par_ids.length-1;i>=0;i--){
  		var par_id = par_ids.pop();
  		if(!openTree(par_id)){
  			par_ids.push(par_id);
  		}
  	}
  }
}

//��¼��ʼ�����ĸ��ڵ�
var parentNodeId;
//��ʼ�����ڵ㣬divId����¼������div��id��par_id����¼�����ڵ��ID��isVisual���������ʵ����ʵ����Ҫ�����ݿ� ��hasSelect���Ƿ���Ҫ��ѡ��
function iniRootNodes(){
  var nodesHtml="<%=res.toString()%>";
  var nodeId="<%=nodeId%>";
  var curPardiv=document.getElementById("baseTree");
  curPardiv.className='child_show';
  $(curPardiv).append(nodesHtml);
	if(par_ids && par_ids.length >0 ){
  	for(var i=par_ids.length-1;i>=0;i--){
  		var par_id = par_ids.pop();
  		if(!openTree(par_id)){
  			par_ids.push(par_id);
  		}
  	}
  }
}

//ͼ��ת������Ҫ���߼�ת����ִ��
function hideOrShow_(par_id){
	var img1div=document.getElementById('m'+par_id+'Tree');
	var img2div=document.getElementById('m'+par_id+'Folder');
	var pardiv=document.getElementById('m'+par_id+'Child');
	var pardiv2=document.getElementById('m'+par_id+'span');
	if(pardiv){
		if(pardiv2.isOpen=='0'){
			if(pardiv2.isLast=='0'){
				img1div.src="/npage/callbosspage/k170/tree/images/Tplus.gif";				
			}else{
				img1div.src="/npage/callbosspage/k170/tree/images/Lplus.gif";
			}
			img2div.src="/npage/callbosspage/k170/tree/images/foldericon.gif";
			pardiv.style.display='none';
		}
		else{
			if(pardiv2.isLast=='0'){
				img1div.src="/npage/callbosspage/k170/tree/images/Tminus.gif";				
			}else{
				img1div.src="/npage/callbosspage/k170/tree/images/Lminus.gif";
			}
			img2div.src="/npage/callbosspage/k170/tree/images/openfoldericon.gif";
			pardiv.style.display='block';
		}
	}
}

var oldColor;
function changeColor(node_id){
	if(operateDiv!=null&&operateDiv!=''){
	   var spandiv=document.getElementById(operateDiv);
	   if(spandiv!=null){
	   			spandiv.style.color = oldColor;
	   			spandiv.style.backgroundColor = '';
	   	}
	}
	operateDiv = 'm'+node_id+'span';
	var spandiv2=document.getElementById(operateDiv);
	if(spandiv2!=null){
					oldColor = spandiv2.style.color;
	   			spandiv2.style.color = '#FFFFFF';
	   			spandiv2.style.backgroundColor = '#000BB0';
	}
}
	
	
function childToParent(nodeType,sel){
	var ids = new Array();
	var val = "";
	var ids_str = "";
	if(sel && sel.length){
		for(var i=0 ;i<sel.length;i++){
			//����node_type=0����ҵ������1����������ѯ
			val = sel[i].value;
			if(sel[i].node_type == nodeType)
				if(val != null && val != "")
					ids.push(val);
		}
	}
	if(nodeType == "1")//������ѯ
		tablename = "DZXSCETRANSFERTAB";
	else	//ҵ�����
		tablename="DSCETRANSFERTAB";
	ids_str = ids.toString();
	if(ids_str != null && ids_str != ""){
		var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/callTrans/k029_childToParent.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
		packet.data.add("ids_str",ids.toString());
		packet.data.add("tablename",tablename);
		core.ajax.sendPacket(packet,getParentNode,true);
		packet=null;
	}else{
		<%if(!"2".equals(selectTabBar)){%>
			iniRootNodes();
		<%}%>		
	}
}

//ȫ�ֱ�������Ҫ�򿪵ĸ��ڵ�,ͨ��getParentNode�ص�������ȡ
var par_ids = new Array();
function getParentNode(packet){
	var ret = packet.data.findValueByName("ret");
	var select_Name = window.parent.document.getElementById("select_Name");
	par_ids = packet.data.findValueByName("par_ids").split(",");
	//�������غ��ڵ���iniRootNodes����
	<%if(!"2".equals(selectTabBar)){%>
		iniRootNodes();
	<%}%>
}

function openTree(par_id){
	var e = document.getElementById("m" + par_id + "span");
	if(e){
		//setTimeout("img1Click("+par_id+")",100);
		//img1Click(par_id);
		img1Click(par_id);
		return true;
	}
	return false;
}

window.onload = function(){
	var select_Name = window.parent.document.getElementById("select_Name");
	var sel = select_Name.options;
	if(sel && sel.length && sel.length >0)
		childToParent(inFlag,sel);
	else{
		<%if(!"2".equals(selectTabBar)){%>
			iniRootNodes();
		<%}%>
	}
}
</SCRIPT>