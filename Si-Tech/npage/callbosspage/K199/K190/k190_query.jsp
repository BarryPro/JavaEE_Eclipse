<%
  /*
   * ����: �ͷ�һ������¼����Ϣ��
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
		<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
		<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
	  <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
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
	    window.sitechform.action="k190_Main.jsp" ;
			window.sitechform.submit(); 
			    
	}
	/***************��ҳ��������**************/
	
	
		//��ת��ָ��ҳ��
		function jumpToPage(operateCode){
				 
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
			 	if(expflag=="cur")
			  {
			  	 window.sitechform.exp.value="cur";
			  }else
			  {
			  	 window.sitechform.exp.value="all";
			  }
			    
			   /*���ݵ�ǰΪ�ڼ�ҳ*/
			    <%	if( curPage >1)  { %>
				   var thePage = document.getElementById("thePage").value;
		   		 window.sitechform.page.value=parseInt(thePage);
		   		<%}else {%>
		   				 window.sitechform.page.value=parseInt('1');
		   		<%	} %>
		   	
		   	window.sitechform.action="k190_Main.jsp";	
		   	window.sitechform.submit();   
			 //	alert('a');
				 
			   
			}
			function submitInputCheck(){
	         
				   window.sitechform.action="k190_Main.jsp" ;
			     window.sitechform.submit();    
			}
			
			function modifysceTrans(){
			 
				if($("input:checked").length !=1)
				{
						rdShowMessageDialog("��ѡ��һ�����ݽ����޸Ĳ���",0);
						return;
				} 
				
				  if($(":checkbox").length==1 )
				 {
				 	  
			    		openWinMid('k190_modifysceTrans.jsp?sceid='+document.all.sceid.value.trim(),'�޸Ľ��',650,1000);
			   }else
			   {
			   	   
			  	    openWinMid('k190_modifysceTrans.jsp?sceid='+document.all.sceid[$("input:checked")[0].value ].value.trim(),'�޸Ľ��',650,1000);
			   }
			  //alert(document.all.sceid[$("input:checked")[0].value ].value.trim());
			}
			
			
			
			function delsceTrans(){
			 
				var checkval="";
				if($("input:checked").length ==0)
				{
						rdShowMessageDialog("��ѡ��һ����������ݽ���ɾ������",0);
						return;
				} 
			
			if(rdShowConfirmDialog("��ȷ��ɾ���˼�¼ô��")=='1'){
				 
				for(var i=0;i<$("input:checked").length;i++)
				{ 
					/*modify by yinzx 20091003*/ 
					if($(":checkbox").length==1)
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
  
				var packet = new AJAXPacket("k190_delsceTrans_rpc.jsp","...");
				packet.data.add("retType","delsceTrans");
				packet.data.add("checkval" ,checkval);
			
				core.ajax.sendPacket(packet,doProcessdelsceTrans,true);
				packet=null;
			}
			}
			 
			 
	/**
  *���ش�����
  */
function doProcessdelsceTrans(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");

	if (retCode == "000000") {
		rdShowMessageDialog("ɾ�����ݳɹ���",1);	
		 document.location.replace("k190_Main.jsp");	
     window.close();
   
	} else {
		rdShowMessageDialog("ɾ������ʧ�ܣ�",2);

	}
}


function doProcessexl(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");

	if (retCode == "000000") {
		rdShowMessageDialog("ɾ�����ݳɹ���",1);	
		 document.location.replace("k188_Main.jsp");	
     window.close();
   
	} else {
		rdShowMessageDialog("ɾ������ʧ�ܣ�",2);

	}
}
			
function keepValue(){
	 
	 
}		 
			
		</script>
	</head>


<body>
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<div class="title"><div id="title_zi">�ͷ�һ������¼����Ϣ��</div></div>
		<input type="hidden" name="page" value="">

		<table cellspacing="0">
   

      
     
   
    <tr >
      <td > ��ʼʱ�� </td>
      <td >
			  <input id="start_date" name ="start_date" type="text"   onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);return false;">
		    <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td>
		      
		</tr>
        
    <tr >
      <td colspan="6" align="center" id="footer">
       
       <input name="search" type="button" class="b_foot"  id="search" value="��ѯ" onClick="submitInputCheck();return false;">
       <input name="delete_value" type="reset" class="b_foot"  id="add" value="����">
      
			
       
      </td>
    </tr>
		</table>    
	</div>
</form>
</body>
</html>


	 