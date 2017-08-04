<%
  /*
   * 功能: 坐席列表页面
　 * 版本: 1.0.0
　 * 日期: 2008/10/20
　 * 作者: mixh
　 * 版权: sitech
   *update:
　*/
%>

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
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
   sqlStr="select ccsworkno, decode(org_id, '01','哈尔滨','02','齐齐哈尔','03','牡丹江','04','佳木斯','05','双鸭山','06','七台河','07','鸡西','08','鹤岗','09','伊春','10','黑河','11','绥化','12','大兴安岭','13','大庆','15','异地或它网','90','省客服中心'), login_no, decode(staffstatus,'12','放音态','13','插入或旁听态','0','未签入','1','空闲状态','2','预占用状态','3','占用状态','4','应答状态','5','通话状态','6','工作状态','7','忙状态','8','请假休息态','9','学习态','10','调整态','11','通话保持态','14','挂起转IVR'), kf_name, class_id, duty from (select * from dstaffstatus  where 1=1  order by ccsworkno) where 1=1 ";
  }
  else{
   sqlStr= "select ccsworkno, decode(org_id, '01','哈尔滨','02','齐齐哈尔','03','牡丹江','04','佳木斯','05','双鸭山','06','七台河','07','鸡西','08','鹤岗','09','伊春','10','黑河','11','绥化','12','大兴安岭','13','大庆','15','异地或它网','90','省客服中心'), login_no, decode(staffstatus,'12','放音态','13','插入或旁听态','0','未签入','1','空闲状态','2','预占用状态','3','占用状态','4','应答状态','5','通话状态','6','工作状态','7','忙状态','8','请假休息态','9','学习态','10','调整态','11','通话保持态','14','挂起转IVR'), kf_name, class_id, duty from dstaffstatus where 1=1 ";
  	}
  	
  if(noNatural != null && "Y".equals(noNatural)){  	
  		sqlStr += " and (staffstatus = '6' or staffstatus = '7' or staffstatus = '8' or staffstatus = '9' or staffstatus = '10') ";  
  }
  if(org_id !=null && !org_id.equals("null") && !org_id.equals("")){
     sqlStr += "and org_id =:org_id ";
     myParams = "org_id="+org_id ;
	}
	if(class_id !=null && !class_id.equals("null") && !class_id.equals("")){
	    if(class_id.equals("神州行1")){
       class_id="神州行";
       sqlStr+="and  (mainccs like '10.204.155%' or backccs like '10.204.155%') ";
        sqlStr += "and  class_id like '%'||:class_id||'%' ";
        if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        	}
        
      } 
     else if(class_id.equals("神州行2")) {
    	 class_id="神州行";
    	 sqlStr+="and  (mainccs like '10.204.201%' or backccs like '10.204.201%') ";
       sqlStr += "and  class_id like '%'||:class_id||'%'  ";
       if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        	}
    	}
     else if(class_id.equals("神州行一客服多技能组")){
    	 sqlStr+="and  (mainccs like '10.204.155%' or backccs like '10.204.155%') ";
       sqlStr += "and  class_id=:class_id ";
       if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        	}
    	}
     else if(class_id.equals("神州行二客服多技能组")){
    	 sqlStr+="and  (mainccs like '10.204.201%' or backccs like '10.204.201%') ";
       sqlStr += "and  class_id=:class_id ";
       if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        	}
    	}
     else if (class_id.equals("动感地带2")){
    	  class_id="动感地带";
    	 sqlStr+="and  (mainccs like '10.204.201%' or backccs like '10.204.201%') ";
        sqlStr += "and  class_id like '%'||:class_id||'%'  ";
        if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        	}
    	}
     else if (class_id.equals("动感地带1")){
    	  class_id="动感地带";
    	 sqlStr+="and  (mainccs like '10.204.155%' or backccs like '10.204.155%') ";
        sqlStr += "and  class_id like  '%'||:class_id||'%'  ";
        if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        	}
    	}
     else if (class_id.equals("普通全球通1")){
    	   class_id="普通全球通";
    	   sqlStr+="and  (mainccs like '10.204.155%' or backccs like '10.204.155%') ";
          sqlStr += "and  class_id like  '%'||:class_id||'%'   ";
    	 	if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        }
    	}
     else if(class_id.equals("普通全球通2")){
    	  class_id="普通全球通";
    	  sqlStr+="and  (mainccs like '10.204.201%' or backccs like '10.204.201%') ";
        sqlStr += "and  class_id like  '%'||:class_id||'%'  ";
        if(myParams.equals("")){
        	myParams += "class_id="+class_id ;
        }else{
        	myParams += ",class_id="+class_id ;
        } 
     } //以上所有判断吉林不使用
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
<title>坐席列表</title>
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
      	<td class="blue">选择</td>
        <td class="blue">工号</td>
       
        <td class="blue">地市</td>
        <td class="blue">BOSS工号</td>
        <td class="blue">状态</td>
        <td class="blue">姓名</td>
        <td class="blue">班组</td>        
        <td class="blue">班长</td>
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
      				if("通话状态".equals(retData[i][3])||"忙状态".equals(retData[i][3])){
					    	 color_str="red";
					    }else if("工作状态".equals(retData[i][3])||"应答状态".equals(retData[i][3])){
					    	 color_str="blue";
					    }else if("空闲状态".equals(retData[i][3])){
					    	 color_str="green";
					    }
			%>
			
			<%  	
      			int j = 0;
      			for(; j < retData[i].length; j++){

					    if(j == 2){
			%>
			<td style="color:<%=color_str %> "><a href="<%=request.getContextPath()%>/npage/callbosspage/K084/K084_commNoteSend.jsp?loginno_call=<%=retData[i][j]%>" target="_blank" title="发通知"><%=retData[i][j]%></font></td>
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
	//选中行高亮显示
		var hisObj="";//保存上一个变色对象
		var hisColor=""; //保存上一个对象原始颜色
		/**
   *hisColor ：当前tr的className
   *obj       ：当前tr对象
   */
		function changeColor(color,obj,val){
		
		  //恢复原来一行的样式
		  if(hisObj != ""){
			 for(var i=0;i<hisObj.cells.length;i++){
				var tempTd=hisObj.cells.item(i);
				tempTd.className=hisColor;
			 }
			}
				hisObj   = obj;
				hisColor = color;
		
		  //设置当前行的样式
			for(var i=0;i<obj.cells.length;i++){
				var tempTd=obj.cells.item(i);
				tempTd.className='bright';
			}
			obj.cells.item(0).children.item(0).checked = true;
			parent.document.getElementById("called_no_agent").value = val;
		}
</script>
