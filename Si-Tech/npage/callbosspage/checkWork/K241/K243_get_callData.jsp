<%
  /*
	* ����: ȡ��ͨ������
	* �汾: 1.0.0
	* ����: 2011/07/05
	* ����: tangsong
	* ��Ȩ: sitech
	*/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dth XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dth/xhtml1-transitional.dth">
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient,java.util.*,java.text.SimpleDateFormat"%>
<%
	//20120213 by wench
  String caller=request.getParameter("caller_phone");
  String accept_login_no = request.getParameter("accept_login_no");
 	String Contact_id = request.getParameter("Contact_id");
 	String accept_long_begin = request.getParameter("accept_long_begin");
 	String accept_long_end = request.getParameter("accept_long_end");
  String beginTime = request.getParameter("beginTime"); 
  String endTime = request.getParameter("endTime");
  System.out.println("wench:"+beginTime+"********************");
  System.out.println("wench:"+endTime+"********************");
  System.out.println("wench:"+accept_login_no+"********************");
  System.out.println("wench:"+accept_long_begin+"********************");
  System.out.println("wench:"+accept_long_end+"********************");
  System.out.println("wench:"+Contact_id+"********************");
  if(beginTime!=null&&!"".equals(beginTime)){
  String begin_time=beginTime.substring(4,6);
  String end_time=endTime.substring(4,6);
  System.out.println("wench:"+begin_time+"********************");
  System.out.println("wench:"+end_time+"********************");
  }
  
%>
<%
	  String assignId = WtcUtil.repNull(request.getParameter("assignId"));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		Calendar c = Calendar.getInstance();
		String thisMonth = sdf.format(c.getTime()); //����
		c.add(c.MONTH, -1);
		String lastMonth = sdf.format(c.getTime()); //����
	int rowCount =0; //���ϲ�ѯ�������ܼ�¼��
	int pageSize = 15; //ÿҳ��¼��
	int pageCount = 0; //��ҳ��
	int curPage = 0; //��ǰҳ��
	int sumTime= 0;//�ܼ�ʱ��
	String strPage = WtcUtil.repNull(request.getParameter("page")); //��תҳ��
	String clikcdate= WtcUtil.repNull(request.getParameter("clickdata"));//�Զ�����ʱ��¼��ѡ������
	String qclickcdate= WtcUtil.repNull(request.getParameter("qclickcdate"));//�ֶ����븺���¼����
		//add by songjia .20100914
  String sort_sql = "begin_date asc";
  String orderColumn = request.getParameter("orderColumn")==null?"":request.getParameter("orderColumn");
  String orderCode = request.getParameter("orderCode")==null?"":request.getParameter("orderCode");
  if (!orderColumn.equals("") && !orderCode.equals("")) {
  	sort_sql = orderColumn + " " + orderCode;
 	}
 	
 	
	String[][] dataRows = new String[][]{};

	if ("".equals(assignId)) {
		pageCount = 0;
	} else {

		String[] tablenames = new String[]{"dcallcall"+thisMonth, "dcallcall"+lastMonth};
		String flag_no="1";
		Map pMap = new HashMap();
		pMap.put("assignId", assignId);
		pMap.put("tablenames", tablenames);
		pMap.put("flag_no", flag_no);
    pMap.put("sort_sql",sort_sql);
    //20120213 by wench
    if(caller!=null&&!"".equals(caller)){
        pMap.put("caller",caller);
    }
    if(accept_login_no!=null&&!"".equals(accept_login_no)){
        pMap.put("accept_login_no",accept_login_no);
    }
    if(Contact_id!=null&&!"".equals(Contact_id)){
        pMap.put("contact_id",Contact_id);
    }
    if(beginTime!=null&&!"".equals(beginTime)){
        pMap.put("beginTime",beginTime);
    }
  	if(endTime!=null&&!"".equals(endTime)){
    		pMap.put("endTime",endTime);
    }
    if(accept_long_begin!=null&&!"".equals(accept_long_begin)){
    		pMap.put("accept_long_begin",accept_long_begin);
    }
    if(accept_long_end!=null&&!"".equals(accept_long_end)){
    		pMap.put("accept_long_end",accept_long_end);
    }
		rowCount = ((Integer)KFEjbClient.queryForObject("query_K243_countCallData",pMap)).intValue();
		// sumTime = ((Integer)KFEjbClient.queryForObject("query_K243_sumCallData",pMap)).intValue();
		
		if (strPage.equals("")) {
			curPage = 1;
		}else {
			curPage = Integer.parseInt(strPage);
		  	if(curPage < 1) {
		  		curPage = 1;
		  	}
		}
		pageCount = (rowCount + pageSize - 1) / pageSize;
		if (curPage > pageCount) {
			curPage = pageCount;
		}
		int start = (curPage - 1) * pageSize + 1;
		int end = curPage * pageSize;

		pMap.put("start", ""+start);
		System.out.println(rowCount);
		
		pMap.put("end", ""+end);
		System.out.println(end);
		pMap.put("sort_sql",sort_sql);
		List resultList = KFEjbClient.queryForList("query_K243_getCallData",pMap);
		dataRows = getArrayFromListMap(resultList,1,28);
	}
