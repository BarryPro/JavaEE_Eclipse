<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
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
	String myParams="";
   String sqlStr="";
  if(endNum !=null && !endNum.equals("null") && !endNum.equals("")){
   
   sqlStr="select ccsworkno, decode(org_id, '01','������','02','�������','03','ĵ����','04','��ľ˹','05','˫Ѽɽ','06','��̨��','07','����','08','�׸�','09','����','10','�ں�','11','�绯','12','���˰���','13','����','15','��ػ�����','90','ʡ�ͷ�����'), login_no, decode(staffstatus,'12','����̬','13','���������̬','0','δǩ��','1','����״̬','2','Ԥռ��״̬','3','ռ��״̬','4','Ӧ��״̬','5','ͨ��״̬','6','����״̬','7','æ״̬','8','�����Ϣ̬','9','ѧϰ̬','10','����̬','11','ͨ������̬','14','����תIVR'), kf_name, class_id, duty from (select * from dstaffstatus  where 1=1  order by ccsworkno) where 1=1 ";
  }
  else{
   sqlStr= "select ccsworkno, decode(org_id, '01','������','02','�������','03','ĵ����','04','��ľ˹','05','˫Ѽɽ','06','��̨��','07','����','08','�׸�','09','����','10','�ں�','11','�绯','12','���˰���','13','����','15','��ػ�����','90','ʡ�ͷ�����'), login_no, decode(staffstatus,'12','����̬','13','���������̬','0','δǩ��','1','����״̬','2','Ԥռ��״̬','3','ռ��״̬','4','Ӧ��״̬','5','ͨ��״̬','6','����״̬','7','æ״̬','8','�����Ϣ̬','9','ѧϰ̬','10','����̬','11','ͨ������̬','14','����תIVR'), kf_name, class_id, duty from dstaffstatus where 1=1 ";
  	}
  
  if(org_id !=null && !org_id.equals("null") && !org_id.equals("")){
       sqlStr += "and org_id =:org_id ";
       myParams = "org_id="+org_id+",";
   }
   if(class_id !=null && !class_id.equals("null") && !class_id.equals("")){
   	   if(class_id.equals("������1")){
       class_id="������";
       sqlStr+="and  (mainccs like '10.204.155%' or backccs like '10.204.155%') ";
        sqlStr += "and  class_id like '%'||:class_id ||'%'  ";
        myParams = myParams + ",class_id="+class_id;
      } 
     else if(class_id.equals("������2")) {
    	 class_id="������";
    	 sqlStr+="and  (mainccs like '10.204.201%' or backccs like '10.204.201%') ";
       sqlStr += "and  class_id like '%'||:class_id||'%'   ";
       myParams = myParams + ",class_id="+class_id;
    	}
     else if(class_id.equals("������һ�ͷ��༼����")){
    	 sqlStr+="and  (mainccs like '10.204.155%' or backccs like '10.204.155%') ";
       sqlStr += "and  class_id=:class_id ";
       myParams = myParams + ",class_id="+class_id;
    	}
     else if(class_id.equals("�����ж��ͷ��༼����")){
    	 sqlStr+="and  (mainccs like '10.204.201%' or backccs like '10.204.201%') ";
       sqlStr += "and  class_id=:class_id ";
       myParams = myParams + ",class_id="+class_id;
    	}
     else if (class_id.equals("���еش�2")){
    	  class_id="���еش�";
    	 sqlStr+="and  (mainccs like '10.204.201%' or backccs like '10.204.201%') ";
        sqlStr += "and  class_id like '%'||:class_id||'%'   ";
        myParams = myParams + ",class_id="+class_id;
    	}
     else if (class_id.equals("���еش�1")){
    	  class_id="���еش�";
    	 sqlStr+="and  (mainccs like '10.204.155%' or backccs like '10.204.155%') ";
        sqlStr += "and  class_id like '%'||:class_id||'%' ";
        myParams = myParams + ",class_id="+class_id;
    	}
     else if (class_id.equals("��ͨȫ��ͨ1")){
    	   class_id="��ͨȫ��ͨ";
    	   sqlStr+="and  (mainccs like '10.204.155%' or backccs like '10.204.155%') ";
          sqlStr += "and  class_id like '%'||:class_id||'%' ";
          myParams = myParams + ",class_id="+class_id;
    	 
    	}
     else if(class_id.equals("��ͨȫ��ͨ2")){
    	  class_id="��ͨȫ��ͨ";
    	  sqlStr+="and  (mainccs like '10.204.201%' or backccs like '10.204.201%') ";
         sqlStr += "and  class_id like '%'||:class_id||'%' ";
         myParams = myParams + ",class_id="+class_id;
     } 
     else{
    	   sqlStr += "and  class_id like '%'||:class_id||'%' ";
    	   myParams = myParams + ",class_id="+class_id;
    	} 
   }
   if(staffstatus !=null && !staffstatus.equals("null") && !staffstatus.equals("")){
   	   sqlStr += " and staffstatus =:staffstatus ";
   	   myParams = myParams + ",staffstatus="+staffstatus;
   }    
   if(endNum !=null && !endNum.equals("null") && !endNum.equals("")){
   	   sqlStr += " and rownum <=:endNum ";
   	   myParams = myParams + ",endNum="+endNum;
   }
	 sqlStr += " order by ccsworkno ";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="7">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" start="0" length="7">
<%
retData = queryList;
%>
</wtc:array>
<head>
<title>��ϯ�б�</title>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
</head>
<!--
<body onload="getWorkNos();">
-->
<form  name=formbar>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top">
    <div id="Operation_Table">
      <table id="dataTable" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td class="blue">ѡ��</td>
        <td class="blue">����</td>
        <td class="blue">����</td>
        <td class="blue">BOSS����</td>
        <td class="blue">״̬</td>
        <td class="blue">����</td>
        <td class="blue">����</td>
        <!--<td class="blue">������</td>-->
        <td class="blue">�೤</td>
      </tr>
      <%
      	if(retData.length > 0){
      		for(int i = 0; i < retData.length; i++){
      %>
      <tr>
      	<td><input type="radio" name="staff" value="<%=retData[i][0]%>,<%=retData[i][2]%>" onclick="setCallNo(this.value);" ></td>
      	
      <%      	
      			int j = 0;
      			for(; j < retData[i].length; j++){
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
							<td style="color:<%=color_str %> "><a href='#' value=<%=retData[i][2]%> onclick='sendmsg(this.value);'><font color=<%=color_str %>><%=retData[i][j]%></font></td>
							<%		    	
							}	else{
							%>
							<td style="color:<%=color_str %> "><%=retData[i][j]%></td>
							<%  
							}			
      			}
      %>
      </tr>
      <%		
      		}
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
    for(var j=0;j<=7;j++){
      //���ӱ��
      
      //Ϊ�ղ���td��&nbsp; by libin 2009-05-17
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

function setCallNo(callNo)
{
	var strs = callNo.split(",");
parent.document.getElementById("called_no_agent").value = strs[0];
parent.document.getElementById("transagent").value = strs[1];
 var els=document.all("staff")
 for(var i=0;i<els.length;i++){
   if(els[i].checked){
   parent.document.getElementById("transagent").value=strs[1];
   }
 }

}
function sendmsg(value){
	window.parent.sendmsg(value);
}

</script>



