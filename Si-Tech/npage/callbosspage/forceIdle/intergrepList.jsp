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
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String[][] retData = new String[][] {};
	String region=request.getParameter("org_id");
	String brand=request.getParameter("class_id");
	String skill=request.getParameter("skill_id");
	String staffstatus=request.getParameter("staffstatus");
	String lineNum=request.getParameter("endNum");
	
  String org_id = request.getParameter("org_id");
  String class_id = request.getParameter("class_id");
  String skill_id = request.getParameter("skill_id");
  
  String endNum = request.getParameter("endNum");
  String noNatural = request.getParameter("noNatural")==null?"":request.getParameter("noNatural");
  String sqlStr="";
  if(endNum !=null && !endNum.equals("null") && !endNum.equals("")){
   sqlStr="select ccsworkno, decode(org_id, '01','������','02','�������','03','ĵ����','04','��ľ˹','05','˫Ѽɽ','06','��̨��','07','����','08','�׸�','09','����','10','�ں�','11','�绯','12','���˰���','13','����','15','��ػ�����','90','ʡ�ͷ�����'), login_no, decode(staffstatus,'12','����̬','13','���������̬','0','δǩ��','1','����״̬','2','Ԥռ��״̬','3','ռ��״̬','4','Ӧ��״̬','5','ͨ��״̬','6','����״̬','7','æ״̬','8','�����Ϣ̬','9','ѧϰ̬','10','����̬','11','ͨ������̬','14','����תIVR'), kf_name, class_id, duty from (select * from dstaffstatus  where 1=1  order by ccsworkno) where 1=1 ";
  }
  else{
   sqlStr= "select ccsworkno, decode(org_id, '01','������','02','�������','03','ĵ����','04','��ľ˹','05','˫Ѽɽ','06','��̨��','07','����','08','�׸�','09','����','10','�ں�','11','�绯','12','���˰���','13','����','15','��ػ�����','90','ʡ�ͷ�����'), login_no, decode(staffstatus,'12','����̬','13','���������̬','0','δǩ��','1','����״̬','2','Ԥռ��״̬','3','ռ��״̬','4','Ӧ��״̬','5','ͨ��״̬','6','����״̬','7','æ״̬','8','�����Ϣ̬','9','ѧϰ̬','10','����̬','11','ͨ������̬','14','����תIVR'), kf_name, class_id, duty from dstaffstatus where 1=1 ";
  	}
  	
  if(noNatural != null && "Y".equals(noNatural)){  	
  		sqlStr += " and (staffstatus = '6' or staffstatus = '7' or staffstatus = '8' or staffstatus = '9' or staffstatus = '10') ";  
  }
  if(org_id !=null && !org_id.equals("null") && !org_id.equals("")){
     sqlStr += "and org_id =:org_id ";
     myParams = "org_id="+org_id ;
	}
	if(class_id !=null && !class_id.equals("null") && !class_id.equals("")){
	    if(class_id.equals("������1")){
       class_id="������";
       sqlStr+="and  (mainccs like '10.204.155%' or backccs like '10.204.155%') ";
        sqlStr += "and  class_id like '%'||:class_id||'%' ";
        if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        	}
        
      } 
     else if(class_id.equals("������2")) {
    	 class_id="������";
    	 sqlStr+="and  (mainccs like '10.204.201%' or backccs like '10.204.201%') ";
       sqlStr += "and  class_id like '%'||:class_id||'%'  ";
       if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        	}
    	}
     else if(class_id.equals("������һ�ͷ��༼����")){
    	 sqlStr+="and  (mainccs like '10.204.155%' or backccs like '10.204.155%') ";
       sqlStr += "and  class_id=:class_id ";
       if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        	}
    	}
     else if(class_id.equals("�����ж��ͷ��༼����")){
    	 sqlStr+="and  (mainccs like '10.204.201%' or backccs like '10.204.201%') ";
       sqlStr += "and  class_id=:class_id ";
       if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        	}
    	}
     else if (class_id.equals("���еش�2")){
    	  class_id="���еش�";
    	 sqlStr+="and  (mainccs like '10.204.201%' or backccs like '10.204.201%') ";
        sqlStr += "and  class_id like '%'||:class_id||'%'  ";
        if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        	}
    	}
     else if (class_id.equals("���еش�1")){
    	  class_id="���еش�";
    	 sqlStr+="and  (mainccs like '10.204.155%' or backccs like '10.204.155%') ";
        sqlStr += "and  class_id like  '%'||:class_id||'%'  ";
        if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        	}
    	}
     else if (class_id.equals("��ͨȫ��ͨ1")){
    	   class_id="��ͨȫ��ͨ";
    	   sqlStr+="and  (mainccs like '10.204.155%' or backccs like '10.204.155%') ";
          sqlStr += "and  class_id like  '%'||:class_id||'%'   ";
    	 	if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        }
    	}
     else if(class_id.equals("��ͨȫ��ͨ2")){
    	  class_id="��ͨȫ��ͨ";
    	  sqlStr+="and  (mainccs like '10.204.201%' or backccs like '10.204.201%') ";
        sqlStr += "and  class_id like  '%'||:class_id||'%'  ";
        if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        } 
     } //���������жϼ��ֲ�ʹ��
     else{
    	   sqlStr += "and  class_id like  '%'||:class_id||'%' ";
    	   if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        }
    	} 	  
	}
	if(staffstatus !=null && !staffstatus.equals("null") && !staffstatus.equals("")){
	  sqlStr += " and staffstatus =:staffstatus ";
	  if(myParams.equals("")){
        	myParams += "staffstatus="+staffstatus ;
        }else{
        	myParams += ",staffstatus="+staffstatus ;
        }
	}    
	if(endNum !=null && !endNum.equals("null") && !endNum.equals("")){
	  sqlStr += " and rownum <=:endNum ";
	  if(myParams.equals("")){
        	myParams += "endNum="+endNum ;
        }else{
        	myParams += ",endNum="+endNum ;
        }
	}
   sqlStr += " order by ccsworkno ";
	