%>

<%!
public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
				Calendar cal = Calendar.getInstance();
    //nΪ�Ƴٵ�������1���ܣ�-1��ǰ�Ƴ�һ�ܣ�2���ܣ���������
    int n = -1;
    cal.add(Calendar.DATE, n*7);
    if(str.equals("00:00:00")){
		return objSimpleDateFormat.format(cal.getTime())+" "+str;
		}else{
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
		}
	}
%>

<html>
<head>
<title>��ˮ����ִ��</title>
<style type="text/css">
	.mydiv {
		border:1px solid #99CCFF;
	}
	.mydiv th, .mydiv td {
		text-align:center;
	}
	#Operation_Table td {
		text-indent:0;
	}
</style>
<script type="text/javascript">
$(document).ready(
	function()
	{
    	$("td").not("[input]").addClass("Blue");
		$("#footer input:button").addClass("b_foot");
		$("td:not(#footer) input:button").addClass("b_text");

		$("a").hover(function() {
			$(this).css("color", "orange");
		}, function() {
			$(this).css("color", "#159ee4");
		});
		$("input[type='text']").css("line-height","16px");
		window.parent.setCheckboxStatus1();
	}
);


//ѡ���и�����ʾ
var hisObj="";//������һ����ɫ����
var hisColor=""; //������һ������ԭʼ��ɫ
function changeColor(color,obj){
	//�ָ�ԭ��һ�е���ʽ
	if(hisObj != ""){
		for(var i=0;i<hisObj.cells.length;i++){
			var tempTd=hisObj.cells.item(i);
			//tempTd.className=hisColor; ��ԭ�ֵ���ɫ
			tempTd.style.backgroundColor = '#F7F7F7';		//��ԭ�б�����ɫ
		}
	}
	hisObj   = obj;
	hisColor = color;
	//���õ�ǰ�е���ʽ
	for(var i=0;i<obj.cells.length;i++){
		var tempTd=obj.cells.item(i);
		//tempTd.className='green'; �ı��ֵ���ɫ
		tempTd.style.backgroundColor='#00BFFF';	//�ı��б�����ɫ
	}
}


function putvaluea(a) {

	if (rdShowConfirmDialog("��ȷ��Ҫȥ���Դ���ˮ���ʼ���") == 0) {
		return;
	}
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K241/K243_getdata_add_do.jsp","");
	packet.data.add("contact_id", a);
	core.ajax.sendPacket(packet,doProcessAdd,false);
	packet=null;
}

