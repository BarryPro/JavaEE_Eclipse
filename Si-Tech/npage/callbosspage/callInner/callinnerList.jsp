<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
  /*
   * ����: ��ϯ�б�ҳ��
�� * �汾: 1.0.0
�� * ����: 2008/10/20
�� * ����: mixh
�� * ��Ȩ: sitech
   *update:
��*/
%>
<%
	String[][] retData = new String[][] {};
	String region=request.getParameter("org_id");
	String brand=request.getParameter("class_id");
	String skill=request.getParameter("skill_id");
	String staffstatus=request.getParameter("staffstatus");
	String lineNum=request.getParameter("endNum");
	
	/**********begin �ڲ���������Ż�***********/
  String org_id = request.getParameter("org_id");
  String class_id = request.getParameter("class_id");
  String skill_id = request.getParameter("skill_id");
  
  String endNum = request.getParameter("endNum");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String params = "";
  String sqlStr="";
  if(endNum !=null && !endNum.equals("null") && !endNum.equals("")){
   
   sqlStr="select ccsworkno, decode(org_id, '01','������','02','�������','03','ĵ����','04','��ľ˹','05','˫Ѽɽ','06','��̨��','07','����','08','�׸�','09','����','10','�ں�','11','�绯','12','���˰���','13','����','15','��ػ�����','90','ʡ�ͷ�����'), login_no, decode(staffstatus,'12','����̬','13','���������̬','0','δǩ��','1','����״̬','2','Ԥռ��״̬','3','ռ��״̬','4','Ӧ��״̬','5','ͨ��״̬','6','����״̬','7','æ״̬','8','�����Ϣ̬','9','ѧϰ̬','10','����̬','11','ͨ������̬','14','����תIVR'), kf_name, class_id, duty from (select * from dstaffstatus  where 1=1  order by ccsworkno) where 1=1 ";
  }
  else{
   sqlStr= "select ccsworkno, decode(org_id, '01','������','02','������� ','03','ĵ����','04','��ľ˹','05','˫Ѽɽ','06','��̨��','07','����','08','�׸�','09','����','10','�ں�','11','�绯','12','���˰���','13','����','15','��ػ�����','90','ʡ�ͷ�����'), login_no, decode(staffstatus,'12','����̬','13','���������̬','0','δǩ��','1','����״̬','2','Ԥռ��״̬','3','ռ��״̬','4','Ӧ��״̬','5','ͨ��״̬','6','����״̬','7','æ״̬','8','�����Ϣ̬','9','ѧϰ̬','10','����̬','11','ͨ������̬','14','����תIVR'), kf_name, class_id, duty from dstaffstatus where 1=1 ";
  	}	
  if(org_id !=null && !org_id.equals("null") && !org_id.equals("")){
       sqlStr += "and org_id =:org_id ";
       params+="org_id="+org_id;
   }
   if(class_id !=null && !class_id.equals("null") && !class_id.equals("")){ 
		sqlStr += "and  class_id like '%'||:class_id||'%'   "; 
		 params+=",class_id="+class_id;
   }
   if(staffstatus !=null && !staffstatus.equals("null") && !staffstatus.equals("")){
   	   sqlStr += " and staffstatus =:staffstatus ";
   	   params+=",staffstatus="+staffstatus;
   }    
   if(endNum !=null && !endNum.equals("null") && !endNum.equals("")){
   	   sqlStr += " and rownum <=:endNum ";
   	   params+=",endNum="+endNum;
   }
	 sqlStr += " order by ccsworkno ";
%>

<wtc:service name="TlsPubSelCrm" outnum="7" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=params%>"/>
</wtc:service>
<wtc:array id="queryList" start="0" length="7">

<%
retData = queryList;
%>
</wtc:array>
<html>
<head>
<title>��ϯ�б�</title>
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
</head>

<body>
<form  name=formbar>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top">
    <div id="Operation_Table">
      <table id="dataTable" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<!--comment by hucw,20100530,�����û�Ҫ��ȡ��radioѡ��-->
      	<!--<td class="blue">ѡ��</td>-->
        <th class="blue" class="Blue" style="color:#3366FF;font-weight:bold;">���</th>
        <th class="blue" class="Blue" style="color:#3366FF;font-weight:bold;">����</th>
        <th class="blue" class="Blue" style="color:#3366FF;font-weight:bold;">����</th>
        <th class="blue" class="Blue" style="color:#3366FF;font-weight:bold;">BOSS����</th>
        <th class="blue" class="Blue" style="color:#3366FF;font-weight:bold;">״̬</th>
        <th class="blue" class="Blue" style="color:#3366FF;font-weight:bold;">����</th>
        <th class="blue" class="Blue" style="color:#3366FF;font-weight:bold;">����</th>
        <th class="blue" class="Blue" style="color:#3366FF;font-weight:bold;">�೤</th>
      </tr>
      <%      
