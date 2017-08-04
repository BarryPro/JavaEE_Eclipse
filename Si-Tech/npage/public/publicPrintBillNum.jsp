<%
		String work_no_bill =(String)session.getAttribute("workNo");
		String org_code_bill =(String)session.getAttribute("orgCode");
		String regionCode_bill = org_code_bill.substring(0,2);
		//liujian 2012-8-17 13:51:18 增加发票编号
		String sql_select_bill = "select to_char(S_INVOICE_NUMBER),flag  from WLOGININVOICE where LOGIN_NO = :workNo";
		String srv_params_bill = "workNo=" + work_no_bill;
		
		String bill_number = "";
		String printLogoFlag = "";
		
		//打印初始值
		int rowInit = 9;
		int fontSizeInit = 9;
		int fontStrongInit = 0;//0为不加粗
		String fontType = "宋体";
		String vR = "0";
	%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode_bill%>"  
			retcode="retBillNumCode" retmsg="retBillNumMsg" outnum="2">
		<wtc:param value="<%=sql_select_bill%>"/>
		<wtc:param value="<%=srv_params_bill%>"/>
	</wtc:service>
	<wtc:array id="billNumRst" scope="end" />
<%
	if(retBillNumCode.equals("000000") && billNumRst.length>0) {
		bill_number = billNumRst[0][0];
		printLogoFlag = billNumRst[0][1];
%>
		<script>
			var wlHref = window.location.href;
		if(wlHref.indexOf('pubBillPrintBroad.jsp')!=-1 || wlHref.indexOf('f9130_print.jsp')!=-1) {
			//	|| wlHref.indexOf('chkPrint.jsp')!=-1 || wlHref.indexOf('chkTwoPrint.jsp')!=-1 
			//	|| wlHref.indexOf('chkTwoPrintZero.jsp')!=-1 ) {
			$(function(){
				
				if(confirm('发票号码是<%=billNumRst[0][0]%>，是否打印收据？')==1){
					doPrint();
				}else {
					if(wlHref.indexOf('f9130_print.jsp')!=-1) {
						if(parent.g_activateTab == undefined){
							var l_activateTab = "";
							var lis = new Array();
							if(parent.document.getElementById('tabtag')!=null){
								if(parent.document.getElementById('tabtag').getElementsByTagName('li')!=null&&typeof(parent.document.getElementById('tabtag').getElementsByTagName('li'))!="undefined"){
									lis = parent.document.getElementById('tabtag').getElementsByTagName('li');
								}
							}
							for(var i=0; i<lis.length; i++){
								if(lis[i].className == "current"){
									l_activateTab = lis[i].id;
									break;		        
								} 
							}
							if(l_activateTab!=""){
								parent.removeTab(l_activateTab);
							}
					     }else{
							parent.removeTab(parent.g_activateTab); 
					     }
					}else {
						window.close();
					}
					
				}
			});
		}else if(wlHref.indexOf('pubBillPrintCfm.jsp')!=-1) {
			if(confirm('发票号码是<%=billNumRst[0][0]%>，是否打印收据？')==1){
				
			}else {
				window.close();
			}
		}else {
			if(confirm('发票号码是<%=billNumRst[0][0]%>，是否打印收据？')==1){
			}else{
				if(parent.g_activateTab == undefined){
					var l_activateTab = "";
					var lis = new Array();
					if(parent.document.getElementById('tabtag')!=null){
						if(parent.document.getElementById('tabtag').getElementsByTagName('li')!=null&&typeof(parent.document.getElementById('tabtag').getElementsByTagName('li'))!="undefined"){
							lis = parent.document.getElementById('tabtag').getElementsByTagName('li');
						}
					}
					for(var i=0; i<lis.length; i++){
						if(lis[i].className == "current"){
							l_activateTab = lis[i].id;
							break;		        
						} 
					}
					if(l_activateTab!=""){
						parent.removeTab(l_activateTab);
					}
			     }else{
					parent.removeTab(parent.g_activateTab); 
			     }
			}
		}
		</script>
<%			
	}else {
%>
		<script>
			alert('业务办理成功，获取发票号码失败！');
			var wlHref = window.location.href;
			if(wlHref.indexOf('pubBillPrintCfm.jsp')!=-1) {
				 window.close();
			}else {
				if(parent.g_activateTab == undefined){
					var l_activateTab = "";
					var lis = new Array();
					if(parent.document.getElementById('tabtag')!=null){// 打印发票点击取消bug hejwa updby 2013年6月27日11:22:08
						if(parent.document.getElementById('tabtag').getElementsByTagName('li')!=null&&typeof(parent.document.getElementById('tabtag').getElementsByTagName('li'))!="undefined"){
							lis = parent.document.getElementById('tabtag').getElementsByTagName('li');
						}
					}
					
					for(var i=0; i<lis.length; i++){
						if(lis[i].className == "current"){
							l_activateTab = lis[i].id;
							break;		        
						} 
					}
					if(l_activateTab!=""){//  打印发票点击取消bug hejwa updby 2013年6月27日11:22:08
						parent.removeTab(l_activateTab);
					}
			  }else{
					parent.removeTab(parent.g_activateTab); 
			  }
		   }
		</script>
<%
	}
%>	


<script>
	//js自动下载文件到本地 
	var xh;
	var localPath = "c:/billLogo.jpg";
	
	function InitAjax() {
	    var ajax;
	    if (window.ActiveXObject) {
	        var versions = ['Microsoft.XMLHTTP', 'MSXML.XMLHTTP', 'Microsoft.XMLHTTP', 'Msxml2.XMLHTTP.7.0', 'Msxml2.XMLHTTP.6.0', 'Msxml2.XMLHTTP.5.0', 'Msxml2.XMLHTTP.4.0', 'MSXML2.XMLHTTP.3.0', 'MSXML2.XMLHTTP'];
	        for (var i = 0; i < versions.length; i++) {
	            try {
	                ajax = new ActiveXObject(versions[i]);
	                if (ajax) {
	                    return ajax;
	                }
	            } catch (e) {
	            }
	
	        }
	    } else if (window.XMLHttpRequest) {
	        ajax = new XMLHttpRequest();
	    }
	
	    return ajax;
	}
	
	function getXML(geturl) {
	    xh = InitAjax();
	    xh.onreadystatechange = getReady;
	    xh.open("GET", geturl, true);
	    xh.send();
	}
	
	function getReady() { 
	    if (xh.readyState == 4) {
	        if (xh.status == 200) {
	            saveFile(localPath);
	            return true;
	        }
	        else {
	            return false;
	        }
	    }
	    else
	        return false;
	}
	
	function saveFile(tofile) {
		if(!judgeFileExsit(tofile)) {
			var objStream;
		    var imgs;
		    imgs = xh.responseBody;
		    objStream = new ActiveXObject("ADODB.Stream");
		    objStream.Type = 1;
		    objStream.open();
		    objStream.write(imgs);
		    objStream.SaveToFile(tofile);
		}
	}
	
	function judgeFileExsit(filespec)
	{
	  var fso = new ActiveXObject("Scripting.FileSystemObject");
	  if (fso.FileExists(filespec)) {
	      return true;
	  }
	  else {
	      return false;	
	  }
	}	
</script>