<%
  /*
   * ����: ҵ����ѯ
�� * �汾: 1.0
�� * ����: 2009/08/07
�� * ����: yinzx 
�� * ��Ȩ: sitech
   * 
 ��*/
 %>

<%@ page import="java.util.Calendar"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%!
	public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
%>

<html>
	<head>
	
		<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>

		<script language="javascript">
   
   	//�������¼
		function clearValue(){
			var e = document.sitechform.elements;
			for(var i=0;i<e.length;i++){
				if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
				  e[i].value="";
				}else{
			  		e[i].checked=false;
			    }
			} 
		}
					
			/*****************��ҳ���� begin******************/
	function doLoad(operateCode){
		window.sitechform.yin.value="";
		window.sitechform.exp.value="";
		window.sitechform.sqlyin.value="";
		window.sitechform.sqlxin.value="";

		var formobj =document.sitechform;
		 var str='1';
	   if(operateCode=="load")
	   {
	   	formobj.page.value="";
	   	str='0';
	   }
	   else if(operateCode=="first")
	   {
	   	formobj.page.value=1;
	   }
	   else if(operateCode=="pre")
	   {
	   	formobj.page.value=<%=(curPage-1)%>;
	   }
	   else if(operateCode=="next")
	   {
	   	formobj.page.value=<%=(curPage+1)%>;
	   }
	   else if(operateCode=="last")
	   {
	   	formobj.page.value=<%=pageCount%>;
	   }
	    keepValue();
	    window.sitechform.action="k189_Main.jsp" ;
			window.sitechform.submit(); 
			    
	}
	/***************��ҳ��������**************/
	
	
		//��ת��ָ��ҳ��
		function jumpToPage(operateCode){
					window.sitechform.yin.value="";
					window.sitechform.exp.value="";
			 		window.sitechform.sqlyin.value="";
			 		window.sitechform.sqlxin.value="";
			 if(operateCode=="jumpToPage")
		   {
		   	  var thePage = document.getElementById("thePage").value;
		   	  if(trim(thePage)!=""){
		   		 window.sitechform.page.value=parseInt(thePage);
		   		 doLoad('0');
		   	  }
		   }
		   else if(operateCode=="jumpToPage1")
		   {
		   	  var thePage=document.getElementById("thePage").value;
		   	  if(thePage.trim()!=""){
		   		window.sitechform.page.value=parseInt(thePage);
		       doLoad('0');
		      }
		   }else if(operateCode.trim()!=""){
		   	 sitechform.page.value=parseInt(operateCode);
		   	 doLoad('0');
		   }
		}
			
			    //���д򿪴���
			function openWinMid(url,name,iHeight,iWidth)
				{
				
				  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
				  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
				  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
				}
				
			//��������
			function showExpWin(expflag){
			 	    window.sitechform.page.value="<%=curPage%>";
			 	    keepValue();
						openWinMid('k189_expSelect.jsp?flag='+expflag,'ѡ�񵼳���',340,320);
			}
			function submitInputCheck(){
	         window.sitechform.yin.value="";
	         window.sitechform.exp.value="";
	         window.sitechform.sqlyin.value="";
					 window.sitechform.sqlxin.value="";
				   window.sitechform.action="k189_Main.jsp" ;
			     window.sitechform.submit();    
			}
			
			function modifysceTrans(){
				window.sitechform.yin.value="";
				window.sitechform.exp.value="";
				window.sitechform.sqlyin.value="";
				window.sitechform.sqlxin.value="";
				if($("input:checked").length !=1)
				{
						rdShowMessageDialog("��ѡ��һ�����ݽ����޸Ĳ���",0);
						return;
				} 
				
				  if($(":checkbox").length==2 )
				 {
				 	  
			    		openWinMid('k189_modifysceTrans.jsp?sceid='+document.all.sceid.value.trim()+'&accesscode=' + document.all.accesscode.value.trim()+ '&citycode=' + document.all.citycode.value.trim()+ '&digitcode=' + document.all.digitcode.value.trim(),'�޸Ľ��',650,800);
			   }else
			   {
			   	   
			  	    openWinMid('k189_modifysceTrans.jsp?sceid='+document.all.sceid[$("input:checked")[0].value ].value.trim()+'&accesscode=' + document.all.accesscode[$("input:checked")[0].value ].value.trim()+ '&citycode=' + document.all.citycode[$("input:checked")[0].value ].value.trim()+ '&digitcode=' + document.all.digitcode[$("input:checked")[0].value ].value.trim(),'�޸Ľ��',650,800);
			   }
			  //alert(document.all.sceid[$("input:checked")[0].value ].value.trim());
			}
			
			
			
			function delsceTrans(){
				window.sitechform.yin.value="";
				window.sitechform.exp.value="";
				window.sitechform.sqlyin.value="";
				window.sitechform.sqlxin.value="";
				var checkval="";
				if($("input:checked").length ==0)
				{
						rdShowMessageDialog("��ѡ��һ����������ݽ���ɾ������",0);
						return;
				} 
			
			if(rdShowConfirmDialog("��ȷ��ɾ���˼�¼ô��")=='1'){	 
				for(var i=0;i<$("input:checked").length;i++)
				{
					 
          if($("input:checked")[i].name!='ck_all')
         {   if($(":checkbox").length==2)
					{
						 checkval=document.all.sceid.value.trim();
					}else{
						 
					  if (i==($("input:checked").length -1))
					  {
								checkval+=document.all.sceid[$("input:checked")[i].value].value.trim();
						}else
						{
							  checkval+=document.all.sceid[$("input:checked")[i].value].value.trim()+",";
					  }
					}
				 }
				}
 
				var packet = new AJAXPacket("k189_delsceTrans_rpc.jsp","...");
				packet.data.add("retType","delsceTrans");
				packet.data.add("checkval" ,checkval);
			
				core.ajax.sendPacket(packet,doProcessdelsceTrans,true);
				packet=null;
			}
			}