if(retData.length > 0){

	for(int i = 0; i < retData.length; i++){//��ʼѭ��.FOR �ⲿ%>
		<tr class="blue" value="<%=retData[i][0]%>" onclick="sendmsg(this);">
		<td width="40px;">
			<%=(i+1)%>
		</td>
		<%      	
		int j = 0;
		for(; j < retData[i].length; j++){//��ʼѭ��.FOR �ڲ�
			String color_str = "";
			if("ͨ��״̬".equals(retData[i][3])||"æ״̬".equals(retData[i][3])){
				color_str="red";
			}else if("����״̬".equals(retData[i][3])||"Ӧ��״̬".equals(retData[i][3])){
				color_str="blue";
			}else if("����״̬".equals(retData[i][3])){
				color_str="green";
			}
			if(j == 0||j==2){
				%>
				<!--<td style="color:<%=color_str %> "><a href="<%=request.getContextPath()%>/npage/callbosspage/K084/K084_commNoteSend.jsp?loginno_call=<%=retData[i][j]%>" target="_blank"><%=retData[i][j]%></font></td>-->
				<td style="color:<%=color_str %> ">
					<a href='#' value="<%=retData[i][0]%>,<%=retData[i][2]%>" onclick="setCallNo_modify(this);" style="text-decoration:none;">
						<font color=<%=color_str %>><%=retData[i][j]%></font>
					</a>
				</td>
				<%		    	
			}	else{
				%>
				<td style="color:<%=color_str %>"><%=retData[i][j]%></td>
				<%  
			}	
		}//����ѭ��.FOR �ڲ�
		%>
		</tr>
		<%
	}//����ѭ��.FOR �ⲿ
}      	
%>
      </table>
    </div>
    <br/>
    </td>
  </tr>
</table>
</form>
</body>
</html>
<script>
/*�Է���ֵ���д���*/
var worknos;
function doProcess(packet)
{
	//alert("Begin call doProcess()......");
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	 worknos = packet.data.findValueByName("worknos");
	//alert(retType);
	//alert(retCode);
	//alert(retMsg);
	if(retType=="getworknos"){
		if(retCode=="000000"){
			//alert("�ɹ���ȡ��ϯ�б���Ϣ!");
			//alert(worknos);
			fillDataTable(worknos,document.getElementById("dataTable"));
		}else{
			//alert("�޷���ȡ��ϯ�б���Ϣ!");
			return false;
		}
	}
	//alert("End call doProcess()......");
}

/*����mac��ַ����ñ���mac��ַ*/
function getWorkNos()
{
	//alert("Begin call getWorkNos()....");
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/innerHelp/get_work_nos.jsp","���ڻ�ȡ����������Ϣ,���Ժ�...");
    chkPacket.data.add("retType", "getworknos");
    chkPacket.data.add("org_id", "<%=request.getParameter("org_id")%>");
    chkPacket.data.add("class_id", "<%=request.getParameter("class_id")%>");
    chkPacket.data.add("skill_id", "<%=request.getParameter("skill_id")%>");
    chkPacket.data.add("staffstatus", "<%=request.getParameter("staffstatus")%>");
    chkPacket.data.add("endNum", "<%=request.getParameter("endNum")%>");
    core.ajax.sendPacket(chkPacket);
    //core.ajax.sendPacket(chkPacket,doProcessNew,true);
	//chkPacket =null;
	//alert("End call getWorkNos()....");
}


function fillDataTable(retData,tableid)
{
	for(var i=0;i<retData.length;i++){
	//������
	var tr=tableid.insertRow();
	tr.insertCell().innerHTML="<input type='radio' name='staff' value='"+retData[i][0]+"' onclick='setCallNo(this.value);' >";
	var color_str = '';
	if('ͨ��״̬'==retData[i][3]||'æ״̬'==retData[i][3]){
		 color_str='red';
	}else if('����״̬'==retData[i][3]||'Ӧ��״̬'==retData[i][3]){
		 color_str='blue';
	}else if('����״̬'==retData[i][3]){
		 color_str='green';
	}
	var td = tr.insertCell();
	//by libin 2009-05-09 �������ӵ�֪ͨ����
	td.innerHTML="<a href='<%=request.getContextPath()%>/npage/callbosspage/K084/K084_commNoteSend.jsp?loginno_call="+retData[0][0]+"' target='_blank'>"+retData[0][0]+"</font>";
	td.style.color = color_str;
	for(var j=1;j<=7;j++){
		//���ӱ��
		var str = "&nbsp;";
		if(retData[i][j] != ""){
		str = retData[i][j]
		}
		var td = tr.insertCell();
		td.innerHTML=str;
		td.style.color = color_str;
	}
	}
}

//ȫ�ֱ���,��������������a��ǩ,����Ϊfalse,��ʱ���ᵯ������֪ͨ����,���Ϊtrue��ִ�з���֪ͨ�Ĳ���,
var flag=true;
function setCallNo_modify(e){
	setCallNo(e.value);
	flag=false;
	changeBackground($(e).parents("tr").get(0));
}

function setCallNo(callNo)
{
	var strs = callNo.split(",");
	parent.document.getElementById("called_no_agent").value = strs[0];
	parent.document.getElementById("transagent").value = strs[1];
	parent.isRaidoClick = 1;
	/*comment by hucw,20100601
	var els=document.all("staff")
	for(var i=0;i<els.length;i++){
		if(els[i].checked){
		parent.document.getElementById("transagent").value=strs[1];
		}
	}*/
}

//add by hucw,20100915,ѡ�к󣬸ı䱳��ɫ��
function changeBackground(e)
{
	$("table tr").css("background","#F5F5F5");
	$(e).css("background","#00BFFF");	
}


function sendmsg(e){
	  if(flag){
	  	//add by hucw,20100915
			changeBackground(e);
			var iHeight=480;
			var iWidth =640;
			var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
			var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
			window.parent.opener.showMsg_temp=window.open("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_commNoteRecSend.jsp?sendWork="+e.value,"��֪ͨ",'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',scrollbars=auto, resizable=no,location=no, status=yes');
		}else{
			flag=true;
		}
}
</script>
