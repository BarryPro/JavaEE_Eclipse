
<%
  /*
   * 功能: 特殊名单
　 * 版本: 1.0
　 * 日期: 2009/10/28
　 * 作者: yinzx
　 * 版权: sitech
 　*/
 %>
 
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>

<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<html>
<head>
<style>
		img{
				cursor:hand;
		}
</style>	
<title>特殊名单维护</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="Calendar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<%!
 public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date()) + " " + str;
	}
	
	
%>
  

<script language="javascript">
    //居中打开窗口
		function openWinMid(url,name,iHeight,iWidth)
		{
		  //var url; //转向网页的地址;
		  //var name; //网页名称，可为空;
		  //var iWidth; //弹出窗口的宽度;
		  //var iHeight; //弹出窗口的高度;
		  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
		  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
		  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
		}
		

		
function getLoginNo(){
  openWinMid('k170_getLoginNo.jsp','工号查询',240,320);
}
			
//导出窗口
function showExpWin(flag){
	//var querysqln="select  ACCEPT_PHONE,CUST_NAME,specialtype_name,GRADE_CODE,end_date,nvl(SQ_LOGIN_NO,' '),nvl(op_login_no,' '),nvl(reason,' '),specialid from dcallspeciallist a ,scallspecialtype b ";
 
	//openWinMid('k197_expcur_rpc.jsp?querySql='+querysqln,'选择导出列',340,320);
	 window.sitechform.action="result.jsp?exp="+flag;
		 
   window.sitechform.method='post';
   window.sitechform.target = 'resultFrame';
   window.sitechform.submit();
}

function submitInputCheck(){
    
         hiddenTip(document.sitechform.start_date);
         hiddenTip(document.sitechform.end_date);
         hiddenTip(document.sitechform.accept_long_end);
         hiddenTip(document.getElementById('contact_id'));
         hiddenTip(document.getElementById('accept_login_no'));
         hiddenTip(document.getElementById('accept_phone'));

         submitMe('0');
    	 
}

 


function submitMe(flag){
   
   
    
			window.sitechform.action="result.jsp";
		 
   window.sitechform.method='post';
   window.sitechform.target = 'resultFrame';
   window.sitechform.submit();
}
function changeSize(typeA){
	
	var row;
	//全视图时
	if(document.getElementById('show_content_btn').style.display=='none')
		row = 270;
	else
		row = 145;
	
				if(typeA==1){
					parent.frames['frameset110'].rows=''+row+',*';
				}else if(typeA==2){
					parent.frames['frameset110'].rows='270,*';
				}else{
					parent.frames['frameset110'].rows='270,*';
			  }
}


function tochange()
{     
				var SPECIALTYPE_ID = document.all.SPECIALTYPE_ID[document.all.SPECIALTYPE_ID.selectedIndex].value;
				
				if(SPECIALTYPE_ID=="")
				{
					 document.all("6_=_A.BAK1").length=0;
					 document.all("6_=_A.BAK1").options.length=1;
					 document.all("6_=_A.BAK1").options[0].text="";
				   document.all("6_=_A.BAK1").options[0].value="";
					 return;
				}
				
				var myPacket = new AJAXPacket("select_rpc.jsp","正在获得信息，请稍候......");
				//update by tangsong 20100501 应该截前两位
				//var sqlStr = "  select  funcid SPECIALTYPE_ID, funcname SPECIALTYPE_name from scallspeciallist where is_leaf='Y' and is_del='N' and substr(funcid,0,1)=:SPECIALTYPE_ID     order by SPECIALTYPE_ID    ";
				var sqlStr = "  select  funcid SPECIALTYPE_ID, funcname SPECIALTYPE_name from scallspeciallist where is_leaf='Y' and is_del='N' and substr(funcid,0,2)=:SPECIALTYPE_ID     order by SPECIALTYPE_ID    ";
		    var para="SPECIALTYPE_ID="+SPECIALTYPE_ID;
		myPacket.data.add("sqlStr",sqlStr);
		myPacket.data.add("para",para);
		core.ajax.sendPacket(myPacket);
		 myPacket=null;
}


 function doProcess(packet)
  {
     
	  var triListData = packet.data.findValueByName("tri_list"); 
	  var triList=new Array(triListData.length);
 
        document.all("6_=_A.BAK1").length=0;
			  document.all("6_=_A.BAK1").options.length=triListData.length +1 ;//triListData[i].length;
			  document.all("6_=_A.BAK1").options[0].text='--全部--';
				document.all("6_=_A.BAK1").options[0].value='';
			  for(j=0;j<triListData.length;j++)
			  {
			  	 
				document.all("6_=_A.BAK1").options[j+1].text=triListData[j][1];
				document.all("6_=_A.BAK1").options[j+1].value=triListData[j][0];
			  } 
			  document.all("6_=_A.BAK1").options[0].selected=true;	  
		 
   }
   

</script>
</head>

<body>
	<% 
	    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
	 %>