function checkAll(a) {
    var el = document.getElementsByTagName('input');
    var ck_all = document.getElementsByName('ck_all');
    var len = el.length;
    //alert(len);
   
    
 if(a.checked==false)
 {   for (var i = 1; i < len; i++) {
        if ((el[i].type == "checkbox") ) {
            el[i].checked = false;
        }
    }
 
 }
 else if(a.checked==true)
 { 
 	  
 	for (var i = 1; i < len; i++) {
        if ((el[i].type == "checkbox") ) {
            el[i].checked = true;
        }
    }
   
 }
}			 
			 
	/**
  *���ش�����
  */
function doProcessdelsceTrans(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");

	if (retCode == "000000") {
		keepValue();
		rdShowMessageDialog("ɾ��ҵ����ѯ������ݳɹ���",1);	
		  window.sitechform.action="k189_Main.jsp" ;
			window.sitechform.submit(); 
		 //document.location.replace("k189_Main.jsp");	
     window.close();
   
	} else {
		rdShowMessageDialog("ɾ��ҵ����ѯ�������ʧ�ܣ�",2);

	}
}


function doProcessexl(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");

	if (retCode == "000000") {
		keepValue();
		rdShowMessageDialog("ɾ��ҵ����ѯ������ݳɹ���",1);	
		 //document.location.replace("k188_Main.jsp");	
		  window.sitechform.action="k189_Main.jsp" ;
			window.sitechform.submit(); 
     window.close();
   
	} else {
		rdShowMessageDialog("ɾ��ҵ����ѯ�������ʧ�ܣ�",2);

	}
}
			
function keepValue(){
	window.sitechform.city_code.value="<%=city_code%>";
	window.sitechform.service_name.value="<%=service_name%>";
	window.sitechform.digit_code.value="<%=digit_code%>"; 
}		 


function beforeLoad(){ 
			var time = new Date();
			var path='<%=request.getContextPath()%>/npage/callbosspage/K189/k189_loadPage.jsp?now=' + time;
			 
				
			var Height = window.screen.availHeight - 500; 
			var width  = window.screen.availWidth  - 500;
			var top    = (window.screen.availHeight-30 - Height)/2; //��ô��ڵĴ�ֱλ��;
			var left   = (window.screen.availWidth-10 - width)/2; //��ô��ڵ�ˮƽλ��;
			var param  = 'height=' + Height + ',width=' + width + ',top=' + top + ',left=' + left + 
			             ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no';
			
			window.open(path, '������ѯ����', param);	
}		

function beforeLoadExecl(){ 
			var time = new Date();
			var path='<%=request.getContextPath()%>/npage/callbosspage/K189/k189_loadPageExecl.jsp?now=' + time;
			 
				
			var Height = window.screen.availHeight - 500; 
			var width  = window.screen.availWidth  - 500;
			var top    = (window.screen.availHeight-30 - Height)/2; //��ô��ڵĴ�ֱλ��;
			var left   = (window.screen.availWidth-10 - width)/2; //��ô��ڵ�ˮƽλ��;
			var param  = 'height=' + Height + ',width=' + width + ',top=' + top + ',left=' + left + 
			             ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no';
			
			window.open(path, '������ѯ����', param);	
}			
	
		</script>
	</head>


<body>
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<div class="title"><div id="title_zi">תҵ����ѯ����</div></div>
		<input type="hidden" name="page" value="">
	  <input type="hidden" name="yin" value="">
	  <input type="hidden" name="exp" value="">
	  <input type="hidden" name="sqlyin" value="">
	  <input type="hidden" name="sqlxin" value="">
	  <input type="hidden" name="sqlWhere" value="">
<table cellspacing="0">
      <tr >
      <td colspan="10" align="center" id="footer" height="10">
  <table cellspacing="0" >
          <tr>
<td class="blue" >��������</td>
      <td>
				<select id="city_code" name="city_code" >
		      <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>
								select * from (select '' city_code ,'--ȫ��--'  region_name from dual union select  city_code,region_name from scallregioncode where valid_flag='Y'   ) order by city_code  desc  </wtc:sql>
				   </wtc:qoption>	
        </select>
      </td>
      
      <td class="blue"> �������� </td>
      <td   >
			  <input id="service_name" name ="service_name" type="text"   >
		    
		    <font color="orange">&nbsp;&nbsp;*</font>
		  </td> 
		   <td class="blue"> ����·�� </td>
      <td  >
			  <input id="digit_code" name ="digit_code" type="text"   >
		    
		    <font color="orange">&nbsp;&nbsp;*</font>
		  </td> 

		</tr>
		<table>
      <td>
      </tr>     
    <tr >
      <td colspan="10" align="center" id="footer">
       
       <input name="search" type="button" class="b_foot"  id="search" value="��ѯ" onClick="submitInputCheck();return false;">
       <input name="delete_value" type="reset" class="b_foot"  id="add" value="����">
    <!--   <input name="export" type="button" class="b_foot"  id="search" value="����" onClick="showExpWin('cur');">  -->
      </td>
    </tr>

</form>
</body>
</html>

