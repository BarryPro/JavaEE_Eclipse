<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">	
<%@ include file="/npage/workflow/admin/pub/wb_include.jsp" %>

<%
	String opCode = "6052";
%>
<%@ include file="/npage/include/header.jsp" %>	
		<!--�������ڿؼ�-->
<link rel="stylesheet" type="text/css" media="all" href="js/cal/calendar-win2k-cold-2.css" title="win2k-cold-2" />
<script type="text/javascript" src="js/cal/calendar.js"></script>
<script type="text/javascript" src="js/cal/cal2.js"></script>
<script type="text/javascript" src="js/cal/lang/calendar-zh.js"></script>

<div id="tabnav"> 
	<ul>     
		<li  class='current'><a id='tab1' href='#' onclick='changeTab(this.id);return false;'><span>��λ����</span></a></li>
	</ul> 
</div> 

  
<style type="text/css">  
		
    #tabnav {
      float:left;
      width:100%;
      font-size:93%;
      line-height:normal;
    }
    #tabnav ul {
      margin:0;
      padding:10px 10px 0 5px;
      list-style:none;
    }
    #tabnav li {
      display:inline;
      margin:0;
      padding:0;
    }
    #tabnav a {
      float:left;
      background:url("/nresources/default/images/tableftJ.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      cursor:hand;
    }
    #tabnav a span {
      float:left;
      display:block;
      background:url("/nresources/default/images/tabrightJ.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#24618E;
    }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabnav a span {
    	float:none;
    }
    /* End IE5-Mac hack */
    #tabnav a:hover span {
      color:#FFF;
    }
    #tabnav a:hover {
      background-position:0% -42px;
    }
    #tabnav a:hover span {
      background-position:100% -42px;
    }

    #tabnav .current a {
      background-position:0% -42px;
    }
    #tabnav .current a span {
			font: bold;
      background-position:100% -42px;
      color:#FFF;
    }
	
	 </style>  
	 

<div id='listdiv1' style="display:block" >
		<jsp:include page="f_wb_5_01_part1.jsp" flush="true" /> 
</div>

<div id='listdiv2' style="display:none" >
		<jsp:include page=" " flush="true" /> 
</div>

<div id='listdiv3' style="display:none" >
		<jsp:include page=" " flush="true" /> 
</div>


   <%@ include file="/npage/include/footer.jsp" %>	

<script language="javascript">
	//��ǰtab
	var currTab = 'tab1';

	changeTab(currTab);

function changeTab(obj)
{
	currTab = obj;
	
	if(obj=='tab1')
	{
		

		
		var tab1 = document.getElementById('tab1');
		tab1.className='here';
		
		var list1 = document.getElementById('listdiv1');
		list1.style.display='block';
		var list2 = document.getElementById('listdiv2');
		list2.style.display='none';
		
		var list3 = document.getElementById('listdiv3');
		list3.style.display='none';
	}
	
}

//��ȡ��ǰ���²���
function getCurrentList()
{
	if(currTab=='tab1')
	{
		return 'condquery1'
	}
}

	<!--
			
			
			onload=function(){
				core.ajax.onreceive = doProcess;
			}		
			
			/**����rpc���ؽ��"**/
			function doProcess(packet){
				var retType = packet.data.findValueByName("retType");
				var returnCode = packet.data.findValueByName("returnCode");
				var returnMessage = packet.data.findValueByName("returnMessage");
				
				/**"���ݲ�����������"��������Ĳ�����ʾ�������˴��벢�����ʾ���**/
				if(retType=="addRole"){
					if(returnCode!="000000"){
						rdShowMessageDialog(returnMessage);
						return false;
					}else{
						rdShowMessageDialog("��ӳɹ�!");
					}
				}
				
				if(retType=="addRole2"){
					if(returnCode!="000000"){
						rdShowMessageDialog(returnMessage);
						return false;
					}else{
						rdShowMessageDialog("��ӳɹ�!");
						window.location.reload();
					}
				}	
				
				if(retType=="delRole"){
					if(returnCode!="000000"){
						rdShowMessageDialog(returnMessage);
						return false;
					}else{
						rdShowMessageDialog("ɾ���ɹ�!");
						window.location.reload();
					}
				}									
			}				
		
		
		//���ӽڵ�
		function add1(){
				var role_code = jtrim(document.all.role_code.value);
				var role_desc = jtrim(document.all.role_desc.value);
				
				if(role_desc==""){
					rdShowMessageDialog("��ɫ���Ʋ���Ϊ��!");
					document.all.role_desc.focus();	
					return false;
				}
				
		    var myPacket = new AJAXPacket("f_wb_5_01_add_role.jsp?role_desc="+role_desc,"���ڲ�ѯ�����Ժ�......");
		    myPacket.data.add("retType","addRole");
			myPacket.data.add("role_code",role_code);
		    core.ajax.sendPacket(myPacket);
		    myPacket=null;	
		}
		
		//���ӽڵ�
		function add2(){
				var role_code = jtrim(document.all.role_code_2.value);
				var login_no = jtrim(document.all.login_no.value);
				
//				if(login_no==""){
//					rdShowMessageDialog("���Ų���Ϊ��!");
//					document.all.login_no.focus();	
//					return false;
//				}
				if(login_no.length!=6){
					rdShowMessageDialog("���ų���ӦΪ6λ!");
					document.all.login_no.focus();	
					return false;
					}
				
				
		    var myPacket = new AJAXPacket("f_wb_5_01_add_role2.jsp","���ڲ�ѯ�����Ժ�......");
		    myPacket.data.add("retType","addRole2");
			myPacket.data.add("role_code",role_code);
			myPacket.data.add("login_no",login_no);
		    core.ajax.sendPacket(myPacket);
		    myPacket=null;	
		}
		
				//���ӽڵ�
		function delete2(a,b){
				var role_code = a;
				var login_no = b;
				
				if( !confirm("��ȷ��Ҫɾ���ù�����?\n")) { 
					return false; 
				} 
				
		    var myPacket = new AJAXPacket("f_wb_5_01_del_role.jsp","���ڲ�ѯ�����Ժ�......");
		    myPacket.data.add("retType","delRole");
			myPacket.data.add("role_code",role_code);
			myPacket.data.add("login_no",login_no);
		    core.ajax.sendPacket(myPacket);
		    myPacket=null;	
		}
		
		/**�����ַ����ҵĿո�**/
		function jtrim(str){
			if(str==null){
				return "";	
			}
			return str.replace( /^\s*/, "" ).replace( /\s*$/, "" );	
		}
	//-->

</script>