<form id=sitechform name=sitechform>
	<input type="hidden" name="page" value="">
	<input type="hidden" name="myaction" value="doLoad">
	<input type="hidden" name="sqlFilter" value="">
	<input type="hidden" name="sqlWhere" value="">
	<div id="Operation_Table">		
		<table cellspacing="0" width="100%">
		<div class="title">
			<div id="title_zi">特殊名单</div>
		<!--	<div style='float:right;width:70px'>
			<a id='show_content_btn' href="#" onclick="showContent()">更多>></a>
			<a id='hide_content_btn' href="#" onclick="hideContent()" style='display:none'>更多<<</a>
			</div>  -->
		</div>
         <tr>
      <td class="blue" >特殊客户类别</td>
      <td>
				<select id="SPECIALTYPE_ID" name="0_=_a.SPECIALTYPE_ID"  onChange="tochange()">
		      <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>
								
select * from (select '' SPECIALTYPE_ID ,'--全部--'  SPECIALTYPE_name from dual union select  funcid SPECIALTYPE_ID, funcname SPECIALTYPE_name from dbcalladm.scallspeciallist where is_leaf='N' and is_del='N' and parfuncid = '0' ) order by SPECIALTYPE_ID  desc 
					 </wtc:sql>
				   </wtc:qoption>	
        </select>
      </td>
      
      <td class="blue"> 申请人帐号 </td>
      <td>
			  <input id="SQ_LOGIN_NO" name ="1_=_SQ_LOGIN_NO" type="text"   >
		    
 
		  </td> 
		  
		   <td class="blue"> 操作人 </td>
      <td  >
			  <input id="OP_LOGIN_NO" name ="2_=_OP_LOGIN_NO" type="text"   >
		    
 
		  </td> 
		      
		</tr>
		<tr>
			
			 <td class="blue"> 受理号码 </td>
      <td   >
			  <input id="ACCEPT_PHONE" name ="3_=_ACCEPT_PHONE" type="text"   >
		    
 
		  </td> 
		  
		  <td class="blue"> 客户名称 </td>
      <td   >
			  <input id="CUST_NAME" name ="4_like_CUST_NAME" type="text"   >
		    
 
		  </td> 
		  
      <td class="blue" >业务地市</td>
      <td>
				<select id="CITY_CODE" name="5_=_CITY_CODE" >
		      <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>
								select * from (select '' city_code ,'--全部--'  region_name from dual union select  city_code,region_name from scallregioncode where valid_flag='Y'   ) order by city_code  desc  </wtc:sql>
				   </wtc:qoption>	
        </select>
      </td>  
		</tr>
		
		<tr>
			
			 <td class="blue"> 客户类别等级 </td>
      <td  >
			  <select name="6_=_A.BAK1"   >
			  </select> 
			  
		    
		  </td> 
		  
		  <td class="blue"> 有效起始时间 </td>
      <td>
			   <input id="start_date" name ="start_date" type="text"  value="" onclick="showDateWithTime(this.parentNode.childNodes[0])">
		    <img onclick="showDateWithTime(this.parentNode.childNodes[0])" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
 
		  </td> 
		  
      <td class="blue" >有效结束时间</td>
      <td>
				 <input id="end_date" name ="end_date" type="text"  value=""   onclick="showDateWithTime(this.parentNode.childNodes[0])">
		    <img onclick="showDateWithTime(this.parentNode.childNodes[0])" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
 
   
      </td>  
		</tr>
    <tr >

      <td colspan="6" align="center" id="footer" style="width:600px"> 

       
       <input name="search" type="button" class="b_foot" id="search" value="查询" onClick="submitInputCheck();">
       <input name="delete_value" type="reset" class="b_foot"  id="add" value="重置">
       <input name="export" type="button" class="b_foot"  id="search" value="导入" onClick="beforeLoad();"%> 
      </td>
    </tr>
		</table>
	</div>
	</form>
	</body>
	
<script>
	
	function hideContent(){
		document.getElementById('show_content_btn').style.display='block';
		document.getElementById('hide_content_btn').style.display='none';
		document.getElementById('hidenSection').style.display='none';
		//$("#hidenSection").slideUp("fast"); 	
		parent.frames['frameset110'].rows='145,*';
	}
	function showContent(){
		document.getElementById('show_content_btn').style.display='none';
		document.getElementById('hide_content_btn').style.display='block';
		document.getElementById('hidenSection').style.display='block';
		//$("#hidenSection").slideDown("fast"); 	
		parent.frames['frameset110'].rows='270,*';	
	}
	
	function beforeLoad(){
		 
	 
			var time = new Date();
			var path='<%=request.getContextPath()%>/npage/callbosspage/K197/k197_loadPage.jsp?now=' + time;
			 
				
			var Height = window.screen.availHeight - 500; 
			var width  = window.screen.availWidth  - 500;
			var top    = (window.screen.availHeight-30 - Height)/2; //获得窗口的垂直位置;
			var left   = (window.screen.availWidth-10 - width)/2; //获得窗口的水平位置;
			var param  = 'height=' + Height + ',width=' + width + ',top=' + top + ',left=' + left + 
			             ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no';
			
			window.open(path, '导入特殊名单数据', param);	
}
</script>