function doProcessAdd(packet) {
	var result = packet.data.findValueByName("result");
	if (result == "success") {
		window.top.similarMSNPop("����ɹ���");
		window.sitechform.submit();
	} else {
		window.top.similarMSNPop("����ʧ�ܣ�");
	}
}

//��ҳ����
function doLoad(operateCode){
	if(operateCode=="load"){
		window.sitechform.page.value = "";
	}else if(operateCode=="first"){
		window.sitechform.page.value=1;
	}else if(operateCode=="pre"){
		window.sitechform.page.value=<%=(curPage-1)%>;
	}else if(operateCode=="next"){
		window.sitechform.page.value=<%=(curPage+1)%>;
	}else if(operateCode=="last"){
		window.sitechform.page.value=<%=pageCount%>;
	}
	submitMe();
}

//��ת��ָ��ҳ��
 function jumpToPage(operateCode){
	 if(operateCode=="jumpToPage")
   {
   	  var thePage=document.getElementById("thePage").value;
   	  if(thePage!=""){
   		 window.sitechform.page.value=parseInt(thePage);
   		 doLoad('0');
   	  }
   }
   else if(operateCode=="jumpToPage1")
   {
   	  var thePage=document.getElementById("thePage").value;
   	  if(thePage!=""){
   		 window.sitechform.page.value=parseInt(thePage);
       doLoad('0');
      }
   }else if(operateCode!=""){
   	 window.sitechform.page.value=parseInt(operateCode);
   	 doLoad('0');
   }
 }

 //�ύ��ѯ����
function submitMe(){
	  if( document.sitechform.beginTime.value == "")
		   {		
		    	   showTip(document.sitechform.beginTime,"��ʼʱ�䲻��Ϊ��"); 
		    	   sitechform.beginTime.focus(); 	
		   }
		   else if(document.sitechform.endTime.value == "")
		   {
				     showTip(document.sitechform.endTime,"����ʱ�䲻��Ϊ��"); 
		    	   sitechform.endTime.focus(); 	
		   }else if(document.sitechform.endTime.value<=document.sitechform.beginTime.value)
		   {
				     showTip(document.sitechform.endTime,"����ʱ�������ڿ�ʼʱ��"); 
		    	   sitechform.endTime.focus();	
    }
   else {
	 			window.sitechform.myaction.value='doLoad';
	 			parent.document.getElementById("flag").value='1';
   			window.sitechform.action="K243_get_callData.jsp?";
   			window.sitechform.method='post';
   			window.sitechform.submit();
   		}
    

}

function chooseAll(obj) {
	if (obj.checked) {
		
		var callDataBox=document.getElementsByName("callDataBox");
		 for (var k = 0;k < callDataBox.length; k++) {
		 	var tempdata=callDataBox[k].value;
		 		var fg=0;
				for(var i=0;i<arry.length;i++)
				{
					if(arry[i]==tempdata)
					{	
					arry.splice(i,1);				
					break;
				  }
			  }
			  document.getElementById("clickdata").value=arry;
		}
		
		$("input[type='checkbox']").attr("checked","checked");
	} else {
		
		 var callDataBox=document.getElementsByName("callDataBox");
		 for (var k = 0;k < callDataBox.length; k++) {
		 	var tempdata=callDataBox[k].value;
		 		var fg=0;
				for(var i=0;i<arry.length;i++)
				{
					if(arry[i]==tempdata)
					{					
					fg=1;
					break;
				  }
			  }
			  if(fg==0)
			  {
			  	arry.push(tempdata);
			  }
			  document.getElementById("clickdata").value=arry;
		}
		$("input[type='checkbox']").attr("checked","");
	}
	
	
}
function submitInputCheck(orderColumn, orderCode){
				window.sitechform.orderColumn.value=orderColumn;
				window.sitechform.orderCode.value=orderCode;
				submitMe('0','0','0');
}

