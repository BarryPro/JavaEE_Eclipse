<%
/********************
 version v2.0
������: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
		String regionCode= (String)session.getAttribute("regCode");
		String loginNoPass = (String)session.getAttribute("password");
		String ipAddrss = (String)session.getAttribute("ipAddr");

%>
  
	
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script type="text/javascript">
  onload=function()
  {

		document.all.querysss.disabled=true;
	  document.all.quchoose.disabled=false;     
  
  }
 
				function checkAll() { 
				var el = document.getElementsByTagName('input');
				var len = el.length;
				
				for(var i=0; i<len; i++) {
				if((el[i].type=="checkbox") && (el[i].id=='ckbox')) {
				el[i].checked = true;
				}
				}
				}
				function clearAll() {
				var el = document.getElementsByTagName('input');
				var len = el.length;
				for(var i=0; i<len; i++) {
				if((el[i].type=="checkbox") && (el[i].id=='ckbox')) {
				el[i].checked = false;
				}
				}
				}
				
				
 
  		function frmCfm(){
				document.form1.action = "fm338Cfm.jsp";
   			document.form1.submit();
        return true;
      }
    
 
    
		function querinfo(data){
				//�ҵ���ӱ���div
				var markDiv=$("#showTab"); 
				markDiv.empty();
				markDiv.append(data);
				
		}
		
		
	function changeType(opCode){

	
	if(opCode == "add"){
	document.all.querysss.disabled=true;
	document.all.quchoose.disabled=false;
	
	$("#add").show();
	$("#query").hide();
 	
				
    $("#showTab").empty();    
    $("#worknos").val("");
 

	}
	if(opCode == "query"){
	document.all.quchoose.disabled=true;
	document.all.querysss.disabled=false;;

	
	$("#add").hide();
	$("#query").show();

    $("#showTab").empty();    
    $("#worknos").val("");
    
        var myPacket = new AJAXPacket("fm338Qry.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
				core.ajax.sendPacketHtml(myPacket,querinfo,true);
				getdataPacket = null;

    
	}	
}	


 	function resetPage(){
 		window.location.href = "f<%=opCode%>.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
	
	function changeType33(workno){
	$("#worknodel").val(workno);
	}
	
	
		function doCommit()
		{
	 
			var radio1 = document.getElementsByName("opType");
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
								  if(opFlag=="add")
								{	
       		    

									
							if($("#worknos").val().trim()==""){
					         rdShowMessageDialog("������Ҫ���õĹ��ţ�");
					         return false;
								}
									
								$("#optypess").val("a");
    						document.all.quchoose.disabled=true;
								frmCfm();
     		

						    }
						    else {
						    
     var workchooses = $("#worknodel").val();
				if(workchooses.trim()=="") {
						rdShowMessageDialog("��ѡ��Ҫɾ���Ĺ��ţ�");
						return false;
				}
				
	
			  	if(rdShowConfirmDialog("ȷ��ɾ������"+workchooses+"��")==1)
			{
					$("#optypess").val("d");				
					$("#delnums").val("1");
					
					frmCfm();
      }

	
 						    						    	
						    }
    
				    }
		     }
		
		

		      
		}

</script>
</head>
<body>
<form name="form1" id="form1" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
              
   <table id=""  cellspacing="0" >  	
        	  <tr>

			        		<td width=16% class="blue">��������</td>

			        		<td width=84% colspan="3">

			        			<input type="radio" name="opType"	value="add"   onclick="changeType(this.value);" checked/>���� &nbsp;&nbsp;

			        			<input type="radio" name="opType"	value="query"  onclick="changeType(this.value);"/>ɾ�� &nbsp;&nbsp;

			        		</td>

        				</tr>
       </table>
       
       <table id="add" style="display:block">
       	        <tr>

					        <td class='blue' width=16%>Ҫ���õĹ���</td>

					        <td>

								<input type="text" value="" name="worknos" id="worknos"    maxlength="6" />

								<font class="orange">*</font>

					        </td>


					        </tr>    				
        			
        				
              </table>

        				  

	<div id="showTab" ></div>
	

              <table cellspacing="0">
          <tr>
            <td noWrap id="footer">
              <div align="center">	
              	<input  name="quchoose" id="quchoose" class="b_foot" type=button value=����  onclick="doCommit()" >
              	<input  name="querysss" id="querysss" class="b_foot" type=button value=ɾ��  onclick="doCommit()" >
              <input class="b_foot" type=button name=back value="���" onClick="resetPage()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab()">
              </div>
            </td>
          </tr>
        </table>
      <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
      <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
      <input type="hidden" name="worknodel" id="worknodel"  />
      <input type="hidden" name="optypess" id="optypess"  />
      <input type="hidden" name="delnums" id="delnums"  />

    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
</html>