%>



<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="7">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" start="0" length="7">

<%
retData = queryList;
%>
</wtc:array>

<html>
<head>
<title>��ϯ�б�</title>
<META http-equiv=Content-Type content="text/html; charset=GBK">
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
      	<td class="blue">ѡ��</td>
        <td class="blue">����</td>
       
        <td class="blue">����</td>
        <td class="blue">BOSS����</td>
        <td class="blue">״̬</td>
        <td class="blue">����</td>
        <td class="blue">����</td>        
        <td class="blue">�೤</td>
      </tr>
      <%
        String tdClass = "";
      	if(retData.length > 0){
      		for(int i = 0; i < retData.length; i++){
      			if((i+1)%2==1){
	          	tdClass="grey";
	          }
      %>
      <tr onClick="changeColor('<%=tdClass%>',this,'<%=retData[i][0] %>');"  onDblClick="parent.dbonclickcanle('<%=retData[i][0] %>');"  style="cursor:hand">      	
      	<td><input type="radio" name="staff" value="<%=retData[i][0]%>,<%=retData[i][2]%>" onclick="setCallNo(this.value);" ></td>
      <%    
      			  String color_str = "";
      				if("ͨ��״̬".equals(retData[i][3])||"æ״̬".equals(retData[i][3])){
					    	 color_str="red";
					    }else if("����״̬".equals(retData[i][3])||"Ӧ��״̬".equals(retData[i][3])){
					    	 color_str="blue";
					    }else if("����״̬".equals(retData[i][3])){
					    	 color_str="green";
					    }
			%>
			
			<%  	
      			int j = 0;
      			for(; j < retData[i].length; j++){

					    if(j == 2){
			%>
			<td style="color:<%=color_str %> "><a href="<%=request.getContextPath()%>/npage/callbosspage/K084/K084_commNoteSend.jsp?loginno_call=<%=retData[i][j]%>" target="_blank" title="��֪ͨ"><%=retData[i][j]%></font></td>
			<%		    	
					  	}else{
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
	<%
	if(retData.length > 0){
	%>
	parent.document.getElementById("called_no_agent").value = <%=retData[0][0] %>;
	<%	
	}
 else{
	%>
	parent.document.getElementById("called_no_agent").value="";
	<%
	}
	%>
	
function setCallNo(callNo)
{
	var strs = callNo.split(",");
parent.document.getElementById("called_no_agent").value = strs[0];
parent.document.getElementById("transagent").value = strs[1];
parent.isRaidoClick = 1;
 var els=document.all("staff")
 for(var i=0;i<els.length;i++){
   if(els[i].checked){
   parent.document.getElementById("transagent").value=strs[1];
   }
 }

}	
	//ѡ���и�����ʾ
		var hisObj="";//������һ����ɫ����
		var hisColor=""; //������һ������ԭʼ��ɫ
		/**
   *hisColor ����ǰtr��className
   *obj       ����ǰtr����
   */
		function changeColor(color,obj,val){
		
		  //�ָ�ԭ��һ�е���ʽ
		  if(hisObj != ""){
			 for(var i=0;i<hisObj.cells.length;i++){
				var tempTd=hisObj.cells.item(i);
				tempTd.className=hisColor;
			 }
			}
				hisObj   = obj;
				hisColor = color;
		
		  //���õ�ǰ�е���ʽ
			for(var i=0;i<obj.cells.length;i++){
				var tempTd=obj.cells.item(i);
				tempTd.className='bright';
			}
			obj.cells.item(0).children.item(0).checked = true;
			parent.document.getElementById("called_no_agent").value = val;
		}
</script>