</script>
</head>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>	
<form name="sitechform" id="sitechform">
<input type="hidden" name="myaction" value="" />
<input type="hidden" name="page" value="<%=curPage%>" />
<input type="hidden" name = "clickdata" value="<%=clikcdate%>">
<input type="hidden" name = "qclickcdate" id="qclickcdate" value="<%=qclickcdate%>">
<input type="hidden" name="assignId" value="<%=assignId%>" />
	<!-- added by tancf 20100331 �������� -->
	<input type="hidden" name="orderColumn" id="orderColumn" value="" />
	<input type="hidden" name="orderCode" id="orderCode" value="" />

<div id="Operation_Table">

		<table wcellspacing="0">	
	 				<tr>
      				<td align="right" class="blue"  nowrap> ��ʼʱ�䣺</td>
      				<td nowrap>
							<input  id="beginTime" name="beginTime" type="text" value="<%=(beginTime==null)?getCurrDateStr("00:00:00"):beginTime%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(beginTime==null)?"":beginTime%>">
	        		<img onclick="WdatePicker({el:$dp.$('beginTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	        		<font color="orange">*</font>
							</td>
      				<td align="right" class="blue"  nowrap> ������룺</td>
      				<td>
      					<input name ="caller_phone" type="text" id="caller_phone" onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"  value="<%=caller==null?"":caller%>" maxlength="11">     					
      				</td>
      				<td align="right" class="blue"  nowrap> ������ˮ�ţ�</td>
      				<td>
      					<input name ="Contact_id" type="text" id="Contact_id" value="<%=Contact_id==null?"":Contact_id%>" >
      				</td>
		    	 </tr>
		    	 <tr >
		    		  <td align="right" class="blue"  nowrap> ����ʱ�䣺</td>
     				  <td nowrap>
			 				<input id="endTime" name ="endTime" type="text"  value="<%=(endTime==null)?getCurrDateStr("23:59:59"):endTime%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endTime);">
		    			<img onclick="WdatePicker({el:$dp.$('endTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    			<font color="orange">*</font>
		    			</td>
		    			<td align="right" class="blue"  nowrap> ����ʱ����</td>
      				<td>
      					>=<input name ="accept_long_begin" type="text" id="accept_long_begin"  maxlength="5" style="width:5.5em" value="<%=accept_long_begin==null?"":accept_long_begin%>" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
			          <=<input name ="accept_long_end" type="text" id="accept_long_end"      maxlength="5" style="width:5.5em"  value="<%=accept_long_end==null?"":accept_long_end%>" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
      				</td>
							<td align="right" class="blue"  nowrap> �������ţ�</td>
      				<td>
      					<input name ="accept_login_no" type="text" id="accept_login_no" value="<%=accept_login_no==null?"":accept_login_no%>">
      				</td>
		</tr>	
		<tr >
       <td colspan="6" align="center" id="footer" style="width:420px" nowrap >
       <input name="search" type="button" class="b_foot"  id="search" value="��ѯ" onClick="doLoad('0')">	
       <input name="delete_value" type="button" class="b_foot"  id="add" value="����" onClick="Reset()" >
       </td>
   	</tr>
		</table>
		</form>
	<table>
	   <tr>
	      <td class="blue" align="left" colspan="28">
	        <%if(pageCount!=0){%>
	        ��<%=curPage%>ҳ ��<%=pageCount%>ҳ ��<%=rowCount%>��
	        
	        <%} else{%>
	        <font color="orange">��ǰ��¼Ϊ�գ�</font>
	        <%}%>
	        <%if(pageCount!=1 && pageCount!=0){%>
	        <a href="#" onclick="doLoad('first');return false;">��ҳ</a>
	        <%}%>
	        <%if(curPage>1){%>
	        <a href="#" onclick="doLoad('pre');return false;">��һҳ</a>
	        <%}%>
	        <%if(curPage<pageCount){%>
	        <a href="#" onclick="doLoad('next');return false;">��һҳ</a>
	        <%}%>
	        <%if(pageCount>1){%>
	        <a href="#" onclick="doLoad('last');return false;">βҳ</a>
	        <span>����ѡ��</span>
			  <select onchange="jumpToPage(this.value)" style="width:3em;height:1.5em">
	        <%for(int i=1;i<=pageCount;i++){
	        	out.print("<option value='"+i+"'");
	        	if(i==curPage){
	        	 out.print("selected");
	        	}
	        	out.print(">"+i+"</option>");
	        }%>
	     	 </select>&nbsp;&nbsp;
				<span>������ת</span>
	        	<input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:14px;width:30px" onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/>
	        	<a href="#" onclick="jumpToPage('jumpToPage');return false;">GO</a>
	        &nbsp;&nbsp;&nbsp;&nbsp; 
	        <%}%>
	        	<%if(pageCount!=0){%>
	       <span>�ܼ�<%=sumTime%>��</span>	
	        
	        <%}%>
	        <input name="export" type="button"  id="search" value="ˢ��" onclick="doLoad('0')">
	        <input name="export" type="button"  id="search" value="����" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
    	    <input name="export" type="button"  id="search" value="����ȫ��" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('all')\"");%>>
	      </td>
	    </tr>
		<tr>
			<th nowrap > ȫѡ<input type="checkbox" onclick="chooseAll(this)" /> </th>
			<th nowrap > ���� </th>
			<th nowrap > ��ˮ�� </th>
			<th nowrap > �������
			            	<%//added by tangosng 20110118 ����
            		if ("accept_phone".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('accept_phone','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('accept_phone','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('accept_phone','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>	
			</th>
			<th nowrap > ���к���
            	<%//added by tangosng 20110118 ����
            		if ("caller_phone".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('caller_phone','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('caller_phone','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('caller_phone','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>	
            	</th>		
			<th nowrap > ���к���
            	<%//added by tangosng 20110118 ����
            		if ("callee_phone".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('callee_phone','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('callee_phone','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('callee_phone','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%></th>			
			<th nowrap > ������
            	<%//added by tangosng 20110118 ����
            		if ("accept_login_no".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('accept_login_no','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('accept_login_no','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('accept_login_no','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%></th>			
			<th nowrap > �ͻ�����
            	<%//added by tangosng 20110118 ����
            		if ("cust_name".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('cust_name','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('cust_name','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('cust_name','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>
            </th>  			
			<th nowrap > �ͻ�����
            	<%//added by tangosng 20110118 ����
            		if ("servicecity".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('servicecity','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('servicecity','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('servicecity','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>	</th>		
			<th nowrap > �ͻ�����
            	<%//added by tangosng 20110118 ����
            		if ("region_code".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('region_code','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('region_code','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('region_code','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>		</th>	
			<th nowrap > �ͻ�����
            	<%//added by tangosng 20110118 ����
            		if ("usertype".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('usertype','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('usertype','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('usertype','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>	</th>		
			<th nowrap > ����ʱ��
            	<%//added by tangosng 20110118 ����
            		if ("begin_date".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('begin_date','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('begin_date','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('begin_date','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>	</th>		
			<th nowrap > �һ�ʱ��
            	<%//added by tangosng 20110118 ����
            		if ("end_date".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('end_date','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('end_date','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('end_date','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>	</th>		
			<th nowrap > ����ʱ��
            	<%//added by tangosng 20110118 ����
            		if ("accept_long".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('accept_long','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('accept_long','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('accept_long','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>		</th>	
			<th nowrap > ����ʽ
            	<%//added by tangosng 20110118 ����
            		if ("acceptid".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('acceptid','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('acceptid','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('acceptid','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>	</th>		
			<th nowrap > �һ��� </th>
			<th nowrap > �ͻ������
            	<%//added by tangosng 20110118 ����
            		if ("statisfy_code".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('statisfy_code','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('statisfy_code','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('statisfy_code','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>	</th>		
			<th nowrap > ����ԭ��</th>
			<th nowrap > ��Ч��</th>
			<th nowrap > �Ƿ�������֤</th>
			<th nowrap > �Ƿ��ʼ�
            	<%//added by tangosng 20110118 ����
            		if ("qc_flag".equals(orderColumn)) {
            			if ("desc".equals(orderCode)) {
            				out.print("<img onclick=\"submitInputCheck('qc_flag','asc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_desc.gif\" />");
            			} else {
            				out.print("<img onclick=\"submitInputCheck('qc_flag','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/sort_asc.gif\" />");
            			}
            		} else {
            			out.print("<img onclick=\"submitInputCheck('qc_flag','desc')\" alt=\"�����������\"' src=\""+request.getContextPath()+"/nresources/default/images/framework/group-checked.gif\" />");
            		}
            	%>	</th>		
			<th nowrap > �ʼ�Ա����</th>
			<th nowrap > ��������</th>
			<th nowrap > ¼����ȡ��־ </th>
			<th nowrap > ���й켣</th>
			<th nowrap > ��ע</th>
			<th nowrap > ת�ӱ�ע</th>
			<th nowrap > ���ܶ���</th>
		</tr>
<%
	for (int i = 0; i < dataRows.length; i++) {
%>
		<tr onclick="changeColor('blue',this);">
			<td align="center" nowrap ><input type="checkbox" name="callDataBox" value="<%=dataRows[i][0]%>" onclick="putclickdata('<%=dataRows[i][0]%>')"/></td>
			<td align="center" nowrap ><input type="button" class="b_foot" value="ɾ��" onclick="putvaluea('<%=dataRows[i][0]%>')"/></td>
			<td align="center" nowrap ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][24].length()!=0)?dataRows[i][24]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][25].length()!=0)?dataRows[i][25]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][23].length()!=0)?dataRows[i][23]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][12].length()!=0)?dataRows[i][12]:"&nbsp;"%></td>
			<td align="left" nowrap ><%=(dataRows[i][14].length()!=0)?dataRows[i][14]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][8].length()!=0&&Integer.parseInt(dataRows[i][8])>=3)?"��Ч":"��Ч"%></td>
			<td align="center" nowrap ><%=(dataRows[i][18].length()!=0)?dataRows[i][18]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=((dataRows[i][17].length()!=0)?dataRows[i][17]:"&nbsp;")%></td>
			<td align="center" nowrap ><%=(dataRows[i][13].length()!=0)?dataRows[i][13]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][15].length()!=0)?dataRows[i][15]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][26].length()!=0)?dataRows[i][26]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][20].length()!=0)?dataRows[i][20]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][21].length()!=0)?dataRows[i][21]:"&nbsp;"%></td>
			<td align="center" nowrap ><%=(dataRows[i][27].length()!=0)?dataRows[i][27]:"&nbsp;"%></td>
		</tr>
<%
	}
%>
	   <tr>
	      <td class="blue" align="right" colspan="28">
	        <%if(pageCount!=0){%>
	        ��<%=curPage%>ҳ ��<%=pageCount%>ҳ ��<%=rowCount%>��
	        <%} else{%>
	        <font color="orange">��ǰ��¼Ϊ�գ�</font>
	        <%}%>
	        <%if(pageCount!=1 && pageCount!=0){%>
	        <a href="#" onclick="doLoad('first');return false;">��ҳ</a>
	        <%}%>
	        <%if(curPage>1){%>
	        <a href="#" onclick="doLoad('pre');return false;">��һҳ</a>
	        <%}%>
	        <%if(curPage<pageCount){%>
	        <a href="#" onclick="doLoad('next');return false;">��һҳ</a>
	        <%}%>
	        <%if(pageCount>1){%>
	        <a href="#" onclick="doLoad('last');return false;">βҳ</a>
	        <span>����ѡ��</span>
			  <select onchange="jumpToPage(this.value)" style="width:3em;height:1.5em">
	        <%for(int i=1;i<=pageCount;i++){
	        	out.print("<option value='"+i+"'");
	        	if(i==curPage){
	        	 out.print("selected");
	        	}
	        	out.print(">"+i+"</option>");
	        }%>
	     	 </select>&nbsp;&nbsp;
				<span>������ת</span>
	        	<input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:14px;width:30px" onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/>
	        	<a href="#" onclick="jumpToPage('jumpToPage');return false;">GO</a>
	        <%}%>
	         	<%if(pageCount!=0){%>
	       <span>�ܼ�<%=sumTime%>��</span>	
	        
	        <%}%>
	      </td>
	    </tr>

	</table>
</div>
</body>
</html>
<script language="javascript" defer>
var arry = new Array();
var clikcdate='<%=clikcdate%>';
if(clikcdate!='')
{
	arry=clikcdate.split(",");
}
var arraya = new Array();
var qclickcdate='<%=qclickcdate%>';
if(qclickcdate!='')
{
	arraya=qclickcdate.split(",");
}
window.onload=function(){
	var objs = parent.document.getElementsByName("assignType");
	for (var i = 0;i < objs.length; i++) {
		if (objs[i].checked) {
			assignType = objs[i].value;
			break;
		}
	}
	if (assignType == "1") {
	var callDataBox=document.getElementsByName("callDataBox");
		for (var i = 0;i < callDataBox.length; i++) {
			for(var j=0;j<arraya.length;j++){
				if(callDataBox[i].value==arraya[j]){
					callDataBox[i].checked= true;
				}
			}
		}
	
  }
}
function putclickdata(a)
{

	var fg=0;
	for(var i=0;i<arry.length;i++)
	{
		if(arry[i]==a)
		{
		arry.splice(i,1);
		fg=1;
		break;
	  }
  }
  if(fg==0)
  {
  	arry.push(a);
  }
  document.getElementById("clickdata").value=arry;
  var flg=0;
  for(var i=0;i<arraya.length;i++){
  	if(arraya[i]==a)
		{
		arraya.splice(i,1);
		flg=1;
		break;
	  }
  }
    if(flg==0)
  {
  	arraya.push(a);
  }
  document.getElementById("qclickcdate").value=arraya;
}


//�������� ---zengdj20110928 ���ӵ�������
function showExpWin(flag){
	 //var startDate = new Date(document.sitechform.start_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 //var endDate = new Date(document.sitechform.end_date.value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 //var month_interval = getMonths(startDate,endDate);
	 //document.sitechform.month_interval.value = month_interval;
	 //<input type="hidden" name="orderColumn" id="orderColumn" value="" />
	 //<input type="hidden" name="orderCode" id="orderCode" value="" />
	var assignId = $("#assignId").val();
	var orderColumn = $("#orderColumn").val();
	var orderCode = $("#orderCode").val();
	if (assignId == "-1") {
		assignId="";
	}
	var url = 'K243_expSelect.jsp?flag='+flag+'&assignId='+assignId;
	url +="&orderColumn="+orderColumn;
	url +="&orderCode="+orderCode;
  openWinMid(url,'expSelect',340,320);
}
//���д򿪴���
function openWinMid(url,name,iHeight,iWidth)
{
  //var url; //ת����ҳ�ĵ�ַ;
  //var name; //��ҳ���ƣ���Ϊ;
  //var iWidth; //�������ڵĿ��;
  //var iHeight; //�������ڵĸ߶�;
  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}
function Reset(){
	document.getElementById("endTime").value ='<%=getCurrDateStr("23:59:59")%>';
	document.getElementById("accept_long_begin").value ="";
	document.getElementById("accept_long_end").value ="";
	document.getElementById("caller_phone").value ="";
	document.getElementById("Contact_id").value ="";
	document.getElementById("beginTime").value ='<%=getCurrDateStr("00:00:00")%>';
	document.getElementById("accept_login_no").value ="";
}
</script>
